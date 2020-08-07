
class Match {

  Match({this.fixtureId , this.league_id , this.homeTeam , this.awayTeam , this.leagueName , this.goalsHome , this.goalsAway });

  int fixtureId , league_id ;

  Team homeTeam ;
  Team awayTeam ;

  String leagueName ;
  int goalsHome ;
  int goalsAway ;

  String score ;

  void setScore() {
    this.score = this.goalsHome.toString() + ':' + this.goalsAway.toString() ;
  }



}


class League {
  int id ;
  String name , type , country , logoUrl ;
  int season ;

  League({this.id, this.name, this.type, this.country, this.logoUrl,
      this.season});
}

class Standings {
  int rank ;
  Team team ;
  String description ;

  Standings({this.rank, this.team, this.description});

}



class Team {

  Team(name , logo) {
    this.name = name ;
    this.logo = logo ;
  }

  int id ;
  String logo ;
  String name ;

}

class Player {
  String name ;
  Team team ;
  String photo ;
  Player({this.name , this.photo , this.team}) ;

}

class Event {

  String type ;
  int time ;
  String mainPlayer , secPlayer ;
  bool home ;

  Event({this.type , this.time , this.mainPlayer , this.secPlayer , this.home}) ;

}


class statObject {
  String name ;
  var home ;
  var away ;

  statObject({this.name , this.home, this.away});
}