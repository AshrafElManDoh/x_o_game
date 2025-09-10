import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:x_o_app/cubits/game_cubit/game_cubit.dart';
import 'package:x_o_app/widgets/custom_button.dart';
import 'package:x_o_app/widgets/custom_x_o.dart';
import 'package:x_o_app/widgets/winning_line.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: "Logo",child: SvgPicture.asset("assets/x_o_logo.svg", height: 90)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state is GameDraw) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Draw",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SvgPicture.asset("assets/x_o_logo.svg", height: 60),
                    ],
                  ),
                  SizedBox(height: 30),
                  AbsorbPointer(absorbing: true, child: CustomXO()),
                  SizedBox(height: 50),
                  CustomButton(
                    title: "Reset",
                    onTap: () {
                      cubit.reset();
                    },
                  ),
                ],
              );
            }
            if (state is GameOver) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Winner ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      state.winner == CellState.x
                          ? SvgPicture.asset("assets/x.svg", height: 60)
                          : SvgPicture.asset("assets/o.svg", height: 60),
                    ],
                  ),
                  SizedBox(height: 30),
                  AbsorbPointer(
                    absorbing: true,
                    child: Stack(
                      children: [
                        CustomXO(),
                        WinningLine(type: state.lineType),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomButton(
                    title: "Reset",
                    onTap: () {
                      cubit.reset();
                    },
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      cubit.playerState == CellState.x ||
                              cubit.playerState == CellState.empty
                          ? SvgPicture.asset("assets/x.svg", height: 60)
                          : SvgPicture.asset("assets/o.svg", height: 60),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomXO(),
                  SizedBox(height: 50),
                  CustomButton(
                    title: "Reset",
                    onTap: () {
                      cubit.reset();
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
