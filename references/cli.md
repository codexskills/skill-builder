# CLI Tool Stack Reference

## Common Stacks

### Stack A: Python + Click / Typer (Recommended)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Typer (built on Click) | Type hints → CLI args, auto help text |
| HTTP Client | httpx | Async, HTTP/2, connection pooling |
| Config | Pydantic Settings | Type-safe env/config loading |
| Testing | pytest + CliRunner | Built into Click for testing CLI |
| Packaging | pyproject.toml (PEP 621) | Modern Python packaging standard |
| Publishing | PyPI via twine / GitHub Release | Standard Python distribution |

### Stack B: Node.js + Commander / Ink (TypeScript)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Commander + Inquirer | Battle-tested CLI parsing, interactive prompts |
| HTTP Client | undici / node-fetch | Modern, fast HTTP |
| Config | env-cafe / dotenv | Environment variable loading |
| Output | Chalk + Ora + CliProgress | Colors, spinners, progress bars |
| Testing | Vitest | Fast, TypeScript-native |
| Publishing | npm | Standard JS distribution |

### Stack C: Go + Cobra (Single Binary)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Cobra + Viper | Industry standard (Docker, Hugo, Kubernetes use it) |
| HTTP Client | stdlib net/http | No dependencies needed |
| Config | Viper | YAML/TOML/JSON/env config |
| Output | Fatih/color + spinner | Terminal colors, spinners |
| Testing | stdlib testing + golden files | Snapshot testing for CLI output |
| Publishing | GitHub Releases | Single binary download |

## When to Choose Which

| Criteria | Stack A (Python) | Stack B (Node.js) | Stack C (Go) |
|----------|------------------|-------------------|--------------|
| Install | `pip install` | `npm install -g` | Download binary |
| Dependencies | Python runtime required | Node runtime required | None (static binary) |
| Startup time | 200-500ms | 100-300ms | 5-15ms |
| Binary size | N/A | N/A | 5-20MB |
| Best for | Data/ML tools | JS ecosystem tools | Ops/DevOps tools |

## CLI Design Patterns

### Argument Convention

```
# Subcommand pattern (preferred)
my-cli create resource --name "foo" --verbose

# Single command (simple tools)
my-cli --input file.txt --output result.json

# Interactive (no flags)
my-cli
> What do you want to do?
```

### Exit Codes
| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Invalid usage |
| 64 | Input error |
| 70 | Internal software error |

## Sample Configuration

### Typer (Python)
```python
import typer
from typing import Optional
from enum import Enum

app = typer.Typer()

class OutputFormat(str, Enum):
    json = "json"
    yaml = "yaml"
    table = "table"

@app.command()
def generate(
    name: str = typer.Argument(..., help="Resource name"),
    format: OutputFormat = typer.Option("json", help="Output format"),
    verbose: bool = typer.Option(False, "--verbose", "-v"),
):
    """Generate a resource with the given name."""
    typer.echo(f"Generating {name} in {format} format")

@app.callback()
def main():
    """My CLI tool — does awesome things."""
    pass

if __name__ == "__main__":
    app()
```

### Cobra (Go)
```go
package cmd

import (
    "fmt"
    "github.com/spf13/cobra"
)

var generateCmd = &cobra.Command{
    Use:   "generate [name]",
    Short: "Generate a resource",
    Long:  `Generate a resource with the given name and format.`,
    Args:  cobra.ExactArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        name := args[0]
        format, _ := cmd.Flags().GetString("format")
        fmt.Printf("Generating %s in %s format\n", name, format)
    },
}

func init() {
    generateCmd.Flags().StringP("format", "f", "json", "Output format")
    rootCmd.AddCommand(generateCmd)
}
```

## Deployment Quirks

### PyPI Publishing
- `pip install build && python -m build` to create distribution
- `twine upload dist/*` to publish
- Set up `~/.pypirc` with API token
- GitHub Actions: `pypa/gh-action-pypi-publish@release/v1`
- Consider `pipx` for end-user install over global pip

### npm Publishing
- `npm run build && npm publish`
- Set up npm token in GitHub secrets
- Consider `npx` for one-off usage
- Use `oclif` if CLI needs plugin system

### GitHub Releases (Go)
- Use `goreleaser` for automated releases
- Generate binaries for: linux/amd64, linux/arm64, darwin/amd64, darwin/arm64, windows/amd64
- Homebrew formula can be auto-published via `goreleaser`
- Docker image optional for container environments

## Example Folder Structure (Python + Typer)

```
cli-tool/
├── src/
│   └── my_cli/             # Package directory
│       ├── __init__.py
│       ├── __main__.py     # python -m entry point
│       ├── main.py         # Typer app definition
│       ├── commands/       # Subcommand modules
│       │   ├── __init__.py
│       │   ├── init.py
│       │   ├── generate.py
│       │   └── config.py
│       ├── services/       # Business logic
│       │   ├── __init__.py
│       │   └── api_client.py
│       ├── models/         # Data models
│       │   ├── __init__.py
│       │   └── config.py
│       └── utils/          # Helpers
│           ├── __init__.py
│           ├── formatting.py
│           └── terminal.py
├── tests/
│   ├── __init__.py
│   ├── test_commands.py
│   └── test_services.py
├── pyproject.toml           # PEP 621 packaging
├── README.md
└── .env.example
```

## Starting Quick

```bash
# Python Typer
pip install typer httpx pydantic-settings rich
typer my_cli/main.py --run

# Node.js Commander
mkdir my-cli && cd my-cli
npm init -y && npm install commander inquirer chalk ora
npx tsc --init

# Go Cobra
go install github.com/spf13/cobra-cli@latest
cobra-cli init my-cli
cobra-cli add generate
```

## Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | pytest / Vitest / go test | Business logic, argument parsing, config loading, output formatting |
| CLI integration | Click CliRunner / execa / cobra test framework | Subcommand execution, flag parsing, exit codes, error messages |
| Golden file | pytest-snapshot / Vitest snapshot / go-cmp | CLI output regression — compare stdout/stderr against known-good files |
| Integration | pytest + httpx / nock / httptest | API client calls, authentication flow, config file I/O |
| Install | test in Docker (clean OS) | Verify `pip install` / `npm install -g` / binary download works fresh |

## When NOT to Choose Each Stack

### Stack A (Python + Typer)
- **Avoid when**: Startup time is critical (200-500ms penalty)
- **Avoid when**: Distributing as single binary (PyInstaller/Nuitka work but add complexity)
- **Avoid when**: No Python runtime available on target machines

### Stack B (Node.js + Commander)
- **Avoid when**: Target users are not JS developers (they may not have Node installed)
- **Avoid when**: Startup time >100ms is unacceptable
- **Avoid when**: CLI must work offline without installing npm

### Stack C (Go + Cobra)
- **Avoid when**: Rapid prototyping is priority (Go compile times, verbose error handling)
- **Avoid when**: Python data/ML libraries are core to CLI functionality
- **Avoid when**: Team doesn't know Go (learning curve adds time)

## Scaling Limits

| Stack | Breaks At | Notes |
|-------|-----------|-------|
| Python CLI | ~500 lines of subcommands | Beyond this, consider plugin architecture or splitting into multiple CLIs |
| Node.js CLI | ~300 modules (memory pressure) | Node.js startup with many dependencies gets slow |
| Go CLI | Virtually unlimited | Single binary, fast startup regardless of size |

## Cost Profile

| Stack | Free Tier | Publishing Cost | Notes |
|-------|-----------|----------------|-------|
| Python + PyPI | Yes | $0 (PyPI) | Free hosting on PyPI; pip install anywhere |
| Node.js + npm | Yes | $0 (npm) | Free hosting on npm; npx for one-off |
| Go + GitHub Releases | Yes | $0 (GitHub) | Free binary hosting via GitHub Releases |
