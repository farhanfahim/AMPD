class RepositoryResponse{

  bool _success;
  String _msg;
  dynamic _data;
  int _statusCode;
  int _userVerified;

  dynamic get data => _data;

  set data(dynamic value) {
    _data = value;
  }

  bool get success => _success;

  set success(bool value) {
    _success = value;
  }

  int get statusCode => _statusCode;

  set statusCode(int value) {
    _statusCode = value;
  }

  String get msg => _msg;

  set msg(String value) {
    _msg = value;
  }

  int get userVerified => _userVerified;

  set userVerified(int value) {
    _userVerified = value;
  }
}