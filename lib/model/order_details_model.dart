// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//     Welcome({
//         this.orderDetailsModel,
//     });

//     OrderDetailsModel orderDetailsModel;

//     factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         orderDetailsModel: json["OrderDetailsModel"] == null ? null : OrderDetailsModel.fromJson(json["OrderDetailsModel"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "OrderDetailsModel": orderDetailsModel == null ? null : orderDetailsModel.toJson(),
//     };
// }

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.commercialRecord,
    this.creatorId,
    this.invoiceNumber,
    this.catsNumber,
    this.boxNumber,
    this.details,
    this.warehouseId,
    this.address,
    this.isStampedBill,
    this.returns,
    this.returnsIsDelivered,
    this.isPrinted,
    this.isOk,
    this.deleiverdType,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.clientNumber,
    this.clientRegion,
    this.clientLongitude,
    this.clientLatitude,
    this.clientCity,
    this.processes,
    this.statusColor,
    this.statusName,
  });

  int? id;
  String? clientLatitude;
  String? clientLongitude;

  String? commercialRecord;
  int? creatorId;
  int? invoiceNumber;
  int? catsNumber;
  int? boxNumber;
  String? details;
  int? warehouseId;
  String? address;
  int? isStampedBill;
  bool? returns;
  int? returnsIsDelivered;
  int? isPrinted;
  int? isOk;
  String? deleiverdType;
  int? statusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? clientNumber;
  String? clientRegion;
  String? clientCity;
  String? statusName;
  String? statusColor;

  List<Process>? processes;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        id: json["id"] == null ? null : json["id"],
        commercialRecord: json["commercial_record"] == null ? null : json["commercial_record"],
        creatorId: json["creator_id"] == null ? null : json["creator_id"],
        invoiceNumber: json["invoice_number"] == null ? null : json["invoice_number"],
        catsNumber: json["cats_number"] == null ? null : json["cats_number"],
        boxNumber: json["box_number"] == null ? null : json["box_number"],
        details: json["details"] == null ? null : json["details"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        address: json["address"] == null ? null : json["address"],
        isStampedBill: json["is_stamped_bill"] == null ? null : json["is_stamped_bill"],
        returns: json["returns"] == null ? null : json["returns"],
        returnsIsDelivered: json["returns_is_delivered"] == null ? null : json["returns_is_delivered"],
        isPrinted: json["is_printed"] == null ? null : json["is_printed"],
        isOk: json["is_ok"] == null ? null : json["is_ok"],
        deleiverdType: json["deleiverd_type"] == null ? null : json["deleiverd_type"],
        statusId: json["status_id"] == null ? null : json["status_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        clientNumber: json["client_number"] == null ? null : json["client_number"],
        clientRegion: json["client_region"] == null ? null : json["client_region"],
        clientCity: json["client_city"] == null ? null : json["client_city"],
        clientLatitude: json["client_latitude"] == null ? null : json["client_latitude"],
        clientLongitude: json["client_longitude"] == null ? null : json["client_longitude"],
        statusColor: json["order_status_color"] == null ? null : json["order_status_color"],
        statusName: json["order_status_name"] == null ? null : json["order_status_name"],
        processes: json["processes"] == null ? null : List<Process>.from(json["processes"].map((x) => Process.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "commercial_record": commercialRecord == null ? null : commercialRecord,
        "creator_id": creatorId == null ? null : creatorId,
        "invoice_number": invoiceNumber == null ? null : invoiceNumber,
        "cats_number": catsNumber == null ? null : catsNumber,
        "box_number": boxNumber == null ? null : boxNumber,
        "details": details == null ? null : details,
        "warehouse_id": warehouseId == null ? null : warehouseId,
        "address": address == null ? null : address,
        "is_stamped_bill": isStampedBill == null ? null : isStampedBill,
        "returns": returns == null ? null : returns,
        "returns_is_delivered": returnsIsDelivered == null ? null : returnsIsDelivered,
        "is_printed": isPrinted == null ? null : isPrinted,
        "is_ok": isOk == null ? null : isOk,
        "deleiverd_type": deleiverdType == null ? null : deleiverdType,
        "status_id": statusId == null ? null : statusId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "client_number": clientNumber == null ? null : clientNumber,
        "client_region": clientRegion == null ? null : clientRegion,
        "client_city": clientCity == null ? null : clientCity,
        "processes": processes == null ? null : List<dynamic>.from(processes!.map((x) => x.toJson())),
      };
}

class Process {
  Process({
    this.id,
    this.employeeId,
    this.orderId,
    this.statusId,
    this.warehouseId,
    this.details,
    this.driverType,
    this.taked,
    this.createdAt,
    this.updatedAt,
    this.statusName,
    this.statusColor,
    this.employeeName,
  });

  int? id;
  int? employeeId;
  int? orderId;
  int? statusId;
  int? warehouseId;
  String? details;
  int? driverType;
  int? taked;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusName;
  String? statusColor;
  String? employeeName;

  factory Process.fromJson(Map<String, dynamic> json) => Process(
        id: json["id"] == null ? null : json["id"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        statusId: json["status_id"] == null ? null : json["status_id"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        details: json["details"] == null ? null : json["details"],
        driverType: json["driver_type"] == null ? null : json["driver_type"],
        taked: json["taked"] == null ? null : json["taked"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        statusName: json["status_name"] == null ? null : json["status_name"],
        statusColor: json["status_color"] == null ? null : json["status_color"],
        employeeName: json["employee_name"] == null ? null : json["employee_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "employee_id": employeeId == null ? null : employeeId,
        "order_id": orderId == null ? null : orderId,
        "status_id": statusId == null ? null : statusId,
        "warehouse_id": warehouseId == null ? null : warehouseId,
        "details": details == null ? null : details,
        "driver_type": driverType == null ? null : driverType,
        "taked": taked == null ? null : taked,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "status_name": statusName == null ? null : statusName,
        "status_color": statusColor == null ? null : statusColor,
        "employee_name": employeeName == null ? null : employeeName,
      };
}
