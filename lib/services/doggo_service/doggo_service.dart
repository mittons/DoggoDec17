import 'dart:convert';

import 'package:doggo_dec_17/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_17/services/service_result.dart';
import 'package:doggo_dec_17/utils/service_locator.dart' as srv_loc;
import 'package:http/http.dart' as http;

class DoggoService {
  final String baseDoggoApiUrl;

  DoggoService({required this.baseDoggoApiUrl});

  http.Client _getHttpClient() {
    return srv_loc.serviceLocator<http.Client>();
  }

  String _generateRequestUrl(String endpointRoute) {
    return "$baseDoggoApiUrl$endpointRoute";
  }

  Future<ServiceResult<List<DoggoBreed>?>> getDoggoBreeds() async {
    late final http.Response response;
    try {
      response =
          await _getHttpClient().get(Uri.parse(_generateRequestUrl("/breeds")));
    } catch (e) {
      print("Error fetching data from service: $e");
      return ServiceResult(data: null, success: false);
    }

    if (response.statusCode != 200) {
      print("Invalid http status code: ${response.statusCode}");
      return ServiceResult(data: null, success: false);
    }

    try {
      var jsonResponse = jsonDecode(response.body);

      List<DoggoBreed> doggoBreeds = (jsonResponse as List)
          .map((breedJson) => DoggoBreed.fromJson(breedJson))
          .toList();

      return ServiceResult(data: doggoBreeds, success: true);
    } catch (e) {
      print("Error parsing json from service response");
      return ServiceResult(data: null, success: false);
    }
  }
}
