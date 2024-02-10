
import 'package:flutter/cupertino.dart';

enum MQTTAppConnectionState { connected, disconnected, connecting }

class MQTTAppState with ChangeNotifier{
  MQTTAppConnectionState _appConnectionState = MQTTAppConnectionState.disconnected;
  String _ds0 = '';
  String _ds1 = '';
  String _ds2 = '';
  String _ds3 = '';
  String _timer = '';
  String _uptime = '1';
  String _security = '';
  String _engine = '';
  String _vbat = '';
  String _ussl = '';
  String _ussd = '153.4';
  String _rssi = '';
  String _c = '';
  String _cf = '';

  void setDs0(String text){
    _ds0 = text;
    notifyListeners();
  }
  void setDs1(String text){
    _ds1 = text;
    notifyListeners();
  }
  void setDs2(String text){
    _ds2 = text;
    notifyListeners();
  }
  void setDs3(String text){
    _ds3 = text;
    notifyListeners();
  }
  void setTimer(String text){
    _timer = text;
    notifyListeners();
  }
  void setUptime(String text){
    _uptime = text;
    notifyListeners();
  }
  void setSecurity(String text){
    _security = text;
    notifyListeners();
  }
  void setEngine(String text){
    _engine = text;
    notifyListeners();
  }
  void setVbat(String text) {
    _vbat = text;
    notifyListeners();
  }
  void setUssl(String text) {
    _ussl = text;
    notifyListeners();
  }
  void setUssd(String text) {
    _ussd = text;
    notifyListeners();
  }
  void setRssi(String text) {
    _rssi = text;
    notifyListeners();
  }
  void setC(String text) {
    _c = text;
    notifyListeners();
  }
  void setCF(String text) {
    _cf = text;
    notifyListeners();
  }
  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }
  String get getDs0 => _ds0;
  String get getDs1 => _ds1;
  String get getDs2 => _ds2;
  String get getDs3 => _ds3;
  String get getVbat => _vbat;
  String get getTimer => _timer;
  String get getUptime => _uptime;
  String get getSecurity => _security;
  String get getEngine => _engine;
  String get getUssl => _ussl;
  String get getUssd => _ussd;
  String get getRssi => _rssi;
  String get getC=> _c;
  String get getCF => _cf;
  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;

}