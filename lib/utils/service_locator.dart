import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
}
