import 'package:translators/core/helpers/extensions.dart';

class ApiErrorModel {
  final String? message;
  final List<dynamic>? errors;
  const ApiErrorModel({this.message, this.errors});

  ///  Returns a String containing all the error messages
  String getAllMessages() {
    if (errors.isNullOrEmpty()) return message ?? "unknown error";

    final String combinedMessages =
        errors!.map((e) => e['message'].toString()).join('\n');
    return combinedMessages.isNotEmpty
        ? combinedMessages
        : message ?? "unknown error";
  }
}
