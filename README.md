# Citywide--MOM (Minutes of Meeting)

This repository stores minutes of meetings (MoM) from client calls, including key discussion points, decisions, action items, and follow-ups. It ensures transparency and accountability in client communications.

## 🚀 Quick Start

### Creating New Meeting Minutes

**Using the automation script (Recommended)**:
```bash
# Interactive mode - guided prompts
./scripts/generate-meeting-minutes.sh --interactive

# Quick creation
./scripts/generate-meeting-minutes.sh --client "ClientName" --date "2024-12-10" --type "StatusUpdate"
```

**Manual creation**:
1. Copy `templates/meeting-minutes-template.md`
2. Save as `YYYY-MM-DD_ClientName_MeetingType.md` in appropriate year directory
3. Fill in all sections following the template guide

### Finding Meeting Minutes

- **Browse Index**: See `meetings/INDEX.md` for organized view of all meetings
- **By Year**: Navigate to `meetings/YYYY/` directories
- **Search**: Use GitHub search or `git grep "search term" meetings/`

## 📁 Repository Structure

```
.
├── README.md                           # This file
├── meetings/                           # All meeting minutes organized by year
│   ├── INDEX.md                       # Auto-generated index of all meetings
│   ├── README.md                      # Meeting directory guide
│   ├── 2024/                          # 2024 meetings
│   ├── 2025/                          # 2025 meetings
│   └── [future years]/
├── templates/                          # Templates for meeting minutes
│   └── meeting-minutes-template.md    # Standardized meeting minutes template
├── scripts/                            # Automation scripts
│   ├── generate-meeting-minutes.sh    # Create new meeting minutes from template
│   └── generate-index.sh              # Generate/update meeting index
└── docs/                               # Documentation
    ├── TEMPLATE_GUIDE.md              # Comprehensive template usage guide
    └── VERSION_CONTROL_GUIDE.md       # Git workflow and best practices
```

## 📝 Features

### ✅ Standardized Template
- Comprehensive template covering all essential meeting elements
- Consistent structure across all meeting records
- Includes sections for decisions, action items, issues, and more

### 🤖 Automation
- Script to generate meeting minutes from template automatically
- Automatic filename formatting following naming conventions
- Interactive mode for guided creation

### 📊 Navigation & Discovery
- Auto-generated index organized by year, client, and meeting type
- Easy search and filtering capabilities
- Quick reference to past meetings

### 🔄 Version Control
- Git-based version tracking for all changes
- Complete audit trail of who changed what and when
- Ability to view historical versions

### 📖 Documentation
- Detailed template guide explaining each section
- Version control best practices guide
- Examples and quick reference materials

## 📚 Documentation

- **[Template Guide](docs/TEMPLATE_GUIDE.md)** - Complete guide on using the meeting minutes template
- **[Version Control Guide](docs/VERSION_CONTROL_GUIDE.md)** - Git workflow and best practices
- **[Meetings README](meetings/README.md)** - Guide for the meetings directory
- **[Meeting Index](meetings/INDEX.md)** - Organized list of all meetings

## 🎯 Meeting Template Sections

Each meeting minutes document includes:

1. **Meeting Information** - Date, time, location, meeting type
2. **Attendees** - Present and absent participants  
3. **Meeting Objective** - Primary purpose of the meeting
4. **Agenda Items** - Topics discussed with outcomes
5. **Decisions Made** - Key decisions with impact assessment
6. **Action Items** - Tasks with owners, due dates, and status
7. **Key Takeaways** - Important insights and conclusions
8. **Issues and Concerns** - Problems requiring resolution
9. **Next Steps** - Immediate actions following the meeting
10. **Next Meeting** - Schedule and agenda preview
11. **Additional Notes** - Extra context and information
12. **Attachments and References** - Links to supporting materials
13. **Document History** - Version tracking within the document
14. **Document Footer** - Approval and review status

## 🔧 Usage Examples

### Create Meeting Minutes

```bash
# Interactive mode (recommended for first-time users)
./scripts/generate-meeting-minutes.sh --interactive

# With all parameters
./scripts/generate-meeting-minutes.sh \
  --client "AcmeCorp" \
  --date "2024-12-10" \
  --type "ProjectKickoff"

# Using short options
./scripts/generate-meeting-minutes.sh -c "TechStartup" -t "StatusUpdate"
```

### Update Meeting Index

```bash
# Regenerate index after adding/updating meetings
./scripts/generate-index.sh
```

### Search for Meetings

```bash
# Find meetings by client
find meetings/ -name "*ClientName*"

# Find meetings on specific date
find meetings/ -name "2024-12-10*"

# Search content in all meetings
grep -r "action item" meetings/

# Search using Git
git grep "decision" meetings/
```

### View Meeting History

```bash
# See all changes to a meeting
git log meetings/2024/2024-12-10_Client_Meeting.md

# See detailed changes
git log -p meetings/2024/2024-12-10_Client_Meeting.md

# See who changed what
git blame meetings/2024/2024-12-10_Client_Meeting.md
```

## 📋 File Naming Convention

**Format**: `YYYY-MM-DD_ClientName_MeetingType.md`

**Examples**:
- `2024-12-10_AcmeCorp_ProjectKickoff.md`
- `2024-11-15_TechStartup_StatusUpdate.md`
- `2024-10-20_CityCouncil_QuarterlyReview.md`

**Meeting Types**:
- `ProjectKickoff` - Initial project launch meeting
- `StatusUpdate` - Regular progress update
- `QuarterlyReview` - Quarterly business review
- `WeeklyCheckIn` - Weekly sync meeting
- `PlanningSession` - Planning and strategy meeting
- `TechnicalReview` - Technical design or code review
- `ExecutiveReview` - Executive stakeholder review
- `Other` - Any other meeting type

## 🤝 Contributing

### Adding New Meeting Minutes

1. Create meeting minutes using the automation script or template
2. Fill in all required sections
3. Review for accuracy and completeness
4. Commit with descriptive message:
   ```bash
   git add meetings/YYYY/YYYY-MM-DD_Client_Type.md
   git commit -m "Add meeting minutes: ClientName YYYY-MM-DD"
   git push
   ```
5. Update the index:
   ```bash
   ./scripts/generate-index.sh
   git add meetings/INDEX.md
   git commit -m "Update meeting index"
   git push
   ```

### Updating Existing Minutes

1. Make necessary changes to the file
2. Update "Document Version" and "Last Updated" fields
3. Add entry to "Document History" table in the document
4. Commit changes:
   ```bash
   git add meetings/YYYY/YYYY-MM-DD_Client_Type.md
   git commit -m "Update meeting minutes: ClientName YYYY-MM-DD - [description]"
   git push
   ```

## ✨ Best Practices

### During the Meeting
- Take notes in real-time using the template
- Capture action items with clear owners and due dates
- Document all decisions made
- Note any issues or concerns raised

### After the Meeting  
- Complete meeting minutes within 24 hours
- Review for accuracy before sharing
- Get approval from key stakeholders
- Distribute to all attendees
- Update the index

### Writing Style
- Be concise and clear
- Be objective (facts, not opinions)
- Be specific (avoid vague statements)
- Use active voice
- Avoid unnecessary jargon

## 🔍 Example

See a complete example at:
- **[AcmeCorp Project Kickoff Meeting](meetings/2024/2024-12-10_AcmeCorp_ProjectKickoff.md)**

## 📞 Support

- **Questions**: Open an issue in this repository
- **Bug Reports**: Submit an issue with details
- **Feature Requests**: Open an issue with your suggestion
- **Documentation Issues**: Submit a pull request with corrections

## 📄 License

This repository is for internal use. All meeting minutes are confidential and should not be shared outside the organization without proper authorization.

---

**Last Updated**: 2024-12-10  
**Maintained by**: Repository Administrators
