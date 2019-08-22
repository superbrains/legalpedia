import 'package:flutter/material.dart';
import 'package:legalpedia/rules.dart';

class Sections extends StatefulWidget{
  final String statetype;
  final String selectedstate;

  Sections(this.statetype, this.selectedstate);
  @override
  _Sections createState()=> _Sections(this.statetype, this.selectedstate);

}

class _Sections extends State<Sections>{
final String statetype;
final String selectedstate;

_Sections(this.statetype, this.selectedstate);

  final List<String> sections = ["Orders", "Parts", "Schedules", "Forms", "Portrate Forms", "Civil Forms", "Appendix"];
  List<String> filteredsections = List();



  @override
  void initState() {
    super.initState();
    setState(() {

      filteredsections = sections;

    });

  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),
        title: Text('$selectedstate : Select Section', style: TextStyle(
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
                hintText: 'Search Section...'
            ),
            onChanged: (string){

              setState(() {
                filteredsections = sections.where((u)=>
                (u.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  filteredsections.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  Rules(statetype, selectedstate, filteredsections[index].toString());
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
                            Text(filteredsections[index].toString(), style: TextStyle(
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


