import 'package:flutter/material.dart';
import './config/app.dart';
import './routes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        // bottomSheetTheme: const BottomSheetThemeData(
        //     backgroundColor: Colors.white
        // ),
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      routes: Routes.getRoutes(),
    );
  }
}