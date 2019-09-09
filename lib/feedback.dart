
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_mailer/flutter_mailer.dart';


class FeedBack extends StatefulWidget{
  @override
  _FeedBack createState()=> _FeedBack();

}


class _FeedBack extends State<FeedBack> {
String phone;
String mac;
String phoneAct;
String name;
String filesel;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      
    });
  }
  
TextEditingController emailController =  TextEditingController();
TextEditingController nameController =  TextEditingController();
TextEditingController descrController =  TextEditingController();

 List<String> _topics = ['Feature Suggestions', 'Bugs', 'Technical', 'Missing Content', 'Others']; // Option 2
  String _selectedtopic; // Option 2

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


 


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     filesel=''; 
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.red),
        elevation: 15.0,

        title:Image.asset('assets/LGPLogo.png', width: 200.0, height: 50.0,),
        backgroundColor: Colors.white,

),
        body: 
        ListView(
          children: <Widget>[
                  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            Container(
              padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[

                  Text('Feedback Form', style: TextStyle(
                    fontFamily: 'Monserrati',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    
                  ),),
                  SizedBox(height: 40,),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:  TextStyle(
                            fontFamily: 'MontSerrat',
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:  TextStyle(
                            fontFamily: 'MontSerrat',
                            fontWeight: FontWeight.bold
                        )
                    ),

                  ),
                    SizedBox(height: 20.0),
                    DropdownButton(
                      
                    hint: Text('Please Choose A Topic'), // Not necessary for Option 1
                    value: _selectedtopic,
                  
                    onChanged: (newValue) {
                    setState(() {
                    _selectedtopic = newValue;
                    });
                    },
                  items: _topics.map((location) {
                    return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                   );
                   }).toList(),
                    isExpanded: true,
                    style: TextStyle(
                      fontFamily: 'Monserrati',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54
                    ),
                    ),
                  SizedBox(height: 20.0),
                  TextField(
                      controller: descrController,
                     keyboardType: TextInputType.multiline,
                     maxLines: 4,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle:  TextStyle(
                            fontFamily: 'MontSerrat',
                            fontWeight: FontWeight.bold
                        )
                    ),

                  ),

                  SizedBox(height: 30.0),
                  
                  
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async{
                           //send mail
                            final MailOptions mailOptions = MailOptions(
                            body: 'Dear Sir/Ma,<br/><br/> Below is the feedback from '+ nameController.text +'<br/><br/>' + descrController.text,
                            subject: _selectedtopic,
                            recipients: ['support@legalpediaonline.com'],
                            isHTML: true,
                            
                           // attachments: [ 'path/to/image.png', ],
                            );

                            await FlutterMailer.send(mailOptions);
                            print('sent email');
                          },
                          child: Center(
                            child: Text(
                              'SEND FEEDBACK',
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
          ],
        )
  
    );
  }
}
