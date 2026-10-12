# REVIEW r1686: L226's mixed Ricci entries of the block operator (2968c8de)

**Verdict: CONFIRMED WITH GAPS.** [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean) proves the record's $\operatorname{Ric}_{pa}=\operatorname{Ric}_{ap}=0$ and $\operatorname{Ric}_{ab}=0$ at $a\ne b$ for `blockOp`, the same operator the diagonal Ricci theorems use, against the base layer's `Ric`, which is the record's contraction $\sum_r\langle W\varphi_{ir},\varphi_{jr}\rangle$. The three statements are universally quantified over free $S,M,K$, so they specialise to every block operator of $\mathcal S_J$ at $k=3$, and all three rest on the standard three axioms. Two gaps, both in the prose around the file: the record's own Lean paragraph still says the mixed entries are outside the Lean, and the L226 row's owed list names $k\ne3$ only for item 1 although every Ricci theorem, the new ones included, is at $k=3$.

| # | Claim | Verdict |
|---|---|---|
| 1a | `Ric_blockOp_Jout`, `Ric_blockOp_outJ`, `Ric_blockOp_outer_ne` are the record's $\operatorname{Ric}_{pa}$, $\operatorname{Ric}_{ap}$, $\operatorname{Ric}_{ab}$ in the record's convention | **CONFIRMED** |
| 1b | `blockOp` is the operator of `Ric_blockOp_J` and `Ric_blockOp_outer` | **CONFIRMED** |
| 1c | $a\ne b$ is the right hypothesis | **CONFIRMED** |
| 2 | The hypothesis-free form (no symmetry of $S$, $M_a$, $K$, no zero diagonal) is a strength and hides no mismatch | **CONFIRMED** |
| 3a | The row's new sentence claims exactly what the file proves | **CONFIRMED WITH GAPS** (G2) |
| 3b | Everything in item 2 is now proved or owed | **CONFIRMED WITH GAPS** (G2) |
| 3c | The record agrees with the row about what the Lean holds | **GAP** (G1) |
| 4 | Axioms: standard three only | **CONFIRMED** (3/3 clean, a screen by the repo's audit script) |

One line: the three theorems are exactly step 4's mixed entries at $k=3$ and cannot be vacuous, but [second-order.md:1578](../findings/second-order.md#L1578) still reports them outside the Lean and the row's owed list omits item 2 at $k\ne3$.

## Attack line 1: statement fidelity

- **The contraction.** `RealLayer.Ric R a b = ∑ c, inner2 (R (phi a c)) (phi b c)` ([WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean#L106)), with `inner2 X Y = ½ tr(XᵀY)` and `phi i j = E_ji - E_ij`, so $\langle\varphi_{ij},\varphi_{kl}\rangle=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$. This is the record's $\operatorname{Ric}_{ij}=\sum_r W_{ir,jr}$, the convention of $\rho(R_J)_{pq}=\sum_r\langle R_J\varphi_{pr},\varphi_{qr}\rangle$ in item 2. The sum runs over the whole index set `Fin 3 ⊕ Fin m`, $J$ and $A$ together, as the record's Ricci does.
- **The operator.** All three theorems take `blockOp S M K` from [L226Statement.lean:69](../lean/HamiltonsCubic/Results/L226Statement.lean#L69), the definition `Ric_blockOp_J` ([:1213](../lean/HamiltonsCubic/Results/L226Statement.lean#L1213)) and `Ric_blockOp_outer` ([:1230](../lean/HamiltonsCubic/Results/L226Statement.lean#L1230)) and `Pcubic_blockOp` use. The imports and `open` make `Ric` resolve to `RealLayer.Ric`, the same constant the diagonal theorems unfold.
- **Hand expansion of each term.** `pairing` gives $\langle W\varphi_{ic},\varphi_{jc}\rangle=\tfrac14(C_{icjc}-C_{cijc}-C_{iccj}+C_{cicj})$ with $C=$ `blockCoeff`. I expanded all four index patterns for both kinds of $c$:
  - $\operatorname{Ric}_{pa}$, $i=$ `inl p`, $j=$ `inr a`. At $c=$ `inl r` the patterns are $(\ell,\ell,r,\ell)$, $(\ell,\ell,r,\ell)$, $(\ell,\ell,\ell,r)$, $(\ell,\ell,\ell,r)$, writing $\ell$ for `inl` and $r$ for `inr`. At $c=$ `inr b` they are $(\ell,r,r,r)$, $(r,\ell,r,r)$, $(\ell,r,r,r)$, $(r,\ell,r,r)$. None of these eight patterns is a case of `blockCoeff`, so each falls to the wildcard `0`. $\operatorname{Ric}_{ap}$ is the mirror and gives the same eight patterns permuted.
  - $\operatorname{Ric}_{ab}$, $i=$ `inr a`, $j=$ `inr b`. At $c=$ `inl r` the patterns are the four $M$ cases, each `if a = b then ±M a r r else 0`, zero at $a\ne b$. At $c=$ `inr c` the four $K$ cases are `if a ≠ c ∧ a = b ∧ c = c` or `if a ≠ c ∧ a = c ∧ ...` and their mirrors, every branch requiring $a=b$ or $a=c\ne a$, so zero.
- This is the record's reason word for word: the only nonzero entries have index shapes $JJJJ$, $\{p,q,a,a\}$ with the outer index repeated, or $\{a,b,a,b\}$, and a Ricci term $W_{ic,jc}$ with $i,j$ from different blocks, or two distinct outer indices, has none of these shapes.
- **Is $a\ne b$ right.** Yes. At $a=b$ the entry is $\operatorname{Ric}_{aa}=\operatorname{tr}M_a+\sum_{b\ne a}K_{ab}$, which is `Ric_blockOp_outer`, generally nonzero. The hypothesis is used exactly where the proof discharges `if a = b` and the $K$ branches (`hab`, `h1`, `h2`).
- **Both orders stated.** `Ric` of a non-symmetric operator is not symmetric in its two indices, and `blockOp` with free $M$ need not be symmetric, so stating $\operatorname{Ric}_{ap}$ separately from $\operatorname{Ric}_{pa}$ is correct and needed. $\operatorname{Ric}_{ba}$ at $a\ne b$ is `Ric_blockOp_outer_ne` with the roles swapped, since its hypothesis is symmetric.

## Attack line 2: non-vacuity and the free parameters

- **What the record's $W$ satisfies.** $W\in\mathcal S_J$ gives symmetric $R_J$ (so symmetric $S$ at $k=3$), symmetric $M_a$, and $K$ symmetric with zero diagonal, since $W\varphi_{ab}=K_{ab}\varphi_{ab}$ and $\varphi_{ba}=-\varphi_{ab}$.
- **Why the free form is a strength.** The three theorems are $\forall S\,M\,K$ with no hypothesis beyond $a\ne b$. Each record instance is one choice of $(S,M,K)$, so each theorem specialises to it. A universally quantified conclusion over a superset of the intended inputs cannot be vacuous: no hypothesis can be unsatisfiable, and the conclusion is an equation that holds at every input.
- **Could the free form hide a mismatch.** Only if `blockOp` at non-symmetric data were not the record's operator at symmetric data, which does not arise: the theorems hold at every input, the record's included. The vanishing uses no symmetry at all, which matches the record's reason, a block-shape argument with no algebra. The diagonal theorems need `hS`, `hM` (for `eps_S_contract`) and `hK`, `hK0` (for the $K$ sum), and the mixed ones have no such step.
- **What stays outside this file and this review.** That `blockOp` at symmetric data IS the general element of $\mathcal S_J$ at $k=3$ is `blockCoeff`'s fidelity, screened in [screen_blockcoeff_L226.py](../scripts/misc/screen_blockcoeff_L226.py) and accepted by earlier L226 reviews. The mixed theorems inherit it unchanged.
- **The object that would break the claims** is a `blockCoeff` case with an index pattern mixing blocks, e.g. a $J$-to-$V_a$ entry $W_{pq,ra}$ or a $V_a$-to-$\Lambda^2\mathbb R^A$ entry $W_{pa,bc}$ written nonzero. I read every case of `blockCoeff` ([L226Statement.lean:57](../lean/HamiltonsCubic/Results/L226Statement.lean#L57)): the $J$ block, four $M$ cases each of shape $\{p,q,a,b\}$ gated by `a = b`, two $K$ cases of shape $\{a,b,a,b\}$ gated by `a ≠ b`, and the wildcard `0`. There is none.

## Attack line 3: the row and item 2's ledger

- **The new row sentence.** "The mixed Ricci entries vanish, PROVED in L226Mixed.lean: `Ric_blockOp_Jout` and `Ric_blockOp_outJ` ($\mathrm{Ric}_{pa}=\mathrm{Ric}_{ap}=0$) and `Ric_blockOp_outer_ne` ($\mathrm{Ric}_{ab}=0$ at $a\ne b$), each term of $\sum_rW_{ir,jr}$ an entry `blockCoeff` sets to zero; standard three axioms." Each clause matches a theorem, and the proof description matches the tactic proof (`pairing`, `Fintype.sum_sum_type`, `simp [blockCoeff]`).
- **Ledger of item 2 against the row.**

| Item 2 clause | Row |
|---|---|
| $\operatorname{Ric}_{pq}=\rho(R_J)_{pq}+\sum_a(M_a)_{pq}$, $k=3$ | proved, `Ric_blockOp_J` |
| $\operatorname{Ric}_{aa}=\operatorname{tr}M_a+\sum_{b\ne a}K_{ab}$, $k=3$ | proved, `Ric_blockOp_outer` |
| $\operatorname{Ric}_{pa}=\operatorname{Ric}_{ap}=0$, $\operatorname{Ric}_{ab}=0$, $k=3$ | proved, this commit |
| $\rho(R_J)=(\operatorname{tr}S)I-S$ at $k=3$ | proved, inside `Ric_blockOp_J` |
| the Bianchi clause | owed |
| the equivalence $W\in\mathcal W_n\iff$ Bianchi and both Ricci conditions | owed |
| all Ricci entries at $k\ne3$ | **absent** (G2) |

- **G2.** The row's owed list reads "the Bianchi clause, the equivalence of item 2, and item 1 at $k\ne3$". Item 2 is stated for every $k\ge2$, and all five Ricci theorems are at $|J|=3$ because `blockOp` is. The row's header does say "AT $\lvert J\rvert=3$", and the equivalence at general $k$ is owed and would need the entries, so nothing false is asserted. The owed list is still incomplete as written: it should read "items 1 and 2 at $k\ne3$". The wording predates this commit, and this commit rewrote the owed list, so the repair belongs here.
- **G1, the record.** [second-order.md:1578](../findings/second-order.md#L1578), the record's L226 **Lean** paragraph, still says `Ric_blockOp_J` and `Ric_blockOp_outer` are "each closed by a named `sorry`" and "the vanishing of $\operatorname{Ric}_{pa}$ and $\operatorname{Ric}_{ab}$ ... are outside the file". The `sorry` clause was already stale after 2026-09-24. The second clause is newly contradicted by this commit. The row and the record now disagree about what the kernel holds, which is the downstream sweep this commit owed.
- **Minor, no verdict.** The module docstring of [L226Statement.lean](../lean/HamiltonsCubic/Results/L226Statement.lean) still lists "the vanishing mixed Ricci entries" as "outside this file". That stays true of that file, and a pointer to L226Mixed.lean would help a reader.
- **What the equivalence at $k=3$ now needs.** With all five entry theorems proved, the Ricci half of item 2 at $k=3$ is an assembly: `IsRicciFlat (blockOp S M K)` iff $(\operatorname{tr}S)I-S+\sum_aM_a=0$ and $\operatorname{tr}M_a+\sum_bK_{ab}=0$ for every $a$, under the symmetry hypotheses the diagonal theorems carry. With the record's step 5 (Bianchi automatic at $k=3$) and symmetry of `blockOp`, that is item 2 at $k=3$. This is the natural next owed item, and it is recorded here as a pointer only.

## Attack line 4: axioms

- `python3 scripts/misc/axiom_audit.py --only L226Mixed.lean` reported "auditing 3 declarations across 1 files, 3/3 clean, resting on the standard three alone". This is a screen of the kernel's report and agrees with the commit's statement. The import of L226Mixed.lean into [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) is present, so the file is part of the build.

## Repairs requested

- **G1.** Rewrite the L226 **Lean** paragraph at [second-order.md:1578](../findings/second-order.md#L1578) to the kernel's state: `Pcubic_blockOp`, `normSq_blockOp`, `Ric_blockOp_J`, `Ric_blockOp_outer` proved in L226Statement.lean, the mixed entries proved in L226Mixed.lean, and the Bianchi clause, the equivalence of item 2 and $k\ne3$ owed.
- **G2.** In the L226 row of [lean/INDEX.md](../lean/INDEX.md), write the owed $k\ne3$ clause as covering items 1 and 2.
