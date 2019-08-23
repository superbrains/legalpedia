import 'dart:ui' as prefix1;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalpedia/switchboard.dart';
import 'package:legalpedia/judgements.dart';
import 'package:legalpedia/subjectmatter.dart';
import 'package:legalpedia/latestjudgements.dart';
import 'package:legalpedia/lawsoffed.dart';
import 'package:legalpedia/formsandprec.dart';
import 'package:legalpedia/otherrules.dart';
import 'package:legalpedia/legalarticles.dart';
import 'package:legalpedia/dictionary.dart';
import 'package:legalpedia/maxims.dart';
import 'package:legalpedia/foreign.dart';
import 'package:legalpedia/states.dart';
import 'package:legalpedia/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  String getName(){

    return '';
  }
  String getPhone(){

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LEGALPEDIA',
      routes: <String, WidgetBuilder>{
        'Judgment': (BuildContext context) => new Judgment(),
        'SubjectMatter': (BuildContext context) => new  SubjectMatter(),
        'LatestJudgements': (BuildContext context) => new  LatestJudgements(),
        'LawsOfFederation': (BuildContext context) => new  LawsOfFederation(),
        'States': (BuildContext context) => new  States(),
        'Forms': (BuildContext context) => new  Forms(),
        'OtherRules': (BuildContext context) => new  OtherRules(),
        'Articles': (BuildContext context) => new  Articles(),
        'Dictionary': (BuildContext context) => new  Dictionary(),
        'Maxims': (BuildContext context) => new  Maxims(),
        'Foreign': (BuildContext context) => new  Foreign(),
      },
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: Activation(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final name;
  final phone;
  MyHomePage(this.name, this.phone);

  @override
  _MyHomePageState createState() => _MyHomePageState(this.name, this.phone);
}

class _MyHomePageState extends State<MyHomePage> {

  final name;
  final phone;
  _MyHomePageState(this.name, this.phone);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.red),
    elevation: 15.0,

  title:   Image.asset('assets/LGPLogo.png', width: 200.0, height: 50.0,),
      backgroundColor: Colors.white,

),
      drawer: new Drawer(
        elevation: 10.0,

        child: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                color: Colors.red.withOpacity(1),

              ),
              clipper: getClipper(),
            ),

            Positioned(

              width: 300.0,
              top: MediaQuery.of(context).size.height/6.7,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage('http://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                     boxShadow: [
                       BoxShadow(blurRadius: 20.0, color: Colors.black)
                     ]
                     // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                    ),

                  ),
                  SizedBox(height: 10),
                  Text(name,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Monseratti',
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5),
                  Text(phone,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Monseratti',
                        fontStyle: FontStyle.italic
                    ),)



                ],


              ),

            ),

            Positioned(
              top: MediaQuery.of(context).size.height/2.1,
              width: 300.0,

              child: new Column(
                children: <Widget>[
                  CustomListTile(Icons.help_outline, 'Ask a Legalpedia Lawyer', ()=>{}),
                  CustomListTile(Icons.account_box, 'About Legapedia', ()=>{}),
                  CustomListTile(Icons.feedback, 'Feedback', ()=>{}),
                  CustomListTile(Icons.face, 'Visit Our Facebook Page', ()=>{}),
                  CustomListTile(Icons.transfer_within_a_station, 'Visit Our Twitter Page', ()=>{}),
                  CustomListTile(Icons.lock, 'Logout', ()=>{}),
                ],
              ),
            )

          ],


        ),


      ),

    //  backgroundColor: Color.alphaBlend(Colors.redAccent,  Colors.redAccent),

      body: new  ListView(
      
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,

                  ),
                SizedBox(height:  25.0),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
          child: Text('Find authorities on any issue of law in the search box below', style: TextStyle(
            color: Colors.white,
            fontFamily: 'Monseratti',
            fontStyle: FontStyle.normal,


          ), textAlign: TextAlign.center
            ,),
        ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 80),
                  child: Material(
                    elevation: 7.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.red, size: 30.0,),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top:15.0),
                        hintText: 'Search'
                      ),
                    ),
                  ),

                )
                /*  Positioned(
                    bottom: 10,
                    right: 100,
                    child: Container(
                      height: 400,
                      width: 400,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(100.0),
                         color: Colors.red.shade400
                       ),
                    ),
                  )*/
                ],
              ),
              SizedBox(height: 40.0,),
              ListView(
                 shrinkWrap: true,
                children: <Widget>[
                      new MySwitchboard()
                ],
              ),


            ],
          )
        ],

      ),

    );

  }
}

class CustomListTile extends StatelessWidget{
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
return Padding(
  padding: EdgeInsets.all(6.0),
  child: Container(
    decoration: BoxDecoration(
      border: Border( bottom: BorderSide(color: Colors.grey.shade400)),

    ),
    child: InkWell(

      splashColor: Colors.redAccent,
      onTap: onTap,

      child: Container(
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: Colors.red),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child:   Text(text, style: TextStyle(
                      fontSize: 14.0,
                    fontFamily: 'Monseratti'
                  ),) ,
                )

              ],
            ),

            Icon(Icons.arrow_right)

          ],
        ),

      ),

    ) ,

  ),

);

  }
}

class getClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = new Path();

    path.lineTo(0.0, size.height/3);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<prefix1.Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
