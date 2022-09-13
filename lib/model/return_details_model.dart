// To parse this JSON data, do
//
//     final returnDetailsModel = returnDetailsModelFromJson(jsonString);

import 'dart:convert';

ReturnDetailsModel returnDetailsModelFromJson(String str) => ReturnDetailsModel.fromJson(json.decode(str));

String returnDetailsModelToJson(ReturnDetailsModel data) => json.encode(data.toJson());

class ReturnDetailsModel {
  ReturnDetailsModel({
    this.id,
    this.commercialRecord,
    this.creatorId,
    this.warehouseId,
    this.details,
    this.returnsIsDelivered,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.clientNumber,
    this.clientName,
  });

  int? id;
  String? commercialRecord;
  int? creatorId;
  int? warehouseId;
  String? details;
  int? returnsIsDelivered;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? clientNumber;
  List<ImageModel>? images;
  String? clientName;
  factory ReturnDetailsModel.fromJson(Map<String, dynamic> json) => ReturnDetailsModel(
        id: json["id"] == null ? null : json["id"],
                clientName: json["client_name"] == null ? null : json["client_name"],
        commercialRecord: json["commercial_record"] == null ? null : json["commercial_record"],
        creatorId: json["creator_id"] == null ? null : json["creator_id"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        details: json["details"] == null ? null : json["details"],
        returnsIsDelivered: json["returns_is_delivered"] == null ? null : json["returns_is_delivered"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        images: json["images"] == null ? null : List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),
        clientNumber: json["client_number"] == null ? null : json["client_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        'client_name':clientName==null?null:clientName,
        "commercial_record": commercialRecord == null ? null : commercialRecord,
        "creator_id": creatorId == null ? null : creatorId,
        "warehouse_id": warehouseId == null ? null : warehouseId,
        "details": details == null ? null : details,
        "returns_is_delivered": returnsIsDelivered == null ? null : returnsIsDelivered,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
        "client_number": clientNumber == null ? null : clientNumber,
      };
}

class ImageModel {
  ImageModel({
    this.id,
    this.orderId,
    this.creatorId,
    this.path,
    this.type,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.returnsId,
  });

  int? id;
  dynamic orderId;
  int? creatorId;
  String? path;
  String? type;
  dynamic details;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? returnsId;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"],
        creatorId: json["creator_id"] == null ? null : json["creator_id"],
        path: json["path"] == null ? null : json["path"],
        type: json["type"] == null ? null : json["type"],
        details: json["details"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        returnsId: json["returns_id"] == null ? null : json["returns_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_id": orderId,
        "creator_id": creatorId == null ? null : creatorId,
        "path": path == null ? null : path,
        "type": type == null ? null : type,
        "details": details,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "returns_id": returnsId == null ? null : returnsId,
      };
}
