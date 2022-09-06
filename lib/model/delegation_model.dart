// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// ClientModel clientModelFromJson(String str) =>
//     ClientModel.fromJson(json.decode(str));

// String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class DelegationModel {
  DelegationModel(
      {this.id,
      this.delegationEmployeeName,
      this.commercialRecord,
      this.creatorId,
      this.warehouseId,
      this.orderId,
      this.details,
      this.accepted,
      this.acceptedDetails,
      this.createdAt,
      this.updatedAt,
      this.employeeId,
      this.clientNumber});
  dynamic employeeId;
  String? delegationEmployeeName;
  int? id;
  String? details;
  dynamic clientNumber;
  dynamic creatorId;

  String? commercialRecord;
  int? warehouseId;
  int? orderId;
  int? accepted;
  String? acceptedDetails;
  DateTime? createdAt;
  DateTime? updatedAt;
  factory DelegationModel.fromJson(Map<String, dynamic> json) => DelegationModel(
        clientNumber: json["client_number"] == null ? null : json["client_number"],
        id: json["id"] == null ? null : json["id"],
        delegationEmployeeName: json["delegation_employee_name"] == null ? null : json["delegation_employee_name"],
        commercialRecord: json["commercial_record"] == null ? null : json["commercial_record"],
        creatorId: json["creator_id"] == null ? null : json["creator_id"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        details: json["details"] == null ? null : json["details"],
        accepted: json["accepted"] == null ? null : json["accepted"],
        acceptedDetails: json["accepted_details"] == null ? null : json["accepted_details"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
      );

  //This one for adding delegation from the start(from the sales manger root screen -assign sales employee- and it doesn't need delegation id)
  Map<String, dynamic> toJsonMangerFromScratch() => {
        // 'delegation_id': id == null ? null : id,
        "client_number": clientNumber == null ? null : clientNumber,
        "details": details == null ? null : details,
        "creator_id": creatorId == null ? null : creatorId,
        "employee_id": employeeId == null ? null : employeeId.toString(),
      };

  //This one for accepting delegation from the salesman(from the delegations screen after we select one delegation and press accept and assign salesman) and it needs delegation id that we take from delegation details controller)
  Map<String, dynamic> toJsonManger() => {
        'delegation_id': id == null ? null : id.toString(),
        "client_number": clientNumber == null ? null : clientNumber,
        "details": details == null ? null : details,
        "creator_id": creatorId == null ? null : creatorId,
        "employee_id": employeeId == null ? null : employeeId.toString(),
      };
  Map<String, dynamic> toJson() => {
        "client_number": clientNumber == null ? null : clientNumber,
        "details": details == null ? null : details,
        "creator_id": creatorId == null ? null : creatorId,
      };
}
