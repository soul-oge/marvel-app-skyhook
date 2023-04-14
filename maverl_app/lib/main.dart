import 'package:flutter/material.dart';
import 'package:maverl_app/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: ((settings) => RouteGenerator.generateRoute(settings)),
      title: 'Hero App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
        ),
      ),
      //home: LandingPage(),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Home());
      case '/detail':
        return MaterialPageRoute(builder: (context) => Home());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(title: Text('Error'), centerTitle: true),
                body: Center(
                  child: Text('Page not found'),
                )));
    }
  }
}
