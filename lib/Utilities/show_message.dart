import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentee_real_estate/Utilities/colors.dart';

class Utils {
  static Future<void> showMessage(String message) async {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
