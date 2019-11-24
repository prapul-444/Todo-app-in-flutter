class Note{


int _id;
String _title;
String _description;
String _date;
int _priority;

Note(this._title,this._date,this._priority,[this._description]);
Note.withId(this._id,this._title,this._date,this._priority,[this._description]);

int get id=>_id;
String get title=>_title;
String get description=>_description;
String get date=>_date;
int get priority=>_priority;




set title(String nt){
  this._title=nt;
}
set date(String nd){
  this._date=nd;
}
set description(String ndp){
  this._description=ndp;
}
set priority(int np){
  if(np>=1 && np<=2){
    this._priority=np;
  }
}

Map<String,dynamic> tomap(){
  var map= Map<String,dynamic>();
  if(id!=null){
    map['id']=_id;
   }
   map['description']=_description;
   map['date']=_date;
   map['title']=_title;
   map['priority']=_priority;
   return map;



}
Note.fromMapObject(Map<String,dynamic> map){
  this._id=map['id'];
  this._date=map['date'];
  this._priority=map['priority'];
  this._title=map['title'];
  this._description=map['description'];


}
}