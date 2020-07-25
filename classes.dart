
class Match {

  Match({this.fixtureId , this.homeTeam , this.awayTeam , this.leagueName , this.goalsHome , this.goalsAway});

  int fixtureId , status ;

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


class Team {

  Team(name , logo) {
    this.name = name ;
    this.logo = logo ;
  }
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