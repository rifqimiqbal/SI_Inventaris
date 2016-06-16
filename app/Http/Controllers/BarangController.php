<?php

namespace App\Http\Controllers;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Pagination\Paginator;
use App\Models\Barang;
use App\Models\Area;
use App\Models\Ruang;
use Input;
use Request;
use DB;
use View;
use PDF;
use html;
use App;
use Excel;
use DNS1D;
use DNS2D;
use Alert;

class BarangController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $daftar_inventaris['barang'] = Barang::orderBy('fid_area','asc')->orderBy('fid_ruang', 'asc')->orderBy('noperarea', 'asc')->paginate(10);
        $daftar_ruang['ruang'] = Ruang::orderBy('fid_area','asc')->get();
        $daftar_area['area'] = Area::all();
        // Alert::message('Welcome back!');

            return view('barang.index',array('ruang' => $daftar_ruang, 'area' => $daftar_area ,'barang' => $daftar_inventaris));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function create($fid_area)
    {
       
         if (Request::isMethod('get')) {

            
            $daftar_ruang['ruang'] = Ruang::where('fid_area', $fid_area)->get();
            $daftar_area['area'] = Area::all();
            $item['pilih'] = Area::find($fid_area);
            // return view('barang.create',$item,$daftar_ruang,$daftar_area);


            //    $item[] = Area::find($fid_area);
            return view('barang.create', array('ruang' => $daftar_ruang, 'area' => $daftar_area ,'pilih' => $item));
        } elseif (Request::isMethod('post')) {
            $data = Input::all();


            // file start
   

              if (!empty($data['gambar'])) {
                     $destinationPath = 'imgbarang'; // upload path
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
    $maxi= DB::table('barang')
    ->where('fid_area','=',$data['fid_area'])
    ->max('noperarea');

    $rea= DB::table('area')->select('kode_area')->where('id_area','=',$data['fid_area'])->first();
    $rua= DB::table('ruang')->select('kode_ruang')->where('id_ruang','=',$data['ruang'])->first();

    $norea= sprintf('%04d',$maxi+1);

    if(Input::get('tahun')>1999){
        $nohun=Input::get('tahun')%2000;
    }
    else{
        $nohun=Input::get('tahun')%1900;
    }
    $nohun=sprintf('%02d',$nohun);


  
    $noinv= $norea."/".$rua->kode_ruang."/".$rea->kode_area."/".$nohun;
    

   

    

    

            Barang::insertGetId(array(
                    'nama_barang' => $data['nama_barang'], 
                    'merek' => $data['merek'], 
                    'tahun' => $data['tahun'], 
                    'jumlah' => $data['jumlah'], 
                    'satuan' => $data['satuan'], 
                    'fisik' => $data['fisik'], 
                    'keterangan' => $data['keterangan'],
                    'fid_ruang' => $data['ruang'],
                    'gambar' => $gambar,
                    'fid_area' => $data['fid_area'],
                    'noperarea' => $maxi+1,
                    'nomor_inventaris' => $noinv
             ));


            // $item = array('nama_barang' => Input::get('nama_barang')
            //     , 'merek' => Input::get('merek')
            //      , 'tahun' => Input::get('tahun')
            //       , 'jumlah' => Input::get('jumlah')
            //       , 'satuan' => Input::get('satuan')
            //        , 'fisik' => Input::get('fisik')
            //        , 'keterangan' => Input::get('keterangan')
            // );
             alert()->success('Barang berhasil ditambahkan!');
            return redirect('barang');
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function printpdf()
    {

         // $daftar_inventaris['barang'] = Barang::all();

          // $data['barang'] = Barang::get();
        $data = Barang::where('id_barang', '=', 1);
            // return view('barang.forprint',array('barang' => $data));
      //  return Excel::create('itsolutionstuff_example', function($excel) use ($data) {
      //   $excel->sheet('mySheet', function($sheet) use ($data)
      //   {
      //       // $sheet->loadView('barang.forprint', array('barang' => $data));
      //       $sheet->loadView('barang.forprint')
      // ->with('barang', $data);
      //       // $sheet->fromArray($data);
      //   });
      //  })->stream("xls");

        // $view = View::make('barang.forprint',$daftar_inventaris);
        // $contents = (string) $view;
        // $contents = $view->render();

        //  $html = App::make('dompdf.wrapper');
        // $html = $html->loadHtml(view('barang.forprint',$daftar_inventaris)->render());
        // return $html->download('card.pdf');


        // $pdf = PDF::loadView('barang.forprint',$data);
        // return $pdf->download('certificate.pdf');
        // $data=$data->get();

        // semua barang

        $item['barang'] = Barang::all();
        $pdf= PDF::loadView('barang.coco',$item);
         return $pdf->download('certificate.pdf');
         // close semua barang


        // return view('barang.coco',$item);

//          Excel::create('barang', function($excel) use($daftar_inventaris) {
//             $excel->sheet('Sheet 1', function($sheet) use($daftar_inventaris) {
//                  $sheet->fromArray($daftar_inventaris);
//                     });
//             })->export('xls');

//          exit();


//         Excel::create('New file', function($excel)

//                  $excel->sheet('New sheet', function($sheet) {

//         $sheet->loadView('barang.forprint');

//          });

// });
         // return $excel->download('Nsheet.xls');
        // return view('barang.forprint',$daftar_inventaris);
    }




    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function detail($id_barang)
    {
        //
        if (Request::isMethod("get")) {
            # code...
            $item['barang'] = Barang::find($id_barang);


            return view('barang.detail', $item);
        }
        elseif(Request::isMethod('post')){
        
            $daftar_inventaris['barang'] = Barang::all();

         return view('barang.index',$daftar_inventaris);
        }
           
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
   public function search()
    {
    // Gets the query string from our form submission 
    // $query = Request::input('search');
    // Returns an array of articles that have the query string located somewhere within 
    // our articles titles. Paginates them so we can break up lots of search results.
    // $articles = DB::table('articles')->where('title', 'LIKE', '%' . $query . '%')->paginate(10);
        


// $daftar_barang['barang'] = Barang::all();
$term = Input::all();

// if(!empty($term['nama_barang'])){
//     $query = Request::input('nama_barang');
//     // $daftar_barang['barang'] = Barang::where('nama_barang', $term['nama_barang'])->get();
//      // $daftar_barang['barang']->where('nama_barang','=',$term['nama_barang']);
//      $daftar_barang['barang'] = DB::table('barang')->where('nama_barang', 'LIKE', '%' . $query . '%')->paginate(10);

// }
// if(!empty($term['merek'])){
//     $query = Request::input('merek');
//     // $daftar_barang['barang'] = Barang::where('merek', $term['merek'])->get();
//      $daftar_barang['barang']->where('merek','=',$term['merek']);
// }
// if(!empty($term['ruang'])){
//     // $daftar_barang['barang'] = Barang::where('fid_ruang', $term['ruang'])->get();
//     $daftar_barang['barang']->where('fid_ruang','=',$term['ruang']);
// }










    $users = Barang::orderBy('fid_area','asc')->orderBy('fid_ruang', 'asc')->orderBy('noperarea', 'asc')->where('id_barang', '>', 0);






// $users = Barang::all();
// $daftar_barang['barang'] = Barang::all();

    $terima=array();
if (!empty($term['nama_barang'])) {
    // $daftar_barang['barang'] = $daftar_barang['barang']->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
    $users = $users->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
    $terima[0]=$term['nama_barang'];
}
$terima[0]="";

if (!empty($term['merek'])) {
    // $users = $users->where('Genre', 'LIKE', '%'.Input::get('genre').'%');
    $users = $users->where('merek', 'LIKE', '%'.$term['merek'].'%');
     $terima[1]=$term['merek'];
}

if (!empty($term['area'])) {

    // $daftar_barang['barang'] = $daftar_barang['barang']->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
//     $rea = Area::where('id_area', '>', 0);
//     $arekod=array();

//     $rea = $rea->where('id_area', 'LIKE', '%'.$term['area'].'%');
//     // $users = $users->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
//     $rea= $rea->get();
// foreach($rea as $reb):
//     foreach($reb->ruang as $lala):
//         foreach($lala->barang as $lele):
//             array_push($arekod,$lele->id_barang);
//         endforeach;
//     endforeach;
// endforeach;
    
   

//     $daftar_barang['barang'] = $users->get();
//     $daftaro['key'] = $arekod;

//     $terima[3]=$term['area'];

     $users = $users->where('fid_area','=',$term['area']);
     // $terima[2]=$term['ruang'];


}
if (!empty($term['ruang'])) {
    // $users = $users->where('Genre', 'LIKE', '%'.Input::get('genre').'%');
    $users = $users->where('fid_ruang', '=', $term['ruang']);
     $terima[2]=$term['ruang'];
} 

    // $terima[3]="";
    
     // $daftaro['key'] = NULL;

    // $users=$users->get()->toArray();

 $daftar_barang['barang'] = $users->get();
$daftar_area['area']=Area::all();
$daftar_ruang['ruang']=Ruang::orderBy('fid_area','asc')->get();
$term['seb'] = Input::all();
    // return Excel::create('itsolutionstuff_example', function($excel) use ($users) {
    //     $excel->sheet('mySheet', function($sheet) use ($users)
    //     {
    //         $sheet->fromArray($users);
    //     });
    //    })->download("xls");
     
        // $pdf= PDF::loadView('barang.forprint',array('barang' => $daftar_barang));
        //  return $pdf->download('certificate.pdf');


 return view('barang.search',array('ruang' => $daftar_ruang, 'area' => $daftar_area ,'barang' => $daftar_barang,'seb' => $term));

    // returns a view and passes the view the list of articles and the original query.
    // return view('barang.search', compact('articles', 'query'));
        // return view('barang.search',$daftar_barang,$daftaro);
    }






     public function forprint()
    {
    // Gets the query string from our form submission 
    // $query = Request::input('search');
    // Returns an array of articles that have the query string located somewhere within 
    // our articles titles. Paginates them so we can break up lots of search results.
    // $articles = DB::table('articles')->where('title', 'LIKE', '%' . $query . '%')->paginate(10);
        
 
            # code...
          
       
// $daftar_barang['barang'] = Barang::all();
        // $term = Input::all();
        // var_dump($term);
// if(!empty($term['nama_barang'])){
//     $query = Request::input('nama_barang');
//     // $daftar_barang['barang'] = Barang::where('nama_barang', $term['nama_barang'])->get();
//      // $daftar_barang['barang']->where('nama_barang','=',$term['nama_barang']);
//      $daftar_barang['barang'] = DB::table('barang')->where('nama_barang', 'LIKE', '%' . $query . '%')->paginate(10);

// }
// if(!empty($term['merek'])){
//     $query = Request::input('merek');
//     // $daftar_barang['barang'] = Barang::where('merek', $term['merek'])->get();
//      $daftar_barang['barang']->where('merek','=',$term['merek']);
// }
// if(!empty($term['ruang'])){
//     // $daftar_barang['barang'] = Barang::where('fid_ruang', $term['ruang'])->get();
//     $daftar_barang['barang']->where('fid_ruang','=',$term['ruang']);
// }





      $namafile="PLN";




    $users = Barang::orderBy('fid_area','asc')->orderBy('fid_ruang', 'asc')->orderBy('noperarea', 'asc')->where('id_barang', '>', 0);



   $term = Input::all();
   $rua['ruang']=null;
   $rea['area']=null;

// $users = Barang::all();
// $daftar_barang['barang'] = Barang::all();

if (!empty($term['nama_barang'])) {
    // $daftar_barang['barang'] = $daftar_barang['barang']->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
    $users = $users->where('nama_barang','LIKE', '%'.$term['nama_barang'].'%');
    $terima[0]=$term['nama_barang'];
    $namafile=$namafile." nama ".$term['nama_barang']." ";
}


if (!empty($term['merek'])) {
    // $users = $users->where('Genre', 'LIKE', '%'.Input::get('genre').'%');
    $users = $users->where('merek', 'LIKE', '%'.$term['merek'].'%');
     $terima[1]=$term['merek'];
         $namafile=$namafile." merek ".$term['merek']." ";
}
$terima[1]="";
   

if (!empty($term['area'])) {

    // $daftar_barang['barang'] = $daftar_barang['barang']->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
//     $rea = Area::where('id_area', '>', 0);
//     $arekod=array();

//     $rea = $rea->where('id_area', 'LIKE', '%'.$term['area'].'%');
//     // $users = $users->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
//     $rea= $rea->get();
// foreach($rea as $reb):
//     foreach($reb->ruang as $lala):
//         foreach($lala->barang as $lele):
//             array_push($arekod,$lele->id_barang);
//         endforeach;
//     endforeach;
// endforeach;
    
   

//     $daftar_barang['barang'] = $users->get();
//     $daftaro['key'] = $arekod;

//     $terima[3]=$term['area'];

     $users = $users->where('fid_area', 'LIKE', '%'.$term['area'].'%');
     // $terima[2]=$term['ruang'];
    $rea['area']= DB::table('area')->select('nama_area')->where('id_area','=',$term['area'])->first();
    $reas= DB::table('area')->select('nama_area')->where('id_area','=',$term['area'])->first();
    $namafile=$namafile." rayon ".$reas->nama_area." ";
   

}
if (!empty($term['ruang'])) {
    // $users = $users->where('Genre', 'LIKE', '%'.Input::get('genre').'%');
    $users = $users->where('fid_ruang', 'LIKE', '%'.$term['ruang'].'%');
    $rua['ruang']= DB::table('ruang')->where('id_ruang','=',$term['ruang'])->first();
     $ruas= DB::table('ruang')->select('nama_ruang')->where('id_ruang','=',$term['ruang'])->first();
    $namafile=$namafile." ruang ".$ruas->nama_ruang." ";
} 



    // $terima[3]="";
    
     // $daftaro['key'] = NULL;

    // $users=$users->get()->toArray();

    $daftar_barang['barang'] = $users->get();

    // $term['seb'] = Input::all();
    // return Excel::create('itsolutionstuff_example', function($excel) use ($users) {
    //     $excel->sheet('mySheet', function($sheet) use ($users)
    //     {
    //         $sheet->fromArray($users);
    //     });
    //    })->download("xls");
    $term['seb'] = Input::all();
        $pdf= PDF::loadView('barang.forprint',array('barang' => $daftar_barang,'seb' => $term,'area' => $rea,'ruang' => $rua));
        return $pdf->download($namafile.".pdf");
         
// return view('barang.forprint',$daftar_barang,$term);
 // return view('barang.search',array('ruang' => $daftar_ruang, 'area' => $daftar_area ,'barang' => $daftar_barang,'seb' => $term));

    // returns a view and passes the view the list of articles and the original query.
    // return view('barang.search', compact('articles', 'query'));
        // return view('barang.search',$daftar_barang,$daftaro);
    }


    public function forexcel()
    {
    // Gets the query string from our form submission 
    // $query = Request::input('search');
    // Returns an array of articles that have the query string located somewhere within 
    // our articles titles. Paginates them so we can break up lots of search results.
    // $articles = DB::table('articles')->where('title', 'LIKE', '%' . $query . '%')->paginate(10);
        
 
            # code...
          
       
// $daftar_barang['barang'] = Barang::all();
        // $term = Input::all();
        // var_dump($term);
// if(!empty($term['nama_barang'])){
//     $query = Request::input('nama_barang');
//     // $daftar_barang['barang'] = Barang::where('nama_barang', $term['nama_barang'])->get();
//      // $daftar_barang['barang']->where('nama_barang','=',$term['nama_barang']);
//      $daftar_barang['barang'] = DB::table('barang')->where('nama_barang', 'LIKE', '%' . $query . '%')->paginate(10);

// }
// if(!empty($term['merek'])){
//     $query = Request::input('merek');
//     // $daftar_barang['barang'] = Barang::where('merek', $term['merek'])->get();
//      $daftar_barang['barang']->where('merek','=',$term['merek']);
// }
// if(!empty($term['ruang'])){
//     // $daftar_barang['barang'] = Barang::where('fid_ruang', $term['ruang'])->get();
//     $daftar_barang['barang']->where('fid_ruang','=',$term['ruang']);
// }










$users = Barang::select('nomor_inventaris','nama_barang','merek','tahun','jumlah','satuan','fisik','keterangan')->orderBy('fid_area','asc')->orderBy('fid_ruang', 'asc')->orderBy('noperarea', 'asc')->where('id_barang', '>', 0);



   $term = Input::all();
$namafile="PLN";

// $users = Barang::all();
// $daftar_barang['barang'] = Barang::all();

    $terima=array();
if (!empty($term['nama_barang'])) {
    // $daftar_barang['barang'] = $daftar_barang['barang']->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
    $users = $users->where('nama_barang', 'LIKE', '%'.$term['nama_barang'].'%');
     $namafile=$namafile." nama ".$term['nama_barang']." ";
}


if (!empty($term['merek'])) {
    // $users = $users->where('Genre', 'LIKE', '%'.Input::get('genre').'%');
    $users = $users->where('merek', 'LIKE', '%'.$term['merek'].'%');
  $namafile=$namafile." merek ".$term['merek']." ";
}


if (!empty($term['area'])) {

   

//     $daftar_barang['barang'] = $users->get();
//     $daftaro['key'] = $arekod;

//     $terima[3]=$term['area'];

     $users = $users->where('fid_area', 'LIKE', '%'.$term['area'].'%');
     // $terima[2]=$term['ruang'];

   $reas= DB::table('area')->select('nama_area')->where('id_area','=',$term['area'])->first();
    $namafile=$namafile." rayon ".$reas->nama_area." ";

}
if (!empty($term['ruang'])) {
    // $users = $users->where('Genre', 'LIKE', '%'.Input::get('genre').'%');
    $users = $users->where('fid_ruang', 'LIKE', '%'.$term['ruang'].'%');

     $ruas= DB::table('ruang')->select('nama_ruang')->where('id_ruang','=',$term['ruang'])->first();
    $namafile=$namafile." ruang ".$ruas->nama_ruang." ";
} 

    // $terima[3]="";
    
     // $daftaro['key'] = NULL;

    // $users=$users->get()->toArray();

    $users=$users->get()->toArray();
    
    // $term['seb'] = Input::all();
return Excel::create($namafile, function($excel) use ($users) {
        $excel->sheet('mySheet', function($sheet) use ($users)
        {
            
            $sheet->fromArray($users);
        });
       })->download("xls");
   
     
        // $pdf= PDF::loadView('barang.forprint',$daftar_barang,$term);
        // return $pdf->download('certificate.pdf');
         
// return view('barang.forprint',$daftar_barang,$term);
 // return view('barang.search',array('ruang' => $daftar_ruang, 'area' => $daftar_area ,'barang' => $daftar_barang,'seb' => $term));

    // returns a view and passes the view the list of articles and the original query.
    // return view('barang.search', compact('articles', 'query'));
        // return view('barang.search',$daftar_barang,$daftaro);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update($id_barang)
    {
        //
        if (Request::isMethod("get")) {
            # code...
            $item['barang'] = Barang::find($id_barang);
            $semua['ruang'] = Ruang::orderBy('fid_area','asc')->get();
            return view('barang.update', $item,$semua);
        } elseif (Request::isMethod('post')) {
            # code...

            $item       = Barang::find($id_barang);


        if($item->gambar!=NULL){
            
            if (!empty(Input::file('gambar'))) {
                     $destinationPath = 'imgbarang'; // upload path
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
                     $destinationPath = 'imgbarang'; // upload path
                    $extension = Input::file('gambar')->getClientOriginalExtension(); // getting image extension
                     $fileName = rand(11111,99999).'.'.$extension; // renaming image
                    Input::file('gambar')->move($destinationPath, $fileName);
                    $gambar=$destinationPath. '/'.$fileName;}
            else{
                 $gambar=NULL;
            }

        }


    // $rea= DB::table('area')->select('kode_area')->where('id_area','=',Input::get('fid_area')->first();
    $rua= DB::table('ruang')->select('kode_ruang')->where('id_ruang','=',Input::get('fid_ruang'))->first();
    $cari = Ruang::find(Input::get('fid_ruang'));


    $norea= sprintf('%04d',Input::get('noperarea'));

    if(Input::get('tahun')>1999){
        $nohun=Input::get('tahun')%2000;
    }
    else{
        $nohun=Input::get('tahun')%1900;
    }
    $nohun=sprintf('%02d',$nohun);


  
    $noinv= $norea."/".$rua->kode_ruang."/".$cari->area->kode_area."/".$nohun;
    
 
            $item->nama_barang = Input::get('nama_barang');
            $item->merek = Input::get('merek');
            $item->tahun = Input::get('tahun');
            $item->jumlah = Input::get('jumlah');
            $item->satuan = Input::get('satuan');
            $item->fisik = Input::get('fisik');
            $item->keterangan = Input::get('keterangan');
            $item->fid_ruang = Input::get('fid_ruang');
            $item->fid_area=$cari->area->id_area;
            $item->gambar=$gambar;
            $item->nomor_inventaris=$noinv;
            $item->save();
            alert()->success('Update Sukses!');
            return redirect('barang');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

        public function delete($id)
    {
        //
        $item = Barang::find($id);
        if($item->delete())
        {
        $item->delete();
        alert()->success('Barang telah dihapus!');
        return redirect('barang');
        }
    }

    public function barcode($id)
        {
          $x=DB::table('barang')->where('id_barang', '=', $id)->get();
          $namafile=$x[0]->nomor_inventaris;
          // echo $x[0]->nomor_inventaris;
          // echo DNS1D::getBarcodeHTML($x[0]->nomor_inventaris, "C39");
          $bar['codbar']= DNS2D::getBarcodeHTML($x[0]->nomor_inventaris, "QRCODE");
          $item['barang'] = Barang::find($id);
          $pdf= PDF::loadView('barang.forbarcode',$bar,$item);
          return $pdf->download("barcode ".$namafile.".pdf");
        }

        public function allbarcode()
        {
          $x=DB::table('barang')->select('nomor_inventaris')->where('id_barang', '>', 0)->orderBy('fid_ruang','asc')->get();
          // echo $x[0]->nomor_inventaris;
          // echo DNS1D::getBarcodeHTML($x[0]->nomor_inventaris, "C39");
          $counter=0;
          foreach($x as $y):
            // $result = str_replace('/','',$y->nomor_inventaris);
         $bar['codbar'][$counter]= DNS2D::getBarcodeHTML($y->nomor_inventaris, "QRCODE");
     $counter=$counter+1;
          endforeach;

          // $bar['codbar']= DNS1D::getBarcodeHTML($x[0]->nomor_inventaris, "C39");
          $item['barang'] = Barang::select('nomor_inventaris')->orderBy('fid_ruang','asc')->get();
          $pdf= PDF::loadView('barang.allbarcode',$bar,$item);
          return $pdf->download("semua_barcode.pdf");
        }
   
}
