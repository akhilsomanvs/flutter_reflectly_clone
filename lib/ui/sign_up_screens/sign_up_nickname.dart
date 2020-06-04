import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uisample/ui/app_stf_widget.dart';
import 'package:uisample/ui/theme_selection_screen/theme_selection_screen.dart';
import 'package:uisample/ui/widgets/page_reveal.dart';
import 'package:uisample/ui/widgets/responsive_safe_area.dart';
import 'package:uisample/viewModels/global_change_notifier.dart';

class SignUpNicknameScreen extends AppStatefulWidget {
  static String routeName = "screen_sign_up_nickname";
  Animation animation;
  double animPercent;

  @override
  _SignUpNicknameScreenState createState() => _SignUpNicknameScreenState();

  @override
  void setAnimationFromPageRoute(Animation<dynamic> animation) {
    assert(animation != null);
    this.animation = animation;
  }

  @override
  void setAnimationValueFromPageRoute(double animValue) {
    assert(animValue != null);
    print("ANIM PERCENT ::::: ___ $animValue");
    this.animPercent = animValue;
  }
}

class _SignUpNicknameScreenState extends State<SignUpNicknameScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation revealAnimation;
  int currentPageIndex = 0;
  GlobalChangeNotifier _notifier;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _notifier.setCurrentToPreviousTheme();
            controller.reset();
          }
        },
      );
    revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  double containerHeight = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (currentPageIndex == 0) {
            return true;
          } else {
            --currentPageIndex;
            setState(() {

            });
          }
          return false;
        },
        child: Consumer<GlobalChangeNotifier>(
          builder: (context, notifier, child) {
            _notifier = notifier;
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: notifier.previousTheme,
                  ),
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return PageReveal(
                      revealPercent: revealAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: notifier.currentThemeGradient,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  child: ResponsiveSafeArea(
                    builder: (context, size) {
                      if (containerHeight < size.height) {
                        containerHeight = size.height;
                      }
                      if (widget.animation == null) {
                        return Container();
                      } else {
                        if (currentPageIndex == 0) {
                          return SingleChildScrollView(
                            child: Container(
                              height: containerHeight,
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 32),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SlideTransition(
                                      position: Tween(begin: Offset(-3, 0), end: Offset.zero).animate(widget.animation),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(Icons.chevron_left, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Hero(
                                      tag: 'logo_image',
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: FlareActor(
                                          "assets/rive/robot_assistant.flr",
                                          alignment: Alignment.center,
                                          animation: "reposo",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Flexible(
                                    child: SlideTransition(
                                      position: Tween(begin: Offset(3, 0), end: Offset.zero).animate(widget.animation),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "So nice to meet you! What do your friends call you?",
                                            style: theme.textTheme.bodyText1.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 12),
                                          Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFF9E9D).withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
                                                child: Padding(
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  child: TextField(
                                                    keyboardType: TextInputType.text,
                                                    textAlign: TextAlign.center,
                                                    style: theme.textTheme.bodyText2.copyWith(color: theme.accentColor, fontSize: 20),
                                                    decoration: InputDecoration(
                                                      hintText: "Your nickname...",
                                                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                                      border: new OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: const BorderRadius.all(
                                                          const Radius.circular(10.0),
                                                        ),
                                                      ),
                                                      focusColor: Colors.red,
                                                      hintStyle: theme.textTheme.bodyText2.copyWith(color: theme.accentColor, fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(child: Container()),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                            child: Transform.translate(
                                              offset: Offset(0, 0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    currentPageIndex = 1;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 16),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(60),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "CONTINUE",
                                                      style: TextStyle(
                                                        color: notifier.currentThemeGradient.colors[1],
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 32),
                                  SlideTransition(
                                    position: Tween(begin: Offset(0, 60), end: Offset.zero).animate(widget.animation),
                                    child: Container(
                                      width: 64,
                                      height: 4,
                                      color: theme.accentColor.withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(height: 32),
                                ],
                              ),
                            ),
                          );
                        } else if (currentPageIndex == 1) {
                          return Container(
                            height: containerHeight,
                            child: ThemeSelectionScreen(
                              width: size.width,
                              executeOnTap: () {
                                try {
                                  controller.forward();
                                } catch (e) {}
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
