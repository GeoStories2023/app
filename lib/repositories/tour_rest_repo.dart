import 'dart:convert';
import 'package:geostories/consumer/tour/models/tour_info.dart';
import 'package:geostories/repositories/i_tour_repo.dart';
import 'package:http/http.dart' as http;

import '../auth/auth_service.dart';

class TourRestRepo extends ITourRepo {
  final String url;
  final String _allEndpoint = '/tours';
  final String _startedEndpoint = '/tours/started';
  final String _locationEndpoint =
      '/tours/path/name'; // /:continentName:/:countryName?:/:cityName?:

  TourRestRepo(this.url);

  @override
  Future<List<TourInfo>> getTours() async {
    var uri = Uri.parse(url + _allEndpoint);
    var auth = await AuthService().currentUser!.getIdToken();
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth'
    });
    if (response.statusCode == 200) {
      var toursJson = jsonDecode(response.body);
      List<TourInfo> tours = [];
      for (var element in toursJson) {
        tours.add(TourInfo.fromJson(element));
      }
      return tours;
    } else {
      throw Exception('Failed to load tours');
    }
  }

  @override
  Future<List<TourInfo>> getStarted() async {
    var uri = Uri.parse(url + _startedEndpoint);
    var auth = await AuthService().currentUser!.getIdToken();
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth'
    });
    if (response.statusCode == 200) {
      var toursJson = jsonDecode(response.body) ?? [];
      List<TourInfo> tours = [];
      for (var element in toursJson) {
        tours.add(TourInfo.fromJson(element));
      }
      return tours;
    } else {
      throw Exception('Failed to load started tours');
    }
  }

  @override
  Future<List<TourInfo>> getToursForLocation(
    String continent, {
    String? country,
    String? city,
  }) async {
    var tmpUri = "$url$_locationEndpoint/$continent";
    if (country != null) {
      tmpUri += "/$country";
      if (city != null) {
        tmpUri += "/$city";
      }
    }
    var uri = Uri.parse(tmpUri);
    var auth = await AuthService().currentUser!.getIdToken();
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth'
    });
    if (response.statusCode == 200) {
      var toursJson = jsonDecode(response.body);
      List<TourInfo> tours = [];
      for (var element in toursJson) {
        tours.add(TourInfo.fromJson(element));
      }
      return tours;
    } else {
      throw Exception('Failed to load tours for $continent $country $city');
    }
  }
}
