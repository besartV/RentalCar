@extends('layouts.appAdmin')

@section('content')
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Add car
                        </h1>

                        <form class="form-horizontal" enctype="multipart/form-data" role="form" method="POST"
                              action="{{ url('/admin/car/add') }}">
                            {!! csrf_field() !!}

                            <div class="form-group{{ $errors->has('model') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Model</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="model" value="{{ old('model') }}">

                                    @if ($errors->has('model'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('model') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('type') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Type</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="type" value="{{ old('type') }}">

                                    @if ($errors->has('type'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('type') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('description') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Description</label>

                                <div class="col-md-6">
                                    <textarea class="form-control" rows="3"
                                              name="description">{{ old('description') }}</textarea>

                                    @if ($errors->has('description'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('description') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('color') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Color</label>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="color" value="{{ old('color') }}">

                                    @if ($errors->has('color'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('color') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('fuel') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Fuel</label>

                                <div class="col-md-6">
                                    <select class="form-control" name="fuel" id="select">
                                        <option>Petrol</option>
                                        <option>Diesel</option>
                                        <option>Biodiesel</option>
                                        <option>Autogas</option>
                                        <option>Ethanol Blend</option>
                                        <option>Hybrid</option>
                                    </select>

                                    @if ($errors->has('fuel'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('fuel') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>


                            <div class="form-group{{ $errors->has('sits') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Number of sits</label>

                                <div class="col-md-6">
                                    <input type="number" class="form-control" name="sits" value="{{ old('sits') }}">

                                    @if ($errors->has('sits'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('sits') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('location') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Location</label>

                                <div class="col-md-6">
                                    <select class="form-control" name="location" id="select">
                                        @foreach($locations as $location)
                                            <option value="{{$location->id}}">{{$location->city . ' - ' . $location->name}}</option>
                                        @endforeach
                                    </select>

                                    @if ($errors->has('location'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('location') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('rental_price') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Rental price per day</label>

                                <div class="col-md-6">
                                    <input type="number" class="form-control" name="rental_price"
                                           value="{{ old('rental_price') }}">

                                    @if ($errors->has('rental_price'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('rental_price') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group{{ $errors->has('picture') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Picture</label>

                                <div class="col-md-6">
                                    <input type="file" name="picture">

                                    @if ($errors->has('picture'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('picture') }}</strong>
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
                    </div>
                </div>

            </div>
        </div>
    </div>
@endsection
