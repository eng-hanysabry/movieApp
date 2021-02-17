/* 
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController mLonController=TextEditingController();
  TextEditingController mLatController=TextEditingController();
  TextEditingController eastController=TextEditingController();
  TextEditingController westController=TextEditingController();
  TextEditingController northController=TextEditingController();
  TextEditingController southController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  final _coFormKey=GlobalKey<FormState>();
  final _scaffoldKey=GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,backgroundColor: Colors.white,body: SingleChildScrollView(
      child:Form(key: _formKey,child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 35,),
          //AppButton(context, "test", () { }, false,colors: [Colors.white,Colors.black],textColor: Colors.black,width:MediaQuery.of(context).size.width),
          CoordinatesForm(),
          SizedBox(height: 10,),
          AppButton(context, "ابحث", () {test(_coFormKey); }, false,colors: [Colors.white,Colors.white],textColor: Colors.black,width: MediaQuery.of(context).size.width),
          SizedBox(height: 10,),
          AppCard(context, 200, false,textColor: Colors.amber,
          child: GoogleMap(onMapCreated: _onMapCreated,initialCameraPosition: CameraPosition(target: _center,
            zoom: 11.0,))),
          SizedBox(height: 10,),
          AppLabel(context, eastController, false, "East",colors: [Colors.white,Colors.white],textColor: Colors.black),
          SizedBox(height: 10,),
          AppLabel(context, westController, false, "West",colors: [Colors.white,Colors.white],textColor: Colors.black),
          SizedBox(height: 10,),
          AppLabel(context, northController, false, "North",colors: [Colors.white,Colors.white],textColor: Colors.black),
          SizedBox(height: 10,),
          AppLabel(context, southController, false, "South",colors: [Colors.white,Colors.white],textColor: Colors.black),
          SizedBox(height: 10,),
          AppButton(context, "حفظ", () { test(_coFormKey);test(_formKey);}, false,colors: [Colors.white,Colors.white],textColor: Colors.black,width: MediaQuery.of(context).size.width),
          SizedBox(height: 10,),
        ],
      ) ,),
      
    ),);
  }
  Widget CoordinatesForm(){
    return Form(key:_coFormKey ,child: Column(children: [
      AppField(context, "Longitude : ", mLonController, false,colors: [Colors.white,Colors.white],textColor: Colors.black),
      SizedBox(height: 10,), 
      AppField(context, "Latitude : ", mLatController, false,colors: [Colors.white,Colors.white],textColor: Colors.black),
    ],));
  }
  
  Widget AppButton(
    BuildContext context, String textTitle, VoidCallback onPressed, bool isFlat,
    {List<Color> colors, Color textColor,double width}) {
  return Card(
    //margin cause 
    margin: EdgeInsets.symmetric(horizontal: 25),
    shape: isFlat
        ? null
        : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    elevation: isFlat ? 0 : 4,
    child: Container(
      //alignmet cause btn wrap not fill widget
      //alignment: Alignment.center,
      width:width ,
      decoration: isFlat
          ? null
          : BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(30)),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 8),
        onPressed: onPressed,
        child: Text(
          textTitle,style: TextStyle(fontSize: 18, color: textColor ?? null),
          //style: SimpleTextStyle(fontSize: 18, color: textColor ?? null),
        ),
        color: Colors.transparent,
      ),
    ),
  );
}
 
  Widget AppField(
    BuildContext context, String hint, TextEditingController mController, bool isFlat,
    {List<Color> colors, Color textColor,double margin}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: margin??25),
    shape: isFlat
        ? null
        : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //elevation: isFlat ? 0 : 4,
    child: Container(
      alignment: Alignment.center,
      //width: MediaQuery.of(context).size.width,
      decoration: isFlat
          ? null
          : BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        controller: mController,
        decoration: InputDecoration(
                  hintText: hint,//tr(LocaleKeys.report),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),validator: (txt){if(txt.isEmpty){
                        return "Field required";
                      }else{
                        return null;
                      }},
      ),
    ),
  );
}
  
  Widget AppCard(
    BuildContext context, double height, bool isFlat,
    { Color textColor,Widget child}) {
  return Card(
    //margin cause 
    margin: EdgeInsets.symmetric(horizontal: 5),
    shape: isFlat
        ? null
        : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    elevation: isFlat ? 0 : 4,
    child: Container(
      height: height,
      
      //alignmet cause btn wrap not fill widget
      //alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: isFlat
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),color: textColor,),
      child:child ,
    ),
  );
}
  
  Widget AppLabel( BuildContext context, TextEditingController mController, bool isFlat,String text,
    {List<Color> colors, Color textColor} ){
  return ListTile(
    title: AppField(context,"", mController, false,colors: [Colors.white,Colors.white],textColor: Colors.black,margin: 0),
    trailing: Container(
      width: 50,
      height: 30,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Text(text,style: TextStyle(fontSize: 18),),
    ),
  );
}
  
  bool test(GlobalKey<FormState> key){
  if (key.currentState.validate()) {
      // If the form is valid, display a Snackbar.
     _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
     return true;
  }
  else{
    return false;
  }
}
  

} */