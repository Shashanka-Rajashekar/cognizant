import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(NavigationApp());

class NavigationApp extends StatefulWidget {
  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  GoogleMapController mapController;
  Location location = Location();
  LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await location.hasPermission();
    if (!hasPermission) {
      await location.requestPermission();
    }

    final LocationData current = await location.getLocation();
    setState(() {
      currentLocation = LatLng(current.latitude, current.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Navigation App'),
        ),
        body: Center(
          child: currentLocation == null
              ? CircularProgressIndicator()
              : GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 15.0,
                  ),
                  markers: Set<Marker>.from([
                    Marker(
                      markerId: MarkerId('currentLocation'),
                      position: currentLocation,
                      infoWindow: InfoWindow(title: 'Current Location'),
                    ),
                  ]),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getCurrentLocation,
          tooltip: 'Get Location',
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }
}
