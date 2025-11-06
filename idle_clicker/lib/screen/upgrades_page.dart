import 'package:flutter/material.dart';

class UpgradesPage extends StatelessWidget {
  final int score;
  final int clickPower;
  final int clickUpgradeCost;
  final int scorePerSecond;
  final int upgradeCost;

  final Function() onBuyClickUpgrade;
  final Function() onBuyPassiveUpgrade;

  const UpgradesPage({
    super.key,
    required this.score,
    required this.clickPower,
    required this.clickUpgradeCost,
    required this.scorePerSecond,
    required this.upgradeCost,
    required this.onBuyClickUpgrade,
    required this.onBuyPassiveUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.mouse),
          title: Text('Puissance du Clic (+1)'),
          subtitle: Text(
            'Niveau actuel : $clickPower\nCoût : $clickUpgradeCost',
          ),
          trailing: ElevatedButton(
            onPressed: (score >= clickUpgradeCost) ? onBuyClickUpgrade : null,
            child: const Text('Acheter'),
          ),
        ),

        ListTile(
          leading: const Icon(Icons.settings_input_antenna),
          title: Text('Revenu Passif (+1/sec)'),
          subtitle: Text(
            'Niveau actuel : $scorePerSecond\nCoût : $upgradeCost',
          ),
          trailing: ElevatedButton(
            onPressed: (score >= upgradeCost) ? onBuyPassiveUpgrade : null,
            child: const Text('Acheter'),
          ),
        ),
      ],
    );
  }
}
