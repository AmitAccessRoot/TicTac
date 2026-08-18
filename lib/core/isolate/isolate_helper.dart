// lib/core/isolate/isolate_helper.dart
import 'dart:isolate';

class IsolateHelper {
  Future<T> executeTask<T>(T Function() task) async {
    return await Isolate.run(task);
  }
}
