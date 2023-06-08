import 'dart:convert';

import 'package:geostories/consumer/tour/models/started_tour_data.dart';
import 'package:http/http.dart' as http;
import '../../../auth/auth_service.dart';
import '../models/tour_data.dart';
import 'i_map_repo.dart';

class MapRestRepo implements IMapRepo {
  final String url;

  MapRestRepo(this.url);

  @override
  Future<TourData> getTour(String id) async {
    AuthService authService = AuthService();
    var uri = Uri.parse("$url/api/v1/tours/$id");

    try {
      // '10.0.2.2:3000/tour/$id
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${await authService.currentUser!.getIdToken()}',
      });
      var parsedJson = jsonDecode(response.body);
      return TourData.fromJson(parsedJson);
    } catch (e) {
      throw Exception("Cannot Fetch $e");
    }
  }

  @override
  Future<StartedTour> setTourpointVisited(
      String startedTourId, String tourPointId) async {
    AuthService authService = AuthService();
    var uri = Uri.parse(
        "${url}/api/v1/tours/point/visited/"); // '10.0.2.2:3000/tour/$id
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${await authService.currentUser!.getIdToken()}',
      },
      body: jsonEncode(
          {'startedTourId': startedTourId, 'tourPointId': tourPointId}),
    );
    var parsedJson = jsonDecode(response.body);
    return StartedTour.fromJson(parsedJson);
  }

  @override
  Future<StartedTour> startTour(String id) async {
    AuthService authService = AuthService();
    var uri = Uri.parse("$url/api/v1/tours/start"); // '10.0.2.2:3000/tour/$id
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${await authService.currentUser!.getIdToken()}',
      },
      body: jsonEncode({'tourId': id}),
    );

    var parsedJson = jsonDecode(response.body);
    return StartedTour.fromJson(parsedJson);
  }

  @override
  Future<StartedTour> getStartedTour(String id) async {
    AuthService authService = AuthService();
    var uri = Uri.parse("$url/api/v1/tours/started/$id");
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${await authService.currentUser!.getIdToken()}',
      },
    );
    var parsedJson = jsonDecode(response.body);
    return StartedTour.fromJson(parsedJson);
  }

  @override
  Future<List<StartedTour>> getStartedTours() async {
    AuthService authService = AuthService();
    var uri = Uri.parse("$url/api/v1/tours/started");
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${await authService.currentUser!.getIdToken()}',
      },
    );
    var parsedJson = (jsonDecode(response.body) as List);
    List<StartedTour> result = [];
    for (var startedTour in parsedJson) {
      result.add(StartedTour.fromJson(startedTour));
    }
    return result;
  }
}
