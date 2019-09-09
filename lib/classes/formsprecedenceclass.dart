class FormsPrecedenceClass{
  String category;
  String title;
  String content;
  
  int id;

//

  FormsPrecedenceClass({this.category, this.title, this.content,  this.id});

  factory FormsPrecedenceClass.fromJson(Map<String, dynamic> json){

    return FormsPrecedenceClass(
      category: json["category"] as String,
      title: json["title"] as String,
      content: json["content"] as String,
      
     
      id: json["id"] as int,



    );
  }


}