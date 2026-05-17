#!/usr/bin/env bash
# Creates symlinks from local_sqlgenerator codemods into Moodle core lib dirs.
# Must be run as the file owner (marcus) or root, not as www-data.
# Usage: bash /path/to/moodle/local/sqlgenerator/cli/create_symlinks.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEMODS="$(dirname "$SCRIPT_DIR")/codemods"
DIRROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

declare -A LINKS=(
    ["$CODEMODS/xmldb_field.php"]="$DIRROOT/lib/xmldb/xmldb_field.php"
    ["$CODEMODS/xmldb_structure.php"]="$DIRROOT/lib/xmldb/xmldb_structure.php"
    ["$CODEMODS/sql_generator.php"]="$DIRROOT/lib/ddl/sql_generator.php"
    ["$CODEMODS/mysql_sql_generator.php"]="$DIRROOT/lib/ddl/mysql_sql_generator.php"
)

ERRORS=0

for target in "${!LINKS[@]}"; do
    link="${LINKS[$target]}"

    if [ ! -f "$target" ]; then
        echo "ERROR: source not found: $target"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    if [ -L "$link" ]; then
        rm "$link"
    elif [ -f "$link" ]; then
        mv "$link" "${link}.original"
        echo "Backed up: ${link}.original"
    fi

    if ln -s "$target" "$link"; then
        echo "Linked: $link -> $target"
    else
        echo "ERROR: symlink failed: $link"
        ERRORS=$((ERRORS + 1))
    fi
done

if [ "$ERRORS" -gt 0 ]; then
    echo "Completed with $ERRORS error(s)."
    exit 1
fi

echo "All symlinks created successfully."
