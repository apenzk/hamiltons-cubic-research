# Review r910: do the two R23 corollaries follow, the Fox algebra is not isospectral (I87) and not medial (I88)

This round checked two new-mathematics corollaries attached to [Lemma L207](../findings/nondegeneracy.md), each deciding whether R23 (separate the maximiser by the Fox-algebra spectrum) keeps a live engine. I read the Krasnov--Tkachev givens in [references/krasnov-tkachev-2022-medial-isospectral/notes.md](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) (Definitions 1.1, 1.6, 2.1 and 2.2, Propositions 3.6 to 3.9, Corollaries 4.5 to 4.9, Remark 1.2 and Theorem 2.3), the L207 statement and the recorded (2,2) spectrum in [findings/nondegeneracy.md](../findings/nondegeneracy.md), the corollary text there, and the Lean declaration [foxAlgebra_not_isospectral](../lean/HamiltonsCubic/Results/L207SphereExcess.lean). I ran one $n=4$ screen on the record's own Fox-product code ([rsharp_basis_free.py](../scripts/lib/rsharp_basis_free.py), [g1_le_machinery.py](../scripts/lib/g1_le_machinery.py)): a few-seconds computation on objects already in hand, exact to residual $\sim10^{-16}$, reported as a screen and never as establishing a positive claim. Log: `agent_logs/gate2-i87-i88-r910.log`.

## Claim table

| # | Item | Verdict |
|---|------|---------|
| 1 | I87: "same spectrum" (Def 1.1) is the multiset with multiplicity, the reading the argument needs | CONFIRMED |
| 2 | I87: $S^2\times S^{n-2}$ and $S^3\times S^{n-3}$ are two distinct nonzero idempotents of one $\mathcal W_n$ | CONFIRMED |
| 3 | I87: $2(n-2)=3(n-3)$ only at $n=5$, exclusion harmless, multiplicities differ for $n\ge6$ | CONFIRMED |
| 4 | I87: corollary neither vacuous nor trivial | CONFIRMED |
| 5 | I88: endomorphism step gives $u\circ u=Q(u)\in E_{1/4}\cup\{0\}$ under mediality | CONFIRMED |
| 6 | I88: $u\circ u\ne0$ for a $1/2$-eigenvector at $S^2\times S^2$ (load-bearing) | CONFIRMED |
| 7 | I88: $\operatorname{spec}L_e=\{1,\tfrac12,-1\}$ at $S^2\times S^2$, $\tfrac14$ absent | CONFIRMED |
| 8 | I88: Prop 3.6(a) smuggles no hypothesis $\mathcal W_n$ fails | CONFIRMED |
| 9 | I88: the reach ("classification does not apply off the shelf", engine gone, route live) | CONFIRMED |
| 10 | Breakers named for each corollary, and searched for | CONFIRMED |

## Summary

Both corollaries hold: the Fox algebra $\mathcal W_n$ is not isospectral (I87) and not medial (I88), so R23's separating invariant is real while Krasnov--Tkachev's medial classification is unavailable off the shelf.

## 1. Def 1.1 reads the multiset, which is what I87 needs

The argument separates the two idempotents by a differing multiplicity of $\tfrac12$, so it lives or dies on whether "same spectrum" counts multiplicity. [Definition 2.1](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) settles it in the paper's own words: the spectrum $\mathrm{spec}(c)$ is "the multi-set of all roots of the characteristic polynomial of $L_c$", and the Peirce spectrum $\sigma(c)$ is "the set of all distinct eigenvalues", with the explicit warning that "two idempotents may have distinct spectra while their Peirce spectra may be the same". [Definition 1.1](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) (isospectral: all idempotents share one spectrum) therefore compares the multiset. The paper's usage confirms the reading: Proposition 3.7 says the idempotents of $\mathrm{Idm}^\times$ share "the same characteristic polynomial", and Corollary 4.9 gives the shared spectrum as the full list of primitive roots of unity with their multiplicities. No finding: the argument needs the multiset reading, and the paper supplies exactly that.

## 2. Two distinct nonzero idempotents of one algebra

Same $n$ means one algebra $\mathcal W_n$, so the two idempotents are compared inside a single algebra as Def 1.1 requires. Both products exist for $n\ge6$: $S^2\times S^{n-2}$ needs $n-2\ge2$ and $S^3\times S^{n-3}$ needs $n-3\ge3$, both met at $n\ge6$. They are distinct critical points (distinct sectional matrices, distinct isotropy $\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$ against $\mathfrak{so}(3)\oplus\mathfrak{so}(n-3)$), so the Weyl tensors $W$ differ and $e=W/\theta$ differs. Each $e$ is a genuine nonzero idempotent: a critical point satisfies $Q(W)=\theta W$, hence $Q(e)=Q(W)/\theta^2=e$ and $e\circ e=Q(e)=e$. My $n=4$ screen spot-checks this construction on the record's code: at $S^2\times S^2$, $e=W/\theta$ satisfies $\lVert Q(e)-e\rVert\sim2\times10^{-16}$. No finding: distinct, both nonzero idempotents, one algebra.

## 3. The crossing is at $n=5$ alone and the exclusion is harmless

Solving $2(n-2)=3(n-3)$ gives $2n-4=3n-9$, so $n=5$, the unique real solution. At $n=5$ the two "products" are $S^2\times S^3$ and $S^3\times S^2$, the same product with its factors swapped, so there is no second idempotent to compare and the excluded case carries nothing. For $n\ge6$ the multiplicities always differ, since $3(n-3)-2(n-2)=n-5>0$. The Lean theorem [foxAlgebra_not_isospectral](../lean/HamiltonsCubic/Results/L207SphereExcess.lean) states exactly $2(n-2)\ne3(n-3)$ for $6\le n$ and closes it by `omega`, which is the correct and harmless range. No finding.

## 4. Not vacuous, not trivial

The corollary would be vacuous if one product failed to exist, if the two coincided, or if $\dim E_{1/2}$ were not a genuine spectral invariant. None holds: for $n\ge6$ both exist and differ (item 2), and $\dim E_{1/2}(L_e)$ is the multiplicity of $\tfrac12$ in the multiset $\mathrm{spec}(e)$, which L207 gives in closed form as $pq$. It is not trivial in the sense of holding for every algebra, since isospectral algebras exist (the Hsiang algebras the paper opens with, all idempotents sharing $\{-1,-\tfrac12,\tfrac12,1\}$ with fixed multiplicities). So non-isospectrality is a real property that $\mathcal W_n$ has and other metrised algebras lack. The claim rests on L207's $pq$ formula and nothing weaker would give it. No finding.

## 5. The endomorphism step is correct, and $u\circ u=Q(u)$ is the right reading

Granting [Proposition 3.6(a)](../references/krasnov-tkachev-2022-medial-isospectral/notes.md), $L_e(x\circ y)=(L_ex)\circ(L_ey)$. For a $\tfrac12$-eigenvector $u$, so $L_eu=\tfrac12u$, this gives $L_e(u\circ u)=(\tfrac12u)\circ(\tfrac12u)=\tfrac14(u\circ u)$, hence $u\circ u\in E_{1/4}(L_e)\cup\{0\}$. The reading $u\circ u=Q(u)$ is correct because $Q$ is a homogeneous quadratic map ($Q(W)=W^2+W^\#$, both terms degree two), so $u\circ u=\tfrac12(Q(2u)-Q(u)-Q(u))=\tfrac12(4Q(u)-2Q(u))=Q(u)$. The screen confirms the identity directly: $\lVert Q(u)-u\circ u\rVert\sim10^{-16}$ for each $\tfrac12$-eigenvector at $n=4$. No finding.

## 6. Load-bearing vacuity check: $u\circ u\ne0$

This is the "trivially true" trap: if $u\circ u=0$ for every $\tfrac12$-eigenvector, then $u\circ u\in E_{1/4}\cup\{0\}$ holds vacuously and mediality is not contradicted. The screen refutes that at $S^2\times S^2$. The $\tfrac12$-eigenspace is four-dimensional, and $u\circ u=Q(u)$ is nonzero for all four unit basis eigenvectors, with norms $1.2105$, $0.8662$, $0.8944$ and $1.0555$. The value $0.866\approx\sqrt3/2$ that the record cites is reproduced exactly (eigenvector 1). One nonzero witness is all the argument needs, and there are four. The screen also shows the actual algebra is not medial where the argument predicts: for a random unit $\tfrac12$-eigenvector, $\lVert L_e(u\circ u)-\tfrac14(u\circ u)\rVert=1.14$ against $\lVert u\circ u\rVert=0.996$, so $u\circ u$ is not a $\tfrac14$-eigenvector, which is precisely the failure of 3.6(a). CONFIRMED, and this is the item on which I88 turns.

## 7. The complete $S^2\times S^2$ spectrum, with $\tfrac14$ absent

$n=4$, $p=q=2$, so $\mu=\frac{n-2}{2(p-1)(q-1)}=\frac{2}{2}=1\ne\tfrac12$, and L207 gives $\dim E_{1/2}=pq=4$ with no four-set contribution. The screen returns the full spectrum $\{-1$ with multiplicity $4$, $\tfrac12$ with multiplicity $4$, $1$ with multiplicity $2\}$, summing to $10=\dim\mathcal W_4=4\cdot5\cdot6\cdot1/12$ and with trace $0$, matching [Lemma L26](../findings/nondegeneracy.md)'s recorded $(-1)^4,(\tfrac12)^4,1^2$ verbatim. The distinct spectrum is $\{1,\tfrac12,-1\}$ and $\tfrac14$ is absent (screen: no eigenvalue within $10^{-6}$ of $\tfrac14$). The obstruction needs only $\tfrac14\notin\operatorname{spec}$ together with $u\circ u\ne0$, and both hold. No finding.

## 8. Proposition 3.6(a) smuggles no hypothesis

3.6 assumes only that $A$ is medial and $c\in\mathrm{Idm}(A)$ an idempotent. The proof of (a) recorded in the notes is $L_c(xy)=c(xy)=(cc)(xy)=(cx)(cy)=L_cx\,L_cy$, which uses only $c=cc$ (idempotence) and the medial identity (10). No unit, reduced, generic or semisimple hypothesis enters. $e=W/\theta$ is an idempotent (item 2). The route that once died on a cited theorem's unital hypothesis does not recur here: the unital assumption in Krasnov--Tkachev lives in Proposition 3.9 (a unital medial algebra is associative), and $\mathcal W_n$ having no unit costs 3.9 but leaves 3.6(a) untouched, since 3.6(a) never mentions a unit. No finding.

## 9. The reach is correct, not overstated

The claim is that Krasnov--Tkachev's classification does not apply off the shelf, that I89 loses its off-the-shelf method, and that the route stays live because the spectrum still separates. Each classification result assumes mediality: Theorem 2.6 (unique medial generic isospectral algebra) and Theorem 2.8 (the $\mathbb Z_{2^n-1}$ bijection) both take a medial algebra, and Corollaries 4.5 to 4.9 (the reduced-medial Peirce calculus, eigenvalues multiplying, semisimple idempotents forcing isospectrality) all sit under "reduced medial". Non-mediality removes every one of them, and Proposition 3.6's ideal and subalgebra structure with it. A second, independent exclusion is already on record: [Remark 1.2](../references/krasnov-tkachev-2022-medial-isospectral/notes.md) shows a generic isospectral algebra of dimension $\ge3$ is not metrised, and $\mathcal W_n$ is metrised, so the generic classification was disjoint from it in any case. What survives without mediality is Theorem 2.3, the genericity criterion, which is a statement about the Peirce spectrum alone: since $\tfrac12\in\sigma(\mathcal W_n)$ (indeed $\dim E_{1/2}=pq>0$), Theorem 2.3 says $\mathcal W_n$ is not generic. That is a usable structural fact, but it does not separate the balanced maximiser from a low-moment rival, so it does not pin the maximiser. The phrasing "the spectrum does separate, but its engine is gone" is therefore accurate: I87's separating invariant is real, and the medial machinery that would have leveraged it into a classification is unavailable. No finding, the reach is correct.

## 10. What would break each corollary, and the search for it

**I87.** The single object that would reopen it is Definition 1.1 comparing Peirce spectra (the set of distinct eigenvalues) rather than spectra (the multiset). Under the set reading, both idempotents carry $\tfrac12$ in their support and the differing multiplicity proves nothing. I looked for that by reading the paper's own Definition 2.1 and its usage in Proposition 3.7 and Corollary 4.9 (item 1), and it comes down against the set reading. A second breaker would be the two idempotents coinciding or one failing to exist, checked at item 2 and excluded for $n\ge6$. I found no route to reopen I87.

**I88.** The load-bearing object is $u\circ u=Q(u)$ for a $\tfrac12$-eigenvector: if it vanished, the obstruction would collapse. I looked by computing it on the record's Fox-product code at $n=4$ and found all four values nonzero (item 6). A second breaker would be $\tfrac14\in\operatorname{spec}L_e$ at $S^2\times S^2$, checked at item 7 and absent. A third would be a hidden hypothesis in 3.6(a), checked at item 8 and absent. I found no route to reopen I88.

## I87 verdict

CONFIRMED. The Fox algebra $\mathcal W_n$ is not isospectral. The two sphere-product idempotents $S^2\times S^{n-2}$ and $S^3\times S^{n-3}$ live in one algebra, are distinct for $n\ge6$, and carry $\tfrac12$ with multiplicities $2(n-2)$ and $3(n-3)$, which the multiset reading of Definition 1.1 compares and which differ at every $n\ge6$. The corollary is neither vacuous nor trivial, and its Lean skeleton states the right arithmetic on the right range.

## I88 verdict

CONFIRMED. The Fox algebra is not medial. Granting Proposition 3.6(a), a $\tfrac12$-eigenvector would force $u\circ u=Q(u)\in E_{1/4}(L_e)\cup\{0\}$, but at $S^2\times S^2$ the spectrum is $\{1,\tfrac12,-1\}$ with $\tfrac14$ absent while $Q(u)\ne0$ (screen, norm $0.866=\sqrt3/2$, exact to $10^{-16}$), so the medial identity fails. Proposition 3.6(a) carries no hypothesis $\mathcal W_n$ lacks. The reach is correct: the medial classification is unavailable off the shelf, so I89 loses that method, while the separating invariant of I87 keeps the route live. On the Lean question the brief poses, I agree no base-layer declaration can carry I88 as it stands: its load-bearing input is the numerical fact $Q(u)\ne0$ at $n=4$, and the base layer's real-operator Fox product has no `native_decide` path to it. A declaration could exist only by moving the algebra to exact arithmetic, for instance $\mathcal W_4$ over $\mathbb Q$ with $L_e$, its $\tfrac12$-eigenspace and $Q(u)$ as rational matrices, then `decide` on $Q(u)\ne0$ and on $\tfrac14\notin\operatorname{spec}$. That is a real construction rather than a restatement of the arithmetic already typed in [L207SphereExcess.lean](../lean/HamiltonsCubic/Results/L207SphereExcess.lean), so recording I88 as prose plus a screen is the honest state today.
