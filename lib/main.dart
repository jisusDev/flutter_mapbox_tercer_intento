import "package:flutter_mapbox_tercer_intento/widgets/widgets.dart";

void main() => runApp(const ProviderScope(child: MyApp()));

final lightTheme = ThemeData(
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
);



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }
}
