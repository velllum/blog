<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Cviebrock\EloquentSluggable\Sluggable;

class Categories extends Model
{
    use Sluggable;
    
    protected $fillable = ['title'];

    //Связь с таблицей пост
    public function posts()
    {
        return $this->hasMany(Post::class);
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
    
    //создание категории
    public static function add($fields)
    {
        $category = new static;
        $category->fill($fields);
        $category->save();

        return $category;
    }
}
