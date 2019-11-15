import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../style/colors.dart';
import 'dart:convert';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

// class Alarm {
//   final String room;
//   final String updateTime;
//   final int gender;
//   final int id;
//   final String level;
//   final String region;
//   final String humanPic;
//   final String facePic;
//   final int operatorId;
//   final int status;
//   final String statusString;
//   final String remark;
//   final int result;
//   final String resultString;
//   final String createTime;
//   final int cameraId;

// Alarm(
//     this.room,
//     this.updateTime,
//     this.gender,
//     this.id,
//     this.level,
//     this.region,
//     this.humanPic,
//     this.facePic,
//     this.operatorId,
//     this.status,
//     this.statusString,
//     this.remark,
//     this.result,
//     this.resultString,
//     this.createTime,
//     this.cameraId);

// Alarm.fromJson(Map<String, dynamic> json)
//     : room = json['room'],
//       updateTime = json['update_time'],
//       gender = json['reported_gender'],
//       id = json['id'],
//       level = json['level'],
//       region = json['region'],
//       humanPic = json['human_pic'],
//       facePic = json['face_pic'],
//       operatorId = json['operator_id'],
//       status = json['status'],
//       statusString = json['status_string'],
//       remark = json['remark'],
//       result = json['result'],
//       resultString = json['result_string'],
//       createTime = json['create_time'],
//       cameraId = json['camera_id'];

// Map<String, dynamic> toJson() => {
//       'room': room,
//       'update_time': updateTime,
//       'reported_gender': gender,
//       'id': id,
//       'level': level,
//       'region': region,
//       'human_pic': humanPic,
//       'face_pic': facePic,
//       'operator_id': operatorId,
//       'status': status,
//       'status_string': statusString,
//       'remark': remark,
//       'result': result,
//       'result_string': resultString,
//       'create_time': createTime,
//       'camera_id': cameraId
//     };
// }

List<String> imageList = [
  'http://img5.mtime.cn/mt/2018/11/07/092515.55805319_180X260X4.jpg',
  'http://img5.mtime.cn/mt/2018/11/13/093605.61422332_180X260X4.jpg',
  'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg'
];

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    //接收参数
    Map<String, dynamic> alarm = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: nusBackgroundWhite,
      appBar: new AppBar(
        title: Text('Alert Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 40.0),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    alarm['region'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: nusblack200),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    alarm['update_time'],
                    style: TextStyle(fontSize: 14.0, color: nusblack50),
                  )
                ],
              ),
              Container(
                width: 70.0,
                height: 24.0,
                decoration: BoxDecoration(
                    color: alarm['reported_gender'] == 1 ? nusRed : nusOrange,
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Center(
                    child: Text(
                  alarm['reported_gender'] == 1 ? 'male' : 'unknown',
                  style: TextStyle(fontSize: 12.0, color: nusBackgroundWhite),
                )),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('${alarm['level']}-${alarm['room']}',
              style: TextStyle(fontSize: 16.0, color: nusblack200)),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 344.0,
            width: double.infinity,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  imageList[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(
                // margin: const EdgeInsets.only(bottom: 0.0),
                builder: DotSwiperPaginationBuilder(
                    color: nusGrey100, activeColor: nusblack150),
              ),
              control: null,
            ),
          ),
          SizedBox(height: 50.0),
          Column(
            children: <Widget>[
              Container(
                  height: 45,
                  child: (GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/result', arguments: 2);
                    },
                    child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: nusGreen,
                        child: Center(
                            child: const Text(
                          'Female - Add to whitelist',
                          style: TextStyle(
                              fontSize: 16, color: nusBackgroundWhite),
                        ))),
                  ))),
              SizedBox(height: 10.0),
              Container(
                  height: 45,
                  child: (GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/remark');
                    },
                    child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: nusRed,
                        child: Center(
                            child: const Text(
                          'Male - Process the alert',
                          style: TextStyle(
                              fontSize: 16, color: nusBackgroundWhite),
                        ))),
                  ))),
              SizedBox(height: 10.0),
              Container(
                  height: 45,
                  child: (GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/result', arguments: 1);
                    },
                    child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: nusOrange,
                        child: Center(
                            child: const Text(
                          'Unsure - Keep it is',
                          style: TextStyle(
                              fontSize: 16, color: nusBackgroundWhite),
                        ))),
                  ))),
            ],
          )
        ],
      ),
    );
  }
}
