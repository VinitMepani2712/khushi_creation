import 'package:flutter/material.dart';
import 'package:khushi_creation/screens/profile_screen/order_screen/active_order_screen.dart';
import 'package:khushi_creation/screens/profile_screen/order_screen/cancelled_order_screen.dart';
import 'package:khushi_creation/screens/profile_screen/order_screen/completed_order_screen.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.brown,
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 2,
            dividerColor: Color.fromARGB(255, 235, 235, 235),
            indicatorColor: Colors.brown,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ActiveOrdersScreen(),
                CompletedOrdersScreen(),
                CancelledOrdersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
