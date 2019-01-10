<?php

namespace App;

use Auth;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\Model;
use Cviebrock\EloquentSluggable\Sluggable;

class Post extends Model
{

    use Sluggable;

    const IS_DRAFT = 0;
    const IS_PUBLIC = 1;

    protected $fillable = [
        'title', 'content', 'date', 'description'
    ];

    //Связь с таблицей категории многие(Post) к одному(Categories)
    public function categories()
    {
        return $this->belongsTo(Categories::class);
    }

    //Связь с таблицей пользователь многие(Post) к одному(User)
    public function author()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    
    //Связь с таблицей один(Comment) ко многим(Post)
    public function comment()
    {
        return $this->hasMany(Comment::class);
    }

    //Связь с таблицей тагс
    public function tags()
    {
        return $this->belongsToMany(
            Tag::class,
            'post_tags',
            'post_id',
            'tag_id'
        );
    }

    //создание человекопонятной ссылки 
    public function sluggable()
    {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    //создание поста
    public static function add($fields)
    {
        $post = new static;
        $post->fill($fields);
        $post->user_id = Auth::user()->id;
        $post->save();

        return $post;
    }

    //редактирование (изменение) поста
    public function edit($fields)
    {
        $this->fill($fields);
        $this->removeSlug();
        $this->save();
    }
    
    public function removeSlug()
    {
        if($this->slug != null){
            $this->delete();
        }
    }

    //удаление поста и картинки (если есть)
    public function remow()
    {
        $this->remowImage();
        $this->delete();
    }

    //создание картинки
    public function uploadImage($image)
    {
        if ($image == null) {
            return;
        }

        $this->remowImage();
        
        $obgectImage = \Image::make($image); //Создаем объект типа Intervention Image
        $obgectImage->resize(null, 200, function ($constraint) {
            $constraint->aspectRatio();
        });
        $obgectImage->blur(15);
        
        $fielname = str_random(10) . '.' . $image->extension(); 
        $imagePath = $image->storeAs('uploads', $fielname);
        
        $this->image = $fielname;
        $obgectImage->save($imagePath);

    }
    
    public function remowImage()
    {
        if($this->image != null){
            Storage::delete('uploads/' . $this->image);
        }
    }

    //присвоить категорию посту
    public function setCategory($id)
    {
        if ($id == null) {
            return;
        }

        /* $category = Categories::find($id);
          $this->categories()->save($category); */

        $this->categories_id = $id;
        $this->save();
    }

    //присвоить тег посту
    public function setTags($ids)
    {
        if ($ids == null) {
            return;
        }

        $this->tags()->sync($ids);
    }
    
    //Вывод картинки в посте
    public function getImage()
    {
        if ($this->image == null) {
            return '/img/no-image.png';
        }
        return '/uploads/' . $this->image;
    }

    //установить в черновик (0)
    public function setDraft()
    {
        $this->status = Post::IS_DRAFT;
        $this->save();
    }

    //установить в публичный доступ (1)
    public function setPublic()
    {
        $this->status = Post::IS_PUBLIC;
        $this->save();
    }

    //выбор установки публичный или в черновик (переключатель)
    public function toggleStatus($value)
    {
        if ($value == null) {
            return $this->setDraft();
        }

        return $this->setPublic();
    }

    //установить статью для вывода (1)
    public function setFeatured()
    {
        $this->is_featured = Post::IS_PUBLIC;
        $this->save();
    }

    //установить статью не выводится (0)
    public function setStandart()
    {
        $this->is_featured = Post::IS_DRAFT;
        $this->save();
    }

    //выбор установки статьи (переключатель)
    public function toggleFeatured($value)
    {
        if ($value == null) {
            return $this->setStandart();
        }

        return $this->setFeatured();
    }
    
    //меняем вид дате для баз данных
    public function setDateAttribute($vallue)
    {
        $date = Carbon::createFromFormat('d/m/y', $vallue)->format('Y-m-d');
        $this->attributes['date'] = $date;
    }
    
    //меняем вид дате для баз данных
    public function getDateAttribute($vallue)
    {
        $date = Carbon::createFromFormat('Y-m-d', $vallue)->format('d/m/y');
        return $date;
    }
    
    //Проверка категории на ноль и вывод ее наименования через связь с категорией $this->categories()
    public function getCategoryTitle()
    {
        if($this->categories != null){
            return $this->categories->title;
        }
        return 'Нет категории';
    }
    
    //Проверка тагов на пустоту и вывод их наименования
    public function getTagsTitle()
    {
        if (!$this->tags->isEmpty()) {
            return implode(', ', $this->tags->pluck('title')->all());
        }
        return 'Нет тегов';
    }
    
    //Проверка id категории на ноль
    public function getCategoryId()
    {
        if ($this->categories != null){
            return $this->categories->id;
        }
        return null;
    }
    
    //Меняем вид даты для вывода в блокес постами
    public function getDate()
    {
        $date = Carbon::createFromFormat('d/m/y', $this->date)->format('F d, Y');
        return $date;
    }
    
    //Предыдущий пост
    //Выбрать все id меньше чем текущее id и выбрать из них максимальное id, то есть: 
    //1,2,3,(4) < (5)
    //return $post->id
    public function hasPrevious()
    {
        return self::where('id', '<', $this->id)->max('id');
    }
    
    //Вывод предыдущего поста , на странице текущего поста
    public function getPrevious()
    {
        $postID = $this->hasPrevious();
        return self::find($postID);
    }
    
    //Следующий пост
    //Выбрать все id больше чем текущее id и выбрать из них минимальное id, то есть: 
    //(5) > (6),7,8,9
    //return $post->id
    public function hasNext()
    {
        return self::where('id', '>', $this->id)->min('id');
    }
    
    //Вывод следующего поста , на странице текущего поста
    public function getNext()
    {
        $postID = $this->hasNext();
        return self::find($postID);
    }
    
    //Вывод всех постов кроме текущего поста
    public function related()
    {
        return self::all()->except($this->id);
    }
    
    //Проверка категории на ноль 
    //(если исключение верно то тгода можно вывести заданную строку вшаблоне)
    public function hasCategory()
    {
        if($this->categories != null){
            return true;
        }
        return false;
    }
    
    //собирательные метод для вывода списка популярных постов (app/Providers/AppServiceProvider)
    public static function getPopularPosts()
    {
        return self::orderBy('views','desc')->where('status', Post::IS_DRAFT)->take(3)->get();
    }
    
    //собирательные метод для вывода списка рекомендуемых постов (app/Providers/AppServiceProvider)
    public static function getFeaturedPosts()
    {
        return self::where('is_featured', 1)->where('status', Post::IS_DRAFT)->take(3)->get();
    }
    
    //собирательные метод для вывода списка недавние постов (app/Providers/AppServiceProvider)
    public static function getRecentPosts()
    {
        return self::orderBy('date', 'desc')->where('status', Post::IS_DRAFT)->take(4)->get();
    }
    
    //Получить коментарии поста , через связь (comment())
    public function getComments()
    {
        return $this->comment()->where('status',1)->get();
    }
    
}
