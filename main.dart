import 'package:flutter/material.dart';
import 'package:livescore/UI/constants.dart';
import 'package:livescore/UI/sideMenu.dart';
import 'dart:ui';
import 'api.dart';
import 'classes.dart';
import 'package:intl/intl.dart';
import 'searchBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashScore',
      theme: ThemeData(
        fontFamily: 'beinNormal',
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'فلاش سكور'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>() ;

  @override
  Widget build(BuildContext context) {

     return Scaffold(
       resizeToAvoidBottomPadding: false,
       endDrawer: NavDrawer(),
       key: scaffoldKey,
       backgroundColor: Colors.blueGrey[100],

        appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15) ,
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[Container()],
          flexibleSpace: Container(
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
                ),
              ),
            ),
          ),

          title: Padding(
            padding: EdgeInsets.only(top : MediaQuery.of(context).size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                IconButton(
                    icon: Icon( Icons.search , color: Colors.white,) ,
                    onPressed: () {
                      showSearch(context: context, delegate: Search()) ;
                    }),
                Text(widget.title , style: titleTextWhite,),
                IconButton(
                    icon: Icon( Icons.menu , color: Colors.white,) ,
                    onPressed: () {
                      if(scaffoldKey.currentState.isDrawerOpen){
                        scaffoldKey.currentState.openEndDrawer();
                      }else{
                        scaffoldKey.currentState.openEndDrawer();
                      }
                    }),

              ],
            ),
          ),

        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            HomelistTop((DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(DateTime.now()) ) ? 'مباريات اليوم'
                        : DateFormat('yyyy-MM-dd').format(date).toString(), Icons.calendar_today),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Expanded(
              child: FutureBuilder(
                future: fillGames(),
                builder: ( BuildContext context, AsyncSnapshot snap) {
                  if(snap.hasData) {
                  return ListView.builder(
                    itemCount: games.length,
                    padding : EdgeInsets.symmetric(horizontal : MediaQuery.of(context).size.width * 0.04),
                    itemBuilder: (BuildContext context , int index){
                     return  listElem(context , games[index]);
                    },


                );
                  }
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
                          child: Text('هناك خلل ما ${snap.error}'    , style: titleText),
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
            ),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  List<Match> games  ;

  Future fillGames() async {

    games = [] ;

    List<Match> tmp = await getTodaysMatches() ;



    for(int i = 0 ; i < tmp.length ; i++ ) {
      games.add(tmp[i]) ;
    }

    return 1 ;


  }








  HomelistTop(title , iconLeft) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.062,
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.025),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color : Colors.blueGrey),
                  )
            ),
            child: IconButton(
            icon: Icon(iconLeft , color: Colors.blueGrey[600],),
            onPressed: () {

              return showDatePicker(
                context: context,
                cancelText: 'عودة',
                confirmText: 'تأكيد',
                firstDate: DateTime(1900),
                initialDate: date,
                lastDate: DateTime(2100),


              ).then((value) async {

                if(value != date && value != null) {

                date = value ;

                var tmp = await getTodaysMatches() ;

              setState (() {
                  games = tmp ;
              }) ;
                }
              });
            },
        ),
          ),
        Text(title, style: secTextBlack,),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Container(
            decoration: BoxDecoration(
            color: mainIconColor,
            border: Border(
            right: BorderSide(color : Colors.blueGrey),
              left: BorderSide(color : Colors.blueGrey)
            )
            ),
            child: Listener(
              onPointerUp: (tap) {
                setState(() {
                  mainIconColor = Colors.grey[100] ;
                  onclickIconColor = Colors.blueGrey[600] ;
                });
              },
              onPointerDown: (tap) {
                setState(() {
                  Color tmp = mainIconColor ;
                  mainIconColor = onclickIconColor ;
                  onclickIconColor = tmp ;
                });
              },
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios , color: onclickIconColor,),
                onPressed: () async {
                  date = date.subtract(Duration(days: 1)) ;
                  var tmp = await getTodaysMatches() ;
                  setState(() {
                    games = tmp ;
                  });
                },
              ),
            ),
        ),

           Listener(
             onPointerUp: (tap) {
               setState(() {
                 secIconColor = Colors.grey[100] ;
                 secOnclickIconColor = Colors.blueGrey[600] ;
               });
             },
             onPointerDown: (tap) {
               setState(() {
                 Color tmp = secIconColor ;
                 secIconColor = secOnclickIconColor ;
                 secOnclickIconColor = tmp ;
               });
             },
             child: Container(
               color: secIconColor,
               child: IconButton(
                icon: Icon(Icons.arrow_forward_ios , color: secOnclickIconColor,),
                onPressed: () async {
                  date = date.add(Duration(days: 1)) ;
                  //await fillGames() ;
                  var tmp = await getTodaysMatches() ;

                  setState(() {
                    games = tmp ;
                  });
                },
          ),
             ),
           ),


      ],
    )
    ],
    ),
    ),
    );
  }


}
