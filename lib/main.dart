import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_pip_demo/overlays/true_caller_overlay.dart';

void main() {
  runApp(const MainApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const UberHomePage(),
    );
  }
}

class UberHomePage extends StatefulWidget {
  const UberHomePage({super.key});

  @override
  State<UberHomePage> createState() => _UberHomePageState();
}

class _UberHomePageState extends State<UberHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Uygulama arka plana atıldığında overlay'i göster
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      showOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildWelcomeScreen());
  }

  void showNotification(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showOverlay() async {
    if (await FlutterOverlayWindow.isActive()) return;
    await FlutterOverlayWindow.showOverlay(
                  enableDrag: true,
                  overlayTitle: "X-SLAYER",
                  overlayContent: 'Overlay Enabled',
                  flag: OverlayFlag.defaultFlag,
                  visibility: NotificationVisibility.visibilityPublic,
                  positionGravity: PositionGravity.auto,
                  height: (MediaQuery.of(context).size.height).toInt(),
                  width: WindowSize.matchParent,
                  startPosition: const OverlayPosition(0, 10),
                );
  }

  Widget _buildWelcomeScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Welcome to the Head up Display demo page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10),
            Text('Please press the home button to see the overlay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
            ElevatedButton(
              onPressed: () async {
                final bool status =
                    await FlutterOverlayWindow.isPermissionGranted();
                showNotification('status: $status');
                if (!status) {
                  final bool status =
                      await FlutterOverlayWindow.requestPermission() ?? false;
                  showNotification('status: $status');
                }
              },
              child: Text('Check Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
