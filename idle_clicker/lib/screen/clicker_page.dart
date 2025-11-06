import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ClickerPage extends StatefulWidget {
  const ClickerPage({super.key});

  @override
  State<ClickerPage> createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage> {
  int _score = 0;
  int _cps = 0;
  int _upgradeCost = 10;
  Timer? _gameTimer;

  @override
  void initState() {
    super.initState();

    _loadGame();

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _score += _cps;
      });
      _saveGame();
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _incrementScore() {
    setState(() {
      _score++;
    });
    _saveGame();
  }

  void _upgradeCPS() {
    if (_score >= _upgradeCost) {
      setState(() {
        _score -= _upgradeCost;
        _cps++;
        _upgradeCost = (_upgradeCost * 1.5).round();
      });
      _saveGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Clicker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ton score est de :',
            ),
            Text(
              '$_score',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Text(
              'Codes par seconde : $_cps cps',
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _incrementScore,
              child: Image.asset(
                'assets/OldComps/ibm5150_animated.gif',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: (_score >= _upgradeCost) ? _upgradeCPS : null,
              child: Text('Upgrade CPS ($_upgradeCost codes)'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveGame() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('score', _score);
    prefs.setInt('cps', _cps);
    prefs.setInt('upgradeCost', _upgradeCost);
  }

  Future<void> _loadGame() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _score = prefs.getInt('score') ?? 0;
      _cps = prefs.getInt('cps') ?? 0;
      _upgradeCost = prefs.getInt('upgradeCost') ?? 10;
    });
  }
}
