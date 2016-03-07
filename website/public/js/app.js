'use strict';
/*
 var rc  = (function() {
 return {
 modules: {}
 }
 })();

 rc.modules.home = (function() {
 return {
 init: function() {

 }
 }
 })();
 */

//  rc.modules.home.init();
console.log("OOKOKOK");
angular.module('rcApp', []).config(function($interpolateProvider) {
    $interpolateProvider.startSymbol('//');
    $interpolateProvider.endSymbol('//');
}).controller('MapController', function () {
    this.test = "HELLO";
});