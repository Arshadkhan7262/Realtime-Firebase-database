import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/screens/auth/user_login.dart';
import 'package:firebase_crud/screens/dashboard/edit_screen.dart';
import 'package:firebase_crud/screens/dashboard/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  final refernce=FirebaseDatabase.instance.ref('data').child('student');
  FirebaseAuth auth=FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data from Firebase'),
        leading: GestureDetector(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())),
            child: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: (){
            auth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> UserLoginScreen()));
            Fluttertoast.showToast(msg: 'User Signed Out Sucessfully',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);
            
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: FirebaseAnimatedList(query: refernce,itemBuilder: (context,snapshot,animation,index){
              return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                color: Colors.lime,
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Column(

                    children: [
                      Container(
                        width:double.infinity,
                          child: Text(snapshot.child('cgpa').value.toString(),textAlign:TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),)),

                      Row(
                        children: [
                          Text(snapshot.child('father_name').value.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),),
                          Spacer(),
                          IconButton(onPressed: (){
                            var Name=snapshot.child('name').value.toString();
                            var Father=snapshot.child('father_name').value.toString();
                            var Degree_name=snapshot.child('degree_name').value.toString();
                            var Cgpa=snapshot.child('cgpa').value.toString();
                            var datakey=snapshot.key;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen(Name:Name,Father: Father,Degree_name: Degree_name,Cgpa: Cgpa,datakey: datakey,)));
                          }, icon: Icon(Icons.edit)),

                        ],
                      ),
                      Row(
                        children: [
                          Text(snapshot.child('name').value.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),),
                          Spacer(),
                          IconButton(onPressed: (){
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Are You Sure You Want to Delete this Data?'),
                                actions: [
                                  TextButton(onPressed: (){
                                    refernce.child('${snapshot.key}').remove().then((value) {
                                      Fluttertoast.showToast(msg: 'Data Deleted Successfully',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white);
                                      Navigator.pop(context);

                                    }).onError((error, stackTrace){
                                      Fluttertoast.showToast(msg: 'Data Deleted Successfully',
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white);
                                      Navigator.pop(context);

                                    });

                                  }, child: Text('YES')),
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);


                                  }, child: Text('No'))
                                ],
                              );
                            });


                          }, icon: Icon(Icons.delete)),

                        ],
                      ),
                      Container(
                        width:double.infinity,
                          child: Text(snapshot.child('degree_name').value.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),)),


                      Divider(height: 5,thickness: 5,color: Colors.blue,)
                    ],
                  ),
                ),
              );

            },))

          ],
        ),
      ),
    );
  }
}
