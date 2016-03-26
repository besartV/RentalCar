<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Rental extends Model
{
    //
    public function car() {
        return $this->belongsTo('App\Car', 'car_id');
    }

    public function user() {
        return $this->belongsTo('App\User', 'user_id');
    }

    public function location() {
        return $this->belongsTo('App\Location', 'location_id');
    }
}
