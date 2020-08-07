import 'package:flutter/material.dart';
import 'constants.dart';


futureBuilderFunc (widget , future , list) {
  return FutureBuilder(
    future: future ,
    builder: (BuildContext context , AsyncSnapshot snap) {
      if(snap.hasData)
      return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true ,
          scrollDirection: Axis.vertical,
          padding : EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.042),
          itemCount: (list is List<List<String>>) ? 1 : list.length ,
          itemBuilder: (BuildContext context , int index) {
            return (list is List<List<String>>) ? widget(context , list) :  widget(context , list[index])   ;
          }

      );
      else return catchSnap(context, snap) ;
    },
  );
}


catchSnap(context , snap) {
  if (snap.hasError) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: MediaQuery.of(context).size.height * 0.1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03 , horizontal:  MediaQuery.of(context).size.width * 0.05 ),
          child: Text('هناك خلل ما ${snap.error}'  , style: titleText),
        )
      ],
    );
  }
  else {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(' .. جاري التحميل '),
          )
        ],
      ),
    );
  }
}