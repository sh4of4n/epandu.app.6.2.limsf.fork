class CheckOnline {
  bool? isOnline;
  String? userId;
  CheckOnline({required this.isOnline, required this.userId});

  factory CheckOnline.fromJson(Map<String, dynamic> json) {
    return CheckOnline(
      isOnline: json['isOnline'],
      userId: json['userId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isOnline'] = isOnline;
    data['userId'] = userId;
    return data;
  }
}
