#!/bin/bash
set -e

FLUTTER_VERSION="3.24.5"
FLUTTER_DIR="$HOME/flutter"

echo "==> Downloading Flutter SDK ${FLUTTER_VERSION}..."
curl -fsSL \
  "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
  -o /tmp/flutter.tar.xz

echo "==> Extracting Flutter..."
mkdir -p "$FLUTTER_DIR"
tar xf /tmp/flutter.tar.xz -C "$HOME" 

export PATH="$PATH:$FLUTTER_DIR/bin"

echo "==> Disabling analytics to prevent interactive prompts..."
flutter config --no-analytics --suppress-analytics 2>/dev/null || true

echo "==> Flutter version:"
flutter --version --suppress-analytics

echo "==> Enabling web support..."
flutter config --enable-web

echo "==> Getting dependencies..."
flutter pub get

echo "==> Building Flutter web..."
flutter build web --release --web-renderer canvaskit

echo "==> Build complete! Output is in build/web"
