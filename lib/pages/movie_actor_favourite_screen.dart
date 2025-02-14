import 'package:flutter/material.dart';
import 'package:pelis_app/config/tabs.dart';
import 'package:pelis_app/pages/favourite_movies_list.dart';
import 'package:pelis_app/shared_preferences/shared_preferences.dart';
import 'package:pelis_app/widgets/favourite_actor_list.dart';

import 'package:flutter/material.dart';

class MovieActorFavouriteScreen extends StatelessWidget {
  MovieActorFavouriteScreen({super.key}) {
     prefs.setUltimaRuta('favourites');
  }
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: Tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () => Navigator.pushNamed(context, 'home'), icon: Icon(Icons.arrow_back,color: Colors.white,)),
          title: Text('Lista de favoritos'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            FavouriteActorList(),
            FavouriteMoviesList(),
          ],
          viewportFraction: 1.5,
        ),
        bottomNavigationBar: Container(
          color: Colors.blueAccent, // Fondo azul para el TabBar
          child: TabBar(
            tabs: Tabs,
            indicatorColor: Colors.white,
            labelColor: Colors.white, // Texto blanco para pestañas seleccionadas
            unselectedLabelColor: Colors.white70, // Texto blanco tenue para no seleccionadas
          ),
        ),
      ),
    );
  }
}