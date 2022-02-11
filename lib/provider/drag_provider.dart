import 'package:flutter/cupertino.dart';

class DragProvider extends ChangeNotifier {
  bool started = false;
  DragProvider();

  //When the user starts the drag
  void startDrag() {
    started = true;
    notifyListeners();
  }

  //When the user finish the drag
  void endDrag() {
    started = false;
    notifyListeners();
  }
}
