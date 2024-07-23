import 'package:app_cosmetic/model/voucher.model.dart';
import 'package:app_cosmetic/services/voucher_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class VoucherManagementScreen extends StatefulWidget {
  @override
  _VoucherManagementScreenState createState() =>
      _VoucherManagementScreenState();
}

class _VoucherManagementScreenState extends State<VoucherManagementScreen> {
  late VoucherService voucherService;
  late Future<List<VoucherDto>> vouchers;

  @override
  void initState() {
    super.initState();
    voucherService = VoucherService();
    vouchers = voucherService.voucherList();
  }

  void _addVoucher() async {
    final newVoucher = await showDialog<VoucherDto>(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        String description = '';
        int priceSale = 0;
        int maxPriceSale = 0;
        int quantity = 0;
        String code = '';

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Thêm mới voucher',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(
                    'Tên mã giảm giá', 'Tên Voucher', (value) => name = value),
                _buildTextField(
                    'Mô tả', 'Mô tả', (value) => description = value),
                _buildTextField(
                    'Giá giảm',
                    'Giá giảm',
                    (value) => priceSale = int.tryParse(value) ?? 0,
                    TextInputType.number),
                _buildTextField(
                    'Giảm tối đa',
                    'Giảm tối đa',
                    (value) => maxPriceSale = int.tryParse(value) ?? 0,
                    TextInputType.number),
                _buildTextField(
                    'Số lượng',
                    'Số lượng',
                    (value) => quantity = int.tryParse(value) ?? 0,
                    TextInputType.number),
                _buildTextField(
                    'Code Voucher', 'Code Voucher', (value) => code = value),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Thêm', style: TextStyle(color: Colors.green)),
              onPressed: () {
                final voucher = VoucherDto(
                  percent_sale: priceSale,
                  userUsed: [],
                  nameVoucher: name,
                  description: description,
                  maxPriceSale: maxPriceSale,
                  quantity: quantity,
                  codeVoucher: code,
                  id: mongo.ObjectId().toHexString(), // Generate valid new id
                );
                Navigator.of(context).pop(voucher);
              },
            ),
          ],
        );
      },
    );

    if (newVoucher != null) {
      try {
        await voucherService.newVoucher(newVoucher);
        setState(() {
          vouchers = voucherService.voucherList();
        });
        Fluttertoast.showToast(msg: 'Đã thêm voucher thành công');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Thêm voucher thất bại');
      }
    }
  }

  Widget _buildTextField(String label, String hint, Function(String) onChanged,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0, // Tăng kích thước chữ cho nhãn
              )),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 14.0), // Kích thước chữ nhỏ hơn cho trường văn bản
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }

  void _removeVoucher(String id) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn chắc chắn muốn xóa voucher này ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete ?? false) {
      try {
        await voucherService.removeVoucher(id);
        setState(() {
          vouchers = voucherService.voucherList();
        });
        Fluttertoast.showToast(msg: 'Voucher removed successfully');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Failed to remove voucher');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF13131A),
        title: const Text(
          'QUẢN LÝ VOUCHER',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<VoucherDto>>(
        future: vouchers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No vouchers available'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final voucher = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(voucher.codeVoucher),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Giảm giá: ${voucher.percent_sale}%'),
                        Text('Số lượng: ${voucher.quantity}'),
                        Text('Code: ${voucher.codeVoucher}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeVoucher(voucher.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addVoucher,
        child: Icon(Icons.add),
      ),
    );
  }
}
