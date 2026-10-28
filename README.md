# template-zsh-function

Template repository for creating autoloadable Zsh function command extensions deployed via `sstix-tools` for **APT**, **RPM**, and **Nix** with **Zsh autocompletion**.

Use this template to break large functions out of your `.zshrc` into standalone, package-managed command extensions.

## Repository Structure
```
├── .github/workflows/
│   ├── release.yaml               # Automated packaging and release pipeline
│   └── test.yaml                  # Zsh syntax & execution test workflow
├── functions/
│   └── template-zsh-function      # Autoloadable Zsh function definition
├── completion/
│   └── _template-zsh-function     # Zsh completion definition
├── packaging/
│   ├── debian/                    # Debian package metadata (installs to /usr/share/zsh/functions)
│   └── rpm/                       # RPM spec file (installs to /usr/share/zsh/functions)
├── flake.nix                      # Nix package definition
├── flake.lock                     # Nix lockfile
├── LICENSE
└── README.md
```

## How Autoloading Works
When installed via `apt`, `dnf`, or `nix profile`, the function file is placed in your system or user `fpath`.

Ensure your `~/.zshrc` has user and system paths configured:
```zsh
# User-installed executables
export PATH="$HOME/.local/bin:$PATH"

# User-installed zsh functions and completions
fpath=(
    "$HOME/.local/share/zsh/functions"
    "$HOME/.local/share/zsh/site-functions"
    $fpath
)

autoload -Uz compinit
compinit
```

### Loading in Shell
You can autoload the function explicitly or automatically:
```zsh
# Autoload this specific function
autoload -Uz template-zsh-function

# Call the function directly
template-zsh-function status
```

To automatically autoload all functions installed in your functions directory, add this to `~/.zshrc`:
```zsh
for f in "$HOME/.local/share/zsh/functions"/*(N:t) /usr/share/zsh/functions/*(N:t); do
    autoload -Uz "$f"
done
```

## How to Use This Template
1. Create a new repository in GitHub from this template under the `sstix-tools` organization.
2. Rename occurrences of `template-zsh-function` to your function name:
   - `functions/template-zsh-function` -> `functions/<your-function>`
   - `completion/_template-zsh-function` -> `completion/_<your-function>`
   - `packaging/rpm/template-zsh-function.spec` -> `packaging/rpm/<your-function>.spec`
   - In `flake.nix`: update `pname = "<your-function>"` and description
   - In `.github/workflows/release.yaml`: update `pkg_name="<your-function>"`
   - In `packaging/debian/control`: update `Package:` and `Description:`
3. Implement your Zsh function logic in `functions/<your-function>`.
4. Commit your changes and tag a release:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
5. GitHub Actions will package Debian (`.deb`), RPM (`.rpm`), and Nix assets and dispatch a trigger to `sstix-tools/registry`.
