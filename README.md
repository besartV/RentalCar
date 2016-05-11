# RentalCar
[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)

Software Engineering Project 2016 - University of Lodz | Poland

> Looking for a rental car for your holidays or for personal reasons? RentalCar propose you some rental car with your criteria. Put the city, the period of time and choose your car!

Creation of rental car application (Website and Swift iOS Application). The most important of this application will be the web service(Restful API). This web service will use to communicate all information to iOS application. All information are saved into a database.

##Website

Client side: You can search a car with your criteria

Admin side: You can manage car, location, user

####Components and Libraries
- [Laravel framework](https://laravel.com)
  - Authentification
  - Routing system (API)
  - MVC pattern
  - Eloquent ORM (Database)
  - Migration and seeder
- AngularJS/JQuery/GoogleMaps
  - DOM Manipulation
  - Map Manipulation
  - Create Event/Catch Event (JS)
  - Ajax (POST, GET) to web service
- Composer: dependencies manager

####Intallation
1. `git clone git@github.com:YMonnier/RentalCar.git`
2. put website folder on your server
3. `cd website`
4. `composer install` - IF you don't have composer click [here](https://getcomposer.org)
5. `php artisan migrate --seed` - IF you receive a "class not found" error when running migrations, try running the `composer dump-autoload` command and re-issuing the migrate command.
6. now you can login on the website
  - client user@car.com | password: secret
  - admin admin@car.com | password: secret

##iOS Application
####Components and Libraries
- Swift 2.2
- Deployment iOS 9.3
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [EPCalendarPicker](https://github.com/ipraba/EPCalendarPicker)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Cocoapods](https://cocoapods.org): dependencies manager

####Intallation
1. `git clone git@github.com:YMonnier/RentalCar.git`
2. `cd RentalCar`
3. `pod install` - IF you don't have CocoaPods click [here](https://cocoapods.org)
4. change host url of variable `APP_URL`and `APP_STORAGE` in AppDelegate file to your host server
5. run application!

##Contributors
[@YMonnier](https://github.com/YMonnier)
