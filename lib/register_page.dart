import 'package:chat_app/firebase_helper.dart';
import 'package:chat_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                  'Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                    hintText: "Enter Your Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      }, 
                      icon: hidePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    ),
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
                      service.createUser(context, emailController.text, passwordController.text);
                      pref.setString("email", emailController.text);
                    }else{
                      service.erroBox(context, "Fields must be not empty!");
                    }
                  }, 
                  child: Text("Register"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                  },
                  child: Text("Already have account?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
