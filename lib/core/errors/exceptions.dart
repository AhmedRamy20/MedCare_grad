import 'package:dio/dio.dart';
import 'package:medical_app/core/errors/error_model.dart';

class ApiException implements Exception {
  final ErrorModel errorModel;

  ApiException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
        case 401:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
        case 403:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
        case 404:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
        case 409:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
        case 422:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
        case 504:
          throw ApiException(errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
