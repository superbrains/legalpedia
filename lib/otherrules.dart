import 'package:flutter/material.dart';
import 'package:legalpedia/sections.dart';

class OtherRules extends StatefulWidget{
  @override
  _OtherRules createState()=> _OtherRules();

}

class _OtherRules extends State<OtherRules>{


  final List<String> states = ["ADMIRALTY JURISDICTION PROCEDURE RULES",
    "COURT OF APPEAL RULES",
    "FEDERAL HIGH COURT RULES",
    "FUNDAMENTAL RIGHTS ENFORCEMENT PROCEDURE RULES 2009",
    "NATIONAL INDUSTRIAL COURT RULES 2007",
    "SECURITIES AND EXCHANGE COMMISSION RULES",
    "SUPREME COURT RULES"];
  List<String> filteredstates = List();



  @override
  void initState() {
    super.initState();
    setState(() {

      filteredstates = states;
      print(filteredstates.length);
    });

  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),
        title: Text('List of States', style: TextStyle(
            fontWeight:  FontWeight.bold,
            fontSize: 16.0,
            fontFamily: 'Monseratti',
            color: Colors.white

        ),),
        actions: <Widget>[

          new IconButton(icon: new Icon(Icons.refresh),onPressed: null,),

        ],
        backgroundColor: Colors.red,

      ),
      body:
      Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Search States...'
            ),
            onChanged: (string){

              setState(() {
                filteredstates = states.where((u)=>
                (u.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  filteredstates.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  Sections('Others', filteredstates[index].toString());
                        }));

                      });
                    },

                    child:  Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredstates[index].toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ),),

                          ],
                        ),
                      ),
                    )
                    ,
                  );

                }),
          )
        ],
      ),
    );
  }


}


