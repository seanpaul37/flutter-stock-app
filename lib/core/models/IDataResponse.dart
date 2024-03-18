class DataResponse<T> {
  T? data;
  int? statusCode;
  String? statusMessage;

  DataResponse({this.data, this.statusMessage, this.statusCode});

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
        statusMessage: json["status_message"],
        statusCode: int.parse("${json["status_code"] ?? 0}"),
        data: json.containsKey("data") ? dataFromJson(json['data'], T) : null);
  }

  static DataResponse<dynamic> withError(dynamic error) {
    return DataResponse(statusCode: 400, statusMessage: "", data: error);
  }

  static dataFromJson(json, Type t) {
    return json;
  }
}
