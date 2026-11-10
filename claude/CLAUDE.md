# Global Rules

## Never speak as me

- Never post anything to an external service from my account unless I explicitly asked for that exact post: `gh pr comment`, `gh pr review`, `gh issue comment`, replies to review bots (Greptile, CodeRabbit), Slack, Linear — anything that appears publicly under my name.
- "Fix the review findings" authorises code changes only. It never authorises replying to the reviewer.
- Permission is per-post and does not carry over. An earlier "create the PR" does not cover commenting on that PR afterwards.
- Report results in the chat. If a reply on the PR would be useful, draft it in the chat and ask before posting.

## Git Commits

- Never commit unless I explicitly say to. Leave the changes in the working tree, tell me what changed, and wait — even if a task brief says "commit as you go".
- Never mention Claude, Claude Code, or AI in commit messages
- Do not add "Co-Authored-By" lines referencing Claude or Anthropic

## Git Branching

- Always run `git pull origin main` on main before creating a new feature branch
- Never commit directly to main — always create a feature branch
- Branch naming: `<type>/<short-description>` (e.g. `feat/add-inbox-page`, `fix/auth-redirect`, `chore/update-deps`, `ui/polish-sidebar`)

## gstack

- Workflow template: /Users/rs/github.com/dotfiles/claude/gstack-workflow.md
- Use the `/browse` skill from gstack for all web browsing.
- Never use `mcp__claude-in-chrome__*` tools.
- Available gstack skills: `/plan-ceo-review`, `/plan-eng-review`, `/review`, `/ship`, `/browse`, `/qa`, `/qa-only`, `/setup-browser-cookies`, `/retro`.

