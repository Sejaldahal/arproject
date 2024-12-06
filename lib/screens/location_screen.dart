// import 'package:flutter/material.dart';
// import 'package:galli_map/galli_map.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   late GalliController _controller;

//   final TextEditingController _searchController = TextEditingController();
//   final LatLng _startPoint = LatLng(27.7128, 85.3240); // Example: Kathmandu
//   LatLng? _destinationPoint;
//   List<LatLng> _routeCoordinates = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller = GalliController(
//       authKey: "805e896e-209f-44a2-8a1d-28e8847dcdf4", // Use the provided token
//       initialPosition: _startPoint,
//       zoom: 14,
//     );
//   }

//   Future<void> _fetchRoute(String destinationName) async {
//     try {
//       // Step 1: Geocode destination using Galli Map API
//       LatLng? destination = await _geocodeLocation(destinationName);
//       if (destination == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location not found!')),
//         );
//         return;
//       }
//       setState(() {
//         _destinationPoint = destination;
//       });

//       // Step 2: Fetch route from startPoint to destination using Galli Map API
//       List<LatLng> route = await _getRoute(_startPoint, destination);
//       setState(() {
//         _routeCoordinates = route;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching route: $e')),
//       );
//     }
//   }

//   Future<LatLng?> _geocodeLocation(String locationName) async {
//     // Use Galli Map API's geocoding endpoint to get coordinates
//     // For now, return dummy coordinates for demonstration
//     if (locationName.toLowerCase() == "kathmandu durbar square") {
//       return LatLng(27.671063090320615, 85.43918926701888); // Example: Kathmandu Durbar Square
//     }
//     return null;
//   }

//   Future<List<LatLng>> _getRoute(LatLng start, LatLng destination) async {
//     // Use Galli Map API to fetch the route
//     // For now, return a dummy route for demonstration
//     return [
//       start,
//       LatLng((start.latitude + destination.latitude) / 2, (start.longitude + destination.longitude) / 2),
//       destination,
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location Screen'),
//         backgroundColor: const Color(0xFF8B4513),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for a location',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     _fetchRoute(_searchController.text);
//                   },
//                 ),
//                 filled: true,
//                 fillColor: Colors.white.withOpacity(0.9),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GalliMap(
//               controller: _controller,
//               onTap: (tapPosition) {
//                 print("Tapped at: ${tapPosition.latitude}, ${tapPosition.longitude}");
//               },
//               markers: [
//                 // Marker for the start point
//                 GalliMarker(
//                   latlng: _startPoint,
//                   markerWidget: const Icon(
//                     Icons.my_location,
//                     color: Colors.blue,
//                     size: 30,
//                   ),
//                 ),
//                 // Marker for the destination
//                 if (_destinationPoint != null)
//                   GalliMarker(
//                     latlng: _destinationPoint!,
//                     markerWidget: const Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                       size: 30,
//                     ),
//                   ),
//               ],
//               lines: [
//                 if (_routeCoordinates.isNotEmpty)
//                   GalliLine(
//                     line: _routeCoordinates,
//                     borderColor: Colors.blue,
//                     borderStroke: 2,
//                     lineColor: Colors.blueAccent,
//                     lineStroke: 4,
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:galli_map/galli_map.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the GalliController
    final GalliController controller = GalliController(
      authKey: "e0db6968-0dfb-485c-8fab-f896ebd7bd1e",
      initialPosition: LatLng(27.12441, 67.12412),
      zoom: 16, // Optional initial position
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Screen'),
      ),
      body: GalliMap(
        controller: controller,
        onTap: (tap) {
          // Handle map tap if needed
          print("Tapped at: ${tap.latitude}, ${tap.longitude}");
        },
        lines: [
          GalliLine(
            line: [
              LatLng(27.12441, 67.12412),
              LatLng(27.12500, 67.12500),
            ],
            borderColor: Colors.blue,
            borderStroke: 1,
            lineColor: Colors.white,
            lineStroke: 2,
          ),
        ],
        polygons: [
          GalliPolygon(
            polygon: [
              LatLng(27.12441, 67.12412),
              LatLng(27.12500, 67.12500),
              LatLng(27.12600, 67.12600),
            ],
            borderColor: Colors.red,
            borderStroke: 2,
            color: Colors.green,
          ),
        ],
        markers: [
          GalliMarker(
            latlng: LatLng(27.12441, 67.12412),
            markerWidget: const Icon(Icons.location_city),
          ),
        ],
      ),
    );
  }
}