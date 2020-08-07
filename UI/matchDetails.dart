import 'package:flutter/material.dart';
import 'dart:ui';
import 'constants.dart';
import 'package:livescore/classes.dart';
import 'package:livescore/api.dart';
import 'futureBuilderFunc.dart';

class MatchDetails extends StatefulWidget {

  MatchDetails({this.fixture}) ;

  final Match fixture ;

  @override
  MatchDetailsState createState() => MatchDetailsState() ;

}


class MatchDetailsState extends State<MatchDetails> {

  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              actions: <Widget>[

              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: true,
                title : Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image : DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/darkwallpaper.jpg')
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.withOpacity(0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top : MediaQuery.of(context).size.height * 0.10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.network(
                                  widget.fixture.homeTeam.logo,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: MediaQuery.of(context).size.height * 0.09,
                                ),

                                (widget.fixture.score == 'null:null') ? Text('لم تبدأ' , style: secText,) : Text(widget.fixture.score , style: titleTextWhite, ),


                                Image.network(
                                  widget.fixture.awayTeam.logo,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: MediaQuery.of(context).size.height * 0.09,
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ),

            ),

            SliverList(
              delegate: SliverChildListDelegate( [
                 // listTop(context , 'جارية حاليا' , Icons.cached , false),
                  Container(
                    height : MediaQuery.of(context).size.height * 0.06,
                    color : Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          navbarElem(context, 'التشكيل', this , 5 ),
                          navbarElem(context, 'مساحة الزوار', this , 4 ),
                          navbarElem(context, 'الهدافون', this , 3 ),
                          navbarElem(context, 'الترتيب', this , 2 ),
                          navbarElem(context, 'الاحصائيات', this , 1 ),
                          navbarElem(context, 'احداث المباراة', this , 0 ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                  buildMain(),

              ]),
            )
            
            
          ],
        ),


      );
  }
  int _selectedIndex = 0;

  void setIndex(index) => this._selectedIndex = index ;
  void getIndex() =>  this._selectedIndex ;

  List<Event> events ;

  List<statObject> stats ;

  List<Standings> standings ;

  List<List<String>>  lineUps ;

  Future getEvents() async {
    events = [] ;
    var tmp = await getGameEvents(widget.fixture) ;
    for(int i = 0 ; i < tmp.length ; i++){
      events.add(tmp[i]) ;
    }
    return 1 ;
  }



  Future getStats() async {
    stats = [] ;
    var tmp = await getGameStats(widget.fixture.fixtureId) ;
    for(int i = 0 ; i < tmp.length ; i++){
      stats.add(tmp[i]) ;
    }
    return 1 ;
  }

  Future getStandingsTable() async {
    standings = [] ;
    var tmp = await getStandings(widget.fixture.league_id) ;
    for(int i = 0 ; i < tmp.length ; i++){
      standings.add(tmp[i]) ;
    }
    return 1 ;
  }

  Future getLineUpsList() async {
    lineUps = [] ;
    var tmp = await getLineUps(widget.fixture.fixtureId) ;
    for(int i = 0 ; i < tmp.length ; i++){
      lineUps.add(tmp[i]) ;
    }
    print(lineUps);
    return 1 ;
  }






  buildMain() {
    if(_selectedIndex == 0)
      return futureBuilderFunc(DetailElem, getEvents(), events) ;


      else if (_selectedIndex == 1)
      return futureBuilderFunc(statBar, getStats(), stats) ;

      else if(_selectedIndex == 2)
        return futureBuilderFunc(standingTable , getStandingsTable() , standings) ;

      else if(_selectedIndex == 5)
        return futureBuilderFunc(lineUpElem , getLineUpsList() , lineUps) ;

  }



}
