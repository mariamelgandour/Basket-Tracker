import 'package:flutter/material.dart';

class PlayerDescriptionScreen extends StatefulWidget {
  final Map<String, dynamic> matchDetails;

  const PlayerDescriptionScreen({
    super.key,
    required this.matchDetails,
  });

  @override
  State<PlayerDescriptionScreen> createState() => _PlayerDescriptionScreenState();
}

class _PlayerDescriptionScreenState extends State<PlayerDescriptionScreen> {
  int _homeTeamScore = 0;
  int _awayTeamScore = 0;

  void _addPoints(String team, int points) {
    setState(() {
      if (team == 'home') {
        _homeTeamScore +=  points;
      } else {
        _awayTeamScore += points;
      }
    });
  }

  void _resetScores() {
    setState(() {
      _homeTeamScore = 0;
      _awayTeamScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.matchDetails['team1']} vs ${widget.matchDetails  ['team2']}',
        ),
        titleTextStyle: TextStyle(color: Colors.white,
          fontSize: 16 ,
          fontWeight: FontWeight.bold
        ),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
         iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetScores,
            color: Colors.white,
            tooltip: 'Reset Scores',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              color: Colors.grey[200],
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.matchDetails['league'] ?? 'No League',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.matchDetails['time'] ?? 'No Time',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            SizedBox(
              height: 220,
              child: PlayerStatsCard(
                playerName: '${widget.matchDetails['team1']} Player',
                score: _homeTeamScore,
                onAddPoints: (points) => _addPoints('home', points),
                cardColor: Colors.grey[400]!,
                buttonColor: Colors.orange[800]!,
              ),
            ),
            const SizedBox(height: 20),


            SizedBox(
              height: 220,
              child: PlayerStatsCard(
                playerName: '${widget.matchDetails['team2']} Player',
                score: _awayTeamScore,
                onAddPoints: (points) =>  _addPoints('away', points),
                  cardColor: Colors.grey[400]!,
                  buttonColor: Colors.orange[800]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerStatsCard extends StatelessWidget {
  final String playerName;
  final int score;
  final Function(int) onAddPoints;
  final Color cardColor;
  final Color buttonColor;

  const PlayerStatsCard({
    super.key,
    required this.playerName,
    required this.score,
    required this.onAddPoints,
    required this.cardColor,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Player Name
            Text(
              playerName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Points
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPointButton(1, '1 Point'),
                _buildPointButton(2, '2 Points'),
                _buildPointButton(3, '3 Points'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointButton(int points, String label) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          onPressed: () => onAddPoints(points),
          child: Text(
            '+$points',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}