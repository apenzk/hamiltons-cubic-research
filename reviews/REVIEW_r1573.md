# Review r1573: batch 45, the torus-invariant idempotent system of so(2m)

Log: agent_logs/r1573.log

**Overall: CONFIRMED with two corrections to the scope paragraph.** The family, the three constants and the reduced system are right, derived by hand and screened. The paragraph "What it gives and where it stops" overstates what the system contains and misattributes the reason it stops.

| claim | verdict | reason in one line |
|---|---|---|
| G1 the torus-invariant family | CONFIRMED | T acts on t trivially and on each R_alpha by a rotation with character alpha, the real isotypic pieces are pairwise non-isomorphic, and the commutant of a rotation meets Sym in scalars; the named counterexamples are invariant under subgroups of full rank |
| G2 the three constants | CONFIRMED | A#P_alpha = (u^T A u) P_alpha, P_alpha#P_alpha = 2 u u^T and the pair coefficient 1 all rederived; the Weyl step is right for D_m with the stabiliser element swap(12) composed with the sign change on (1,2), needed at m = 3 |
| G3 the reduced system | CONFIRMED | (u_alpha.u_beta)^2 = <alpha,beta>^2/4, 4(m-2) neighbours, 2(m-2) pairs, A eliminated and positive definite; screen at m = 3, 4 agrees to 1e-15 and L267 at n = 8 solves it |
| G4 scope and counterexamples | PLAUSIBLE, corrections | the D_m system does not contain L267 at odd n or L263's two on g2 (different root systems, where the one-coefficient argument fails); the system carries idempotency only, and stability on all of Sym^2 is outside it; F36 closes coordinate-diagonalisability of a Weyl-tensor maximiser, a different statement on a different space |
| G5 Lean | CONFIRMED, one note | torus_uniform is faithful to the uniform point and uses the counts 4(m-2) and 2(m-2); it types sufficiency only, while the prose says "requires" (necessity follows from the Cartan conjunct but is untyped) |

## Method

- Read the batch link by link, then rederived every constant from the definitions in the brief, with <A,B> = -(1/2) tr AB and the orthonormal basis e_ij.
- Read F36 in [fence-posts.md](../findings/fence-posts.md), the head of [diagonality.md](../findings/diagonality.md) for what "diagonalisable" means there, L267's statement in [second-order.md](../findings/second-order.md), and torus_uniform in [I117LemmaF.lean](../lean/HamiltonsCubic/Results/I117LemmaF.lean).
- One screen, seconds long, reported as a screen only: built so(6) and so(8) from the bracket, took a random symmetric A on t (off-diagonal entries included) and random mu_alpha in (0.1, 1), computed the full C#C via C#X = (1/2) sum C_ab ad_a X ad_b^T and compared it with the batch's formulas over the whole of Sym^2. Max deviation 8.9e-16 (m = 3) and 1.3e-15 (m = 4), which also shows no leakage outside the family. I#I = (n-2)I held exactly. L267's idempotent at n = 8, written in the family (mu = 5/12, 1/12 on the two so(4) roots, b on the mixed roots, a_s on so(4)'s complement, A = 2 sum mu^2 u u^T), has |C#C - C| = 1.1e-16 and least eigenvalue 1/12.

## G1, the family

- The complexified weights of T on so(2m) are 0 (multiplicity m) and plus or minus alpha for each positive root, each with multiplicity 1. The real T-isotypic pieces are t and the planes R_alpha, and R_alpha is isomorphic to R_beta only when beta = plus or minus alpha. So an operator commuting with Ad_T preserves t and each R_alpha, and has no block between different pieces.
- On R_alpha, T acts through rotations by alpha(t), so the commutant is a + bJ. Symmetry forces b = 0. On t anything commutes, so A is an arbitrary symmetric matrix. The form is right.
- The family is closed under #, since # is Ad-equivariant. This is what makes "C#C = C" reduce to one equation per block, a step the batch uses silently.
- L267's C is invariant under SU(2)_+ x SU(2)_- x O(n-4), whose rank 2 + floor((n-4)/2) = floor(n/2) is SO(n)'s. L263's C on g2 is a P_k + b P_p with k = su(3) or so(4), each of rank 2 = rank g2, and Ad_T preserves k and p. So every counterexample named is T-invariant for a maximal torus, as claimed. The first sentence of the family paragraph is right. What these operators satisfy is a separate question, answered in G4.

## G2, the constants

- **Brackets.** With h_k = e_{2k-1,2k}, ad_{h_k} acts on R_alpha as alpha_k J for one fixed complex structure J on that plane, so with q = Jp, [h_k,p] = alpha_k q and [h_k,q] = -alpha_k p. Hand check: [e_12, e_13] = -e_23, of norm 1 in this inner product, so alpha_k is in {0, 1, -1}.
- **A#P_alpha.** Write A = sum a_kl h_k h_l^T. Then A#X = (1/2) sum a_kl ad_{h_k} X ad_{h_l}^T, and ad_{h_k} P_alpha ad_{h_l}^T = alpha_k alpha_l P_alpha. So A#P_alpha = (1/2)(alpha^T A alpha) P_alpha = (u^T A u) P_alpha with u = alpha/sqrt2. The cross term in C#C doubles this, giving 2 mu_alpha u^T A u. A#A = 0 because t is abelian. Correct.
- **P_alpha#P_alpha.** Here (pp^T + qq^T)#(pp^T + qq^T) = 2 (pp^T)#(qq^T) = [p,q][p,q]^T. The bracket [p,q] has weights 0 and plus or minus 2alpha, and 2alpha is not a root, so [p,q] lies in t. Invariance gives <[p,q],h_k> = <p,[q,h_k]> = <p, alpha_k p> = alpha_k, so [p,q] = sqrt2 u and P#P = 2 u u^T. Correct.
- **No other landings.** P_beta#P_gamma with beta different from gamma has weights plus or minus beta plus or minus gamma, never 0, so nothing from it reaches t. It lands on R_{beta+gamma} or R_{beta-gamma} when that is a root. In a simply-laced system, beta+gamma a root forces <beta,gamma> = -1, and then |beta-gamma|^2 = 6, which is not a root. So each pair lands on at most one plane, and by T-invariance it lands as a scalar multiple of that plane's projection. Orthogonal roots have |beta plus or minus gamma|^2 = 4, not roots, so they give zero. The answer to the brief's "could cross terms also land elsewhere" is no.
- **Pair count.** For alpha = e1-e2 the pairs are {e1+s e_k, e2+s e_k}, k = 3..m and s = plus or minus, each a difference of positive roots. For alpha = e1+e2 they are {e1-e_k, e2+e_k} and {e1+e_k, e2-e_k}, each a sum. That is 2(m-2) in both cases.
- **Weyl uniformity.** Elements of N(T) are orthogonal automorphisms preserving #, and they carry P_beta to P_{w beta}, so the coefficient kappa_{beta gamma} is constant on orbits of the stabiliser of plus or minus alpha. For alpha = e1-e2 that stabiliser contains the permutations of {3..m}, together with swap(12) composed with the sign change on (1,2). The latter carries the pair with sign s to the pair with sign -s, and is the element that works at m = 3, where a lone sign change on e3 is not in W(D_3). So the group is transitive, and every alpha is in one orbit, which settles the other roots.
- **Value 1.** Read I#I = (n-2)I on R_alpha: 2 (I_t # P_alpha) = 2, plus 2 kappa for each ordered pair, giving 2 + 4 kappa (m-2) = 2m-2. So kappa = 1/2, and the unordered-pair coefficient in C#C is 2 kappa mu_beta mu_gamma = mu_beta mu_gamma. Correct.
- **Minor, notation.** The display writes the sum as beta+gamma = alpha. For alpha = e1-e2 every pair is a difference, and the prose ("combining to plus or minus alpha") is the accurate reading. The sentence "the Weyl group acts transitively on the pairs" means the stabiliser of plus or minus alpha.

## G3, the reduced system

- u_alpha.u_beta = <alpha,beta>/2, which is in {1, plus or minus 1/2, 0}, so the squares are {1, 1/4, 0} as stated.
- The positive roots non-orthogonal to e1-e2, other than itself, are e1 plus or minus e_k and e2 plus or minus e_k for k at least 3: 4(m-2). The root e1+e2 is orthogonal to e1-e2.
- The Cartan block of C#C is 2 sum mu^2 u u^T (no contribution from A#A or from the mixed pairs), so idempotency forces A to equal it. Then u_alpha^T A u_alpha = 2 mu_alpha^2 + (1/2) sum over the neighbours of mu_beta^2. Doubling and multiplying by mu_alpha gives 4 mu_alpha^3 + mu_alpha sum mu_beta^2, which is the stated cubic.
- With every mu > 0, A is positive definite because the D_m roots span R^m (m at least 2). Conversely, any positive solution defines a positive-definite T-invariant idempotent. So "exactly the positive solutions" is right.
- Uniform point: c^2 = 4(m-1) + 2(m-2)c has roots c = 2m-2 and c = -2. The Cartan equation 2(m-1)/c^2 = 1/c keeps only 2(m-1).
- L267 check by hand: on the root e1 minus or plus e2 the cubic is a = 4a^3 + 2(n-4) a b^2 + (n-4) b^2. Substituting L267's 2a^2 + (n-4) b^2 = a reduces it to a identically, and the screen confirms the whole system at n = 8.

## G4, scope (corrections)

1. **The D_m system does not contain every counterexample found.** The batch says U_s restricted to T-invariant idempotents "is a finite problem on the root system that contains every counterexample to U found", and "L267's counterexample is a solution". That holds for even n only. L267 at odd n lives on so(2m+1) (root system B_m), and L263's two live on g2 (root system G_2). Neither is a solution of this system, which is derived for D_m. The derivation does not transfer verbatim either. In B_m the short roots e_i and e_j have both e_i+e_j and e_i-e_j as roots, so a pair can land on two planes, and with two root lengths the pair coefficients form more than one Weyl orbit. So the "one number fixed by I#I" step fails there. Correction: "contains every counterexample found on so(2m); the odd n and g2 cases need the B_m and G_2 analogues, which carry more than one pair constant".
2. **The system carries idempotency and leaves stability out.** The idempotents of the family are its positive solutions. The stability condition of U_s, however, is <C#H,H> at most (1/2)|H|^2 for every H orthogonal to C in all of Sym^2 so(2m), including directions outside the T-invariant family. The batch does not supply that condition. So "U_s restricted to T-invariant idempotents is a finite problem" is true only in the sense that the candidate set is finite-dimensional, and the stability half still has to be written down (for instance, weight by weight under T).
3. **The F36 attribution is imprecise.** F36's fourth paragraph closes proving the maximiser of P on Weyl_n coordinate-diagonalisable, which is the lifting lemma of [diagonality.md](../findings/diagonality.md). It closes because padded W_CP2 is a Plucker-obstructed local maximum, separated from a maximiser only by the value. The batch's step is different: that a maximiser of F on Sym^2 so(n) is T-invariant for some maximal torus. It is also mis-described as "averaging over a torus". Averaging a maximiser over T does not preserve idempotency or the value of the cubic, so it is no candidate step at all. The accurate reason the reduction stops is the batch's own first clause, that the maximiser need not be T-invariant for any T. F36 is at most an analogue on the Weyl-tensor side. Correction: drop "averaging", and cite F36 as the Weyl_n analogue rather than as a closure of this step.

The claim "Lemma D shape (L261) with a coupling through the coroot form" was not checked: L261 is not among the brief's givens.

## G5, Lean and other

- torus_uniform types the reduced root equation at mu = 1/c with neighbour count 4(m-2) and pair count 2(m-2), and the Cartan block 2(m-1)(1/c)^2 = 1/c, both under the hypothesis c = 2(m-1). The Cartan conjunct uses sum over the positive roots of u u^T = (m-1)I, which holds for D_m. This is faithful to "the uniform point solves the system".
- The brief's row says "exactly when", and the prose says "requires". The declaration proves the direction "if" only. Necessity is immediate from the Cartan equation, but it is not typed. A one-line converse would make the row literal.
- Everything else (the family, the constants, the cubic) is prose, as the table says. My screen at m = 3, 4 is independent of the author's at m = 3.
