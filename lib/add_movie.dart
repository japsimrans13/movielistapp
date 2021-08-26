import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movielistapp/boxes.dart';
import 'package:movielistapp/main.dart';
import 'package:movielistapp/models/movie.dart';

class AddMovie extends StatefulWidget {
  const AddMovie(this.homeTabController, {Key? key}) : super(key: key);

  final TabController? homeTabController;

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final _movieNameController = TextEditingController();

  // get _gettabController => widget.tabController;

  @override
  void dispose() {
    _movieNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double curRating = 0;
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'This is Add movie Page',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _movieNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Movie Name',
            ),
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              curRating = rating;
            },
          ),
          ElevatedButton(
              onPressed: () {
                // Close keyboard
                FocusScope.of(context).requestFocus(FocusNode());
                print(_movieNameController.value.text);
                if (_movieNameController.value.text.isNotEmpty) {
                  addMovie(_movieNameController.value.text, curRating);
                  // empty keyboard field
                  _movieNameController.clear();
                  // setTabControllerIndex(0);
                  widget.homeTabController!.index = 0;
                  // show pop up message that new movie added.
                }
                print('The movie name is empty');
                // show here a popup message:
              },
              child: const Text('Add Movie')),
        ],
      ),
    );
  }
}

Future? addMovie(String? movieName, double rating) {
  final movie = Movie()
    ..name = movieName!
    ..createdDate = DateTime.now()
    ..ratings = rating;

  // using the getter method for acessing our hive box.
  final dbBox = Boxes.getMovieBox();
  dbBox.add(movie);
}
