#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <android-device-id>" >&2
  exit 64
fi

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
android_device_id="$1"

if [[ -z "${JAVA_HOME:-}" ]]; then
  flutter_configuration="$(flutter config --machine)"
  if [[ "$flutter_configuration" =~ \"jdk-dir\"[[:space:]]*:[[:space:]]*\"([^\"]+)\" ]]; then
    export JAVA_HOME="${BASH_REMATCH[1]}"
  fi
fi

cd "$repository_root"
flutter pub get --no-example
dart format --page-width 120 --output=none --set-exit-if-changed lib test example/lib example/test example/integration_test
dart analyze
flutter test --no-pub test

cd "$repository_root/example"
flutter pub get --enforce-lockfile --no-example
dart analyze
flutter test --no-pub test
flutter test --no-pub integration_test -d "$android_device_id"

"$repository_root/android/gradlew" -p "$repository_root/example/android" :firebase_testlab_detector:testDebugUnitTest --no-daemon

cd "$repository_root/example"
flutter build apk --debug --no-pub
