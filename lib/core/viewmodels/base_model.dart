import 'package:flutter/foundation.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';

/// Represents the state of the view
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
