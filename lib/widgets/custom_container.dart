import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_o_app/cubits/game_cubit/game_cubit.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.state});
  final CellState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    return Container(
      height: cubit.getSize(context),
      width: cubit.getSize(context),
      color: Colors.transparent,
      child: state == CellState.x
          ? SvgPicture.asset("assets/x.svg")
          : state == CellState.o
          ? SvgPicture.asset("assets/o.svg")
          : null,
    );
  }
}
