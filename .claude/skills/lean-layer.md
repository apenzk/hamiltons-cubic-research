# The Lean layer, where it is, and how it is used

**The single address for the machine-checked layer**, so the loops cannot drift apart: they keep *when*, this file keeps *where* and *what*, and [lean-practice.md](lean-practice.md) keeps *how*.

## Where the files are

| path | what it holds |
|---|---|
| [lean/](../../lean/) | the layer's root; `lake build` from here checks everything in the kernel |
| `lean/HamiltonsCubic/Results/` | one file per numbered result, **named by its id**, so a Lean file and a [findings/](../../findings/) block share one address |
| `lean/HamiltonsCubic/Base/` | the base layer, the definitions results are stated over |
| `lean/HamiltonsCubic.lean` | the root import |
| [lean/INDEX.md](../../lean/INDEX.md) | **the layer's index**, one row per id: the file, the state, what is checked and what is owed. It also carries the layer's quotation convention and its coverage statement |
| [lean/lean-toolchain](../../lean/lean-toolchain) | the pinned Lean version |
| [lean/lakefile.toml](../../lean/lakefile.toml) | the Mathlib revision and the lint options |

**Numbering is owned by [findings/INDEX-results.md](../../findings/INDEX-results.md) and adopted here.** A file never assigns a number; it takes the one the record gave.

**A base-layer piece is a row of its own, id `B<n>`**, naming what it defines and which rows it unblocks. It is not a numbered result and never enters the record's numbering, `B` is the layer's own letter and shares with nothing.

## The four states

| state | meaning |
|---|---|
| `proved` | the statement is proved, kernel-checked |
| `partial` | one named half is proved; the row says what the other owes |
| `stated` | the statement type-checks with `sorry` |
| `unsupported` | the record does not hold what a proof would need, and the row names what is missing |

**`unsupported` and `stated` are both deliverables**, the first is a fact about the record that no further formalising would improve; the second is worth having before any proof exists, since the type-checker alone catches undefined symbols, missing hypotheses and quantities used outside their domain. **`native_decide` is declared in the file and in the row**, never silent: it trusts the compiler rather than the kernel.

## What checks it, and the one way that check goes quiet

**`lake build` from [lean/](../../lean/).** [.githooks/pre-commit](../../.githooks/pre-commit) launches that build in the background after every commit staging `lean/`, into `/tmp/lean_tree_build.log`, and refuses nothing. A file that fails to build is fixed in the committing session's next commit.

**A fresh clone must run `git config core.hooksPath .githooks` once.** Hook paths are local config and do not travel with the repository.

> **AND WHERE THERE IS NO TOOLCHAIN THE HOOK PASSES SILENTLY.** *It looks for `lake`, tries `$HOME/.elan/bin`, and exits `0` if it finds neither, there is nothing for it to enforce.* **So on a machine without Lean installed, an unchecked file commits clean and announces nothing**, which is the one configuration in which the layer's whole warrant is absent while every signal says it is present. **`lake` is usually NOT on `PATH`: it lives in `~/.elan/bin`, which is why the hook prepends that directory before looking.** *Check the way the hook checks, then settle it by running `PATH="$HOME/.elan/bin:$PATH" lake build` from [lean/](../../lean/).* **A bare `which lake` returning nothing is not evidence the toolchain is missing**, and reading it as such is how a layer that builds gets recorded as blocked.

> **AND A FILE THE ROOT DOES NOT IMPORT IS COMPILED ONLY WHEN NAMED.** *The build with no target checks the root's import closure and nothing else, so a new file passes every check it is given and is never given one: it type-checks when built individually, the hook reports OK, and its index row says the statement is machine-checked.* **So adding a file to the layer means adding it to the root import in the same change, and the witness is the default build's job count**, which moves only when the closure grows. *This is the toolchain failure's shape twice over: every signal reads as verified while nothing verified anything.*

## What a state names, and what it does not

**A state names what the FILE establishes, which on a numbered result is normally the lemma's arithmetic rather than its statement.** *`proved` means the file's own theorems are proved, not that the lemma is*, most `proved` rows here carry reductions, counts and constants, and [L133](../../lean/HamiltonsCubic/Results/L133.lean) is typical, with four theorems that are all ingredients and none the lemma. **So read a state as what it says and never as "the lemma is machine-checked".**

**The consequence is the one that matters: a route cannot be assembled from rows like these, because the composable objects are not there.** *Files being written is not statements being typed, and only the second composes.*

**A ROW WHOSE FILE CARRIES THE LEMMA'S OWN STATEMENT SAYS `statement: typed`, AND [structure-check](structure-check/check.py) COUNTS THEM.** *Without that marker the index cannot be read to tell whether a lemma is stated at all, which is how 164 results carried files while the route stayed uncomposable, invisible until someone asked.* **The count is reported and not enforced**, because the rule requiring the statement is younger than the layer and retro-fitting the backlog is work rather than a gate.

**Take a count of this layer two ways before reporting it.** *A count of rows matching `| L<n> |` misses every row naming its result as a link (155 of 175 in one census) and a headline built on the short count went into the index and was reported before anyone asked.*

## Reading a row against the record

**Build the statement and put it in the brief before reviewers are dispatched.** A brief that omits it sends readers at the prose alone, and the statement then goes unaudited, *a file written after its result was reviewed carries a docstring nobody read, which is how a refuted claim survives a passed Gate 2.*


**A statement that disagrees with the record is a finding; one that agrees settles the hypothesis question mechanically**, every binder being a hypothesis. **Triage before queueing**, most first refusals are the formalisation's fault, and one surviving re-statement gets a row in [plan-verification.md](../../plan-verification.md) at the top of tier 1.

## Editing this file

**An edit here follows [editing-skills](editing-skills/SKILL.md).** *A loop that starts explaining the layer again in its own words is the drift this file exists to prevent.*
