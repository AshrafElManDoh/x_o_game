import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

enum CellState { empty, x, o, still, draw }

enum WinningLineType { row1, row2, row3, col1, col2, col3, diagMain, diagAnti }

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  CellState playerState = CellState.empty;
  WinningLineType? winningLineType;
  AudioPlayer audio = AudioPlayer();
  List<List<int>> xIndices = [];
  List<List<int>> oIndices = [];

  double getSize(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.3;

    return size;
  }

  List<List<CellState>> board = List.generate(
    3,
    (_) => List.filled(3, CellState.empty),
  );

  void playSound() {
    audio.play(AssetSource("sounds/sound.mp3"));
  }

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
      checkWinner();
    }
  }

  void pressedOnCellVersion3XO({required int index, required int row}) {
    if (board[row][index] != CellState.x && board[row][index] != CellState.o) {
      if (playerState == CellState.empty) {
        playerState = CellState.x;
        board[row][index] = playerState;
        check3XAnd3O(state: playerState, newIndex: index, newRow: row);
        playerState = CellState.o;
      } else if (playerState == CellState.o) {
        board[row][index] = CellState.o;
        check3XAnd3O(state: playerState, newIndex: index, newRow: row);
        switchPlayer();
      } else if (playerState == CellState.x) {
        board[row][index] = CellState.x;
        check3XAnd3O(state: playerState, newIndex: index, newRow: row);
        switchPlayer();
      }
      emit(GameClicked());
      checkWinner();
    }
  }

  // [ [0,1] , [1,1] , [1,2] ]
  void check3XAnd3O({
    required CellState state,
    required int newIndex,
    required int newRow,
  }) {
    if (state == CellState.x) {
      if (xIndices.length == 3) {
        int deletedRow = xIndices[0][0];
        int deletedIndex = xIndices[0][1];
        board[deletedRow][deletedIndex] = CellState.empty;
        xIndices.removeAt(0);
        xIndices.add([newRow, newIndex]);
      } else {
        xIndices.add([newRow, newIndex]);
      }
    } else if (state == CellState.o) {
      //
      if (oIndices.length == 3) {
        int deletedRow = oIndices[0][0];
        int deletedIndex = oIndices[0][1];
        board[deletedRow][deletedIndex] = CellState.empty;
        oIndices.removeAt(0);
        oIndices.add([newRow, newIndex]);
      } else {
        oIndices.add([newRow, newIndex]);
      }
    }
  }

  void checkWinner() {
    // 1. check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] != CellState.empty &&
          board[row][0] == board[row][1] &&
          board[row][1] == board[row][2]) {
        if (row == 0) {
          winningLineType = WinningLineType.row1;
        } else if (row == 1) {
          winningLineType = WinningLineType.row2;
        } else if (row == 2) {
          winningLineType = WinningLineType.row3;
        }
        playSound();
        emit(GameOver(winner: board[row][0], lineType: winningLineType!));
      }
    }

    // 2. check columns
    for (int col = 0; col < 3; col++) {
      if (board[0][col] != CellState.empty &&
          board[0][col] == board[1][col] &&
          board[1][col] == board[2][col]) {
        if (col == 0) {
          winningLineType = WinningLineType.col1;
        } else if (col == 1) {
          winningLineType = WinningLineType.col2;
        } else if (col == 2) {
          winningLineType = WinningLineType.col3;
        }
        playSound();
        emit(GameOver(winner: board[0][col], lineType: winningLineType!));
      }
    }

    // 3. check diagonals
    if (board[0][0] != CellState.empty &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      winningLineType = WinningLineType.diagMain;
      playSound();
      emit(GameOver(winner: board[0][0], lineType: winningLineType!));
    }
    if (board[0][2] != CellState.empty &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      winningLineType = WinningLineType.diagAnti;
      playSound();
      emit(GameOver(winner: board[0][2], lineType: winningLineType!));
    }

    // 4. check if still moves left (game not finished)
    bool hasEmpty = board.any((row) => row.contains(CellState.empty));
    if (!hasEmpty) {
      emit(GameDraw());
    }
  }

  void reset() {
    board = List.generate(3, (_) => List.filled(3, CellState.empty));
    playerState = CellState.empty;
    xIndices = [];
    oIndices = [];
    emit(GameClicked());
  }
}
