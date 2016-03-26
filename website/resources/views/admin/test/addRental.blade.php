@extends('layouts.appAdmin')

@section('content')
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            TEST Add Rental
                        </h1>

                        <form class="form-horizontal" enctype="multipart/form-data" role="form" method="POST"
                              action="{{ url('/admin/rental/add') }}">
                            {!! csrf_field() !!}

                            <div class="form-group{{ $errors->has('start') ? ' has-error' : $errors->has('end') ? ' has-error' : ''}}"
                                 id="findCalendar">
                                <label class="col-md-2 control-label">Date</label>

                                <div class="col-md-8 input-daterange input-group" id="datepicker">
                                    <input type="date" class="input-sm form-control" name="start"/>
                                    <span class="input-group-addon">to</span>
                                    <input type="date" class="input-sm form-control" name="end"/>

                                </div>

                            <div class="form-group{{ $errors->has('car') ? ' has-error' : '' }}">
                                <label class="col-md-1 control-label">Car</label>

                                <div class="col-md-6">
                                    <select class="form-control" name="car" id="select">
                                        @foreach($cars as $car)
                                            <option value="{{$car->id}}">{{$car->model . ' - ' . $car->type}}</option>
                                        @endforeach
                                    </select>

                                    @if ($errors->has('car'))
                                        <span class="help-block">
                                        <strong>{{ $errors->first('car') }}</strong>
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
