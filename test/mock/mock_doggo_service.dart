import 'package:doggo_dec_17/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_17/services/doggo_service/doggo_service.dart';
import 'package:doggo_dec_17/services/service_result.dart';

class MockDoggoService extends DoggoService {
  // We can set the base api url to "" as this mock service doesnt perform any http calls
  // - it simply mocks the outputs of the actual service layer that interacts with external services through http
  MockDoggoService() : super(baseDoggoApiUrl: "");

  @override
  Future<ServiceResult<List<DoggoBreed>?>> getDoggoBreeds() async {
    List<DoggoBreed> doggoBreeds = [1, 2, 3, 4, 5]
        .map((idx) => DoggoBreed(
            id: idx,
            name: "Breed $idx",
            weight: "10 - 2$idx",
            height: "1 - $idx",
            lifeSpan: "10 - 2$idx",
            referenceImageId: "referenceImageId$idx"))
        .toList();
    return ServiceResult(data: doggoBreeds, success: true);
  }
}
