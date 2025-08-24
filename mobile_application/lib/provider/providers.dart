import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/data_models/menu.dart';
import 'package:mobile_application/services/firestore_service.dart';

class MenuNotifier extends StateNotifier<List<Menu>> {
  MenuNotifier() : super([]) ; 

  void addMenu(Menu toAddMenu) {
    FirestoreService.addMenu(toAddMenu) ;
    state = [...state, toAddMenu] ; 
  }

  void removeMenu(Menu toRemoveMenu) {
    FirestoreService.removeMenu(toRemoveMenu) ;
    final List<Menu> newList = [...state] ; 
    newList.removeWhere((m) => m.menuId == toRemoveMenu.menuId) ;
    state = newList ;   
  }

}

final menuNotifierProvider = StateNotifierProvider<MenuNotifier, List<Menu>>((ref) {
  return MenuNotifier() ; 
}) ; 