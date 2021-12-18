import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielistapp/add_movie.dart';
import 'package:movielistapp/models/movie.dart';
import 'package:movielistapp/movies_list.dart';
import 'palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('movies');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie List App',
        theme: ThemeData(
          primarySwatch: Palette.ProjectThemeColor,
          // primaryColor: Color(0xFFD800),
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// This tab controller is defined outside so that we can acess it outside
TabController? _tabController;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Movie> movies = [];

  @override
  void dispose() {
    Hive.box('movies').close();
    super.dispose();
  }

  final List<Tab> topTabs = const <Tab>[
    Tab(text: 'MOVIES'),
    Tab(icon: Icon(Icons.addchart)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List App'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                print('search button clicked');
              }),
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                print('more button clicked');
              })
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: topTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const MovieList(),
          AddMovie(_tabController),
        ],
      ),
    );
  }
}
