import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum MessageType {
  info,
  success,
  error,
  warning,
  toast,
}

class CustomSnackbar {
  static const int _defaultDuration = 2000;
  final double _defaultTextSize = 15.0;
  final double _defaultIconSize = 28.0;
  final EdgeInsets _defaultPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  final EdgeInsets _defaultMargin =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 15);
  final BorderRadius _defaultBorderRadius = BorderRadius.circular(15.0);

  static int getDuration() {
    return _defaultDuration;
  }

  void show(
    BuildContext context, {
    required message,
    required MessageType type,
    int? duration,
  }) {
    Color? backgroundColor;
    Icon? icon;

    switch (type) {
      case MessageType.error:
        backgroundColor = Colors.red;
        icon = Icon(
          Icons.cancel,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;

      case MessageType.warning:
        backgroundColor = Colors.amberAccent[400];
        icon = Icon(
          Icons.warning,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;

      case MessageType.success:
        backgroundColor = Colors.green;
        icon = Icon(
          Icons.check,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;
      case MessageType.info:
        backgroundColor = Colors.black87;
        icon = Icon(
          Icons.info_outline,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;
      case MessageType.toast:
        backgroundColor = Colors.black87;
        break;
      default:
        backgroundColor = const Color(0xFF303030);
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
    required message,
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
          fontSize: textSize ?? _defaultTextSize,
          color: textColor ?? Colors.white,
        ),
      ),
      padding: _defaultPadding,
      margin: type == MessageType.toast
          ? _defaultMargin
          : const EdgeInsets.all(0.0),
      borderRadius: type == MessageType.toast
          ? _defaultBorderRadius
          : BorderRadius.circular(0.0),
      icon: icon,
      backgroundColor: bgColor ?? const Color(0xFF303030),
      duration: Duration(milliseconds: duration ?? _defaultDuration),
    ).show(context);
  }
}
