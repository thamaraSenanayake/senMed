import 'package:balance/model/channelingModel.dart';
import 'package:flutter/foundation.dart';

import '../const.dart';

class BaseProvider with ChangeNotifier {
  bool isLoading = false;
  Pages currentPage = Pages.HomePage;
  ChannelingModel? channelingModel;


  setLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void setProfilePage(Pages page,{ChannelingModel? channelingModel}){
    currentPage = page;
    if(channelingModel != null){
      this.channelingModel = channelingModel;
    }
    notifyListeners();
  }
}
