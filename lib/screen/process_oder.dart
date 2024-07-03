import 'package:app_cosmetic/screen/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProcessOder extends StatefulWidget {
  const ProcessOder({super.key});

  @override
  State<ProcessOder> createState() => _ProcessOderState();
}

class _ProcessOderState extends State<ProcessOder> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Đơn hàng "),
            actions: [
              TextButton(
                onPressed: () {},
                child: Icon(Icons.shopping_bag),
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Chờ xác nhận'),
                Tab(text: 'Đang giao hàng '),
                Tab(text: 'Thành công'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(children: [
                OrderItem(status: "Chờ xác nhận"),
                OrderItem(status: "Chờ xác nhận")
              ]),
              OrderItem(status: "Đang giao hàng"),
              OrderItem(status: "Thành công ")
            ],
          ),
        ),
      ),
    );
  }
}
