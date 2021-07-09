import 'package:flutter/material.dart';

class CartStatus extends ChangeNotifier {
  int? cartItem = 0;
  bool showBadge = false;

  void setShowBadge({required bool showBadge}) {
    this.showBadge = showBadge;

    notifyListeners();
  }

  void updateCartBadge({required int? cartItem}) {
    this.cartItem = cartItem;

    notifyListeners();
  }
}
