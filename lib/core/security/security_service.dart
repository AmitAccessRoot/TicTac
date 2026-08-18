// lib/core/security/security_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SecurityService {
  final FlutterSecureStorage secureStorage;

  SecurityService({required this.secureStorage});

  Future<bool> isDeviceCompromised() async {
    try {
      final bool jailbroken = await FlutterJailbreakDetection.jailbroken;
      final bool developerMode = await FlutterJailbreakDetection.developerMode;
      return jailbroken || developerMode;
    } catch (_) {
      return true;
    }
  }

  Future<List<int>> getSecureDatabaseKey() async {
    const keyName = 'isar_master_encryption_key';
    final existingKey = await secureStorage.read(key: keyName);

    if (existingKey != null) {
      return base64Decode(existingKey);
    }

    final random = Random.secure();
    final newKey = List<int>.generate(32, (index) => random.nextInt(256));
    await secureStorage.write(key: keyName, value: base64Encode(newKey));

    return newKey;
  }
}
