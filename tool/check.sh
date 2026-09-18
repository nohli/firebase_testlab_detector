#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <android-device-id>" >&2
  exit 64
fi

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
android_device_id="$1"

cd "$repository_root"
fvm flutter pub get --no-example
fvm dart format --page-width 120 --output=none --set-exit-if-changed lib test example/lib example/test example/integration_test
fvm dart analyze
fvm flutter test --no-pub test

cd "$repository_root/example"
fvm flutter pub get --enforce-lockfile --no-example
fvm dart analyze
fvm flutter test --no-pub test
fvm flutter test --no-pub integration_test -d "$android_device_id"

"$repository_root/android/gradlew" -p "$repository_root/example/android" :firebase_testlab_detector:testDebugUnitTest --no-daemon

cd "$repository_root/example"
fvm flutter build apk --debug --no-pub
