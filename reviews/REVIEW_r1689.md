# REVIEW r1689: L226 item 2 at |J| = 3, first Bianchi for the block operator and the Weyl equivalence (059aec2a)

**Verdict: CONFIRMED WITH GAPS.** `blockOp_bianchi` in [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean) states `IsWeyl`'s third clause for `blockOp` at every index quadruple of `Fin 3 ⊕ Fin m`, under exactly the record's symmetries of $S$, $M_a$ and $K$, and `isWeyl_blockOp_iff` is item 2 of [L226](../findings/second-order.md) at $k=3$ with item 3's automatic Bianchi absorbed, the Bianchi conjunct of item 2 correctly absent from the right-hand side. `kc` is the outer case of `blockCoeff` character for character and `pk` is `pairing`'s formula applied to it, so `bianchi_K` is the outer block of the Bianchi sum. A nonzero Weyl witness and a non-Weyl instance of the same shape both compile against the theorem, and the 13 declarations of the file rest on the standard three axioms. The one gap is editorial and outside the commit: the record's Lean paragraph in [second-order.md](../findings/second-order.md) still lists first Bianchi and the rest of item 2 as owed.

| # | Claim | Verdict |
|---|---|---|
| 1a | `blockOp_bianchi` is `IsWeyl`'s third clause for `blockOp`, at every quadruple, under the record's hypotheses | **CONFIRMED** |
| 1b | `isWeyl_blockOp_iff` is item 2 at $k=3$ with item 3's automatic Bianchi absorbed, on the record's hypotheses (symmetric $S$, $M_a$, $K$, $K_{aa}=0$) | **CONFIRMED** |
| 1c | `hK0` is a normalisation, loses no block operator, and is load-bearing for the iff | **CONFIRMED** (by hand) |
| 2 | `kc` is exactly the outer case of `blockCoeff`, and `bianchi_K` is the outer block of `bianchi (blockOp S M K)` | **CONFIRMED** |
| 3 | Non-vacuity: an object satisfying the hypotheses and both sides of the iff | **CONFIRMED** (kernel-checked witness, $m=2$) |
| 4 | Axioms: standard three only | **CONFIRMED** (13/13 clean, a screen by the repo's audit script) |
| 5 | The [lean/INDEX.md](../lean/INDEX.md) row claims what is proved | **CONFIRMED** |
| 6 | The record's Lean paragraph agrees with the Lean | **GAP** (G1) |

One line: the Bianchi clause and item 2's equivalence at $|J|=3$ are stated faithfully and proved on the standard axioms, and only the record's Lean paragraph lags behind.

## Attack line 1: statement fidelity

- **`IsWeyl`'s third clause** ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)) is `∀ i j k l, bianchi R i j k l = 0`, and `bianchi R i j k l = inner2 (R φ_ij) φ_kl + inner2 (R φ_ik) φ_lj + inner2 (R φ_il) φ_jk` ([WeylReal.lean:110](../lean/HamiltonsCubic/Base/WeylReal.lean#L110)). `blockOp_bianchi S hS M hM K hK i j k l : bianchi (blockOp S M K) i j k l = 0` with `i j k l : Fin 3 ⊕ Fin m` free is that clause for `R = blockOp S M K`, verbatim, with nothing restricted: repeated indices, all-$J$, all-outer and every mixed pattern are in scope.
- **Hypotheses of `blockOp_bianchi`.** `hS : S.IsSymm`, `hM : ∀ a, (M a).IsSymm`, `hK : ∀ a b, K a b = K b a`. These are the Setting's symmetric $R_J$ (written as symmetric $S$ in item 3's frame), symmetric $M_a$, and $K$ symmetric (forced by $\varphi_{ba}=-\varphi_{ab}$). No Ricci hypothesis and no `hK0`, which matches step 4: Bianchi uses only the pair symmetries. The theorem is therefore at least as strong as the record needs.
- **The all-$J$ block is item 3's "Bianchi holds automatically".** Step 5's reason is that four indices from a three-element set repeat one. The Lean closes the all-`inl` case by `fin_cases` over the $81$ quadruples with the $\varepsilon$ table and the three off-diagonal symmetries of $S$, so it proves the same fact for every symmetric $S$, no condition on $S$ beyond symmetry. That is the content of "automatically".
- **`isWeyl_blockOp_iff`** states `IsWeyl (blockOp S M K) ↔ (S.trace • 1 - S + ∑ a, M a = 0 ∧ ∀ a, (M a).trace + ∑ b, K a b = 0)`. Against item 2: "$W\in\mathcal S_J$ lies in $\mathcal W_n$ exactly when $R_J$ satisfies Bianchi on $\mathbb R^J$, $\rho(R_J)+\sum_aM_a=0$, and $\operatorname{tr}M_a+\sum_{b\ne a}K_{ab}=0$ at every $a$."
  - The Bianchi conjunct is dropped because at $k=3$ it is always true (item 3), which is what the brief asks for. The forward direction reads only `h.2.2.2`, and the reverse supplies `blockOp_bianchi` unconditionally, so the absorption is explicit in the proof.
  - $\rho(R_J)=(\operatorname{tr}S)I-S$ is item 3's third identity, and `Ric_blockOp_J` (proved earlier, reviewed in the r1687 and r1688 rounds) is what ties the Lean's `S.trace • 1 - S` to $\rho(R_J)$ through the base layer's `Ric`. The first conjunct is item 2's $J$ condition in item 3's coordinates.
  - The second conjunct sums over all `b`, including `b = a`. With `hK0` this is $\sum_{b\ne a}K_{ab}$.
  - Hypotheses: `hS`, `hM`, `hK`, `hK0`, exactly the brief's list and the Setting's.
- **The domain.** `blockOp S M K` with symmetric data is the Lean's parametrisation of $\mathcal S_J$ at $k=3$. That every $W\in\mathcal S_J$ is of this form is the Setting's appeal to the block note, and neither the row nor the theorem claims it. The iff is therefore item 2 on the image of `blockOp`, which is the only form in which the record's $\mathcal S_J$ exists in the layer.

### 1c: `hK0`

- **Normalisation.** Every `K` branch of `blockCoeff` is guarded by `a ≠ b`, so `blockOp S M K` does not read `K a a`. Setting the diagonal to zero changes no operator, so `hK0` loses no block operator.
- **Load-bearing.** Without it the iff is false: fix any Weyl instance and add $t\ne0$ to one `K a a`. The left side is unchanged and the second conjunct at that `a` moves by $t$. So `hK0` is exactly the hypothesis that makes `∑ b` read as the record's $\sum_{b\ne a}$, and it is present.

## Attack line 2: `kc` and `bianchi_K`

- **`kc` against `blockCoeff`.** `blockCoeff`'s outer case ([L226Statement.lean:64](../lean/HamiltonsCubic/Results/L226Statement.lean#L64)) is `if a ≠ b ∧ a = c ∧ b = d then K a b else if a ≠ b ∧ a = d ∧ b = c then -K a b else 0`. `kc K a b c d` is the same expression, token for token. So on four `inr` arguments `blockCoeff S M K (.inr a) (.inr b) (.inr c) (.inr d)` unfolds to `kc K a b c d`, definitionally.
- **`pk` against `pairing`.** `pairing` ([L226Statement.lean:99](../lean/HamiltonsCubic/Results/L226Statement.lean#L99)) gives `inner2 (opOf C φ_ab) φ_cd = ¼ (C a b c d - C b a c d - (C a b d c - C b a d c))`. `pk K a b c d` is that right side with `C = kc K`, same signs and same order of subtraction.
- **The cyclic sum.** `bianchi_K` states `pk a b c d + pk a c d b + pk a d b c = 0`, which is `bianchi`'s pattern $(ij,kl)+(ik,lj)+(il,jk)$ at $(i,j,k,l)=(a,b,c,d)$. So after `simp only [pairing, blockCoeff]` the all-`inr` goal of `blockOp_bianchi` is literally the statement of `bianchi_K`, and the `exact bianchi_K K hK _ _ _ _` branch discharges the right goal. It cannot close a different goal: `exact` requires the types to agree up to definitional unfolding, and the only unfolding between the two is `kc`'s body.
- **Hand check of `bianchi_K`'s truth**, independent of the tactic. `kc a b c d` is nonzero only when $a\ne b$ and $(c,d)$ is $(a,b)$ or $(b,a)$, so a term `pk a x y z` can be nonzero only when $\{y,z\}=\{a,x\}$. With $a,b,c,d$ pairwise distinct every term vanishes. Example $c=b\ne a$, $d\notin\{a,b\}$: the pairs are $(ab,bd)$, $(ab,db)$, $(ad,bb)$, none of the required shape, so all three vanish. Example $c=a$, $d=b\ne a$: `pk a b a b` $=\tfrac14(K_{ab}+K_{ba}+K_{ab}+K_{ba})=K_{ab}$, `pk a a b b` $=0$, `pk a b b a` $=-K_{ab}$, sum zero by `hK`. The kernel checks all 64 branches of the six `by_cases`. It does not need `hK0`, which is correct since `kc` never reads the diagonal.
- **The mixed blocks** close by `split_ifs`, `subst_vars` and `hM'`, the symmetry of $M_a$, which is step 4's "a Bianchi sum with a repeated index follows from the pair symmetries". Every mixed quadruple with a nonzero term has a repeated outer index, since `blockCoeff`'s mixed entries require `a = b`.

## Attack line 3: non-vacuity

A kernel-checked witness, compiled against the built layer with `lake env lean` on an uncommitted scratch file, exit 0:

- **A nonzero Weyl block operator.** $m=2$, $M_0=M_1=I$, $K_{01}=K_{10}=-3$, $K_{aa}=0$, $S=-I$. Then $\operatorname{tr}M_a+\sum_bK_{ab}=3-3=0$ and $(\operatorname{tr}S)I-S+\sum_aM_a=-3I+I+2I=0$, so both conjuncts hold. `IsWeyl (blockOp (-1) (fun _ => 1) Kw)` is proved by rewriting with `isWeyl_blockOp_iff` and discharging the two conjuncts. All four hypotheses (`hS`, `hM`, `hK`, `hK0`) are discharged, so the object satisfies the hypotheses and both sides.
- **A non-Weyl instance of the same shape.** Same $M$, $K$ with $S=0$: the first conjunct's $(0,0)$ entry is $2\ne0$, and `¬ IsWeyl (blockOp 0 (fun _ => 1) Kw)` compiles through the theorem's forward direction. So the iff separates real data and neither side is constant.
- The witness's $S$ is item 3's $S=N-\tfrac12(\operatorname{tr}N)I=2I-3I=-I$, as `Pcubic_ricciFlat` requires.

## Attack line 4: axioms

- `python3 scripts/misc/axiom_audit.py --only L226Mixed.lean`: "auditing 13 declarations across 1 files, 13/13 clean, resting on the standard three alone". The witness file's own `#print axioms` on `isWeyl_blockOp_iff`, `blockOp_bianchi` and `bianchi_K` returned `[propext, Classical.choice, Quot.sound]` for each. This is a screen by the repo's script.
- `set_option maxHeartbeats 1000000` on the two heavy proofs raises elaboration budget only and adds no axiom.

## Attack line 5: the row

- The new sentences name `blockOp_bianchi` with the three block mechanisms and `isWeyl_blockOp_iff` with the two Ricci conditions, as stated. The owed list shrinks to items 1 and 2 at $k\ne3$, which is correct: `blockOp` exists only at $k=3$, and the $k=3$ content of item 2 (Bianchi, Ricci, and the equivalence) is now complete.

## G1: the record's Lean paragraph is stale

- [second-order.md](../findings/second-order.md), L226's **Lean.** paragraph, still reads "Owed in Lean: the first Bianchi identity for `blockOp` ..., the rest of item 2's equivalence, and $k\ne3$". After 059aec2a only $k\ne3$ is owed. Repair: replace the owed sentence with one naming `blockOp_bianchi` and `isWeyl_blockOp_iff` as proved and $k\ne3$ as owed. This is the same drift r1688's G2 reported for the previous round.

## What would break the claims, and what was done to look for it

- **The breaking object** would be a symmetric triple $(S,M,K)$ with zero-diagonal $K$ for which the Ricci conditions hold but some Bianchi sum of `blockOp` is nonzero, or for which `IsWeyl` holds and a Ricci conjunct fails. The second is excluded by `ricciFlat_iff` (reviewed before). The first would require a nonzero Bianchi sum, and `blockOp_bianchi` rules it out at every quadruple with no Ricci hypothesis.
- **A mis-stated statement** would be the realistic failure: a `kc` differing from `blockCoeff`'s outer case (checked token for token), a `pk` with a sign or slot swap against `pairing` (checked), a cyclic sum in the wrong pattern (checked against `bianchi`'s definition), a quadruple type narrower than `Fin 3 ⊕ Fin m` (it is the full type), or a missing `hK0` (present and shown necessary).
- **Vacuity** was tested by the compiled witness pair above, one each side of the iff.
- No numerical run was made. The witness is a single kernel check on objects in hand.
