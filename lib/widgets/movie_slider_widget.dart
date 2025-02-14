import 'package:flutter/material.dart';
import 'package:pelis_app/models/movie_model.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSliderWidget extends StatefulWidget {
  final List<Movie> movies;
  final Function nextPage;
  const MovieSliderWidget({super.key, required this.movies, required this.nextPage});

  @override
  State<MovieSliderWidget> createState() => _MovieSliderWidgetState();
}

class _MovieSliderWidgetState extends State<MovieSliderWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_set_literal
    scrollController.addListener(() => {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        widget.nextPage()
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) => _MoviePoster(widget.movies[index]))
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  Movie? movie;

  _MoviePoster(Movie peli) {
    movie = peli;
  }
  @override
  Widget build(BuildContext context) {
    movie!.heroId = 'slider-${movie!.id}';
    final provider = Provider.of<MoviesProvider>(context);
    provider.rutaFrom = movie!.heroId!;
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detail',arguments: movie),
            child: Hero(
              tag: movie!.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  image: NetworkImage(movie!.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(movie!.title,overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}