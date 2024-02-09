// import 'package:app_mqtt/main.dart';
import 'package:app_mqtt/redux/actions.dart';
import 'package:app_mqtt/redux/app_state.dart';
// import 'package:flutter/material.dart';

AppStateRedux reducer(AppStateRedux state, dynamic action){
  if (action is SetVbatAction){
  return AppStateRedux(vbat: state.vbat);
} else {
  return state;
}
}
  

