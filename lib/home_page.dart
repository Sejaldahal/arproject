import 'package:flutter/material.dart';
import 'screens/favorites_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/location_screen.dart';
import 'screens/profile_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'screens/temple_detail_screen.dart';

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

class TempleCarousel extends StatefulWidget {
  final List<Map<String, String>> temples;

  const TempleCarousel({
    super.key,
    required this.temples,
  });

  @override
  State<TempleCarousel> createState() => _TempleCarouselState();
}

class _TempleCarouselState extends State<TempleCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: _currentPage,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Temples',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF281202),
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFFB35D1E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.temples.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.synchronized(
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildCarouselItem(index),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildPageIndicator(),
      ],
    );
  }
  Widget _buildCarouselItem(int index) {
  final temple = widget.temples[index];
  final isCurrentPage = index == _currentPage;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => TempleDetailScreen(
            templeName: temple['name']!,
            imageUrl: temple['image']!,
            description: temple['description']!,
            rating: 4.7, // You can modify this or pass an actual rating if available
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
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isCurrentPage ? 0 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              temple['image']!,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    temple['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    temple['description']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  // Widget _buildCarouselItem(int index) {
  //   final temple = widget.temples[index];
  //   final isCurrentPage = index == _currentPage;


  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOutQuint,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: 8,
  //       vertical: isCurrentPage ? 0 : 8,
  //     ),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.brown.withOpacity(0.2),
  //           spreadRadius: 2,
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20),
  //       child: Stack(
  //         fit: StackFit.expand,
  //         children: [
  //           Image.asset(
  //             temple['image']!,
  //             fit: BoxFit.cover,
  //           ),
  //           Container(
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 begin: Alignment.topCenter,
  //                 end: Alignment.bottomCenter,
  //                 colors: [
  //                   Colors.transparent,
  //                   Colors.black.withOpacity(0.7),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 16,
  //             left: 16,
  //             right: 16,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   temple['name']!,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   temple['description']!,
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     color: Colors.white.withOpacity(0.9),
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.temples.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xFF8B4513)
                : Colors.brown.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
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
  List<Map<String, dynamic>> get popularFood => const [
        {
          'name': 'Juju Dhau',
          'image': 'assets/image/juju_dhau.jpg',
          'price': 'NPR 100',
          'rating': 4.8,
        },
        {
          'name': 'Yomari',
          'image': 'assets/image/yomari.jpeg',
          'price': 'NPR 80',
          'rating': 4.6,
        },
        {
          'name': 'Samay Baji',
          'image': 'assets/image/samay_baji.jpeg',
          'price': 'NPR 200',
          'rating': 4.7,
        },
      ];

  List<Map<String, dynamic>> get upcomingEvents => const [
        {
          'name': 'Bisket Jatra',
          'image': 'assets/image/Bisket_Jatra_VIbes.jpg',
          'date': 'April 14-22, 2024',
          'location': 'Bhaktapur Durbar Square',
        },
        {
          'name': 'Gai Jatra',
          'image': 'assets/image/gaijatra.png',
          'date': 'August 15, 2024',
          'location': 'Throughout Bhaktapur',
        },
        {
          'name': 'Indra Jatra',
          'image': 'assets/image/indrajatra.png',
          'date': 'September 20, 2024',
          'location': 'Taumadhi Square',
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
        child: ListView(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              _buildSearchBar(),
              TempleCarousel(temples: temples),
              const SizedBox(height: 24),
              _buildPopularFoodSection(),
              const SizedBox(height: 24),
              _buildUpcomingEventsSection(),
              const SizedBox(height: 24),
            ],
          ),
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

  Widget _buildPopularFoodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Popular Local Food',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF281202),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: popularFood.length,
            itemBuilder: (context, index) {
              final food = popularFood[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        food['image']!,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                food['price']!,
                                style: const TextStyle(
                                  color: Color(0xFFB35D1E),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                food['rating'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF281202),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: upcomingEvents.length,
          itemBuilder: (context, index) {
            final event = upcomingEvents[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                    child: Image.asset(
                      event['image']!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Color(0xFFB35D1E),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                event['date']!,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Color(0xFFB35D1E),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                event['location']!,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}  


//   Widget _buildSearchBar() {
//     return TweenAnimationBuilder(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: const Duration(milliseconds: 800),
//       builder: (context, double value, child) {
//         return Transform.translate(
//           offset: Offset(0, (1 - value) * 50),
//           child: Opacity(
//             opacity: value,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search temples...',
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: const Icon(Icons.tune),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.9),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // Widget _buildFilterChips() {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //       children: [
//   //         _buildAnimatedChip('Places'),
//   //         _buildAnimatedChip('Food'),
//   //         _buildAnimatedChip('Events'),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildAnimatedChip(String label) {
//     return TweenAnimationBuilder(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: const Duration(milliseconds: 500),
//       builder: (context, double value, child) {
//         return Transform.scale(
//           scale: value,
//           child: Chip(
//             label: Text(
//               label,
//               style: const TextStyle(color: Colors.white),
//             ),
//             backgroundColor: const Color(0xFF8B4513),
//           ),
//         );
//       },
//     );
//   }
//
//
//   // Widget _buildFilterChips() {
//   //   return SingleChildScrollView(
//   //     scrollDirection: Axis.horizontal,
//   //     padding: const EdgeInsets.symmetric(horizontal: 16),
//   //     child: Row(
//   //       children: AnimationConfiguration.toStaggeredList(
//   //         duration: const Duration(milliseconds: 500),
//   //         childAnimationBuilder: (widget) => SlideAnimation(
//   //           horizontalOffset: 50.0,
//   //           child: FadeInAnimation(child: widget),
//   //         ),
//   //         children: [
//   //           _buildAnimatedChip('Places'),
//   //           const SizedBox(width: 8),
//   //           _buildAnimatedChip('Food'),
//   //           const SizedBox(width: 8),
//   //           _buildAnimatedChip('Events'),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   // Widget _buildAnimatedChip(String label) {
//   //   return TweenAnimationBuilder(
//   //     tween: Tween<double>(begin: 0, end: 1),
//   //     duration: const Duration(milliseconds: 500),
//   //     builder: (context, double value, child) {
//   //       return Transform.scale(
//   //         scale: value,
//   //         child: Chip(
//   //           label: Text(
//   //             label,
//   //             style: const TextStyle(color: Colors.white),
//   //           ),
//   //           backgroundColor: const Color(0xFF8B4513),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//
//   Widget _buildTempleGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       itemCount: temples.length,
//       itemBuilder: (context, index) {
//         return AnimationConfiguration.staggeredGrid(
//           position: index,
//           duration: const Duration(milliseconds: 500),
//           columnCount: 2,
//           child: ScaleAnimation(
//             child: FadeInAnimation(
//               child: _buildTempleCard(context, temples[index]),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildTempleCard(BuildContext context, Map<String, String> temple) {
//     return GestureDetector(
//         onTap: () {
//       Navigator.push(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               TempleDetailScreen(
//                 templeName: temple['name']!,
//                 imageUrl: temple['image']!,
//                 description: temple['description']!,
//                 rating: 4.7,
//               ),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation,
//               child: child,
//             );
//           },
//         ),
//       );
//     },
//     child: Hero(
//     tag: temple['name']!,
//     child: Card(
//     elevation: 5,
//     shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(15),
//     ),
//     child: Container(
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(15),
//     boxShadow: [
//     BoxShadow(
//     color: Colors.brown.withOpacity(0.2),
//     spreadRadius: 2,
//     blurRadius: 5,
//       offset: const Offset(0, 3),
//     ),
//     ],
//     ),
//       child: Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius:
//               const BorderRadius.vertical(top: Radius.circular(15)),
//               child: Image.asset(
//                 temple['image']!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius:
//               BorderRadius.vertical(bottom: Radius.circular(15)),
//             ),
//             child: Text(
//               temple['name']!,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF8B4513),
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     ),
//     ),
//     ),
//     );
//   }
// }
//
// // Create a bare minimum TempleDetailScreen for the app to compile
// class TempleDetailScreen extends StatelessWidget {
//   final String templeName;
//   final String imageUrl;
//   final String description;
//   final double rating;
//
//   const TempleDetailScreen({
//     super.key,
//     required this.templeName,
//     required this.imageUrl,
//     required this.description,
//     required this.rating,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(templeName),
//               background: Hero(
//                 tag: templeName,
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.all(16.0),
//             sliver: SliverList(
//               delegate: SliverChildListDelegate([
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                       size: 24,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       rating.toString(),
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   description,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     height: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF8B4513),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Plan Visit',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Create placeholder screens for the bottom navigation
// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Favorites Screen'),
//       ),
//     );
//   }
// }
//
// class CameraScreen extends StatelessWidget {
//   const CameraScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Camera Screen'),
//       ),
//     );
//   }
// }
//
// class LocationScreen extends StatelessWidget {
//   const LocationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Location Screen'),
//       ),
//     );
//   }
// }
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Profile Screen'),
//       ),
//     );
//   }
// }


