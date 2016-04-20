<?php

namespace App\Http\Controllers;

use App\Http\Requests;
use Illuminate\Foundation\Auth\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {

    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('welcome');
    }

    public function about() {
        return view('about');
    }

    public function booking() {
        if (Auth::check())
        {
            $rentals = Auth::user()->rentals()->get();

            foreach($rentals as $rental) {
                $from = new \DateTime($rental->from);
                $to = new \DateTime($rental->to);
                $diff = $from->diff($to);

                $rental->car = $rental->car()->get()[0];
                $rental->location = $rental->location()->get()[0];
                $rental->days = $diff->days == 0 ? 1 : $diff->days + 1;
            }
            //dd(session()->has('book'));
            return view('booking', ['rentals' => $rentals]);
        } else {
            return redirect()->guest('login');
        }

    }
}
