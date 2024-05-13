import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditScreen extends StatefulWidget {
  String Name,Father,Degree_name,Cgpa;
  var datakey;

  EditScreen({required this.Name,required this.Father,required this.Degree_name,required this.Cgpa,required this.datakey});


  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  FirebaseDatabase firebaseDatabase=FirebaseDatabase.instance;
  final refernce=FirebaseDatabase.instance.ref('data').child('student');
  final formkey = GlobalKey<FormState>();
  TextEditingController? nameController;
  TextEditingController? fatherController;
  TextEditingController? degreeController;
  TextEditingController? cgpaController;
  var NAME,FATHER,DEGREE,CGPA;


@override
  void initState() {
   nameController=TextEditingController(text: widget.Name);
   fatherController=TextEditingController(text: widget.Father);
   degreeController=TextEditingController(text: widget.Degree_name);
   cgpaController=TextEditingController(text: widget.Cgpa);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text('Name'),
                      hintText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: fatherController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text('Father Name'),
                      hintText: 'Enter Father Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: degreeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text('Degree'),
                      hintText: 'Degree Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: cgpaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text('CGPA'),
                      hintText: 'Enter CGPA',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: (){
                    NAME=nameController?.text.toString();
                    FATHER=fatherController?.text.toString();
                    DEGREE=degreeController?.text.toString();
                    CGPA=cgpaController?.text.toString();
                    refernce.child('${widget.datakey}').update({
                      'name':NAME,
                      'father_name':FATHER,
                      'degree_name':DEGREE,
                      'cgpa':CGPA
                    }).then((value){
                      Fluttertoast.showToast(msg: 'Your Data Updated Sucessfully',
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM);

                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString(),
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM);


                    });


                  },child: Text('Update Data'),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
