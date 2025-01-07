import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class DirectionsScreen extends StatefulWidget {
  final LatLng destination;
  final LatLng current;
  const DirectionsScreen(
      {super.key, required this.destination, required this.current});

  @override
  State<DirectionsScreen> createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen> {
  List<LatLng> _route = [];
  @override
  void initState() {
    super.initState();
    _getDirections();
  }

  Future<void> _getDirections() async {
    final response = await http.get(Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/${widget.current.longitude},${widget.current.latitude};${widget.destination.longitude},${widget.destination.latitude}?overview=full&steps=true'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final encodedPolyLine = data['routes'][0]['geometry'];

      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> points = polylinePoints.decodePolyline(encodedPolyLine);

      setState(() {
        _route = points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    } else {
      throw Exception('Failed to load directions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Directions')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(widget.current.latitude, widget.current.longitude),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _route,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point:
                    LatLng(widget.current.latitude, widget.current.longitude),
                child: const Icon(Icons.location_on, color: Colors.green),
              ),
              Marker(
                point: LatLng(
                    widget.destination.latitude, widget.destination.longitude),
                child: const Icon(Icons.location_on, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
