import 'package:aventure/models/activity_model.dart';
import 'package:aventure/models/booking_model.dart';
import 'package:aventure/models/eventmanager_model.dart';
import 'package:aventure/screens/admin/Allviewbookings.dart';
import 'package:aventure/screens/admin/add_catrogry.dart';
import 'package:aventure/screens/admin/allactivitypage.dart';
import 'package:aventure/screens/admin/dashboard.dart';
import 'package:aventure/screens/admin/eventmanager_page.dart';
import 'package:aventure/screens/admin/generatereports.dart';
import 'package:aventure/screens/admin/notification.dart';
import 'package:aventure/screens/admin/paymentchart.dart';
import 'package:aventure/screens/admin/paymentdetail.dart';
import 'package:aventure/screens/admin/users_page.dart';
import 'package:aventure/screens/common/forgotpage.dart';
import 'package:aventure/screens/event_manager/Addbannerpage.dart';
import 'package:aventure/screens/event_manager/abouteventers.dart';
import 'package:aventure/screens/event_manager/addactivity.dart';
import 'package:aventure/screens/event_manager/allcreatedactivity.dart';
import 'package:aventure/screens/event_manager/cerificategenerate.dart';
import 'package:aventure/screens/event_manager/certificatetabs.dart';
import 'package:aventure/screens/event_manager/event_home.dart';
import 'package:aventure/screens/event_manager/event_reg.dart';
import 'package:aventure/banner/offer_page.dart';
import 'package:aventure/screens/common/splash_page.dart';
import 'package:aventure/screens/event_manager/eventmanager_profile.dart';
import 'package:aventure/screens/event_manager/gen_tickets.dart';
import 'package:aventure/screens/event_manager/bookinglist.dart';
import 'package:aventure/screens/event_manager/listtickets.dart';
import 'package:aventure/screens/event_manager/refundrequests.dart';
import 'package:aventure/screens/user/mybookings.dart';
import 'package:aventure/screens/user/mypayments.dart';
import 'package:aventure/screens/event_manager/mytickets.dart';
import 'package:aventure/screens/user/notification.dart';
import 'package:aventure/screens/user/refundusernoti.dart';
import 'package:aventure/screens/user/tickets.dart';
import 'package:aventure/screens/user/categorypage.dart';
import 'package:aventure/screens/user/history.dart';
import 'package:aventure/screens/user/medinfo.dart';
import 'package:aventure/screens/user/paymentpage.dart';
import 'package:aventure/screens/user/privacypolicy.dart';
import 'package:aventure/rating/view_reviews.dart';
import 'package:aventure/screens/user/termcondition.dart';
import 'package:aventure/screens/user/Activity_Booking.dart';
import 'package:aventure/screens/user/activity.dart';
import 'package:aventure/screens/user/bottom_navigation.dart';
import 'package:aventure/screens/user/explore_page.dart';
import 'package:aventure/screens/user/home_page.dart';
import 'package:aventure/screens/user/personal_info.dart';
import 'package:aventure/screens/user/profile.dart';
import 'package:aventure/screens/user/user_register_page.dart';
import 'package:aventure/screens/user/usercertificates.dart';
import 'package:aventure/screens/user/userhistorypage.dart';
import 'package:aventure/screens/user/userreviews.dart';
import 'package:aventure/screens/user/viewusertickets.dart';
import 'package:flutter/material.dart';
import 'package:aventure/screens/common/login_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'banner/addbanner.dart';
import 'firebase_options.dart';
import 'screens/common/splash2.dart';
import 'screens/user/generatereview.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/splash2': (context) => SplashTwoPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/eventregister': (context) => EventManagerRegisterPage(),
        '/admin': (context) => AdminDashboard(),
        '/listactivity': (context) => AllActivityListPage(),
        '/listbooking': (context) => AllBookingListPage(),
        '/userpage': (context) => UserPage(),
        '/paymentdetail': (context) => PaymentListScreen(),
        '/eventmanagerpage': (context) => EventManagerPage(),
        '/notifyaccess': (context) => NotificationAccess(),
        '/reports': (context) => GenerateReports(),
        '/eventhome': (context) => EventManagerHome(),
        '/addbanners': (context) => AddBannerPage(),
        '/addactivity': (context) => ActivityManager(),
        '/allactivity': (context) => AllCreatedActivitiesPage(),
        '/eventerprofile': (context) => EventersProfile(),
        '/abouteventer': (context) => EventManagerProfilePage(),
        '/refund': (context) => RefundRequestList(),
        '/certificate': (context) => CertificateTab(),
        '/viewbookings': (context) => BookingsPage(),
        '/navigation': (context) => BottomNavigationPage(),
        '/home': (context) => HomePage(),
        '/explore': (context) => ExplorePage(),
        '/category': (context) => CategoriesPage(),
        '/tickets': (context) =>PdfListPage(),
        '/history': (context) =>UserHistoryPage(userId: '',),
        '/profile': (context) => ProfilePage(),
        '/personalinfo': (context) => PersonalInfo(),
        '/privacy': (context) => PrivacyPolicyPage(),
        '/termc': (context) => TermsConditionsPage(),
        '/forgot': (context) => ForgotPage(),
        '/notificition': (context) => CombinedPage(),
        '/refundnotificition': (context) => UserNotificationPage(refund: {}),
        '/reviewuser': (context) =>  UserReviewsPage(),
        '/activity1': (context) => ActivityPage(
              activity: ActivityModel(),
            ),
        '/activitybooking': (context) => ActivityBooking(
              activity: ActivityModel(),
            ),
        '/medinfo': (context) => MedicalInfoPage(),
       //  '/payment': (context) => PaymentPage (),
        '/banner': (context) => BannerSection(),
        '/addbanner': (context) => AddBannerSection(),
        '/activityreview': (context) => ActivityReviewPage(),
        '/categorymanagement': (context) => CategoryManager(),
        '/bookinglist': (context) => BookingsPage(),
        '/ticketlist':(context)=>UserTicketsPage(userid: '',),
        '/mybookings': (context) => MyBookingList(),
        '/mycertificate': (context) => UserCertificatesPage(),
        '/mytickets': (context) =>TicketListScreen(),
        '/mypayments': (context) => PaymentHistoryPage(),
        '/generatereview': (context) => GenerateReview(activityTitle: '',),
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
        scaffoldBackgroundColor: Colors.orange,
      ),
    );
  }
}
