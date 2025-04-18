# pmp_english

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Latest cut

## fastlane android release env:dev c:1 n:0.0.1
## fastlane android release env:prod c:1 n:1.0.0

## ShoreBird
# shorebird init
# shorebird release android --flavor prod --artifact apk --dart-define=flavor=prod
# shorebird patch android --flavor prod --release-version=1.0.0+1 --dart-define=flavor=prod

# flutterfire configure --project=pmp-english-prod -a com.pmpenglish.mobile --platforms android
# service_credentials_file: "D:\\PMP_Projects\\service-keys\\#{env}-service-key.json",