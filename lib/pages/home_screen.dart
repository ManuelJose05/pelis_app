import 'package:flutter/material.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:pelis_app/search/search_delegate.dart';
import 'package:pelis_app/shared_preferences/shared_preferences.dart';
import 'package:pelis_app/widgets/card_swiper.dart';
import 'package:pelis_app/widgets/movie_slider_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key}) {
prefs.setUltimaRuta('home');
   }
   final prefs = PreferenciasUsuario();
    

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pushNamed(context, 'favourites'), icon: Icon(Icons.favorite_outline)),
        title: Text('Películas en cines'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () => showSearch(
            context: context, 
            delegate: MovieSearchDelegate()
            ), icon: Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiperWidget(movies: moviesProvider.enCines,),
        
            MovieSliderWidget(movies: moviesProvider.popular,nextPage: () => moviesProvider.getPopularMovies()),
          ],
        ),
      )
    );
  }
}