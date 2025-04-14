# 🧠 Zed Default Editor Setup Script

This script makes [Zed](https://zed.dev)—or its Preview/Nightly builds—your **default editor for all text/code files on macOS**.

It:

- Installs [`duti`](https://github.com/moretension/duti) if needed
- Lets you choose between **Zed**, **Zed Preview**, or **Zed Nightly**
- Associates a broad set of file types (including `.mdx`, `.ts`, `.py`, `.json`, etc.) with Zed

---

## 🧪 Option 1: Copy-Paste (No Download)

Just paste this entire script into your terminal:

```bash
#!/bin/bash

if ! command -v duti &>/dev/null; then
  echo "📦 Installing duti with Homebrew..."
  if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew is not installed. Please install it from https://brew.sh/"
    exit 1
  fi
  brew install duti
fi

echo "Which version of Zed do you want to use?"
select choice in "Zed" "Zed Preview" "Zed Nightly" "Cancel"; do
  case $choice in
    "Zed") ZED_APP_NAME="Zed"; break ;;
    "Zed Preview") ZED_APP_NAME="Zed Preview"; break ;;
    "Zed Nightly") ZED_APP_NAME="Zed Nightly"; break ;;
    "Cancel") echo "🚫 Cancelled."; exit 0 ;;
    *) echo "Invalid option." ;;
  esac
done

ZED_BUNDLE_ID=$(osascript -e "id of app \\"$ZED_APP_NAME\\"") || {
  echo "❌ Could not find $ZED_APP_NAME in /Applications."; exit 1;
}
echo "✅ Using $ZED_APP_NAME ($ZED_BUNDLE_ID)"

UTIS=(
  "public.plain-text" "public.utf8-plain-text" "public.unix-executable"
  "public.script" "public.source-code" "public.json" "public.xml"
  "public.yaml" "public.shell-script" "public.python-script"
  "public.ruby-script" "public.perl-script" "public.php-script"
  "public.c-source" "public.objective-c-source" "public.c-plus-plus-source"
  "public.java-source" "public.swift-source" "public.rust-source"
  "org.gnu.assembly" "org.gnu.emacs.lisp" "com.sun.java-properties"
  "org.yaml.yaml" "com.apple.property-list" "public.javascript"
  "com.netscape.javascript-source" "public.typescript-script" "public.css"
  "public.html" "public.markdown" "net.daringfireball.markdown"
  "public.ini-settings" "com.microsoft.windows-ini" "public.makefile"
  "org.gnu.gnu-make" "public.log" "dyn.ah62d4rv4ge8044pq"
)

for uti in "${UTIS[@]}"; do
  echo "Setting $uti to open with $ZED_APP_NAME..."
  duti -s "$ZED_BUNDLE_ID" "$uti" all
done

echo "Setting .mdx extension to open with $ZED_APP_NAME..."
duti -s "$ZED_BUNDLE_ID" mdx all

echo "🎉 Done! $ZED_APP_NAME is now your default editor for text and code files."
```

---

## 🧰 Option 2: GitHub Clone Method

### 1. Clone the repo

```bash
git clone https://github.com/YOUR-USERNAME/zed-default-editor.git
cd zed-default-editor
```

### 2. Run the script

```bash
chmod +x set_zed_defaults.sh
./set_zed_defaults.sh
```

---

## 📦 Requirements

- macOS
- [Homebrew](https://brew.sh/) installed (used to install `duti`)

---

## 🧠 What’s Covered?

This script sets Zed as the default app for:

- Plain text files (`.txt`, `.md`, `.log`, `.ini`)
- Code files (`.js`, `.ts`, `.py`, `.rs`, `.html`, `.css`, etc.)
- Configs (`.json`, `.xml`, `.yml`, `.plist`)
- Markdown & MDX files (`.md`, `.mdx`)
- Scripts (`.sh`, `.bash`, `.php`, `.rb`, etc.)

---

## 🛑 Troubleshooting

If Zed isn’t detected:
- Make sure it's installed in `/Applications`
- You can re-run the script any time

---

## 🧑‍💻 Contributing

Feel free to PR more file types, support for other editors, or general improvements!

---

## 📝 License

MIT
