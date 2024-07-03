import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final Order? order;

  const OrderDetailPage({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'CHI TIẾT ĐƠN HÀNG',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mã đơn: ${order?.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 25,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Thông tin vận chuyển',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Nhanh',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textHint
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'SPX Express - SPXVN20212025',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textHint
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    // Handle order confirmation
                  },
                  child: Text(
                    'Giao hàng',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Ngày tạo đơn: ${order?.createdAt}',
                  style: TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Ngày nhận: ${order?.updatedAt}',
                  style: TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 25,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Địa chỉ nhận hàng',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  order?.userId ?? '',
                  style: TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  '(+84)${order?.phoneNumber}',
                  style: TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  order?.address ?? '',
                  style: TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              SizedBox(height: 10),
              Divider(color: AppColors.primaryColor, thickness: 2),
              ...order!.products.map((product) {
                return Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 12,),
                      Image.network(
                        product.imageBase,
                        width: 80.0,
                        height: 90.0,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name, style: TextStyle(fontSize: 15),),
                            Text('x${product.quantity}'),
                          ],
                        ),
                      ),
                      Text(
                        '${product.price}  ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              Divider(color: AppColors.primaryColor, thickness: 2),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phụ phí:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${order?.priceSale}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thành tiền:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${order?.totalPrice}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phương thức thanh toán:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${order?.paymentMethod.toUpperCase()}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
