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
        double priceSale = 0.0;
        double maxPriceSale = 0.0;
        int quantity = 0;
        String code = '';

        return AlertDialog(
          title: Text('Add New Voucher'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(hintText: "Name"),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(hintText: "Description"),
              ),
              TextField(
                onChanged: (value) => priceSale = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(hintText: "Price Sale"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) =>
                    maxPriceSale = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(hintText: "Max Price Sale"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) => quantity = int.tryParse(value) ?? 0,
                decoration: InputDecoration(hintText: "Quantity"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) => code = value,
                decoration: InputDecoration(hintText: "Code"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final voucher = VoucherDto(
                  priceSale: priceSale,
                  userUsed: [],
                  nameVoucher: name,
                  description: description,
                  maxPriceSale: maxPriceSale,
                  quantity: quantity,
                  codeVoucher: code,
                  id: mongo.ObjectId().toHexString(), // Tạo id hợp lệ mới
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
        Fluttertoast.showToast(msg: 'Voucher added successfully');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Failed to add voucher');
      }
    }
  }

  void _editVoucher(VoucherDto voucher) async {
    final editedVoucher = await showDialog<VoucherDto>(
      context: context,
      builder: (BuildContext context) {
        String name = voucher.nameVoucher;
        String description = voucher.description;
        double priceSale = voucher.priceSale;
        double maxPriceSale = voucher.maxPriceSale;
        int quantity = voucher.quantity;
        String code = voucher.codeVoucher;

        return AlertDialog(
          title: Text('Edit Voucher'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(hintText: "Name"),
                controller: TextEditingController(text: name),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(hintText: "Description"),
                controller: TextEditingController(text: description),
              ),
              TextField(
                onChanged: (value) => priceSale = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(hintText: "Price Sale"),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: priceSale.toString()),
              ),
              TextField(
                onChanged: (value) =>
                    maxPriceSale = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(hintText: "Max Price Sale"),
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: maxPriceSale.toString()),
              ),
              TextField(
                onChanged: (value) => quantity = int.tryParse(value) ?? 0,
                decoration: InputDecoration(hintText: "Quantity"),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: quantity.toString()),
              ),
              TextField(
                onChanged: (value) => code = value,
                decoration: InputDecoration(hintText: "Code"),
                controller: TextEditingController(text: code),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final updatedVoucher = VoucherDto(
                  id: voucher.id,
                  priceSale: priceSale,
                  nameVoucher: name,
                  description: description,
                  maxPriceSale: maxPriceSale,
                  quantity: quantity,
                  codeVoucher: code,
                  userUsed: [],
                );
                _handleEditVoucher(updatedVoucher);
              },
            ),
          ],
        );
      },
    );
  }

  void _handleEditVoucher(VoucherDto updatedVoucher) async {
    try {
      await voucherService.editVoucher(updatedVoucher.id, updatedVoucher);
      setState(() {
        vouchers = voucherService.voucherList();
      });
      Fluttertoast.showToast(msg: 'Voucher updated successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to update voucher');
    }
  }

  void _removeVoucher(String voucherId) async {
    try {
      await voucherService.removeVoucher(voucherId);
      setState(() {
        vouchers = voucherService.voucherList();
      });
      Fluttertoast.showToast(msg: 'Voucher removed successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to remove voucher');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addVoucher,
          ),
        ],
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final voucher = snapshot.data![index];
                return ListTile(
                  title: Text(voucher.nameVoucher),
                  subtitle: Text(voucher.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editVoucher(voucher),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeVoucher(voucher.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
