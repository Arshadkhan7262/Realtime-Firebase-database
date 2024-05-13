import 'package:firebase_crud/screens/dashboard/fetch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController fatherController=TextEditingController();
  TextEditingController degreeController=TextEditingController();
  TextEditingController cgpaController=TextEditingController();
  var Name,Father,Degree,CGPA;
  final databaseref=FirebaseDatabase.instance.ref('data');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff33ccff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('Name'),
                        hintText: 'Enter Your Name',
                        suffixIcon: Icon(Icons.person),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: fatherController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('Father Name'),
                        hintText: 'Enter Father Name',
                        suffixIcon: Icon(Icons.person),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: degreeController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('Degree'),
                        hintText: 'Enter Degree Name',
                        suffixIcon: Icon(Icons.school),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: cgpaController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        label: Text('CGPA'),
                        hintText: 'Enter CGPA',
                        suffixIcon: Icon(Icons.question_mark_sharp),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: (){
                      setState(() {


                      });
                      Name=nameController.text.toString();
                      Father=fatherController.text.toString();
                      Degree=degreeController.text.toString();
                      CGPA=cgpaController.text.toString();
                      databaseref.child('student').push().set({
                        'name':Name,
                        'father_name':Father,
                        'degree_name':Degree,
                        'cgpa':CGPA

                      }).then((value){
                        Fluttertoast.showToast(msg: 'Data Added Successfully',
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        gravity: ToastGravity.BOTTOM,);

                      }).onError((error, stackTrace) {
                        Fluttertoast.showToast(msg: error.toString(),
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM,);

                      });

                    },child: Text('Send data to Firebase',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchDataScreen()));

                    },child: Text('Fetch from Firebase',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
