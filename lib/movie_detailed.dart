import 'package:flutter/material.dart';
import 'package:movielistapp/models/movie.dart';

class MovieDetialPage extends StatefulWidget {
  const MovieDetialPage(this.movie, {Key? key}) : super(key: key);
  final Movie movie;
  @override
  _MovieDetialPageState createState() => _MovieDetialPageState();
}

class _MovieDetialPageState extends State<MovieDetialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            buildEditMovie(widget.movie),
          ],
        ),
      ),
    );
  }
}

Widget buildEditMovie(Movie movie) {
  return Container(
    child: Text('Here comes the build widget, movie name : ${movie.name}'),
  );
}
