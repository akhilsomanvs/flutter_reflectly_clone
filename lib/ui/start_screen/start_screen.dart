import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisample/ui/custom_page_route.dart';
import 'package:uisample/ui/sign_up_screens/sign_up_nickname.dart';
import 'package:uisample/ui/widgets/responsive_safe_area.dart';
import 'package:uisample/viewModels/global_change_notifier.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation anim_slideUpFirst;
  Animation anim_fadeInFirst;
  Animation anim_slideUpSecond;
  Animation anim_fadeInSecond;
  Animation anim_slideUpThird;
  Animation anim_fadeInThird;
  Animation anim_scaleBounce;
  Animation anim_scaleBounceSecond;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 6));
    anim_slideUpFirst = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.050,
          0.150,
          curve: Curves.ease,
        ),
      ),
    );
    anim_fadeInFirst = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.050,
          0.150,
          curve: Curves.ease,
        ),
      ),
    );
    anim_slideUpSecond = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.150,
          0.250,
          curve: Curves.ease,
        ),
      ),
    );
    anim_fadeInSecond = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.150,
          0.250,
          curve: Curves.ease,
        ),
      ),
    );
    anim_slideUpThird = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.240,
          0.340,
          curve: Curves.ease,
        ),
      ),
    );
    anim_fadeInThird = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.240,
          0.340,
          curve: Curves.ease,
        ),
      ),
    );
    anim_scaleBounce = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.400,
          0.550,
          curve: Curves.bounceOut,
        ),
      ),
    );
    anim_scaleBounceSecond = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.600,
          0.850,
          curve: Curves.bounceOut,
        ),
      ),
    );
    super.initState();

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Offset startOffset = Offset(0, 1);
    final gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFFFECEA6),
//            Color(0xFFFECEA6),
        Color(0xFFFF9E9D),
      ],
    );
    return Consumer<GlobalChangeNotifier>(
      builder: (context, notifier, child) => Container(
        decoration: BoxDecoration(
          gradient: notifier.currentThemeGradient,
        ),
        child: ResponsiveSafeArea(
          builder: (context, size) {
            return Container(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 24),
                      Hero(
                        tag: 'logo_image',
                        child: Container(
                          width: 120,
                          height: 120,
                          child: FlareActor(
                            "assets/rive/robot_assistant.flr",
                            alignment: Alignment.center,
                            animation: "reposo",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: Tween<Offset>(begin: startOffset, end: Offset.zero).animate(anim_slideUpFirst),
                        child: FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim_fadeInFirst),
                          child: Text(
                            "Hi there,",
                            style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: Tween<Offset>(begin: startOffset, end: Offset.zero).animate(anim_slideUpSecond),
                        child: FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim_fadeInSecond),
                          child: Container(
                            child: Text(
                              "I'm Reflectly",
                              style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SlideTransition(
                        position: Tween<Offset>(begin: startOffset, end: Offset.zero).animate(anim_slideUpThird),
                        child: FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim_fadeInThird),
                          child: Text(
                            "Your new personal\nself-care companion",
                            style: theme.textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      ScaleTransition(
                        scale: anim_scaleBounce,
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          child: Consumer<GlobalChangeNotifier>(
                            builder: (context, notifier, child) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    AppPageRoute(
                                      builder: (context) => SignUpNicknameScreen(),
                                      fullscreenDialog: false,
                                      notifier: notifier,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 64),
                                  child: Text(
                                    "HI, REFLECTLY",
                                    style: theme.textTheme.bodyText2.copyWith(
                                      color: notifier.currentThemeGradient.colors[1],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      ScaleTransition(
                        scale: anim_scaleBounce,
                        child: Text(
                          "I ALREADY HAVE AN ACCOUNT",
                          style: theme.textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 32),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
