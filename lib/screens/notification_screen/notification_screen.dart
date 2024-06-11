import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildNotification(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildAppBar(BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffE6E6E6),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CircleAvatar(
                  minRadius: 20,
                  maxRadius: 20,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 50.w),
            Text(
              "Notification",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 50.w),
            Container(
              alignment: Alignment.center,
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xff704F38),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '2 NEW',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget sectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ),
  );
}

Widget _buildNotification(BuildContext context) {
  return Column(
    children: notifications.asMap().entries.map((entry) {
      int index = entry.key;
      NotificationItem notification = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index == 0) sectionHeader('TODAY'),
          if (index == 3) sectionHeader('YESTERDAY'),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffEDEDED),
              child: Icon(notification.icon, color: Colors.brown),
            ),
            title: Text(notification.title),
            subtitle: Text(notification.message),
            trailing: Text(notification.time),
            isThreeLine: true,
          ),
          Divider(),
        ],
      );
    }).toList(),
  );
}
