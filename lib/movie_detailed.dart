import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
            const Text(
              'Movie Detail Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Movie Name : ${widget.movie.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Category : ${widget.movie.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Date created : ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    getYearMonthDate(widget.movie.createdDate)!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            RatingBar.builder(
              // set initial rating to movie.ratings
              initialRating: widget.movie.ratings,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ignoreGestures: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            )
          ],
        ),
      ),
    );
  }
}

String? getYearMonthDate(DateTime data) {
  String _day = data.day.toString();
  String _month = data.month.toString();
  String _year = data.year.toString();
  return _day + '-' + _month + '-' + _year;
}
