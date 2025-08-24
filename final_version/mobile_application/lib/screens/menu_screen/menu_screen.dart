// menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/data_models/menu.dart';
import 'package:mobile_application/main.dart';
import 'package:mobile_application/provider/providers.dart';
import 'package:mobile_application/screens/shared_for_screens/screen_enum.dart';
import 'package:mobile_application/services/api.dart';
import 'package:mobile_application/shared/styled_text.dart';
import 'package:mobile_application/theme.dart';
import 'package:mobile_application/shared/styled_button.dart';
import 'package:mobile_application/screens/home/product_card.dart';
import 'package:mobile_application/data_models/product.dart';
import 'package:uuid/uuid.dart';
import 'package:mobile_application/screens/home/home_screen.dart';
import 'package:mobile_application/screens/menu_screen/menu_screen.dart';
import 'package:mobile_application/screens/shared_for_screens/bottom_navigation_bar.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(menuCategoryFutureProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Vorschläge"),
      ),
      bottomNavigationBar: const ScreenBottomNavigationBar(currentScreen: AppScreensEnum.menu),
      body: asyncValue.when(
        data: (data) {
          
          if (data.isEmpty) {
            return const Center(
              child: Text("No menu suggestions found."),
            );
          }
          return GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(15),
            children: List.generate(data.length, (index) {
              final meal = data[index]; 
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryAccentColor,
                ),
                child: StyledHeading(meal.menuTitle)
              );
            }),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(200, 80, 70, 1),
          ),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}