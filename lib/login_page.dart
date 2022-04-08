import 'package:chat_app/firebase_helper.dart';
import 'package:chat_app/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true;
  Service service = Service();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login Page', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword ? true : false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      }, 
                      icon: hidePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    ),
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      service.loginUser(context, emailController.text, passwordController.text);
                      pref.setString("email", emailController.text);
                    }else{
                      service.erroBox(context, "Fields must be not empty!");
                    }
                  }, 
                  child: Text("Login"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => RegisterPage(title: "Register Page",)),
                    );
                  }, 
                  child: Text("Don't have account?\n Register now!", textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
