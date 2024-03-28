import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pyq_portal/models/local_paper_model.dart';
import 'package:pyq_portal/screens/admin/uploadpaper_screen.dart';
import 'package:pyq_portal/themeData.dart';
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
    return AdaptiveTheme(
        light: AppTheme.lightTheme,
        dark: AppTheme.darkTheme,
        initial: AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            home: StudentHomeScreen(),
          );
        });
  }
}
// #FCF4F1