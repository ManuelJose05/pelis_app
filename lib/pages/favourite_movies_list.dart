import 'package:flutter/material.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:pelis_app/shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class FavouriteMoviesList extends StatelessWidget {
  FavouriteMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MovieListView()
    );
  }
}

class _MovieListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoviesProvider>(context);
    return ListView.builder(
      itemCount: provider.pelisFavoritas.length,
      itemBuilder: (context, index) {
        return provider.pelisFavoritas.isEmpty
            ? Text(
              'No hay actores favoritas',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
            : ListTile(
              title: TextButton.icon(
                icon: Icon(Icons.favorite,color: Colors.red,),
                onPressed: () {
                  provider.deleteMovieFavorita(provider.pelisFavoritas[index].id);
                },
               label: Text(provider.pelisFavoritas[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              )),
            );
      },
    );
  }
}