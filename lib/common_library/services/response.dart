class Response {
  bool isSuccess;
  String? message;
  dynamic data;

  Response(this.isSuccess, {this.message, this.data});
}
