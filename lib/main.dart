import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marewood_client/stores/themeProvider.dart';
import 'package:marewood_client/stores/userProvider.dart';
import 'package:provider/provider.dart';
import './config/app.dart';
import './routes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: appName,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor:themeProvider.themeColor)
            ),
            initialRoute: Routes.home,
            routes: Routes.getRoutes(),
          );
        },
      ),
      // child: MaterialApp(
      //   title: appName,
      //   theme: ThemeData(
      //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      //     // scaffoldBackgroundColor:const Color.fromARGB(255, 250, 250, 250),
      //     // appBarTheme:const AppBarTheme(
      //     //   backgroundColor: Colors.white,
      //     // ),
      //     // // bottomSheetTheme: const BottomSheetThemeData(
      //     // //     backgroundColor: Colors.white
      //     // // ),
      //     //   primaryColor: Colors.black,
      //     // useMaterial3: true,
      //     // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //     //   backgroundColor: Colors.white,
      //     // )
      //   ),
      //   initialRoute: Routes.home,
      //   routes: Routes.getRoutes(),
      // ),
    );
  }
}