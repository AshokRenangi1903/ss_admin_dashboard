import 'package:ss_admin_dashboard/core/response/status.dart';

class ApiResponse<T> {
  // T is a placeholder for the type of data this response carries.
  // It could be User, List<User>, Product, LoginModel, etc.
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status: $status \n message : $message \n data: $data';
  }
}
