import 'package:flutter/material.dart';
import 'HomeScreen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;


  final List<Map<String, String>> _onboardingPages = [
    {
      'image': 'images/Basketball.png',
      'title': 'Discover BasketBall World !',
      'description': 'Follow the latest matches and statistics and prepare for an exciting and challenging season.'
    },
    {
      'image': 'images/court.png',
      'title':'Track results in real-time',
      'description': 'Get instant updates on all results and follow your favorite teams'
    },
    {
      'image': 'images/player.png',
      'title': 'Join the fan community',
      'description': 'Participate in discussions, predict outcomes, and become part of the largest community of basketball fans.'
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _onboardingPages.length,
              itemBuilder: (context, index) {
                final page = _onboardingPages[index];
                return OnboardingPage(
                  imagePath: page['image']!,
                  title: page['title']!,
                  description: page['description']!,
                );
              },
            ),


            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_onboardingPages.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.deepOrangeAccent
                          : Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),


            Positioned(
              bottom: 40,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: () {
                  if (_currentPage < _onboardingPages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>  HomeScreen()),
                    );
                  }
                },
                child: Icon(
                  _currentPage == _onboardingPages.length - 1
                      ? Icons.check
                      : Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}