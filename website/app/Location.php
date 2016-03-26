<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Location extends Model
{
    protected $fillable = ['name', 'address', 'city', 'country', 'latitude', 'longitude'];

    public function cars()
    {
        return $this->hasMany('App\Car');
    }

    public function rentals() {
        return $this->hasMany('App\Rental');
    }
}
