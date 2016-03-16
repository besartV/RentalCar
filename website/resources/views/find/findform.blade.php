@extends('layouts.appGuest')

@section('content')
    <section id="home" ng-controller="FindFormController">
        <div class="container home-block">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="form-horizontal">
                            <fieldset>
                                <legend>Your rental car!</legend>
                                <div class="form-group{{ $errors->has('start') ? ' has-error' : $errors->has('end') ? ' has-error' : ''}}"
                                     id="findCalendar">
                                    <label class="col-md-2 control-label">Date</label>

                                    <div class="col-md-8 input-daterange input-group" id="datepicker">
                                        <input type="text" class="input-sm form-control" name="start"/>
                                        <span class="input-group-addon">to</span>
                                        <input type="text" class="input-sm form-control" name="end"/>
                                        @if ($errors->has('start') || $errors->has('end'))
                                            <span class="help-block">
                                        <strong>{{ $errors->first('start') }}</strong>
                                    </span>
                                            <span class="help-block">
                                        <strong>{{ $errors->first('end') }}</strong>
                                    </span>
                                        @endif
                                    </div>
                                </div>

                                <div class="form-group{{ $errors->has('city') ? ' has-error' : '' }}">
                                    <label class="col-md-2 control-label">City</label>

                                    <div class="input-city col-md-8">
                                        <input type="text" class=" form-control" name="city" value="{{ old('city') }}">

                                        @if ($errors->has('city'))
                                            <span class="help-block">
                                        <strong>{{ $errors->first('city') }}</strong>
                                    </span>
                                        @endif
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-lg-10 col-lg-offset-2 ">
                                        <button type="submit" class="btn btn-primary pull-right">Submit</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </section>
@endsection