# gstack workflow template

This is a compact, repeatable flow based on the example sequence described in the gstack README, adapted as a reusable checklist.

## When to use
Use this flow when need to high-rigor planning, careful review, and disciplined shipping, with QA and optional browser verification.

## Flow (short)
1. `/plan-ceo-review` — validate the product goal and the right shape of the feature.
2. `/plan-eng-review` — make it buildable: architecture, data-flow, edge cases, tests, diagrams.
3. Build the feature.
4. `/review` — paranoid staff-engineer pass: hunt for real-world failure modes.
5. `/ship` — release machine: sync main, run tests, update changelog/versioning, push, PR.
6. `/qa` — diff-aware QA on affected routes (or `--quick` / `--regression` as needed).
7. `/browse` — spot-check key flows in staging with real UI eyes.

## Flow (detailed prompts)

### 1) Product fit
```
/plan-ceo-review
Context: <short product context>
Goal: <what success looks like>
Constraints: <time, scope, risk>
```

### 2) Engineering plan
```
/plan-eng-review
Feature: <short name>
Ask:
- Architecture diagram (components, boundaries)
- Data-flow diagram (sync vs async)
- Failure modes and retry strategy
- Tests required (unit/integration/e2e)
```

### 3) Implementation
- Build according to the plan.
- Keep changes small enough for review and QA.

### 4) Paranoid review
```
/review
Focus: hidden failure modes, races, N+1s, trust boundaries, bad invariants, missing indexes
```

### 5) Ship
```
/ship
Expect: sync main, run tests, update version/changelog, push, create/update PR
```

### 6) QA
```
/qa
```
Variants:
- `--quick` for 30s smoke test
- `--regression baseline.json` to compare to a previous baseline
- `https://staging.example.com` for full staging sweep

### 7) Browser verification
```
/setup-browser-cookies
/browse <staging-url> — login, test the primary flow, check changed pages
```

## Notes
- The example flow in gstack README is: plan (ceo) → plan (eng) → review → ship → QA/browse.
- Use `/setup-browser-cookies` before `/qa` or `/browse` if auth is required.
