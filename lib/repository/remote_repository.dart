import 'package:api_byteplex/data/message_class.dart';
import 'package:dio/dio.dart';

class RemoteRepository {
  final String _apiPoint = 'https://api.byteplex.info/api/test/contact/';
  final _dio = Dio();

  Future<bool> postToRepo(MessageClass message) async {
    final Map<String, dynamic> data = message.toJson();
    final Response response = await _dio.post(_apiPoint, data: data);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
