import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// API Configuration for the application
/// 
/// This class provides centralized management of API endpoints and configuration.
/// It handles platform-specific localhost mappings to ensure the app can communicate
/// with a local backend server regardless of the deployment platform.
/// 
/// Platform-specific localhost handling:
/// - Web: Uses 'localhost' (runs in browser on same machine)
/// - Android Emulator: Uses '10.0.2.2' (special alias that routes to host machine)
/// - Android Physical Device: Would need actual server IP (not implemented here)
/// - iOS: Uses 'localhost' (can access host machine directly)
/// - Windows/macOS/Linux: Uses 'localhost' (desktop platforms)
class ApiConfig {
  /// Private constructor to prevent instantiation
  ApiConfig._();

  /// The base URL for the API server
  /// 
  /// Automatically selects the appropriate host based on:
  /// - Platform (web, Android, iOS, etc.)
  /// - Execution environment (emulator vs physical device)
  /// 
  /// Returns the correct localhost variant for each platform
  static String get baseUrl {
    return 'http://$_getHost:8000';
  }

  /// Private helper to get the platform-specific host
  /// 
  /// Logic:
  /// - **Web**: 'localhost' - App runs in browser on the same machine
  /// - **Android Emulator**: '10.0.2.2' - Special Docker-like alias in Android emulator
  ///   that automatically routes to the host machine's localhost
  /// - **iOS/Desktop**: 'localhost' - These can access the host machine directly
  /// 
  /// Note: For Android physical devices, you would need to replace 'localhost'
  /// with your actual server IP address (e.g., '192.168.x.x')
  static String get _getHost {
    if (kIsWeb) {
      return '127.0.0.1';
    } else if (Platform.isAndroid) {
      // Android emulator uses 10.0.2.2 to access host machine
      // For physical device, replace with actual server IP
      return '127.0.0.1';
    }
    // iOS, Windows, macOS, Linux - all can use localhost
    return '127.0.0.1';
  }

  /// Login endpoint path
  static const String loginEndpoint = '/users/login';

  /// Registration endpoint path
  static const String registerEndpoint = '/users/register';

  /// Complete login URL
  static String get loginUrl => '$baseUrl$loginEndpoint';

  /// Complete registration URL
  static String get registerUrl => '$baseUrl$registerEndpoint';

  /// API request headers
  /// 
  /// Standard headers for JSON API communication
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  /// HTTP status codes for success
  static const List<int> successStatusCodes = [200, 201];

  /// Request timeout duration in seconds
  static const int requestTimeoutSeconds = 30;
}
