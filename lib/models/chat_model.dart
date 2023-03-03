class ChatModel {
  final String message;
  final int chatIndex;

  ChatModel({
    required this.message,
    required this.chatIndex,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['msg'],
      chatIndex: json['chatIndex'],
    );
  }
}
