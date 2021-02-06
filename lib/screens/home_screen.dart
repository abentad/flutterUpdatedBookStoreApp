import 'dart:convert';

import 'package:BookApp/screens/details_screen.dart';
import 'package:BookApp/widgets/myBookCover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List booksList;
  bool isConnectedToInternet = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getData() async {
    http.Response response =
        await http.get('https://ab-books-api.vercel.app/books');
    var data = jsonDecode(response.body);
    setState(() {
      booksList = data;
    });
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isConnectedToInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnectedToInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.none) {
      showInSnackBar(bgColor: Colors.red, value: "No Internet");
      setState(() {
        isConnectedToInternet = false;
      });
    }
  }

  void showInSnackBar({String value, Color bgColor}) {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: bgColor,
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    if (isConnectedToInternet = true) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: booksList == null
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.red),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: () {},
                )
              ],
            ),
      body: booksList == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: devHeight,
              width: devWidth,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: devHeight * 0.2,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(2, 7),
                            blurRadius: 20.0,
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover books',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CLASSICS',
                                style: TextStyle(color: Colors.red)),
                            Text('NEW'),
                            Text('UPCOMING'),
                            SizedBox(width: 40.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //big books cover
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: booksList.length,
                      itemBuilder: (context, index) {
                        return myBookCover(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  selectedBook: booksList[index],
                                ),
                              ),
                            );
                          },
                          title: booksList[index]['title'],
                          imgUrl: booksList[index]['posterImage'],
                          datePosted: DateFormat('yMMMMd').format(
                              DateTime.parse(booksList[index]['postDate'])),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    child: Center(child: Text('to be implemented')),
                  )
                ],
              ),
            ),
    );
  }
}
