class ResponseModel {
  final bool _isSuccess;
  final String _message;

  ResponseModel(this._isSuccess, this._message);

  bool get isSuccess => _isSuccess;
  String get message => _message;

}