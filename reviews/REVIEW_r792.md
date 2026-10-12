# Reviewer r792, is `four_le_card_edges` L176, and does `card_edges_ne_three` close the last case

*Reviewer r792, on the cold brief for Gate 2 on [L176Statement.lean](../lean/HamiltonsCubic/Results/L176Statement.lean). I read the brief in full before anything else, then the file on disk in its entirety, then the record's own L176 block in [diagonal-half.md](../findings/diagonal-half.md) together with the L177 material beneath it, then the three rows of [lean/INDEX.md](../lean/INDEX.md) that speak about the file, then the two prior audits [REVIEW_r789.md](REVIEW_r789.md) and [REVIEW_r790.md](REVIEW_r790.md). I ran no numerical work: `lake build` once, one `#print axioms`, and one candidate witness elaborated in a scratch file outside the repository, all three are reading the artefact, which the standing analysis-only rule permits as screening. Every value below is exact and every counterexample search is an exhaustive hand enumeration in closed form. My log is [agent_logs/g2-l176-r792.log](../agent_logs/g2-l176-r792.log).*

| # | claim attacked | verdict | reason |
|---|---|---|---|
| 1 | `IsSectional` captures the coordinate-diagonal locus | **CONFIRMED AS ALGEBRA** | the three fields are the record's three conditions and no more; the derivation of them from a Weyl tensor in an orthonormal frame is prose, so orthonormality is consumed outside Lean rather than dropped |
| 2 | `(edges K).card` is the $\Lambda^2$-rank | **CONFIRMED AS ALGEBRA** | the `p.1 < p.2` filter counts each unordered support pair exactly once, which is the record's $\lvert E(G)\rvert$; the identification of that count with $\operatorname{rank}(W:\Lambda^2\to\Lambda^2)$ appears only in the module docstring |
| 3 | `four_le_card_edges` is L176's conclusion | **CONFIRMED, TWO CLAUSES OF THREE** | the edge bound is `four_le_card_edges` and the degree statement is `card_nbr_zero_or_two_le`, both sorry-free; the rank clause is absent because no $\Lambda^2$ exists in the file |
| 4 | the theorem is non-vacuous | **CONFIRMED** | the four-cycle with alternating weights elaborates as `IsSectional` and nonzero at `n = 4`, attaining four edges; vacuous at `n ≤ 3`, where the record's own object vanishes too |
| 5 | every imported lemma proves what its name and docstring say | **REFUTED FOR ONE OF TWENTY** | `card_nbr_eq_two_of_three` is named for an equality, docstringed for an argument it does not make, concludes `≤ 3`, and is called by nothing |
| 6 | `card_edges_ne_three` is correct | **CONFIRMED** | `far`, `far_components`, `rowsum_pair` and `nbr_eq_pair` are correctly oriented at each of the three vertices, and the row-sum system they feed is the record's |
| 7 | `rowsum_pair` discharges its `sum_subset` side condition | **CONFIRMED** | the obligation is `∀ b ∈ univ, b ∉ nbr K a → K a b = 0`, which is the definitional unfolding of `nbr`, established rather than assumed |
| 8 | both hypotheses of `four_le_card_edges` are used | **CONFIRMED** | `hne` enters through `card_edges_ne_zero` alone and `hK` through all four exclusions |
| 9 | the index row's claim | **REFUTED AS STATED** | the "no `sorry`" half is true and screened; the appended "Both audits call this file faithful" credits r789 and r790 with an endorsement of the three-edge case, which did not exist when they read the file |
| 10 | the record's "second proof" paragraph | **CONFIRMED** | the file reaches the triangle through incidence membership with no handshake sum anywhere, which is what the paragraph says |
|, | the record's "machine-checked in full" | **REFUTED AS STATED** | the matrix theorem is machine-checked in full; the lemma quantifies over Weyl tensors and $\Lambda^2$, neither of which the file mentions |

**One-line summary.** The mathematics of the file is correct throughout and `four_le_card_edges` is genuinely L176's edge bound with no `sorry`, but three sentences written *about* the file overstate it: the record's "machine-checked in full", the index's transfer of two earlier audits' endorsement onto 380 lines they never saw, and one dead lemma whose name and docstring outrun its conclusion.

## 0. Conventions, fixed once

Quoted from the brief and the record. $W\ne0$ is a Weyl tensor coordinate-diagonal in an orthonormal frame $\{f_a\}$; $K_{ab}=W_{abab}$ is its sectional matrix; $G$ is the graph on $\{1,\dots,n\}$ whose edges are the pairs with $K_{ab}\ne0$; $E=E(G)$. In Lean the index type is `Fin n`, `nbr K a` is the neighbourhood of `a`, `edges K` is the set of pairs `p` with `p.1 < p.2` and `K p.1 p.2 ≠ 0`, and `edgesAt K a` is the set of edges having `a` as a component. A counterexample is exhibited in closed form or it is not a counterexample. Computation is confined to screening a claim about to be recorded.

## The hypothesis inventory

Every hypothesis of the record's statement, and of every Lean declaration the proof of `four_le_card_edges` reaches, against the object it applies to.

### The record's statement

| hypothesis | where it is used in the record's proof | where it lands in Lean |
|---|---|---|
| $W$ is a Weyl tensor | supplies Ricci-flatness, hence $\sum_bK_{ab}=0$ | the `rowsum` field, asserted rather than derived |
| the frame $\{f_a\}$ is orthonormal | makes $g^{bd}W_{abcd}=0$ read as $\sum_bW_{abab}=0$, and makes $\{f_a\wedge f_b\}$ an orthogonal basis on which $W$ acts diagonally | nowhere, the file has no metric, so this hypothesis is spent in the prose bridge that produces `IsSectional` |
| $W$ is coordinate-diagonal in that frame | gives $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, hence $\operatorname{rank}=\lvert E\rvert$ | nowhere, the rank clause is not typed |
| $W\ne0$ | forces $\lvert E\rvert\ge1$ | `hne : K ≠ 0`, used in `card_edges_ne_zero` |

### The Lean declarations, in dependency order

| declaration | hypotheses | each checked against its object |
|---|---|---|
| `IsSectional` | `symm`, `hollow`, `rowsum` | the record's own three conditions on $K$, stated over $\mathbb R$ at general $n$ |
| `card_nbr_ne_one` | `hK` | `rowsum` collapses to the single entry; `hollow` is not needed here and is not used |
| `card_nbr_zero_or_two_le` | `hK` | `omega` from `card ≠ 1` alone |
| `two_le_card_nbr` | `hK`, `hab : K a b ≠ 0` | `hab` puts `b` in `nbr K a`, so the degree is nonzero |
| `mem_edges_of_ne` | `hK`, `h : K a c ≠ 0` | `hollow` gives `a ≠ c`; `symm` supplies the reversed orientation |
| `card_edges_ne_one` | `hK` | uses `hollow` and `symm` through `mem_edges_of_ne`, and `rowsum` through `card_nbr_ne_one` |
| `edgeOf`, `edgeOf_mem`, `edgeOf_inj` | `hK`, `hc : c ≠ a`, `hd : d ≠ a` | both `hc` and `hd` are load-bearing, in the two mixed branches of the four-way case split |
| `card_edges_ne_zero` | `hK`, `hne` | `hollow` on the diagonal, `symm` below it, `hne` as the target of the contradiction |
| `edges_eq_image` | `hK`, `ha : 2 ≤ card (nbr K a)`, `h2 : card (edges K) = 2` | both cardinality hypotheses feed the `eq_of_subset_of_card_le` step |
| `mem_edges_has` | as above | inherits them unchanged |
| `card_edges_ne_two` | `hK` | applies `mem_edges_has` at both endpoints of one edge |
| `triangle_forces_zero` | `h1`, `h2`, `h3` | three real equations, determinant $-2$ as the docstring says |
| `card_nbr_eq_two_of_three` | `hK`, `ha`, `h3` | **`ha` is not needed for the stated conclusion `≤ 3`**, see §5 |
| `edgesAt`, `card_edgesAt` | `hK` | `hollow` for injectivity, `symm` for the lower-endpoint branch |
| `two_le_card_edgesAt` | `hK`, `hab` | transports `two_le_card_nbr` along `card_edgesAt` |
| `exists_other_edge` | `hpin`, `h2` | erasure of a member of a set of size at least two |
| `edge_endpoints_deg` | `hK`, `hp` | `symm` to get the second endpoint's nonzero entry |
| `far`, `far_mem_nbr`, `far_ne`, `far_components` | `hK`, `he : e ∈ edgesAt K a` | `he` alone in `far_components`; `hollow` in `far_ne`; `symm` in `far_mem_nbr`'s second branch |
| `rowsum_pair` | `hK`, `hxy : x ≠ y`, `hnbr : nbr K a = {x, y}` | `hxy` for `Finset.sum_pair`; `rowsum` for the value |
| `nbr_eq_pair` | `hK`, `hxy`, `hx`, `hy`, `hle : card (edgesAt K a) ≤ 2` | all five used; `hle` is transported to `nbr` by `card_edgesAt` |
| `card_edges_ne_three` | `hK` | the whole three-edge case |
| `four_le_card_edges` | `hK`, `hne` | both used, `hne` through `card_edges_ne_zero` only |

## 1. Does `IsSectional` capture the coordinate-diagonal locus?

**No finding on the three fields.** The record's proof says the locus is *"hollow symmetric with vanishing row sums, which is the whole of what the proof uses"*, and the structure is exactly those three clauses. `symm` is $K_{ab}=K_{ba}$, immediate from $W_{abab}=W_{baba}$ by the pair symmetry; `hollow` is $W_{aaaa}=0$ by antisymmetry in the first index pair; `rowsum` is the record's *"Ricci-flatness of a Weyl tensor reads $\sum_bK_{ab}=0$ for each $a$ there"*.

**Orthonormality is spent outside the file rather than dropped.** The trace-free condition on a Weyl tensor is $g^{bd}W_{abcd}=0$. Reading it at $a=c$ as $\sum_bW_{abab}=0$ needs $g^{bd}=\delta^{bd}$, which is precisely orthonormality of $\{f_a\}$ in a positive-definite metric. The Lean file has no metric object at all, so it cannot express this step; what it does instead is take the conclusion of the step, `rowsum`, as a field. That is a legitimate abstraction and the module docstring is open about it (*"Its content needs no curvature tensor"*) but the consequence is that the hypothesis the record itself flags as *"used and unstated"* is the one hypothesis Lean cannot check. This confirms r789's inventory line and I record it independently.

**The abstraction strengthens rather than weakens.** Every coordinate-diagonal $K$ is `IsSectional`, so the Lean theorem quantifies over a set at least as large as the record's locus, and its conclusion therefore implies the record's. (By [L177](../findings/diagonal-half.md)(1) the two sets coincide, so nothing is even lost.)

## 2. Does `(edges K).card` capture the $\Lambda^2$-rank?

**No finding on the count.** `edges K` filters `Fin n × Fin n` by `p.1 < p.2 ∧ K p.1 p.2 ≠ 0`. The strict inequality picks one representative of each unordered pair $\{a,b\}$ with $a\ne b$, so each support pair is counted once and the diagonal is excluded, and the diagonal carries nothing anyway, by `hollow`. Nothing is double-counted and nothing is missed: the pairs with `p.1 > p.2` are the same 2-forms up to sign, and `symm` guarantees they are nonzero exactly when their transposes are.

**The identification with the rank is prose.** The record's chain is $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, so $W$ is diagonal in the basis $\{f_a\wedge f_b\}_{a<b}$ of $\Lambda^2$ and its rank is the number of nonzero diagonal entries, which is $\lvert E\rvert$. The file asserts this in its module docstring (*"the $\Lambda^2$-rank is the number of nonzero entries above the diagonal"*) and never types it. The step is sound, and a normalisation factor in the $\Lambda^2$ convention would change the eigenvalues without changing which of them vanish, so the rank claim is robust to that convention; but it is asserted, not checked.

## 3. Is `four_le_card_edges` L176's conclusion or something weaker?

The record's sentence has three clauses. Taking them one at a time:

- *"every vertex of $G$ has degree $0$ or degree $\ge2$"*, this is `card_nbr_zero_or_two_le`, whose type is `(nbr K a).card = 0 ∨ 2 ≤ (nbr K a).card`, universally quantified over `a`. `nbr K a` is the degree set of `a` in $G$, and `hollow` keeps `a` out of it, so the cardinality is the degree. **Present, proved, sorry-free.**
- *"$G$ has at least four edges"*, this is `four_le_card_edges`, type `4 ≤ (edges K).card` under `IsSectional K` and `K ≠ 0`. **Present, proved, sorry-free.**
- *"in particular $\operatorname{rank}(W:\Lambda^2\to\Lambda^2)\ge4$"*, **absent.** The file has no $W$, no $\Lambda^2$ and no rank.

The record itself says *"only the edge bound is equivalent to the rank bound; the degree statement is strictly more than it"*, and both of the two things it distinguishes are in the file. The degree statement is there, so the brief's worry on that point is cleared.

**The withdrawn part of this candidate.** I considered reporting the missing rank clause as a defect of the file, and withdraw it: the clause is flagged *"in particular"* in the record, meaning it follows from the edge bound by the identification of §2, and the file's own docstring says in its first paragraph that the rank has been traded for the edge count. The defect is not in the file. It is in the sentence the record writes about the file, which is §11.

## 4. Vacuity

**At what $n$ is `K ≠ 0` satisfiable under `IsSectional`?** The answer is $n\ge4$, and I give both halves in closed form.

*Unsatisfiable at $n\le3$.* At $n=0$ the matrix type is a subsingleton and its only element is $0$. At $n=1$, `hollow` gives $K_{00}=0$, so $K=0$. At $n=2$, `hollow` gives $K_{00}=K_{11}=0$ and `rowsum` at row $0$ gives $K_{00}+K_{01}=0$, so $K_{01}=0$ and $K=0$. At $n=3$ the three row sums read $K_{01}+K_{02}=0$, $K_{01}+K_{12}=0$, $K_{02}+K_{12}=0$, whose only solution is $K_{01}=K_{02}=K_{12}=0$, the same $3\times3$ system as `triangle_forces_zero`, determinant $-2$.

So at $n\le3$ the theorem is vacuously true. **This is honest rather than a defect**, and it aligns with the mathematics: a Weyl tensor vanishes identically in dimension at most three, so the record's own L176 is vacuous there too. r789 recorded the same and I confirm it independently.

*Satisfiable and sharp at $n=4$.* Screened, and reported as a screen: I elaborated the record's four-cycle witness in a scratch file outside the repository,

```
C4 : Matrix (Fin 4) (Fin 4) ℝ := !![0, 1, 0, -1; 1, 0, -1, 0; 0, -1, 0, 1; -1, 0, 1, 0]
```

and both `IsSectional C4` and `C4 ≠ 0` elaborate with no error. By hand: row $0$ reads $1+0-1=0$, row $1$ reads $1-1+0=0$, row $2$ reads $0-1+1=0$, row $3$ reads $-1+0+1=0$; the support is $\{01,12,23,03\}$, four edges. This is the record's *"cycle $12,23,34,41$ with values $c,-c,c,-c$"* at $c=1$ in zero-based indices, and it shows the theorem is non-vacuous and its constant attained.

**Should `n` be constrained in the file?** No. The theorem is true at every `n` and the unconstrained form is the stronger statement; constraining `n` would add a hypothesis nothing uses.

## 5. Every lemma the proof calls, and the one that fails

I checked all twenty declarations. Nineteen prove what their name and docstring say. The exception:

**`card_nbr_eq_two_of_three` is a finding, cleared through all three steps of the protocol.**

1. **Located.** [L176Statement.lean](../lean/HamiltonsCubic/Results/L176Statement.lean), lines 218–241. The docstring reads *"**A vertex of a three-edge support has exactly two neighbours.** Its neighbours inject into the edges, so it has at most three; and the degree step forbids one, so two or three. Three would put every edge on it, which the other endpoints' degrees forbid."* The declaration's conclusion is `(nbr K a).card ≤ 3`.
2. **Exhibited.** The gap is exact and needs no witness matrix. The docstring's title asserts an equality with $2$; the type asserts an inequality with $3$; the docstring's last two sentences describe two further arguments (the exclusion of degree one and the exclusion of degree three), of which the proof makes neither. The proof body is `card_le_card` on the image of `edgeOf a`, then `omega`. And the name `card_nbr_eq_two_of_three` states in its own identifier the equality the conclusion does not carry. Compounding it, the hypothesis `ha : 2 ≤ (nbr K a).card` is not needed: `card_le_card hsub` plus `h3` give `≤ 3` on their own. The `unusedVariables` linter stays silent because `omega` sweeps the whole context, so nothing in the build flags it.
3. **The opposite argued.** The strongest defence is that the docstring's first sentence is a section heading for the surrounding argument rather than a claim about this declaration, and that `≤ 3` is the only part of that argument this step contributes. That defence fails on two counts. The name carries `eq_two` and a name is not a heading; and the declaration is **called by nothing**, `grep` over the tree returns only its own definition site, and `card_edges_ne_three` reaches the triangle through `edgesAt` without touching it. A dead declaration whose identifier and docstring claim more than its type is exactly the pattern [r789](REVIEW_r789.md) named as the layer's failure mode, arriving here in a file otherwise free of it.

**Severity.** This does not touch the correctness of `four_le_card_edges`, which never calls it. It is a reader-facing defect: someone auditing the file by docstring would credit the file with an argument it does not contain.

**No finding on the other nineteen.** `card_nbr_ne_one` is the record's degree paragraph, and the `Finset.sum_eq_single` step is correctly discharged in both obligations. `card_edges_ne_zero`'s docstring names hollowness and symmetry and the proof uses exactly those, on the three branches of `lt_trichotomy`. `card_edges_ne_two`'s docstring (*"Both endpoints of one edge lie in every edge, so the two edges coincide"*), is the proof: `mem_edges_has` is applied at `p.1` and at `p.2` and the four-way case split closes on `p.1 ≠ p.2` twice, on `Prod.ext` once, and on the asymmetry of `<` once. `triangle_forces_zero`'s determinant is genuinely $-2$: $\det\begin{psmallmatrix}1&1&0\\1&0&1\\0&1&1\end{psmallmatrix}=-1-1=-2$. `edgeOf_inj` needs both `hc` and `hd`, one in each mixed branch. The one docstring that reaches slightly past its type is `far_mem_nbr`, whose title says *"An edge at `a` is `a` and its far endpoint, in some order"* while the type states only the neighbour half, but the order half is `far_components`, two declarations below, so nothing is claimed that the file does not prove.

## 6. `card_edges_ne_three` in detail

This is the whole of the last case and it is new since both prior audits. I checked every step.

**The skeleton.** Take `p ∈ edges K`, which exists because the support has three edges. Both endpoints have incidence at least two (`edge_endpoints_deg`), so `p.1` carries a second edge `e2 ≠ p` and `p.2` carries a second edge `e3 ≠ p`. Set `c := far p.1 e2`.

**`far` and `far_components` are correctly oriented.** `far a e = if e.1 = a then e.2 else e.1`. In `far_mem_nbr`, the branch `e.1 = a` rewrites the goal `K a (far a e) ≠ 0` to `K e.1 e.2 ≠ 0`, which is the edge's own membership condition. The branch `e.2 = a` first shows `e.1 ≠ a`, if `e.1 = a` then with `e.2 = a` we get `e.1 = e.2`, against `e.1 < e.2`, then rewrites to `K e.2 e.1 ≠ 0` and applies `symm`. Both orientations are right. `far_components` runs the same split and returns `(e.1 = a ∧ e.2 = far a e)` in the first case and `(e.1 = far a e ∧ e.2 = a)` in the second, matching the branch each time. A swap in either would have been invisible; there is none.

**`c ∉ {p.1, p.2}`.** `c ≠ p.1` is `far_ne`, which uses `hollow`. `c ≠ p.2` is the step where a wrong orientation would bite: if `c = p.2`, then in the first branch of `far_components` `e2 = (p.1, p.2) = p`, contradicting `e2 ≠ p`; in the second branch `e2 = (p.2, p.1)`, whose components would satisfy `p.2 < p.1` against `p.1 < p.2`. Both branches close.

**`e2 ≠ e3`.** If they were equal, the common edge would lie in `edgesAt K p.2`, forcing one of `e2`'s two components to be `p.2`. Its components are `p.1` and `c` by `far_components`, and neither is `p.2`. Correct, and note this is a slightly different route to the same fact as the record's *"a common edge would be the first one"*, since an edge containing both `p.1` and `p.2` is `p`.

**The support is `{p, e2, e3}`.** Three distinct edges inside a three-element set, so `eq_of_subset_of_card_le` gives equality. `p ∉ {e2, e3}` comes from `hne2.symm` and `hne3.symm`; `e2 ≠ e3` from the previous step.

**`c`'s second edge can only be `e3`.** `c` has incidence at least two, so it carries `e4 ≠ e2`. Since `p ∉ edgesAt K c` (neither of `p`'s components is `c`) and `e4 ≠ e2`, membership in `{p, e2, e3}` leaves `e4 = e3`. Hence `e3 ∈ edgesAt K c`, and `far p.2 e3 = c` follows by matching `far_components` at `p.2` against `e3`'s membership at `c`, four branches, two of which close on `p.2 ≠ c` and two of which deliver `c`. So `K p.2 c ≠ 0`, and the triangle is closed.

**The incidence bounds.** `edgesAt K p.1 ⊆ {p, e2}` because `e3` is not incident to `p.1` (its components are `p.2` and `c`); `edgesAt K p.2 ⊆ {p, e3}` because `e2`'s components are `p.1` and `c`; `edgesAt K c ⊆ {e2, e3}` because `p` is not incident to `c`. Each gives `card ≤ 2`.

**The row sums.** `nbr_eq_pair` then pins each of the three neighbourhoods to a two-element set, and `rowsum_pair` reads the row sum off it: $K_{p_1p_2}+K_{p_1c}=0$, $K_{p_2p_1}+K_{p_2c}=0$, $K_{cp_1}+K_{cp_2}=0$. Two `symm` rewrites put all three in the upper triangle, giving $x+y=0$, $x+z=0$, $y+z=0$ with $x=K_{p_1p_2}$, $y=K_{p_1c}$, $z=K_{p_2c}$. `triangle_forces_zero` gives $x=0$, against `p` being an edge. **The argument is correct at every step**, and it is the record's own triangle system.

## 7. `rowsum_pair`, is the `sum_subset` obligation discharged?

**No finding: it is discharged.** `Finset.sum_subset` with `s = nbr K a` and `t = univ` asks for `∀ b ∈ univ, b ∉ nbr K a → K a b = 0`. The proof is `intro b _ hb; simpa [nbr] using hb`. Unfolding `nbr K a = univ.filter (fun b => K a b ≠ 0)`, the hypothesis `hb` is `¬(b ∈ univ ∧ K a b ≠ 0)`, and since `b ∈ univ` holds definitionally this reduces to `¬(K a b ≠ 0)`, i.e. `K a b = 0`. That is the goal. The obligation is **established from the definition of `nbr`**, not assumed: `simpa` is discharging a definitional unfolding, and nothing about the row sum is used to prove it. The direction of `sum_subset` is also right (it concludes `∑ b ∈ nbr K a, K a b = ∑ b, K a b`, the smaller sum equal to the larger) and `Finset.sum_pair hxy` then evaluates the left side, which is why `hxy : x ≠ y` is needed.

## 8. Unused and unstated hypotheses

- **`four_le_card_edges` uses both.** `hne` reaches only `card_edges_ne_zero`; `hK` reaches all four exclusions. Neither is idle.
- **One unused hypothesis found**, `ha` in `card_nbr_eq_two_of_three`, §5.
- **One unstated hypothesis found**, and it is the record's own: orthonormality, §1. It is unstated in Lean because the file has no metric to state it against, and the record flags it as *"used and unstated"* in its own text.
- **No step uses a hypothesis nobody stated.** Every branch I traced consumes only `symm`, `hollow`, `rowsum` and the local cardinality facts.

## 9. The index row's claim

[lean/INDEX.md](../lean/INDEX.md) line 38 makes three claims. Taking them apart:

**(a) "a Lean theorem with no `sorry`", TRUE, and screened.** The build completes at exit 0 over 9012 jobs with no `sorry` warning against this module, and `#print axioms four_le_card_edges` returns `[propext, Classical.choice, Quot.sound]`, the three standard axioms, with no `sorryAx`. The same holds for `card_edges_ne_three` and `card_nbr_zero_or_two_le`. The elaborated type is `∀ {n : ℕ} (K : Matrix (Fin n) (Fin n) ℝ), IsSectional K → K ≠ 0 → 4 ≤ (edges K).card`, which is `four_le_card_edges` at general `n` as claimed.

**(b) "the first numbered lemma whose own conclusion is a Lean theorem", true on a reading the index itself supplies.** [L180](../lean/HamiltonsCubic/Results/L180Statement.lean)'s row claims to be *"the first numbered lemma with parts of its own STATEMENT proved"*, and [L178](../lean/HamiltonsCubic/Results/L178Statement.lean)'s conclusion is proved with a four-step chain owed. So "whole conclusion" leaves L176 first. The qualifier *"own conclusion"* is doing real work and it survives, subject to §11's point that "own conclusion" here means two clauses of three.

**(c) "Both audits call this file faithful", REFUTED AS STATED, and this is the finding of this section.** Cleared through the protocol:

1. **Located.** The sentence sits at the end of the row for `L176 (statement)`, in a row whose state cell now reads **proved**, so a reader takes the audits to have endorsed the proved file.
2. **Exhibited.** [REVIEW_r790.md](REVIEW_r790.md) line 69 says in terms: *"the edge half is `four_le_card_edges`, stated with a `sorry`"*, and its row 12 grades L176's `sorry` as **HONEST, INCOMPLETE**. [REVIEW_r789.md](REVIEW_r789.md) line 55 enumerates the file as having **five** proved theorems, `card_nbr_ne_one`, `card_nbr_zero_or_two_le`, `two_le_card_nbr`, `mem_edges_of_ne`, `card_edges_ne_one`, which are exactly the first five of the twenty on disk today. Every declaration from `edgeOf` onwards, including all of `card_edges_ne_two`, `edgesAt`, `card_edgesAt`, `far`, `far_components`, `rowsum_pair`, `nbr_eq_pair` and the whole 153-line `card_edges_ne_three`, postdates both audits. That is roughly 380 of the file's 554 lines, and it includes the entirety of the case the row's own text advertises: *"$\lvert E\rvert\ne3$ because three edges force a triangle"*.
3. **The opposite argued.** The charitable reading is that the sentence records a historical fact (two audits did read this file and did call it faithful) and makes no claim about coverage. It is a fair reading of the words in isolation. It fails in position: the sentence is the last thing in a cell whose first words are **proved** and whose body describes the three-edge exclusion, so its plain function is to certify the row it terminates. A reader deciding whether the three-edge case has been checked would read that sentence and conclude yes, and until this report the answer was no.

**The repair belongs to someone else.** Naming the defect is the whole of my job here; I note only that the fact this report establishes is that the three-edge case has now been read by one reviewer.

## 10. The record's "second proof" paragraph

[diagonal-half.md](../findings/diagonal-half.md) line 575 says the three-edge case *"is reached there by edge membership rather than by the degree sum above"*, and calls the file *"a second proof rather than a transcription"*.

**No finding: the description is accurate.** The record's own argument for $\lvert E\rvert=3$ is a handshake count, *"the degree sum is $6$ with every support degree $\ge2$, forcing exactly three vertices of degree exactly two"*. The Lean argument contains no sum of degrees anywhere. It works entirely through membership in `edgesAt`, bounding each of the three vertices' incidence sets above by explicit two-element sets carved out of `{p, e2, e3}`, and below by `two_le_card_edgesAt`. The record's three clauses each land:

- *"an edge's two endpoints each carry a second edge"*, `edge_endpoints_deg` then `exists_other_edge`, twice.
- *"those two are distinct because a common edge would be the first one"*, `h23`, which reaches the same conclusion through `c ≠ p.2` rather than through the common edge being `p`. Same substance, a slightly different route; the record's phrasing is a fair summary rather than a line-by-line description.
- *"the far endpoint of one needs a second edge that can only be the other"*, `hdc`, `e4`, then `he3c`, exactly.

The claim that the two routes *"agree on the triangle"* is also right: both end at the same $3\times3$ system with determinant $-2$.

## 11. The record's "machine-checked in full"

The same paragraph opens **"This lemma is machine-checked in full."** Cleared through the protocol:

1. **Located.** [diagonal-half.md](../findings/diagonal-half.md) line 575, first sentence, directly beneath L176's proof.
2. **Exhibited.** L176's statement begins *"Let $W\ne0$ be a Weyl tensor coordinate-diagonal in some orthonormal frame"* and ends *"in particular $\operatorname{rank}(W:\Lambda^2\to\Lambda^2)\ge4$"*. The elaborated type of `four_le_card_edges` is `∀ {n : ℕ} (K : Matrix (Fin n) (Fin n) ℝ), IsSectional K → K ≠ 0 → 4 ≤ (edges K).card`. It quantifies over no tensor, mentions no metric, no frame, no exterior power and no rank. Two steps of the lemma are therefore outside the machine check: that a coordinate-diagonal Weyl tensor in an orthonormal frame yields an `IsSectional` matrix, and that $\lvert E\rvert$ is the $\Lambda^2$-rank.
3. **The opposite argued.** The strongest defence is the file's own first paragraph, *"Its content needs no curvature tensor: the coordinate-diagonal locus is exactly the hollow symmetric matrices with vanishing row sums, and the $\Lambda^2$-rank is the number of nonzero entries above the diagonal. So the lemma is a statement about matrices"*, under which "the lemma" names its mathematical content and the sentence is true. That defence has real force, and it is why I grade this **REFUTED AS STATED** rather than refuted: the mathematics is fully checked and the sentence's next clause openly says the file *"carries the locus as a structure"*. What the phrase "in full" adds is a claim of completeness that the two prose steps deny, and one of those steps is where the record's own flagged-as-unstated hypothesis lives.

## The verdict

**`four_le_card_edges` is L176's edge bound, it is proved, and the proof is correct.** I traced all twenty declarations and every branch of the three-edge case; the mathematics holds at every step, the axiom set is the standard three, the hypotheses are satisfiable from $n=4$ up with the record's four-cycle attaining the bound, and the theorem's vacuity at $n\le3$ matches the vanishing of Weyl tensors there. The degree statement the record calls *strictly more* than the edge bound is present and proved. Nothing in this file states something false, and nothing in it is a scalar identity wearing a mathematical docstring, with the single exception of a dead lemma.

**Three sentences written about the file overstate it, and all three are outside the mathematics.**

- The record's **"This lemma is machine-checked in full"**, the matrix theorem is; the lemma, which quantifies over Weyl tensors and $\Lambda^2$, is not, and the reduction between them is prose containing the orthonormality hypothesis.
- The index's **"Both audits call this file faithful"**, appended to a row now marked **proved**, those audits read a file whose `four_le_card_edges` carried a `sorry` and which had five proved theorems rather than twenty. The whole three-edge case was unaudited until this report.
- The file's **`card_nbr_eq_two_of_three`**, dead, named for an equality it does not prove, docstringed with two arguments it does not make, carrying a hypothesis it does not need.

**What would falsify the theorem, and what I did to look for it.** A counterexample is a nonzero real matrix $K$ that is hollow, symmetric, with every row summing to zero, and with at most three nonzero entries strictly above the diagonal. I enumerated the possibilities exhaustively by the shape of the support graph, in closed form. At one edge $\{a,b\}$, row $a$ sums to $K_{ab}\ne0$. At two edges, sharing a vertex or not, some endpoint has degree one and its row sums to that single entry. At three edges, every simple graph with three edges other than the triangle (the path on four vertices, the star, a two-edge path plus a disjoint edge, three disjoint edges), has a vertex of degree one, and the same collapse applies; the triangle survives that test and dies on $x+y=0$, $x+z=0$, $y+z=0$, whose determinant is $-2$ and whose only solution is zero. No falsifier exists, and the enumeration is complete rather than sampled. Going the other way, I screened the record's sharp witness (the four-cycle with weights $1,-1,1,-1$ at $n=4$) and it elaborates as `IsSectional` and nonzero, so four edges are attained and the theorem's constant cannot be raised.
