# Review r1572: batch 45, the torus-invariant idempotent system of so(2m)

Log: agent_logs/r1572.log

**Overall: CONFIRMED with two corrections.** The family, the three constants and the reduced system are right. The F36 sentence misattributes a closure, and the Lean declaration types one direction of a biconditional.

| claim | verdict | reason in one line |
|---|---|---|
| G1 the torus-invariant family | CONFIRMED | t and the root planes are pairwise non-isomorphic real T-modules, so Schur gives no mixing, and the commutant of a plane rotation meets the symmetric operators in the scalars |
| G2 the three constants | CONFIRMED | [h_k,p]=alpha_k q and [p,q]=sqrt2 u_alpha from invariance at the norm -(1/2)tr, the root-pair coefficient 1 via the stabiliser of alpha in W(D_m) and I#I; screened from the bracket |
| G3 the reduced system | CONFIRMED | (u.u)^2 in {1,1/4,0}, 4(m-2) neighbours, 2(m-2) pairs, A eliminated and positive definite; formula screened at m=3,4 with random A and mu, residual below 1e-14 |
| G4 scope and counterexamples | PLAUSIBLE (with corrections) | the three counterexamples are T-invariant, but the D_m system covers only L267 at even n, and F36 closes diagonalisability of a Weyl-tensor maximiser, a condition incomparable with T-invariance; "averaging over a torus" preserves neither idempotence nor maximality |
| G5 Lean | CONFIRMED (with correction) | torus_uniform matches the uniform system and the Cartan block, but proves only c=2(m-1) implies a solution, while the prose says "requires" and the brief says "exactly when" |

## Method

- Read the batch chain link by link against the definitions, then derived each step by hand from the bracket of so(2m).
- Read F36 in [fence-posts.md](../findings/fence-posts.md) (post F36, lines 294 onward), the statement and proof of L267 in [second-order.md](../findings/second-order.md), and `torus_uniform` in [I117LemmaF.lean](../lean/HamiltonsCubic/Results/I117LemmaF.lean).
- One screen, seconds of compute (`sage -python`, script at the scratchpad path r1572_screen.py): build so(6) and so(8) with basis e_ij of norm 1 under -(1/2)tr, implement # from the definition, check I#I=(n-2)I, extract root planes as eigenspaces of -ad_h^2 at a generic h, compare C#C with the stated formula for random symmetric A and random mu on the whole N x N matrix, and plug L267's idempotent at n=8 into the family. Reported as a screen only.

## G1, the family

- Under Ad(T), so(2m) = t ⊕ ⊕_{alpha>0} R_alpha, with t the zero weight space (the Cartan is its own centraliser) and R_alpha carrying the character e^{±i alpha}. Distinct positive roots give non-isomorphic real irreducible T-modules (R_alpha ≅ R_beta iff alpha = ±beta), so a T-equivariant symmetric map preserves each summand and is arbitrary symmetric on t.
- On R_alpha every h acts by alpha(h)J with one fixed skew J (the plane is a single root space), so the commutant is a + bJ and symmetry forces b = 0. The family is correct.
- Counterexamples: L267's C = a_+P_+ + a_-P_- + a_sP_s + bP_V is invariant under SO(4) x SO(n-4), of rank 2 + floor((n-4)/2) = floor(n/2), so it contains a maximal torus of SO(n). SU(3) and SO(4) in G2 have rank 2 = rank G2, and aP_k + bP_p is invariant under them. So all three are T-invariant for some maximal T of the ambient group. **Scope caveat under G4.**

## G2, the constants

- Normalisation: e_{2k-1,2k} has norm 1 under -(1/2)tr, and this form gives Cas_g(g) = 2(n-2), c = n-2, matching the givens. The eigenvalues of h_k on C^{2m} are ±i on the k-th plane, so ad h_k acts on R_alpha with eigenvalues ±i alpha_k, which is alpha_k J in an oriented orthonormal basis p, q.
- A#P_alpha: with A = Σ λ_i v_i v_i^T and L265's formula, A#P_alpha = (1/2)Σ λ_i ad_{v_i} P_alpha ad_{v_i}^T = (1/2)(alpha^T A alpha) P_alpha = (u^T A u) P_alpha, and the cross term 2μ A#P_alpha gives the coefficient 2. It lands only on R_alpha.
- [p,q]: [R_alpha,R_alpha] lies in g_0 + g_{2alpha} and 2alpha is not a root, so [p,q] ∈ t, and <[p,q],h_k> = <p,[q,h_k]> = alpha_k. So [p,q] = alpha = sqrt2 u_alpha, and P_alpha#P_alpha = (1/2)·2·[p,q][p,q]^T = 2u u^T. Screen: [p,q] has components (-1, 1, 0, ...) for alpha = ε1-ε2 (orientation sign) and norm sqrt2.
- Landing of cross terms: [R_beta,R_gamma] ⊂ R_{beta+gamma} ⊕ R_{beta-gamma} for beta ≠ ±gamma. In simply laced D_m, beta+gamma is a root iff <beta,gamma> = -1 and beta-gamma iff <beta,gamma> = 1, so at most one of them is, never t, and orthogonal roots bracket to zero. P_beta#P_gamma is T-invariant and supported on Sym^2 R_alpha, so it is scalar there. **No cross term reaches t or a second plane.** A#A = 0 because t is abelian.
- Pairs: for alpha = ε1-ε2 they are (ε1-εj)+(εj-ε2) and (ε1+εj)-(ε2+εj), j = 3..m, and for ε1+ε2 the two mixed types, 2(m-2) each. Transitivity: W(D_m) is transitive on roots, and the stabiliser of alpha = ε1-ε2 contains the permutations of {3..m} and the element ε1 -> -ε2, ε2 -> -ε1 (two sign changes, so in W(D_m)), which sends {ε1-εj, εj-ε2} to {-ε2-εj, ε1+εj}, the other type. So it is transitive for every m ≥ 3, including m = 3. Weyl elements are realised by Ad(n), n in N(T), orthogonal automorphisms carrying P_beta to P_{w beta}, so the scalar is one number. I#I = (n-2)I read on R_alpha gives 2 + k·2(m-2) = 2(m-1), so k = 1.
- Screen: pair count 2 (m=3) and 4 (m=4), matching 2(m-2).

## G3, the reduced system

- (C#C)_t = 2Σ μ_alpha^2 u u^T is the only contribution to t, so at an idempotent A equals it. (u_alpha.u_beta)^2 = <alpha,beta>^2/4 ∈ {1, 1/4, 0}.
- u_alpha^T A u_alpha = 2μ_alpha^2 + (1/2)Σ_{beta~alpha} μ_beta^2, the neighbours being ε1±εj, ε2±εj (j ≥ 3), 4(m-2) of them. Multiplying by 2μ_alpha gives 4μ^3 + μΣμ_beta^2, as stated.
- The coroots span t, so A is positive definite once every μ > 0. Conversely a positive solution with A so defined gives C#C = C (C#C is T-invariant, hence in the family, and matches on every block). "Exactly the positive solutions" holds.
- Uniform point: Σ_{alpha>0} alpha alpha^T = 2(m-1)I in D_m (the off-diagonal ± contributions cancel), so the Cartan block reads 2(m-1)μ^2 = μ, and the root equation divided by μ reads 1 = 4(m-1)μ^2 + 2(m-2)μ, which μ = 1/(2(m-1)) satisfies.
- L267 at even n: with μ_{ε1±ε2} = a_±, μ = a_s on the so(n-4) roots and b on the mixed roots, the system reads a = 4a^3 + 4(m-2)ab^2 + 2(m-2)b^2. Using L267's 2a^2 + (n-4)b^2 = a this equals 2a^2 + 2(m-2)b^2, which is L267's equation again, so consistent. Screen at n = 8: |C#C - C| = 1e-16 for both assignments of a_± to ε1±ε2, least eigenvalue 1/12.
- Screen of the whole formula, random symmetric A (non-idempotent) and random μ: residual 4.4e-16 at m=3, 8.7e-15 at m=4, over the whole matrix, so leakage is covered.

## G4, scope and F36

- **Correction 1, the stated system covers less than "every counterexample to U found".** The T-invariant family exists on any compact g, but the system written is for D_m. L263's two idempotents on g2 and L267 at odd n (B_m, short roots ε_i, (u.u)^2 values and pair structure differ) are T-invariant but lie outside this system. Suggested wording: "the T-invariant family contains every counterexample found, and on so(2m) it is this system, which contains L267 at even n."
- **Correction 2, the F36 clause.** F36's last paragraph closes "proving the Weyl-tensor maximiser diagonalisable" (the lifting lemma renamed). T-invariance is a different condition from diagonality in an e_i∧e_j frame, and the two are incomparable: a T-invariant C with μ_{ε1-ε2} ≠ μ_{ε1+ε2} is non-diagonal in the frame e_ij (the planes R_{ε1±ε2} are spanned by the combinations e13±e24, e14∓e23 in some sign convention, never by coordinate vectors), and a diagonal C with unequal entries on e13, e24 is not T-invariant. Further, "averaging over a torus" is no valid step at all: the average of an idempotent over T is T-invariant but in general neither idempotent nor a maximiser, since F is cubic. So F36 is no reason the reduction stops. The preceding sentence, "the maximiser need not be T-invariant for any T", is accurate and suffices on its own. Suggested fix: drop the F36 clause, or state that showing the maximiser T-invariant is an open symmetry claim which the record has no tool for.
- The batch claims nothing beyond the T-invariant family otherwise. Its "Lemma D shape (L261)" comparison was not checked (L261 not in the brief).

## G5, Lean

- `torus_uniform (m c) (hm : 2 ≤ m) (hc : c = 2(m-1))` proves μ = 1/c satisfies μ = 4μ^3 + μ·4(m-2)μ^2 + 2(m-2)μ^2 and 2(m-1)μ^2 = μ. These are exactly the uniform specialisation of the reduced system and of the Cartan block A = 2Σμ^2 uu^T = 2(m-1)μ^2 I. Faithful.
- **Correction: only the "if" direction is typed.** The prose says the uniform solution "requires" c = 2(m-1), and the brief's row says "exactly when". The converse (the Cartan equation with μ = 1/c ≠ 0 forces c = 2(m-1)) is one line by hand but absent from the declaration. Either add it as an iff or word the row as "at c = 2(m-1)".
- The family, the constants and the system are untyped, as the brief states; they rest on the hand derivation above plus the screen.
