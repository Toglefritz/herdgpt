import 'package:firebase_remote_config/firebase_remote_config.dart';

/// The keys used for Firebase Remote Config variables.

enum RemoteConfigKeys {
  initialTokenBalance('initial_token_balance');

  final String key;

  const RemoteConfigKeys(this.key);
}

/// Contains fields and methods related to Firebase Remote Configs, which are used to set configurations
/// options used by the app without requiring a new app build.

class RemoteConfigs {
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  /// The initial token balance to award to newly created accounts.
  static int get initialTokenBalance => remoteConfig.getInt(RemoteConfigKeys.initialTokenBalance.key);

  /// Initializes the Firebase Remote Configs service, allowing the app to retrieve remote configuration
  /// variables from Firebase.
  static Future<void> initializeRemoteConfigs() async {
    // Firebase Remote Configs setup
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await remoteConfig.setDefaults({
      RemoteConfigKeys.initialTokenBalance.key: 20000,
    });
  }
}
