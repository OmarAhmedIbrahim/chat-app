import 'package:chat_app/classes/custom_button_class.dart';
import 'package:chat_app/classes/custom_text_form_field_class.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../classes/validator.dart';
import '../functions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final CustomTextFormFieldClass emailEx = CustomTextFormFieldClass(
      hintText: "BlaBlaBLa@gmail.com", labelText: "Email");

  final CustomTextFormFieldClass passwordEx =
      CustomTextFormFieldClass(hintText: "Abcd@123", labelText: "Password");

  String? emailAddress;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool registered = false;

  bool isLoading = false;

  CustomButtonClass details = CustomButtonClass(ButtonText: "Register");
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
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
                  padding: EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
                  child: Text(
                    "REGISTER NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomTextFormField(
                  controller: emailController,
                  elevation: 10,
                  validator: Validator.emailValidator,
                  hintText: 'Email',
                  onSubmitted: (value) {
                    emailAddress = value;
                  },
                ),
                CustomTextFormField(
                  obscureText: true,
                  controller: passwordController,
                  elevation: 5,
                  validator: Validator.passwordValidator,
                  hintText: 'Password',
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
                        registered = await AuthenticationUsingEmailPass(
                            emailAddress: emailAddress!,
                            password: password!,
                            context: context);
                        setState(() {
                          isLoading = false;
                        });
                      }
                      if (registered == true)  {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  ChatPage(email: emailAddress!,)));
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
