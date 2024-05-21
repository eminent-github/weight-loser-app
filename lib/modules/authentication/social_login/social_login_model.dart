// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FacebookLoginModel {
  String? name;
  String? email;
  Picture? picture;
  String? id;
  FacebookLoginModel({
    this.name,
    this.email,
    this.picture,
    this.id,
  });

  

  FacebookLoginModel copyWith({
    String? name,
    String? email,
    Picture? picture,
    String? id,
  }) {
    return FacebookLoginModel(
      name: name ?? this.name,
      email: email ?? this.email,
      picture: picture ?? this.picture,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'picture': picture?.toMap(),
      'id': id,
    };
  }

  factory FacebookLoginModel.fromMap(Map<String, dynamic> map) {
    return FacebookLoginModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      picture: map['picture'] != null ? Picture.fromMap(map['picture'] as Map<String,dynamic>) : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacebookLoginModel.fromJson(String source) => FacebookLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FacebookLoginModel(name: $name, email: $email, picture: $picture, id: $id)';
  }

  @override
  bool operator ==(covariant FacebookLoginModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.picture == picture &&
      other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      picture.hashCode ^
      id.hashCode;
  }
}

class Picture {
  Data? data;
  Picture({
    this.data,
  });

  

  Picture copyWith({
    Data? data,
  }) {
    return Picture(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
    };
  }

  factory Picture.fromMap(Map<String, dynamic> map) {
    return Picture(
      data: map['data'] != null ? Data.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Picture.fromJson(String source) => Picture.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Picture(data: $data)';

  @override
  bool operator ==(covariant Picture other) {
    if (identical(this, other)) return true;
  
    return 
      other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class Data {
  int? height;
  String? url;
  int? width;
  Data({
    this.height,
    this.url,
    this.width,
  });

  

  Data copyWith({
    int? height,
    String? url,
    int? width,
  }) {
    return Data(
      height: height ?? this.height,
      url: url ?? this.url,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'url': url,
      'width': width,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      height: map['height'] != null ? map['height'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(height: $height, url: $url, width: $width)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;
  
    return 
      other.height == height &&
      other.url == url &&
      other.width == width;
  }

  @override
  int get hashCode => height.hashCode ^ url.hashCode ^ width.hashCode;
}
