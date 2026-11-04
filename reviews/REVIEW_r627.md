# REVIEW r627, Lemma L101, the $SO(n)$-invariance identity and $P\equiv0$ on $V_{1/2}$

**Verdict: GAP.** The three-term identity, its off-diagonal law $(\lambda-\mu)\theta^*\langle A\!\cdot\!x,y\rangle$ and the orbit-orthogonality $Q(x)\perp T_u(SO(n)\!\cdot\!u)$ all re-derive cold, and the last is **stronger than the block claims**, it is a one-line fact about any metrised commutative algebra with an orthogonal invariance group, needing neither $\mathcal W_n$, nor $\mathbb{CP}^2$, nor criticality. **The fifth clause does not follow.** *"It also gives $P\equiv0$ on $V_{1/2}$"* consumes two inputs the block never names: criticality of $u$ (asserted unused in the sentence immediately before it) and $V_{1/2}\subseteq T_u(SO(n)\!\cdot\!u)$, which is [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(b) at $n\ge9$ and floating point below it. That clause is equivalent to Krasnov–Tkachev's third-order fusion rule, which **the record's own [fence-posts.md](../findings/fence-posts.md) reports failing at $S^3\times S^3$**, so it cannot be a free consequence of an identity that holds at every point. Reviewer r627, cold brief; the concurrent r628 unread.

| attack | outcome |
| --- | --- |
| the three-term identity $T(A\!\cdot\!x,y,z)+T(x,A\!\cdot\!y,z)+T(x,y,A\!\cdot\!z)=0$ | **CONFIRMED**, one differentiation of $SO(n)$-invariance; total symmetry of $T$ is *not* needed here |
| $T$ is the record's invariant trilinear form, totally symmetric | **CONFIRMED**, $T(x,y,z)=\langle x\circ y,z\rangle$, symmetric term by term; **load-bearing twice** below, and used at neither place with a citation |
| the off-diagonal law $(\lambda-\mu)\theta^*\langle A\!\cdot\!x,y\rangle$ | **CONFIRMED**, as $T(x,y,A\!\cdot\!u)=\langle[\mathcal A,F_u]x,y\rangle$, the constant is right **only under the $\theta^*$-normalised eigenvalue labelling** |
| $\lambda$ in the block's own displayed chain | **INCONSISTENT**, *"$F_ux=\lambda x$"* two lines above a display whose $\theta^*$ requires $F_ux=\lambda\theta^*x$; two normalisations of one letter inside one paragraph |
| the polarization factor, does the block commit the $2\times$ error it warns about? | **NO.** The table's $\sqrt{5/6}$ is in the record's own normalisation, pinned independently by [route-a.md:99](../findings/route-a.md#L99). **But the warning itself is off by two**: what it names equals $2T$, so recovering $T$ from it is division by *two* |
| $Q(x)\perp T_u(SO(n)\!\cdot\!u)$, *"every eigenvector in every dimension"* | **CONFIRMED and understated**, holds at every $u$, over any Euclidean space, for any orthogonal invariance group, with $\lambda=0$ included |
| *"with no hypothesis"* | **REFUTED as written**, three: $x$ an $F_u$-eigenvector, $T$ totally symmetric, the action orthogonal |
| *"the argument never uses criticality of $u$"* | **TRUE of the orthogonality, FALSE of the next sentence**, $P\equiv0$ on $V_{1/2}$ needs $Q(u)=\theta^*u$ |
| the degenerate case $\lambda=\mu$ | **not vacuous, it is where the content is**; $T(V_\lambda,V_\lambda,V_{1/2})=0$ for every $\lambda$, and $T\equiv0$ on $T_u\mathcal O^{\times3}$ |
| $P\equiv0$ on $V_{1/2}$ | **GAP**, true at $u$, not proved here; equivalent to KT Proposition 6.7, which fails at $S^3\times S^3$ |
| *"a fifth, separate statement"* | the count resolves (four vanishings $+$ this) but **is nowhere anchored**, and the four are unproven while this one is proven, the sentence reads them as peers |
| *"though it does not tighten the bound"* | **CONFIRMED**, $W_2\perp(\mathbb Ru\oplus T_u\mathcal O)$ by construction, so no $V_{1/2}$ slot ever appears downstream |
| does the identity prove any table vanishing? | **NO, and provably not**, its third slot is confined to $V_{1/2}$, which is orthogonal to every space the table mentions |
| the table's closed forms | **row 1 converted**: $\sqrt{5/6}$ is *equivalent to* $\max\{\lVert Q(x)\rVert:x\in V_{1/3},\lVert x\rVert=1\}=1$, with $\tfrac16=(\theta^*/3)^2$ exact. Rows 5 and 6 restate as projection norms; neither reduces further without a run |
| the near-zero rows | **a theorem is owed and one candidate is missed**, [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Lemma 4.15 is named in this record's own reference notes as the model for row 4 and appears in none of the six dead explanations |
| pointers | **the block has none**, zero links in twenty-six lines, while it cites Remark 4.18, Theorem 4.14, $V_{1/3}$, $V_{1/2}$, $F_u$, $\theta^*$ and $Q$, none of them defined in it |
| the table's rendering | **BROKEN**, [route-a.md:407](../findings/route-a.md#L407) is a paragraph *between* table rows, orphaning the $\sqrt{2/3}$ row at [line 408](../findings/route-a.md#L408) |

No computation was run. The analysis-only rule is inherited and honoured; the one screening allowance was not needed, every check below being closed by hand.

---

## 0. The reading adopted for every symbol

[conventions.md](../findings/conventions.md) is incomplete in exactly the places this block leans on, so each is pinned by use rather than by the table.

| symbol | reading adopted | pinned by |
| --- | --- | --- |
| $T$ | $T(x,y,z)=\langle x\circ y,z\rangle$ with $x\circ y=\tfrac12(Q(x+y)-Q(x)-Q(y))$, so $P(x)=T(x,x,x)$ and $T(x,x,z)=\langle Q(x),z\rangle$. **$T$ is defined nowhere in [findings/](../findings/) or [conventions.md](../findings/conventions.md)** | [route-a.md:97](../findings/route-a.md#L97) ($T(u,u,V)=\theta^*\langle u,V\rangle$) and the cubic expansion at [route-a.md:99](../findings/route-a.md#L99), which fixes the normalisation with no factor free |
| $u$ | the padded $\mathbb{CP}^2$-type competitor, $\lVert u\rVert=1$, $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$ | [route-a.md:182](../findings/route-a.md#L182) |
| $F_u$ | $F_u(h)=\tfrac12(uh+hu)+u\#h=u\circ h$, i.e. $\theta^*L_e$ | [route-a.md:101](../findings/route-a.md#L101), identified with $L_e$ at [route-a.md:197](../findings/route-a.md#L197) |
| $V_\lambda$ | $\ker(F_u-\lambda\theta^*)$, the eigenvalue is $\lambda\theta^*$, the **label** is $\lambda$. **Defined nowhere**; forced by *"$W_1$ in the $\tfrac13\theta^*$-eigenspace"* at [route-a.md:505](../findings/route-a.md#L505), by the seven-value spectrum $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\theta^*$, and by [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py)'s own `ratio = w / SQ32` | [route-a.md:175](../findings/route-a.md#L175) |
| $V_{1/2}$ | that eigenspace at $\lambda=\tfrac12$; it **is** [conventions.md](../findings/conventions.md)'s $A(\tfrac12)=\ker B$ with $B=\tfrac\theta2\mathrm{Id}-L_W$ at $W=u$, since $L_W=F_u$ there. The two names are the same space and the record uses both without saying so |
| $\rho(A)$, $A\!\cdot\!X$ | $\rho(A)=D_A$, the derivation $A$ induces on $\Lambda^2\mathbb R^n$; $A\!\cdot\!X=[\rho(A),X]$ for $X$ an operator on $\Lambda^2$ | [conventions.md](../findings/conventions.md), row $D_A$ |
| $\lVert\cdot\rVert$ | the $\Lambda^2$ half-trace pairing, under which $\lVert u\rVert=1$ and $\mathop{\mathrm{spec}}(u)=(2,-1,-1,0,0,0)/\sqrt6$ | [conventions.md](../findings/conventions.md), *Norms and pairings* |

**Two symbol collisions inside this one block.** $A$ is simultaneously the Lie algebra element of the display, [conventions.md](../findings/conventions.md)'s $A(\tfrac12)=\ker B$ (which is the very space the heading calls $V_{1/2}$) and, forty lines below, the trust-region coupling $A=T(W_1,W_1,K)$ whose value at $t=3/4$ is quoted as $5/6$. And [route-a.md:414](../findings/route-a.md#L414) writes $[A,u]$ where $A$ is $n\times n$ skew and $u$ acts on $\Lambda^2$: a type error, corrected to $[\rho(A),u]$ four lines later in the same paragraph.

---

## 1. The invariance identity, derived

$P$ is $SO(n)$-invariant because $Q$ is equivariant and the pairing is invariant, so its full polarization $T$ is invariant: $T(g\!\cdot\!x,g\!\cdot\!y,g\!\cdot\!z)=T(x,y,z)$ for the action $g\!\cdot\!X=\rho(g)X\rho(g)^{-1}$. Differentiating along $g=\exp(tA)$ at $t=0$ gives the displayed three-term relation, with $A\!\cdot\!X=[\rho(A),X]$. **CONFIRMED**, and it needs only invariance and the chain rule, not symmetry of $T$, not $\mathcal W_n$, not $u$.

**Two facts the block uses without saying it uses them.**

- **The action is orthogonal**, so $\mathcal A:=A\!\cdot\!(\,\cdot\,)$ is skew: $\langle\mathcal Ax,y\rangle+\langle x,\mathcal Ay\rangle=0$. The block calls this *"Frobenius-skew"*, which is right.
- **$T$ is totally symmetric.** Writing $x\circ y=\tfrac12(xy+yx)+x\# y$, the first part pairs to $\tfrac12(\mathop{\mathrm{tr}}(xyz)+\mathop{\mathrm{tr}}(yxz))$, invariant under every transposition by cyclicity; the second to $\sum c_{\alpha\beta\gamma}c_{\alpha'\beta'\gamma'}x_{\alpha\alpha'}y_{\beta\beta'}z_{\gamma\gamma'}$, totally symmetric because $c$ is totally antisymmetric ([conventions.md](../findings/conventions.md), *Structure constants*) and $x,y,z$ are symmetric.

**Where total symmetry is load-bearing here, since the brief asks.** In exactly two steps, both inside the specialisation: it is what makes $F_u$ self-adjoint, and it is what licenses $T(a,b,u)=\langle a\circ b,u\rangle=\langle a,b\circ u\rangle=\langle a,F_ub\rangle$, moving $u$ out of the third slot and into the operator. Delete total symmetry and the identity survives while every consequence below it dies. The block cites it at neither step; [support-dichotomy.md](../findings/support-dichotomy.md) and [LEDGER.md](../findings/LEDGER.md) both record that this same omission cost a cycle in a neighbouring proof.

---

## 2. The specialisation, and where the constant comes from

Set $z=u$ and keep $y$ free:

$$T(x,y,[\rho(A),u])=-T(\mathcal Ax,y,u)-T(x,\mathcal Ay,u)=-\langle\mathcal Ax,F_uy\rangle-\langle\mathcal Ay,F_ux\rangle=\langle[\mathcal A,F_u]x,y\rangle,$$

the last step by skewness of $\mathcal A$. This is the **fully general form, with no eigenvector hypothesis at all**, and it is worth recording in place of the displayed one: $[\mathcal A,F_u]=F_{A\cdot u}$, so the identity is the equivariance $F_{g\cdot u}=gF_ug^{-1}$ differentiated once.

Now take $F_ux=\lambda\theta^*x$ and $F_uy=\mu\theta^*y$:

$$T(x,y,[\rho(A),u])=\lambda\theta^*\langle\mathcal Ax,y\rangle-\mu\theta^*\langle\mathcal Ax,y\rangle=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle .$$

**CONFIRMED exactly as displayed.** Three checks that it is the right constant and not a scaled one:

1. **The hypothesis the display omits is in fact printed**, $(x\in V_\lambda,\;y\in V_\mu)$ sits in the display. **The heading drops it**, and so does [REVIEW_r465.md](REVIEW_r465.md) when it cites the law. That is where the omission actually bites.
2. **The $\theta^*$ is bookkeeping, not content.** It is there only because $V_\lambda$ names the $\lambda\theta^*$-eigenspace. Under the raw labelling the identity reads $(\lambda_F-\mu_F)\langle A\!\cdot\!x,y\rangle$ with no $\theta^*$, **which is what the block's own preceding chain uses**, writing *"$F_u$ is symmetric with $F_ux=\lambda x$"* and then $-2\lambda\langle A\!\cdot\!x,x\rangle$. Both are correct in their own normalisation and they are eleven lines apart under one letter. The conclusion is unaffected because both sides are zero there; the reader is not.
3. **Symmetry test.** $T$ is symmetric in $x,y$ while $(\lambda-\mu)$ is antisymmetric and $\langle\mathcal Ax,y\rangle$ is antisymmetric; the product is symmetric. Passes.
4. **Stabiliser test, which the identity could have failed.** Adding $A_0$ with $A_0\!\cdot\!u=0$ leaves the left side untouched but changes $\langle A\!\cdot\!x,y\rangle$ by $\langle A_0\!\cdot\!x,y\rangle$. Consistency therefore *requires* $\langle A_0\!\cdot\!x,y\rangle=0$ for $\lambda\ne\mu$, and it holds, because $[\mathcal A_0,F_u]=F_{A_0\cdot u}=0$ makes $\mathcal A_0$ preserve every $V_\lambda$. The identity is self-consistent, and the mechanism of the check is the point of §7 below.

**Which $u$, and is criticality used?** Steps 1–4 use no property of $u$ whatever. The orthogonality claim therefore holds at **every** $u\in\mathcal W_n$ and every eigenvector of $L_u=u\circ(\cdot)$, the block's *"never uses criticality"* is correct, and if anything the block understates it: nothing in the argument is about $\mathcal W_n$, about $SO(n)$, or about $\mathbb{CP}^2$. The general statement is

> **Let $T$ be a symmetric invariant trilinear form on a Euclidean space carrying an orthogonal action of a Lie group $G$, $x\circ y$ its product, $u$ any point and $x$ any eigenvector of $L_u$. Then $Q(x)=x\circ x$ is orthogonal to $T_u(G\!\cdot\!u)$.**

which is the form [second-order.md](../findings/second-order.md)'s [Lemma L51](../findings/second-order.md) is already written in, and the form this block should carry.

**The $\theta^*$ does re-enter once, and only for the labelling.** Writing $(\lambda-\mu)\theta^*$ presupposes a $u$ that has a $\theta^*$ attached, i.e. a critical one. That is presentational, but it is why the display and the claim of hypothesis-freedom sit awkwardly together.

---

## 3. The polarization factor: the block is clean, its warning is not

The parenthetical at [route-a.md:407](../findings/route-a.md#L407) reads:

> (The polarization $\tfrac12(Q(x+y)-Q(x-y))$ equals $2T(x,y,\cdot)$, so recovering $T$ from it needs division by four. A factor of two here reads as a constant of $1.825742$ against the true $\sqrt{5/6}$.)

**The first sentence contradicts itself.** $Q(x\pm y)=Q(x)\pm2x\circ y+Q(y)$, so $Q(x+y)-Q(x-y)=4\,x\circ y$ and $\tfrac12(Q(x+y)-Q(x-y))=2\,x\circ y=2T(x,y,\cdot)$. The first clause is right. Recovering $T$ from *that quantity* is division by **two**; division by four recovers it from $Q(x+y)-Q(x-y)$. As printed the sentence names one object and gives the other's divisor, **the warning commits, in its own instruction, precisely the factor-of-two slip it exists to prevent**. One of the two clauses must go; the cheap repair is to drop the leading $\tfrac12$.

**The block's formulas are nonetheless clean.** The record's $T$ is fixed with no freedom by the Lemma L20 expansion at [route-a.md:99](../findings/route-a.md#L99): $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ with $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ and $\gamma_V=\sqrt{2/3}P(V)$ must return $\sqrt{2/3}P(u)=1$ at $\varphi=0$ and $\gamma_V$ at $\varphi=\pi/2$, which forces the multinomial normalisation $P(x)=T(x,x,x)$, $T(u,V,V)=\langle F_uV,V\rangle$. Every use of $T$ in this section is consistent with that, [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py) included.

**And $1.825742$ is excluded on independent grounds.** By Banach's theorem, for a symmetric $k$-linear form on a real Hilbert space the multilinear norm equals the norm of its diagonal, $\sup\{|T(x,y,z)|:\lVert x\rVert=\lVert y\rVert=\lVert z\rVert=1\}=\max\{|P(W)|:\lVert W\rVert=1\}=M(n)$. Every table entry is a supremum over a *subspace*, hence $\le M(n)$. Padding preserves $P$ and the norm ([conventions.md](../findings/conventions.md)), so $M(10)\le M(12)$, and the record's own global ascent at $n=12$ tops out at $\theta_0(12)=1.236$ ([route-a.md:27](../findings/route-a.md#L28)). A value of $1.825742$ would need $M(10)>1.82$, which contradicts every measurement the programme has of $M$ at $n\le12$ and would refute Conjecture A outright. *This is an argument from the record's measurements, not a proof, the strongest rigorous cap on record, $\theta\le2-o(1)$ at [curvature-invariants.md](../findings/curvature-invariants.md), does not by itself exclude $1.826$.* The normalisation is settled by §3's first paragraph regardless.

---

## 4. The orthogonality, and the degenerate case

Setting $y=x$ in §2, or $\lambda=\mu$: $T(x,x,[\rho(A),u])=0$ for every $A$. Since $T_u(SO(n)\!\cdot\!u)=\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$ by definition of an orbit, $\langle Q(x),\cdot\rangle$ annihilates it. **CONFIRMED, and no witness exists**, the claim is a two-line theorem, so §3's demand for a single counterexample cannot be met.

**$\lambda=\mu$ is not the vacuous case, it is the whole content.** The right side vanishes and the left side is *therefore* zero, an assertion, not an absence of one. Three consequences follow that the block does not separate:

- $\Pi_{V_{1/2}}Q(x)=0$ for **every** eigenvector $x$, in every dimension. This is the *one* of the five components the containment $Q(V_{1/3})\subseteq\ker F_u\oplus\langle u\rangle$ needs, the block's *"a single column of the $7\times7$ coupling table"* is exactly right.
- $T(V_\lambda,V_\lambda,V_{1/2})=0$ for every $\lambda$, which is more than the block states.
- $T\equiv0$ on $T_u\mathcal O\times T_u\mathcal O\times T_u\mathcal O$, hence $P\equiv0$ **on the orbit tangent**. This one needs criticality, see §5.

**$\lambda=0$ carries no exception**, unlike the $\lambda=0$ trap [REVIEW_r590.md](REVIEW_r590.md) records three copies of elsewhere in the canon: here the right-hand side is $-2\lambda\theta^*\langle\mathcal Ax,x\rangle$ and *both* factors vanish.

**What *"with no hypothesis"* costs.** Three hypotheses are live: $x$ must be an eigenvector of $F_u$ (for a general $x$, $\langle Q(x),A\!\cdot\!u\rangle=T(x,x,A\!\cdot\!u)$ is not forced to vanish and the identity only rewrites it); $T$ must be totally symmetric; and the action must be orthogonal. The phrase should read *with no hypothesis on $u$*, which is the true and stronger claim.

---

## 5. $P\equiv0$ on $V_{1/2}$, the gap

The block's whole warrant is the sentence *"It also gives $P\equiv0$ on $V_{1/2}$."* It does not, on its own.

**What the identity gives.** For $x\in V_{1/2}$, $P(x)=T(x,x,x)=\langle Q(x),x\rangle$, and §4 kills this **only if $x\in T_u\mathcal O$**. So the identity delivers $P\equiv0$ on the orbit tangent and nothing more.

**The clean half, with its input named.** $T_u\mathcal O\subseteq V_{1/2}$ is a theorem *and it needs criticality*: differentiating $Q(g\!\cdot\!W)=g\!\cdot\!Q(W)$ at $W=u$ along $g=\exp(tX)$ gives $DQ_u(X\!\cdot\!u)=X\!\cdot\!Q(u)=\theta^*(X\!\cdot\!u)$, and $DQ_u=2F_u$, so $F_u(X\!\cdot\!u)=\tfrac12\theta^*(X\!\cdot\!u)$. The step consumes $Q(u)=\theta^*u$. Hence:

> **$P\equiv0$ on $T_u\mathcal O$ at every critical point of $P$ on the sphere.** *Proof.* $x=A\!\cdot\!u$ lies in $V_{1/2}$, so $T(\mathcal Ax,x,u)=\langle\mathcal Ax,F_ux\rangle=\tfrac{\theta^*}2\langle\mathcal Ax,x\rangle=0$, and the invariance identity gives $P(x)=T(x,x,A\!\cdot\!u)=-2T(\mathcal Ax,x,u)=0$. $\square$

**The sentence that is false in place.** *"…and the argument never uses criticality of $u$"* is printed **one sentence before** *"It also gives $P\equiv0$ on $V_{1/2}$"*, and the second statement uses criticality twice over. The two clauses cannot both be attached to the same argument.

**The second input, unnamed anywhere in the block.** Going from $T_u\mathcal O$ to all of $V_{1/2}$ needs the reverse containment $V_{1/2}\subseteq T_u\mathcal O$. Its status on this record:

| source | what it gives | status |
| --- | --- | --- |
| [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(b) | the $\tfrac12\theta^*$-eigenspace is $\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}$, of dimension $2+4(n-4)=4n-14$ | published theorem, $n\ge9$, resting on his Lemma 4.13's multiplicity-free hypothesis, **which [route-a.md:162](../findings/route-a.md#L162) itself calls *"unverified at large $n$"*** |
| $\dim T_u\mathcal O$ | $\binom n2-\dim\mathfrak u(2)-\dim\mathfrak{so}(n-4)=4n-14$ | clean, given $\mathrm{Stab}^0(u)$ |
| [route-a.md:24](../findings/route-a.md#L24) | $\ker(6F_u-3\theta^*)=T_u\mathcal O$ | exact over a finite field at $n=6,8,10$ |
| [route-a.md:26](../findings/route-a.md#L26) | $\lVert\Pi_E-\Pi_T\rVert_2\le1.4\times10^{-14}$ | floating point, $n=8,10,12,14$ |
| [route-a.md:173](../findings/route-a.md#L173) | the four-block $SO(n-4)$ table, $n$-uniform | the spectra are computed numerically; [REVIEW_r486.md](REVIEW_r486.md) and [REVIEW_r487.md](REVIEW_r487.md) record that **rational rank certificates are still owed** |

So the clause is true at $u$, on a real input, in every dimension, but the input is a cited theorem carrying a hypothesis the record disputes, plus a numerical replacement still owed a certificate. **A `Lemma` label on the bundle is not literal**: the identity and the orthogonality are Lemma-grade, the fifth clause is at best a Lemma conditional on Nienhaus 4.14(b), and below $n=9$ it is floating point.

**That the gap is real, and not pedantry, the record proves against itself.** [fence-posts.md:193](../findings/fence-posts.md#L193) records Krasnov–Tkachev Proposition 6.7, the fusion rule $A_c(\tfrac12)A_c(\tfrac12)\subseteq A_c(\tfrac12)^\perp$, which **is** $T\equiv0$ on $A(\tfrac12)$ by polarisation, which **is** $P\equiv0$ on $V_{1/2}$, as *"the third-order necessary condition for a local maximum"*, and reports that **it fails at $S^3\times S^3$**, a critical point. A statement that fails at some critical points cannot follow from an identity that holds at all of them. Whatever proves it at $u$ must be a property $S^3\times S^3$ lacks, and the eigenspace–orbit coincidence is exactly that property: [second-order.md:223](../findings/second-order.md#L223) records $S^3\times S^3$ carrying $m(\tfrac12)=18$ against an orbit of $9$.

**And the record already holds the general statement, uncited.** [Lemma L51](../findings/second-order.md) states, for any compact $G$ acting orthogonally and any critical $W$: $L_Wz=\tfrac\theta2z$, $Bu=z\circ z$, *"the orbit tangent lies in $A(\tfrac12)$; $T(z,z,z)=0$ there; the fusion rule $\langle z\circ z,y\rangle=0$ holds for every $y\in A(\tfrac12)$"*, with the note *"None of this uses maximality"*. That is L101's fifth clause in its correct scope, proved, sourced to Krasnov–Tkachev Propositions 6.6/6.7, and Gate 2 landed. **L101 restates a weaker version of it with a stronger claim of hypothesis-freedom, and points at it nowhere.**

**What it buys, since the brief asks.** *"It does not tighten the bound"* is **CONFIRMED and for a reason stronger than the block gives**: in the Remark 4.18 subdivision *and* in Lemma L20's own expansion the competitor direction is orthogonal to $\mathbb Ru\oplus T_u\mathcal O$ by construction, so no $V_{1/2}$ slot occurs anywhere downstream. What it does establish is (i) $\Pi_{V_{1/2}}Q(x)=0$ on every eigenspace (one of the five components §6 needs, and the only one currently proved rather than measured) and (ii) at $u$, the third-order necessary condition for local maximality, which is a real test that $S^3\times S^3$ fails and $u$ passes.

---

## 6. The table: one row converts, and the vanishings are untouched

**No table entry follows from the invariance identity, and this can be settled without a run.** The identity determines $T(x,y,z)$ only for $z\in T_u\mathcal O=V_{1/2}$. Every slot of every table row lies in $V_{1/3}\oplus V_0\oplus V_{<0}$, which is orthogonal to $V_{1/2}$. **The identity's content and the table's content are disjoint sets of couplings**, so the block's *"it proves none of the four vanishings"* is right, and the brief's hypothesis that the obvious candidate turns the table into a corollary is **refuted**, not merely unverified. [p0_negative_vanishing.py](../scripts/pipelines/p0_negative_vanishing.py) reaches the same conclusion from the Casimir side and records the collapse to $0=0$.

**Row 1 does convert, and this is the report's one positive deliverable.** Fix a unit $W_1\in V_{1/3}$ and decompose $Q(W_1)$ over the seven eigenspaces:

| component | value | why |
| --- | --- | --- |
| $\Pi_{\langle u\rangle}Q(W_1)$ | $\tfrac13\theta^*u$, of norm$^2$ $\tfrac16$ | $\langle Q(W_1),u\rangle=T(W_1,W_1,u)=\langle F_uW_1,W_1\rangle=\tfrac13\theta^*$, and $(\theta^*/3)^2=\tfrac{3/2}9=\tfrac16$, **exact** |
| $\Pi_{V_{1/2}}Q(W_1)$ | $0$ | **Lemma L101 itself**, §4 |
| $\Pi_{V_{1/3}}Q(W_1)$ | $0$ | table row 4, and rigorously: a symmetric trilinear form vanishing on the diagonal of a subspace vanishes on it identically |
| $\Pi_{V_{<0}}Q(W_1)$ | $0$ | table row 2 |
| $\Pi_{V_0}Q(W_1)$ | free |, |

Since $\sup_{\lVert K\rVert=1,\,K\in V_0}T(W_1,W_1,K)=\lVert\Pi_{V_0}Q(W_1)\rVert$, the table's first row says

$$\sup_{W_1}\lVert\Pi_{V_0}Q(W_1)\rVert=\sqrt{5/6}\iff\max\{\lVert Q(x)\rVert:x\in V_{1/3},\ \lVert x\rVert=1\}=1,$$

because $\lVert Q(W_1)\rVert^2=\tfrac16+\lVert\Pi_{V_0}Q(W_1)\rVert^2$ and $\tfrac16+\tfrac56=1$.

**What this is worth.** The constant $\sqrt{5/6}$ stops being a measured supremum of a coupling and becomes $\sqrt{1-(\theta^*/3)^2}$, an exact arithmetic consequence of $\theta^*=\sqrt{3/2}$ together with a single sharp norm identity, $\lVert Q\rVert\le1$ on the unit sphere of $V_{1/3}$ with equality attained. That is a much smaller target than the original: it mentions neither $K$ nor $\ker F_u$, and it is the kind of statement the algebra's trace identities at [second-order.md:217](../findings/second-order.md#L217) act on. **It is not free**, $\lVert Q(u)\rVert=\theta^*=1.2247>1$, so the bound is a property of $V_{1/3}$ and not of unit Weyl tensors generally. It also gives the table a self-check the record does not have: rows 1, 2 and 4 are consistent only if $\lVert Q(W_1^*)\rVert=1$ at the maximiser.

**Rows 5 and 6 restate the same way but do not close.** $\sup T(W_1,K,K)=\sup_K\lVert\Pi_{V_{1/3}}Q(K)\rVert=2/3$ and $\sup T(W_1,N,N)=\sup_N\lVert\Pi_{V_{1/3}}Q(N)\rVert=\sqrt{2/3}$, by total symmetry; the same accounting gives $\langle Q(K),u\rangle=\langle F_uK,K\rangle=0$ and $\Pi_{V_{1/2}}Q(K)=0$, but nothing on the record kills $\Pi_{V_0}Q(K)$ or $\Pi_{V_{<0}}Q(K)$, so no norm identity drops out. **Two coincidences worth recording as leads and not as results**: $\mathop{\mathrm{spec}}(u)=(2,-1,-1,0,0,0)/\sqrt6$ makes $\sqrt{2/3}=\lambda_{\max}(u)$, $2/3=\lambda_{\max}(u)^2$ and $\sqrt{5/6}=\sqrt{\lambda_1^2+\lambda_2^2}$, so all three constants sit on the lattice $u$'s own spectrum generates. Deciding whether that is structure or arithmetic accident needs the explicit maximisers, which is a run, and I do not have approval for one. **What such a run would decide**: if the maximiser of row 5 is supported in the distinguished $\mathbb R^4$ against $u$'s top eigenline, the three constants are one closed form; if not, they are three.

**A vanishing is a theorem or it is nothing, and the record's own reference notes name a candidate the block's dead list omits.** [references/nienhaus-2023-second-best-einstein/notes.md:58](../references/nienhaus-2023-second-best-einstein/notes.md#L58) records Lemma 4.15, *"the trace of $F$ vanishes on any $SU(2)_-$-invariant subspace of $\mathrm{Weyl}_n$"*, with the gloss *"cited as the model for proving that $P$ vanishes on the $\tfrac13$-eigenspace, which the 4.17 repair needs"*, i.e. **the model for table row 4 specifically**. It appears in none of the six dead explanations, and the block's closing *"a sixth symmetry argument is not worth attempting"* is therefore written without the record's own best-supported candidate on the table. The verdict `blocked` should not stand until Lemma 4.15's route is either run or refuted.

**And two of the six dead explanations are one explanation.** *"$\mathrm{Stab}^0$-invariance alone"* and *"the $SO(n)$-invariance identity"* are the **same** three-term identity read at two kinds of $A$: $A\!\cdot\!u\ne0$ gives L101, and $A\!\cdot\!u=0$ gives $\mathfrak{stab}(u)$-invariance of $T$, the very fact §2's consistency check turns on. Listing them as independent failures overstates the coverage by one. The surviving lead named at [Observation L102](../findings/route-a.md)'s block, *"$\mathrm{Stab}(u)$-isotypic disjointness, which is analysis rather than computation"*, is precisely the second reading pushed further: rows 2 and 3 are **selection rules between different isotypic types**, which the dead entry's objection (*"the invariant cubics on $V_{1/3}$ form a $4$-dimensional space"*), does not touch, since that objection is about the **diagonal** row 4 alone. **The `dead` verdict on that row is over-broad by two rows.**

---

## 7. Provenance, pointers and presentation

**Provenance: checked and clean, which is the exception here.** The block entered at `2f1ad056`, *"docs(conjecture-a): prove the SO(n)-invariance vanishing and record that it is inert"*, whose message matches the block line for line, including *"in every dimension and without criticality of u"* and the four-vanishings note. `51ab61f8` is the file split only. **One thing the commit message shows that the block hides**: *"fold in Reviewer 20: … the exact off-diagonal law and P = 0 on V_{1/2} found beyond the brief"*, the fifth clause arrived as an appended reviewer by-product, which is consistent with its being the one clause with no derivation anywhere.

**The $0.91$ has no source.** *"vanishing on the diagonal and reaching $0.91$ off it"* appears twice on the record, [route-a.md:420](../findings/route-a.md#L420) and the docstring of [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py), and **no script computes it**. That script verifies only $\lVert\Pi_{\mathrm{orbit}}Q(x)\rVert/\lVert Q(x)\rVert$ at $n=8,10,12$, and calls the check *"a check on the derivation rather than as its evidence"*, correctly. A bare number with no run behind it, eleven lines from $\sqrt{5/6}=0.912871$ in the same section, is a confusion waiting to be made; it should be sourced or deleted.

**Pointers: the block has none at all.** Thirty-four lines, zero links, while depending on Remark 4.18, Theorem 4.14, Lemma L21, Lemma L51, $F_u$, $\theta^*$, $V_{1/3}$, $V_{1/2}$ and the eigenspace–orbit coincidence. Nothing in [findings/](../findings/), [results.md](../results.md) or [report/](../report/) cites L101 in return, and [report/sections/90-appendix.tex:398](../report/sections/90-appendix.tex#L398) carries only the dead-explanation row. **Blast radius: contained**, the fifth clause is load-bearing for nothing. Externally, [REVIEW_r465.md](REVIEW_r465.md) cites the law through a line anchor `route-a.md#L356` that now points 54 lines above the block; the file split that [Lemma L100](../findings/route-a.md)'s audit found inverting block order broke this pointer too.

**The block's own boundaries are wrong.** [Lemma L101](../findings/route-a.md#L410)'s heading runs to [Observation L102](../findings/route-a.md#L445) at line 445, so **lines 424--443 sit inside it**: the six dead explanations, the closed-form display for $\gamma_{\text{coupled}}$, and *"the repair is an interval-covering statement, and it now closes for every $n\ge12$"*. None of that is about L101. A reader arriving at the heading finds the Theorem 4.17 repair's headline result filed under a lemma that the same block says is **inert for it**. The material belongs above the heading, with the table it continues.

**Rendering.** [route-a.md:407](../findings/route-a.md#L407) sits between rows 5 and 6 of the table, which terminates the table and leaves $\sup T(W_1,N,N)=\sqrt{2/3}$ rendering as literal pipe-delimited text. The [report](../report/sections/90-appendix.tex) carries all six values in one paragraph and is unaffected, so this is the findings copy alone. Move the parenthetical below the table.

---

## 8. What is owed

| # | owed | reachable? |
| --- | --- | --- |
| 1 | Split the block: **Lemma** for the identity and the orbit-orthogonality, at the generality of §2 and citing [Lemma L51](../findings/second-order.md); **Observation, conditional on Nienhaus 4.14(b)** for $P\equiv0$ on $V_{1/2}$ | now, by editing |
| 2 | Delete *"the argument never uses criticality of $u$"* from the paragraph that then uses it, or move the fifth clause out of that paragraph | now |
| 3 | Fix the two normalisations of $\lambda$; state $x\in V_\lambda,y\in V_\mu$ **in the heading**; define $V_\lambda$ and $T$ in [conventions.md](../findings/conventions.md), neither of which is defined anywhere | now |
| 4 | Repair the parenthetical at [route-a.md:407](../findings/route-a.md#L407) (its object and its divisor disagree by two) and move it below the table so row 6 renders | now |
| 5 | Source or delete *"reaching $0.91$"* | now |
| 5b | Move [route-a.md:424--443](../findings/route-a.md#L424) out of the L101 block, the dead-explanation table and the closed-form repair belong to the section above, not under a heading the same block calls inert for them | now |
| 6 | Record row 1 as $\max\lVert Q\rVert=1$ on the unit sphere of $V_{1/3}$, with $\tfrac16=(\theta^*/3)^2$ exact; this is the honest form of $\sqrt{5/6}$ and the smallest remaining target | now, from §6 |
| 7 | Reopen the `blocked` verdict for row 4 against [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Lemma 4.15, and for rows 2–3 against $\mathrm{Stab}(u)$-isotypic disjointness, which the *"$\mathrm{Stab}^0$-invariance alone"* entry does not address | analysis; the branching of $\mathrm{Sym}^2V_{1/3}$ and $V_\mu$ under $\mathrm{Stab}^0(u)=U(2)\times SO(n-4)$ decides it |
| 8 | The rational rank certificates [REVIEW_r486.md](REVIEW_r486.md)/[REVIEW_r487.md](REVIEW_r487.md) already owe for the four $F_\lambda$ blocks would also discharge $V_{1/2}=T_u\mathcal O$ in every dimension, and with it item 1's condition | one exact computation, not approved here |

**Blocked on computation, named as the rule requires.** Whether $2/3$ and $\sqrt{2/3}$ are the same closed form as $\sqrt{5/6}$ turns on the support of the row-5 and row-6 maximisers, a run over the $F_{W_1}$ eigenblocks at $n=10$. **If the maximisers are supported in the distinguished $\mathbb R^4$ against $u$'s top eigenline**, all three constants derive from $\mathop{\mathrm{spec}}(u)=(2,-1,-1,0,0,0)/\sqrt6$ and the table becomes a corollary. **If they are not**, the two constants are independent and each needs its own argument. I did not run it, and record it as blocked rather than working around it.
