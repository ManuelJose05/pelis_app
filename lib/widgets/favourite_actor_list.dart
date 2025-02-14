import 'package:flutter/material.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class FavouriteActorList extends StatelessWidget {
  const FavouriteActorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _ActorListview());
  }
}

class _ActorListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoviesProvider>(context);
    return ListView.builder(
      itemCount: provider.actoresFavoritos.length,
      itemBuilder: (context, index) {
        return provider.actoresFavoritos.isEmpty
            ? Text(
              'No hay actores favoritas',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
            : ListTile(
              title: TextButton.icon(
                icon: Icon(Icons.favorite,color: Colors.red,),
                onPressed: () {
                  provider.deleteActorFavorito(provider.actoresFavoritos[index].id);
                },
               label: Text(provider.actoresFavoritos[index].name,
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
