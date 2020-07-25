import 'package:flutter/material.dart';
import 'dart:ui';
import 'constants.dart';
import 'classes.dart';
import 'api.dart';

class MatchDetails extends StatefulWidget {

  MatchDetails({this.fixture}) ;

  final Match fixture ;

  @override
  MatchDetailsState createState() => MatchDetailsState() ;

}

class MatchDetailsState extends State<MatchDetails> {

  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
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
                        image: AssetImage('assets/wallpaper.jpg')
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
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
                    height : MediaQuery.of(context).size.height * 0.085,
                    color : Colors.grey[200],
                    child: BottomNavigationBar(
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon : Icon(Icons.add),
                          title: Text('مساحة الزوار'),
                        ),
                        BottomNavigationBarItem(
                          icon : Icon(Icons.details),
                          title: Text('التفاصيل'),
                        ),
                        BottomNavigationBarItem(
                          icon : Icon(Icons.live_tv),
                          title: Text(' أحداث المباراة'),
                        )
                      ],
                      elevation: 0,
                    ),
                  ),
                  FutureBuilder(
                    future: getEvents(),
                    builder: (BuildContext context , AsyncSnapshot snap) {
                      if(snap.hasData)
                      return ListView.builder(
                          physics: ScrollPhysics(),
                         shrinkWrap: true ,
                         scrollDirection: Axis.vertical,
                          padding : EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.042),
                      itemCount: events.length ,
                      itemBuilder: (BuildContext context , int index) {
                        return DetailElem(context, events[index]) ;
                      }

                      );

                      else if (snap.hasError) {
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
                        return Column(
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
                        );
                      }

                    }

                  ),

              ]),
            )
            
            
          ],
        ),


      );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Event> events ;

  Future getEvents() async {
    events = [] ;
    var tmp = await getGameEvents(widget.fixture) ;
    for(int i = 0 ; i < tmp.length ; i++){
      events.add(tmp[i]) ;
    }
    return 1 ;
  }

}