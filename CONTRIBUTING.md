# Contributing

## Commit messages

**Bullets, not prose paragraphs.** A summary line, a blank line, then `- ` bullets. Each bullet carries one distinct, non-obvious fact that the summary does not already state; padding with filler bullets is worse than having fewer.

```
type(scope): short summary of what changed

- a distinct fact about the change
- another one
```

- **type**, one of `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
- **scope**, the area affected, preferred though optional.
- **summary**, imperative mood, lowercase, no trailing period.
- **bullet count follows the size of the change**, a trivial change takes the summary line alone, a small focused one 1–2 bullets, a medium one 2–4, a large one 4–6.

**Commits before 2026-08-31 use long prose paragraphs instead.** That is the superseded style; read them for content, not for form.

## The two research-loop trailers

Commits made while a research cycle is active carry trailers that [cycle_deliverable.py](.claude/hooks/cycle_deliverable.py) enforces as a pre-commit gate, so a message missing one is refused rather than merely discouraged. They apply to `feat(` and `fix(` only, `docs(`, `chore(`, `refactor(` and `test(` pass untouched.

```
Deliverable: derivation | refutation | dead-end | none
Searched: <what was searched> -> references/<slug>/
```

- `Deliverable:` names what the cycle settled. `none` means measurement only, and three consecutive `none` cycles are refused outright.
- `Searched:` is required when the commit opens or reopens a plan item. It must be **a single line** ending in a `references/` path, or `none -- <reason>`; a wrapped line fails the gate.
