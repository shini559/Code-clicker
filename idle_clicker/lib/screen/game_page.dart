import 'package:flutter/material.dart';

// Un widget "Stateless" car il ne gère pas son propre état.
// Il ne fait que recevoir et afficher les données du parent.
class GamePage extends StatelessWidget {
  // 1. Déclarer les variables dont on a besoin
  final int score;
  final int scorePerSecond;
  final Function() onIncrementScore; // C'est une fonction !

  // 2. Le constructeur pour recevoir les données
  const GamePage({
    super.key,
    required this.score,
    required this.scorePerSecond,
    required this.onIncrementScore,
  });

  @override
  Widget build(BuildContext context) {
    // 3. C'est le code de notre ANCIENNE méthode _buildGamePage()
    // J'ai remplacé _score par 'score', _scorePerSecond par 'scorePerSecond',
    // et _incrementScore par 'onIncrementScore'
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Ton score est :',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            '$score', // Utilise la variable reçue
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          Text(
            'Par seconde : $scorePerSecond cps',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onIncrementScore, // Utilise la fonction reçue
            child: Image.asset(
              'assets/OldComps/ibm5150_animated.gif',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
