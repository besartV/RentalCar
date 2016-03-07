<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateForeignkey extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('rentals', function ($table) {
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('car_id')->references('id')->on('cars');
            $table->foreign('location_id')->references('id')->on('locations');
        });

        Schema::table('cars', function ($table) {
            $table->foreign('location_id')->references('id')->on('locations');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('rentals', function ($table) {
            $table->dropForeign(['user_id']);
            $table->dropForeign(['car_id']);
            $table->dropForeign(['location_id']);
        });

        Schema::table('cars', function ($table) {
            $table->dropForeign(['location_id']);
        });
    }
}
