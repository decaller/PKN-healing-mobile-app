import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class MizanFitrahBalanceScale extends StatefulWidget {
  final double tiltBalance; // -1.0 (sakinah penuh) to +1.0 (amarah berat)

  const MizanFitrahBalanceScale({
    super.key,
    this.tiltBalance = -0.35, // default condong ke sakinah
  });

  @override
  State<MizanFitrahBalanceScale> createState() => _MizanFitrahBalanceScaleState();
}

class _MizanFitrahBalanceScaleState extends State<MizanFitrahBalanceScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _currentTilt;

  @override
  void initState() {
    super.initState();
    _currentTilt = widget.tiltBalance;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: _currentTilt, end: _currentTilt).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(covariant MizanFitrahBalanceScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tiltBalance != widget.tiltBalance) {
      _animateTo(widget.tiltBalance);
    }
  }

  void _animateTo(double target) {
    _animation = Tween<double>(begin: _currentTilt, end: target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward(from: 0.0);
    _currentTilt = target;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Animasi osilasi interaktif saat disentuh
            final nextTilt = _currentTilt < 0 ? 0.3 : -0.4;
            _animateTo(nextTilt);
          },
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(double.infinity, 150),
                painter: _MizanScalePainter(
                  tilt: _animation.value,
                  primaryColor: colors.celestialSky,
                  accentColor: colors.meadowCanopy,
                  warningColor: colors.nafsLawwamah,
                  barkColor: colors.ancientBark,
                  surfaceHighColor: colors.surfaceContainerHigh,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: colors.meadowCanopy,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Sakinah & Thuma\'ninah (78%)',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: colors.meadowCanopy,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Reaktif / Amarah (22%)',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: colors.nafsLawwamah.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _MizanScalePainter extends CustomPainter {
  final double tilt; // -1.0 to 1.0
  final Color primaryColor;
  final Color accentColor;
  final Color warningColor;
  final Color barkColor;
  final Color surfaceHighColor;

  _MizanScalePainter({
    required this.tilt,
    required this.primaryColor,
    required this.accentColor,
    required this.warningColor,
    required this.barkColor,
    required this.surfaceHighColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final baseY = size.height - 15;
    final fulcrumTopY = 45.0;

    // 1. Tiang Utama (Pillar) & Dudukan (Base)
    final pillarPaint = Paint()
      ..color = barkColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final basePaint = Paint()
      ..color = barkColor.withValues(alpha: 0.8)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Base horizontal
    canvas.drawLine(
      Offset(centerX - 35, baseY),
      Offset(centerX + 35, baseY),
      basePaint,
    );

    // Tiang vertikal
    canvas.drawLine(
      Offset(centerX, baseY),
      Offset(centerX, fulcrumTopY),
      pillarPaint,
    );

    // Fulcrum center bead
    final fulcrumBeadPaint = Paint()..color = primaryColor;
    canvas.drawCircle(Offset(centerX, fulcrumTopY), 7, fulcrumBeadPaint);

    // 2. Lengan Timbangan (Mizan Beam)
    final maxAngle = 0.22; // radian
    final angle = tilt * maxAngle;
    final beamLength = size.width * 0.38;

    final leftBeamEnd = Offset(
      centerX - beamLength * math.cos(angle),
      fulcrumTopY - beamLength * math.sin(angle),
    );

    final rightBeamEnd = Offset(
      centerX + beamLength * math.cos(angle),
      fulcrumTopY + beamLength * math.sin(angle),
    );

    final beamPaint = Paint()
      ..color = barkColor
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(leftBeamEnd, rightBeamEnd, beamPaint);

    // 3. Tali Piringan (Strings) & Piringan Timbangan (Pans)
    final stringLength = 40.0;
    final panRadius = 26.0;

    final stringPaint = Paint()
      ..color = barkColor.withValues(alpha: 0.5)
      ..strokeWidth = 1.2;

    // Left Pan (Sakinah)
    final leftPanCenter = Offset(leftBeamEnd.dx, leftBeamEnd.dy + stringLength);
    canvas.drawLine(leftBeamEnd, Offset(leftPanCenter.dx - 18, leftPanCenter.dy), stringPaint);
    canvas.drawLine(leftBeamEnd, Offset(leftPanCenter.dx + 18, leftPanCenter.dy), stringPaint);

    final leftPanPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    final leftPanBorder = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final leftRect = Rect.fromCenter(
      center: Offset(leftPanCenter.dx, leftPanCenter.dy + 4),
      width: panRadius * 1.6,
      height: 14,
    );
    canvas.drawArc(leftRect, 0, math.pi, true, leftPanPaint);
    canvas.drawArc(leftRect, 0, math.pi, false, leftPanBorder);

    // Right Pan (Amarah)
    final rightPanCenter = Offset(rightBeamEnd.dx, rightBeamEnd.dy + stringLength);
    canvas.drawLine(rightBeamEnd, Offset(rightPanCenter.dx - 18, rightPanCenter.dy), stringPaint);
    canvas.drawLine(rightBeamEnd, Offset(rightPanCenter.dx + 18, rightPanCenter.dy), stringPaint);

    final rightPanPaint = Paint()
      ..color = warningColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    final rightPanBorder = Paint()
      ..color = warningColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final rightRect = Rect.fromCenter(
      center: Offset(rightPanCenter.dx, rightPanCenter.dy + 4),
      width: panRadius * 1.6,
      height: 14,
    );
    canvas.drawArc(rightRect, 0, math.pi, true, rightPanPaint);
    canvas.drawArc(rightRect, 0, math.pi, false, rightPanBorder);
  }

  @override
  bool shouldRepaint(covariant _MizanScalePainter oldDelegate) {
    return oldDelegate.tilt != tilt;
  }
}
