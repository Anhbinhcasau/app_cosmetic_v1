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
  Cart cart;
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
  VoucherDto? _appliedVoucher;
  late VoucherService _voucherService;
  int _discountedPrice = 0;
  final TextEditingController _voucherController = TextEditingController();
  bool _voucherValid = true;

  @override
  void initState() {
    super.initState();
    _voucherService = VoucherService();
    _calculateTotalPrice();
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
          .findVoucherByVoucherName(_voucherController.text.toUpperCase());
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
          _discountedPrice = _calculateTotalPrice();
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
        _discountedPrice = _calculateTotalPrice();
        _voucherValid = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mã giảm giá không hợp lệ')),
      );
    }
  }

  int _calculateDiscountedPrice() {
    if (_appliedVoucher == null || widget.cart == null) {
      return _calculateTotalPrice();
    }

    final discount =
        widget.cart.totalPriceCart * _appliedVoucher!.percent_sale / 100;
    final maxDiscount = _appliedVoucher!.maxPriceSale.toInt();
    final actualDiscount =
        discount.toInt() > maxDiscount ? maxDiscount : discount.toInt();
    return _calculateTotalPrice() - actualDiscount;
  }

  int _calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in widget.cart.itemsCart) {
      totalPrice += item.price.toInt() * item.quantity;
    }
    return totalPrice;
  }

  Future<void> _refreshCart() async {
    final cart = await CartService().getCartByUserId(widget.userId);
    if (cart != null) {
      setState(() {
        widget.cart = cart;
        _discountedPrice = _calculateDiscountedPrice();
      });
    }
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

      // Gọi _refreshCart để cập nhật giỏ hàng và giá trị đơn hàng mới nhất
      await _refreshCart();

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
        final check = await CheckoutService.checkoutOrder(checkout);
        print('kiểm tra dữ liệu: $check');
        if (check == "201" || check == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đặt hàng thành công!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
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
    _discountedPrice =
        _calculateDiscountedPrice(); // Tính giá trị sau khi giảm giá

    return GestureDetector(
      onTap: (() {
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      child: Scaffold(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                                return 'Vui lòng nhập họ tên';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              fullName = value!;
                            },
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
                            onSaved: (value) {
                              phone = value!;
                            },
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
                            onSaved: (value) {
                              email = value!;
                            },
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
                            onSaved: (value) {
                              address = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Áp dụng mã giảm giá
                    Text(
                      'Mã giảm giá:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _voucherController,
                            decoration: InputDecoration(
                              labelText: 'Nhập mã giảm giá',
                              errorText: _voucherValid
                                  ? null
                                  : 'Mã giảm giá không hợp lệ',
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: _applyVoucher,
                          child: Text(
                            'Áp dụng',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    // Hiển thị tổng giá và giá trị giảm
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng giá:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          '${_formatMoney(_calculateTotalPrice())} đ',
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _appliedVoucher != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Giảm giá:',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '-${_formatMoney(_calculateTotalPrice() - _discountedPrice)} đ',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.green),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Giá sau giảm:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    '${_formatMoney(_discountedPrice)} đ',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _confirmPayment,
                child: Text(
                  'Xác nhận thanh toán',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat("#,###");
    return formatter.format(amount);
  }
}
