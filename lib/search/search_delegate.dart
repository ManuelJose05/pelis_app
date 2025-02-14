import 'package:flutter/material.dart';
import 'package:pelis_app/models/movie_model.dart';
import 'package:pelis_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: Icon(Icons.clear)
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), 
      icon: Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    if (query.isEmpty) {
      return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 150,),
        ),
      );
    }
    return FutureBuilder(
      future: movieProvider.searchMovie(query), 
      builder: (context, snapshot) {
        return !snapshot.hasData ?
        Center(
          child: CircularProgressIndicator())
          :
          ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_,index) {
              return _SuggestionItem(movie: snapshot.data![index]);
            }
            );
      },
      );
  }

}

class _SuggestionItem extends StatelessWidget {
  final Movie movie;

  const _SuggestionItem({ required this.movie});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/images/no-image.jpg'), 
        image: movie.posterPath == null ? AssetImage('assets/images/no-image.jpg') : NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
        ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'detail',arguments: movie),  
    );
  }
}