import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pelis_app/models/movie_model.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';


class CardSwiperWidget extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiperWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return movies.isEmpty
    ?
    SizedBox(
      width: double.infinity,
      height: size.height * 0.6,
      child: Center(child: CircularProgressIndicator(),),
    )
    :    
    SizedBox(
      width: size.width > 1300 ? size.height * 0.7 : double.infinity,
      height: size.height < 1300 ? size.height * 0.6 : size.height * 0.8,
      //color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.75 ,
        itemHeight:  size.height * 0.5,
        itemBuilder: (context, index) {
          final Movie movie = movies[index];
          movie.heroId = 'swiper-${movie.id}';
          final provider = Provider.of<MoviesProvider>(context);
          provider.rutaFrom = movie.heroId!;
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detail',arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/loading.gif'), 
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.fill,
                  ),
              ),
            ),
          );
        },
        )
   
    );
  }
}