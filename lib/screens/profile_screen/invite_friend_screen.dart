import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/friend_model.dart';

class InviteFriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _buildAppBar(context),
          _buildFriendListView(context),
        ],
      ),
    ));
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
                "Invite Friends",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFriendListView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        itemCount: inviteFriendsListModel.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final friend = inviteFriendsListModel[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(friend.image),
            ),
            title: Text(friend.name),
            subtitle: Text(friend.phone),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF704F38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Invite',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
