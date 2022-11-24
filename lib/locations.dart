import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  LatLng.fromJson(Map<String, dynamic> json)
  :
    lat = json['lat'],
    lng = json['lng'];
  
  Map<String, dynamic> toJson() => {
      'lat': lat,
      'lng': lng
  };

  final double lat;
  final double lng;
}

class Region {
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  Region.fromJson(Map<String, dynamic> json) :
  coords = json['coords'],
  id = json['id'],
  name = json['name'],
  zoom = json['zoom'];

  Map<String, dynamic> toJson() => {
    'coords': coords,
    'id': id,
    'name': name,
    'zoom': zoom
  };

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

class Office {
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.region,
  });

  Office.fromJson(Map<String, dynamic> json) :
    address = json['address'],
    id = json['id'],
    image = json['image'],
    lat = json['lat'],
    lng = json['lng'],
    name = json['name'],
    phone = json['phone'],
    region = json['region'];

  Map<String, dynamic> toJson() => {
    'address': address,
    'id': id,
    'image': image,
    'lat': lat,
    'lng': lng,
    'name': name,
    'phone': phone,
    'region': region

  };

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}


class Locations {
  Locations({
    required this.offices,
    required this.regions,
  });

  Locations.fromJson(Map<String, dynamic> json) :
  offices = json['offices'],
  regions = json['regions'];

  Map<String, dynamic> toJson() => {
    'offices': offices,
    'regions': regions
  };

  final List<Office> offices;
  final List<Region> regions;
}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  try {
    final response = await http.get(Uri.parse(googleLocationsURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}