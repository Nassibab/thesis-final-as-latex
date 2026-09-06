---
name: push-thesis-part
description: >-
  Commit and push the current thesis snapshot to GitHub in one step.
  Use when the user finishes a chapter, section, or writing session, or says
  push, save this part, save progress, commit and push, snapshot, I'm done
  with this section, or wants to back up the thesis at once.
---

# Push Thesis Part

When the user finishes a part of the thesis, **commit all relevant source files and push to `origin` in one step**. Do not wait for a second confirmation unless something below is unsafe or ambiguous.

## What to include

Stage and commit:

- Thesis source: `*.tex`, `*.bib`, figures, tables, and other authored files
- Project Cursor files: `.cursor/skills/`, `.cursor/rules/`, `guide.cursor`
- `.gitignore` and other repo config the user changed

Do **not** commit unless the user explicitly asks:

- Generated PDFs (`main.pdf` and other `*.pdf` build output)
- LaTeX build artifacts (already in `.gitignore`)
- `.DS_Store`, editor caches, secrets

If the only new file is `main.pdf`, say so and do not create an empty or PDF-only commit.

## Workflow

Copy this checklist and complete it in order:

```
Push thesis part:
- [ ] Inspect repo state
- [ ] Name the finished part
- [ ] Stage source files only
- [ ] Commit
- [ ] Push
- [ ] Confirm
```

### 1. Inspect repo state

Run these in parallel:

```bash
git status
git diff && git diff --staged
git log -8 --oneline
git branch -vv
```

If there are **no changes**, stop. Do not create an empty commit. Tell the user the repo is already clean and pushed.

If the branch has **no upstream**, still push with `-u` in step 4.

### 2. Name the finished part

Infer the part from the user message first, then from the diff.

Use this commit-message format (why, not a file dump):

```
Save [Part]: short description of what was finished
```

Examples:

- `Save Literature Review: add theoretical framework subsection`
- `Save Methods: complete interview protocol`
- `Save Introduction: revise research questions`
- `Save Formatting: fix citation commands in chapter 2`

If the user already gave a message, use it verbatim as the subject (still prefix with `Save [Part]:` only if they did not).

### 3. Stage source files only

```bash
git add main.tex references.bib
```

Add any other **authored** files that appear in `git status` (new chapters, figures, skills, rules). Never `git add .` if that would include `main.pdf` or build output.

### 4. Commit, then push

Commit with a HEREDOC:

```bash
git commit -m "$(cat <<'EOF'
Save [Part]: short description of what was finished

EOF
)"
```

Then push the current branch. Never force-push. Never `--no-verify`. Never amend unless the user asked.

```bash
git push -u origin HEAD
```

If push fails because the remote has new commits, **stop**. Pull/rebase only if the user asks. Do not force-push.

### 5. Confirm

Run `git status` and tell the user:

- The commit subject
- That it was pushed to `origin` (branch name)
- The GitHub repo: `https://github.com/Nassibab/thesis-final-as-latex`

## Safety

- Never update git config
- Never `git add .` blindly
- Never rewrite thesis prose as part of this skill
- Never force-push `main`
- Never skip hooks
- This skill **is** explicit permission to commit **and** push

## Triggers

Apply this skill when the user says things like:

- "push this"
- "push the thesis"
- "save this part"
- "I'm done with this section"
- "commit and push"
- "snapshot this"
- "save progress"
