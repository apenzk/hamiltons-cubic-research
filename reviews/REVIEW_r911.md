# Review r911: do the two R23 corollaries follow, Fox algebra not isospectral (I87) and not medial (I88)

This round audits two new-mathematics corollaries of R23, that the Fox algebra $\mathcal W_n$ is not isospectral (I87) and not medial (I88). I read the Krasnov-Tkachev givens in [notes.md](../references/krasnov-tkachev-2022-medial-isospectral/notes.md), the L207 spectrum lemma and the corollary text in [nondegeneracy.md](../findings/nondegeneracy.md), and reconstructed the $n=4$ Fox algebra from the record's own machinery in [core297.py](../scripts/reviewers/r297/core297.py). Every numeric here is a few-minutes $n=4$ to $n=8$ screen on objects already in hand, reported as an exact screen and never as establishing a positive claim. Log: [agent_logs/gate2-i87-i88-r911.log](../agent_logs/gate2-i87-i88-r911.log).

| # | Item | Verdict |
|---|------|---------|
| 1 | I87: "same spectrum" means the multiset (char poly), not the set of distinct eigenvalues | CONFIRMED |
| 2 | I87: two distinct nonzero idempotents of the one algebra $\mathcal W_n$ | CONFIRMED |
| 3 | I87: $2(n-2)=3(n-3)$ only at $n=5$, multiplicities differ for $n\ge6$ | CONFIRMED (with an $n=6$ caveat) |
| 4 | I87: the corollary is not vacuous or trivial | CONFIRMED |
| 5 | I88: endomorphism step gives $u\circ u\in E_{1/4}(L_e)\cup\{0\}$, and $u\circ u=Q(u)$ | CONFIRMED |
| 6 | I88: $u\circ u\ne0$ at $S^2\times S^2$ (the load-bearing vacuity check) | CONFIRMED |
| 7 | I88: $\mathop{\mathrm{spec}}L_e=\{1,\tfrac12,-1\}$ at $S^2\times S^2$, with $\tfrac14$ absent | CONFIRMED |
| 8 | I88: Prop 3.6(a) smuggles no extra hypothesis $\mathcal W_n$ fails | CONFIRMED |
| 9 | I88: the reach ("classification does not apply off the shelf", route not dead) is correct | CONFIRMED |
| 10 | What would break each corollary | both stand |

Summary: both corollaries follow. I87 is correct in its conclusion for every $n\ge6$, and I record one imprecision, that its blanket "$\dim E_{1/2}(L_e)=pq$ at $S^p\times S^q$" drops L207's own $(3,3)$ excess, so the value it assigns to $S^3\times S^3$ at $n=6$ is $9$ where the true multiplicity is $18$, and the inequality that carries the argument survives either number. I88 is a valid closed-form-style obstruction, and its one load-bearing screen ($u\circ u\ne0$) passes.

## What I computed, and that it is a screen

I rebuilt $\mathcal W_4$ as the Ricci-flat first-Bianchi subspace of $\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb R^4)$ (dimension $10$), took $W$ for $S^2\times S^2$ as the sectional-matrix idempotent, formed $L_e=e\circ(\cdot)$ projected back onto $\mathcal W_4$, and read its spectrum. The Fox product used is $X\circ Y=\tfrac12(XY+YX)+\mathop{\mathrm{sharp}}(X,Y)$ projected onto $\mathcal W_n$, matching the record's [Q_full](../scripts/lib/rsharp_basis_free.py) and [core297.py](../scripts/reviewers/r297/core297.py). All of this ran in under a second. It refutes and confirms and screens, it does not establish, and the positive content rests on the analysis below.

Findings, exact at the stated precision:

- $S^2\times S^2$ at $n=4$: $\theta=\sqrt3/2=0.866025$, criticality residual $3.9\times10^{-16}$, and $e\circ e=e$ to $6.2\times10^{-16}$, so $e$ is a genuine idempotent.
- $\mathop{\mathrm{spec}}L_e=\{-1,\tfrac12,1\}$ with multiplicities $(4,4,2)$ summing to $10=\dim\mathcal W_4$, and $\tfrac14$ absent.
- Each of the four basis $\tfrac12$-eigenvectors $u$ (unit norm) has $\lVert u\circ u\rVert=\sqrt3/2=0.866025$, a generic unit $\tfrac12$-vector gives $1.028$, and $L_W(u,u)=Q(u)$ to $10^{-32}$.
- I87 multiplicities: $S^2\times S^4$ gives $8$, $S^3\times S^3$ gives $18$, $S^2\times S^5$ gives $10$, $S^3\times S^4$ gives $12$, $S^2\times S^6$ gives $12$, $S^3\times S^5$ gives $15$, each pairwise unequal at fixed $n$.
- Medial identity $(X\circ Y)\circ(Z\circ W)=(X\circ Z)\circ(Y\circ W)$ screened on $20$ random Weyl quadruples at $n=4,5,6$: worst relative discrepancy $0.81$, $0.86$, $0.72$, so it fails at each.

## I87, the Fox algebra is not isospectral

### 1. "Same spectrum" means the multiset. CONFIRMED

The paper's [Definition 2.1](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) fixes this without ambiguity: the spectrum $\mathop{\mathrm{spec}}(c)$ is the multi-set of all roots of the characteristic polynomial of $L_c$, and the distinct-eigenvalue set is a separate object, the Peirce spectrum $\sigma(c)$. Definition 1.1 defines isospectral as all idempotents sharing one spectrum, meaning the multiset. The same definition adds the exact remark the argument relies on, that two idempotents may have distinct spectra while their Peirce spectra coincide. That is precisely the I87 configuration, where both idempotents carry $\tfrac12$ in $\sigma$ but with different multiplicity. Proposition 3.7 (same characteristic polynomial for elements of $\mathrm{Idm}^\times$) and Corollary 4.9 (spectrum as roots of unity) both read the multiset. The argument needs the multiset reading, and the paper supplies it.

### 2. Two distinct nonzero idempotents of one algebra. CONFIRMED

$S^2\times S^{n-2}$ and $S^3\times S^{n-3}$ share the single dimension $n$, so they are curvature tensors of the one algebra $\mathcal W_n$, not two algebras compared illegitimately. Both are Ricci-flat two-block products, so both lie in $\mathcal W_n$, and their block structures differ, so they are distinct tensors. Each critical point gives $e=W/\theta$ with $\theta>0$ (at $n=4$ I measured $\theta=\sqrt3/2$, and $e\circ e=e$), a nonzero idempotent. Both families are genuine two-block products once $n\ge6$, where $S^3\times S^{n-3}$ has $q=n-3\ge3$.

### 3. The collision is at $n=5$ alone, and the multiplicities differ for $n\ge6$. CONFIRMED, with a caveat at $n=6$

Solving $2(n-2)=3(n-3)$ gives $2n-4=3n-9$, so $n=5$. At $n=5$ the two families are the single product $S^2\times S^3$ read two ways, so no pair of distinct idempotents exists there and the exclusion $n\ne5$ removes nothing real. For $n\ge6$ the gap $3(n-3)-2(n-2)=n-5\ge1$ is strictly positive, so the multiplicities of $\tfrac12$ always differ, which I confirmed at $8\ne18$ ($n=6$), $10\ne12$ ($n=7$) and $12\ne15$ ($n=8$).

The caveat is a real imprecision in the corollary's arithmetic. L207 reads $\dim E_{1/2}=pq+\binom p2\binom q2\,[\mu=\tfrac12]$, with the excess active exactly at $(3,3)$. The split $S^3\times S^{n-3}$ hits $(3,3)$ precisely at $n=6$, where the true multiplicity is $3\cdot3+\binom32^2=18$, not the corollary's $3(n-3)=9$. My screen confirms $18$. The corollary's headline formula "$\dim E_{1/2}(L_e)=pq$ at $S^p\times S^q$" is therefore stated too broadly, since it drops the term L207 itself carries. The conclusion is untouched, because $8\ne18$ refutes isospectrality at $n=6$ just as $8\ne9$ would, and for every $n\ge7$ both chosen splits sit away from $(3,3)$ so the plain $pq$ formula is exact and the corollary is verbatim correct.

### 4. Not vacuous or trivial. CONFIRMED

A refutation of isospectrality would be vacuous if the algebra had at most one idempotent, or if the two named idempotents coincided, or if $\dim E_{1/2}$ were forced equal for an unrelated reason. None holds: $\mathcal W_n$ carries many critical points, the two products are distinct for $n\ge6$, and their $\tfrac12$-multiplicities are demonstrably different numbers, so the differing characteristic polynomials are a genuine separation and not an identity dressed as one.

## I88, the Fox algebra is not medial

### 5. The endomorphism step. CONFIRMED

Granting Proposition 3.6(a), $L_e$ is an algebra endomorphism, so $L_e(u\circ u)=(L_e u)\circ(L_e u)$. For a $\tfrac12$-eigenvector, $L_e u=\tfrac12 u$, and bilinearity of $\circ$ gives $(\tfrac12 u)\circ(\tfrac12 u)=\tfrac14(u\circ u)$. Hence $u\circ u\in E_{1/4}(L_e)$ when nonzero, and lies in $\{0\}$ otherwise. The reading $u\circ u=Q(u)$ is correct: the Fox self-product is the polarization of the quadratic $Q$ at coincident arguments, $u\circ u=\tfrac12(Q(2u)-2Q(u))=Q(u)$, which I checked numerically as $L_W(u,u)=Q(u)$ to $10^{-32}$.

### 6. The vacuity check, $u\circ u\ne0$ at $S^2\times S^2$. CONFIRMED

This is the load-bearing point and it passes. Each of the four basis $\tfrac12$-eigenvectors has $\lVert u\circ u\rVert=\lVert Q(u)\rVert=\sqrt3/2=0.866025$ after projection onto $\mathcal W_4$, reproducing the record's cited $0.866$, and a generic unit $\tfrac12$-vector gives $0$ nowhere ($1.028$). The obstruction is therefore not the trivial one where $u\circ u=0$ sits in $E_{1/4}$ for free. As a direct corroboration I checked that the actual $L_e(u\circ u)$ misses $\tfrac14(u\circ u)$ by relative norm $1.15$, so $u\circ u$ is a nonzero vector that is not a $\tfrac14$-eigenvector, which is the endomorphism property failing in the open.

### 7. The spectrum at $S^2\times S^2$, with $\tfrac14$ absent. CONFIRMED

At $p=q=2$, L207 gives $\mu=\tfrac{n-2}{2(p-1)(q-1)}=1\ne\tfrac12$, so no excess and $\dim E_{1/2}=pq=4$. My screen returns the complete spectrum $\{-1,\tfrac12,1\}$ with multiplicities $(4,4,2)$, summing to $10=\dim\mathcal W_4$, matching L26's recorded $(-1)^4,(\tfrac12)^4,1^2$ quoted at [nondegeneracy.md](../findings/nondegeneracy.md). The value $\tfrac14$ is absent, which is all the obstruction needs alongside $u\circ u\ne0$.

### 8. Proposition 3.6(a) carries no hypothesis $\mathcal W_n$ fails. CONFIRMED

The proof recorded in [notes.md](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) is $L_c(xy)=c(xy)=(cc)(xy)=(cx)(cy)=L_cx\,L_cy$, which uses only that the algebra is commutative, that it is medial, and that $c$ is idempotent ($cc=c$). No unital, reduced, generic, semisimple or metrised hypothesis enters, so the trap that once killed a route through a theorem assuming a unit is not present here. The ambient Krasnov-Tkachev convention is $\mathop{\mathrm{char}}K\ne2,3$, satisfied over $\mathbb R$. And $e=W/\theta$ is a genuine idempotent, checked as $e\circ e=e$ to $6\times10^{-16}$. So the step is applied within its stated hypotheses, which is what makes the failure of its conclusion a proof of non-mediality.

### 9. The reach. CONFIRMED

Every classification result in the paper rests on the medial identity, and $\mathcal W_n$ fails it. Theorem 2.6 (unique medial generic isospectral algebra), Theorem 2.8 (the $\mathbb Z_{2^n-1}$ bijection), Proposition 4.5 through Corollary 4.9 (the Peirce-multiplicativity chain, eigenvalues multiplying, semisimple idempotents cospectral) and the Bruck-Murdoch-Toyoda Theorem 2.5 all assume mediality, and 4.9 and 2.6 add genericity on top. Non-mediality removes all of them as off-the-shelf tools, so I89's plan to pin the maximiser through that classification loses its engine. This is stated correctly and not overstated.

The "route is not dead" qualifier is also correct. I87 shows the $L_e$ spectrum is a separating invariant among critical points, so a bespoke argument could still separate the maximiser. What survives without the medial identity is Theorem 2.3, a statement about the Peirce spectrum alone, and it only tells the record that $\mathcal W_n$ is not generic, because $\tfrac12\in\sigma(\mathcal W_n)$, which closes the syzygy route rather than opening one. I add that I88's endomorphism obstruction is exhibited at $n=4$, and I strengthened the family reading with a direct medial-identity screen that fails at $n=4,5,6$ (relative discrepancy $0.72$ to $0.86$), so non-mediality is witnessed across the low range and not at a single dimension. Independently, I87 already removes $\mathcal W_n$ ($n\ge6$) from the isospectral classification whatever mediality does, since a non-isospectral algebra is outside Theorems 2.6 and 2.8 by hypothesis.

### 10. What would break each corollary

I87 reopens under three objects, and I looked for each. First, a reading of Definition 1.1 as comparing Peirce spectra (sets): checked against Definition 2.1, which fixes the multiset and explicitly allows equal Peirce spectra with distinct spectra, so the set reading is the paper's $\sigma$, not its spectrum. Second, an error in L207's $\dim E_{1/2}=pq$: it is Gate 2 passed, and I reconfirmed it at $n=4,6,7,8$, including the $(3,3)$ excess. Third, a coincidence of the two products: only at $n=5$, excluded. None reopens it.

I88 reopens under three objects too. First, a $\tfrac12$-eigenvector with $u\circ u=0$: I computed $u\circ u$ for all four basis eigenvectors and a random unit combination, all of norm $\ge0.866$. Second, $\tfrac14\in\mathop{\mathrm{spec}}L_e$ at $S^2\times S^2$: absent in the full spectrum I read. Third, a hidden hypothesis in Proposition 3.6(a): the proof uses only idempotency and the medial identity. None reopens it.

## Verdicts

**I87 (not isospectral): CONFIRMED.** The corollary's conclusion holds for every $n\ge6$, where $\mathcal W_n$ carries two distinct idempotents with different $\tfrac12$-multiplicity and hence different spectra in the multiset sense the paper defines. One imprecision to fix in the text, not the mathematics: the blanket "$\dim E_{1/2}(L_e)=pq$ at $S^p\times S^q$" drops L207's own $(3,3)$ excess, so at $n=6$ the value it assigns to $S^3\times S^3$ is $9$ where the true multiplicity is $18$. The inequality that carries the refutation holds under either value, and for all $n\ge7$ both named splits avoid $(3,3)$ and the plain formula is exact.

**I88 (not medial): CONFIRMED.** The endomorphism obstruction is valid, its load-bearing vacuity check passes ($u\circ u\ne0$, norm $\sqrt3/2$), and $\tfrac14$ is absent from $\mathop{\mathrm{spec}}L_e$ at $S^2\times S^2$, so the medial identity fails. A direct medial-identity screen corroborates this at $n=4,5,6$. The reach is stated correctly: the classification assumes mediality and $\mathcal W_n$ fails it, so I89 loses its off-the-shelf method while the spectrum remains a separating invariant. The one boundary worth naming is that the endomorphism witness is at $n=4$ and the all-$n$ family claim is inferred, supported by the low-range screen and made moot for the classification's isospectral branch by I87.

On the Lean question: I88 has no Lean declaration, and I agree none in the base layer can decide it, because the obstruction turns on the numerical fact $u\circ u\ne0$ at $n=4$, which the real-operator Fox product cannot settle by `native_decide` over an exact type. A declaration could exist only after the record carries $\mathcal W_4$, the Fox product and the $S^2\times S^2$ idempotent as exact rational or algebraic objects, at which point $\lVert u\circ u\rVert^2=\tfrac34$ and $\tfrac14\notin\mathop{\mathrm{spec}}L_e$ become decidable rational statements. That is a construction the base layer does not yet hold.
