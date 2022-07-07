import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:people_repository/people_repository.dart';

import 'people/people.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  initHive();
  runApp(
    RepositoryProvider<PeopleRepository>(
      create: (context) => PeopleRepository(),
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
        ],
        path: 'assets/translations',
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squadio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularPeoplePage(),
    );
  }
}

void initHive() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(PeoplePageAdapter());
    await Hive.openBox('zidoBox');
  } catch (_) {}
}

