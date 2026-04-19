{ pkgs, templatesPath }:
''
#!/usr/bin/env bash
set -euo pipefail

TEMPLATES_DIR="${templatesPath}"

USAGE="create-project - Initialize new projects from templates

Usage:
  create-project <template> [project-name]

Templates:
  general      General-purpose, language-agnostic template
  rust         Rust binary project with Nix dev shell
  python       Python project with uv/Hatch configuration
  nixos-module NixOS module template

Examples:
  create-project general my-app  # Creates ./my-app/ from general template
  create-project rust my-rust    # Creates ./my-rust/ from rust template
  create-project python          # Creates ./python-project/ in current dir
  create-project nixos-module    # Creates ./nixos-module/ in current dir
"

# Parse arguments
if [[ $# -lt 1 ]]; then
  echo "Error: Missing template name." >&2
  echo >&2
  echo "$USAGE"
  exit 1
fi

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo "$USAGE"
  exit 0
fi

template_name="$1"
project_name=""

# Determine project directory
if [[ $# -lt 2 || -z "$2" ]]; then
  project_name="''${template_name}-project"
  echo "No project name provided. Creating in current directory as '$project_name'."
else
  project_name="$2"
fi

# Check if directory already exists
if [[ -d "$project_name" ]]; then
  echo "Error: Directory '$project_name' already exists." >&2
  exit 1
fi

# Get the template directory
template_dir="$TEMPLATES_DIR/$template_name"

if [[ ! -d "$template_dir" ]]; then
  echo "Error: Template directory '$template_dir' not found." >&2
  exit 1
fi

# Copy template files
echo "Creating project '$project_name' from template '$template_name'..."
cp -r "$template_dir" "$project_name"

# Replace placeholders in template files
replace_in_file() {
  local file="$1"
  local name="$2"
  local desc="$3"
  local content
  content=$(cat "$file")
  new_content=$(echo "$content" | sed "s/''${PROJECT_NAME}/$name/g; s/''${PROJECT_DESCRIPTION}/$desc/g")
  if [[ "$content" != "$new_content" ]]; then
    echo "$new_content" > "$file"
  fi
}

process_dir() {
  local dir="$1"
  local name="$2"
  local desc="$3"
  for entry in "$dir"/*; do
    if [[ -d "$entry" ]]; then
      process_dir "$entry" "$name" "$desc"
    elif [[ -f "$entry" ]]; then
      local ext="''${entry##*.}"
      case "$ext" in
        rs|toml|nix|md|txt|json|yaml|yml)
          replace_in_file "$entry" "$name" "$desc"
          ;;
      esac
    fi
  done
}

# Generate description from project name
project_description="$project_name project"
process_dir "$project_name" "$project_name" "$project_description"

# Success message
echo
echo "✓ Project created successfully!"
echo
echo "  Location: $project_name"
echo "  Template: $template_name"
echo
echo "Next steps:"
case "$template_name" in
  general)
    echo "  cd $project_name"
    echo "  nix develop"
    ;;
  rust)
    echo "  cd $project_name"
    echo "  nix develop"
    echo "  cargo run"
    ;;
  python)
    echo "  cd $project_name"
    echo "  uv sync"
    echo "  python -m $project_name"
    ;;
  nixos-module)
    echo "  cd $project_name"
    echo "  # Import in your NixOS configuration:"
    echo "  # imports = [ ./$project_name ]"
    ;;
esac
''
