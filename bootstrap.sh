#!/usr/bin/env bash
set -euo pipefail

# helios. installer
VERSION="latest"
BOLD="\033[1m"
CYAN="\033[36m"
GREEN="\033[32m"
RED="\033[31m"
DIM="\033[2m"
RESET="\033[0m"

echo ""
echo -e "${CYAN}${BOLD}  helios.${RESET}"
echo -e "${DIM}  AI Operating Layer${RESET}"
echo ""

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Darwin)  PLATFORM="macos" ;;
  Linux)   PLATFORM="linux" ;;
  MINGW*|MSYS*|CYGWIN*)
    echo -e "${RED}Error: Use install.ps1 for Windows.${RESET}"
    echo "  irm https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/install.ps1 | iex"
    exit 1 ;;
  *) echo -e "${RED}Error: Unsupported OS: $OS${RESET}"; exit 1 ;;
esac

case "$ARCH" in
  x86_64|amd64) ARCH="x64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) echo -e "${RED}Error: Unsupported architecture: $ARCH${RESET}"; exit 1 ;;
esac

echo -e "  Platform: ${BOLD}${PLATFORM}-${ARCH}${RESET}"

check_cmd() {
  if ! command -v "$1" &>/dev/null; then
    echo -e "${RED}Error: $1 is required but not installed.${RESET}"
    echo "  $2"
    exit 1
  fi
}

check_cmd "node" "Install Node.js 18+: https://nodejs.org"
check_cmd "npm"  "npm should come with Node.js"

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  echo -e "${RED}Error: Node.js 18+ required (found v${NODE_VERSION}).${RESET}"
  exit 1
fi
echo -e "  Node.js:  ${BOLD}$(node -v)${RESET}"

echo ""
echo -e "  ${DIM}Installing...${RESET}"
npm install -g @familiar/pi 2>&1 | tail -1

echo ""
echo -e "  ${GREEN}${BOLD}✓ Installed${RESET}"
echo ""
echo -e "  ${DIM}Get started:${RESET}"
echo -e "  ${CYAN}helios config set ANTHROPIC_API_KEY sk-...${RESET}"
echo -e "  ${CYAN}helios \"your first task\"${RESET}"
echo ""
