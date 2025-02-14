import 'package:flutter/material.dart';
import 'package:pelis_app/models/credits_response_model.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:pelis_app/shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActorDetailScreen extends StatelessWidget {
   ActorDetailScreen({super.key}) {
    prefs.setUltimaRuta('actorDetail');
   }
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoviesProvider>(context);
    final Cast? actor = ModalRoute.of(context)?.settings.arguments as Cast?;
    if (actor != null) prefs.saveActor(actor.toJsonString());
    return _ActorView(actor: prefs.getActor(), provider: provider);
  }
}

class _ActorView extends StatelessWidget {
  const _ActorView({
    super.key,
    required this.actor,
    required this.provider,
  });

  final Cast? actor;
  final MoviesProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pushNamed(context, 'detail'), icon: Icon(Icons.arrow_back)),
        title: Text(actor!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            provider.isActorFavourite(actor!.id) ?
            provider.deleteActorFavorito(actor!.id)
            :
            provider.addActorFavoritos(actor!);
          }, icon: Icon(Icons.favorite,color: provider.isActorFavourite(actor!.id)? Colors.red : Colors.white,))
        ],
      ),
      body: _ActorDetailView(actor!),
    );
  }
}

class _ActorDetailView extends StatelessWidget {
  final Cast actorPeli;
  
  _ActorDetailView(this.actorPeli);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoviesProvider>(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height:  MediaQuery.of(context).size.width > 1300 ? MediaQuery.of(context).size.height * 0.65 : size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width > 1300 ? size.width * 0.3 : size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: actorPeli.fullPosterImg == '' ? Image.asset('assets/images/no-image.jpg'): Image.network(actorPeli.fullPosterImg, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 15),
            Divider(thickness: 2, color: Colors.black),
            const SizedBox(height: 10),
            infoActorRow(data: actorPeli.name, icon: Icons.person_outline),
            infoActorRow(data: actorPeli.character ?? 'Desconocido', icon: Icons.movie),
            infoActorRow(data: actorPeli.popularity.toString(), icon: Icons.star_outline),
            infoActorRow(
              data: actorPeli.knownForDepartment.name == 'ACTING' ? 'Actor' : 'Crew',
              icon: actorPeli.knownForDepartment.name == 'ACTING' ? Icons.theater_comedy_outlined : Icons.build,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => provider.addActorFavoritos(actorPeli),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
              ),
              child: const Text('Añadir a favoritos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class infoActorRow extends StatelessWidget {
  const infoActorRow({super.key, required this.data, required this.icon});
  final IconData icon;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 10),
          Text(data, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
