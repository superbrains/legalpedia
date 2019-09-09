import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class About extends StatefulWidget{


 

  @override
  _About createState()=> _About();

}

class _About extends State<About>{


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
 
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('About Legalpedia', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),

          actions: <Widget>[


            new IconButton(icon: new Icon(Icons.email),onPressed: null,),
          ],
          backgroundColor: Colors.red,

        ),
        body:    Center(
          child: Column(
          
            children: <Widget>[
               Container(
                      padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                      child:  Image.asset('assets/LGPLogo.png', height: 30.0)
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                      child:    Text('Legalpedia is set up to provide relevant and cutting-edge technology to the Nigerian Legal Profession by reducing, to the barest minimum, the use of manual methods within the courtroom, the judges’ chambers, court registries, and in Law Firms. The overall purpose of this company is to make legal practice much more productive and profitable for the Legal profession.', style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Monseratti'
                    ),)
                    ),
                  
          ],)
        )
    );
  }


}