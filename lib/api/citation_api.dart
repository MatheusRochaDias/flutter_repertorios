import 'package:dio/dio.dart';
import '../models/citationResponse.dart';

class CitationApiServices {
  final String _url = "https://citai.herokuapp.com/";
  Dio _dio;

   CitationApiServices() {
    _dio = Dio();
  }

  // ignore: missing_return
  Future<List<Result>> fetchCitationServices() async {
    try {
      Response response = await _dio.get(_url + 'citations');
      CitationResponse citationResponse = CitationResponse.fromJson(response.data);
      return citationResponse.results;
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
