# VERIFY_v6, L04: "a generator for critical points, and a new family"

Verifier `v6`. Cold brief; no numerical work; no project record read.

Notation used throughout: $N=\binom n2$, $\Lambda^2=\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$ (so $|e_i\wedge e_j|=1$), $\mathfrak h\subseteq\mathfrak{so}(n)$ of dimension $r$, $\pi$ the orthogonal projection of $\Lambda^2$ onto $\mathfrak h$, $s=N-r$, $\theta=P(W)/\lVert W\rVert^3$.

## 1. Hypothesis inventory

### 1a. Hypotheses the entry states

| # | Hypothesis | Where used |
|---|---|---|
| H1 | $K\subseteq SO(n)$ | criticality generator |
| H2 | $(\Lambda^4\mathbb R^n)^K=0$ | claimed for criticality; actually needed for the cap |
| H3 | $\dim\mathcal W_n^K=1$ | criticality generator |
| H4 | $\mathfrak h$ is a subalgebra of dimension $r$, and $r$ is the parameter of the closed form | closed form, monotonicity, cap |
| H5 | "every member has just two eigenvalues" | closed form |
| H6 | $\theta$ increases with $\dim\mathfrak h$ | cap $\Rightarrow$ maximiser |
| H7 | max admissible $r$ is $n(n-2)/4$ (Lemma L23) | maximiser |

### 1b. Hypotheses the entry needs and does not state

| # | Unstated hypothesis | Consequence if dropped |
|---|---|---|
| U1 | $K$ compact, or replaced by its closure | Palais' principle needs a compact/proper action. Harmless: $\mathcal W_n^K=\mathcal W_n^{\overline K}$ for a linear continuous action, so taking closures is free. **Correctable.** |
| U2 | $\mathbb R^n$ is $K$-irreducible | Without it $\Lambda^2$ has $\ge 3$ invariant summands and H5 is false, Finding 1. |
| U3 | $\mathfrak h\neq 0$, i.e. $K$ is not finite | H4's parameter $r$ would be $0$ while $P\neq0$. Flagged, not exhibited (Finding 8, withdrawn). |
| U4 | $\mathfrak g=\mathfrak h\oplus\mathbb R^n$ is semisimple (no flat factor) | the Casimir normalisation $\operatorname{Cas}_{\mathfrak h}\vert_{\mathfrak p}=\tfrac12$ used in the closed form fails. |
| U5 | $\mathfrak h$ simple, or its simple factors interchanged by $K$ | $A=\sum_\alpha\gamma_\alpha r_\alpha$ is not $\gamma r$; the closed form is then false, Finding 1's mechanism. |
| U6 | $\ker W=0$ | zero-padding produces $\ker\tilde W\neq0$ and breaks both H5 and the closed form, Finding 2. |
| U7 | $n$ even, for the maximiser clause | $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ does not exist for odd $n$, Finding 6. |

## 2. Imported-theorem checks

**Principle of symmetric criticality (Palais).** Hypotheses: a compact group (or proper action) acting by isometries on a Riemannian manifold $M$, an invariant smooth $f$, and the fixed set $M^G$. Checked against the object here:

- $M=$ unit sphere of $\mathcal W_n$, $K$ acts by isometries because the $SO(n)$-action on $\operatorname{Sym}^2(\Lambda^2)$ preserves $\langle\cdot,\cdot\rangle$. ✓
- $f=P$ is $O(n)$-invariant because $Q$ is equivariant. ✓
- Compactness: supplied by U1. ✓ (correctable, see above)
- $M^K$ = unit sphere of the linear subspace $\mathcal W_n^K$. Under H3 this is $\{\pm W_0\}$, zero-dimensional.

I do not in fact need Palais here; the one-line direct argument is stronger and avoids the citation. $\nabla(P\vert_M)(W_0)=3\operatorname{proj}_{\mathcal W_n}Q(W_0)-\lambda W_0$ lies in $T_{W_0}M=W_0^{\perp}\cap\mathcal W_n$ and is $K$-invariant (equivariance of $Q$ and of the projection), hence lies in $\mathcal W_n^K\cap W_0^\perp=0$ under H3. **So H3 alone gives criticality.**

**Bianchi $\leftrightarrow$ symmetric pair.** The classical correspondence I used: for $\mathfrak h\subseteq\mathfrak{so}(n)$, $\pi_{\mathfrak h}\in\operatorname{Sym}^2(\Lambda^2)$ satisfies the first Bianchi identity iff $\mathfrak g:=\mathfrak h\oplus\mathbb R^n$ with $[x,y]:=-\pi_{\mathfrak h}(x\wedge y)$ for $x,y\in\mathbb R^n$ satisfies Jacobi, i.e. iff $(\mathfrak g,\mathfrak h)$ is an orthogonal symmetric pair with $\mathfrak h$ the holonomy. This is standard symmetric-space theory; I verified it internally rather than from a paper, by re-deriving the two consequences it predicts and checking them on four independent examples in §3, Finding 5. Two of those checks are recorded there: $C=\sum_{p,q,t\in\mathfrak m}c_{pqt}^2=0$ for the balanced product, which is exactly $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$; and $\gamma=2(n-2)$ for $\mathfrak h=\mathfrak{so}(n)$, matching $\operatorname{id}^{\#}=(n-2)\operatorname{id}$.

**Lemma L23 (the cap $r\le n(n-2)/4$).** Not supplied in this brief and not read (record files are out of bounds). Its conclusion is load-bearing for the maximiser claim and is recorded as hypothesis-debt in Finding 7. I did check that the cap survives the obvious attacks: $\mathbb{CP}^{n/2}$ has $r=n^2/4>n(n-2)/4$ but is excluded by H2; $S^{n-1}\times S^1$ has $r=\binom{n-1}2$ but has $\dim\mathcal W^K=0$; real Grassmannians and $SU(m)/SO(m)$ fall far below.

**$\operatorname{id}^{\#}=(n-2)\operatorname{id}$** and $Q(\mathcal W_n)\subseteq\mathcal W_n$ (asserted in the README). I independently confirmed the second on the balanced product: $\operatorname{tr}(W^{\#})=-\tfrac{(n-1)(n-2)}2=-\lVert W\rVert^2$, so $\operatorname{tr} Q(W)=0$. ✓

## 3. Findings

Every finding below carries the three-step record: (i) independent re-derivation, (ii) concrete closed-form failure, (iii) strongest defence.

### The re-derivation all findings rest on

Let $W=a\pi+b(I-\pi)$. In an adapted orthonormal basis of $\Lambda^2$ with totally antisymmetric structure constants $c_{\alpha\beta\gamma}$,

$$\langle W,W^{\#}\rangle=\tfrac12\sum_{\alpha\gamma\delta}c_{\alpha\gamma\delta}^2\,w_\alpha w_\gamma w_\delta=\tfrac12\big(Aa^3+Bab^2+Cb^3\big),$$

where $A$ sums over triples inside $\mathfrak h$, $B$ over triples with exactly one $\mathfrak h$-index, $C$ over triples inside $\mathfrak m=\mathfrak h^{\perp}$; triples with exactly two $\mathfrak h$-indices vanish because $\mathfrak h$ is a subalgebra. From $\operatorname{id}^{\#}=(n-2)\operatorname{id}$: $A+B+C=2(n-2)N$ and $A+B/3=2(n-2)r$. Eliminating,

$$2\langle W,W^{\#}\rangle=A\,(a-b)^2(a+2b)+2(n-2)\big(3rab^2+(N-3r)b^3\big).$$

Trace-freeness gives $b=-ra/s$. Normalising $a=1$ and writing $A=\gamma r$:

$$\lVert W\rVert^2=\frac{rN}{s},\qquad P=\frac{rN}{2s^3}\Big(2s(s-r)+\gamma N(s-2r)+4(n-2)r^2\Big).$$

So $\theta$ depends on $\mathfrak h$ through the single extra invariant $\gamma$, the Casimir constant of $\mathfrak h$ on its own adjoint module with respect to the metric induced from $\Lambda^2$, and the coefficient $(a-b)^2(a+2b)$ of $A$ vanishes only when $N=3r$. **The closed form is therefore equivalent to the single scalar identity $\gamma=\gamma_{\mathrm{req}}(n,r)$**, and the whole question is whether $\gamma$ is a function of $(n,r)$.

### Finding 5 (positive), the closed form is a theorem on the isotropy-irreducible subfamily, not a fit

(i) **Re-derivation.** Under H2, $\pi_{\mathfrak h}$ satisfies Bianchi, so $\mathfrak g=\mathfrak h\oplus\mathfrak p$ is a symmetric pair. Two Casimir computations, both with respect to the metric $q$ induced on $\mathfrak h$ from $\Lambda^2$, which satisfies $q(h,h)=-\tfrac12\operatorname{tr}_{\mathfrak p}(\operatorname{ad}_h^2)$:

- $\operatorname{Cas}^q_{\mathfrak h}\vert_{\mathfrak p}=2r/n$, forced by $\operatorname{tr}\operatorname{Cas}=2r$ and Schur (needs U2).
- $\operatorname{Cas}^{-\kappa_{\mathfrak g}}_{\mathfrak h}\vert_{\mathfrak p}=\tfrac12$, the standard symmetric-space fact (needs U4). Verified on $S^n=SO(n+1)/SO(n)$: $\operatorname{Cas}$ with respect to $-\operatorname{tr}$ is $\tfrac{n-1}2$, and $-\kappa_{\mathfrak{so}(n+1)}=-(n-1)\operatorname{tr}$, giving $\tfrac12$. ✓

Hence $q=\sigma\,(-\kappa_{\mathfrak g}\vert_{\mathfrak h})$ with $\sigma=n/(4r)$, and with $c=\kappa_{\mathfrak h}/\kappa_{\mathfrak g}\vert_{\mathfrak h}$ one gets $\gamma=4rc/n$. Independently, $q=\tfrac12(-\kappa_{\mathfrak g}\vert_{\mathfrak h}+\kappa_{\mathfrak h})$ gives $\gamma=2c/(1-c)$. Eliminating $c$:

$$\boxed{\;c=1-\frac{n}{2r},\qquad \gamma=\frac{2(2r-n)}{n}\;}$$

Checked on four independent cases: $\mathfrak{so}(n)\subset\Lambda^2\mathbb R^n$ ($r=N$, $\gamma=2(n-2)$ ✓); $\mathfrak{su}(3)$ on $\mathbb R^8$ ($\gamma=2$ ✓); $\mathfrak{so}(3)$ on $V_5$ inside $\mathfrak{su}(3)$, i.e. $SU(3)/SO(3)$ ($\gamma=2/5$ ✓, via $\kappa_{\mathfrak{so}(3)}/\kappa_{\mathfrak{su}(3)}=1/6$); $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ ($\gamma=2(m-2)=n-4$ ✓).

Substituting $\gamma=2(2r-n)/n$ into the $P$ formula and clearing $n$, using $n^2=2N+n$:

$$4rN^2-12r^2N-2nN^2+6nrN \;=\; 2(2r-n)N(N-3r),$$

an identity. So $P=\dfrac{2r^2N^2}{n s^2}$ and $\theta=\dfrac2n\sqrt{\dfrac{rN}{N-r}}$ exactly.

Two corollaries worth recording. For every bi-invariant metric on a compact simple group, $r=n$ and $\gamma=2$ uniformly, and $\gamma_{\mathrm{req}}(n,n)=2$ identically in $n$, so the entire Lie-group subfamily is covered by one line, with no per-example work. And for $r=n(n-2)/4$ the formula gives $\theta^2=2(n-1)(n-2)/n^2=\theta_0(n)^2$ on the nose.

(ii) **Where it nevertheless fails.** Only outside U2/U4/U5, see Findings 1 and 2.

(iii) **Defence of the criticism that it is a fit.** "Checked against held-out spaces it was never fitted to" is the language of fitting, and on its face invites Finding 3 of the brief. It is however an understatement: the formula is derivable, and the derivation is the one above. The entry's failure here is presentational, not mathematical.

**Verdict on this item: the closed form is PROVEN on the subfamily $\{U2, U4, U5\}$.**

### Finding 1, "every member has just two eigenvalues" is FALSE; closed form fails on genuine members

(i) **Re-derivation of the eigenvalue count.** If $\Lambda^2$ is multiplicity-free with $m_2$ irreducible summands and $\mathbb R^n$ with $m_1$, then $\dim\operatorname{Sym}^2(\Lambda^2)^K=m_2$ (each real/complex/quaternionic irreducible contributes exactly $1$ to the symmetric invariants, since $J,i,j,k$ are skew), $\dim(\operatorname{Sym}^2_0\mathbb R^n)^K=m_1-1$, and

$$\dim\mathcal W_n^K=m_2-m_1-\dim(\Lambda^4\mathbb R^n)^K .$$

Under H2 and H3 this reads $m_2=m_1+1$. The invariant $W$ therefore has $m_2=m_1+1$ eigenvalues. Two eigenvalues holds **iff $m_1=1$**, i.e. iff $\mathbb R^n$ is $K$-irreducible, which is U2 and is not stated.

(ii) **Concrete failure.** Take $K=SO(3)\times SO(5)$ on $\mathbb R^8=\mathbb R^3\oplus\mathbb R^5$, the isotropy of $S^3\times S^5$.

- $(\Lambda^4\mathbb R^8)^K=0$: the summands of $\Lambda^4(\mathbb R^3\oplus\mathbb R^5)$ are $\Lambda^3\mathbb R^3\otimes\mathbb R^5$ (no $SO(5)$-invariant vector), $\Lambda^2\otimes\Lambda^2$ (no $SO(p)$-invariant $2$-form), and $\Lambda^4\mathbb R^5\cong\mathbb R^5$ (no invariant). H2 holds. ✓
- $m_1=2$, and $\Lambda^2\mathbb R^8=\Lambda^2\mathbb R^3\oplus\Lambda^2\mathbb R^5\oplus(\mathbb R^3\otimes\mathbb R^5)$ gives $m_2=3$, so $\dim\mathcal W_8^K=3-2-0=1$. H3 holds. ✓
- So $W$ is a critical point by the generator, and is a genuine member of the family as the entry defines it.
- Its three eigenvalues are distinct. With $R=\pi_1+\pi_2$ of eigenvalues $(1,1,0)$ and $\operatorname{Ric}$-correction proportional to $(2(p-1),2(q-1),p+q-2)=(4,8,6)$, the Weyl eigenvalues are $W_i=R_i-\kappa u_i+C$ with $\kappa>0$: $W_1-W_2=4\kappa\neq0$, $W_1-W_3=1+2\kappa\neq0$, $W_2-W_3=1-2\kappa\neq0$ for $\kappa=\tfrac1{2(n-2)}=\tfrac1{12}$. **Three distinct eigenvalues.**
- The closed form fails. Here $\mathfrak h=\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ has $\gamma_\alpha=2(p-2)$ per factor, so $A=2\cdot1\cdot3+2\cdot3\cdot10=66$ and $A/r=66/13$, whereas $\gamma_{\mathrm{req}}=2(2r-n)/n=2(26-8)/8=9/2$. Since $66/13\neq 9/2$ ($132\neq117$), $\theta\neq\tfrac2n\sqrt{rN/(N-r)}$. The single-$\gamma$ step (U5) is exactly what breaks: $\mathfrak h$ has two simple factors with different index ratios and no symmetry exchanging them.
- The same construction lands **inside the target range**: $S^5\times S^7$, $n=12$, $r=31$, $A=2\cdot3\cdot10+2\cdot5\cdot21=270$, $A/r=270/31$ against $\gamma_{\mathrm{req}}=2(62-12)/12=25/3$; $810\neq775$.

(iii) **Defence.** One could argue "member" was only ever meant to denote the isotropy-irreducible and group cases actually listed, in which case H5 is a true observation about those. But the sentence is "Every member has just two eigenvalues, giving the closed form…", quantified over the family the two hypotheses define, and $S^3\times S^5$ and $S^5\times S^7$ satisfy both hypotheses. One could also try to exclude them by demanding $\mathfrak h$ simple, but that would eject $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, the claimed maximiser, so the repair is not available. The correct repair is U2.

### Finding 2, zero-padding contradicts both H5 and the closed form

(i) **Re-derivation.** Let $W\in\mathcal W_8$ be the $SU(3)$ member and $\tilde W\in\mathcal W_{12}$ its extension by zero. $\tilde W$ is a legitimate element of $\mathcal W_{12}$ (Bianchi and $\operatorname{Ric}$ are block-local) and $\theta(\tilde W)=\theta(W)$, so the *value* does persist. It also remains critical, but for a reason the entry does not give: $\tilde W^{\#}=\widetilde{W^{\#}}$ because $c_{\alpha\gamma\delta}\neq0$ with $\gamma,\delta\in\mathfrak{so}(8)$ forces $\alpha\in\mathfrak{so}(8)$, and $\operatorname{Ric}(Q(W))=0$ makes the $\mathcal W_{12}$-projection block-local too.

(ii) **Concrete failure of the stated mechanism and of the closed form.**

- **The generator no longer applies.** $\tilde K=SU(3)\times SO(4)$ has $(\Lambda^4\mathbb R^{12})^{\tilde K}\ni \mathrm{vol}_{\mathbb R^4}\neq0$, so H2 fails outright. And $\mathcal W_{12}^{\tilde K}$ contains both $\tilde W$ and the independent "$S^8\times S^4$-type" invariant built from the splitting, so $\dim\mathcal W_{12}^{\tilde K}\ge2$ and H3 fails too. "Zero-padding preserves everything" is false as stated: it preserves the *conclusion* while destroying *both hypotheses*.
- **H5 fails.** $\tilde W$ has eigenvalues $1$ (on $\mathfrak{su}(3)$, $\dim 8$), $-2/5$ (on $\mathfrak m\subset\Lambda^2\mathbb R^8$, $\dim 20$) and $0$ (on the remaining $38$ dimensions). Three values, with $\ker\tilde W\neq0$.
- **The closed form fails.** The true value is $\theta=\sqrt{7/10}$, preserved by padding. The formula at $n=12$, $r=\dim\mathfrak{su}(3)=8$, $N=66$ gives $\theta=\tfrac16\sqrt{8\cdot66/58}=\tfrac16\sqrt{264/29}$, and $\tfrac1{36}\cdot\tfrac{264}{29}=\tfrac{264}{1044}=\tfrac{22}{87}\neq\tfrac7{10}$ (since $220\neq609$). So on padded members $\theta$ is not a function of $(n,r)$ at all.

(iii) **Defence.** The strongest reading is that the closed form is asserted only for unpadded members and padding is a separate, value-preserving operation. That reading is coherent and is what I would write in the repair. But it is not what the entry says, the padding sentence sits between the criticality claim and the "Every member…" sentence, and the following paragraph then derives the family maximum from the closed form applied to "the family". If padded members are members, "$\theta$ increases with $\dim\mathfrak h$" is not even a well-posed statement about the family, and the maximiser argument does not close.

### Finding 3, "None is coordinate-diagonalizable" contradicts "the balanced sphere product is itself a member"

(i) **Re-derivation.** For $S^m\times S^m$ ($n=2m$) the curvature operator $R=\pi_1+\pi_2$ is diagonal in the basis $\{e_i\wedge e_j\}$. Because $p=q$, $\operatorname{Ric}=(m-1)g$ is a multiple of the metric, so $\operatorname{Ric}_0=0$ and $W=R-\tfrac{\tau}{2n(n-1)}\,g\owedge g$ differs from $R$ by a multiple of the identity. Hence $W$ is diagonal in $\{e_i\wedge e_j\}$.

(ii) **Concrete failure.** $S^m\times S^m$ for every $m\ge3$ is simultaneously (a) asserted to be a member and the family's maximiser, and (b) covered by "None is coordinate-diagonalizable". Both cannot hold. The entry itself supplies the $m=3$ instance and calls it "the lone exception", but the exception is not lone: it is the whole balanced series.

(iii) **Defence.** "None" plausibly ranges over the *listed* examples, bi-invariant metrics on compact simple groups and isotropy-irreducible symmetric spaces with $b_4=0$, of which $S^m\times S^m$ ($m\ge4$) is neither, being neither a simple group nor isotropy-irreducible in the usual sense. Under that reading the sentence is defensible and $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ genuinely is the lone exception among groups. But the second paragraph then asserts the balanced product *is* a member, and the two sentences are two lines apart with no scope marker between them. The quantifier is stated over "every member" / "none", and read that way it is false.

### Finding 4, $(\Lambda^4\mathbb R^n)^K=0$ does nothing for criticality; it is the cap that needs it

(i) **Re-derivation.** §2 shows H3 alone yields criticality: the invariant gradient lies in $\mathcal W_n^K\cap W_0^{\perp}=0$. H2 is nowhere used.

(ii) **Concrete demonstration that H2 is not idle overall.** $\mathbb{CP}^{m}$, $n=2m$, $K=U(m)$: $\Lambda^2\mathbb R^{2m}=\mathbb R\omega\oplus\mathfrak{su}(m)\text{-part}\oplus[\Lambda^{2,0}]$ gives $m_2=3$, $m_1=1$, $\dim(\Lambda^4)^{U(m)}\ni\omega\wedge\omega$ gives $1$, so $\dim\mathcal W^{K}=3-1-1=1$, **H3 holds, H2 fails**, and $r=\dim\mathfrak u(m)=n^2/4>n(n-2)/4$. Without H2 the cap in the second paragraph is immediately violated. So H2's real job is to exclude the Kähler and quaternionic-Kähler holonomies, which is the content of Lemma L23, not of the criticality claim.

(iii) **Defence.** One can argue H2 is stated as part of the *family's* definition rather than as a criticality hypothesis, and the sentence merely lists the defining conditions. Fair, but the sentence is "If $K$ satisfies $(\Lambda^4)^K=0$ and $\dim\mathcal W_n^K=1$, the $K$-invariant $W$ is a critical point automatically, by equivariance", which attributes both conditions to the criticality conclusion. The honest form separates them: H3 gives criticality; H2 defines the family and drives the cap.

### Finding 6, the maximiser clause is even-$n$ only

(i) **Re-derivation.** $\dim(\mathfrak{so}(m)\oplus\mathfrak{so}(m))=2\binom m2=m(m-1)$, and with $m=n/2$ this is $n(n-2)/4$ ✓, confirming the cap value is attained, when $n$ is even.

(ii) **Concrete failure.** For odd $n$ there is no $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, so the cap $n(n-2)/4$ (which is not even an integer for odd $n$: $n(n-2)$ is odd) is not attained, and "the balanced sphere product is itself a member and the family's maximiser" is vacuous. The nearest members $\mathfrak{so}(\lceil n/2\rceil)\oplus\mathfrak{so}(\lfloor n/2\rfloor)$ fall foul of Finding 1 anyway ($p\neq q$ gives three eigenvalues). Since the programme's goal is stated for all $n\ge12$, odd $n$ is inside the range of interest.

(iii) **Defence.** The result under review is about a family and its internal maximum, not about the global conjecture, and $\theta_0(n)$ is itself usually taken at the balanced split, so odd $n$ is a known separate case throughout the programme. This is a scope omission rather than an error.

### Finding 7, the cap is hypothesis-debt within this entry

(i) The monotonicity "$\theta$ increases with $\dim\mathfrak h$" is elementary and correct *given* the closed form: $r\mapsto rN/(N-r)$ is strictly increasing on $(0,N)$.

(ii) But the closed form is unbounded as $r\to N$, at $r=N-1$ it would give $\theta\approx 2N/n\approx n$, far above any achievable value of a cubic form on the unit sphere. The formula therefore carries **no internal bound at all**; the entire maximiser claim rests on the external cap $r\le n(n-2)/4$, i.e. on Lemma L23, which is cited and not given here. I checked the obvious escapes (Finding 4's $\mathbb{CP}$, $S^{n-1}\times S^1$ with $\dim\mathcal W^K=0$, Grassmannians, $SU(m)/SO(m)$, the group case $r=n$) and found none, so the cap is plausible; but it is not established by anything in this entry.

(iii) **Defence.** The entry explicitly says "Lemma L23 proves both statements", so it does not claim self-containment. The debt is honestly flagged there; I record it because the entry is being audited as a standalone result.

### Finding 8, WITHDRAWN: $r\to0$ / finite $K$

Candidate: if $K$ is finite then $\mathfrak h=0$, the closed form gives $\theta=0$, and the derivation's identification of $\mathfrak h$ with one of the two $\Lambda^2$-summands collapses, while $P(W)\neq0$ generically. **Withdrawn at step (ii):** I could not exhibit a finite $K\subset SO(n)$ with $\dim\mathcal W_n^K=1$ and $(\Lambda^4)^K=0$ in closed form, the requirement $m_2=m_1+1$ is very restrictive for finite groups, whose representations on $\mathbb R^n$ typically split into many summands. Recorded so the next verifier does not repeat the attempt: the obstruction is constructing the group, not the argument.

## 4. Verdict

**GAP.**

What survives, and I would sign:

- The criticality generator is **correct, with a hypothesis correction**: $\dim\mathcal W_n^K=1$ alone (plus $K$ compact, free by closure) forces criticality. $(\Lambda^4\mathbb R^n)^K=0$ plays no part in it.
- The closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$ is a **theorem, not a fit**, on the subfamily where $\mathbb R^n$ is $K$-irreducible, $\mathfrak h\oplus\mathbb R^n$ is a semisimple symmetric pair, and $\mathfrak h$ has a single Casimir constant. The proof is the $\gamma=2(2r-n)/n$ computation in Finding 5; it covers every bi-invariant metric on a compact simple group in one line, and returns $\theta_0(n)$ exactly at $r=n(n-2)/4$.
- Monotonicity in $r$ is correct given the closed form.

What is broken as written:

| Claim | Status |
|---|---|
| "Every member has just two eigenvalues" | **false**, $S^3\times S^5$ ($n=8$), $S^5\times S^7$ ($n=12$) |
| closed form holds on the family the hypotheses define | **false**, same counterexamples, and padded members |
| "zero-padding preserves everything" | **false**, destroys both H2 and H3, gives three eigenvalues and $\ker\tilde W\neq0$, and the closed form gives $\tfrac1{36}\cdot\tfrac{264}{29}$ against the true $\tfrac7{10}$ |
| "None is coordinate-diagonalizable" | **false** on the stated quantifier, $S^m\times S^m$, $m\ge3$, is diagonal, and is asserted to be a member |
| $(\Lambda^4)^K=0$ contributes to criticality | **idle** for that conclusion; essential for the cap ($\mathbb{CP}^{n/2}$ has $r=n^2/4$) |
| "the balanced sphere product … the family's maximiser" | **even $n$ only** |
| cap $=n(n-2)/4$ | **hypothesis-debt**, Lemma L23 not supplied here; the closed form supplies no bound of its own |

The minimal repair: state U2 (isotropy-irreducible), U4 (semisimple $\mathfrak g$) and U5 (uniform Casimir) as hypotheses of the closed form; separate H2 from the criticality claim and attach it to the cap; restrict the diagonalizability sentence explicitly to the group and isotropy-irreducible members; and treat padding as a value-preserving operation *outside* the closed form's domain rather than inside the family.
