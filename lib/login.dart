import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalpedia/classes/activationclass.dart';
import 'package:legalpedia/verification.dart';
import 'package:legalpedia/classes/activationserv.dart';
import 'package:legalpedia/main.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';


class Activation extends StatefulWidget{
  @override
  _Activation createState()=> _Activation();

}

//Activation
class _Activation extends State<Activation> {
String phone;
String mac;
String phoneAct;
String name;

TextEditingController phoneController =  TextEditingController();
TextEditingController nameController =  TextEditingController();

Future<bool> loader(){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: ScalingText("Getting OTP. Please wait...", style: TextStyle(
          fontSize: 14
        ),),
      ));
}


Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: Text(str, style: TextStyle(
            fontSize: 14,
          color: Colors.red

        ),),
      ));
}


  void getOtp(){
    new Future.delayed(Duration.zero, () {
      loader();
      Services.getOTP(phone, mac).then((responseFromServer) {
        setState(() {
          phoneAct = responseFromServer;
          try{
          if(phoneAct.contains('Error')){
              Navigator.pop(context);
              dialog(phoneAct);
            //Show a Dialog Box and ask them to create an account
          }else{

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return Verification(phone, mac, name);
            }));

          }
          }
          catch(e){
            Navigator.pop(context);
            dialog(e.toString());
          }
        });
      });
    });
  }

 static Future<String> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } on Exception {
      print('Failed to get platform version');
    }

//if (!mounted) return;
return identifier;
}

  @override
  void initState() {
     
    // TODO: implement initState
    super.initState();
    setState(() {
    
      SharedPreferences.getInstance().then((ss){

        name =ss.getString('Name') ?? 'null';
        phone =ss.getString('Phone') ?? 'null';

         if(name!='null'){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return MyHomePage(name,phone);
        }));

      }

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child:  Image.asset('assets/LGPLogo.png', height: 30.0)
                    )
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'FULL NAME',
                        labelStyle:  TextStyle(
                            fontFamily: 'MontSerrat',
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        labelText: 'PHONE NUMBER or EMAIL',
                        labelStyle:  TextStyle(
                            fontFamily: 'MontSerrat',
                            fontWeight: FontWeight.bold
                        )
                    ),

                  ),

                  SizedBox(height: 40.0),
                  Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: ()async{
                            phone= phoneController.text;
                           // mac= phoneController.text;
                            mac = await getDeviceDetails();
                            print(mac);
                            name = nameController.text;
                            getOtp();

                          },
                          child: Center(
                            child: Text(
                              'REQUEST ACTIVATION CODE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          ),
                        )
                    ),

                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all( color: Colors.black, style: BorderStyle.solid, width: 1.0),
                          color: Colors.transparent,
                          borderRadius:  BorderRadius.circular(20.0)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: IconButton(icon: new Icon(Icons.email), onPressed: null),
                          ),
                          Center(
                            child: Text('Create An Account', style:  TextStyle(
                                fontWeight:  FontWeight.bold,
                                fontFamily: 'MontSerrat'
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100.0),
                  Container(
                    child: Text('Empowering you to achieve more...', style: TextStyle(
                        fontWeight:  FontWeight.bold,
                        color: Colors.redAccent
                    ),),
                  )
                ],
              ),

            )
          ],
        )
    );
  }
}
