// ignore_for_file: prefer_const_constructors

// import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:husbh_app/main.dart';
import '../../widgets/option_card.dart';
import 'AnswerScreen.dart';
import 'dart:async';
import 'QuizButtonIcon.dart';
import 'package:nice_buttons/nice_buttons.dart';
// import 'package:fabexdateformatter/fabexdateformatter.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();

  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    TextDirection.rtl;
    return Container();
  }
}

class _QuizScreenState extends State<QuizScreen> {
  get width => MediaQuery.of(context).size.width;
  get height => MediaQuery.of(context).size.height;

  ArabicNumbers arabicNumber = ArabicNumbers();


  List qustions = [];
  List answers = [];
  bool isMarked = false;
  List<List<dynamic>> mcq = [];
  List userAnswer = [];
  var ansData;
  List<dynamic> ans = [];
  var j = 0;
  final int numOfSingleQuestions = 4; //الآحاد
  final int numOfTensQuestions = 4; //العشرات
  final int numOfHundredQuestions = 4; //المئات
  List<dynamic> Xx = [];
  List<dynamic> Yy = [];
  var Singlescore = 0;
  var Tensscore = 0;
  var Hundredscore = 0;
  bool isPressed = false;
// //Array of numbers to convert from english to arabic
//   var numberMap = {
//     0: '۰',
//     1: '۱',
//     2: '۲',
//     3: '۳',
//     4: '٤',
//     5: '٥',
//     6: '٦',
//     7: '٧',
//     8: '۸',
//     9: '۹'
//   };

  String arabicX = "";
  String arabicY = "";

  var x = Random().nextInt(9) + 1;
  var y = Random().nextInt(9) + 1;

  bool getIsPressed() {
    return isPressed;
  }

  //get isPressed => null;

 // get onPressed => null;

  get startColor => null;

  get endColor => null;

  get borderColor => null;

  get color => null;

  get onPressed => null;

  get states => null;

  void initState() {
    TextDirection.rtl;
    super.initState();

    for (var i = 1; i < numOfSingleQuestions + 1; i++) {
      ans = [];
      x = Random().nextInt(9) + 1;
      y = Random().nextInt(9) + 1;
      Xx.add(x);
      Yy.add(y);

      textDirection:
      TextDirection.rtl;
      qustions.add(convertToArabic());
      answers.add(x + y);
      ansData = [
        convertOptionsToArabic(x + y),
        convertOptionsToArabic(x + y + 1),
        convertOptionsToArabic(x + y + 7),
        convertOptionsToArabic(x + y + 3),
      ];

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }

    for (var i = 1; i < numOfTensQuestions + 1; i++) {
      ans = [];
      x = Random().nextInt(99) + 1;
      y = Random().nextInt(99) + 1;
      while (x < 10 || y < 10 || x + y > 100) {
        x = Random().nextInt(99) + 1;
        y = Random().nextInt(99) + 1;
      }

      textDirection:
      TextDirection.rtl;
      qustions.add(convertToArabic());
      answers.add(x + y);
      ansData = [
        convertOptionsToArabic(x + y),
        convertOptionsToArabic(x + y + 2),
        convertOptionsToArabic(x + y + 9),
        convertOptionsToArabic(x + y + 5),
      ];

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }

    for (var i = 1; i < numOfHundredQuestions + 1; i++) {
      ans = [];
      x = Random().nextInt(999);
      y = Random().nextInt(999);
      while (x < 100 || y < 100 || x + y > 500) {
        x = Random().nextInt(999);
        y = Random().nextInt(999);
      }

      textDirection:
      TextDirection.rtl;
      qustions.add(convertToArabic());
      answers.add(x + y);
      ansData = [
        convertOptionsToArabic(x + y),
        convertOptionsToArabic(x + y + 1),
        convertOptionsToArabic(x + y + 3),
        convertOptionsToArabic(x + y + 6),
      ];

      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
  }

  String convertToArabic() {
    arabicX = arabicNumber.convert(x);
    arabicY = arabicNumber.convert(y);

    // if (x.toString().length == 1) {
    //   arabicX = numberMap[x].toString();
    // }
    // if (y.toString().length == 1) {
    //   arabicY = numberMap[y].toString();
    // }

    // var numberLengthX = x.toString().length;
    // if (numberLengthX > 1) {
    //   var Xstring = x.toString();
    //   arabicX = Xstring;
    //   for (var i = 0; i < numberLengthX; i++) {
    //     var num = int.parse(Xstring[i]);
    //     arabicX = arabicX.replaceAll(num.toString(), numberMap[num]!);
    //   }
    // }
    // var numberLengthY = y.toString().length;
    // if (numberLengthY > 1) {
    //   var Ystring = y.toString();
    //   arabicY = Ystring;
    //   for (var s = 0; s < numberLengthY; s++) {
    //     var num = int.parse(Ystring[s]);
    //     arabicY = arabicY.replaceAll(num.toString(), numberMap[num]!);
    //   }
    // }
    return "$arabicX " + "+" + " $arabicY";
  }

  String convertOptionsToArabic(int num) {
    arabicX = arabicNumber.convert(num);

    // if (num.toString().length == 1) {
    //   arabicX = numberMap[num].toString();
    // }

    // var numberLengthX = num.toString().length;

    // if (numberLengthX > 1) {
    //   var Xstring = num.toString();
    //   arabicX = Xstring;
    //   for (var i = 0; i < numberLengthX; i++) {
    //     var number = int.parse(Xstring[i]);
    //     arabicX = arabicX.replaceAll(number.toString(), numberMap[number]!);
    //   }
    // }
    return "$arabicX";
  }

  _changeQuestion(ans) {
   
    userAnswer.add(ans);
    //print(userAnswer);
    
    if (j + 1 >= 12) {
      // if (j + 1 >= qustions.length) {
      // print(userAnswer);
      for (var i = 0; i < 4; i++) {
         //print(userAnswer[i].toString());
         //print( convertOptionsToArabic(answers[i]));
        if (userAnswer[i].toString() ==  convertOptionsToArabic(answers[i]).toString()) {
           //print(userAnswer[i].toString());
          Singlescore++;
        }
      }

      // var Tensscore = 0;
      for (var i = 4; i < 8; i++) {
        if (userAnswer[i].toString() == convertOptionsToArabic(answers[i]).toString()) {
          Tensscore++;
        }
      }

      // var Hundredscore = 0;
      for (var i = 8; i <11 ; i++) {
        if (userAnswer[i].toString() == convertOptionsToArabic(answers[i]).toString()) {
          Hundredscore++;
        }
      }
      Navigator.of(context).push(
        // Navigator.pushReplacement(
        // context,
        MaterialPageRoute(
          builder: (BuildContext context) => AnswerScreen(
              maxSingleScore: numOfSingleQuestions,
              maxTensScore: numOfTensQuestions,
              maxHundredScore: numOfHundredQuestions,
              singlescore: Singlescore,
              tensscore: Tensscore,
              hundredscore: Hundredscore,
              answers: answers,
              qustions: qustions,
              userAnswer: userAnswer),
        ),
      );
    } else {
      setState(() {
        ++j;
        isMarked = false;
        isPressed=false;
      });
    }
  }

  //objects for questions
  List<String> objects = [
    'images/GreenApple.png',
    'images/RedApple.png',
    'images/Xgreen.png',
    'images/Xred.png',
  ];
//returns images for value x
  Widget _printImageX(xValue) {
    //if value = 0 show its image
    if (x == 0) {
      return Center(
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            Image.asset(
              //xgreen
              objects[2],
              width: width * 0.13,
              height: height * 0.12,
            )
          ],
        ),
      );
    }
    //else show the apples
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          for (var i = 0; i < xValue; i++)
            Image.asset(
              objects[0],
              width: width * 0.13,
              height: height * 0.12,
            )
        ],
      ),
    );
  }

//returns images for value y
  Widget _printImageY(yValue) {
    if (y == 0) {
      return Center(
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            Image.asset(
              objects[3],
              width: width * 0.13,
              height: height * 0.12,
            )
          ],
        ),
      );
    }
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          for (var i = 0; i < yValue; i++)
            Image.asset(
              objects[1],
              width: width * 0.13,
              height: height * 0.12,
            )
        ],
      ),
    );
  }
  


  void changeColor(){
    setState(() {
      isPressed = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    textDirection:
    TextDirection.rtl;
    return Scaffold(
      body: Stack(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/farm.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(qustions[j],
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.lightBlue,
                          fontFamily: "ReadexPro-Regular",
                          fontSize:
                              MediaQuery.of(context).size.width > 500 ? 45 : 20,
                          fontWeight: FontWeight.bold)),
                ),
                ImagesUnderQuestion(j),
                
                    //for(int i=0;i<12;i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //children:<Widget>[
                    //for (int g=0;g<4;g++) 
                   /* ElevatedButton(
                       child: QuizButtonIcon(option: mcq[j][0].toString()),
                         onPressed: () async {
                          /*for (int i=0;i<12;i++)
                          {if(mcq[j][0].toString()==convertOptionsToArabic(answers[i]).toString())
                           {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 14, 210, 47)));}
                          else {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 210, 79, 14)));
                          }}*/
                            await Future.delayed(const Duration(seconds: 1),
                          _changeQuestion(mcq[j][0].toString()));

                         },

                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){if (states.contains(MaterialState.pressed)){
                        for (int i=0;i<12;i++)
                           {if(mcq[j][0].toString()==convertOptionsToArabic(answers[i]).toString())
                                return Colors.green;
                                 
                                }
                                return Colors.red;}
                          return Colors.blue;}),
                       // side: 50,
                        padding: MaterialStateProperty.all(EdgeInsets.all(0.5)),
                        
                           ),
                            
                        ),  

                         ElevatedButton(
                       child: QuizButtonIcon(option: mcq[j][1].toString()),
                         onPressed: () async {
                          /*for (int i=0;i<12;i++)
                          {if(mcq[j][1].toString()==convertOptionsToArabic(answers[i]).toString())
                           {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 14, 210, 47)));}
                          else {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 210, 79, 14)));
                          }}*/
                          
                            await Future.delayed(const Duration(seconds: 1),
                          _changeQuestion(mcq[j][1].toString()));

                         },

                        style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){if (states.contains(MaterialState.pressed)){
                           for (int i=0;i<12;i++)
                           {if(mcq[j][1].toString()==convertOptionsToArabic(answers[i]).toString())
                                return Colors.green;
                                
                                }
                            return Colors.red;
                           }
                          return Colors.blue;}),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0.5)),
                        
                           ),
                            
                        ) , 
                         ElevatedButton(
                       child: QuizButtonIcon(option: mcq[j][2].toString()),
                         onPressed: () async {
                         /* for (int i=0;i<12;i++)
                          {
                            if(mcq[j][2].toString()==convertOptionsToArabic(answers[i]).toString())
                           {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 14, 210, 47)));}
                          else {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 210, 79, 14)));
                          }}*/
                          
                            await Future.delayed(const Duration(seconds: 1),
                          _changeQuestion(mcq[j][2].toString()));

                         },

                        style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){if (states.contains(MaterialState.pressed)){
                         for (int i=0;i<12;i++)
                           {if(mcq[j][2].toString()==convertOptionsToArabic(answers[i]).toString())
                                return Colors.green;
                               
                                }
                                 return Colors.red;}
                          return Colors.blue;}),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0.5)),
                        
                        
                           ),
                            
                        ) , 
                         ElevatedButton(
                       child: QuizButtonIcon(option: mcq[j][3].toString()),
                         onPressed: () async {
                           
                         /* for (int i=0;i<12;i++)
                          {if(mcq[j][3].toString()==convertOptionsToArabic(answers[i]).toString())
                           {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 14, 210, 47)));}
                          else {style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 210, 79, 14)));
                          }}*/
                          
                            await Future.delayed(const Duration(seconds: 1),
                          _changeQuestion(mcq[j][3].toString()));

                         },

                        style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states)
                         {if (states.contains(MaterialState.pressed)){
                           for (int i=0;i<12;i++)
                           {if(mcq[j][3].toString()==convertOptionsToArabic(answers[i]).toString())
                                return Colors.green;
                                 
                                }
                                return Colors.red;}
                          return Colors.blue;}),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0.5)),
                        
                           ),
                            
                        )  
                  ]*/
                
               
                  children: <Widget>[

                    NiceButtons(

                        onTap: (finish) async { 
                           changeColor();
     await Future.delayed(const Duration(seconds: 1),
                            _changeQuestion(mcq[j][0].toString()));
                          
                        },
                        
                        stretch: false,
                        startColor: /*isPressed 
                        ? mcq[j][0].toString()==convertOptionsToArabic(answers[i]).toString()
                           ?Colors.green
                           : Colors.red*/

                        Colors.lightBlueAccent,
                        
                        endColor: Colors.lightBlueAccent,
                        borderColor: Color(0xFF3489e9),

                        width: 90.0,
                        height: 60.0,
                        // width: 80.0,
                        // height: 80.0,
                        borderRadius: 60.0,
                        gradientOrientation: GradientOrientation.Horizontal,
                        child: QuizButtonIcon(option: mcq[j][0].toString())),
                    SizedBox(width: 30),
// >>>>>>>>>>>>>>>>>>>>second option on left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                     
                    NiceButtons(
                        onTap: (finish)  async {
 changeColor();
     await Future.delayed(const Duration(seconds: 1),
                          _changeQuestion(mcq[j][1].toString()));
                        },
                        
                        stretch: false,
                        startColor: 
                        Colors.lightBlueAccent,
                        endColor: Colors.lightBlueAccent,
                        borderColor: Color(0xFF3489e9),
                        width: 90.0,
                        height: 60.0,
                        borderRadius: 60.0,
                        gradientOrientation: GradientOrientation.Horizontal,
                        child: QuizButtonIcon(option: mcq[j][1].toString())),
                    SizedBox(width: 30),
                    // >>>>>>>>>>>>>>>>>>>>third  option on left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                     
                    NiceButtons(
                        onTap: (finish) async {
                        changeColor();
     await Future.delayed(const Duration(seconds: 1),
                          _changeQuestion(mcq[j][2].toString()));
                        },
                        stretch: false,
                        startColor: Colors.lightBlueAccent,
                        endColor: Colors.lightBlueAccent,
                        borderColor: Color(0xFF3489e9),
                        width: 90.0,
                        height: 60.0,
                        borderRadius: 60.0,
                        gradientOrientation: GradientOrientation.Horizontal,
                        child: QuizButtonIcon(option: mcq[j][2].toString())),
                    SizedBox(width: 30),
                     // >>>>>>>>>>>>>>>>>>>>forth  option on left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                    
                    NiceButtons(
                        onTap: (finish)  async {
                         changeColor();
     await Future.delayed(const Duration(seconds: 1),

                          _changeQuestion(mcq[j][3].toString()));
                        },
                        stretch: false,
                        startColor: Colors.lightBlueAccent,
                        endColor: Colors.lightBlueAccent,
                        borderColor: Color(0xFF3489e9),
                        width: 90.0,
                        height: 60.0,
                        borderRadius: 60.0,
                        gradientOrientation: GradientOrientation.Horizontal,
                        child: QuizButtonIcon(option: mcq[j][3].toString())),
                  ],
                ),
              ])
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ImagesUnderQuestion(int j) {
    if (j == 4 || j == 5 || j == 6 || j == 7) {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/dogFrame.png',
                      height: height * 0.49,
                      width: width * 0.30,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Text(
                              "  ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 50,
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 33.0),
                            ),
                          ),
                          SizedBox(
                            width: 35,
                            height: 34,
                            child: Text(
                              qustions[j].toString().substring(0, 2),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.01,
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(
                                  width: 67,
                                  height: 21,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        // width: 63,
                                        // height: 44,
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35,
                            height: 40,
                            child: Text(
                              qustions[j].toString().substring(5, 7),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.75,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 63,
                                  height: 44,
                                  child: Text(
                                    "________",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (j == 0 || j == 1 || j == 2 || j == 3) {
      return SizedBox(
        height: 200,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              SizedBox(width: 300, child: _printImageY(Yy[j])),
              const Text(
                ' + ',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 300, child: _printImageX(Xx[j])),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/dogFrame.png',
                      height: height * 0.49,
                      width: width * 0.30,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Text(
                              "  ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 50,
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 33.0),
                            ),
                          ),
                          SizedBox(
                            width: 59,
                            height: 34,
                            child: Text(
                              qustions[j].toString().substring(0, 3),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.01,
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(
                                  //to Change the "+" position
                                  width: 67,
                                  height: 21,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            height: 40,
                            child: Text(
                              qustions[j].toString().substring(5, 9),
                              style: TextStyle(
                                  letterSpacing: 4,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                          ),
                          Align(
                            heightFactor: 0.75,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 63,
                                  height: 44,
                                  child: Text(
                                    "________",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
