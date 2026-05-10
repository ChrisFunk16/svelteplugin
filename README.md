# Notepad++ Svelte Support 🧩

Syntax highlighting + autocomplete for **Svelte 5** files (`.svelte`) in Notepad++.

> ⚠️ This is a **User Defined Language (UDL)** — it ships as XML, not as a binary plugin. No compilation needed, works with stock Notepad++.

## ✨ Features

- 🎨 Syntax highlighting for Svelte markup, `<script>`, `<style>`
- 🪄 Svelte 5 **runes** highlighted (`$state`, `$derived`, `$effect`, `$props`, …)
- 🔁 **Block syntax** highlighted and folded (`{#if}` / `{:else}` / `{/if}`, `{#each}`, `{#await}`, `{#snippet}`, `{#key}`)
- 🏷️ Special tags `{@render}`, `{@html}`, `{@const}`, `{@debug}`, `{@attach}`
- 🎯 Directives: `bind:`, `on:`, `use:`, `transition:`, `class:`, `style:`
- 💡 Autocomplete for Svelte runes & block syntax
- 🌗 Two themes: **Dark** (VSCode-like) and **Light**

## 📦 Installation

### Easy way (Windows PowerShell)

```powershell
git clone https://github.com/<you>/notepad-svelte-support
cd notepad-svelte-support
.\scripts\install.ps1                # Dark theme (default)
.\scripts\install.ps1 -Theme Light   # Light theme
```

### Manual way

1. **UDL (syntax highlighting):**
   - Open Notepad++ → `Language` → `User Defined Language` → `Define your language…`
   - Click **Import…** and select `udl/Svelte.xml` (or `Svelte-Light.xml`)
   - Restart Notepad++

2. **Autocomplete:**
   - Copy `autocomplete/Svelte.xml` to:
     - `%ProgramFiles%\Notepad++\autoCompletion\Svelte.xml`
   - Enable: `Settings` → `Preferences` → `Auto-Completion` → ✓ **Enable auto-completion on each input**

3. Open a `.svelte` file — language should be auto-detected.

## 🧪 Test it

The `samples/` folder contains real Svelte 5 components:
- [`Counter.svelte`](samples/Counter.svelte) — runes, blocks, await, styles
- [`TodoList.svelte`](samples/TodoList.svelte) — bindings, each blocks, events

## 🗑️ Uninstall

```powershell
.\scripts\uninstall.ps1
```

## 🛠️ Development

```bash
# Validate XML files
./scripts/validate.sh
```

## 🗺️ Roadmap

This project starts as a UDL. If real Svelte support needs more (like multi-language lexing of HTML+CSS+JS within one file, or context-aware autocomplete), Phase 2 will be a real C++ Notepad++ plugin. See [`docs/ROADMAP.md`](docs/ROADMAP.md).

## 🤝 Contributing

Found a missing keyword? A wrong color? PRs welcome! Edit the `udl/*.xml`, run `./scripts/validate.sh`, open PR.

## 📜 License

MIT — see [LICENSE](LICENSE).

## 🙏 Credits

Inspired by other community Notepad++ language packs (e.g. the official [userDefinedLanguages](https://github.com/notepad-plus-plus/userDefinedLanguages) repo). Color palette inspired by VSCode Dark+ / Light+.
