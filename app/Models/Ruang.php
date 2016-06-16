<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ruang extends Model
{
    //
    protected $table = "ruang";

    protected $primaryKey='id_ruang';

	protected $fillable = ['id_ruang', 'nama_ruang','fid_area','foto']; 

	public function area(){
		return $this->belongsTo('App\Models\Area','fid_area','id_area');
	}

	public function barang(){
    	return $this->hasMany('App\Models\Barang', 'fid_ruang', 'id_ruang');
    }

}
