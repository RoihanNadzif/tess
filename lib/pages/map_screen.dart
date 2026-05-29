import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _tampilkanPesan(String kata) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(kata)));
  }

  final MapController _mapController = MapController();
  LatLng _defaultPosition = const LatLng(-8.1688, 113.67);

  final List<Marker> _marker = [];

  List<Map<String, dynamic>> daftarLokasi = [
    {'nama': 'Unej', 'lat': -8.164444, 'lng': 113.718361},
    {'nama': 'Alun-alun Jember', 'lat': -8.1689, 'lng': 113.7022},
  ];

  List<Marker> _buatSeluruhMarker() {
    final objekMarker = daftarLokasi.map((lokasi) {
      return Marker(
        point: LatLng(lokasi['lat'], lokasi['lng']),
        child: Column(
          children: [
            const Icon(Icons.place, size: 60, color: Colors.red),
            Text(
              lokasi['nama']!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      );
    }).toList();
    return objekMarker;
  }

  Future<void> _dapatkanLokasi() async {
    final bool serviceAktif = await Geolocator.isLocationServiceEnabled();
    if (!serviceAktif) {
      _tampilkanPesan(
        "Layanan lokasi tidak aktif. Silakan aktifkan layanan lokasi.",
      );
    }

    LocationPermission izin = await Geolocator.checkPermission();
    if (izin == LocationPermission.denied) {
      izin = await Geolocator.requestPermission();
    }
    if (izin == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    await Geolocator.requestPermission();

    Position pos = await Geolocator.getCurrentPosition();

    LatLng _koordinatSaatini = LatLng(pos.latitude, pos.longitude);

    setState(() {
      _defaultPosition = _koordinatSaatini;
      _marker.clear();
      _marker.add(
        Marker(
          point: _koordinatSaatini,
          child: const Icon(Icons.location_on, size: 40, color: Colors.red),
        ),
      );
      _mapController.move(_koordinatSaatini, 15.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ini Halaman Map")),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(initialCenter: _defaultPosition, initialZoom: 12.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: _buatSeluruhMarker()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _dapatkanLokasi,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
