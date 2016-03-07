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

Route::group(['middleware' => 'web'], function () {
    //Authentification
    Route::auth();
    //Divers
    Route::get('/home', 'HomeController@index');
    Route::get('/', 'HomeController@index');
    Route::get('/about', 'HomeController@about');


    //Find route
    Route::get('/find', 'FindController@index');
});

Route::group(['prefix' => 'admin', 'middleware' => ['App\Http\Middleware\AdminMiddleware','web']], function()
{
    Route::get('/', 'AdminController@index');

    //Users
    Route::get('/users', 'AdminController@users');

    //Cars
    Route::get('/cars', 'AdminController@cars');
    Route::get('/cars/add', 'AdminController@formAdd');
    Route::post('/cars/add', 'AdminController@storeCar');
    Route::get('/cars/{id}', 'AdminController@destroyCar');

    //Locations
    Route::get('/locations', 'AdminController@locations');
});
