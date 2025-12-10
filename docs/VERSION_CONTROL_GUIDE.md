# Version Control Guide for Meeting Minutes

This guide explains how to use Git for managing meeting minutes, including best practices for version control, tracking changes, and collaborating effectively.

## Table of Contents
1. [Overview](#overview)
2. [Basic Git Workflow](#basic-git-workflow)
3. [Version Numbering](#version-numbering)
4. [Commit Message Guidelines](#commit-message-guidelines)
5. [Tracking Changes](#tracking-changes)
6. [Collaboration](#collaboration)
7. [Advanced Topics](#advanced-topics)

---

## Overview

Using Git for meeting minutes provides:
- **Complete History** - See all changes ever made to any document
- **Who Changed What** - Track author of every change
- **When It Changed** - Timestamp for every modification
- **Why It Changed** - Commit messages explain reasoning
- **Ability to Revert** - Undo changes if needed
- **Collaboration** - Multiple people can work together

---

## Basic Git Workflow

### Creating New Meeting Minutes

**Step 1: Generate the file**
```bash
# Use the automation script
./scripts/generate-meeting-minutes.sh -c "ClientName" -d "2024-12-10" -t "StatusUpdate"
```

**Step 2: Fill in the content**
- Open the generated file
- Complete all sections following the template
- Review for accuracy and completeness

**Step 3: Commit to Git**
```bash
# Check what files changed
git status

# Add the new file
git add meetings/2024/2024-12-10_ClientName_StatusUpdate.md

# Commit with a descriptive message
git commit -m "Add meeting minutes: ClientName status update 2024-12-10"

# Push to the remote repository
git push
```

### Updating Existing Meeting Minutes

**Step 1: Make your changes**
- Open the file and edit as needed
- Update "Document Version" field (e.g., 1.0 → 1.1)
- Update "Last Updated" field with current date
- Add entry to "Document History" table

**Step 2: Review changes**
```bash
# See what changed
git diff meetings/2024/2024-12-10_ClientName_StatusUpdate.md

# Review all unstaged changes
git status
```

**Step 3: Commit changes**
```bash
# Stage the modified file
git add meetings/2024/2024-12-10_ClientName_StatusUpdate.md

# Commit with explanation
git commit -m "Update meeting minutes: ClientName 2024-12-10 - Add action item completion status"

# Push changes
git push
```

### Updating the Index

After adding or modifying meetings:
```bash
# Regenerate the index
./scripts/generate-index.sh

# Commit the updated index
git add meetings/INDEX.md
git commit -m "Update meeting index"
git push
```

---

## Version Numbering

### Document Version Field

Every meeting minutes document has a "Document Version" field in the Meeting Information section. This should be updated following semantic versioning principles:

**Format**: `MAJOR.MINOR`

**Version Increments**:
- **1.0** - Initial approved version
- **1.1, 1.2, ...** - Minor updates (typos, clarifications, adding action item status)
- **2.0, 3.0, ...** - Major revisions (significant content changes, restructuring)

**Examples**:
```
1.0 → Initial creation
1.1 → Fixed typo in attendee name
1.2 → Added forgotten action item
1.3 → Updated action item status
2.0 → Major revision after follow-up meeting
```

### Document History Table

Always update the Document History table when making changes:

```markdown
| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2024-12-10 | John Doe | Initial creation |
| 1.1 | 2024-12-11 | Jane Smith | Fixed attendee names |
| 1.2 | 2024-12-15 | John Doe | Updated action item status |
```

---

## Commit Message Guidelines

Good commit messages help others (and your future self) understand changes.

### Format

```
<type>: <subject>

[optional body]
```

### Types

- **Add** - New meeting minutes
- **Update** - Changes to existing minutes
- **Fix** - Corrections to errors
- **Docs** - Documentation changes
- **Refactor** - Reorganization without content changes

### Examples

**Good commit messages**:
```bash
git commit -m "Add meeting minutes: AcmeCorp project kickoff 2024-12-10"

git commit -m "Update meeting minutes: AcmeCorp 2024-12-10 - Mark action items complete"

git commit -m "Fix meeting minutes: TechStartup 2024-11-15 - Correct attendee list"

git commit -m "Update meeting index"
```

**Bad commit messages** (avoid these):
```bash
git commit -m "update"
git commit -m "changes"
git commit -m "fix"
git commit -m "meeting"
```

### Detailed Messages

For complex changes, add a body:
```bash
git commit -m "Update meeting minutes: AcmeCorp 2024-12-10 - Major revision

- Added three new action items from follow-up discussion
- Updated decisions section with board approval
- Clarified technical architecture requirements
- Added links to design documents"
```

---

## Tracking Changes

### View File History

**See all commits for a file**:
```bash
git log meetings/2024/2024-12-10_Client_Meeting.md
```

**See commits with changes**:
```bash
git log -p meetings/2024/2024-12-10_Client_Meeting.md
```

**See summary of changes**:
```bash
git log --stat meetings/2024/2024-12-10_Client_Meeting.md
```

**See one-line summary**:
```bash
git log --oneline meetings/2024/2024-12-10_Client_Meeting.md
```

### View Specific Changes

**Compare current version to previous**:
```bash
git diff HEAD~1 HEAD -- meetings/2024/2024-12-10_Client_Meeting.md
```

**Compare two specific commits**:
```bash
git diff abc123 def456 -- meetings/2024/2024-12-10_Client_Meeting.md
```

**See changes in a specific commit**:
```bash
git show abc123:meetings/2024/2024-12-10_Client_Meeting.md
```

### View Old Versions

**Show file as it was in a specific commit**:
```bash
git show abc123:meetings/2024/2024-12-10_Client_Meeting.md
```

**Show file as it was on a specific date**:
```bash
git show HEAD@{2024-12-01}:meetings/2024/2024-12-10_Client_Meeting.md
```

### Blame (Who Changed What)

**See who last modified each line**:
```bash
git blame meetings/2024/2024-12-10_Client_Meeting.md
```

**See changes in a specific range**:
```bash
git blame -L 10,20 meetings/2024/2024-12-10_Client_Meeting.md
```

---

## Collaboration

### Working with Others

**Pull latest changes before editing**:
```bash
# Get latest from remote
git pull

# Now safe to make changes
```

**Check if remote has updates**:
```bash
git fetch
git status
```

### Handling Conflicts

If two people edit the same meeting minutes, conflicts may occur.

**When conflict happens**:
```bash
# After git pull shows conflict
git status  # See which files conflict

# Open the conflicting file
# Look for conflict markers:
<<<<<<< HEAD
Your changes
=======
Their changes
>>>>>>> branch-name

# Manually resolve by choosing correct content
# Remove conflict markers

# Mark as resolved
git add meetings/2024/2024-12-10_Client_Meeting.md

# Complete the merge
git commit

# Push resolved version
git push
```

**Prevention tips**:
1. Always pull before starting work
2. Communicate with team about who's editing what
3. Make changes quickly and push promptly
4. Use descriptive commit messages

### Reviewing Others' Changes

**See what others changed**:
```bash
# View recent commits
git log --all --graph --oneline

# See changes by author
git log --author="Jane Smith" meetings/

# Review a specific commit
git show abc123
```

**Get someone else's changes**:
```bash
# Pull from remote
git pull

# View what changed
git log HEAD@{1}..HEAD
```

---

## Advanced Topics

### Reverting Changes

**Undo uncommitted changes**:
```bash
# Discard changes to a file
git checkout -- meetings/2024/2024-12-10_Client_Meeting.md

# Discard all uncommitted changes
git reset --hard
```

**Undo last commit (keep changes)**:
```bash
git reset --soft HEAD~1
```

**Undo last commit (discard changes)** - ⚠️ Use with caution:
```bash
git reset --hard HEAD~1
```

**Revert a specific commit** (creates new commit):
```bash
git revert abc123
```

### Searching History

**Find when text was added or removed**:
```bash
git log -S "search text" meetings/
```

**Find commits with message containing text**:
```bash
git log --grep="ClientName" meetings/
```

**Search in all commits**:
```bash
git log --all --grep="action item"
```

### Tags for Milestones

Tag important versions:
```bash
# Create annotated tag
git tag -a v1.0-quarterly-review -m "Q4 2024 Quarterly Review"

# Push tags
git push --tags

# List tags
git tag

# Show tag details
git show v1.0-quarterly-review
```

### Viewing Repository State

**See all changed files**:
```bash
git status
```

**See what's been staged**:
```bash
git diff --cached
```

**See all local changes**:
```bash
git diff
```

---

## Git Configuration

### Set Your Identity

Before your first commit:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Useful Aliases

Make Git easier:
```bash
# Short status
git config --global alias.st status

# Short log
git config --global alias.lg "log --oneline --graph --all"

# Show staged changes
git config --global alias.staged "diff --cached"
```

Use them:
```bash
git st
git lg
git staged
```

---

## Best Practices Summary

1. **Commit Often** - Small, focused commits are better than large ones
2. **Write Good Messages** - Explain what and why, not how
3. **Pull Before Push** - Always get latest changes first
4. **Review Before Commit** - Use `git diff` to check changes
5. **Update Version Numbers** - Increment document version for changes
6. **Update History Table** - Document all revisions
7. **Keep Commits Atomic** - One logical change per commit
8. **Push Regularly** - Don't let changes sit uncommitted
9. **Communicate** - Let team know about major changes
10. **Use Branches** - For experimental changes (advanced)

---

## Quick Reference

```bash
# Daily workflow
git pull                                    # Get latest changes
# Make your edits
git status                                  # See what changed
git diff                                    # Review changes
git add meetings/2024/file.md              # Stage changes
git commit -m "descriptive message"        # Commit
git push                                   # Share changes

# Viewing history
git log meetings/                          # See commits
git log -p meetings/file.md               # See changes
git blame meetings/file.md                # Who changed what

# Searching
git grep "text" meetings/                 # Search current version
git log -S "text" meetings/               # Search history
```

---

## Getting Help

```bash
# Command help
git help <command>
git <command> --help

# Examples
git help commit
git help log
```

**Online Resources**:
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)

---

**Last Updated**: 2024-12-10  
**Version**: 1.0
