export 'src_faces/face_with_shadow.dart';
export 'src_faces/face_classic.dart';

import 'package:dalton_timer/constants.dart';
import 'package:dalton_timer/widgets/instance_provider.dart';
import 'package:dalton_timer/widgets/src_faces/face_classic.dart';
import 'package:dalton_timer/widgets/src_faces/face_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaceFromSettings extends StatelessWidget {
  final Color color;
  final Duration duration;
  final Duration initialDuration;

  const FaceFromSettings({Key key, this.color, this.duration, this.initialDuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = InstanceProvider
        .of<SharedPreferences>(context);
    final selection = prefs.getInt(SETTINGS_FACE) ?? 0;
    switch (selection) {
      case 0: return FaceWithShadow(color, duration, initialDuration: initialDuration,);
      case 1: return FaceClassic(duration, initialDuration: initialDuration,);
    }
    return null;
  }
}
