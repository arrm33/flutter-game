import 'dart:io';

void main() {
  List<String> board = List.generate(9, (index) => ' ');
  String currentPlayer = 'X';
  bool gameOver = false;

  void printBoard() {
    print('\n'
        ' ${board[0]} | ${board[1]} | ${board[2]}\n'
        '-----------\n'
        ' ${board[3]} | ${board[4]} | ${board[5]}\n'
        '-----------\n'
        ' ${board[6]} | ${board[7]} | ${board[8]}\n');
  }

  bool checkWinner(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  bool isBoardFull() {
    return !board.contains(' ');
  }

  void startGame() {
    while (!gameOver) {
      printBoard();
      stdout.write('Player $currentPlayer, choose position (1-9): ');
      String? input = stdin.readLineSync();

      int? pos = int.tryParse(input ?? '');
      if (pos == null || pos < 1 || pos > 9 || board[pos - 1] != ' ') {
        print('❌ Invalid move, try again.');
        continue;
      }

      board[pos - 1] = currentPlayer;

      if (checkWinner(currentPlayer)) {
        printBoard();
        print('🎉 Player $currentPlayer wins!');
        gameOver = true;
      } else if (isBoardFull()) {
        printBoard();
        print('🤝 It\'s a draw!');
        gameOver = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    }
  }

  startGame();
}