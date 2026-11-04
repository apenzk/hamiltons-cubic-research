# VERIFY v106, L4's generator criterion, its two-eigenvalue clause, the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$, and the "none is coordinate-diagonalizable" clause

**Verifier v106, round [L04](ROUND_L04b.md), cold brief.** The text checked is the block quoted in the round file under "The brief as dispatched", which is [ungraded-slack.md](../findings/ungraded-slack.md):119 and :121 verbatim, together with the canonical form at [results.md](../results.md):116. **No numerical work was done**: no script was run, and every number below is an exact hand evaluation of a closed form, given as a rational or a surd before any decimal. Log: [agent_logs/verify-L04-v106.log](../agent_logs/verify-L04-v106.log).

## Claim table

| # | claim, as written | verdict |
|---|---|---|
| C1 | $(\Lambda^4\mathbb R^n)^K=0$ **and** $\dim\mathcal W_n^K=1$ $\Rightarrow$ the $K$-invariant $W$ is critical | **PROVEN, hypotheses corrected** |
| C2 | "Every member has just two eigenvalues" | **BROKEN** |
| C3 | closed form $P/\lVert W\rVert^3=\tfrac2n\sqrt{rN/(N-r)}$ | **PROVEN** on the Casimir family with $0<r<N$; **BROKEN** as written over "every member" |
| C4 | "None is coordinate-diagonalizable … the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$" | **BROKEN** |
| C5 | "for the Lie-group members that is proven rather than numerical" | **HYPOTHESIS-DEBT** |
| C6 | the family's maximum is $r=n(n-2)/4$ at $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ | **PROVEN, hypotheses corrected** ($n$ even) |
| C7 | "members with **simple** isotropy … top out far below at $0.8367$" | **BROKEN** |
| C8 | [results.md](../results.md):116, "a new, **provably non-diagonalizable** family" | **BROKEN** |

**Summary.** The criterion is true and its written proof uses one of its two hypotheses; the closed form is genuinely derived on file and I reproduced the derivation by hand; and four of the block's surrounding clauses are false at objects the record itself names, including at the family's own stated maximiser, whose $\Pi_{\mathfrak h}$ is a $0/1$ **diagonal** matrix in $\{e_i\wedge e_j\}$.

*(sections appended below as they were completed)*

## 0. Conventions, fixed once

- **$\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$**, with the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$, $N=\binom n2$. Structure constants $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ in an orthonormal basis $\{\varphi_a\}$, totally antisymmetric.
- **"Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$**, not diagonal as an operator on $\Lambda^2\mathbb R^n$. This is [conventions.md](../findings/conventions.md):53, and it is the sense every claim below is read in. $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf 1=0\}$ is the vertex-matrix model of that locus ([conventions.md](../findings/conventions.md):37).
- **"Critical point" is $Q(W)=\theta W$** ([conventions.md](../findings/conventions.md):119), with $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$, so $\theta=P(W)$ at $\lVert W\rVert=1$.
- **$\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.**
- **$W_{\mathfrak h}$** is the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, $r=\dim\mathfrak h$; $\mathfrak m=\mathfrak h^\perp$.
- **Every decimal below is the decimal expansion of a rational or a surd given first.** Nothing was computed by machine.

## 1. The hypothesis inventory

**Hypotheses the dispatched block states.**

| # | hypothesis | where stated | on which object |
|---|---|---|---|
| H1 | $K\subseteq SO(n)$ | :119 | the acting group |
| H2 | $(\Lambda^4\mathbb R^n)^K=0$ | :119 | $K$ |
| H3 | $\dim\mathcal W_n^K=1$ | :119 | $K$ |
| H4 | $r=\dim\mathfrak h$, $N=\binom n2$ | :119 | a member's isotropy subalgebra $\mathfrak h$ |
| H5 | $n$ even | **nowhere**, needed by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ at :121 | the maximiser |
| H6 | $\theta$ monotone in $\dim\mathfrak h$ **at fixed $n$** | :121 states it unqualified | the family |

**Hypotheses of imported results, which the block does not restate.**

| # | hypothesis | imported from | status at the block's objects |
|---|---|---|---|
| I1 | $Q$ is $O(n)$-equivariant | structure constants are $\mathrm{Ad}$-invariant | holds |
| I2 | $\mathcal W_n$ is $Q$-closed | Böhm–Wilking / Fox, noted at [conventions.md](../findings/conventions.md):41(ii) and [problem.md](../findings/problem.md):108 | **asserted, absent from [conventions.md](../findings/conventions.md)'s own table; load-bearing** |
| I3 | $0<r<N$ | [L23](../findings/ungraded-slack.md):130 | **omitted at :119**; the closed form's derivation divides by $u$ and by $v$ |
| I4 | $\mathfrak h$ is a **subalgebra** ($[\mathfrak h,\mathfrak h]\perp\mathfrak m$) | [L23](../findings/ungraded-slack.md):136 | **omitted at :119**; carries both structure-constant identities |
| I5 | $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ assumed | [L23](../findings/ungraded-slack.md):130, "If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then" | supplied by H3 for members |
| I6 | $W_{\mathfrak h}$ has **exactly two** eigenvalues | [L23](../findings/ungraded-slack.md):136, the whole of "Write $u=\dots$ and $v=\dots$ for the two eigenvalues" | **fails on the padded objects the same sentence pair introduces, §5** |
| I7 | $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ | [L23](../findings/ungraded-slack.md):138 "Producing members" | **omitted at :119**, and it is what makes $W_{\mathfrak h}$ Ricci-flat |
| I8 | $\mathfrak h\not\cong\mathfrak m$ as $K$-modules | [L23](../findings/ungraded-slack.md):140 | **omitted at :119** |
| I9 | $(\Lambda^4\mathbb R^n)^K\cong H^4(G/K;\mathbb R)$, needed to read "$b_4=0$" as H2 | **É. Cartan's theorem on invariant forms** | **rests on an unread source**: [references/](../references/) holds no Cartan and no Helgason entry, as [LEDGER.md](../findings/LEDGER.md):1284 itself records |

**Which of them the written argument at :119 uses.** Exactly one: **H3**, together with the two unstated imports I1 and I2. The chain is: $W$ spans $\mathcal W_n^K$; $Q$ is equivariant so $Q(W)$ is $K$-invariant; $Q$ preserves $\mathcal W_n$ so $Q(W)\in\mathcal W_n^K=\mathbb R W$; hence $Q(W)=\theta W$. **H2 enters nowhere in that chain.** H4–H8 belong to the closed form and the maximiser, not to the criterion.

## 2. Pre-registered question 1, which hypothesis the proof uses

**The written argument, in full, is five words.** [ungraded-slack.md](../findings/ungraded-slack.md):119:

> "the $K$-invariant $W$ is a critical point automatically, **by equivariance**, no per-example computation."

**Verdict on C1: PROVEN, hypotheses corrected.** The implication is true, and true from **H3 alone**.

**H2 is unused.** The equivariance chain never mentions $\Lambda^4$. Nor could it: H3 already asserts that $\mathcal W_n^K$ is one-dimensional, and an element of $\mathcal W_n^K$ satisfies the first Bianchi identity **by membership in $\mathcal W_n$**. The only thing a vanishing invariant $4$-form could buy is Bianchi, and Bianchi is already inside H3's hypothesis. So H2 is inert in the stated implication.

**And H2 is not necessary**, by a result the record already holds. Take $K=U(m)\subset SO(2m)$, $m\ge2$. The Kähler form $\omega$ is $U(m)$-invariant, so $\omega\wedge\omega\in(\Lambda^4\mathbb R^{2m})^{U(m)}$ and is nonzero, H2 **fails**. Yet [L28](../findings/nondegeneracy.md):504 records $\dim\mathcal W_{2m}^{U(m)}=1$ with $W_{\mathbb{CP}^m}$ spanning it and critical. So the criterion's conclusion holds at a $K$ violating H2, which settles necessity in the negative. *I read [L28](../findings/nondegeneracy.md) and [REVIEW_r583.md](../reviews/REVIEW_r583.md) before recording this; r583's D4 reaches the same conclusion independently, and my chain above was written before I opened it.*

**What would have to be true for H2 to be necessary.** H3 would have to be **dropped** and replaced by the constructive hypotheses under which one-dimensionality is *derived*, [L23](../findings/ungraded-slack.md):138's "Producing members" paragraph, whose hypotheses are $K$-irreducibility of $\mathfrak h$ and $\mathfrak m$ with $\mathfrak h\not\cong\mathfrak m$ (I8), $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ (I7), and H2. There H2 does real work: it is what places the candidate $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})\in\mathrm{Sym}^2(\Lambda^2)$ inside $\mathcal W_n$ at all. Even in that form H2 is **sufficient-only**, since $U(m)$ again generates a member while violating it.

**So the block states a criterion under a hypothesis that belongs to a different theorem** (the one that produces members) and states neither of that theorem's other two hypotheses (I7, I8). *The most charitable reading:* :119 is a compressed statement of the constructive route, in which case H2 is legitimate but I7 and I8 are **missing**, and I8's absence is not cosmetic, [L23](../findings/ungraded-slack.md):140 records that without it $\mathfrak h\cong\mathfrak m$ forces $r=N/2=n(n-1)/4$, **strictly above** the same block's cap $n(n-2)/4$, so the criterion as written contradicts the cap it is quoted beside. Under either reading H2 is not the hypothesis doing the work.

## 3. Pre-registered question 2, $\Pi_{\mathfrak h}$ at the family's own maximiser

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):119:

> "**None is coordinate-diagonalizable**, and for the Lie-group members that is proven rather than numerical, **the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$**, which is exactly why $S^3\times S^3$ *is* diagonal, so the argument recovers its own boundary case."

and [results.md](../results.md):116:

> "producing a new, **provably non-diagonalizable** family with a closed-form $P$."

**Exhibit, at the family's own stated maximiser.** Let $n=2m$ be even and split $\{1,\dots,n\}=A\sqcup B$ with $A=\{1,\dots,m\}$, $B=\{m+1,\dots,n\}$. Then

$$\mathfrak h=\mathfrak{so}(m)_A\oplus\mathfrak{so}(m)_B=\mathop{\mathrm{span}}\{e_i\wedge e_j:\ i<j,\ \{i,j\}\subseteq A\ \text{or}\ \{i,j\}\subseteq B\},$$
$$\mathfrak m=\mathfrak h^\perp=\mathop{\mathrm{span}}\{e_i\wedge e_j:\ i\in A,\ j\in B\}.$$

Both are **spanned by basis vectors of $\{e_i\wedge e_j\}$**. Hence, in that basis,

$$\Pi_{\mathfrak h}=\mathop{\mathrm{diag}}\big(\underbrace{1,\dots,1}_{\text{within-block pairs}},\ \underbrace{0,\dots,0}_{\text{cross pairs}}\big),$$

a $0/1$ **diagonal** matrix, and therefore

$$W_{\mathfrak h}=c\Big(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\Big)=\mathop{\mathrm{diag}}\big(\underbrace{u,\dots,u}_{r},\ \underbrace{v,\dots,v}_{N-r}\big),\qquad u=c\big(1-\tfrac rN\big),\ v=-c\tfrac rN,$$

is diagonal in $\{e_i\wedge e_j\}$, that is, **coordinate-diagonal**, in exactly the sense [conventions.md](../findings/conventions.md):53 fixes. No computation is involved; it is inspection of a span.

The object is a genuine Weyl operator, so this is not a technicality about a non-member. Its sectional matrix is $K_{ab}=u$ for $a,b$ in the same block and $K_{ab}=v$ for $a,b$ across, with $r=m(m-1)$ and $N=m(2m-1)$, so $\tfrac rN=\tfrac{m-1}{2m-1}$ and $1-\tfrac rN=\tfrac m{2m-1}$. The row sum at $a\in A$ is
$$(m-1)\cdot c\tfrac m{2m-1}\ +\ m\cdot\Big(-c\tfrac{m-1}{2m-1}\Big)=\frac{c}{2m-1}\big[m(m-1)-m(m-1)\big]=0,$$
so $K$ is hollow, symmetric and row-sum-zero: $K\in\mathcal D_n$, the vertex-matrix model of the coordinate-diagonal locus. **The maximiser sits inside $\mathcal D_n$.**

**Named witnesses that are not the block's exception.** $\mathfrak{so}(4)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(8)$, $r=12=\tfrac{8\cdot6}4$; and $\mathfrak{so}(5)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(10)$, $r=20=\tfrac{10\cdot8}4$. Both are members at the cap by the block's own second paragraph, both are coordinate-diagonal by the display above, and neither is $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$.

**Argue the opposite, the most charitable reading the words support.** Two readings were tried.

1. *"Coordinate-diagonalizable" might mean diagonal as an operator on $\Lambda^2\mathbb R^n$ in some basis.* Then every symmetric $W$ qualifies and the claim is vacuous, so this cannot be meant, and [conventions.md](../findings/conventions.md):53 explicitly forbids it: *"not diagonal as an operator on $\Lambda^2\mathbb R^n$ … conflating the two is what makes the diagonal case look liftable."*
2. *The exception clause might be read as naming the balanced tower by its $n=6$ representative.* This is the strongest available reading, and it fails on the words: "the **lone** exception" is a cardinality claim, and $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ is a second one. It also fails on the sentence's own purpose, the exception is offered as the reason "$S^3\times S^3$ *is* diagonal, so the argument recovers its own boundary case", which presents $n=6$ as a boundary rather than as the first term of an infinite tower.

**Verdict on C4 and C8: BROKEN.** "None is coordinate-diagonalizable" is false at every even $n$, and the exception clause understates an infinite family as one case. [results.md](../results.md):116's "provably non-diagonalizable" carries the same defect with no exception clause at all.

**Spillover I checked and record without repairing.** [problem.md](../findings/problem.md):158 already carries the correction (*"Some members are coordinate-diagonalizable), the balanced sphere product is one"*, and then offers a replacement: *"What holds is the weaker statement it was reaching for: their positive eigenspaces contain **no** decomposable bivector at all."* At the same witness the positive eigenspace of $W_{\mathfrak h}$ is $E_u=\mathfrak h$, which contains $e_1\wedge e_2$, a decomposable bivector. **So the replacement statement is false at the very member the same sentence concedes.** It is true of the bi-invariant simple members; it is not true of the family. *This is recorded, not fixed.*

## 4. Pre-registered question 3, is the closed form derived or fitted?

**It is derived, on file, and I reproduced the derivation by hand.** The derivation is [Lemma L23](../findings/ungraded-slack.md):136, three section-headings below the block under review. What follows is my own re-derivation, done before comparing with L23's text.

**Setup.** $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra, $0<r<N$, $W=W_{\mathfrak h}$ with $w_a=u>0$ on $\mathfrak h$ and $w_a=v<0$ on $\mathfrak m$. Tracelessness: $ru+(N-r)v=0$, so $v=-\rho u$ with $\rho=r/(N-r)$.

**The two identities.** In an orthonormal basis, $\sum_{b,c}c_{abc}^2=\kappa=2(n-2)$ for every $a$, and $c_{abc}=0$ whenever $a,b\in\mathfrak h$ and $c\in\mathfrak m$, because $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m$. Splitting the Killing sum by where the indices sit, and writing $S_{\mathfrak{hhh}}$, $S_{\mathfrak{hmm}}$, $S_{\mathfrak{mmm}}$ for the sums of $c_{abc}^2$ over one, two and three $\mathfrak m$-indices:
$$S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r,\qquad 2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r).$$

**The eigen-equation, traced against each projector.** With $(W^\#)_{aa}=\tfrac12\sum_{c,d}c_{acd}^2w_cw_d$, summing $Q(W)_{aa}=\theta w_a$ over $a\in\mathfrak h$ and over $a\in\mathfrak m$:
$$ru^2+\tfrac12\big(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2\big)=\theta ru,\qquad (N-r)v^2+\tfrac12\big(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2\big)=\theta(N-r)v.$$

**Elimination.** Write $\sigma=1+\kappa/2=n-1$. Substituting $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ into the first and $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}$ into the second:
$$S_{\mathfrak{hmm}}(v^2-u^2)=2ru(\theta-\sigma u),\qquad S_{\mathfrak{hmm}}(u-v)=(N-r)(\theta-\sigma v).$$
Dividing the first by the second and using $u+v=u(1-\rho)$, $(N-r)(1-\rho)=N-2r$:
$$-(N-2r)(\theta+\sigma\rho u)=2r(\theta-\sigma u)\ \Longrightarrow\ -N\theta=\sigma u\Big[(N-2r)\tfrac r{N-r}-2r\Big]=-\frac{\sigma urN}{N-r},$$
$$\boxed{\ \theta=\frac{\sigma ur}{N-r}=\frac{(n-1)ur}{N-r}.\ }$$

**Normalisation.** $\lVert W\rVert^2=ru^2+(N-r)v^2=u^2r\cdot\frac{(N-r)+r}{N-r}=\frac{u^2rN}{N-r}=1$, so $u=\sqrt{\frac{N-r}{rN}}$ and
$$\theta=(n-1)\cdot\frac r{N-r}\sqrt{\frac{N-r}{rN}}=(n-1)\sqrt{\frac r{N(N-r)}}=\frac{2}{n}\sqrt{\frac{rN}{N-r}},$$
the last step because $(n-1)/\!\sqrt N\cdot\sqrt{1/(N-r)}\div\big(\tfrac2n\sqrt{N/(N-r)}\big)=\tfrac{n(n-1)}{2N}=1$. **The block's closed form is exactly this.**

**Back-substitution.** $S_{\mathfrak{hmm}}=(N-r)\dfrac{\theta-\sigma v}{u-v}=(N-r)\dfrac{2\sigma\rho u}{uN/(N-r)}=\dfrac{2\sigma r(N-r)}N$, and hence
$$S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=(N-r)\Big[2(n-2)-\frac{4(n-1)r}N\Big],$$
matching L23 term for term. $S_{\mathfrak{mmm}}\ge0$ as a sum of squares gives $r\le\frac{2(n-2)N}{4(n-1)}=\frac{n(n-2)}4$, and at that value $N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{n^2}4$, whence $\theta=\frac2n\sqrt{\frac{n(n-2)}4\cdot\frac{n(n-1)}2\cdot\frac4{n^2}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$.

**Verdict on the derivation: PROVEN.** The closed form is not fitted. It is a two-line consequence of the eigen-equation plus the two Killing splittings, and I obtained it independently.

**But the block does not say so, and its own stated support is agreement at test points.** [ungraded-slack.md](../findings/ungraded-slack.md):119 offers, as the entire justification, *"Every member has just two eigenvalues, giving the closed form … **checked against held-out spaces it was never fitted to**"*, and gives no pointer to L23 for the closed form (the pointer at :121 is for the *maximum*, not for $\theta$). [problem.md](../findings/problem.md):158 is worse, offering *"verified on eight cases and on two held-out spaces"* and nothing else. **A reader of either site is told the support is test-point agreement.** The derivation exists; the two sites that state the formula do not cite it.

**Two hypotheses of the derivation are dropped at :119.** $0<r<N$ (I3), without which $u$ or $v$ vanishes and the elimination divides by zero; and *$\mathfrak h$ is a subalgebra* (I4), which is the whole of $[\mathfrak h,\mathfrak h]\perp\mathfrak m$ and hence of both structure-constant identities. At :119 the symbol $\mathfrak h$ appears only inside "$r=\dim\mathfrak h$", with no statement of what $\mathfrak h$ is.

**Exact checks of the two published values, by hand.**

| space | $n$ | $\mathfrak h$ | $r$ | $N$ | $\theta^2=\tfrac4{n^2}\tfrac{rN}{N-r}$ | $\theta$ | printed |
|---|---|---|---|---|---|---|---|
| $SU(3)$ bi-invariant | $8$ | $\mathfrak{su}(3)$ | $8$ | $28$ | $\tfrac1{16}\cdot\tfrac{224}{20}=\tfrac7{10}$ | $0.8366600\ldots$ | $0.8367$ |
| $SU(6)/Sp(3)$ | $14$ | $\mathfrak{sp}(3)$ | $21$ | $91$ | $\tfrac1{49}\cdot\tfrac{1911}{70}=\tfrac{39}{70}$ | $0.7464230\ldots$ | $0.7464$ |

Both match, and both agree with the [Lean row](../lean/INDEX.md):38, which records $7/10$ and $39/70$ kernel-checked.

## 5. "Every member has just two eigenvalues", and the padded objects the same sentence pair introduces

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):119, two consecutive sentences:

> "… zero-padding preserves everything, so **they persist into $n=12$**. **Every member has just two eigenvalues**, giving the closed form $P/\lVert W\rVert^3=\tfrac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$, $N=\binom n2$ …"

**Exhibit, at the block's own first named example.** Take $W$ the $SU(3)$ bi-invariant member, $n=8$, $\mathfrak h=\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$, $r=8$, $N=28$. Its spectrum is $u=\sqrt{\tfrac{N-r}{rN}}=\sqrt{\tfrac{20}{224}}=\sqrt{\tfrac5{56}}$ with multiplicity $8$ and $v=-\tfrac25 u$ with multiplicity $20$; the norm check is $8\cdot\tfrac5{56}+20\cdot\tfrac4{25}\cdot\tfrac5{56}=\tfrac{40}{56}+\tfrac{16}{56}=1$. Two eigenvalues, as claimed.

Now zero-pad it into $\Lambda^2\mathbb R^{12}$, which the preceding sentence says carries it there unchanged. $\dim\Lambda^2\mathbb R^{12}=66$; $W\oplus0$ acts as $0$ on the $66-28=38$ planes $e_i\wedge e_j$ meeting $\{9,10,11,12\}$. So the padded object's spectrum is
$$\Big\{\ \sqrt{\tfrac5{56}}\ (\times\,8),\quad -\tfrac25\sqrt{\tfrac5{56}}\ (\times\,20),\quad 0\ (\times\,38)\ \Big\},$$
**three** distinct eigenvalues, and $\ker W\ne0$ of dimension $38$.

**And the closed form fails on it, by a factor.** $\mathrm{ad}(\mathfrak{su}(3))$ is a subalgebra of $\mathfrak{so}(12)$ of dimension $8$, so the block's own recipe $r=\dim\mathfrak h=8$, $N=\binom{12}2=66$ gives
$$\theta_{\text{formula}}^2=\frac4{144}\cdot\frac{8\cdot66}{58}=\frac1{36}\cdot\frac{528}{58}=\frac{22}{87},$$
against the value the padding is said to carry unchanged, $\theta^2=\tfrac7{10}$. Cross-multiplying, $22\cdot10=220$ against $7\cdot87=609$: **$\tfrac{22}{87}<\tfrac7{10}$**, i.e. $0.5029\ldots$ against $0.8366\ldots$. The formula understates the value of the object by a third.

The failure is traceable to exactly one place: the derivation in §4 uses $W=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, and the padded object is **not** of that shape in $\mathfrak{so}(12)$, it is the $\mathfrak{so}(8)$-Casimir extended by zero, which has the wrong constant on the $\mathfrak{so}(8)$ block and no negative eigenvalue at all on the padding directions. So the two-eigenvalue premise (I6) is the load-bearing one, and it is the one that padding destroys.

**A second, non-padded candidate the record already holds.** [ungraded-slack.md](../findings/ungraded-slack.md):161 records $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ with **three** eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$ (a seven-dimensional kernel) and :154 states the general principle: *"any graded critical point whose Weyl operator has three or more distinct eigenvalues is not a Casimir."* Whether that point satisfies H2 and H3 for $K=SO(3)\subset SO(6)$ is **not on the record**, so I do not claim it as a member; it is a candidate falsifier the block never evaluates against its own criterion.

**Argue the opposite.** The strongest reading is that "member" means an object of the *Casimir* family, the sense [nondegeneracy.md](../findings/nondegeneracy.md):650 fixes, *"the subalgebra family is exactly the two-eigenvalue points"*, in which case "every member has just two eigenvalues" is true by definition, and the padded objects at $n=12$ are images of members rather than members. **This reading is available and it costs the block its conclusion**: under it, the family has **no** object at $n=12$, and the sentence "they persist into $n=12$" is a claim about objects outside the family, to which neither the two-eigenvalue clause nor the closed form applies. Either the padded objects are members, and both clauses are false on them; or they are not, and the $n=12$ persistence is outside everything the block proves. The block asserts both halves in adjacent sentences and never distinguishes them.

**Verdict on C2: BROKEN.** **Verdict on C3:** the closed form is **PROVEN** on the two-eigenvalue Casimir family with $0<r<N$ and $\mathfrak h$ a subalgebra; it is **BROKEN** as written, where "every member" is made to include the padded objects of the preceding sentence.

## 6. Quantifier order, scope, and the edges of every range

| edge | what the block says | what holds |
|---|---|---|
| **quantifier order** | ":119 fixes $K$ then asserts criticality", correct order, $\forall K\,(\text{H2}\wedge\text{H3}\Rightarrow\exists\theta)$ | sound |
| **"$\theta$ increases with $\dim\mathfrak h$"** (:121) | stated unqualified | **holds at fixed $n$ only**. $\theta^2=\tfrac{2(n-1)}n\cdot\tfrac r{N-r}$, and $r\mapsto \tfrac r{N-r}$ is strictly increasing on $(0,N)$. Across $n$ it fails on the block's own two examples: $r=8$ at $n=8$ gives $\tfrac7{10}$, while $r=21$ at $n=14$ gives $\tfrac{39}{70}=\tfrac{39}{70}<\tfrac{49}{70}$. **Larger $\mathfrak h$, smaller $\theta$.** |
| **$n$ even** | ":121 says the answer is $n(n-2)/4$, attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$", with no parity hypothesis | **needs $n$ even**. At odd $n$, $\mathfrak{so}(n/2)$ does not exist and $n(n-2)/4\notin\mathbb Z$ ($n$ odd $\Rightarrow n(n-2)$ odd), so the cap is not attained and the inequality is strict. [L23](../findings/ungraded-slack.md):134 states this correctly; :121 drops it. |
| **smallest admissible $n$** | unstated | $\mathcal W_n=0$ for $n\le3$, so $n\ge4$. At $n=4$ the cap is $\tfrac{4\cdot2}4=2$ and $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ attains it, $\theta_0(4)=\tfrac{\sqrt{2\cdot3\cdot2}}4=\tfrac{\sqrt3}2$. Nothing in the block breaks here, but nothing in it states a floor either. |
| **$r\to0$** | unstated | $r=0$ gives $W=0$, excluded by $\lVert W\rVert=1$; the derivation divides by $u$ and $v$. The closed form's limit $\theta\to0$ is consistent but is outside its own hypothesis. |
| **$r\to N$** | unstated | $\theta\to\infty$, so the formula alone is unbounded; what stops it is the cap $r\le n(n-2)/4$, and $n(n-2)/4<N=n(n-1)/2$ always. **The cap is not stated at :119 at all**, it appears only at :121, phrased as a statement about the maximiser rather than as a hypothesis on the formula. |
| **$\ker W\ne0$** | ":119 implicitly excludes it via two eigenvalues" | no Casimir member has a kernel ($u,v\ne0$ for $0<r<N$). **Every padded object has one** (dimension $38$ in the $n=8\to12$ case of §5) so the block's own persistence clause populates the family with kernel-carrying objects the closed form cannot see. |

## 7. "Members with **simple** isotropy top out far below at $0.8367$"

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):121:

> "The members with **simple** isotropy, which is where the first enumeration looked, **top out far below at $0.8367$**."

**Exhibit, at a space the block's own membership clause names.** The block admits *"isotropy-irreducible symmetric spaces with $b_4=0$"*. Take the Cayley plane $\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$: $n=\dim=52-36=16$, isotropy $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ acting irreducibly on $\mathbb R^{16}$ by the spin representation, $r=\dim\mathfrak{so}(9)=36$, $N=\binom{16}2=120$. $\mathfrak{spin}(9)$ is **simple**. It is under the cap: $36\le\tfrac{16\cdot14}4=56$. Its value:
$$\theta^2=\frac4{256}\cdot\frac{36\cdot120}{120-36}=\frac1{64}\cdot\frac{4320}{84}=\frac1{64}\cdot\frac{360}7=\frac{45}{56},\qquad \theta=\sqrt{\tfrac{45}{56}}=\tfrac34\sqrt{\tfrac{10}7}=0.8964214\ldots$$
Against the stated ceiling $\theta^2=\tfrac7{10}$: cross-multiplying, $45\cdot10=450$ against $7\cdot56=392$, so $\tfrac{45}{56}>\tfrac7{10}$ **exactly**, with no decimal step. The ceiling is exceeded by a simple-isotropy member, by $0.0598$ in $\theta$.

**One hypothesis of this witness rests on an unread source.** Reading "$b_4=0$" as H2 uses É. Cartan's theorem identifying $(\Lambda^4\mathbb R^n)^K$ with $H^4(G/K;\mathbb R)$ for a compact symmetric space. **[references/](../references/) holds no Cartan and no Helgason entry**, [LEDGER.md](../findings/LEDGER.md):1284 records exactly this: *"Cartan's classification is cited to no source anywhere … four findings files appeal to it bare."* So the witness's H2, and equally the block's own *"isotropy-irreducible symmetric spaces with $b_4=0$ qualify"*, rest on a source nobody here has read. **This cuts both ways and does not save the clause**: the same unread theorem is what admits the members the ceiling is a ceiling over, so the ceiling and its counterexample stand or fall together.

**Argue the opposite.** The charitable reading is that "the first enumeration" ranged only over bi-invariant metrics on compact simple groups, where $\mathfrak h=\mathrm{ad}(\mathfrak g)$ and $r=n$, so $\theta=\tfrac2n\sqrt{\tfrac{n(n-1)}{n-3}}$, decreasing in $n$ from its smallest case $n=8$ ($\mathfrak{su}(3)$), giving $\tfrac7{10}$ as that sub-population's genuine maximum. **On that reading the sentence is true and says something much narrower than it claims**, and [problem.md](../findings/problem.md):158 states it honestly, *"the maximum over members with $\mathfrak h$ **simple**, which is where the enumeration looked"*, while :121 keeps the qualifier "which is where the first enumeration looked" as a parenthetical **about the history of the search** rather than as a restriction on the quantifier. A consumer reads "members with simple isotropy top out at $0.8367$", which is a claim over all of them.

**Verdict on C7: BROKEN**, with $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ the witness. *[REVIEW_r584.md](../reviews/REVIEW_r584.md) and the Gate-2 box at [ungraded-slack.md](../findings/ungraded-slack.md):108 record the same witness and the same value; I derived $\tfrac{45}{56}$ from the closed form before reading either.*

## 8. "For the Lie-group members that is proven rather than numerical"

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):119, the continuation of the non-diagonalizability clause.

**What is on file.** The clause claims a *proof* of non-diagonalizability for the bi-invariant simple members. I searched [findings/](../findings/), [results.md](../results.md) and the reviews the record cites for L4 ([r583](../reviews/REVIEW_r583.md), [r584](../reviews/REVIEW_r584.md), [r25](../reviews/REVIEW_r25.md), [r491](../reviews/REVIEW_r491.md), [r492](../reviews/REVIEW_r492.md), [r153](../reviews/REVIEW_r153.md)). **No argument for it appears at the block, in L23, or in the reviews.** The nearest thing on the record is [problem.md](../findings/problem.md):156, which proves a *different* statement about a *different* object, that Fox's $\mathcal S^4(\alpha)$ is never coordinate-diagonalizable, by a decomposable-bivector rank argument, a gradient-ascent floor and a $U(m)$-eigenvalue argument. None of those three is applied to $\mathrm{ad}(\mathfrak g)\subset\mathfrak{so}(n)$ anywhere on file.

The shape a proof would take is visible, for $\mathfrak h=\mathrm{ad}(\mathfrak g)$ the positive eigenspace consists of the operators $\mathrm{ad}(X)$, whose rank is at least $4$ for $X\ne0$ in a compact simple $\mathfrak g$, so $E_{\max}$ carries no decomposable bivector, and [r583](../reviews/REVIEW_r583.md) gestures at it in one clause of a parenthesis. **I do not supply it and do not count it.** *That is the finding.*

**Verdict on C5: HYPOTHESIS-DEBT.** What would have to be shown: that for every compact simple $\mathfrak g$ with $n=\dim\mathfrak g$, no orthonormal frame of $\mathbb R^n$ diagonalises $W_{\mathrm{ad}(\mathfrak g)}$, equivalently, that $\mathrm{ad}(\mathfrak g)\subset\Lambda^2\mathbb R^n$ contains no $r$-dimensional subspace spanned by decomposable bivectors $e_i\wedge e_j$ of a common frame. **Note that this debt is owed on a clause whose surrounding universal statement is already false (§3)**, so discharging it would repair a sub-case of a broken claim, not the claim.

*A note on what §5 does and does not assume.* My contradiction needs no independent proof that padding preserves criticality: the block itself asserts *"zero-padding preserves everything, so they persist into $n=12$"*, and the contradiction is between that sentence and the next one. For completeness, what the record actually holds on padding is [ungraded-slack.md](../findings/ungraded-slack.md):21 (*"Zero-padding … preserves Ricci-flatness and the first Bianchi identity automatically"*) which establishes membership in $\mathcal W_n$ and nothing about $Q$; the preservation of $\theta$ is recorded there as a residual of $6\times10^{-16}$ at $n=8,10,12$ for a different family. **The clause the block leans on is supported numerically, not analytically, at the one site that argues it.**

## 9. Compare the forms

**Four forms exist. I read all four.**

| form | location | what it carries that the others do not |
|---|---|---|
| **F-slack** | [ungraded-slack.md](../findings/ungraded-slack.md):119, :121 | the full text: criterion, two example values, padding to $n=12$, the two-eigenvalue clause, the closed form, the non-diagonalizability clause with its exception, the maximiser, the $0.8367$ ceiling. **It is the only form carrying any of the four broken clauses' detail.** |
| **F-glance** | [results.md](../results.md):116 | a one-line summary. Carries **"provably non-diagonalizable"** with **no exception clause at all**, strictly worse than F-slack, which at least names one exception. Carries no closed form, no cap, no parity, no examples. |
| **F-statement** | [results.md](../results.md):312 | *a heading and a proof pointer, and nothing else*: `##### Lemma L4, a generator for critical points, and a new family` followed by `**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)`. **The canonical statement entry states no statement.** |
| **F-Lean** | [lean/INDEX.md](../lean/INDEX.md):38, [L4.lean](../lean/HamiltonsCubic/Results/L4.lean) | the two numeric points, exact and kernel-checked: $\theta^2=7/10$ at $SU(3)$, $n=8$ and $39/70$ at $SU(6)/Sp(3)$, $n=14$, both below $3/2$ and below $\theta_0(12)^2$ before and after padding. **Its "Not claimed" line is the record's most accurate statement of the gap**: *"the generator criterion, or the identification of $r$ with $\dim\mathfrak h$"*. |

**A Lean row for L4 exists**, so the "if none exists" branch of the check does not apply. What it does **not** claim is exactly the content §§2–8 examine: the criterion, the identification $r=\dim\mathfrak h$, the closed form as a theorem, the cap, the maximiser, and every diagonalizability clause. **What a row would have to claim to cover this block**: that for $K\subseteq SO(n)$ with $\dim\mathcal W_n^K=1$ the invariant $W$ satisfies $Q(W)=\theta W$, which needs $Q$-closure of $\mathcal W_n$ (I2) formalised first, and that is not in [lean/INDEX.md](../lean/INDEX.md) either.

**The forms disagree, in the direction that matters.** F-glance is the shortest, the most cited, and the *most* wrong: it states the false universal without the exception that at least signals a boundary case. F-statement, the form a reader would go to for the canonical statement, is empty and forwards to F-slack.

## 10. A universal claim with no witness, one object from each named family

The block carries two universals: *"Every member has just two eigenvalues"* and *"None is coordinate-diagonalizable"*. Taking one object from each structured family the record names:

| family the record names | object taken | two eigenvalues? | coordinate-diagonal? |
|---|---|---|---|
| bi-invariant metric on a compact simple Lie group | $\mathfrak{su}(3)$, $n=8$, $r=8$, $\theta^2=\tfrac7{10}$ | **yes**, $u=\sqrt{5/56}$ ($\times8$), $v=-\tfrac25u$ ($\times20$) | not shown either way; §8 records the debt |
| isotropy-irreducible symmetric space, $b_4=0$ | $SU(6)/Sp(3)$, $n=14$, $r=21$, $\theta^2=\tfrac{39}{70}$ | **yes** | not shown either way |
| isotropy-irreducible symmetric space, $b_4=0$ | $F_4/\mathrm{Spin}(9)$, $n=16$, $r=36$, $\theta^2=\tfrac{45}{56}$ | **yes** | not shown; **and it breaks the $0.8367$ ceiling** (§7) |
| **balanced split** | $\mathfrak{so}(4)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(8)$, $r=12$, $\theta=\theta_0(8)=\tfrac{\sqrt{21}}4$ | yes | **YES, $\Pi_{\mathfrak h}$ is $0/1$ diagonal in $\{e_i\wedge e_j\}$ (§3). Witness against "None is."** |
| **balanced split** | $\mathfrak{so}(5)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(10)$, $r=20$, $\theta=\theta_0(10)=\tfrac65$ | yes | **YES. Second witness.** |
| **unbalanced split** | $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$, $r=13$ | yes, as a Casimir | **not a member**: $13>\tfrac{8\cdot6}4=12$, so $S_{\mathfrak{mmm}}<0$ would be forced and the eigen-equation fails. The record's $1.151371$ for it is $P$ at a **non-critical** Casimir; the closed form would give $\theta^2=\tfrac1{16}\cdot\tfrac{364}{15}=\tfrac{91}{60}$, i.e. $1.2315$, which is *not* the recorded value, consistent, since the formula presupposes criticality. |
| **symmetric pair** | $\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subset\mathfrak{so}(12)$, $r=31$ | yes, as a Casimir | **not a member**: $31>\tfrac{12\cdot10}4=30$. Its Casimir is $\mathbb Z_2$-graded and *not* critical; $S^5\times S^7$'s actual critical operator sits at $1.2282390$ ([ungraded-slack.md](../findings/ungraded-slack.md):162) against the formula's $\tfrac2{12}\sqrt{31\cdot66/35}$. **A symmetric pair is critical only *at* the cap** ([ungraded-slack.md](../findings/ungraded-slack.md):144). |
| **padded object** | $SU(3)$'s member padded $n=8\to12$ | **NO, three eigenvalues, $\ker W$ of dimension $38$ (§5)** | inherits $E_{\max}=\mathrm{ad}(\mathfrak{su}(3))$; the kernel adds $38$ coordinate planes it is diagonal on, so the question is unchanged from $n=8$ |

**Two of the eight rows falsify a stated universal, and both are objects the block itself names.** The balanced splits falsify *"None is coordinate-diagonalizable"*; the padded object falsifies *"Every member has just two eigenvalues"* and the closed form with it.

**Edge check on the smallest split.** $\mathfrak{so}(2)\oplus\mathfrak{so}(2)\subset\mathfrak{so}(4)$, $r=2=\tfrac{4\cdot2}4$, $N=6$: $\theta=\tfrac24\sqrt{\tfrac{2\cdot6}4}=\tfrac12\sqrt3=\theta_0(4)$. Coordinate-diagonal by the same display. So the tower of witnesses starts at the smallest admissible $n$.

## 11. The named trap, reading each citable claim alone

**The correction sits at lines 107–115; the claims it corrects sit, verbatim and unmarked, at 119 and 121.** The Gate-2 blockquote refutes four clauses and then leaves all four standing in full below it, with no marker on the sentences themselves. Reading :119 alone, which is exactly what a consumer does, and exactly what this round's own brief did in quoting :119 and :121 under "The brief as dispatched", returns the uncorrected text with every broken clause intact.

**The trap is demonstrable three ways in this record.**

1. **The dispatched brief.** [ROUND_L04b.md](ROUND_L04b.md) quotes :119 and :121 "verbatim, from the current source" and inherits all four defects. The round file knows this ("Phase 0's own finding") and the *file* does not.
2. **[results.md](../results.md):116 carries the defect with no correction anywhere near it.** *"producing a new, provably non-diagonalizable family"*, and unlike :119 it does not even carry the $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ exception. The nearest correction in that file is nine lines below, in **L5's** entry, and corrects a different figure. A reader of the glance list has no signal.
3. **The Gate-2 box is itself incomplete against the reviews it names.** It says *"FOUR CLAUSES … ARE FALSE"*, folding r584's D3, D4, D8, D9 and the D6/D7 quantifiers. **[r584](../reviews/REVIEW_r584.md)'s D5 (the padding-versus-two-eigenvalues inconsistency of §5), is not in the box**, and it is the clause on which the block's own closed form fails by a third at $n=12$. So the record's correction of L4 corrected four of five, and the fifth is the one carrying a wrong number.

**Consequence for the citation chain.** [results.md](../results.md):320 and [graded-half.md](../findings/graded-half.md):69 both cite L4 inside the same sentence of L5, and both consume *"the simple-isotropy members of Lemma L4's family, which top out at $P\le0.837$"*, the clause §7 refutes. A consumer of L5 therefore inherits a refuted bound through a citation to a corrected lemma, because the correction is in a box the citation does not pass through.

## 12. The gap between what is proven and what is used, and what a consumer may cite

**Proven, and citable as written:**

- **The criterion**, in the form: *$K\subseteq SO(n)$ with $\dim\mathcal W_n^K=1$ $\Rightarrow$ the spanning $W$ satisfies $Q(W)=\theta W$ with $\theta=P(W)$*, given that $\mathcal W_n$ is $Q$-closed. **Cite it without $(\Lambda^4\mathbb R^n)^K=0$**, which is inert.
- **The closed form** $\theta=\tfrac2n\sqrt{rN/(N-r)}$, **on the two-eigenvalue Casimir $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $\mathfrak h$ a subalgebra, $0<r<N$, and $W_{\mathfrak h}$ critical.** All four qualifiers are load-bearing.
- **The cap** $r\le n(n-2)/4$ on that family, from $S_{\mathfrak{mmm}}\ge0$; and $\theta\le\theta_0(n)$, with equality iff $S_{\mathfrak{mmm}}=0$.
- **The maximiser**, $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, **at even $n$ only**.
- **The two numeric points**, $\theta^2=7/10$ and $39/70$, which are additionally kernel-checked in [L4.lean](../lean/HamiltonsCubic/Results/L4.lean).

**Used but not proven:**

- **$\mathcal W_n$ is $Q$-closed** (I2). The entire criterion rests on it. It is asserted at [problem.md](../findings/problem.md):108 as a remark on Fox and is absent from [conventions.md](../findings/conventions.md)'s own tables. Not in Lean.
- **$(\Lambda^4\mathbb R^n)^K\cong H^4(G/K;\mathbb R)$** (I9), which is what makes "$b_4=0$" a checkable hypothesis. **Rests on an unread source**, no Cartan or Helgason folder in [references/](../references/).
- **Padding preserves criticality and $\theta$.** Argued on file only for Ricci-flatness and Bianchi; $\theta$-preservation is a numerical residual.

**Not to be cited:**

- *"None is coordinate-diagonalizable"* and *"provably non-diagonalizable"*, false at every even $n$.
- *"Every member has just two eigenvalues"*, false on the padded objects the same paragraph introduces.
- *the closed form at a padded object's ambient $n$*, off by a third at the block's own first example.
- *"members with simple isotropy top out at $0.8367$"*, false at $F_4/\mathrm{Spin}(9)$.
- *"$\theta$ increases with $\dim\mathfrak h$"* without "at fixed $n$", false across the block's own two examples.

## 13. Verdict

**HYPOTHESIS-DEBT**, and four of the eight claims **BROKEN**.

The criterion itself is true and provable from one of its two stated hypotheses, and the closed form is genuinely derived rather than fitted, I reproduced both by hand in §2 and §4. What fails is everything the block asserts *around* them: the universal non-diagonalizability claim is false at the family's own maximiser, at every even $n$, by inspection of a span; the two-eigenvalue clause and the closed form are false on the padded objects the preceding sentence introduces, by a factor of a third at $n=12$; and the simple-isotropy ceiling is false at a space the block's own membership clause admits. The one clause that is neither proven nor refuted (*"for the Lie-group members that is proven rather than numerical"*), has **no argument anywhere on file**, which is the standing debt.

**The debt, stated precisely.** To discharge C5 one must show that for every compact simple $\mathfrak g$ with $n=\dim\mathfrak g$, the subspace $\mathrm{ad}(\mathfrak g)\subset\Lambda^2\mathbb R^n$ contains no $n$-dimensional span of decomposable bivectors $e_i\wedge e_j$ from a common orthonormal frame. Nothing on the record attempts it for this object; the three arguments at [problem.md](../findings/problem.md):156 are proved for Fox's $\mathcal S^4(\alpha)$ and are not transported.

**What would falsify my findings, and what I did to look for it.**

- **Against §3 (C4, C8):** an orthonormal frame of $\Lambda^2\mathbb R^n$ in which $\Pi_{\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)}$ is *not* diagonal would not falsify anything, since diagonality in *one* coordinate frame is the definition. **The object that would falsify it is a definition of "coordinate-diagonalizable" on this record under which the balanced split fails.** I looked: [conventions.md](../findings/conventions.md):53, :37, :108, :114 and :119 all fix the same sense, and :53 explicitly rules out the reading that would save the clause. None exists.
- **Against §5 (C2, C3):** an argument that the padded objects are not members. **That object would be a definition of "member" excluding them**, [nondegeneracy.md](../findings/nondegeneracy.md):650 supplies one (*"the subalgebra family is exactly the two-eigenvalue points"*), and I state in §5 what it costs: the $n=12$ persistence clause then lies outside the family. I found no reading on which both sentences hold.
- **Against §7 (C7):** a reason $F_4/\mathrm{Spin}(9)$ fails a membership hypothesis. **The object would be a nonzero $\mathrm{Spin}(9)$-invariant $4$-form on $\mathbb R^{16}$.** I could not check this against a read source, it turns on Cartan's theorem and on $H^4(\mathbb{OP}^2)$, and [references/](../references/) holds neither, so §7 is recorded with that dependency named, and it is the *same* dependency the block's own membership clause carries.
- **Against §2 (C1):** a step in the equivariance chain that consumes $(\Lambda^4)^K=0$. **The object would be a $K$ with $\dim\mathcal W_n^K=1$ whose invariant $W$ is not critical.** By the chain in §2 none can exist while $\mathcal W_n$ is $Q$-closed, so the search reduces to I2, which is the unproven input named in §12.
