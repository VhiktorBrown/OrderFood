import 'package:order_food/data/models/sign_up_body.dart';

class ResponseModel {
  final bool _success;
  final String _message;

  ResponseModel(this._success, this._message);

  bool get success => _success;
  String get message => _message;

}