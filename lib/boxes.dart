import 'package:hive/hive.dart';
import 'package:movielistapp/models/movie.dart';

class Boxes {
  static Box<Movie> getMovieBox() => Hive.box<Movie>('movies');
  static deleteMovie(key) {
    getMovieBox().delete(key);
  }

  static updateMovie(dynamic key, Movie movie) {
    getMovieBox().put(key, movie);
  }
}
