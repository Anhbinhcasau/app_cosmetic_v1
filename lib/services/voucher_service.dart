import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/voucher.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VoucherService {
  Future<VoucherDto?> newVoucher(VoucherDto voucher) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/voucher/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(voucher.toJson()),
    );

    if (response.statusCode == 200) {
      return VoucherDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create voucher');
    }
  }

  Future<void> useVoucher(VoucherDto voucher) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/voucher/useVoucher'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(voucher.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to use voucher');
    }
  }

  Future<List<VoucherDto>> voucherList() async {
    final response = await http.get(
      Uri.parse('${Api.DB_URI}/voucher/list'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => VoucherDto.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load voucher list');
    }
  }

  Future<void> removeVoucher(String id) async {
    final response = await http.delete(
      Uri.parse('${Api.DB_URI}/voucher/remove/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete voucher: ${response.body}');
    }
  }

  Future<VoucherDto> editVoucher(String id, VoucherDto voucher) async {
    final response = await http.put(
      Uri.parse('${Api.DB_URI}/voucher/edit/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(voucher.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return VoucherDto.fromJson(responseData['voucher']);
    } else {
      throw Exception('Failed to edit voucher');
    }
  }

  Future<VoucherDto?> findVoucherByVoucherName(String voucherName) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/voucher/applyVoucher'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'voucherName': voucherName}),
    );

    if (response.statusCode == 200) {
      return VoucherDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to apply voucher');
    }
  }
}
