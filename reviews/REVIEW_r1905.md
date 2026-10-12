# REVIEW r1905: I123, the Ricci-free extension (second attempt)

Log: [agent_logs/r1905-i123-ricci-free.log](../agent_logs/r1905-i123-ricci-free.log). Section under review: "Second attempt: the Ricci-free extension is false" and "Where the coupling stands" in [2026-09-28o-I123-coupling.md](2026-09-28o-I123-coupling.md). Analysis-only footing: every numerical line below is a screen of seconds on objects built for this review (my own halved # via L265, in the scratchpad), and no positive claim rests on it alone.

**Verdict: the counterexample is CONFIRMED in every link, by hand and by an independent screen. Two scope corrections: the heading's "survives at the balanced product" holds at n = 12 and fails at n = 8, and the closing "no lift that relaxes either can carry it" is proved for invariant enlargements with the same bound, a narrower class than the sentence names.**

| # | claim | verdict |
|---|---|---|
| 1 | the space and the L181 reading | CONFIRMED (the L181 reading PLAUSIBLE, as an analogy) |
| 2 | the Hessian split | CONFIRMED |
| 3 | the screen values | CONFIRMED (screen), with a scope correction at n = 8 |
| 4 | the P± products, the cubic and the norm | CONFIRMED |
| 5 | the plane, the value, θ0(12) | CONFIRMED |
| 6 | the conclusion | PLAUSIBLE, with corrections |
| 7 | the Lean | CONFIRMED (axioms below) |

## 1. The space

- The Ricci contraction is O(n)-equivariant from Sym²Λ² to Sym²ℝⁿ. On Λ⁴ (the operator R_(ij),(kl) = ω_ijkl) it gives Σ_k ω_ikjk = 0 by antisymmetry in the 2nd and 4th slots. On Weyl it vanishes by definition. On the Kulkarni–Nomizu image h ∧ g it returns (n−2)h + (tr h)g, invertible for n ≥ 3.
- So for x = w + r with w ∈ Weyl ⊕ Λ⁴ and r in the Ricci and scalar parts, Ric(x) = Ric(r) = 0 forces r = 0. The kernel is exactly Weyl ⊕ Λ⁴. CONFIRMED.
- L181 reading: L181 lives on the block-diagonal family W = Σ N_ab ε_a ε_bᵀ with N = MᵀΛM. There Ric(ε_a ε_bᵀ) = 0 for a ≠ b (disjoint planes) and the Λ⁴ part of ε_a ⊙ ε_b is ε_a ∧ ε_b, zero exactly when a = b. So inside that family the diagonal is Ricci and the off-diagonal is the Λ⁴ (Bianchi) component, and the sentence is literally true there. Outside the family Ricci has n(n+1)/2 conditions and Bianchi binom(n,4), with no single matrix. Fair as an analogy, and it should be marked as one.

## 2. The Hessian split

- The gradient of G at W0 is 3Q(W0) = 3θ0W0, so W0 is critical for G/‖·‖³ on all of Sym²Λ², hence on the Ricci-free space.
- Along X(s) = W0 cos s + V sin s with unit V ⊥ W0: G = cos³s θ0 + 3cos²s sin s T(W0,W0,V) + 3cos s sin²s T(W0,V,V) + sin³s G(V). T(W0,W0,V) = θ0⟨W0,V⟩ = 0, and the second derivative at 0 is −3θ0 + 6T(W0,V,V). CONFIRMED.
- Cross term: B(x,y) = ½(Q(x+y) − Q(x) − Q(y)) lies in Weyl whenever x, y do, and Λ⁴ ⊥ Weyl, so T(W0,V_W,Y) = ⟨B(W0,V_W),Y⟩ = 0. The −3θ0‖V‖² term splits too. CONFIRMED.

## 3. The screen values

Own construction at n = 12: unit basis e_i ∧ e_j of so(12), ad matrices from explicit brackets, W#Y = ½Σλ_k ad_{v_k} Y ad_{v_k}ᵀ over W's eigenvectors, I#I = 10I checked, 495 unit Λ⁴ basis operators, and M_ij = ⟨B(W,Y_i),Y_j⟩ (exactly symmetric).

| point | θ (G(W), with Q(W) = θW checked) | top of T(W,Y,Y) on Λ⁴ | θ/2 |
|---|---|---|---|
| S⁶ × S⁶ | 1.236033 | 0.404520 | 0.618017 |
| S⁴ × S⁸ | 1.201561 | 0.873863 | 0.600781 |

Both match the note. S⁵ × S⁷ and padded W_CP² were not re-run.

**Scope correction (screen, n = 8).** The same construction on Λ⁴(ℝ⁸) at the balanced product S⁴ × S⁴ gives a top of 0.654654 against θ0(8)/2 = 0.572822. At n = 8 the balanced product itself has a Λ⁴ ascent direction. That is the chirality tilt of one ℝ⁴ factor, and the tilted maximum 1.171080 exceeds θ0(8) = 1.145644. The heading "although it survives at the balanced product" is therefore an n = 12 statement and should say so.

## 4. The products, the cubic and the norm

- P±#P∓ = 0 because [Λ²₊, Λ²₋] = 0. From P₊#P₊ + P₋#P₋ + 2P₊#P₋ = I₄#I₄ = 2(P₊ + P₋), each P±#P± = κ²P± with κ² = 2, since so(3) with unit basis has P#P = κ²P and the two halves are isometric.
- **P±#P_mix, derived.** For f ∈ so(4), [f, e_i ∧ e_a] = (f e_i) ∧ e_a, so ad_f acts on mix = ℝ⁴ ⊗ ℝ⁸ as f ⊗ 1. The unit (anti-)self-dual forms are J_k/√2 with J_k² = −1, so ad_f ad_fᵀ = ½·1 on mix. Summing over three k and halving gives ¾P_mix. CONFIRMED without the orientation argument.
- P±#P₈ = 0, since the two blocks commute.
- Term by term, with ranks 3, 3, 28, 32:
  - α³: 3 (trace) + 2·3 (#) = 9.
  - b³: 28 + 6·28 = 196.
  - c³: 32.
  - αc²: 8·3 (from P_mix#P_mix = 8P_so(4) + 4P_so(8)) + 2·¾·32 = 72.
  - bc²: 4·28 + 2·(7/2)·32 = 336.
- The norm is 3α² + 3β² + 28b² + 32c².
- Screen: every product in the table holds exactly with the explicit #, and G and N agree with the formula at three random points to machine precision. CONFIRMED.

## 5. The plane and the value

- ⋆ = P₊ − P₋ equals the operator of e₀₁₂₃ (R(e₀₁) = e₂₃ and so on), so it is a Λ⁴ element with ‖⋆‖² = 6. Checked exactly.
- Ricci diagonal: 3(α+β)/2 + 8c on ℝ⁴ and 7b + 4c on ℝ⁸. The off-diagonal vanishes by invariance. The Ricci-free plane is α + β = −16c/3 and b = −4c/7: two conditions on four parameters, a plane equal to the S⁴ × S⁸ Weyl line plus t⋆. Screen: the witness's Ricci is below 2e−15.
- G on the plane, with u = −8c/3: 9(2u³ + 6ut²) − (256/7)c³ − 384c³ − 192c³ + 32c³ = −(19360/21)c³ − 144ct². The norm is (1760/21)c² + 6t². CONFIRMED.
- At c = −1 and s = t², the condition d log f/ds = 0 reads 144N = 9G, so G = 16N, giving 48s = 8800/21 and s = 3850/441. Then N = 2860/21 and f = 16/√N, with f² = 5376/2860 = (8√15015/715)², so f = 1.371029. f → 0 as s → ∞, so this single critical point is the maximum.
- At t = 0 the value is 11√(21/1760) = √2310/40 = 1.201561. θ0(12)² = 55/36, so θ0(12) = 1.236033. The explicit-# ratio at the witness is 1.3710289. CONFIRMED.

## 6. The conclusion

- **What is established.** The O(n)-invariant subspaces strictly containing Weyl are Weyl ⊕ S for S a nonempty sum of ℝI, Sym²₀ and Λ⁴ (all irreducible and distinct under O(n)). Each contains one of the three tested minimal ones. So "the same inequality G ≤ θ0‖X‖³ on an invariant enlargement" is false at n = 12 for every such enlargement. A proof of P at n = 12 must use Bianchi, and at every even n must use the trace-free Ricci condition. That part is sound.
- **Correction 1, wider than tested.** "No lift that relaxes either can carry it" covers hard-constraint lifts with the same functional and the same constant. It leaves open lifts that relax a condition through a penalty, such as G(X) ≤ θ0‖X‖³ + κ‖X_Λ⁴‖·‖X‖² or a Ricci-weighted term in the Böhm–Wilking cone form the note itself cites. It also leaves open lifts to non-invariant subspaces and lifts with a different constant. "Closes the lifting approach" should be restricted to invariant hard-constraint lifts of the same bound.
- **Correction 2, the n-range is understated.** The note has the Λ⁴ failure "at n = 12" only. Screen on the general-q cubic from the same table (S⁴ × S^q tilted, rational in q, reproducing 1.371029 at q = 8):

| n | θ0(n) | tilted S⁴ × S^(n−4) maximum |
|---|---|---|
| 8 | 1.145644 | 1.171080 |
| 10 | 1.200000 | 1.290994 |
| 12 | 1.236033 | 1.371029 |
| 14 | 1.261680 | 1.426954 |
| 16 | 1.280869 | 1.468027 |

So P⁺ fails at every even n from 8 to 16, and it plausibly fails at every even n ≥ 8. A symbolic version of Section 5 in q would make this a statement. As written, the Bianchi half of "must use both conditions" is shown at n = 12, while the Ricci half is shown at every even n.

## 7. The Lean

- G_plane and N_plane are `unfold; ring` identities on the displayed cubic, with the substitution α = −8c/3 + t, β = −8c/3 − t, b = −4c/7. They match the note.
- ricci_free_beats states G > 0 and (55/36)N³ < G² at c = −1 under t² = 3850/441, which is f > √55/6. That is what the table says.
- scalar_flat_beats is the bare rational 55/36 < 120/77. It belongs to the scalar-flat extension (section 3 of the note), and the Ricci-free section lists it among its own declarations, which should be separated.
- The docstring's "Not typed: the cubic itself from the # table, and the maximisations" is accurate. The # table is where the content lives, and Section 4 above checks it.
- `#print axioms`: all four depend only on [propext, Classical.choice, Quot.sound], with no sorryAx. The file compiles.
