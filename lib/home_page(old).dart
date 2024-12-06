import 'package:flutter/material.dart';
import 'screens/favorites_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/location_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/temple_detail_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


void main() {
  runApp(const HistoryApp());
}

class HistoryApp extends StatelessWidget {
  const HistoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Histoury',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFDE6D5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B4513),
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const FavoritesScreen(),
    const CameraScreen(),
    const LocationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF8B4513),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  final List<Map<String, String>> temples = const [
    {
      'name': 'Nyatapola Temple',
      'image': 'assets/image/nyatapola.jpg',
      'description':
      'Nyatapola Temple is a five-tiered temple located in Bhaktapur, Nepal. It is the tallest monument within the city and is also the tallest temple in Nepal.',
    },
    {
      'name': 'Bhaktapur Durbar Square',
      'image': 'assets/image/bhaktapur.png',
      'description':
      'Bhaktapur Durbar Square is a historic site in Bhaktapur, featuring ancient architecture, temples, and cultural heritage.',
    },
    {
      'name': 'Dattatreya Temple',
      'image': 'assets/image/dattatreya.png',
      'description':
      'Dattatreya Temple is an ancient temple in Bhaktapur known for its intricate wooden carvings and historical significance.',
    },
    {
      'name': 'Changu Narayan Temple',
      'image': 'assets/image/changunarayan.png',
      'description':
      'Changu Narayan Temple is one of the oldest Hindu temples in Nepal, dedicated to Lord Vishnu and located on a hilltop near Bhaktapur.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'HISTOURY',
                  speed: const Duration(milliseconds: 200),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
              isRepeatingAnimation: false,
            ),
            const SizedBox(width: 8),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Image.asset(
                    'assets/image/temple_icon.png',
                    height: 30,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: AnimationLimiter(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildFilterChips(),
            _buildTempleGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search temples...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildAnimatedChip('Places'),
            const SizedBox(width: 8),
            _buildAnimatedChip('Food'),
            const SizedBox(width: 8),
            _buildAnimatedChip('Events'),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedChip(String label) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Chip(
            label: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF8B4513),
          ),
        );
      },
    );
  }

  Widget _buildTempleGrid() {
    return Expanded(
      child: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: temples.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: _buildTempleCard(context, temples[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTempleCard(BuildContext context, Map<String, String> temple) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                TempleDetailScreen(
                  templeName: temple['name']!,
                  imageUrl: temple['image']!,
                  description: temple['description']!,
                  rating: 4.7,
                ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Hero(
        tag: temple['name']!,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      temple['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
                  ),
                  child: Text(
                    temple['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


