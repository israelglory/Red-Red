import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_red_group/home.dart';
import 'package:red_red_group/model/create_user.dart';
import 'package:red_red_group/model/service.dart';
import 'package:red_red_group/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red & Red Group',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      //themeMode: ThemeMode.light,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
