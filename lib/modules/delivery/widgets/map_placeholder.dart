import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MapPlaceholder extends StatelessWidget {
  final List<Offset> markers;
  const MapPlaceholder({super.key, this.markers = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFD3DFD8), // Mock map green-ish color
      child: Stack(
        children: [
          // Background Grid / Map Mock
          CustomPaint(
            size: Size.infinite,
            painter: MapGridPainter(),
          ),
          
          // Route Line Mock
          CustomPaint(
            size: Size.infinite,
            painter: RoutePainter(),
          ),

          // Pickup Marker
          const Positioned(
            top: 200,
            left: 100,
            child: Icon(Icons.radio_button_checked, color: AppTheme.primaryPink, size: 28),
          ),

          // Drop Marker
          const Positioned(
            top: 450,
            left: 250,
            child: Icon(Icons.location_on, color: AppTheme.successGreen, size: 36),
          ),

          // Rider Icon
          Positioned(
            top: 320,
            left: 175,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: const Icon(Icons.directions_bike_rounded, color: AppTheme.primaryPink, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2;

    for (var i = 0.0; i < size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (var j = 0.0; j < size.height; j += 50) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppTheme.primaryPink
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(114, 214); // Near Pickup
    path.lineTo(150, 250);
    path.lineTo(175, 320); // Rider position
    path.lineTo(200, 380);
    path.lineTo(260, 460); // Near Drop

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
