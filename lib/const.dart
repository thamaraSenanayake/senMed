enum Pages{
  Settings,
  HomePage,
  ECG,
  ECGHistory,
  Salary,
  Stock,
  Income,
  PrivatePractice,
  Channeling,
  ChannelingDetails,
  OtherExpends,
  VisitingDoctors,
  DefaultValues,
  ChannelingExtraItems,
  PrivatePracticeHistory
}

class AppData{
  static int getDoseMultiply(String does){
    if(does == AppData.dose[0]){
      return  2;
    }
    if(does == AppData.dose[1]){
      return  3;
    }
    if(does == AppData.dose[2]){
      return  4;
    }
    if(does == AppData.dose[3]){
      return  1;
    }
    if(does == AppData.dose[4]){
      return  1;
    }
    if(does == AppData.dose[5]){
      return  1;
    }
    return 0;
  }
  static const List<String> stockList =["All","Medicine","Other"]; 
  static const List<String> dose =["BD","TDS","QDS","MANE","NOCTE","EOD"]; 
}