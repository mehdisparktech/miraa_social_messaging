class CommentResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final CommentDataModel meta;
  final List<CommentItemModel> data;

  CommentResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: CommentDataModel.fromJson(json['meta'] ?? {}),
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => CommentItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class CommentDataModel {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  CommentDataModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory CommentDataModel.fromJson(Map<String, dynamic> json) {
    return CommentDataModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class CommentItemModel {
  final String id;
  final String message;
  final CommentUserModel user;
  final String content;
  final List<dynamic> reactions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  CommentItemModel({
    required this.id,
    required this.message,
    required this.user,
    required this.content,
    required this.reactions,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory CommentItemModel.fromJson(Map<String, dynamic> json) {
    return CommentItemModel(
      id: json['_id'] ?? '',
      message: json['message'] ?? '',
      user: CommentUserModel.fromJson(json['user'] ?? {}),
      content: json['content'] ?? '',
      reactions: json['reactions'] ?? [],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      version: json['__v'] ?? 0,
    );
  }
}

class CommentUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? profile;

  CommentUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profile,
  });

  factory CommentUserModel.fromJson(Map<String, dynamic> json) {
    return CommentUserModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profile: json['profile'],
    );
  }

  String get fullName => '$firstName $lastName';
}
