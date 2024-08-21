import 'dart:convert';

APIResponse apiResponseFromJson(String str) =>
    APIResponse.fromJson(json.decode(str));
String apiResponseToJson(APIResponse data) => json.encode(data.toJson());

class APIResponse {
  APIResponse({
    required this.statusCode,
    required this.headers,
    required this.isSuccess,
    this.data,
    this.status,
    this.statusMessage,
    this.rowCount,
    this.totalRow,
  });

  final dynamic data;
  final String? status;
  final String? statusMessage;
  final int? rowCount;
  final int? totalRow;

  final bool isSuccess;
  final Map<String, dynamic> headers;
  final int statusCode;

  APIResponse copyWith({
    dynamic data,
    String? status,
    String? statusMessage,
    int? rowCount,
    int? totalRow,
    bool? isSuccess,
    Map<String, dynamic>? headers,
    int? statusCode,
  }) =>
      APIResponse(
        data: data ?? this.data,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
        rowCount: rowCount ?? this.rowCount,
        headers: headers ?? this.headers,
        isSuccess: isSuccess ?? this.isSuccess,
        statusCode: statusCode ?? this.statusCode,
        totalRow: totalRow ?? this.totalRow,
      );

  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse(
      data: json["data"],
      status: json["status"],
      statusMessage: json["status_message"],
      rowCount: json["row_count"],
      headers: Map<String, dynamic>.from(json["headers"] ?? {}),
      statusCode: json["status_code"],
      isSuccess: json["is_success"] ?? true,
      totalRow: json["total_row"]);

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "status_message": statusMessage,
        "row_count": rowCount,
        "total_row": totalRow,
        "status_code": statusCode,
        "header": headers,
        "is_success": isSuccess
      };
}
