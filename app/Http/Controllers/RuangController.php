<?php

namespace App\Http\Controllers;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Models\Ruang;
use App\Models\Area;
use App\Models\Barang;
use Input;
use Request;
use PDF;

use html;
use App;
// use Maatwebsite\Excel\Facades\Excel;
use Excel;

use View;




class RuangController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $daftar_ruang['ruang'] = Ruang::orderBy('fid_area','asc')->paginate(10);
         return view('ruang.index',$daftar_ruang);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
         if (Request::isMethod('get')) {
            $daftar_area['area'] = Area::all();
            return view('ruang.create',$daftar_area);
        } elseif (Request::isMethod('post')) {
            $data = Input::all();


            // file start
   

              if (!empty($data['gambar'])) {
                     $destinationPath = 'imgruang'; // upload path
                    $extension = Input::file('gambar')->getClientOriginalExtension(); // getting image extension
                     $fileName = rand(11111,99999).'.'.$extension; // renaming image
                    Input::file('gambar')->move($destinationPath, $fileName);
                    $gambar=$destinationPath. '/'.$fileName;}
            else{
                 $gambar=NULL;
    }
    

            // // file end

            // print $target_file_final;
            // out();

            Ruang::insertGetId(array(
                    'nama_ruang' => $data['nama_ruang'], 
                    'fid_area' => $data['fid_area'], 
                     'kode_ruang' => $data['kode_ruang'], 
                    'foto' => $gambar
             ));


            // $item = array('nama_ruang' => Input::get('nama_ruang')
            //     , 'merek' => Input::get('merek')
            //      , 'tahun' => Input::get('tahun')
            //       , 'jumlah' => Input::get('jumlah')
            //       , 'satuan' => Input::get('satuan')
            //        , 'fisik' => Input::get('fisik')
            //        , 'keterangan' => Input::get('keterangan')
            // );

            alert()->success('Ruangan berhasil ditambahkan!');
            return redirect('ruang');
        }
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function detail($id_ruang)
    {
        //
        $item['ruang'] = Ruang::find($id_ruang);
        $daftar_barang['barang'] = Barang::where('fid_ruang', $id_ruang)->get();
            return view('ruang.detail', $item,$daftar_barang);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update($id_ruang)
    {
        //
        if (Request::isMethod("get")) {
            # code...
            $item['ruang'] = Ruang::find($id_ruang);
            $daftar_area['area'] = Area::all();
            return view('ruang.update', $item,$daftar_area);
            
        } elseif (Request::isMethod('post')) {
            # code...

            $item       = Ruang::find($id_ruang);


        if($item->gambar!=NULL){
            
            if (!empty(Input::file('gambar'))) {
                     $destinationPath = 'imgruang'; // upload path
                    $extension = Input::file('gambar')->getClientOriginalExtension(); // getting image extension
                     $fileName = rand(11111,99999).'.'.$extension; // renaming image
                    Input::file('gambar')->move($destinationPath, $fileName);
                    $gambar=$destinationPath. '/'.$fileName;}
            else{
                 $gambar=$item->gambar;
            }
        }
        else{
                
            if (!empty(Input::file('gambar'))) {
                     $destinationPath = 'imgruang'; // upload path
                    $extension = Input::file('gambar')->getClientOriginalExtension(); // getting image extension
                     $fileName = rand(11111,99999).'.'.$extension; // renaming image
                    Input::file('gambar')->move($destinationPath, $fileName);
                    $gambar=$destinationPath. '/'.$fileName;}
            else{
                 $gambar=NULL;
            }

        }

            $item->nama_ruang = Input::get('nama_ruang');
            $item->fid_area=Input::get('fid_area');
            $item->kode_ruang=Input::get('kode_ruang');
            $item->foto=$gambar;
            $item->save();
            alert()->success('Update Sukses!');
            return redirect('ruang');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

    public function cetakbarang($id)
    {
        //
        $item['ruang'] = Ruang::find($id);
        $users = Barang::where('id_barang', '>', 0)->orderBy('fid_ruang','asc');
        $users = $users->where('fid_ruang', 'LIKE', '%'.$id.'%');

        $daftar_barang['barang'] = $users->get();
         $namafile="PLN";
        $namafile=$namafile." Ruang ".$item['ruang']->nama_ruang." ";
         $pdf= PDF::loadView('ruang.forprint',$daftar_barang,$item);
        return $pdf->download($namafile.".pdf");
        // $daftar_barang['barang'] = Barang::where('fid_area', $id)->orderBy('fid_ruang','asc')->get();
        // return view('area.forprint',$item ,$daftar_barang);
    }

    public function cetakexcel($id)
    {
        //
        $item['ruang'] = Ruang::find($id);
        $users = Barang::select('nomor_inventaris','nama_barang','merek','tahun','jumlah','satuan','fisik','keterangan')->orderBy('fid_ruang','asc')->where('id_barang', '>', 0);
        $users = $users->where('fid_ruang', 'LIKE', '%'.$id.'%');

        // $daftar_barang['barang'] = $users->get();

        $users=$users->get()->toArray();
        $namafile="PLN";
        $namafile=$namafile." Ruang ".$item['ruang']->nama_ruang." Rayon ".$item['ruang']->area->nama_area;
        return Excel::create($namafile, function($excel) use ($users) {
        $excel->sheet('mySheet', function($sheet) use ($users)
        {
            
            $sheet->fromArray($users);
        });
       })->download("xls");



        //  $pdf= PDF::loadView('area.forprint',$daftar_barang,$item);
        // return $pdf->download('certificate.pdf');
        // // $daftar_barang['barang'] = Barang::where('fid_area', $id)->orderBy('fid_ruang','asc')->get();
        // return view('area.forprint',$item ,$daftar_barang);
    }

        public function delete($id)
    {
        //
        $item = Ruang::find($id);
        $item->delete();
        alert()->success('Ruangan telah dihapus!');
        return redirect('ruang');
    }

   
}
