import 'package:flutter/material.dart';
import 'package:movie_list_app/widget/movie_list_widget.dart';

class MainSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          color: Theme.of(context).iconTheme.color,
          focusColor: Colors.black,
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return MovieList(query: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search For A movie"));
  }
}
