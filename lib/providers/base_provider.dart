import 'package:flutter/foundation.dart';

import '../const.dart';

class BaseProvider with ChangeNotifier {
  bool isLoading = false;
  Pages currentPage = Pages.HomePage;


  setLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void setProfilePage(Pages page,){
    currentPage = page;
    notifyListeners();
  }
}
