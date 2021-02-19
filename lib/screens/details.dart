import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_281/screens/home.dart';
import '../model/Movie.dart';

class Details extends StatefulWidget {
  // Movie movie;
  //   Details({Key key, @required this.movie}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
        double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              }),
        ),
        body: Stack(
          children: [
            forG(movie),
            backG(movie),
          ],
        ));
  }

  Widget backG(Movie movie) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("${movie.bgImg}"),
            fit: BoxFit.fill,
          ),
        ));
  }

  Widget forG(Movie movie) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 70,
                          child: Image.network(
                            "${movie.posterPath}",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "OverView : ",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      movie.overView,
                      style: TextStyle(fontSize: 16),
                    ),
                    flex: 2,
                  )
                ],
              )),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rating : "),
              Text(
                movie.rating.toString(),
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
              Text("Release Date : "),
              Text(movie.dateOfRelease.toString().substring(0, 10))
            ],
          ),
          Container(
            height: 500,
            child: Text("Crew Data"),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
