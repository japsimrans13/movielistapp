import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielistapp/boxes.dart';
import 'package:movielistapp/edit_movie.dart';
import 'package:movielistapp/models/movie.dart';
import 'package:movielistapp/movie_detailed.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    var _box = Boxes.getMovieBox();
    final _movies = _box.values.toList().cast<Movie>();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Movie List Page',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                if (_movies.isEmpty) {
                  print('Movies is empty');
                  return const Text('Watch some movies first');
                } else {
                  print('Movie length is ${_movies.length}');
                  return Column(children: [
                    const Divider(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetialPage(_movies[index])));
                          },
                          onLongPress: () {
                            print(_movies[index].name);
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditMovie(_movies[index])))
                                .then((value) {
                              setState(() {});
                            });
                          },
                          title: Text(
                            _movies[index].name,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          leading: Text((index + 1).toString()),
                          subtitle: Text(
                            _movies[index].createdDate.toString(),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Boxes.deleteMovie(_movies[index].key);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  ]);
                }
              }),
        ),
      ],
    );
  }
}

// IconButton(
//     onPressed: () {
//       final newmovie = Movie()
//         ..name = 'Let me test edit functions'
//         ..createdDate = _movies[index].createdDate;
//       Boxes.updateMovie(_movies[index].key, newmovie);
//       setState(() {});
//     },
// icon: const Icon(Icons.edit)),
