class AppConfig {
  final String doggoBaseApiUrl;

  AppConfig({required this.doggoBaseApiUrl});
}

// This app uses thedogapi.com as a data source, but the http requests are routed through a backend to manage secrets.
// Its possible to replace this url with a direct reference to thedogapi.com but it requires user access to the api from the person
//   who is responsible for the requests.
class DefaultAppConfig extends AppConfig {
  DefaultAppConfig()
      : super(
            doggoBaseApiUrl: "https://nodedogroute-38a170d08520.herokuapp.com");
}

class IntegrationTestConfig extends AppConfig {
  IntegrationTestConfig() : super(doggoBaseApiUrl: "http://localhost:3017");
}
