import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:connectivity/connectivity.dart';
import 'package:legalpedia/classes/foreignlegalclass.dart';

import 'classes/foreignlegalserv.dart';

import 'package:url_launcher/url_launcher.dart';


class Foreign extends StatefulWidget{
  @override
  _Foreign createState()=> _Foreign();

}

class _Foreign extends State<Foreign>{
   List<ForeignLegal> foreignlist = List();
  List<ForeignLegal> filteredforeignlist = List();

_launchURL(String url) async {
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
  // dialog();
  }
}

  Future<bool> loader() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
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
  void initState()  {
    super.initState();
    new Future.delayed(Duration.zero, () async{
     
      var res = await checkconnectivity();
      if (res=="Connected"){
         loader();
        Services.getForeign().then((foreignFromServer) {
        setState(() {
          foreignlist = foreignFromServer;
          filteredforeignlist = foreignlist;
            filteredforeignlist.removeWhere((item) => item.title == null);
                                filteredforeignlist.removeWhere((item) => item.description == null);
                                filteredforeignlist.removeWhere((item) => item.url == null);

          Navigator.pop(context);
        });
      });
      }else{
        dialog('Please check your internet connectivity. Internet connection is required to access this content');
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),
        title: Text('Foreign Legal Resources', style: TextStyle(
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
      body:  Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Search Foreign Resources...'),
            onChanged: (string) {
              setState(() {
                filteredforeignlist = foreignlist
                    .where((u) => (u.title
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
                        u.description.toLowerCase().contains(string.toLowerCase())))
                    .toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredforeignlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      setState(() {
                        _launchURL( filteredforeignlist[index].url);
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              filteredforeignlist[index].title,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              filteredforeignlist[index].description,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }


}


