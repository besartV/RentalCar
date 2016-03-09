@extends('layouts.appAdmin')

@section('content')
    <div id="wrapper" ng-controller="MapController as map">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            List of locations //map.test//
                        </h1>
                        <a href="{{ url('/admin/location/add') }}" class="btn btn-primary pull-right"><i class="fa fa-lg fa-plus-square"></i>  Add</a>
                        <table class="table table-striped table-hover ">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>City</th>
                                <th>Country</th>
                                <th>Latitude</th>
                                <th>Longitude</th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($locations as $location)
                                <tr>
                                    <td>{{ $location->id }}</td>
                                    <td>{{ $location->name }}</td>
                                    <td>{{ $location->address }}</td>
                                    <td>{{ $location->city }}</td>
                                    <td>{{ $location->country }}</td>
                                    <td>{{ $location->latitude }}</td>
                                    <td>{{ $location->longitude }}</td>
                                    <td><a href=" {{ url('/admin/location/' . $location->id . '/edit') }}"><i class="fa fa-lg fa-edit"></i></a></td>
                                    <td><a href="{{ url('/admin/location/' . $location->id . '/delete') }}"><i class="fa fa-lg fa-remove"></i></a></td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div id="googleMap" style="width:500px;height:380px;"></div>
                </div>

            </div>
        </div>
    </div>
@endsection
