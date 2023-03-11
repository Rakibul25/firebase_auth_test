
import '../models/login_model.dart';

class LoginController {
  final model = LoginModel();

  void dispose() {
    model.dispose();
  }
}