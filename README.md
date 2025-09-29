# Uber-Style Flutter PiP & Auto Floating Overlay Demo

Bu uygulama **GERÇEK** Uber benzeri deneyim sunar - Home tuşuna bastığınızda otomatik floating window açılır!

## ✨ Özellikler

- **🎉 UBER Karşılama Ekranı**: "Hoşgeldiniz" ile professional giriş
- **🏠 OTOMATİK Floating Window**: Home tuşuna basınca otomatik açılır
- **📱 MÜKEMMEL Taksi Kartı**: "4 dk. uzaklıkta, X km kaldı" bilgileri
- **🎯 GERÇEK Picture-in-Picture (PiP) Modu**: Native Android PiP desteği  
- **🔐 Otomatik İzin Yönetimi**: Sistem overlay izinlerini otomatik yönetir
- **🚫 Overflow Hatası YOK**: Perfect responsive tasarım

## 🚀 Kurulum

1. **Paketleri yükleyin:**
```bash
flutter pub get
```

2. **Android cihazda çalıştırın (gerçek cihaz gerekli):**
```bash
flutter run
```

> **⚠️ ÖNEMLİ**: Floating overlay özelliği sadece gerçek Android cihazlarda çalışır, emülatörde çalışmaz!

## 📱 Kullanım

### 🎯 PERFECT DEMO DENEYİMİ

1. **Uygulamayı açın**: Uber "Hoşgeldiniz" karşılama ekranı görüntülenir
2. **Home tuşuna basın**: 🏠 OTOMATİK floating window açılır!
3. **Floating kartı görün**: Resimde olduğu gibi "4 dk. uzaklıkta" bilgileri
4. **Overflow hatası YOK**: Perfect responsive tasarım

### 🏠 Otomatik Floating Window
- Home tuşuna bastığınız anda otomatik açılır
- Platform channels ile native Android lifecycle entegrasyonu
- "4 dk. uzaklıkta, 1.2 km uzaklıkta" perfect bilgilendirme
- Drag indicator ile modern Uber tasarımı

### 📱 Mükemmel Taksi Kartı
- **Header**: 🚖 Sarı Taksi + ✕ kapatma butonu
- **Ana bilgi**: "4 dk. uzaklıkta" büyük yazı
- **Rating**: ★4.9 (450) + "1.2 km uzaklıkta"
- **Adresler**: 📍 Merdivenköy + 📍 Çamlıdere Bostan
- **Aksiyon**: "Eşleşme" butonu

### 📺 Bonus PiP Modu
- Home tuşu aynı zamanda PiP modunu da aktif eder
- Hem floating window hem PiP birlikte çalışır

## 🔧 Gereksinimler

- Flutter SDK
- Android API 23+ (Marshmallow)
- System overlay permissions

## 📝 Önemli Notlar

- **Floating overlay** özelliği sadece Android'de çalışır
- İlk kullanımda sistem overlay izinleri istenir
- PiP modu Android 8.0+ sürümlerinde desteklenir

## 🎯 Demo Özellikleri

### 🚖 Uber-Style Interface
- Harita benzeri arka plan (Custom Paint ile çizilmiş sokaklar)
- Başlangıç/Varış noktaları (yeşil/kırmızı pin'ler)
- Taksi ikonları harita üzerinde konumlandırılmış
- Alt panel ile UberX, Comfort, XL seçenekleri

### 🟡 Floating Taksi Bubble
- Ana ekranda sürekli görünen sarı taksi baloncuğu
- "4 dk." badge ile bekleme süresi göstergesi
- Tıklanabilir ve sürüklenebilir
- Diğer uygulamaların üzerinde görünür

### 📱 Full Width Taksi Kartı  
- Ekran genişliğinde tam boyut taksi kartı
- Alt taraftan çıkan Uber benzeri tasarım
- Taksi ikonu, rating (★4.9), mesafe bilgisi
- "AKTİF" durumu göstergesi  
- Fiyat bilgisi (₺25-30 • 4 kişi)
- "Taksi Çağır" butonu ile etkileşim
- Drag indicator ile sürüklenebilir görünüm

### 📺 PiP Mode
- Uygulamayı küçük pencerede gösterir
- Home tuşuna basınca otomatik aktif olur
- Native Android PiP API kullanımı

## 🔒 İzinler

Aşağıdaki izinler AndroidManifest.xml'e eklenmiştir:

```xml
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

## 🎨 Uber-Style Tasarım

Uygulama tam Uber benzeri tasarıma sahiptir:
- **Harita görünümü**: Custom Paint ile çizilmiş sokaklar ve rotalar
- **Taksi konumları**: Gerçekçi taksi ikonları harita üzerinde
- **Modern UI**: Gradient renkler, gölgeler ve Material Design
- **Floating controls**: Sağ üstte floating bubble ve PiP kontrolleri
- **Bottom panel**: UberX, Comfort, XL seçenekleri
- **Sarı taksi bubble**: Ana ekranda sürekli görünen gerçek overlay
- **Taksi kartı**: Uber'daki gibi detaylı taksi bilgi kartı

### 📷 Özellikler
- ✅ Gerçek sistem overlay (diğer uygulamaların üzerinde görünür)
- ✅ Native Android PiP modu
- ✅ HTML/CSS ile zengin tasarım
- ✅ İnteraktif harita simülasyonu
- ✅ Uber benzeri kullanıcı deneyimi