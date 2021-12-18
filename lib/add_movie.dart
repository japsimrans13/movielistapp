import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movielistapp/boxes.dart';
import 'package:movielistapp/models/movie.dart';
import 'package:movielistapp/helper/dialog_helper.dart';

class AddMovie extends StatefulWidget {
  const AddMovie(this.homeTabController, {Key? key}) : super(key: key);

  final TabController? homeTabController;

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final _movieNameController = TextEditingController();
  final _movieCategoryController = TextEditingController();

  // get _gettabController => widget.tabController;

  @override
  void dispose() {
    _movieNameController.dispose();
    _movieCategoryController.dispose();
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
          TextFormField(
            controller: _movieCategoryController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Movie Category',
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
                // print(_movieNameController.value.text);
                // print(_movieCategoryController.value.text);
                if (_movieNameController.value.text.isNotEmpty &&
                    _movieCategoryController.value.text.isNotEmpty) {
                  addMovie(_movieNameController.value.text, curRating,
                      _movieCategoryController.value.text);
                  // empty keyboard field
                  _movieNameController.clear();
                  _movieCategoryController.clear();
                  // setTabControllerIndex(0);
                  widget.homeTabController!.index = 0;
                  print('Movie added');
                  showPopUpToast('Movie Added');
                } else {
                  print('The movie name is empty or category name is empty');
                  showPopUpToast('Please fill all the details');
                }
              },
              child: const Text('Add Movie')),
        ],
      ),
    );
  }
}

Future? addMovie(String? movieName, double rating, String category) {
  final movie = Movie()
    ..name = movieName!
    ..createdDate = DateTime.now()
    ..ratings = rating
    ..category = category;

  // using the getter method for acessing our hive box.
  final dbBox = Boxes.getMovieBox();
  dbBox.add(movie);
}
