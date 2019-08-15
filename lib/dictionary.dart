import 'package:flutter/material.dart';
import 'package:legalpedia/classes/maximclass.dart';
import 'classes/maximserv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:progress_indicators/progress_indicators.dart';

class Dictionary extends StatefulWidget{
  @override
  _Dictionary createState()=> _Dictionary();

}

class _Dictionary extends State<Dictionary>{

  List<MaximList> maxim = List();
  List<MaximList> filteredmaxims = List();

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      loader();
      Services.getMaxims().then((maximsFromServer) {
        setState(() {
          maxim = maximsFromServer;
          filteredmaxims = maxim;
          Navigator.pop(context);
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),
        title: Text('Law Dictionary', style: TextStyle(
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
                hintText: 'Search Dictionary...'
            ),
            onChanged: (string){

              setState(() {
                filteredmaxims = maxim.where((u)=>
                (u.title.toLowerCase().contains(string.toLowerCase()) ||
                    u.content.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  filteredmaxims.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      setState(() {

                      });
                    },

                    child:  Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredmaxims[index].title, style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Monseratti',
                                fontWeight: FontWeight.bold

                            ),),
                            SizedBox(height: 10.0),

                            Html(
                              data: filteredmaxims[index].content,
                              customTextAlign: (dom.Node node) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "p":
                                      return TextAlign.left;
                                  }
                                }
                                return null;
                              },
                              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "p":
                                      return baseStyle.merge(TextStyle(height: 2, fontSize: 14, fontFamily: 'Monseratti'));
                                  }
                                }
                                return baseStyle;
                              },

                              /*customRender: (node, children) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case "custom_tag":
                                        return Column(children: children);
                                    }
                                  }
                                  return null;
                                },*/
                            ),

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


