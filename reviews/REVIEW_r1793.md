# Review r1793: identity (86), the finite-angle inequality and the classification (I121)

Brief: [BRIEF_I121_86.md](BRIEF_I121_86.md). Log: [agent_logs/r1793-86.log](../agent_logs/r1793-86.log). Worked cold from the definitions and the quoted text, by hand. The only computation was compiling [MixingGapVariance.lean](../lean/HamiltonsCubic/Results/MixingGapVariance.lean) and printing its axioms, which checks a typed claim and cannot be replaced by argument.

| claim | verdict |
|---|---|
| 1, identity (86), the written chain | CONFIRMED, with two unstated uses of givens (step 1 uses A ⊥ B, step 2 uses self-adjointness of 𝒰) |
| 1, Lean `identity_86` | CONFIRMED: statement matches, six hypotheses are consequences of the character decomposition and are jointly satisfiable with 0 < t < 1 |
| 2, finite-angle inequality | CONFIRMED, reading "maximal frame" as the record's max over all frames |
| 3, classification against L214 | CONFIRMED, with ρ > 0 needed for both equivalences |

## Claim 1, link by link

Setting: W = A + B, A = π_D W, B = Σ_U B_U over nontrivial characters, t = ‖A‖, b = ‖B‖.

1. **Step 1.** A/t − tW = (1 − t²)A/t − tB = (b²/t)A − tB, squared norm b⁴ + t²b² = b². ⟨A/t − tW, W⟩ = ⟨A,W⟩/t − t = t − t = 0. Both computations use ⟨A,B⟩ = 0 (orthogonality of the trivial character to the others), which the step leaves unstated, and ‖W‖ = 1. Dividing by b and t uses 0 < t < 1. Correct.
2. **Step 2.** 𝒰W = ½W + ½⟨W,W⟩W − ρ⁻¹Q(W) = 0 uses ‖W‖ = 1, criticality and ρ ≠ 0. **Gap (minor):** passing from 𝒰W = 0 to ⟨C,W⟩ = ⟨𝒰z,W⟩ − η⟨z,W⟩ = ⟨z,𝒰W⟩ = 0 needs 𝒰 self-adjoint, which holds because L_W is self-adjoint (a given of the brief) and W⊗W is. The step does not say so. The span claim: W = A + B and z = (b/t)A − (t/b)B have determinant −(t/b + b/t) = −1/(tb) ≠ 0, so span{W,z} = span{A,B}. Correct.
3. **Step 3.** z ⊥ W kills the W⊗W term. Q(W,z) = (Q(W,A)/t − tQ(W))/b with Q(W,A) = Q(A) + Σ_U Q(A,B_U) and Q(W) = ρW: matches. **Trivial character = diagonal operators**: conjugation by h = diag(ε) multiplies the matrix entry at (e_i∧e_j, e_k∧e_l) by ε_iε_jε_kε_l = χ_{{i,j}△{k,l}}(ε), which is identically 1 exactly when {i,j} = {k,l}. **Q(A,B_U) lies in character U**: h ∈ O(n), so h·Q(A,B_U) = Q(h·A, h·B_U) = χ_U(h)Q(A,B_U) by equivariance. Q(A) is diagonal likewise. The components (z has diagonal part (b/t)A and U-part −(t/b)B_U) give π_D C = (½ − η)(b/t)A + (t/b)A − Q(A)/(ρtb) and π_U C = (t(½+η)/b)B_U − (λ_U B_U + Y_U)/(ρtb). Both match.
4. **Step 4.** ⟨π_D C, A⟩ = 0, multiplied by b/t, gives (½ − η)b² + t² = P(A)/(ρt²), so the coefficient of A is P(A)/(ρt³b) and π_D C = −q_⊥/(ρtb). Σ_U⟨π_U C, B_U⟩ = t(½+η)b − Σ p_Uλ_U/(ρtb) = 0 gives λ̄ = ρt²(η + ½), so t(½+η)/b = λ̄/(ρtb). Both correct. Only the sum over U vanishes, and only the sum is used.
5. **Step 5.** ‖C‖² = ‖π_D C‖² + Σ_U‖π_U C‖² by orthogonality of characters, and ‖Y_U + (λ_U − λ̄)B_U‖² = ‖Y_U‖² + p_U(λ_U − λ̄)² by Y_U ⊥ B_U. Correct.

Characters with B_U = 0 contribute nothing (Y_U = Q(A,0) = 0, p_U = 0), so λ_U may be arbitrary there. Neither maximality of the frame nor global maximality is used. Q maps 𝒲_n × 𝒲_n into 𝒲_n (the reaction term of the Ricci evolution vanishes at Ric = 0), so criticality read as Q(W) = ρW or as π_𝒲Q(W) = ρW is one condition, and the chain holds equally in Sym²(Λ²) where the total symmetry of ⟨Q(X,Y),Z⟩ also holds.

## Claim 1, the Lean file against the statement

- Compiles clean with `lake env lean`, no warnings, no `sorry`. `#print axioms identity_86`: `propext`, `Classical.choice`, `Quot.sound`.
- **Statement match.** `hz` is z = (A/t − tW)/b, `hUz` is 𝒰z with (W⊗W)z = ⟨W,z⟩W, `hη`, `hC` as in the note. The right side is ‖Q(A) − (P(A)/‖A‖²)A‖² + Σ‖Q(A,B_U) − λ_U B_U‖² + Σ p_U(λ_U − λ̄)², with λ̄ = Σp_Vλ_V / Σp_V. Σp_V = b² follows from `hBB`, `hAB`, `hW1`, `htb`, so this is the note's λ̄. `hAn` fixes t = ‖A‖ and `htb` with `hb` gives 0 < t < 1. `hadj` with `hsymm` is total symmetry. `hlam` is Y_U ⊥ B_U.
- **Each hypothesis is a consequence of the decomposition.** `hAB`: trivial ⊥ U. `hBB`: U ⊥ V. `hQB`, `hQQ`: Q(A) is in the trivial character. `hLB`, `hLL`: Q(A,B_U) is in character U (equivariance, equivalently L120). The note proves these in step 3 and the Lean file assumes them, which its docstring discloses. Nothing else the note derives is assumed: C ⊥ A and C ⊥ ΣB_U are proved in `front_end`.
- **Jointly satisfiable, so the theorem is non-vacuous.** E = ℝ³, the totally symmetric trilinear form T(x,x,x) = x₁³ + 3x₁x₂² + 3x₁x₃², s = {2,3}, A = te₁, B₂ = b₂e₂, B₃ = b₃e₃. Then m(e₁,e₁) = e₁, m(e₁,e_k) = e_k, m(e_k,e_k) = e₁, m(e₂,e₃) = 0, so m(W,W) = (1, 2tb₂, 2tb₃), critical with ρ = 1/t exactly when t² = ½, giving 0 < t < 1. `hQB`, `hQQ`, `hLB`, `hLL` hold since m(A,A) ∥ e₁ and m(A,B_k) = tB_k. This T is invariant under the sign flips of x₂ and x₃, so it is a genuine instance of the character setting.
- **Documentation slip.** The module docstring says the character facts "enter as `hA` and `hUV`", which are `variance_core`'s names. In `identity_86` they enter as `hAB`, `hQB`, `hQQ`, `hBB`, `hLB`, `hLL`. Cosmetic only.

## Claim 2

- A sign twist h = diag(ε) conjugates a diagonal operator to itself (entry factor χ_∅ = 1), so h·A = A and h·B_S = χ_S(h)B_S. Correct.
- The record's L214 and INDEX use max_F t_F over all orthonormal frames. With that reading, ‖π_D(g·W')‖² ≤ max_F t_F = ‖A‖² for every W' in the O(n)-orbit, in particular W' = h·W, since π_D(g·X) is the diagonal part of X in the frame g⁻¹F. This is the right consequence. It needs global frame maximality. A frame maximal only locally would give it for g near identity only, and the twists h are not near the identity.
- Expanding F(h) = ‖a + Σχ_S(h)y_S‖² with χ_Sχ_{S'} = χ_{S△S'} (pointwise product of ∏_{i∈S}ε_i) gives c₀ = ‖a‖² + Σ‖y_S‖² from S = S', and c_U = 2⟨a,y_U⟩ + Σ_S⟨y_S, y_{S△U}⟩ over ordered pairs, with y absent read as 0. Distinct subsets give distinct characters, which are orthonormal in L²({±1}ⁿ), so c_U = 𝔼[Fχ_U] and, for U ≠ ∅, |c_U| = |𝔼[(F − ‖A‖²)χ_U]| ≤ 𝔼[‖A‖² − F] = ‖A‖² − c₀. Correct.

## Claim 3

- From step 4 with T = t², b² = 1 − T: P(A) = ρT[(½ − η)(1 − T) + T]. For ρ > 0 and T < 1, η ≥ 0 ⟺ P(A) ≤ ½ρT(1 + T), which is L214's P(D) ≤ ½θt(1+t) with the record's t = ‖D‖² = T and θ = ρ. The cap gives η = ½ − ρ⁻¹⟨z,L_Wz⟩ ≥ 0 since z ⊥ W is a unit vector, again using ρ > 0. Correct.
- P(A)/t³ < ρ ⟺ (½ − η)(1 − t²) < t(1 − t) ⟺ (½ − η)(1 + t) < t ⟺ η > (1 − t)/(2(1 + t)). Correct for ρ > 0 and 0 < t < 1.
- The novelty grep of findings/ for q_⊥, Y_U, λ_U returns nothing, as stated.

## Corrections requested

1. Step 1: state that ⟨A,B⟩ = 0 is used.
2. Step 2: state that C ⊥ W uses the self-adjointness of 𝒰, inherited from L_W.
3. Claim 3: state ρ > 0 as the hypothesis for both equivalences (automatic at a maximiser).
4. Lean module docstring: name `hAB` to `hLL` in place of `hA`, `hUV`.
