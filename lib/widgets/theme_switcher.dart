import 'package:flutter/material.dart';

class ThemeSwitcher extends StatefulWidget {
  final WidgetBuilder childBuilder;
  final ThemeData initialTheme;

  const ThemeSwitcher(
      {Key key, @required this.childBuilder, @required this.initialTheme})
      : assert(childBuilder != null),
        assert(initialTheme != null),
        super(key: key);

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  ThemeData _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding switcher with brightness: ${_currentTheme.brightness}");
    return ChangeTheme(child: widget.childBuilder(context), switcher: this, theme: _currentTheme,);
  }

  void setTheme(ThemeData newTheme) {
    setState(() {
      _currentTheme = newTheme;
    });
  }
}

class ChangeTheme extends InheritedWidget {
  final _ThemeSwitcherState _switcher;
  final ThemeData _theme;

  ChangeTheme(
      {Key key,
      @required Widget child,
      @required _ThemeSwitcherState switcher,
      @required ThemeData theme})
      : assert(child != null),
        assert(switcher != null),
        assert(theme != null),
        this._switcher = switcher,
        this._theme = theme,
        super(key: key, child: child);

  static ChangeTheme of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ChangeTheme) as ChangeTheme;
  }

  @override
  bool updateShouldNotify(ChangeTheme old) {
    return _theme != old._theme;
  }

  void setTheme(ThemeData newTheme) {
    _switcher.setTheme(newTheme);
  }

  ThemeData getTheme() => _theme;
}
