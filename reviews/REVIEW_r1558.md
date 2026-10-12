# Review r1558: batch 39, statement H from stable idempotents (U_s) and the stability exchange on two-component families

Log: agent_logs/r1558.log

Overall: CONFIRMED WITH SCOPE CORRECTIONS. Every computation holds. The reduction H ⇐ U_s is sound. Two sentences read wider than what they establish (B4, B8).

| claim | verdict | reason in one line |
|---|---|---|
| B1 the reduction to U_s | CONFIRMED | Lagrange gives C#C=C, the second variation of F/norm^3 at C along H ⊥ C is 3(⟨L_C H,H⟩ − ‖H‖²/2)/‖C‖³, Sym² h is #-closed, and L256 with M(h)=2F(Π,Π,Π)=2c_h d gives d_i/c_i² ≥ N/(n−2)² for each ideal |
| B2 several ideals fail the bound | CONFIRMED | Π_i#Π_j=0 for i≠j, so L_C=1 on span(Π_i), which meets C^⊥ in dimension k−1 ≥ 1. Simplicity follows from U_s as stated. Block diagonality is needed only to PROVE U_s |
| B3 the plane eigenvalues and the exchange at y = 2x | CONFIRMED | the plane is L_C-invariant, the matrix is right, the second eigenvalue is trace − 1 with eigenvector ⊥ C by self-adjointness, (c1−α)/c at I/c, and at y=2x D=4x(c1x+α²)=xc², so a'=b'=1/c |
| B4 U_s on two-component families, and so(n) | CONFIRMED (scope corrected) | established: among idempotents aP_k+bP_p only I/c can be PD and satisfy the bound when y ≤ 2x. The so(n) remark covers families with g=so(n) only. H needs U_s on every compact simple h ⊂ so(n), and there y ≤ 2x is open |
| B5 y <= 2x as a ratio bound | CONFIRMED | y ≤ 2x ⟺ c1 ≤ α(2+d_p/d_k), using c=c1+x and x=αd_p/d_k |
| B6 the SU(3) in G2 values | CONFIRMED | D=112/9, c(2x−y)(y−x)=8/9, giving 1/2+1/28=15/28, and (3−4/3)/4=5/12 |
| B7 Lean statements | CONFIRMED | sharp_lin, twocomp_second_root_peirce and g2_su3_peirce each state exactly the prose claim (43/28 − 1 = 15/28) |
| B8 anything else | two scope notes, one wording slip | (i) "U_s holds on every two-component family" means on the ansatz only, (ii) the so(n) sentence does not reach subalgebras, (iii) at y=2x the second root IS I/c, so "fails whenever I/c satisfies it" should read "for x<y<2x" |

## Method

- Read the batch 39 chain link by link against the givens (L256, L259, L260, L263, Tkachev's Theorem A) and the Lean file [I117LemmaF.lean](../lean/HamiltonsCubic/Results/I117LemmaF.lean).
- Derived every step by hand. The only file lookup was L256's bracket mass M in findings/second-order.md (line 485: F(Π,Π,Π) = M(V)/2).
- No computation was run. The rational checks in B6 are arithmetic done by hand.

## B1: the reduction

- **The idempotent.** A maximiser X of F on the unit sphere is a critical point, so 3X#X = μX, and pairing with X gives μ = 3F(X). F(X) = κ_n > 0 because I gives a positive value. So C = X/F(X) satisfies C#C = C and ‖C‖ = 1/F(X). L260 (1) supplies a PSD maximiser, and H is a statement about κ_n alone, so one maximiser is enough.
- **Tkachev's setting.** (Sym² so(n), #, trace pairing) is commutative (# is symmetric), and ⟨A#B,C⟩ is fully symmetric. That makes it a Euclidean metrized algebra, and C is minimal in his sense (a global maximum of u). The normalisation matches: x² there is x#x here, and an idempotent is C#C = C.
- **Direct check of the Hessian step.** It is independent of the slide's formula. Take H ⊥ C, and use F(C,C,H) = ⟨C,H⟩ = 0 and F(C,C,C) = ‖C‖². Then f(C+tH) = (‖C‖² + 3t²⟨L_C H,H⟩ + O(t³)) / (‖C‖³(1 + t²‖H‖²/‖C‖²)^{3/2}), whose t² coefficient is 3(⟨L_C H,H⟩ − ‖H‖²/2)/‖C‖³. A local maximum therefore forces ⟨L_C H,H⟩ ≤ ½‖H‖² for every H ⊥ C in Sym² so(n). Only local maximality is used.
- **Restriction to Sym² h.** C is PSD with range h, so C = P_h C P_h ∈ Sym² h. The generators satisfy (vvᵀ)#(wwᵀ) = ½[v,w][v,w]ᵀ with [v,w] ∈ h, so Sym² h is #-closed and carries h's own # for the restricted ad-invariant form. The bound restricts to C^⊥ ∩ Sym² h.
- **L256.** Line 485 of the record gives M(h) = 2F(Π,Π,Π) = 2c_h d for a subalgebra with Π#Π = c_hΠ. L256 (n ≥ 9) then reads c_h/√d ≤ (n−2)/√N, that is d/c_h² ≥ N/(n−2)². Each ideal h_i is itself a subalgebra of so(n), so ‖⊕Π_i/c_i‖² = Σ d_i/c_i² is at least N/(n−2)² (one term already reaches it). Then κ_n = 1/‖C‖ ≤ (n−2)/√N, and I attains it (L259 (2)). The chain holds as written, with n ≥ 9 entering only through L256.
- **Remark (strength of the hypothesis).** The maximiser satisfies L_C ≤ ½ on all of C^⊥ ⊂ Sym² so(n), including the directions leaving Sym² h. U_s as stated uses only the intrinsic part. That is sufficient for the reduction, but it makes U_s a stronger statement than H needs. If the intrinsic U_s fails somewhere, the ambient directions are unused leverage.

## B2: several ideals

- For v ∈ h_i and w ∈ h_j with i ≠ j, [v,w] = 0, so Π_i#Π_j = 0. Hence L_C Π_j = Π_j#Π_j/c_j = Π_j.
- The eigenspace for eigenvalue 1 contains span(Π_1,…,Π_k), of dimension k ≥ 2. It meets C^⊥ in dimension k−1 ≥ 1, where L_C = 1 > ½. The bound fails, as claimed.
- **Does simplicity follow?** Yes, given U_s as stated. U_s already asserts that a stable PD idempotent on semisimple h has the form ⊕Π_i/c_i, and this computation rules out k ≥ 2. No block-diagonality assumption is used.
- **Where block diagonality would enter.** A proof of U_s that reduces to simple ideals would need it, because Sym² h contains the cross blocks Hom(h_i,h_j). For h = h_1 ⊕ h_2 with h_1 ≅ h_2, the idempotents aP_Δ + bP_Δ' (diagonal and antidiagonal) are not block diagonal across the ideals. There I#I = cI still holds and the pair is symmetric (y = 0), so L263's algebra leaves only I/c as positive definite on that family. This is a note for whoever proves U_s, and not a defect in batch 39.

## B3: the plane

- **Invariance and formula.** C#P_k = ac1 P_k + bα P_p and C#P_p = aα P_p + b(xP_k + yP_p). This reproduces the stated matrix, so the plane is invariant.
- **Eigenvalue 1.** Applying L_C to (a,b) gives (a²c1 + b²x, 2abα + b²y), which is C#C = C. The other eigenvalue is therefore the trace minus 1, namely ac1 + aα + by − 1.
- **Orthogonality.** L_C is self-adjoint and the plane is invariant, so eigenvectors for distinct eigenvalues are orthogonal. When the second eigenvalue is also 1, an orthogonal choice exists in the 2-dimensional eigenspace.
- **At I/c.** The eigenvalue is (c1 + α + y − c)/c = (c1 − α)/c, using c = 2α + y. It is at most ½ exactly when c1 − 2α ≤ x. With c1 = c − x and 2α = c − y this is y ≤ 2x. The eigenvector is d_p P_k − d_k P_p (⊥ I).
- **At the second root.** The value ½ + c(2x−y)(y−x)/(2D) is the kernel-checked identity. With c, D > 0 it exceeds ½ exactly when x < y < 2x.
- **At y = 2x.** D = 4c1x² + 4α²x = 4x(c1x + α²). Substituting c1 = c − x and 2α = c − 2x gives 4(c1x + α²) = 4cx − 4x² + (c − 2x)² = c², so D = xc² and a' = b' = cx/D = 1/c. The two roots coincide, and the eigenvalue there is exactly ½ from both formulas.

## B4: what is established, and the so(n) sentence

- **Established.** Take the family aP_k + bP_p inside a compact simple g satisfying L263's hypotheses, with y ≤ 2x. The PD idempotents are I/c and, when y > x, the second root. For x < y < 2x the second root has a plane direction ⊥ C with eigenvalue above ½. So the only PD idempotent on the ansatz that can satisfy the bound is I/c. This is U_s restricted to the two-parameter ansatz, and the bold sentence should say so.
- **What it leaves open.** It says nothing about PD idempotents on g off the ansatz. It also does not show that I/c satisfies the bound on all of C^⊥ ∩ Sym² g, though U_s does not need that.
- **The so(n) consequence.** L259 (2) makes I a local maximum of F/‖·‖³ on Sym² so(n) for n ≥ 7. By the B1 computation, L_{I/c} ≤ ½ on I^⊥. Evaluated on d_p P_k − d_k P_p this is (c1 − α)/c ≤ ½, that is y ≤ 2x, for every two-component family with g = so(n). The sentence is correct as literally written.
- **Scope correction.** H via U_s needs U_s on every compact semisimple h ⊂ so(n), and hence on two-component families inside every compact simple h, since each such h embeds in so(n) for large n. L259 (2) concerns I of so(n), not I_h of Sym² h, so it gives nothing there. On a family inside h with y > 2x (if one exists), I_h/c_h fails the bound and the second root passes it on the plane, so U_s would have to be decided by the directions off the plane. "No classification needed" holds only for g = so(n).
- **Sample pairs (hand, within the givens).** All satisfy y ≤ 2x:
  - SU(3) ⊂ G2: y/x = 4/3.
  - G2 ⊂ so(7): x = y = 1/10 in units c = 1/2 (x·14 = α·7 checks).
  - principal SO(3) ⊂ G2: y = 26/112 < x = 55/112.
  - Spin(9) ⊂ so(16): x = 21/2, y = 5 (x·36 = α·84 = 378 checks).
  - For p = Cⁿ under su(n) and C^{2n} under sp(n), the ratio stays above 1/(2 + d_p/d_k).
  - This is evidence, not a proof that y ≤ 2x holds on all isotropy-irreducible pairs.

## B5: ratio form

- Substitute c = c1 + x into y = c − 2α ≤ 2x and use x = αd_p/d_k: c1 + αd_p/d_k ≤ 2α + 2αd_p/d_k.
- This is c1 ≤ α(2 + d_p/d_k), that is Cas_k(p)/Cas_k(k) = α/c1 ≥ 1/(2 + d_p/d_k). Correct.

## B6: SU(3) ⊂ G2

- Check L263's identity: x·d_k = 8 and α·d_p = (4/3)·6 = 8.
- D = 3·16/9 + 4·(16/9)·1 = 112/9, and c(2x−y)(y−x) = 4·(2/3)(1/3) = 8/9. This gives ½ + (8/9)/(224/9) = ½ + 1/28 = 15/28. Directly: (9/28)·3 + (9/28)(4/3) + (3/28)(4/3) − 1 = 43/28 − 1 = 15/28.
- At I/4: (3 − 4/3)/4 = 5/12. Both are correct.

## B7: Lean fidelity

- **sharp_lin** (IsotropyPair namespace) states C#(uP_k + vP_p) = (a c_k u + b x v)P_k + (b α u + (a α + b y) v)P_p. That is the prose formula exactly.
- **twocomp_second_root_peirce** states a'c_k + a'α + b'y − 1 − ½ = c(2x − y)(y − x)/(2D), under c_k + x = c, 2α + y = c and D ≠ 0. That is the prose identity with the same hypotheses L263 supplies.
- **g2_su3_peirce** states (9/28)·3 + (9/28)(4/3) + (3/28)(4/3) − 1 = 15/28. It matches.
- The untyped rows (the Hessian step, the orthogonality, (c1 − α)/c) are verified by hand in B1 and B3.

## B8: other findings

1. **Wording slip at the boundary.** "The positive-definite second root fails the bound whenever I/c satisfies it" is false at y = 2x, where the second root is I/c and satisfies the bound with eigenvalue exactly ½. It should read "for x < y < 2x". The next sentence ("meet and exchange stability") already describes the boundary correctly.
2. **Scope of the bold claim.** "U_s holds on every two-component family with y ≤ 2x" should read "on the ansatz aP_k + bP_p of every two-component family with y ≤ 2x" (B4).
3. **Scope of the so(n) sentence.** It gives y ≤ 2x for families in so(n) itself, not for families inside the subalgebras h on which U_s must hold (B4).
4. **Status.** The batch reduces H (n ≥ 9) to U_s. U_s remains an open statement, verified only on the ansatz. Nothing within the givens refutes U_s: SU(3) ⊂ G2, the only known PD idempotent other than I/c, fails the bound as U_s requires.
