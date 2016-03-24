<?php

namespace App\Http\Controllers;

use App\Car;
use App\Location;
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
            'place' => 'required|max:255',
        ]);

        $city = explode(':', $request['city'])[1];
        $place_id = intval(explode(':', $request['place'])[1]);

        dd($city . '   ' . $place_id);
    }
}
