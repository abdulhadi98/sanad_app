import 'dart:convert';

import 'package:wits_app/model/status_model.dart';

OrderModel userModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));
String userModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? commercialRecord;
  int? statusId;
  dynamic invoiceNumber;
  int? creatorId;
  dynamic categoriesNumber;
  String? address;
  String? details;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? clientNumber;
  dynamic catsNumber;
  int? boxNumber;
  int? warehouseId;
  dynamic isStampedBill;
  dynamic returns;
  dynamic returnsIsDelivered;
  int? isPrinted;
  dynamic isOk;
  dynamic deleiverdType;
  Status? status;
  String? clientName;
  String? name;
  String? cityName;
  String? regionName;

  OrderModel(
      {required this.clientNumber,
      this.id,
      this.name,
      this.boxNumber,
      this.commercialRecord,
      this.statusId,
      this.address,
      this.categoriesNumber,
      this.creatorId,
      this.details,
      this.invoiceNumber,
      this.updatedAt,
      this.createdAt,
      this.isStampedBill,
      this.returns,
      this.returnsIsDelivered,
      this.isPrinted,
      this.isOk,
      this.deleiverdType,
      this.status,
      this.warehouseId,
      this.cityName,
      this.regionName});

  //String get formattedNetWorth => Utils.getFormattedNum(netWorth??0);

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        regionName:
            json["client_region"] == null ? null : json["client_region"],
        cityName: json["client_city"] == null ? null : json["client_city"],
        clientNumber:
            json["client_number"] == null ? null : json["client_number"],
        id: json["id"] == null ? null : json["id"],
        name: json["client_name"] == null ? null : json["client_name"],

        statusId: json["status_id"] == null ? null : json["status_id"],
        address: json["address"] == null ? null : json["address"],
        categoriesNumber:
            json["cats_number"] == null ? null : json["cats_number"],
        creatorId: json["creator_id"] == null ? null : json["creator_id"],
        details: json["details"] == null ? null : json["details"],
        invoiceNumber: json["invoice_number"] == null
            ? null
            : json["invoice_number"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        commercialRecord: json["commercial_record"] == null
            ? null
            : json["commercial_record"],
        createdAt: json["created_at"] == null ? null : json["created_at"],

        isStampedBill:
            json["is_stamped_bill"] == null ? null : json["is_stamped_bill"],
        returns: json["returns"] == null ? null : json["returns"],
        returnsIsDelivered: json["returns_is_delivered"] == null
            ? null
            : json["returns_is_delivered"],
        isPrinted: json["is_printed"] == null ? null : json["is_printed"],
        isOk: json["is_ok"] == null ? null : json["is_ok"],
        deleiverdType:
            json["deleiverd_type"] == null ? null : json["deleiverd_type"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        // roleName: json["role_name"] == null ? null : json["role_name"],

        // apiToken:json["api_token"] == null ? null : json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "client_number":
            commercialRecord == null ? null : clientNumber.toString(),
        "invoice_number": invoiceNumber == null ? null : invoiceNumber,
        "address": address == null ? null : address.toString(),
        "details": details == null ? null : details.toString(),
        "cats_number": categoriesNumber == null ? null : categoriesNumber,
        "creator_id": creatorId == null ? null : creatorId.toString(),
        "warehouse_id":warehouseId==null? null: warehouseId.toString()
      };
}
