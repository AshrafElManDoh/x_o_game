import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o_app/cubits/game_cubit/game_cubit.dart';
import 'package:x_o_app/widgets/custom_container.dart';

class CustomXOFor3xo extends StatelessWidget {
  const CustomXOFor3xo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    return Table(
      border: TableBorder.all(color: Colors.white, width: 5),
      defaultColumnWidth: FixedColumnWidth(cubit.getSize(context)),
      children: [
        TableRow(
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                cubit.pressedOnCellVersion3XO(index: index, row: 0);
              },
              child: CustomContainer(state: cubit.board[0][index]),
            );
          }),
        ),
        TableRow(
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                cubit.pressedOnCellVersion3XO(index: index, row: 1);
              },
              child: CustomContainer(state: cubit.board[1][index]),
            );
          }),
        ),
        TableRow(
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                cubit.pressedOnCellVersion3XO(index: index, row: 2);
              },
              child: CustomContainer(state: cubit.board[2][index]),
            );
          }),
        ),
      ],
    );
  }
}
