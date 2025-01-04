import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/signup_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/LogoAuth.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import '../../widget/auth/textsignup.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 3.0,
        title: Text(
          'Registration',
          style: Theme.of(context)
              .textTheme.headlineMedium!
              .copyWith(color: AppColor.text),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignUpControllerImp>(
            builder: (controller) => HandlingDataViewRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30),
                child: Form(
                  key: controller.formstate,
                  child: ListView(children: [
                    const LogoAuth(),
                    const SizedBox(height: 15),
                    const CustomTextTitleAuth(text: "Welcome"),
                    const SizedBox(height: 8),
                    const CustomTextBodyAuth(
                        text:
                        "You can create an account using your email and some information about you"),
                    const SizedBox(height: 15),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 3, 20, "username");
                      },
                      mycontroller: controller.username,
                      hinttext: "Enter your username",
                      iconData: Icons.person_outline,
                      labeltext: "Username",
                    ),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 3, 35, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "Enter your email",
                      iconData: Icons.email_outlined,
                      labeltext: "Email",
                    ),
                    CustonTextFormAuth(
                      isNumber: true,
                      valid: (val) {
                        return validInput(val!, 2, 19, "phone");
                      },
                      mycontroller: controller.phone,
                      hinttext: "Enter your phone number",
                      iconData: Icons.phone_android_outlined,
                      labeltext: "Phone Number",
                    ),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 3, 30, "password");
                      },
                      obscureText: true,
                      mycontroller: controller.password,
                      hinttext: "Enter your password",
                      iconData: Icons.lock_outline,
                      labeltext: "Password",
                    ),
                    CustomButtomAuth(
                        text: "Create", onPressed: () {
                      controller.signUp();
                    }),
                    const SizedBox(height: 20),
                    CustomTextSignUpOrSignIn(
                      textone: "Already have an account? ",
                      texttwo: "Go to login",
                      onTap: () {
                        controller.goToSignIn();
                      },
                    ),
                    const SizedBox(height: 30),

                  ]),
                ),
              ),
            )),
      ),
    );
  }
}
