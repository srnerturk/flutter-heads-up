import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class CallerOverlay extends StatefulWidget {
  const CallerOverlay({Key? key}) : super(key: key);

  @override
  State<CallerOverlay> createState() => _CallerOverlayState();
}

class _CallerOverlayState extends State<CallerOverlay> {
  int? _receivedTickValue;
  String _lastUpdated = '';

  @override
  void initState() {
    super.initState();
    FlutterOverlayWindow.overlayListener.listen((event) {
      log('Overlay data: $event');
      if (event is Map) {
        setState(() {
          _receivedTickValue = event['tickValue'];
          _lastUpdated = event['timestamp'] ?? '';
        });
      }
    });
  }

  String _formatTime() {
    if (_lastUpdated.isEmpty) return 'Bilinmiyor';
    try {
      final time = DateTime.parse(_lastUpdated);
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Şimdi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 400),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with profile pic and close button
                  Row(
                    children: [
                      Container(
                        height: 32.0,
                        width: 32.0,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Sarı Taksi",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await FlutterOverlayWindow.closeOverlay();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Distance text - shows received tick value
                  Text(
                    _receivedTickValue != null 
                        ? "$_receivedTickValue saniye geçti"
                        : "3 dk. uzaklıkta",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating and distance info
                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.blue, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        _receivedTickValue != null ? "Live Timer" : "4,90",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _receivedTickValue != null 
                            ? "Data alındı: ${_formatTime()}"
                            : "1,1 km uzaklıkta",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Location details
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.black54),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Caddebostan, Göztepe 60. Yıl Parkı, 34728 Kadıköy/İstanbul, Türkiye",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        log("Eşleşme butonuna tıklandı");
                        FlutterOverlayWindow.getOverlayPosition().then((value) {
                          log("Overlay Position: $value");
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _receivedTickValue != null ? "Timer Aktif: $_receivedTickValue" : "Eşleşme",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}