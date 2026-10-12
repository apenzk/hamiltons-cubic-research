# Review r1605: L126 stated as one theorem (commit cf045d7e) and L265's Weyl clause with spanVec_ne_zero (commit 32d26f0c)

**Standfirst.** [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean) states Lemma L126 as two theorems, `L126_general` at a Weyl diagonal weight and `L126_sphere` at a unit $S^p\times S^q$, and the L126 row of [lean/INDEX.md](../lean/INDEX.md#L482) now reads **proved** with *statement: typed*. Both theorems are faithful compositions of the proved `L126*.lean` pieces, both modules build, and the audit gives 2/2 and 2/2 on the standard three. Every clause of the record's statement has a sorry-free Lean counterpart on the standard three, so **"proved" is the right state for the row**. The file is a capstone that leaves three of the record's clauses to their own files: orbit-freeness, the identification $\ker DF(M)=E_{1/2}(L_e)$, and the reading of the sphere product's kernel clause as a derivative. It also states the sphere product's kernel clause for one vector per block, where the record's "met only at $S^3\times S^3$" is a statement about the whole block. A screen composes that block-level form in about ten lines from `L126_general`, `L126_threshold` and `recip_iff_three_three`. `L265_weyl_clause` is correct and is exactly the second clause of `L265_I_sharp`. `spanVec_ne_zero` is correct.

| Claim | Verdict |
|---|---|
| A-1. $DF(M)=\theta(2L_e-\mathrm{Id})$ on the tangent space | **CONFIRMED WITH GAPS** (in L126Kernel, restated in L126Main only along four-set Bianchi directions) |
| A-2. $\ker DF(M)$ is the $\tfrac12$-eigenspace of $L_e$ | **CONFIRMED WITH GAPS** (`critMap_kernel_iff`, absent from L126Main) |
| A-3. A four-set block meets it exactly when $\Sigma=\theta^2$ | **CONFIRMED** (`L126_general` first conjunct, at $\theta=P(M)$) |
| A-4. Orbit-freeness | **CONFIRMED WITH GAPS** (proved in L126Orbit, absent from L126Main) |
| A-5. At $S^p\times S^q$ the nonzero four-set blocks are the $(2,2)$-splits, common value $\mu_{p,q}$ | **CONFIRMED** |
| A-6. $\mu_{p,q}=\tfrac12\iff(p,q)=(3,3)$, and the block meets the kernel only there | **CONFIRMED WITH GAPS** (block-level form not stated, composes in a screen) |
| A-7. Scope limits acceptable and disclosed | **CONFIRMED WITH GAPS** (unit norm and the omitted clauses not in the scope note) |
| A-8. `L265_weyl_clause` against findings' L265 | **CONFIRMED** |
| A-9. `spanVec_ne_zero` | **CONFIRMED** |
| B. Build and axiom audit | **CONFIRMED** |
| C. Downstream text | **CONFIRMED WITH GAPS** |
| D. Style | **CONFIRMED WITH GAPS** |

**Summary:** L126 is proved clause by clause on the standard three and the row's **proved** stands, but L126Main is a two-theorem capstone that omits three clauses and the block-level sphere form, and the sibling statement row still points to an owed list that no longer exists.

## 1. Files and commits

- [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean), new in cf045d7e: `L126_general` ([line 29](../lean/HamiltonsCubic/Results/L126Main.lean#L29)) and `L126_sphere` ([line 46](../lean/HamiltonsCubic/Results/L126Main.lean#L46)).
- [I117Sharp.lean](../lean/HamiltonsCubic/Results/I117Sharp.lean), new in 32d26f0c: `sharpB_eq_sharpCross` and `L265_weyl_clause` ([line 35](../lean/HamiltonsCubic/Results/I117Sharp.lean#L35)).
- [L126GenBridge.lean:152](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L152), `spanVec_ne_zero`, new in 32d26f0c.
- [lean/INDEX.md:482](../lean/INDEX.md#L482) (L126 row), [lean/INDEX.md:483](../lean/INDEX.md#L483) (L126 statement row), [lean/INDEX.md:116](../lean/INDEX.md#L116) (L265 row).
- Statements read against: `critMap_hasDerivAt` and `critMap_kernel_iff` ([L126Kernel.lean:75](../lean/HamiltonsCubic/Results/L126Kernel.lean#L75)), `LeLin` ([L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87)), `split_DF` ([L126DF.lean:161](../lean/HamiltonsCubic/Results/L126DF.lean#L161)), `split_kernel_iff` ([L126Final.lean:45](../lean/HamiltonsCubic/Results/L126Final.lean#L45)), `general_LeLin_iff` and `general_DF` ([L126GenBridge.lean:61](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L61), [:117](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L117)), `orbit_perp_fourSet` and `orbit_in_pairBlock` ([L126Orbit.lean:79](../lean/HamiltonsCubic/Results/L126Orbit.lean#L79)), `fourSet_sigma` and `L126_threshold` ([L126Sphere.lean:27](../lean/HamiltonsCubic/Results/L126Sphere.lean#L27), [:100](../lean/HamiltonsCubic/Results/L126Sphere.lean#L100)), `mu` and `mu_eq_half_iff` ([L126Statement.lean:74](../lean/HamiltonsCubic/Results/L126Statement.lean#L74), [:128](../lean/HamiltonsCubic/Results/L126Statement.lean#L128)), `D` ([L121.lean:38](../lean/HamiltonsCubic/Results/L121.lean#L38)).

## 2. The record's statement

Quoted from [second-order.md:1695-1703](../findings/second-order.md#L1695), statement lines, with the machine-checked asides elided:

> #### Lemma L126, the four-set $\tfrac12$-threshold, met in the two-factor family only at $S^3\times S^3$
>
> **Let $M$ be a diagonal critical point **of unit norm** with $\theta>0$, which $P(M)=\theta$ requires. On the tangent space the criticality map $F(W)=Q(W)-P(W)W$ has $DF(M)=\theta(2L_e-\mathrm{Id})$, so $\ker DF(M)$ is the $\tfrac12$-eigenspace of $L_e$ (…), which by Lemma L121 a four-set block meets exactly when $\Sigma_{ijkl}=\theta^2$. The four-set blocks are orbit-free: the orbit tangent for the $(j,k)$ generator lies in the $\{j,k\}$ pair block, so the orbit's tangent space lies in the span of the pair blocks. (…)**
>
> **At $S^p\times S^q$, $n=p+q$, the nonzero four-set blocks are the $(2,2)$-splits, with the common value $\mu_{p,q}=\dfrac{n-2}{2(p-1)(q-1)}$, and**
> $$\mu_{p,q}=\tfrac12\iff\frac1{p-1}+\frac1{q-1}=1\iff(p,q)=(3,3),$$

## 3. Clause by clause

1. **$DF(M)=\theta(2L_e-\mathrm{Id})$ (A-1).** `L126_general`'s second conjunct gives, at a critical M (`Qop2 M = th • M`, th free), `HasDerivAt (s ↦ ⟨Z, critMap(M + s v)⟩) ⟨Z, 2M∘v − P(M)v⟩ 0` for every test Z and every Bianchi vector v of a four-set span. Since `LeLin M v = foxProd2 (P(M)⁻¹ M) v`, the value is $P(M)(2L_e-\mathrm{Id})v$, and at unit norm $P(M)=\theta$. This is the record's formula restricted to the four-set Bianchi directions. The formula on the whole tangent space is `critMap_hasDerivAt` in L126Kernel, which L126Main does not restate. Correct, and partial as a restatement.
2. **$\ker DF(M)=E_{1/2}(L_e)$ (A-2).** This is `critMap_kernel_iff`, `2M∘H − P(M)H = 0 ↔ LeLin M H = ½H` at $P(M)\ne0$. L126Main uses it only inside `split_kernel_iff`. `L126_general` states the derivative's value and the ½-eigenspace clause as separate conjuncts and never links them, so "the block meets $\ker DF(M)$" at a general M is two theorems in two files.
3. **Meets exactly when $\Sigma=\theta^2$ (A-3).** `L126_general`'s first conjunct: some Bianchi vector with a nonzero coefficient triple has `LeLin M v = ½ v` iff `D(A,B,C) = P(M)²`, with D the record's $\Sigma$ on the opposite-pair sums. The nonzero triple gives a nonzero operator by `spanVec_ne_zero`, which is proved alongside and not composed into the statement. The clause holds with no unit-norm hypothesis and with $P(M)$ in place of $\theta$, which is the record's clause at unit norm. Confirmed.
4. **Orbit-freeness (A-4).** Proved in [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean): `orbit_in_pairBlock` is the record's "lies in the $\{j,k\}$ pair block" form, and `orbit_perp_fourSet` the orthogonality to every $\varphi_{ab}\odot\varphi_{cd}$ on disjoint pairs. **For the row's "proved" this is no gap**: the clause is machine-checked on the standard three. **For the file's own claim it is one**: [L126Main.lean:9-10](../lean/HamiltonsCubic/Results/L126Main.lean#L9) says the file "states them as the lemma", and the INDEX row says "the lemma is stated as one theorem", while a clause of the record's statement is absent from both theorems.
5. **Nonzero blocks are the $(2,2)$-splits (A-5).** First conjunct of `L126_sphere`: every four-set whose $T$-count is not 2 has $M\circ v=0$ on its whole Bianchi part, read on the bare layer through `nonsplit_kill`. Second conjunct: at each $(2,2)$-split $v=2a-b-c$ is nonzero, Weyl, orthogonal to $M$ and has `LeLin M v = μ_{p,q} • v`. **The (2,2) blocks being nonzero is covered**: $v\ne0$ together with $\mu_{p,q}=(n-2)/(2(p-1)(q-1))>0$ at $p,q\ge2$ makes $L_e$ nonzero on the block. The positivity of $\mu$ is left unstated, a one-line fact. The ordering $i,j\in T$, $k,l\notin T$ covers every $(2,2)$ four-set up to relabelling. Confirmed.
6. **$\mu_{p,q}=\tfrac12\iff(3,3)$, and the kernel (A-6).** The third conjunct is `mu_eq_half_iff`, correct. The kernel conjunct is `split_kernel_iff`: $2M\circ v-P(M)v=0\iff(p,q)=(3,3)$ **for the single vector $v=2a-b-c$**. Two points follow.
   - *The derivative reading.* `L126_sphere` states the vanishing of the algebraic expression and discards `split_DF`'s HasDerivAt conjunct and the criticality of the sphere product (`sphere_isCritical`). Only `(split_DF …).1`, the orthogonality, is used at [L126Main.lean:69](../lean/HamiltonsCubic/Results/L126Main.lean#L69). The expression **is** the derivative of the criticality map along $M+sv$ at a critical $M$ in a Weyl direction, by `split_DF` and `splitVec_isWeyl2`, so the record's meaning holds. It holds by reference, and the file's docstring ([line 17](../lean/HamiltonsCubic/Results/L126Main.lean#L17)) and the INDEX row say "lies in the kernel of the derivative" of a statement that does not contain the derivative.
   - *Block level.* The record's heading, "met only at $S^3\times S^3$", concerns the whole block, whose Bianchi part is two-dimensional with eigenvalues $\pm\mu_{p,q}$ (`split_eigen_second` on the bare layer). `L126_sphere` shows that one vector of the block is in the kernel iff $(3,3)$. That no other Bianchi vector of a $(2,2)$ block reaches $\tfrac12$ off $(3,3)$ is not stated. **Screen** (a compile of objects in hand, not evidence for the row): the block-level statement, `(∃ nonzero triple, LeLin M v = ½ v) ↔ T.card = 3 ∧ Tᶜ.card = 3` at a unit sphere product and a $(2,2)$-split, with $P(M)>0$ as an extra hypothesis, compiles with no errors from `L126_general`'s first conjunct, `L126_threshold`, `theta_of_unit` and `recip_iff_three_three`, in ten lines. $P(M)>0$ at the sphere product is true ($P(M)=\theta=t(n-1)$ at unit norm by `sphere_isCritical`) and would need its own few lines.
7. **Scope (A-7).** `Fin n` (from `Pcubic2_restrict`) and criticality as a hypothesis at a general M are disclosed in the row's *Scope* note. Both are acceptable: the record's M is a diagonal critical point, so criticality is the record's hypothesis, and `Fin n` loses no generality for a finite index set. The unit-norm sphere product (`hn`) is the record's own "of unit norm" and is acceptable, but the scope note does not mention it. `L126_general` is stated **without** unit norm and at $\theta=P(M)$, which is a strengthening and consistent with the record at unit norm.

**Recommendation: "proved".** Each clause of the record's statement is a sorry-free theorem on the standard three somewhere in `L126*.lean`, and the one missing assembly (the block-level sphere form) is a composition of proved statements that a screen closes in ten lines. "Partial" would claim missing mathematics where only packaging is missing. The row's wording should say that L126Main collects the general and sphere clauses and that orbit-freeness and $\ker DF=E_{1/2}$ stay in L126Orbit and L126Kernel, or L126Main should gain those conjuncts and the block-level sphere form.

## 4. L265's Weyl clause and spanVec_ne_zero (A-8, A-9)

- `sharpB A B = ½(#(A+B) − #A − #B)` ([I117Statements.lean:369](../lean/HamiltonsCubic/Results/I117Statements.lean#L369)) is the polarised bilinear $A\#B$, so `sharpB idOp W` is the record's $I\#W$. [second-order.md:533](../findings/second-order.md#L533), Lemma L265's proof, gives the $\mathfrak{so}(n)$ scalars $n-2$, $\tfrac{n-4}2$, $-1$, $2$ on the Casimirs $0$, $2n$, $4n-4$, $4n-16$, the $-1$ being the Weyl component. `L265_weyl_clause` is `sharpB idOp W = (-1) • W` at every `IsWeyl2 W`, which is exactly the second conjunct of `L265_I_sharp` ([I117Statements.lean:459](../lean/HamiltonsCubic/Results/I117Statements.lean#L459)) and holds at every $n$, where `L265_I_sharp` assumes $n\ge7$. The proof moves to the bare layer through `sharpB_eq_sharpCross` (`sharpOp_extend` three times), swaps `extend idOp` for the identity on bivectors by `sharpOp_congr_on_skew`, and closes with L131Sharp's `sharpCross_id`, Böhm–Wilking's $W\#I=-W$. The L265 row stays **partial**, correct since `L265_I_sharp` and `L265_cp` are still `sorry`. `L265_I_sharp`'s second clause could now be discharged by `L265_weyl_clause`, which the row does not mention.
- `spanVec_ne_zero`: `span_coords` reads $x$, $y$, $z$ at $\varphi_{ij}$, $\varphi_{ki}$, $\varphi_{il}$ as the $(l,k)$, $(l,j)$, $(k,j)$ entries, and a zero restriction on `CurvOp2` makes all three vanish. Correct at four distinct indices.

## 5. Soundness (B)

- `lake build HamiltonsCubic.Results.L126Main HamiltonsCubic.Results.I117Sharp`: exit 0, 8802 jobs. The `sorry` warnings in the log are in I117Statements.lean, none in L126Main.lean or I117Sharp.lean. Only `show`-linter warnings in L126Sphere.lean and L126Kernel.lean.
- `axiom_audit.py --only L126Main.lean`: 2/2 on the standard three. `--only I117Sharp.lean`: 2/2 on the standard three.

## 6. Downstream (C)

1. [lean/INDEX.md:483](../lean/INDEX.md#L483), the L126 (statement) row: *"What remains owed is listed on the L126 row."* The L126 row now reads **proved** and lists nothing owed. Stale.
2. [L126Statement.lean:52-66](../lean/HamiltonsCubic/Results/L126Statement.lean#L52), "What is NOT typed here", names every L126 file but L126Main.
3. [second-order.md:1699-1707](../findings/second-order.md#L1699): the machine-checked notes in the L126 block cite the component files and not `L126_general` or `L126_sphere`.
4. [second-order.md:1712](../findings/second-order.md#L1712), pre-existing: an orphan line, *"since $u=1$ forces $\tfrac1v=0$ and $u=v=2$ is the only integer solution."*, stands after the padding paragraph, detached from the Diophantine step it completes at line 1704.
5. [lean/INDEX.md:544](../lean/INDEX.md#L544), L26 row: *"Owed, narrowed: the two closed forms and L126's exclusion of $(3,3)$."* L126 is now proved, so the second half of that owed list is dischargeable by import. Worth a look by the lean loop.
6. [findings/INDEX-results.md:142](../findings/INDEX-results.md#L142) carries no Lean status and needs none.

## 7. Style (D)

- No em dashes in L126Main.lean, I117Sharp.lean or rows 116, 482, 483. No backticks inside link text in those rows.
- [lean/INDEX.md:482](../lean/INDEX.md#L482): *"… equivalently $\mu_{p,q}=\tfrac12$; 2/2 on the standard three."* is a semicolon splice. The *Scope* sentence ends *"the record's "diagonal critical point" **statement: typed**"* with no full stop before the tag, and "stated as one theorem" names two theorems.

## 8. Final verdict

**CONFIRMED WITH GAPS.** L126 is proved as the record states it, clause by clause, on the standard three, and the row's **proved** should stand. Gaps: L126Main omits orbit-freeness, $\ker DF=E_{1/2}(L_e)$ and the derivative reading at the sphere product while its docstring and the row say it states the lemma; the sphere kernel clause is stated for one vector per block where the record's "only at $S^3\times S^3$" is block-level (composable in ten lines, per the screen, plus $P(M)>0$); the scope note omits the unit-norm hypothesis; the L126 statement row points to an owed list that is gone; and one semicolon splice. `L265_weyl_clause` and `spanVec_ne_zero` are CONFIRMED.
