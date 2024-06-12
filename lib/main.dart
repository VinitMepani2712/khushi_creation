import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/firebase_options.dart';
import 'package:khushi_creation/provider/cart_screen_provider.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:khushi_creation/provider/product_details_provider.dart';
import 'package:khushi_creation/provider/profile_provider.dart';
import 'package:khushi_creation/theme/theme_provider.dart';
import 'package:khushi_creation/screens/splash_screen/splash_screen.dart';
import 'package:khushi_creation/theme/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(lightTheme),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: const KhushiCreation(),
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
      builder: (_, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: SplashScreen(),
        );
      },
    );
  }
}
