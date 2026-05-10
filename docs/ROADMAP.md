# Roadmap

## ✅ Phase 1: UDL (User Defined Language) — DONE

- XML-based, no compilation needed
- Syntax highlighting for runes, blocks, directives
- Code folding for Svelte block syntax
- Autocomplete file with Svelte 5 runes
- Dark + Light themes
- PowerShell installer

**Limitations of UDL:**
- ❌ Cannot mix lexers (HTML + CSS + JS in same file are all colored by the same rules)
- ❌ Cannot context-detect (e.g. inside `<script>` it should behave like JS, inside `<style>` like CSS)
- ❌ Autocomplete is keyword-based, not context-aware

## 🚧 Phase 2: Real C++ Plugin (future)

When the UDL hits its limits, the next step is a proper Notepad++ plugin DLL.

### Approach

1. Start from official **Notepad++ plugin template** (C++)
   - https://github.com/npp-plugins/plugintemplate
2. Use **Scintilla API** for editor interaction (`SCI_*` calls)
3. Implement a custom lexer that:
   - Tracks state (in markup / `<script>` / `<style>`)
   - Delegates to existing Scintilla lexers (HTML / JavaScript / CSS) per region
4. Add features UDL can't do:
   - Context-aware autocomplete (props, components, etc.)
   - Snippets (`#if<TAB>` expands to full block)
   - Format on save (delegate to `prettier` via shell)
   - Go-to-definition (basic, file-local)

### Reference plugins (read their source)

| Plugin | Why look at it |
|---|---|
| [NppMarkdownPanel](https://github.com/mohabouje/NppMarkdownPanel) | Compact, modern C++ plugin |
| [NppExec](https://github.com/d0vgan/nppexec) | Complex plugin, shows IPC patterns |
| [JSTool](https://github.com/sunjw/jstoolnpp) | JS-specific helpers |
| [DSpellCheck](https://github.com/Predelnik/DSpellCheck) | Background workers + UI |

### Build pipeline

- Visual Studio 2022, C++17
- x64 + Win32 builds
- GitHub Actions CI: build on push, attach DLLs to releases
- Submit to [nppPluginList](https://github.com/notepad-plus-plus/nppPluginList) for inclusion in Plugin Admin

## 🔮 Phase 3: Niceties

- LSP integration (talk to `svelte-language-server` over stdio) → real IntelliSense
- Snippet library (componentize, `each` skeleton, `await` skeleton)
- Side panel: component tree, props inspector
