import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/voucher.model.dart';
import 'package:app_cosmetic/screen/user/Payment/payment_successful.dart';
import 'package:app_cosmetic/services/cart_service.dart';
import 'package:app_cosmetic/services/voucher_service.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/model/checkout.model.dart';
import 'package:app_cosmetic/services/checkout_service.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final Cart cart;
  final String userId;
  final int? priceSale;
  final int? percentSale;

  CheckoutPage({
    required this.userId,
    required this.cart,
    this.priceSale,
    this.percentSale,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  late String fullName;
  late String phone;
  late String email;
  late String address;
  late CheckoutService _checkoutService;
  VoucherDto? _appliedVoucher;
  late VoucherService _voucherService;
  int _discountedPrice = 0;
  final TextEditingController _voucherController = TextEditingController();
  bool _voucherValid = true;

  @override
  void initState() {
    super.initState();
    _checkoutService = CheckoutService();
    _voucherService = VoucherService();
  }

  Future<void> _applyVoucher() async {
    print(_voucherController.text);
    if (_voucherController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập mã giảm giá')),
      );
      return;
    }

    try {
      final voucher = await _voucherService
          .findVoucherByVoucherName(_voucherController.text);
      if (voucher != null) {
        setState(() {
          _appliedVoucher = voucher;
          _discountedPrice = _calculateDiscountedPrice();
          _voucherValid = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Áp dụng mã giảm giá thành công')),
        );
      } else {
        setState(() {
          _appliedVoucher = null;
          _discountedPrice = widget.cart?.totalPriceCart.toInt() ?? 0;
          _voucherValid = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mã giảm giá không hợp lệ')),
        );
      }
    } catch (e) {
      print('Error applying voucher: $e');
      setState(() {
        _appliedVoucher = null;
        _discountedPrice = widget.cart?.totalPriceCart.toInt() ?? 0;
        _voucherValid = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mã giảm giá không hợp lệ')),
      );
    }
  }

  int _calculateDiscountedPrice() {
    if (_appliedVoucher == null || widget.cart == null) {
      return widget.cart?.totalPriceCart.toInt() ?? 0;
    }

    final discount =
        widget.cart!.totalPriceCart * _appliedVoucher!.percent_sale / 100;
    final maxDiscount = _appliedVoucher!.maxPriceSale.toInt();
    final actualDiscount =
        discount.toInt() > maxDiscount ? maxDiscount : discount.toInt();
    return widget.cart!.totalPriceCart.toInt() - actualDiscount;
  }

  void _confirmPayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.cart.cartId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể lấy ID giỏ hàng')),
        );
        return;
      }

      if (widget.userId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể lấy ID người dùng')),
        );
        return;
      }

      if (fullName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập họ và tên')),
        );
        return;
      }

      if (phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập số điện thoại')),
        );
        return;
      }

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập email')),
        );
        return;
      }

      if (address.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập địa chỉ')),
        );
        return;
      }

      double finalPrice = widget.cart.totalPriceCart;
      if (widget.percentSale != null && widget.percentSale! > 0) {
        finalPrice = finalPrice;
      }
      if (widget.priceSale != null && widget.priceSale! > 0) {
        finalPrice -= widget.priceSale!;
      }

      final checkout = Checkout(
        cartId: widget.cart.cartId!,
        userId: widget.userId,
        totalPrice: _discountedPrice.toInt(),
        fullName: fullName,
        phoneNumber: phone,
        email: email,
        address: address,
        priceSale: _appliedVoucher?.maxPriceSale ?? 0, // Đảm bảo giá trị hợp lệ
        percentSale:
            _appliedVoucher?.percent_sale ?? 0, // Đảm bảo giá trị hợp lệ
      );

      try {
        final check = await _checkoutService.checkoutOrder(checkout);
        if (check != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đặt hàng thành công!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đặt hàng thất bại')),
          );
        }
      } catch (e) {
        print('Error placing order: $e');
        // Thêm thông báo lỗi chi tiết và kiểm tra các giá trị bị null
        if (e is FormatException) {
          print('Format Exception: ${e.message}');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đặt hàng thất bại: $e')),
        );
        // Không xóa giỏ hàng nếu có lỗi
        // Giữ nguyên giỏ hàng và thông tin đã nhập
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double finalPrice = widget.cart.totalPriceCart;
    if (widget.percentSale != null && widget.percentSale! > 0) {
      finalPrice = finalPrice;
    }
    if (widget.priceSale != null && widget.priceSale! > 0) {
      finalPrice -= widget.priceSale!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Hiển thị thông tin sản phẩm đã đặt
                  Text(
                    'Sản phẩm đã đặt:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8.0),
                  ...widget.cart.itemsCart.map((item) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item.image,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                        title: Text(item.typeProduct),
                        subtitle: Text(
                            'Giá: ${_formatMoney(item.price.toInt())} đ x ${item.quantity}'),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 16.0),
                  // Hiển thị thông tin thanh toán
                  Text(
                    'Thông tin thanh toán:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Họ tên',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập họ và tên';
                            }
                            return null;
                          },
                          onSaved: (value) => fullName = value!,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Số điện thoại',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số điện thoại';
                            }
                            return null;
                          },
                          onSaved: (value) => phone = value!,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập email';
                            }
                            return null;
                          },
                          onSaved: (value) => email = value!,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Địa chỉ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập địa chỉ';
                            }
                            return null;
                          },
                          onSaved: (value) => address = value!,
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextField(
                                controller: _voucherController,
                                decoration: InputDecoration(
                                  labelText: 'Nhập mã giảm giá',
                                  errorText: _voucherValid
                                      ? null
                                      : 'Mã giảm giá không hợp lệ',
                                  suffixIcon: ElevatedButton(
                                    onPressed: _applyVoucher,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors
                                          .primaryColor, // Thêm màu nền
                                    ),
                                    child: Text('Áp mã',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.text)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Tổng đơn hàng: ${_formatMoney(widget.cart!.totalPriceCart.toInt())} đ',
                                style: TextStyle(fontSize: 18),
                              ),
                              if (_appliedVoucher != null) ...[
                                Text(
                                  'Giảm giá: ${_formatMoney((widget.cart!.totalPriceCart - _discountedPrice).toInt())} đ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Thanh Toán: ${_formatMoney(_discountedPrice.toInt())} đ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (widget.priceSale != null)
                          Text(
                            'Mã giảm giá: ${_formatMoney(widget.priceSale ?? 0)} đ',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        if (widget.percentSale != null)
                          Text(
                            'Giảm giá: ${widget.percentSale ?? 0}%',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _confirmPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Xác nhận thanh toán',
                style: TextStyle(fontSize: 16, color: AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }
}
