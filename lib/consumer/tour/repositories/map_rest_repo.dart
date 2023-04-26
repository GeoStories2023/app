import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../../auth/auth_service.dart';
import '../models/tour_data.dart';
import 'i_map_repo.dart';

class MapRestRepo implements IMapRepo {
  @override
  Future<TourData> getTour(String id) async {
    AuthService authService = AuthService();
    print("start get");
    var url = Uri.http(
        "192.168.0.219:80", "api/v1/tours/$id"); // '10.0.2.2:3000/tour/$id
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await authService.currentUser!.getIdToken()}',
    });
    print(response.body);
    var parsedJson = jsonDecode(response.body);
    return TourData.fromJson(parsedJson);
  }
}
