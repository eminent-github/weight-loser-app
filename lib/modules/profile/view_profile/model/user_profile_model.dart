// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  int? id;
  String? name;
  String? email;
  String? profileName;
  String? location;
  String? mobile;
  String? imgPah;
  String? unitWeight;
  double? currentWeight;
  double? targetWeight;
  UserProfileModel({
    this.id,
    this.name,
    this.email,
    this.profileName,
    this.location,
    this.mobile,
    this.imgPah,
    this.unitWeight,
    this.currentWeight,
    this.targetWeight,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profileName': profileName,
      'location': location,
      'mobile': mobile,
      'imgPah': imgPah,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profileName:
          map['profileName'] != null ? map['profileName'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      imgPah: map['imgPah'] != null ? map['imgPah'] as String : null,
      unitWeight:
          map['unitWeight'] != null ? map['unitWeight'] as String : null,
      currentWeight:
          map['currentWeight'] != null ? map['currentWeight'] as double : null,
      targetWeight:
          map['targetWeight'] != null ? map['targetWeight'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, email: $email, profileName: $profileName, location: $location, mobile: $mobile, imgPah: $imgPah)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profileName == profileName &&
        other.location == location &&
        other.mobile == mobile &&
        other.imgPah == imgPah;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileName.hashCode ^
        location.hashCode ^
        mobile.hashCode ^
        imgPah.hashCode;
  }
}
