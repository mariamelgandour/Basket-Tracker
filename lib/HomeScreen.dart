import 'package:flutter/material.dart';
import 'PlayerDescriptionScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<MatchData> matches = const [
    MatchData(
      league: 'NBA',
      team1: 'Miami Heat',
      team2: 'Milwaukee Bucks',
      time: '20:30 (UTC)',
    ),
    MatchData(
      league: 'NBA',
      team1: 'Otago Nuggets',
      team2: 'Auckland Tuatara',
      time: '22:00 (UTC)',
    ),
    MatchData(
      league: 'Liga A',
      team1: 'Gimnasia',
      team2: 'San Martín',
      time: '23:30 (UTC)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today Matches'),
        titleTextStyle: TextStyle(color: Colors.white,
            fontSize: 20 ,
            fontWeight: FontWeight.bold
        ),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: matches.length * 2, // Duplicate for demo
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final match = matches[index % matches.length];
          return MatchCard(match: match);
        },
      ),
    );
  }
}

@immutable
class MatchData {
  final String league;
  final String team1;
  final String team2;
  final String time;

  const MatchData({
    required this.league,
    required this.team1,
    required this.team2,
    required this.time,
  });
}

class MatchCard extends StatelessWidget {
  final MatchData match;

  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToPlayerScreen(context),
        splashColor: Colors.orange.withOpacity(0.2),
        highlightColor: Colors.orange.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildLeagueHeader(),
              const SizedBox(height: 16),
              _buildTeamsRow(),
              const SizedBox(height: 16),
              _buildTimeFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.orange[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        match.league,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTeamsRow() {
    return Row(
      children: [
        _buildTeamColumn(match.team1),
        const Spacer(),
        _buildVsText(),
        const Spacer(),
        _buildTeamColumn(match.team2),
      ],
    );
  }

  Widget _buildTeamColumn(String teamName) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            teamName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          const Icon(
            Icons.sports_basketball,
            size: 28,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildVsText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: const Text(
        'VS',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildTimeFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.access_time, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            match.time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPlayerScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PlayerDescriptionScreen(
          matchDetails: {
            'team1': match.team1,
            'team2': match.team2,
            'league': match.league,
            'time': match.time,
          },
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}