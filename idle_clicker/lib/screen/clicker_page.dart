import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_page.dart';
import 'upgrades_page.dart';

class ClickerPage extends StatefulWidget {
  const ClickerPage({super.key});

  @override
  State<ClickerPage> createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage> {
  int _score = 0;

  int _cps = 0;
  int _upgradeCost = 10;

  int _clickPower = 1;
  int _clickUpgradeCost = 20;

  Timer? _gameTimer;

  int _selectedIndex = 0;

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
      _score += _clickPower;
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

  void _upgradeClickPower() {
    if (_score >= _clickUpgradeCost) {
      setState(() {
        _score -= _clickUpgradeCost;
        _clickPower++;
        _clickUpgradeCost = (_clickUpgradeCost * 1.8).round();
      });
      _saveGame();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      GamePage(
        score: _score,
        scorePerSecond: _cps,
        onIncrementScore: _incrementScore,
      ),

      UpgradesPage(
        score: _score,
        clickPower: _clickPower,
        clickUpgradeCost: _clickUpgradeCost,
        scorePerSecond: _cps,
        upgradeCost: _upgradeCost,
        onBuyClickUpgrade: _upgradeClickPower,
        onBuyPassiveUpgrade: _upgradeCPS,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Idle Clicker'),
      ),

      body: pages.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cookie),
            label: 'Jeu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Améliorations',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _saveGame() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('score', _score);
    prefs.setInt('cps', _cps);
    prefs.setInt('upgradeCost', _upgradeCost);
    prefs.setInt('clickPower', _clickPower);
    prefs.setInt('clickUpgradeCost', _clickUpgradeCost);
  }

  Future<void> _loadGame() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _score = prefs.getInt('score') ?? 0;
      _cps = prefs.getInt('cps') ?? 0;
      _upgradeCost = prefs.getInt('upgradeCost') ?? 10;
      _clickPower = prefs.getInt('clickPower') ?? 1;
      _clickUpgradeCost = prefs.getInt('clickUpgradeCost') ?? 20;
    });
  }
}
