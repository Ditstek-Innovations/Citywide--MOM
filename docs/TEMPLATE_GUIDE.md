# Meeting Minutes Template Guide

This guide explains how to use the standardized meeting minutes template to ensure consistency and completeness across all meeting records.

## Table of Contents
1. [Overview](#overview)
2. [Template Sections](#template-sections)
3. [Naming Conventions](#naming-conventions)
4. [Best Practices](#best-practices)
5. [Version Control](#version-control)

---

## Overview

The meeting minutes template is designed to capture all essential information from client calls in a standardized format. This ensures:
- **Consistency**: All meeting records follow the same structure
- **Completeness**: No critical information is missed
- **Accessibility**: Easy to find and reference past decisions
- **Accountability**: Clear ownership of action items and decisions

---

## Template Sections

### 1. Meeting Information
**Purpose**: Provides basic metadata about the meeting.

**Fields to complete**:
- **Date**: Use YYYY-MM-DD format (e.g., 2024-12-10)
- **Time**: Include timezone (e.g., 2:00 PM - 3:00 PM EST)
- **Location/Platform**: Physical address or virtual platform (Zoom, Teams, etc.)
- **Meeting Type**: Categorize the meeting for easier filtering
- **Document Version**: Start with 1.0, increment for revisions
- **Last Updated**: Date of the most recent modification

### 2. Attendees
**Purpose**: Track who participated and who was absent.

**Guidelines**:
- List all invited participants
- Include full name, role, and organization
- Note reasons for absence when known
- This helps with follow-up and accountability

### 3. Meeting Objective
**Purpose**: State the primary purpose of the meeting in 1-2 sentences.

**Example**: "Review Q4 project deliverables and discuss timeline for Phase 2 implementation."

### 4. Agenda Items
**Purpose**: Document each topic discussed during the meeting.

**Structure**:
- Number each agenda item
- Include discussion points (bullet format)
- Document outcomes and conclusions
- Keep entries concise but informative

### 5. Decisions Made
**Purpose**: Record all decisions with context and impact.

**Table fields**:
- **#**: Sequential numbering
- **Decision**: Clear description of what was decided
- **Decision Maker**: Person or group who made the decision
- **Date**: When the decision was made
- **Impact**: High/Medium/Low - helps prioritize implementation

### 6. Action Items
**Purpose**: Track tasks assigned during the meeting.

**Table fields**:
- **#**: Sequential numbering
- **Action Item**: Specific, actionable task description
- **Owner**: Person responsible for completion
- **Due Date**: Expected completion date
- **Status**: Current state (Not Started, In Progress, Blocked, Completed, Cancelled)
- **Priority**: High/Medium/Low
- **Notes**: Additional context or dependencies

**Best practices**:
- Make action items SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- Assign one clear owner per item
- Update status in subsequent meetings

### 7. Key Takeaways
**Purpose**: Summarize the most important insights or conclusions.

**Guidelines**:
- 3-5 bullet points maximum
- Focus on strategic insights
- Highlight anything that changes direction or priorities

### 8. Issues and Concerns
**Purpose**: Track problems that need resolution.

**Table fields**:
- **#**: Sequential numbering
- **Issue/Concern**: Clear description of the problem
- **Severity**: High/Medium/Low
- **Owner**: Person responsible for addressing it
- **Status**: Open/In Progress/Resolved
- **Resolution**: How the issue was resolved (if applicable)

### 9. Next Steps
**Purpose**: Outline immediate actions following the meeting.

**Guidelines**:
- List in chronological or priority order
- Keep to 3-5 main steps
- These should be high-level, not duplicating action items table

### 10. Next Meeting
**Purpose**: Schedule and preview the next meeting.

**Include**:
- Proposed date and time
- Brief agenda overview
- Any preparation required

### 11. Additional Notes
**Purpose**: Capture anything not fitting other sections.

**Examples**:
- Links to related documents
- Background information
- Technical details
- Risk factors

### 12. Attachments and References
**Purpose**: Link to supporting materials.

**Include**:
- Presentation files
- Relevant documents
- Previous meeting minutes
- External resources

### 13. Document History
**Purpose**: Track all revisions to the meeting minutes.

**Guidelines**:
- Start with version 1.0
- Increment minor version (1.1, 1.2) for small updates
- Increment major version (2.0) for significant changes
- Always note who made changes and what changed

### 14. Document Footer
**Purpose**: Document approval and review status.

**Fields**:
- **Prepared by**: Original author
- **Review Status**: Draft / Under Review / Approved
- **Approved by**: Final approver and date

---

## Naming Conventions

### File Names
Use the following format for meeting minutes files:

```
YYYY-MM-DD_ClientName_MeetingType.md
```

**Examples**:
- `2024-12-10_AcmeCorp_StatusUpdate.md`
- `2024-11-15_TechStartup_ProjectKickoff.md`
- `2024-10-20_CityCouncil_QuarterlyReview.md`

**Guidelines**:
- Always use YYYY-MM-DD date format for proper sorting
- Replace spaces in client names with no spaces or underscores
- Use CamelCase or underscores consistently
- Keep names concise but descriptive

### Directory Structure
Organize meetings by year and optionally by client:

```
meetings/
├── 2024/
│   ├── 2024-01-15_ClientA_Kickoff.md
│   ├── 2024-02-20_ClientA_Review.md
│   └── 2024-03-10_ClientB_StatusUpdate.md
├── 2025/
│   └── 2025-01-05_ClientA_Planning.md
└── README.md
```

---

## Best Practices

### During the Meeting
1. **Real-time Capture**: Take notes during the meeting, not after
2. **Use the Template**: Open the template before the meeting starts
3. **Assign Note-taker**: Designate someone to own the minutes
4. **Confirm Decisions**: Verify decisions with attendees before documenting
5. **Clarify Action Items**: Ensure owners agree to assignments

### After the Meeting
1. **Complete Within 24 Hours**: Finish and distribute within one business day
2. **Review for Accuracy**: Proofread before sharing
3. **Get Approval**: Have key stakeholders review draft
4. **Distribute Widely**: Share with all attendees and stakeholders
5. **Follow Up**: Track action items in subsequent meetings

### Writing Style
- **Be Concise**: Use clear, brief language
- **Be Objective**: Stick to facts, not opinions
- **Be Specific**: Avoid vague statements
- **Use Active Voice**: "Team will implement" not "Implementation will be done"
- **Avoid Jargon**: Use plain language when possible

### What NOT to Include
- Off-topic conversations
- Personal opinions (unless relevant to decisions)
- Confidential information not meant for wider distribution
- Verbatim transcripts (summarize instead)

---

## Version Control

### Git Workflow

#### Creating New Meeting Minutes
1. Create new file from template
2. Fill in meeting information
3. Commit with descriptive message:
   ```bash
   git add meetings/YYYY/YYYY-MM-DD_Client_Type.md
   git commit -m "Add meeting minutes: ClientName YYYY-MM-DD"
   git push
   ```

#### Updating Existing Minutes
1. Make necessary changes
2. Update "Document Version" and "Last Updated" fields
3. Add entry to "Document History" table
4. Commit with change description:
   ```bash
   git add meetings/YYYY/YYYY-MM-DD_Client_Type.md
   git commit -m "Update meeting minutes: ClientName YYYY-MM-DD - [brief description of changes]"
   git push
   ```

#### Version Numbering
- **1.0**: Initial approved version
- **1.1, 1.2, etc.**: Minor corrections or additions
- **2.0, 3.0, etc.**: Major revisions or significant changes

### Tracking Changes
Git automatically tracks:
- Who made changes (author)
- When changes were made (timestamp)
- What was changed (diff)
- Why changes were made (commit message)

To view history:
```bash
# See all changes to a specific file
git log meetings/2024/2024-12-10_Client_Meeting.md

# See detailed changes
git log -p meetings/2024/2024-12-10_Client_Meeting.md

# Compare versions
git diff <commit1> <commit2> -- meetings/2024/2024-12-10_Client_Meeting.md
```

---

## Quick Reference Checklist

Before submitting meeting minutes, verify:

- [ ] All required fields are filled in
- [ ] Date format is YYYY-MM-DD
- [ ] All attendees are listed
- [ ] Decisions have owners and impact levels
- [ ] Action items have owners, due dates, and status
- [ ] Next meeting is scheduled
- [ ] Document version is updated
- [ ] Prepared by and review status are filled
- [ ] File naming convention is followed
- [ ] File is saved in correct directory
- [ ] Changes are committed to git
- [ ] Minutes are distributed to attendees

---

## Support

For questions or suggestions about the template:
- Open an issue in this repository
- Contact the repository maintainers
- Refer to example meeting minutes in the repository

---

**Last Updated**: 2024-12-10  
**Template Version**: 1.0
