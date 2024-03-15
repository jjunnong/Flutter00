import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences 인스턴스를 어디서든 접근 가능하도록 전역 변수로선언
// late : 나중에 꼭 값을 할당해준다는 의미
late SharedPreferences prefs;

void main() async {
  // main()함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();

  //Shared_preferences 인스턴스 생성
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SharedPreferences 에서 온보딩 완료 여부 조회
    // isOnboared에 해당하는 값에서 null을 반환하는 경우 false를 기본값으로 저장
    bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '넌 누구니',
      //isOnboared값에 따라 Homepage로 열지 TestScreen으로 열지 결정됨
      home: isOnboarded ? HomePage() : TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: '사고 & 팔기',
      subTitle: '사고 팔아라',
      imageUrl: 'assets/images/onboarding3.png',
    ),
    Introduction(
      title: '배송',
      subTitle: '배송받아라',
      imageUrl: 'assets/images/onboarding4.png',
    ),
    Introduction(
      title: '신형 배달',
      subTitle: '빨리 받게 해주겟다',
      imageUrl: 'assets/images/onboarding5.png',
    ),
    Introduction(
      title: '끝',
      subTitle: '끝이다',
      imageUrl: 'assets/images/onboarding3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        //마지막페이지가 나오거나 skip을 해서 Homepage로 가기전에 isOnboarded를 true로 바꿔준다.
        prefs.setBool('isOnboarded', true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ), //MaterialPageRoute
        );
      },
      // foregroundColor: Colors.red,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈페이지'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              prefs.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
        child: Text(
          '또와라!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
