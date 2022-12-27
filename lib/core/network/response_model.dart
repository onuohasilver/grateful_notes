class ResponseModel {
  final int code;
  final Map data;
  final bool success;

  ResponseModel({
    required this.code,
    required this.data,
    required this.success,
  });

  @override
  String toString() => {code, data, success}.toString();
}
