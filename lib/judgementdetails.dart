import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:legalpedia/classes/summaryclass.dart';
import 'package:intl/intl.dart';
import 'package:legalpedia/judgementbody.dart';

class JudgementDetail extends StatefulWidget{

  final List<SummaryList> summary;
  final String  suitNo;
  List<SummaryList> filteredsummary = List();

  JudgementDetail(this.summary, this.suitNo);
//

  @override
  _JudgementDetail createState()=> _JudgementDetail(this.summary, this.suitNo);

}

class _JudgementDetail extends State<JudgementDetail>{

  final List<SummaryList> summary;
  final String  suitNo;
  List<SummaryList> filteredsummary = List();

  _JudgementDetail(this.summary, this.suitNo);


  @override
  void initState() {
    super.initState();

    setState(() {

      filteredsummary = summary.where((u)=>
      (u.suitNo.toLowerCase().contains(suitNo.toLowerCase()))).toList();

     /* var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(now);*/

    });


  }

  String getDate(str){

    var parsedDate = DateTime.parse(str);

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }

  double getHeight(height){

    String ht = height.toString();
    double ht2 = double.parse(ht);
    return ht2 * 25.0;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Judgements Details', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),

          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.share),onPressed: null,),
            new IconButton(icon: new Icon(Icons.email),onPressed: null,),
          ],
          backgroundColor: Colors.red,

        ),
        body:
        Column(
          children: <Widget>[

            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(5.0),
                  itemCount:1,
                  itemBuilder: (BuildContext context, int index){
                    return  Card(
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(filteredsummary[index].title==null?'Not Available': filteredsummary[index].title, textAlign: TextAlign.center, style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    fontFamily: 'Monseratti'

                                ),),
                                SizedBox(height: 20.0),
                                Text(filteredsummary[index].legalpediaCitation==null?'None':filteredsummary[index].legalpediaCitation, textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green
                                ),),

                                SizedBox(height: 20.0),
                                Text(filteredsummary[index].court==null?'Not Available': filteredsummary[index].court, textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,

                                ),),

                                Text( filteredsummary[index].judgementDate==null?'Not Available': getDate(filteredsummary[index].judgementDate) , textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',


                                ),),
                                SizedBox(height: 40.0),
                                Text('SUIT NUMBER', textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent

                                ),),
                                Text(filteredsummary[index].suitNo==null?'Not Available:':filteredsummary[index].suitNo, textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold

                                ),),
                                SizedBox(height: 30.0),
                                Text('CORAMS', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),

                              Container(
                               
                                alignment: Alignment.center,
                                child:  ListView.builder(
                                   
                                    shrinkWrap: true,
                                     physics: ClampingScrollPhysics(),
                                    itemCount: filteredsummary[index].corams.length,
                                    itemBuilder: (BuildContext context, int count){
                                      return  Text(filteredsummary[index].corams[count].toString()==null?'Not Available':filteredsummary[index].corams[count].toString(), textAlign: TextAlign.center, style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Monseratti',

                                      ),);

                                    }

                                ),

                              ),
                                SizedBox(height: 20.0,),

                                Text('PARTY TYPE A', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                Text(filteredsummary[index].partyAType==null?'Not Available':filteredsummary[index].partyAType, textAlign: TextAlign.center, style : TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Monseratti',

                                ),),
                                SizedBox(height: 20.0),

                                Text('PARTY NAME', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green

                                ),),
                                Text(filteredsummary[index].partiesA==null?'Not Available':filteredsummary[index].partiesA, textAlign: TextAlign.center, style : TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',

                                ),),

                                SizedBox(height: 20.0,),

                                Text('PARTY TYPE B', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                Text(filteredsummary[index].partyBType==null?'Not Available':filteredsummary[index].partyBType, textAlign: TextAlign.center, style : TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',

                                ),),
                                SizedBox(height: 20.0),

                                Text('PARTY NAME', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green

                                ),),
                                Text(filteredsummary[index].partiesB==null?'Not Availble':filteredsummary[index].partiesB, textAlign: TextAlign.center, style : TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Monseratti',

                                ),),

                                SizedBox(height: 30.0),

                                Text('SUMMARY OF FACTS', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10,),
                                Text(filteredsummary[index].summaryOfFacts==null?'Not Available':filteredsummary[index].summaryOfFacts, textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',
                                 

                                ),),
                                SizedBox(height: 30.0,),

                                Text('HELD', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10,),
                                Text(filteredsummary[index].held==null?'Not Available':filteredsummary[index].held , textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',


                                ),),
                                SizedBox(height: 30.0,),

                                Text('ISSUE', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10,),
                                Text(filteredsummary[index].issues==null?'Not Available':filteredsummary[index].issues, textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',


                                ),),
                                SizedBox(height: 30.0,),

                                Text('RATIO', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10.0,),
                              Column(
                                children: <Widget>[
                                  Container(
                                   
                                    child:  ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: filteredsummary[index].ratios.length,
                                        itemBuilder: (BuildContext context, int count){
                                          return Column(
                                            children: <Widget>[
                                              Text(filteredsummary[index].ratios[count].heading==null?'Not Available':filteredsummary[index].ratios[count].heading, style: TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'Monseratti',
                                                fontWeight: FontWeight.bold

                                              ),
                                              ),
                                              SizedBox(height: 5.0,),
                                              Text(filteredsummary[index].ratios[count].body==null?'Not Available':filteredsummary[index].ratios[count].body, style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Monseratti',

                                              ),

                                              ),
                                              SizedBox(height: 10.0,),
                                            ],
                                          )  ;

                                        }

                                    ),

                                  ),
                                ],
                              ),

                                SizedBox(height: 30.0,),
                                Text('CASES SITED', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10,),
                                Text(filteredsummary[index].casesCited==null?'Not Available': filteredsummary[index].casesCited , textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',


                                ),),
                                SizedBox(height: 30.0,),
                                Text('STATUS SITED', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10,),
                                Text(filteredsummary[index].statusCited==null?'Not Available': filteredsummary[index].statusCited , textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Monseratti',


                                ),),
                                SizedBox(height: 50,),
                                Container(
                                  height: 40.0,
                                  child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: Colors.redAccent,
                                      color: Colors.red,
                                      elevation: 7.0,
                                      child: GestureDetector(
                                        onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return JudegementBody(filteredsummary[index].suitNo);
                                            }));
                                        },
                                        child: Center(
                                          child: Text(
                                            'READ FULL JUDGEMENT',
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
                                SizedBox(height: 50,)
                              ],
                            ),
                          ),
                        );
                  }),
            )
          ],
        )
    );
  }


}