import 'package:blog_app/models/api_response.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/screens/home.dart';
import 'package:blog_app/screens/login.dart';
import 'package:blog_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response =
        await registerUser(txtName.text, txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            TextFormField(
              controller: txtName,
              validator: (val) => val!.isEmpty ? 'Invalid name' : null,
              // ignore: prefer_const_constructors
              decoration: kInputDecoration('Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              // ignore: prefer_const_constructors
              decoration: kInputDecoration('Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: txtPassword,
              obscureText: true,
              validator: (val) =>
                  val!.length < 6 ? 'Required at least 6 character.' : null,
              // ignore: prefer_const_constructors
              decoration: kInputDecoration('Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: txtConfirmPassword,
              obscureText: true,
              validator: (val) =>
                  val != txtPassword.text ? 'Password does not match' : null,
              // ignore: prefer_const_constructors
              decoration: kInputDecoration('Confirm Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : kTextButton('Register', () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                        _registerUser();
                        // _loginUser();
                      });
                    }
                  }),
            const SizedBox(
              height: 10,
            ),
            kLoginRegisterHint(
              'Already have an account?',
              ' Login',
              () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
