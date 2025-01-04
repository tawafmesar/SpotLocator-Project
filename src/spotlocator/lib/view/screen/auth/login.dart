import 'package:flutter/material.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';

import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/LogoAuth.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import 'package:get/get.dart';

import '../../widget/auth/textsignup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 3.0,
        title: Text(
          'Login',
          style: Theme.of(context)
              .textTheme.headlineMedium!
              .copyWith(color: AppColor.text),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataViewRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    const LogoAuth(),
                    const SizedBox(height: 20),
                    const CustomTextTitleAuth(text: "Welcome"),
                    const SizedBox(height: 10),
                    const CustomTextBodyAuth(
                      text: "Log in with your email and password",
                    ),
                    const SizedBox(height: 15),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) => validInput(val!, 5, 100, "email"),
                      mycontroller: controller.email,
                      hinttext: "Enter your email",
                      iconData: Icons.email_outlined,
                      labeltext: "Email",
                    ),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) => validInput(val!, 5, 30, "password"),
                      obscureText: true,
                      mycontroller: controller.password,
                      hinttext: "Enter your password",
                      iconData: Icons.lock_outline,
                      labeltext: "Password",
                    ),
                    InkWell(
                      onTap: controller.goToForgetPassword,
                      child: const Text(
                        "Forgot password?",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    CustomButtomAuth(
                      text: "Login",
                      onPressed: controller.login,
                    ),
                    const SizedBox(height: 40),
                    CustomTextSignUpOrSignIn(
                      textone: "Don't have an account? ",
                      texttwo: "Create an account",
                      onTap: controller.goToSignUp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
