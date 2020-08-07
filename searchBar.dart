import 'package:flutter/material.dart';
import 'package:livescore/UI/constants.dart';

class Search extends SearchDelegate<String> {



  List suggs = ['messi' , 'ronaldo' , 'david silva'] ;
  List titles = ['الفرق الاكثر بحثا' , 'اللاعبون الاكثر بحثا' , 'البطولات الاكثر بحثا'];



  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon : Icon(Icons.clear) , onPressed: () {
      query = '' ;
    },)] ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List recentClubSearchs = [CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),] ;
    List recentPlayerSearchs = [CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),] ;
    List recentLeagueSearchs = [CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),CircleImage_(context),] ;
    final suggestionList = query.isEmpty ? [recentClubSearchs , recentPlayerSearchs , recentLeagueSearchs ] : suggs.where((element) => element.startsWith(query)).toList() ;
    return (query.isNotEmpty) ? ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true ,
        itemCount: suggestionList.length,
        itemBuilder: (context , index) =>  ListTile(
          onTap: () {
            showResults(context) ;
          },
          leading:  Icon(Icons.print) ,
          title: RichText(text: TextSpan(
          text: suggestionList[index].substring(0,query.length) ,
          style: menuTextGrey,
          children: [
            TextSpan(text: suggestionList[index].substring(query.length) , style: menuTextBlack)
          ]
        ))))

     :  Container(
      color: Colors.blueGrey[50],
       child: Padding(
        padding: EdgeInsets.only(top : MediaQuery.of(context).size.height * 0.05  ),
         child: Column(
         children: <Widget>[
         for(var element in suggestionList) Column(
          children: <Widget>[
          Text(titles[suggestionList.indexOf(element)] , style: menuTextGrey,),
          SizedBox(height:  MediaQuery.of(context).size.height * 0.015 ,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
             reverse: true,
             child: Row(
                children: <Widget>[
                for(var e in element)
              Padding(
                padding : EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.02),
                  child : e
              )
            ],),
          ),
        SizedBox(height:  MediaQuery.of(context).size.height * 0.077 ,),

    ],
             ),
    ])),
     );
  }


  @override
  Widget buildResults(BuildContext context) {
    //do the actions here
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
            close(context, null) ;
        } ) ;
  }

  String get searchFieldLabel => 'بحث' ;

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.blueGrey[100],
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.blueGrey[600]),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
      accentColor: Colors.white
    );
  }

}