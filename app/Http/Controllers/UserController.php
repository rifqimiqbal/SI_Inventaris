<?php

namespace App\Http\Controllers;



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
use Alert;

class UserController extends Controller
{
    

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
      return view('register');
    }

   /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function delete_confirm_register($id)
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store()
    {
        //
        if(Request::isMethod('post'))
        {
            $data = Input::all();
            
            

            $rules = array(
            'nama'=>'required|max:255',
           'email' => 'required|email|unique:users',
           'username' => 'required|unique:users',
           'password2' => 'required|same:password3',
           'id'=>'required|unique:users',
           'alamat'=>'required|max:50',
           'gender'=>'required',
           'hp'=>'required',
            'password3'=>'required|same:password2',
            'gambar'=>'required',);
            $validation = Validator::make(Input::all(), $rules);
            if ($validation->fails())
             {
            alert()->error('Semua data harap diisi');
             return Redirect::to('/register')->withErrors($validation)->withInput();
             }

             else{
                $data = Input::all();
                $destinationPath = 'imguser'; // upload path
                    $extension = Input::file('gambar')->getClientOriginalExtension(); // getting image extension
                    $fileName = rand(11111,99999).'.'.$extension; // renaming image
                    Input::file('gambar')->move($destinationPath, $fileName);
                    $foto=$destinationPath. '/'.$fileName;

             $id=$data['id'];
             $name=$data['nama'];
             $username=$data['username'];
             $alamat=$data['alamat'];
             $telepon=$data['hp'];
             $email=$data['email'];
             $password=bcrypt($data['password2']);
             $confirm_password=bcrypt($data['password3']);
             $gender=$data['gender']; 
             $sql="call register_native_user('$name','$email','$confirm_password',null,'$id','$telepon','$gender','$foto','$username','$alamat')";
             DB::connection()->getPdo()->exec($sql);
             DB::commit();
             return Redirect::to('/auth/login');

             }


             
             
             

       
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
         $akun =  DB::table('users')->where('id','=',$id)->get();
         
         
        return view('detail_akun', ['x' => $akun]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
       $akun =  DB::table('users')->where('id','=',$id)->get();
         
        return view('edit_akun', ['x' => $akun]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update()
    {
        if(Request::isMethod('post'))
        {

             $data = Input::all();
             $id=DB::table('users')->where('username','=',$data['username'])->get();
             
             $rules = array(
            'nama'=>'required|max:255',        
            'hp'=>'required',
            'alamat'=>'required',);
             $validation = Validator::make(Input::all(), $rules);
             if ($validation->fails())
             {
             //return redirect()->route('/editakun/', [$id[0]->id]);
            return Redirect::action('UserController@edit', array($id[0]->id))->with('message', 'Jangan ada yang kosong');
             }
             else{
             $data = Input::all();
             $name=$data['nama'];
             $username=$data['username'];
             $alamat=$data['alamat'];
             $telepon=$data['hp'];
             $x=$id[0]->id;
             $sql="call editakun('$name','$telepon','$alamat','$x')";
             DB::connection()->getPdo()->exec($sql);
             DB::commit();
             //return redirect()->route('/detailakun/', [$id[0]->id]);
             return Redirect::action('UserController@show', array($x));
             //return Redirect::route('detailakun', array($x));
             }
         } 

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function logout($username)
    { 
      $id= DB::table('users')->select('id')->where('username','=',$username )->get();
      $a=$id[0]->id;
     
       
        $sql="call logout('$a')";
        DB::connection()->getPdo()->exec($sql);
        DB::commit();
        return redirect('auth\logout');
        //
    }

   public function confirm_req()
   {
      $akun =  DB::table('users')->where('status_reg','=',0)->get();
      return view('register_confirm_request', ['x' => $akun]);

   }
   public function confirm($id)
   {
    $sql="call confirmed('$id')";
     DB::connection()->getPdo()->exec($sql);
     DB::commit();
     return redirect('/confirmrequest');

   }

   public function editfoto($id)
   {
       $akun =  DB::table('users')->where('id','=',$id)->get();
         
        return view('edit_foto', ['x' => $akun]);
   }
   public function editpassword($id)
   {
        $akun =  DB::table('users')->where('id','=',$id)->get();
         
        return view('edit_password', ['x' => $akun]);
   }
   public function updatefoto()
   {
     if(Request::isMethod('post'))
        {

             $data = Input::all();
             $id=DB::table('users')->where('username','=',$data['username'])->get();
             $a=Input::file('gambar');
             $rules = array(
            
            'gambar'=>'require|image|max:4000',);
             $validation = Validator::make(Input::all(), $rules);
             if ($validation->fails() || $a==NULL)
             {
             //return redirect()->route('/editakun/', [$id[0]->id]);
            return Redirect::action('UserController@editfoto', array($id[0]->id))->with('message', 'Jangan ada yang kosong');
             }
             else
             {
             $data = Input::all();
             $destinationPath = 'imguser'; // upload path
            $extension = Input::file('gambar')->getClientOriginalExtension(); // getting image extension
            $fileName = rand(11111,99999).'.'.$extension; // renaming image
            Input::file('gambar')->move($destinationPath, $fileName);
            $foto=$destinationPath. '/'.$fileName;
                    


             $x=$id[0]->id;
             $sql="call editfoto('$foto','$x')";
             DB::connection()->getPdo()->exec($sql);
             DB::commit();
             //return redirect()->route('/detailakun/', [$id[0]->id]);
             return Redirect::action('UserController@show', array($x));
             //return Redirect::route('detailakun', array($x));
             }
         } 
   }
   public function updatepassword()
   {
       
       if(Request::isMethod('post'))
        {

             $data = Input::all();
             $id=DB::table('users')->where('username','=',$data['username'])->get();
             
             $rules = array(
            'password2'=>'required|same:password3',        
            'password3'=>'required|same:password2',);
             $validation = Validator::make(Input::all(), $rules);
             if ($validation->fails())
             {
             //return redirect()->route('/editakun/', [$id[0]->id]);
            return Redirect::action('UserController@editpassword',array($id[0]->id))->with('message', 'Jangan ada yang kosong atau ketik ulang password dan password tidak sama');
             }
             else{
             $data = Input::all();
             $password=bcrypt($data['password2']);
             
             $x=$id[0]->id;
             $sql="call chgpassword('$password','$x')";
             DB::connection()->getPdo()->exec($sql);
             DB::commit();
             //return redirect()->route('/detailakun/', [$id[0]->id]);
             return Redirect::action('UserController@show', array($x));
             //return Redirect::route('detailakun', array($x));
             }
         } 
   }


   public function delete_confirm_req($id)
   {
    DB::table('users')->where('id', '=', $id)->delete();
     return redirect('/confirmrequest');
   }

   public function search()
   {
     if(Request::isMethod('post'))
        {

             $data = Input::all();
             $akun=DB::table('users')->where('name','like','%'.$data['nama'].'%')->paginate(2);}
             return view('register_confirm_request', ['x' => $akun]);
   } 



}
