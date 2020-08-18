import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:movie_list_app/Model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SearchResultsState extends ChangeNotifier {
  List<MovieModel> movies = [];
  bool isFetching = true;
  bool get fetching => isFetching;

  void setFetching(bool fetch){
    isFetching = fetch;
    notifyListeners();
  }
  void fetchResults(String query) async {
    if(movies==null){
    setFetching(true);
    }
    
    try {
      final response = await http
          .get(("http://www.omdbapi.com/?apikey=e1d9e9e&s=" + query), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });
      if (response.statusCode == 200) {
        movies = [];
        var _data = jsonDecode(response.body);
        for (var movie in _data['Search']) {
          MovieModel movieModel = MovieModel.fromJson(movie);
          movies.add(movieModel);
        }
       setFetching(false);
        print(movies);
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }

  void searchResults(List<MovieModel> post) {
    movies = post;
    notifyListeners();
  }

  void serachResultsClear() {
    movies.clear();
    notifyListeners();
  }
}
