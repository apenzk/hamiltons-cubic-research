# REVIEW r1466: L134(c)'s passage and L53's $p_3(\omega)$ in Lean, commit 365837f3: `WCP2_bianchi`, `isWeyl_U`, `Le_pairing`, `L134c_margin`, `trS2_cube_WCPm`, `p3omega_WCPm`, and the L53 and L134 rows

Log [agent_logs/r1466.log](../agent_logs/r1466.log). One reviewer, working cold and adversarially. Analysis-only: `lake build` of the two modules, a cold `lake env lean` of [L134Passage.lean](../lean/HamiltonsCubic/Results/L134Passage.lean), and two scratch files in the session scratchpad outside the repository, one holding the `#print axioms` and `#check` calls and one a mutation screen of `WCP2_bianchi`'s tactic. Every closed form was checked by hand. No numerical run was made.

**Standfirst.** Both modules build, and all six headline declarations rest on `propext`, `Classical.choice` and `Quot.sound` alone. `WCP2_bianchi` is first Bianchi for [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s real `WCP2`, index by index, and its 256-case check does real work: the same tactic on the perturbed coefficients $(1,-\tfrac12,0)$ fails at exactly the all-distinct index tuples. `isWeyl_U`'s case analysis outside the corner is right in all four branches of Bianchi and both of Ricci. `Le_pairing` is $\langle L_eH,H\rangle=\theta^{-1}\langle U,Q(H)\rangle$ with `Lidem` the record's $e\circ(\cdot)$, $e=u/\theta$, and `L134c_margin` is the record's $\langle L_eH,H\rangle=0$ on the padded flat at every $\theta$. $\operatorname{tr}_{S^2}\mathring W^3=3\operatorname{tr}M^3-2P=-216m(m^2-1)/(2m-1)^2$ checks by hand, $-144$ at $m=2$, and `p3omega_WCPm` is $p_3(\omega)=-9/R$ at unit norm. One gap, in record text: the edited Families.lean docstring says [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) discharges Bianchi by `native_decide`, and CP2.lean uses none.

| Item | Verdict | Reason |
| --- | --- | --- |
| A. `WCP2_bianchi` | CONFIRMED | Real `WCP2` through `WCP2_specOp`, 256 cases closed by `simp`/`norm_num`, no `sorry` or `native_decide`. A mutation screen fails the same tactic on the 24 distinct-index tuples, and the $(0,1,2,3)$ value is $1-\tfrac12-\tfrac12=0$ by hand |
| B. `isWeyl_U` | CONFIRMED | Skew and symmetry from the general `specOp` lemmas. Bianchi's four outside-corner branches each kill all three products. Ricci's corner case reduces by `sum_pad` to `WCP2_ric_sum` and its off-corner cases vanish row by row |
| C. `Le_pairing`, `L134c_margin` | CONFIRMED | `Lidem U θ = (θ⁻¹•U) ∘ (·)` by definition. `foxTri_comm` then `foxTri_symm_right` at Weyl $H$, $e$, $H$ gives $T(H,H,e)$, and `foxProd_self` at linear $H$ gives $\langle Q(H),e\rangle$. `L134c_margin` covers every Weyl $H$ presented off the corner |
| D. $p_3(\omega)$ | CONFIRMED | `L50_bispectral` gets `IsLinOp`, skew, symmetry and Bianchi from `WCPm_isWeylOp`. The bracket $8m^3-24m+11-2(m+1)(2m-1)^2=-9(2m-1)$ gives the closed form, $(216)^2\cdot3=81\cdot1728$ gives $p_3(\omega)^2R^2=81$, and the certificate is kernel-checked `ring` modulo $(2m-1)u=1$ |
| E. Axioms | CONFIRMED | `L134c_margin`, `WCP2_bianchi`, `isWeyl_U`, `Le_pairing`, `p3omega_WCPm`, `trS2_cube_WCPm`: `[propext, Classical.choice, Quot.sound]` each |
| F. Record text | CONFIRMED WITH GAP | L134 row owes (a), (b), (d) only, its sentences are whole, (c) is assembled from proved parts. The L53 row, route-a.md and bispectral.md are accurate, and the diff has no em dash. Families.lean:921 names a `native_decide` that CP2.lean no longer has |

**Summary: CONFIRMED WITH GAP, the mathematics and the Lean are sound, and one edited docstring line cites a compiler proof that was retired.**

## A. `WCP2_bianchi`

**The object.** The statement is `bianchi WCP2 i j k l = 0` over `Fin 4` with `RealLayer.bianchi`, a function of `Matrix → Matrix` operators, so `WCP2` resolves to Families.lean's real operator at [Families.lean:826](../lean/HamiltonsCubic/Base/Families.lean#L826) and not CP2.lean's $6\times6$ rational matrix. The proof's first line, `WCP2 = specOp lamCP2 omCP2`, confirms the type. The rewrite through `bianchi_eq_comp` and `comp_specOp_apply` turns each entry into $\sum_\gamma\lambda_\gamma(\omega_{ij}\omega_{kl}+\omega_{ik}\omega_{lj}+\omega_{il}\omega_{jk})$ with $\lambda=(1,-\tfrac12,-\tfrac12)$ and $\omega=(a,b,c)$ given as explicit matrices (`hA`, `bivB_eq`, `bivC_eq`).

**By hand at $(0,1,2,3)$.** $a_{01}a_{23}=(-1)(-1)=1$, $b_{02}b_{31}=(-1)(-1)=1$, $c_{03}c_{12}=(-1)(-1)=1$, and every other product is zero, so the entry is $1-\tfrac12-\tfrac12=0$. Each self-dual bivector contributes the same $\omega\wedge\omega$, and the coefficients sum to zero, which is the $\Lambda^4$ obstruction the Families docstring names.

**Non-vacuity.** The cold compile of the whole file takes 11.5 s, which is short enough to raise the question. *Screen, not evidence*: the identical tactic script on `specOp ![1, -1/2, 0] omCP2` fails, leaving `False` at the cases `0 1 2 3`, `0 1 3 2`, `0 2 1 3`, `0 2 3 1`, `0 3 1 2` and onward, the all-distinct tuples, while the repeated-index tuples still close. So the script evaluates each case against the coefficients and closes the true statement because it is true. No `sorry` and no `native_decide` in the file.

## B. `isWeyl_U`

**Skew and symmetry** come from `specOp_isSkew` with `pad_skew` and from `specOp_symmetric`, both general.

**Bianchi outside the corner.** The negation, pushed, is $i<4\to j<4\to k<4\to l\ge4$. The four branches ([L134Passage.lean:83-90](../lean/HamiltonsCubic/Results/L134Passage.lean#L83)):

- $i,j,k<4\le l$: $\omega_{kl}$, $\omega_{lj}$, $\omega_{il}$ vanish, one per product.
- $i,j<4\le k$: $\omega_{kl}$, $\omega_{ik}$, $\omega_{jk}$ vanish.
- $i<4\le j$: $\omega_{ij}$, $\omega_{lj}$, $\omega_{jk}$ vanish.
- $i\ge4$: $\omega_{ij}$, $\omega_{ik}$, $\omega_{il}$ vanish.

Each product has one factor with an index $\ge4$, so all four branches are right. The corner case factors $(\sqrt6)^{-1}$ out and applies `WCP2_bianchi_sum`.

**Ricci.** In the corner, $\omega_{ac}=0$ for $c\ge4$, so `sum_pad` restricts to `Fin 4` and the sum is $(\sqrt6)^{-1}$ times `WCP2_ric_sum`. Off the corner, either $a\ge4$ and $\omega_{ac}=0$, or $a<4\le b$ and $\omega_{bc}=0$, which is the case split at lines 104-106. `WCP2_ric_sum` itself is `WCP2_ricciFlat` rewritten through `comp_specOp_apply`.

## C. `Le_pairing` and `L134c_margin`

**`Lidem` is the record's $L_e$.** [FoxProduct.lean:316](../lean/HamiltonsCubic/Base/FoxProduct.lean#L316) sets `idemOf W θ = θ⁻¹ • W` and [FoxProduct.lean:357](../lean/HamiltonsCubic/Base/FoxProduct.lean#L357) `Lidem W θ = Lmul (idemOf W θ)`, with `Lmul W X = foxProd W X` and `foxProd` the record's $\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. That is $L_e=e\circ(\cdot)$ with $e=u/\theta$, the Setting of [route-a.md](../findings/route-a.md)'s L134.

**The symmetry step.** `innerOp (Lidem U θ H) H` is `foxTri e H H` by definition. `foxTri_comm` gives `foxTri H e H`. [FoxBridge.lean:223](../lean/HamiltonsCubic/Results/FoxBridge.lean#L223)'s `foxTri_symm_right` needs `IsWeyl` of all three arguments, and it gets `hH`, `isWeyl_idemOf hU θ` and `hH`, giving `foxTri H H e`. `foxProd_self` at `IsLinOp H` turns that into $\langle Q(H),e\rangle$, `innerOp_comm` flips it, and the scalar $\theta^{-1}$ comes out of `inner2`. `U` needs `IsWeyl` only, which `isWeyl_U` supplies, and linearity is asked of $H$ alone, which `specOp_add` and `specOp_smul` give. At $\theta=0$ both sides are $0$, so the free $\theta$ admits nothing false.

**`L134c_margin` is the record's statement.** Its type, printed by `#check`, is `innerOp (Lidem (specOp lamU omU) θ (specOp mu eta)) (specOp mu eta) = 0` for skew `eta` vanishing on rows $<4$ (hence on columns $<4$ by skewness), with Bianchi and Ricci-flatness of $H$. The record's (c) takes *"$H$ a Weyl tensor of the complementary $\mathbb R^{n-4}$"*, and every such $H$ has a presentation of this shape by the spectral theorem on $\Lambda^2\mathbb R^{n-4}$, so the hypotheses are the record's. The value holds at every $\theta$, the record's $\theta^*=\sqrt{3/2}$ included. With `L24_hessian_Le` it gives the padded flat's Hessian value $3\theta^*(0-\tfrac12)$, and the comparison $\lvert\kappa_n\rvert\tfrac5{36}<\tfrac32\theta^*$ follows from L134.lean's `candidate_strict`, which gives the stronger $<\tfrac12\theta^*$. *Note*: no single declaration assembles (c)'s last sentence, and the row lists the parts, which is how every other row on the record reads.

## D. $p_3(\omega)$

**Hypotheses of `L50_bispectral`.** [L50Spectra.lean:141](../lean/HamiltonsCubic/Results/L50Spectra.lean#L141) includes `hR : IsLinOp R`, `hskew`, `hsym` and `hB`. `WCPm_isWeylOp` is `IsLinOp ∧ IsWeyl` with `IsWeyl` = skew ∧ symmetric ∧ Bianchi ∧ Ricci, so `hW.1`, `hW.2.1`, `hW.2.2.1`, `hW.2.2.2.1` are the four in order, and Ricci is not needed. `trS2` traces over all of $S^2$, and $\mathring W g=\mathrm{Ric}=0$, so it equals the trace over $S^2_0$. `L50_norm` gives $\operatorname{tr}_{S^2}\mathring W^2=3\lVert W\rVert^2$, which is the record's $\sum\omega^2=3$ at unit norm, so $p_3(\omega)=\operatorname{tr}_{S^2}\mathring W^3/\lVert W\rVert^3$.

**By hand.** $3\operatorname{tr}M^3-2P=\frac{24m(m^2-1)(8m^3-24m+11)}{(2m-1)^3}-\frac{48m(m+1)(m^2-1)}{2m-1}$. With $(m+1)(2m-1)^2=4m^3-3m+1$ the bracket is $8m^3-24m+11-(8m^3-6m+2)=-9(2m-1)$, so the value is $-216m(m^2-1)/(2m-1)^2$. At $m=2$: $-216\cdot2\cdot3/9=-144$, with $\lVert W\rVert^2=12\cdot2\cdot3/3=24$.

**`p3omega_WCPm` is the record's form.** Squared against $R^2=3m(m^2-1)(2m-1)$ the left side is $216^2\cdot3\,m^3(m^2-1)^3/(2m-1)^3$ and $81\lVert W\rVert^6=81\cdot1728\,m^3(m^2-1)^3/(2m-1)^3$, and $139968=139968$. The sign conjunct is strict at $m\ge2$ and the value is $0$ at $m=1$, so the bound is placed right. Hence $p_3(\omega)=-9/R$, [bispectral.md:457](../findings/bispectral.md#L457)'s display. As a check against the record, $\tfrac32\cdot\tfrac N{3R}+\tfrac12\cdot\tfrac9R=(2m^2+m-1)/R$, the L53 row's numerator.

**The certificate.** After `rw` the goal is a polynomial identity in $m$ and $u=(2m-1)^{-1}$, and `hu` states $(2m-1)u=1$. `linear_combination e * hu` closes when goal minus $e\cdot(\text{hu.lhs}-\text{hu.rhs})$ is a ring identity, checked by `ring` in the kernel. The rational identity above holds, so the goal lies in the ideal of $(2m-1)u-1$, and a certificate exists in principle. That this one is correct is what the kernel checked.

## E. Axioms

`#print axioms` from a scratch file outside the repository, after `lake build HamiltonsCubic.Results.L134Passage HamiltonsCubic.Results.L53CPm` completed:

- `HamiltonsCubic.L134Coupling.L134c_margin`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L134Coupling.WCP2_bianchi`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L134Coupling.isWeyl_U`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L134Coupling.Le_pairing`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L70CPm.p3omega_WCPm`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L70CPm.trS2_cube_WCPm`: `[propext, Classical.choice, Quot.sound]`

## F. Record text

**L134 row, [lean/INDEX.md:458](../lean/INDEX.md#L458).** *"**Owed**: (a)'s bound ... asserted stable; (b), a one-sided second derivative of the defect through Rellich's theorem; and the repaired (d). **(c) is PROVED in full.** Its defect ceiling ..."*. The owed list is (a), (b), (d), its semicolons separate list items that carry commas, and r1465's stranded *"and the repaired (d)"* and *"whose"* are gone. The *"passage is PROVED"* sentence names the four declarations accurately. (c)'s parts are all proved: $c_2=\delta^2(H)-\tfrac19\le\tfrac5{36}$ (`L134c`), $\langle L_eH,H\rangle=0$ (`L134c_margin`), the Hessian reading (`L24_hessian_Le`) and the numerical comparison (`candidate_strict`).

**L53 row, [lean/INDEX.md:371](../lean/INDEX.md#L371).** Names `trS2_cube_WCPm` and `p3omega_WCPm` with the right closed form and the right route, and r1465's G1 is discharged. The *"<0"* is `p3omega_WCPm`'s, at $m\ge2$, the range the row works in.

**route-a.md, [route-a.md:205](../findings/route-a.md#L205).** Adds `L134c_margin` to the machine-checked list, accurately. **bispectral.md, [bispectral.md:457](../findings/bispectral.md#L457).** The three closed forms and the five cited declarations match, and `bispectral_closes` exists at [L53.lean:53](../lean/HamiltonsCubic/Results/L53.lean#L53). *"whence both displayed forms"* takes the sign of $p_3(\mu)$ from `trCube_WCPm`'s closed form, as r1465 recorded.

**No em dash** in any added line of the commit. The semicolons in the new docstrings and rows separate list items.

**G1. Families.lean names a `native_decide` proof that no longer exists.** [Families.lean:920-921](../lean/HamiltonsCubic/Base/Families.lean#L920) reads *"[CP2.lean](CP2.lean) discharges it over `ℚ` in the pair basis by `native_decide`."* [CP2.lean:41-47](../lean/HamiltonsCubic/Base/CP2.lean#L41) proves `WCP2_bianchi : IsBianchi WCP2` by three `rfl` entries and `norm_num`, and the only `native_decide` in CP2.lean is the historical note at line 78, and [plan-lean.md](../plan-lean.md) counts `native_decide` in 0 files. *Arguing the opposite*: the phrase predates this commit, which touched the line only to extend the sentence. But the commit rewrote line 921 and the brief makes the Families citation part of the review, and a reader following it looks for a compiler proof and finds a kernel one, which understates the ℚ result's trust. **Stands**, as a text defect with no effect on any theorem. *Pre-existing and outside the diff*: line 920's *"here `2 - 1 - 1 = 0`; [CP2.lean] discharges it"* splices two clauses with a semicolon, and line 919's *"does not type, the obstruction is"* joins two with a comma.

**Candidates withdrawn.**

- *L53CPm.lean's docstring writes "`p₃(ω)² R² = 81 ‖W‖⁶`" with $p_3(\omega)$ unnormalised, then "`p₃(ω) = −9/R`" normalised.* The file's $p_3(\mu)$ bullet uses the same convention and states the normalisation beside it. Withdrawn as notation.
- *`L134c_margin` requires a presentation rather than an operator.* Every Weyl operator on the complementary block has one, and r1463 recorded the same step for `L134c`. Withdrawn.

**Verdict: CONFIRMED WITH GAP.** G1 at [Families.lean:921](../lean/HamiltonsCubic/Base/Families.lean#L921).
