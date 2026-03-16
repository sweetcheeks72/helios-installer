#!/usr/bin/env bash
# =============================================================================
# helios. — One-Command Bootstrap
# =============================================================================
# Usage: curl -fsSL https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/bootstrap.sh | bash
# =============================================================================

set -euo pipefail

# ─── Windows Detection ────────────────────────────────────────────────────────
case "$(uname -s 2>/dev/null || echo Unknown)" in
  MINGW*|MSYS*|CYGWIN*)
    echo ""
    echo "  Helios requires WSL (Windows Subsystem for Linux)."
    echo ""
    echo "  In PowerShell as Admin:"
    echo "    irm https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/install.ps1 | iex"
    echo ""
    exit 1 ;;
esac

# ─── Restore stdin from terminal (critical for curl|bash piping) ─────────────
if [[ ! -t 0 ]]; then
  if [[ -e /dev/tty ]]; then
    exec < /dev/tty
  else
    echo "ERROR: No terminal available. Run directly instead:" >&2
    echo "  bash <(curl -fsSL https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/bootstrap.sh)" >&2
    exit 1
  fi
fi

BOLD='\033[1m'; CYAN='\033[0;36m'; GREEN='\033[0;32m'
RED='\033[0;31m'; DIM='\033[2m'; RESET='\033[0m'

echo ""
echo -e "${CYAN}${BOLD}  helios.${RESET}"
echo -e "${DIM}  AI Operating Layer${RESET}"
echo ""

# ─── Prerequisites ────────────────────────────────────────────────────────────
fail=false

if command -v node &>/dev/null; then
  if node -e "process.exit(parseInt(process.version.slice(1)) < 18 ? 1 : 0)" 2>/dev/null; then
    echo -e "  ${GREEN}✓${RESET} Node.js $(node -v)"
  else
    echo -e "  ${RED}✗${RESET} Node.js 18+ required (found $(node -v))"
    fail=true
  fi
else
  echo -e "  ${RED}✗${RESET} Node.js not found — https://nodejs.org"
  fail=true
fi

command -v git &>/dev/null && echo -e "  ${GREEN}✓${RESET} git" || { echo -e "  ${RED}✗${RESET} git not found"; fail=true; }
command -v npm &>/dev/null && echo -e "  ${GREEN}✓${RESET} npm $(npm -v)" || { echo -e "  ${RED}✗${RESET} npm not found"; fail=true; }

if [ "$fail" = true ]; then
  echo ""
  echo -e "  ${RED}Missing prerequisites. Install them and try again.${RESET}"
  exit 1
fi

echo ""

# ─── Download and run full installer ─────────────────────────────────────────
INSTALL_URL="https://github.com/sweetcheeks72/helios-installer/releases/latest/download/install.sh"
INSTALL_SCRIPT=$(mktemp)

echo -e "  ${DIM}Downloading installer...${RESET}"
if curl -fsSL --max-time 30 -o "$INSTALL_SCRIPT" "$INSTALL_URL" 2>/dev/null && [ -s "$INSTALL_SCRIPT" ]; then
  echo -e "  ${GREEN}✓${RESET} Installer downloaded"
  echo ""
  exec bash "$INSTALL_SCRIPT" "$@"
else
  rm -f "$INSTALL_SCRIPT"
  echo -e "  ${RED}✗${RESET} Failed to download installer."
  echo ""
  echo -e "  ${DIM}Try downloading manually:${RESET}"
  echo -e "  ${CYAN}curl -fsSL $INSTALL_URL -o /tmp/helios-install.sh && bash /tmp/helios-install.sh${RESET}"
  exit 1
fi
