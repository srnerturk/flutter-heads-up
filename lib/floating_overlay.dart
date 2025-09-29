import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class FloatingOverlayService {
  static bool _isVisible = false;
  
  static bool get isVisible => _isVisible;

  static Future<void> showFloatingBubble() async {
    if (_isVisible) return;

    try {
      // Request permission first
      final bool hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Sistem overlay izni gerekli');
      }

      // Show real floating overlay
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "Uber Taksi",
        overlayContent: '''
        <div style="
          width: 60px; 
          height: 60px; 
          background: #FFD700;
          border-radius: 50%; 
          display: flex; 
          align-items: center; 
          justify-content: center;
          box-shadow: 0 4px 20px rgba(0,0,0,0.4);
          cursor: pointer;
          position: relative;
          border: 3px solid #FFA500;
        ">
          <svg width="28" height="28" fill="#000" viewBox="0 0 24 24">
            <path d="M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.22.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.5 16c-.83 0-1.5-.67-1.5-1.5S5.67 13 6.5 13s1.5.67 1.5 1.5S7.33 16 6.5 16zm11 0c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zM5 11l1.5-4.5h11L19 11H5z"/>
          </svg>
          <div style="
            position: absolute;
            top: -8px;
            right: -8px;
            width: 20px;
            height: 20px;
            background: #FF6B6B;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
            border: 2px solid white;
          ">4</div>
        </div>
        ''',
        width: 80,
        height: 80,
        alignment: OverlayAlignment.topLeft,
        startPosition: const OverlayPosition(16, 250),
      );
      
      _isVisible = true;
      
      // Listen for tap events
      FlutterOverlayWindow.overlayListener.listen((data) {
        if (data == 'click') {
          _handleBubbleClick();
        }
      });
      
    } catch (e) {
      throw Exception('Floating bubble gösterilemedi: $e');
    }
  }

  static Future<void> showFloatingCard({
    required String title,
    required String address,
    required String distance,
  }) async {
    try {
      print('FloatingOverlayService.showFloatingCard called');
      print('_isVisible: $_isVisible');
      
      // Close current overlay if any
      if (_isVisible) {
        print('Closing existing overlay');
        await FlutterOverlayWindow.closeOverlay();
      }

      print('Showing new floating overlay...');
      // Show floating card overlay
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "Sarı Taksi",
        overlayContent: '''
        <div style="
          width: 100%;
          max-width: 400px;
          height: auto;
          background: white;
          border-radius: 16px;
          box-shadow: 0 8px 32px rgba(0,0,0,0.3);
          overflow: hidden;
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          position: relative;
        ">
          <!-- Drag indicator -->
          <div style="
            width: 40px;
            height: 4px;
            background: #E0E0E0;
            border-radius: 2px;
            margin: 8px auto 16px auto;
          "></div>
          
          <!-- Header with icon and close -->
          <div style="
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 16px 12px 16px;
          ">
            <div style="
              background: #000;
              color: white;
              padding: 6px 12px;
              border-radius: 12px;
              font-size: 12px;
              font-weight: 600;
              display: flex;
              align-items: center;
            ">
              🚖 Sarı Taksi
            </div>
            <div style="
              width: 28px;
              height: 28px;
              background: #F5F5F5;
              border-radius: 50%;
              display: flex;
              align-items: center;
              justify-content: center;
              cursor: pointer;
            ">
              ✕
            </div>
          </div>

          <!-- Main content -->
          <div style="padding: 0 16px 16px 16px;">
            <!-- Distance and time info -->
            <div style="
              background: #F8F8F8;
              padding: 12px;
              border-radius: 12px;
              margin-bottom: 16px;
            ">
              <div style="font-size: 24px; font-weight: bold; color: #000; margin-bottom: 4px;">
                4 dk. uzaklıkta
              </div>
              <div style="display: flex; align-items: center; justify-content: space-between;">
                <div style="display: flex; align-items: center;">
                  <span style="color: #FFD700; margin-right: 4px;">★</span>
                  <span style="font-weight: 600; margin-right: 4px; font-size: 14px;">4.9</span>
                  <span style="color: #666; font-size: 14px;">(450)</span>
                </div>
                <div style="color: #666; font-size: 14px;">
                  1.2 km uzaklıkta
                </div>
              </div>
            </div>

            <!-- Address info -->
            <div style="margin-bottom: 16px;">
              <div style="color: #333; font-size: 14px; line-height: 1.4;">
                📍 Merdivenköy, İmam Rauf Sokağı<br/>
                📍 Çamlıdere Bostan, Göztepe 60. Yıl Parkı
              </div>
            </div>

            <!-- Action button -->
            <div style="
              background: #000;
              color: white;
              padding: 16px;
              border-radius: 12px;
              text-align: center;
              font-weight: 600;
              cursor: pointer;
              font-size: 16px;
            ">
              Eşleşme
            </div>
          </div>
        </div>
        ''',
        width: 400,
        height: 280,
        alignment: OverlayAlignment.bottomCenter,
      );
      
      _isVisible = true;
      print('Floating overlay opened successfully!');
    } catch (e) {
      print('Floating card error: $e');
      throw Exception('Floating card gösterilemedi: $e');
    }
  }

  static Future<void> hideFloatingWindow() async {
    if (!_isVisible) return;
    
    try {
      await FlutterOverlayWindow.closeOverlay();
      _isVisible = false;
    } catch (e) {
      throw Exception('Floating window kapatılamadı: $e');
    }
  }

  static Future<void> _handleBubbleClick() async {
    // When taxi bubble is clicked, show the taxi card
    await showFloatingCard(
      title: "Sarı Taksi",
      address: "Merdivenköy, İmam Rauf Sokağı\nNo:63, 34732 Kadıköy/İstanbul, Türkiye", 
      distance: "4 dk. uzaklıkta",
    );
  }

  static Future<bool> requestPermissions() async {
    try {
      print('Checking overlay permissions...');
      // Check if overlay permission is granted
      bool hasPermission = await FlutterOverlayWindow.isPermissionGranted();
      print('Has overlay permission: $hasPermission');
      
      if (!hasPermission) {
        print('Requesting overlay permission...');
        // Request overlay permission
        hasPermission = await FlutterOverlayWindow.requestPermission() ?? false;
        print('Permission request result: $hasPermission');
      }
      
      return hasPermission;
    } catch (e) {
      print('Permission error: $e');
      return false;
    }
  }
}

// Widget for displaying in system overlay
class FloatingBubbleWidget extends StatelessWidget {
  const FloatingBubbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.location_on,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

// Widget for floating card display
class FloatingCardWidget extends StatelessWidget {
  final String title;
  final String address;
  final String distance;
  final VoidCallback? onClose;

  const FloatingCardWidget({
    super.key,
    required this.title,
    required this.address,
    required this.distance,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onClose != null)
                  GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        distance,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Action button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Detaylar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

