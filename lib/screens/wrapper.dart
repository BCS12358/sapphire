import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire/config/custom_theme.dart';
import 'package:sapphire/models/reminder/reminder.dart';
import 'package:sapphire/models/todo_list/todo_list.dart';
import 'package:sapphire/screens/add_list/add_list_screen.dart';
import 'package:sapphire/screens/add_reminder/add_reminder_screen.dart';
import 'package:sapphire/services/database_service.dart';
import 'auth/authenticate_screen.dart';
import 'home/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final customTheme = Provider.of<CustomTheme>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<TodoList>>.value(
            initialData: [],
            value: user != null
                ? DatabaseService(uid: user.uid).todoListStream()
                : null),
        StreamProvider<List<Reminder>>.value(
            initialData: [],
            value: user != null
                ? DatabaseService(uid: user.uid).reminderStream()
                : null),
      ],
      child: MaterialApp(
        title: 'Sapphire',
        initialRoute: '/',
        routes: {
          "/home": (context) => HomeScreen(),
          AddListScreen.routeName: (context) => const AddListScreen(),
          AddReminderScreen.routeName: (context) => AddReminderScreen(),
        },
        home: user != null ? HomeScreen() : Authenticate(),
        theme: customTheme.lightTheme,
        darkTheme: customTheme.darkTheme,
        themeMode: customTheme.currentTheme(),
      ),
    );
  }
}
