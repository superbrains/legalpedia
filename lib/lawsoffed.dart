import 'package:flutter/material.dart';
import 'package:legalpedia/classes/lawclass.dart';
import 'classes/lawserv.dart';
import  'package:legalpedia/lawoffedDetails.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';
import 'package:legalpedia/main.dart';

class LawsOfFederation extends StatefulWidget{
  @override
  _LawsOfFederation createState()=> _LawsOfFederation();

}

class _LawsOfFederation extends State<LawsOfFederation>{

  List<LawList> laws = List();
  List<LawList> filteredlaws = List();

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }

Future<String> checkconnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return 'Connected';
    } else {
       return 'Not Connected';
    }
  }

Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title:Text('Connection Error') ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(str, style: TextStyle(
          fontSize: 14,
          color: Colors.red

        ),),
        SizedBox(height: 10.0,),
        Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                              Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              'Back to home screen',
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
        ],) 
        
      ));
}

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () async{
      // var res = await checkconnectivity();
     // if (res=="Connected"){
       
      loader();
      Services.getLaws().then((lawsFromServer) {
        setState(() {
          laws = lawsFromServer;
          filteredlaws = laws;
           filteredlaws.sort((a, b) => a.title.compareTo(b.title));
          Navigator.pop(context);
        });
      });
     // }else{
     //   dialog('Please check your internet connectivity. Internet connection is required to access this content');
     // }
    });
  }

  String getDate(str){

    var parsedDate = DateTime.parse(str);

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),
        title: Text('Laws of the Federation', style: TextStyle(
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
                hintText: 'Search by Title or Year...'
            ),
            onChanged: (string){

              setState(() {
                filteredlaws = laws.where((u)=>
                (u.title.toLowerCase().contains(string.toLowerCase()) ||
                    u.lawDate.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  filteredlaws.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      setState(() {

                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LawofFederationDetail(filteredlaws[index].id);
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
                            Text(filteredlaws[index].title, style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Monseratti',


                            ),),
                          /*  SizedBox(height: 15.0),

                            Text(getDate(filteredlaws[index].lawDate)  , style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Monseratti',

                                color: Colors.grey


                            ),),*/

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


