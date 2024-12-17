import 'package:get/get.dart';

enum SignupOptionsEnum {
  customer,
  artist,
  studio
}

class SignupController extends GetxController {
  
  final signupOption = SignupOptionsEnum.customer.obs;

  final activeSignupPage = 1.obs;


  isOptionSelected(SignupOptionsEnum option) {
    return signupOption.value == option;
  }

  selectOption(SignupOptionsEnum option) => signupOption.value = option;

}
