import 'package:pocketbase/pocketbase.dart';

import '../../../../../service_locator.dart';

class AuthRepository {
  final PocketBase db = getit<PocketBase>();

  Future<RecordModel?> signup(
      String name, String email, String password) async {
    try {
      return await db.collection('users').create(body: {
        "name": name,
        "email": email,
        "emailVisibility": true,
        "password": password,
        "passwordConfirm": password,
      });
    } on ClientException catch (e) {
      print(e.response);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<RecordModel?> login(String email, String password) async {
    try {
      final m = await db.collection('users').authWithPassword(email, password);
      return m.record;
    } on ClientException catch (e) {
      print(e.response);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
