@extends('layouts.appAdmin')

@section('content')
    <div id="wrapper" ng-controller="MapController as map">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Add location
                        </h1>

                        <form class="form-horizontal" enctype="multipart/form-data" role="form" method="POST" action="{{ url('/admin/location/add') }}">
                            {!! csrf_field() !!}

                            <div class="form-group{{ $errors->has('name') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Name</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name" value="{{ old('name') }}">

                                    @if ($errors->has('name'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('name') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('address') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Address</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="address" value="{{ old('address') }}" ng-change="geo()" ng-model="address">

                                    @if ($errors->has('address'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('address') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('city') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">City</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="city" value="{{ old('city') }}" ng-change="geo()" ng-model="city">

                                    @if ($errors->has('city'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('city') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('country') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Country</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="country" value="{{ old('country') }}" ng-change="geo()" ng-model="country">

                                    @if ($errors->has('country'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('country') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('latitude') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Latitude</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="latitude" value="{{ old('latitude') }}" ng-model="lat">

                                    @if ($errors->has('latitude'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('latitude') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('longitude') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Longitude</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="longitude" value="{{ old('longitude') }}" ng-model="long">

                                    @if ($errors->has('longitude'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('longitude') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-6">
                                    <button type="submit" class="btn btn-primary">
                                        Submit
                                    </button>
                                </div>
                            </div>
                        </form>
                        <div id="map">

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
@endsection
