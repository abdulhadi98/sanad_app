import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.active,
      this.apiToken,
      this.wareHouseId,
      this.roleId,
      this.imageProfile,
      this.roleName,
      this.accessToken});
  int? id;
  String? name;
  String? email;
  String? firstName;
  int? wareHouseId;
  int? roleId;
  int? active;
  String? imageProfile;
  String? apiToken;
  String? password;
  String? roleName;
  String? accessToken;

  String? lastName;
  DateTime? joinDate;
  String? bio;
  String? country;
  String? city;
  String? phone;
  DateTime? updatedAt;
  DateTime? createdAt;

  double? netWorth;

  //String get formattedNetWorth => Utils.getFormattedNum(netWorth??0);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        password: json["password"] == null ? null : json["password"],
        active: json["active"] == null ? null : json["active"],
        imageProfile:
            json["image_profile"] == null ? null : json["image_profile"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        wareHouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        roleName: json["role_name"] == null ? null : json["role_name"],
        accessToken: json["access-token"] == null ? null : json["access-token"],

        // apiToken:json["api_token"] == null ? null : json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "join_date": joinDate == null ? null : joinDate?.toIso8601String(),
        "bio": bio,
        "country": country == null ? null : country,
        "city": city == null ? null : city,
        "phone": phone == null ? null : phone,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "id": id == null ? null : id,
        "api_token": apiToken == null ? null : apiToken,
        "net_worth": netWorth == null ? null : netWorth,
      };
}
