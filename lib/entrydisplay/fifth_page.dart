
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/loginpage.dart'; // Import the next page

// class Fifthpage extends StatelessWidget {
//   const Fifthpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Illustration (centered)
//             Expanded(
//               child: Center(
//                 child: Image.asset(
//                   'assets/image/fifthpage.png', // Replace with your actual asset path
//                   width: 150,
//                   height: 150,
//                 ),
//               ),
//             ),

//             // Text below the image
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Explore new destinations',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Pagination and "Next" button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Pagination dots
//                   Row(
//                     children: [
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
                      
//                       const SizedBox(width: 8),
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Next button
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LoginPage(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       padding: const EdgeInsets.all(12),
//                       backgroundColor: Colors.black, // Background color of the button
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// fifth_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/loginpage.dart';
import 'package:flutter_application_1/entrydisplay/third_page.dart'; // Import SmoothPageRoute

class Fifthpage extends StatelessWidget {
  const Fifthpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/image/fifthpage.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Explore new destinations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        SmoothPageRoute(page: const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.black,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}