<?php
/*Auth::user()->role;
Auth::user()->username;
Auth::user()->status_login;
Auth::user()->status_reg;
Auth::user()->last_login;*/

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/
Route::post('/forgot_password', array('before' => 'csrf', 'uses' => 'WelcomeController@forgot'));
Route::post('/input_token', array('before' => 'csrf', 'uses' => 'WelcomeController@token'));
Route::post('/chgpassword2', array('before' => 'csrf', 'uses' => 'WelcomeController@ubahpassword'));
Route::get('/forgot_password',  'WelcomeController@forgot');
Route::get('/input_token',  'WelcomeController@token');
Route::get('/chgpassword2',  'WelcomeController@ubahpassword');
Route::get('/', 'WelcomeController@index');
Route::get('/c', 'HomeController@index');
Route::get('/barcode/{id}','BarangController@barcode');

/*Route::get('home', 'HomeController@index');


Route::get('/barang', 'BarangController@index');



// Route::get('/barang/create', 'BarangController@create');
Route::get('/barang/create/{fid_area}', 'BarangController@create');
Route::post('/barang/create/{fid_area}', array('before' => 'csrf', 'uses' => 'BarangController@create'));
Route::get('/barang/update/{id}', 'BarangController@update');
Route::post('/barang/update/{id}', array('before' => 'csrf', 'uses' => 'BarangController@update'));
Route::get('/barang/delete/{id}', 'BarangController@delete');
Route::get('/barang/detail/{id}', 'BarangController@detail');


Route::get('/area', 'AreaController@index');
Route::get('/area/create', 'AreaController@create');
Route::post('/area/create', array('before' => 'csrf', 'uses' => 'AreaController@create'));
Route::get('/area/update/{id}', 'AreaController@update');
Route::post('/area/update/{id}', array('before' => 'csrf', 'uses' => 'AreaController@update'));
Route::get('/area/delete/{id}', 'AreaController@delete');
Route::get('/area/detail/{id}', 'AreaController@detail');


Route::get('/ruang', 'RuangController@index');
Route::get('/ruang/create', 'RuangController@create');
Route::post('/ruang/create', array('before' => 'csrf', 'uses' => 'RuangController@create'));
Route::get('/ruang/update/{id}', 'RuangController@update');
Route::post('/ruang/update/{id}', array('before' => 'csrf', 'uses' => 'RuangController@update'));
Route::get('/ruang/delete/{id}', 'RuangController@delete');
Route::get('/ruang/detail/{id}', 'RuangController@detail');*/


Route::get('/z', function(){
	$a="001/KER/CRB/03";
  echo DNS1D::getBarcodeHTML($a, "C39");/*$b="123";
	echo $b;
	$a=bcrypt($b);
    echo $a;*/
});
 /*App::missing(function($exception)
    {

        // shows an error page (app/views/error.blade.php)
        // returns a page not found error
        return Response::view('error', array(), 404);
    });*/


Route::get('/register', 'UserController@index');
Route::post('/create_user', array('before' => 'csrf', 'uses' => 'UserController@store'));

Route::get('/test',function(){
$username="iqbal";
$id=DB::table('users')->select('id')->where('username','=',$username )->get();



echo $id[0]->id;


/*$z="bana@gmail.com";
$y="iqbal";
$a=DB::table('users')->where('email','=',$z)->count();
$b=DB::table('users')->where('username','=',$y)->count();
$c=$a+$b;
echo $c;*/
});

Route::controllers([
	'auth' => 'Auth\AuthController',
	'password' => 'Auth\PasswordController',
]);


Route::group( [
    'middleware' => 'auth' ,
        ] , function() {

        	

Route::get('/barang', 'BarangController@index');
Route::get('/barang/create/{fid_area}', 'BarangController@create');
Route::post('/barang/create/{fid_area}', array('before' => 'csrf', 'uses' => 'BarangController@create'));
Route::get('/barang/update/{id}', 'BarangController@update');
Route::post('/barang/update/{id}', array('before' => 'csrf', 'uses' => 'BarangController@update'));
Route::post('/barang/delete/{id}', array('before' => 'csrf', 'uses' => 'BarangController@delete'));
Route::get('/barang/delete/{id}', 'BarangController@delete');
Route::get('/barang/detail/{id}', 'BarangController@detail');
Route::get('/barang/barcode/{id}','BarangController@barcode');
Route::get('/barang/allbarcode/','BarangController@allbarcode');
Route::get('/barang/search', 'BarangController@index');
Route::post('/barang/search',array('before' => 'csrf', 'uses' => 'BarangController@search'));
Route::get('/barang/coco', 'BarangController@printpdf');
Route::post('/barang/search/forprint',array('before' => 'csrf', 'uses' => 'BarangController@forprint'));
Route::post('/barang/search/forexcel',array('before' => 'csrf', 'uses' => 'BarangController@forexcel'));

Route::get('/barang/printpdf', 'BarangController@printpdf');


Route::get('/area', 'AreaController@index');
Route::get('/area/create', 'AreaController@create');
Route::post('/area/create', array('before' => 'csrf', 'uses' => 'AreaController@create'));
Route::get('/area/update/{id}', 'AreaController@update');
Route::post('/area/update/{id}', array('before' => 'csrf', 'uses' => 'AreaController@update'));
Route::get('/area/delete/{id}', 'AreaController@delete');
Route::get('/area/detail/{id}', 'AreaController@detail');
Route::get('/area/forprint/{id}', 'AreaController@cetakbarang');
Route::get('/area/cetakexcel/{id}', 'AreaController@cetakexcel');


Route::get('/ruang', 'RuangController@index');
Route::get('/ruang/create', 'RuangController@create');
Route::post('/ruang/create', array('before' => 'csrf', 'uses' => 'RuangController@create'));
Route::get('/ruang/update/{id}', 'RuangController@update');
Route::post('/ruang/update/{id}', array('before' => 'csrf', 'uses' => 'RuangController@update'));
Route::get('/ruang/delete/{id}', 'RuangController@delete');
Route::get('/ruang/detail/{id}', 'RuangController@detail');
Route::get('/ruang/forprint/{id}', 'RuangController@cetakbarang');
Route::get('/ruang/cetakexcel/{id}', 'RuangController@cetakexcel');



    	

       get('/dashboard', function()
     {
        $x=Auth::user()->id;
		$sql="call login('$x')";
		DB::connection()->getPdo()->exec($sql);
        DB::commit();	
		return view('home');
		
		

	}); 


  get('/logout/{id}',  'UserController@logout');

  get('/editakun/{id}',  'UserController@edit');
  get('/editfoto/{id}',  'UserController@editfoto');
  get('/editpassword/{id}',  'UserController@editpassword');
  post('/updateakun', array('before' => 'csrf', 'uses' => 'UserController@update'));
  post('/updatefoto',  array('before' => 'csrf', 'uses' =>'UserController@updatefoto'));
  post('/updatepassword',array('before' => 'csrf', 'uses' =>  'UserController@updatepassword'));
  get('/akun/{id}',  'UserController@show');
  get('/confirmrequest', 'UserController@confirm_req');
  get('/confirm/{id}', 'UserController@confirm');
  get('/detailakun', function(){
  
      $akun=Auth::user();   
     return view('detail_akun');   
  });
  get('/deleteconfirmrequest/{id}', 'UserController@delete_confirm_req');
   post('/confirm/{id}', 'UserController@confirm');
   post('/confirm_search',array('before' => 'csrf', 'uses' =>'UserController@search'));
  

	

} );
