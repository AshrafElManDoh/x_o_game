import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:x_o_app/cubits/game_cubit/game_cubit.dart';
import 'package:x_o_app/views/game_view.dart';
import 'package:x_o_app/views/x_o_3_game_view.dart';
import 'package:x_o_app/widgets/custom_button.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/x_o_logo.svg"),
          SizedBox(height: 30),
          CustomButton(
            title: "Normal game",
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameView()),
                )..then((value) {
                  context.read<GameCubit>().reset();
                }),
          ),
          SizedBox(height: 30),
          CustomButton(
            title: "3X / 3O",
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => XO3GameView()),
                )..then((value) {
                  context.read<GameCubit>().reset();
                }),
          ),
        ],
      ),
    );
  }
}
