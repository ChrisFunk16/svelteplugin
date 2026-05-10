# Installation Guide

## Windows (PowerShell, recommended)

```powershell
# 1. Clone or download
git clone https://github.com/<you>/notepad-svelte-support
cd notepad-svelte-support

# 2. Run installer (closes Notepad++ if open)
.\scripts\install.ps1
# or for light theme:
.\scripts\install.ps1 -Theme Light

# 3. Open Notepad++ and a .svelte file
```

## Manual install

### Step 1: UDL (syntax highlighting)

1. Open Notepad++
2. Menu: `Language` → `User Defined Language` → `Define your language…`
3. Click **Import…**
4. Select `udl/Svelte.xml` (Dark theme) or `udl/Svelte-Light.xml`
5. Click **OK** and restart Notepad++

After restart, `.svelte` files should automatically use the **Svelte** language. To switch manually: `Language` → `Svelte`.

### Step 2: Autocomplete

1. Find your Notepad++ install folder, usually:
   - `C:\Program Files\Notepad++\autoCompletion\`
2. Copy `autocomplete/Svelte.xml` into that folder
3. Restart Notepad++
4. Enable autocomplete: `Settings` → `Preferences` → `Auto-Completion` → ✓ **Enable auto-completion on each input**
   - Recommended: ✓ Function and word completion
   - Recommended: Min character: 1 or 2

### Step 3: (Optional) Associate `.svelte` extension

Already done by the UDL — but if N++ doesn't pick it up:

1. `Settings` → `Style Configurator…`
2. Find **Svelte** in the list (under User Defined)
3. In **User ext.** field add: `svelte`

## Troubleshooting

**Language doesn't show up after import**
→ Notepad++ must be restarted. Close ALL Notepad++ windows.

**Colors look wrong**
→ Style Configurator might override. Check `Settings` → `Style Configurator…` → **Svelte** → make sure no global font/style overrides are forcing changes.

**Autocomplete doesn't trigger**
→ `Settings` → `Preferences` → `Auto-Completion` must be enabled. Min character should be 1.

**Syntax highlighting works in `<script>` but not in `<style>`**
→ This is a UDL limitation. UDL uses one lexer for the whole file. The Phase 2 C++ plugin will fix this — see [ROADMAP.md](ROADMAP.md).

## Linux/Mac users

Notepad++ is Windows-only. If you really need it:
- Run via Wine
- Or use an alternative editor (VS Code, Sublime, Helix) with their own Svelte plugins
