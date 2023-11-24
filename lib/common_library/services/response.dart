class Response<T> {
  final bool isSuccess;
  final String message;
  final T? data;

  Response(
    this.isSuccess, {
    this.message = '',
    this.data,
  });
}
