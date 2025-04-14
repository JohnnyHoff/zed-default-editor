# 🧠 Zed Default Editor Setup Script

This is a simple script to make [Zed](https://zed.dev)—or its Preview/Nightly builds—your **default editor for all text/code files on macOS**.

It:

- Installs [`duti`](https://github.com/moretension/duti) if needed
- Asks if you want to use **Zed**, **Zed Preview**, or **Zed Nightly**
- Associates a broad set of file types (including `.mdx`, `.ts`, `.py`, `.json`, etc.) with Zed
- Automatically sets them via `duti` in one shot

---

## 🚀 Quickstart

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
