import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MovieListView()));
}

class MovieListView extends StatelessWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Movie> movieList = Movie.getMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              Positioned(child: movieCard(movieList[index], context)),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ]);
            /*return Card(
              elevation: 4.5,
              color: Colors.white,
              child: ListTile(
                title: Text(movieList[index].title),
                leading: CircleAvatar(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(movieList[index].images[0]),
                            fit: BoxFit.cover)),
                  ),
                ),
                subtitle: Text(movieList[index].released),
                trailing: Text("..."),
                //onTap: () => debugPrint("hello"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieListDetails(
                                movie: movieList[index],
                              )));
                },
              ),
            );*/
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(left: 60.0),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Card(
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            movie.title,
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "${movie.imdbRating} / 10",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          movie.released,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          movie.runtime,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          movie.rated,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListDetails(
                      movie: movie,
                    )));
      },
    );
  }

  Widget movieImage(String url) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }
}

class MovieDetailThumbnail extends StatelessWidget {
  const MovieDetailThumbnail({super.key, required this.thumbnail});
  final String thumbnail;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 190,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail), fit: BoxFit.cover)),
          )
        ]),
        Container(
          height: 80,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.white, Colors.white70],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        Icon(
          Icons.play_circle_fill_outlined,
          size: 100,
          color: Colors.white,
        )
      ],
    );
  }
}

class MovieDetailsPoster extends StatelessWidget {
  const MovieDetailsPoster({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(
            poster: movie.images[0],
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: MovieDetailsHeader(movie: movie),
          )
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} - ${movie.genre}".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
        Text.rich(TextSpan(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(text: movie.plot),
              TextSpan(
                  text: "More...", style: TextStyle(color: Colors.indigoAccent))
            ]))
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Director", value: movie.director),
          MovieField(field: "Awards", value: movie.awards)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  const MovieField({super.key, required this.field, required this.value});
  final String field;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field : ",
          style: TextStyle(
              color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Flexible(
            child: Text(value,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 14,
                    fontWeight: FontWeight.w300)),
          ),
        )
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.poster});

  final String poster;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(poster), fit: BoxFit.cover)),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class MovieListDetails extends StatelessWidget {
  const MovieListDetails({super.key, required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie Details"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView(
          children: [
            MovieDetailThumbnail(thumbnail: movie.images[1]),
            MovieDetailsPoster(movie: movie),
            MovieDetailsCast(movie: movie),
            HorizontalLine(),
            MovieExtraPosters(posters: movie.images)
          ],
        )

        /*Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ElevatedButton(
              child: const Text("go back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: Text(movie.title),
          )
        ],
      ),*/
        );
  }
}

class MovieExtraPosters extends StatelessWidget {
  const MovieExtraPosters({super.key, required this.posters});
  final List<String> posters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "more images".toUpperCase(),
          style: TextStyle(fontSize: 16, color: Colors.black26),
        ),
        Container(
          height: 200,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(posters[index]))),
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    width: 8,
                  ),
              itemCount: posters.length),
        )
      ],
    );
  }
}

class Movie {
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String metascore;
  String imdbRating;
  String imdbVotes;
  String imdbID;
  String type;
  List<String> images;
  String response;

  static List<Movie> getMovies() => [
        Movie(
            "Avatar",
            "2009",
            "PG-13",
            "18 Dec 2009",
            "162 min",
            "Action, Adventure, Fantasy",
            "James Cameron",
            "James Cameron",
            "Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang",
            "A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.",
            "English, Spanish",
            "USA, UK",
            "Won 3 Oscars. Another 80 wins & 121 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg",
            "83",
            "7.9",
            "890,617",
            "tt0499549",
            "movie",
            [
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMjEyOTYyMzUxNl5BMl5BanBnXkFtZTcwNTg0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BNzM2MDk3MTcyMV5BMl5BanBnXkFtZTcwNjg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTY2ODQ3NjMyMl5BMl5BanBnXkFtZTcwODg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxOTEwNDcxN15BMl5BanBnXkFtZTcwOTg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYxMDg1Nzk1MV5BMl5BanBnXkFtZTcwMDk0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
            ],
            "True"),
        Movie(
            "I Am Legend",
            "2007",
            "PG-13",
            "14 Dec 2007",
            "101 min",
            "Drama, Horror, Sci-Fi",
            "Francis Lawrence",
            "Mark Protosevich (screenplay), Akiva Goldsman (screenplay), Richard Matheson (novel), John William Corrington, Joyce Hooper Corrington",
            "Will Smith, Alice Braga, Charlie Tahan, Salli Richardson-Whitfield",
            "Years after a plague kills most of humanity and transforms the rest into monsters, the sole survivor in New York City struggles valiantly to find a cure.",
            "English",
            "USA",
            "9 wins & 21 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTU4NzMyNDk1OV5BMl5BanBnXkFtZTcwOTEwMzU1MQ@@._V1_SX300.jpg",
            "65",
            "7.2",
            "533,874",
            "tt0480249",
            "movie",
            [
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTI0NTI4NjE3NV5BMl5BanBnXkFtZTYwMDA0Nzc4._V1_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTIwMDg2MDU4M15BMl5BanBnXkFtZTYwMTA0Nzc4._V1_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc5MDM1OTU5OV5BMl5BanBnXkFtZTYwMjA0Nzc4._V1_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTA0MTI2NjMzMzFeQTJeQWpwZ15BbWU2MDMwNDc3OA@@._V1_.jpg"
            ],
            "True"),
        Movie(
            "300",
            "2006",
            "R",
            "09 Mar 2007",
            "117 min",
            "Action, Drama, Fantasy",
            "Zack Snyder",
            "Zack Snyder (screenplay), Kurt Johnstad (screenplay), Michael Gordon (screenplay), Frank Miller (graphic novel), Lynn Varley (graphic novel)",
            "Gerard Butler, Lena Headey, Dominic West, David Wenham",
            "King Leonidas of Sparta and a force of 300 men fight the Persians at Thermopylae in 480 B.C.",
            "English",
            "USA",
            "16 wins & 42 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMjAzNTkzNjcxNl5BMl5BanBnXkFtZTYwNDA4NjE3._V1_SX300.jpg",
            "52",
            "7.7",
            "611,046",
            "tt0416449",
            "movie",
            [
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTMwNTg5MzMwMV5BMl5BanBnXkFtZTcwMzA2NTIyMw@@._V1_SX1777_CR0,0,1777,937_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTQwNTgyNTMzNF5BMl5BanBnXkFtZTcwNDA2NTIyMw@@._V1_SX1777_CR0,0,1777,935_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0MjQzOTEwMV5BMl5BanBnXkFtZTcwMzE2NTIyMw@@._V1_SX1777_CR0,0,1777,947_AL_.jpg"
            ],
            "True")
      ];
  Movie(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.images,
      this.response);
}
