import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<Map> {
  final MapController _mapController = MapController(); // Contrôleur pour les menu de la map
  LatLng? _clickedPosition; 
  List<Marker> _markers = []; 
  bool Musee = true;
  bool Bar = true;
  bool Concert = true; 
  bool CommerceDeNuit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Filters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text('Show Musee'),
              value: Musee,
              onChanged: (bool value) {
                setState(() {
                  Musee = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Bar'),
              value: Bar,
              onChanged: (bool value) {
                setState(() {
                  Bar = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Concert'),
              value: Concert,
              onChanged: (bool value) {
                setState(() {
                  Concert = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Commerce de nuit'),
              value: CommerceDeNuit,
              onChanged: (bool value) {
                setState(() {
                  CommerceDeNuit = value;
                });
              },
            ),
          ],
        ),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(47.216671, -1.55), // Centrer sur Nantes
          zoom: 10.0,
          maxZoom: 18.0,
          minZoom: 3.0,
          onTap: (tapPosition, latlng) {
            setState(() {
              _clickedPosition = latlng; 
              _markers.add(
                Marker(
                  point: latlng,
                  builder: (ctx) => const Icon(Icons.location_on, color: Colors.red, size: 30),
                ),
              );
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: _markers.where((marker) {
              if (Musee && marker.point.latitude > 47.0) {
                return true;
              }
              if (Bar && marker.point.latitude <= 47.0) {
                return true;
              }
              return false;
            }).toList(),
          ),
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
          ),
          if (_clickedPosition != null)
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lat: ${_clickedPosition!.latitude}, Lng: ${_clickedPosition!.longitude}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: _clickedPosition != null
          ? FloatingActionButton.extended(
              onPressed: () {
                _mapController.move(_clickedPosition!, 15.0);
              },
              label: const Text('Zoom to Position'),
              icon: const Icon(Icons.zoom_in),
            )
          : null,
    );
  }
}
