import 'package:app_cosmetic/screen/user/profile/forgot_pass.dart';
import 'package:app_cosmetic/screen/user/profile/process_oder.dart';
import 'package:app_cosmetic/screen/user/Home/home.dart';
import 'package:app_cosmetic/screen/sign_up.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/564x/5f/6b/50/5f6b50ae839f59f5f002d25eb0e42a44.jpg'),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      color: Colors.brown,
                      size: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Huỳnh Thanh Bình',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Divider(),
              ListTile(
                leading: Icon(Icons.person, color: Colors.brown),
                title: Text('Your profile'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  // Handle navigation to "Your profile"
                },
              ),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.brown),
                title: Text('Payment Methods'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  // Handle navigation to "Payment Methods"
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.brown),
                title: Text('My Orders'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProcessOder()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.brown),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.brown),
                title: Text('Log out'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
