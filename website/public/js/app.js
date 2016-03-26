'use strict';
angular.module('rcApp', []).config(function ($interpolateProvider) {
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

    $scope.geo = function () {
        console.log($scope.address + ' ' + $scope.city);
        geocoder.geocode({'address': $scope.address + ' ' + $scope.city + ' ' + $scope.country}, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                $scope.lat = results[0].geometry.location.lat();
                $scope.long = results[0].geometry.location.lng();
                new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
            } else {
                console.log('does not work...');
            }
        });
    };


}).controller('FindFormController', function ($scope, $http) {
    console.log('FindFormController');

    //Init datepicker
    $('#findCalendar .input-daterange').datepicker({
        format: "dd/mm/yyyy",
        startDate: "today",
        todayHighlight: true
    });


    //GET Request to get all cities
    $http({
        url: APP_URL + '/api/findCities',
        method: 'GET'
    }).success(function (data) {
        console.log(data);
        $scope.cities = data;
    });

    //Get request to get all place form a specific city
    $scope.findPlaces = function (city) {
        console.log('TEST...' + city);
        if (city != null) {
            $http({
                url: APP_URL + '/api/findPlaces/' + city,
                method: 'GET'
            }).success(function (data) {
                console.log(data);
                $scope.places = data;
            });
        }
    };
}).controller('SearchFindController', function ($scope) {
    console.log('TESTTEST');

    $scope.openModal = function (id) {
        console.log('Click on ' + id);
        var modal = document.getElementById('cardModel-' + id);
        modal.style.display = "block";
//        var

        var span = modal.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        };

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    };

    // var modal = document.getElementById('myModal');

// Get the button that opens the modal
    //var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
    //var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal
    /*btn.onclick = function () {
        modal.style.display = "block";
    };
*/
// When the user clicks on <span> (x), close the modal
  /*
    span.onclick = function () {
        modal.style.display = "none";
    };
*/
// When the user clicks anywhere outside of the modal, close it
    /* window.onclick = function (event) {
     if (event.target == modal) {
     modal.style.display = "none";
     }
     }*/
});