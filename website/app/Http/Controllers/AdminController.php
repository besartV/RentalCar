<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class AdminController extends Controller
{
    public function index() {
        return view('admin.home');
    }

    /**
     * User section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function users() {
        return view('admin.users.list');
    }


    /**
     * Car section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function cars() {
        return view('admin.cars.list');
    }


    /**
     * Location section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function locations() {
        return view('admin.locations.list');
    }
}
