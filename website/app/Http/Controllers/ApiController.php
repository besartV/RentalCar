<?php

namespace App\Http\Controllers;

use App\Car;
use App\Location;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Validation\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;

class ApiController extends Controller
{
    public function cars() {
        return response()->json(['cars' => Car::all()]);
    }

    public function find() {


        return response()->json(['fetch' => [], 'status' => 'test...']);
    }

    public function booked(Request $request) {
        try {
            JWTAuth::parseToken()->toUser();
        } catch (Exception $e) {
            return Response::json(['error' => $e->getMessage()], 400);
        }

        return Response::json(['data' => 'Congratulation, you booked a car!!!!!!!']);
    }

    public function booking() {
        try {
            JWTAuth::parseToken()->toUser();
        } catch (Exception $e) {
            return Response::json(['error' => $e->getMessage()], 400);
        }

        return Response::json(['data' => JWTAuth::parseToken()->authenticate()->rentals()->get()]);
    }


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
