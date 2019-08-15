import 'package:flutter/material.dart';
import 'package:legalpedia/classes/rules.dart';
import 'classes/rulesserv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class StateRules extends StatefulWidget{
  @override
  _StateRules createState()=> _StateRules();

}

class _StateRules extends State<StateRules>{


  List<Rules> rules = List();
  List<Rules> filteredrules = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Services.getRules().then((rulesFromServer) {
      setState(() {
        rules = rulesFromServer;
        filteredrules = rules;
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
        title: Text('State Rules of Court', style: TextStyle(
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
                  hintText: 'Search State rules...'
              ),
              onChanged: (string){

                  setState(() {
                    filteredrules = rules.where((u)=>
                    (u.title.toLowerCase().contains(string.toLowerCase()) ||
                        u.content.toLowerCase().contains(string.toLowerCase()))).toList();
                  });


              },
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount:  filteredrules.length,
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
                              Text(filteredrules[index].title, style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Monseratti'

                              ),),
                              SizedBox(height: 10.0),

                              Html(
                                data: filteredrules[index].content,
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
                                        return baseStyle.merge(TextStyle(height: 2, fontSize: 12, fontFamily: 'Monseratti'));
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


