# Review r1794: identity (86), the finite-angle inequality, the classification (I121)

Brief: [BRIEF_I121_86.md](BRIEF_I121_86.md). Log: agent_logs/r1794-86.log. Footing: analysis only. The one run was `#print axioms identity_86` against the built module (seconds), and no numerical screen was needed.

| claim | verdict |
|---|---|
| 1, identity (86), the written chain | CONFIRMED, with two presentational omissions (below), neither a gap in the mathematics |
| 1, Lean `identity_86` | CONFIRMED: states Claim 1 exactly, the six hypotheses are consequences of the character decomposition, and they are jointly satisfiable with 0<t<1 |
| 2, finite-angle inequality | CONFIRMED |
| 3, classification against L214 | CONFIRMED, with one sharpening: the author's z is L214's test vector, so the equivalence is literal |

## Claim 1, link by link

Notation: W = A + B, A = π_D W, B = Σ_U B_U over nontrivial characters, t = ‖A‖, b = ‖B‖, t² + b² = 1.

1. **Step 1.** A/t − tW = ((1−t²)/t)A − tB = (b²/t)A − tB. Its squared norm is b⁴ + t²b² = b². The pairing with W is ⟨A,W⟩/t − t = t − t = 0. Uses: A ⊥ B (distinct characters), ‖W‖ = 1, and t ≠ 0, b ≠ 0 so that z is defined, which is where 0 < t < 1 enters. Follows.
2. **Step 2.** 𝒰W = ½W + ½⟨W,W⟩W − ρ⁻¹Q(W) = 0 uses ‖W‖ = 1, criticality Q(W) = ρW and ρ ≠ 0. **Omission 1:** the passage from 𝒰W = 0 to ⟨C,W⟩ = 0 needs ⟨𝒰z,W⟩ = ⟨z,𝒰W⟩, i.e. the self-adjointness of 𝒰, which the text leaves unstated. It is a Given (L_W self-adjoint, W⊗W symmetric), so this is an unstated citation rather than a gap. ⟨C,z⟩ = 0 is the definition of η. The span claim holds because the change of basis from (A,B) to (W,z) has determinant −(t/b + b/t) ≠ 0. Follows.
3. **Step 3.** 𝒰z = ½z − ρ⁻¹Q(W,z) since z ⊥ W. Q(W,z) = (Q(W,A)/t − tQ(W))/b = (Q(A) + Σ_U Q(A,B_U))/(tb) − ρtW/b. Then C = (½−η)z − ρ⁻¹Q(W,z), and expanding z and W reproduces both displayed components term by term (the diagonal coefficient (½−η)b/t + t/b, the U coefficient t(½+η)/b). Character facts, attack item 2:
   - The sign element ε acts on the matrix entry X_{ij,kl} by ε_iε_jε_kε_l = χ_{{i,j}Δ{k,l}}(ε). The entry is fixed by every ε iff {i,j} = {k,l}, so the trivial isotypic component is exactly the diagonal operators. Distinct subsets give distinct characters of {±1}ⁿ, so the decomposition is orthogonal.
   - Sign matrices lie in O(n), so equivariance gives h·Q(A,B_U) = Q(hA, hB_U) = χ_U(h)Q(A,B_U). Hence Q(A,B_U) lies in character U, and Q(A) is diagonal.
   - Q preserves 𝒲ₙ, since scal and Ric of Q(R) vanish when Ric(R) = 0 (Hamilton's evolution of Ric and scal is driven by Ric). So all the vectors in the chain lie in 𝒲ₙ, and the projections of 𝒲ₙ agree with those of the ambient operator space.
4. **Step 4.** ⟨π_D C, A⟩ = ⟨C,A⟩ = 0 gives ((½−η)b/t + t/b)t² = P(A)/(ρtb). Multiplying by b/t gives the stated relation, and substituting back gives π_D C = (P(A)A/t² − Q(A))/(ρtb) = −q_⊥/(ρtb). ⟨C,B⟩ = Σ_U⟨π_U C, B_U⟩ (orthogonality of characters) = Σ_U p_U(t(½+η)/b − λ_U/(ρtb)) = 0 gives Σ p_Uλ_U = ρt²(½+η)b², which is λ̄ = ρt²(η+½). Substituting gives π_U C = −(Y_U + (λ_U − λ̄)B_U)/(ρtb). Follows. **Omission 2:** λ_U is undefined when B_U = 0. Such U carry weight p_U = 0 and Y_U = 0, so the sums restrict to U with B_U ≠ 0 at no cost.
5. **Step 5.** C = π_D C + Σ_U π_U C, because every term of C lies in D or in a character carried by B. The characters are mutually orthogonal and Y_U ⊥ B_U, which gives the identity after multiplying by ρ²t²b². Follows.

Hypothesis use: ρ ≠ 0 in the definition of 𝒰 and in steps 2 and 4. 0 < t < 1 for z and the span (t, b ≠ 0). ‖W‖ = 1 in steps 1 and 2. Criticality in step 2 (𝒰W = 0) and step 3 (Q(W) = ρW inside Q(W,z)). The frame is arbitrary and global maximality is used nowhere, so the verdict's scope sentence is accurate.

## Lean, identity_86 against Claim 1

- **Statement match.** LHS ρ²t²b²‖C‖². The first RHS term is ‖Q(A) − (⟨Q(A),A⟩/‖A‖²)A‖² = ‖q_⊥‖², since ‖A‖ = t (hAn). The second term is Σ‖Q(A,B_U) − λ_U B_U‖² = Σ‖Y_U‖², where hlam is exactly Y_U ⊥ B_U. The third is Σ p_U(λ_U − λ̄)², with λ̄ the p-weighted mean. hUz is ½I + ½W⊗W − ρ⁻¹L_W applied to z, and hz, hη and hC are the note's definitions. b is tied to B through htb, hW1 and hAB, and t < 1 follows from b > 0. It matches.
- **Nothing proved by the note is assumed.** C ⊥ A, C ⊥ B and the decomposition are derived in front_end from criticality, the norms and hadj. The two forced scalars are derived in variance_core.
- **The six hypotheses are each a consequence of the decomposition.** hAB, hBB: distinct characters. hQB, hQQ: Q(A) is trivial, while B_U and Q(A,B_U) lie in U ≠ trivial. hLB, hLL: Q(A,B_U) lies in U, and B_V and Q(A,B_V) lie in V ≠ U. With ι the set of characters, U ≠ V means distinct characters. hsymm and hadj are the total symmetry. The module docstring's "Not typed" note still names only variance_core's hA and hUV. This is harmless, but it is stale against identity_86's six.
- **Joint satisfiability with 0 < t < 1.** A witness by hand: E = ℝ², T the symmetric trilinear form with T(e₁,e₁,e₁) = 1, T(e₁,e₂,e₂) = 1 and its permutations, others 0, m(x,y) = T(x,y,·)♯, s a singleton, A = e₁/√2, B = e₂/√2. Then m(W,W) = e₁ + e₂ = √2·W, so ρ = √2 and t = b = 1/√2. m(A,A) ∝ e₁ is orthogonal to B and to m(A,B) ∝ e₂. hBB, hLB and hLL are vacuous on a singleton, and λ = 1/√2. On 𝒲ₙ (n ≥ 4) the hypotheses hold at every unit critical point in every frame, and some frame has 0 < t < 1: for W ≠ 0, the orbit of the diagonal subspace spans the irreducible 𝒲ₙ, which excludes both t ≡ 0 and t ≡ 1. The theorem is not vacuous.
- **Kernel check.** The olean (07:14:40) is newer than the source (07:13:35). `#print axioms identity_86` gives [propext, Classical.choice, Quot.sound]. There is no sorry or native_decide in the file.
- **Scope.** The theorem is abstract over E and m, so the bridge from CurvOp2/𝒲ₙ to the six hypotheses is left untyped. The brief's table states this accurately.

## Claim 2

- A sign twist h fixes A (diagonal means trivial character) and sends B_S to χ_S(h)B_S. For every k ∈ O(n), frame maximality in its global sense, ‖π_D(kW)‖ ≤ ‖π_D W‖ = ‖A‖, applied at k = gh, is the stated inequality, with (gh)·W = g·(h·W). This is correct provided "maximal frame" means a global maximiser of ‖π_D(kW)‖ over O(n), which exists by compactness. A merely local maximiser would not support the finite-angle statement.
- The expansion uses χ_Sχ_{S'} = χ_{SΔS'}, valid because h_i² = 1. Ordered pairs with S = S' give c_0. U ≠ ∅ collects 2⟨a,y_U⟩ (zero if U is not carried) plus Σ_S⟨y_S, y_{SΔU}⟩, with y := 0 off the support, and each unordered pair is counted twice, consistent with the expansion.
- Put G = ‖A‖² − F ≥ 0 on the finite group. Then |Ĝ(U)| = |E[Gχ_U]| ≤ E[G] = Ĝ(∅), i.e. |c_U| ≤ ‖A‖² − c_0. It is exact and elementary. CONFIRMED. The historical remark about prior attempts on (b) was not checked.

## Claim 3

- **Dictionary.** L214 has T = ‖D‖² = t² and a = ⟨L_D N,N⟩ = Σ_U p_Uλ_U = b²λ̄ = ρT(1−T)(η+½) by step 4's companion. Substituting this a into L214's θT = P(D) + a gives exactly P(A) = ρT((½−η)(1−T) + T), step 4's first relation. So the two agree, **through the companion**, which the classification should cite as part of the translation.
- **η ≥ 0 is L214's inequality, literally.** z ∝ (1−T)A − TB = −X, with X = tN − (1−t)D L214's own test vector in L214's t. So η = ½ − ρ⁻¹⟨L_W z,z⟩ ≥ 0 is ⟨L_W X,X⟩ ≤ (ρ/2)‖X‖², which is L214's step 4. With ρ > 0 (the cap's scope) this is equivalent to a ≥ (ρ/2)T(1−T) and to P(A) ≤ (ρ/2)T(1+T). Equivalence holds, beyond implication.
- **Threshold.** P(A)/t³ < ρ ⟺ (½−η)b² + t² < t ⟺ ½ − η < t(1−t)/((1−t)(1+t)) = t/(1+t) ⟺ η > (1−t)/(2(1+t)). This uses ρ > 0, t > 0 and b² = (1−t)(1+t). Follows.
- The novelty grep and the F67 remark are record-keeping claims, and were not re-run here.
