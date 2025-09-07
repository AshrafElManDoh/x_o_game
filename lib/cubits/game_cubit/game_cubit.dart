import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

enum CellState { empty, x, o, still, draw, xWin, owin }

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  CellState playerState = CellState.empty;

  double getSize(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.3;

    return size;
  }

  List<List<CellState>> board = List.generate(
    3,
    (_) => List.filled(3, CellState.empty),
  );

  void switchPlayer() {
    if (playerState == CellState.x) {
      playerState = CellState.o;
    } else {
      playerState = CellState.x;
    }
  }

  void pressedOnCell(int index, int row) {
    if (board[row][index] != CellState.x && board[row][index] != CellState.o) {
      if (playerState == CellState.empty) {
        board[row][index] = CellState.x;
        playerState = CellState.o;
      } else if (playerState == CellState.o) {
        board[row][index] = CellState.o;
        switchPlayer();
      } else if (playerState == CellState.x) {
        board[row][index] = CellState.x;
        switchPlayer();
      }
      emit(GameClicked());
    }
    checkWinner();
  }

  void checkWinner() {
    // 1. check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] != CellState.empty &&
          board[row][0] == board[row][1] &&
          board[row][1] == board[row][2]) {
        emit(GameOver(winner: board[row][0]));
      }
    }

    // 2. check columns
    for (int col = 0; col < 3; col++) {
      if (board[0][col] != CellState.empty &&
          board[0][col] == board[1][col] &&
          board[1][col] == board[2][col]) {
        emit(GameOver(winner: board[0][col]));
      }
    }

    // 3. check diagonals
    if (board[0][0] != CellState.empty &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      emit(GameOver(winner: board[0][0]));
    }
    if (board[0][2] != CellState.empty &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      emit(GameOver(winner: board[0][2]));
    }

    // 4. check if still moves left (game not finished)
    bool hasEmpty = board.any((row) => row.contains(CellState.empty));
    if (!hasEmpty) {
      emit(GameDraw());
    }
  }

  void reset() {
    board = List.generate(3, (_) => List.filled(3, CellState.empty));
    playerState = CellState.empty ;
    emit(GameClicked());
  }
}
