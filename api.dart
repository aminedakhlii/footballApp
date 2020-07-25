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



  http.Response res = await http.get(
      'https://v2.api-football.com/fixtures/date/' + today ,
      headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}

  ) ;

  dynamic matchs = jsonDecode(res.body);

  List<Match> todayGames = [] ;

  for(int i = 0 ; i < matchs['api']['results'] ; i++) {

    dynamic fixture = matchs['api']['fixtures'][i] ;

    Team home = new Team(fixture['homeTeam']['team_name'] ,  fixture['homeTeam']['logo'] ) ;
    Team away = new Team(fixture['awayTeam']['team_name'] , fixture['awayTeam']['logo'] ) ;
    Match game = new Match(fixtureId: fixture['fixture_id'] , homeTeam : home , awayTeam : away , leagueName : fixture['league']['name'] ,
        goalsHome : fixture['goalsHomeTeam'] , goalsAway : fixture['goalsAwayTeam']) ;

    game.setScore() ;

    todayGames.add(game) ;
  }

  return todayGames ;

}


Future getGameEvents(fixture) async {

  http.Response res = await http.get(
      'https://v2.api-football.com/events/' + fixture.fixtureId.toString() ,
      headers: {'X-RapidAPI-Key' : 'acbd76b6a08facedc0b9db24bf29f97b'}
  ) ;

  dynamic eventsJson = jsonDecode(res.body) ;

  List<Event> events = [] ;

  for (int i = 0 ; i < eventsJson['api']['results'] ; i++ ){
    dynamic tmp = eventsJson['api']['events'][i];

    Event e = new Event( type : tmp['type'] , time : tmp['elapsed'] , mainPlayer : tmp['player'] , secPlayer : tmp['assist'] , home :(fixture.homeTeam.name == tmp['teamName'] ));

    events.add(e) ;

  }
  return events ;

}