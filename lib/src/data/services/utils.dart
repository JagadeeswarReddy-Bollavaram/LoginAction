import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncryptionHelper {
  final _key = encrypt.Key.fromUtf8("my32lengthsupersecretnooneknows1");
  final _iv = encrypt.IV.fromUtf8("16bytesivforaes");

// Encryption method
  String encryptText(String text) {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(_key)); // Use the key for AES encryption
    final encrypted =
        encrypter.encrypt(text, iv: _iv); // Encrypt the text with the IV
    return encrypted.base64; // Return encrypted string as base64
  }

  String decryptText(String encryptedText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
    return decrypted;
  }
}

class HashHelper {
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
