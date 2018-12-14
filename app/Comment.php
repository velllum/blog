<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{

    //связь с таблицей пост
    public function post()
    {
        return $this->hasOne(Post::class);
    }

    //связь стаблицей юзер
    public function author()
    {
        return $this->hasOne(User::class);
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

}
