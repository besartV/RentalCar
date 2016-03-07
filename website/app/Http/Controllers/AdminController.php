<?php

namespace App\Http\Controllers;

use App\Car;
use Illuminate\Foundation\Auth\User;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\File\UploadedFile;

class AdminController extends Controller
{
    public function index()
    {
        return view('admin.home');
    }

    /**
     * User section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function users()
    {
        $users = User::where('admin', '=', false)->get();
        return view('admin.users.list', ['users' => $users]);
    }


    /**
     * Car section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function cars()
    {
        $cars = Car::all();
        return view('admin.cars.list', ['cars' => $cars]);
    }

    public function formAdd()
    {
        return view('admin.cars.add');
    }

    public function formUpdate()
    {
        return view('admin.cars.add');
    }

    public function storeCar(Request $request)
    {
        //dd(base_path());
        $this->validate($request, [
            'model' => 'required|max:255',
            'type' => 'required|max:255',
            'color' => 'required|max:255',
            'fuel' => 'required|max:255',
            'rental_price' => 'required|max:255',
            'picture' => 'required',
        ]);

        $car = new Car();
        $car->model = $request['model'];
        $car->type = $request['type'];
        $car->color = $request['color'];
        $car->fuel = $request['fuel'];
        $car->rental_price = $request['rental_price'];
        $car->save();

        $file = $request->file('picture');

        $imageName = $car->id . '.' . $file->getClientOriginalExtension();

        $car->picture = $imageName;
        $car->update();
        $request->file('picture')->move(base_path() . '/public/images/cars/', $imageName);

        return redirect('/admin/cars');
    }

    public function destroyCar($id)
    {
        Car::destroy($id);
        return redirect('/admin/cars');
    }

    /**
     * Location section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function locations()
    {
        return view('admin.locations.list');
    }
}
