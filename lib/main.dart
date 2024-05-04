import 'package:aventure/models/offer_model.dart';
import 'package:aventure/screens/event_manager/event_home.dart';
import 'package:aventure/screens/event_manager/event_reg.dart';
import 'package:aventure/banner/offer_page.dart';
import 'package:aventure/screens/common/splash_page.dart';
import 'package:aventure/screens/user/air_category.dart';
import 'package:aventure/screens/user/category_pages.dart';
import 'package:aventure/screens/user/medinfo.dart';
import 'package:aventure/screens/user/mountain_category.dart';
import 'package:aventure/screens/user/road_category.dart';
import 'package:aventure/rating/view_reviews.dart';
import 'package:aventure/screens/user/water/Activity_Booking.dart';
import 'package:aventure/screens/user/water/activity.dart';
import 'package:aventure/screens/user/air/activity10.dart';
import 'package:aventure/screens/user/air/activity11.dart';
import 'package:aventure/screens/user/air/activity12.dart';
import 'package:aventure/screens/user/water/activity2.dart';
import 'package:aventure/screens/user/water/activity3.dart';
import 'package:aventure/screens/user/mountain/activity4.dart';
import 'package:aventure/screens/user/mountain/activity5.dart';
import 'package:aventure/screens/user/mountain/activity6.dart';
import 'package:aventure/screens/user/road/activity7.dart';
import 'package:aventure/screens/user/road/activity8.dart';
import 'package:aventure/screens/user/road/activity9.dart';
import 'package:aventure/screens/user/water/activity_three_booking.dart';
import 'package:aventure/screens/user/water/activity_two_booking.dart';
import 'package:aventure/screens/user/air/bookin11.dart';
import 'package:aventure/screens/user/air/booking10.dart';
import 'package:aventure/screens/user/road/booking9.dart';
import 'package:aventure/screens/user/road/booking_7.dart';
import 'package:aventure/screens/user/road/booking_8.dart';
import 'package:aventure/screens/user/mountain/booking_five.dart';
import 'package:aventure/screens/user/mountain/booking_four.dart';
import 'package:aventure/screens/user/mountain/booking_six.dart';
import 'package:aventure/screens/user/air/bookingg12.dart';
import 'package:aventure/screens/user/bottom_navigation.dart';
import 'package:aventure/screens/user/explore_page.dart';
import 'package:aventure/screens/user/home_page.dart';
import 'package:aventure/screens/user/personal_info.dart';
import 'package:aventure/screens/user/profile.dart';
import 'package:aventure/screens/user/review.dart';
import 'package:aventure/screens/user/user_register_page.dart';
import 'package:aventure/screens/user/water_category.dart';
import 'package:flutter/material.dart';
import 'package:aventure/screens/common/login_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/activitybooking',
      routes: {
        // '/': (context) => const SplashPage(),
        // '/login': (context) => LoginPage(),
        // '/register': (context) => RegisterPage(),
        // '/eventregister': (context) => EventManagerRegisterPage(),
        '/eventhome': (context) => EventManagerHome(),
        '/navigation': (context) => BottomNavigationPage(),
        '/home': (context) => HomePage(),
        '/explore': (context) => ExplorePage(),
        '/category': (context) => CategoryPage(),
        '/water': (context) => WaterCatogoryPage(),
        '/mountain': (context) => MountainCatogoryPage(),
        '/road': (context) => RoadCatogoryPage(),
        '/air': (context) => AirCatogoryPage(),
        '/profile': (context) => ProfilePage(),
        '/personalinfo': (context) => PersonalInfo(),
        '/activity1': (context) => ActivityPage(),
        '/activity2': (context) => ActivityTwoPage(),
        '/activity3': (context) => ActivityThreePage(),
        '/activity4': (context) => ActivityFourPage(),
        '/activity5': (context) => ActivityFivePage(),
        '/activity6': (context) => ActivitySixPage(),
        '/activity7': (context) => ActivitySevenPage(),
        '/activity8': (context) => ActivityEightPage(),
        '/activity9': (context) => ActivityNinePage(),
        '/activity10': (context) => ActivityTenPage(),
        '/activity11': (context) => ActivityElevenPage(),
        '/activity12': (context) => ActivityTwelvePage(),

        '/activitybooking': (context) => ActivityBooking(
              title: '',
            ),
        '/booking4': (context) => ActivityFourBooking(
              title: '',
            ),
        '/booking5': (context) => ActivityFiveBooking(
              title: '',
            ),
        '/booking6': (context) => ActivitySixBooking(
              title: '',
            ),
        '/booking7': (context) => ActivitySevenBooking(
              title: '',
            ),
        '/booking8': (context) => ActivityEightBooking(
              title: '',
            ),
        '/booking9': (context) => ActivityNineBooking(
              title: '',
            ),
        '/booking10': (context) => ActivityTenBooking(
              title: '',
            ),
        '/booking11': (context) => ActivityElevenBooking(
              title: '',
            ),
        '/booking12': (context) => ActivityTwelveBooking(
              title: '',
            ),
        '/activitybook': (context) => ActivityTwoBooking(
              title: '',
            ),
        '/booking': (context) => ActivityThreeBooking(
              title: '',
            ),
        '/medinfo': (context) => MedicalInfoPage(),
        '/banner': (context) => BannerSection(),

        '/activityreview': (context) => ActivityReviewPage(),
        '/review': (context) => ReviewListPage(
              reviews: [],
            ),
      },
      debugShowCheckedModeBanner: false,
      title: 'Aventure App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.orange,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.orange, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            displaySmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            labelSmall: TextStyle(
                color: Colors.orange, fontSize: 12, letterSpacing: 2)),
        scaffoldBackgroundColor: Colors.orange.withOpacity(0.8),
      ),
    );
  }
}
