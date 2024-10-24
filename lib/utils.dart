import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncryptionHelper {
// Ensure the key length is appropriate for AES (32 bytes here for AES-256)
  final _key = encrypt.Key.fromUtf8(
      "my32lengthsupersecretnooneknows1"); // Make sure the key is of valid length
  final _iv = encrypt.IV
      .fromUtf8("16bytesivforaes"); // IV must also be the correct length

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
    final bytes = utf8.encode(password); // Convert password to UTF-8
    final digest = sha256.convert(bytes); // Hash using SHA-256
    return digest.toString();
  }
}
