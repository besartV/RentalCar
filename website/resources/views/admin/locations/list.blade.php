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
                        <a href="{{ url('/admin/cars/add') }}" class="btn btn-primary pull-right"><i class="fa fa-lg fa-plus-square"></i>  Add</a>
                        <table class="table table-striped table-hover ">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>City</th>
                                <th>Latitude</th>
                                <th>Longitude</th>
                                <th>Price</th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td><a href=""><i class="fa fa-lg fa-edit"></i></a></td>
                                    <td><a href=""><i class="fa fa-lg fa-remove"></i></a></td>
                                </tr>
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
