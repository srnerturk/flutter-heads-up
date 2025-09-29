import 'dart:async';
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
    const MaterialApp(debugShowCheckedModeBanner: false, home: CallerOverlay()),
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

class _UberHomePageState extends State<UberHomePage>
    with WidgetsBindingObserver {
  Timer? _timer;
  int _tickCounter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _tickCounter++;
      });
      
      // Her tick'te otomatik olarak overlay'e data gönder
      _sendTickDataToOverlay();
    });
  }

  Future<void> _sendTickDataToOverlay() async {
    try {
      await sendDataToOverlay({
        'message': 'Auto tick from main app',
        'tickValue': _tickCounter,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Hata durumunda sessizce devam et
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Uygulama arka plana atıldığında overlay'i göster
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      showOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildWelcomeScreen());
  }

  Future<void> sendDataToOverlay(dynamic data) async {
    await FlutterOverlayWindow.shareData(data);
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
            Text(
              'Welcome to the Head up Display demo page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Timer her saniye overlay\'e otomatik gönderilir. Home tuşuna basın veya manual olarak açın.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'Timer Counter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$_tickCounter',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  Text(
                    'saniye (otomatik gönderim)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
            ElevatedButton(
              onPressed: () async {
                await showOverlay();
                showNotification('Overlay manuel olarak açıldı');
              },
              child: Text('Show Overlay Manually'),
            ),
          ],
        ),
      ),
    );
  }
}
