import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisample/ui/widgets/page_reveal.dart';
import 'package:uisample/viewModels/global_change_notifier.dart';

class ThemeSelectionScreen extends StatefulWidget {
  final List<Gradient> gradientList;
  final Function executeOnTap;
  final double width;

  ThemeSelectionScreen({this.gradientList, this.executeOnTap, this.width});

  @override
  _ThemeSelectionScreenState createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> with TickerProviderStateMixin {
  double scrollPercent = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSelector(onScroll: (double scrollPercent) {}, executeOnTap: widget.executeOnTap, width: widget.width);
  }
}

class ThemeSelector extends StatefulWidget {
  final Function(double scrollPercent) onScroll;
  final Function executeOnTap;
  final double width;

  ThemeSelector({this.onScroll, this.executeOnTap, this.width});

  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;
  PageController _pageController = PageController(initialPage: 0, viewportFraction: 1 / 3);

  double currentPage = 0;
  List<Gradient> gradientList = [
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFFFECEA6), Color(0xFFFF9E9D)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFFE72518), Color(0xFFE75D53)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFF15B213), Color(0xFF4D944B)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFF1AB1A2), Color(0xFF58ADA4)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFF501DA1), Color(0xFF7958AD)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFF666469), Color(0xFFE3D9F2)]),
  ];

  @override
  void initState() {
    super.initState();
    finishScrollController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    )..addListener(
        () {
          setState(
            () {
              scrollPercent = lerpDouble(finishScrollStart, finishScrollEnd, finishScrollController.value);

              if (widget.onScroll != null) {
                widget.onScroll(scrollPercent);
              }
            },
          );
        },
      );

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page == null ? 0 : _pageController.page;
        scrollPercent = _pageController.page / 6;
        print("PAGE SCROLL :::: ${_pageController.page}");
      });
    });
  }

  @override
  void dispose() {
    finishScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Consumer<GlobalChangeNotifier>(
            builder: (context, notifier, child) {
              return Container();
            },
          ),
          _buildThemeAvatar(widget.width),
        ],
      ),
    );
  }

  Widget _buildThemeAvatar(double width) {
    double singleAvatarWidth = width / 3;
    return PageView(
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      controller: _pageController,
      children: _buildAvatars(singleAvatarWidth, currentPage),
    );
  }

  List<Widget> _buildAvatars(double size, double currentPage) {
    return [
      _buildSingleAvatar(size, 0, currentPage),
      _buildSingleAvatar(size, 1, currentPage),
      _buildSingleAvatar(size, 2, currentPage),
      _buildSingleAvatar(size, 3, currentPage),
      _buildSingleAvatar(size, 4, currentPage),
      _buildSingleAvatar(size, 5, currentPage),
    ];
  }

  Widget _buildSingleAvatar(double size, int index, double currentPage) {
    var _height = getAvatarHeight(index, currentPage);
    return Container(
      width: size,
      child: Center(
        child: Consumer<GlobalChangeNotifier>(
          builder: (context, notifier, child) {
            return GestureDetector(
              onTap: () {
                notifier.setCurrentThemeGradient(gradientList[index]);
                widget.executeOnTap();
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(60),
                        gradient: gradientList[index],
                      ),
                      child: Container(),
                    ),
                  ),
                  SizedBox(
                    height: _height,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  double getAvatarHeight(int index, double centerIndex) {
    double minHeight = 40;
    double centerHeight = 70;
    double maxHeight = 100;
    var diff = (centerIndex - index).abs();

    if (index < centerIndex) {
      if (diff > 1) {
        return minHeight;
      }
      return lerpDouble(minHeight, centerHeight, 1 - diff);
    } else {
      if (diff > 1) {
        return maxHeight;
      }
      return lerpDouble(centerHeight, maxHeight, diff);
    }
  }
}
