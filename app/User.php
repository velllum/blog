<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use \Storage;

class User extends Authenticatable
{

    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'description'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    //связь с таблицей пост один(User) ко многим(Post)
    public function posts()
    {
        return $this->hasMany(Post::class);
    }

    //связь с таблицей коментарии один ко многим
    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    //создание нового пользователя
    public static function add($fields)
    {
        $user = new static;
        $user->fill($fields);
        $user->save();

        return $user;
    }

    //редактирование (изменение) пользователя
    public function edit($fields)
    {
        $this->fill($fields);
        $this->save();
    }
    
    //проверка пароля на ноль, если пароль не ноль,
    // то тогда его кодируем и сохраняем
    public function generatePassword($password)
    {
        if($password != null){
           $this->password = bcrypt($password);
           $this->save();
        }
    }

    //удаление пользователя и аватара (если есть)
    public function remow()
    {
        $this->remowAvatar();
        $this->delete();
    }

    //загрузить аватар картинкупользователя
    public function uploadeAvatar($image)
    {
        if ($image == null) {
            return;
        }
        //dd(get_class_methods($image)); проверка какие сеть методы у объекста $image
        
        $this->remowAvatar();
        
        $filename = str_random(10) . '.' . $image->extension();
        $image->storeAs('uploads', $filename);
        $this->avatar = $filename;
        $this->save();
    }
    
    //удаление картинки (аватара) у пользователей
    public function remowAvatar()
    {
        if($this->avatar != null){
            Storage::delete('uploads/' . $this->avatar);
        }
    }

    //добавление картинки пользователем
    public function getImage()
    {
        if ($this->avatar == null) {
            return '/img/no-image.png';
        }
        return '/uploads/' . $this->avatar;
    }

    //назначение данноо пользлователя админом
    //назначить админом (1)
    public function makeAdmin()
    {
        $this->is_admin = 1;
        $this->save();
    }

    //по умолчанию создается обычный пользователь
    public function makeNormal()
    {
        $this->is_admin = 0;
        $this->save();
    }

    //переключатель пользователя и админа
    public function toggleAdmin($value)
    {
        if ($value == null) {
            return $this->makeNormal();
        }

        return $this->makeAdmin();
    }

    //пользователь статус забанен
    public function ban()
    {
        $this->status = 1; //const IS_BANNED
        $this->save();
    }

    //пользователь статус разбанен
    public function anban() //const IS_ACTIVE
    {
        $this->status = 0;
        $this->save();
    }

    //перключатель на забаненный статус
    public function toggleBan()
    {
        if ($this->status == 1) {
            return $this->anban();
        }

        return $this->ban();
    }
    
    //Находим каокой статус у пользователя проходящего аунтификацию, для проверки на бан
    public static function getStatus($request)
    {
        return self::where('email',$request)->value('status');
    }

}
