<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{

    //связь с таблицей пост многие(Comment) к одному(Post)
    public function post()
    {
        return $this->belongsTo(Post::class);
    }

    //связь стаблицей юзер многие(Comment) к одному(User)
    public function author()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    //коментарий статус разрешен
    public function allow()
    {
        $this->status = 1;
        $this->save();
    }

    //коментарий статус запрещен (по умолчанию)
    public function disAllow()
    {
        $this->status = 0;
        $this->save();
    }

    //перключатель на разрешенный статус
    public function toggleStatus()
    {
        if ($this->status == 0) {
            return $this->allow();
        }

        return $this->disAllow();
    }
    
    public function remove()
    {
        $this->delete();
    }

}
