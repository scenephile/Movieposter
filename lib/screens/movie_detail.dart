import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movies/api/endpoints.dart';
import 'package:movies/constants/api_constants.dart';
import 'package:movies/modal_class/credits.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/screens/widgets.dart';
import 'package:movies/theme/utils.dart';
class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final ThemeData themeData;
  final String heroId;
  final List<Genres> genres;
  MovieDetailPage({this.movie, this.themeData, this.heroId, this.genres});
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: widget.themeData.accentColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Expanded(
                      child: Slider(
                        min: 1,
                        max: 10,
                        value: 1,
                        onChanged: (val){
                          setState(() {
                          });
                      }
                      ),
                    ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Positioned(
                      child: Hero(
                        tag: widget.heroId,
                        child: SizedBox(
                          height: 550,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top:20),
                            child: Container(
                              decoration: BoxDecoration (
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    spreadRadius: 5.0,
                                    blurRadius: 20.0,
                                    offset: Offset(5.0, 5.0), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    spreadRadius: 5,
                                    blurRadius: 20.0,
                                    offset: Offset(-5.0, -5.0), // changes position of shadow
                                  )
                                ],
                              ),
                              child: ClipRRect(

                                borderRadius: BorderRadius.circular(20),
                                child: widget.movie.posterPath == null
                                    ? Image.asset(
                                  'assets/images/na.jpg',
                                  fit: BoxFit.cover,
                                )
                                    : FadeInImage(
                                  image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                      'w500/' +
                                      widget.movie.posterPath),
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage(
                                      'assets/images/loading.gif'),
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),

                    ),

                  ),

                  Text(
                    widget.movie.title,
                    style: widget
                        .themeData.textTheme.headline5,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.yellow,
                      ),
                      Text(
                        widget.movie.voteAverage,
                        style: widget.themeData
                            .textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          widget.movie.releaseDate,
                          style: widget.themeData
                              .textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void modalBottomSheetMenu(Cast cast) {
    // double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            // height: height / 2,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                      padding: const EdgeInsets.only(top: 54),
                      decoration: BoxDecoration(
                          color: widget.themeData.primaryColor,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(16.0),
                              topRight: const Radius.circular(16.0))),
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${cast.name}',
                                    style: widget.themeData.textTheme.bodyText2,
                                  ),
                                  Text(
                                    'as',
                                    style: widget.themeData.textTheme.bodyText2,
                                  ),
                                  Text(
                                    '${cast.character}',
                                    style: widget.themeData.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.themeData.primaryColor,
                            border: Border.all(
                                color: widget.themeData.accentColor, width: 3),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: cast.profilePath == null
                                    ? AssetImage('assets/images/na.jpg')
                                    : NetworkImage(TMDB_BASE_IMAGE_URL +
                                        'w500/' +
                                        cast.profilePath)),
                            shape: BoxShape.circle),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}

