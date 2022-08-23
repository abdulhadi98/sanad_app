import 'package:dio/dio.dart';
import 'package:wits_app/network/error_model.dart';

import '../helper/utils.dart';
import 'server_error_handler.dart';
import 'urls_container.dart';

class ApiHandler {
  Map<String, String> _headers = <String, String>{
    // 'Content-Type': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
  Map<String, String> _multiPartHeaders = <String, String>{
    'content-type': 'multipart/form-data',
    'Accept': 'application/json',
  };

  static const String LOG_TAG = 'ChatApiHandler';

  Future<Dio> _createDioInstance() async {
    Dio dio = new Dio();
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
    ));
    return dio;
  }

  Future<dynamic> getTestMultiPartCallApi({
    required String url,
  }) async {
    Dio dio = new Dio();
    return await _makeHttpRequest(
      dio.get('$url',
          options: Options(
            headers: _headers,
          )),
    );
  }

  Future<dynamic> getCustomCallApi({
    required String url,
  }) async {
    Dio dio = await _createDioInstance();
    return await _makeHttpRequest(
      dio.get(
        url,
        // options: Options(headers: _headers,),
      ),
    );
  }

  Future<dynamic> getCallApi({
    required String url,
  }) async {
    Dio dio = await _createDioInstance();
    return await _makeHttpRequest(
      dio.get('${UrlsContainer.baseApiUrl}$url',
          options: Options(
            headers: _headers,
          )),
    );
  }

  Future<dynamic> postCallApi(
      {required String url, required Map body, onUploadProgress}) async {
    Utils.removeNullMapObjects(body);
    Dio dio = await _createDioInstance();
    return await _makeHttpRequest(
      dio.post(
        '$url',
        data: body,
        options: Options(headers: _headers),
      ),
    );
  }

  Future<dynamic> putCallApi({
    required String url,
    required Map body,
  }) async {
    Utils.removeNullMapObjects(body);
    Dio dio = await _createDioInstance();
    return await _makeHttpRequest(
      dio.put('${UrlsContainer.baseApiUrl}$url',
          data: body, options: Options(headers: _headers)),
    );
  }

  Future<dynamic> deleteCallApi({
    required String url,
    required Map body,
  }) async {
    Utils.removeNullMapObjects(body);
    Dio dio = await _createDioInstance();
    return await _makeHttpRequest(
      dio.delete(
        '${UrlsContainer.baseApiUrl}$url',
        data: body,
        options: Options(headers: _headers),
      ),
    );
  }

  Future<dynamic> postMultiPartCallApi(
      {required String url,
      required Map<String, dynamic> body,
      onUploadProgress}) async {
    Utils.removeNullMapObjects(body);
    FormData formDataBody = FormData.fromMap(body);
    Dio dio = await _createDioInstance();
    return await _makeHttpRequest(
      dio.post(
        '${UrlsContainer.baseApiUrl}$url',
        data: formDataBody,
        options: Options(headers: _multiPartHeaders),
        onSendProgress: onUploadProgress,
      ),
    );
  }

  Future<dynamic> _makeHttpRequest(
    Future<Response<dynamic>> httpReq,
  ) async {
    try {
      final response = await httpReq;
      var statusCode = response.data['code'];

      if (response.data['data'] != null) {
        if (statusCode.toString() == '200')
          return response.data['data'];
        else {
          print('0000000000000000000000000000000');
          String message = _getErrorMessage(response.data);
          throw FormatException(message = message);
        }
      } else {
        print('null error null error null error');
        _getErrorMessage(response.data);

        return response.data;
      }
    } on DioError catch (e) {
      String message = _handleDioError(e);
      throw FormatException(message = message);
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } catch (e) {
      throw Exception('something_went_wrong');
    }
  }

  String _getErrorMessage(response) {
    ErrorModel error = ErrorModel.fromJson(
      response,
    );
    return ServerErrors.getError(error)?.message ?? 'something_went_wrong';
  }

  String _handleDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return "request_canceled";
      case DioErrorType.connectTimeout:
        return "connection_timeout";
      case DioErrorType.other:
        return "internet_connection_error";
      case DioErrorType.receiveTimeout:
        return "receive_timeout";
      case DioErrorType.response:
        ErrorModel error = ErrorModel.fromJson(
          dioError.response?.data ?? {},
        );
        return ServerErrors.getError(error)?.message ?? 'something_went_wrong';
        return "something_went_wrong";
      case DioErrorType.sendTimeout:
        return "send_timeout";
      default:
        return "something_went_wrong";
    }
  }
  // Future<dynamic> _makeHttpRequest(
  //   Future<Response<dynamic>> httpReq,
  // ) async {
  //   try {
  //     final response = await httpReq;
  //     var statusCode = response.data['code'];

  //     if (response.data['data'] != null) {
  //       if (statusCode.toString() == '200')
  //         return response.data['data'];
  //       else {
  //         print('0000000000000000000000000000000');
  //         String message = _getErrorMessage(response.data);
  //         throw FormatException(message = message);
  //       }
  //     } else {
  //       print('null error null error null error');
  //       _getErrorMessage(response.data);

  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     String message = _handleDioError(e);
  //     throw FormatException(message = message);
  //   } on FormatException catch (e) {
  //     throw FormatException(e.message);
  //   } catch (e) {
  //     throw Exception('something_went_wrong');
  //   }
  // }
}
