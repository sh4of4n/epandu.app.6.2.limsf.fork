class Response {
  bool isSuccess = false;
  String? message;
  dynamic data;

  Response(this.isSuccess, {this.message, this.data});

  Response.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
