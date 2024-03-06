import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  // KEYS FOR STRIPE
  @EnviedField(varName: 'STRIPE_TEST_PUBLISHABLE_KEY', obfuscate: true)
  static final String stripeTestPublishableKey = _Env.stripeTestPublishableKey;

  @EnviedField(varName: 'STRIPE_TEST_SECRET_KEY', obfuscate: true)
  static final String stripeTestSecretKey = _Env.stripeTestSecretKey;

  @EnviedField(varName: 'STRIPE_LIVE_PUBLISHABLE_KEY', obfuscate: true)
  static final String stripeLivePublishableKey = _Env.stripeLivePublishableKey;

  @EnviedField(varName: 'STRIPE_LIVE_SECRET_KEY', obfuscate: true)
  static final String stripeLiveSecretKey = _Env.stripeLiveSecretKey;
}
