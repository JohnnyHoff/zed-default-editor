#!/bin/bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "❌ This script only supports macOS."
  exit 1
fi

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
  "public.text"
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
  "com.apple.markdown"
  "com.apple.x-markdown"
  "net.daringfireball.markdown"
  "public.ini-settings"
  "com.microsoft.windows-ini"
  "public.makefile"
  "org.gnu.gnu-make"
  "public.log"
  "dyn.ah62d4rv4ge8044pq"  # mdx (Dynamic UTI for Markdown Extended)
)

# File extensions for common dev files (duti accepts extension names without the dot)
EXTENSIONS=(
  "txt"
  "md"
  "markdown"
  "mdx"
  "log"
  "json"
  "jsonc"
  "yaml"
  "yml"
  "toml"
  "ini"
  "cfg"
  "conf"
  "env"
  "xml"
  "plist"
  "js"
  "jsx"
  "mjs"
  "cjs"
  "ts"
  "tsx"
  "css"
  "scss"
  "sass"
  "less"
  "html"
  "htm"
  "sh"
  "bash"
  "zsh"
  "fish"
  "py"
  "pyi"
  "rb"
  "erb"
  "php"
  "phtml"
  "go"
  "rs"
  "c"
  "h"
  "cpp"
  "hpp"
  "cc"
  "cxx"
  "m"
  "mm"
  "swift"
  "java"
  "kt"
  "kts"
  "scala"
  "sc"
  "cs"
  "fs"
  "fsx"
  "vb"
  "sql"
  "graphql"
  "gql"
  "gradle"
  "groovy"
  "lua"
  "r"
  "hs"
  "clj"
  "cljs"
  "cljc"
  "edn"
  "ex"
  "exs"
  "erl"
  "hrl"
  "dart"
  "asm"
  "s"
  "make"
  "mk"
)

# Apply defaults using duti
apply_duti() {
  local target=$1
  if ! duti -s "$ZED_BUNDLE_ID" "$target" all; then
    echo "⚠️  Skipping $target (not a valid UTI/extension on this system)."
  fi
}

for uti in "${UTIS[@]}"; do
  echo "🔧 Setting $uti to open with $ZED_APP_NAME..."
  apply_duti "$uti"
done

for ext in "${EXTENSIONS[@]}"; do
  echo "🔧 Setting .$ext to open with $ZED_APP_NAME..."
  apply_duti "$ext"
done

echo "🎉 Done! $ZED_APP_NAME is now the default editor for text/code files."
