import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalpedia/classes/activationclass.dart';
import 'package:legalpedia/verification.dart';
import 'package:legalpedia/classes/activationserv.dart';

import 'package:progress_indicators/progress_indicators.dart';



class Activation extends StatefulWidget{
  @override
  _Activation createState()=> _Activation();

}


class _Activation extends State<Activation> {
String phone;
String mac;
String phoneAct;

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


Future<bool> dialog(){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: Text("Could Not Get OTP. Phonenumber not Registered. Call Our Support Line or Click Create Account to Subscribe", style: TextStyle(
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
          if(phoneAct=='Error'){
              Navigator.pop(context);
              dialog();
            //Show a Dialog Box and ask them to create an account
          }else{

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return Verification(phone, mac);
            }));

          }
          }
          catch(e){
            Navigator.pop(context);
            dialog();
          }
        });
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
                          onTap: (){
                            phone= phoneController.text;
                            mac= phoneController.text;
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
