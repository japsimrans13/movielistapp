import 'package:flutter/material.dart';
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
          ElevatedButton(
              onPressed: () {
                // Close keyboard
                FocusScope.of(context).requestFocus(FocusNode());
                print(_movieNameController.value.text);
                if (_movieNameController.value.text.isNotEmpty) {
                  addMovie(_movieNameController.value.text);
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

Future? addMovie(String? movieName) {
  final movie = Movie()
    ..name = movieName!
    ..createdDate = DateTime.now();

  // using the getter method for acessing our hive box.
  final dbBox = Boxes.getMovieBox();
  dbBox.add(movie);
}
