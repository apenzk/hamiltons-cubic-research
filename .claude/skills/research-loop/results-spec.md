# results.md, the specification

Reactive: consult when writing or revising [results.md](../../../results.md). The cycle protocol around it (when to touch it at all, and the handoff that follows) stays in [SKILL.md](SKILL.md) step 4.

**Touching results.md means a whole-document pass**, not an append. That rule is below and is the one most often skipped.

---

#### What results.md is

The outgoing progress report on an open conjecture, written for the mathematician who set the problem. It reports honestly on a partial attack: what is proven, what is measured, what is guessed, and what is untouched. It reads as mathematics (hypotheses, statement, proof, citation) at the register of a colleague's letter rather than a journal submission.

Its first line states where the conjecture actually stands, and it stays accurate even when that is uncomfortable. **Nothing is oversold.** A reader who acts on this document must never be surprised by what it turns out not to contain.

#### Fixed section order

The skeleton is stable across cycles, so a returning reader finds things where they left them:

1. **Where this stands**, the verdict in one paragraph, then a piece-by-state table, then what changed since the previous version.
2. **What has been achieved**, the standing gains, in prose.
3. **Relation to the existing literature**, what is published, what is new here, what was independently reproduced.
4. **The route that now carries the argument**, the primary route, named and committed to.
5. **What is missing to prove the conjecture**, the open gap, stated sharply enough to recognise a solution.
6. **How the attack is organised**, the strategies (A), (B), (C) and what each is for.
7. **Preliminary: the granted assumption, and its repair.**
8. **Scope notes**, parity and any other restriction in force.
9. **The results at a glance**, one bolded line per numbered result, grouped by strategy.
10. **The results in detail**, the full statement of each, in the same order and numbering, **each ending in a pointer to the [findings/](../../../findings/) file that carries its proof**.

Sections 9 and 10 mirror each other exactly: every glance entry has a detail entry carrying the same number and title, and no detail entry exists without its glance line.

#### Length budget for the glance entries

One glance entry is one bullet: a bolded title, then a body that states the result. Counted over the whole entry with the bullet marker excluded:

| | Words |
|---|---|
| **Target** | **40** |
| Comfortable band | 30–50 |
| Hard cap | **60** |
| Floor | 25 |
| Title alone | aim at 12, stay under 16 |

**At the cap, the entry stops and the detail entry takes over.** An entry running past 60 words is carrying an argument, a caveat or a second result, all three belong in section 10, where there is room for them. Cut the entry to the claim itself and move the rest down rather than compressing the prose.

**At the floor, the entry is naming rather than stating.** "Rival critical-point families. Six eliminated." tells a reader nothing they can weigh. Say what the result asserts and what it costs, the dimensions it holds in, the hypothesis it needs, or the thing it fails to reach.

The band is where a reader skimming section 9 alone gets an accurate picture of the whole attack. Aim at 40 and let the harder results sit at 50.

Check the section before committing:

```bash
python3 - <<'PY'
import re
lines = open('results.md').read().split('\n')
a = next(i for i,l in enumerate(lines) if l.startswith('## The results at a glance'))
b = next(i for i,l in enumerate(lines) if l.startswith('## The results in detail'))
for l in lines[a:b]:
    if not l.startswith('- **'): continue
    n = len(l.split()) - 1
    t = len(re.match(r'- \*\*(.+?)\*\*', l).group(1).split())
    flag = 'OVER CAP' if n > 60 else 'under floor' if n < 25 else 'long title' if t > 16 else ''
    if flag: print(f'{n:3d}w title {t:2d}w  {flag}  {l[:70]}')
PY
```

#### Labels carry their evidence level

| Label | Means | Requires |
|---|---|---|
| **Lemma** | Proven | A complete argument, Gate 1 and Gate 2 passed |
| **Observation** | Verified numerically at the dimensions stated | Gate 1, plus the dimensions named in the statement |
| **Conjecture** | A candidate not proved | Stated as a candidate, with what would settle it |

Labels are literal and the document says so. A result moves up a tier only after the evidence for the higher tier exists, a numerically convincing Observation stays an Observation until there is a proof. Each result carries its strategy tag, `(A)`, `(B)` or `(C)`, except where it stands outside all of them.

#### Numbering is an address, and [findings/INDEX.md](../../../findings/INDEX.md) owns it

**A number is assigned when a result gets a block in [findings/](../../../findings/)**, catalogued in that index with a short name; this file and the report adopt it. *A result with no block there has no number to cite.*

Result numbers are cited from [findings/INDEX.md](../../../findings/INDEX.md), [plan.md](../../../plan.md), [reviews/INDEX.md](../../../reviews/INDEX.md) and previous versions the reader already holds, so a number means one thing permanently. When a result is refuted, delete its content and retire its number; assign the next new result a fresh number. Fix every cross-reference in the same edit.

#### Each detail entry

**This file states results; [findings/](../../../findings/) proves them.** An entry carries the claim a reader must be able to check the *shape* of, and points at the file where the argument, the numerics and the sources live. That file is where a result is corrected when it moves, so the proof has one home and cannot drift between two.

- **States the result with its full hypotheses**, dimension ranges included, enough that a reader knows exactly what is claimed without opening anything.
- **Ends with `**Proof:** [<file>](../../../findings/<file>.md)`**, naming the findings file that carries the canonical block.
- **Says what it does not reach** when the scope is narrower than the reader would assume.
- **Keeps the motivation to a sentence** where it earns one; the full "why it was needed" belongs with the proof.

**What does NOT belong here:** the argument, the estimates, the numerics, the source citations, the reproduction notes. All of those go in the findings file, under a `#### Lemma N, …` block, one canonical block per result. *Every proof lived in this file once and in no other, which is how a rewrite of one summary section came within a check of destroying forty of them.*

#### Every update is a whole-document pass

**Touching [results.md](../../../results.md) means reading all ten sections and reconciling every one of them against what the cycle established.** A new result is never appended to section 10 and left there. One result changes the standing of the whole attack, and a document where only the newest section knows that is worse than one that was never updated, the reader trusts sections 1 through 8 precisely because they are summaries, so a stale summary misleads more than a stale detail.

Walk the sections in order and ask what each now says wrongly:

| Section | What the cycle can have invalidated |
|---|---|
| 1 · Where this stands | The verdict paragraph, every row of the state table, and the "what changed" note, which is rewritten for *this* cycle rather than accumulated |
| 2 · What has been achieved | A gain that was retracted, or one now understood at a different scope |
| 3 · Relation to the literature | A result the cycle found already published, or a citation the reading corrected |
| 4 · The route that carries the argument | Whether the named primary route is still the primary route |
| 5 · What is missing | The gap moved, narrowed, or turned out to be a different gap |
| 6 · How the attack is organised | A strategy that closed, died, or absorbed another |
| 7 · The granted assumption | Its repair's scope |
| 8 · Scope notes | A restriction lifted or newly imposed |
| 9 · At a glance | The entry, its label, its strategy tag, and the entries whose claims this one weakened |
| 10 · In detail | The entry, plus every other entry that cited it |

Then check the document against itself before finishing: **the state table, the glance list and the detail entries must agree**, no claim may cite a retired number, and no section may describe the attack in terms an earlier section has already abandoned. A result that changes nothing outside its own entry is rare enough to be worth double-checking rather than assuming.

Sections 1 and 5 are the ones a reader acts on, so they are re-derived from the current section 10 every cycle rather than edited incrementally.

#### Editing rules

- Only Gate 2 material enters as a claim. Gate-2-pending results are labelled as such wherever they appear, or held back.
- **Delete boldly.** Statements the cycle refuted come out entirely, along with scaffolding that now supports nothing and framing the refutation invalidated. Apply the correction to the summary table, the glance list and the detail entry in one pass, so the three never disagree.
- A refutation that teaches something becomes one positive sentence stating the corrected fact. Strikethroughs, "previously believed" asides and superseded paragraphs are removed.
- Numerical evidence is labelled as numerical, with the dimensions it covers.
- Prose is never hard-wrapped; mathematics is LaTeX, inline as $\dots$ and display as $$\dots$$; spectra and multiplicities go in tables.



**The plan check is the third of these, and it exists for the same reason.** *The task list, and nothing else* has been in this file since the beginning, and the plan still reached $53$ kB with three live items carrying full derivations that the findings files already held. Prose cannot enforce a size discipline, because every individual addition is justified at the moment it is written, the item genuinely did learn something, and the sentence recording it genuinely belongs somewhere. What the check supplies is the part a cycle cannot supply for itself: the observation that the *accumulation* has passed a threshold. A live item over $2.5$ kB is carrying mathematics; move it to the findings file that owns the subject and leave the task, the route, what is owed and the falsifier.

**A rule that has been violated twice is replaced by a check, not restated.** The instruction to index every reviewer was written after nine went missing at once, and sixteen went missing afterwards anyway, because the rule fires at the moment the cycle has already moved on to its next task, which is exactly when a rule is least likely to be read. The check costs one line and runs where the cycle cannot skip it.

## A withdrawn value is renamed, not annotated

**When [results.md](../../../results.md) withdraws a value from the role it was recorded in, the same edit renames it to what it measures.** *A withdrawal phrased as what the number is not leaves the name pointing at the withdrawn role, and the next reader who searches for it finds the old slot with a note beside it.* **The old name resolves to nothing; the quantity keeps a name of its own.**

