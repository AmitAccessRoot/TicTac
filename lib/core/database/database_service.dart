// lib/core/database/database_service.dart
import 'dart:typed_data';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;
import '../security/security_service.dart';

class DatabaseService {
  final SecurityService securityService;
  late final Isar isar;
  late final enc.Encrypter _encrypter;

  DatabaseService({required this.securityService});

  Future<void> init(List<CollectionSchema<dynamic>> schemas) async {
    final isCompromised = await securityService.isDeviceCompromised();
    if (isCompromised) {
      throw Exception('Device environment compromised. Database locked.');
    }

    final dir = await getApplicationDocumentsDirectory();
    
    isar = await Isar.open(
      schemas,
      directory: dir.path,
      name: 'secure_tic_tac_db',
    );

    final keyBytes = await securityService.getSecureDatabaseKey();
    final key = enc.Key(Uint8List.fromList(keyBytes));
    
    _encrypter = enc.Encrypter(enc.AES(key));
  }

  String encryptData(String plainText) {
    final iv = enc.IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  String decryptData(String encryptedPayload) {
    final parts = encryptedPayload.split(':');
    if (parts.length != 2) {
      throw Exception('Invalid encrypted payload format.');
    }
    final iv = enc.IV.fromBase64(parts[0]);
    final encryptedText = parts[1];
    return _encrypter.decrypt64(encryptedText, iv: iv);
  }
}
