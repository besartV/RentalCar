@extends('layouts.appGuest')

@section('content')
    <section id="home">
        <div class="container home-block">
            <div class="col-md-10 col-md-offset-1 ">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="form-horizontal">
                            <fieldset>
                                <legend>Legend</legend>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                                    <div class="col-lg-10">
                                        <input type="text" class="form-control" id="inputEmail" placeholder="Email">
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