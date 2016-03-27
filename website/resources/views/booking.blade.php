@extends('layouts.appGuest')

@section('content')
    <section ng-controller="SearchFindController">
        <div class="container container-margin">
            <div class="col-lg-12">
                @if(session()->has('book'))
                    <div class="alert alert-dismissible alert-success">
                        <strong>{{session()->pull('book', '')}}</strong>.
                    </div>
                @endif
                <h1 class="page-header">
                    List of booking
                </h1>
                <table class="table table-striped table-hover ">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Car</th>
                        <th>Location</th>
                        <th>Price</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($rentals as $rental)
                        <tr>
                            <td>{{$rental->id}}</td>
                            <td>{{$rental->from}}</td>
                            <td>{{$rental->to}}</td>
                            <td>{{$rental->car['model'] . ' - ' . $rental->car['type']}}</td>
                            <td>{{$rental->location['name'] . ' - ' . $rental->location['city']}}</td>
                            <td>{{$rental->car['rental_price']}}</td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </section>

@endsection