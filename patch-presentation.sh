#!/bin/bash

INPUT_FILE="presentation/index.html"
BACKUP_FILE="presentation/index.html.$(date +%Y%m%d-%H%M%S).bak"

# Create a backup with timestamp
cp "$INPUT_FILE" "$BACKUP_FILE"

# Replace domain references
sed -i '' 's|https://www.shadertoy.com|http://localhost:8888|g' "$INPUT_FILE"
sed -i '' 's|https://shadertoy.com|http://localhost:8888|g' "$INPUT_FILE"

echo "✅ Replaced 'https://shadertoy.com' with 'http://localhost:8888' in $INPUT_FILE"
echo "🗂 Original backup created at: $BACKUP_FILE"
