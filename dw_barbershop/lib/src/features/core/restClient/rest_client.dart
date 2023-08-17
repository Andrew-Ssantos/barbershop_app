import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final class RestClient extends DioForNative {
  RestClient() : super(BaseOptions(baseUrl: 'http://'));
}
