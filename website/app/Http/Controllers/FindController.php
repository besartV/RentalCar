<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class FindController extends Controller
{
    public function index() {
        return view('find.findform');
    }

    public function fetch(Request $request) {
        $this->validate($request, [
            'start' => 'required|max:255',
            'end' => 'required|max:255',
            'city' => 'required|max:255',
        ]);

        
    }
}
