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
      theme: ThemeData(brightness: Brightness.dark),
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
  int xWins = 0;
  int oWins = 0;
  int draws = 0;

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

          if (winner == 'X')
            xWins++;
          else if (winner == 'O')
            oWins++;
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        winner = 'tie';
        gameOver = true;
        draws++;
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
          color: Colors.black54,
          border: Border.all(color: Colors.white),

          boxShadow: [BoxShadow(color: Colors.pinkAccent, blurRadius: 10)],
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
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset('assets/icon.png',),
        ),
        title: Text('Tic Tac Toe', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gameOver ? 'Winner: $winner' : 'Turn: $currentPlayer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) => buildCell(index),
          ),
          SizedBox(height: 20),
          Text(
            'X wins: $xWins   O wins: $oWins   Draws: $draws',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: resetGame, child: Text('Play Again')),
        ],
      ),
    );
  }
}
