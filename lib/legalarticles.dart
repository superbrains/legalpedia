import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:connectivity/connectivity.dart';
import 'package:legalpedia/classes/legalarticleclass.dart';

import 'classes/legalarticleserv.dart';


import 'package:legalpedia/globals.dart' as globals;
import 'package:legalpedia/legalarticlescontent.dart';

class Articles extends StatefulWidget{
  @override
  _Articles createState()=> _Articles();

}

class _Articles extends State<Articles>{
   List<LegalArticlesClass> articleslist = List();
  List<LegalArticlesClass> filteredarticleslist = List();



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
        Services.getArticles().then((formsFromServer) {
        setState(() {
          articleslist = formsFromServer;
          filteredarticleslist = articleslist;
            filteredarticleslist.removeWhere((item) => item.title == null);
                                filteredarticleslist.removeWhere((item) => item.content == null);
                                filteredarticleslist.removeWhere((item) => item.title == null);

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
        title: Text('Legal Articles', style: TextStyle(
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
                hintText: 'Search Legal Articles'),
            onChanged: (string) {
              setState(() {
                filteredarticleslist = articleslist
                    .where((u) => (u.title
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
                        u.content.toLowerCase().contains(string.toLowerCase())||
                        u.title.toLowerCase().contains(string.toLowerCase())))
                    .toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredarticleslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      setState(() {
                        globals.selectedarticlesContent = filteredarticleslist[index].content;
                         globals.selectedarticlesTitle = filteredarticleslist[index].title;

                          
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LegalArticlesContent();
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
                              filteredarticleslist[index].title,
                              style: TextStyle(
                                  fontSize: 16.0,
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


