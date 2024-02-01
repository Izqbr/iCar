import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings {
  ExampleModel() async {
    await Hive.initFlutter();
  }
  
  Future<void> saveValue(String key,String value) async {
    var box = await Hive.openBox<String>('settingstBox');
    box.put(key, value);
    box.close();
  }
  
  Future<String?> getSettingsValue(String key) async {
    var box = await Hive.openBox<String>('settingstBox');
    final value =  box.get(key);
    box.close();
    return value;
  }
}