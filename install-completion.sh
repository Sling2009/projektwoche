#!/bin/bash

set -e

echo "🔧 Installiere erforderliche Pakete..."
sudo apt update
sudo apt install -y zsh curl bash-completion

ZSH_COMPLETION_DIR="${HOME}/.zsh/completions"
mkdir -p "$ZSH_COMPLETION_DIR"

ZSHRC="$HOME/.zshrc"

#############################################
# KIND COMPLETION
#############################################
if command -v kind &> /dev/null; then
  echo "⚙️  Generiere Zsh Completion für kind..."
  kind completion zsh > "$ZSH_COMPLETION_DIR/_kind"
else
  echo "⚠️  kind ist nicht installiert. Überspringe."
fi

#############################################
# KUBECTL COMPLETION
#############################################
if command -v kubectl &> /dev/null; then
  echo "⚙️  Generiere Zsh Completion für kubectl..."
  kubectl completion zsh > "$ZSH_COMPLETION_DIR/_kubectl"
else
  echo "⚠️  kubectl ist nicht installiert. Überspringe."
fi

#############################################
# DOCKER COMPLETION
#############################################
if command -v docker &> /dev/null; then
  echo "⚙️  Lade Zsh Completion für docker..."
  curl -sSL https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker \
    -o "$ZSH_COMPLETION_DIR/_docker"
else
  echo "⚠️  docker ist nicht installiert. Überspringe."
fi

#############################################
# ZSHRC EINBINDUNG
#############################################
if ! grep -q "fpath+=${ZSH_COMPLETION_DIR}" "$ZSHRC"; then
  echo "" >> "$ZSHRC"
  echo "# CLI Autocompletion für kind, kubectl und docker" >> "$ZSHRC"
  echo "fpath+=${ZSH_COMPLETION_DIR}" >> "$ZSHRC"
  echo "autoload -Uz compinit && compinit" >> "$ZSHRC"
fi

echo "✅ Installation abgeschlossen!"
echo "🔁 Starte ein neues Zsh-Terminal oder führe:"
echo "    source ~/.zshrc"
