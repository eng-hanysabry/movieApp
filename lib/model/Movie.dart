class Movie{
  int _movieId;
  String _title;
  double _rating;
  String _posterPath;
  String _dateOfRelease;
  bool _isFavourite;
  String _overView;
  String _bgImg;

  Movie(this._movieId,this._title, this._rating, this._posterPath,
      this._dateOfRelease,this._overView,this._isFavourite,this._bgImg);


   //convert from map  to  User object
  Movie.fromMap(Map<String, dynamic> data) {
    _movieId = data['id'];
    
  }

  //convert from User object to Map
  Map<String, dynamic> toMap() {
    return {"id": _movieId};
  }

  get bgImg => _bgImg;

  set bgImg(value) {
    _bgImg = value;
  }  
  get id => _movieId;

  set id(value) {
    _movieId = value;
  }    
  get overView => _overView;

  set overView(value) {
    _overView = value;
  }
  get title => _title;

  set title(value) {
    _title = value;
  }
    get isFavourite => _isFavourite;

  set isFavourite(value) {
    _isFavourite = value;
  }
  get rating => _rating;

  get dateOfRelease => _dateOfRelease;

  set dateOfRelease(value) {
    _dateOfRelease = value;
  }

  get posterPath => _posterPath;

  set posterPath(value) {
    _posterPath = value;
  }

  set rating(value) {
    _rating = value;
  }
}