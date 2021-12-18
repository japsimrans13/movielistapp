import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movielistapp/boxes.dart';
import 'package:movielistapp/models/movie.dart';
import 'package:movielistapp/helper/dialog_helper.dart';

class EditMovie extends StatefulWidget {
  const EditMovie(this.movie, {Key? key}) : super(key: key);
  final Movie? movie;

  @override
  State<EditMovie> createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  late TextEditingController _movieNameController;
  late TextEditingController _movieCategoryController;

  @override
  void dispose() {
    _movieNameController.dispose();
    _movieCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _movieNameController = TextEditingController(text: widget.movie!.name);
    _movieCategoryController =
        TextEditingController(text: widget.movie!.category);
    double newRating = widget.movie!.ratings;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'This is Edit movie Page',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              // initialValue: ,
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
                hintText: 'Enter Movie Name',
              ),
            ),
            RatingBar.builder(
              initialRating: widget.movie!.ratings,
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
                newRating = rating;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  // Closing keyboard on submit
                  FocusScope.of(context).requestFocus(FocusNode());
                  // print(_movieNameController.value.text);
                  // print(_movieCategoryController.value.text);
                  if (_movieNameController.value.text.isNotEmpty &&
                      _movieCategoryController.value.text.isNotEmpty) {
                    final newmovie = Movie()
                      ..name = _movieNameController.value.text.toString()
                      ..createdDate = widget.movie!.createdDate
                      ..ratings = newRating
                      ..category =
                          _movieCategoryController.value.text.toString();
                    print('key is :');
                    print(widget.movie!.key);
                    Boxes.updateMovie(widget.movie!.key, newmovie);
                    Navigator.pop(context);
                    print('Movie editted');
                  } else if (_movieNameController.value.text.isEmpty) {
                    print('The movie name is empty or category name is empty');
                    showPopUpToast('Please fill all the details');
                  }
                },
                child: const Text('Edit Movie')),
          ],
        ),
      ),
    );
  }
}
