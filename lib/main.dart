import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khushi_creation/firebase_options.dart';
import 'package:khushi_creation/provider/cart_screen_provider.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:khushi_creation/provider/product_details_provider.dart';
import 'package:khushi_creation/screens/location/location_screen.dart';
// import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:khushi_creation/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const KhushiCreation());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProviderScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsProvider(),
        ),
      ],
      child: KhushiCreation(),
    ),
  );
}

class KhushiCreation extends StatelessWidget {
  const KhushiCreation({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 255, 255, 255),
          ),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
