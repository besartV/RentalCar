<?php

namespace App\Http\Controllers;

use App\Car;
use App\Location;
use App\Rental;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Tymon\JWTAuth\Facades\JWTAuth;
use Validator;

class ApiController extends Controller
{
    public function cars() {
        return response()->json(['cars' => Car::all()]);
    }

    /**
     * Method which allows to find all cars
     * available with specific criteria
     * start - date from
     * end - date to
     * city
     * place
     * @param Request $request
     * @return mixed
     */
    public function find(Request $request) {
        $validator = Validator::make($request->all(), [
            'start' => 'required|max:255',
            'end' => 'required|max:255',
            'city' => 'required|max:255',
            'place' => 'required|max:255',
        ]);

        if ($validator->fails()) {
            return Response::json(['error' => $validator->errors()->all()], 400);
        }
        $res = [];
        $from = $this->formatDate($request['start']);
        $to = $this->formatDate($request['end']);

        $cars = Car::where('location_id', '=', $request['place'])->get();

        foreach ($cars as $car) {
            $add = true;
            $rentals = $car->rentals()->get();

            foreach ($rentals as $rental) {
                //dd($rental->from . '    ' . $from);
                //dd($rental->from > $from);
                if (($rental->from >= $from && $rental->from <= $to) || ($rental->to >= $from && $rental->to <= $to) || ($rental->from <= $from && $rental->to >= $to)) {
                    $add = false;
                    break;
                }
            }
            if ($add)
                array_push($res, $car);
        }

        return Response::json(['data' => $res]);
    }

    /**
     * Method which create a rental for this user
     * @param Request $request
     * @return mixed
     */
    public function booked(Request $request) {
        //return Response::json('OKOK');

        $validator = Validator::make($request->all(), [
            'from' => 'required|max:255',
            'to' => 'required|max:255',
            'user_id' => 'required|max:255',
            'car_id' => 'required|max:255',
        ]);

        if ($validator->fails()) {
            return Response::json(['error' => $validator->errors()->all()], 400);
        }

        $car = Car::find($request['car_id']);
        //dd(Auth::id());
        $rental = new Rental();
        $rental->from = $request['from'];
        $rental->to = $request['to'];
        $rental->car_id = $request['car_id'];
        $rental->location_id = $car->location_id;
        $rental->user_id = $request['user_id'];

        $rental->save();
        return Response::json(['data' => 'Congratulation, you are booked a car!!!!!!!']);
    }

    /**
     * Return all booking of the user
     * @return mixed
     */
    public function booking() {
        try {
            JWTAuth::parseToken()->toUser();
        } catch (Exception $e) {
            return Response::json(['error' => $e->getMessage()], 400);
        }
        $rentals = JWTAuth::parseToken()->authenticate()->rentals()->get();
        foreach($rentals as $rental) {
            $from = new \DateTime($rental->from);
            $to = new \DateTime($rental->to);
            $diff = $from->diff($to);

            $rental->car = $rental->car()->get()[0];
            $rental->location = $rental->location()->get()[0];
            $rental->days = $diff->days == 0 ? 1 : $diff->days + 1;
        }

        return Response::json(['data' => $rentals]);
    }

    /**
     * Return all cities where we can find a rental car
     * @return mixed
     */
    public function findCities() {
        $cities = [];
        $locations = Location::all();
        foreach ($locations as $location ) {
            if (!in_array($location->city,$cities)){
                array_push($cities, $location->city);
            }
        }
        return Response::json(['data' => $cities]);
    }

    /**
     * Return all places of a specific sity
     * @param $city
     * @return mixed
     */
    public function findPlaces($city) {
        $places = [];
        $locations = Location::where('city', '=', $city)->get();
        foreach ($locations as $location ) {
            if (!in_array($location->city,$places)){
                $places[intval($location->id)] = $location->name . " - " . $location->address;
            }
        }
        return Response::json(['data' => $places]);
    }

    private function formatDate($s)
    {
        $date = \DateTime::createFromFormat('d/m/Y', $s);
        return $date->format('Y-m-d');
    }
}
