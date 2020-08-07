import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:ui';

class Favorites extends StatefulWidget {

  @override
  FavoritesState createState() => FavoritesState() ;
}



class FavoritesState extends State<Favorites> {

  String title = 'المفضلة' ;

  int s_index = 0 ;


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  child: Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    child: Text('', style: titleTextWhite,),
                  ),
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
                    icon: Icon( Icons.arrow_back_ios , color: Colors.white,) ,
                    onPressed: () {
                     Navigator.of(context).pop() ;
                    }),
                Text(this.title , style: titleTextWhite,),

              ],
            ),
          ),

        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white70,
            height: MediaQuery.of(context).size.height * 0.0735 ,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                ),

                hoverColor: Colors.white,
                hintText: 'كلمة البحث ' ,
                hintStyle: smallTextblueGrey,

              ),
            ),
          ),
          Expanded(child: GestureDetector( onTap: () => FocusScope.of(context).unfocus(),
              child: FutureBuilder(
                builder: (BuildContext context , AsyncSnapshot snap){
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder:(BuildContext c , int index){
                        return singleListElem(context) ;
                      }) ;
                },

              ),
            ),
          )
        ],
      ),

    );
  }
}