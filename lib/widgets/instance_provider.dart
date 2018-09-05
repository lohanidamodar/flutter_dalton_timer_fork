
import 'package:flutter/widgets.dart';

class InstanceProvider<T> extends InheritedWidget {
  const InstanceProvider({
    Key key,
    @required Widget child,
    @required this.value,
  })  : assert(child != null),
        super(key: key, child: child);

  const InstanceProvider._typed(): value = null;

  final T value;

  static T of<T>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InstanceProvider<T>._typed().runtimeType)
    as InstanceProvider<T>)
        .value;
  }

  @override
  bool updateShouldNotify(InstanceProvider old) {
    return old.value != value;
  }
}