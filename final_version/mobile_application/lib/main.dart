import 'package:flutter/material.dart';
import 'package:mobile_application/provider/providers.dart';
import 'package:mobile_application/theme.dart';
import 'package:mobile_application/screens/home/home_screen.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// A provider that handles the asynchronous initialization
final appInitializerProvider = FutureProvider<void>((ref) async {
  // Load menus and products
  await ref.read(menuNotifierProvider.notifier).loadMenus();
  await ref.read(productNotifierProvider.notifier).loadProducts();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the future provider to handle the loading state
    final asyncValue = ref.watch(appInitializerProvider);

    return MaterialApp(
      title: 'Mobile Application',
      theme: primaryTheme, 
      home: asyncValue.when(
        data: (_) => const HomeScreen(),
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color : Color.fromRGBO(200, 80, 70, 1)
            ),
          ),
        ),
        error: (error, stack) => Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        ),
      ),
    ); 
  }
}