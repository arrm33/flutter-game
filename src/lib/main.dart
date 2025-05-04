import 'package:flutter/material.dart';

void main() {
  runApp(const XoGame());
}

class XoGame extends StatelessWidget {
  const XoGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XO Game',
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  bool gameOver = false;

  void handleTap(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        checkWinner();
        if (!gameOver) {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  void checkWinner() {
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
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a != '' && a == b && b == c) {
        setState(() {
          winner = a;
          gameOver = true;
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        winner = 'tie';
        gameOver = true;
      });
    }
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
      gameOver = false;
    });
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () => handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tic tac two')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gameOver ? 'Winner: $winner' : 'Turn: $currentPlayer',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) => buildCell(index),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }
}
