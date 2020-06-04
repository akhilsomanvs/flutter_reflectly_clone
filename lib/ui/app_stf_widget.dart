import 'package:flutter/material.dart';

abstract class AppStatefulWidget extends StatefulWidget {
  void setAnimationFromPageRoute(Animation animation);
  void setAnimationValueFromPageRoute(double animValue);
}

abstract class AppStateLessWidget extends StatelessWidget {
  void setAnimationFromPageRoute(Animation animation);
  void setAnimationValueFromPageRoute(double animValue);
}
