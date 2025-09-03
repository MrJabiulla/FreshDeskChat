// class UsersResponse {
//   final List<UserModel>? users;
//   final Pagination? pagination;
//   final Links? links;
//
//   UsersResponse({
//     this.users,
//     this.pagination,
//     this.links,
//   });
//
//   factory UsersResponse.fromJson(Map<String, dynamic> json) {
//     return UsersResponse(
//       users: (json['users'] as List?)?.map((e) => UserModel.fromJson(e)).toList(),
//       pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
//       links: json['links'] != null ? Links.fromJson(json['links']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'users': users?.map((e) => e.toJson()).toList(),
//       'pagination': pagination?.toJson(),
//       'links': links?.toJson(),
//     };
//   }
// }
//
// class UserModel {
//   final List<Property>? properties;
//   final String? createdTime;
//   final String? updatedTime;
//   final String? id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final Avatar? avatar;
//   final String? phone;
//   final String? orgContactId;
//   final bool? loginStatus;
//
//   UserModel({
//     this.properties,
//     this.createdTime,
//     this.updatedTime,
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.avatar,
//     this.phone,
//     this.orgContactId,
//     this.loginStatus,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       properties: (json['properties'] as List?)?.map((e) => Property.fromJson(e)).toList(),
//       createdTime: json['created_time'],
//       updatedTime: json['updated_time'],
//       id: json['id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       email: json['email'],
//       avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
//       phone: json['phone'],
//       orgContactId: json['org_contact_id'],
//       loginStatus: json['login_status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'properties': properties?.map((e) => e.toJson()).toList(),
//       'created_time': createdTime,
//       'updated_time': updatedTime,
//       'id': id,
//       'first_name': firstName,
//       'last_name': lastName,
//       'email': email,
//       'avatar': avatar?.toJson(),
//       'phone': phone,
//       'org_contact_id': orgContactId,
//       'login_status': loginStatus,
//     };
//   }
// }
//
// class Property {
//   final String? name;
//   final String? value;
//
//   Property({this.name, this.value});
//
//   factory Property.fromJson(Map<String, dynamic> json) {
//     return Property(
//       name: json['name'],
//       value: json['value'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'value': value,
//     };
//   }
// }
//
// class Avatar {
//   final String? url;
//
//   Avatar({this.url});
//
//   factory Avatar.fromJson(Map<String, dynamic> json) {
//     return Avatar(
//       url: json['url'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'url': url,
//     };
//   }
// }
//
// class Pagination {
//   final int? totalItems;
//   final int? totalPages;
//   final int? currentPage;
//   final int? itemsPerPage;
//
//   Pagination({
//     this.totalItems,
//     this.totalPages,
//     this.currentPage,
//     this.itemsPerPage,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) {
//     return Pagination(
//       totalItems: json['total_items'],
//       totalPages: json['total_pages'],
//       currentPage: json['current_page'],
//       itemsPerPage: json['items_per_page'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'total_items': totalItems,
//       'total_pages': totalPages,
//       'current_page': currentPage,
//       'items_per_page': itemsPerPage,
//     };
//   }
// }
//
// class Links {
//   final PageLink? firstPage;
//   final PageLink? lastPage;
//
//   Links({this.firstPage, this.lastPage});
//
//   factory Links.fromJson(Map<String, dynamic> json) {
//     return Links(
//       firstPage: json['first_page'] != null ? PageLink.fromJson(json['first_page']) : null,
//       lastPage: json['last_page'] != null ? PageLink.fromJson(json['last_page']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'first_page': firstPage?.toJson(),
//       'last_page': lastPage?.toJson(),
//     };
//   }
// }
//
// class PageLink {
//   final String? href;
//   final String? rel;
//   final String? type;
//
//   PageLink({this.href, this.rel, this.type});
//
//   factory PageLink.fromJson(Map<String, dynamic> json) {
//     return PageLink(
//       href: json['href'],
//       rel: json['rel'],
//       type: json['type'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'href': href,
//       'rel': rel,
//       'type': type,
//     };
//   }
// }

class UserResponseModel {
  final String id;
  final String referenceId;
  final String restoreId;
  final String createdTime;
  final String updatedTime;
  final String firstName;
  final String lastName;
  final String email;
  final Map<String, dynamic> avatar;
  final String phone;
  final String orgContactId;
  final bool loginStatus;
  final List<Property> properties;

  UserResponseModel({
    required this.id,
    required this.referenceId,
    required this.restoreId,
    required this.createdTime,
    required this.updatedTime,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.phone,
    required this.orgContactId,
    required this.loginStatus,
    required this.properties,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'] ?? '',
      referenceId: json['reference_id'] ?? '',
      restoreId: json['restore_id'] ?? '',
      createdTime: json['created_time'] ?? '',
      updatedTime: json['updated_time'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? {},
      phone: json['phone'] ?? '',
      orgContactId: json['org_contact_id'] ?? '',
      loginStatus: json['login_status'] ?? false,
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => Property.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "reference_id": referenceId,
      "restore_id": restoreId,
      "created_time": createdTime,
      "updated_time": updatedTime,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "avatar": avatar,
      "phone": phone,
      "org_contact_id": orgContactId,
      "login_status": loginStatus,
      "properties": properties.map((e) => e.toJson()).toList(),
    };
  }
}

class Property {
  final String name;
  final String value;

  Property({
    required this.name,
    required this.value,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'] ?? '',
      value: json['value']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "value": value,
    };
  }
}
