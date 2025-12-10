# Meeting Minutes Directory

This directory contains all meeting minutes organized by year. Each file follows a standardized template to ensure consistency and completeness.

## Directory Structure

```
meetings/
├── INDEX.md                    # Comprehensive index of all meetings (auto-generated)
├── README.md                   # This file
├── 2024/                       # Meetings from 2024
│   └── YYYY-MM-DD_Client_Type.md
├── 2025/                       # Meetings from 2025
│   └── YYYY-MM-DD_Client_Type.md
└── [future years]/
```

## Quick Start

### Creating New Meeting Minutes

**Option 1: Using the automation script (Recommended)**
```bash
# Interactive mode - guided prompts
./scripts/generate-meeting-minutes.sh --interactive

# Quick creation with parameters
./scripts/generate-meeting-minutes.sh --client "ClientName" --date "2024-12-10" --type "StatusUpdate"

# Short form
./scripts/generate-meeting-minutes.sh -c "ClientName" -t "ProjectKickoff"
```

**Option 2: Manual creation**
1. Copy the template from `templates/meeting-minutes-template.md`
2. Rename following the naming convention: `YYYY-MM-DD_ClientName_MeetingType.md`
3. Save in the appropriate year directory
4. Fill in all required sections

### Updating the Index

After adding or modifying meeting minutes, regenerate the index:

```bash
./scripts/generate-index.sh
```

This creates/updates `meetings/INDEX.md` with organized links to all meetings.

## File Naming Convention

**Format**: `YYYY-MM-DD_ClientName_MeetingType.md`

**Examples**:
- `2024-12-10_AcmeCorp_ProjectKickoff.md`
- `2024-11-15_TechStartup_StatusUpdate.md`
- `2024-10-20_CityCouncil_QuarterlyReview.md`

**Guidelines**:
- Always use `YYYY-MM-DD` format for dates (enables proper sorting)
- Remove spaces from client names (use CamelCase or underscores)
- Use descriptive meeting types

## Meeting Types

Common meeting types include:
- **ProjectKickoff** - Initial project launch meeting
- **StatusUpdate** - Regular progress update
- **QuarterlyReview** - Quarterly business review
- **WeeklyCheckIn** - Weekly sync meeting
- **PlanningSession** - Planning and strategy meeting
- **TechnicalReview** - Technical design or code review
- **ExecutiveReview** - Executive stakeholder review
- **Other** - Any other meeting type

## Finding Meeting Minutes

### Using the Index
The `INDEX.md` file provides three ways to browse meetings:
1. **By Year** - Chronologically organized
2. **By Client** - All meetings per client
3. **By Meeting Type** - Grouped by meeting category

### Using Command Line
```bash
# Find meetings for a specific client
find meetings/ -name "*ClientName*"

# Find meetings on a specific date
find meetings/ -name "2024-12-10*"

# Search for content in all meetings
grep -r "action item" meetings/

# Search with Git
git grep "search term" meetings/
```

### Using GitHub
When viewing on GitHub, use the search bar:
- `path:meetings/ ClientName` - Find all meetings with a client
- `path:meetings/2024/` - Browse meetings from 2024

## Template and Documentation

- **Template**: `templates/meeting-minutes-template.md`
- **Template Guide**: `docs/TEMPLATE_GUIDE.md` - Comprehensive guide on using the template
- **Version Control Guide**: `docs/VERSION_CONTROL_GUIDE.md` - Best practices for managing meeting minutes

## Best Practices

### During the Meeting
1. **Take Notes in Real-Time** - Don't wait until after the meeting
2. **Use the Template** - Open it before the meeting starts
3. **Capture Action Items Clearly** - Include owner and due date
4. **Document Decisions** - Note who made decisions and why

### After the Meeting
1. **Complete Within 24 Hours** - Finish and distribute quickly
2. **Review for Accuracy** - Proofread before sharing
3. **Get Approval** - Have key stakeholders review
4. **Update the Index** - Run `generate-index.sh`
5. **Commit to Git** - Version control your changes

### Writing Style
- **Be Concise** - Clear and brief language
- **Be Objective** - Facts, not opinions
- **Be Specific** - Avoid vague statements
- **Use Active Voice** - "Team will implement" not "Implementation will be done"

## Version Control with Git

### Adding New Minutes
```bash
# Add the new file
git add meetings/2024/2024-12-10_Client_Meeting.md

# Commit with descriptive message
git commit -m "Add meeting minutes: ClientName 2024-12-10"

# Push to repository
git push
```

### Updating Existing Minutes
```bash
# Make your changes, then:
git add meetings/2024/2024-12-10_Client_Meeting.md
git commit -m "Update meeting minutes: ClientName 2024-12-10 - Add action item status"
git push
```

### Viewing History
```bash
# See all changes to a file
git log meetings/2024/2024-12-10_Client_Meeting.md

# See detailed changes
git log -p meetings/2024/2024-12-10_Client_Meeting.md

# Compare versions
git diff HEAD~1 HEAD -- meetings/2024/2024-12-10_Client_Meeting.md
```

## Template Sections Overview

Each meeting minutes file includes:

1. **Meeting Information** - Date, time, location, type
2. **Attendees** - Present and absent participants
3. **Meeting Objective** - Primary purpose
4. **Agenda Items** - Discussion points and outcomes
5. **Decisions Made** - Key decisions with context
6. **Action Items** - Tasks with owners and due dates
7. **Key Takeaways** - Important insights
8. **Issues and Concerns** - Problems needing resolution
9. **Next Steps** - Immediate actions
10. **Next Meeting** - Schedule and agenda preview
11. **Additional Notes** - Extra context
12. **Attachments and References** - Supporting materials
13. **Document History** - Version tracking
14. **Document Footer** - Approval status

For detailed guidance on each section, see `docs/TEMPLATE_GUIDE.md`.

## Support and Contribution

- **Questions**: Open an issue in the repository
- **Suggestions**: Submit a pull request with improvements
- **Issues**: Report problems with the template or scripts

## Examples

See `meetings/2024/2024-12-10_AcmeCorp_ProjectKickoff.md` for a complete example of a filled-out meeting minutes document.

---

**Last Updated**: 2024-12-10  
**Maintainer**: Repository Administrators
