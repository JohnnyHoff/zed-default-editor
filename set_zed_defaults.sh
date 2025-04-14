#!/bin/bash

# Check for duti, install if missing
if ! command -v duti &>/dev/null; then
  echo "📦 Installing duti with Homebrew..."
  if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew is not installed. Please install Homebrew first: https://brew.sh/"
    exit 1
  fi
  brew install duti
fi

# Prompt for Zed variant
echo "Which version of Zed do you want to use?"
select choice in "Zed" "Zed Preview" "Zed Nightly" "Cancel"; do
  case $choice in
    "Zed")
      ZED_APP_NAME="Zed"
      break
      ;;
    "Zed Preview")
      ZED_APP_NAME="Zed Preview"
      break
      ;;
    "Zed Nightly")
      ZED_APP_NAME="Zed Nightly"
      break
      ;;
    "Cancel")
      echo "🚫 Cancelled."
      exit 0
      ;;
    *)
      echo "Invalid option."
      ;;
  esac
done

# Get bundle ID
ZED_BUNDLE_ID=$(osascript -e "id of app \"$ZED_APP_NAME\"") || {
  echo "❌ Could not find $ZED_APP_NAME. Make sure it's installed in /Applications."
  exit 1
}
echo "✅ Using $ZED_APP_NAME with bundle ID: $ZED_BUNDLE_ID"

# List of UTIs for text/code-related file types
UTIS=(
  "public.plain-text"
  "public.utf8-plain-text"
  "public.unix-executable"
  "public.script"
  "public.source-code"
  "public.json"
  "public.xml"
  "public.yaml"
  "public.shell-script"
  "public.python-script"
  "public.ruby-script"
  "public.perl-script"
  "public.php-script"
  "public.c-source"
  "public.objective-c-source"
  "public.c-plus-plus-source"
  "public.java-source"
  "public.swift-source"
  "public.rust-source"
  "org.gnu.assembly"
  "org.gnu.emacs.lisp"
  "com.sun.java-properties"
  "org.yaml.yaml"
  "com.apple.property-list"
  "public.javascript"
  "com.netscape.javascript-source"
  "public.typescript-script"
  "public.css"
  "public.html"
  "public.markdown"
  "net.daringfireball.markdown"
  "public.ini-settings"
  "com.microsoft.windows-ini"
  "public.makefile"
  "org.gnu.gnu-make"
  "public.log"
  "dyn.ah62d4rv4ge8044pq"  # mdx (Dynamic UTI for Markdown Extended)
)

# Apply defaults using duti
for uti in "${UTIS[@]}"; do
  echo "🔧 Setting $uti to open with $ZED_APP_NAME..."
  duti -s "$ZED_BUNDLE_ID" "$uti" all
done

# Handle file extension for .mdx explicitly
echo "🔧 Setting .mdx extension to open with $ZED_APP_NAME..."
duti -s "$ZED_BUNDLE_ID" mdx all

echo "🎉 Done! $ZED_APP_NAME is now the default editor for text/code files."
