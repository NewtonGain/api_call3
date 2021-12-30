import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main()=>runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
Map? mapResponse;
Map? mapJsonData;
List? listResponse;

class _MyAppState extends State<MyApp> {
 

  


fetchData() async{
  http.Response response;
  response=await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
  if (response.statusCode==200){
    mapResponse=jsonDecode(response.body);
    setState(() {
      mapJsonData=mapResponse;
      listResponse=mapJsonData?["data"];
    });
  }
}
@override
  void initState() {
   
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: const Text('API Call'),
        centerTitle: true,
        
        ),
        drawer:  Drawer(elevation: 5.0,backgroundColor: Colors.cyan,child: ListView(children: const [
          DrawerHeader(child: Center(child: Text("Profile",style:
           TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
           decoration: BoxDecoration(gradient: LinearGradient(begin:Alignment.bottomLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red,Colors.blueAccent]),),),
          ListTile(leading: Icon(Icons.person),title: Text("Newton Gain"),),
          ListTile(leading: Icon(Icons.email),title: Text("newtongain7@gmail.com"),),
          ListTile(leading: Icon(Icons.phone),title: Text("01918104119"),),
        ],
        ),
        ),

        body:ListView.builder(itemCount:listResponse?.length ,itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Image.network(listResponse?[index]["avatar"]),
              Text(listResponse![index]["id"].toString()),
              Text(listResponse?[index]["first_name"],style: const TextStyle(fontSize: 27),),
              Text(listResponse?[index]["last_name"],style: const TextStyle(fontSize: 27),),
              Text(listResponse?[index]["email"],style: const TextStyle(fontSize: 27),)
            ],),
          );

        })
        ),);
  }
}