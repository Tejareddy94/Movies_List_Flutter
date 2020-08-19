import 'package:flutter/material.dart';
import 'package:movie_list_app/provider/movie_fetch.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  final String query;

  const MovieList({Key key, this.query}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  SearchResultsState resultsState;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      resultsState = Provider.of<SearchResultsState>(context);
      resultsState.fetchResults(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return resultsState == null
        ? Center(child: CircularProgressIndicator())
        : resultsState.fetching
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.025),
                child: ListView.builder(
                    itemCount: resultsState.movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                      3.0,
                                      1.0,
                                    ),
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              width: double.infinity,
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.04),
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                        ),
                                        Text(
                                          "${resultsState.movies[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .fontSize),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          "Gener: ${resultsState.movies[index].gener}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .color),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${resultsState.movies[index].rating}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .fontSize),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            StarDisplay(
                                              value: resultsState
                                                  .movies[index].startRating,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                left: 35,
                                top: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius: 14.0,
                                          spreadRadius: 1.5,
                                          offset: Offset(
                                            0.0,
                                            5.0,
                                          ),
                                        ),
                                      ],
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30)),
                                  // height: 120,
                                  width: MediaQuery.of(context).size.width / 3.8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      resultsState.movies[index].poster,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      );
                    }),
              );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: Colors.orange,
        );
      }),
    );
  }
}
