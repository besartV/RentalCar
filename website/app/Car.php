<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Car extends Model
{
    protected $fillable = ['model', 'type', 'color', 'fuel', 'rental_price'];

    public function location() {
        return $this->belongsTo('App\Location', 'location_id');
    }

    public function rentals() {
        return $this->hasMany('App\Rental');
    }
}
