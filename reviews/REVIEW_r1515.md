# Review r1515: r1513's repair, L44 back to partial and L157's uniqueness and second root proved (commit d7595c2f)

*Gate 2, one reviewer, Lean layer. Subject: commit d7595c2f, which answers [REVIEW_r1513.md](REVIEW_r1513.md) with two new theorems in [L157Statement.lean](../lean/HamiltonsCubic/Results/L157Statement.lean), `unique_root` and `other_root_is_root`, and edits to the L125, L157, L44, L37 and L36 rows of [lean/INDEX.md](../lean/INDEX.md), to rows 36, 37, 44 and 157 of [INDEX-results.md](../findings/INDEX-results.md) and to STATUS.md's count. Analysis only: one build and one axiom audit (run twice) were run, nothing numerical.*

| item | claim | verdict |
| --- | --- | --- |
| A | `unique_root` and `other_root_is_root` state the box's *"unique root in (0,1)"* and *"the other root being its reciprocal and spurious"* faithfully, and prove them soundly | **CONFIRMED** |
| L44-1 | the L44 main row reads partial and owes the cone conclusion, and INDEX-results row 44 and STATUS.md follow | **CONFIRMED WITH GAP** |
| L44-2 | the claim that the elementary route replaces the padding map is gone, and `hwitness` is named as the carrier | **CONFIRMED** |
| L157-1, L157-2 | uniqueness in (0,1), and the reciprocal being a root above 1, are typed | **CONFIRMED** |
| L157-3 | the main row reads partial, owing the derivation of the two branches from the reach problem | **CONFIRMED WITH GAP** |
| L36-1, L37-2 | INDEX-results rows 36 and 37 read proved, agreeing with lean/INDEX.md | **CONFIRMED** |
| L36-2 | the cap is named `L36Proof.cap` | **CONFIRMED** |
| L37-1 | the corollary's n-dimensional subspace is placed at a diagonal W | **CONFIRMED WITH GAP** |
| D-1, D-2 | the semicolon splices in the L125 and L37 rows are split | **CONFIRMED** |
| C | style of the changed rows and docstrings | **CONFIRMED** |

**Summary: the two new theorems are faithful and sound, every r1513 gap is repaired in the main rows it was cited against, and three statement rows next to them still carry the old claims, the sharpest being L44's statement row, which reads proved and says the elementary route *"delivers the conclusion outright"* beside a main row that now owes that conclusion.**

## A. The new L157 theorems

- Record box ([second-order.md:2116](../findings/second-order.md)): *"they cross at the unique root in (0,1) η\*(t) = (2t+1-√(4t+1))/(2t), the other root being its reciprocal and spurious"*. The crossing η = t(1-η)² is, after expansion, tη² - (2t+1)η + t = 0, which is exactly the hypothesis `hη` of `unique_root` and the equation of `etaStar_root`.
- `unique_root` ([L157Statement.lean:116](../lean/HamiltonsCubic/Results/L157Statement.lean)): for t > 0 and any η with 0 < η < 1 solving the quadratic, η = η\*(t). This is the uniqueness half the box asserts, over the same parameter range the file uses throughout (t a free positive real). Faithful.
- Proof: the identity t(η - η\*)(ηη\* - 1) = η\*·q(η) - η·q(η\*) holds by expansion (both sides reduce to tη²η\* + tη\* - tηη\*² - tη, checked by hand), so the product vanishes. t ≠ 0 disposes of the first factor, and ηη\* = 1 is impossible with both factors in (0,1), which is what the closing `nlinarith` has from `h0`, `h1`, `e0`, `e1`. Sound.
- `other_root_is_root` ([L157Statement.lean:105](../lean/HamiltonsCubic/Results/L157Statement.lean)): 1/η\* solves the same quadratic and exceeds 1. The root half is `etaStar_root` divided through by η\*², which is the palindromic symmetry, and the bound is `lt_div_iff₀` from η\* < 1. With `other_root` (line 87), which identifies 1/η\* with (2t+1+√(4t+1))/(2t), the box's *"reciprocal"* and *"spurious"* (outside the unit interval) are both now stated. Sound.
- **A value satisfying the hypotheses**: t = 2, η = 1/2. Then 2·¼ - 5·½ + 2 = 0, and η\*(2) = (5 - √9)/4 = ½, as `unique_root` demands. The other root is 2 > 1. A second check: t = 6 gives √25 = 5, η\* = (13 - 5)/12 = ⅔, and 6·(4/9) - 13·(2/3) + 6 = (8 - 26 + 18)/3 = 0, with reciprocal 3/2 > 1.
- Build: `lake build HamiltonsCubic.Results.L157Statement` completed successfully (8706 jobs). The only warning is the missing closing `end L157` / `end HamiltonsCubic`, present in the parent commit as well, so no regression.
- Audit: the first run of `axiom_audit.py --only L157Statement` returned all 14 declarations unparsed (AUDIT INCOMPLETE), run immediately after the build. The rerun gave **14/14 clean on the standard three axioms**, `unique_root` and `other_root_is_root` included. The first run's failure reads as a transient of the audit script, not of the file.

## B. The r1513 gaps

### L44

- **L44-1, main rows: repaired.** The main row ([lean/INDEX.md:612](../lean/INDEX.md)) reads **partial**, says the statement row proves the heading by the elementary route (the conjecture's conclusion fails for 4 ≤ n ≤ 11), and lists as owed *"the cone conclusion, Ω₀ non-invariant for 4 ≤ n ≤ 11"*. That is the conclusion [results.md:107](../results.md) states and the one [problem.md:213](../findings/problem.md) says the elementary witness does not give. Correct. [INDEX-results.md:59](../findings/INDEX-results.md) reads **Lean: partial**, and STATUS.md's count moves from 134 to 136 (100 to 102 partial), which is L44 and L157 both leaving proved. Consistent.
- **Gap L44-1r** ([lean/INDEX.md:613](../lean/INDEX.md)): the L44 **statement** row still reads **proved** and opens *"by the ELEMENTARY route the record itself calls overdetermining, which delivers the conclusion outright"*. The row directly above now says that route does not deliver the stated conclusion. The statement row should say what `L44_elementary` delivers (the heading, conditional on `hwitness`) and drop *"the conclusion outright"*.
- **L44-2: repaired.** The phrase *"replaced there by the elementary route"* no longer occurs in lean/INDEX.md, and the main row says the padded value enters as the binder `hwitness`, which CP2Real's `Wc_weyl`, `Wc_values` and `Wc_theta` could discharge. Accurate.
- **L44-3 (outside this brief's list): open.** [L44Statement.lean:52](../lean/HamiltonsCubic/Results/L44Statement.lean) still says the padded value *"is imported, not proved"*, while the main row now says the layer could discharge it. The commit does not claim to repair it.

### L157

- **L157-1, L157-2: repaired**, by `unique_root` and `other_root_is_root` (section A). The docstring of `etaStar_mem_Ioo` ([L157Statement.lean:66](../lean/HamiltonsCubic/Results/L157Statement.lean)) now calls it the location half and points to `unique_root`.
- **L157-3, main row: repaired.** [lean/INDEX.md:503](../lean/INDEX.md) reads **partial**, lists the proved algebra accurately and owes *"the derivation of the two branches η and t(1-η)² from the reach problem, which the lemma takes as its setting"*. That owed clause is accurate: the box's opening sentence asserts the branches, the derivation is the self-consistency condition r ≤ √c / sup‖A''(s)‖ with ‖A''(s)‖ ≤ 2M/(ρ-|s|)² in the prose before the box ([second-order.md:2108](../findings/second-order.md) and [second-order.md:2110](../findings/second-order.md)), and no Lean declaration touches it. [INDEX-results.md:173](../findings/INDEX-results.md) reads **Lean: partial** and says the statement proves the boxed algebra. Consistent.
- **Gap L157-3r** ([lean/INDEX.md:504](../lean/INDEX.md), [L157Statement.lean:19](../lean/HamiltonsCubic/Results/L157Statement.lean)): the statement row still opens *"Every clause of the boxed lemma"* and the file's docstring *"Every clause of the boxed lemma, proved"*. The box's first clause is the two branches, which the main row now owes. The row's qualifier *"the two branches taken as the lemma's setting"* is honest, but *"every clause"* should read *"every clause after the branches"* or *"the boxed algebra"*, the phrase INDEX-results already uses.

### L36 and L37

- **L36-1, L37-2: repaired.** [INDEX-results.md:51](../findings/INDEX-results.md) and [INDEX-results.md:52](../findings/INDEX-results.md) read **Lean: proved**, matching the main rows at [lean/INDEX.md:618](../lean/INDEX.md) and [lean/INDEX.md:614](../lean/INDEX.md).
- **L36-2: repaired.** The L36 main row ([lean/INDEX.md:618](../lean/INDEX.md)) now says *"The cap is the statement row's `L36Proof.cap`, from `mu_le` and `mu_ge`"*.
- **L37-1, main row: repaired.** [lean/INDEX.md:614](../lean/INDEX.md) now places the n-dimensional subspace *"at a diagonal W"*, which is the contrapositive of `diagonality_criterion`'s second conjunct (finrank ker Φ_W < n ⇒ not diagonalizable, [L37Statement.lean:511](../lean/HamiltonsCubic/Results/L37Statement.lean)). No longer readable as a general lower bound.
- **Gap L37-1r** ([lean/INDEX.md:615](../lean/INDEX.md)): the L37 **statement** row still ends *"The corollary: `diagIn g` is an n-dimensional subspace of ker Φ_W."*, with no condition on g, the same unconditioned reading r1513 flagged. The preceding sentence supplies the diagonalising frame, so a careful reader recovers it, but the corollary the theorem states is the dimension test, and the row should say so.

### Cross-record agreement

| result | lean/INDEX.md main row | INDEX-results.md | agree |
| --- | --- | --- | --- |
| 36 | **proved** (line 618) | **Lean: proved** (line 51) | yes |
| 37 | **proved** (line 614) | **Lean: proved** (line 52) | yes |
| 44 | **partial** (line 612) | **Lean: partial** (line 59) | yes |
| 157 | **partial** (line 503) | **Lean: partial** (line 173) | yes |

The statement rows at lines 504 and 613 read **proved** under partial main rows. The index uses statement rows for what the statement file proves, so the status tag itself is defensible. The text inside them is what L157-3r and L44-1r address.

## C. Style

- **D-1: repaired.** *"is √Σ/(2θ). Standard three axioms."* is now two sentences in the L125 row ([lean/INDEX.md:464](../lean/INDEX.md)). The remaining *"on W^⊥; and `L125_fourSet`, ..."* separates two comma-bearing items of a list introduced by a colon (`L125_weyl`, ... and `L125_fourSet`, ...), which is the permitted use.
- **D-2: repaired.** The L37 row ([lean/INDEX.md:614](../lean/INDEX.md)) now reads *"act on `Λ²`. `δ` is additive"* and *"the corollary counts. And"*.
- The six changed lean/INDEX.md rows and the four changed INDEX-results rows contain no em dash, no backtick inside markdown link text, are single lines, and each closes with a pipe. The two new docstrings contain no em dash and no splice.
- Outside the changed cells: the Gate-2 text of INDEX-results rows 36, 44 and 157 keeps older semicolon splices (for example *"not a new symbol; what is new"* in row 157). The commit edited only the Lean cell of those rows, so these are noted, not charged.
