import 'package:flutter/material.dart';
import 'package:x_o_app/cubits/game_cubit/game_cubit.dart';

class WinningLinePainter extends CustomPainter {
  final WinningLineType type;
  final double progress; 

  WinningLinePainter(this.type, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    double cellSize = size.width / 3;

    Offset start, end;

    switch (type) {
      case WinningLineType.row1:
        start = Offset(0, cellSize / 2);
        end = Offset(size.width, cellSize / 2);
        break;
      case WinningLineType.row2:
        start = Offset(0, cellSize * 1.5);
        end = Offset(size.width, cellSize * 1.5);
        break;
      case WinningLineType.row3:
        start = Offset(0, cellSize * 2.5);
        end = Offset(size.width, cellSize * 2.5);
        break;
      case WinningLineType.col1:
        start = Offset(cellSize / 2, 0);
        end = Offset(cellSize / 2, size.height);
        break;
      case WinningLineType.col2:
        start = Offset(cellSize * 1.5, 0);
        end = Offset(cellSize * 1.5, size.height);
        break;
      case WinningLineType.col3:
        start = Offset(cellSize * 2.5, 0);
        end = Offset(cellSize * 2.5, size.height);
        break;
      case WinningLineType.diagMain:
        start = Offset(0, 0);
        end = Offset(size.width, size.height);
        break;
      case WinningLineType.diagAnti:
        start = Offset(size.width, 0);
        end = Offset(0, size.height);
        break;
    }

    final currentEnd = Offset(
      start.dx + (end.dx - start.dx) * progress,
      start.dy + (end.dy - start.dy) * progress,
    );

    canvas.drawLine(start, currentEnd, paint);
  }

  @override
  bool shouldRepaint(covariant WinningLinePainter oldDelegate) {
    return true;
  }
}
