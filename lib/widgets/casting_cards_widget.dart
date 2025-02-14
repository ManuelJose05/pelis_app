import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelis_app/models/credits_response_model.dart';
import 'package:pelis_app/models/movie_model.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCardsWidget extends StatelessWidget {
  final int movieId;

  const CastingCardsWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
      future: movieProvider.getMovieCast(movieId),
      builder: (_,AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        } else {
          final List<Cast> cast = snapshot.data!;
          return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemCount: cast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _CastCard(actor: snapshot.data![index]),
        ),
      );
        }
  });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({ required this.actor});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'actorDetail',arguments: actor),
       child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 100,
        child: Column(
          children: [
             ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height: 130,
                  width: 100,
                  placeholder: AssetImage('assets/images/no-image.jpg'), 
                  image: actor.profilePath == '' ? AssetImage('assets/images/no-image.jpg') : NetworkImage(actor.fullPosterImg),
                  fit: BoxFit.cover,
                  ),
              ),
              SizedBox(height: 5,),
              Text(actor.name, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
          ],
        ),
           ),
     );
  }
}