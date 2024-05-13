import 'package:firebase_crud/screens/auth/user_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
class UserSignInScreen extends StatefulWidget {
  const UserSignInScreen({super.key});

  @override
  State<UserSignInScreen> createState() => _UserSignInScreenState();
}

class _UserSignInScreenState extends State<UserSignInScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var Name,Email,Password;
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase=FirebaseDatabase.instance;
  final databaseref=FirebaseDatabase.instance.ref('data');
  final formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(


      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [

                  Color(0xff33ccff),
                  Color(0xffff99cc)
                ]
            )
        ),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            
            child: SafeArea(
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: [
                  SizedBox(height: 30,),
                  Image.asset('assets/images/signup.png',height: 100,width: 100,),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(

                          label: Text('Name'),
                          hintText: 'Enter Name',
                          suffixIcon: Icon(Icons.person),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Your Name';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          label: Text('Email'),
                          hintText: 'Enter Email',
                          suffixIcon: Icon(Icons.email),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Email';
                              }

                              else {
                                return null;
                              }
                            },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text('Password'),
                          hintText: 'Enter Password',
                          suffixIcon: Icon(Icons.lock),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value){
                        if(value!.isEmpty)
                          {
                            return 'Enter Password';
                          }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
              
                  Container(
                      width: 200,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          onPressed: ()async{
                            if(formkey.currentState!.validate())

                            setState(() {

                            });
                            Name=nameController.text.toString();
                            Email=emailController.text.toString();
                            Password=passwordController.text.toString();
                           await auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){

                              Fluttertoast.showToast(msg: 'User Created Successfully',
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  gravity: ToastGravity.BOTTOM);


                            }).onError((error, stackTrace){
                              Fluttertoast.showToast(msg: error.toString(),
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  gravity: ToastGravity.BOTTOM);

                            });


                          }, child: Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.white),))),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account?',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 15),),
                      SizedBox(width: 10,),
              
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> UserLoginScreen()));
                        },
                          child: Text('Login',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 15),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );


  }
}
