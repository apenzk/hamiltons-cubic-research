# Review r1036, the axiom audit tool against the behaviour it asserts

**Reviewer r1036, cold on the six changes of 2026-09-21 to [axiom_audit.py](../scripts/misc/axiom_audit.py).** Every claim below was re-derived from the sources, from Lake 4.33.1's own source, or from a probe elaborated with `lake env lean`. Log: [r-audit-tool.log](../agent_logs/r-audit-tool.log).

| # | change | verdict |
|---|---|---|
| 1 | [REPORT](../scripts/misc/axiom_audit.py#L100) anchored with `MULTILINE` | **CONFIRMED**, mechanism reproduced on a synthetic stream |
| 2 | [NAME_OK](../scripts/misc/axiom_audit.py#L106) refuses whitespace | **PLAUSIBLE but inert.** It can never fire, so a clean run is no evidence |
| 3 | `lake env lean` rather than `lake build` | **CONFIRMED**, the replacement reason holds and is verified from Lake's source |
| 4 | [DECL](../scripts/misc/axiom_audit.py#L67) no longer matches `private` | **CONFIRMED as to its stated reason**, and it is a hole: an unconsumed private theorem now hides completely |
| 5 | `/- ... -/` blocks skipped | **CONFIRMED**, 19 names removed, every one a prose fragment, no real declaration dropped |
| 6 | the banner compares DISTINCT names | **REFUTED.** The stated reason is false, and the change silenced a correct alarm |
| the count | is the reported 3 correct? | **CONFIRMED**, by an independent route |

## The headline: change 6 silenced the symptom of a live bug

**All seven "fully-qualified names declared in more than one file" are artifacts of a name-truncation bug in [DECL](../scripts/misc/axiom_audit.py#L67).** Not one of them is a name genuinely declared twice.

[DECL](../scripts/misc/axiom_audit.py#L67)'s name group is `([A-Za-z_][A-Za-z0-9_'!?₀-₉]*)`, which **excludes the dot**. A declaration written as `theorem IsWeylOf.add ...` is therefore collected as `HamiltonsCubic.Base.IsWeylOf`, the name of the *structure*, and the theorem itself is never asked about. There are **27 such lines in the layer, collapsing onto 17 distinct prefixes**, which is 10 repeated entries. That is exactly the "ten lost declarations that were never lost".

| name collected | times | what it really is |
|---|---|---|
| [HamiltonsCubic.Base.SupportedIn](../lean/HamiltonsCubic/Results/L30.lean#L33) | 3 | a `def`, standing in for `.mul`, `.bracket`, `.add` |
| [HamiltonsCubic.L148Statement.IsCoordDiagonal](../lean/HamiltonsCubic/Results/L148Statement.lean#L129) | 4 | a `def`, standing in for `.zero`, `.add`, `.smul`, `.affine` |
| [HamiltonsCubic.Base.IsSkew](../lean/HamiltonsCubic/Base/RoundTrip.lean#L19) | 2 | a `def`, standing in for `.diag_zero`, `.swap` |
| [HamiltonsCubic.Base.IsWeylOf](../lean/HamiltonsCubic/Results/L34.lean#L52) | 2 | a `def`, standing in for `.add`, `.neg` |
| [HamiltonsCubic.L129Statement.IsPure](../lean/HamiltonsCubic/Results/L129Statement.lean#L282) | 2 | a `def`, standing in for `.isHermitian`, `.trace_eq_zero` |
| [HamiltonsCubic.L98Statement.DiagFloorExact](../lean/HamiltonsCubic/Results/L98Statement.lean#L298) | 2 | a `def`, standing in for `.sInf_eq`, `.strong_reading` |
| [HamiltonsCubic.RealLayer.IsSelfAdjoint2](../lean/HamiltonsCubic/Results/PhiTri.lean#L371) | 2 | a `def`, standing in for `.isAdjoint2`, `.compOp2` |

**The substitution is invisible to every other guard in the tool.** The prefix resolves, because the `def` exists, so `#print axioms` answers and the entry lands in the `clean` bucket. Nothing comes back unknown, so [lost](../scripts/misc/axiom_audit.py#L297) stays empty. Probed live:

```
'HamiltonsCubic.Base.IsSkew' depends on axioms: [Quot.sound]
'HamiltonsCubic.Base.IsSkew.diag_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The first is what the audit asks. The second is the theorem, and it is asked about nowhere.

**What this does to the numbers the layer reports.** A live run today gives `5368/5444 clean`, with `auditing 5454 declarations` on the line above it.

- **17 of the 5444 audited entries are definitions, not theorems.** They cost nothing to prove and their presence in a "clean" count is meaningless.
- **27 public theorems are audited nowhere.** I asked about all 27 directly and every one is clean on the standard three, so the reported 3 survives. That is luck, not design: nothing in the tool would have reported it otherwise.
- **The true public theorem count is 5454, of which 5427 are audited.** The tool's two printed totals, 5454 and 5444, are both wrong and disagree with each other by exactly the truncation excess.

**The fix is one character.** Admit the dot in [DECL](../scripts/misc/axiom_audit.py#L67)'s name group, so it reads `([A-Za-z_][A-Za-z0-9_.'!?₀-₉]*)`. Then the 27 are asked about under their own names, the 17 phantom entries disappear, the duplicate count drops to zero and the length comparison the banner used to make becomes correct again on its own terms.

## Change 1, the anchored REPORT regex: CONFIRMED

**The failure mode reproduces exactly.** Screened on a three-line stream carrying one linter warning with an apostrophe in it, followed by two genuine reports:

| regex | names captured |
|---|---|
| the old `'(.+?)'` under `DOTALL` | `s type is unused\n'HamiltonsCubic.Base.a`, `HamiltonsCubic.Base.b` |
| the current `^'([^\n]+?)'` under `MULTILINE` | `HamiltonsCubic.Base.a`, `HamiltonsCubic.Base.b` |

The old form does two things at once, and the second is the worse: it **fabricates** an entry whose key is a block of log, and it **loses** the real report that the fabricated match swallowed. A caller reading `clean/total` saw both a garbage row and a smaller total. The specific figure in the docstring, 130 of 5437, cannot be checked retrospectively because the run's raw output was not kept, and today's run emits no warnings at all, so the fault would not reproduce on the current tree. The mechanism is exact and the fix addresses it.

## Change 2, NAME_OK: PLAUSIBLE, and it can never fire

**The guard is correct about Lean and unreachable in this pipeline.** Two independent reasons:

- With change 1 in place, group 1 is `[^\n]+?` anchored to a line start, and under `lake env lean` the only lines beginning with `'` are genuine `#print axioms` reports. Build diagnostics all carry a `file:line:col:` prefix, verified on a live run.
- A name containing whitespace requires guillemets, `«a b»`. [DECL](../scripts/misc/axiom_audit.py#L67)'s name group cannot capture a guillemet at all, so such a declaration is never asked about, and there are none in the layer in any case (`grep` for `«` over `lean/` returns nothing).

**So the `REFUSED n matches` line is dead code, and its silence carries no information.** That matters for how a reader treats a clean run: the absence of that message is currently read as "no build output reached the parser", when it is really "this check cannot report anything". If the layer ever did adopt a guillemet name, [NAME_OK](../scripts/misc/axiom_audit.py#L106) would still not fire, because [DECL](../scripts/misc/axiom_audit.py#L67) would have skipped the declaration silently first. The whitespace fault class is guarded at the wrong end.

## Change 3, lake env lean: CONFIRMED, the replacement reason holds

**Both halves check out.**

`lake env lean` does not prefix. Verified on a live probe: the `#print axioms` lines come back at column zero as `'name' depends on axioms: [...]`, while errors from the same run carry `R1036Probe.lean:35:14: error(...)`.

`lake build` does prefix, and the regex would genuinely fail. From Lake 4.33.1's own source, [Lake/Util/Log.lean](file://~/.elan/toolchains/leanprover--lean4---v4.33.1/src/lean/lake/Lake/Util/Log.lean):

```
LogEntry.toString  =  s!"{self.level}: {self.message}"
LogEntry.ofSerialMessage  sets  message := mkErrorStringWithPos msg.fileName msg.pos str none
```

and [Lean/Message.lean:31](file://~/.elan/toolchains/leanprover--lean4---v4.33.1/src/lean/Lean/Message.lean) ends `mkErrorStringWithPos` with `s!"{fileName}:{pos.line}:{pos.column}{endPos}:{label} {msg}"`. So a report reaches the terminal as `info: <path>:<line>:<col>: 'name' depends on axioms: [...]`. Screened against the current regex: zero matches on two such lines. The coupling the docstring describes is real, and it is the whole reason the runner cannot be swapped back.

**One consequence the docstring states and a reader should hold on to.** `lake env lean` elaborates against the oleans already on disk, so every verdict is as current as the last build of the tree and no more. The tool cannot tell a caller that the tree is stale.

## Change 4, dropping `private`: CONFIRMED as stated, and a hole

**The stated reason is true, tested on a real private theorem of the layer.** `#print axioms HamiltonsCubic.L133Statement.sqrt220_lb` from an importing module returns ``Unknown constant `HamiltonsCubic.L133Statement.sqrt220_lb` ``. The declaration's real name is mangled to `_private.<Module>.0.<Namespace>.<name>`, and that form cannot even be written in Lean source, since the parser breaks at the `.0.` component. So the 24 private theorems were genuinely producing 24 lost entries before the change.

**Taint does reach the report through a public consumer.** Constructed and run:

```lean
private theorem hidden_sorry : (1 : Nat) = 2 := by sorry
theorem public_user : (1 : Nat) = 2 := hidden_sorry
#print axioms R1036.public_user   -- 'R1036.public_user' depends on axioms: [sorryAx]
```

Privateness is a naming discipline, so the elaborated term carries the dependency regardless, and the axiom set is computed on the term.

**The hole is the unconsumed private theorem, and it is demonstrated rather than argued.** A `private theorem dead_sorry` in the same probe, used by nothing, appears in no report at all: it is not asked about, it produces no lost entry, and its `sorryAx` is reported nowhere. **A private theorem is only covered while something public uses it.** The audit therefore certifies a layer under a condition it never checks.

**The current exposure is one declaration and it is clean.** Of the 24 private theorems, 23 are used within their own file. The exception is [symOp_mem_long](../lean/HamiltonsCubic/Results/WeylRadical.lean#L84), a long alternative proof of [symOp_mem](../lean/HamiltonsCubic/Results/WeylRadical.lean#L81) kept for the record and used by nothing. Its proof is ordinary tactic work with no `sorry` and no `native_decide`, so nothing hides today.

**Replace the drop with a qualification.** Mathlib's `open private <name> from <Module> in` makes the mangled constant addressable, and the generated module already imports the module in question. That restores the 24 to the audit under their own names and closes the unconsumed case. Until then the docstring should say that the coverage claim is conditional on a public consumer, because as written it asserts the taint "still reaches the report" without the qualifier that makes it true.

## Change 5, skipping comment blocks: CONFIRMED

**Measured both ways over all 542 files.** With the skip: 5444 distinct names. Without it: 5463, and the 19 extra names are every one a prose fragment.

```
HamiltonsCubic.FamilyLayer.about   <- "theorem about a named object", because the layer could not build the family.
HamiltonsCubic.L114.at             <- "theorem at the complementary block, with the slot symmetries used to..."
INSIDE                             <- "lemma INSIDE it.* **The constraint set ..."
```

**No real declaration is dropped.** The set difference in the other direction, names present with the skip but absent without it, is **empty**, so the skip removes only what it was written to remove.

**The three over-skip shapes the brief names were each checked.**

- A one-line docstring `/-- ... -/` is handled, because [BLOCK_OPEN](../scripts/misc/axiom_audit.py#L78) matching is guarded by `and not BLOCK_CLOSE.search(line)`, so the line opens and closes in one step and `in_block` stays false.
- Nesting `/- /- -/ -/` would close early and expose the outer block's remaining lines to the parser. That direction **adds** phantom names rather than dropping real ones, it is caught by the banner when it happens, and the layer contains no such nesting.
- A block whose terminating `-/` is followed by more text on the same line would swallow the rest of the file. Every real declaration is accounted for, so this does not occur in the layer, and it remains the shape a future file could trip on.

## Change 6, the banner: REFUTED

**`lost` is computed against the right set. The reason given for making the change is false.**

The set arithmetic itself is sound: `asked_names = set(decls)` against `set(found)` compares like with like, where the previous `len(decls)` against `len(found)` compared a list with a dict. The defect is the diagnosis attached to it. **There are no fully-qualified names declared in more than one file.** All seven are the truncation artifacts tabulated at the top, and the "ten lost declarations that were never lost" were the tool's only signal that 27 theorems were falling out of the audit. Deduplicating removed the signal and left the cause in place.

**On the second half of the question, a declaration can indeed come back under a different name and count as lost.** That is precisely what private declarations do: asked as `Ns.name`, they answer as `_private.<Module>.0.Ns.name`, which is what change 4 was reacting to. Unicode normalisation is not a live route here, since every asked name is built from source bytes that Lean reads from the same file. The general point stands: `lost` measures "the printed name differed from the asked name" and reports it as "not audited", and those are different facts.

**A stronger banner is available at no cost.** Compare `set(found)` against `asked_names` in **both** directions. A name in `found` that was never asked about is exactly the private-mangling signature, and a repeated entry in `decls` is exactly the truncation signature. Both are one line and neither can be silenced by a name that happens to resolve.

## Is the reported 3 correct? CONFIRMED

**Established independently of the script, and it agrees.**

- `grep` for a real `native_decide` invocation over all 542 files returns **three sites**: [RelationB.lean:58](../lean/HamiltonsCubic/Base/RelationB.lean#L58), and [L199Statement.lean:95](../lean/HamiltonsCubic/Results/L199Statement.lean#L95) and [:103](../lean/HamiltonsCubic/Results/L199Statement.lean#L103). Every other occurrence of the string is prose in a docstring recording a use that was retired.
- Those three sites close exactly [WCP2_sharp_one](../lean/HamiltonsCubic/Base/RelationB.lean#L58), [Gmat_diagTest_ne_zero](../lean/HamiltonsCubic/Results/L199Statement.lean#L94) and [G_eq_sharp_diagTest_00](../lean/HamiltonsCubic/Results/L199Statement.lean#L101), the three names the tool reports.
- **None of the three has a consumer.** `grep` over the layer finds every other mention of all three names to be inside a comment. So the transitive closure adds nothing and 3 is the whole of it.
- The 27 theorems the truncation bug hides were asked about directly and are **all clean**, so the bug does not conceal a fourth.
- The 24 private theorems live in files that contain no `native_decide` at all, and 23 of them have a public consumer that would carry the taint if they did.

**The three is right. The 5444 and the 5368 are not**, and neither is the `auditing 5454 declarations` line, which counts a list that contains ten duplicates of names that should not exist.

## Two operational notes

**The generated module sits inside the tree the orphan gate scans.** [axiom_audit.py](../scripts/misc/axiom_audit.py) writes `lean/HamiltonsCubic/AxiomAudit.lean`, which is not imported from [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), so while a run is in flight [lean_orphans.py](../scripts/misc/lean_orphans.py) refuses every commit in every session. The `finally` clause deletes it on a clean exit and on an exception, and it survives a `SIGKILL`, a full disk, or `--keep`. **Writing it to `lean/AxiomAudit.lean` instead removes the interaction entirely**, and `lake env lean` elaborates it equally well from there, which is how my own probe was run after the coordinator flagged the same collision.

**The gate's other wedge is any reviewer probe under `lean/HamiltonsCubic/`.** My first probe landed there and blocked the parent session's commits. Any file a reviewer, a hook, or an editor's autosave leaves under that directory does the same, including a `.lean.bak` or a conflicted copy, since the scan keys on the directory rather than on git tracking. **Restricting the gate to git-tracked files would keep its purpose and stop it from blocking on scratch.**

## Analysis-only rule

**The rule was given to me in the brief and I honoured it.** Everything here is either static analysis of the script against the sources, reading Lake and Lean's own source for the message format, or a run that finishes in seconds to a few minutes on objects already in hand.

- **Runs made**: one full `axiom_audit.py`, about three minutes, which the brief names as permitted; three single-file `lake env lean` probes of a few seconds each; and four Python passes over the 542 source files, under a second each.
- **Screens, reported as screens**: the regex comparison on a synthetic three-line stream, and the `lake build` prefix shape checked against a synthetic line rather than against a real `lake build`, which the brief forbids.
- **Nothing open-ended was started.** No sweep, no census, no search for a falsifier without a bound. Every run above had a cost I could state in advance and a fixed thing it would decide.
- `lake build` was never run, and the probe files were deleted at the end of the phase that used them.
