#!/bin/bash
echo "Checking all local image references in Section 2..."
broken_images=()

# Find all markdown files and check local image references
find . -name "*.md" | while read md_file; do
    # Extract local image references (not URLs)
    grep -o '!\[[^]]*\]([^)]*\.\(svg\|png\|jpg\|jpeg\|gif\))' "$md_file" | while read img_ref; do
        # Extract the path from the reference
        img_path=$(echo "$img_ref" | sed 's/.*(\([^)]*\)).*/\1/')
        
        # Skip URLs (http/https)
        if [[ "$img_path" =~ ^https?:// ]]; then
            continue
        fi
        
        # Resolve relative path
        if [[ "$img_path" =~ ^\.\. ]]; then
            # Go up one directory from the markdown file
            base_dir=$(dirname "$md_file")
            full_path="$base_dir/$img_path"
        elif [[ "$img_path" =~ ^\. ]]; then
            # Same directory as markdown file
            base_dir=$(dirname "$md_file")
            full_path="$base_dir/$img_path"
        else
            # Absolute path from current directory
            full_path="$img_path"
        fi
        
        # Check if file exists
        if [ ! -f "$full_path" ]; then
            echo "BROKEN: $md_file -> $img_path (resolved to: $full_path)"
        fi
    done
done
