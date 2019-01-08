<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Categories;

class CategoriesController extends Controller
{
    public function index()
    {
        $categories = Categories::all();
        return view('admin.categories.index', ['categories' => $categories]);
    }
    
    public function create()
    {
        return view('admin.categories.create');
    }
    
    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required' //обезательное поле
        ]);
        
        Categories::create($request->all());
        return redirect()->route('categories.index');
    }
    
    public function edit($id)
    {
        $categories = Categories::find($id);
        return view('admin.categories.edit', ['categories' => $categories]);
    }
    
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'title' => 'required' //обезательное поле
        ]);
        
        $categories = Categories::find($id);
        $categories->update($request->all());
        $categories->updateSlug();
        
        return redirect()->route('categories.index');
    }
    
    public function destroy($id)
    {
        $categories = Categories::find($id);
        $categories->delete();
        return redirect()->route('categories.index');
    }
}
