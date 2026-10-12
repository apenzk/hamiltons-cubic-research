# Review r328, Lemma L71, saturation, and the $\mathfrak r$ question

**Reviewer 328, adversarial, cold brief.** Everything below is computed by an implementation written from the definitions alone, [scripts/reviewers/r328/](../scripts/reviewers/r328/), which reproduces $\theta_0(n)$ at the balanced products to $10^{-15}$ and $\sqrt{3/2}$ at $W_{\mathbb{CP}^2}$ before it is used on anything. No script of this record was read while building it.

## Verdicts

| claim | verdict |
| --- | --- |
| **M4**, is $\mathfrak r\subseteq\ker W$ at saturation? | **DECIDED, and much more strongly than conjectured: $\mathfrak r=0$ at every $n\ge5$**, unconditionally. The conjecture is true and vacuous; $n=4$ is the only dimension where $\mathfrak r\ne0$ is possible, because $\mathfrak{so}(4)$ is the only non-simple $\mathfrak{so}(n)$ |
| **M1**, the structure at saturation | **CONFIRMED**, with two presentational repairs and one addition: the displayed Jacobi chain is not a set containment as written, and $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ is used but never derived |
| **M2**, Lemma L71 itself | **CONFIRMED given $\mathfrak r=0$, and now unconditional at $n\ge5$.** Two defects in the write-up: "exactly two eigenvalues (derived, not assumed)" is a restatement of the hypothesis $\mathfrak r=0$; and routes (i) and (ii) are **not independent**, both terminate in Cartan's classification of the involutions of $\mathfrak{so}(n)$ |
| **M3**, the mass law | **CONFIRMED numerically and in its derivation**, with one false premise in the prose: $T$ is **not** supported on $(\mathfrak m,\mathfrak m,\mathfrak h)$ at saturation. The residue identity is an assumption of the ratio $n/(n-2)$ in its derivation and a five-point check of it in its verification, at five points whose spectra were never in doubt |

---

## M4, the one that matters. $\mathfrak r=0$ is a theorem, not a conjecture

### Statement

> **Theorem (r328).** Let $n\ge5$ and let $W\ne0$ be a symmetric operator on $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$ with $\operatorname{tr}W=0$, such that $D(v)=0$ for every $v\in\mathfrak m=E_{\min}(W)$. Then $\mathfrak r=0$: $W$ has exactly two eigenvalues $\lambda_{\min}<0<\lambda_{\max}$, $\ker W=0$, $\mathfrak h=E_{\max}=[\mathfrak m,\mathfrak m]$, and $\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$ is a symmetric pair.

Criticality is not used, beyond the record's own observation that it makes $D$ constant on $E_{\min}$ so that "saturating" is unambiguous. What is used is that $\mathfrak{so}(n)$ is **simple** for $n\ge5$.

### Proof

*Step 1, the support, stated exactly.* $\lambda_{\min}<0\le\lambda_{\max}$ comes from $\operatorname{tr}W=0$, and $\lambda_{\max}=0$ would force $W\preceq0$ with zero trace, i.e. $W=0$; so $\lambda_{\min}<0<\lambda_{\max}$. For eigenvalues $\lambda_a,\lambda_b$ of $W$, $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_{\max}$ with **equality iff $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$** (or the swap): equal signs give $\lambda_a\lambda_b\ge0>\lambda_{\min}\lambda_{\max}$; and for $\lambda_a<0\le\lambda_b$, $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_b\ge\lambda_{\min}\lambda_{\max}$, whose second equality forces $\lambda_b=\lambda_{\max}>0$ and whose first then forces $\lambda_a=\lambda_{\min}$. So $D(v)=0$ says precisely $c_{vab}=0$ unless $(a,b)\in\mathfrak m\times\mathfrak h\cup\mathfrak h\times\mathfrak m$.

*Step 2, six inclusions, not three.* With $c$ totally antisymmetric, $c_{vab}$ for $v\in\mathfrak m$ is symmetric in the roles of all three slots, so the support condition also constrains brackets that do not visibly involve $\mathfrak m$:

$$[\mathfrak m,\mathfrak m]\subseteq\mathfrak h,\quad[\mathfrak m,\mathfrak h]\subseteq\mathfrak m,\quad[\mathfrak m,\mathfrak r]=0,\quad [\mathfrak h,\mathfrak h]\perp\mathfrak m,\quad[\mathfrak h,\mathfrak r]\perp\mathfrak m,\quad[\mathfrak r,\mathfrak r]\perp\mathfrak m .$$

The last three are $c_{v h h'}=c_{v h \rho}=c_{v\rho\rho'}=0$ read cyclically. In particular $\mathfrak k:=\mathfrak h\oplus\mathfrak r$ is a subalgebra and $\mathfrak{so}(n)=\mathfrak k\oplus\mathfrak m$ is **already a symmetric pair, with $\mathfrak r$ present**, a fact the record does not state.

*Step 3, $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is an ideal.* Write $\mathfrak h_0=[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, so $\mathfrak g'=\mathfrak m\oplus\mathfrak h_0$ (the sum is direct because $\mathfrak h_0\perp\mathfrak m$). Test each summand of $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h\oplus\mathfrak r$ against $\mathfrak g'$:

- $[\mathfrak m,\mathfrak m]=\mathfrak h_0$ and $[\mathfrak m,\mathfrak h_0]\subseteq[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$;
- $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, and for $x\in\mathfrak h$, $a,b\in\mathfrak m$, Jacobi gives $[x,[a,b]]=[[x,a],b]+[a,[x,b]]\in[\mathfrak m,\mathfrak m]=\mathfrak h_0$;
- $[\mathfrak r,\mathfrak m]=0$, and $[\rho,[a,b]]=[[\rho,a],b]+[a,[\rho,b]]=0$.

So $[\mathfrak{so}(n),\mathfrak g']\subseteq\mathfrak g'$.

*Step 4, simplicity.* $\mathfrak m\ne0$, so $\mathfrak g'\ne0$; $\mathfrak{so}(n)$ is simple for $n\ge5$, so $\mathfrak g'=\mathfrak{so}(n)$. Then $\mathfrak m\oplus\mathfrak h_0=\mathfrak m\oplus\mathfrak h\oplus\mathfrak r$ with $\mathfrak h_0\subseteq\mathfrak h$ forces $\mathfrak h_0=\mathfrak h$ and $\mathfrak r=0$. $\square$

### What it does to the record

- **Lemma L71 is unconditional at every $n\ge5$.** The hypothesis "$\mathfrak r=0$", and the substitute "$\ker W=0$" the record proposes, are both automatic. [plan.md](../plan.md)'s **T4′** ("the work is removing the irreducibility hypothesis"), is closed by this, off the diagonal locus as well as on it.
- **"Checked at exactly one point with $\mathfrak r\ne0$, because that is the only such point known" is right for the wrong reason.** $W_{\mathbb{CP}^2}$ at $n=4$ is not a sparsely-sampled case; it is the *only* case there can ever be, since $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ is the unique non-simple member of the family. My own build of the witness confirms the shape the proof predicts: $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ has dimension $3$ (one $\mathfrak{so}(3)$ factor) and $\mathfrak r$ is the other, with $[\mathfrak r,\mathfrak r]\subseteq\mathfrak r$ of norm $3.4641$ and $[\mathfrak m,\mathfrak r]=0$.
- **The multiplicity conjecture $\dim\mathfrak m=n\operatorname{rk}W/2(n-1)$ is correct and empty.** At $n\ge5$, $\mathfrak r=0$ gives $\ker W=0$ and $\operatorname{rk}W=N$, so it returns $n^2/4$ and $n(n-2)/4$ always. Its only instance with $\operatorname{rk}W<N$ is the $n=4$ witness. "The two known regimes are one formula" is true because the second regime is a single point in a single dimension.
- **New corollary: no critical point of $\mathcal W_n$ saturates at odd $n\ge5$.** Saturation forces $\dim\mathfrak m/\dim\mathfrak h=\lambda_{\max}/|\lambda_{\min}|=n/(n-2)$ and $\dim\mathfrak m+\dim\mathfrak h=N$, so $\dim\mathfrak m=n^2/4\notin\mathbb Z$ for odd $n$. Saturation is an even-dimensional phenomenon.
- **r324's inequality becomes an equality.** That audit gives $\theta\ge\theta_0(n)$ at saturation, with equality iff $W$ has exactly two eigenvalues of multiplicities $n^2/4$ and $n(n-2)/4$, which is now automatic at $n\ge5$. So **$\theta=\theta_0(n)$ at every saturating critical point with $n\ge5$**, and the inequality is strict only at $n=4$, where $W_{\mathbb{CP}^2}$ sits at $\sqrt{3/2}=1.224745$ against $\theta_0(4)=0.866025$.
- **[T4′](../plan.md) is closed as stated.** Its deliverable, "every critical point saturating Lemma L70 is a balanced sphere product, with no two-eigenvalue and no diagonality hypothesis", holds at every $n\ge5$, with $n=4$ and $W_{\mathbb{CP}^2}$ as the complete exception.

### The search that was asked for, run anyway

Newton (`least_squares` on $Q(W)-\theta W$ with an analytic Jacobian, in an orthonormal basis of $\mathcal W_n$) from random and structured seeds, paddings of $W_{\mathbb{CP}^2}$ and of every sphere product $S^k\times S^{n_s-k}$, block projections, maximal tori, each also perturbed at $\varepsilon=0.05,0.2,0.5$. Every point below is inside $\mathcal W_n$ to $10^{-15}$; criticality residual and Weyl distance are reported for all of them.

| population | critical points reached | saturating | min $D$ found |
| --- | --- | --- | --- |
| $n=5$, 140 seeds, run to completion | 92 (10 distinct) | **0** | $0.133333$ |
| $n=6$, 114 of 152 seeds before the run was stopped | 106 | **0** | $0.223800$ |
| $n=8$, catalogue screen (below) | 6 | 1, the balanced product | $0$ at $S^4\times S^4$ |

At $n=5$ the Lemma L70 identity itself was checked at every one of those points and holds to $\le2.4\times10^{-15}$; the top of that list is padded $W_{\mathbb{CP}^2}$ at $\theta=1.224745$ with $D=0.333333$.

Genuine critical points at $n=8$, each built independently and screened against $\mathcal W_8$:

| point | $\theta$ | crit. residual | dist. from $\mathcal W_8$ | $\dim\mathfrak m/\mathfrak h/\mathfrak r$ | $D$ |
| --- | --- | --- | --- | --- | --- |
| $S^4\times S^4$ | $1.145643924$ | $2.5\times10^{-15}$ | $1.2\times10^{-15}$ | $16/12/0$ | $\mathbf 0$ |
| $\Pi_{\mathfrak{so}(3)\oplus\mathfrak{so}(5)}$ projected, $=S^3\times S^5$'s value | $1.115546702$ | $2.6\times10^{-15}$ | $1.4\times10^{-15}$ | $15/3/10$ | $0.177778$ |
| $\Pi_{\mathfrak{so}(2)\oplus\mathfrak{so}(6)}$ projected | $0.986013297$ | $2.6\times10^{-15}$ | $1.5\times10^{-15}$ | $12/1/15$ | $0.555556$ |
| maximal torus $\mathfrak{so}(2)^4$ | $0.540061725$ | $1.2\times10^{-15}$ | $1.1\times10^{-15}$ | $24/4/0$ | $0.166667$ |
| padded $W_{\mathbb{CP}^2}$ | $1.224744871$ | $3.2\times10^{-15}$ | $1.4\times10^{-15}$ | $2/1/25$ | $1.333333$ |
| padded $S^3\times S^3$ | $1.054092553$ | $2.1\times10^{-15}$ | $1.2\times10^{-15}$ | $9/6/13$ | $0.133333$ |

Kernel-carrying critical points were screened explicitly, since they are where the conjecture would bite:

| point | $n$ | $\theta$ | crit. residual | dist. from $\mathcal W_n$ | $\dim\mathfrak m/\mathfrak h/\mathfrak r$ | $D$ |
| --- | --- | --- | --- | --- | --- | --- |
| padded $W_{\mathbb{CP}^2}$ | $5,\dots,12$ | $1.224744871$ | $\le6.5\times10^{-15}$ | $\le2.5\times10^{-15}$ | $2/1/(N-3)$ | $(n-4)/3$: $0.333\dots2.667$ |
| padded $S^3\times S^3$ | $7,8,9$ | $1.054093$ | $\le4.0\times10^{-15}$ | $\le2.0\times10^{-15}$ | $9/6/\{6,13,21\}$ | $0.0667,0.1333,0.2$ |
| padded $S^4\times S^4$ | $9,10,11$ | $1.145644$ | $\le4.9\times10^{-15}$ | $\le2.4\times10^{-15}$ | $16/12/\{8,17,27\}$ | $0.0357,0.0714,0.1071$ |

Every one has $\mathfrak r=\ker W$ **and fails to saturate**, so $\mathfrak r\subseteq\ker W$ is nowhere near sufficient, and the deficiency grows linearly in the padding.

The most plausible shape a counterexample could take was also blocked by hand: $\mathfrak m$ the $(2,3)$ off-block of $\mathfrak{so}(5)\subset\mathfrak{so}(8)$, $\mathfrak h_0=\mathfrak{so}(2)\oplus\mathfrak{so}(3)$, and the centralising $\mathfrak{so}(3)$ as $\mathfrak r$. The three intended inclusions hold exactly ($|[\mathfrak m,\mathfrak m]$ off $\mathfrak h_0|=|[\mathfrak m,\mathfrak h_0]$ off $\mathfrak m|=|[\mathfrak m,\mathfrak r]|=0$), and the construction still dies on the $15$-dimensional mixed block: $\lVert[\mathfrak m,\text{mix}]\rVert=6.0$ forbids it from $\mathfrak r$, and $\lVert[\mathfrak m,\text{mix}]$ off $\mathfrak m\rVert=6.0$ forbids it from $\mathfrak h$. That is Step 3 made concrete.

---

## M1, the structure. Confirmed, with three notes

**The three inclusions are right**, and the derivation of the support (Step 1 above) is right, provided one records that it needs $\lambda_{\max}>0$ strictly, supplied by $\operatorname{tr}W=0$ and $W\ne0$, exactly as Lemma L70 already records for the sign of $D$.

**The first Jacobi step is sound in content and false as written.** "$[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]$" is not a containment of subspaces; nothing about the left side puts it inside the right side unless the left factor is expanded as a bracket. What is true is the elementwise statement: for $a,b\in\mathfrak m$ and $Y\in[\mathfrak m,\mathfrak m]$, $[[a,b],Y]=[a,[b,Y]]-[b,[a,Y]]\in[\mathfrak m,[\mathfrak m,\mathfrak h]]\subseteq[\mathfrak m,\mathfrak m]$, and bilinearity extends it because $[\mathfrak m,\mathfrak m]$ **is** the span of brackets. So the answer to the brief's question is: it does need $[\mathfrak m,\mathfrak m]$ to be spanned by brackets, that is what the notation means, and the chain should be written elementwise. The same applies to $[\mathfrak r,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak r,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak r,\mathfrak m]]$, which is likewise correct elementwise.

**The conclusions all hold**: $\mathfrak g'=\mathfrak m\oplus[\mathfrak m,\mathfrak m]$ is a subalgebra, $(\mathfrak g',[\mathfrak m,\mathfrak m])$ is a symmetric pair with odd part $\mathfrak m$ (the sum is direct, since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\perp\mathfrak m$), and $\mathfrak r$ centralises $\mathfrak g'$. **What the record stops one line short of** is that $\mathfrak h$ also normalises $\mathfrak g'$, which is what upgrades "$\mathfrak r$ centralises $\mathfrak g'$" into "$\mathfrak g'$ is an ideal" and closes M4.

**Verified at every saturating point** with my own structure constants: at $S^{n/2}\times S^{n/2}$, $n=6,8,10,12$, $\dim[\mathfrak m,\mathfrak m]=6,12,20,30=\dim\mathfrak h$ with $[\mathfrak m,\mathfrak m]$ off $\mathfrak h$ measuring $0$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$ exactly, $\mathfrak r=0$, $\dim\mathfrak g'=N$; at $W_{\mathbb{CP}^2}$, $\dim[\mathfrak m,\mathfrak m]=1=\dim\mathfrak h$, $\dim\mathfrak g'=3$, $[\mathfrak h,\mathfrak h]=[\mathfrak h,\mathfrak r]=[\mathfrak m,\mathfrak r]=0$. The maximal-torus control breaks the first inclusion loudly: at $n=6$, $[\mathfrak m,\mathfrak m]$ has norm $8.485$ of which $6.928$ lies in $\mathfrak m$ itself.

---

## M2, Lemma L71. Confirmed, with a circular sub-claim and a false independence claim

### "Exactly two eigenvalues, derived not assumed", REFUTED AS STATED

$\mathfrak r$ is defined as "everything else, the other eigenspaces, kernel included". So "$\mathfrak r=0$" **is** the statement "$W$ has exactly two eigenvalues and no kernel", written in other letters. Under that hypothesis, deriving two eigenvalues is not a derivation. The section heading ("saturation forces the balanced sphere product, with no two-eigenvalue hypothesis"), is therefore wrong as it stands: the hypothesis was renamed, not removed.

**The repair is the M4 theorem**, which genuinely derives $\mathfrak r=0$ from simplicity. With it, the heading becomes accurate at every $n\ge5$, and the two-eigenvalue conclusion is earned.

### A missing step: $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$

Lemma L71 concludes "$\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$ is a symmetric pair", which requires $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$. Saturation as the record uses it gives only $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, and the symmetric-pair statement that is actually proved is for $(\mathfrak g',[\mathfrak m,\mathfrak m])$, which coincides with $(\mathfrak{so}(n),\mathfrak h)$ only once $[\mathfrak m,\mathfrak m]=\mathfrak h$, itself unproved at that point in the text. **One line fixes it**: $\langle[\mathfrak h,\mathfrak h],v\rangle=c_{v\mathfrak h\mathfrak h}=0$ by total antisymmetry and the support condition, so $[\mathfrak h,\mathfrak h]\perp\mathfrak m$, which with $\mathfrak r=0$ is $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$. Route (i) needs the same line, since Lemma L23 requires $\mathfrak h$ to be a subalgebra.

### Route (i), valid

Two eigenvalues plus $\operatorname{tr}W=0$ force $W\propto\Pi_{\mathfrak h}-\frac rN\mathrm{Id}$ identically (the trace-free two-eigenvalue operator with $E_{\max}=\mathfrak h$ *is* that multiple), so [Lemma L23](../results.md) applies verbatim once $\mathfrak h$ is a subalgebra. Its cap $r\le n(n-2)/4$ with equality iff symmetric pair then selects the balanced split. The defect arithmetic is right: $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=n(n-2)/4+\big(\tfrac{p-q}2\big)^2$ and $\dim\mathfrak u(n/2)=n^2/4=n(n-2)/4+n/2$, so both exceed the cap unless $p=q$.

### Route (ii), valid, and not independent of route (i)

The arithmetic checks: $\dim\mathfrak m/\dim\mathfrak h=\lambda_{\max}/|\lambda_{\min}|=n/(n-2)$ with $\dim\mathfrak m+\dim\mathfrak h=n(n-1)/2$ gives $\dim\mathfrak m=n^2/4$, $\dim\mathfrak h=n(n-2)/4$.

**The uniqueness claim is true for every even $n$, not just $n=6,\dots,16$**, and the proof is one line rather than a case list: with $p=\tfrac n2+t$, $q=\tfrac n2-t$, $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{n^2}4+t^2-\tfrac n2$, and the target $\tfrac{n(n-2)}4=\tfrac{n^2}4-\tfrac n2$ forces $t=0$; $\mathfrak u(n/2)$ misses by $n/2$ at every $n$. Machine-checked at all even $n\le40$.

**The $n=8$ exceptional check is unnecessary, for a reason worth recording.** $\dim\mathfrak g^\theta$ is invariant under conjugating $\theta$ by any automorphism, triality included, so a triality-twisted involution has *exactly* the dimension of its untwisted partner, $\mathfrak{spin}(7)$ at $21=\dim\mathfrak{so}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $13=\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(5))$, as the record's own numbers show. Outer automorphisms can never introduce a new dimension, so the dimension route is insensitive to them at $n=8$ and anywhere else. It is also worth noting the converse benefit: $12$ is attained by a single $\mathrm{Aut}$-class, so at $n=8$ the pair is *inner*-conjugate to the standard balanced split and the geometric conclusion (a genuine $\mathbb R^4\oplus\mathbb R^4$ splitting of $\mathbb R^8$) follows, which a bare Aut-conjugacy would not give.

**"Route (i) uses nothing from the audit; route (ii) is a check on it", REFUTED AS STATED.** The independence is real only in the *source of the dimension*: route (i) gets $\dim\mathfrak h=n(n-2)/4$ from Lemma L23's sum-of-squares cap, route (ii) from r324's spectral ratio. From there both routes ask the identical question (*which symmetric pairs of $\mathfrak{so}(n)$ have $\dim\mathfrak h=n(n-2)/4$*) and both answer it with Cartan's classification of the involutions of $\mathfrak{so}(n)$. That classification is a shared, load-bearing, unaudited input; if it were wrong or incomplete, both routes fail together. Two derivations of one number, not two routes to the conclusion.

**Is the list complete as used?** For the *dimension* argument, yes: $\dim\mathfrak g^\theta$ over involutions of the compact $\mathfrak{so}(n)$ takes values in $\{p(p-1)/2+q(q-1)/2:p+q=n\}\cup\{n^2/4\}$ for every $n\ge5$, and the $n=8$ triality classes add no new values by the invariance above. The record's phrasing ("$\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$ exhaust them only for $n\ne8$"), is about embeddings up to *inner* conjugacy, which is the right caution for a geometric claim and the wrong one for a dimension count.

---

## M3, the mass law. Confirmed, on a premise that is false as stated

### Reproduced

$T_{abc}=c_{abc}^2$ built in $W$'s own eigenbasis, row masses verified at $2(n-2)$ to $10^{-12}$, and $M$ and the residue measured **directly from $T$** rather than from the formulae:

| point | $n$ | $\dim\mathfrak m/\mathfrak h/\mathfrak r$ | $M$ | $\dim\mathfrak m(n-2)$ | residue, measured | $\dim\mathfrak h(n-4)$ |
| --- | --- | --- | --- | --- | --- | --- |
| $W_{\mathbb{CP}^2}$ | $4$ | $2/1/3$ | $4$ | $4$ | $0$ | $0$ |
| $S^3\times S^3$ | $6$ | $9/6/0$ | $36$ | $36$ | $12$ | $12$ |
| $S^4\times S^4$ | $8$ | $16/12/0$ | $96$ | $96$ | $48$ | $48$ |
| $S^5\times S^5$ | $10$ | $25/20/0$ | $200$ | $200$ | $120$ | $120$ |
| $S^6\times S^6$ | $12$ | $36/30/0$ | $360$ | $360$ | $240$ | $240$ |
| maximal torus (control) | $6$ | $12/3/0$ | $24$ | $48$ | $0$ | $6$ |
| maximal torus (control) | $8$ | $24/4/0$ | $48$ | $144$ | $0$ | $16$ |

All five reported values and both control failures reproduce exactly. The three orderings of $(\mathfrak m,\mathfrak m,\mathfrak h)$ carry equal mass at every point, as total symmetry requires.

### The counting is right, including the factor $2$

Each $\mathfrak m$ row has all $2(n-2)$ of its mass on ordered pairs in $\mathfrak m\times\mathfrak h\cup\mathfrak h\times\mathfrak m$, and $T_{abc}=T_{acb}$ splits it evenly, so $\sum_{a\in\mathfrak m}2(n-2)=2M$ and $M=\dim\mathfrak m\,(n-2)$. **The factor $2$ is correct.** The residue then follows from total symmetry: the mass with $a\in\mathfrak h$, $b,c\in\mathfrak m$ is the same $M$, so $\mathfrak h$'s rows carry $2(n-2)\dim\mathfrak h-M=(n-2)(2\dim\mathfrak h-\dim\mathfrak m)$ elsewhere.

### The premise is false as written

> "$T$ … at saturation it is supported on $(\mathfrak m,\mathfrak m,\mathfrak h)$."

It is not. Saturation constrains only the rows **through $\mathfrak m$**; the $(\mathfrak h,\mathfrak h,\mathfrak h)$, $(\mathfrak h,\mathfrak h,\mathfrak r)$ and $(\mathfrak r,\mathfrak r,\mathfrak r)$ blocks are untouched by it. Measured off-support mass: $12$ at $W_{\mathbb{CP}^2}$ (the $(\mathfrak r,\mathfrak r,\mathfrak r)$ block, $\mathfrak r\cong\mathfrak{so}(3)$) and $12,48,120,240$ at the balanced products, which is exactly the residue, since there the residue **is** $[\mathfrak h,\mathfrak h]$'s own mass. The derivation survives untouched because it only ever uses the $\mathfrak m$ rows, but the sentence should read "every row through $\mathfrak m$ is supported on $\mathfrak m\times\mathfrak h$".

### Check of the ratio, or assumption of it? Both, in different places

- **In the derivation it is an assumption.** $(n-2)(2\dim\mathfrak h-\dim\mathfrak m)=\dim\mathfrak h(n-4)$ is *equivalent* to $\dim\mathfrak m/\dim\mathfrak h=n/(n-2)$, rearranging gives $n\dim\mathfrak h=(n-2)\dim\mathfrak m$ and nothing else. Bracket-mass counting **alone** yields only an inequality: $M=(n-2)\dim\mathfrak m$ is carried by $\mathfrak h$'s rows, which hold at most $2(n-2)\dim\mathfrak h$, so $\dim\mathfrak m\le2\dim\mathfrak h$. That is saturated at $n=4$ (ratio exactly $2$, residue $0$, and hence $[\mathfrak h,\mathfrak h]=[\mathfrak h,\mathfrak r]=0$, the record's observation, now explained) and strictly slack at every $n\ge6$, where $n/(n-2)<2$.
- **In the verification it is a genuine check**, because the residue can be and here was measured directly from $T$ without using the ratio. But it is a check at five points whose spectra are known in closed form, four of them the equality family; it confirms the ratio *there* and derives nothing. **"A route sharing nothing with the reviewer's derivation" overstates it**, the shared ingredient is $\operatorname{tr}W=0$, which is where the ratio meets the dimensions in both arguments. The claim "that discharges the validation this record owes" should be downgraded to "checked at five points".

---

## What I recommend the record change

1. **Replace the hypothesis of Lemma L71 with nothing, at $n\ge5$**, on the ideal-plus-simplicity argument above, and record $n=4$ as the single exceptional dimension with $W_{\mathbb{CP}^2}$ as its witness, not as a sparsely-tested conjecture but as the complete list. The corollary "no saturating critical point exists at odd $n\ge5$" comes free.
2. **Retire the conjecture $\mathfrak r\subseteq\ker W$ and the multiplicity formula** to a remark about $n=4$; at $n\ge5$ they read $\mathfrak r=0$ and $\dim\mathfrak m=n^2/4$.
3. **Fix the three write-up defects**: the Jacobi chains as elementwise statements; $[\mathfrak h,\mathfrak h]\perp\mathfrak m$ derived rather than assumed; and "$T$ is supported on $(\mathfrak m,\mathfrak m,\mathfrak h)$" narrowed to the rows through $\mathfrak m$.
4. **Stop calling routes (i) and (ii) independent.** They are two derivations of $\dim\mathfrak h=n(n-2)/4$ feeding one classification step. Give the classification its own audit, and replace the $n=6,\dots,16$ case list with the $t^2=0$ identity plus the remark that $\dim\mathfrak g^\theta$ is an $\mathrm{Aut}$-invariant.

## Reproduction

[scripts/reviewers/r328/core.py](../scripts/reviewers/r328/core.py) (structure constants, $\mathcal W_n$, $\#$, $Q$, criticality, Weyl distance), [points.py](../scripts/reviewers/r328/points.py) (sphere products, tori, $W_{\mathbb{CP}^2}$, paddings), [lemma70.py](../scripts/reviewers/r328/lemma70.py) ($D$, saturation, the bracket structure), [mass.py](../scripts/reviewers/r328/mass.py) (M3), [search.py](../scripts/reviewers/r328/search.py) and [run_hunt.py](../scripts/reviewers/r328/run_hunt.py) (M4 hunt). Log: [agent_logs/r328-lemma71.log](../agent_logs/r328-lemma71.log).
