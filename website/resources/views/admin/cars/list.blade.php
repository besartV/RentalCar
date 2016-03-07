@extends('layouts.appAdmin')

@section('content')
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            List of cars
                        </h1>
                        <a href="{{ url('/admin/cars/add') }}" class="btn btn-primary pull-right"><i class="fa fa-lg fa-plus-square"></i>  Add</a>
                        <table class="table table-striped table-hover ">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th></th>
                                <th>Model</th>
                                <th>Type</th>
                                <th>Color</th>
                                <th>Fuel</th>
                                <th>Price</th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($cars as $car)
                                <tr>
                                    <td>{{$car->id}}</td>
                                    <td><img style="height: 100px; width: 200px;;" src="{{ url('/') . '/images/cars/' . $car->picture }}" alt="car {{$car->picture}}"></td>
                                    <td>{{$car->model}}</td>
                                    <td>{{$car->type}}</td>
                                    <td>{{$car->color}}</td>
                                    <td>{{$car->fuel}}</td>
                                    <td>{{$car->rental_price}}</td>
                                    <td><a href=""><i class="fa fa-lg fa-edit"></i></a></td>
                                    <td><a href="{{ url('/admin/cars/'.$car->id) }}"><i class="fa fa-lg fa-remove"></i></a></td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
@endsection
