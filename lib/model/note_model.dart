// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) => List<NoteModel>.from(json.decode(str).map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel {
  NoteModel({
    this.id,
    this.managerName,
    this.managerId,
    this.employeeId,
    this.departmentId,
    this.orderId,
    this.note,
    this.isGood,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? managerId;
  int? employeeId;
  int? departmentId;
  int? orderId;
  String? note;
  dynamic isGood;
  String? managerName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"] == null ? null : json["id"],
        managerId: json["manager_id"] == null ? null : json["manager_id"],
        managerName: json["manager_name"] == null ? null : json["manager_name"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        departmentId: json["department_id"],
        orderId: json["order_id"],
        note: json["note"] == null ? null : json["note"],
        isGood: json["is_good"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "manager_id": managerId == null ? null : managerId,
        "employee_id": employeeId == null ? null : employeeId,
        "department_id": departmentId,
        "order_id": orderId,
        "note": note == null ? null : note,
        "is_good": isGood,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
