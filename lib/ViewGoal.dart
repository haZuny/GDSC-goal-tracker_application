import 'package:dio/dio.dart';
import 'package:first_side_project_app/View_Diary.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';

import 'EditDaily.dart';
import 'EditGoal.dart';

class ViewGoal extends StatefulWidget {
  int goalId = 0;
  ViewGoal(int id){
    this.goalId = goalId;
  }
  @override
  State<ViewGoal> createState() => _ViewGoal(goalId);
}

class _ViewGoal extends State<ViewGoal> {
  int goalId = 0;
  String title = "";
  String content = "";
  String duoDay = "";
  String alarmOnOff = "";
  String alertTime = "";

  // 완료 여부, 0: 완료, 1:미완료
  int selectedState = 0;

  // 위젯간 간격(세로)
  double titleFontSize = 17;

  _ViewGoal(int id){
    this.goalId = id;
  }

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGoal(goalId);

    // 서버에서 데이터를 받아옴
  }

  @override
  Widget build(BuildContext context) => Container(
        // 상태바 높이만큼 띄우기
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // 배경 이미지 적용
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/background.png'))),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(getMobileSizeFromPercent(context, 18, false)),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset('assets/img/icon.png'),
                      height: getMobileSizeFromPercent(context, 10, false),
                    ),
                    Container()
                  ],
                ),
              ),
            ),

            // Body
            body: Container(
                height: getMobileSizeFromPercent(context, 82, false) -
                    MediaQuery.of(context).padding.top * 2,
                width: double.infinity,
                // 여기서부터 찐 개발 시작
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 제목
                      Column(
                        children: [
                          Text("제목", style: TextStyle(fontSize: titleFontSize)),
                          Container(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              //모서리를 둥글게 하기 위해 사용
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(color_whiteYellow),
                            elevation: 0, // 그림자 깊이
                            child: Container(
                                padding: EdgeInsets.all(5),
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height:
                                    getMobileSizeFromPercent(context, 6, false),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        this.title,
                                        style: TextStyle(fontSize: 21),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                      // 설명
                      Column(
                        children: [
                          Text("설명", style: TextStyle(fontSize: titleFontSize)),
                          Container(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              //모서리를 둥글게 하기 위해 사용
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(color_whiteYellow),
                            elevation: 0, // 그림자 깊이
                            child: Container(
                                padding: EdgeInsets.all(5),
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height: getMobileSizeFromPercent(
                                    context, 18, false),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        this.content,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                      // 반복 요일
                      Container(
                        width: getMobileSizeFromPercent(context, 65, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("목표기간",
                                style: TextStyle(fontSize: titleFontSize)),
                            // Text(
                            //   this.duoDay.substring(0, 4) +
                            //       "-" +
                            //       this.duoDay.substring(4, 6) +
                            //       "-" +
                            //       this.duoDay.substring(6, 8),
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(fontSize: 25),
                            // )
                          ],
                        ),
                      ),

                      // 알림
                      Container(
                        width: getMobileSizeFromPercent(context, 65, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("알림 ",
                                    style: TextStyle(fontSize: titleFontSize)),
                                Container(
                                  width: 10,
                                ),
                                Text(this.alarmOnOff,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(alertTime,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      // 상태
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("상태",
                                style: TextStyle(fontSize: titleFontSize)),
                            Row(
                              children: [
                                // 완료 상태
                                GestureDetector(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: Color(selectedState == 0
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      height: 40,
                                      child: Text(
                                        "완료",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // 색 Switch
                                    setState(() {
                                      selectedState = 0;
                                    });
                                  },
                                ),
                                Container(width: 10),
                                // 미완료 상태
                                GestureDetector(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: Color(selectedState == 1
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      height: 40,
                                      child: Text(
                                        "미완료",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedState = 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 10,
                      ),

                      // 뒤로가기
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(selectedState==0 ? 60:80, 40),
                                //width, height
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "수정",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditGoal())),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(selectedState==0 ? 60:80, 40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "삭제",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),

                            // 일기 페이지 이동
                            if(selectedState == 0)
                              Container(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                        borderRadius: BorderRadius.circular(16)),
                                    primary: Color(color_mint),
                                    onPrimary: Colors.black,
                                    minimumSize: Size(60, 40),
                                    shadowColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "일기",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>View_Diary())),
                                ),
                              ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(selectedState==0 ? 60:80, 40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "뒤로",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 5,
                      ),
                    ]))),
      );

  /// 정보 받아옴
  Future<int> getGoal(int id) async {
    String getDailyURI = hostURI +
        'api/daily/' +
        goalId.toString();

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getDailyURI);
      print(res);
      // setState(() {
      //   this.title = res.data['title'];
      //   this.content = res.data['content'];
      //   this.alertTime = res.data['alertTime'];
      //   this.alarmOnOff = res.data['alertStatus'];
      //   this.duoDay = res.data['endDate'];
      //
      //   if (res.data['goalStatus'] == "ON") {
      //     this.selectedState = 0;
      //   } else {
      //     this.selectedState = 1;
      //   }
      // });
      print("====================");
      print("sucess getView");
    } catch (e) {
      print("====================");
      print("getView Err");
    }
    return -1;
  }
}
