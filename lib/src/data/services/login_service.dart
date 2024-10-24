import 'package:hive/hive.dart';
import 'package:travalizer/src/data/services/utils.dart';

class HiveStorageService {
  final EncryptionHelper _encryptionHelper = EncryptionHelper();
  final HashHelper _hashHelper = HashHelper();

  // Open Hive box
  Future<void> _initBox() async {
    await Hive.openBox('userBox');
  }

  // Store encrypted email and hashed password
  Future<void> storeCredentials(String email, String password) async {
    await _initBox();
    var box = Hive.box('userBox');

    // Encrypt email and hash password
    String encryptedEmail = _encryptionHelper.encryptText(email);
    String hashedPassword = _hashHelper.hashPassword(password);

    // Store them in Hive
    await box.put('email', encryptedEmail);
    await box.put('password', hashedPassword);
  }

  // Retrieve credentials
  Future<Map<String, String>> retrieveCredentials() async {
    await _initBox();
    var box = Hive.box('userBox');

    // Get encrypted email and hashed password
    String encryptedEmail = box.get('email', defaultValue: '');
    String hashedPassword = box.get('password', defaultValue: '');

    // Decrypt email
    String decryptedEmail = encryptedEmail.isNotEmpty
        ? _encryptionHelper.decryptText(encryptedEmail)
        : "";

    return {'email': decryptedEmail, 'password': hashedPassword};
  }

  // Clear credentials
  Future<void> clearCredentials() async {
    await _initBox();
    var box = Hive.box('userBox');
    await box.clear();
  }
}
