import 'dart:async';

import 'package:flutter/services.dart';

const _CHANNEL_NAME = "pl.ukaszapps/screenwakelock";
const _METHOD_SET_AWAKE = "setAwake";
const _METHOD_CLEAR_AWAKE = "clearAwake";

const _platform = MethodChannel(_CHANNEL_NAME);
/// Keeps screen awake
///
/// This method stops system from moving screen to sleeping.
Future setAwake() async {
  await _platform.invokeMethod(_METHOD_SET_AWAKE);
}

/// Cancels screen being awake
///
/// This method tells system that screen needs no longer to be visible
Future clearAwake() async {
  await _platform.invokeMethod(_METHOD_CLEAR_AWAKE);
}