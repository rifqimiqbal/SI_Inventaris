<?php namespace App\Http\Controllers;


use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Models\Barang;
use App\Models\Area;
use App\Models\Ruang;
use Input;
use Request;
use DB;
use View;
use Redirect;
use Validator;


class WelcomeController extends Controller {

	/*
	|--------------------------------------------------------------------------
	| Welcome Controller
	|--------------------------------------------------------------------------
	|
	| This controller renders the "marketing page" for the application and
	| is configured to only allow guests. Like most of the other sample
	| controllers, you are free to modify or remove it as you desire.
	|
	*/

	/**
	 * Create a new controller instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$this->middleware('guest');
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function index()
	{
		return view('awal');
	}


public function forgot(){

	if(Request::isMethod('post'))
        {

             $data = Input::all();
             $id=DB::table('users')->where('email','=',$data['email'])->get();
             if($id==NULL)
             {
             	//echo "yes";
             	return Redirect::back()->with('message', 'Jangan ada yang kosong atau ketik ulang password dan password tidak sama');
             }
             else{
             $a=bcrypt($data['email']);
             $sql="call sent_remember_token('$a')";
             DB::connection()->getPdo()->exec($sql);
             DB::commit();

              return view('token');

             }
             
             
         } 
		
	}
	public function token(){

	if(Request::isMethod('post'))
        {

             $data = Input::all();
             $id=DB::table('users')->where('remember_token','=',$data['token'])->get();
             if($id==NULL)
             {
             	//echo "yes";
             	return Redirect::back()->with('message', 'Jangan ada yang kosong atau ketik ulang password dan password tidak sama');
             }
             else{
             
             

              return view('auth.reset',['x'=>$id[0]->id]);

             }
             
             
         } 
		
	}

	public function ubahpassword()
   {
       
       if(Request::isMethod('post'))
        {

             $data = Input::all();
             $id=DB::table('users')->where('id','=',$data['id'])->get();
             
             $rules = array(
            'password2'=>'required|same:password3',        
            'password3'=>'required|same:password2',);
             $validation = Validator::make(Input::all(), $rules);
             if ($validation->fails())
             {
             //return redirect()->route('/editakun/', [$id[0]->id]);
            return Redirect::back()->with('message', 'Jangan ada yang kosong atau ketik ulang password dan password tidak sama');
             }
             else{
             $data = Input::all();
             $password=bcrypt($data['password2']);
             
             $x=$id[0]->id;
             $sql="call chgpassword('$password','$x')";
             DB::connection()->getPdo()->exec($sql);
             DB::commit();
             //return redirect()->route('/detailakun/', [$id[0]->id]);
             return Redirect::to('auth/login');
             //return Redirect::route('detailakun', array($x));
             }
         } 
   }

}
