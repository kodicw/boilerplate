# Style Guide

Python and Nix conventions for this project.

## Python

### Formatting
- **Formatter:** `ruff format` — configured in `pyproject.toml`.
- **Line length:** 100 characters.
- **Quote style:** Double quotes.

### Linting
- **Linter:** `ruff check .`
- Fix auto-fixable issues: `ruff check --fix .`

### Type Hints
- Use type hints for all function signatures.
- Use `from __future__ import annotations` for modern syntax.

```python
from __future__ import annotations

def process_items(items: list[str], *, verbose: bool = False) -> dict[str, int]:
    ...
```

### Testing
- **Framework:** `pytest`
- Tests live in `tests/` directory.
- Name test files `test_<module>.py`, functions `test_<behavior>`.

```bash
pytest                    # Run all tests
pytest -x                 # Stop on first failure
pytest -k "test_parse"    # Run matching tests
```

### Imports
Group by: standard library → third-party → local.

```python
import os
from pathlib import Path

import httpx
from pydantic import BaseModel

from myproject.config import Settings
```

### Naming
- Classes: `PascalCase`
- Functions, variables, modules: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Private: prefix with `_`

### Package Management
- **Tool:** `uv` for dependency management.
- `uv sync` to install dependencies.
- `uv add <package>` to add new dependencies.

## Nix

- **Formatter:** `nixfmt` (RFC-style). Never `nixpkgs-fmt`.
- **Linter:** `statix check .`
- **No hardcoded secrets.** Ever.

## Git

- Follow [Conventional Commits](https://www.conventionalcommits.org/).
- Imperative mood, no capital first letter, no trailing period, max 72 chars.

```
feat(api): add user endpoint
fix(parser): handle unicode input
chore(deps): bump httpx to 0.28
```
