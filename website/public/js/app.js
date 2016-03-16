'use strict';
angular.module('rcApp', []).config(function($interpolateProvider) {
    $interpolateProvider.startSymbol('//');
    $interpolateProvider.endSymbol('//');
}).controller('MapController', function ($scope) {
    console.log('FindFormController');
    var geocoder = new google.maps.Geocoder();
    this.test = "..Angular.. TEST..";

    $scope.address = '';
    $scope.city = '';
    $scope.country = '';
    var latlng = new google.maps.LatLng(51.793424, 19.523844);
    var map = new google.maps.Map(document.getElementById('map'), {
        center: latlng,
        zoom: 14
    });

    $scope.geo = function() {
        console.log($scope.address + ' ' + $scope.city);
        geocoder.geocode( { 'address': $scope.address + ' ' + $scope.city + ' ' + $scope.country}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                console.log('success');
                console.log(results[0]);
                map.setCenter(results[0].geometry.location);
                $scope.lat = results[0].geometry.location.lat();
                $scope.long = results[0].geometry.location.lng();
                new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
            } else {
                console.log('does not work...');
                //alert("Geocode was not successful for the following reason: " + status);
            }
        });
    };


}).controller('FindFormController', function ($scope){
    console.log('FindFormController');

    $('#findCalendar .input-daterange').datepicker({
        format: "dd/mm/yyyy",
        startDate: "today",
        todayHighlight: true
    });
});