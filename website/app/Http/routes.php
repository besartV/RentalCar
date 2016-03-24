<?php

/*
|--------------------------------------------------------------------------
| Routes File
|--------------------------------------------------------------------------
|
| Here is where you will register all of the routes in an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/


/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| This route group applies the "web" middleware group to every route
| it contains. The "web" middleware group is defined in your HTTP
| kernel and includes session state, CSRF protection, and more.
|
*/

use Illuminate\Support\Facades\Response;

Route::group(['middleware' => 'web'], function () {
    //Authentification
    Route::auth();
    //Divers
    Route::get('/home', 'HomeController@index');
    Route::get('/', 'HomeController@index');
    Route::get('/about', 'HomeController@about');


    //Find route
    Route::get('/find', 'FindController@index');
    Route::post('/find', 'FindController@fetch');

});

Route::group(['prefix' => 'admin', 'middleware' => ['App\Http\Middleware\AdminMiddleware', 'web']], function () {
    Route::get('/', 'AdminController@index');

    //Users
    Route::get('/users', 'AdminController@users');

    //Cars
    Route::get('/cars', 'AdminController@cars');
    Route::get('/car/add', 'AdminController@formAddCar');
    Route::post('/car/add', 'AdminController@storeCar');
    Route::get('/car/{id}/delete', 'AdminController@destroyCar');
    Route::get('/car/{id}', 'AdminController@descriptionCar');

    //Locations
    Route::get('/locations', 'AdminController@locations');
    Route::get('/location/add', 'AdminController@formAddLocation');
    Route::post('/location/add', 'AdminController@storeLocation');
    Route::get('/location/{id}/delete', 'AdminController@destroyLocation');
});


//API
Route::group(['prefix' => 'api', 'middleware' => 'api'], function() {
    Route::get('/findCities', 'ApiController@findCities');
    Route::get('/findPlaces/{city}', 'ApiController@findPlaces');

    Route::get('/cars', 'ApiController@cars');
    Route::get('/find', 'ApiController@find');

    Route::post('/register', 'AuthenticateApiController@register');
    Route::post('/login', 'AuthenticateApiController@login');
});

Route::group(['before' => 'jwt-auth', 'prefix' => 'api'], function () {
    Route::get('/restricted', 'ApiController@booked');
});

