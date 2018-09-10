import 'dart:async';

import 'package:flutter/material.dart';

class MaterialPageRouteExtended<T> extends MaterialPageRoute<T> {
  /// Creates a page route for use in a material design app.
  MaterialPageRouteExtended({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState: true,
    bool fullscreenDialog: false,
  }) : super(builder : builder, settings: settings, maintainState : maintainState, fullscreenDialog: fullscreenDialog);

  /// This future completes only once the push animation has finished.
  ///
  /// This future completes once the animation has been completed.
  Future<bool> get nextAnimationCompleted => _transitionCompleter.future;
  final Completer<bool> _transitionCompleter = new Completer<bool>();

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
        _transitionCompleter.complete(true);
    }
  }

  @override
  Animation<double> createAnimation() {
    final animation = super.createAnimation();
    animation.addStatusListener(_handleStatusChanged);
    return animation;
  }
}