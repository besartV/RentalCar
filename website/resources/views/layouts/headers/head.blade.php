<!DOCTYPE html>
<html lang="en" ng-app="rcApp">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Rental car</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Lato:100,300,400,700" rel='stylesheet' type='text/css'>

    <!-- Styles -->
    <link href="{{ url('public/css/app.css') }}" rel="stylesheet">
    <link href="{{ url('public/css/bootstrap.min.css') }}" rel="stylesheet">
    <link href="{{ url('public/css/font-awesome.min.css') }}" rel="stylesheet">
    <link href="{{ url('public/css/bootstrap-datepicker.min.css') }}" rel="stylesheet">
    <script type="text/javascript">
        var APP_URL = {!! json_encode(url('/')) !!};
    </script>
</head>