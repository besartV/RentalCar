<?php

namespace App\Http\Controllers;

use App\Car;
use App\Location;
use App\Rental;
use Illuminate\Foundation\Auth\User;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
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
        foreach ($cars as $car) {
            $location = Location::find($car->location_id);
            $car->locationName = $location->city . ' - ' . $location->name;
        }
        return view('admin.cars.list', ['cars' => $cars]);
    }

    public function formAddCar()
    {
        $locations = Location::all();
        return view('admin.cars.add', ['locations' => $locations]);
    }

    public function formUpdate()
    {
        return view('admin.cars.add');
    }

    public function storeCar(Request $request)
    {
        $this->validate($request, [
            'model' => 'required|max:255',
            'type' => 'required|max:255',
            'description' => 'required|max:255',
            'color' => 'required|max:255',
            'fuel' => 'required|max:255',
            'rental_price' => 'required|max:255',
            'sits' => 'required|max:255',
            'location' => 'required|max:255',
            'picture' => 'required',
        ]);


        $car = new Car();
        $car->model = $request['model'];
        $car->type = $request['type'];
        $car->color = $request['color'];
        $car->fuel = $request['fuel'];
        $car->description = $request['description'];
        $car->sits = $request['sits'];
        $car->location_id = intval($request['location']);
        $car->rental_price = $request['rental_price'];
        $car->save();

        $file = $request->file('picture');

        $imageName = $car->id . '.' . $file->getClientOriginalExtension();

        $car->picture = $imageName;
        $car->update();
        $request->file('picture')->move(base_path() . '/public/images/cars/', $imageName);

        return redirect('/admin/cars');
    }

    public function descriptionCar($id)
    {
        $car = Car::find($id);
        return view('admin.cars.desc', ['car' => $car]);
    }

    public function destroyCar($id)
    {
        $car = Car::find($id);
        $car->rentals()->delete();
        File::delete(public_path() . '/images/cars/' . $car->picture);
        $car->delete();
        return redirect('/admin/cars');
    }

    /**
     * Location section
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function locations()
    {
        $locations = Location::all();
        return view('admin.locations.list', ['locations' => $locations]);
    }

    public function formAddLocation()
    {
        return view('admin.locations.add');
    }

    public function storeLocation(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|max:255',
            'address' => 'required|max:255',
            'city' => 'required|max:255',
            'country' => 'required|max:255',
            'latitude' => 'required|max:255',
            'longitude' => 'required',
        ]);

        $location = new Location();
        $location->name = $request->name;
        $location->address = $request->address;
        $location->city = $request->city;
        $location->country = $request->country;
        $location->latitude = $request->latitude;
        $location->longitude = $request->longitude;

        $location->save();

        return redirect('/admin/locations');
    }

    public function destroyLocation($id)
    {
        Location::destroy($id);
        return redirect('/admin/locations');
    }

    public function formAddRental() {
        $cars = Car::all();
        return view('admin.test.addRental', ['cars' => $cars]);
    }

    public function storeRental(Request $request) {
        $car = Car::find(intval($request['car']));
        $rental = new Rental();
        $rental->from = $this->formatDate($request['start']);
        $rental->to = $this->formatDate($request['end']);
        $rental->car_id= intval($request['car']);
        $rental->user_id = Auth::user()->id;
        $rental->location_id = $car->location_id;
        $rental->save();
        return redirect()->back();
        //dd($rental);
    }

    //Change format date dd/mm/yyyy to yyyy/mm/dd
    private function formatDate($s) {
        $date = \DateTime::createFromFormat('d/m/Y', $s);
        return $date->format('Y/m/d');
    }
}
