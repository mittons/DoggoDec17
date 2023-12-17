import 'package:doggo_dec_17/services/doggo_service/doggo_service.dart';
import 'package:doggo_dec_17/services/service_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doggo_dec_17/utils/service_locator.dart' as srv_loc;
import 'package:http/http.dart' as http;

import '../mock/mock_http_client_factory.dart';

void main() {
  group('When Doggo Service', () {
    tearDown(() {
      srv_loc.serviceLocator.unregister<http.Client>();
    });

    group('operates on happy paths', () {
      test(
          'getBreeds function returns a ServiceResult object with success set as true',
          () async {
        // Set up services and external resources to the function/class being tested can function
        // - mock http client that response 200 & service body
        srv_loc.serviceLocator.registerSingleton<http.Client>(
            MockHttpClientFactory.get200Client(_getValidDogBreedJson()));

        // Create an instance of the class (if required)
        DoggoService doggoService = DoggoService(baseDoggoApiUrl: "");

        // Test functionality
        ServiceResult doggoBreedsResult = await doggoService.getDoggoBreeds();

        expect(doggoBreedsResult.success, true);
      });
    });

    group(
        'deals with invalid json formatting in the external service response body',
        () {
      test('getBreeds function handles invalid json formatting', () async {
        _testErrorClient(
            MockHttpClientFactory.get200Client(_getInvalidDogBreedJson()));
      });
    });

    group('deals with errors and exceptions', () {
      test('HttpException handling delivers an unsuccessful result', () async {
        _testErrorClient(MockHttpClientFactory.getHttpExceptionClient());
      });

      test('TimeoutExecption handling delivers an unsuccessful result',
          () async {
        _testErrorClient(MockHttpClientFactory.getTimeoutExceptionClient());
      });

      test('WebSocketException handling delivers an unsuccessful result',
          () async {
        _testErrorClient(MockHttpClientFactory.getWebSocketExceptionClient());
      });
    });
  });
}

Future<void> _testErrorClient(http.Client mockClient) async {
  // Set up services and external resources to the function/class being tested can function
  srv_loc.serviceLocator.registerSingleton<http.Client>(mockClient);

  // Create an instance of the class (if required)
  DoggoService doggoService = DoggoService(baseDoggoApiUrl: "");

  // Test functionality
  ServiceResult doggoBreedsResult = await doggoService.getDoggoBreeds();

  expect(doggoBreedsResult.success, false);
}

String _getValidDogBreedJson() {
  return """[{"weight":{"imperial":"6 - 13","metric":"3 - 6"},"height":{"imperial":"9 - 11.5","metric":"23 - 29"},"id":1,"name":"Affenpinscher","bred_for":"Small rodent hunting, lapdog","breed_group":"Toy","life_span":"10 - 12 years","temperament":"Stubborn, Curious, Playful, Adventurous, Active, Fun-loving","origin":"Germany, France","reference_image_id":"BJa4kxc4X"},{"weight":{"imperial":"50 - 60","metric":"23 - 27"},"height":{"imperial":"25 - 27","metric":"64 - 69"},"id":2,"name":"Afghan Hound","country_code":"AG","bred_for":"Coursing and hunting","breed_group":"Hound","life_span":"10 - 13 years","temperament":"Aloof, Clownish, Dignified, Independent, Happy","origin":"Afghanistan, Iran, Pakistan","reference_image_id":"hMyT4CDXR"},{"weight":{"imperial":"44 - 66","metric":"20 - 30"},"height":{"imperial":"30","metric":"76"},"id":3,"name":"African Hunting Dog","bred_for":"A wild pack animal","life_span":"11 years","temperament":"Wild, Hardworking, Dutiful","reference_image_id":"rkiByec47"}]
  """;
}

String _getInvalidDogBreedJson() {
  return "!@#asdlkfj";
}
