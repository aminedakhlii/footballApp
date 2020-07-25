import 'package:flutter/material.dart' ;
import 'matchDetails.dart';


final titleText = TextStyle(fontSize: 35, fontWeight: FontWeight.bold ) ;
final titleTextWhite = TextStyle(fontSize: 35, fontWeight: FontWeight.bold , color: Colors.white ) ;

final secText = TextStyle(fontSize: 18, fontWeight: FontWeight.w800 , color: Colors.white) ;
final secTextBlack = TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.black54) ;

final menuTextBlack = TextStyle(fontSize: 20, fontWeight: FontWeight.w800 , color: Colors.black) ;
final menuTextGrey = TextStyle(fontSize: 15, fontWeight: FontWeight.w800 , color: Colors.grey) ;


listElem(context , game ) {

  return Padding(
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.023),
    child: GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetails(fixture: game,))),
      child: Container(
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3)
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left : MediaQuery.of(context).size.height * 0.02),
            child: Image.network(
              game.homeTeam.logo,
              width: MediaQuery.of(context).size.height * 0.08,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ),
         // home.logo ,
          Column(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top : MediaQuery.of(context).size.height * 0.0000),
                  child: Text('النتيجة' , style: secTextBlack, ),
                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.000),
                  child: (game.score == 'null:null') ? Text('لم تبدأ بعد' , style: menuTextGrey,) : Text(game.score , style: secTextBlack, ) ,
                )
              ]
          ),
          Padding(
            padding: EdgeInsets.only(right : MediaQuery.of(context).size.height * 0.02),
            child: Image.network(
              game.awayTeam.logo,
              width: MediaQuery.of(context).size.height * 0.08,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ),

        ],
      ),
),
    ),
  );

}

DetailElem(context , event ) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.005 , vertical:  MediaQuery.of(context).size.height * 0.022 ),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3)
            )
          ]
      ),
      child: (!event.home) ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[


            Expanded(
                flex: 4,
                child : (event.type == 'Card') ? Icon(
                  Icons.style , color: Colors.yellow,) : (event.type == 'Goal') ? Icon(Icons.plus_one , color: Colors.green,) :
                Icon(Icons.swap_vert , color: Colors.purpleAccent,)
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top : MediaQuery.of(context).size.height * 0.005),
                child: Text( event.time.toString() + '\'' , style: menuTextBlack, ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal :  MediaQuery.of(context).size.width * 0.035),
                child: (event.type == 'subst') ? Text(event.mainPlayer + '\n' + event.secPlayer , style: menuTextGrey,) :
                Text(event.mainPlayer , style: menuTextGrey,) ,
              ),
            ),


          ],
      ) :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[


          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal :  MediaQuery.of(context).size.width * 0.035),
              child: (event.type == 'subst') ? Text(event.mainPlayer + '\n' + event.secPlayer , style: menuTextGrey,) :
              Text(event.mainPlayer , style: menuTextGrey,) ,
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top : MediaQuery.of(context).size.height * 0.005),
              child: Text( event.time.toString() + '\'' , style: menuTextBlack, ),
            ),
          ),


          Expanded(
              flex: 4,
              child : (event.type == 'Card') ? Icon(
                Icons.style , color: Colors.yellow,) : (event.type == 'Goal') ? Icon(Icons.plus_one , color: Colors.green,) :
              Icon(Icons.swap_vert , color: Colors.purpleAccent,)
          ),


        ],
      ),
    ),
  );
}