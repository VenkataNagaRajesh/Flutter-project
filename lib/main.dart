import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'example.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sending Otp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Sending Otp'),


    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController otp = TextEditingController();

  Future<void> insertRecord() async
  {
    var otp1 = otp.text;
    if(otp1!=""  && otp1!=null && otp1.isNotEmpty)
      {
        try {
          int opt2 = int.parse(otp1);
          String uri = "http://192.168.2.120/example/index.php";
          try {
            var res = await http.post(Uri.parse(uri), body: {
              "Otp": otp1
            });
            if (res.statusCode == 200) {
              otp.text = "";
              print("data inserted");
              showToast("Otp Sent Successfully");
            }
            else {
              print("error occurred while inserting the data");
              showToast("An error occurred while sending otp");
            }
          }
          catch (e) {
            print(e);
          }
        }
        catch(e)
        {
          showToast("Enter numbers only");
        }
      }
    else
      {
        print("please enter otp");
        showToast("Please Enter Otp");
      }
  }
  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.amberAccent.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Center(
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(20),
            child: SizedBox( // <-- SEE HERE
              width: 300,
              child: TextField(
                controller: otp,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),

                  ),
                  label:Text("Otp here"),

                ),
                textAlign: TextAlign.center,

              ),
            ),
          ),
          Container(   child: Column(

            children: <Widget>[


              TextButton(onPressed: () {
                insertRecord();

                //Act when the button is pressed
              },
                  child: const Text(
                    'Send Otp',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue)
              )
            ],
          ),)
        ],),

      ),

    );
  }
}
