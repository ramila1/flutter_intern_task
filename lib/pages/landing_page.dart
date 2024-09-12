import 'package:flutter/material.dart';
import 'home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() =>
      _LandingPageState(); // Creates the state for this widget
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    // Rounded corners for the image
                    child: Image.asset(
                      "images/landing.jpeg", // Asset image for landing page
                      width: constraints.maxWidth,
                      height: constraints.maxHeight / 2,
                      fit: BoxFit.cover, // Cover the entire container
                    ),
                  ),
                ),
                const SizedBox(height: 20.0), // Spacer between image and text
                Text(
                  "News from around the\n   world for you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Text color
                    fontSize: constraints.maxWidth < 600 ? 20.0 : 26.0,
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
                const SizedBox(height: 20.0), // Spacer between texts
                Text(
                  "Best time to read, take your time to read\n   a little more of this world.",
                  textAlign: TextAlign.center, // Center-align the text
                  style: TextStyle(
                    color: Colors.black45, // Text color
                    fontSize: constraints.maxWidth < 600 ? 14.0 : 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  width: constraints.maxWidth * 0.8,
                  // Responsive width for button
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    // Rounded corners for the button
                    elevation: 5.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home()), // Navigate to Home page
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
