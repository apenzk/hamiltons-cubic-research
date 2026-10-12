# Verifier v105, the generator criterion, the two-eigenvalue closed form, and the "none is coordinate-diagonalizable" clause of L4

**Cold brief.** Checked the block quoted in [ROUND_L04b.md](ROUND_L04b.md) under "The brief as dispatched", whose source is [ungraded-slack.md](../findings/ungraded-slack.md):119 and :121. **No numerical work was done**: no script was run, and every number below is an exact hand evaluation from the definitions on file. Log: [agent_logs/verify-L04-v105.log](../agent_logs/verify-L04-v105.log).

## Verdicts

| # | Claim, as written | Verdict |
|---|---|---|
| C1 | $(\Lambda^4\mathbb R^n)^K=0$ and $\dim\mathcal W_n^K=1$ $\Rightarrow$ the $K$-invariant $W$ is critical | **PROVEN, HYPOTHESES CORRECTED** (one of the two is unused) |
| C2 | "Every member has just two eigenvalues" | **BROKEN** |
| C3 | The closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$ | **PROVEN, AND DERIVED, not fitted**; scope narrower than stated |
| C4 | "None is coordinate-diagonalizable" | **BROKEN** |
| C5 | "for the Lie-group members that is proven rather than numerical" | **HYPOTHESIS-DEBT** |
| C6 | "the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$" | **BROKEN** |
| C7 | "zero-padding preserves everything" | **BROKEN** |
| C8 | The cap $r\le n(n-2)/4$, attained at $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ | **PROVEN for even $n$; GAP**, no parity quantifier is written |
| C9 | "$\theta$ increases with $\dim\mathfrak h$" | **PROVEN at fixed $n$; BROKEN as written** (no "at fixed $n$") |
| C10 | "The members with **simple** isotropy … top out far below at $0.8367$" | **BROKEN** |

**Verdict on the block as a whole: BROKEN.** The criterion is true and its closed form is genuinely derived; five of the surrounding clauses are false as written, and the falsity of the diagonalizability clause is exhibited at the block's own stated maximiser.

## 0. Conventions, fixed once

All taken from [conventions.md](../findings/conventions.md) and [problem.md](../findings/problem.md); nothing here is my own choice.

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$, with $\{\varphi_{ij}=e_i\wedge e_j\}_{i<j}$ **orthonormal**. So $\lVert W\rVert^2=\sum_{i<j}\lambda_{ij}^2$ for a coordinate-diagonal $W$, the unordered-pair convention. This is the choice that reproduces the record's own $\Theta_4=0.866$ and $\Theta_6=1.0541$ ([conventions.md](../findings/conventions.md):21), and it is the $\sqrt2$ trap that file warns about, so I fix it here and use it throughout.
- $Q(W)=W^2+W^\#$, mapping $\mathcal W_n$ to itself ([conventions.md](../findings/conventions.md):15).
- **Critical point means $Q(W)=\theta W$** on $\{\lVert W\rVert=1\}$ ([conventions.md](../findings/conventions.md):119), and $\theta=P(W)/\lVert W\rVert^3$ there.
- **Coordinate-diagonal** means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of *some* orthonormal frame of $\mathbb R^n$ ([problem.md](../findings/problem.md):124). "Coordinate-diagonalizable" is the existence of such a frame.
- On the coordinate-diagonal locus, $(Q(W))_{ij,ij}=\lambda_{ij}^2+\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$ ([problem.md](../findings/problem.md):118), and $Q$ preserves diagonality. **Every hand evaluation in §3 uses this formula and nothing else.**
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- $\kappa=2(n-2)$ is the Killing constant: $\sum_{b,c}c_{abc}^2=\kappa$ for each $a$, with $c_{abc}=\langle[\varphi_b,\varphi_c],\varphi_a\rangle$ totally antisymmetric.

## 1. Hypothesis inventory

**The block's own hypotheses, as written.**

| H | Statement | Applies to | Checked? |
|---|---|---|---|
| H1 | $K\subseteq SO(n)$ | the group | stated |
| H2 | $(\Lambda^4\mathbb R^n)^K=0$ | the group | stated; **unused** by the written argument (§2) |
| H3 | $\dim\mathcal W_n^K=1$ | the group | stated; **this is the one that does the work** (§2) |
| H4 | (unstated, needed) $Q$ is $O(n)$-equivariant and $Q(\mathcal W_n)\subseteq\mathcal W_n$ | the map | on file at [conventions.md](../findings/conventions.md):15 and :41(ii), where $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(Q(W))=0$ is what makes $Q$ preserve $\mathcal W_n$ |
| H5 | (unstated, needed for the closed form) $W$ has exactly two eigenvalues, i.e. $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ | the operator | **asserted, not proven, and false for the block's own padded objects** (§6) |
| H6 | (unstated, needed for $r=\dim\mathfrak h$) $\mathfrak h\subseteq\mathfrak{so}(n)$ is a subalgebra and $\mathfrak m=\mathfrak h^\perp$ | the pair | supplied only later, by [L23](../findings/ungraded-slack.md) |
| H7 | (unstated) $0<r<N$ | the subalgebra | supplied only by L23's statement |
| H8 | (unstated) $n$ even, for the maximiser $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ to exist | the dimension | **absent from the block** (§4) |

**Hypotheses of the results the block imports.**

- **L23** ([ungraded-slack.md](../findings/ungraded-slack.md), same file, below the block) supplies the closed form's derivation. Its hypotheses are: $\mathfrak h$ a subalgebra, $\mathfrak m=\mathfrak h^\perp$, $0<r<N$, $W_{\mathfrak h}$ the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, **and $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ assumed**. The closed form is a *consequence of criticality*, never a criterion for it.
- **L23's "Producing members" paragraph** supplies sufficient conditions for that assumed criticality: $\mathfrak h$ and $\mathfrak m$ both $K$-irreducible **and inequivalent as $K$-modules**, $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, and $(\Lambda^4\mathbb R^n)^K=0$, with $K=N_{O(n)}(\mathfrak h)$ the **full** normaliser. **These are four hypotheses; the block quotes two of them and neither of the two that force the two-eigenvalue shape.**
- **Jäger's Theorem A** is not imported by this block.
- The identification $b_4=0\Rightarrow(\Lambda^4\mathbb R^n)^K=0$ for a symmetric space is **Cartan's theorem that invariant forms compute real cohomology**. That source is **not in [references/](../references/)**, I listed the directory. So every use of the phrase "isotropy-irreducible symmetric spaces with $b_4=0$ qualify" rests on an **unread source**.

**Which the written argument uses: H3 + H4 only.** See §2.

## 2. Pre-registered question 1, which hypothesis does the proof use?

**The written argument is one clause**: *"the $K$-invariant $W$ is a critical point automatically, by equivariance"*. Unfolded, the only inference available from those words is:

1. $Q$ is $O(n)$-equivariant, so for $K\subseteq SO(n)$ and $k\in K$, $Q(k\cdot W)=k\cdot Q(W)$.
2. $Q(\mathcal W_n)\subseteq\mathcal W_n$ (H4), so $Q$ maps $\mathcal W_n^K$ into $\mathcal W_n^K$.
3. $\dim\mathcal W_n^K=1$ (H3), so $\mathcal W_n^K=\mathbb R W$ with $W\ne0$, and $Q(W)\in\mathbb R W$, i.e. $Q(W)=\theta W$. Normalise $\lVert W\rVert=1$. $\square$

**$(\Lambda^4\mathbb R^n)^K=0$ (H2) appears nowhere in that chain.** It cannot: the chain never asks whether a candidate operator is Bianchi-free, because $\mathcal W_n^K$ is by construction a subspace of $\mathcal W_n$, whose members already satisfy the first Bianchi identity. **H2 is unused.**

**Is H2 necessary?** No. Necessity would require: some $K$ with $\dim\mathcal W_n^K=1$ whose invariant $W$ fails to be critical. Steps 1–3 forbid that outright, for every $K$, with no reference to $\Lambda^4$. **So H2 cannot be necessary as long as H4 holds**, and H4 is on file independently of $K$.

**Is H2 sufficient-only?** It is neither sufficient nor necessary *for criticality*. Where it earns its place is one step earlier, in **verifying H3 for an example**: if $(\Lambda^4\mathbb R^n)^K=0$ then the Bianchi map $b:\mathrm{Sym}^2(\Lambda^2\mathbb R^n)\to\Lambda^4\mathbb R^n$, being equivariant, kills every $K$-invariant operator automatically, so one may compute $\dim$ of the *Ricci-flat $K$-invariant* space and read it as $\dim\mathcal W_n^K$ without a separate Bianchi check. That is a computational convenience in the membership test, not a hypothesis of the theorem.

**What would have to be true for H2 to be necessary.** Exactly one thing: the criterion would have to be restated so that its conclusion is stronger than criticality, for instance *"the $K$-invariant traceless Ricci-flat operator is a Weyl operator and is critical"*. Under that reading H2 is doing real work (it is what upgrades "Ricci-flat" to "Weyl"), and H3 would have to be weakened correspondingly to *"the $K$-invariant traceless Ricci-flat operators form a line"*. **As the block writes it (with $\mathcal W_n^K$, not a Ricci-flat space), H2 is redundant.**

**Discrepancy record (three steps).**
- *Locate.* [ungraded-slack.md](../findings/ungraded-slack.md):119, first clause: "If $K\subseteq SO(n)$ satisfies $(\Lambda^4\mathbb R^n)^K=0$ **and** $\dim\mathcal W_n^K=1$".
- *Exhibit.* At $K=SO(n)$ itself: $\mathcal W_n^{SO(n)}=0$, so H3 fails and the criterion is vacuous, H2, by contrast, holds. At the other end, the derivation in steps 1–3 runs verbatim with H2 deleted, so no object exists at which deleting H2 changes the conclusion.
- *Argue the opposite.* The most charitable reading is that the author intends the pair as a *checkable package*, H2 makes H3 cheap to verify, and the two are quoted together because that is how a member is certified in practice. Under that reading the sentence is not false, only overstated: it advertises as a hypothesis something that is a lemma of the membership test. **The clause survives as a true implication and fails as a minimal one.** Verdict: **PROVEN, hypotheses corrected**.

## 3. Pre-registered question 2, the family's own maximiser, written out

Fix $n=2m$, $m\ge2$. Let $\mathfrak h=\mathfrak{so}(m)\oplus\mathfrak{so}(m)\subseteq\mathfrak{so}(n)$ block-diagonally, block $A=\{1,\dots,m\}$, block $B=\{m+1,\dots,2m\}$.

**$\Pi_{\mathfrak h}$ in the basis $\{e_i\wedge e_j\}$.** A block-diagonal antisymmetric matrix is precisely a linear combination of $\varphi_{ij}$ with $i,j$ in the same block. So

$$\mathfrak h=\operatorname{span}\{\varphi_{ij}: i<j,\ \{i,j\}\subseteq A\ \text{or}\ \{i,j\}\subseteq B\},\qquad \mathfrak m=\operatorname{span}\{\varphi_{ij}: i\in A,\ j\in B\}.$$

$\mathfrak h$ and $\mathfrak m$ are each **spanned by a subset of the basis $\{e_i\wedge e_j\}$**, and the two subsets partition it. Therefore

$$\boxed{\ \Pi_{\mathfrak h}\varphi_{ij}=\varphi_{ij}\ \text{if }i,j\text{ are in the same block},\qquad \Pi_{\mathfrak h}\varphi_{ij}=0\ \text{otherwise.}\ }$$

**$\Pi_{\mathfrak h}$ is the $0/1$ diagonal matrix in the basis $\{e_i\wedge e_j\}$.** Hence so is $W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$. **The family's own stated maximiser is coordinate-diagonal in the standard frame, no rotation is even required.**

Counts: $r=2\binom m2=m(m-1)=\tfrac{n(n-2)}4$ (the cap exactly), $N=m(2m-1)$, $N-r=m^2=\tfrac{n^2}4$.

### 3.1 It is a critical point, at every even $n\ge4$, hand derivation

Write $\lambda_{ij}=u$ for same-block pairs, $v$ for mixed pairs. Tracelessness: $m(m-1)u+m^2v=0$, so $u=-\tfrac{m}{m-1}v$.

Apply the diagonal formula $(Q(W))_{ij}=\lambda_{ij}^2+\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$.

*Same-block pair, say $\{1,2\}\subseteq A$.* For $k\in A\setminus\{1,2\}$ ($m-2$ of them) both factors are $u$; for $k\in B$ ($m$ of them) both are $v$. So
$$(Q(W))_{12}=u^2+(m-2)u^2+mv^2=(m-1)u^2+mv^2.$$

*Mixed pair, say $\{1,m+1\}$.* For $k\in A\setminus\{1\}$ ($m-1$): $\lambda_{1k}\lambda_{m+1,k}=uv$. For $k\in B\setminus\{m+1\}$ ($m-1$): $\lambda_{1k}\lambda_{m+1,k}=vu$. So
$$(Q(W))_{1,m+1}=v^2+2(m-1)uv.$$

Substituting $u=-\tfrac m{m-1}v$:
$$(m-1)u^2+mv^2=\frac{m^2}{m-1}v^2+mv^2=\frac{m(2m-1)}{m-1}v^2,\qquad \frac{(m-1)u^2+mv^2}{u}=\frac{m(2m-1)v^2/(m-1)}{-mv/(m-1)}=-(2m-1)v;$$
$$v^2+2(m-1)uv=v^2-2mv^2=(1-2m)v^2,\qquad \frac{(1-2m)v^2}{v}=-(2m-1)v.$$

The two ratios agree, so $Q(W)=\theta W$ with $\theta=-(2m-1)v=-(n-1)v$. **Criticality holds at every even $n=2m\ge4$, with no numerics.**

### 3.2 Its value is $\theta_0(n)$, hand derivation

$$\lVert W\rVert^2=m(m-1)u^2+m^2v^2=\frac{m^3}{m-1}v^2+m^2v^2=\frac{m^2(2m-1)}{m-1}v^2=1\ \Longrightarrow\ |v|=\frac1m\sqrt{\frac{m-1}{2m-1}},$$
$$\theta=(2m-1)|v|=\frac{\sqrt{(2m-1)(m-1)}}{m}=\frac{2\sqrt{(n-1)\cdot\tfrac{n-2}2}}{n}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n).$$

**Two exact instances, evaluated by hand.**

| $n$ | $\mathfrak h$ | $u:v$ | $\theta$ | record's value |
|---|---|---|---|---|
| $4$ | $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ | $u=-2v$ | $-3v=3/\sqrt{12}=\sqrt3/2=0.8660\ldots$ | $\Theta_4=0.866$ ([conventions.md](../findings/conventions.md):21) |
| $6$ | $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ | $u=-\tfrac32v$ | $-5v=5/\sqrt{22.5}=\sqrt{10}/3=1.05409\ldots$ | $\Theta_6=1.0541$ ([conventions.md](../findings/conventions.md):21) |

At $n=4$: $\lVert W\rVert^2=2u^2+4v^2=12v^2$; at $n=6$: $6u^2+9v^2=22.5v^2$. Both reproduce the record's numbers exactly, which also confirms the norm convention fixed in §0.

### 3.3 What I find, stated plainly

**"None is coordinate-diagonalizable" is false at the family's own maximiser, at every even $n\ge4$.** The maximiser is not merely diagonalizable, it is already diagonal in the standard frame, its off-diagonal mass is $0$ before any minimisation, and this is a whole infinite tower, not one case.

**Discrepancy record (three steps).**
- *Locate.* [ungraded-slack.md](../findings/ungraded-slack.md):119: "**None is coordinate-diagonalizable** … the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$".
- *Exhibit.* $n=8$, $\mathfrak h=\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, $r=12=8\cdot6/4$, $N=28$, $N-r=16$. $\Pi_{\mathfrak h}$ is diagonal with $1$ on the $12$ basis bivectors $\varphi_{ij}$ with $i,j$ both $\le4$ or both $\ge5$, and $0$ on the $16$ mixed ones. $u=-\tfrac43v$, $\theta=-7v$, $\lVert W\rVert^2=\tfrac{16\cdot7}{3}v^2$, $\theta=7\cdot\tfrac1{4}\sqrt{3/7}=\tfrac{\sqrt{21}}4=1.14564\ldots=\theta_0(8)=\sqrt{2\cdot7\cdot6}/8=\sqrt{84}/8$. A coordinate-diagonal critical member, at a dimension the block itself works in.
- *Argue the opposite.* The most charitable reading is that "$\mathfrak{su}(2)\oplus\mathfrak{su}(2)$" is meant as a *stand-in* for "the balanced-split isotropies", so the sentence intends "none except the balanced tower". The words do not support it: the exception is named by a specific $6$-dimensional Lie algebra, tied to a specific space $S^3\times S^3$, and called "the **lone** exception". A second charitable reading is that "member" is restricted to the Lie-group and symmetric-space examples in the preceding sentence, excluding $\mathfrak{so}(n/2)^{\oplus2}$, but the very next paragraph declares that algebra "**itself a member and the family's maximiser**". **Both charitable readings are closed off by the block's own next sentence.** Verdict: **BROKEN**. And note $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is **not simple**, so it is not in the class ("compact **simple** Lie groups") the same sentence claims to have proven the statement for.

## 4. Pre-registered question 3, is the closed form derived or fitted?

**Derived. The derivation is on file**, in the same file as the block, at [L23](../findings/ungraded-slack.md) ("the subalgebra family"), roughly forty lines below the sentence under audit. The block itself points only at "checked against held-out spaces it was never fitted to", which **understates its own support**: the record holds a proof, and the block advertises a test.

I rebuilt the derivation from the definitions rather than reading it off. It is correct. Here it is in full.

**Setup.** $\mathfrak h$ a subalgebra, $\mathfrak m=\mathfrak h^\perp$, $W=u$ on $\mathfrak h$ and $v$ on $\mathfrak m$, $ru+(N-r)v=0$. Write $c_{abc}=\langle[\varphi_b,\varphi_c],\varphi_a\rangle$, totally antisymmetric, and $S_{\mathfrak{xyz}}=\sum_{a\in\mathfrak x,b\in\mathfrak y,c\in\mathfrak z}c_{abc}^2$.

**The two trace equations.** For $W$ diagonal in the basis $\{\varphi_a\}$ with eigenvalues $w_a$, $\langle W^\#\varphi_a,\varphi_a\rangle=\tfrac12\sum_{b,c}c_{abc}^2w_bw_c$. Contract $Q(W)=\theta W$ against $\Pi_{\mathfrak h}$: the cross terms $a\in\mathfrak h,\ b\in\mathfrak h,\ c\in\mathfrak m$ vanish because $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m\perp\mathfrak h$, leaving
$$ru^2+\tfrac12\big(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2\big)=\theta ru.$$
Contract against $\Pi_{\mathfrak m}$: the terms $a\in\mathfrak m,\ b,c\in\mathfrak h$ vanish because $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m$, and the two mixed orderings each contribute $S_{\mathfrak{hmm}}$ by total symmetry of $c_{abc}^2$, leaving
$$(N-r)v^2+\tfrac12\big(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2\big)=\theta(N-r)v.$$
These are exactly the two equations L23 writes, after dividing by $r$ and $N-r$. **They check.**

**The two Killing relations.** $\sum_{b,c}c_{abc}^2=-B(\varphi_a,\varphi_a)=\kappa=2(n-2)$ for every $a$. Summing over $a\in\mathfrak h$ gives $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$; over $a\in\mathfrak m$ gives $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$. **They check.**

**Elimination.** Substituting and writing $\sigma=1+\kappa/2=n-1$:
$$2\sigma ru^2+S_{\mathfrak{hmm}}(v^2-u^2)=2r\theta u,\qquad 2\sigma(N-r)v+2S_{\mathfrak{hmm}}(u-v)=2(N-r)\theta .$$
With $v=-\tfrac{ru}{N-r}$ one has $u-v=\tfrac{uN}{N-r}$, $u+v=u\tfrac{N-2r}{N-r}$, $v-u=-\tfrac{uN}{N-r}$, so the two become
$$\theta=\sigma u-\frac{S_{\mathfrak{hmm}}\,uN(N-2r)}{2r(N-r)^2},\qquad \theta=-\frac{\sigma ru}{N-r}+\frac{S_{\mathfrak{hmm}}\,uN}{(N-r)^2}.$$
Equating and cancelling $u$: the left sides combine to $\dfrac{\sigma N}{N-r}$ and the right to $\dfrac{S_{\mathfrak{hmm}}N^2}{2r(N-r)^2}$, giving
$$S_{\mathfrak{hmm}}=\frac{2\sigma r(N-r)}{N},\qquad\text{hence}\qquad \theta=\frac{\sigma ru}{N-r}.$$
Both agree with L23 **exactly**.

**Closing the form.** $\lVert W\rVert^2=ru^2+(N-r)v^2=\tfrac{r(N-r)}N c^2=1$ for $W=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, so $u=c\tfrac{N-r}N=\sqrt{\tfrac{N-r}{rN}}$ and
$$\theta=(n-1)\frac{r}{N-r}\sqrt{\frac{N-r}{rN}}=(n-1)\sqrt{\frac{r}{N(N-r)}}=\frac2n\sqrt{\frac{rN}{N-r}},$$
the last step being an identity in $N$: $\dfrac{(n-1)\sqrt{r/(N(N-r))}}{(2/n)\sqrt{rN/(N-r)}}=\dfrac{n(n-1)}{2}\cdot\dfrac1N=1$ because $N=\tfrac{n(n-1)}2$. **The closed form is exactly the record's.**

**The cap falls out of the same elimination.** $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$, a sum of squares, so $\ge0$, so $r\le\tfrac{2(n-2)N}{4(n-1)}=\tfrac{n(n-2)}4$. **Checks.** At $r=n(n-2)/4$, $N-r=n^2/4$ and the closed form gives $\tfrac2n\sqrt{\tfrac{n(n-2)}4\cdot\tfrac{n(n-1)}2\cdot\tfrac4{n^2}}=\tfrac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$. **Checks.**

**Three independent confirmations of the closed form, all by hand.**

| object | $n$ | $r$ | $N$ | $\theta$ from the closed form | agreement |
|---|---|---|---|---|---|
| $\mathfrak{su}(3)$ bi-invariant | $8$ | $8$ | $28$ | $\tfrac28\sqrt{\tfrac{8\cdot28}{20}}=\tfrac14\sqrt{\tfrac{56}5}=\sqrt{7/10}=0.836660$ | the block's $0.8367$ |
| $SU(6)/Sp(3)$ | $14$ | $21$ | $91$ | $\tfrac2{14}\sqrt{\tfrac{21\cdot91}{70}}=\tfrac17\sqrt{\tfrac{273}{10}}=\sqrt{39/70}=0.746420$ | the block's $0.7464$ |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ | $6$ | $6$ | $15$ | $\tfrac26\sqrt{\tfrac{6\cdot15}9}=\tfrac13\sqrt{10}=1.054093$ | my independent §3.2 derivation from $Q$ alone |

The third row is the one that matters: §3.2 reached $\sqrt{10}/3$ **without using the closed form at all**, from the diagonal $Q$-formula, so the closed form is confirmed against a route that does not assume it.

**Verdict on C3: PROVEN, AND DERIVED.** *But its scope is narrower than the block states.* The derivation assumes (i) exactly two eigenvalues and (ii) criticality. The block presents the closed form as a consequence of membership ("Every member has just two eigenvalues, **giving** the closed form") which is the inference in §6 that fails.

## 5. Quantifier order, scope, and every edge of every range

**Quantifier order in the criterion.** As written: *for all $n$, for all $K\subseteq SO(n)$: if H2 and H3 then $\exists\theta$ with $Q(W)=\theta W$*. That order is correct and is what §2 proves. **The block never states the order of the closed form's quantifiers**, and this is where it slips: the closed form is *for all $\mathfrak h$ with $0<r<N$ such that $W_{\mathfrak h}$ is critical*, whereas the block reads as *for all members of the criterion*. Those are different sets (§6).

**Smallest admissible $n$.** $\mathcal W_n\ne0$ requires $n\ge4$ ($\dim\mathcal W_4=10$, [conventions.md](../findings/conventions.md):14). The closed form and cap are already correct at $n=4$: $r\le 4\cdot2/4=2$, attained by $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, $\theta=\sqrt3/2=\theta_0(4)$, verified in §3.2 from $Q$ alone. **No finding: the small-$n$ edge is sound.** *One caveat the block does not raise*: at $n=4$, $\Lambda^2\mathbb R^4$ splits into self-dual and anti-self-dual pieces and $\mathcal W_4=\mathcal W_4^+\oplus\mathcal W_4^-$, so whether $\dim\mathcal W_4^K=1$ holds for the relevant $K$ is a separate question; the criticality in §3.1 is established directly and does not depend on it.

**Odd $n$.** The cap $n(n-2)/4$ is not an integer when $n$ is odd ($n(n-2)$ is odd), so $r\le\lfloor n(n-2)/4\rfloor$ and $\theta<\theta_0(n)$ **strictly**; and $\mathfrak{so}(n/2)$ does not exist. **The block asserts the maximum "is $n(n-2)/4$, attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$" with no parity condition.** L23, forty lines below, does state "for $n$ odd the cap is not an integer and the inequality is strict". The block does not. Verdict on C8: **GAP**, a true statement missing a quantifier that a consumer reading the block alone will not supply.

**$r\to0$.** Excluded by $0<r<N$, a hypothesis L23 carries and the block does not. At $r=0$, $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}=0$ and there is no unit-norm multiple; the closed form gives $\theta\to0$, which is the limit of nothing. **No finding beyond the missing hypothesis.**

**$r\to N$.** Formally $\theta\to\infty$, which would violate the record's own $M(n)<\infty$. The cap $r\le n(n-2)/4<N$ closes it, so the divergence is unreachable *given the cap*. But the cap is a **consequence** of criticality via $S_{\mathfrak{mmm}}\ge0$, not a hypothesis: the closed form is stated for all $r$ and only afterwards restricted. **The block quotes the closed form before the cap, so a consumer stopping at [ungraded-slack.md](../findings/ungraded-slack.md):119 has an unbounded formula.** Recorded as a scope defect, not a falsehood.

**$\ker W\ne0$.** For a genuine two-eigenvalue member, $u=c(1-\tfrac rN)>0$ and $v=-c\tfrac rN<0$ with $0<r<N$, so **both eigenvalues are nonzero and $\ker W_{\mathfrak h}=0$ always**. This is the fact that makes §6 decisive.

## 6. "Every member has just two eigenvalues", and what zero-padding does

**Discrepancy record (three steps).**

*Locate.* [ungraded-slack.md](../findings/ungraded-slack.md):119, two consecutive clauses: "zero-padding preserves everything, so they persist into $n=12$. **Every member has just two eigenvalues**, giving the closed form $P/\lVert W\rVert^3=\tfrac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$, $N=\binom n2$".

*Exhibit.* Take the block's own first example, the $\mathfrak{su}(3)$ bi-invariant at $n=8$: $W$ has $u>0$ with multiplicity $8$ and $v<0$ with multiplicity $20$, and $\theta=\sqrt{7/10}$. Zero-pad it into $n=12$, which the block says preserves everything. The padded operator $\widetilde W$ is supported on $\Lambda^2\mathbb R^8\subset\Lambda^2\mathbb R^{12}$, so its spectrum on the $N=\binom{12}2=66$-dimensional space is
$$u\ (\times 8),\qquad v\ (\times 20),\qquad 0\ (\times 38).$$
**Three eigenvalues, and a $38$-dimensional kernel.** By §5 no two-eigenvalue member has a kernel at all, so $\widetilde W$ is **not** of the form $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ for any subalgebra $\mathfrak h\subseteq\mathfrak{so}(12)$, and the closed form's derivation (§4), which begins "$W=u$ on $\mathfrak h$ and $v$ on $\mathfrak m$", does not reach it. Reading the block's formula at the padded object with the only $r$ it offers, $r=\dim\mathfrak h=8$ and $n=12$:
$$\frac2{12}\sqrt{\frac{8\cdot 66}{58}}=\frac16\sqrt{\frac{264}{29}}=\frac16\cdot 3.017193\ldots=0.502866\ldots$$
against the true $\theta=0.836660\ldots$, which padding preserves, the record says so at [conventions.md](../findings/conventions.md):21 ("padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$") and again in [lean/INDEX.md](../lean/INDEX.md):38 ("both stay below $3/2$ … **before and after padding**"). **The closed form is wrong by a factor of $1.66$ at an object the block declares a member two clauses earlier.**

*Argue the opposite.* The most charitable reading separates the two clauses: "member" means an unpadded $W_{\mathfrak h}$ at its native $n$, and padding is a remark about persistence of *critical points*, not about membership. That reading rescues the closed form, and immediately breaks the other clause, because zero-padding then does **not** preserve "everything": it destroys the two-eigenvalue structure, it destroys $\ker W=0$, and it destroys $\dim\mathcal W_n^K=1$ (the padded isotropy $K\times O(n'-n)$ has strictly more invariants, since $\Lambda^2\mathbb R^{12}$ acquires the summands $\mathbb R^8\otimes\mathbb R^4$ and $\Lambda^2\mathbb R^4$, each carrying its own invariant projection). **Exactly one of the two clauses is false under every reading, and the block gives the consumer no way to tell which.** Verdicts: C2 **BROKEN**, C7 **BROKEN**.

**What the block would have to say instead.** That two eigenvalues follows not from the criterion but from the *stronger* hypotheses in L23's "Producing members" paragraph ($\mathfrak h$ and $\mathfrak m$ both $K$-irreducible **and inequivalent**) which is a Schur argument, and which the block does not quote. Under the criterion alone, $\dim\mathcal W_n^K=1$ says nothing about how many eigenvalues the spanning operator has.

## 7. The universal claims, one object tried from each family the record names

The block carries four universals: *"Every member has just two eigenvalues"*, *"None is coordinate-diagonalizable"*, *"the lone exception"*, and *"the members with simple isotropy top out at $0.8367$"*. I took one object from each structured family named in the record.

### 7.1 Bi-invariant metrics on compact simple Lie groups, $\mathfrak{su}(3)$, $n=8$

$\mathfrak h=\mathrm{ad}\,\mathfrak{su}(3)\subset\mathfrak{so}(8)$, $r=8$, $N=28$, $\theta=\sqrt{7/10}=0.836660$, reproducing the block's $0.8367$ exactly (§4). **Cap check:** $8\le 8\cdot6/4=12$ ✓, so nothing here contradicts L23. **Diagonalizability:** *no certificate of either sign exists on file for this object.* [diagonality.md](../findings/diagonality.md) lists three instruments and applies them to $\mathbb{CP}^4$, $\mathbb{CP}^5$ and padded $W_{\mathbb{CP}^2}$ only; the unitary-isotropy instrument is explicitly "native dimension $4$ only" and this object's isotropy is orthogonal. **No finding: not refuted, not proven**, this is the content of C5 below.

### 7.2 Isotropy-irreducible symmetric spaces, $\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$, $n=16$

$\mathfrak h=\mathfrak{spin}(9)$, **simple**, $r=36$, $N=\binom{16}2=120$, $N-r=84$. $H^*(\mathbb{OP}^2)$ is concentrated in degrees $0,8,16$, so $b_4=0$ and $\mathbb{OP}^2$ is in the class the block itself declares qualifying. Cap: $36\le 16\cdot14/4=56$ ✓. Closed form:
$$\theta=\frac2{16}\sqrt{\frac{36\cdot120}{84}}=\frac18\sqrt{\frac{360}{7}}=\frac18\cdot\frac{6\sqrt{10}}{\sqrt7}=\frac34\sqrt{\frac{10}7}=0.8964215\ldots$$

**Discrepancy record (three steps), C10.**
- *Locate.* [ungraded-slack.md](../findings/ungraded-slack.md):121: "The members with **simple** isotropy, which is where the first enumeration looked, top out far below at $0.8367$."
- *Exhibit.* $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$: simple isotropy, a member by the block's own class statement, $\theta=\tfrac34\sqrt{10/7}=0.896421>0.836660$. The excess is $0.0598$, about $7\%$, comfortably outside any rounding of "$0.8367$".
- *Argue the opposite.* The charitable reading takes "the members with simple isotropy" to mean "the members with simple isotropy **that the first enumeration found**", making the sentence a report on a census rather than a theorem. The clause "which is where the first enumeration looked" gives that reading some purchase. It does not survive the record's own restatement at [problem.md](../findings/problem.md):158, "The earlier ceiling $0.8367$ is **the maximum over members with $\mathfrak h$ simple**", which is unambiguously universal and equally false. Verdict: **BROKEN**.
- *Dependency.* The membership of $\mathrm{Spin}(9)$ needs $(\Lambda^4\mathbb R^{16})^{\mathrm{Spin}(9)}=0$, which follows from $b_4(\mathbb{OP}^2)=0$ **only through Cartan's theorem identifying invariant forms with real cohomology on a compact symmetric space**. That source is **not in [references/](../references/)**. The refutation therefore stands on the block's own class statement, and its independent confirmation rests on an unread source. I record that rather than paper over it.

### 7.3 Symmetric pairs and the two-block splits, an exact census, by hand

For $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p+q=n$, $W_{\mathfrak h}$ is coordinate-diagonal with $\lambda_{ij}=u$ within a block and $v$ across. Ricci-flatness is the vanishing of the vertex matrix's row sums ([problem.md](../findings/problem.md):30). Row $i$ in the $p$-block gives $(p-1)u+qv=0$; row $j$ in the $q$-block gives $(q-1)u+pv=0$. Subtracting, $(p-q)(u-v)=0$, and $u\ne v$ since $W\ne0$. **Hence $p=q$.**

> **The two-block split lies in $\mathcal W_n$ exactly when it is balanced.** Unbalanced splits are not merely non-maximal, they are not Weyl operators at all, so they are outside the arena, which is what the record's "$\lVert\mathrm{Ric}\rVert\approx1$" measurement at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and $\mathfrak{so}(4)\oplus\mathfrak{so}(6)$ reports numerically. Derived here, not measured.

- **Balanced split**, $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$: a member, coordinate-diagonal, $\theta=\theta_0(n)$, $r=n(n-2)/4$, §3. **Refutes C4 and C6.**
- **Unbalanced split**, e.g. $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$: $r=3+10=13$, which already **exceeds the cap $12$**, consistent with its failing Ricci-flatness and so failing to be critical. Reading the closed form there anyway gives $\tfrac28\sqrt{13\cdot28/15}=\tfrac14\sqrt{364/15}=1.23153\ldots$, which is *not* the record's measured $1.151371$ for that object, as it should not be, since the closed form's derivation assumes criticality and there is none. **No finding: the closed form correctly declines to describe non-members.**

### 7.4 Padded objects

Covered in §6. **Refutes C2 and C7.**

### 7.5 The "lone exception"

$\mathfrak{su}(2)\oplus\mathfrak{su}(2)\cong\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ acting on $\mathbb R^3\oplus\mathbb R^3=\mathbb R^6$ **is** the $n=6$ member of the balanced tower of §3, with $r=6=6\cdot4/4$ and $\theta=\sqrt{10}/3=\theta_0(6)$. It is therefore not an exception to a rule but one term of an infinite family the rule was wrong about. Two further defects in the same clause:

1. It is offered as an exception among "the **Lie-group members**", i.e. bi-invariant metrics on compact **simple** Lie groups, and $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ **is not simple**. The exception is not a member of the class it is excepted from.
2. Its stated role, "which is exactly why $S^3\times S^3$ *is* diagonal, so the argument recovers its own boundary case", is presented as evidence that the surrounding claim is well-calibrated. §3 shows the same mechanism makes $S^{n/2}\times S^{n/2}$ diagonal at **every** even $n$, so the "boundary case" is the whole boundary.

Verdict on C6: **BROKEN**.

## 8. Comparing the forms

I checked four forms of L4.

| form | location | what it carries that the others do not |
|---|---|---|
| **A. the block** | [ungraded-slack.md](../findings/ungraded-slack.md):119 and :121 | the only place the closed form, the padding claim, the diagonalizability clause, the "lone exception" and the simple-isotropy ceiling all appear **together and unqualified**. It is the longest form and the only one a proof-consumer would quote from. |
| **B. the canonical one-liner** | [results.md](../results.md):116 | compresses the family to "a new, **provably non-diagonalizable** family with a closed-form $P$", **strictly worse than A**, because it drops the "lone exception" carve-out entirely, so the false universal is stated with no escape clause at all, and it attaches the word *provably* to the whole family rather than to the Lie-group members. |
| **C. the pointer** | [results.md](../results.md):312 | "Lemma L4, a generator for critical points, and a new family. **Proof:** [ungraded-slack.md](../findings/ungraded-slack.md)". Carries no mathematics; routes the reader to A. |
| **D. the Lean row** | [lean/INDEX.md](../lean/INDEX.md):38 | the **narrowest and the only sound one**. It claims exactly two arithmetic facts, $\theta^2=7/10$ at $(n,r)=(8,8)$ and $39/70$ at $(14,21)$, in ratio $39/49$, both below $3/2$ and below $\theta_0(12)^2=55/36$, and explicitly disclaims the rest: "**Not claimed**: the generator criterion, or the identification of $r$ with $\dim\mathfrak h$". I checked its arithmetic: $\tfrac4{64}\cdot\tfrac{8\cdot28}{20}=\tfrac{7}{10}$ ✓ and $\tfrac4{196}\cdot\tfrac{21\cdot91}{70}=\tfrac{1911}{3430}=\tfrac{39}{70}$ ✓, $\tfrac{39/70}{7/10}=\tfrac{39}{49}$ ✓, $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}$ ✓. |

**No Lean row covers the criterion, the two-eigenvalue shape, or the diagonalizability clause.** A row that did would have to claim, at minimum: (i) $Q$ is $O(n)$-equivariant and $Q(\mathcal W_n)\subseteq\mathcal W_n$, from which (ii) $\dim\mathcal W_n^K=1\Rightarrow Q(W)=\theta W$; and, for the family, (iii) that $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ is the unique traceless $K$-invariant, which needs $K$-irreducibility and inequivalence of $\mathfrak h$ and $\mathfrak m$, none of which is a numeric identity, so none of it is within reach of the arithmetic rows the index currently holds.

**Forms A and B disagree with each other, and B is the more dangerous.** A says "None is coordinate-diagonalizable … the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$"; B says "provably non-diagonalizable" with no exception. §3 refutes both, but a consumer citing B has no signal at all that any member is diagonal.

## 9. The two remaining discrepancy records

### C5, "for the Lie-group members that is proven rather than numerical"

- *Locate.* [ungraded-slack.md](../findings/ungraded-slack.md):119: "None is coordinate-diagonalizable, and **for the Lie-group members that is proven rather than numerical**".
- *What I looked for.* [diagonality.md](../findings/diagonality.md) in full (77 lines), the file whose stated job is "the three instruments, their domains, and what each decides". It certifies non-diagonalisability at $\mathbb{CP}^4$, $\mathbb{CP}^5$ and padded $W_{\mathbb{CP}^2}$ by the Plücker obstruction, quoting $\min\lVert\omega\wedge\omega\rVert=0.61,0.63,0.50$, **three minimisations over a sphere, i.e. numerical, and none of the three objects is a Lie-group member of this family**. The second instrument is an explicit $O(n)$-minimisation. The third, unitary isotropy, is stated to have domain "native dimension $4$ only" and is called "the one to distrust"; the Lie-group members have orthogonal isotropy, so it does not apply to them. [second-order.md](../findings/second-order.md):309 repeats the same three certificates. [problem.md](../findings/problem.md):156 gives three arguments, all about Fox's $\mathcal S^4(\alpha)$, the hyperkähler family and the quaternionic-Kähler family, again not these members.
- *Finding.* **There is no argument on file, of any kind, that a bi-invariant Lie-group member of this family is non-coordinate-diagonalizable.** The word "proven" has nothing behind it in the record.
- *What would have to be shown.* For $\mathfrak h=\mathrm{ad}\,\mathfrak g\subseteq\mathfrak{so}(\mathfrak g)$ with $\mathfrak g$ compact simple: that the eigenspace $\mathfrak h$ of $W_{\mathfrak h}$ contains no decomposable bivector (equivalently, that no nonzero $\mathrm{ad}(X)$, $X\in\mathfrak g$, has matrix rank $2$), **stated and proved, for every compact simple $\mathfrak g$, with the rank of $\mathrm{ad}(X)$ bounded below by $\dim\mathfrak g-\dim Z_{\mathfrak g}(X)$.** *I do not supply that argument here; naming it is the finding.* Verdict: **HYPOTHESIS-DEBT**.
- *Argue the opposite.* The charitable reading is that "proven" refers forward to the "lone exception" clause, i.e. the author means the statement is *structural* (it turns on whether $\mathfrak h$ splits) rather than measured. That reading makes the sentence a promise rather than a claim, and §3 shows the promised structure is wrong anyway: the split $\mathfrak h$ are exactly the coordinate-diagonal ones, and there are infinitely many of them.

### C9, "$\theta$ increases with $\dim\mathfrak h$"

- *Locate.* [ungraded-slack.md](../findings/ungraded-slack.md):121: "Since $\theta$ increases with $\dim\mathfrak h$, the question is how large a subalgebra can be…".
- *Exhibit.* The block's own two examples move the wrong way: $r=8$ at $n=8$ gives $0.836660$; $r=21$ at $n=14$ gives $0.746420$. **$\dim\mathfrak h$ nearly triples and $\theta$ falls by $11\%$.** The statement is true only at fixed $n$, where $\theta^2=\tfrac4{n^2}\cdot\tfrac{rN}{N-r}$ and $r\mapsto\tfrac r{N-r}$ is strictly increasing on $(0,N)$.
- *Argue the opposite.* The most charitable reading is that the sentence lives inside a paragraph about "the family's maximum", which is computed at fixed $n$, so the quantifier is meant to be inherited from context. It is a fair reading of the paragraph and a poor one of the sentence, which is the unit a consumer cites. Verdict: **PROVEN at fixed $n$; BROKEN as written.**

## 10. The named trap, reading each citable claim alone

This record's signature failure is a correction landing **beside** the statement it corrects. I read each citable sentence as a consumer would, with nothing else in view.

**The trap is present, in its purest form, at C4.** A correction box sits directly above the block in the same file, and [problem.md](../findings/problem.md):158 carries a second correction ("**Some members are coordinate-diagonalizable**), the balanced sphere product is one", yet:

- [ungraded-slack.md](../findings/ungraded-slack.md):119 still reads "None is coordinate-diagonalizable … the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$", **unmarked**;
- [results.md](../results.md):116 still reads "**provably non-diagonalizable** family", with **no exception clause at all and no marker**;
- the block prose is the target of the "**Proof:**" pointer at [results.md](../results.md):312, so a reader following the canonical route lands on the uncorrected sentence.

A consumer who cites [results.md](../results.md):116 (the canonical statement, the one a paper would quote), inherits a false universal with no trace of the two corrections that exist elsewhere in the record.

**And the correction beside it is itself defective.** [problem.md](../findings/problem.md):158, having conceded that some members are diagonal, offers a replacement universal: "**What holds is the weaker statement it was reaching for: their positive eigenspaces contain no decomposable bivector at all.**" At the balanced split the positive eigenspace is $\mathfrak h=\operatorname{span}\{\varphi_{ij}:i,j\text{ in the same block}\}$, and $\varphi_{12}=e_1\wedge e_2$ is **decomposable**. So the replacement universal is false at the very object the same sentence names as diagonal. *This is outside my brief's block and I record it as a spillover rather than scoring it, but it is the same failure mode one layer down: the repair was written next to the defect without being run against the defect's own witness.*

## 11. What a consumer may cite

**Citable, as proved:**

1. **The criterion, in the corrected form.** *If $K\subseteq SO(n)$ and $\dim\mathcal W_n^K=1$, then the unit-norm generator $W$ of $\mathcal W_n^K$ satisfies $Q(W)=\theta W$.* Proof in §2, three lines, using only $O(n)$-equivariance of $Q$ and $Q(\mathcal W_n)\subseteq\mathcal W_n$. The hypothesis $(\Lambda^4\mathbb R^n)^K=0$ may be dropped.
2. **The closed form, in the corrected form.** *If $\mathfrak h\subseteq\mathfrak{so}(n)$ is a subalgebra with $0<r=\dim\mathfrak h<N$ and the unit-norm $W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ satisfies $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and $r\le n(n-2)/4$, hence $\theta\le\theta_0(n)$.* Derivation re-run in full in §4. **Criticality is a hypothesis here, not a conclusion.**
3. **The balanced split is a critical point with $\theta=\theta_0(n)$ at every even $n\ge4$**, and it is coordinate-diagonal in the standard frame. §3.
4. **A two-block split $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ gives a Weyl operator exactly when $p=q$.** §7.3.

**Not citable:**

5. "None is coordinate-diagonalizable" and "provably non-diagonalizable", **false**, §3.
6. "for the Lie-group members that is proven", **no argument on file**, §9.
7. "Every member has just two eigenvalues", **false** on the block's own padded objects, §6.
8. "zero-padding preserves everything", **false**, §6.
9. "the members with simple isotropy top out at $0.8367$", **false**, §7.2.
10. "$\theta$ increases with $\dim\mathfrak h$" without "at fixed $n$", **false**, §9.
11. "attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$" without "$n$ even", **incomplete**, §5.

**Blast radius of item 9.** [results.md](../results.md):118 (Lemma L5) eliminates rival families on value and quotes its highest survivor as $\theta(\mathbb{HP}^2)=\sqrt{56/45}=1.11554\ldots$ against $\sqrt{3/2}=1.22474\ldots$. Raising the simple-isotropy ceiling from $0.836660$ to at least $0.896421$ leaves both comparisons intact, so **L5's elimination is unaffected**; the defect is a wrong figure, not a wrong conclusion. I checked no further consumer.

## 12. What would falsify the findings, and what I did to look

- **Against §3 (the refutation of C4).** The object that would break it is an orthonormal frame in which $\Pi_{\mathfrak{so}(m)\oplus\mathfrak{so}(m)}$ fails to be diagonal, impossible, since $\mathfrak h$ is spanned by a *subset of the basis itself*, so the standard frame already works; or a proof that $W_{\mathfrak h}$ at the balanced split is not a critical point, which §3.1 forecloses by direct evaluation of $Q$ at every even $n\ge4$. I looked for a hidden hypothesis that would exclude the balanced split from the family and found the opposite: the block's next paragraph names it "**itself a member and the family's maximiser**".
- **Against §6 (the refutation of C2/C7).** The object would be a padded member whose spectrum is still two-valued, impossible, since padding adds a kernel of dimension $\binom{n'}2-\binom n2>0$ while $u,v\ne0$. Or a statement, somewhere on file, restricting "member" so as to exclude padded objects: I read [ungraded-slack.md](../findings/ungraded-slack.md) around the block and [problem.md](../findings/problem.md):158, and both put padding *inside* the family ("zero-padding **carries them into $n=12$ unchanged**").
- **Against §7.2 (the refutation of C10).** The object would be a proof that $\mathrm{Spin}(9)\subset SO(16)$ fails $\dim\mathcal W_{16}^{\mathrm{Spin}(9)}=1$. I could not construct one: $\Lambda^2\mathbb R^{16}=\mathfrak{spin}(9)\oplus\mathfrak m$ with $\dim\mathfrak m=84$, and $\mathfrak m$ is inequivalent to $\mathfrak{spin}(9)$ on dimension grounds alone ($84\ne36$), so the traceless invariants are at most a line as soon as $\mathfrak m$ is irreducible. **The one step I cannot close from files in this repository is $(\Lambda^4\mathbb R^{16})^{\mathrm{Spin}(9)}=0$, which needs Cartan's theorem, not in [references/](../references/).** Recorded as an unread-source dependency; the refutation itself runs on the block's own class statement and does not need it.
- **Against §2 (H2 unused).** The object would be a $K$ with $\dim\mathcal W_n^K=1$ whose generator is *not* critical. Steps 1–3 of §2 exclude it for every $K$, so no such object can exist unless $Q$ fails to preserve $\mathcal W_n$, and that preservation is on file at [conventions.md](../findings/conventions.md):41(ii) with its mechanism ($\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(Q(W))=0$).

## 13. Verdict

**BROKEN.**

The criterion is a true theorem and is over-hypothesised; the closed form is a true theorem, genuinely derived on file, and under-advertised. Around them, five clauses are false as written, the diagonalizability universal, its "lone exception", the two-eigenvalue universal, the padding claim, and the simple-isotropy ceiling, one clause ("proven rather than numerical") has **no argument on file at all**, and two more are missing quantifiers ("at fixed $n$", "$n$ even"). The false diagonalizability clause is exhibited at the family's **own stated maximiser**, in the standard frame, with no rotation and no computation, at every even $n\ge4$; and it survives in the canonical form at [results.md](../results.md):116 in a *stronger* shape than in the block, with the exception clause dropped.
