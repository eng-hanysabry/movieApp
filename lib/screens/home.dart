import 'package:flutter/material.dart';
import 'package:flutter_application_281/db/DbHelper.dart';
import 'package:flutter_application_281/model/Movie.dart';
import 'package:flutter_application_281/model/MovieResponse.dart';
import 'package:dio/dio.dart';
import 'details.dart';
import 'favourite.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  TabController tabController;
  var _PopularMovielist;
  var _Top_RatedMovielist;
  List<Movie> movie_List = [];
  List<Movie> favMovies = [];
  List<int> idList = [];
  DbHelper dbHelper;
  @override
  initState() {
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _PopularMovielist = fetchMovies("popular");
    _Top_RatedMovielist = fetchMovies("top_rated");
    dbHelper = DbHelper();
    dbHelper.createDB();
    getFromDB();
    getMovieById(movie_List,idList);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Movies App",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        actions: [
          FlatButton(onPressed: (){
            showFavourite(favMovies);
          }, child: Text("Favourite", style: TextStyle(color: Colors.black, fontSize: 16),))
        ],
        bottom: PreferredSize(
          preferredSize: Size(0.0, 30.0),
          child: TabBar(
            tabs: [
              Text(
                "Top_Rated",
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              Text(
                "Popular",
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              )
            ],
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: Colors.blueAccent,
              ),
            ),
            controller: tabController,
          ),
        ),
      ),
      body: TabBarView(
        children: [
          movieCard(context, _PopularMovielist),
          movieCard(context, _Top_RatedMovielist),
        ],
        controller: tabController,
      ),
    );
  }

  Future<MovieResponse> fetchMovies(String sortby) async {
    var dio = Dio();
    var response = await dio.get(
        "https://api.themoviedb.org/3/movie/$sortby?api_key=837aa67b269303622a476bbe24283a57");
    if (response != null && response.statusCode == 200) {
      return MovieResponse.fromJson(response.data);
    }
  }

  Widget movieCard(context, var _list_Movie) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FutureBuilder(
        future: _list_Movie,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.data != null && !snapshot.hasError && snapshot.hasData) {
            var results = snapshot.data.results;
            movie_List = toMovies(results);
            //childAspectRatio:.8 hieght /width define child space
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemCount: movie_List.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: .6, color: Colors.black)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200${results[index].posterPath}"),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                )),
                            alignment: Alignment.topRight,
                            child: IconButton(
                                //Data Base operations
                                icon: Icon(
                                  //Condition isfav?t:f => icon shape
                                  idList.contains(movie_List[index].id)
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  ///////////////////////////////////////modify
                                  idList.contains(movie_List[index].id)
                                      ? removeFromDB(movie_List[index])
                                      : addToDB(movie_List[index]);
                                  setState(() {
                                    idList.clear();
                                    getFromDB();
                                  });
                                }),
                          ),
                          //TextOverflow.ellipsis end line with ...
                          Text(
                            results[index].originalTitle,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 5, 10, 5),
                            child: Row(
                              children: [
                                Text(
                                  results[index].voteAverage.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 18,
                                ),
                                Expanded(child: SizedBox()),
                                Text(results[index]
                                    .releaseDate
                                    .toString()
                                    .substring(0, 10))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showDetails(movie_List[index]);
                    },
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  showDetails(Movie movie) {
    getMovieById(movie_List,idList);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Details(),
            settings: RouteSettings(arguments: movie)));
  }
  showFavourite(List<Movie> movies) {
    getMovieById(movie_List,idList);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FavouriteMovies(),
            settings: RouteSettings(arguments: movies)));
  }
  

  addToDB(Movie movie) {
    dbHelper
        .insertMovie(movie)
        .then((value) => print(value > 0 ? "Done add" : "Error"));
  }

  removeFromDB(Movie movie) {
    dbHelper
        .deleteMovie(movie)
        .then((value) => print(value > 0 ? "Done delete" : "Error"));
  }

  getFromDB() {
    dbHelper.getAllMovies().then((value) {
      value.forEach((element) {
        var movie = Movie.fromMap(element);
        idList.add(movie.id);
      });
      print(idList);
      setState(() {
      });
    });
  }
getMovieById(List<Movie> movies,List<int> ids){
  for(int i =0;i < ids.length;i++){
    for(int x=0;x<movies.length;x++){
      if(ids[i] == movies[x].id){
        favMovies.add(movies[x]);
      }
    }
  }
  
}

  List<Movie> toMovies(List<Result> results) {
    List<Movie> movies = [];
    results.forEach((result) {
      Movie movie = Movie(
          result.id,
          result.title,
          result.voteAverage,
          "https://image.tmdb.org/t/p/w200${result.posterPath}",
          result.releaseDate.toString().substring(0, 10),
          result.overview,
          false,
          "https://image.tmdb.org/t/p/w200${result.backdropPath}");
      movies.add(movie);
    });
    return movies;
  }
}