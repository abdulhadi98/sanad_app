// To parse this JSON data, do
//
//     final RoleModel = RoleModelFromJson(jsonString);



class RoleModel {
    RoleModel({
        this.id,
        this.role,
        this.departmentId,
        this.hide,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? role;
    dynamic departmentId;
    int? hide;
    dynamic createdAt;
    dynamic updatedAt;

    factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"] == null ? null : json["id"],
        role: json["role"] == null ? null : json["role"],
        departmentId: json["department_id"],
        hide: json["hide"] == null ? null : json["hide"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "role": role == null ? null : role,
        "department_id": departmentId,
        "hide": hide == null ? null : hide,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
