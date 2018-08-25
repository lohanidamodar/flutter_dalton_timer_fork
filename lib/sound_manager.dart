import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:soundpool/soundpool.dart';

abstract class Sounds {
  Future playAlarm();
}

class SoundsManager extends Sounds {
  int _alarmSoundId = -1;

  SoundsManager(BuildContext context) {
    //TODO can it be implemented better way?
    DefaultAssetBundle.of(context).load("sounds/Shut_Down1.wav").then((data) {
      Soundpool.load(data).then((id) {
        _alarmSoundId = id;
      });
    });
  }

  @override
  Future<int> playAlarm() {
    return Soundpool.play(_alarmSoundId, repeat: 3);
  }
  
}

class SoundsProvider extends InheritedWidget {
  const SoundsProvider({
    Key key,
    @required Widget child,
    @required this.sounds,
  })  : assert(child != null),
        super(key: key, child: child);

  final Sounds sounds;

  static Sounds of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SoundsProvider)
            as SoundsProvider)
        .sounds;
  }

  @override
  bool updateShouldNotify(SoundsProvider old) {
    return old.sounds != sounds;
  }
}
