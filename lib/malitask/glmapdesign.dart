import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController mLonController = TextEditingController();
  TextEditingController mLatController = TextEditingController();
  TextEditingController eastController = TextEditingController();
  TextEditingController westController = TextEditingController();
  TextEditingController northController = TextEditingController();
  TextEditingController southController = TextEditingController();
  final _direcformKey = GlobalKey<FormState>();
  final _coFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  CameraPosition cameraPosition;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  var markers = HashSet<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraPosition = CameraPosition(
      target: _center,
      zoom: 11.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  onTap: (latlong) {

                    setState(() {
                      if(markers.isEmpty){
                      
                      markers.add(
                          Marker(markerId: MarkerId("1"), position: latlong));
                    
                    }else{
                      markers.clear();
                      markers.add(
                      Marker(markerId: MarkerId("1"), position: latlong));


                    }
                      mLonController.text=latlong.latitude.toString();
                      mLatController.text=latlong.longitude.toString();
                                                              
                    });
                    
                    
                  },
                  onCameraMove: (e) {
                    setState(() {
                      cameraPosition = e;
                    });
                  },
                  markers: markers,
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    child: CoordinatesForm(),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Container(
                    child: DirectionsForm(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CoordinatesForm() {
    return Form(
        key: _coFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            
                 AppField(
                      context, "Longitude : ", mLonController, false,
                      colors: [Colors.white, Colors.white],
                      textColor: Colors.black,
                      margin: 25,
                      isvalid: true),
                SizedBox(
              height: 10,
            ),
                 AppField(context, "Latitude : ", mLatController, false,
                      colors: [Colors.white, Colors.white],
                      textColor: Colors.black,
                      margin: 25,
                      isvalid: true),
            SizedBox(
              height: 10,
            ),
            AppButton(context, "ابحث", () {
              test(_coFormKey);
            }, false,
                colors: [Colors.white, Colors.white], textColor: Colors.black),
          ],
        ));
  }

  Widget DirectionsForm() {
    return Form(
        key: _direcformKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppField(context, "East : ", eastController, false,
                      colors: [Colors.white, Colors.white],
                      textColor: Colors.black,
                      margin: 5,
                      isvalid: true),
                ),
                Expanded(
                  flex: 1,
                  child: AppField(context, "West : ", westController, false,
                      colors: [Colors.white, Colors.white],
                      textColor: Colors.black,
                      margin: 5,
                      isvalid: true),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppField(context, "North : ", northController, false,
                      colors: [Colors.white, Colors.white],
                      textColor: Colors.black,
                      margin: 5,
                      isvalid: true),
                ),
                Expanded(
                  flex: 1,
                  child: AppField(context, "South : ", southController, false,
                      colors: [Colors.white, Colors.white],
                      textColor: Colors.black,
                      margin: 5,
                      isvalid: true),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AppButton(context, "حفظ", () {
              test(_direcformKey);
            }, false,
                colors: [Colors.white, Colors.white],
                textColor: Colors.black,
                width: MediaQuery.of(context).size.width,
                margin: 25),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget AppButton(BuildContext context, String textTitle,
      VoidCallback onPressed, bool isFlat,
      {List<Color> colors, Color textColor, double width, double margin}) {
    return Card(
      //margin cause
      margin: EdgeInsets.symmetric(horizontal: margin ?? 5),
      shape: isFlat
          ? null
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: isFlat ? 0 : 4,
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        //alignmet cause btn wrap not fill widget
        //alignment: Alignment.center,
        width: width,
        decoration: isFlat
            ? null
            : BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(30)),
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(vertical: 2),
          onPressed: onPressed,
          child: Text(
            textTitle, style: TextStyle(fontSize: 16, color: textColor ?? null),
            //style: SimpleTextStyle(fontSize: 18, color: textColor ?? null),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  Widget AppField(BuildContext context, String hint,
      TextEditingController mController, bool isFlat,
      {List<Color> colors, Color textColor, double margin, bool isvalid}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: margin ?? 25),
      shape: isFlat
          ? null
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //elevation: isFlat ? 0 : 4,
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        alignment: Alignment.center,
        //width: MediaQuery.of(context).size.width,
        decoration: isFlat
            ? null
            : BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          maxLines: 1,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          controller: mController,
          decoration: InputDecoration(
            
              hintText: hint, //tr(LocaleKeys.report),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          validator: (txt) {
            if (txt.isEmpty) {
              return "Field required";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget AppCard(BuildContext context, double height, bool isFlat,
      {Color textColor, Widget child}) {
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
                borderRadius: BorderRadius.circular(15),
                color: textColor,
              ),
        child: child,
      ),
    );
  }

/*  Widget AppLabel(BuildContext context, TextEditingController mController,
       bool isFlat, String text,
      {List<Color> colors, Color textColor}) {
    return ListTile(
      title: AppField(context, "", mController, false,
          colors: [Colors.white, Colors.white],
          textColor: Colors.black,
          margin: 0),
      trailing: Container(
        width: 50,
        height: 30,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  } */

  bool test(GlobalKey<FormState> key) {
    if (key.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      return true;
    } else {
      return false;
    }
  }
}
