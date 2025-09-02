class NewUserResponse {
  final List<Property> properties;
  final String referenceId;
  final String restoreId;
  final String createdTime;
  final String updatedTime;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Avatar avatar;
  final String phone;
  final String orgContactId;
  final bool loginStatus;

  NewUserResponse({
    required this.properties,
    required this.referenceId,
    required this.restoreId,
    required this.createdTime,
    required this.updatedTime,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.phone,
    required this.orgContactId,
    required this.loginStatus,
  });

  factory NewUserResponse.fromJson(Map<String, dynamic> json) {
    return NewUserResponse(
      properties: (json['properties'] as List)
          .map((e) => Property.fromJson(e))
          .toList(),
      referenceId: json['reference_id'],
      restoreId: json['restore_id'],
      createdTime: json['created_time'],
      updatedTime: json['updated_time'],
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: Avatar.fromJson(json['avatar'] ?? {}),
      phone: json['phone'],
      orgContactId: json['org_contact_id'],
      loginStatus: json['login_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'properties': properties.map((e) => e.toJson()).toList(),
      'reference_id': referenceId,
      'restore_id': restoreId,
      'created_time': createdTime,
      'updated_time': updatedTime,
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar.toJson(),
      'phone': phone,
      'org_contact_id': orgContactId,
      'login_status': loginStatus,
    };
  }
}

class Property {
  final String name;
  final String value;

  Property({required this.name, required this.value});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class Avatar {
  final String? url;

  Avatar({this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
