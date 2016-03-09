@extends('layouts.appAdmin')

@section('content')
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Description - {{ $car->model }}
                        </h1>
                        <div class="col-md-6"><img class="img-responsive"
                                                   src="{{ url('/') . '/images/cars/' . $car->picture }}"
                                                   alt="car {{$car->picture}}"></div>
                        <div class="col-md-6">
                            <p>Description: {{ $car->description }}</p>
                            <p>Model: {{ $car->model }}</p>
                            <p>Type: {{ $car->type }}</p>
                            <p>Color: {{ $car->color }}</p>
                            <p>Sits: {{ $car->sits }}</p>
                            <p>Price/Day: {{ $car->rental_price }}€</p>
                        </div>
                </div>

            </div>
        </div>
    </div>
@endsection
