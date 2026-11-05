import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract final class AppToast {
  static const Duration _duration = Duration(seconds: 3);
  static const double _borderRadius = 16;

  static void show({
    required BuildContext context,
    required String title,
    String description = '',
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      alignment: Alignment.topCenter,
      autoCloseDuration: _duration,
      showProgressBar: false,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      icon: Icon(_getIcon(type), color: Colors.white, size: 24),
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: description.trim().isEmpty
          ? null
          : Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
      backgroundColor: _getColor(type),
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide.none,
      boxShadow: const [
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 20,
          offset: Offset(0, 6),
        ),
      ],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      animationDuration: const Duration(milliseconds: 300),
      applyBlurEffect: true,
    );
  }

  static Color _getColor(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return const Color(0xFF218C62);

      case ToastificationType.info:
        return const Color(0xFF343A50);

      case ToastificationType.warning:
        return const Color(0xFFB7791F);

      case ToastificationType.error:
        return const Color(0xFFB8323A);

      default:
        return const Color(0xFF343A50);
    }
  }

  static IconData _getIcon(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Icons.check_circle_rounded;

      case ToastificationType.info:
        return Icons.movie_rounded;

      case ToastificationType.warning:
        return Icons.warning_amber_rounded;

      case ToastificationType.error:
        return Icons.error_rounded;

      default:
        return Icons.notifications_active_rounded;
    }
  }
}
