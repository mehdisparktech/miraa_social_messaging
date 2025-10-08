class MessageResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final MessageDataModel data;

  MessageResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: MessageDataModel.fromJson(json['data'] ?? {}),
    );
  }
}

class MessageDataModel {
  final MessageMetaModel meta;
  final List<MessageItemModel> data;

  MessageDataModel({required this.meta, required this.data});

  factory MessageDataModel.fromJson(Map<String, dynamic> json) {
    return MessageDataModel(
      meta: MessageMetaModel.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => MessageItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class MessageMetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  MessageMetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory MessageMetaModel.fromJson(Map<String, dynamic> json) {
    return MessageMetaModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class MessageItemModel {
  final String id;
  final MessageUserModel sender;
  final MessageUserModel receiver;
  final String message;
  final List<dynamic> deletedBy;
  final int reactionCount;
  final int commentCount;
  final bool isShared;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageItemModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.deletedBy,
    required this.reactionCount,
    required this.commentCount,
    required this.isShared,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageItemModel.fromJson(Map<String, dynamic> json) {
    return MessageItemModel(
      id: json['_id'] ?? '',
      sender: MessageUserModel.fromJson(json['sender'] ?? {}),
      receiver: MessageUserModel.fromJson(json['receiver'] ?? {}),
      message: json['message'] ?? '',
      deletedBy: json['deletedBy'] ?? [],
      reactionCount: json['reactionCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      isShared: json['isShared'] ?? false,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

class MessageUserModel {
  final String id;
  final String firstName;
  final String lastName;

  MessageUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory MessageUserModel.fromJson(Map<String, dynamic> json) {
    return MessageUserModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}