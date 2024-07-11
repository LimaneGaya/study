import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/settings/settings_service.dart';
import 'src/settings/settings_controller.dart';

GetIt getit = GetIt.instance;

Future<void> setupServiceLocator() async {
  await addSharedPrefs();
  await addPocketBase();
  await addSettings();
}

Future<void> addSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  getit.registerSingleton(prefs);
}

Future<void> addPocketBase() async {
  final sharedp = getit<SharedPreferences>();
  final store = AsyncAuthStore(
      save: (String data) async => await sharedp.setString('pb_auth', data),
      initial: sharedp.getString('pb_auth'));
  final pb = PocketBase('http://127.0.0.1:8090', authStore: store);
  getit.registerSingleton(pb);
}

Future<void> addSettings() async {
  final settingsController = SettingsController(SettingsCore());
  await settingsController.loadSettings();
  getit.registerSingleton(settingsController);
}
