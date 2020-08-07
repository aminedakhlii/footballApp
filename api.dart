import 'dart:async';
import 'dart:convert';

import 'classes.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


DateTime date = DateTime.now() ;


Future getTodaysMatches() async {

    String today ;



    var formatter = DateFormat('yyyy-MM-dd');
    today = formatter.format(date);



 /* http.Response res = await http.get(
      'https://v2.api-football.com/fixtures/league/524/' + today ,
      headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}

  ) ;*/

  http.Response res = await http.get('http://192.168.1.18:8050/football') ;


  dynamic matchs = jsonDecode(res.body);


  List<Match> todayGames = [] ;

  for(int i = 0 ; i < matchs['api']['results'] ; i++) {

    dynamic fixture = matchs['api']['fixtures'][i] ;

    Team home = new Team(fixture['homeTeam']['team_name'] ,  fixture['homeTeam']['logo'] ) ;
    Team away = new Team(fixture['awayTeam']['team_name'] , fixture['awayTeam']['logo'] ) ;

    Match game = new Match(fixtureId: fixture['fixture_id'] , league_id: fixture['league_id'] , homeTeam : home , awayTeam : away , leagueName : fixture['league']['name'] ,
        goalsHome : fixture['goalsHomeTeam'] , goalsAway : fixture['goalsAwayTeam']) ;

    game.setScore() ;

    todayGames.add(game) ;
  }

  return todayGames ;

}


Future getGameEvents(fixture) async {

  /*http.Response res = await http.get(
      'https://v2.api-football.com/events/' + fixture.fixtureId.toString() ,
     headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}
  ) ;*/

  http.Response res = await http.get('http://192.168.1.18:8050/football/events') ;


  dynamic eventsJson = jsonDecode(res.body) ;

  List<Event> events = [] ;

  for (int i = 0 ; i < eventsJson['api']['results'] ; i++ ){
    dynamic tmp = eventsJson['api']['events'][i];

    Event e = new Event( type : tmp['type'] , time : tmp['elapsed'] , mainPlayer : tmp['player'] ,
        secPlayer : tmp['assist'] , home :(fixture.homeTeam.name == tmp['teamName'] ));

    events.add(e) ;

  }

  print('hi' + fixture.fixtureId.toString());

  return events ;

}

Future getGameStats(fixtureId) async {


  /*http.Response res = await http.get(
      'https://v2.api-football.com/statistics/fixture/' + fixtureId.toString() ,
     // headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}
  ) ;
*/

  http.Response res = await http.get('http://192.168.1.18:8050/football/stats') ;


  dynamic statJson = jsonDecode(res.body) ;



  List<statObject> gameStats = [] ;


  statJson['api']['statistics'].forEach((k,v) {

    statObject stat = new statObject(name : k , home : v['home'] , away : v['away']) ;

    gameStats.add(stat);

  }

  );

  return gameStats ;

}

Future getStandings(league_id) async {

  /*http.Response res = await http.get(
    'https://v2.api-football.com/leagueTable/' + league_id.toString() ,
     headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}
  ) ;*/

  http.Response res = await http.get('http://192.168.1.18:8050/football/stands') ;



  dynamic standingJson = jsonDecode(res.body) ;


  List<Standings> standings = [] ;


  for (int i=0 ; i < standingJson['api']['standings'][0].length ; i++) {

    dynamic standElem = standingJson['api']['standings'][0][i] ;


      Team tmp = new Team(standElem['teamName'], standElem['logo']);

    Standings s = new Standings(rank : standElem['rank'] , team : tmp , description : standElem['description']) ;

    standings.add(s);

  }

  print(standings);

  return standings ;
}


Future getLineUps(fixId) async {

   /* http.Response res = await http.get(
    'https://v2.api-football.com/lineups/' + fixId.toString() ,
     headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}
  ) ;*/

  http.Response res = await http.get('http://192.168.1.18:8050/football/lineups') ;



  dynamic lineupJson = jsonDecode(res.body) ;




  List<List<String>> lineups = [] ;

  bool home = true ;

  lineupJson['api']['lineUps'].forEach((k,v){

    List<String> tmp = [] ;

      for (int i = 0; i < v['startXI'].length ; i++) {


       tmp.add(v['startXI'][i]['player']);



    }

      lineups.add(tmp) ;

  });


  return lineups ;

}

