# r810: Gate 2 on the Lean batch, the star layer, the axiom gate, L191's typing, and the record repair

*Cold brief: I was given four commits and the pointers, and read [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [L190Statement.lean](../lean/HamiltonsCubic/Results/L190Statement.lean), [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean), [axiom_audit.py](../scripts/misc/axiom_audit.py), [lean/INDEX.md](../lean/INDEX.md), [findings/INDEX-results.md](../findings/INDEX-results.md) and [findings/diagonal-half.md](../findings/diagonal-half.md) (L178, L184, L190, L191, L144) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Two machine actions were screens on objects constructed for the purpose: one run of [axiom_audit.py](../scripts/misc/axiom_audit.py), which the brief names as permitted, and one re-derivation of its asked-against-parsed set from its own functions. Every entry computation below is by hand. Log: [agent_logs/g2-leanbatch-r810.log](../agent_logs/g2-leanbatch-r810.log).*

| Target | Verdict |
|---|---|
| **A**, the star layer, `862e87c6` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** Both theorems are correct and kernel-clean, and `selfDual_expand` is genuine spanning. **$\dim\Lambda^2_+=3$ is typed nowhere**. No `finrank`, no `LinearIndependent`, no `Submodule.span` exists anywhere in the layer, and the same file's `selfDualForms` docstring still says the three-dimensionality *"is NOT proved here"*, so the file now contradicts the row |
| **B**, the axiom gate, `fb6c12cc` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** $63$, $80$ and $71$ all reproduce exactly. **The gate has a silent coverage hole**: $55$ of the $4459$ declarations it asks about return no parsed report and the script never compares the two counts, and **twelve of the fifty-five are real theorems in rows marked `proved`**. *And "all 63 sit in modules this table marks `partial`" is false for two of them: [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) is marked `stated`* |
| **C**, L191's typing, `8af22b49` | **REFUTED as credited, the theorems themselves being true.** `pair_coincidences_at_dim4` proves the two coincidences and says **nothing about $\omega_2\ne\pm\omega_1$**, which is the entire content of *"the pair statement is FALSE one dimension below its hypothesis"*. **Everything typed in the file is consistent with L191 holding at $\dim V=4$**, so neither the falsification nor the inhabitation is established |
| **D**, the record repair, `12219558` | **SPLIT.** The id arithmetic is **CONFIRMED exactly** against the rows on disk. The L191 row is **CONFIRMED on the rigidity and the entailment** and repeats target C's mis-credit. **The L144 promotion is REFUTED as a completed repair**: [findings/INDEX-results.md](../findings/INDEX-results.md) row 144 still reads `Observation`, so the commit created the mismatch it claimed to fix, and the block still carries *"screened and not proved"* live |
| **The `Lean: blocked` reason on `12219558`** | **OVERSTATED.** *"The three cases run on the six dimensional Hodge star identity"* is false for case 1, which closes on area forms and sign algebra with no star anywhere, and which the record itself calls dimension-free |

**One line.** *The two star-layer theorems and the audit script are real work and their headline numbers survive a re-run, but three of the four commits credit a declaration or a row with a step that is not in it: the spanning is credited with a dimension, the audit is credited with coverage it does not check, and `pair_coincidences_at_dim4` is credited with a falsification whose one load-bearing half, that the two forms are not equal up to sign, is nowhere in the file, and would have cost one matrix entry to type.*

## 0. What I checked, and how

Every claim below was cleared on three passes. **Locate exactly**: the declaration or the row is quoted from disk, never from the commit body. **Exhibit concretely**: each defect is given in closed form, an entry or a name, not as a worry. **Argue the opposite**: each is stated with the strongest defence I could build for it, and the two that survived that defence are recorded as sound rather than as findings.

The whole Lean layer compiled during my audit screen: the generated `#print axioms` module imports all 452 package files and returned $4401$ reports, so *every declaration discussed here type-checks*, and all five new ones rest on the standard three axioms alone.

## 1. Target A: `star4_star4` and `selfDual_expand`

### 1.1 The star is the record's, and the normalisation is right

[star4](../lean/HamiltonsCubic/Base/SelfDual.lean) is $(\star X)_{ab}=\tfrac12\sum_{cd}\varepsilon_{abcd}X_{cd}$, with `levi4` the product of the six ordered-pair signs. That product **is** the permutation sign on a permutation and vanishes on a repeat, so `levi4` is the Levi-Civita symbol and not a lookalike. The $\tfrac12$ is the ordered-pair double count, and the layer already anchors it twice, at `normSq_star4 = 6` against the record's $\lVert\star\rVert^2=6$ and at `inner2_complexStructure = 3` against $c=\tfrac13$. **No defect.**

### 1.2 `star4_star4`'s `IsSkew` hypothesis is the right scope, and the prose is accurate

On a general matrix $\star$ annihilates the symmetric part, so $\star\star=\mathrm{id}$ is false without skewness and the hypothesis is necessary rather than defensive. A bivector **is** a skew matrix in this layer's reading, so the row's *"at every bivector"* is exact. **I looked for the overclaim the brief anticipated here and did not find one.**

### 1.3 `selfDual_expand` is genuine spanning, checked entry by entry

`phi i j` carries $-1$ at $(i,j)$ and $+1$ at $(j,i)$, so the three exhibited forms have entries $(\mathrm{sdForm}_0)_{01}=(\mathrm{sdForm}_0)_{23}=-1$, $(\mathrm{sdForm}_1)_{02}=-1$ with $(\mathrm{sdForm}_1)_{13}=+1$, and $(\mathrm{sdForm}_2)_{03}=(\mathrm{sdForm}_2)_{12}=-1$. Reading the claimed identity at the six independent entries gives
$$X_{01},\quad X_{02},\quad X_{03}\ \text{ at the first three, and }\ X_{23}=X_{01},\quad X_{13}=-X_{02},\quad X_{12}=X_{03}\ \text{ at the other three.}$$
Those last three are exactly $\star X=X$ read at $(0,1)$, $(0,2)$ and $(0,3)$: $(\star X)_{01}=X_{23}$, $(\star X)_{02}=-X_{13}$ and $(\star X)_{03}=X_{12}$, each a two-term contraction I recomputed from `levi4` directly. **So the theorem is right, it is spanning and not a normal form for a subclass, and the hypotheses are exactly what it uses.**

### 1.4 The finding: $\dim\Lambda^2_+=3$ is stated in the row and typed nowhere

[lean/INDEX.md](../lean/INDEX.md) says, verbatim, *"$\star\circ\star=\mathrm{id}$ AND THE SPANNING ARE NOW PROVED"* and then *"so the three exhibited members SPAN and $\dim\Lambda^2_+=3$"*. The first half is right. The second is a second statement wearing the first's grammar.

- **`grep` over the whole of [lean/](../lean/) returns no `finrank`, no `LinearIndependent` and no `Submodule.span`, at any declaration.** There is no theorem in this repository that says $\Lambda^2_+$ has dimension three.
- Spanning alone does not give the dimension. **Independence is the other half**, and although it is two lines from the entries above, namely $\sum_kc_k\mathrm{sdForm}_k=0$ read at $(0,1)$, $(0,2)$ and $(0,3)$ giving $c_0=c_1=c_2=0$, those two lines are not written, and the row does not distinguish what was proved from what follows from it.
- **The same file now contradicts the row.** [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean)'s `selfDualForms` docstring still reads *"That it is three-dimensional (the record's 'self-dual 3-space'), is NOT proved here; three explicit members with pairwise-zero pairing are exhibited below, and spanning is not."* The commit appended a section and left that paragraph standing. **A consumer reading the definition is told the opposite of what the index tells them**, and on this point the stale docstring is the more accurate of the two.

*The defence I tried:* the row could be read as claiming the dimension mathematically rather than in Lean, since the base-layer paragraph is prose about a file rather than a table row. **It does not survive contact with the sentence's own frame**. It opens *"ARE NOW PROVED"* and closes by moving *"$\star\circ\star=\mathrm{id}$ hence $\dim\Lambda^2_+=3$"* out of the *"Owed and named"* list at the end of the same paragraph. The list is the file's record of what is not in the kernel, and one of the two items removed from it is still not in the kernel.

### 1.5 The second finding: what L178's step 1 needs is more than a dimension

The row closes *"which is what [L178]'s step 1 needs to call $W^\pm$ trace-free on a three-dimensional space."* Reading [findings/diagonal-half.md](../findings/diagonal-half.md)'s step 1 against that, the step needs four things:

1. that $\Lambda^2V$ splits as $\Lambda^+\oplus\Lambda^-$ and that $W$ is block-diagonal for the splitting, which is a Weyl fact and is typed nowhere.
2. that each summand is three-dimensional, which is what a proof of the spanning plus independence would give.
3. that each summand is **trace-free**, which step 1 gets from total tracelessness giving $\operatorname{tr}W^++\operatorname{tr}W^-=0$ **and first Bianchi giving $\operatorname{tr}W^+-\operatorname{tr}W^-=0$**, the block being explicit that *"it takes both to make each summand trace-free on its own three-space"*.
4. that a self-adjoint trace-free operator on a three-space has rank $0$, $2$ or $3$ and never $1$, which is the step's actual conclusion.

**The spanning supplies item 2 and nothing else.** The row's phrasing puts item 3 inside its own scope, and item 3 is the half the record says consumes first Bianchi exactly once. *This is not a wrong theorem, it is a row that a later reader would cite for a step it does not carry, which is the failure mode [L187](../findings/diagonal-half.md) was refuted for.*

**Verdict A: CONFIRMED AS TYPED, PROSE OVERCLAIMS.**

## 2. Target B: the axiom gate

### 2.1 The four claims, one at a time

**Claim 1, that one `#print axioms` call covers the whole tree.** **Sound, and correctly used.** Lean walks the transitive dependency graph and returns its unproved roots, so a theorem whose proof reaches a `sorry` at any depth carries `sorryAx` itself. That is exactly what makes the brief's suspicion, a `proved` module importing a `partial` one hidden by module-level grouping, **impossible to realise**: such a theorem surfaces under its own name in its own module, not under the imported one. I attacked this and it holds.

**Claim 2, the counts.** My run: `4258/4401 clean`, **63 on `sorryAx`**, **80 on the compiler**, `0` unknown. The commit's `4255/4398` differs by exactly three in both numerator and denominator, which is the eighteen untracked `L*Statement.lean` files in the tree moving under the walker. **The two headline bucket sizes reproduce exactly.**

**Claim 3, that 71 of the 80 are in `Base/`.** **Reproduced exactly**, and if anything understated: three of the nine counted as non-Base are the mangled keys `_id_four`, `_id_five` and `_id_six`, which are `HamiltonsCubic.Base.sharpQF'_id_*`, so the true figure is $74$. The claim errs against itself, which is the safe direction.

**Claim 4, that `native_decide` mints a per-theorem axiom and that Lean wraps the list.** **Confirmed from the output.** Every compiler entry has the shape `<theorem>._native.native_decide.ax_1_1`, `Lean.ofReduceBool` appears nowhere, and `sharpQF_one_basis` carries six of them on one wrapped line. The `re.DOTALL` in `REPORT` is load-bearing and the comment explaining it is accurate.

### 2.2 The finding: the gate does not check its own coverage

`main` asks Lean about `len(decls)` declarations and then reports on `len(found)`. **It compares the two nowhere.** Its only emptiness guard is `if not found`, which fires only when the build fails outright. Re-deriving the asked set from the script's own `sources` and `declarations`:

- **$4459$ asked, $4401$ parsed. $55$ distinct declarations return no report at all**, and the run exits reporting a clean layer.
- **Twelve of the fifty-five are real theorems in files whose [lean/INDEX.md](../lean/INDEX.md) row reads `proved`**: `L129Statement.lambda_max_gt'`, `L130Statement.entry_cap'`, `L157.sqrt_sq_val`, `L157.one_lt_sqrt`, `L179.inner2_rankOne'`, `L183.inner2_unitSD'`, `L66Statement.slot1`, `slot2`, `slot3`, `L23Statement.sqrt_four_mul`, `L114.at` and `L172Statement.needs`. *A `sorry` or a `native_decide` under any of them would be invisible to this gate.*
- **Two distinct causes, both fixable.** The `REPORT` regex is delimited by `'`, so a name containing an apostrophe is mis-parsed: `'…sharpQF'_id_five' depends on axioms:` matches with the name captured as `_id_five`, which is how three Base compiler entries reached the report under truncated keys and how the rest were lost. Separately, some names the namespace tracker builds do not exist in Lean at all, `L157.sqrt_sq_val` among them, so `#print axioms` errors on them and the theorem is never audited under its true name. **A third, harmless cause is the `DECL` regex reading prose**: `rather`, `settling`, `needs`, `uses`, `at`, `making`, `tabulates` and `probe_four` are words following *theorem* or *lemma* inside docstrings.

*The defence I tried:* $55$ of $4459$ is $1.2\%$, and every one of the twelve is a small arithmetic helper rather than a headline. **That is a reason the hole has not bitten yet, not a reason the gate reports honestly.** The gate exists because *"a row reading `proved` records that the file compiled, which is a weaker fact than the word says"*. A gate that silently under-reports its own coverage has the same defect one level up, and the fix is one comparison and one non-zero exit.

### 2.3 The second finding: `stated` is not `partial`

[lean/INDEX.md](../lean/INDEX.md) says *"All 63 declarations resting on `sorryAx` sit in modules this table marks `partial`, and every one is in a `*Statement.lean` file."*

- **The second half is true.** All $63$ live in `*Statement.lean` files, [L37Statement.lean](../lean/HamiltonsCubic/Results/L37Statement.lean) and [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) included, whose namespaces read `L37` and `L182` and could have been elsewhere.
- **The first half is false for two of the sixty-three.** `L182.lam_mul_F_floor` and `L182.lam_mul_F_gt` live in [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean), whose row reads **`stated`**. The other $61$ are all in rows reading `partial`, which I checked file by file.
- **The conclusion drawn from it survives.** `stated` is weaker than `proved`, so *"No row marked `proved` rests on a `sorry`"* holds on the audited set. The sentence is wrong in its premise and right in its conclusion, which is worth fixing because the premise is the checkable half.

**Verdict B: CONFIRMED AS TYPED, PROSE OVERCLAIMS.** *The numbers are real and reproducible. The coverage sentence and the `partial` sentence are not.*

## 3. Target C: L191's typing

### 3.1 What the two theorems actually say

`wedgeSelf_sdCombo_apply` gives $(\omega\wedge\omega)_{0123}=2(x^2+y^2+z^2)$ at $\omega=\mathrm{sdCombo}(x,y,z)$, and `inner2_sdCombo` in [L190Statement.lean](../lean/HamiltonsCubic/Results/L190Statement.lean) gives $\lVert\omega\rVert^2=2(x^2+y^2+z^2)$ in the same normalisation, so the docstring's *"the self-wedge of a self-dual form being its norm"* is exact. `pair_coincidences_at_dim4` takes two triples of equal $x^2+y^2+z^2$ and returns equality of the matrix squares and of that one $\Lambda^4$ component. **Both are true, both are kernel-clean, and neither is vacuous.**

### 3.2 The finding: the falsification is not typed, and its missing half is one entry

The file docstring's headline is *"the pair statement is FALSE one dimension below its hypothesis"*, and [lean/INDEX.md](../lean/INDEX.md) row 191 and [findings/INDEX-results.md](../findings/INDEX-results.md) row 191 both name `pair_coincidences_at_dim4` as *"the $\dim V=4$ falsifier"*.

L191 reads: common support, equal squares, equal self-wedges $\Rightarrow\omega_2=\pm\omega_1$. **To falsify it one needs a pair meeting the three hypotheses AND failing the conclusion.** The file types the hypotheses and never touches the conclusion.

- **Every declaration in the file is consistent with L191 being TRUE at $\dim V=4$.** A world in which all equal-norm members of $\Lambda^+\mathbb R^4$ are $\pm$ one another satisfies `pair_coincidences_at_dim4`, `wedgeSelf_sdCombo_apply` and `unitSD_coincidences` word for word. *Nothing in the file rules that world out*, so nothing in the file falsifies anything.
- **The missing statement is one matrix entry.** $\mathrm{unitSD}_0=\tfrac1{\sqrt2}(\varphi_{01}+\varphi_{23})$ has $(\mathrm{unitSD}_0)_{01}=-\tfrac1{\sqrt2}\ne0$, while $\mathrm{unitSD}_1=\tfrac1{\sqrt2}(\varphi_{02}-\varphi_{13})$ has $(\mathrm{unitSD}_1)_{01}=0$. **That single entry gives $\mathrm{unitSD}_1\ne\pm\mathrm{unitSD}_0$ and is the whole of the falsification.** It is cheaper than any theorem already in the file, and its absence is what makes this a mis-credit rather than a shortfall of tooling.
- **`unitSD_coincidences` is closer to the reviewers' object and is still not it.** [r808](REVIEW_r808.md) and [r809](REVIEW_r809.md) both built an **orthonormal** pair. `inner2_unitSD` in the base layer does give the orthonormality, so that half is typed somewhere. **The distinctness is typed nowhere**, and `unitSD_coincidences` is stated at arbitrary `i j : Fin 3`, so at $i=j$ it is a tautology and the file never separates the two cases.

### 3.3 The third finding: one $\Lambda^4$ component is not the self-wedge

`wedgeSelf_sdCombo_apply` fixes the indices at $(0,1,2,3)$, and the docstring says without qualification that *"`Φ`'s two components agree"*. $\Lambda^4\mathbb R^4$ is one-dimensional, so on **skew** arguments the single component does determine the tensor, through `wedgeSelf_swap01`, `wedgeSelf_swap12`, `wedgeSelf_swap23` and `wedgeSelf_diag01`, all of which carry an `IsSkew` hypothesis and all of which exist in the base layer.

- **The reduction is a short derivation and it is not made.** No declaration in the file says $\mathrm{sdCombo}$ is skew, and none invokes the alternation lemmas.
- **The layer already knows this is owed and says so elsewhere**: [lean/INDEX.md](../lean/INDEX.md)'s base paragraph still lists *"the full $\Lambda^4$ identity beyond its $(0,1,2,3)$ component"* under *"Owed and named"*. **So the file's own index contradicts the file's own docstring on the same page.** *The docstring is where a reader stops.*

### 3.4 The fourth finding: nothing here says the pair is a Weyl tensor

The record's L191 box and both reviewers say *"each gives an honest rank-two Weyl tensor"*. The layer carries `IsWeyl` at [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) over $\mathbb R$ and `IsWeyl`, `IsRicciFlat`, `IsBianchi` at [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean), so the predicate exists.

- **No tensor is formed in [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean)**. The file contains three theorems about forms and no operator on $\Lambda^2$.
- *The defence, which is partly good:* the layer's habit is to type the defining identities rather than the predicate, and both ingredients are on file. `unitSD_gram` gives $\omega\omega^{\mathsf T}=\tfrac12\mathrm{Id}_4$, which is Ricci's Gram summand, and `wedgeSelf_unitSD_apply` gives the shared self-wedge, which is Bianchi's. **L190 does the same and its row says so honestly**, claiming `ricci_at_witness` rather than Weyl-ness. **L191's rows do not**, and it is the difference between the two rows that makes this a finding.

**Verdict C: REFUTED as credited.** *The three theorems are true, correct and kernel-clean. The falsification and the inhabitation they are credited with are not among them, and the load-bearing half is a one-entry statement nobody wrote.*

## 4. Target D: the record repair

### 4.1 The id arithmetic: CONFIRMED exactly

Derived from the rows rather than from the sentence, as the file's own note instructs:

| Quantity | On disk | Footer |
|---|---|---|
| Rows matching `^\| \*\*<n>\*\*` | **191**, no duplicates | *191 numbered results* |
| Range | min $0$, max $191$ | *[L0] through L191* |
| Absent ids in $[0,191]$ | **exactly $\{60\}$** | *L60 never assigned* |
| Next free | $192$ | *192* |

$0$ through $191$ is $192$ ids, less $L60$ is $191$, and $191$ rows is what the file has. **The arithmetic is right and the repair is real**: a number taken from the old footer would have been $159$, an id in use since before this line was last correct. The commit body's *"against 190 rows"* is the count before its own L191 row, which is consistent.

### 4.2 The L191 row states the lemma, and repeats target C's mis-credit

*"It empties the RANK-TWO Weyl branch at $\dim V=6$"* is **supported**. The block's entailment box derives every hypothesis: at rank two tracelessness gives $\lambda_2=-\lambda_1$, [L180](../findings/diagonal-half.md)(1) gives $\omega_1^2=\omega_2^2$, [L179](../findings/diagonal-half.md)(b) gives $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$, and the common support is derived from $\ker\omega=\ker\omega^2$ rather than assumed. The row is scoped to $\dim V=6$ and says so, which is the scoping [r807](REVIEW_r807.md) had to force on the L190 row.

**The Lean column is not honest in the same way.** It reads *"the $\dim V=4$ falsifier is [L191Statement.lean]'s `pair_coincidences_at_dim4`"*, which is section 3.2's finding restated in the numbered index, where it is worse: [findings/INDEX-results.md](../findings/INDEX-results.md) is the file later work cites.

### 4.3 The `Lean: blocked` reason is not the true blocker

The trailer reads *"the three cases run on the six dimensional Hodge star identity for J wedge J"*. Reading the three cases in [findings/diagonal-half.md](../findings/diagonal-half.md):

- **Case 1 contains no star at all.** $A$'s eigenplanes, a skew map on a plane being a multiple of its area form, $\omega_i=\sum_js_{ij}c_j\varepsilon_j$, then $u_ju_k=1$ in the sign variables. **The record itself calls this case dimension-free**, citing [r808](REVIEW_r808.md), in the same block.
- **Case 2 does run on $\star_V(J\wedge J)=2\epsilon_JJ$.** The trailer is right about this one case.
- **Case 3 runs on the cross term in $\Lambda^2Q\otimes\Lambda^2P$ and on $J\wedge J=2\eta\,\mathrm{vol}_Q$ for a complex structure on a four-plane**, which is a different identity on a different space. The block's own note says case 3 is six-dimensional *"because its splitting is $4+2$"*, not because of the star.

**So one case of three is blocked, and the blocked one is named as though it were all three.** Case 1 is the case a Lean layer with `areaForm`, `inner2` and `wedgeSelf` already in it is closest to reaching, and the recorded reason is what would stop a later round from trying.

### 4.4 The L144 promotion: REFUTED as a completed repair

The commit changed one heading in [findings/diagonal-half.md](../findings/diagonal-half.md) from `Observation L144` to `Lemma L144`, and one plan.md reference to match. The convention in [findings/INDEX-results.md](../findings/INDEX-results.md) is *"Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** …"*.

**The promotion has an argument behind it, and the commit body is right that the block asserts one.** The Gate 2 box reads *"THE PRIMITIVE HALF IS NOW PROVED, SO THIS IS A LEMMA"* and gives the route: eigenvalue coordinates, $D>A$, the AM–GM $A^2\ge4\mu r(S+1)$, complement-invariance to assume $r\ge S$, and an inequality affine in $\mu$ whose two coefficients both hold. That is a derivation, not a note, so the brief's suspicion that the type change was taken from a remark does not hold up. **The repair is nonetheless incomplete in three places, all on disk now.**

1. **The numbered index still labels it `Observation`.** Row 144 of [findings/INDEX-results.md](../findings/INDEX-results.md) reads `| **144** | Observation |`, and its own summary text still ends *"imprimitive half proved, primitive half screened to $n\le200$"*. **The commit's stated defect was a heading disagreeing with a block, and what is on disk now is a heading disagreeing with the numbered table**, which is the more load-bearing of the two, because the table is what a citation resolves against.
2. **The block still states the opposite of its own promotion, further down and still live**: *"THE PRIMITIVE HALF, SCREENED AND NOT PROVED. … screened to $n\le200$, maximum $0.4758$ … This is a census over a finite range, so it is evidence rather than a theorem, and a uniform bound over all primitive parameter sets is owed."* Two boxes in one block now say proved and not-proved about the same half.
3. **The commit's own plan.md edit preserves the contradiction.** The line it touched still reads *"Its primitive half is a screen to $n\le200$, not a theorem, so the discharge inherits that status."* **The same commit promotes the result to `Lemma` and re-states in another file that the half is not a theorem.**

*A fourth item, smaller:* the block flags that the imprimitive half's *"maximised uniquely at $g=n/2$"* is **missing the two qualifiers that refuted [L96](../findings/diagonal-half.md)**, needing $n$ even and holding only up to complementation, and the printed statement still carries neither. The reviewers judged the conclusion unharmed, so this is a wording debt rather than a break, but it means *"its own block states both halves proved"* is generous about the imprimitive half too.

*The defence I tried:* the promotion may be right on the mathematics, and the index row simply lags. **The label is the record's type system.** A result whose heading, whose numbered row and whose own body give three different answers is not citable in either direction, which is the condition the L191 row was created to end.

**Verdict D: SPLIT.** *Id arithmetic CONFIRMED exactly, the L191 row CONFIRMED with target C's mis-credit repeated, the `Lean: blocked` reason OVERSTATED, and the L144 promotion REFUTED as a completed repair.*

## 5. What would falsify each finding, and what I did to look for it

| Finding | What would falsify it | What I did |
|---|---|---|
| **A**, $\dim\Lambda^2_+=3$ not typed | A `finrank`, `LinearIndependent`, `Submodule.span` or `Basis` statement anywhere in the layer | Searched the whole of [lean/](../lean/) for all four, with zero hits at any declaration. Read `selfDualForms` and its docstring in full |
| **A**, the row overclaims L178's step 1 | Step 1 needing only a three-dimensional space, with tracelessness of $W^\pm$ coming from somewhere else | Read step 1 and step 4 of the L178 block. Step 4 says first Bianchi *"IS CONSUMED, exactly once, in step 1"* to make each summand trace-free, and names the two trace equations |
| **B**, the coverage hole | The 55 unreported names being all prose noise, or the script comparing its two counts | Re-derived the asked set from the script's own `sources` and `declarations`, diffed against the parsed table, and resolved each name to its file and its index row. Twelve are real theorems in `proved` rows. Read `main` for a count comparison, and there is none |
| **B**, `stated` is not `partial` | [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean)'s row reading `partial` | Mapped all 63 `sorryAx` declarations to files and each file to its row state. 61 `partial`, 2 `stated`, 0 `proved` |
| **C**, the falsification is not typed | Any declaration in the file, or reachable from it by name, asserting $\omega_2\ne\pm\omega_1$ or the injectivity of `sdCombo` | Read the file in full and searched it and [L190Statement.lean](../lean/HamiltonsCubic/Results/L190Statement.lean) for `≠`, `Ne` and `Function.Injective`. One hit, `sdCombo_nondecomposable`'s hypothesis $x^2+y^2+z^2\ne0$, which is a different statement |
| **C**, the pair is not typed as a Weyl tensor | An `IsWeyl`, `IsRicciFlat` or `IsBianchi` application in the file | Searched the file for all three and for `Ricci` and `Bianchi`, with zero hits. Confirmed the predicates exist in the base layer, so the omission is a choice |
| **D**, the id arithmetic | A duplicate id, a second gap, or a row above 191 | Extracted every row id, sorted, counted duplicates and gaps. 191 rows, one gap at 60, max 191 |
| **D**, the L144 promotion | Row 144 of [findings/INDEX-results.md](../findings/INDEX-results.md) reading `Lemma`, or the *"screened and not proved"* box being gone | Read row 144 and the whole L144 block on disk after the commit. The row reads `Observation`, the box is still there, and plan.md's *"not a theorem"* is still there |
| **D**, the `Lean: blocked` reason | Case 1 or case 3 using $\star_V(J\wedge J)=2\epsilon_JJ$ | Read all three case bodies. Case 1 uses area forms and signs, case 3 uses the cross term and a four-plane $\Lambda^4$ fact, and the record's own note attributes case 3's six-dimensionality to the $4+2$ splitting instead |

## 6. What I checked and cleared

Recorded because a reviewer's silence is not evidence.

- **`star4_star4`'s hypothesis scope.** Right, and the row's *"at every bivector"* is accurate.
- **`star4`'s normalisation.** The $\tfrac12$ is the record's, anchored twice in the same file, and `levi4` is the genuine Levi-Civita symbol rather than a sign-lookalike.
- **`selfDual_expand`'s identity.** Verified at all six independent entries by hand, against $\star X=X$ read at $(0,1)$, $(0,2)$ and $(0,3)$.
- **The transitivity defence of the audit.** A `proved` module importing a `partial` one **cannot** hide a `sorry` from this gate, because the dependent theorem carries `sorryAx` under its own name. The brief's suspected failure mode does not exist. The realised failure mode is the coverage hole instead.
- **Claims 3 and 4 of the audit commit.** Both reproduce, claim 3 conservatively.
- **The L191 row's rigidity statement and rank-two entailment.** Supported by the block, correctly scoped to $\dim V=6$, with the common support derived rather than assumed.
- **`wedgeSelf_sdCombo_apply`'s constant.** $2(x^2+y^2+z^2)$ against $\lVert\omega\rVert^2=2(x^2+y^2+z^2)$, so $\omega\wedge\omega=\lVert\omega\rVert^2f_{1234}$ holds in this layer's normalisation exactly.
- **All five new declarations rest on the standard three axioms.** No `sorry`, no `native_decide`, checked in the same run that produced section 2.

## 7. Screens, declared

Two, both on objects constructed for the purpose, neither offered as evidence for a positive claim.

1. **One run of [axiom_audit.py](../scripts/misc/axiom_audit.py)**, which the brief names as permitted. Output: `4258/4401 clean`, 63 `sorryAx`, 80 compiler, 0 unknown.
2. **One re-derivation of its asked set** by importing its own `sources` and `declarations` and diffing against its JSON table, to locate the 55. *No search, no sweep, no census, and no Lean proof was attempted or written.*

*One incidental observation, outside the four commits: [lean/HamiltonsCubic/AxiomProbe.lean](../lean/HamiltonsCubic/AxiomProbe.lean) is present in the working tree, untracked, timestamped one minute after `fb6c12cc`. It is leftover probe debris and the walker picks up its `probe_four`.*
