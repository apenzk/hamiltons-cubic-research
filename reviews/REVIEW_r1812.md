# REVIEW r1812: L224Eq.lean, step 5's first half of L224

*Gate 2 on [L224Eq.lean](../lean/HamiltonsCubic/Results/L224Eq.lean) at commit 4273add4, against [findings/second-order.md](../findings/second-order.md), Lemma L224, step 5. The file compiles, both declarations rest on the standard three axioms, every hypothesis is used, and the theorem carries the record's first half of step 5 faithfully in a homogeneous, Θ-parametrised form. The observations concern what the theorem leaves for step 5's second half to derive, and one name missing from the INDEX owed list at odd n.*

| # | Claim | Verdict |
|---|---|---|
| C1 | `charOne_le`: L57's diagonal bound, taken as a hypothesis with constant Θ, holds for every Weyl operator of character 1 | CONFIRMED |
| C2 | `L224_eq_tight` carries the record's step 5 first half: at equality, q_E(y) = λ‖y‖², q_E(x) = λ‖x‖², W' attains Θ, and λ > 0 when s > 0 | CONFIRMED WITH OBSERVATIONS |
| C3 | The Θ-parametrised form carries Θ_n at both parities through `L57_diagonal` and `L57_diagonal_odd` | CONFIRMED WITH OBSERVATIONS |
| C4 | The y = x = 0 branch is the record's "At s=0, W=E is diagonal" | CONFIRMED WITH OBSERVATIONS |
| C5 | lean/INDEX.md's L224 sentence and owed list, and the L222 row's new owed item | CONFIRMED WITH OBSERVATIONS |

**Summary.** CONFIRMED WITH OBSERVATIONS: the Lean is a faithful and slightly stronger form of the record's step 5 first half, with O1 to O5 recording what the second half must still derive and one INDEX gap at odd n.

## 1. The record

Step 5, quoted verbatim: "**Equality.** If $P(W)=\Theta_n$ then $P(W')=\Theta_n$, $q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$. At $s=0$, $W=E$ is diagonal. At $s>0$, $\lVert E\rVert<1$ gives $P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$, so $\lambda>0$."

Step 4, quoted verbatim: "**Rank one.** Let $\lambda$ be the top eigenvalue of the quadratic form $q_E(z)=\langle E,G_z\rangle$ on $\{\sum z=0\}$ and $z_*$ a unit eigenvector for it. Then $q_E(y)+q_E(x)\le\lambda s=q_E(\sqrt s\,z_*)$, so $W'=E+D^-_{\sqrt sz_*}$ is a unit diagonal tensor with $P(W)\le P(E)+3\lambda s=P(W')\le\Theta_n$ by L57."

## 2. Build and audit

- `lake env lean HamiltonsCubic/Results/L224Eq.lean` from lean/: exit 0, no output.
- `python3 scripts/misc/axiom_audit.py --only L224Eq.lean`: "auditing 2 declarations across 1 files", "2/2 clean -- resting on the standard three alone".
- The file at HEAD is identical to the file at 4273add4.

## 3. `charOne_le`

It unpacks `charOne_diag` (Weyl of character 1 gives a weight w with P and ‖·‖² equal to those of `diagOp w`) and rewrites the hypothesis into the operator form. The hypothesis hL57 is used verbatim, and `RealLayer.norm` unfolds to the square root of `normSq`, so the rewrite is exact. CONFIRMED.

## 4. `L224_eq_tight` against the record

**The chain.** The proof takes y, x from `L224_norm` and the cubic P(D+ν) = P(E) + 3q_E(y) + 3q_E(x) from `L224_cubic_pair` with `Q_Dminus` and `Q_nuX`. It then builds W' = E + D⁻_{√s z₁} from `exists_qE_max`, whose z₁ satisfies q_E(z) ≤ ‖z‖² q_E(z₁) on the plane, which is the record's "top eigenvalue" without eigenvector language. With ‖W'‖ = ‖W‖ (orthogonality by `inner_flip_zero`) and `charOne_le` at W', the chain P(W) ≤ P(W') ≤ Θ‖W'‖³ = Θ‖W‖³ = P(W) closes. That gives q_E(y) + q_E(x) = s·λ, and with each term bounded separately by ‖·‖²λ, each equality follows. This is the record's "If $P(W)=\Theta_n$ then $P(W')=\Theta_n$, $q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$", in homogeneous form.

**Fidelity question 3, λ > 0.** The Lean argues by contradiction: λ ≤ 0 gives q_E(y) + q_E(x) ≤ sλ ≤ 0, so P(W) ≤ P(E) ≤ Θ‖E‖³. Then ‖E‖² = ‖W‖² − 2s < ‖W‖² because s > 0 (`hnE`, `Real.sqrt_lt_sqrt`, `pow_lt_pow_left₀`), and Θ > 0 turns the cube inequality into Θ‖E‖³ < Θ‖W‖³ = P(W), a contradiction (`nlinarith`, the only use of hΘ). The record's "$\lVert E\rVert<1$ gives $P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$, so $\lambda>0$" is this argument at unit norm, with the step "λ ≤ 0 forces P(W) ≤ P(E)" and the positivity of Θ_n left implicit. The Lean supplies both. Faithful.

**Fidelity question 5, hypotheses and vacuity.**

- hΘ is used in `hlam`. hL57 is used twice (at W' and at E). hjk, hDW, hνW, hD, hν feed `L224_norm` and the cubic. heq feeds `htight`. None is idle.
- The maximiser property of z₁ is exported verbatim (`hbound`), with z₁ on the plane and of unit norm.
- heq is satisfiable in both branches (section 6), so neither disjunct is vacuous.
- The branches are split on s = 0, and within s > 0 the witness for a nonempty unit sphere is taken from y or from x, whichever is nonzero. The case y = 0, x ≠ 0 is thus handled, which section 6's second object exercises.

## 5. The Θ parametrisation and the INDEX

**Fidelity question 1.** hL57 has the shape `∀ w, IsWeight w → Pcubic (diagOp w) ≤ Θ * norm (diagOp w) ^ 3`. `L57_diagonal` (n ≥ 4) and `L57_diagonal_odd` (n ≥ 5 odd) state exactly this with Θ the even or odd Θ_n in terms of `Fintype.card ι`, which `Fintype.card_fin` rewrites to n, as [L224Bound.lean](../lean/HamiltonsCubic/Results/L224Bound.lean) already does. Θ > 0 holds at both: √12/4 at n = 4 and upward, and thetaOddSq(n) = 2(n−1)(n−3)/((n+1)(n−2)) > 0 at n ≥ 5. The instantiation itself is not written anywhere (O1).

**Fidelity question 2.** The left branch is s = 0, equivalently y = x = 0, which is the record's "At $s=0$". The record's conclusion "$W=E$ is diagonal" is not exported but follows in a few lines (O2).

**Fidelity question 4.** The second half needs W' to be an L57 maximiser, y and x to be eigen-directions, and P(W') = Θ‖W'‖³. The last two are exported directly. The first needs a bridge (O3).

**INDEX.** The L224 result row's sentence reads: "**`L224_eq_tight`**, at $P(D+\nu)=\Theta\lVert D+\nu\rVert^3$ for any positive $\Theta$ bounding the diagonal operators, either $y=x=0$ or $\lambda=q_E(z_*)>0$ with $q_E(y)=\lambda\lVert y\rVert^2$, $q_E(x)=\lambda\lVert x\rVert^2$, and $W'=E+D^-_{\sqrt sz_*}$ attaining $\Theta$ (r1808 O2); standard three axioms." It is accurate. The owed list opens with "step 5's second half, $W'$ an L57 maximiser (`L57_unit_eq`) whose block-constant form gives $q_E=q_{B'}$ of rank one with the line of $\bar u$ as the whole top eigenspace, and the rotation $e^{\varphi\xi}$ carrying $W'$ to $W$ (L222 item 5)", which names the second half (O4 on the odd parity). The L222 row's new item, "the converse of `pair_eq_nuX`, that `nuX j k x` with $x$ zero at $j,k$ and $\sum x=0$ is Weyl of character $\varepsilon_j\varepsilon_k$ (r1809 O2)", is accurate: a search of lean/HamiltonsCubic finds no theorem giving `IsWeyl2 (nuX …)` or its sign character. It is also what the converse direction of the Statement's equality clause will need (O5).

## 6. Hand evaluation (exact, by hand, labelled as such)

A hand evaluation, not a machine check. n = 4, j = 1, k = 2, the diagonal form P = Σ K_pq³ + 3 Σ_triangles K_pq K_pr K_qr and ‖W‖² = Σ K_pq². Θ_4 = √(2·3·2)/4 = √3/2. The plane {z₁ = z₂ = 0, Σz = 0} is the line of û = (0,0,1,−1)/√2.

**Object 1, a sphere product with j, k in different blocks.** B has K₁₃ = K₂₄ = 2 and the other four entries −1 (blocks A = {1,3}, B = {2,4}).

- P(B) = (2·8 − 4) + 3·(4·2) = 36, ‖B‖² = 12, Θ‖B‖³ = (√3/2)·24√3 = 36. Equality holds.
- E = ½(B + σB): K₁₂ = K₃₄ = −1, K₁₃ = K₂₃ = K₁₄ = K₂₄ = ½. The odd part is D⁻_y with y = (3/2)(0,0,1,−1), Σy = 0, ‖y‖² = 9/2. Here ν = 0, x = 0, s = 9/2 > 0.
- ‖E‖² = 3 = 12 − 2s. P(E) = (−2 + ½) + 3·(4·(−¼)) = −9/2.
- G_û: K₁₃ = K₁₄ = K₂₃ = K₂₄ = ½, K₁₂ = −1, K₃₄ = −1. λ = q_E(û) = 1 + 1 + 4·¼ = 3 > 0. The record's formula gives c = α_A + α_B − 2γ = 2 + 2 + 2 = 6, ū = (½, −½) on {3,4}, λ = 6·½ = 3. They agree.
- Tight equalities: q_E(y) = 9/2 · 3 = 27/2 = λ‖y‖², q_E(x) = 0 = λ‖x‖². P(E) + 3q_E(y) = −9/2 + 81/2 = 36 = P(B).
- W' = E + D⁻_{√s û} = E + D⁻_y = B, attaining Θ. With z₁ = −û, W' = σB, also attaining 36.
- The λ > 0 step: Θ‖E‖³ = (√3/2)·3√3 = 9/2 < 36, and P(E) = −9/2 ≤ 9/2.

**Object 2, the 45° rotation in the (1,2)-plane.** By `rot45_Dminus` it carries D⁻_y to ν_y and fixes E (E has K₁ₐ = K₂ₐ), so W = E + ν_x with x = (3/2)(0,0,1,−1) and y = 0. Then ‖W‖² = 3 + 2·9/2 = 12 and P(W) = P(E) + 3q_E(x) = 36 by step 3. Here y = 0 and x ≠ 0, so s = 9/2 and the right branch holds with the plane's unit vector taken from x. q_E(y) = 0 = λ·0, q_E(x) = 27/2 = λ‖x‖², λ = 3 > 0, W' = B or σB.

Both objects satisfy every conclusion of `L224_eq_tight`, and both have s > 0, so the right disjunct is inhabited. W = E (a diagonal E attaining Θ with s = 0) inhabits the left disjunct, for instance an L57 maximiser with j, k in the same block.

## 7. Observations

- **O1. The parity instantiation is argued, not written.** No declaration applies `L224_eq_tight` with `L57_diagonal` or `L57_diagonal_odd`. The types match after `Fintype.card_fin`, and Θ > 0 is a one-line positivity fact at each parity, so this is routine. The step 5 assembly will need both corollaries.
- **O2. The left branch exports y = x = 0 only.** The docstring's "(so D+ν=E)" and the record's "$W=E$ is diagonal" follow from the exported `hM` and `ν = nuX j k x` at zero arguments, plus `charOne_diag` for diagonality. Neither is stated. A corollary stating D + ν = E would make the branch read as the record does.
- **O3. The bridge to `L57_unit_eq` is owed.** The attained equality is stated for W' at its own norm. `L57_unit_eq` wants a weight S with `fro S = 2` and `diagP S` equal to the constant, so the second half needs charOne_diag at W', a rescaling to unit norm, and s > 0 to know W' ≠ 0. ‖W'‖ = ‖W‖ (the internal `hnW'`) and "W' is Weyl of character 1" are also internal and not exported. All are derivable from the exported z₁ facts and the lemmas the proof cites.
- **O4. The owed list names `L57_unit_eq` only.** At odd n the second half runs through `L57_unit_eq_odd` in [L57OddEq.lean](../lean/HamiltonsCubic/Results/L57OddEq.lean), whose maximiser is two-valued with block sizes differing by one. The record's block-constant argument covers it, but the owed list should name both.
- **O5. The converse of `pair_eq_nuX` is the gap for the Statement's "Conversely".** Object 2 needs ν_x to be Weyl of character ε_jε_k, which the record asserts in step 1 and which the INDEX correctly lists as owed. Section 6 uses it by hand.

## 8. What would falsify each headline

- C1 would fall if `charOne_diag`'s norm equation related `normSq2 W` to anything other than `normSq (diagOp w)`, making the unfolded norm differ from `Real.sqrt (normSq2 W)`.
- C2 would fall if an operator D + ν satisfying every hypothesis had λ ≤ 0 with s > 0, or had q_E(y) < λ‖y‖² at equality. Object 1 and object 2 are consistent with the theorem, and the kernel check excludes this given the cited lemmas.
- C3 would fall if `L57_diagonal` or `L57_diagonal_odd` stated the bound with a different norm or on a restricted class of weights. Both state it for every `IsWeight w` with `RealLayer.norm`.
- C4 would fall if s = 0 did not force y = x = 0. The proof derives this from the vanishing of sums of squares.
- C5 would fall if a theorem proving the converse of `pair_eq_nuX` existed in lean/HamiltonsCubic. None was found.
