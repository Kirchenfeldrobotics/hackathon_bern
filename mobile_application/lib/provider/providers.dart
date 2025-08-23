import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/data_models/menu.dart';

class MenuNotifier extends StateNotifier<List<Menu>> {
  MenuNotifier() : super([]) ; 

  void addMenu(Menu toAddMenu) {
    state = [...state, toAddMenu] ; 
  }

  void removeMenu(Menu toRemoveMenu) {
    final List<Menu> newList = [...state] ; 
    newList.removeWhere((m) => m.menuId == toRemoveMenu.menuId) ;
    state = newList ;   
  }

}