import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../util/http.dart';
import 'dart:convert';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  List _tabs = ['all', 'male', 'unknow'];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _showContent;
  List alerts = new List();
  int page = 0;
  int pageSize = 10;
  ScrollController _scrollController = ScrollController(); // listview 控制器
  bool isLoading = false;
  String url = ''; // 暂存头像地址 base64
  var moreData;
  int gender; //默认all

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = buildDropDownMenuItem(_tabs);
    _showContent = _dropDownMenuItems[0].value;
    _alertList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _getMore() async {
    print('more');
    this.setState(() {
      page = page + 1;
    });
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      if (gender == 0) {
        print('null');
        DioUtil.request('/alarm/list?page=$page&&page_size=$pageSize')
            .then((res) => {
                  moreData = res.data['data'],
                  print(moreData[0]['id']),
                  setState(() {
                    // list.addAll(List.generate(moreData.length, (item) => item));
                    alerts.addAll(moreData);
                    isLoading = false;
                  }),
                });
      } else {
        print('!!!null');
        DioUtil.request(
                '/alarm/list?page=$page&&page_size=$pageSize&&gender=$gender')
            .then((res) => {
                  moreData = res.data['data'],
                  print(moreData[0]['id']),
                  setState(() {
                    // list.addAll(List.generate(moreData.length, (item) => item));
                    alerts.addAll(moreData);
                    isLoading = false;
                  }),
                });
      }
    }
  }

  void _alertList() {
    // int gender;
    if (_showContent == 'all') {
      gender = 0;
    } else if (_showContent == 'unknow') {
      gender = -1;
    } else if (_showContent == 'male') {
      gender = 1;
    }
    setState(() {
      page = 0;
    });
    print('index');
    print(gender);
    print('page');
    print(page);
    if (gender == 0) {
      DioUtil.request('/alarm/list?page=$page&&page_size=$pageSize')
          .then((res) => {
                setState(() {
                  alerts = res.data['data'];
                }),
              });
    } else {
      DioUtil.request(
              '/alarm/list?page=$page&&page_size=$pageSize&&gender=$gender')
          .then((res) => {
                setState(() {
                  alerts = res.data['data'];
                }),
              });
    }
  }

  _getImage(int id) {
    DioUtil.request('/image/face_pic/$id').then((res) => {
          this.url = res.toString().split(',')[1],
        });
    return this.url;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItem(List tabs) {
    List<DropdownMenuItem<String>> items = List();
    for (String tab in tabs) {
      items.add(DropdownMenuItem(value: tab, child: Text(tab)));
    }
    return items;
  }

  void changedDropDownItem(String showContent) {
    setState(() {
      _showContent = showContent;
    });
    _alertList();
  }

  Widget _fontStyle(String name, double size, Color color,
      {FontWeight weight}) {
    return Text(
      name,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight ?? FontWeight.w500,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  // var value;
  Widget _buildAlert(BuildContext context, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: alerts[index]);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 15.0),
          color: nusBackgroundWhite,
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _fontStyle(alerts[index]['update_time'], 12.0, nusblack200),
                  Container(
                    child: Row(
                      children: <Widget>[
                        _fontStyle('Detail', 12.0, nusblack200),
                        Image.asset('assets/arrow_right.png'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                      // TODO
                      image: DecorationImage(
                        // image: AssetImage('assets/alert.png'),
                        image: MemoryImage(Base64Decoder()
                            .convert(_getImage(alerts[index]['id']))),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: (Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _fontStyle(
                                alerts[index]['region'], 18.0, nusblack200,
                                weight: FontWeight.w700),
                            SizedBox(
                              height: 14.0,
                            ),
                            Text(alerts[index]['level']),
                            Text(alerts[index]['room']),
                          ],
                        ),
                        Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: Container(
                              width: 70.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                  color: alerts[index]['reported_gender'] == 1
                                      ? nusRed
                                      : nusOrange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              child: Center(
                                child: _fontStyle(
                                    alerts[index]['reported_gender'] == 1
                                        ? 'male'
                                        : 'unknown',
                                    12.0,
                                    nusBackgroundWhite),
                              ),
                            ))
                      ],
                    )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: AppBar(
            title: Text('Alerts'),
            centerTitle: true,
            leading: Text(''),
            elevation: 0,
            // bottom: new TabBar(tabs: tab),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownButton(
                          value: _showContent,
                          items: _dropDownMenuItems,
                          onChanged: changedDropDownItem,
                          underline: new Container(),
                          isDense: true,
                        ),
                        // SizedBox(width: 40.0),
                        // DropdownButton(
                        //   value: _showContent,
                        //   items: _dropDownMenuItems,
                        //   onChanged: changedDropDownItem,
                        //   underline: new Container(),
                        // )
                      ],
                    )

                    // DropdownButton(
                    //   items: getList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _showContent = value;
                    //     });
                    //   },
                    //   hint: new Text(
                    //     _showContent,
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   underline: new Container(),
                    //   style: TextStyle(color: Colors.white),
                    //   iconEnabledColor: Colors.white,
                    //   iconDisabledColor: Colors.white,
                    //   value: _showContent,
                    // )
                    )),
          ),
          body: Container(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: ListView.builder(
                itemCount: alerts.length,
                itemBuilder: _buildAlert,
                controller: _scrollController,
              )),
        ));
  }
}
