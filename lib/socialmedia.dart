
import 'package:flutter/material.dart';

import 'package:legalpedia/verification.dart';
import 'package:legalpedia/classes/activationserv.dart';

import 'package:progress_indicators/progress_indicators.dart';

import 'package:url_launcher/url_launcher.dart';


class SocialMedia extends StatefulWidget{
  @override
  _SocialMedia createState()=> _SocialMedia();

}


class _SocialMedia extends State<SocialMedia> {
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


Future<bool> dialog(){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: Text("Oops!! Could not launch the forum at the moment", style: TextStyle(
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
              return Verification(phone, mac, name);
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

_launchURL(String url) async {
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
   dialog();
  }
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.red),
    elevation: 15.0,

  title:   Image.asset('assets/LGPLogo.png', width: 200.0, height: 50.0,),
      backgroundColor: Colors.white,

),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text('Our Social Media Forums', style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserrati',
              color: Colors.black
            ),),
            Text('Click the desired icon to visit our forums', style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              fontFamily: 'Monserrati',
              color: Colors.red
            ),),
            SizedBox(height: 50.0,),
            Center(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                     InkWell(
                      
                       splashColor: Colors.red,
                      onTap: (){
                        _launchURL('https://www.facebook.com/Legalpedia');
                      },
                      borderRadius: BorderRadius.circular(60.0),
                      
                      child:     Container(
                     
                    width: 100.0,
                    height: 100.0,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                    
                      color: Colors.white,
                      
                      image: DecorationImage(
                        image: AssetImage('assets/facebook.png'),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      
                     boxShadow: [
                       BoxShadow(blurRadius: 10.0, color: Colors.black)
                     ]
                     
                     // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                    ),

                  ) ,
                    ),

                  SizedBox(height: 50,),
                      InkWell(
                      
                       splashColor: Colors.red,
                      onTap: (){
                         _launchURL('https://twitter.com/legalpedia');
                      },
                      borderRadius: BorderRadius.circular(60.0),
                      
                      child:     Container(
                     
                    width: 100.0,
                    height: 100.0,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                    
                      color: Colors.white,
                      
                      image: DecorationImage(
                        image: AssetImage('assets/twitter.png'),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      
                     boxShadow: [
                       BoxShadow(blurRadius: 10.0, color: Colors.black)
                     ]
                     
                     // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                    ),

                  ) ,
                    ),

                    SizedBox(height: 50,),

                    InkWell(
                      
                       splashColor: Colors.red,
                      onTap: (){
                          _launchURL('https://www.instagram.com/legalpedianigeria/');
                      },
                      borderRadius: BorderRadius.circular(60.0),
                      
                      child:     Container(
                     
                    width: 100.0,
                    height: 100.0,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                    
                      color: Colors.white,
                      
                      image: DecorationImage(
                        image: AssetImage('assets/instagram.png'),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      
                     boxShadow: [
                       BoxShadow(blurRadius: 10.0, color: Colors.black)
                     ]
                     
                     // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                    ),

                  ) ,
                    ),

              
              ],
            )
            ),

            ],
          ),
      
        ),
        
        backgroundColor: Colors.white,
        
    );
  }
}
