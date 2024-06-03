// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class MapPage extends StatefulWidget {
//   final Position initialPosition;
//
//   MapPage({required this.initialPosition});
//
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;
//   late LatLng _center;
//
//   @override
//   void initState() {
//     super.initState();
//     _center = LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude);
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('currentLocation'),
//             position: _center,
//           ),
//         },
//       ),
//     );
//   }
// }
