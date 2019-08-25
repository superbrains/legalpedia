
import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';




class FeedBack extends StatefulWidget{
  @override
  _FeedBack createState()=> _FeedBack();

}


class _FeedBack extends State<FeedBack> {
String phone;
String mac;
String phoneAct;
String name;

TextEditingController phoneController =  TextEditingController();
TextEditingController nameController =  TextEditingController();

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
                    controller: phoneController,
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

                  SizedBox(height: 40.0),
                   Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.white,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                            phone= phoneController.text;
                            mac= phoneController.text;
                            name = nameController.text;
                          

                          },
                          child: Center(
                            child: Text(
                              'Click to Attach a File(Optional)',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                            
                          ),
                          
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
                            name = nameController.text;
                          

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
