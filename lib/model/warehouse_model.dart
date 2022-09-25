// To parse this JSON data, do
//
//     final wareHouseModel = wareHouseModelFromJson(jsonString);

import 'dart:convert';

List<WareHouseModel> wareHouseModelFromJson(String str) => List<WareHouseModel>.from(json.decode(str).map((x) => WareHouseModel.fromJson(x)));

String wareHouseModelToJson(List<WareHouseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WareHouseModel {
    WareHouseModel({
        this.id,
        this.name,
        this.address,
        this.cityId,
        this.createdAt,
        this.updatedAt,
    });

    int ?id;
    String? name;
    dynamic address;
    int? cityId;
    dynamic createdAt;
    dynamic updatedAt;

    factory WareHouseModel.fromJson(Map<String, dynamic> json) => WareHouseModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address,
        "city_id": cityId == null ? null : cityId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
