import 'package:flutter/material.dart';

class BrandIcons {
  BrandIcons._();

  static Widget github({double size = 18, Color color = Colors.white}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GitHubPainter(color: color),
    );
  }

  static Widget linkedin({double size = 18, Color color = Colors.white}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LinkedInPainter(color: color),
    );
  }

  static Widget facebook({double size = 18, Color color = Colors.white}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FacebookPainter(color: color),
    );
  }

  static Widget instagram({double size = 18, Color color = Colors.white}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _InstagramPainter(color: color),
    );
  }

  static Widget whatsapp({double size = 18, Color color = Colors.white}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WhatsAppPainter(color: color),
    );
  }

  static Widget email({double size = 18, Color color = Colors.white}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _EmailPainter(color: color),
    );
  }
}

class _GitHubPainter extends CustomPainter {
  final Color color;
  _GitHubPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final sx = w / 24.0;
    final sy = h / 24.0;

    canvas.save();
    canvas.scale(sx, sy);

    final path = Path();
    // GitHub Octocat path
    path.moveTo(12, 2);
    path.cubicTo(6.477, 2, 2, 6.477, 2, 12);
    path.cubicTo(2, 16.418, 5.205, 20.086, 9.645, 21.562);
    path.cubicTo(10.145, 21.654, 10.327, 21.345, 10.327, 21.082);
    path.cubicTo(10.327, 20.845, 10.318, 20.218, 10.314, 19.382);
    path.cubicTo(7.186, 20.062, 6.527, 17.873, 6.527, 17.873);
    path.cubicTo(6.015, 16.572, 5.277, 16.226, 5.277, 16.226);
    path.cubicTo(4.256, 15.528, 5.354, 15.542, 5.354, 15.542);
    path.cubicTo(6.484, 15.621, 7.078, 16.7, 7.078, 16.7);
    path.cubicTo(8.081, 18.419, 9.709, 17.923, 10.35, 17.635);
    path.cubicTo(10.452, 16.908, 10.743, 16.413, 11.065, 16.131);
    path.cubicTo(8.568, 15.847, 5.943, 14.882, 5.943, 10.573);
    path.cubicTo(5.943, 9.345, 6.381, 8.341, 7.099, 7.555);
    path.cubicTo(6.983, 7.271, 6.597, 6.128, 7.209, 4.58);
    path.cubicTo(7.209, 4.58, 8.153, 4.278, 10.3, 5.733);
    path.cubicTo(11.197, 5.483, 12.152, 5.359, 13.1, 5.355);
    path.cubicTo(14.048, 5.359, 15.003, 5.483, 15.9, 5.733);
    path.cubicTo(18.047, 4.278, 18.991, 4.58, 18.991, 4.58);
    path.cubicTo(19.603, 6.128, 19.217, 7.271, 19.101, 7.555);
    path.cubicTo(19.819, 8.341, 20.257, 9.345, 20.257, 10.573);
    path.cubicTo(20.257, 14.893, 17.628, 15.843, 15.122, 16.122);
    path.cubicTo(15.525, 16.469, 15.885, 17.155, 15.885, 18.204);
    path.cubicTo(15.885, 19.719, 15.871, 20.942, 15.871, 21.082);
    path.cubicTo(15.871, 21.348, 16.05, 21.66, 16.559, 21.561);
    path.cubicTo(21.018, 20.082, 24, 16.416, 24, 12);
    path.cubicTo(24, 6.477, 19.523, 2, 14, 2);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GitHubPainter oldDelegate) => oldDelegate.color != color;
}

class _LinkedInPainter extends CustomPainter {
  final Color color;
  _LinkedInPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final sx = w / 24.0;
    final sy = h / 24.0;

    canvas.save();
    canvas.scale(sx, sy);

    final path = Path();
    // LinkedIn "in" symbol
    // "i" dot
    canvas.drawCircle(const Offset(4.5, 5.0), 2.2, paint);
    // "i" bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(2.5, 9.0, 4.0, 12.0), const Radius.circular(1)),
      paint,
    );
    // "n"
    path.moveTo(9.5, 9.0);
    path.lineTo(13.5, 9.0);
    path.lineTo(13.5, 11.2);
    path.cubicTo(14.5, 9.5, 16.8, 8.7, 19.0, 8.7);
    path.cubicTo(22.2, 8.7, 23.5, 10.8, 23.5, 14.5);
    path.lineTo(23.5, 21.0);
    path.lineTo(19.5, 21.0);
    path.lineTo(19.5, 15.2);
    path.cubicTo(19.5, 13.5, 19.0, 12.2, 17.2, 12.2);
    path.cubicTo(15.2, 12.2, 13.5, 13.6, 13.5, 16.0);
    path.lineTo(13.5, 21.0);
    path.lineTo(9.5, 21.0);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LinkedInPainter oldDelegate) => oldDelegate.color != color;
}

class _FacebookPainter extends CustomPainter {
  final Color color;
  _FacebookPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final sx = w / 24.0;
    final sy = h / 24.0;

    canvas.save();
    canvas.scale(sx, sy);

    final path = Path();
    path.moveTo(14.0, 22.0);
    path.lineTo(14.0, 14.5);
    path.lineTo(16.5, 14.5);
    path.lineTo(17.0, 11.5);
    path.lineTo(14.0, 11.5);
    path.lineTo(14.0, 9.5);
    path.cubicTo(14.0, 8.6, 14.5, 7.8, 16.0, 7.8);
    path.lineTo(17.5, 7.8);
    path.lineTo(17.5, 5.2);
    path.cubicTo(16.8, 5.1, 15.8, 5.0, 14.8, 5.0);
    path.cubicTo(11.8, 5.0, 10.0, 6.8, 10.0, 10.0);
    path.lineTo(10.0, 11.5);
    path.lineTo(7.5, 11.5);
    path.lineTo(7.5, 14.5);
    path.lineTo(10.0, 14.5);
    path.lineTo(10.0, 22.0);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FacebookPainter oldDelegate) => oldDelegate.color != color;
}

class _InstagramPainter extends CustomPainter {
  final Color color;
  _InstagramPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final sx = w / 24.0;
    final sy = h / 24.0;

    canvas.save();
    canvas.scale(sx, sy);

    // Outer rounded square
    final rect = Rect.fromLTWH(3.0, 3.0, 18.0, 18.0);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5.0)), strokePaint);

    // Inner circle
    canvas.drawCircle(const Offset(12.0, 12.0), 4.5, strokePaint);

    // Flash dot
    canvas.drawCircle(const Offset(16.5, 7.5), 1.2, fillPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _InstagramPainter oldDelegate) => oldDelegate.color != color;
}

class _WhatsAppPainter extends CustomPainter {
  final Color color;
  _WhatsAppPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final sx = w / 24.0;
    final sy = h / 24.0;

    canvas.save();
    canvas.scale(sx, sy);

    // Speech bubble path
    final bubble = Path();
    bubble.moveTo(12.0, 2.5);
    bubble.cubicTo(6.8, 2.5, 2.5, 6.8, 2.5, 12.0);
    bubble.cubicTo(2.5, 13.8, 3.0, 15.5, 4.0, 17.0);
    bubble.lineTo(2.5, 21.5);
    bubble.lineTo(7.2, 20.1);
    bubble.cubicTo(8.6, 21.0, 10.3, 21.5, 12.0, 21.5);
    bubble.cubicTo(17.2, 21.5, 21.5, 17.2, 21.5, 12.0);
    bubble.cubicTo(21.5, 6.8, 17.2, 2.5, 12.0, 2.5);
    bubble.close();

    canvas.drawPath(bubble, strokePaint);

    // Phone handset icon inside bubble
    final phone = Path();
    phone.moveTo(9.0, 7.5);
    phone.cubicTo(8.7, 7.5, 8.3, 7.7, 8.0, 8.1);
    phone.cubicTo(7.5, 8.8, 7.3, 9.8, 7.8, 11.2);
    phone.cubicTo(8.5, 13.0, 10.0, 15.0, 12.0, 16.0);
    phone.cubicTo(13.2, 16.6, 14.3, 16.5, 15.0, 15.9);
    phone.cubicTo(15.4, 15.6, 15.5, 15.2, 15.5, 15.0);
    phone.lineTo(14.5, 13.8);
    phone.cubicTo(14.3, 13.6, 13.9, 13.6, 13.7, 13.8);
    phone.lineTo(13.0, 14.3);
    phone.cubicTo(12.2, 13.8, 11.0, 12.6, 10.5, 11.8);
    phone.lineTo(11.0, 11.1);
    phone.cubicTo(11.2, 10.9, 11.2, 10.5, 11.0, 10.3);
    phone.lineTo(9.8, 9.1);
    phone.close();

    canvas.drawPath(phone, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WhatsAppPainter oldDelegate) => oldDelegate.color != color;
}

class _EmailPainter extends CustomPainter {
  final Color color;
  _EmailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final sx = w / 24.0;
    final sy = h / 24.0;

    canvas.save();
    canvas.scale(sx, sy);

    // Envelope box
    final rect = Rect.fromLTWH(3.0, 5.0, 18.0, 14.0);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(3.0)), strokePaint);

    // Envelope flap fold
    final flap = Path();
    flap.moveTo(3.5, 6.0);
    flap.lineTo(12.0, 13.0);
    flap.lineTo(20.5, 6.0);
    canvas.drawPath(flap, strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _EmailPainter oldDelegate) => oldDelegate.color != color;
}
