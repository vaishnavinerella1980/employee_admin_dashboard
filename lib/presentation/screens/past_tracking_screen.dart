import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PastTrackingScreen extends StatefulWidget {
  @override
  _PastTrackingScreenState createState() => _PastTrackingScreenState();
}

class _PastTrackingScreenState extends State<PastTrackingScreen> {
  GoogleMapController? mapController;

  DateTime? startDate;
  DateTime? endDate;

  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");

  // Example data with timestamps
  final List<Map<String, dynamic>> allRouteData = [
    {
      "lat": 17.385044,
      "lng": 78.486671,
      "time": DateTime(2025, 9, 20, 9, 0),
    },
    {
      "lat": 17.386044,
      "lng": 78.487671,
      "time": DateTime(2025, 9, 20, 10, 0),
    },
    {
      "lat": 17.387044,
      "lng": 78.488671,
      "time": DateTime(2025, 9, 21, 11, 0),
    },
    {
      "lat": 17.388044,
      "lng": 78.489671,
      "time": DateTime(2025, 9, 22, 12, 0),
    },
  ];

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> filteredRoutePoints = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      initialDateRange: DateTimeRange(
        start: startDate ?? DateTime.now().subtract(Duration(days: 1)),
        end: endDate ?? DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  void _filterRoute() {
    if (startDate == null || endDate == null) return;

    setState(() {
      filteredRoutePoints = allRouteData
          .where((point) =>
              point["time"].isAfter(startDate!.subtract(Duration(days: 1))) &&
              point["time"].isBefore(endDate!.add(Duration(days: 1))))
          .map<LatLng>((point) => LatLng(point["lat"], point["lng"]))
          .toList();

      _markers.clear();
      _polylines.clear();

      if (filteredRoutePoints.isNotEmpty) {
        _markers.add(Marker(
          markerId: const MarkerId("start"),
          position: filteredRoutePoints.first,
          infoWindow: const InfoWindow(title: "Start Point"),
        ));

        _markers.add(Marker(
          markerId: const MarkerId("end"),
          position: filteredRoutePoints.last,
          infoWindow: const InfoWindow(title: "End Point"),
        ));

        _polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          points: filteredRoutePoints,
          color: Colors.blue,
          width: 5,
        ));

        // Move camera to first point
        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(filteredRoutePoints.first, 15),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Past Tracking")),
      body: Column(
        children: [
          // 🔹 Date Range Picker UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    startDate != null
                        ? "From: ${_dateFormat.format(startDate!)}"
                        : "Select Start Date",
                  ),
                ),
                Expanded(
                  child: Text(
                    endDate != null
                        ? "To: ${_dateFormat.format(endDate!)}"
                        : "Select End Date",
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () => _pickDateRange(context),
                ),
                ElevatedButton(
                  onPressed: _filterRoute,
                  child: const Text("Filter"),
                )
              ],
            ),
          ),

          // 🔹 Map
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: const LatLng(17.385044, 78.486671),
                zoom: 14.0,
              ),
              markers: _markers,
              polylines: _polylines,
            ),
          ),
        ],
      ),
    );
  }
}
