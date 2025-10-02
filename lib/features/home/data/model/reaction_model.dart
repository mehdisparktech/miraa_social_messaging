class ReactionModel {
  final String id;
  final String message;
  final User user;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReactionModel({
    required this.id,
    required this.message,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      id: json['_id'] ?? json['id'] ?? '',
      message: json['message'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'message': message,
      'user': user.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
    };
  }

  String get fullName => '$firstName $lastName'.trim();
}