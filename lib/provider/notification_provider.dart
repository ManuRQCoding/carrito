import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  double width = 20;
  double height = 20;

  NotificationProvider();

  //The notification container will grow up
  void up() {
    width = 25;
    height = 25;
    notifyListeners();
  }

  //The notification container will grow down
  void down() {
    width = 20;
    height = 20;
    notifyListeners();
  }
}
