import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ScreenLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://txfkhkwonpadlsuteyeb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4Zmtoa3dvbnBhZGxzdXRleWViIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0MzY0MjMsImV4cCI6MjA0NDAxMjQyM30.yjVzzlI0vjbxqHes7zRh_nlmNeY2ez0BGsUti4_Fkbs',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Supabase',
      debugShowCheckedModeBanner: false,
      home: ScreenLogin(),
    );
  }
}
