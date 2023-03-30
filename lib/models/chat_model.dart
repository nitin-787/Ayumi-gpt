class ChatModel {
  final String message;
  final int chatIndex;
  final String role;

  ChatModel({
    required this.message,
    required this.chatIndex,
    required this.role,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['msg'],
      chatIndex: json['chatIndex'],
      role: json['role'],
    );
  }
}
