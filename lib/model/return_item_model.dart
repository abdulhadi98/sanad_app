// To parse this JSON data, do
//
//     final returnModel = returnModelFromJson(jsonString);

import 'dart:convert';

ReturnModel returnModelFromJson(String str) => ReturnModel.fromJson(json.decode(str));

String returnModelToJson(ReturnModel data) => json.encode(data.toJson());

class ReturnModel {
  ReturnModel({
    this.id,
    this.commercialRecord,
    this.creatorId,
    this.warehouseId,
    this.details,
    this.returnsIsDelivered,
    this.createdAt,
    this.updatedAt,
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
  String? clientName;
  factory ReturnModel.fromJson(Map<String, dynamic> json) => ReturnModel(
        id: json["id"] == null ? null : json["id"],
        clientName: json["client_name"] == null ? null : json["client_name"],
        commercialRecord: json["commercial_record"] == null ? null : json["commercial_record"],
        creatorId: json["creator_id"] == null ? null : json["creator_id"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        details: json["details"] == null ? null : json["details"],
        returnsIsDelivered: json["returns_is_delivered"] == null ? null : json["returns_is_delivered"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        clientNumber: json["client_number"] == null ? null : json["client_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "client_name": clientName == null ? null : clientName,
        "commercial_record": commercialRecord == null ? null : commercialRecord,
        "creator_id": creatorId == null ? null : creatorId,
        "warehouse_id": warehouseId == null ? null : warehouseId,
        "details": details == null ? null : details,
        "returns_is_delivered": returnsIsDelivered == null ? null : returnsIsDelivered,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "client_number": clientNumber == null ? null : clientNumber,
      };
}
