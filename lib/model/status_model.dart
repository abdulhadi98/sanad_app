class Status {
  Status({
    this.id,
    this.status,
    this.color,
    this.secondColor,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? status;
  dynamic color;
  dynamic secondColor;

  DateTime? createdAt;
  DateTime? updatedAt;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? null : json["status"],
        color: json["color"] == null ? null : json["color"],
        secondColor: json["second_color"] == null ? null : json["second_color"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "status": status == null ? null : status,
        "color": color,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
