
class ErrorModel {
  String? message;
  String? code;
  // Details? details;

  ErrorModel({
    this.message,
    this.code,
    // this.details,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"] == null ? null : json["message"],
        code: json["code"] == null ? null : json["code"].toString(),
        // details: json["data"] == null ? null : Details.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "code": code == null ? null : code,
        // "data": details == null ? null : details?.toJson()??'',
      };
}

class Details {
  Details();

  factory Details.fromJson(Map<String, dynamic> json) => Details();

  Map<String, dynamic> toJson() => {};
}
