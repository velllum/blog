<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Auth;

class AuthController extends Controller
{
    public function registerForm()
    {
        return view('pages.register');
    }
    
    public function register(Request $request)
    {
        $this->validate($request, [
           'name' => 'required',
           'email' => 'required|email|unique:users',
           'password' => 'required'
        ]);
        
        $users = User::add($request->all());
        $users->generatePassword($request->get('password'));
        
        return redirect('/login');
    }
    
    public function loginForm()
    {
        return view('pages.login');
    }
    
    public function login(Request $request)
    {
        $this->validate($request, [
           'email' => 'required|email',
           'password' => 'required'
        ]);

        if(Auth::attempt([
            'email' => $request->get('email'),
            'password' => $request->get('password'),
            'status' => 0
        ]))
        {
            return redirect('/')->with('status','Пользователь подтвержден');
        }
        
        elseif(User::getStatus($request->get('email')) == 1)
        {
            return redirect()->back()->with('status','Пользователь с таким именем ЗАБАНЕН');
        }

        return redirect()->back()->with('status','Неправильный логин или пароль');
    }
    
    public function logout()
    {
        Auth::logout();
        
        return redirect('/login');
    }
}
