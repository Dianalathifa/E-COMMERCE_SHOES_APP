import 'package:flutter/material.dart';
import 'package:sneaker_shop_app/pages/login.dart';
import 'package:sneaker_shop_app/models/users.dart';
import 'package:sneaker_shop_app/sqlite.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              const ListTile(
                title: Text(
                  "Register New Account",
                  style:  TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),


              Container(
                margin: EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400]!.withOpacity(0.2),
                ),
                child: TextFormField(
                  controller: username,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: InputBorder.none,
                    hintText: "Username",
                  ),
                ),
              ),
              // Password field
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400]!.withOpacity(0.3),
                ),
                child: TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Membuat click untuk menampilkan dan menyembunyikan password
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(isVisible 
                          ? Icons.visibility 
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              
              //confirm password field

              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400]!.withOpacity(0.3),
                ),
                child: TextFormField(
                  controller: confirmPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }else if(password.text != confirmPassword.text) {
                      return "Password don't match";
                    }
                    return null;
                  },
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Membuat click untuk menampilkan dan menyembunyikan password
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(isVisible 
                          ? Icons.visibility 
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              // Add other form fields or widgets as needed
              
              const SizedBox(height: 10),
              // SIGNUP Button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(color: Colors.grey[850]),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {

                          final db = DatabaseHelper();
                          db.signup(Users(userName: username.text, userPassword: password.text)).whenComplete(() {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> Login())); 
                          });                       
                        }
                      },
                      child: const Text(
                        "SIGN UP", 
                      style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  // SizedBox added here to separate the login button and the "Don't have an account?" text
                  const SizedBox(height: 10),

                  // Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          // Add your sign-up logic here
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const Login()));
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
