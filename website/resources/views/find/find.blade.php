@extends('layouts.appGuest')

@section('content')
    <section ng-controller="SearchFindController">
        <div class="container container-margin">
            <ul class="breadcrumb">
                <li><a href="{{ url('/') }}">Home</a></li>
                <li class="active">Find</li>
            </ul>
            <h1>Search results (<strong>{{ $dates['from'] . ' - ' . $dates['to'] }}</strong>):</h1>

            <div class="row">
                @if(!empty($cars))
                    @foreach($cars as $car)
                        <div class=" col-md-3">

                            <div class="panel panel-primary card" ng-click="openModal({{ $car->id }})">
                                <div class="panel-heading">
                                    <h3 class="panel-title">{{ $car->model . ' - ' . $car->type }}</h3>
                                </div>
                                <div class="panel-body">
                                    <img class="img-responsive" src="{{ url('/') . '/public/images/cars/' . $car->picture }}"
                                         alt="">

                                    <p><strong>{{ $car->sits }} sits</strong></p>

                                    <p><strong>{{ $car->fuel }}</strong></p>

                                    <span class="price pull-right card"><strong>{{ $car->rental_price }}
                                            <i class="fa fa-eur" aria-hidden="true"></i></strong></span>
                                </div>
                            </div>
                            <!-- The Modal -->
                            <div id="cardModel-{{$car->id}}" class="modal">

                                <!-- Modal content -->
                                <div class="modal-content col-md-push-4 col-md-4">
                                    <div class="modal-header">
                                        <span class="close">×</span>

                                        <h2>{{ $car->model . ' - ' . $car->type }}</h2>
                                    </div>
                                    <div class="modal-body">
                                        <p>Description: {{ $car->description }}</p>

                                        <p>Model: {{ $car->model }}</p>

                                        <p>Type: {{ $car->type }}</p>

                                        <p>Color: {{ $car->color }}</p>

                                        <p>Fuel: {{ $car->fuel }}</p>

                                        <p>Sits: {{ $car->sits }}</p>

                                        <p>Price/Day: {{ $car->rental_price }}<i class="fa fa-eur" aria-hidden="true"></i></p>
                                    </div>
                                    <div class="modal-footer">
                                        <a href="{{ url('/find/book/car/') . '/'. $car->id . '/' . $dates['from'] . '/' . $dates['to']}}"
                                           class="btn btn-primary">Book</a>
                                    </div>
                                </div>

                            </div>
                        </div>


                    @endforeach
                @else
                    <div class="panel panel-danger">
                        <div class="panel-heading">
                            <h3 class="panel-title"><strong>Ooops! </strong></h3>
                        </div>
                        <div class="panel-body">
                            There are no cars available for this time.
                        </div>
                    </div>
                @endif
            </div>
        </div>
    </section>
@endsection