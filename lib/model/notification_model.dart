// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel(
      {this.id,
      this.isDone,
      this.action,
      this.senderId,
      this.receiverId,
      this.orderId,
      this.type,
      this.url,
      this.isRead,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.color,
      this.secondColor,
      this.delegationId,
      this.reviewId,
      this.returnsId});

  int? id;
  int? senderId;
  int? receiverId;
  int? orderId;
  String? type;
  String? title;
  String? url;
  int? isRead;
  String? body;
  String? color;
  String? secondColor;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? action;

  int? isDone;
  int? reviewId;
  int? delegationId;
  int? returnsId;
  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"] == null ? null : json["id"],
        action: json["action"] == null ? null : json["action"],
        color: json["color"] == null ? null : json["color"],
        secondColor: json["second_color"] == null ? null : json["second_color"],
        senderId: json["sender_id"] == null ? null : json["sender_id"],
        receiverId: json["receiver_id"] == null ? null : json["receiver_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
        title: json['title'] == null ? null : json['title'],
        isDone: json['is_done'] == null ? null : json['is_done'],
        isRead: json["is_read"] == null ? null : json["is_read"],
        reviewId: json["review_id"] == null ? null : json["review_id"],
        delegationId: json["delegation_id"] == null ? null : json["delegation_id"],
        returnsId: json["returns_id"] == null ? null : json["returns_id"],
        body: json["body"] == null ? null : json["body"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sender_id": senderId == null ? null : senderId,
        "receiver_id": receiverId == null ? null : receiverId,
        "order_id": orderId == null ? null : orderId,
        "type": type == null ? null : type,
        "url": url == null ? null : url,
        "is_read": isRead == null ? null : isRead,
        "body": body == null ? null : body,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
