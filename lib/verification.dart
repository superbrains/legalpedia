import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalpedia/classes/activationserv.dart';
import 'package:legalpedia/main.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Verification extends StatefulWidget{

  final phone;
  final mac;
  final name;

  Verification(this.phone, this.mac, this.name);

  @override
  State<StatefulWidget> createState(){

   return _Verification(this.phone, this.mac, this.name);
  }

}


class _Verification extends State<Verification> {

  final phone;
  final mac;
  final name;
  String otp;
  String res;
  TextEditingController otpController =  TextEditingController();


  _Verification(this.phone, this.mac, this.name);

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Activating Device. Please wait...", style: TextStyle(
              fontSize: 14
          ),),
        ));
  }


  Future<bool> dialog(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: Text("This Device Could not be activated at the moment", style: TextStyle(
              fontSize: 14,
              color: Colors.red

          ),),
        ));
  }

  void activatephone(){
    new Future.delayed(Duration.zero, () {
      loader();
      Services.activatePhone(otp, mac).then((responseFromServer) {
        setState(() {
          res = responseFromServer;
          try{
            if(res=='Error'){
              Navigator.pop(context);
              dialog();
              //Show a Dialog Box and ask them to create an account
            }else{

              SharedPreferences.getInstance().then((ss){
                ss.setString('Name', name);
                ss.setString("Phone", phone);


                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return MyHomePage(name, phone);
                }));

              });


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


                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 190.0, 0.0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text("Please enter the OTP sent to your registered phone and email. If you don's receive it in fifteen(15) minutes, call our support line", textAlign: TextAlign.center, style: TextStyle(
                            fontFamily: 'Monserrati',
                            fontSize: 15,

                          ),)
                        ],
                      ),
                    )
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: otpController,
                    decoration: InputDecoration(
                        labelText: 'ENTER VERIFICATION CODE',
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
                            otp= otpController.text;
                            activatephone();
                          },
                          child: Center(
                            child: Text(
                              'ACTIVATE',
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


                ],
              ),

            )
          ],
        )
    );
  }
}
