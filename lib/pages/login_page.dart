import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../classes/custom_button_class.dart';
import '../classes/custom_text_form_field_class.dart';
import '../classes/validator.dart';
import '../constants.dart';
import '../functions.dart';
import '../widgets/custom_text_form_field.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final CustomTextFormFieldClass emailEx = CustomTextFormFieldClass(
      hintText: "BlaBlaBLa@gmail.com", labelText: "Email");

  final CustomTextFormFieldClass passwordEx =
      CustomTextFormFieldClass(hintText: "Abcd@123", labelText: "Password");

  CustomButtonClass details = CustomButtonClass(ButtonText: "Login");

  String? emailAddress;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool loggedIn = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    kimagePath,
                    fit: BoxFit.fill,
                  ),
                ),
                const Center(
                  child: Text(
                    "Scholar Chat App",
                    style: TextStyle(
                      fontFamily: kfontName,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
                  child: Text(
                    "LOGIN NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomTextFormField(
                  elevation: 10,
                  validator: Validator.emailValidator,
                  hintText: 'Email',
                  controller: emailController,
                  onSubmitted: (value) {
                    emailAddress = value;
                  },
                ),
                CustomTextFormField(
                  elevation: 5,
                  validator: Validator.passwordValidator,
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  onSubmitted: (value) {
                    password = value;
                  },
                ),
                CustomButton(
                    details: details,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        emailController.clear();
                        passwordController.clear();
                        setState(() {
                          isLoading = true;
                        });
                        loggedIn = await LoginUsingEmailPass(
                            emailAddress: emailAddress!,
                            password: password!,
                            context: context);
                        setState(() {
                          isLoading = false;
                        });
                      }
                      if (loggedIn == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      email: emailAddress!,
                                    )));
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
