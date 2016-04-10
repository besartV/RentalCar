<?php

namespace App\Http\Controllers;

use App\User;
use Validator;
use Illuminate\Http\Request;
use App\Http\Requests;
use Illuminate\Support\Facades\Response;
use JWTAuth;
use Mockery\CountValidator\Exception;
use Tymon\JWTAuth\Exceptions\JWTException;

class AuthenticateApiController extends Controller
{

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:users',
            'password' => 'required|min:6',
            'address' => 'required|max:255',
        ]);

        if ($validator->fails()){
            $s = "";
            foreach($validator->errors()->all() as $error)
                $s .= $error . " \n";
            return Response::json(['error' => $s], 400);
        }


        try {
            $user = User::create([
                'name' => $request['name'],
                'email' => $request['email'],
                'password' => bcrypt($request['password']),
                'admin' => false,
                'address' => $request['address'],
            ]);
        } catch (Exception $e) {
            return Response::json(['error' => 'User already exists.'], 400);
        }

        $token = JWTAuth::fromUser($user);

        return Response::json(compact('token'));
    }

    public function login(Request $request)
    {
        // grab credentials from the request
        $credentials = $request->only('email', 'password');

        try {
            // attempt to verify the credentials and create a token for the user
            if (!$token = JWTAuth::attempt($credentials)) {



                return response()->json(['error' => 'invalid credentials'], 400);
            }
        } catch (JWTException $e) {
            // something went wrong whilst attempting to encode the token
            return response()->json(['error' => 'could not create token'], 400);
        }
        // all good so return the token
        return response()->json(['token' => $token, 'user' => User::where('email', '=', $credentials['email'])->get()[0]]);
    }
}