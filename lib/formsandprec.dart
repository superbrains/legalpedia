import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:connectivity/connectivity.dart';
import 'package:legalpedia/classes/formsprecedenceclass.dart';

import 'classes/formsprecedenceserv.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:legalpedia/globals.dart' as globals;
import 'package:legalpedia/formsprecedencecontent.dart';

class Forms extends StatefulWidget{
  @override
  _Forms createState()=> _Forms();

}

class _Forms extends State<Forms>{
   List<FormsPrecedenceClass> formslist = List();
  List<FormsPrecedenceClass> filteredformslist = List();

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
        Services.getForeign().then((formsFromServer) {
        setState(() {
          formslist = formsFromServer;
          filteredformslist = formslist;
            filteredformslist.removeWhere((item) => item.title == null);
                                filteredformslist.removeWhere((item) => item.content == null);
                                filteredformslist.removeWhere((item) => item.category == null);

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
        title: Text('Forms and Precedents', style: TextStyle(
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
                hintText: 'Search Forms and Precedents...'),
            onChanged: (string) {
              setState(() {
                filteredformslist = formslist
                    .where((u) => (u.title
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
                        u.content.toLowerCase().contains(string.toLowerCase())||
                        u.category.toLowerCase().contains(string.toLowerCase())))
                    .toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredformslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      setState(() {
                        globals.selectedFormContent = filteredformslist[index].content;
                         globals.selectedFormTitle = filteredformslist[index].title;

                          
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return FormsContent();
        }));

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
                              filteredformslist[index].title,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20.0),
                            Row(children: <Widget>[
                               Text(
                              'CATEGORY:',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  ),
                            ),
                            SizedBox(width: 10,),
                                 Text(
                              filteredformslist[index].category,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',
                                  ),
                            ),
                            ],),
                           
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


