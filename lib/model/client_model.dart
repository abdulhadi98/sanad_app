// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  ClientModel({
    this.commercialRecord,
    this.name,
    this.clientNumber,
    this.stamp,
    this.telephone,
    this.longitude,
    this.latitude,
    this.active,
    this.oldSystemReference,
    this.cityId,
    this.regionId,
    this.cityName,
    this.regionName,
    this.createdAt,
    this.updatedAt,
  });

  String? commercialRecord;
  String? name;
  String? clientNumber;
  String? stamp;
  String? telephone;
  String? longitude;
  String? latitude;
  String? cityName;
  String? regionName;

  int? active;
  String? oldSystemReference;
  int? cityId;
  int? regionId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        cityName: json["city_name"] == null ? null : json["city_name"],
        regionName: json["region_name"] == null ? null : json["region_name"],
        commercialRecord: json["commercial_record"] == null ? null : json["commercial_record"],
        name: json["name"] == null ? null : json["name"],
        clientNumber: json["client_number"] == null ? null : json["client_number"],
        stamp: json["stamp"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        active: json["active"] == null ? null : json["active"],
        oldSystemReference: json["old_system_reference"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "commercial_record": commercialRecord == null ? null : commercialRecord,
        "name": name == null ? null : name,
        "client_number": clientNumber == null ? null : clientNumber,
        "stamp": stamp,
        "telephone": telephone == null ? null : telephone,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "active": active == null ? null : active,
        "old_system_reference": oldSystemReference,
        "city_id": cityId == null ? null : cityId,
        "region_id": regionId == null ? null : regionId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
