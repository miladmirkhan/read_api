import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       
        title: Text("APi"),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
           future: getAPI(),
           builder: (context,snapshot){
              if(!snapshot.hasData){

                   return Center(child: CircularProgressIndicator());

              } else if(snapshot.hasError){

                   return Text(snapshot.error.toString());

              }else{

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){

                      return Container(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          color:index % 2==0 ?  Colors.deepPurple .shade200 : Colors.lightGreen.shade300,

                          margin: EdgeInsets.all(8.0),

                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Text(snapshot.data![index],
                            style: TextStyle(
                              color: index % 2==0 ?  Colors.black  :Colors.white ,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                              ),
                            );
                    },
                    
                    );

              }
           },

        ),
      ),
    );
  }

Future<List<dynamic>> getAPI()async{
  String theUri ="https://jsonplaceholder.typicode.com/albums";
   http.Response response= await http.get(Uri.parse(theUri));

List decodedJson=jsonDecode(response.body);
  
  return  decodedJson.map((e) => e["title"]).toList();
}





}
