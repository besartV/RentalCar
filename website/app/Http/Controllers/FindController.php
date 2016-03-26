<?php

namespace App\Http\Controllers;

use App\Car;
use App\Location;
use App\Rental;
use App\User;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class FindController extends Controller
{
    public function index()
    {
        return view('find.findform');
    }

    public function fetch(Request $request)
    {
        $res = [];
        $this->validate($request, [
            'start' => 'required|max:255',
            'end' => 'required|max:255',
            'city' => 'required|max:255',
            'place' => 'required|max:255',
        ]);

        $request['city'] = explode(':', $request['city'])[1];
        $request['place'] = intval(explode(':', $request['place'])[1]);

        $from = $this->formatDate($request['start']);
        $to = $this->formatDate($request['end']);

        $cars = Car::where('location_id', '=', $request['place'])->get();

        foreach ($cars as $car) {
            $add = true;
            $rentals = $car->rentals()->get();

            foreach ($rentals as $rental) {
                //dd($rental->from . '    ' . $from);
                //dd($rental->from > $from);
                if (($rental->from > $from && $rental->from < $to) || ($rental->to > $from && $rental->to < $to) || ($rental->from < $from && $rental->to > $to)) {

                    $add = false;
                    break;
                }
            }
            if ($add)
                array_push($res, $car);
        }


        return view('find.find', ['cars' => $res, 'dates' => ['from' => $from, 'to' => $to]]);
    }

    public function book($car_id, $from, $to) {
        dd('ok');
    }

    private function formatDate($s)
    {
        $date = \DateTime::createFromFormat('d/m/Y', $s);
        return $date->format('Y-m-d');
    }
}
