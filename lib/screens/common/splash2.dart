import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SplashTwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   "assets/img/splashimg.jpg", // Replace with your image path
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   height: double.infinity,
        // ),


        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height, // Adjust height to screen height
            aspectRatio: 16 / 9, // Adjust aspect ratio as needed
            viewportFraction: 1.0, // Each image takes up the entire screen width
            autoPlay: true, // Enable auto-play for sliding images
            autoPlayInterval: Duration(seconds: 2), // Set auto-play interval
            autoPlayAnimationDuration: Duration(milliseconds: 800), // Set animation duration
            autoPlayCurve: Curves.fastOutSlowIn, // Set animation curve
            pauseAutoPlayOnTouch: true, // Pause auto-play when user touches the slider
            enlargeCenterPage: false, // Set to true if you want the center image to be larger
            enableInfiniteScroll: true, // Enable infinite scroll
          ),
          items: [
            "assets/img/splashimg.jpg",
            "assets/img/splashimg3.jpg",
            "assets/img/splashimg2.jpg",
            // Add more image paths as needed
          ].map((item) {
            return Image.asset(
              item,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            );
          }).toList(),
        ),


        // Curve container
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.53,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: CurvePainter(color: Colors.orange.shade600),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: CurvePainter(color: Colors.white70),
            ),
          ),
        ),
        // Get Started button
        Positioned(
          bottom: 10.0,
          right: 100.0,
          left: 90.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Find your ADVENTURE",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black, decoration: TextDecoration.none),
              ),SizedBox(height: 3),

                  // Text("Fuel your passion for adventure with our app, your steadfast guide through every exhilarating moment. Packed with all the resources you need to make every thrill unforgettable!",
                  //   style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal,color: Colors.orange, decoration: TextDecoration.none),),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Set the border radius
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text(
                      "    Get Started  ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class CurvePainter extends CustomPainter {
  final Color color;

  CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);

    // Draw a C-shaped curve using quadratic bezier curve
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.6,
      size.width,
      0,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
