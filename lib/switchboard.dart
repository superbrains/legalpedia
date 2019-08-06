import 'package:flutter/material.dart';

class MySwitchboard extends StatefulWidget{
  @override
  _MySwitchboardState createState()=> _MySwitchboardState();

}

class _MySwitchboardState extends State<MySwitchboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
        crossAxisCount: 3,
        primary: false,
        padding: EdgeInsets.all(10.0),
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        shrinkWrap: true,
        children: <Widget>[
          _buildCard('Judgements', 'assets/latest-judgments.png', (){}),
          _buildCard('Subject Matters', 'assets/laws.png',(){}),
          _buildCard('Forms', 'assets/forms.png', (){}),
          _buildCard('Dictionary', 'assets/dictionay.png', (){}),
          _buildCard('Judgements', 'assets/judgements.png', (){}),
          _buildCard('Subject Matters', 'assets/judgements.png',(){}),
          _buildCard('Judgements', 'assets/latest-judgments.png', (){}),
        _buildCard('Subject Matters', 'assets/laws.png',(){}),
        _buildCard('Forms', 'assets/forms.png', (){}),
          _buildCard('Judgements', 'assets/latest-judgments.png', (){}),
          _buildCard('Subject Matters', 'assets/laws.png',(){}),
          _buildCard('Forms', 'assets/forms.png', (){}),

      ],
    );
  }

  _buildCard(String title, String imgPath, Function onTap){
    return Container(
      padding: EdgeInsets.all(7.0),
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow:[
            BoxShadow(

                blurRadius: 3.0,
                spreadRadius: 2.0,

                color: Colors.red.withOpacity(0.3)
            )
          ]
      ),


      child:InkWell (

        splashColor: Colors.redAccent,
          onTap: onTap,
          child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[


              Container(
                height: 30.0,
                width: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(

                    image: AssetImage(imgPath),
                    fit: BoxFit.scaleDown,

                  )
                ),

              ),


            ],
          ),
          SizedBox(height: 20.0,),
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0
          ),)
        ],
      ),
      ),
    );

  }
}


