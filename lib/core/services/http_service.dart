import 'package:http/http.dart' as http;

class HttpService {
  final http.Client client;

  HttpService(this.client);

  Future<http.Response> post(
    String url, {
    required Map<String, String> headers,
    required Object body,
  }) async {
    return client.post(Uri.parse(url), headers: headers, body: body);
  }
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return client.get(Uri.parse(url), headers: headers);
  }
}
