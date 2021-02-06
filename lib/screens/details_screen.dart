import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final Map selectedBook;
  DetailScreen({this.selectedBook});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  String formatDate(String date) {
    return DateFormat('yMMMMd').format(
      DateTime.parse(date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.selectedBook['posterImage'],
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.selectedBook['posterImage']),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedBook['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    buildMyRow("Price", widget.selectedBook['price']),
                    SizedBox(height: 10.0),
                    buildMyRow(
                      "Date Posted",
                      formatDate(widget.selectedBook['postDate']),
                    ),
                    SizedBox(height: 10.0),
                    buildMyRow("Category", widget.selectedBook['category']),
                    SizedBox(height: 10.0),
                    buildMyRow("Author", widget.selectedBook['author']),
                    SizedBox(height: 10.0),
                    buildMyRow("Rating", widget.selectedBook['rating']),
                    SizedBox(height: 10.0),
                    buildMyDescription(
                        "Description", widget.selectedBook['description']),
                    SizedBox(height: 10.0),
                    MaterialButton(
                      onPressed: () {},
                      minWidth: double.infinity,
                      height: 50.0,
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.orange,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column buildMyDescription(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 10.0),
        Text(
          description,
          softWrap: true,
        )
      ],
    );
  }

  Row buildMyRow(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
