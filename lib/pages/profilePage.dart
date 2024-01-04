import 'package:flutter/material.dart';
import 'package:sneaker_shop_app/models/users.dart';
import 'package:sneaker_shop_app/sqlite.dart';

class ProfilePage extends StatefulWidget {
  final String userName;

  const ProfilePage({required this.userName, Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Users user;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    bool isLoginSuccess = await dbHelper.login(Users(userName: widget.userName, userPassword: ''));

    if (isLoginSuccess) {
      user = await dbHelper.getUserByUsername(widget.userName);

      if (user != null) {
        setState(() {
          // Tidak perlu menginisialisasi variabel user di sini.
          // Kita hanya perlu mengisi nilai variabel user yang sudah dideklarasikan di atas.
        });
      }
    } else {
      // Handle login failure, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey,
      ),
      body: user != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User ID: ${user.userId}'),
                const SizedBox(height: 8),
                Text('Username: ${user.userName}'),
                // Add more profile details as needed
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
