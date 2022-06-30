import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:road_ster/domain/api_values/api.dart';

class RepositoryHandler {
  static final Dio _dio = Dio(BaseOptions(
      baseUrl: ApiValues.baseUrl, responseType: ResponseType.plain));
  static Future<Response<dynamic>> loginCheaking(
      Map<String, dynamic> login) async {
    try {
      final response =
          await _dio.post(ApiValues.loginUrl, data: jsonEncode(login));
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw "Email or Password is incorrect Please cheack and try again";
      } else {
        throw "Cheak your internet connecion and try again";
      }
    } catch (e) {
      throw "OOPS! Something went wrong";
    }
  }

  static Future<Response<dynamic>> getUsersDetails() async {
    try {
      final response = await _dio.get(ApiValues.getUsers);

      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw "Cant't get data";
      } else {
        throw "Cheak your internet connecion and try again";
      }
    } catch (e) {
      throw "OOPS! Something went wrong";
    }
  }

  static Future<Response<dynamic>> registerUser(
      Map<String, dynamic> signUp) async {
    try {
      final response =
          await _dio.post(ApiValues.signUpUrl, data: jsonEncode(signUp));
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw e.response!.data.toString();
      } else {
        throw "Cheak your internet connecion and try again";
      }
    } catch (e) {
      throw "OOPS! Something went wrong";
    }
  }
}
