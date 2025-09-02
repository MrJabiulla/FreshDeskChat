class UserParams {
  final String id;
  final String createdTime;
  final String updatedTime;
  final Avatar avatar;
  final String email;
  final String firstName;
  final String lastName;
  final bool loginStatus;
  final String orgContactId;
  final String phone;
  final List<Property> properties;
  final String referenceId;
  final String restoreId;

  UserParams({
    required this.id,
    required this.createdTime,
    required this.updatedTime,
    required this.avatar,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.loginStatus,
    required this.orgContactId,
    required this.phone,
    required this.properties,
    required this.referenceId,
    required this.restoreId,
  });

  @override
  String toString() {
    return 'UserParams(id: $id, createdTime: $createdTime, updatedTime: $updatedTime, avatar: $avatar, email: $email, firstName: $firstName, lastName: $lastName, loginStatus: $loginStatus, orgContactId: $orgContactId, phone: $phone, properties: $properties, referenceId: $referenceId, restoreId: $restoreId)';
  }
}

class Avatar {
  final String url;

  Avatar({required this.url});

  @override
  String toString() {
    return 'Avatar(url: $url)';
  }
}

class Property {
  final String name;
  final String value;

  Property({
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return 'Property(name: $name, value: $value)';
  }
}
