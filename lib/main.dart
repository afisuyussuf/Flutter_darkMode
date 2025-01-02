import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dark Mode',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkmode = false;
  dynamic savedThemeMode;
  late String iconAdress;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('thème sombre');
      setState(() {
        darkmode = true;
        iconAdress = 'assets/icon/dark-icon.png';
      });
    } else {
      print('thème clair');
      setState(() {
        darkmode = false;
        iconAdress = 'assets/icon/ligth-icon.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: iconAdress != null ? Image.asset(iconAdress) : Container(),
            ),
            const SizedBox(height: 70),
            const Text(
              'Changez de thème',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 250,
              child: Text(
                "Vous pouvez changer le thème de l'interface de votre application.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Mode sombre'),
              activeColor: Colors.orange,
              secondary: const Icon(Icons.nightlight_round),
              value: darkmode,
              onChanged: (bool value) {
                print(value);
                if (value == true) {
                  AdaptiveTheme.of(context).setDark();
                  iconAdress = 'assets/icon/dark-icon.png';
                } else {
                  AdaptiveTheme.of(context).setLight();
                  iconAdress = 'assets/icon/ligth-icon.png';
                }
                setState(() {
                  darkmode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
