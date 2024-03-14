import 'package:flutter/material.dart';

void main() {
  print("1. start");
  runApp(const MyApp());
}

// StatefulWidget의 기능을 상속함
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// MyApp의 상태를 나타내는 클래스
class _MyAppState extends State<MyApp> {
  int number = 0; // number가 0인 상태 시작

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AppBar'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.purple,
                          child: Text('컨테이너'),
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(50),
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text(
                          'hello',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                  ],
                ),
                Image.asset(
                  'asset/image/minions.jpg',
                ),
                Image.network(
                  'https://gratisography.com/wp-content/uploads/2023/10/gratisography-cool-cat-800x525.jpg',
                ),
                Image.network(
                  'https://gratisography.com/wp-content/uploads/2023/10/gratisography-cool-cat-800x525.jpg',
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Input'),

                  //입력폼(text)에 값이 변경될 경우 작동한다.
                  onChanged: (text) {
                    print(text);
                  },
                  // 엔터를 눌러을 경우 작동한다.
                  onSubmitted: (text) {
                    print("enter를 눌렀습니다 입력값 : $text");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
