# REVIEW r1779: L219Max.lean (5fe2b6d5), L219's bound at a maximiser

| Claim | Verdict | Reason |
|---|---|---|
| `even_odd_orth`: ⟨b, c⟩ = 0 | CONFIRMED | `innerOp2_sig` with σb = b and σc = −c gives ⟨b, c⟩ = −⟨b, c⟩ |
| `odd_mass_max`: ‖c‖² ≤ ¾ at a unit Weyl global maximiser, coordinate reflection | CONFIRMED | the β = 0 point of the record's plane is a unit Weyl competitor with P = (θ/2)(3α − α³), and `odd_mass_le` closes it |
| Hypothesis set matches the record | CONFIRMED WITH OBSERVATIONS | hmax is the record's maximiser, while hQ and hθ are consequences of hmax that the layer already proves and the theorem takes as extra hypotheses |
| b = 0 excluded by P(W) = θ > 0 | CONFIRMED | b = 0 makes W = c and P(W) = P(c) = 0 |
| "every unit u" recorded as owed | CONFIRMED | the L219 (statement) row lists "a general unit u (frame rotation)" as owed |
| Axioms | CONFIRMED | `#print axioms` gives propext, Classical.choice, Quot.sound for both theorems |
| L219 row against the code | CONFIRMED WITH OBSERVATIONS | every stated fact matches, and the row leaves out `even_odd_orth` and the dischargeability of hQ and hθ |

**Summary:** the theorem is a faithful, axiom-clean formalisation of step 4 at a coordinate reflection. It carries two hypotheses (criticality and θ > 0) that the layer could discharge from maximality at n ≥ 4.

## 1. Hypothesis set

- **Record.** Statement: "At a unit global maximiser, $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$." Step 4: "On the plane $\{\alpha b+\beta c\}$ at unit norm, $\beta^2s^2=1-\alpha^2(1-s^2)$, and the two relations give $P=\tfrac\theta2(3\alpha-\alpha^3)$, which exceeds $\theta$ for $\alpha<-2$. The admissible range reaches $\alpha=-(1-s^2)^{-1/2}$, so a global maximiser has $(1-s^2)^{-1/2}\le2$, that is $s^2\le\tfrac34$."
- **hmax is the record's maximiser.** It quantifies over `R : CurvOp2 ι` with `IsWeyl2 R` (self-adjoint on Λ², first Bianchi, Ricci-flat, [Bivectors2.lean:352](../lean/HamiltonsCubic/Base/Bivectors2.lean)) and `normSq2 R = 1`. That set is exactly `weylSphereSet ι` of [WeylMaximiser.lean:98](../lean/HamiltonsCubic/Results/WeylMaximiser.lean), the unit sphere of W_n used throughout the layer. The normalisation of `normSq2` (½ΣΣ inner2) is immaterial because the conclusion is the ratio ‖c‖²/‖W‖².
- **hQ is derivable.** `Qop2_eq_smul_weyl` ([WeylMaximiser.lean:132](../lean/HamiltonsCubic/Results/WeylMaximiser.lean)) gives Q(W) = P(W)·W from `IsLocalMaxOn Pcubic2 (weylSphereSet ι) W`, which hmax implies. So θ = P(W) is forced, and `odd_mass_max` also recovers P(W) = θ internally from `Tsym_crit`.
- **θ > 0 is derivable at n ≥ 4 and is an extra hypothesis as stated.** P is odd, so P(W) ≥ P(−W) gives θ ≥ 0, and `exists_weyl_maximiser` / `L24_nonvacuous` show a maximiser has P ≥ √(3/2) at `Fin n`, n ≥ 4 (any unit competitor with P = √(3/2) bounds P(W) below through hmax). For ι with fewer than four elements W_n = 0 and the hypotheses are unsatisfiable, so the theorem is vacuous there, as the record's lemma is.
- **Observation O1.** The theorem is a conditional on two hypotheses that the layer already proves from maximality. A corollary on `Fin n`, n ≥ 4, taking only hmax (composing with `Qop2_eq_smul_weyl` and the √(3/2) competitor) would state the record's hypothesis set exactly. This is a presentational gap: the stated theorem is sound and implies the record's claim once those two layer results are applied.

## 2. The β = 0 line and P(V)

- **It is the record's endpoint.** With s² = ‖c‖² and t = ‖b‖² = 1 − s², the record's constraint β²s² = 1 − α²t vanishes at α² t = 1, so α = −(1 − s²)^(−1/2) is the β = 0 end. The Lean's α = −(√t)⁻¹ with `hαt : α ^ 2 * t = 1` is this point, and V = α•b is Weyl by `even_odd_isWeyl2` and `isWeyl2_smul`, unit by `normSq2_smul`.
- **No other point of the plane is needed.** The record's argument uses one competitor: if the endpoint had α < −2 it would beat θ. That competitor is the endpoint. The interior formula (θ/2)(3α − α³) holding on the whole circle (checked by hand: α³θ(t − s²/2) + 3αβ²·(θ/2)s² reduces to (θ/2)(3α − α³) under β²s² = 1 − α²t and s² = 1 − t) explains why the record speaks of a range, and the Lean needs only its end.
- **P(V) derivation checked.** `Pcubic2_smul` gives P(V) = α³P(b). `L219_op`'s second component gives P(b) = θ(t − s²/2). With s² = 1 − t (from `hnorm`, itself from `even_odd_orth`) and α³t = α: α³θ(t − (1 − t)/2) = θ(3α³t − α³)/2 = (θ/2)(3α − α³). The `linear_combination (3/2·θ) * h3` step encodes exactly this.
- **`odd_mass_le`** ([L219Statement.lean:95](../lean/HamiltonsCubic/Results/L219Statement.lean)): from θ > 0, α < 0, α²t = 1 and (θ/2)(3α − α³) ≤ θ it gives t ≥ ¼. By hand: 3α − α³ ≤ 2 is (α − 1)²(α + 2) ≥ 0, so α ≥ −2, α² ≤ 4, t = α⁻² ≥ ¼. Then ‖c‖² = 1 − t ≤ ¾.

## 3. Excluding b = 0

- Sound. `normSq2_eq_zero` (definiteness on `CurvOp2`, [Bivectors2.lean:288](../lean/HamiltonsCubic/Base/Bivectors2.lean)) turns ‖b‖² = 0 into b = 0. Then `L219_op`'s fourth component P(W) = P(b) + 3T(b, c, c) reads P(W) = 0 via `Pcubic2_smul 0 0` and `Tsym_smul_left 0 0`, contradicting P(W) = θ > 0.
- The exclusion is needed only to define α. Mathematically b = 0 means W = c is odd, and P(c) = 0 is exactly the record's statement that the odd part has zero cubic.

## 4. "For every unit u"

- Recorded as owed. The row in [lean/INDEX.md](../lean/INDEX.md) says "A general unit u needs `CurvOp2` carried through a frame rotation, not done" and closes with "**Owed**: ... and a general unit u (frame rotation)".
- The reduction is routine on paper: O(n) acts on W_n by isometric automorphisms, so g·W is again a unit global maximiser and σ_u = g σ_{e_m} g⁻¹ for a g taking e_m to u. The Lean result at a coordinate reflection then covers every u once the action is formalised.

## 5. Axioms

- Screen file importing `HamiltonsCubic.Results.L219Max`, run with `lake env lean`:
  - `odd_mass_max` depends on axioms: [propext, Classical.choice, Quot.sound]
  - `even_odd_orth` depends on axioms: [propext, Classical.choice, Quot.sound]
- `#check` confirms the elaborated statement matches the source, with ι an arbitrary `Fintype` and m any index.

## 6. The L219 row against the code

- Matches: `odd_mass_max` hypotheses (unit, Weyl, Q(W) = θW, θ > 0, global maximiser), conclusion ‖c‖² ≤ ¾, the line V = −‖b‖⁻¹b, P(V) = (θ/2)(3α − α³), `odd_mass_le`, b = 0 excluded by P(W) = θ > 0, standard three axioms.
- **Observation O2.** The row omits `even_odd_orth`, a new exported theorem in the file. It duplicates the `horth` step inside `L219_op` ([L219Op.lean:195](../lean/HamiltonsCubic/Results/L219Op.lean)) verbatim, so `L219_op` could now consume it.
- **Observation O3.** The row states θ > 0 and Q(W) = θW as hypotheses without noting that `Qop2_eq_smul_weyl` and the √(3/2) competitor discharge them (O1).

## 7. Falsifier

- **The falsifying object** is a unit W ∈ W_n that globally maximises P on the unit Weyl sphere and has, at some reflection σ_u, odd mass ‖c_u‖² > ¾, equivalently even mass ‖b_u‖² < ¼.
- **What I did.** Checked analytically that any such W would make the unit Weyl competitor V = −‖b‖⁻¹b have P(V) = (θ/2)(3α − α³) with α < −2, hence P(V) > θ = P(W), contradicting maximality. The kernel checks the same chain at a coordinate reflection. I ran no numerics: the argument is a closed kernel proof and the only open reach is the frame rotation, which is an equivariance statement with no numerical content.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: hQ and hθ are dischargeable from hmax at n ≥ 4 by existing layer results, and a hypothesis-minimal corollary would state the record's claim exactly. O2: `even_odd_orth` is unlisted in the row and duplicates a step of `L219_op`. O3: the row does not note O1.
