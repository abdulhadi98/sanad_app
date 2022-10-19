class SalesEmployeeModel {
    SalesEmployeeModel({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.imagePorofile,
        this.active,
        this.warehouseId,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.deviceToken,
        this.deviceKey,
    });

       int?  id;
    String? name;
    String? email;
      bool? emailVerifiedAt;
    String? imagePorofile;
       int? active;
       int? warehouseId;
       int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
    String? deviceToken;
    String? deviceKey;

    factory SalesEmployeeModel.fromJson(Map<String, dynamic> json) => SalesEmployeeModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : json["email_verified_at"],
        imagePorofile: json["image_porofile"] == null ? null : json["image_porofile"],
        active: json["active"] == null ? null : json["active"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        deviceKey: json["device_key"] == null ? null : json["device_key"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt,
        "image_porofile": imagePorofile == null ? null : imagePorofile,
        "active": active == null ? null : active,
        "warehouse_id": warehouseId == null ? null : warehouseId,
        "role_id": roleId == null ? null : roleId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "device_token": deviceToken == null ? null : deviceToken,
        "device_key": deviceKey == null ? null : deviceKey,
    };
}
