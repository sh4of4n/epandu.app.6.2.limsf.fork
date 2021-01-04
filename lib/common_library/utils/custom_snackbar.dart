import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

enum MessageType {
  INFO,
  SUCCESS,
  ERROR,
  WARNING,
  TOAST,
}

class CustomSnackbar {
  static const int _defaultDuration = 2000;
  double _defaultTextSize = 15.0;
  double _defaultIconSize = 28.0;
  EdgeInsets _defaultPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  EdgeInsets _defaultMargin =
      EdgeInsets.symmetric(horizontal: 15, vertical: 15);
  double _defaultBorderRadius = 15.0;

  static int getDuration() {
    return _defaultDuration;
  }

  void show(
    BuildContext context, {
    @required message,
    @required MessageType type,
    int duration,
  }) {
    Color backgroundColor;
    Icon icon;

    switch (type) {
      case MessageType.ERROR:
        backgroundColor = Colors.red;
        icon = Icon(
          Icons.cancel,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;

      case MessageType.WARNING:
        backgroundColor = Colors.amberAccent[400];
        icon = Icon(
          Icons.warning,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;

      case MessageType.SUCCESS:
        backgroundColor = Colors.green;
        icon = Icon(
          Icons.check,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;
      case MessageType.INFO:
        backgroundColor = Colors.black87;
        icon = Icon(
          Icons.info_outline,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;
      case MessageType.TOAST:
        backgroundColor = Colors.black87;
        break;
      default:
        backgroundColor = Color(0xFF303030);
        icon = Icon(
          Icons.info_outline,
          size: _defaultIconSize,
          color: Colors.white,
        );
    }

    _showFlushbar(
      context,
      type,
      message: message,
      bgColor: backgroundColor,
      icon: icon,
      duration: duration,
    );
  }

  void _showFlushbar(
    BuildContext context,
    type, {
    message,
    bgColor,
    textSize,
    textColor,
    icon,
    duration,
  }) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: textSize != null ? textSize : _defaultTextSize,
          color: textColor != null ? textColor : Colors.white,
        ),
      ),
      padding: _defaultPadding,
      margin: type == MessageType.TOAST ? _defaultMargin : EdgeInsets.all(0.0),
      borderRadius: type == MessageType.TOAST ? _defaultBorderRadius : 0.0,
      icon: icon,
      backgroundColor: bgColor != null ? bgColor : Color(0xFF303030),
      duration: Duration(milliseconds: duration ?? _defaultDuration),
    )..show(context);
  }
}
