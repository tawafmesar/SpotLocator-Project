import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/resetpassword_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/validinput.dart';
import '../../../widget/auth/LogoAuth.dart';
import '../../../widget/auth/custombuttonauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResetPasswordControllerImp controller =
    Get.put(ResetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 3.0,
        title: Text(
          'Reset Password',
          style: Theme.of(context)
              .textTheme.headlineMedium!
              .copyWith(color: AppColor.text),
        ),
      ),
      body: GetBuilder<ResetPasswordControllerImp>(
        builder: (controller) =>
            HandlingDataViewRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30),
                child: Form(
                  key: controller.formstate,
                  child: ListView(children: [
                    const LogoAuth(),
                    const SizedBox(height: 20),
                    CustomTextTitleAuth(text: "New Password"),
                    const SizedBox(height: 10),
                    CustomTextBodyAuth(
                        text: "Enter your new password"),
                    const SizedBox(height: 15),
                    CustonTextFormAuth(
                      isNumber: false,
                      obscureText: true,
                      valid: (val) {
                        return validInput(val!, 3, 40, "password");
                      },
                      mycontroller: controller.password,
                      hinttext: "Enter your password",
                      iconData: Icons.lock_outline,
                      labeltext: "Password",
                    ),
                    CustonTextFormAuth(
                      isNumber: false,
                      obscureText: true,
                      valid: (val) {
                        return validInput(val!, 3, 40, "password");
                      },
                      mycontroller: controller.repassword,
                      hinttext: "Re-enter your password",
                      iconData: Icons.lock_outline,
                      labeltext: "Confirm Password",
                    ),
                    CustomButtomAuth(
                        text: "Save",
                        onPressed: () {
                          controller.goToSuccessResetPassword();
                        }),
                    const SizedBox(height: 40),
                  ]),
                ),
              ),
            ),
      ),
    );
  }
}
