import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Verification extends StatefulWidget{

  final phone;
  final mac;

  Verification(this.phone, this.mac);

  @override
  State<StatefulWidget> createState(){

   return _Verification(this.phone, this.mac);
  }

}


class _Verification extends State<Verification> {

  final phone;
  final mac;
  TextEditingController otpController =  TextEditingController();


  _Verification(this.phone, this.mac);


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

                          Text("Please enter the OTP sent to your registered phone and email. If you don's receive it in five(5) minutes, call our support line", textAlign: TextAlign.center, style: TextStyle(
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
                          onTap: (){},
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
