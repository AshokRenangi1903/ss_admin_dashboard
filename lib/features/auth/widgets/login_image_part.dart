import 'package:flutter/material.dart';

class LoginImagePart extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://images.unsplash.com/photo-1519681393784-d120267933ba",
            fit: BoxFit.cover,
          ),

          // Dark vintage overlay
          Container(color: Colors.black.withAlpha(120)),

          // Highlight content
          Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SCIENCE STORIES",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "Explore the stories behind\nscientific discoveries.",
                  style: TextStyle(
                    color: Colors.white.withAlpha(220),
                    fontSize: 20,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                Container(width: 80, height: 4, color: Colors.white),

                const SizedBox(height: 20),

                Text(
                  "Admin Portal",
                  style: TextStyle(
                    color: Colors.white.withAlpha(180),
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
