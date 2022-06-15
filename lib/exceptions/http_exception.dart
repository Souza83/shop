import 'package:flutter/cupertino.dart';

class HttpException implements Exception {
  final String msg;
  final int statusCode;

  HttpException({
    required this.msg,
    required this.statusCode,
  });

  @override
  String toSreing() {
    return msg;
  }
}
