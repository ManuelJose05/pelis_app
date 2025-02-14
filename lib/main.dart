import 'package:flutter/material.dart';
import 'package:pelis_app/pages/actor_detail_screen.dart';
import 'package:pelis_app/pages/detail_screen.dart';
import 'package:pelis_app/pages/full_video_screen.dart';
import 'package:pelis_app/pages/home_screen.dart';
import 'package:pelis_app/pages/movie_actor_favourite_screen.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:pelis_app/shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.iniPrefs();
  runApp(AppState());
}


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(),lazy: false)
      ],
      child: MyApp(),
    );
  }

}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelis App',
      initialRoute: prefs.ultimaRuta,
      routes: {
        'home': (_) => HomeScreen(),
        'detail': (_) => DetailScreen(),
        'actorDetail':(_) => ActorDetailScreen(),
        'favourites' : (_) => MovieActorFavouriteScreen(),
      },
      theme: ThemeData.light()
      .copyWith(appBarTheme: AppBarTheme(color: Colors.indigo,titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),iconTheme: IconThemeData(color: Colors.white))),
    );
  }
}