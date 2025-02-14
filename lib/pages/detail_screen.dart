import 'package:flutter/material.dart';
import 'package:pelis_app/models/movie_model.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:pelis_app/shared_preferences/shared_preferences.dart';
import 'package:pelis_app/widgets/casting_cards_widget.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
   DetailScreen({super.key}){
prefs.setUltimaRuta('detail');
   }
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    
    final Movie? movie = ModalRoute.of(context)?.settings.arguments as Movie?;
    final provider = Provider.of<MoviesProvider>(context);
    if (movie != null) prefs.savePeliId(movie.id);
    return FutureBuilder(
      future: provider.getMovieById(prefs.getPeliId()),
      builder: (context, snapshot) {
        return !snapshot.hasData ?
        Scaffold(
          body: Center(child: CircularProgressIndicator()),
        )
        :
        _DetailView(movie: snapshot.data);
      },
      );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({
    required this.movie,
  });

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie!),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie!),
              _OverView(movie!),
              // _OverView(),
              CastingCardsWidget(movieId: movie!.id)
              ]),
          )
        ],
      )
    );
  }
}

class _OverView extends StatelessWidget {
  Movie? movie;

  _OverView(Movie peli) {
    movie = peli;
  }
  @override
  Widget build(BuildContext context) {
   return Container(
    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
    child: Text(movie!.overview,
    textAlign: TextAlign.justify,
    style: Theme.of(context).textTheme.bodyMedium,
    ),
   );
  }
}

class _PosterAndTitle extends StatelessWidget {
  Movie? movie;

  _PosterAndTitle(Movie peli) {
    movie = peli;
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoviesProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: provider.rutaFrom,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height:   200,
                  placeholder: AssetImage('assets/images/no-image.jpg'), 
                  image: NetworkImage(movie!.fullPosterImg),
                  fit: BoxFit.cover,
                  ),
              ),
          ),
            SizedBox(width: 15,),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie!.title, style: Theme.of(context).textTheme.headlineMedium,maxLines: 2,overflow: TextOverflow.ellipsis),
                  Text(movie!.originalTitle, style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,maxLines: 2,),
                  Row(
                children: [
                  Icon(Icons.star_outlined,size: 15,color: Colors.grey,),
                  SizedBox(width: 5),
                  Text(movie!.voteAverage.toString(),style: Theme.of(context).textTheme.bodySmall,),
                ],
              ),
              IconButton(onPressed: () {
              provider.isMovieFavourite(movie!.id) ?
              provider.deleteMovieFavorita(movie!.id)
              :
              provider.addPelisFavoritas(movie!);
              }, icon: Icon(Icons.favorite,color: provider.isMovieFavourite(movie!.id) ? Colors.red : Colors.black,)),
              FilledButton(onPressed: () async {
                String keyVideo = await provider.getTrailerUrl(movie!.id);
                await provider.openYouTube(keyVideo);
              }, child: Text('Ver trailer'),)
                ],  
              ),
            ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  Movie? movie;
  _CustomAppBar(Movie peli) {
    movie = peli;
  }
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(onPressed: () => Navigator.pushNamed(context, 'home'), icon: Icon(Icons.arrow_back,color: Colors.white,)),
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          width: double.infinity,
          child: Text(movie!.title, style: TextStyle(fontSize: 16,color: Colors.white),),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/images/no-image.jpg'), 
          image: NetworkImage(movie!.fullPosterImg),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}