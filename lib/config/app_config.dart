class AppConfig {
  final String doggoBaseApiUrl;

  AppConfig({required this.doggoBaseApiUrl});
}

class DefaultAppConfig extends AppConfig {
  DefaultAppConfig() : super(doggoBaseApiUrl: "https://api.thedogapi.com/v1");
}

class IntegrationTestConfig extends AppConfig {
  IntegrationTestConfig() : super(doggoBaseApiUrl: "http://localhost:8017");
}
