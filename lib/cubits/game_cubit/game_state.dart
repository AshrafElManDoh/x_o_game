part of 'game_cubit.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GameClicked extends GameState {}

final class GameDraw extends GameState {}

final class GameOver extends GameState {
  final CellState winner;
  final WinningLineType lineType;

  GameOver({required this.winner, required this.lineType});
}
