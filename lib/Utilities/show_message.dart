import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';

class Utils {
  static Future<void> showMessage({
    required String message,
    Toast? toastLength,
  }) async {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      fontSize: 16,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
    );
  }
}
