import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  static const _green = Color(0xFF048A6D);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: height * 0.16,
        decoration: BoxDecoration(
          color: const Color.fromARGB(153, 236, 232, 232),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text(
                    "Early protection for\nyour family health",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: height * 0.026,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Learn More",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: height * 0.16,
                child: const _FemaleDoctorIllustration(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FemaleDoctorIllustration extends StatelessWidget {
  const _FemaleDoctorIllustration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _FemaleDoctorPainter());
  }
}

class _FemaleDoctorPainter extends CustomPainter {
  static const _skin = Color(0xFFFFCBA4);
  static const _scrubs = Color(0xFF048A6D);
  static const _hair = Color(0xFF3B1F0A);
  static const _white = Colors.white;
  static const _stethoscopeGrey = Color(0xFF9E9E9E);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.52;

    final skinPaint = Paint()..color = _skin;
    final scrubsPaint = Paint()..color = _scrubs;
    final hairPaint = Paint()..color = _hair;
    final whitePaint = Paint()..color = _white;
    final stethPaint = Paint()
      ..color = _stethoscopeGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.035
      ..strokeCap = StrokeCap.round;

    // ── Body / scrubs ──────────────────────────────────────────
    final bodyRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        cx - size.width * 0.28,
        size.height * 0.52,
        size.width * 0.56,
        size.height * 0.56,
      ),
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
    );
    canvas.drawRRect(bodyRect, scrubsPaint);

    // ── Collar / white coat lapels ─────────────────────────────
    final leftLapel = Path()
      ..moveTo(cx - size.width * 0.06, size.height * 0.52)
      ..lineTo(cx - size.width * 0.14, size.height * 0.72)
      ..lineTo(cx, size.height * 0.72)
      ..close();
    final rightLapel = Path()
      ..moveTo(cx + size.width * 0.06, size.height * 0.52)
      ..lineTo(cx + size.width * 0.14, size.height * 0.72)
      ..lineTo(cx, size.height * 0.72)
      ..close();
    canvas.drawPath(leftLapel, whitePaint);
    canvas.drawPath(rightLapel, whitePaint);

    // ── Neck ──────────────────────────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(
        cx - size.width * 0.055,
        size.height * 0.42,
        size.width * 0.11,
        size.height * 0.13,
      ),
      skinPaint,
    );

    // ── Head ──────────────────────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, size.height * 0.3),
        width: size.width * 0.38,
        height: size.height * 0.3,
      ),
      skinPaint,
    );

    // ── Hair ──────────────────────────────────────────────────
    final hairPath = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(cx, size.height * 0.24),
          width: size.width * 0.4,
          height: size.height * 0.22,
        ),
      );
    // bun
    canvas.drawPath(hairPath, hairPaint);
    canvas.drawCircle(
      Offset(cx, size.height * 0.06),
      size.width * 0.09,
      hairPaint,
    );
    // side strands
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - size.width * 0.19, size.height * 0.3),
        width: size.width * 0.08,
        height: size.height * 0.18,
      ),
      hairPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + size.width * 0.19, size.height * 0.3),
        width: size.width * 0.08,
        height: size.height * 0.18,
      ),
      hairPaint,
    );

    // ── Eyes ──────────────────────────────────────────────────
    final eyePaint = Paint()..color = const Color(0xFF3B1F0A);
    canvas.drawCircle(
      Offset(cx - size.width * 0.08, size.height * 0.28),
      3.5,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(cx + size.width * 0.08, size.height * 0.28),
      3.5,
      eyePaint,
    );

    // ── Smile ─────────────────────────────────────────────────
    final smilePaint = Paint()
      ..color = const Color(0xFFB85C5C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx, size.height * 0.33),
        width: size.width * 0.14,
        height: size.height * 0.06,
      ),
      0,
      3.14,
      false,
      smilePaint,
    );

    // ── Stethoscope ───────────────────────────────────────────
    final stethPath = Path()
      ..moveTo(cx - size.width * 0.04, size.height * 0.54)
      ..cubicTo(
        cx - size.width * 0.04,
        size.height * 0.78,
        cx + size.width * 0.18,
        size.height * 0.78,
        cx + size.width * 0.18,
        size.height * 0.62,
      );
    canvas.drawPath(stethPath, stethPaint);
    canvas.drawCircle(
      Offset(cx + size.width * 0.18, size.height * 0.62),
      size.width * 0.055,
      Paint()..color = _stethoscopeGrey,
    );
    canvas.drawCircle(
      Offset(cx + size.width * 0.18, size.height * 0.62),
      size.width * 0.032,
      whitePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
