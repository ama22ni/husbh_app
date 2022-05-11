import 'dart:async';
import 'package:flutter/material.dart';
import 'package:husbh_app/screens/addition/additionQuizScreen.dart';
import 'package:husbh_app/screens/division/divisionQuizScreen.dart';
import 'package:husbh_app/screens/multiplication/multiplicationQuizScreen.dart';
import 'package:husbh_app/screens/learn_page.dart';
import 'package:husbh_app/screens/subtraction/subtractionQuizScreen.dart';
import 'package:husbh_app/screens/subtraction/subtraction_video.dart';
import 'package:video_player/video_player.dart';
import 'Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: additionQuizScreen(),
      //home: subtractionQuizScreen(),
       home: divisionQuizScreen(),
      // home: multiplicationQuizScreen(),
     // home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      title: 'حًسبة',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      /* home: Directionality(
        // add this
        textDirection: TextDirection.rtl, // set this property
        child: SplashScreen(),
      ),*/
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Rabbit.mp4')
      ..initialize().then((value) => {setState(() {})});
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
    Timer(
        Duration(seconds: 10),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: width,
              height: height,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        //FURTHER IMPLEMENTATION
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    //const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }
}
