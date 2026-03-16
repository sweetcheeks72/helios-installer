# helios.

AI Operating Layer — terminal-native AI orchestration.

## Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/bootstrap.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/install.ps1 | iex
```

## Requirements

- Node.js 18+
- An API key from any supported LLM provider (Anthropic, OpenAI, Google, Amazon Bedrock)

## What gets installed

- Pi CLI (terminal-native AI coding agent)
- Helios agent layer (orchestration, agents, skills, extensions)
- Memgraph knowledge graph (Docker/OrbStack)
- MCP servers (memory, GitHub, Figma)
- Boot services (auto-start on login)

## Post-install

```bash
helios doctor    # Verify setup
helios           # Launch
```

## Update

```bash
helios update
```

## Links

- [Website](https://sweetcheeks72.github.io/helios-website/)
