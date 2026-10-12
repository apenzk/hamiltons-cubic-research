# REVIEW r1699: L131's fourth entry on all of Λ⁴ in Lean (d8507d41)

**Verdict: CONFIRMED, with two presentation findings.** [L131Lam4.lean](../lean/HamiltonsCubic/Results/L131Lam4.lean)'s `sharpCross_lam4_all` states and proves $R\#I=2R$ on bivectors for every linear $R$ preserving bivectors whose coefficient tensor $C_{abcd}=\langle R\varphi_{ab},\varphi_{cd}\rangle$ is totally antisymmetric. That is [L131](../findings/isotropy-cap.md)'s fourth table entry on the whole $\Lambda^4$ summand, in the same `#` and the same $I$ as the other three entries, under exactly the hypotheses of `lam4_span` that [r1698](REVIEW_r1698.md) confirmed as the record's $\Lambda^4$. It discharges r1698's O3. The [lean/INDEX.md](../lean/INDEX.md) L131 row's "So each summand stands as follows" sentence still gives $\Lambda^4$ through the hand composition (P1), and the file's header names only `lam4_span` (P2).

| # | Claim | Verdict |
|---|---|---|
| 1a | `sharpCross R (fun X => X) Z = 2 • R Z` on skew $Z$ is the record's "$R\#I=2R$ on $\Lambda^4$" in the layer's `#` | **CONFIRMED** |
| 1b | Its hypotheses are exactly `lam4_span`'s | **CONFIRMED** (textually identical) |
| 2a | `alt_zero` is correct and covers all six coincidences | **CONFIRMED** |
| 2b | `Dist` is `sharpCross_lam4_span`'s distinctness hypothesis, in its order | **CONFIRMED** |
| 2c | `sum_dist` equates `lam4_span`'s sum with the sum over distinct quadruples | **CONFIRMED** |
| 3 | Both uses of `sharpOp_congr_on_skew` have their bivector-preservation hypotheses discharged soundly | **CONFIRMED** |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script) |
| 5 | The INDEX row says exactly what is proved and owed | **ACCURATE ON THE NEW THEOREM, ONE STALE SUMMARY SENTENCE** (P1) |

One line: $\#I=2$ on every element of $\Lambda^4$ is now a single kernel-checked declaration, so all four entries of L131's table for the sharp-$I$ map stand in Lean on their whole summand except $S^2_0$, which stands on its diagonal representatives.

## Attack line 1: does the statement say the record's entry

- **The layer's `#`.** [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) defines `sharpCross X Y Z` $=\tfrac12(\mathrm{sharpOp}(X+Y)Z-\mathrm{sharpOp}\,X\,Z-\mathrm{sharpOp}\,Y\,Z)$, the polarisation of `sharpOp`, so `sharpCross R I` is $R\#I$ with $X\#X=\mathrm{sharpOp}\,X$.
- **Same normalisation as the other entries.** `sharpCross_id` ($-1$ on Weyl, [L131Sharp.lean](../lean/HamiltonsCubic/Results/L131Sharp.lean)), `eig_weyl_all` and `eig_scalar_line` ([L131Whole.lean](../lean/HamiltonsCubic/Results/L131Whole.lean)) and `sharpCross_four_id` ([L131Four.lean](../lean/HamiltonsCubic/Results/L131Four.lean)) all take the second slot as `fun X => X` and conclude on skew $Z$. The new theorem uses the same second slot and the same skew-$Z$ conclusion, so its $2$ is the table's $2$, read in one convention with $-1$, $(m-4)/2$ and $m-2$.
- **The record.** [isotropy-cap.md](../findings/isotropy-cap.md), L131 (i): "the fourth, $2$ on $\Lambda^4$, on the four-set elements … carried to every element of $\Lambda^4$ by the first-slot linearity of $\#$". The new declaration is that "carried to every element" step, which the block cites as `sharpCross_lam4_span` alone.
- **Hypotheses.** `R`, `hR : IsLinOp R`, `hsk`, and `hA1`, `hA2`, `hA3` are character for character `lam4_span`'s, and are passed to it unchanged. r1698's reading applies: slots $(12)$, $(34)$, $(23)$ generate total antisymmetry, which implies pair symmetry, so this is the complement of the Bianchi kernel in the symmetric operators on $\Lambda^2$.
- **At $n<4$.** Every quadruple repeats an index, so `Dist ι` is empty, $G=0$, and the statement reduces to $R=0$ on bivectors with $0\#I=0$, consistent with $\Lambda^4=0$.

## Attack line 2: `alt_zero`, `Dist`, `sum_dist`

- **The six coincidences.** The disjunction lists $a=b$, $a=c$, $a=d$, $b=c$, $b=d$, $c=d$, all six pairs of four slots. The three direct cases come from one hypothesis each ($C_{xxyz}=-C_{xxyz}$ by hA1, $C_{xyzz}$ by hA2, $C_{xyyz}$ by hA3). The other three I checked by hand: $C_{abad}=-C_{aabd}=0$ (hA3); $C_{abca}=-C_{abac}=C_{aabc}=0$ (hA2 then hA3); $C_{abcb}=-C_{abbc}=0$ (hA2). Each matches the `linarith` hints given.
- **`alt_zero` drops the typeclasses** (`omit [Fintype ι] [DecidableEq ι]`), correctly, since it is a pointwise statement.
- **`Dist`.** The subtype predicate is $t_1\ne t_{2,1}$, $t_1\ne t_{2,2,1}$, $t_1\ne t_{2,2,2}$, $t_{2,1}\ne t_{2,2,1}$, $t_{2,1}\ne t_{2,2,2}$, $t_{2,2,1}\ne t_{2,2,2}$. With $(i,j,k,l)=(t_1,t_{2,1},t_{2,2,1},t_{2,2,2})$ that is $i\ne j$, $i\ne k$, $i\ne l$, $j\ne k$, $j\ne l$, $k\ne l$, which is `sharpCross_lam4_span`'s `hd` in the same order, so `fun t => t.2` discharges it with no reshuffling.
- **`sum_dist`.** The quadruple sum is rewritten as one sum over `ι × ι × ι × ι` (`Fintype.sum_prod_type`) with the $1/24$ pushed into each coefficient, the terms off the distinctness predicate are zero by `alt_zero` (`hz`, the predicate's negation turned into the six-way disjunction by `tauto`), `Finset.sum_filter_of_ne` restricts to the predicate and `Finset.sum_subtype` moves to `Dist ι`. It uses only that $C$ vanishes at a repeated index. r1698 also noted `lam4` itself vanishes there, which the proof does not need.

## Attack line 3: the congruence step

- **Where it enters.** `lam4_span` and `sum_dist` give `hRG`, $R X=G X$ on skew $X$, with $G=\sum_{t\in\mathrm{Dist}}(C_t/24)\,$`lam4`$_t$. `sharpCross` is not a function of $R$'s values on bivectors alone by definition, so the swap $R\to G$ in the first slot goes through `sharpOp_congr_on_skew` twice.
- **First use, `sharpOp (R + I) Z = sharpOp (G + I) Z`.** Needs $R+I$ to preserve bivectors (`hskS`: $(RX+X)^\top=-RX+(-X)=-(RX+X)$ from `hsk` and $X^\top=-X$, via `neg_add`) and $(R+I)X=(G+I)X$ on skew $X$ (`hsum`, from `hRG`). Both sound.
- **Second use, `sharpOp R Z = sharpOp G Z`.** Needs `hsk` (a hypothesis) and `hRG`. Sound. The third term `sharpOp I Z` is common to both sides.
- **The lemma's hypothesis is on $R$, the first argument**, which is what is discharged in each use ($R+I$, then $R$). [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean)'s `sharpOp_congr_on_skew` reduces through `sharpBil_congr_on_skew` and `sharpQF_congr_on_skew`, which read $R$ only on skew inputs, the bivector hypothesis guaranteeing $R$'s outputs stay where $S$ agrees.
- **Closing.** After `rw [hc, hRG Z hZ]` the goal is `sharpCross G I Z = 2 • G Z`, which is `sharpCross_lam4_span Finset.univ` at the coefficient $C_t/24$, `G` and the lemma's `fun W => ∑ t ∈ univ, …` agreeing definitionally.

## Attack line 4: axioms and build

- **Build (screen).** `lake build HamiltonsCubic.Results.L131Lam4` in the background: "Build completed successfully (8744 jobs)", one `show`-linter warning at line 70, inside the pre-existing `lam4_span`. The working-tree file is clean against d8507d41.
- **Axioms (screen).** `python3 scripts/misc/axiom_audit.py --only L131Lam4.lean`: "auditing 6 declarations across 1 files", "6/6 clean -- resting on the standard three alone", matching the commit message. Both are screens of the build, never evidence beyond it.

## Attack line 5: the INDEX row and the file header

- **The new sentence is exact.** *"And $\#I=2$ on all of $\Lambda^4$ is PROVED (r1698 O3): `sharpCross_lam4_all`, $R\#I=2R$ on bivectors for every linear $R$ preserving bivectors with totally antisymmetric coefficients, through `alt_zero`, `sum_dist` and `sharpOp_congr_on_skew`; standard three axioms."* This is the theorem. The trimmed owed list (reverse inclusion and independence, $S^2_0$ spanning, Weyl as the whole $-1$ eigenspace, $\mathcal A$ on the other summands) is what remains, and nothing retired by this commit is still listed as owed.
- **P1: a stale summary sentence.** Earlier in the same row: *"So each summand stands as follows: … $\Lambda^4$ on the span of the four-set elements by `sharpCross_lam4_span`, with $\Lambda^4\subseteq$ that span declared by `lam4_span` below and the reverse inclusion by a hand count"*. $\Lambda^4$ now stands on the whole summand by one declaration. Suggested: *"$\Lambda^4$ on the whole summand by `sharpCross_lam4_all` below"*.
- **P2: the file header.** L131Lam4.lean's module docstring lists `lam4_span` only. Add a bullet for `sharpCross_lam4_all` (with `alt_zero`, `sum_dist` as its steps), since the file's title "the four-set elements span $\Lambda^4$" no longer covers its main theorem.
- **Outside the commit.** L131 (i) in [isotropy-cap.md](../findings/isotropy-cap.md) credits the extension to every element of $\Lambda^4$ to `sharpCross_lam4_span`. It can now cite `sharpCross_lam4_all`, which is the declaration that says it.

## What would break the claims, and what I did to look for it

- **A different `#` or a different $I$ from the other entries**, which would make the $2$ a different table's $2$. I read `sharpCross`'s definition and the statements of `sharpCross_id`, `eig_weyl_all`, `eig_scalar_line` and `sharpCross_four_id`: same polarisation, same `fun X => X`, same skew-$Z$ conclusion.
- **A missed coincidence in `alt_zero`**, leaving a repeated-index term that `sharpCross_lam4_span` cannot absorb. I enumerated the six pairs and derived each case by hand.
- **A `Dist` predicate in a different order or on different components from `hd`**, which would force a reshuffle the proof does not do. I matched the projections one to one.
- **An unsound congruence**, e.g. a bivector hypothesis discharged for $R$ where the lemma needs it for $R+I$. I read the lemma's statement and both call sites.
- **A vacuous hypothesis set.** Inherited from r1698: `lam4 i j k l` at distinct indices meets it and is nonzero.
- **No object found.** No operator in $\Lambda^4$ escapes the theorem, and none outside it is claimed.
