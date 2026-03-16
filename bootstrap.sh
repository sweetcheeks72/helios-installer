#!/usr/bin/env bash
set -euo pipefail

BOLD="\033[1m"; CYAN="\033[36m"; GREEN="\033[32m"
RED="\033[31m"; DIM="\033[2m"; RESET="\033[0m"

echo ""
echo -e "${CYAN}${BOLD}  helios.${RESET}"
echo -e "${DIM}  AI Operating Layer${RESET}"
echo ""

for cmd in node git curl; do
  if ! command -v "$cmd" &>/dev/null; then
    echo -e "${RED}Error: $cmd is required.${RESET}"
    exit 1
  fi
done

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  echo -e "${RED}Error: Node.js 18+ required (found v${NODE_VERSION}).${RESET}"
  exit 1
fi

echo -e "  ${DIM}Downloading installer...${RESET}"

INSTALL_SCRIPT=$(mktemp)
curl -fsSL "https://raw.githubusercontent.com/sweetcheeks72/helios-agent/main/install.sh" -o "$INSTALL_SCRIPT" 2>/dev/null

if [ ! -s "$INSTALL_SCRIPT" ]; then
  echo -e "${RED}Error: Failed to download installer.${RESET}"
  echo -e "${DIM}Ensure you have repository access.${RESET}"
  rm -f "$INSTALL_SCRIPT"
  exit 1
fi

exec bash "$INSTALL_SCRIPT" "$@"
