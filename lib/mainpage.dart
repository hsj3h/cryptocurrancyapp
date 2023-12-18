import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Mainpage extends StatefulWidget {


  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  Map cryptodata={};
  String newtime='';

  @override
  void initState() {
    (){
      Timer.periodic(Duration(seconds: 1), (Timer timer) async {
        var dio=Dio();
        Response getdatas=await dio.get('https://api.coindesk.com/v1/bpi/currentprice.json');
        print(getdatas);
        print(getdatas.data.runtimeType);
        Map<String, dynamic> stringToMap(String jsonString) {
          // Parse the JSON string and convert it into a Map
          Map<String, dynamic> data = json.decode(jsonString);
          return data;
        }
        String jsonString = '{"key1": "value1", "key2": "value2"}';
        Map<String, dynamic> mapData = stringToMap(getdatas.data);
        print(mapData);
        print(mapData.runtimeType);
        print(mapData['bpi']['USD']['rate']);
        print(mapData['time']['updated']);
        String inputString = "Oct 20, 2023 07:37:00 UTC";
        DateTime dateTime = DateFormat("MMM d, y H:m:s 'UTC'").parse(mapData['time']['updated']);
        String formattedTime = DateFormat('HH:mm').format(dateTime);
        print(formattedTime);


        // DateFormat formatter = DateFormat('HH:mm a');

        // Format the DateTime to a string with hour and minute
        // String formattedTime = formatter.format(timenew);
        // print(formattedTime);




        setState(() {
          cryptodata=mapData;
          newtime=formattedTime;
        });


      });
    }();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          elevation: 0,

        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: 410,
              decoration: BoxDecoration(color: Colors.yellowAccent,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bitcoin",style: TextStyle(fontSize: 30),),
                      SizedBox(width: 250,),
                      Text("BTC",style: TextStyle(fontSize: 25)),

                    ],



                  ),Center(child: Text("\$ ${cryptodata['bpi']['USD']['rate']}",style: TextStyle(fontSize: 30),)),
                  Center(child: Text("\$ ${cryptodata['bpi']['USD']['rate_float']}",style: TextStyle(fontSize: 15,color: Colors.red),)),
                  SizedBox(height: 50,),

                  

                ],
              ),
              


            ),
            Card(
              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network('https://1000logos.net/wp-content/uploads/2023/01/Ethereum-logo.png',height: 100,width: 100,),
                  Column(
                    children: [
                      Text('Ethereum',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text('ETH',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),)
                    ],

                  ),
                  Text('\$1.7455.5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            ),
            Card(
              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network('https://1000logos.net/wp-content/uploads/2022/09/Shiba-Inu-Logo.png',height: 100,width: 100,),
                  Column(
                    children: [
                      Text('Shibainu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text('SHB',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),)
                    ],

                  ),
                  Text('\$00.9885.5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            ),
            Card(
              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network('https://1000logos.net/wp-content/uploads/2022/02/ADA-Logo.png',height: 100,width: 100,),
                  Column(
                    children: [
                      Text('Cardano',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text('ADA',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),)
                    ],

                  ),
                  Text('\$1.4325.5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            ),
            Card(
              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network('https://1000logos.net/wp-content/uploads/2018/05/Ripple-Logo.png',height: 100,width: 100,),
                  Column(
                    children: [
                      Text('Ripple',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text('RPL',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),)
                    ],

                  ),
                  Text('\$0.884.5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
