import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHttp {
  var _dio;

  AppHttp() {
    _dio = Dio();
  }

  AppHttp.withAuth() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onRespose, onError: _onError));
  }

  Dio get instance => _dio;

  _onRequest(RequestOptions options, handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    options.headers['Authorization'] = token ?? 'none';
    return handler.next(options); //continue
  }

  _onError(DioError e, handler) {
    return handler.next(e); //continue
  }

  _onRespose(Response response, handler) {
    // print('>>>>>>>> http response ');
    // print(response.data);
    print('>>>>>>>> http response ok ');
    return handler.next(response);
  }
}
