#!/bin/bash

# Meeting Index Generator Script
# This script generates an index of all meeting minutes for easy navigation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
MEETINGS_DIR="$PROJECT_ROOT/meetings"
INDEX_FILE="$MEETINGS_DIR/INDEX.md"

# Function to print colored messages
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

print_error() {
    echo -e "${RED}✗ ${NC}$1"
}

# Function to extract meeting info from filename
parse_filename() {
    local filename=$1
    # Extract date using sed (POSIX-compatible)
    local date=$(echo "$filename" | sed -n 's/^\([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\).*/\1/p')
    # Remove date and extension
    local rest=$(echo "$filename" | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_//' | sed 's/\.md$//')
    # Extract client (everything before last underscore)
    local client=$(echo "$rest" | sed 's/_[^_]*$//')
    # Extract type (everything after last underscore)
    local type=$(echo "$rest" | sed 's/.*_//')
    
    echo "$date|$client|$type"
}

# Function to generate index
generate_index() {
    print_info "Generating meeting minutes index..."

    # Start writing the index file
    cat > "$INDEX_FILE" << 'EOF'
# Meeting Minutes Index

This index provides a comprehensive overview of all meeting minutes organized for easy navigation and reference.

**Last Updated**: AUTO_GENERATED_DATE

---

## Quick Navigation

- [By Year](#by-year)
- [By Client](#by-client)
- [By Meeting Type](#by-meeting-type)
- [Search Tips](#search-tips)

---

## Statistics

- **Total Meetings**: TOTAL_MEETINGS
- **Years Covered**: YEARS_LIST
- **Unique Clients**: UNIQUE_CLIENTS_COUNT

---

## By Year

EOF

    # Count total meetings
    local total_meetings=0
    local years_list=()
    local clients_list=()
    local temp_clients_file="/tmp/clients_temp_$$.txt"
    > "$temp_clients_file"

    # Process each year directory
    for year_dir in "$MEETINGS_DIR"/[0-9][0-9][0-9][0-9]; do
        if [ -d "$year_dir" ]; then
            local year=$(basename "$year_dir")
            years_list+=("$year")
            
            local year_meetings=$(find "$year_dir" -maxdepth 1 -name "*.md" -type f | wc -l)
            
            if [ $year_meetings -gt 0 ]; then
                echo "### $year ($year_meetings meetings)" >> "$INDEX_FILE"
                echo >> "$INDEX_FILE"
                echo "| Date | Client | Type | Document |" >> "$INDEX_FILE"
                echo "|------|--------|------|----------|" >> "$INDEX_FILE"
                
                # Find and sort all markdown files in this year
                while IFS= read -r filepath; do
                    local filename=$(basename "$filepath")
                    local info=$(parse_filename "$filename")
                    local date=$(echo "$info" | cut -d'|' -f1)
                    local client=$(echo "$info" | cut -d'|' -f2)
                    local type=$(echo "$info" | cut -d'|' -f3)
                    
                    # Add to clients list
                    echo "$client" >> "$temp_clients_file"
                    
                    # Create relative path
                    local rel_path="$year/$filename"
                    
                    echo "| $date | $client | $type | [$filename]($rel_path) |" >> "$INDEX_FILE"
                    
                    total_meetings=$((total_meetings + 1))
                done < <(find "$year_dir" -maxdepth 1 -name "*.md" -type f | sort -r)
                
                echo >> "$INDEX_FILE"
            fi
        fi
    done

    # Generate by client section
    echo "---" >> "$INDEX_FILE"
    echo >> "$INDEX_FILE"
    echo "## By Client" >> "$INDEX_FILE"
    echo >> "$INDEX_FILE"
    
    # Get unique sorted clients
    if [ -f "$temp_clients_file" ] && [ -s "$temp_clients_file" ]; then
        local unique_clients=$(sort "$temp_clients_file" | uniq)
        local unique_clients_count=$(echo "$unique_clients" | wc -l)
        
        for client in $unique_clients; do
            echo "### $client" >> "$INDEX_FILE"
            echo >> "$INDEX_FILE"
            echo "| Date | Type | Document |" >> "$INDEX_FILE"
            echo "|------|------|----------|" >> "$INDEX_FILE"
            
            # Find all meetings for this client
            for year_dir in "$MEETINGS_DIR"/[0-9][0-9][0-9][0-9]; do
                if [ -d "$year_dir" ]; then
                    local year=$(basename "$year_dir")
                    
                    while IFS= read -r filepath; do
                        local filename=$(basename "$filepath")
                        local info=$(parse_filename "$filename")
                        local file_client=$(echo "$info" | cut -d'|' -f2)
                        
                        if [ "$file_client" = "$client" ]; then
                            local date=$(echo "$info" | cut -d'|' -f1)
                            local type=$(echo "$info" | cut -d'|' -f3)
                            local rel_path="$year/$filename"
                            
                            echo "| $date | $type | [$filename]($rel_path) |" >> "$INDEX_FILE"
                        fi
                    done < <(find "$year_dir" -maxdepth 1 -name "*.md" -type f | sort -r)
                fi
            done
            
            echo >> "$INDEX_FILE"
        done
    else
        unique_clients_count=0
        echo "*No client meetings found yet.*" >> "$INDEX_FILE"
        echo >> "$INDEX_FILE"
    fi

    # Generate by meeting type section
    echo "---" >> "$INDEX_FILE"
    echo >> "$INDEX_FILE"
    echo "## By Meeting Type" >> "$INDEX_FILE"
    echo >> "$INDEX_FILE"
    
    # Collect all meeting types
    local temp_types_file="/tmp/types_temp_$$.txt"
    > "$temp_types_file"
    
    for year_dir in "$MEETINGS_DIR"/[0-9][0-9][0-9][0-9]; do
        if [ -d "$year_dir" ]; then
            while IFS= read -r filepath; do
                local filename=$(basename "$filepath")
                local info=$(parse_filename "$filename")
                local type=$(echo "$info" | cut -d'|' -f3)
                echo "$type" >> "$temp_types_file"
            done < <(find "$year_dir" -maxdepth 1 -name "*.md" -type f)
        fi
    done
    
    if [ -f "$temp_types_file" ] && [ -s "$temp_types_file" ]; then
        local unique_types=$(sort "$temp_types_file" | uniq)
        
        for type in $unique_types; do
            echo "### $type" >> "$INDEX_FILE"
            echo >> "$INDEX_FILE"
            echo "| Date | Client | Document |" >> "$INDEX_FILE"
            echo "|------|--------|----------|" >> "$INDEX_FILE"
            
            # Find all meetings of this type
            for year_dir in "$MEETINGS_DIR"/[0-9][0-9][0-9][0-9]; do
                if [ -d "$year_dir" ]; then
                    local year=$(basename "$year_dir")
                    
                    while IFS= read -r filepath; do
                        local filename=$(basename "$filepath")
                        local info=$(parse_filename "$filename")
                        local file_type=$(echo "$info" | cut -d'|' -f3)
                        
                        if [ "$file_type" = "$type" ]; then
                            local date=$(echo "$info" | cut -d'|' -f1)
                            local client=$(echo "$info" | cut -d'|' -f2)
                            local rel_path="$year/$filename"
                            
                            echo "| $date | $client | [$filename]($rel_path) |" >> "$INDEX_FILE"
                        fi
                    done < <(find "$year_dir" -maxdepth 1 -name "*.md" -type f | sort -r)
                fi
            done
            
            echo >> "$INDEX_FILE"
        done
    else
        echo "*No meetings found yet.*" >> "$INDEX_FILE"
        echo >> "$INDEX_FILE"
    fi

    # Add search tips section
    cat >> "$INDEX_FILE" << 'EOF'
---

## Search Tips

### Using Git to Search Meeting Minutes

1. **Search for specific text across all meetings**:
   ```bash
   git grep "search term" meetings/
   ```

2. **Search for text in a specific year**:
   ```bash
   git grep "search term" meetings/2024/
   ```

3. **Search for client name**:
   ```bash
   git grep -l "ClientName" meetings/
   ```

4. **View meeting history**:
   ```bash
   git log --all -- meetings/
   ```

### Using Command Line

1. **Find meetings by client**:
   ```bash
   find meetings/ -name "*ClientName*"
   ```

2. **Find meetings by date**:
   ```bash
   find meetings/ -name "2024-12-*"
   ```

3. **Search content in all meetings**:
   ```bash
   grep -r "search term" meetings/
   ```

### GitHub Search

When viewing this repository on GitHub, use the search bar:
- `path:meetings/ ClientName` - Find all meetings with a client
- `path:meetings/ "action item"` - Find all action items
- `path:meetings/2024/ decision` - Search within a specific year

---

## Maintenance

This index is automatically generated. To regenerate:

```bash
./scripts/generate-index.sh
```

Run this script whenever:
- New meeting minutes are added
- Meeting minutes are updated
- You want to refresh the statistics

---

**Generated by**: Meeting Index Generator Script  
**Location**: `scripts/generate-index.sh`
EOF

    # Update placeholders
    local years_string=$(IFS=', '; echo "${years_list[*]}")
    local current_date=$(date "+%Y-%m-%d %H:%M:%S")
    
    sed -i.bak "s/AUTO_GENERATED_DATE/$current_date/" "$INDEX_FILE"
    sed -i.bak "s/TOTAL_MEETINGS/$total_meetings/" "$INDEX_FILE"
    sed -i.bak "s/YEARS_LIST/$years_string/" "$INDEX_FILE"
    sed -i.bak "s/UNIQUE_CLIENTS_COUNT/$unique_clients_count/" "$INDEX_FILE"
    
    # Remove backup file
    rm -f "${INDEX_FILE}.bak"
    
    # Clean up temp files
    rm -f "$temp_clients_file" "$temp_types_file"

    print_success "Index generated successfully: $INDEX_FILE"
    print_info "Total meetings indexed: $total_meetings"
    print_info "Years covered: $years_string"
    print_info "Unique clients: $unique_clients_count"
}

# Main execution
main() {
    if [ ! -d "$MEETINGS_DIR" ]; then
        print_error "Meetings directory not found: $MEETINGS_DIR"
        exit 1
    fi

    generate_index
}

main "$@"
