<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Barang extends Model
{
    //

    protected $table = "barang";

    protected $primaryKey='id_barang';

	protected $fillable = ['id_barang', 'nama_barang','merek','tahun','nomor_inventaris','jumlah',
	'satuan','fisik','keterangan','fid_ruang','gambar']; 

	public function ruang(){
		return $this->belongsTo('App\Models\Ruang','fid_ruang','id_ruang');
	}
}