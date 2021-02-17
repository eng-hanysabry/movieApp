import 'package:flutter/material.dart';
import 'package:flutter_application_281/screens/home.dart';
import '../db/DbHelper.dart';
import 'details.dart';
import '../model/Movie.dart';

class FavouriteMovies extends StatefulWidget {

  @override
  _FavouriteMoviesState createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  DbHelper dbHelper;
  List<Movie> movie_List=[];
  @override
  void initState() {
    // TODO: implement initState
    dbHelper=DbHelper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    movie_List = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp(),));
      }),
      ),
      body: movieCard(context, movie_List),      
    );
  }
  
  Widget movieCard(context, List<Movie> _list_Movie) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemCount: _list_Movie.length,
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
                                      "${_list_Movie[index].posterPath}"),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                )),
                            alignment: Alignment.topRight,
                            child: IconButton(
                                //Data Base operations
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  ///////////////////////////////////////modify
                                  
                                removeFromDB(_list_Movie[index]);
                                _list_Movie.removeAt(index);
                                  setState(() {
                                    
                                  });
                                }),
                          ),
                          //TextOverflow.ellipsis end line with ...
                          Text(
                            _list_Movie[index].title,
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
                                  _list_Movie[index].rating.toString(),
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
                                Text(_list_Movie[index]
                                    .dateOfRelease
                                    .toString()
                                    .substring(0, 10))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showDetails(_list_Movie[index]);
                    },
                  );
                }));
    
  }
    removeFromDB(Movie movie) {

    dbHelper
        .deleteMovie(movie)
        .then((value) => print(value > 0 ? "Done delete" : "Error"));
  }
  showDetails(Movie movie) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Details(),
            settings: RouteSettings(arguments: movie)));
  }
}