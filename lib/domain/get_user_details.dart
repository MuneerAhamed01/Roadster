import '../main.dart';
import 'models/user_login.dart';

class GetUserDetailsFormSharedPRef {
 LoginDetails getUserDetails() {
    final responseId = preferences.getString("userData");
    final userId = loginDetailsFromJson(responseId!);
    return userId;
  }
}
