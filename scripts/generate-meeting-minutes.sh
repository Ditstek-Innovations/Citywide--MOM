#!/bin/bash

# Meeting Minutes Generator Script
# This script automates the creation of new meeting minutes from the template

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATE_FILE="$PROJECT_ROOT/templates/meeting-minutes-template.md"
MEETINGS_DIR="$PROJECT_ROOT/meetings"

# Function to print colored messages
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

print_warning() {
    echo -e "${YELLOW}⚠ ${NC}$1"
}

print_error() {
    echo -e "${RED}✗ ${NC}$1"
}

# Function to display usage
usage() {
    cat << EOF
${BLUE}Meeting Minutes Generator${NC}

Usage: $0 [OPTIONS]

Options:
    -c, --client <name>        Client name (required)
    -d, --date <YYYY-MM-DD>    Meeting date (default: today)
    -t, --type <type>          Meeting type (default: StatusUpdate)
    -y, --year <YYYY>          Year directory (default: current year)
    -i, --interactive          Interactive mode (prompts for all inputs)
    -h, --help                 Display this help message

Meeting Types:
    - ProjectKickoff
    - StatusUpdate
    - QuarterlyReview
    - WeeklyCheckIn
    - PlanningSession
    - TechnicalReview
    - ExecutiveReview
    - Other

Examples:
    # Interactive mode (recommended for first use)
    $0 --interactive

    # Quick creation with all parameters
    $0 --client "AcmeCorp" --date "2024-12-10" --type "StatusUpdate"

    # Using short options
    $0 -c "TechStartup" -t "ProjectKickoff"

    # Create for specific year
    $0 -c "CityCouncil" -y 2025

EOF
}

# Function to validate date format
validate_date() {
    local date_string=$1
    if [[ ! $date_string =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        return 1
    fi
    # Additional validation - check if it's a valid date
    # Try both GNU date and BSD date formats for cross-platform compatibility
    if date -d "$date_string" &>/dev/null 2>&1; then
        return 0
    elif date -j -f "%Y-%m-%d" "$date_string" &>/dev/null 2>&1; then
        return 0
    else
        # Fallback: basic validation of month and day ranges
        local year=$(echo "$date_string" | cut -d'-' -f1)
        local month=$(echo "$date_string" | cut -d'-' -f2)
        local day=$(echo "$date_string" | cut -d'-' -f3)
        
        # Remove leading zeros for comparison
        month=$((10#$month))
        day=$((10#$day))
        
        if [ $month -lt 1 ] || [ $month -gt 12 ]; then
            return 1
        fi
        if [ $day -lt 1 ] || [ $day -gt 31 ]; then
            return 1
        fi
        return 0
    fi
}

# Function to sanitize filename
sanitize_filename() {
    local input=$1
    # Remove special characters, replace spaces with nothing or underscore
    echo "$input" | sed 's/[^a-zA-Z0-9-]//g'
}

# Function to create meeting minutes
create_meeting_minutes() {
    local client=$1
    local meeting_date=$2
    local meeting_type=$3
    local year=$4

    # Sanitize client name for filename
    local client_filename=$(sanitize_filename "$client")
    local type_filename=$(sanitize_filename "$meeting_type")

    # Create year directory if it doesn't exist
    local year_dir="$MEETINGS_DIR/$year"
    if [ ! -d "$year_dir" ]; then
        mkdir -p "$year_dir"
        print_info "Created directory: $year_dir"
    fi

    # Generate filename
    local filename="${meeting_date}_${client_filename}_${type_filename}.md"
    local filepath="$year_dir/$filename"

    # Check if file already exists
    if [ -f "$filepath" ]; then
        print_warning "File already exists: $filepath"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Cancelled. No file created."
            exit 0
        fi
    fi

    # Copy template
    cp "$TEMPLATE_FILE" "$filepath"

    # Replace placeholders in the file
    local current_datetime=$(date "+%Y-%m-%d")
    
    # Use sed to replace placeholders (cross-platform compatible)
    sed -i.bak "s/\[Client Name\]/$client/g" "$filepath"
    sed -i.bak "s/\[Date: YYYY-MM-DD\]/$meeting_date/g" "$filepath"
    sed -i.bak "s/YYYY-MM-DD/$meeting_date/g" "$filepath"
    sed -i.bak "s/\[Regular Check-in \/ Project Kickoff \/ Status Update \/ Review \/ Other\]/$meeting_type/g" "$filepath"
    
    # Remove backup file
    rm -f "${filepath}.bak"

    print_success "Meeting minutes created successfully!"
    print_info "Location: $filepath"
    echo
    print_info "Next steps:"
    echo "  1. Open the file and fill in the meeting details"
    echo "  2. Update attendees, agenda items, decisions, and action items"
    echo "  3. Review and save the document"
    echo "  4. Commit to git: git add $filepath"
    echo "  5. Commit message: git commit -m 'Add meeting minutes: $client $meeting_date'"
    echo
    print_info "For guidance, see: docs/TEMPLATE_GUIDE.md"
}

# Main script logic
main() {
    # Default values
    CLIENT=""
    MEETING_DATE=$(date "+%Y-%m-%d")
    MEETING_TYPE="StatusUpdate"
    YEAR=$(date "+%Y")
    INTERACTIVE=false

    # Check if template exists
    if [ ! -f "$TEMPLATE_FILE" ]; then
        print_error "Template file not found: $TEMPLATE_FILE"
        print_info "Please ensure the template exists at: templates/meeting-minutes-template.md"
        exit 1
    fi

    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--client)
                CLIENT="$2"
                shift 2
                ;;
            -d|--date)
                MEETING_DATE="$2"
                shift 2
                ;;
            -t|--type)
                MEETING_TYPE="$2"
                shift 2
                ;;
            -y|--year)
                YEAR="$2"
                shift 2
                ;;
            -i|--interactive)
                INTERACTIVE=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done

    # Interactive mode
    if [ "$INTERACTIVE" = true ]; then
        echo -e "${BLUE}=== Interactive Meeting Minutes Generator ===${NC}"
        echo

        # Get client name
        read -p "Client name: " CLIENT
        while [ -z "$CLIENT" ]; do
            print_warning "Client name is required"
            read -p "Client name: " CLIENT
        done

        # Get meeting date
        read -p "Meeting date (YYYY-MM-DD) [default: $MEETING_DATE]: " date_input
        if [ -n "$date_input" ]; then
            MEETING_DATE="$date_input"
        fi

        # Get meeting type
        echo
        echo "Meeting types:"
        echo "  1. ProjectKickoff"
        echo "  2. StatusUpdate (default)"
        echo "  3. QuarterlyReview"
        echo "  4. WeeklyCheckIn"
        echo "  5. PlanningSession"
        echo "  6. TechnicalReview"
        echo "  7. ExecutiveReview"
        echo "  8. Other"
        read -p "Select meeting type [1-8, default: 2]: " type_choice

        case $type_choice in
            1) MEETING_TYPE="ProjectKickoff" ;;
            2|"") MEETING_TYPE="StatusUpdate" ;;
            3) MEETING_TYPE="QuarterlyReview" ;;
            4) MEETING_TYPE="WeeklyCheckIn" ;;
            5) MEETING_TYPE="PlanningSession" ;;
            6) MEETING_TYPE="TechnicalReview" ;;
            7) MEETING_TYPE="ExecutiveReview" ;;
            8)
                read -p "Enter custom meeting type: " custom_type
                MEETING_TYPE="${custom_type:-Other}"
                ;;
            *)
                print_warning "Invalid choice. Using default: StatusUpdate"
                MEETING_TYPE="StatusUpdate"
                ;;
        esac

        # Get year
        read -p "Year directory [default: $YEAR]: " year_input
        if [ -n "$year_input" ]; then
            YEAR="$year_input"
        fi

        echo
    fi

    # Validate required parameters
    if [ -z "$CLIENT" ]; then
        print_error "Client name is required"
        echo
        usage
        exit 1
    fi

    # Validate date format
    if ! validate_date "$MEETING_DATE"; then
        print_error "Invalid date format: $MEETING_DATE"
        print_info "Please use YYYY-MM-DD format (e.g., 2024-12-10)"
        exit 1
    fi

    # Confirm creation
    echo -e "${BLUE}=== Meeting Minutes Details ===${NC}"
    echo "Client:        $CLIENT"
    echo "Date:          $MEETING_DATE"
    echo "Type:          $MEETING_TYPE"
    echo "Year:          $YEAR"
    echo

    if [ "$INTERACTIVE" = true ]; then
        read -p "Create meeting minutes with these details? (Y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            print_info "Cancelled."
            exit 0
        fi
    fi

    # Create the meeting minutes
    create_meeting_minutes "$CLIENT" "$MEETING_DATE" "$MEETING_TYPE" "$YEAR"
}

# Run main function
main "$@"
