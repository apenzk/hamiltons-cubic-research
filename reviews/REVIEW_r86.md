# Reviewer 86, Gate 2 on the $\mathbb{HP}^m$ closed form

**No numerical checking was used.** Exact symbolic algebra in $m$ (`factor`/`simplify`/`discriminant`/`count_roots`) or hand algebra over $\mathbb Q(m)$. Nothing sampled, no operator built, the formula never evaluated at an integer as evidence.

Independent of [Reviewer 85](REVIEW_r85.md), same brief. **Agrees on every verdict**, and reaches the same central theorem by a different route.

| Step | Verdict |
|---|---|
| 1. Petersen–Stanfield input | **CONFIRMED**, re-derived, so not a citation dependency |
| 2. Weyl projection | **CONFIRMED** |
| 3. Sharp-term multinomial and vanishing blocks | **CONFIRMED** |
| 4. Block masses, conventions, $S_{333}$ | **CONFIRMED**, both Killing constants verified with no Dynkin table |
| The closed form | **CONFIRMED** as an identity of rational functions |
| Monotonicity and the cap | **CONFIRMED**; one supporting sentence **WRONG** (harmlessly) |

## What it added

**The eigenvalues are derivable, not a citation.** Petersen–Stanfield's own Prop 2.2 mechanism $R=\mu^\dagger\mu$ with $\mu(X\wedge Y)=[X,Y]$ gives $\lambda_i=\tfrac12(1-B_{\mathfrak h_i}/B_{\mathfrak g})$ in three lines, reproducing the paper **including the overall scale**, its centre eigenvalue $\tfrac12$, and its trace identity $\mathrm{scal}=\dim M/2$.

**$\theta$ is scale-invariant** and $c=\mathrm{scal}/(n(n-1))$ equals $\mathop{\mathrm{tr}}R/N$ identically, so $W$ is just $R$ minus its trace part, **the metric normalisation cannot bite here at all**, checked because it is the obvious place for a factor to hide.

**The $m=2$ accident has a sharper explanation than the record gave.** $S_{\mathfrak{mmm}}=0$ *is* the symmetric-pair condition $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ for $(\mathfrak{so}(4m),\mathfrak h)$. At $m=2$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)\cong\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$, and $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ **genuinely is** a symmetric pair, dimensions $13+15$, $15=3\cdot5$. So the false premise is **true at $m=2$ and nowhere else with $m\ge2$**, which is the real reason it reproduced $\mathbb{HP}^2$ and failed at $\mathbb{HP}^3$. It also explains the record's separate triality observation about $\mathbb{HP}^2$.

**Killing constants derived without the convention.** $c_{\mathfrak{sp}(1)}=4/m$ from $|J_p|^2=2m$ and $[L_i,L_j]=2L_k$; $c_{\mathfrak{sp}(m)}=2(m+1)$ via $\mathbb H\cong\mathbb C\oplus j\mathbb C$ and $B_{\mathfrak{sp}(m)}(A,A)=2(m+1)\cdot2\mathop{\mathrm{Re}}\mathop{\mathrm{tr}}(A^2)$, **no Dynkin index anywhere**, so the factor-2 trap is not present.

**$S_{333}$ needs no second unstated premise.** $[\mathfrak{sp}(1),\mathfrak m]\subseteq\mathfrak m$ and $[\mathfrak{sp}(m),\mathfrak m]\subseteq\mathfrak m$ are used but **automatic**: $\mathfrak h$ is a subalgebra and $\mathrm{ad}(\mathfrak h)$ is skew for the invariant form, so $\mathfrak h^\perp$ is $\mathrm{ad}(\mathfrak h)$-invariant.

## The WRONG item

[graded-half.md](../findings/graded-half.md) said the cubic **"has no real root"**. False: discriminant $-157464<0$ means a real cubic has **exactly one** real root, and Sturm places it in $(-1,0)$. The script's `sp.solve(...)` filtered by `.is_real` is a tooling artefact, two roots return `is_real = None` and are silently dropped. **The conclusion is unaffected**: `count_roots` on $(0,\infty)$ is $0$, and elementarily $34m^3-12m^2+3m+2>0$ for all $m>0$. Fix to "no real root with $m>0$".

The $m=1$ pole is the $W=0$ degeneration ($\mathbb{HP}^1=S^4$, conformally flat), not a blow-up.

## The single statement

Same theorem as Reviewer 85, reached independently: for a compact irreducible symmetric space normalised to Einstein constant $\tfrac12$, $Q(W)=\tfrac12W$ **exactly, blockwise**, hence

$$\theta^2=\frac1{4\big(\lVert R\rVert^2-(\mathop{\mathrm{tr}}R)^2/N\big)} .$$

Two ingredients: the **bridge identity** $\lambda_i=1/(c_i+2)$ (from $\lambda_i=\tfrac12(1-t_i)$ and $c_i=2t_i/(1-t_i)$) which ties the eigenvalue input to the block-mass input the record treats as independent; and the block relations $S_{ipp}=\rho d_i-c_id_i$, $S_{ppp}=\rho d_p-2\sum_iS_{ipp}$. Checked for $r=1,\dots,5$ holonomy factors with $\lambda_i,d_i,n$ all free symbols; at $r=1$ the residual before normalising is $d_1\lambda_1(4d_1\lambda_1-n)/(n^2(n-1))$, so **the identity holds precisely on $\mathop{\mathrm{tr}}R=n/4$, the Einstein condition is not incidental.**

For $\mathbb{HP}^m$: $\lVert R\rVert^2=\frac{m(5m+1)}{4(m+2)^2}$, $(\mathop{\mathrm{tr}}R)^2/N=\frac m{2(4m-1)}$, and the closed form drops out in one line.

**The third family does not fit, and that is a distinction rather than a gap.** Computing the actual curvature operator of $SU(m)/SO(m)$ (holonomy $\mathfrak{so}(m)$, simple, $\lambda=(m+2)/(4m)$) gives $\theta^2=\frac{8m(m^2+m-4)}{(m-2)(m-1)(m+1)(m+2)(m+4)}$, **not** the record's $\frac{m(m+1)}{(m-1)(m+2)}$. A free by-product: a second closed-form family, decreasing, with $\theta^2(SU(3)/SO(3))=24/35$.

## WRONG vs OVERSTATED

**WRONG:** the "no real root" justification (conclusion unaffected).

**OVERSTATED:** (1) "literature first supplied the input", derivable in three lines from the paper's own Prop 2.2, which also hides the bridge identity making eigenvalues and block masses the same data; (2) "vanishes at $m=2$ and only there", true but under-explained, and stating the reason turns an accident into a checkable criterion for any Wolf space; (3) framing the three closed forms as peers, two are corollaries of $Q(W)=\tfrac12W$, the third is not.

**Nothing in the $\mathbb{HP}^m$ result is refuted.**
