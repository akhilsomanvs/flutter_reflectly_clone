/*import 'package:flutter/material.dart';
import 'package:uisample/ui/app_stf_widget.dart';

class ScaleRoute extends PageRouteBuilder {
  final Widget widget;

  ScaleRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          if (widget is AppStatefulWidget) {
            widget.setAnimationFromPageRoute(animation);
          } else if (widget is AppStateLessWidget) {
            widget.setAnimationFromPageRoute(animation);
          }
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return child;
          /*
          return new ScaleTransition(
            scale: new Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.00,
                  0.50,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 1.5,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.50,
                    1.00,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: widget,
            ),
          );
*/
        });
}*/

import 'package:flutter/material.dart';
import 'package:uisample/ui/app_stf_widget.dart';
import 'package:uisample/viewModels/global_change_notifier.dart';

final Tween<Offset> _kBottomUpTween = new Tween<Offset>(
  begin: const Offset(0.0, 1.0),
  end: Offset.zero,
);

// Offset from offscreen to the right to fully on screen.
final Tween<Offset> _kRightMiddleTween = new Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: Offset.zero,
);

// Offset from offscreen below to fully on screen.
class AppPageRoute extends MaterialPageRoute<String> {
  @override
  final bool maintainState;

  @override
  final WidgetBuilder builder;

  ChangeNotifier _notifier;

  AppPageRoute({
    @required this.builder,
    RouteSettings settings: const RouteSettings(),
    this.maintainState: true,
    bool fullscreenDialog: false,
    ChangeNotifier notifier,
  })  : assert(builder != null),
        assert(settings != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(
          settings: settings,
          fullscreenDialog: fullscreenDialog,
          builder: builder,
        ) {
    this._notifier = notifier;
    assert(opaque); // PageRoute makes it return true.
  }

  @override
  Color get barrierColor => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 550);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    print("BUILD PAGE::::: ");
    final Widget result = builder(context);
    if (result is AppStatefulWidget) {
      result.setAnimationFromPageRoute(animation);
    } else if (result is AppStateLessWidget) {
      result.setAnimationFromPageRoute(animation);
    }
    assert(() {
      if (result == null) {
        throw new FlutterError('The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    /*if (result is AppStatefulWidget) {
      print("ANIM ::::: ANIMVALUE :::::: ${animation.value}");
      result.setAnimationValueFromPageRoute(animation.value);
    }*/
    return result;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

    /*if (_notifier is GlobalChangeNotifier) {
      (_notifier as GlobalChangeNotifier).setAnimValue(animation.value);
    }*/
    return child;
  }
}

class _CustomPageTransition extends StatelessWidget {
  final Animation<Offset> _positionAnimation;

  final Widget child;
  final bool fullscreenDialog;

  _CustomPageTransition({
    Key key,
    @required Animation<double> routeAnimation,
    @required this.child,
    @required this.fullscreenDialog,
  })  : _positionAnimation = !fullscreenDialog
            ? _kRightMiddleTween.animate(new CurvedAnimation(
                parent: routeAnimation,
                curve: Curves.elasticIn,
              ))
            : _kBottomUpTween.animate(new CurvedAnimation(
                parent: routeAnimation, // The route's linear 0.0 - 1.0 animation.
                curve: Curves.elasticIn,
              )),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SlideTransition(
      position: _positionAnimation,
      child: child,
    );
  }
}
