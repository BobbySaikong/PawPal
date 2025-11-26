import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawpal/models/user.dart';
import 'package:pawpal/views/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late User user;
  bool isChecked = false;
  bool isVisible = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/image.png',scale: 2.0,),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Login with your details'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                    icon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: isVisible,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password'),
                    icon: Icon(Icons.key),
                    suffixIcon: IconButton(
                      onPressed: () {
                        

                          if (isVisible) {
                          isVisible = false;
                        } else {
                          isVisible = true;
                        }
                        setState(() {});
                        
                      },
                      icon: Icon(Icons.visibility_outlined),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Remember Me'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {

                        preferencesUpdate(isChecked);
                        
                        isChecked = newValue!;
                        setState(() {
                        });
                        // if(newValue = true){
                        //   if(isChecked = false){
                        //     if(passwordController.text.isEmpty || emailController.text.isEmpty){
                        //       printSnackBar('Please fill in details');
                        //       return;
                        //     }else{
                        //       isChecked = newValue;
                        //     }
                          
                        //   }
                        // }
                        

                      }
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    
                      log('register button pressed.');
                      loginCheck();
                  },
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //check detail, if passed, loginUser() will be called.

  void loginCheck() {
    log('loginCheck starts');
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      printSnackBar('Please fill in email and password.');
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      printSnackBar('Please enter valid email');
      return;
    } else {
      log('loginCheck done.');
      loginUser(email, password);
      
    }
  }

  //todo: loadPref
  void loadPreferences() {
    SharedPreferences.getInstance().then((preference) {
      String? emailCache = preference.getString('Email');
      String? passwordCache = preference.getString('Password');
      emailController.text = emailCache?? '';
      passwordController.text = passwordCache?? '';
    });
  }

  //snackbar (w/ custom message)
  void printSnackBar(String message) {
    SnackBar snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  //todo:loginUser(http POST)
  loginUser(String email, String password) async{
    log('loginUser() starts');

    setState(() {
      isLoading = true;
    });
      if (!mounted) return;
      printSnackBar('Logging in');

    await http.post(
      Uri.parse('http://10.117.3.96/pawpal/api/login_user.php'),
      body: {
        'email': email, 
        'password': password}
    ).then((httpResponse){
      if (httpResponse.statusCode == 200) {
      var jsonResponse = httpResponse.body;
      var responseArray = jsonDecode(jsonResponse);
      log(httpResponse.statusCode.toString());
      log(httpResponse.body.toString());
      if(responseArray['success'] == true){

        user = User.fromJson(responseArray['data'][0]);
        if(!mounted) return;
        printSnackBar('Login successful!');

        
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(user: user),
                ),
              );

      }else{
        if(!mounted) return;
        printSnackBar('Login failed, Please try again.');
      }
    }else{
      if(!mounted)return;
      printSnackBar('Login failed. Please try again');

    }
    });

    
    }
  

  Future<void> preferencesUpdate(bool isChecked) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      printSnackBar('Please fill in email and password.');
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      printSnackBar('Please enter valid email');
      return;
    }else{
    SharedPreferences preference = await SharedPreferences.getInstance();
    if (isChecked) {
      preference.setString('Email', emailController.text);
      preference.setString('Password', passwordController.text);
      preference.setBool('RememberMe', isChecked);
    } else {
      preference.remove('Email');
      preference.remove('Password');
      preference.remove('RememberMe');
    }
    log('preferences updated.');}
    isChecked = true;
    setState(() {
      
    });
  }
}