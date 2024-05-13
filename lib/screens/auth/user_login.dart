import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crud/screens/auth/user_signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final formkey = GlobalKey<FormState>();
  FirebaseAuth auth=FirebaseAuth.instance;
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
                    Image.asset('assets/images/login.png',height: 100,width: 100,),
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
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Email';
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
                          if(value!.isEmpty){
                            return 'Enter Password';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        child: Text('Forget Password?',textAlign: TextAlign.end,)),
                    SizedBox(height: 10,),
                    Container(
                        width: 200,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                            onPressed: (){
                              if(formkey.currentState!.validate())
                                {
                                  setState(() {
                                    auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
                                      Fluttertoast.showToast(msg: 'User Logged In Successfully',
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                                    }).onError((error, stackTrace){


                                      Fluttertoast.showToast(msg: error.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          gravity: ToastGravity.BOTTOM);

                                    });

                                  });
                                }
                            }, child: Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.white),))),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t Have Account ?',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 15),),
                        SizedBox(width: 10,),
                
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UserSignInScreen()));
                          },
                            child: Text('Sign Up',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 15,),))
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
