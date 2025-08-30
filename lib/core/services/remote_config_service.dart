import 'package:firebase_remote_config/firebase_remote_config.dart';
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig);

  Future<void> initialize() async {
    await _remoteConfig.setDefaults(const {
      'show_offers_section': false,
    });
    await _remoteConfig.fetchAndActivate();
  }

  bool get showOffersSection => _remoteConfig.getBool('show_offers_section');
}