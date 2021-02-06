import 'package:flutter/material.dart';

Widget myBookCover(
    {String title, String datePosted, String imgUrl, Function onTap}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Hero(
            tag: imgUrl,
            child: Container(
              height: 200.0,
              width: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey[300],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(2, 7),
                    blurRadius: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 3.0),
        Text(datePosted, style: TextStyle(fontSize: 10.0, color: Colors.grey)),
      ],
    ),
  );
}
