# Review r128, the vertex matrix on and off the diagonal locus

Gate 2, cold review of the three claims in [findings/diagonal-half.md](../findings/diagonal-half.md). Every number below was produced independently from the definitions before the record was opened; the comparison section says where it agrees and where it goes further.

---

## Verdicts

| | claim | verdict |
|---|---|---|
| 1 | the matrix statement $K^2-\lambda K\succeq0$ | **CORRECT**, and it is an identity, the deciding fact is that $K^2-\lambda K$ *is* a weighted graph Laplacian |
| 2 | the counting corollary $r\le2/\lambda^2$ | **CORRECT but the wrong corollary**, the same input gives an unconditional bound on $\theta_0(n)$, and the eight sphere products do not test the counting at all |
| 3 | the negative off the diagonal locus | **RECORDED TOO BROADLY** as briefed; the record has since narrowed it (reviewer 130), and the narrowed version's own live question is now answered **NO** |

---

## (a) The algebra, and where $D$ comes from

**The identity is right.** From $K^{\circ2}+K^2=\lambda K+D$,

$$v^{\mathsf T}(K^2-\lambda K)v=v^{\mathsf T}Dv-v^{\mathsf T}K^{\circ2}v=\sum_{a}v_a^2\sum_bK_{ab}^2-\sum_{a,b}K_{ab}^2v_av_b=\sum_{a,b}K_{ab}^2\big(v_a^2-v_av_b\big)=\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2,$$

using $(K^2)_{aa}=\sum_bK_{ab}^2$ (which is $K$ symmetric and hollow) for the first step and $a\leftrightarrow b$ symmetry of $K_{ab}^2$ for the last. Four lines, no hypothesis beyond the equation.

**$D$'s origin is sound, and the worry in the brief resolves in the right direction.** $\Lambda^2$ carries no $(aa)$ index, so criticality supplies equations only at $a\ne b$. Setting $D_{aa}:=(K^2)_{aa}$ is what turns an off-diagonal-only system into a matrix identity: at $a=b$ the left side is $0+(K^2)_{aa}$ and the right is $0+D_{aa}$, so the diagonal row is a definition rather than a constraint. $D=\operatorname{diag}(\operatorname{diag}K^2)$ is therefore exactly right, and it agrees with the record's $\operatorname{diag}(s_1,\dots,s_n)$, $s_i=\sum_jM_{ij}^2$, because $(K^2)_{ii}=s_i$.

**Two supporting facts checked directly, both exact.** The diagonal locus is closed under $Q$: for $M=\operatorname{diag}(K_{ab})$, the operator $M^{\#}$ is diagonal to $0.0$ and its $(ab)$ entry equals $(K^2)_{ab}$ to $0.0$, while $(M^2)_{(ab)(ab)}=K_{ab}^2$. So the reduction to $n\times n$ matrices loses nothing, there are no residual off-diagonal equations. And Ricci-flatness is preserved for free: $\operatorname{Ric}(Q(W))_{aa}=\sum_{c\ne a}(K^{\circ2}+K^2)_{ac}=\lambda(K\mathbf1)_a=0$, so no Lagrange multiplier for the trace-free constraint is needed and $Q(W)=\lambda W$ holds on the nose. (The $\#$ operator was calibrated against $R=\mathrm{Id}\Rightarrow R^{\#}=(n-2)\,\mathrm{Id}$, exact at $n=4,5,6,7$.)

**The right name for the object, and what it buys.** $K^2-\lambda K=L(w)$ with $w_{ab}=K_{ab}^2\ge0$. Positive semidefiniteness is then free, but so is the kernel: $\dim\ker L=$ number of connected components of $\{w_{ab}>0\}$. Since $K$ and $K-\lambda I$ commute, $\ker L=\ker K\oplus\ker(K-\lambda I)$, so for $\lambda\ne0$

$$c\;=\;\dim\ker K\;+\;\big[\lambda\in\operatorname{spec}K\big].$$

Each component contributes its own indicator to $\ker K$ (Ricci-flatness restricts to components), so $\dim\ker K\ge c$, forcing the bracket to vanish:

> **At a diagonal critical point with $\lambda\ne0$, $\lambda$ is never an eigenvalue of $K$, and $\dim\ker K$ equals the number of components of the vertex graph.**

So the inequality is **strict**: every positive eigenvalue satisfies $\theta>\lambda$, not $\ge$. Confirmed on every solution found: $c=\dim\ker K$ and $\lambda\notin\operatorname{spec}K$ in all of them, across $\approx60$ distinct diagonal critical points at $n=5\ldots10$ obtained from random starts, with $\lambda$ of both signs, all at $t=2.0000$ and $\lambda_{\min}(L)$ at $10^{-17}$.

*Note the interval statement presupposes $\lambda>0$. The identity is sign-blind, the correct reading is "no eigenvalue strictly between $0$ and $\lambda$", and roughly half the solutions found have $\lambda<0$, where "$(0,\lambda)$" is empty and the content sits in $(\lambda,0)$.*

---

## (b) Is the matrix form stronger than the scalar one?

**Yes, and the gap is exactly the kernel statement, but the record's own headline is what should be re-derived from it.**

The scalar instance $v=u_1$ gives $\mu_1^2-\lambda\mu_1\ge0$, i.e. $\lambda\le\mu_1$, one Rayleigh quotient. The matrix form constrains the whole spectrum and, through $\dim\ker L=c$, the *graph*. Nothing about symmetry recovers the second from the first: the scalar version at $v=u_1$ says nothing about whether $K$ has a second small positive eigenvalue, which is precisely what $r\le2/\lambda^2$ needs.

**The sharper point is that the scalar instance is worth more than the record currently claims.** [findings/diagonal-half.md](../findings/diagonal-half.md) derives $\theta\le\mu_1$ by bounding $u^{\mathsf T}M^{\circ2}u\le\max_is_i$ and cancelling the $s$ terms, which needs equal row norms, so it is stated **on the vertex-transitive locus**, and line 94 reads "the whole of B1 on the vertex-transitive locus is the factor $(n-1)/n$". The PSD statement gives $\theta\le\mu_1$ with **no hypothesis at all**: $K$ hollow and non-zero forces $\mu_1>0$, and $\mu_1(\mu_1-\lambda)\ge0$ finishes it. Combined with the record's own unconditional $\mu_1\le\sqrt{2(n-2)/(n-1)}$ (from $\sum\mu=0$, $\sum\mu^2=t=2$ and the forced zero):

$$\theta_0(n)\;<\;\sqrt{\tfrac{2(n-2)}{n-1}}\qquad\text{at every diagonal critical point, vertex-transitive or not.}$$

At $n=12$ that is $1.3484004$ against the target $1.236033$, and against the $1.3657$ the record gets by bounding the entrywise and spectral halves separately. **So the reduction of diagonal branch 1 to the single factor $(n-1)/n$ is unconditional, not vertex-transitive**, both halves are already in the record ([findings/target.md](../findings/target.md) line 50 and [findings/diagonal-half.md](../findings/diagonal-half.md) line 94), and the connection between them is what is missing. Checked at the two non-vertex-transitive products: $S^4\times S^8$ has $\lambda=1.201561$ against $\mu_1=1.310794$, and $S^5\times S^7$ has $\lambda=1.228239$ against $\mu_1=1.339897$.

---

## (c) Is $t\le2$ the right bound at a critical point?

**$t=2$ exactly, and the record knows it, but the equality does not tighten $r\le2/\lambda^2$, and the counting is the wrong thing to extract.**

On the diagonal locus $t=2$ identically, since $\lVert M\rVert_F^2=\sum_{a<b}K_{ab}^2=1$. Confirmed at $t=2.000000$ on every sphere product and every random solution. The bound $r\le t/\lambda^2$ therefore reads $r\le2/\lambda^2$ with no slack to recover, so claim 2's "$t\le2$" is correct but its inequality is vacuous where it is used. Strictness ($\theta>\lambda$) upgrades it to $r<2/\lambda^2$, which changes nothing at $\lambda=\Theta_{12}$.

**The eight sphere products do not test the counting bound.** Solving the family in closed form,

$$\lambda(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{pq\,(n-2)},\qquad \operatorname{spec}K=\Big\{\tfrac{n\lambda}{n-1},\;0,\;-\tfrac{q\lambda}{(p-1)(n-1)}^{(p-1)},\;-\tfrac{p\lambda}{(q-1)(n-1)}^{(q-1)}\Big\},$$

with $\Theta_{12}=\lambda(S^6\times S^6)=\sqrt{55}/6=1.2360330$ exactly. **Every sphere product has $r=1$ structurally**, for every $p,q$, there is exactly one positive eigenvalue $n\lambda/(n-1)$ and all the rest are $\le0$, independently of $\lambda$. At $S^2\times S^2$ the bound permits $r\le2$ and the truth is still $r=1$; the same at $S^2\times S^3$, $S^3\times S^3$, $S^2\times S^4$. So "checked at eight sphere products, both parities" confirms $r=1$ without exercising the counting argument anywhere. A test that would exercise it is a critical point with $r=2$: **$S^6\times S^6\oplus S^4\times S^4$** at $n=20$ has $\lambda=0.840232$, $2/\lambda^2=2.83$, and $r=2$ with both positive eigenvalues above $\lambda$, the bound tight and the statement holding.

---

## (d) Non-Kähler, non-diagonal critical points

The brief asked for these because claim 3's evidence was $\mathbb{CP}^m$ plus one padded point. They exist in quantity, and they are built two ways.

**Direct construction, all critical to $2\times10^{-16}$ with $Q(W)=\lambda W$ on the nose:**

| point | $n$ | $\lambda$ | $t$ | $\sqrt t$ | $r$ | in $(0,\lambda)$ | $\lambda_{\min}(K^2-\lambda K)$ |
|---|---|---|---|---|---|---|---|
| $\mathbb{HP}^2$ | $8$ | $1.115547$ | $0.60000$ | $0.7746$ | $1$ | $1$ | $-0.28571$ |
| $\mathbb{HP}^3$ | $12$ | $0.852944$ | $0.42857$ | $0.6547$ | $2$ | $2$ | $-0.18182$ |
| $\mathfrak{su}(3)$ bi-invariant | $8$ | $0.836660$ | $0.48333$ | $0.6952$ | $2$ | $2$ | $-0.16071$ |
| $\mathfrak{so}(5)$ bi-invariant | $10$ | $0.717137$ | $0.28571$ | $0.5345$ | $4$ | $4$ | $-0.10317$ |
| $\mathfrak{so}(6)$ bi-invariant | $15$ | $0.557773$ | $0.25000$ | $0.5000$ | $5$ | $5$ | $-0.06786$ |

Every one is non-Kähler and non-diagonal, and every one fails maximally, so **claim 3's negative is under-evidenced rather than over-stated on this axis**. The $\mathbb{CP}^m$ row of the record reproduces exactly: counts $1,2,3,4,5$ at $\mathbb{CP}^{2\ldots6}$ and $1,1,1$ at padded $W_{\mathbb{CP}^2}$ for $n=6,8,12$, with $\lambda=\sqrt{3/2}$ and $t=1$ invariant under padding.

**But the mechanism is arithmetic, not criticality, which is what the record has since said.** Every row has $\lambda>\sqrt t$, and $\mu_1\le\sqrt{\operatorname{tr}K^2}=\sqrt t$ then forces the outcome with nothing else used. This matches [findings/diagonal-half.md](../findings/diagonal-half.md) line 139 (reviewer 130), reached independently here.

**Frame-independence of those failures, which the record does not state.** Maximising $t$ over $O(n)$ returns $t^*(\mathbb{CP}^2)=1.000000$ and $t^*(\mathbb{HP}^2)=0.600000$, the natural-frame values, so $t$ is a **frame invariant** at these points and the failure is a property of $W$, not of a frame. (Control: the same maximiser returns $t^*=2.000000$ at the diagonal $S^2\times S^2$ and $S^3\times S^3$, recovering the diagonal frame.)

**The block-sum recipe, and the structural fact it exposes.** For $W=\bigoplus c_iW_i$ on disjoint coordinate blocks, cross-pair entries of both $K^{\circ2}$ and $W^{\#}$ vanish, so criticality holds iff $c_i=\lambda/\lambda_i$, giving the harmonic-square law $1/\lambda^2=\sum_i1/\lambda_i^2$. Verified to $3\times10^{-16}$ at four sums, with $\lVert M\rVert_F=1.000000$ and $\lambda$ matching the predicted value to nine digits. Since $K=\bigoplus c_iK_i$,

> **a block sum satisfies $K^2-\lambda K\succeq0$ if and only if every block does**, block $i$ contributes eigenvalues $c_i\theta$, and $c_i\theta\ge\lambda\iff\theta\ge\lambda_i$.

That explains the whole phenomenon and supplies the witnesses below.

---

## The record's own live question, answered: **NO**

[findings/diagonal-half.md](../findings/diagonal-half.md) line 139 ends: *"the derived necessary condition is $K^2-\lambda K\succeq0\Rightarrow t\ge\lambda^2$, and the live question is whether it holds at every critical point with $t\ge\lambda^2$."*

**It does not.** $S^4\times S^4\oplus\mathbb{HP}^2$ at $n=16$ is critical to $2.1\times10^{-16}$ with $\lambda=0.799239$ and $t=1.28137$, so $t\ge\lambda^2=0.63878$ by a factor of two, and $\lambda_{\min}(K^2-\lambda K)=-0.146659$, with one positive eigenvalue inside $(0,\lambda)$. It is non-Kähler, being a sphere product summed with a quaternionic space. The same at $S^6\times S^6\oplus\mathbb{CP}^2$, $n=16$: $t=1.49541$ against $\lambda^2=0.75688$, $\lambda_{\min}=-0.168196$.

**And the gap is not marginal, $t$ can be driven to $2$.** Taking $k$ copies of $S^6\times S^6$ summed with one $\mathbb{CP}^2$:

| $k$ | $n$ | $\lambda$ | $t$ | $2-t$ | $\lambda^2$ | in $(0,\lambda)$ | $\lambda_{\min}(K^2-\lambda K)$ |
|---|---|---|---|---|---|---|---|
| $1$ | $16$ | $0.869989$ | $1.495413$ | $0.504587$ | $0.75688$ | $1$ | $-0.168196$ |
| $2$ | $28$ | $0.711432$ | $1.662577$ | $0.337423$ | $0.50613$ | $1$ | $-0.112474$ |
| $4$ | $52$ | $0.551750$ | $1.797048$ | $0.202952$ | $0.30443$ | $1$ | $-0.067651$ |
| $8$ | $100$ | $0.411588$ | $1.887064$ | $0.112936$ | $0.16940$ | $1$ | $-0.037645$ |

$t\to2^-$ like $1/k$ with the statement failing throughout. So $t\ge\lambda^2$ is necessary and **very far from sufficient**, and no threshold on $t$ below $2$ can rescue it. The vertex matrix cannot be made to decide the non-diagonal case by strengthening the $t$ hypothesis.

**The rotated-frame half, independently reproduced.** The same critical point $W=W(S^6\times S^6)$ viewed in $\exp(\varepsilon A)$-rotated frames keeps $K^2-\lambda K\succeq0$ out to $\varepsilon\approx0.6$, where $t=1.795347<2$ **strictly**, an open set of frames that are off the diagonal locus by the record's own $t$-criterion and satisfy the statement anyway. It breaks at $\varepsilon=0.7$ ($t=1.6197$, $\mu_1=1.2130<\lambda$). In $300$ fully random $O(12)$ frames it holds in $0$, but there $t\in[0.0169,0.2337]$ against $\lambda^2=1.5278$, so those $300$ are decided by $\mu_1\le\sqrt t$ before criticality is consulted. **The "$500$ of $500$ random frames" datum at padded $W_{\mathbb{CP}^2}$ is a foregone conclusion of the same kind and should not be cited as evidence of a dichotomy.**

---

## (e) Is there a diagonality test in here?

**No, and it is dominated on both sides by quantities the record already carries.**

* *As a test on a given frame*: $K^2-\lambda K\succeq0$ holds on an open neighbourhood of the diagonal frame where $t<2$ strictly, so it does not certify diagonality. $t=2$ is an exact iff for the same question, is cheaper, and is already recorded in [findings/target.md](../findings/target.md).
* *As a test on the point $W$*: $K$ is frame-dependent while $\lambda$ is $O(n)$-invariant, so the predicate is not a function of $W$ at all. The frame-independent version of the question is $t^*(W)=2$, which is what $\ker\Phi_W$ decides properly.
* *Compared with fence post F22*: $\ker\Phi_W$ is a genuine necessary-and-sufficient, frame-independent test that carries no information about $\theta$. This is strictly worse, frame-dependent, one-directional, and already implied by $t$. **Its only positive content is the necessary condition $t\ge\lambda^2$, equivalently $\mu_1\ge\lambda$**, and that is a bound, not a test.

---

## What should change in the record

1. **Keep claim 1 as is**, it is correct and the Laplacian naming is right. **Add the kernel statement**: $\lambda\notin\operatorname{spec}K$ and $\dim\ker K=$ components, hence the inequality is strict. The record's connectivity table (reviewer 132) is the $c=1$ case of this; the general statement needs no case analysis.
2. **Demote the counting corollary and promote the bound.** $\theta\le\mu_1$ is unconditional via PSD, so $\theta_0(n)<\sqrt{2(n-2)/(n-1)}$ holds at every diagonal critical point and the $(n-1)/n$ reduction is not confined to the vertex-transitive locus. Also record that $r=1$ is structural at every sphere product, so the eight-point check does not test the bound; $S^6\times S^6\oplus S^4\times S^4$ is a point where it does.
3. **Close reviewer 130's live question with the block-sum witnesses.** $S^4\times S^4\oplus\mathbb{HP}^2$ ($t=1.281\ge\lambda^2=0.639$, $\lambda_{\min}=-0.1467$) and the $t\to2^-$ family settle it negatively. Record the structural reason (a block sum satisfies PSD iff every block does) since that is what makes the family unbounded rather than a coincidence.
4. **Broaden the failure table beyond Kähler.** $\mathbb{HP}^2$, $\mathbb{HP}^3$, $\mathfrak{su}(3)$, $\mathfrak{so}(5)$, $\mathfrak{so}(6)$ fail identically, and $t^*(\mathbb{CP}^2)=1$, $t^*(\mathbb{HP}^2)=0.6$ show those failures are frame-independent. As briefed, the negative was drawn too broadly *and* supported too narrowly; the record's current text fixes the first and this fixes the second.
