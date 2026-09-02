#!/bin/bash
set -e

echo "==> Installing Flutter SDK..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable /opt/flutter
export PATH="$PATH:/opt/flutter/bin"

echo "==> Flutter version:"
flutter --version

echo "==> Enabling web support..."
flutter config --enable-web

echo "==> Getting dependencies..."
flutter pub get

echo "==> Building Flutter web..."
flutter build web --release --web-renderer canvaskit

echo "==> Build complete!"
