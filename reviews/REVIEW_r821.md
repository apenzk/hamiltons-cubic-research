# r821: the fold of r820's round on L193, and the consequence nobody had checked

*Cold brief: I was given the three commits `98dea77c..HEAD` and read [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean), [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean), [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [diagonal-half.md](../findings/diagonal-half.md), [INDEX-results.md](../findings/INDEX-results.md), [lean/INDEX.md](../lean/INDEX.md), [fence-posts.md](../findings/fence-posts.md), [INDEX-traps.md](../findings/INDEX-traps.md) and [REVIEW_r820.md](REVIEW_r820.md) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation is by hand and every constant exact. Four machine actions were Lean screens on objects I constructed for the purpose, reported as screens in §6 and never as evidence for a positive claim. I was the only reviewer on this round. Log: [agent_logs/g2-l193fold-r821.log](../agent_logs/g2-l193fold-r821.log).*

| Target | Verdict |
|---|---|
| **A. `starWedge_of_adjugate` gives `StarWedgeIdentity`** | **CONFIRMED.** The `Prop` is exactly what [L184](../lean/HamiltonsCubic/Results/L184Statement.lean)'s `scalar_case_empty` needs, no weaker and no stronger. `sigma6` is the record's $\sigma$ with no factor between it and `star6`'s normalisation. The two hypotheses are jointly satisfiable at the layer's own witness, so this is not the vacuity r820 found in the predecessor. The derivation carries no `sorry` |
| **A′. "two debts become one"** | **CONFIRMED AS TYPED, one word of prose reaches further.** True of the mathematical input, one normal-form theorem serving both. **False of the Lean obligations, which remain two**: `hPf` is not derivable from `hAdj`, and the file's own docstring says so. [diagonal-half.md](../findings/diagonal-half.md)'s heading word *DISCHARGES* is stronger than its own body's *reduction* |
| **B1. `area_form_sq` replaces the vacuous theorem** | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** $\varphi_{01}^2=-(E_{00}+E_{11})$ is true, compiles free of `sorryAx`, and is the right fact. **No theorem in the file connects it to the adjugate law**, and it is stated at one plane of `Fin 6` rather than at a general plane, so *"that is where the minus comes from"* is an explanation the file does not verify. A strict improvement on the vacuous predecessor all the same |
| **B2. `adjugate_law`'s statement, and the `Id` scoping** | **CONFIRMED, and the scoping cannot bite.** The Lean is at `Fin 6`, so its `1` **is** $\mathrm{Id}_V$ with $V=\mathbb R^6$, which is what r820 asked for. It is also right at degenerate $\omega$, both sides vanishing at $\mathrm{Pf}=0$ |
| **B3. Is the `sorry`'s stated gap the real gap?** | **CONFIRMED as the gap of the chosen route.** Normal form plus $SO(6)$-equivariance is what carries an adapted-frame computation to every $X$, and stating the equivariance repairs r820's *"two load-bearing steps unstated"* in the block's prose proof. *It is the gap of that route and not the minimal obligation*: the identity is polynomial in fifteen entries, as r820 noted |
| **C1. The [lean/INDEX.md](../lean/INDEX.md) row** | **REFUTED. The row contradicts itself inside one cell, and still credits a deleted theorem.** It reads *"THE FRAME-FREE MATRIX STATEMENT IS NOT TYPED"* and closes *"statement: typed, proof owed on the normal form"*. `adjugate_law_sign` was deleted in `c3af3719` and the row still names it. **Three consecutive commits have now left this row saying something false, and the commit that named the failure repeated it** |
| **C2. The module docstring of [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean)** | **REFUTED. The file says its own matrix statement is not typed, sixty lines above typing it.** The header reads *"The frame-free matrix statement is NOT typed"*, while `adjugate_law`'s own docstring reads *"a reviewer typed this to show it"* |
| **C3. The [INDEX-results.md](../findings/INDEX-results.md) row** | **REFUTED. It still carries the claim r820 refuted**, *"the only relation the record carries between a form's SQUARE and its ADJUGATE"*. The repair landed in [diagonal-half.md](../findings/diagonal-half.md) and never in this file, in a commit whose own body names the refutation |
| **C4. Has the stale-row failure spread?** | **NO, and the check is exhaustive.** Every backticked identifier in [lean/INDEX.md](../lean/INDEX.md) matched against every declaration in the Lean tree leaves exactly one dangling name, `adjugate_law_sign`, in L193's row |
| **C5. F63's arithmetic** | **CONFIRMED, independently derived.** $\max\sum\lambda^3=(r-2)/\sqrt{r(r-1)}$ subject to $\sum\lambda=0$, $\sum\lambda^2=1$ over $r$ nonzero eigenvalues, strictly increasing with supremum $1$ never attained. Cross-checked at $r=3$ by a second route. The conclusion the post draws is the one its figures support |

**One line.** *The mathematics of the fold is sound: the debt reduction is real, it is derived rather than asserted, its hypotheses are satisfiable at the layer's own witness, and F63's constant is right to the last figure. **Every defect is in the record's description of what was done**, and all three are the same defect: a repair made in one file and not in its siblings. The [lean/INDEX.md](../lean/INDEX.md) row now contradicts itself inside one cell, [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean)'s header denies what its own body types, and [INDEX-results.md](../findings/INDEX-results.md) still carries a sentence a reviewer refuted and a commit body announced as fixed.*

## 0. Conventions, read off the layer rather than from the block

- `phi i j = Matrix.single j i 1 - Matrix.single i j 1` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), so $(\varphi_{01})_{01}=-1$ and $(\varphi_{01})_{10}=+1$. Writing $j$ for the $2\times2$ block $\begin{psmallmatrix}0&-1\\1&0\end{psmallmatrix}$, $j^2=-\mathrm{Id}_2$.
- `wedgeSelf X abcd = 2(X_{ab}X_{cd} - X_{ac}X_{bd} + X_{ad}X_{bc})`, [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 106 with `wedgeSelf_apply`.
- `star6 T a b = (1/24)·Σ_{cdef} levi6(a,b,c,d,e,f)·T_{cdef}`, line 618, and `levi6` at line 602 is the product of `sgnR` over all fifteen ordered pairs, which is the permutation sign on a permutation of $0\ldots5$ and $0$ elsewhere. In particular $\mathrm{levi6}(0,1,2,3,4,5)=+1$, every factor being `sgnR x y = 1` at $x<y$.
- `pf6 X = triple6 X X X` at $1/48$, [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean) line 36.
- `sigma6 X = (1/2) • star6 (wedgeSelf X)`, which is the record's $\sigma(\omega)=\tfrac12\star(\omega\wedge\omega)$ read through those three normalisations.

## 1. Target A, located and recomputed

**Located.** `starWedge_of_adjugate` at [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) line 92, `StarWedgeIdentity` at [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 693, `scalar_case_empty` at [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean) line 155.

### 1.1 Is there a factor between `sigma6` and the record's $\sigma$?

**There is not, and the way to see it is to recompute the identity in the layer's own signs rather than in the block's.** Put $X=s_1\varphi_{01}+s_2\varphi_{23}+s_3\varphi_{45}$, so the matrix entries are $X_{01}=-s_1$, $X_{23}=-s_2$, $X_{45}=-s_3$ with their skew partners.

At $(a,b)=(0,1)$ only $\{c,d,e,f\}=\{2,3,4,5\}$ contributes to `star6`. On that set $X$ is $s_2\varphi_{23}+s_3\varphi_{45}$, so `wedgeSelf X 2 3 4 5` $=2(X_{23}X_{45}-X_{24}X_{35}+X_{25}X_{34})=2s_2s_3$, the last two products vanishing. Both `levi6` and `wedgeSelf` are totally antisymmetric in those four slots, so all $24$ permutations contribute the same value and the $1/24$ cancels the count exactly:

$$\big(\star(X\wedge X)\big)_{01}=\mathrm{levi6}(0,1,2,3,4,5)\cdot 2s_2s_3=2s_2s_3,\qquad (\mathrm{sigma6}\,X)_{01}=s_2s_3.$$

So in the $\varphi$ basis $\mathrm{sigma6}\,X=\sum_j t_j\varphi$ with $t_1=-s_2s_3$, the block being $-s_2s_3\,j$ against $X$'s $s_1 j$. Their product on that plane is $-s_1s_2s_3\,j^2=+s_1s_2s_3\,\mathrm{Id}_2$, the same on all three.

**And `pf6` carries the matching sign.** The $48$ nonzero terms of $\mathrm{triple6}\,X\,X\,X$ are the $3!$ block orders times the $2^3$ within-pair orientations, each equal to $\mathrm{levi6}(0,1,2,3,4,5)\,X_{01}X_{23}X_{45}=-s_1s_2s_3$: a within-pair swap flips `levi6` and the entry together, and a block transposition is an even permutation of six slots. So $\mathrm{pf6}\,X=-s_1s_2s_3$ and

$$X\cdot\mathrm{sigma6}\,X=+s_1s_2s_3\,\mathrm{Id}_6=-(\mathrm{pf6}\,X)\,\mathrm{Id}_6.$$

**`adjugate_law` is therefore true as typed, in the layer's own signs, with no factor hiding between `sigma6` and $\sigma$.** The apparent sign difference against [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean)'s `sigma` and `pf` is the $\varphi$ basis against the record's $e$ basis, $e_{12}=-\varphi_{01}$: setting $u_j=-s_j$ turns the coefficients above into $(u_2u_3,u_1u_3,u_1u_2)$ and $\mathrm{pf6}$ into $u_1u_2u_3$, which are `sigma` and `pf` on the nose. **Both conventions are internally consistent and neither leaks into the other.**

### 1.2 Does `StarWedgeIdentity` say what L184 case 2 needs?

**Yes, exactly, and the check is that case 2 uses it through one lemma.** The `Prop` is

```
∀ J, IsComplexStructure J → ∃ eps, (eps = 1 ∨ eps = -1) ∧ star6 (wedgeSelf J) = (2 * eps) • J
```

and `scalar_case_empty` consumes `hSW` only at line 173, through `pm_of_eq_wedgeSelf` ([SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 703). That lemma opens the existential twice and uses the four sign cases to cancel a common factor $2$. **It needs the $\pm1$ and it needs nothing else**: no well-definedness of $\epsilon_J$ as a function of orientation, no two-orbit fact, no injectivity of $\star$. So the existential form is not a weakening for this consumer, and the record's own note that *"the two-orbit fact behind $\epsilon_J$'s well-definedness has no computation on file"* names a debt that case 2 never draws on.

*Argued the opposite.* If the `Prop` were weaker than the record's identity in a way case 2 felt, the tell would be a use of `hSW` outside `pm_of_eq_wedgeSelf`, or a use of $\epsilon_J$'s value. There is neither: `hSW` appears once in the file, and `starWedge_of_adjugate` in fact **strengthens** what is delivered by naming $\epsilon_J=\mathrm{Pf}(J)$ inside the existential witness.

### 1.3 Is $\mathrm{Pf}(J)=\pm1$ immediate from the normal form?

**Yes, at the cost of two lines on top of what `adjugate_law` already owes.** In a frame adapted to $J$, $J=\sum_j c_j\varepsilon_j$ and $J^2=-\mathrm{Id}$ reads $c_j^2=1$ blockwise, so $\mathrm{Pf}(J)=\pm c_1c_2c_3=\pm1$. The equivariance that carries this back is the $SO(6)$-equivariance of `pf6`, which `adjugate_law`'s `sorry` already names. **So the claim that one normal-form theorem serves both debts is right.**

*Argued the opposite, twice.* First, there is a cheaper route that does not need the normal form at all: `IsComplexStructure.orthogonal` gives $J J^{\mathsf T}=1$, hence $\det J=\pm1$, and $\mathrm{Pf}^2=\det$ forces $\mathrm{Pf}(J)=\pm1$ over $\mathbb R$. That route needs $\mathrm{Pf}^2=\det$, which the layer does not carry either, so it substitutes one absent theorem for another and does not make the claim wrong. Second, and this is the real limit of the claim: **in Lean the two obligations remain two.** `starWedge_of_adjugate` takes `hAdj` and `hPf` separately, and discharging `hAdj` discharges nothing of `hPf`. The file's docstring is honest about this, *"neither the adjugate law nor `Pf(J) = ±1` is proved in this layer"*, and so is the [lean/INDEX.md](../lean/INDEX.md) clause. **The only place the word reaches further than the fact is [diagonal-half.md](../findings/diagonal-half.md)'s heading *AND IT DISCHARGES L184'S STANDING HYPOTHESIS-DEBT***, whose own body two sentences later says *"the reduction is typed"*. At the record's level, where L193 has a complete prose proof, *discharges* is defensible. It is worth one caveat that L193 is itself marked *Gate 2 owed* in [INDEX-results.md](../findings/INDEX-results.md), so L184 case 2 now leans on a lemma whose gate has not closed.

### 1.4 The vacuity test the predecessor failed

**This is where r820's finding could have repeated itself.** `adjugate_law_sign` was true and empty because `c * c = -1` has no real solution. A conditional theorem with two matrix hypotheses can fail the same way if the hypotheses are jointly unsatisfiable, and here they would be if `star6`'s $1/4!$, `wedgeSelf`'s $2$ and `pf6`'s $1/48$ did not agree.

**They agree, and the layer's own witness shows it.** `stdJ6_isComplexStructure` ([SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 671) exhibits $J=\varphi_{01}+\varphi_{23}+\varphi_{45}$. Screened (§6): `star6 (wedgeSelf stdJ6) 0 1 = 2` and row $0$ of `stdJ6` is $(0,-1,0,0,0,0)$. So `StarWedgeIdentity` at `stdJ6` forces $2=(2\epsilon)(-1)$, that is $\epsilon=-1$, uniquely. And `adjugate_law` at `stdJ6` gives, using the proved `star6_isSkew` for the $(1,0)$ entry,

$$-(\mathrm{pf6}\,\mathrm{stdJ6})=(\mathrm{stdJ6}\cdot\mathrm{sigma6}\,\mathrm{stdJ6})_{00}=\mathrm{stdJ6}_{01}\cdot(\mathrm{sigma6}\,\mathrm{stdJ6})_{10}=(-1)\cdot(-1)=1,$$

so $\mathrm{pf6}(\mathrm{stdJ6})=-1$, which satisfies `hPf` and equals the $\epsilon$ the conclusion forces. **The two hypotheses are simultaneously satisfiable at a witness the layer already proves is a complex structure, and the constants line up in all three places at once.** This matches §1.1's hand value $\mathrm{pf6}=-s_1s_2s_3=-1$.

### 1.5 Does the derivation itself hold up?

**Yes, line by line.** From `hAdj` at $J$: $J\,\sigma_6(J)=-\mathrm{Pf}(J)\,\mathrm{Id}$. Left-multiplying by $-J$ and using $J^2=-1$ gives $\sigma_6(J)=\mathrm{Pf}(J)\,J$, and `sigma6`'s $\tfrac12$ turns that into $\star(J\wedge J)=(2\,\mathrm{Pf}(J))\cdot J$. `hPf` supplies the $\pm1$ clause. **The axiom screen confirms the implication is unconditional**: `starWedge_of_adjugate` depends on `propext`, `Classical.choice` and `Quot.sound` and **not** on `sorryAx`, while `adjugate_law` does depend on `sorryAx`. So the `sorry` in the same file does not leak into the reduction.

## 2. Target B, the repairs to r820's findings

### 2.1 `area_form_sq`

**Located** at line 47. It states $\varphi_{01}\varphi_{01}=-(E_{00}+E_{11})$ in `Matrix (Fin 6) (Fin 6) ℝ`.

**True.** $(\varphi_{01}^2)_{00}=(\varphi_{01})_{01}(\varphi_{01})_{10}=(-1)(1)=-1$, likewise at $(1,1)$, and every other entry vanishes because $\varphi_{01}$ is supported on the $\{0,1\}$ block. It compiles free of `sorryAx` (§6).

**Is it the fact the sign actually comes from?** Yes in substance and no in the file's own economy. The minus in $\omega\,\sigma(\omega)=-\mathrm{Pf}(\omega)\mathrm{Id}$ is $j^2=-\mathrm{Id}_2$ plane by plane, as §1.1 recomputes, and $\varphi_{01}^2=-\Pi_{01}$ is that fact for one plane. **But nothing in the file joins it to the adjugate law.** `adjugate_law` is a `sorry`, `adjugate_law_plane` is a scalar identity with no minus in it, and no theorem takes `area_form_sq` as an input. It is also stated at the single plane $\{0,1\}$ rather than at `areaForm u v`, for which [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) already carries the general statement `areaForm_sq_of_orthonormal` at line 297.

*Argued the opposite.* An anchor that stands alone is still worth having, and this one is honest where its predecessor was empty: the docstring says outright that the earlier version was vacuous and names the reviewer's opposite-sign compilation. **The verdict is that the repair is real and the docstring's *"that is where the minus in $\omega\sigma(\omega)=-\mathrm{Pf}(\omega)\mathrm{Id}$ comes from"* describes a derivation the file does not contain.**

### 2.2 `adjugate_law`, and the `Id` scoping

**Located** at line 76.

**The statement matches the block's Statement.** [diagonal-half.md](../findings/diagonal-half.md) has *"with $\sigma(\omega)=\tfrac12\star(\omega\wedge\omega)$ the Pfaffian adjugate, $\omega\,\sigma(\omega)=-\mathrm{Pf}(\omega)\mathrm{Id}_6$ as a product of skew matrices, at every $\omega$"*, and the Lean is that at `Fin 6` with `IsSkew X` as the hypothesis, `sigma6` as $\sigma$ and `pf6` as $\mathrm{Pf}$.

**The scoping r820 flagged cannot bite here.** The block's caveat is that at $V\subsetneq\mathbb R^n$ the right side is $\mathrm{Id}_V$ and not $\mathrm{Id}_n$, both sides vanishing off $V$. The Lean's ambient is `Fin 6` and the identity is stated there, so $V=\mathbb R^6$ and the layer's `1` **is** $\mathrm{Id}_V$. The reduction of a six-dimensional $V\subseteq\mathbb R^n$ is left to the consumer, exactly as `star6`'s own docstring says at line 610.

**And it is right at degenerate $\omega$ too**, which is where a statement of this shape usually breaks. At $s_3=0$ the adjugate is supported on the third plane alone, where $\omega$ vanishes, so both sides are $0$. No rank hypothesis is missing.

**Is the `sorry`'s stated gap the real gap?** The docstring names the real skew normal form together with the $SO(6)$-equivariance of $\star$, $\wedge$ and $\mathrm{Pf}$. That is what carries §1.1's adapted-frame computation to every $X$, and naming the equivariance is a genuine improvement on the record's prose proof, where r820 found it unstated. **Two qualifications.** The equivariance is what the block leaves out, so the file now states more than the record's own proof does. And it is the gap of *this route*: as r820 observed, the identity is polynomial in the fifteen entries, so a normal form is one proof and not an obligation. *"The `sorry` is the normal form and nothing else"* is right about the intended proof and reads as a statement about the minimum.

## 3. Target C, the rows

### 3.1 The [lean/INDEX.md](../lean/INDEX.md) row contradicts itself, and the fixing commit repeated the failure it named

**Located** at [lean/INDEX.md](../lean/INDEX.md) line 89. One cell carries both of these:

> **THE FRAME-FREE MATRIX STATEMENT IS NOT TYPED, AND WHAT IT NEEDS IS NAMED**: a normal-form theorem for skew matrices, which would carry the pair-spectrum identity to `Matrix (Fin 6) (Fin 6) ℝ`.

> **statement: typed, proof owed on the normal form**

**The first is false.** `adjugate_law` is at `Matrix (Fin 6) (Fin 6) ℝ`, and the carry the sentence says has not happened is what the theorem's own type is. **The row also still credits `adjugate_law_sign`**, deleted in the same commit that wrote `area_form_sq`.

**The diff shows how it survived.** Commit `8789f3f6`, whose subject is *"L193's row said the matrix statement was owed, and recorded no debt reduction"*, changes exactly one line. It appends the debt-reduction clause and rewrites the closing tag from *"statement: partial, the matrix form owed on a normal-form theorem"* to *"statement: typed, proof owed on the normal form"*, and leaves the bold-caps sentence and the dead theorem name in the middle of the line untouched. **Its own body diagnoses the failure mode, *"a scripted edit that asserts and then dies leaves the commit looking complete"*, and the commit ships the same row still wrong in a second place.** Three consecutive commits have now left this row false.

*Argued the opposite.* Could *not typed* be read as *not proved*, making the sentence a clumsy but true statement about the proof? No. The same cell distinguishes statement from proof in its closing tag, and its explanatory clause is specifically about the type, *"which would carry the pair-spectrum identity to `Matrix (Fin 6) (Fin 6) ℝ`"*. Commit `c3af3719`'s own body settles it: *"the row called the frame-free matrix STATEMENT blocked on a normal-form theorem. Wrong."*

### 3.2 The file's own header denies what the file types

**Located** at [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) lines 15 to 18:

> **The frame-free matrix statement is NOT typed, and what it needs is named**: every skew matrix has a normal frame, which is the theorem that would carry the pair-spectrum identity to `Matrix (Fin 6) (Fin 6) ℝ`.

Sixty lines below, `adjugate_law` is that statement, and its docstring reads *"The row for this result previously called the STATEMENT blocked, which was wrong ... a reviewer typed this to show it"*. **The file contradicts itself, and the header is the half a reader meets first.** The diff of `c3af3719` confirms the header was never touched.

### 3.3 [INDEX-results.md](../findings/INDEX-results.md) still carries a claim r820 refuted

**Located** at [INDEX-results.md](../findings/INDEX-results.md) line 212:

> **It is the only relation the record carries between a form's SQUARE and its ADJUGATE**, which is where a proof tying Ricci-flatness to first Bianchi would start.

**[diagonal-half.md](../findings/diagonal-half.md) was repaired and this row was not.** The block now reads *"It is the relation the record carries in a usable matrix form; [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) carries two others ... and an earlier version of this box called it the only one"*. Commit `c3af3719`'s body announces the refutation, *"`the only relation between a form's square and its adjugate` is false"*, and its file list is [INDEX-traps.md](../findings/INDEX-traps.md), [diagonal-half.md](../findings/diagonal-half.md), the Lean file and [reviews/INDEX.md](INDEX.md). [INDEX-results.md](../findings/INDEX-results.md) is not among them.

**Exhibited independently rather than taken from r820.** `StarWedgeIdentity` at [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 693 relates $\star(J\wedge J)$, which is $2\sigma(J)$, to $J$ under a hypothesis on $J^2$. And `Phi_areaForm_of_orthonormal` at line 322 bundles both components at the decomposable locus at once, $\varepsilon^2=-\Pi$ from `areaForm_sq_of_orthonormal` at line 297 together with $\varepsilon\wedge\varepsilon=0$, hence $\sigma(\varepsilon)=0$, from `wedgeSelf_areaForm` at line 317. Two relations, in the layer, before L193.

**The same row's Lean column is stale in the other direction**, recording that *"the pair-spectrum identity and the agreement of the three planes are typed ... the frame-free matrix form needs a normal-form theorem"*, with no mention of `adjugate_law` and none of the debt reduction.

### 3.4 The sweep for the same failure elsewhere

**The brief asked whether the scripted-replacement failure left other rows stale, so I checked every row rather than L193's.** I extracted all $280$ backticked identifiers from [lean/INDEX.md](../lean/INDEX.md) and matched them against every `theorem`, `lemma`, `def`, `abbrev`, `structure`, `inductive`, `instance` and `class` declared anywhere under [lean/HamiltonsCubic/](../lean/HamiltonsCubic/). Eighty-five names did not match, and inspecting all eighty-five leaves **exactly one genuine dangling declaration: `adjugate_law_sign`, in L193's row.** The residue is prose words, local hypothesis names, tactic names, Mathlib lemmas, and one structure field, `IsWeight.symm`, which is real and lives at [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) line 154 where the regex could not see it. **So the failure has not spread past L193.**

*Noted, outside my range.* Commit `ee8f134e` adds a hook that reports backticked identifiers an added `INDEX.md` row's file does not carry. It fires on **added** rows, so the row it was built for stays wrong until someone edits it.

### 3.5 F63, derived independently

**Located** at [fence-posts.md](../findings/fence-posts.md) line 434 and [INDEX-traps.md](../findings/INDEX-traps.md) row 63.

**The claim.** Subject to $\sum_\alpha\lambda_\alpha=0$ and $\sum_\alpha\lambda_\alpha^2=1$ over $r$ nonzero eigenvalues, $\max\sum_\alpha\lambda_\alpha^3=(r-2)/\sqrt{r(r-1)}$, attained at one large positive against $r-1$ equal negatives.

**Derived.** At that configuration, $\lambda_1=a$ and $\lambda_2=\cdots=\lambda_r=b$ with $a+(r-1)b=0$, so $b=-a/(r-1)$. The norm constraint gives $a^2\big(1+\tfrac1{r-1}\big)=a^2\tfrac r{r-1}=1$, so $a=\sqrt{(r-1)/r}$. Then

$$\sum\lambda^3=a^3-\frac{(r-1)a^3}{(r-1)^3}=a^3\frac{(r-1)^2-1}{(r-1)^2}=a^3\frac{r(r-2)}{(r-1)^2}=\frac{(r-1)^{3/2}}{r^{3/2}}\cdot\frac{r(r-2)}{(r-1)^2}=\frac{r-2}{\sqrt{r(r-1)}}.$$

**And the configuration is the maximiser, which the post asserts and does not argue.** At a constrained maximum the Lagrange condition $3\lambda_i^2=a+2b\lambda_i$ makes every $\lambda_i$ a root of one quadratic, so the spectrum takes at most two values, $p$ entries at $x>0$ and $q=r-p$ at $y<0$. The two constraints give $y=-\sqrt{p/(qr)}$ and $x=\sqrt{q/(pr)}$, whence

$$\sum\lambda^3=px^3+qy^3=\frac{q^2-p^2}{\sqrt{pq}\,r^{3/2}}=\frac{q-p}{\sqrt{pqr}},$$

which at $p=1$ is $(r-2)/\sqrt{r(r-1)}$. **It is largest there**: raising $p$ shrinks the numerator $r-2p$ and grows $\sqrt{p(r-p)}$ throughout $p\le r/2$, and beyond $r/2$ the numerator is negative. So the post's *"one large positive eigenvalue against $r-1$ equal negatives"* is the extremum and not merely a configuration attaining the stated value.

**Every figure in the post checks.** $0$ at $r=2$; $1/\sqrt6$ at $r=3$; then $2/\sqrt{12}\approx0.5774$, $3/\sqrt{20}\approx0.6708$, $4/\sqrt{30}\approx0.7303$, strictly increasing, and $(r-2)/\sqrt{r^2-r}\to1$ with the supremum never attained. **Cross-checked at $r=3$ by a second route**: $\sum\lambda=0$ makes $\sum\lambda^3=3\lambda_1\lambda_2\lambda_3$, and $(2,-1,-1)/\sqrt6$ gives $6/6^{3/2}=1/\sqrt6$ with $\sum\lambda^2=1$. **CONFIRMED.**

**And the conclusion the post draws is the one its figures support.** $P(W)=\langle W,Q(W)\rangle$ splits as $\operatorname{tr}W^3$ plus the sharp term $\langle W,W^\#\rangle$ ([problem.md](../findings/problem.md) lines 104 and 114), so a ceiling on $\operatorname{tr}W^3$ that *rises* with $r$ is a route pointing the wrong way, which is what the post says and all it says. **The post's wording is careful in exactly the place where this kind of claim usually goes wrong**: it says the ceiling rises, never that the value does.

*The half I could not check from figures.* The independent leg, *"the sphere products are high-rank and carry $\theta$ up to $\sqrt2$"*, rests on two record facts rather than on arithmetic of mine. $\theta_0(n)^2=2(n-1)(n-2)/n^2\uparrow2$, so $\theta_0\uparrow\sqrt2$ and passes $\sqrt{3/2}$ at $n=12$, which [conventions.md](../findings/conventions.md) and [problem.md](../findings/problem.md) both carry. The high rank is corroborated by the record's own trap table, [INDEX-traps.md](../findings/INDEX-traps.md) row W1 recording that sphere products have $\ker W=0$, hence full $\Lambda^2$-rank. **Neither is a number I recomputed, and the post would survive without that leg in any case**, the spectral argument alone establishing what it claims about the route.

## 4. What would falsify each target, and what I did to look for it

| Target | The falsifier | What I did |
|---|---|---|
| **A** | `StarWedgeIdentity` weaker than case 2 needs, or a factor between `sigma6` and `star6` making `hAdj` and `hPf` jointly unsatisfiable, so the theorem is r820's vacuity again | Read every use of `hSW` in [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean); recomputed $\star$, $\wedge$ and $\mathrm{Pf}$ from `levi6`, `star6` and `triple6` in the layer's own signs (§1.1); screened the constants at `stdJ6`, where the conclusion forces $\epsilon=-1$ and `hAdj` forces $\mathrm{pf6}=-1$, which agree (§1.4); screened the axiom list, finding no `sorryAx` in the reduction |
| **A′** | `hPf` not obtainable from what `adjugate_law` owes, making *"two debts become one"* false | Derived $\mathrm{Pf}(J)=\pm1$ from the normal form in two lines, and found a second route through $\mathrm{Pf}^2=\det$ that the layer also lacks; separated the mathematical claim, which holds, from the Lean obligations, which stay two |
| **B1** | `area_form_sq` false, or a different true statement standing in for the one the sign comes from | Computed $\varphi_{01}^2$ entrywise; searched the file for any consumer of `area_form_sq` and found none; compared against the general `areaForm_sq_of_orthonormal` already in the layer |
| **B2** | `adjugate_law` stating something other than the block's Statement, the `Id` scoping wrong, or the statement failing at degenerate $\omega$ | Compared the Lean type against the block's display term by term; checked that `Fin 6` makes the ambient $V$ itself, so $\mathrm{Id}_V$ is what is written; evaluated both sides at $s_3=0$ |
| **B3** | The `sorry` naming a gap other than the one the proof has | Reconstructed the adapted-frame proof and asked what carries it to every $X$; confirmed that is normal form plus equivariance, and noted it is the route's gap and not the minimal one |
| **C1, C2, C3** | The rows being right and my reading of them uncharitable | Quoted each from disk at HEAD rather than from a commit body; read the diffs of all three commits to see which clauses were touched; looked for a reading of *not typed* that survives, and the commit bodies close it off |
| **C4** | The same staleness elsewhere in the index | Matched all $280$ backticked identifiers in [lean/INDEX.md](../lean/INDEX.md) against every declaration in the tree and inspected all $85$ non-matches by hand |
| **C5** | F63's constant wrong, or the extremal configuration not extremal | Derived the two-value structure from the Lagrange condition, the constant from it, and checked that $p=1$ is where it peaks; cross-checked $r=3$ through $\sum\lambda^3=3\lambda_1\lambda_2\lambda_3$; tabulated $r=2\ldots6$ and the limit; checked the conclusion against the $P=\operatorname{tr}W^3+\langle W,W^\#\rangle$ split the record carries |

## 5. What is owed

1. **Delete the sentence *"THE FRAME-FREE MATRIX STATEMENT IS NOT TYPED, AND WHAT IT NEEDS IS NAMED"* from [lean/INDEX.md](../lean/INDEX.md) line 89, and replace `adjugate_law_sign` there with `area_form_sq`.** The row's closing tag is already right and the middle of the row contradicts it.
2. **Rewrite the *"NOT typed"* paragraph in [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean)'s module docstring** to say what the file now holds: the matrix statement typed, the proof owed on the normal form, and the pair-spectrum identity as the frame the proof works in.
3. **Carry `c3af3719`'s repair into [INDEX-results.md](../findings/INDEX-results.md) line 212.** The *"only relation"* clause is refuted and the Lean column records neither `adjugate_law` nor the debt reduction.
4. **Consider softening [diagonal-half.md](../findings/diagonal-half.md)'s heading word *DISCHARGES* to match its own body**, or note beside it that L193's own Gate 2 is open, since L184 case 2 now leans on it.

## 6. The screens, reported as screens

Four machine actions, all Lean, on objects I constructed or on the layer's own witness, none of them evidence for a positive claim.

1. **`#print axioms`** on the five declarations of [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean). `adjugate_law_plane`, `adjugate_law_agree`, `area_form_sq` and `starWedge_of_adjugate` depend on `propext`, `Classical.choice` and `Quot.sound` only. `adjugate_law` additionally depends on `sorryAx`. **So the debt reduction does not inherit the file's `sorry`.**
2. **`star6 (wedgeSelf stdJ6) 0 1 = 2`**, compiled clean by `simp only` on the definitions plus `norm_num`.
3. **Row $0$ of `stdJ6` is $(0,-1,0,0,0,0)$**, compiled clean.
4. **`pf6 stdJ6 = -1` did not land.** Two attempts exceeded `simp`'s step budget on the $6^6$-term contraction, and the configuration syntax for raising it is not accepted by this toolchain. **The value rests on §1.1's hand computation and on §1.4's consistency argument, which reaches it from screens 2 and 3 together with the proved `star6_isSkew`.** No claim in this report rests on the unlanded screen.

Scratch files were removed after use and nothing outside this report is staged.
