import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:husbh_app/screens/login_screen.dart';
import 'WaitingScreen.dart';
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timelines/timelines.dart';
//bool WaitingScreen = false;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage()));
// }

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
  //const ProfilePage({Key? key}) : super(key: key);
  String? email;
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  var id;
  var email;
  var name;
  var age;
  var sex;

  //add
  var addLevel1 = []; //جمع الآحاد
  var currentScoreAddL1 = 0;
  var secondScoreAddL1 = 0;
  var thirdScoreAddL1 = 0;

  var addLevel2 = []; //جمع العشرات
  var currentScoreAddL2 = 0;
  var secondScoreAddL2 = 0;
  var thirdScoreAddL2 = 0;

  var addLevel3 = []; //جمع المئات
  var currentScoreAddL3 = 0;
  var secondScoreAddL3 = 0;
  var thirdScoreAddL3 = 0;

  var addTotal = 0; //مجموع آخر محاولة من كل ليفيل

  ////////////////////////////////////

  //sub
  var subLevel1 = []; //طرح الآحاد
  var currentScoreSubL1 = 0;
  var secondScoreSubL1 = 0;
  var thirdScoreSubL1 = 0;

  var subLevel2 = []; //طرح العشرات
  var currentScoreSubL2 = 0;
  var secondScoreSubL2 = 0;
  var thirdScoreSubL2 = 0;

  var subLevel3 = []; //طرح المئات
  var currentScoreSubL3 = 0;
  var secondScoreSubL3 = 0;
  var thirdScoreSubL3 = 0;
  var subTotal = 0; //مجموع آخر محاولة من كل ليفيل

  //multiplication

  var mulLevel1 = []; // ضرب 0,1,2,4
  var currentScoreMulL1 = 0;
  var secondScoreMulL1 = 0;
  var thirdScoreMulL1 = 0;

  var mulLevel2 = []; // ضرب 3,6,5,10
  var currentScoreMulL2 = 0;
  var secondScoreMulL2 = 0;
  var thirdScoreMulL2 = 0;

  var mulLevel3 = []; // ضرب 7,8,9
  var currentScoreMulL3 = 0;
  var secondScoreMulL3 = 0;
  var thirdScoreMulL3 = 0;

  var mulTotal = 0; //مجموع آخر محاولة من كل ليفيل

  //division
  var divLevel1 = []; // قسمة 0,2,5,10
  var currentScoreDivL1 = 0;
  var secondScoreDivL1 = 0;
  var thirdScoreDivL1 = 0;

  var divLevel2 = []; // قسمة 1,3,4,6
  var currentScoreDivL2 = 0;
  var secondScoreDivL2 = 0;
  var thirdScoreDivL2 = 0;

  var divLevel3 = []; // قسمة 7,8,9
  var currentScoreDivL3 = 0;
  var secondScoreDivL3 = 0;
  var thirdScoreDivL3 = 0;
  var divlTotal = 0; //مجموع آخر محاولة من كل ليفيل

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
    getCurrentUser();
  }

  onRefresh(userCare) {
    setState(() {
      user = userCare;
    });
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        //  email = signedInUser.email;
        id = signedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["email"] != null && doc["email"] == signedInUser.email) {
          email = doc['email'];
          name = doc['name'];
          age = doc['age'];
          if (age == '٢') {
            age = 'سنتان';
          } else {
            age = age + ' سنوات ';
          }
          sex = doc['sex'];
          addLevel1 = doc['addLevel1'];
          addLevel2 = doc['addLevel2'];
          addLevel3 = doc['addLevel3'];
          if (addLevel1.isNotEmpty) {
            currentScoreAddL1 = addLevel1[addLevel1.length - 1] as int;
          }
          if (addLevel2.isNotEmpty) {
            currentScoreAddL2 = addLevel2[addLevel2.length - 1] as int;
          }
          if (addLevel3.isNotEmpty) {
            currentScoreAddL3 = addLevel3[addLevel3.length - 1] as int;
          }
          if (addLevel1.isNotEmpty) {
            secondScoreAddL1 = addLevel1[addLevel1.length - 2] as int;
          }
          if (addLevel2.isNotEmpty) {
            secondScoreAddL2 = addLevel2[addLevel2.length - 2] as int;
          }
          if (addLevel3.isNotEmpty) {
            secondScoreAddL3 = addLevel3[addLevel3.length - 2] as int;
          }
          if (addLevel1.isNotEmpty) {
            thirdScoreAddL1 = addLevel1[addLevel1.length - 3] as int;
          }
          if (addLevel2.isNotEmpty) {
            thirdScoreAddL2 = addLevel2[addLevel2.length - 3] as int;
          }
          if (addLevel3.isNotEmpty) {
            thirdScoreAddL3 = addLevel3[addLevel3.length - 3] as int;
          }

          subLevel1 = doc['subLevel1'];
          subLevel2 = doc['subLevel2'];
          subLevel3 = doc['subLevel3'];
          subTotal = subLevel1[subLevel1.length - 1] +
              subLevel2[subLevel2.length - 1] +
              subLevel3[subLevel3.length - 1];
          if (subLevel1.isNotEmpty) {
            currentScoreSubL1 = subLevel1[subLevel1.length - 1] as int;
          }
          if (subLevel2.isNotEmpty) {
            currentScoreSubL2 = subLevel2[subLevel2.length - 1] as int;
          }
          if (subLevel3.isNotEmpty) {
            currentScoreSubL3 = subLevel3[subLevel3.length - 1] as int;
          }
          if (subLevel1.isNotEmpty) {
            secondScoreSubL1 = subLevel1[subLevel1.length - 2] as int;
          }
          if (subLevel2.isNotEmpty) {
            secondScoreSubL2 = subLevel2[subLevel2.length - 2] as int;
          }
          if (subLevel3.isNotEmpty) {
            secondScoreSubL3 = subLevel3[subLevel3.length - 2] as int;
          }
          if (subLevel1.isNotEmpty) {
            thirdScoreMulL1 = subLevel1[subLevel1.length - 3] as int;
          }
          if (subLevel2.isNotEmpty) {
            thirdScoreSubL2 = subLevel2[subLevel2.length - 3] as int;
          }
          if (subLevel3.isNotEmpty) {
            thirdScoreSubL3 = subLevel3[subLevel3.length - 3] as int;
          }

          mulLevel1 = doc['mulLevel1'];
          mulLevel2 = doc['mulLevel2'];
          mulLevel3 = doc['mulLevel3'];
          mulTotal = mulLevel1[mulLevel1.length - 1] +
              mulLevel2[mulLevel2.length - 1] +
              mulLevel3[mulLevel3.length - 1];
          if (mulLevel1.isNotEmpty) {
            currentScoreMulL1 = mulLevel1[mulLevel1.length - 1] as int;
          }
          if (mulLevel2.isNotEmpty) {
            currentScoreMulL2 = mulLevel2[mulLevel2.length - 1] as int;
          }
          if (mulLevel3.isNotEmpty) {
            currentScoreMulL3 = mulLevel3[mulLevel3.length - 1] as int;
          }
          if (mulLevel1.isNotEmpty) {
            secondScoreMulL1 = mulLevel1[mulLevel1.length - 2] as int;
          }
          if (mulLevel2.isNotEmpty) {
            secondScoreMulL2 = mulLevel2[mulLevel2.length - 2] as int;
          }
          if (mulLevel3.isNotEmpty) {
            secondScoreMulL3 = mulLevel3[mulLevel3.length - 2] as int;
          }
          if (mulLevel1.isNotEmpty) {
            thirdScoreMulL1 = mulLevel1[mulLevel1.length - 3] as int;
          }
          if (mulLevel2.isNotEmpty) {
            thirdScoreMulL2 = mulLevel2[mulLevel2.length - 3] as int;
          }
          if (mulLevel3.isNotEmpty) {
            thirdScoreMulL3 = mulLevel3[mulLevel3.length - 3] as int;
          }
          divLevel1 = doc['divLevel1'];
          divLevel2 = doc['divLevel2'];
          divLevel3 = doc['divLevel3'];
          mulTotal = divLevel1[divLevel1.length - 1] +
              divLevel2[divLevel2.length - 1] +
              divLevel3[divLevel3.length - 1];
          if (divLevel1.isNotEmpty) {
            currentScoreDivL1 = divLevel1[divLevel1.length - 1] as int;
          }
          if (divLevel2.isNotEmpty) {
            currentScoreDivL2 = divLevel2[divLevel2.length - 1] as int;
          }
          if (divLevel3.isNotEmpty) {
            currentScoreDivL3 = divLevel3[divLevel3.length - 1] as int;
          }
          if (divLevel1.isNotEmpty) {
            secondScoreDivL1 = divLevel1[divLevel1.length - 2] as int;
          }
          if (divLevel2.isNotEmpty) {
            secondScoreDivL2 = divLevel2[divLevel2.length - 2] as int;
          }
          if (divLevel3.isNotEmpty) {
            secondScoreDivL3 = divLevel3[divLevel3.length - 2] as int;
          }
          if (divLevel1.isNotEmpty) {
            thirdScoreDivL1 = divLevel1[divLevel1.length - 3] as int;
          }
          if (divLevel2.isNotEmpty) {
            thirdScoreDivL2 = divLevel2[divLevel2.length - 3] as int;
          }
          if (divLevel3.isNotEmpty) {
            thirdScoreDivL3 = divLevel3[divLevel3.length - 3] as int;
          }
          print(name);
        }
      });
    });
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    getData();
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: getData(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Scaffold(
                    body: Stack(
                      children: [
                        Container(
                          width: MediaQuery.maybeOf(context)?.size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))),
                          // child: Text("plase wait")
                        ),
                        WaitingScreen(),
                      ],
                    ),
                  )

                // محتوى الصفحة
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      backgroundColor: Colors.amber[300],
                      extendBodyBehindAppBar: true,
                      body: SafeArea(
                        child: Stack(
                          children: [
                            //زر الرجوع
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);

                                  // add new scores to first level
                                  // addLevel1 = addLevel1 + [45];
                                  // FirebaseFirestore.instance
                                  //     .collection("users")
                                  //     .doc(user.uid)
                                  //     .update({
                                  //   "addAhad": addLevel1
                                  // });

                                  var i = addLevel1.length - 1;
                                  var j = 0;
                                  var current = addLevel1[i];
                                  var last = addLevel1[i - 1];
                                  var last2 = addLevel1[i - 2];
                                  print(last2);
                                  for (var j = 0; j < 3; j++) {
                                    print(addLevel1[i]);
                                    --i;
                                  }

                                  // FirebaseFirestore.instance
                                  //     .collection("users")
                                  //     .doc(user.uid)
                                  //     .update({
                                  //   "addAhad": FieldValue.arrayUnion(addAhad)
                                  // });
                                },
                                icon: Icon(Icons.arrow_back_ios),
                                color: Color(0xff4A4857),
                              ),
                            ),
                            //زر تسجيل الخروج
                            Align(
                                alignment: Alignment.topLeft,
                                child: Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        //if there is missing info this will be displayed
                                        context: context,
                                        dialogType: DialogType.WARNING,
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 2),
                                        width: 280,

                                        buttonsBorderRadius: BorderRadius.all(
                                            Radius.circular(2)),
                                        headerAnimationLoop: false,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title:
                                            'هل تريد تسجيل الخروج من التطبيق؟',
                                        btnCancelText: "إلغاء",
                                        btnOkText: "نعم",
                                        // desc:
                                        //     'هل أنت متأكد؟',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()),
                                          );
                                        },
                                        showCloseIcon: true,
                                      ).show();
                                    },
                                    icon: Icon(Icons.logout_rounded),
                                    color: Color(0xff4A4857),
                                  ),
                                )),

                            //الجزء الابيض اللي فيه المحتوى
                            Container(
                              margin: EdgeInsets.only(top: 110.0),
                              height: height,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                            ),

                            // progress
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 150, right: 20),
                              child: Row(
                                children: [
                                  //الكونتينر الأبيض حق تقاريري
                                  Container(
                                    height: height / 2,
                                    width: width * 0.42,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            'تقاريري',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'ReadexPro',
                                              color: Colors.brown,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // تقاريري
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 20,
                                            ),
                                            child: GridView(
                                                shrinkWrap: true,
                                                children: [
                                                  //الكونتينر البرتقالي حق الجمع
                                                  GestureDetector(
                                                    onTap: () {
                                                      addTotal = 0;
                                                      print("add");
                                                      print(addLevel1[
                                                          addLevel1.length -
                                                              1]);
                                                      print(addLevel2[
                                                          addLevel2.length -
                                                              1]);
                                                      if (addLevel1
                                                          .isNotEmpty) {
                                                        addTotal += addLevel1[
                                                            addLevel1.length -
                                                                1] as int;
                                                      }
                                                      if (addLevel2
                                                          .isNotEmpty) {
                                                        addTotal += addLevel2[
                                                            addLevel2.length -
                                                                1] as int;
                                                        print('5555');
                                                      }
                                                      if (addLevel3
                                                          .isNotEmpty) {
                                                        addTotal += addLevel3[
                                                            addLevel3.length -
                                                                1] as int;
                                                      }
                                                      print(addTotal);
                                                      // البوب اب ويندو
                                                      popUpWindow(
                                                        context,
                                                        height,
                                                        width,
                                                        addTotal,
                                                        '     جمع الآحاد',
                                                        "جمع العشرات",
                                                        "    جمع المئات",
                                                        currentScoreAddL1,
                                                        secondScoreAddL1,
                                                        thirdScoreAddL1,
                                                        currentScoreAddL2,
                                                        secondScoreAddL2,
                                                        thirdScoreAddL2,
                                                        currentScoreAddL3,
                                                        secondScoreAddL3,
                                                        thirdScoreAddL3,
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[500],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[400]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //الكونتينر البرتقالي حق الطرح
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("subtract");

                                                      popUpWindow(
                                                          context,
                                                          height,
                                                          width,
                                                          subTotal,
                                                          '     طرح الآحاد',
                                                          "طرح العشرات",
                                                          "   طرح المئات",
                                                          currentScoreSubL1,
                                                          secondScoreSubL1,
                                                          thirdScoreSubL1,
                                                          currentScoreSubL2,
                                                          secondScoreSubL2,
                                                          thirdScoreSubL2,
                                                          currentScoreSubL3,
                                                          secondScoreSubL3,
                                                          thirdScoreSubL3);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[400],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[300]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //الكونتينر البرتقالي حق الضرب
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("multiplcation");

                                                      popUpWindow(
                                                          context,
                                                          height,
                                                          width,
                                                          subTotal,
                                                          '  ضرب (۰,۱,۲,٤)',
                                                          "ضرب (٥,۱۰, ۳,٦)",
                                                          "   ضرب (۹, ٧,۸)",
                                                          currentScoreMulL1,
                                                          secondScoreMulL1,
                                                          thirdScoreMulL1,
                                                          currentScoreMulL2,
                                                          secondScoreMulL2,
                                                          thirdScoreMulL2,
                                                          currentScoreMulL3,
                                                          secondScoreMulL3,
                                                          thirdScoreMulL3);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[300],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[200]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'x',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 30,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //الكونتينر البرتقالي حق القسمة
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("division");

                                                      popUpWindow(
                                                        context,
                                                        height,
                                                        width,
                                                        subTotal,
                                                        'قسمة (۰,۲,٥,۱۰)',
                                                        "قسمة (٤,٦, ۱,۳)",
                                                        "  قسمة (۹, ٧,۸)",
                                                        currentScoreDivL1,
                                                        secondScoreDivL1,
                                                        thirdScoreDivL1,
                                                        currentScoreDivL2,
                                                        secondScoreDivL2,
                                                        thirdScoreDivL2,
                                                        currentScoreDivL3,
                                                        secondScoreDivL3,
                                                        thirdScoreDivL3,
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color:
                                                            Colors.orange[200],
                                                        border: Border.all(
                                                          color: Colors
                                                              .orange[100]!,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '÷',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35,
                                                            fontFamily:
                                                                'ReadexPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      2, // how much coulmn
                                                  crossAxisSpacing:
                                                      10, // vertical space
                                                  mainAxisSpacing: 10,
                                                  mainAxisExtent:
                                                      50, // here set custom Height You Want
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18),

                                  //الكونتينر الابيض حق نقاطي
                                  Container(
                                    height: height / 2,
                                    width: width / 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'نقاطي',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'ReadexPro',
                                            color: Colors.brown,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 20),

                                          //النسب المئوية
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print('add points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.7,
                                                  center: new Text(
                                                    " ٧۰ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: new Text(
                                                      "عملية الجمع",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.purple,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('subtraction points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.5,
                                                  center: new Text(
                                                    " ٥۰ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: new Text(
                                                      "عملية الطرح",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.green,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print(
                                                      'multiplication points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.35,
                                                  center: new Text(
                                                    " ۳٥ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: new Text(
                                                      "عملية الضرب",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('division points');
                                                },
                                                child:
                                                    new CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 13.0,
                                                  animation: true,
                                                  percent: 0.17,
                                                  center: new Text(
                                                    " ۱٧ %",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      fontFamily: 'ReadexPro',
                                                    ),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: new Text(
                                                      "عملية القسمة",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily: 'ReadexPro',
                                                      ),
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor:
                                                      Colors.lightBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //معلومات الطفل اللي تطلع فوق
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 65, top: 10),
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: sex == "boy"
                                              ? AssetImage(
                                                  "images/husbh_boy.png")
                                              : AssetImage(
                                                  "images/husbh_girl.png"),
                                          scale: 0.02,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                        boxShadow: [
                                          BoxShadow(
                                            // color: Colors
                                            //     .yellow
                                            //     .shade100,
                                            color: Colors.grey.shade300,
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 17.0),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.ende,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 25,
                                                fontFamily: 'ReadexPro',
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(width: 20, height: 1),
                                          Text(age,
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 10,
                                                  fontFamily: 'ReadexPro',
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(width: 20, height: 5),
                                          Text(email,
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 10,
                                                  fontFamily: 'ReadexPro',
                                                  fontWeight: FontWeight.w700))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          );
        });
  }

  Future<dynamic> popUpWindow(
    BuildContext context,
    double height,
    double width, // هذول دايم نفسهم مايتغيرون
    int total,
    String level1,
    String level2,
    String level3,
    int currentScoreLevel1,
    int secondScoreLevel1,
    int thirdScoreLevel1,
    int currentScoreLevel2,
    int secondScoreLevel2,
    int thirdScoreLevel2,
    int currentScoreLevel3,
    int secondScoreLevel3,
    int thirdScoreLevel3,
  ) {
    // total --> توتال السكور بكل المهارات من 12
    // level1 --> اسم المهارة الأولى
    // level2 --> اسم المهارة الثانية
    // level3 --> اسم المهارة الثالثة
    // currentScoreLevel1 --> ناتج سكور آخر محاولة من أول ليفيل أو أول مهارة
    // currentScoreLevel2 --> ناتج سكور آخر محاولة من ثاني ليفيل أو ثاني مهارة
    // currentScoreLevel2 --> ناتج سكور آخر محاولة من ثالث ليفيل أو ثالث مهارة

    // secondScoreLevel1 --> ناتج سكور ثاني محاولة من أول ليفيل أو أول مهارة
    // secondScoreLevel2 --> ناتج سكور ثاني محاولة من ثاني ليفيل أو ثاني مهارة
    // secondScoreLevel3 --> ناتج سكور ثاني محاولة من ثالث ليفيل أو ثالث مهارة

    // thirdScoreLevel1 --> ناتج سكور ثالث محاولة من أول ليفيل أو أول مهارة
    // thirdScoreLevel2 --> ناتج سكور ثالث محاولة من ثاني ليفيل أو ثاني مهارة
    // thirdScoreLevel3 --> ناتج سكور ثالث محاولة من ثالث ليفيل أو ثالث مهارة

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: (height / 2 + 70),
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: (height / 4) - 20,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade200,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(160),
                                  bottomLeft: Radius.circular(160),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              child: SingleChildScrollView(
                                child: Align(
                                  // alignment: Alignment.center,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          'المستوى الحالي',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'ReadexPro',
                                            color: Colors.brown,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      currentLevel(total),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      currentLevelPer(
                                          currentScoreLevel1, level1),
                                      currentLevelPer(
                                          currentScoreLevel2, level2),
                                      currentLevelPer(
                                          currentScoreLevel3, level3),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: (height / 2 + 70),
                              width: width * 0.45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: (height / 4) - 20,
                              width: width * 0.45,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade200,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(160),
                                  bottomLeft: Radius.circular(160),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              child: SingleChildScrollView(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: SizedBox(
                                          width: width * 0.25,
                                          child: Text(
                                            'المستوى في المحاولات السابقة',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'ReadexPro',
                                              color: Colors.brown,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                //        Padding(
                                                //         padding: const EdgeInsets.only(left:40,bottom: 10),
                                                //          child: Text(
                                                //   "المحاولة الثانية: ",
                                                //   //textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //     fontSize: 12,
                                                //     fontFamily: 'ReadexPro',
                                                //     color: Colors.brown,
                                                //     fontWeight: FontWeight.w900,
                                                //   ),
                                                // ),
                                                //  ),
                                                currentLevelPer(
                                                    secondScoreLevel1, level1),
                                                currentLevelPer(
                                                    secondScoreLevel2, level2),
                                                currentLevelPer(
                                                    secondScoreLevel3, level3),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                //         Padding(
                                                //           padding: const EdgeInsets.only(left:40,bottom: 10),
                                                //           child: Text(
                                                //   "المحاولة الثالة: ",
                                                //   //textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //     fontSize: 12,
                                                //     fontFamily: 'ReadexPro',
                                                //     color: Colors.brown,
                                                //     fontWeight: FontWeight.w900,
                                                //   ),
                                                // ),
                                                //         ),
                                                currentLevelPer(
                                                    thirdScoreLevel1, level1),
                                                currentLevelPer(
                                                    thirdScoreLevel2, level2),
                                                currentLevelPer(
                                                    thirdScoreLevel3, level3),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                      radius: 15,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.70,
                  height: height - 20,
                ),
              ],
            ),
          );
        });
  }

  Row currentLevelPer(score, name) {
    double per = ((score / 12));

    return Row(children: [
      if (score == 0) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٠.٠٠",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.red,
          ),
        ))
      ] else if (score == 1) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٨.٣٣",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.red,
          ),
        ))
      ] else if (score == 2) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%١٦.٦٦",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.red,
          ),
        ))
      ] else if (score == 3) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٢٥",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.orange,
          ),
        ))
      ] else if (score == 4) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٣٣.٣٣",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.orange,
          ),
        ))
      ] else if (score == 5) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٤١.٦٦",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.orange,
          ),
        ))
      ] else if (score == 6) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٥٠",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.lightBlue,
          ),
        ))
      ] else if (score == 7) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٥٨.٣٣",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.lightBlue,
          ),
        ))
      ] else if (score == 8) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٦٦.٦٦",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.lightBlue,
          ),
        ))
      ] else if (score == 9) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٧٥",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.greenAccent,
          ),
        ))
      ] else if (score == 10) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٨٣.٣٣",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.greenAccent,
          ),
        ))
      ] else if (score == 11) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 120,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%٩١.٦٦",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.greenAccent,
          ),
        ))
      ] else if (score == 12) ...[
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13),
          child: new LinearPercentIndicator(
            width: 95,
            lineHeight: 14.0,
            animation: true,
            leading: new Text(
              name,
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'ReadexPro',
                color: Colors.brown.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            animationDuration: 1500,
            percent: per,
            center: Text(
              "%١٠٠",
              style: new TextStyle(fontSize: 10, fontFamily: 'ReadexPro'),
            ),
            barRadius: Radius.circular(25),
            backgroundColor: Color.fromARGB(255, 200, 199, 199),
            progressColor: Colors.greenAccent,
          ),
        ))
      ]
    ]);
  }

  Row currentLevel(score) {
    String img;
    var level;
    Text txt = Text("images/golden.png");
    return Row(
      children: [
        if (score >= 9) ...[
          //اذا الطفل جاب 9 أو فوق من أصل 12 بوينتز
          Container(
            width: 30,
            child: Image.asset("images/golden.png"),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "متقدم",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ReadexPro',
              color: Colors.brown.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else if (score >= 6) ...[
          //اذا الطفل جاب 6 أو فوق من أصل 12 بوينتز
          Container(
            width: 30,
            child: Image.asset("images/silver.png"),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "متوسط",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ReadexPro',
              color: Colors.brown.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else ...[
          //اذا الطفل جاب أقل من 5 من أصل 12 بوينتز
          Container(
            width: 30,
            child: Image.asset("images/bronze.png"),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "مبتدئ",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ReadexPro',
              color: Colors.brown.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}
