import 'package:flutter/material.dart' ;
import 'package:livescore/UI/matchDetails.dart';


final titleText = TextStyle(fontSize: 35, fontWeight: FontWeight.bold , color: Colors.blueGrey[600] ) ;
final titleTextWhite = TextStyle(fontSize: 35, fontWeight: FontWeight.bold , color: Colors.white ) ;

final secText = TextStyle(fontSize: 18, fontWeight: FontWeight.w800 , color: Colors.white) ;
final secTextBlack = TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.blueGrey[600]) ;

final menuTextBlack = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w800 , color: Colors.black) ;
final menuTextGrey = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w800 , color: Colors.blueGrey[600]) ;

final smallTextBlack = TextStyle(fontSize: 14, fontWeight: FontWeight.w800 , color: Colors.black) ;
final smallTextGrey = TextStyle(fontSize: 14, fontWeight: FontWeight.w800 , color: Colors.blueGrey[900]) ;
final smallTextblueGrey = TextStyle(fontSize: 14, fontWeight: FontWeight.w800 , color: Colors.blueGrey[600]) ;

Color mainIconColor = Colors.grey[100] ;
Color onclickIconColor = Colors.blueGrey[600] ;

Color secIconColor = Colors.grey[100] ;
Color secOnclickIconColor = Colors.blueGrey[600] ;

listElem(context , game ) {

  return Padding(
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01 ,  horizontal: MediaQuery.of(context).size.width *0.015 ),
    child: GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetails(fixture: game,))),
      child: Container(
      height: MediaQuery.of(context).size.height * 0.077,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(3)),
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
            padding: EdgeInsets.only(left : MediaQuery.of(context).size.width * 0.01),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.network(
                    game.homeTeam.logo,
                    width: MediaQuery.of(context).size.height * 0.06,
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                 // Expanded(child: Text(game.homeTeam.name , style : smallTextGrey , overflow: TextOverflow.ellipsis, maxLines: 3,)),
                ],
              ),
            ),
          ),
         // home.logo ,
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                (game.score == 'null:null') ? Text('لم تبدأ بعد' , style: menuTextGrey,) : Text(game.score , style: secTextBlack, )
              ]
          ),
          Padding(
            padding: EdgeInsets.only(right : MediaQuery.of(context).size.width * 0.01),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                //  Expanded(child: Text(game.awayTeam.name , style : smallTextGrey , overflow: TextOverflow.ellipsis, maxLines: 3,)),
                  Image.network(
                    game.awayTeam.logo,
                    width: MediaQuery.of(context).size.height * 0.06,
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                ],
              ),
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
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015 , vertical:  MediaQuery.of(context).size.height * 0.015 ),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.077,
      decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.all(Radius.circular(3)),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[



            SizedBox(width: MediaQuery.of(context).size.width * 0.4,),


            Container(
                decoration: BoxDecoration(color: Colors.white70, shape : BoxShape.circle ,   ) ,child: Center(child: Text( event.time.toString() + '\'' , style: menuTextBlack, ))),



            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (event.type == 'Card') ? Icon(
                    Icons.style , color: Colors.yellow,) : (event.type == 'Goal') ? Icon(Icons.plus_one , color: Colors.green,) :
                  Icon(Icons.swap_vert , color: Colors.purpleAccent,),

                  (event.type == 'subst') ? Text(event.mainPlayer + '\n' + event.secPlayer , style:smallTextblueGrey,) :
                  Text(event.mainPlayer , style: smallTextblueGrey,),

                ],
              ),
            ),





          ],
      ) :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[


        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              (event.type == 'subst') ? Text(event.mainPlayer + '\n' + event.secPlayer , style: smallTextblueGrey,) :
                Text(event.mainPlayer , style: smallTextblueGrey,),

              (event.type == 'Card') ? Icon(
                Icons.style , color: Colors.yellow,) : (event.type == 'Goal') ? Icon(Icons.plus_one , color: Colors.green,) :
              Icon(Icons.swap_vert , color: Colors.purpleAccent,),

            ],
          ),
        ),



        Center( child : Text( event.time.toString() + '\'' , style: menuTextBlack, )),

        SizedBox(width: MediaQuery.of(context).size.width * 0.4,)




        ],
      ),
    ),
  );
}

statBar(context , stat) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01 ,  horizontal: MediaQuery.of(context).size.width *0.015),
    child: Column(
      children : <Widget> [
      Text(stat.name , style: smallTextblueGrey,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(stat.home , style: secTextBlack,),
            Text(stat.away , style: secTextBlack,),
          ],
        ),
      )
      ]
  ),
  );
}


singleListElem(context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01 ,  horizontal: MediaQuery.of(context).size.width *0.06 ),
      child: GestureDetector(
        //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetails(fixture: game,))),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.077,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(3)),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // home.logo ,
              Text('برشلونة'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //  Expanded(child: Text(game.awayTeam.name , style : smallTextGrey , overflow: TextOverflow.ellipsis, maxLines: 3,)),
                  Image.asset(
                    'assets/barca.png',
                    width: MediaQuery.of(context).size.height * 0.06,
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );


}

standingTable(context , standingElem) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.white70,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal : MediaQuery.of(context).size.width * 0.015 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(standingElem.team.name),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            Image.network(standingElem.team.logo ,
              width: MediaQuery.of(context).size.height * 0.05,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            Text(standingElem.rank.toString()),
          ],
        ),
      ),
    ),
  );
}

navbarElem(context , text , widget , index ){
  return GestureDetector(
    onTap: () {
      widget.setState(() {
        widget.setIndex(index)  ;
      });
    },
    child: Container(width: MediaQuery.of(context).size.width / 4 , height: MediaQuery.of(context).size.height * 0.058 , color : (widget.getIndex() == index) ? Colors.grey[200] : null ,
        child: Center(child: Text(text, style : smallTextblueGrey))),
  );
}


lineUpElem (context , lineUps ) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015 , vertical: MediaQuery.of(context).size.height * 0.015),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for(var line in lineUps)
    Column(
        children: <Widget>[
          Text('الاساسيون', style: secTextBlack,),
        SizedBox(height:  MediaQuery.of(context).size.height * 0.015 ,),
        for(var player in line)
               Padding(
                 padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
                 child: Container(
                 height:  MediaQuery.of(context).size.height * 0.05,
                    width:  MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(color: Colors.white70),
                   child: Center(
                     child: Row(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: <Widget>[
                            Text(player, style: smallTextblueGrey,)
                          ],
                        ),
                   ),
                 ),
               ),
             ],
           )
    ]
    ),
  );

}


CircleImage_(context) {
  return CircleAvatar(
    backgroundColor: Colors.white70,
    radius: MediaQuery.of(context).size.height * 0.045,
    child: Image.asset('assets/barca.png'),
  );
}