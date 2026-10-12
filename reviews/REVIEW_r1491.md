# Review r1491: L17's dimension count in Lean, codim {F=0} at most 186 at n = 12, and r1490's gaps repaired

Gate 2 review of commit 39dee17a: the new [Results/L17Codim.lean](../lean/HamiltonsCubic/Results/L17Codim.lean) (`vecCoords`, `Kc`, `mem_Kc`, `finrank_Kc`, `projL`, `projL_apply`, `projL_mem`, `inner_projL`, `projK`, `pr6`, `condMap`, `finrank_cod`, `asd_entries_zero`, `inner_vec_of_ker`, `uOp_of_Kc`, `condMap_eq_zero_iff`, `F_eq_zero_iff_condMap`, `L17_codim`, `finrank_biv12`, `L17_codim_12`), the record edits for it ([lean/INDEX.md](../lean/INDEX.md) line 480, [INDEX-results.md](../findings/INDEX-results.md) line 32, [route-a.md](../findings/route-a.md) line 93), and the repairs of [r1490](REVIEW_r1490.md)'s gaps A-1 and E-1 in [L134bPhi.lean](../lean/HamiltonsCubic/Results/L134bPhi.lean), lean/INDEX.md line 463, the [second-order plan](2026-09-26-lean-second-order-plan.md) (Goal and milestone 6) and route-a.md line 203. One reviewer. Analysis-only rule inherited: the only compute was the module build (8728 jobs, no error, no warning in L17Codim.lean, the replayed warnings all upstream in Base/WeylReal.lean and similar) and `scripts/misc/axiom_audit.py --only L17Codim`.

| item | claim | verdict |
| --- | --- | --- |
| A | `L17_codim` and `L17_codim_12` state route-a.md's $\operatorname{codim}\{F=0\}\le186$ at $n=12$ faithfully, with the count $3N-12$ right and the kernel of `condMap` on $V$ exactly $\{F=0\}\cap V$ | CONFIRMED |
| B | `condMap_eq_zero_iff` is sound: the kernel decomposition, the eigenbasis step through `inner_schur_eigen₂`, the symmetric-block reduction | CONFIRMED |
| C | r1490's A-1 and E-1 are repaired | CONFIRMED |
| D | every theorem of L17Codim.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no edited sentence overstates, and the unproved $\dim\mathcal W_{12}\cap T_uS=1637$ is said wherever the Lean is cited | CONFIRMED WITH GAP |
| F | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED WITH GAP |

**Summary: the Lean is sound, kernel-checked on the standard three axioms, and states the record's count as a strengthening, on every space of admissible directions. Both r1490 gaps are repaired. Three small gaps remain: route-a.md line 93 cites the kernel check beside "$1451$ of $1637$" without saying $1637$ is not in Lean, the L17 row of lean/INDEX.md omits L17Codim.lean from its file column and reads the $3\cdot63$ entries as "on the anti-self-dual block", and the A-1 repair in L134bPhi.lean line 25 splices two clauses with a semicolon. CONFIRMED WITH GAP.**

## A. Fidelity of `L17_codim` and `L17_codim_12`

The statement: for $n\ge4$ and any submodule $V$ of operators on $\Lambda^2\mathbb R^n$ all of whose members are `Admissible` (symmetric, $\mathrm{Alt}(H)=0$, $\operatorname{tr}(H\,u)=0$), (i) $H\in V$ lies in $\ker(\mathrm{condMap}\circ V.\mathrm{subtype})$ iff $F(H)=0$, and (ii) $\dim V\le\dim\ker(\mathrm{condMap}|_V)+(3N-12)$, $N=\dim\Lambda^2\mathbb R^n$. `L17_codim_12` specialises (ii) at $n=12$ through `finrank_biv12` ($N=66$) to $+186$.

- **The count.** $u=\sum_i\lambda_i\,\mathrm{vec}_i\mathrm{vec}_i^{\mathsf T}$ with `lam6` $=(2,-1,-1,0,0,0)/\sqrt6$, so $\operatorname{rank}u=3$ and $\ker u=\mathrm{span}(\omega_0,\omega_1,\omega_2)\oplus K_c$ of dimension $3+(N-6)=N-3$, which is $63$ at $n=12$. The conditions $\Pi_{\ker u}H\omega_\gamma=0$ number $3(N-3)$, and on the $3\times3$ anti-self-dual block symmetry identifies the three off-diagonal pairs, leaving $3(N-3)-3=3N-12$. `condMap`'s target is $(K_c)^3\times\mathbb R^6$, of dimension $3(N-6)+6=3N-12$ (`finrank_cod`, from `finrank_Kc`'s $\dim K_c+6=N$, which uses `vec_orthonormal`). At $N=66$: $186=3\cdot63-3$. **Right.**
- **The record's conditions.** $\Pi_{ASD}H\Pi_{\ker u}=0$ says $\langle\omega_\gamma,Hk\rangle=0$ for every $k\in\ker u$, which for symmetric $H$ is $\Pi_{\ker u}H\omega_\gamma=0$. With $\omega_\gamma\in\ker u$ (`uOp_asd`) and `zeroφ` the indicator of $(0,0)$, that is $P_0HP_0\omega_\gamma=0$, the right side of `condMap_eq_zero_iff` and of L17Cone.lean's `F_eq_zero_iff`. **The same conditions.**
- **The kernel is $\{F=0\}\cap V$.** Conjunct (i) is proved by `F_eq_zero_iff_condMap`, the composition of `F_eq_zero_iff` (which needs exactly the three `Admissible` fields) with `condMap_eq_zero_iff`. **Exact, pointwise on $V$.** `L17_codim_12` restates only (ii), so the identification of its kernel with $\{F=0\}$ is read from `L17_codim`'s first conjunct at $n=12$. That is how the L17 row presents it.
- **Any $V$ of admissible operators: a strengthening.** The hypothesis on $V$ is membership in `Admissible`, and L17Cone.lean's docstring with L17Converse.lean's `admissible_opB` puts $\mathcal W_n\cap T_uS$ (Weyl adds Ricci-flatness, which the proof does not use) inside that class. The record's space is therefore one instance, and the bound holds for every other admissible space too. The instance itself is not formed in Lean: $\mathcal W_{12}\cap T_uS$ lives in `CurvOp2`, and turning it into a submodule of `Biv 12` operators with dimension $1637$ needs the image under `opB` and `opB`'s injectivity on it, neither of which is proved (no `opB_injective` in the layer). This is the owed item the L17 row names, so no gap here, but the owed item is larger than the arithmetic $1637$: it includes the transport. **CONFIRMED.**
- **Nothing vacuous.** $V=\bot$ is allowed and the bound is then trivial, which is correct. `hV` is used in (i) through `hV H H.2`. $n\ge4$ is needed for orthonormality of the six `vec`.

## B. `condMap_eq_zero_iff`

- **Forward.** From `condMap H = 0`: $\Pi_{K_c}H\omega_{\gamma'}=0$ for all $\gamma'$ (`h1`, through `projK`'s coercion), and the six upper-triangle entries vanish (`h2`), which `asd_entries_zero` extends to all nine by $\langle\omega_a,H\omega_b\rangle=\langle H\omega_a,\omega_b\rangle=\langle\omega_b,H\omega_a\rangle$ (`hH` then `real_inner_comm`). The nine `fin_cases` branches map $(a,b)$ to `pr6` indices $0,1,2,1^{s},3,4,2^{s},4^{s},5$ correctly. For $b\in\ker u$, `hdec` writes $b=\sum_i\langle\mathrm{vec}_i,b\rangle\mathrm{vec}_i+\Pi b$. The $\Pi b$ term dies by `inner_projL` and `h1`, the $i<3$ terms by `inner_vec_of_ker` (symmetry of $u$ and $\lambda_i\ne0$), the $i\ge3$ terms by the ASD entries through `asd`'s definition $\omega_\gamma=\mathrm{vec}_{\gamma+3}$. Then in $u$'s eigenbasis, `inner_schur_eigen₂` gives $\langle e_k,P_0HP_0\omega_\gamma\rangle=\mathrm{zeroφ}(\lambda_k,0)\langle e_k,H\omega_\gamma\rangle$, zero by `hker` when $\lambda_k=0$ and by `zeroφ` otherwise. `ext_inner_left_basis` closes. **Sound.**
- **Backward.** For $w\in\ker u$, `inner_schur_eigen₂` at $(0,0)$ gives $\langle w,H\omega_\gamma\rangle=\langle w,P_0HP_0\omega_\gamma\rangle=0$. Taking $w=\Pi H\omega_\gamma\in K_c\subset\ker u$ (`uOp_of_Kc`) gives $\lVert\Pi H\omega_\gamma\rVert^2=0$, and taking $w=\omega_{\gamma'}$ gives the six entries. **Sound.**
- **Hypotheses.** `hH` is used only in the forward direction, through `asd_entries_zero`, which is where it is needed. `hN` fixes the eigenbasis size for `schur`. No missing hypothesis, none unused. **CONFIRMED.**

## C. The r1490 repairs

- **A-1.** L134bPhi.lean lines 24 to 26 now read "for unit tangent `H` (`L24Hess.lean`'s `L24_hessian_Le`)" and add the general-norm form $3\langle u,Q(H)\rangle-\tfrac32P(u)\lVert H\rVert^2$, which is r1490's formula. `L134b_Phi`'s docstring (line 217) reads "at unit `H`". lean/INDEX.md line 463 reads "at unit $H$ by `L24_hessian_Le`". Plan milestone 6 (line 14) now states the display in the $3\langle u,Q(H)\rangle$ form and the Hessian reading "at unit $H$". **Repaired.**
- **E-1.** route-a.md line 203 now says `L134b_Phi` kernel-checks the display "with constant $P(u)-\kappa_n/9$, which is $\theta_0$ by the Setting's $\kappa_n$, and $t^2$ coefficient $3\langle u,Q(H)\rangle-\tfrac32P(u)-\kappa_nc_2$, which `L24_hessian_Le` reads as the Hessian form at unit $H$". Both readings are now attributed record-side. **Repaired.**
- *Also done:* the plan's Goal (line 3) now describes $c_2$ as "the $t^2$ coefficient of the one-sided expansion", retiring the "genuine second derivative" wording r1490 remarked on. **CONFIRMED.**

## D. Axioms

`python3 scripts/misc/axiom_audit.py --only L17Codim`: "auditing 14 declarations across 1 files, 14/14 clean, resting on the standard three alone". The fourteen are the theorems. The six definitions (`vecCoords`, `Kc`, `projL`, `projK`, `pr6`, `condMap`) carry proof obligations only in `map_add'`/`map_smul'` and reach the audit through the theorems that unfold them. No `sorry`, no `native_decide` in the file. **CONFIRMED.**

## E. Record accuracy

- **INDEX-results.md line 32** says "its codimension at most $186$ at $n=12$" and names $\dim\mathcal W_{12}\cap T_uS=1637$ "the one input left, as owed". Exact.
- **L17Codim.lean lines 23 to 24** say equality and the $1637$ are not proved. Exact.
- **lean/INDEX.md line 480** states `L17_codim` and `L17_codim_12` correctly and marks $1637$ owed. Gap E-2 below.
- **route-a.md line 93** is gap E-1 below.

**Gap E-1.** route-a.md line 93 reads "so it has dimension at least $1451$ of $T_uS$'s $1637$ ... The bound is kernel-checked as `L17_codim_12` in L17Codim.lean, on any space of admissible directions." Nothing in the paragraph says the $1637$, and so the $1451$, is record-side. "The bound" is ambiguous between the codimension (checked) and the dimension (not), and the identification of `condMap`'s kernel with $\{F=0\}$ is `L17_codim`'s first conjunct, not `L17_codim_12`. Repair: "The codimension bound is kernel-checked as `L17_codim` and `L17_codim_12` in L17Codim.lean, on any space of admissible directions. The dimension $1637$, and with it the $1451$, is not."

**Gap E-2.** lean/INDEX.md line 480, the L17 row. (i) Its file column lists L17.lean and L17Cone.lean and omits L17Codim.lean, which the row's own text cites as the proof of the dimension count. (ii) "the $3\cdot63$ entries of $P_0HP_0$ on the anti-self-dual block less the $3$ that symmetry makes redundant" puts the $189$ entries on the $3\times3$ block, which has nine. The Lean docstring's wording is exact: the $3\cdot63$ entries of $P_0HP_0$ on the three anti-self-dual bivectors, less the $3$ that symmetry makes redundant on their own block. Neither overstates what is proved. Repair both in place.

## F. Style

- No em dash in any added line of the commit.
- No backticks inside markdown link text in any added line.
- The edited markdown lines (route-a.md 93 and 203, lean/INDEX.md 463 and 480, INDEX-results.md 32, plan lines 3 and 14) are each one unwrapped line.
- The semicolons in the L17 row (line 480) and L17Codim.lean's docstring end items of a list whose items carry commas, the layer's convention. The semicolons in L17Codim.lean's proof lines are Lean tactic separators.

**Gap F-1.** L134bPhi.lean line 25, added by the A-1 repair: "for unit tangent `H` (`L24Hess.lean`'s `L24_hessian_Le`); at other norms the Hessian term is ..." joins two independent clauses with a semicolon inside one list item. Repair: a full stop.

## Verdict

**CONFIRMED WITH GAP.** The Lean is sound and faithful, a strengthening to every admissible space, the count $3N-12$ is right, and r1490's A-1 and E-1 are repaired. Open: E-1, route-a.md line 93 cites the kernel check beside "$1451$ of $1637$" without saying $1637$ is record-side. E-2, lean/INDEX.md line 480 omits L17Codim.lean from the file column and misplaces the $3\cdot63$ entries on "the anti-self-dual block". F-1, a semicolon splice at L134bPhi.lean line 25. *Note, outside the commit:* reviews/INDEX.md carries the r1490 row twice (line 1635 and the last row before this one).
