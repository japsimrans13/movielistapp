import 'package:flutter/material.dart';
import 'package:movielistapp/boxes.dart';
import 'package:movielistapp/models/movie.dart';

class EditMovie extends StatefulWidget {
  const EditMovie(this.movie, {Key? key}) : super(key: key);
  final Movie? movie;

  @override
  State<EditMovie> createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  late TextEditingController _movieNameController;

  @override
  void dispose() {
    _movieNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _movieNameController = TextEditingController(text: widget.movie!.name);
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
            ElevatedButton(
                onPressed: () {
                  // Closing keyboard on submit
                  FocusScope.of(context).requestFocus(FocusNode());
                  print(_movieNameController.value.text);
                  if (_movieNameController.value.text.isNotEmpty) {
                    final newmovie = Movie()
                      ..name = _movieNameController.value.text.toString()
                      ..createdDate = widget.movie!.createdDate;
                    print('key is :');
                    print(widget.movie!.key);
                    Boxes.updateMovie(widget.movie!.key, newmovie);
                    Navigator.pop(context);
                    // show pop up message that movie editted.
                  } else if (_movieNameController.value.text.isEmpty) {
                    print('The movie name is empty');
                    // show here a popup message:
                  }
                },
                child: const Text('Edit Movie')),
          ],
        ),
      ),
    );
  }
}
