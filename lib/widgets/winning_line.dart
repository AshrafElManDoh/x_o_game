import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o_app/cubits/game_cubit/game_cubit.dart';
import 'package:x_o_app/paint/winning_line_painter.dart';

class WinningLine extends StatefulWidget {
  const WinningLine({super.key, required this.type});
  final WinningLineType type;

  @override
  State<WinningLine> createState() => _WinningLineState();
}

class _WinningLineState extends State<WinningLine>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.square(context.read<GameCubit>().getSize(context) * 3),
          painter: WinningLinePainter(widget.type, controller.value),
        );
      },
    );
  }
}
