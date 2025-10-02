class FeedResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final FeedDataModel data;

  FeedResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) {
    return FeedResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: FeedDataModel.fromJson(json['data'] ?? {}),
    );
  }
}

class FeedDataModel {
  final MetaModel meta;
  final List<FeedItemModel> data;

  FeedDataModel({required this.meta, required this.data});

  factory FeedDataModel.fromJson(Map<String, dynamic> json) {
    return FeedDataModel(
      meta: MetaModel.fromJson(json['meta'] ?? {}),
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => FeedItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class MetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  MetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class FeedItemModel {
  final String id;
  final SenderModel sender;
  final ReceiverModel receiver;
  final String message;
  final List<dynamic> deletedBy;
  final int reactionCount;
  final int commentCount;
  final bool isShared;
  final DateTime createdAt;
  final DateTime updatedAt;

  FeedItemModel({
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

  factory FeedItemModel.fromJson(Map<String, dynamic> json) {
    return FeedItemModel(
      id: json['_id'] ?? '',
      sender: SenderModel.fromJson(json['sender'] ?? {}),
      receiver: ReceiverModel.fromJson(json['receiver'] ?? {}),
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

class SenderModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? profile;

  SenderModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profile,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profile: json['profile'],
    );
  }

  String get fullName => '$firstName $lastName';
}

class ReceiverModel {
  final String id;
  final String firstName;
  final String lastName;

  ReceiverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory ReceiverModel.fromJson(Map<String, dynamic> json) {
    return ReceiverModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}
