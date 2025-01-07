import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lab_4/models/exam.dart';
import 'package:lab_4/screens/home/direction_screen.dart';
import 'package:lab_4/services/location_service.dart';
import 'package:latlong2/latlong.dart';

class DetailsExam extends StatelessWidget {
  const DetailsExam({super.key});

  @override
  Widget build(BuildContext context) {
    final Exam event = ModalRoute.of(context)!.settings.arguments as Exam;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(event.title),
              subtitle: Text(
                  'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(event.dateTime)}'),
            ),
            ListTile(
              title: Text(
                  'Location: ${event.location?.latitude} : ${event.location?.longitude}'),
            ),
            SizedBox(
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                      event.location!.latitude, event.location!.longitude),
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(event.location!.latitude,
                            event.location!.longitude),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Calculating shortest route...')),
                );
                final position = await LocationHandler.getCurrentPosition();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DirectionsScreen(
                      destination: event.location!,
                      current: LatLng(position!.latitude, position.longitude),
                    ),
                  ),
                );
              },
              child: const Text('Navigate'),
            ),
          ],
        ),
      ),
    );
  }
}
