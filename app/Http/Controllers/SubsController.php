<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Mail\SubscribeEmail;
use App\Subscription;

class SubsController extends Controller
{
    public function subscribe(Request $request)
    {
        $this->validate($request, [
           'email' => 'required|email|unique:subscriptions'
        ]);
        
        $subs = Subscription::add($request->get('email'));
        $subs->generateToken();
        
        \Mail::to($subs)->send(new SubscribeEmail($subs));
        
        return back()->with('status','Ваш email удачно отправлен! Проверте почту!');
    }
    
    public function verify($token)
    {
        $subs = Subscription::where('token', $token)->firstOrFail();
        $subs->verifyToken();
        
        return redirect('/')->with('status', 'Ваша почта подтверждена');
    }
}
