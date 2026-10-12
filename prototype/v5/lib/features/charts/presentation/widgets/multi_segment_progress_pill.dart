import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class MultiSegmentProgressPill extends StatelessWidget {
  final double diriRatio; // e.g. 0.48
  final double hatiRatio; // e.g. 0.32
  final double ilmuRatio; // e.g. 0.08
  final double height;

  const MultiSegmentProgressPill({
    super.key,
    this.diriRatio = 0.48,
    this.hatiRatio = 0.32,
    this.ilmuRatio = 0.08,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final total = (diriRatio + hatiRatio + ilmuRatio).clamp(0.0, 1.0);
    final remaining = (1.0 - total).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Container(
            height: height,
            color: colors.surfaceContainerHighest,
            child: Row(
              children: [
                if (diriRatio > 0)
                  Expanded(
                    flex: (diriRatio * 1000).toInt(),
                    child: Container(color: colors.meadowCanopy),
                  ),
                if (hatiRatio > 0)
                  Expanded(
                    flex: (hatiRatio * 1000).toInt(),
                    child: Container(color: colors.celestialSky),
                  ),
                if (ilmuRatio > 0)
                  Expanded(
                    flex: (ilmuRatio * 1000).toInt(),
                    child: Container(color: colors.ancientBark),
                  ),
                if (remaining > 0)
                  Expanded(
                    flex: (remaining * 1000).toInt(),
                    child: Container(color: colors.surfaceContainerHighest),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildLegendItem(colors.meadowCanopy, 'Diri (${(diriRatio * 100).round()}%)', colors),
            _buildLegendItem(colors.celestialSky, 'Hati (${(hatiRatio * 100).round()}%)', colors),
            _buildLegendItem(colors.ancientBark, 'Ilmu (${(ilmuRatio * 100).round()}%)', colors),
            Text(
              'Total: ${(total * 100).round()}%',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color dotColor, String label, dynamic colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 11,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
