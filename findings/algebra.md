# Fox's algebra, and the Hessian at the sphere product

The nonassociative algebra whose idempotents are the critical points, the Killing constant Fox leaves uncomputed, and the derived Hessian spectrum at $W^*$.

Part of [findings/INDEX.md](INDEX.md), the index that says which file to open.

---

## The algebra behind the problem, and the constant Fox leaves uncomputed

**The setting is Fox's commutative nonassociative algebra**, and the identification is exact: $P(W)=\langle W,Q(W)\rangle$ is its cubic form, **critical points of $P$ on the unit sphere are its idempotents**, and $F_u$ **is the multiplication operator $L(u)$**. Verified from Fox's own tensor formula (5.11) with no project code in the path: $X*Y=-1.000000000000\cdot F_X(Y)$ at residual $2\times10^{-16}$, the sign being his curvature convention, under which $-\mathrm{Id}$ is an isometric algebra isomorphism. So the multiplication table between $F_u$-eigenspaces is a Peirce-type decomposition of a named algebra. Extraction in [notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md).

**Fox's Theorem 1.3** gives, for this algebra, $\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}\big(L(x)L(y)\big)=\kappa_F\langle x,y\rangle$. The group acting irreducibly by isometric automorphisms is $O(n)$ rather than $SO(n)$: at $n=4$ the space of $SO(4)$-invariant symmetric forms on $\mathrm{MC}_W$ is two-dimensional, against one at $n=5,6$.

**The Killing constant, in closed form:**

$$\boxed{\ \kappa_F(n)=\frac{(2n-1)(n-1)}{4}\ }$$

in the Frobenius normalisation used throughout this project, or $(2n-1)(n-1)/16$ in Fox's, whose metric is complete contraction, exactly $4\times$ Frobenius. **This is a number Fox does not have: his Remark 1.4 explicitly leaves $\kappa$ uncomputed for $\dim V>4$.** It is anchored at the one dimension he does compute: at $n=4$ the formula gives $21/16$, matching his Theorem 1.5(2).

**Verified far beyond the fit.** $\mathop{\mathrm{tr}}(F_W^2)=\kappa_F(n)$ holds at roughly 90 points across $n=4\ldots14,16$, every sphere-product splitting, the $\mathfrak{su}(m)$ Kähler points, the Fox plateau, and **random unit Weyl operators with criticality residual $\approx1$**, with maximum deviation $4\times10^{-13}$. So it is a property of the algebra, not of its idempotents. The bilinear form itself checks at random pairs with $\langle X,Y\rangle\ne0$ to $5\times10^{-16}$. Held-out dimensions $4,5,6,7,9,11,13,14,16$ are all exact, $n=14,16$ by an independent matrix-free route ([p0_fox_identities.py](../scripts/pipelines/p0_fox_identities.py)).

**The two identities together bound $\theta$, which is [Lemma L206](bounds.md), and the bound is attained at $S^2\times S^2$ and too loose at the competitor to close the conjecture.** *What this paragraph established is narrower and still holds: at the points named below the identities are arithmetic consequences of spectra already on file, so they supply no new information about those points. The bound is a statement about every critical point at once and does not follow from any single spectrum.* Both identities are arithmetic consequences of spectra already on file: at $W_{\mathbb{CP}^2}$ the $\tfrac13$ and $-\tfrac16$ multiplicities stand in ratio $1:2$, so $\mathop{\mathrm{tr}}L=0$ cancels identically, and $\kappa=\tfrac32\sum m_ir_i^2$ falls straight out of the recorded multiplicities. At the balanced sphere product in $n=8$ (the multiplicities $(1,16,54,148,81)$ sum to $300=\dim\mathcal W_8$), the relation gives $\theta_0(8)^2\cdot\mathop{\mathrm{tr}}(L_e^2)=\tfrac{21}{16}\cdot20=26.25=\kappa_F(8)$. **The $\tfrac{21}{16}$ here is $\theta_0(8)^2=2\cdot7\cdot6/8^2$, not the $\kappa_F(4)$ of the paragraph above**, which carries the same value in Fox's normalisation and nothing else in common, at $n=6$ the two are $\tfrac{55}{16}$ and $\tfrac{10}9$. **And the $\tfrac32$ above is $\theta^2$ at $W_{\mathbb{CP}^2}$ rather than a constant**: the general relation is $\kappa=\theta^2\mathop{\mathrm{tr}}(L_e^2)$ at every unit critical point, since Fox's Theorem 1.3 above gives $\mathop{\mathrm{tr}}(L_e^2)=\kappa_F\lVert e\rVert^2=\kappa_F/\theta^2$. *Checked in [KillingConstant.lean](../lean/HamiltonsCubic/Results/KillingConstant.lean).* **The value of the closed form is that it makes [Lemma L206](bounds.md)'s bound explicit in $n$**, the constant being the numerator there.

**The $\mathbb{CP}^m$ family is Fox's, and its values follow from his norm identity with no numerics.** Lemma L10.1 constructs idempotents $S^r(\alpha)$ from an orthogonal complex structure $\alpha$ on an $r$-dimensional subspace, for every even $r$ with $2\le r\le n$, and (10.4) gives $|S^r|^2=6r(r-2)/((r+2)(r-1))$ in his metric. Since $\theta=1/|S^r|$ in the Frobenius normalisation,

$$\theta(S^r)^2=\frac{2(r+2)(r-1)}{3r(r-2)},$$

reproducing this project's measured $\theta^2=(m+1)(2m-1)/(3m(m-1))$ at $r=2m$ **exactly**, $3/2$, $10/9$, $35/36$, $9/10$, $77/90$, $52/63$ at $r=4,\dots,14$. It is decreasing in $r$, so the family is maximised at $r=4$, which is $W_{\mathbb{CP}^2}$. This is an independent derivation of a family the project had measured, and it supplies the proof of the closed form that the measurement lacked.

**Classifying the critical points is an open problem in the source literature.** Fox writes that "it would be interesting to describe completely the $G$-orbits of idempotents in subalgebras of $(\mathrm{MC}(V^*),*)$", and gives such a description only for $\dim V^*=3$ (his Corollary 8.10) and $\dim V^*=4$ (via Theorem 1.5). His Lemma 10.4 identifies certain of the Lemma L10.1 idempotents with $SO(2n)/U(n)$, the orthogonal complex structures. **Since critical points of $P$ are exactly the idempotents, the ungraded half of this project's problem is a case of a classification the literature poses and leaves open**, which is why it has resisted, and why partial results about it are the realistic target rather than a full enumeration.

## The Hessian at the sphere product, derived rather than fitted

The five rational families in the Hessian spectrum at $W^*$ were fitted on $n=6\ldots14$ and confirmed on a held-out $n=16$; what was owed was their origin. **They are now in closed form in $k=n/2$**, but *as a fit to the three tabulated rows, not a derivation* (Gate 2, both reviewers). The real derivation is Reviewer 84's Casimir master formula, recorded in [fence-posts.md](fence-posts.md); these families are its $p=q=k$ diagonal. **The exception does not "fall out" of the version below, it is fitted along with everything else**, and the fit is structurally blind to the two ambient families that vanish at $p=4$ and $p=7$ and are killed only by first Bianchi.

With $c:=(6F-3\theta)/\theta$ and $\lambda$ the $L_e$ eigenvalue, matching the $k=4$ blocks $(1,16,54,148,81)\leftrightarrow(+3,0,-1,-3,-5)$ against the recorded $L_e$ spectrum $\{1,\tfrac12,\tfrac13,0,-\tfrac13\}$ gives $c=6\lambda-3$ on every block. **So Morse–Bott nondegeneracy is exactly: $c=0$ on the orbit tangent and nowhere else.** The families are

$$c_A=\frac{-3}{k-1},\qquad c_B=\frac{-3(k-3)}{k-1},\qquad c_C=-3,\qquad c_D=\frac{-3(k+1)}{k-1},$$

with $\dim A=(k-1)(k+2)$ and $\dim B=\big(\tfrac{k(k-1)}2\big)^2$, alongside $c=+3$ on the one-dimensional block $W^*$ itself and $c=0$ on the orbit tangent $\mathbb R^k\otimes\mathbb R^k$ of dimension $k^2$. Every recorded row is reproduced: $k=4$ gives $(-1,-1,-3,-5)$, **$A$ and $B$ coincide at $k=4$**, which is why that row has five blocks and not six, and $\dim A+\dim B=18+36=54$ is exactly the merged block; $k=5$ gives $(-\tfrac34,-\tfrac32,-3,-\tfrac92)$ with dimensions $28,100$; $k=6$ gives $(-\tfrac35,-\tfrac95,-3,-\tfrac{21}5)$ with $40,225$.

**The proof, and the exception.** Setting each family to zero: $c_A=0$ never, $c_C=-3\ne0$, $c_D=0$ would need $k=-1$. **Only $c_B$ vanishes, and exactly at $k=3$.** So

> **Every balanced sphere product $S^k\times S^k$ with $k\ge4$ is Morse–Bott nondegenerate, and $k=3$ is the only failure, for all $k$ at once, by closed form rather than by sweep.**

And the failure's *size* comes out too: at $k=3$, $\dim B=\big(\tfrac{3\cdot2}2\big)^2=9$, which added to the orbit tangent $k^2=9$ gives kernel $18$ against orbit $9$, the recorded $n=6$ exception, to the dimension.

*Scope, stated plainly:* this settles the **balanced** family for every $k$. The unbalanced $S^p\times S^q$ statement (that no isotypic block other than $\mathbb R^p\otimes\mathbb R^q$ carries $\lambda=\tfrac12$), still needs its own two-parameter families, and remains verified at $n=8,10$ rather than proved.

| $n$ | block dimensions | $(6F-3\theta)/\theta$ on each |
| --- | --- | --- |
| 8 | $1,16,54,148,81$ | $+3,\ 0,\ -1,\ -3,\ -5$ |

**This table produces the $20$ used in the Killing-constant paragraph above.** Reading $F/\theta=(c+3)/6$ gives the spectrum $\{1,\tfrac12,\tfrac13,0,-\tfrac13\}$ against these multiplicities, whence $\mathop{\mathrm{tr}}L_e=0$ and $\mathop{\mathrm{tr}}L_e^2=20$, so $\kappa_F(8)=\theta_0(8)^2\cdot20=\tfrac{105}4$ is derived here rather than quoted. **And the $\tfrac12$-eigenspace is the orbit exactly**: multiplicity $16$ against $\binom82-\dim(\mathfrak{so}(4)\oplus\mathfrak{so}(4))=28-12=16$, so the excess is $0$ at this point, the figure [second-order.md](second-order.md) records, obtained from this table. The $n=6$ exception above is the same computation with excess $9$. *Checked in [BlockTable.lean](../lean/HamiltonsCubic/Results/BlockTable.lean).*
| 10 | $1,25,28,100,420,196$ | $+3,\ 0,\ -\tfrac34,\ -\tfrac32,\ -3,\ -\tfrac92$ |
| 12 | $1,36,40,225,936,400$ | $+3,\ 0,\ -\tfrac35,\ -\tfrac95,\ -3,\ -\tfrac{21}5$ |

The structure is legible throughout: the $+3$ eigenvalue sits on a one-dimensional block, which is $W^*$ itself; the zero eigenvalue sits on a block of dimension $k^2$, the orbit tangent $\mathbb R^k\otimes\mathbb R^k$; and the negative eigenvalues are rationals with denominator $k-1$. At $n=8$ two Casimir values coincide, giving five blocks where $n=10,12$ give six. **Gate 2 pending.**

