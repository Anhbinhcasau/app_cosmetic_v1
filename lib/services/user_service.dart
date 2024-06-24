import '../../data/user_data.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:dio/dio.dart';


class UserServices {
  static Future<List<UserItem?>> fetchUserList() async {
    final Dio dio = Dio();
    Response response = await dio.get(ApiUrls.GET_RANDOM_USER);
    UserListResponse userListResponse =
        UserListResponse.fromJson(response.data);
    return userListResponse.userItems ?? [];
  }
}