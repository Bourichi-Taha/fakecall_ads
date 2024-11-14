import 'package:fakecall/model/data.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {

  Data data = Data();

  void setData(Data data) {
    this.data = data;
    notifyListeners();
  }

  
  Data getData() {
    return data;
  }
}
