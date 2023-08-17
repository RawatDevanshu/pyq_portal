import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pyq_portal/models/local_paper_model.dart';
import 'models/boxes.dart';
import 'screens/student_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(LocalPaperAdapter());
  await Hive.initFlutter();
  boxPapers = await Hive.openBox<LocalPaper>('paperBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFCF4F1),
        fontFamily: "SpaceGrotesk",
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black, fontFamily: "Clarendon"),
          displayMedium:
              TextStyle(color: Colors.black, fontFamily: "SpaceGrotesk"),
          displaySmall:
              TextStyle(color: Colors.black, fontFamily: "SpaceGrotesk"),
        ),
      ),
      home: StudentHomeScreen(),
    );
  }
}

// #FCF4F1