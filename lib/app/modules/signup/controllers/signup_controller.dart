import 'package:get/get.dart';

enum SignupOptionsEnum {
  customer,
  artist,
  studio
}

class SignupController extends GetxController {
  
  final signupOption = SignupOptionsEnum.customer.obs;


  isOptionSelected(SignupOptionsEnum option) {
    return signupOption.value == option;
  }

  selectOption(SignupOptionsEnum option) => signupOption.value = option;

}
