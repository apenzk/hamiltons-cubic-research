# Review r1054: L72Algebra, the r1053 fold, and the dedup repairs

**Scope**: `84c5e8e3` (L72Algebra.lean), `49e594c6` (the r1053 fold), `55d6a565` (the L15 dedup repairs plus `lean_open_audit.py`). SOLE reviewer. Analysis-only footing: the runs below are SCREENS on objects in hand, two four-line Lean probes against the built tree and a re-run of the audit script, reported as screens.

| # | claim | verdict |
|---|---|---|
| 1 | L72Algebra's three theorems are TRUE and are the record's argument | **CONFIRMED** on the mathematics and on every hypothesis, **but the file is REDUNDANT**: see claim 8 |
| 2 | the gap is named honestly | **PLAUSIBLE.** The gap is real and the division is stated before the claim, but *"which the layer does not carry"* is falsified by a grep in two places |
| 3 | non-vacuity | **CONFIRMED**, all three theorems, and `eq_of_rows` is non-trivial: `T ≥ 0` is load-bearing and a `T < 0` solution with `a ≠ b` exists |
| 4 | the r1053 fold | **PLAUSIBLE.** The substance is folded and the refutation is stated fully, but three residues r1053 named were left, and one overreach was introduced |
| 5 | W7 again | **CONFIRMED.** Every arithmetic value checks, and the restored boundary case is faithful to [r1052](REVIEW_r1052.md) paragraph 99 |
| 6 | the dedup repairs | **CONFIRMED** on every count, and the repair is COMPLETE |
| 7 | `lean_open_audit.py` does what it claims | **REFUTED.** Its only finding was a FALSE POSITIVE, and its premise that Lean ignores a dead open is false |
| 8 | overreach sweep | **one large item**: L72Algebra.lean is subsumed, over ℝ and sorry-free, by a theorem eight days older in the same directory |

---

## Claim 8 first, because it decides the round: the duplication, and the parent has the WRONG duplicate

**`eb0260cf` names [L72.lean](../lean/HamiltonsCubic/Results/L72.lean) as the file L72Algebra rebuilt. That is not the subsumer.** [L72.lean](../lean/HamiltonsCubic/Results/L72.lean) is stated entirely over **ℚ**: twelve type ascriptions, all `ℚ`, none `ℝ`. A rational-arithmetic decomposition does not establish the real statement, so against it L72Algebra.lean is a genuine strengthening and the withdrawal would be wrong.

**The real subsumer is [rows_force_spectrum](../lean/HamiltonsCubic/Results/L72Statement.lean) in [L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean), committed 2026-09-13, over ℝ, sorry-free.** Its signature:

```
theorem rows_force_spectrum {a b th T lam : ℝ} (ha : 0 < a) (hb : 0 < b) (hT : 0 ≤ T)
    (htr : lam = a + b) (hnorm : lam ^ 2 + a ^ 2 + b ^ 2 = 1)
    (hi : T * a * b = lam * (th - lam)) (hii : T * lam * b = a * (th + a))
    (hiii : T * lam * a = b * (th + b)) :
    a = b ∧ lam = 2 * a ∧ th = 3 * a ∧ T = 2 ∧ a = 1 / Real.sqrt 6 ∧ th = Real.sqrt (3 / 2)
```

**It takes the same hypotheses and returns strictly more.** Against L72Algebra's three theorems:

| L72Algebra | already in L72Statement, over ℝ |
|---|---|
| `eq_of_rows : a = b` | conjunct 1 of `rows_force_spectrum`, and `branch_split` + `second_branch_impossible` separately |
| `theta_eq_of_rows : th = 3 * a` | conjunct 3, **and it DERIVES `lam = 2 * a` where L72Algebra takes it as a hypothesis** |
| `scale_of_unit : a = 1 / √6` | conjunct 5, **and conjunct 6 adds `th = √(3/2)`, which L72Algebra never reaches** |
| nothing corresponding | conjunct 4, `T = 2`, which L72Algebra never reaches |
| the file has no non-vacuity statement | `witness_arithmetic`, which exhibits the satisfying tuple |

**So the round's `ready` item was not advanced.** [lean/INDEX.md](../lean/INDEX.md) row 325 marks L72Statement `ready` because of its **one `sorry`**, at line 214, on the passage from `IsCritical` to the three rows. That `sorry` is untouched and still at line 214 at HEAD. The commit message's *"what was owed was the formalisation and not the mathematics"* inverts it: the formalisation of the algebra was done, and what was owed is the geometric step the `sorry` covers.

**RECOMMENDATION: withdraw [L72Algebra.lean](../lean/HamiltonsCubic/Results/L72Algebra.lean), and correct the reason.** Delete the file, its import at [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) line 493 and its [lean/INDEX.md](../lean/INDEX.md) row 123, and record the withdrawal against **L72Statement.lean**, not L72.lean. **Keep L72.lean as it stands**: it is the ℚ-level decomposition plus `count_crosses` and `subset_gives_weaker`, which neither other file carries. *The three-files-per-id signal `eb0260cf` found is right; the file it points at is not.*

**Four smaller overreach items in the same commit message.**

- *"that division is stated BEFORE the claim, which is the correction to [I77PairCap]"* claims a new practice. [L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean)'s own docstring already carries a **"What is NOT typed here"** section naming both omissions, eight days earlier, so the practice is the file's own and not a correction learned from I77.
- **The factorisation is not the record's.** The block, and [L72.lean](../lean/HamiltonsCubic/Results/L72.lean)'s `branch_split`, take `a·(ii) − b·(iii)`, giving `(a-b)(θ(a+b) + a² + ab + b²) = 0` with **no `T` in the factor**. L72Algebra takes `(ii) − (iii)`, giving `(a-b)(θ + a + b + Tλ) = 0`. Both are valid and both reach `a = b`, but the docstring presents its own as the block's step.
- **The commit message and the theorem docstring disagree on the direction.** The message says *"subtracting the third row from the second"*, the `eq_of_rows` docstring says *"subtracting the second row from the third"*. Harmless, the product is zero either way, but one of the two is wrong in every reading.
- *"the open audit reports no new dead open"* is true and empty: [L72Algebra.lean](../lean/HamiltonsCubic/Results/L72Algebra.lean) contains **no `open` at all**.

## Claim 1, the mathematics: CONFIRMED, every step and every hypothesis

**The three rows in the docstring are quoted correctly** from [stratum-two-negative.md](../findings/stratum-two-negative.md)'s L72 block, character for character.

**`eq_of_rows` rebuilt by hand.** `(ii) − (iii)` gives `Tλ(b-a) = (a-b)(θ + a + b)`, so with `λ = a+b` the factorisation `hd` is exact and `linear_combination h3 - h2` discharges it. On the branch, `T(a+b) = -(θ+a+b)`, then `(a+b)θ = -(a²+ab+b²)` and `T(a+b)² = (a²+ab+b²) - (a+b)² = -ab`. With `T ≥ 0` and `ab > 0` that is a contradiction. **Correct.**

**`theta_eq_of_rows` rebuilt.** Cancelling `a > 0` in (ii) gives `2aT = θ + a`; (i) gives `Ta² = 2a(θ - 2a)`; combining, `θ + a = 4(θ - 2a)`, so `9a = 3θ`. **Correct**, and `T = 2` falls out of the same two lines but is not stated.

**`scale_of_unit` rebuilt.** `4a² + a² + a² = 1` is linear in the atom `a²`, so `a² = 1/6`, and `Real.sqrt_sq` with `a > 0` closes it. **Correct.**

**Every hypothesis is licensed by the record, and one is weaker than the record's.**

- **`hT : 0 ≤ T` is licensed and is a WEAKENING.** [conventions.md](../findings/conventions.md) line 61 states outright that `T_{abc} = c_{abc}²` with `c_{abc} = ⟨[v_a,v_b],v_c⟩` totally antisymmetric. So `T` is literally a square in the record's sense and nonnegativity is the weaker half. **Taking the weaker half is the right choice**, and it is why the file needs no separate `T = 0` case where the block does.
- **`hlam : lam = a + b` IS tracelessness and nothing stronger.** The spectrum is `(λ₁, -a, -b, 0, …)`, so `tr W = λ₁ - a - b`, and `tr W = 0` is exactly `λ₁ = a + b`. The record says so in the same sentence: *"using `tr W = 0`, i.e. `λ₁ = a+b`"*.
- **No sign hypothesis on `θ`**, which is what [LEDGER.md](../findings/LEDGER.md) line 1045 records as the block's route being stronger than a competing one. The file matches.
- **`hunit` is `Σλ² = 1` with `b = a`**, the record's unit norm.

**One difference from the block, in the file's favour.** The block needs a separate `T = 0` sub-case, killed by the pair (i) and (ii). `eq_of_rows` needs none: `T(a+b)² = -ab < 0` contradicts `T ≥ 0` including at `T = 0`. **But the docstring drops the recorded correction that goes with it**: [L72.lean](../lean/HamiltonsCubic/Results/L72.lean) and [L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean) both record that the block's *"`T=0` fails (ii)"* is FALSE, since (ii) with `T=0` gives the satisfiable `θ = -a`. L72Algebra quotes the block without that correction.

## Claim 2, the gap: PLAUSIBLE, the division is honest and the absence claim is not

**The honest half.** The docstring's *"What it takes as hypotheses, rather than deriving"* names all three, in the file, above the theorems, and the [lean/INDEX.md](../lean/INDEX.md) row repeats them. The gap is real: no lemma anywhere in [lean/](../lean/) expresses `⟨R# v_β, v_β⟩` in the eigenframe against the bracket tensor.

**The absence claim is falsified by a grep, in two places.**

- *"needs the criticality relation expressed in the bracket entry, **which the layer does not carry**"*. [Base/StructureSquare.lean](../lean/HamiltonsCubic/Base/StructureSquare.lean) **is** the base layer and **does** carry it: `sConst v a b c = inner2 (br (v a) (v b)) (v c)` at line 29 and `tSq v a b c = sConst v a b c ^ 2` at line 33, with `tSq_nonneg` at line 35. Its own docstring says *"the definition and its vanishing live here, in the base layer, where anything stating a bound about `T` has them in scope."*
- [L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean)'s version, *"needs `sharpOp` read in the eigenframe and the bracket tensor `T_{αβγ}`, **neither of which `WeylReal.lean` builds**"*, is wrong on `sharpOp`: [Base/WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) line 153 defines `sharpOp` outright.

**The correction, and it is a sharpening rather than a retraction.** Both `sharpOp` and `T_{αβγ}` exist. What is missing is the **eigenframe expansion connecting them**, a lemma of the shape `⟨sharpOp R (v β), v β⟩ = Σ_{α,γ} tSq v α β γ · lam α · lam γ`. *`tSq` currently has no consumer anywhere outside its own file*, which is the fact worth recording: the tensor is defined and unused. Write the gap as that missing lemma.

## Claim 3, non-vacuity: CONFIRMED, and `eq_of_rows` is not trivially true

**All three theorems are satisfiable with `a, b > 0`**, at the L72 point itself: `a = b = 1/√6`, `λ = 2/√6`, `θ = 3/√6`, `T = 2`. Checked by hand against all three rows: (i) `Tab = 2·(1/6) = 1/3` and `λ(θ-λ) = (2/√6)(1/√6) = 1/3`; (ii) `Tλb = 2·(2/√6)(1/√6) = 2/3` and `a(θ+a) = (1/√6)(4/√6) = 2/3`; (iii) by symmetry. Unit norm `4/6 + 1/6 + 1/6 = 1`. **Nothing is vacuous.** *[L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean)'s `witness_arithmetic` already states exactly this, typed.*

**And `eq_of_rows` has content: `hT` is load-bearing.** Drop it and the conclusion fails. Take `a = 1`, `b = 2`, `λ = 3`, `θ = -7/3`, `T = -2/9`. Then (ii): `Tλb = (-2/9)(3)(2) = -4/3` and `a(θ+a) = -4/3`. (iii): `Tλa = -2/3` and `b(θ+b) = 2(-1/3) = -2/3`. **Both rows hold with `a ≠ b`.** So the second branch is genuinely populated over ℝ and is killed by nonnegativity alone, exactly as the block says.

## Claim 4, the fold: PLAUSIBLE

**The three aggregations are CORRECT, and I rebuilt them rather than reading r1053's.** With `T` totally symmetric and hollow, sum [Lemma L31](../findings/stratum-two-negative.md)'s `Σ_γ T_{αβγ} ≤ 2` over each part of the ordered pair set. For a triple with `j` indices in `A`, count which of its six orderings have their first two entries in the named part: for the `AA` part, `6/6` of a `j=3` triple and `2/6` of a `j=2` triple, giving `t₃ + ⅓t₂ ≤ 2s(s-1)`; for the mixed part, `4/6` of `j=2` and `4/6` of `j=1`, giving `⅔(t₁+t₂) ≤ 4sp`; for `BB`, `6/6` of `j=0` and `2/6` of `j=1`, giving `t₀ + ⅓t₁ ≤ 2p(p-1)`. **Their sum is `Σt_j ≤ 2[s²-s+2sp+p²-p] = 2N(N-1)`**, the parent's single inequality exactly.

**The violation is CONFIRMED by exact arithmetic.** At `n = 12`, `N = 66`, the low-branch vertex has `t₂ = 0`, so the first constraint reads `t₃ ≤ 2s(s-1)`. At `s = 6` the record carries `t₃ = 120` against `2·6·5 = 60`. **Infeasible.** The binding window is right too: `2(n-2)s ≤ 2s(s-1)` is `s ≥ n-1`, so it binds for `s ≤ n-2`, and at `s = 11` the two sides are equal at `220`, tight rather than violated. **And the `{1,3}` vertex is slack on all three**: at `n=12`, `s=30`, `t₃ = 240 ≤ 1740`, `⅔·1080 = 720 ≤ 4320`, `360 ≤ 2520`.

**Three residues r1053 named, left behind by the fold.** *All three are since repaired by `eb0260cf`, which reached them independently; they are recorded here because they belong against the commit in scope.*

- The dangling *"The struck text is kept below so the claim and its refutation are read together"* survived at [diagonal-half.md](../findings/diagonal-half.md) line 1403 with nothing struck below, which is r1053's item 4 verbatim.
- [plan.md](../plan.md) lines 73 and 127 still read *"the PAIR CAP alone remains untried"* while line 125 read *"the pair cap BINDS"*. One file, one object, two answers.
- A **dead link**, `[the successor paragraph](#)`, introduced by the fold itself.

**Two things r1053 established that the fold did not carry.**

- **The screen's number is unhedged in [plan.md](../plan.md).** [diagonal-half.md](../findings/diagonal-half.md) hedges it correctly (*"Screened by r1053 in exact rationals"*), but the plan row states `2.42212` flat. r1053 said in terms that it *"needs a Gate 2 round of its own, since the number above is a screen rather than evidence"*, and the plan is where a next cycle reads its target.
- **`t₃ = 2(n-2)s` on the low branch is asserted without derivation.** It reproduces the record's one printed point (`120` at `n=12`, `s=6`, with `t₀ = 1320-120 = 1200` matching too), but the general formula is r1053's and the fold repeats it as if the record held it.

**One correction to r1053, in the fold's favour.** r1053 charged the I77 row with silently dropping the MOMENT PROBLEM route. **[plan.md](../plan.md) line 127 still names it**, *"The moment-problem form, the ten types, both errors this item has already made and both repairs are in [diagonal-half.md]'s I77 block"*, so the plan never lost the route and the fold was right not to re-add it.

**One thing both r1053 and the fold understate.** Four paragraphs above the corrected block, [diagonal-half.md](../findings/diagonal-half.md) already carries [r864](REVIEW_r864.md)'s repair, which turns **these same three part-sums** into exact equalities under `A`-regularity and gets `θ ≤ (2/n)√(sN/(N-s))` over `n/2 ≤ s ≤ n(n-2)/4`, **whose maximum is `θ₀(n)` EXACTLY**, that is `1.23603` at `n = 12`. The fold's headline `2.42212` is a far weaker consequence of the same caps, and *"the pair cap is the one addition in this paragraph that WORKS"* is written as if the working version were new. **The two live under different hypotheses** (inequalities against `A`-regular equalities), so neither replaces the other, but the plan's `Owed: that bound derived and typed` should say which of the two it means.

## Claim 5, W7: CONFIRMED

**Every number checks**, from [L2.lean](../lean/HamiltonsCubic/Results/L2.lean)'s `sphereProductSq n p q = 2(n-1)(p-1)(q-1)/((n-2)pq)`:

| quantity | recomputed | W7 |
|---|---|---|
| `S⁵×S⁷` at `n=12` | `√(2·11·4·6/(10·5·7)) = √1.5085714 = 1.2282390` | `1.2282390` |
| `√(3/2)` | `1.2247449` | `1.2247449` |
| `θ₀(12)` | `√(220/144) = 1.2360331` | `1.2360` via F43 |
| `θ₀(6)` | `√(40/36) = 1.0540926` | `θ₀(6)` |
| `S³×S³`, Jensen's second | `√(6/5) = 1.0954451 > 1.0540926` | dies at `n=6` |

**The boundary case is faithful to [r1052](REVIEW_r1052.md).** Its paragraph 99 reads *"The only genuinely informative case is the boundary, `θ = θ₀(n)` exactly with `s ≥ 3`, which is precisely the `ℂP³` shape and which nothing on the record excludes at `n ≥ 12`."* W7 now carries it with `s ≥ 3`, `n ≥ 12`, the `ℂP³` shape and the exclusion clause, attributed. **Restored correctly.**

**The overreach r1053 flagged is gone.** *"NO RESTRICTION TO `n ≥ 12` RESCUES IT"* is replaced by *"what would kill it is not yet a witness"* with F43's realisability named open and [I24a](../plan.md) named as the decider. **No new overreach.**

**Two small things.**

- **`(30,20,16)` is called a spectrum and is a MULTIPLICITY vector.** [post F43](../findings/bounds-relaxations.md) says *"the `n=12` spectrum with multiplicities `(30,20,16)` and values `(-m, 1.2m, 0.375m)`"*. The multiplicities sum to `66 = N`. *Inherited from [r1052](REVIEW_r1052.md)'s own correction text, so it is the record's habit rather than this commit's slip, but it is worth fixing where it appears.*
- **The half of [r1052](REVIEW_r1052.md) paragraph 99 that is still unfolded** is its first reason: that a realised `n ≥ 12` point above `θ₀(n)` would refute Conjecture A outright, so the *absence* of a strict witness is the conjecture being open rather than evidence for the candidate. W7 gestures at it; the logical point is not written anywhere.

## Claim 6, the dedup repairs: CONFIRMED on every count, and COMPLETE

| check | result |
|---|---|
| diff stat per file | `3 1` each, i.e. **+3 −1**, not the message's **+4 −1** |
| `sorry` count before and after | **1 and 1** in each of the three, verified at `55d6a565^` and `55d6a565` |
| any proposition changed | **none.** The only changed line in each file is the `open` line, plus a two-line comment |
| is `HamiltonsCubic.AltLayer` the right namespace | **yes.** [Base/AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean) line 96 declares it, and `altCoeff` (line 378) and `altNormSq` (line 440) are inside it |
| other files reaching those names | **five**, and all five are fine |

**The completeness check, in full.** The users of `altNormSq`/`altCoeff` are [I36DiagTest.lean](../lean/HamiltonsCubic/Results/I36DiagTest.lean), [L15Statement.lean](../lean/HamiltonsCubic/Results/L15Statement.lean), [Base/BianchiSym.lean](../lean/HamiltonsCubic/Base/BianchiSym.lean), [Base/AltAntisym.lean](../lean/HamiltonsCubic/Base/AltAntisym.lean) and the three repaired files. [AltAntisym.lean](../lean/HamiltonsCubic/Base/AltAntisym.lean) declares `namespace HamiltonsCubic.AltLayer` itself, so it is in-namespace; [I36DiagTest.lean](../lean/HamiltonsCubic/Results/I36DiagTest.lean) line 35 already opens `HamiltonsCubic.AltLayer` directly and was never broken. **There is also no `export` anywhere under [lean/HamiltonsCubic/](../lean/HamiltonsCubic/)**, so no file reaches the names by re-export. *The `+4 −1` is the one inaccuracy and it is a miscount of the parent's own diff.*

## Claim 7, the audit script: REFUTED

**Its only finding was a false positive, and it was the finding the commit reported.** `HamiltonsCubic.RealLayer.OperatorNorm` **is declared**, at [Base/Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) line 798, as `namespace OperatorNorm` nested directly inside `namespace HamiltonsCubic.RealLayer` (line 33). **`section Fermat` at line 778 is a SECTION and contributes no name**, so the declared namespace is exactly `HamiltonsCubic.RealLayer.OperatorNorm`. The scan missed it because `re.match(r"namespace (HamiltonsCubic[A-Za-z0-9_.]*)", line)` requires the prefix written out at line start. **Two other nested declarations are invisible the same way**, `namespace SymTri` in [L192Statement.lean](../lean/HamiltonsCubic/Results/L192Statement.lean) and `namespace CP2` in [Base/Families.lean](../lean/HamiltonsCubic/Base/Families.lean).

**And the opens it flagged are LOAD-BEARING.** Both [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) line 189 and [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) line 59 write `open scoped HamiltonsCubic.RealLayer.OperatorNorm`, which is what brings the `noncomputable scoped instance : NormedAddCommGroup (CurvOp2 ι)` at line 800 into scope. Removing them on the audit's advice would break the tree.

**So *"exits non-zero on a dead open, so it is gate-ready"* is exactly backwards.** Wired as a gate against the commit's own version, it fails the green tree on its only finding, in perpetuity. *`scripts/INDEX.md` line 416 repeats the false claim as* "One is live, `RealLayer.OperatorNorm` in two files."

**The premise of the whole DEAD OPEN category is also false.** **SCREEN** (four lines of Lean against the built tree, seconds, reported as a screen): `open HamiltonsCubic.NoSuchNamespaceAtAll` produces

```
error: unknown namespace `HamiltonsCubic.NoSuchNamespaceAtAll`
```

**and the `open scoped` form is equally strict**, probed the same way:

```
error: unknown namespace `HamiltonsCubic.AlsoNotARealNamespace`
```

**Lean does not ignore a dead open. It refuses it, in both forms.** The docstring's *"Lean ignores it, so the file compiles and reads as if the open were meaningful"* is false, and so is the harm it describes, *"if anyone later creates that namespace the file changes meaning with no edit"*: the file does not compile today, so nobody can later create anything. **A green tree cannot contain a dead open at all**, which makes the DEAD OPEN category empty by construction and the check's first half capable only of false positives. *This is the finding, and the rewritten script on disk repairs the symptom while keeping the category.*

**Three further false negatives in `--ns`, none currently firing but all reachable.**

- **A relative open is invisible.** Inside `namespace HamiltonsCubic`, `open L15Statement` resolves to `HamiltonsCubic.L15Statement`, but the `re.findall(r"HamiltonsCubic\.[A-Za-z0-9_.]+")` requires the literal prefix. *No file does this today: every `^open ` line without the prefix opens a Mathlib namespace.*
- **A fully qualified reference needs no open.** A file writing `HamiltonsCubic.L15Statement.altNormSq` breaks on the same deletion and `--ns` never sees it.
- **Basenames collide.** The scan stores `f.name`, so two files of the same name in different directories are indistinguishable in the output.

**And the docstring overclaims what `--ns` returns.** *"Run it BEFORE deleting a definition, with `--ns`, to list the files that would break"* is a superset: it returns the files that **open** the namespace, which is what the script's own printed line honestly says (*"would lose any name removed from it"*). That the three matched exactly for L15Statement is a coincidence of that case.

**STATE AT REPORT TIME.** [lean_open_audit.py](../scripts/misc/lean_open_audit.py) has since been rewritten on disk, uncommitted, with a stack-tracking scan that treats `section` as a non-namespace; it now reports **no dead opens** and exits 0. **That repairs the false positive.** The remaining items above stand against the new version too: the DEAD OPEN category's premise, the `--ns` superset claim, relative opens, fully qualified references and basename collisions.

## What a successor should do first

1. **Withdraw [L72Algebra.lean](../lean/HamiltonsCubic/Results/L72Algebra.lean)**, with the reason recorded against **[L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean)'s `rows_force_spectrum`**, over ℝ and sorry-free, and **not** against the ℚ-valued [L72.lean](../lean/HamiltonsCubic/Results/L72.lean). Keep L72.lean.
2. **Rewrite the L72 gap as the missing lemma it is**: `⟨sharpOp R (v β), v β⟩` expanded in the eigenframe against `tSq`. Both `sharpOp` and `tSq` exist; the bridge does not, and `tSq` has no consumer today.
3. **Drop the DEAD OPEN category outright** and keep `--ns`, which is the half that found the real breakage. Both `open` and `open scoped` on an absent namespace are hard Lean errors, so the category is empty in any green tree and every report it can produce is a false positive. *The rewritten script on disk fixes the nesting bug and keeps the category, so this is still owed.*
4. **Hedge `2.42212` in [plan.md](../plan.md)** as r1053's screen, and say whether the `Owed` bound is that one or [r864](REVIEW_r864.md)'s stronger `θ₀(n)` route four paragraphs above it in the same file.
