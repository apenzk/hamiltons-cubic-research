# Gate 2, reviewer r791, does L176Statement.lean prove L176, or a matrix theorem standing in for it?

**Cold brief.** I worked from the coordinator's Gate 2 brief for L176, held outside the repository at `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief.md`, and read [L176Statement.lean](../lean/HamiltonsCubic/Results/L176Statement.lean) line by line before reading anything in [findings/](../findings/), checking every step by hand. **No numerical work was done and every value in this report is exact.** Three **screens** were run, each an elaboration in Lean of an object I constructed for the purpose, the four-cycle at $n=4$, the emptiness of the hypothesis set at $n=2$ and $n=3$, and a restatement of one lemma with a hypothesis deleted. They are reported as screens in §6, §4 and §5.2, and no positive claim in this report rests on one. Log: [agent_logs/g2-l176-r791.log](../agent_logs/g2-l176-r791.log).

## The claim table

| # | Claim attacked | Verdict |
| --- | --- | --- |
| 1 | [IsSectional](../lean/HamiltonsCubic/Results/L176Statement.lean#L31) captures the coordinate-diagonal locus | **CONFIRMED AS ALGEBRA**, the three fields are exactly what the record derives, and the structure is a *superset* of the locus, so the Lean theorem is the stronger one; the containment itself is prose |
| 2 | [(edges K).card](../lean/HamiltonsCubic/Results/L176Statement.lean#L41) counts $\Lambda^2$-rank | **CONFIRMED AS ARITHMETIC, UNPROVED AS GEOMETRY**, the `p.1 < p.2` filter counts each unordered pair once, nothing double-counted; that this equals $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)$ appears in the file only as a comment |
| 3 | [four_le_card_edges](../lean/HamiltonsCubic/Results/L176Statement.lean#L546) is L176's conclusion | **CONFIRMED AS THE EDGE HALF**, it is $K\ne0\Rightarrow4\le\lvert E\rvert$ exactly; the degree half is present separately as [card_nbr_zero_or_two_le](../lean/HamiltonsCubic/Results/L176Statement.lean#L67), so both halves of the record's sentence are in the file |
| 4 | The theorem is non-vacuous | **CONFIRMED, WITH A CLOSED-FORM WITNESS**, vacuous at $n\le3$ because no nonzero sectional matrix exists there, non-vacuous from $n=4$, and the bound is attained |
| 5 | Every imported lemma proves what its name says | **REFUTED FOR ONE**, [card_nbr_eq_two_of_three](../lean/HamiltonsCubic/Results/L176Statement.lean#L221) is named and documented for "exactly two neighbours" and states only $\le3$; it is also dead and its hypothesis `ha` is unused |
| 6 | [card_edges_ne_three](../lean/HamiltonsCubic/Results/L176Statement.lean#L381) is correct | **CONFIRMED**, all four orientations in `far`, `far_components`, `rowsum_pair` and `nbr_eq_pair` checked; the path and star configurations are excluded by $c$'s own degree, and the three row sums are read at the right entries |
| 7 | [rowsum_pair](../lean/HamiltonsCubic/Results/L176Statement.lean#L349) establishes the off-neighbour vanishing | **CONFIRMED**, `Finset.sum_subset`'s side goal is discharged from the definition of `nbr`, not assumed |
| 8 | `four_le_card_edges` uses both `hK` and `hne` | **CONFIRMED**, `hne` enters through `card_edges_ne_zero`, `hK` through all four exclusions; no unstated hypothesis anywhere in the chain |
| 9 | [lean/INDEX.md](../lean/INDEX.md#L38) row: "the conclusion itself a theorem with no `sorry`", "the first such" | **REFUTED AS STATED**, the conclusion typed is a matrix inequality, not a statement about a Weyl tensor; the *first* claim survives |
| 10 | [findings/diagonal-half.md](../findings/diagonal-half.md#L575): "machine-checked in full", "a second proof rather than a transcription" | **SPLIT ("in full" REFUTED, "second proof" CONFIRMED**), the file contains no geometry at all, and the same bridge is called "Owed" nine rows above; but the triangle really is reached by edge membership, with no degree sum anywhere |

## One-line summary

**The Lean file is correct and proves the combinatorial core of L176 with no `sorry`, but it proves a theorem about matrices, and the record's "machine-checked in full" and the index's "the conclusion itself" both claim the geometric bridge that the record elsewhere lists as owed; one auxiliary lemma is dead, mis-named and carries an unused hypothesis.**

## 0. Conventions, fixed once

Quoted from the brief and fixed for the whole report.

- $W\ne0$ is a Weyl tensor **coordinate-diagonal in an orthonormal frame** $\{f_a\}$, with **sectional matrix** $K_{ab}=W_{abab}$.
- $G$ is the graph on $\{1,\dots,n\}$ whose edges are the pairs $\{a,b\}$ with $K_{ab}\ne0$; $E=E(G)$.
- **Degree** of $a$ in $G$ is $\#\{b:K_{ab}\ne0\}$, which is `(nbr K a).card` in the file.
- Lean indices run over `Fin n`, so the record's $\{1,\dots,n\}$ is the file's $\{0,\dots,n-1\}$; this is a relabelling and is used nowhere.
- An **edge** in the file is an ordered pair `p : Fin n × Fin n` with `p.1 < p.2`, so each unordered pair has exactly one representative.
- The record's conclusion has two clauses: **(D)** every vertex has degree $0$ or $\ge2$, and **(E)** $\lvert E\rvert\ge4$, "in particular" $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)\ge4$. The record itself says only (E) is equivalent to the rank bound.

## 1. The hypothesis inventory

Every hypothesis of the statement and of every Lean declaration the proof reaches, checked against the object it is applied to. `hK : IsSectional K` is abbreviated `S` below.

| Declaration | Hypotheses | Used? | Discharged at each call site from |
| --- | --- | --- | --- |
| [IsSectional](../lean/HamiltonsCubic/Results/L176Statement.lean#L31) | `symm`, `hollow`, `rowsum` | all three | assumed; the structure is the definition |
| [card_nbr_ne_one](../lean/HamiltonsCubic/Results/L176Statement.lean#L47) | `S`, `a` | `rowsum` only | `S` in scope |
| [card_nbr_zero_or_two_le](../lean/HamiltonsCubic/Results/L176Statement.lean#L67) | `S`, `a` | via `card_nbr_ne_one` | `S` |
| [two_le_card_nbr](../lean/HamiltonsCubic/Results/L176Statement.lean#L73) | `S`, `hab : K a b ≠ 0` | both | `hp'.2` or its symmetric image |
| [mem_edges_of_ne](../lean/HamiltonsCubic/Results/L176Statement.lean#L83) | `S`, `h : K a c ≠ 0` | `hollow`, `symm` | membership in `nbr` |
| [card_edges_ne_one](../lean/HamiltonsCubic/Results/L176Statement.lean#L95) | `S` | yes |, |
| [edgeOf_mem](../lean/HamiltonsCubic/Results/L176Statement.lean#L120) | `S`, `h : K a c ≠ 0` | `hollow` for $a\ne c$, `symm` for the reversed branch | `nbr` membership |
| [edgeOf_inj](../lean/HamiltonsCubic/Results/L176Statement.lean#L132) | `hc : c ≠ a`, `hd : d ≠ a` | **both, and both are needed**, the two mixed branches ($a<c$, $a\not<d$) close only on them | `hollow` at the call sites |
| [card_edges_ne_zero](../lean/HamiltonsCubic/Results/L176Statement.lean#L139) | `S`, `hne : K ≠ 0` | both | `hne` is `four_le_card_edges`'s own |
| [edges_eq_image](../lean/HamiltonsCubic/Results/L176Statement.lean#L160) | `S`, `ha : 2 ≤ (nbr K a).card`, `h2 : (edges K).card = 2` | all three | `two_le_card_nbr`, case hypothesis |
| [mem_edges_has](../lean/HamiltonsCubic/Results/L176Statement.lean#L182) | as above plus `he : e ∈ edges K` | all | as above |
| [card_edges_ne_two](../lean/HamiltonsCubic/Results/L176Statement.lean#L192) | `S` | yes |, |
| [triangle_forces_zero](../lean/HamiltonsCubic/Results/L176Statement.lean#L215) | `x+y=0`, `x+z=0`, `y+z=0` | all three | the three row sums |
| [card_nbr_eq_two_of_three](../lean/HamiltonsCubic/Results/L176Statement.lean#L221) | `S`, `ha : 2 ≤ (nbr K a).card`, `h3` | **`ha` UNUSED**, and the whole declaration is unused | never called, see §5.2 |
| [card_edgesAt](../lean/HamiltonsCubic/Results/L176Statement.lean#L248) | `S` | `hollow`, `symm` |, |
| [two_le_card_edgesAt](../lean/HamiltonsCubic/Results/L176Statement.lean#L286) | `S`, `hab : K a b ≠ 0` | both | at $p_1$, $p_2$ and $c$ |
| [exists_other_edge](../lean/HamiltonsCubic/Results/L176Statement.lean#L292) | `hpin`, `h2 : 2 ≤ card` | both | `edge_endpoints_deg`, `two_le_card_edgesAt` |
| [edge_endpoints_deg](../lean/HamiltonsCubic/Results/L176Statement.lean#L301) | `S`, `hp : p ∈ edges K` | both | the chosen edge |
| [far_mem_nbr](../lean/HamiltonsCubic/Results/L176Statement.lean#L315) | `S`, `he : e ∈ edgesAt K a` | `symm` in the second branch | `he2`, `he3` |
| [far_ne](../lean/HamiltonsCubic/Results/L176Statement.lean#L328) | `S`, `he` | `hollow` | `he2` |
| [far_components](../lean/HamiltonsCubic/Results/L176Statement.lean#L336) | `he` only, **no `S`** | yes | `he2`, `he3` |
| [rowsum_pair](../lean/HamiltonsCubic/Results/L176Statement.lean#L349) | `S`, `hxy : x ≠ y`, `hnbr : nbr K a = {x,y}` | all three | `nbr_eq_pair`, plus $p_1\ne p_2$, $c\ne p_1$, $c\ne p_2$ |
| [nbr_eq_pair](../lean/HamiltonsCubic/Results/L176Statement.lean#L360) | `S`, `hxy`, `hx`, `hy`, `hle : (edgesAt K a).card ≤ 2` | all five | the three subset bounds `hle1`, `hle2`, `hlec` |
| [card_edges_ne_three](../lean/HamiltonsCubic/Results/L176Statement.lean#L381) | `S` | yes |, |
| [four_le_card_edges](../lean/HamiltonsCubic/Results/L176Statement.lean#L546) | `S`, `hne : K ≠ 0` | **both** | assumed |

**Nothing in the chain uses a hypothesis that is not stated.** The only stated-and-unused hypothesis is `ha` in `card_nbr_eq_two_of_three`, and that declaration is dead (§5.2).

## 2. Does IsSectional capture the locus, and where did orthonormality go?

`IsSectional` carries three fields. Against the record's derivation at [findings/diagonal-half.md](../findings/diagonal-half.md#L569):

- **hollow**, $K_{aa}=W_{aaaa}=0$ by the antisymmetry of $W$ in its first pair. Faithful.
- **symm**, $K_{ab}=W_{abab}=W_{baba}=K_{ba}$ by pair-exchange symmetry. Faithful.
- **rowsum**, Ricci-flatness of a Weyl tensor reads $\sum_bW_{abab}=0$ for each $a$. The Lean sum runs over all of `Fin n`, including $b=a$, whose term is killed by `hollow`; so the two sums agree. Faithful.

**The direction the proof needs is `locus ⊆ IsSectional`, and that is the direction the record derives.** The Lean theorem therefore quantifies over a *superset* of the locus and is at least as strong as L176's combinatorial half. A structure that were *narrower* than the locus would be the dangerous error; this one is wider, which is safe.

**Orthonormality is doing exactly the work the record says, and it does that work outside the file.** It is what makes $K_{ab}=W_{abab}$ frame-meaningful, what makes the Ricci contraction the bare sum $\sum_bW_{abab}$ rather than a metric-weighted one, and what makes $\{f_a\wedge f_b\}_{a<b}$ an eigenbasis. Once one is handed a real matrix with the three fields, orthonormality has no further role, and the file is handed exactly that. **So it is not a hypothesis the file drops; it is a hypothesis the file never reaches.** The cost is entirely in claim 10.

**No finding on the structure itself.**

## 3. Does the edge count capture the $\Lambda^2$-rank?

Two questions, and they separate.

**Arithmetically, yes, and nothing is double-counted.** `edges K = univ.filter (fun p => p.1 < p.2 ∧ K p.1 p.2 ≠ 0)` ranges over `Fin n × Fin n`. For each unordered pair $\{a,b\}$ with $a\ne b$ exactly one of $(a,b)$, $(b,a)$ satisfies `p.1 < p.2`, so exactly one representative can be a member. Diagonal pairs $(a,a)$ fail `p.1 < p.2` and would also fail the entry test by `hollow`. **So `(edges K).card` is $\#\{\{a,b\}:a\ne b,\ K_{ab}\ne0\}=\lvert E(G)\rvert$, once each.** The reversed entry $K_{ba}$ is never counted separately, and `symm` guarantees that whichever representative is tested gives the same answer.

**Geometrically, the identification is not in the file.** The record's step is $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, so $W$ acts diagonally on the basis $\{f_a\wedge f_b\}_{a<b}$ of $\Lambda^2$ and its rank is the number of nonzero eigenvalues, $\lvert E\rvert$. **I grepped the file for every geometric word (Weyl, $\Lambda$, rank, orthonormal, frame, curvature, Ricci) and got three hits, at lines 7, 9 and 542, all three inside comments.** There is no `Λ²`, no exterior power, no linear map, and no `Matrix.rank` in the file.

So: the count is right; the sentence "and the $\Lambda^2$-rank is the number of nonzero entries above the diagonal" ([L176Statement.lean#L9](../lean/HamiltonsCubic/Results/L176Statement.lean#L9)) is an assertion in a docstring. **Verdict: CONFIRMED AS ARITHMETIC, UNPROVED AS GEOMETRY.**

## 4. Vacuity

The brief asks at what $n$ the hypotheses are satisfiable. `n` is unconstrained in the file (`variable {n : ℕ}`), and **it should not be constrained**: the statement is true at every $n$, and vacuously true below $4$ for the right reason.

By hand:

- **$n=0$**, `Matrix (Fin 0) (Fin 0) ℝ` has a unique element, so `K ≠ 0` is unsatisfiable. Vacuous.
- **$n=1$**, `hollow` gives $K_{00}=0$, so $K=0$. Vacuous.
- **$n=2$**, `hollow` gives $K_{00}=K_{11}=0$; `rowsum` at row $0$ then reads $K_{01}=0$, and `symm` gives $K_{10}=0$. So $K=0$. Vacuous.
- **$n=3$**, at most three edges are available ($\binom32=3$), and the file's own `card_edges_ne_{zero,one,two,three}` exclude all four possibilities. So $K=0$. Vacuous.
- **$n\ge4$**, the four-cycle is a witness; see §6.

**Screen.** I elaborated `vacuous_at_two` and `vacuous_at_three` (every `IsSectional K` on `Fin 2` and on `Fin 3` is $0$), in a scratch file against the built library. Both elaborate. This is a screen, run to guard the hand argument above against a slip; the hand argument is what the claim rests on.

**This is the correct shape for the lemma and not a defect.** L176's own sharpness note says the smallest support is $C_4$, which needs four vertices. A theorem vacuous exactly where the mathematics is vacuous is faithful.

**No finding.**

## 5. The imported lemmas, one by one

### 5.1 The ones that are right

- **`card_nbr_ne_one`.** If `nbr K a = {b}` then every $c\ne b$ has $K_{ac}=0$, so `Finset.sum_eq_single b` collapses $\sum_cK_{ac}$ to $K_{ab}$; `rowsum` makes that $0$, contradicting $b\in\mathrm{nbr}$. **The record's degree step, verbatim.**
- **`card_nbr_zero_or_two_le` / `two_le_card_nbr`.** `omega` from `card_nbr_ne_one`, and the contrapositive form. **This is clause (D) of the record's statement, and it is in the file.**
- **`edgeOf_inj`.** Four branches. The two mixed ones ($a<c$ but $a\not<d$, giving $(a,c)=(d,a)$), close only because `hc`/`hd` rule out $c=a$, $d=a$. **Both hypotheses are load-bearing; neither is decoration.**
- **`card_edges_ne_zero`.** A trichotomy on $a$ versus $c$: below the diagonal it uses `symm` to reverse into an edge, on it `hollow`. Faithful to "hollowness kills the diagonal and symmetry carries the rest".
- **`card_edges_ne_one`.** Shows `nbr K p.1 = {p.2}` and appeals to the degree step. The reversed branch closes because $(c,p_1)=p$ would force $p_1=p_2$ against $p_1<p_2$. Correct.
- **`card_edges_ne_two`.** Both endpoints of $p$ have degree $\ge2$, so by `mem_edges_has` every edge contains $p_1$ *and* contains $p_2$; applied to $q$ this gives four cases, of which two force $p_1=p_2$, one forces $p_2<p_1$ against $p_1<p_2$, and the last gives $q=p$ against $p\ne q$. Correct, and note it is stronger than the record's route, which reasoned through a degree sum.
- **`card_edgesAt`.** The image of `nbr K a` under `edgeOf a` is exactly `edgesAt K a`, both inclusions checked, and `edgeOf a` is injective on `nbr K a`. The reconstruction `(e.1, e.2) = e` closes by structure eta. Correct, so degree equals incident-edge count.
- **`triangle_forces_zero`.** $x+y=x+z=y+z=0$; the coefficient matrix $\begin{pmatrix}1&1&0\\1&0&1\\0&1&1\end{pmatrix}$ has determinant $-2\ne0$, as the docstring says, and `linarith` discharges each component. **Docstring and statement agree, determinant included.**

### 5.2 FINDING, `card_nbr_eq_two_of_three` is dead, mis-named, and its docstring claims a step it does not take

**Located exactly.** [L176Statement.lean#L218-L241](../lean/HamiltonsCubic/Results/L176Statement.lean#L218). The docstring reads *"**A vertex of a three-edge support has exactly two neighbours.** Its neighbours inject into the edges, so it has at most three; and the degree step forbids one, so two or three. Three would put every edge on it, which the other endpoints' degrees forbid."* The statement immediately beneath it is

```
    (nbr K a).card ≤ 3
```

**Exhibited concretely.** Three defects, each checkable at the declaration:

1. **The conclusion is $\le3$, not $=2$.** The name says `eq_two`, the bold headline of the docstring says "exactly two neighbours", and the third sentence describes an argument ("three would put every edge on it, which the other endpoints' degrees forbid") that appears nowhere in the proof body. The body is: image under `edgeOf a` is a subset of `edges K`, `card_image_of_injOn`, `omega`. That yields $\le3$ and stops. **The docstring is grander than the goal, which is the failure mode the brief names.**
2. **The hypothesis `ha : 2 ≤ (nbr K a).card` is unused.** The body never mentions it; `omega` closes from `card_le_card hsub` and `h3` alone. *Screen:* I restated the theorem with `ha` deleted and pasted the identical proof body into a scratch file; it elaborates. So `ha` is dead weight in a declaration that also gestures at the degree step in its docstring, it looks as though the degree bound is being used when it is not.
3. **The declaration is never used.** `grep` over the whole `lean/` tree finds `card_nbr_eq_two_of_three` at its own definition and nowhere else. `card_edges_ne_three` re-derives everything it needs, and does so through `edgesAt` rather than `nbr`. **Worse, once `card_edges_ne_three` is available the hypothesis `h3 : (edges K).card = 3` is itself contradictory, so the declaration is a vacuous statement about an empty hypothesis set, sitting 160 lines above the theorem that empties it.**

**The opposite argued.** The most charitable reading is that the docstring describes the *role the declaration was written to play*, the first two sentences are a correct sketch of a route to "exactly two", and $\le3$ is its first step, left in place when the route changed. On that reading nothing false is *proved*: the typed statement is true (indeed vacuously), the file still builds, and no other declaration inherits the confusion. **That defence holds for soundness and fails for the record.** A reader auditing the file sees a bolded sentence asserting "exactly two neighbours" attached to a theorem that does not say it, in a layer where a docstring grander than its goal has already been a defect once. The finding stands as a **record defect, not a soundness defect**.

**Severity: does not touch `four_le_card_edges`.** Deleting this declaration outright would leave the proof of L176 intact.

### 5.3 Two milder docstring overreaches

- **`far_mem_nbr`** ([#L313](../lean/HamiltonsCubic/Results/L176Statement.lean#L313)) is documented as *"An edge at `a` is `a` and its far endpoint, in some order, **and** the far endpoint is a neighbour of `a`"*. Only the second conjunct is its statement; the first is `far_components`, a separate theorem twenty lines below. Harmless, same class as §5.2 and much milder.
- **`edges_eq_image`** ([#L158](../lean/HamiltonsCubic/Results/L176Statement.lean#L158)) has the headline *"Every edge of a two-edge support contains any given support vertex"*, which is `mem_edges_has`'s statement, not its own (`edges K = (nbr K a).image (edgeOf a)`). The second sentence describes the actual content correctly.

Both are reported for completeness; neither affects a proof.

### 5.4 `rowsum_pair`, the `sum_subset` step is discharged, not assumed

The brief asks whether `Finset.sum_subset` establishes the off-neighbour vanishing or assumes it. **It establishes it.** The call is

```
    refine Finset.sum_subset (subset_univ _) ?_
    intro b _ hb
    simpa [nbr] using hb
```

`Finset.sum_subset` takes `s ⊆ t` and `∀ x ∈ t, x ∉ s → f x = 0` and returns $\sum_{s}f=\sum_{t}f$. Here $s=\mathrm{nbr}(a)$, $t=\text{univ}$, and the second argument is a **goal**, opened by `refine ?_` and closed by `simpa [nbr] using hb`: `hb : b ∉ univ.filter (fun b => K a b ≠ 0)` unfolds to $\lnot(b\in\text{univ}\wedge K_{ab}\ne0)$, which simp reduces to $K_{ab}=0$, **exactly the vanishing required, read off the definition of `nbr`, not postulated.** Then `Finset.sum_pair hxy` (which needs $x\ne y$, supplied) splits the two-element sum, and `hK.rowsum a` closes.

**No finding.**

## 6. `card_edges_ne_three` in detail

This is the whole of the last case and the only genuinely new argument. Setting $p=(p_1,p_2)$ with $p_1<p_2$ and $K_{p_1p_2}\ne0$, and $c=\mathrm{far}(p_1,e_2)$:

| Step | Declaration | Check |
| --- | --- | --- |
| both endpoints have degree $\ge2$ | `edge_endpoints_deg` | uses `symm` to get $K_{p_2p_1}\ne0$; correct |
| a second edge $e_2$ at $p_1$, a second $e_3$ at $p_2$ | `exists_other_edge` | erase-nonempty from card $\ge2$; correct |
| $c\ne p_1$ | `far_ne` | else $K_{p_1p_1}\ne0$ against `hollow` |
| $c\ne p_2$ | inline | if $c=p_2$: in the first orientation $e_2=(p_1,p_2)=p$ against $e_2\ne p$; in the second $e_2=(p_2,p_1)$, so $e_2.1<e_2.2$ reads $p_2<p_1$ against $p_1<p_2$. **Both orientations covered.** |
| $e_2\ne e_3$ | `h23` | $e_3$ has $p_2$ as a component; $e_2$'s components are $p_1$ and $c$, and $p_1\ne p_2$, $c\ne p_2$. Correct |
| $E=\{p,e_2,e_3\}$ | `htriple` | three distinct elements, all edges, and $\lvert E\rvert=3$ |
| $p\notin\mathrm{edgesAt}(c)$ | `hpnotc` | from $c\ne p_1$ and $c\ne p_2$ |
| $e_3$ is at $c$ | `he3c` | $c$ has a second edge $e_4\ne e_2$; $e_4\in\{p,e_2,e_3\}$ and the first two are excluded, so $e_4=e_3$ |
| $K_{p_2c}\ne0$ | `h3c` | $\mathrm{far}(p_2,e_3)=c$, both orientations of `far_components` crossed with both of $e_3$'s membership at $c$, four cases, two closing on $c\ne p_2$ |
| $e_3\notin\mathrm{edgesAt}(p_1)$, $e_2\notin\mathrm{edgesAt}(p_2)$ | `hnot3at1`, `hnot2at2` | four cases each; all close on $p_1\ne p_2$ or $c\ne p_1$ / $c\ne p_2$ |
| the three degree bounds $\le2$ | `hle1`, `hle2`, `hlec` | each incident set sits inside a two-element set, via `htriple` and the two exclusions above |
| the three row sums | `rowsum_pair` ∘ `nbr_eq_pair` | $r_1:K_{p_1p_2}+K_{p_1c}=0$, $r_2:K_{p_2p_1}+K_{p_2c}=0$, $r_3:K_{cp_1}+K_{cp_2}=0$ |
| symmetrise and solve | `hK.symm`, `triangle_forces_zero` | with $x=K_{p_1p_2}$, $y=K_{p_1c}$, $z=K_{p_2c}$ the three become $x+y=0$, $x+z=0$, $y+z=0$; the first component $x=0$ contradicts $K_{p_1p_2}\ne0$ |

**The orientations the brief warns about are all correct.** `far a e = if e.1 = a then e.2 else e.1` picks the *other* endpoint; `far_components` returns the matching pair in both orders and takes no `IsSectional`, it needs only `e.1 < e.2`, which it recovers from edge membership, and $e.1\ne a$ in the second branch, which it gets from $e.1<e.2$ and $e.2=a$. In `nbr_eq_pair` the argument order is $(x,y)=(p_2,c)$ at $p_1$, $(p_1,c)$ at $p_2$ and $(p_1,p_2)$ at $c$, and in each case the two nonvanishing witnesses handed in are the right two entries of that row. The final `rw [hK.symm p.2 p.1]` and `rw [hK.symm c p.1, hK.symm c p.2]` normalise $r_2$ and $r_3$ into the same three unknowns before `triangle_forces_zero`, **without them the three equations would be in five symbols and the appeal would not typecheck**, so a wrong orientation here would have failed loudly rather than silently.

**The case analysis is complete, and this is the point worth stating.** A three-edge graph could a priori be a triangle, a path, a star, a path plus an isolated edge, or three disjoint edges. The proof never splits on shape. Instead: $p_1$ and $p_2$ each carry a second edge (degree $\ge2$), which is what kills the star and the disjoint configurations; and the third vertex $c$ carries a second edge too, whose only remaining candidate is $e_3$, which is what kills the path $c-p_1-p_2-d$ by forcing $d=c$. **Every shape but the triangle dies of a degree-one vertex, and the triangle dies of its row sums.**

**No finding.**

## 7. Is `four_le_card_edges` L176's conclusion?

Clause by clause against the record's sentence.

| Record | Lean | Verdict |
| --- | --- | --- |
| "$W\ne0$" | `hne : K ≠ 0` | matches, at the level of $K$ |
| "coordinate-diagonal in some orthonormal frame, with sectional matrix $K_{ab}=W_{abab}$" | `hK : IsSectional K` | the *image* of that hypothesis under a translation the file does not perform (§2) |
| **(D)** "every vertex of $G$ has degree $0$ or degree $\ge2$" | `card_nbr_zero_or_two_le` | **present, as its own theorem** |
| **(E)** "$G$ has at least four edges" | `4 ≤ (edges K).card` | **present, and this is the headline theorem** |
| "in particular $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)\ge4$" | absent | asserted in the docstring at [#L542](../lean/HamiltonsCubic/Results/L176Statement.lean#L542) |

**The record's own gloss, "Only the edge bound is equivalent to the rank bound; the degree statement is strictly more than it", is honoured by the file:** both clauses are theorems, (D) at line 67 and (E) at line 546. **The headline theorem alone is (E) only**, so a reader who reads `four_le_card_edges` as "L176" gets the weaker of the two clauses; but the stronger one is fifteen lines below the structure and is what (E)'s proof runs on.

**Both `hK` and `hne` are used** in `four_le_card_edges`: `hne` enters solely through `card_edges_ne_zero`, `hK` through all four. **No finding on claim 8.**

## 8. FINDING, "machine-checked in full" and "the conclusion itself"

**Located exactly.** Two places.

1. [findings/diagonal-half.md#L575](../findings/diagonal-half.md#L575): *"**This lemma is machine-checked in full.** [L176Statement.lean] carries the locus as a structure … and `four_le_card_edges` is the conclusion itself with no `sorry`."*
2. [lean/INDEX.md#L38](../lean/INDEX.md#L38): *"**The first numbered lemma whose own conclusion is a Lean theorem with no `sorry`, at general $n$.**"*

**Exhibited concretely.** L176's conclusion, as the record states it, is a statement about a Weyl tensor: its support graph's degrees, its edge count, and *"in particular"* its $\Lambda^2$-rank. The Lean theorem's conclusion is `4 ≤ (edges K).card` for a real matrix. Two mathematical steps stand between them, both in the record's proof and neither in the file:

- **the locus identity**, a coordinate-diagonal $W$ in an *orthonormal* frame has $K$ hollow, symmetric, with vanishing row sums;
- **the rank identity**, $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, hence $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)=\lvert E\rvert$.

**The record already knows the second is owed, nine rows above the row that denies it.** [lean/INDEX.md#L37](../lean/INDEX.md#L37), the row for the *other* L176 file, reads: *"**Owed: … the locus identity $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$.**"* **So the index calls one and the same step owed at line 37 and machine-checked at line 38.** The grep of §3 confirms the file's side: three geometric words, all in comments.

**The opposite argued, and it is a strong defence.** The file's own header makes the honest claim, *"Its content needs no curvature tensor … So the lemma is a statement about matrices, and this file states it as one"*, and the record's proof agrees that the locus characterisation "is the whole of what the proof uses". [lean/INDEX.md#L422](../lean/INDEX.md#L422) is careful too: *"yes, **a matrix fact**, typed and proved"*. On the most charitable reading, "machine-checked in full" means "the whole of the difficult content, once the definitions are unwound", and that reading is defensible and probably what was meant. **It still fails on two counts.** First, "in full" and "the conclusion **itself**" are both totality words, and what was checked is a proper part. Second, the bridge is not a definitional unwinding: it is where *orthonormality* is consumed, which is precisely the hypothesis the record records both prior audits as having found unstated. **A phrase that certifies as machine-checked the one step whose omission has already been a finding twice is the wrong phrase.**

**Verdict: REFUTED AS STATED, with the theorem CONFIRMED AS ALGEBRA.** The honest form is on the record already, at INDEX line 422: *a matrix fact, typed and proved.*

**The "first such" half of the index claim survives.** [L180Statement.lean](../lean/HamiltonsCubic/Results/L180Statement.lean) proves parts (1) and (2) of L180 with no `sorry` and owes part (3); [L177Statement.lean](../lean/HamiltonsCubic/Results/L177Statement.lean) and [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) carry declared `sorry`s. So no other numbered result has its *whole* conclusion typed and proved, and [lean/INDEX.md#L434](../lean/INDEX.md#L434) states the distinction between L176 and L180 correctly.

## 9. Is the file "a second proof rather than a transcription"?

[findings/diagonal-half.md#L575](../findings/diagonal-half.md#L575) makes three sub-claims about the Lean route. Taken separately:

- **"reached there by edge membership rather than by the degree sum", TRUE.** There is no degree sum anywhere in the file: no $\sum_a\deg a=2\lvert E\rvert$, no handshake. `card_edges_ne_three` works by intersecting `edgesAt` sets with `htriple` and reading membership. The record's own proof, by contrast, argues "the degree sum is $6$ with every support degree $\ge2$, forcing exactly three vertices of degree exactly two". **Two genuinely different routes to the same triangle.**
- **"the far endpoint of one needs a second edge that can only be the other", TRUE.** That is `he3c` exactly: $c$'s second edge $e_4$ lies in $\{p,e_2,e_3\}$, and $p$ and $e_2$ are excluded.
- **"those two are distinct because a common edge would be the first one", NOT THE FILE'S REASON.** `h23` proves $e_2\ne e_3$ from the components: $e_2$'s two endpoints are $p_1$ and $c$, and neither equals $p_2$, whereas $e_3$ has $p_2$ as an endpoint. **The record's stated reason is itself a valid argument**, a common edge at $p_1$ and at $p_2$ would have $\{p_1,p_2\}$ as its endpoint set and hence *be* $p$, against $e_2\ne p$, **but it is not the argument in the file.** A reader checking the file against this sentence would look for the step and not find it.

**Verdict on claim 10: the "second proof" characterisation is accurate; one of the three reasons given for it describes an argument the file does not make.** Minor, and reported so the next reader does not spend time hunting for it.

## 10. Withdrawn candidates

- **"`edges` may double-count reversed pairs."** *Withdrawn.* The `p.1 < p.2` conjunct admits exactly one representative per unordered pair, and the diagonal fails it outright. No configuration exists at which the count exceeds $\lvert E\rvert$.
- **"`nbr K a` may contain `a`, inflating degrees by one."** *Withdrawn.* `hollow` gives $K_{aa}=0$, so $a$ fails the filter. The dependence on `hollow` is real but `hollow` is a stated field.
- **"the theorem may be vacuous at every $n$, e.g. if `IsSectional` were contradictory."** *Withdrawn in closed form*, §6's four-cycle satisfies all three fields at $n=4$ and is nonzero.
- **"`edges_eq_image` may be provable only when `(nbr K a).card = 2`, so `card_edges_ne_two` may be circular."** *Withdrawn.* `eq_of_subset_of_card_le` needs only $\lvert\text{edges}\rvert\le\lvert\text{image}\rvert$, which `omega` gets from $\lvert\text{image}\rvert=\lvert\mathrm{nbr}\rvert\ge2=\lvert\text{edges}\rvert$; the subset inclusion supplies the other direction. No circularity, and the case $\lvert\mathrm{nbr}\rvert>2$ is simply never reached because the subset forces $\lvert\mathrm{nbr}\rvert\le2$.
- **"`n` should be constrained to $n\ge4$."** *Withdrawn.* The theorem is true at every $n$ and the low cases are vacuous for the correct reason (§4); constraining $n$ would weaken it.

## 11. What would break it, and what I did to look for it

**The falsifier is a hollow symmetric real matrix with vanishing row sums, not identically zero, whose support has one, two or three edges.** Equivalently: a nonzero vector in the kernel of the unsigned incidence matrix of a simple graph with at most three edges, with every coordinate nonzero.

What I did:

- **Tried three edges by hand, exhaustively by shape.** A three-edge simple graph is one of: a triangle, a path $P_4$, a star $K_{1,3}$, a path $P_3$ plus a disjoint edge, or three disjoint edges. Every shape but the triangle has a vertex of degree one, whose row sum is its single entry and must vanish, contradiction. **The triangle** on $\{a,b,c\}$ gives $K_{ab}+K_{ac}=0$, $K_{ab}+K_{bc}=0$, $K_{ac}+K_{bc}=0$, a system with determinant $-2$, so the unique solution is $K_{ab}=K_{ac}=K_{bc}=0$, not a support. **No three-edge falsifier exists.** Two edges: a path $P_3$ or two disjoint edges, both with a degree-one vertex. One edge: two degree-one vertices. **None survives.**
- **Tried $n=4$ with the four-cycle the record calls the sharp witness, in closed form.** $K$ on the cycle $12,23,34,41$ with values $c,-c,c,-c$; every row sum is $c-c=0$, every entry on the cycle is nonzero, and the support has exactly four edges. **This is not a falsifier, it is the extremal case, and it confirms the bound is tight rather than loose.** *Screen:* I elaborated it in Lean at $c=1$, `IsSectional C4` from the three fields, `C4 ≠ 0`, and `(edges C4).card = 4` exactly, against the built library. It elaborates. Reported as a screen; the closed-form check above is what the claim rests on.
- **Looked for the failure to be hiding in the definitions rather than the proof**, since a type-correct file proving the wrong thing is the brief's stated target: §2 for `IsSectional`, §3 for `edges`, §4 for vacuity. **The one place the object is not captured is the Weyl-tensor bridge, and it is not captured because it is not attempted**, which is §8's finding, and it is a claim about the record's prose rather than about the file's mathematics.
- **Screened the build and the axioms.** `lake build` completes (9012 jobs) with no `sorry` in this file; the only warning against it is a `hd` name-shadow at line 132. `#print axioms four_le_card_edges` and `#print axioms card_edges_ne_three` both return `[propext, Classical.choice, Quot.sound]`, **no `sorryAx`, no `native_decide`, no added axiom.** `grep` finds no `sorry`, no `axiom` and no `native_decide` in the file, and `HamiltonsCubic.lean` line 299 imports it, so it is genuinely built.

## Verdict

**The file is sound. `four_le_card_edges` is a real, `sorry`-free, axiom-clean theorem at general $n$, its hypotheses are satisfiable from $n=4$ with a closed-form witness, and it proves the combinatorial content of L176 (both clause (D) and clause (E) of the record's sentence), by an argument I checked step by step and could not break.** I found no false proposition, no vacuous hypothesis, and no unstated hypothesis in the proof chain.

**Two things are wrong with what is said about it, and one small thing is wrong inside it.**

1. **REFUTED AS STATED**, "machine-checked in full" ([findings/diagonal-half.md#L575](../findings/diagonal-half.md#L575)) and "the conclusion itself" ([lean/INDEX.md#L38](../lean/INDEX.md#L38)). The file contains no geometry; the locus identity and the rank identity are prose, and the index calls the second **Owed** at line 37 while calling it checked at line 38. The correct phrase is already on the record at line 422: *a matrix fact, typed and proved*.
2. **REFUTED**, [card_nbr_eq_two_of_three](../lean/HamiltonsCubic/Results/L176Statement.lean#L221) states $\le3$ under a name and a docstring claiming *exactly two*, carries an unused hypothesis `ha`, is never used, and is vacuous once `card_edges_ne_three` is in hand.
3. **MINOR**, one of the three reasons the record gives for the Lean route ("a common edge would be the first one") describes an argument the file does not make, and two docstrings (`far_mem_nbr`, `edges_eq_image`) head a theorem with a neighbouring theorem's statement.

**None of the three touches `four_le_card_edges`.** Deleting `card_nbr_eq_two_of_three` outright and softening the two sentences would leave the proof exactly as it stands.

## Postscript, the working tree moved under this review

**Written after the report was complete, and it changes no verdict.** Everything above was checked against the committed file at `HEAD` (commit a1580d81), 554 lines, which is the file [lean/INDEX.md](../lean/INDEX.md#L38) currently describes. On finishing I found the working tree carrying an **uncommitted** modification to [L176Statement.lean](../lean/HamiltonsCubic/Results/L176Statement.lean) (made by another session while this review was running) that does exactly three things: it deletes `card_nbr_eq_two_of_three` outright, and it rewrites the docstrings of `edges_eq_image` and `far_mem_nbr` to state their own theorems.

**Those are §5.2 and §5.3, arrived at independently and in parallel.** I report it rather than fold it in, because a reviewer who silently retargets at the fix is no longer reviewing what the record points at. Read this way:

- **Findings 2 and 3 of the verdict are already repaired in the working tree**, and this review is independent corroboration that the repair is the right one, `four_le_card_edges` needs none of what was removed, which is the §5.2 severity note discharged in practice.
- **Finding 1 is untouched by that edit.** The "machine-checked in full" sentence lives in [findings/diagonal-half.md](../findings/diagonal-half.md#L575) and the "conclusion itself" row in [lean/INDEX.md](../lean/INDEX.md#L38), and neither is in the modified file. **It is the finding that survives, and it is the one that matters.**
- **The soundness verdict is unaffected either way**: nothing removed by that edit was reachable from `four_le_card_edges`, so the proof I checked is the proof that remains.
