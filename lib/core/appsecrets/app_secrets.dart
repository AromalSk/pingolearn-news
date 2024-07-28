class AppSecrets {
  static const apiKey = 'AIzaSyDIRXhDBvWzKXgRclez7UOpBNm8soXFIkg';
  static const appId = '1:906355889808:android:016c28030f67bc7f6b6a15';
  static const messagingSenderId = 'sendid';
  static const projectId = 'pingolearn-4061a';
  static const storageBucket = 'pingolearn-4061a.appspot.com';
  static const String _baseUrl = "https://newsapi.org/v2/top-headlines";
  static const String _apiKey = "cc2fda71ad0d4d12aabba69caec8cee2";

  static String getUrl({required String countryCode}) {
    return "$_baseUrl?country=$countryCode&apiKey=$_apiKey";
  }
}
