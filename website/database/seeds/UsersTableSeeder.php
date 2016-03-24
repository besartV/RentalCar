<?php

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            'name' => 'Admin',
            'email' => 'admin@car.com',
            'password' => bcrypt('secret'),
            'admin' => true,
            'address' => '10 street of peace...',
        ]);

        DB::table('users')->insert([
            'name' => 'John',
            'email' => 'user@car.com',
            'password' => bcrypt('secret'),
            'admin' => false,
            'address' => '1345 street of peace...',
        ]);
    }
}
