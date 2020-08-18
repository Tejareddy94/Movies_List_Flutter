import 'dart:math';

class MovieModel {
  List<String> geners = ['Action','Adventure','Thriller','Horror','Drama'];
  String title;
  String year;
  String imdbID;
  String type;
  String poster;
  String rating;
  String gener;
  int startRating;


  MovieModel({this.title, this.year, this.imdbID, this.type, this.poster,this.rating,this.gener, this.startRating});

  MovieModel.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
    rating = (Random().nextDouble()*10).toStringAsFixed(1);
    startRating = 1+Random().nextInt(5);
    gener = geners[Random().nextInt(5)];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['imdbID'] = this.imdbID;
    data['Type'] = this.type;
    data['Poster'] = this.poster;
    return data;
  }
}
