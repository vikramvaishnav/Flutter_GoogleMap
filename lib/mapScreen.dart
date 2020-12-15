import 'package:eatoz_map/provider/map_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _myMapController;
  final Set<Marker> _markers = {};

  // Object for PolylinePoints
  PolylinePoints polylinePoints;

  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  void _onMapCreated(GoogleMapController controller) {
    _myMapController = controller;
  }

  _createPolylines(List<double> start, List<double> destination) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyD7qRdEvblL4lRE5KQv9X8QxD_Up0ZabBc", // Google Maps API Key
      PointLatLng(start[0], start[1]),
      PointLatLng(destination[0], destination[1]),
      travelMode: TravelMode.transit,
    );
// Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 3,
    );
    // Adding the polyline to the map
    polylines[id] = polyline;
    // return polylines.values;
  }

  void _onNavigateButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    var mapDataProvider = Provider.of<MapDataProvider>(context);
    LatLng _center = LatLng(mapDataProvider.src[0], mapDataProvider.src[1]);

    Set<Marker> _addMarkers() {
      _markers.add(
        Marker(
            markerId: MarkerId('Source'),
            draggable: false,
            position: LatLng(mapDataProvider.src[0], mapDataProvider.src[1])),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('Destination'),
            draggable: false,
            position: LatLng(mapDataProvider.dest[0], mapDataProvider.dest[1])),
      );
      _createPolylines(mapDataProvider.src, mapDataProvider.dest);
      return _markers;
    }

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              mapToolbarEnabled: false, // To remove direction toolbar
              markers: _addMarkers(),
              polylines: Set<Polyline>.of(polylines.values),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _onNavigateButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.directions, size: 30.0),
                ),
              ),
            ),
          ],
        ));
  }
}
