# Reviewer 292, the symmetry defect on the diagonal locus

Cold adversarial audit of C1–C6 (original brief) and C7–C9 (addendum). Every number below comes from an implementation written from the definitions in [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) and [review_r30_core.py](../scripts/lib/review_r30_core.py); [b_defect_diagonal.py](../scripts/lib/b_defect_diagonal.py) was never opened or imported. The independent implementation reproduces the record's `defect()` to machine precision on ten controls (the four sphere products, $\mathbb{CP}^{2,3}$, the $C_5$ blow-up, padded $\mathbb{CP}^2$, random Weyl tensors at $n=6,8$): worst disagreement $0$ in $\Delta$, `total` and $S_{\mathfrak{mmm}}$.

## Verdicts

| Claim | Verdict | One-line reason |
|---|---|---|
| **C1** | **CONFIRMED** | Proved analytically; matches to $1.8\times10^{-15}$. It needs neither Ricci-flatness nor normalisation, see the vacuity note |
| **C2** | **CONFIRMED** | Immediate from C1 plus basis-independence of the trace; $1.1\times10^{-14}$. One tolerance caveat |
| **C3** | **CONFIRMED, over-attributed** | Identity and the exact deficit $-2\lVert M\mathbf 1\rVert^2$ both proved. But it is *not* a diagonal fact: it holds at every Weyl tensor, diagonal or not |
| **C4** | **CONFIRMED (exact arithmetic), REFUTED as implemented** | Both directions proved; the second conjunct is redundant. Explicit counterexample against the `tol = 1e-9` version |
| **C5** | **CONFIRMED, sharpened** | $S_{\mathfrak{mmm}} = 6\cdot\#\{\text{triangles of }G^-\}$ exactly, not merely "zero iff triangle-free" |
| **C6** | **PLAUSIBLE** | The $\ge$ half and non-attainment near the maximiser are proved (explicit family, and an exact proof at $n=4$); the $\le$ half is the diagonal case *with its equality case*, which [diagonal-half.md](../findings/diagonal-half.md) itself still lists as owed |
| **C7** | **CONFIRMED** | Proved; equivalent to criticality pair-by-pair. Strictly stronger than the record's $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$, not a restatement |
| **C8** | **CONFIRMED, but weaker than advertised** | True and non-vacuous; "uses no defect machinery" is false; it is *not* always sharp, and it loses to a bound already on the record |
| **C9** | **CONFIRMED, derivative** | It is exactly C7 summed over the positive edges, plus one extra use of $M\mathbf 1=0$ |

---

## Setup, fixed once

$\varphi_{ab}=E_{ab}-E_{ba}$ with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and the structure constants $c_{\alpha\beta\gamma}$ are $\pm1$ on triangles $\{a,b\},\{b,d\},\{a,d\}$ and $0$ otherwise. For $W=\mathop{\mathrm{diag}}(M)$ the eigenvectors are the $\varphi_{ab}$ with $\lambda_{ab}=M_{ab}$.

Two bookkeeping points the brief asked about, both settled in the affirmative:

- **Which slot of `T` is traced is immaterial.** $c$ is totally antisymmetric, so $T_{abc}=c_{abc}^2$ is totally *symmetric*. The `einsum('dab,ab->d', T, ...)` may contract any two slots.
- **The factor $2$ is pinned twice, independently.** Once by $\lVert\varphi\rVert_F^2=2$ against the $\tfrac12\mathop{\mathrm{tr}}$ pairing (which makes $c=\pm1$, not $\pm\sqrt2$), and once because $g_\delta$ sums over *ordered* $(\alpha,\beta)$, so each triangle contributes its two orientations. $\Delta$ itself counts each unordered pair once, since `g[p].sum()` runs over eigen-directions.

---

## C1, CONFIRMED

$g_{ab}=\sum_{\alpha\beta}c_{(ab)\alpha\beta}^2(\lambda_\alpha-\lambda_\beta)^2$. A nonzero $c$ forces $\{\alpha,\beta\}=\{(a,d),(b,d)\}$ for some $d\notin\{a,b\}$, each such $d$ contributing two ordered pairs with $c^2=1$. Hence

$$g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2 .$$

Worst deviation $1.78\times10^{-15}$ over 30 random Ricci-flat diagonal $M$ at $n=4,\dots,8$.

**Vacuity finding, C1 is curvature-free.** The derivation uses only that $W$ is diagonal in the pair basis with entries $M_{ij}$. It uses neither $M\mathbf 1=0$ nor $\sum_{a<b}M_{ab}^2=1$. Confirmed numerically: worst deviation $1.33\times10^{-15}$ over 18 draws of a *random symmetric hollow* $M$ with nonzero row sums. C1 is pure $\mathfrak{so}(n)$ structure-constant bookkeeping; every curvature hypothesis in the brief's preamble is inert for it. That is not a defect of C1, but it means C1 cannot be cited as evidence that $\Delta$ sees curvature.

Equivalent form used repeatedly below, also curvature-free:

$$\tfrac12 g_{ab}=\lVert M_a-M_b\rVert^2-2M_{ab}^2=s_a+s_b-2(M^2)_{ab}-2M_{ab}^2,\qquad s_a:=\sum_j M_{aj}^2 .$$

## C2, CONFIRMED

$g$ is the squared norm of the linear map $x\mapsto[\mathop{\mathrm{ad}}(x),W]$, so its trace over the strictly positive eigenspace is basis-independent, degenerate spectra (which the diagonal locus has in abundance) do not spoil it. The positive eigenspace is spanned by the $\varphi_{ab}$ with $M_{ab}>0$, giving the claimed formula. Worst deviation $1.07\times10^{-14}$ over 40 draws at $n=4,\dots,8$.

**Caveat, load-bearing for C4.** The claim says $M_{ab}>0$; the code says $\lambda>10^{-9}$. Those differ, and the difference is not small, see the counterexample under C4.

## C3, CONFIRMED, but the attribution is wrong

Summing C1 over unordered pairs, with $M_{aa}=0$ used to drop the $d=a,b$ terms and $\mathop{\mathrm{tr}}M^2=\sum_{a\ne b}M_{ab}^2=2$:

$$\sum_{a<b}g_{ab}=2(n-2)+2(n-2)-2\sum_{a\ne b}(M^2)_{ab}=4(n-2)-2\big(\lVert M\mathbf 1\rVert^2-2\big)=4(n-1)-2\lVert M\mathbf 1\rVert^2 .$$

So the exact statement is stronger than C3: the deficit is $2\lVert M\mathbf 1\rVert^2$, quantitatively. Verified, $n=4$: nonzero-row-sum draw gives `total` $=8.753909233$ against $4(n-1)-2\lVert M\mathbf1\rVert^2=8.753909233$; $n=5,6,7$ likewise to nine digits. A clean structured witness: $S^2\times S^2\times S^2$ at $n=6$ (three blocks of $2$, in-block $\tfrac12$, cross $-\tfrac14$) has $\lVert M\mathbf 1\rVert^2=1$ after normalisation and returns `total` $=18$ against $4(n-1)=20$.

**"$M\mathbf 1=0$ is used exactly once", TRUE for this proof.** It enters only through $\mathbf 1^{\mathsf T}M^2\mathbf 1=\lVert M\mathbf 1\rVert^2$ in the cross term. Hollowness of $M$ is used twice and the normalisation once, but those are not the hypothesis in question.

**Where it *is* hiding, and it matters, C3 is not a diagonal-locus fact.** In general $\sum_\delta g_\delta=4(n-2)-4\mathop{\mathrm{tr}}(W^{\#})$, and `total` $=4(n-1)$ holds at *every* Weyl tensor: random non-diagonal Weyl tensors at $n=5,6,7,8$ all return `total` $=4(n-1)$ to nine digits with $\mathop{\mathrm{tr}}(W^{\#})=-1.000000000$ exactly. The general identity needs **both** Ricci-flatness and first Bianchi, a symmetric operator that is Ricci-flat with Bianchi violated returns `total` $=13.65$ at $n=5$ (against $16$) and $18.18$ at $n=6$ (against $20$), with $\mathop{\mathrm{tr}}(W^\#)=-0.412,-0.546$. On the diagonal locus Bianchi is free, which is the *only* reason the failure there detects row sums alone. State C3 as: on the diagonal locus, where Bianchi is automatic, the failure of `total` $=4(n-1)$ detects exactly $\lVert M\mathbf 1\rVert^2$, and off it, the same identity is already available and detects the Bianchi defect too.

Structurally, C3 is C7 contracted with $w\equiv1$; the $\theta$ term drops out because $\sum_{a<b}M_{ab}=0$. That is why C3 survives without criticality while C7 does not.

## C4, CONFIRMED in exact arithmetic, REFUTED as implemented

**Proof of both directions.** $\Delta=0$ iff every edge of $G^+$ joins twins ($M_{ad}=M_{bd}$ for all $d\notin\{a,b\}$).

- *Cliques.* $a\sim b$ and $b\sim c$ give $M_{ac}=M_{bc}>0$, so $a\sim c$: $G^+$ is transitive and its components are cliques.
- *Twins across a component.* From the two twin relations, $M_{ab}=M_{ac}=M_{bc}$ for any triple in one component, which also covers $d=b$; so all of a component is mutually twin. Within-block entries are therefore all equal, cross-block entries are constant on $B\times B'$, and cross entries are $\le0$ by definition of $G^+$.
- *Converse.* If $M$ is block-constant with cross entries $\le0$ for *any* partition, a positive edge lies inside one block and both endpoints agree off the pair. So $\Delta=0$.

Verified: 432 located $\Delta=0$ points across eight block shapes, **zero** structural violations; 3000 block-constant draws with strictly negative cross values, **zero** with $\Delta>0$; the exactly-zero cross case (in-block $1$, cross $0$) returns $\Delta=0$ at sizes $[2,2],[3,2],[2,2,2]$.

**Three corrections to the statement as written.**

1. **The second conjunct is redundant.** Once "blocks" are *the components of $G^+$*, a cross entry is by definition not $>0$. "AND every entry between two distinct blocks is $\le0$" adds nothing. It only becomes a real hypothesis if "block" is loosened to an arbitrary partition, and under that reading the equivalence still holds, so the honest statement is "there exists a partition on which $M$ is block-constant with nonpositive cross values".
2. **Not vacuous, and it has a corollary the record wants.** $G^+$ is never empty on the diagonal locus: a row with zero sum and a nonzero entry has a positive entry, and $\lVert M\rVert>0$. And a **singleton $G^+$ block forces an identically zero row**, all its entries are cross entries, hence $\le0$, and they sum to $0$. So on the diagonal locus, $\Delta(M)=0$ together with $\ker W=0$ forces every block to have size $\ge2$: $M$ is a generalised sphere product, $k\ge2$ blocks of size $\ge2$, one positive constant inside each block and one nonpositive constant across each pair. This is the clean converse to the "$\ker W=0$ is load-bearing" note in [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py), on the diagonal locus, $\Delta=0$ *without* trivial kernel is already the sphere-product shape. $\Delta=0$ is also measure-zero: 4000 random Ricci-flat draws at $n=4,\dots,7$ produced no hit.
3. **The implemented $\Delta$ does not satisfy C4.** Counterexample, retypeable, $n=7$, $\varepsilon=5\times10^{-10}$, before normalisation:

   $$M_{ab}=\tfrac16\ (a,b\in\{0,1,2\}\text{ or }a,b\in\{3,4,5\}),\qquad M_{ab}=-\tfrac19\ (a\in\{0,1,2\},b\in\{3,4,5\}),$$
   $$M_{06}=+\varepsilon,\quad M_{16}=-\varepsilon,\quad M_{02}\mapsto\tfrac16-\varepsilon,\quad M_{12}\mapsto\tfrac16+\varepsilon,\quad\text{all other entries }0,$$

   symmetrised, then normalised. Row sums $2.8\times10^{-17}$, `is_weyl` **True**, `total` $=24.000000000=4(n-1)$. The record's `defect()` returns $\Delta=2.16\times10^{-17}$ (zero by any tolerance anyone would apply) while the exact C2 formula gives $\Delta=0.666667$. And $M$ is *not* block-constant on the components of $G^+$: after normalisation $M_{06}=9.49\times10^{-10}>0$ merges vertex $6$ into $\{0,1,2\}$, where $M_{62}=0$ against $M_{02}=0.316228$. So the "only if" direction fails for the tolerance-thresholded $\Delta$ by an $O(1)$ margin. The fix is to state C2/C4 about the exact $\Delta$, and to note that `defect()`'s $\lambda>10^{-9}$ cut makes $\Delta$ discontinuous at every zero crossing of an entry.

## C5, CONFIRMED, and sharper than stated

$T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is $1$ exactly on ordered triples of pair-indices forming a triangle, so summing over $\mathfrak m^{\times3}$ counts each triangle of $G^-$ six times:

$$S_{\mathfrak{mmm}}=6\cdot\#\{\text{triangles of }G^-\} .$$

Exact on 40 random Ricci-flat diagonal $M$ at $n=4,\dots,8$; zero mismatches. Note this is a *different normalisation from a different quantity* than the record's `S_structural = 3 x triangles` quoted in [b_c5_blowup.py](../scripts/lib/b_c5_blowup.py), the two should not be conflated. Basis-independence holds for the same reason as for $\Delta$: $\sum_{a,b\in\mathfrak m}\lVert P_{\mathfrak m}[v_a,v_b]\rVert^2$ is the squared tensor norm of a bilinear map, invariant under orthonormal change of basis inside $\mathfrak m$. Same tolerance caveat as C2.

## C6, PLAUSIBLE

Splitting the claim in two.

**$\sup\ge\theta_0(n)$: PROVED, with an explicit family.** Let $M^*$ be the balanced product on blocks $A=\{0,\dots,p-1\}$, $B=\{p,\dots,n-1\}$, $p=n/2$, and set $M(t)=M^*+tD$ normalised, with

$$D_{0,p}=D_{p,0}=1,\quad D_{0,p+1}=D_{p+1,0}=-1,\quad D_{1,p}=D_{p,1}=-1,\quad D_{1,p+1}=D_{p+1,1}=+1,$$

all other entries $0$. $D$ is symmetric, hollow, and has zero row sums, so $M(t)$ stays on the diagonal locus exactly (row sums $\le10^{-16}$). For small $t$ the strict signs are unchanged, so $G^-=K_{p,p}$ stays bipartite and $S_{\mathfrak{mmm}}=0$ *exactly*; and $\Delta(M(t))=\Theta(t^2)>0$. Measured:

| $n$ | $\theta_0(n)$ | $\theta_0-\theta$ at $t=10^{-3}$ | $\Delta$ | $S_{\mathfrak{mmm}}$ |
|---|---|---|---|---|
| 4 | 0.866025404 | $2.08\times10^{-5}$ | $4.27\times10^{-5}$ | 0 |
| 6 | 1.054092553 | $4.55\times10^{-5}$ | $1.73\times10^{-4}$ | 0 |
| 8 | 1.145643924 | $7.86\times10^{-5}$ | $4.39\times10^{-4}$ | 0 |
| 10 | 1.200000000 | $1.20\times10^{-4}$ | $8.89\times10^{-4}$ | 0 |
| 12 | 1.236033081 | $1.70\times10^{-4}$ | $1.57\times10^{-3}$ | 0 |

**$\sup\le\theta_0(n)$: not established here, and the record does not have it in the form C6 needs.** Unconstrained maximisation of $\theta$ over the whole diagonal Ricci-flat locus (400 BFGS restarts at $n\le9$, 200 above) returns exactly $\theta_0(n)$ at every even $n=4,6,8,10,12$, always at the balanced product with $\Delta\le2\times10^{-12}$ and $S=0$; the odd cases return $0.942809042, 1.095445115, 1.171080088, 1.217161239$ at $n=5,7,9,11$, matching $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$ to nine digits, so C6's restriction to even $n$ is necessary and correctly placed. But this is numerics. The clean statement in [findings/diagonal-half.md](../findings/diagonal-half.md), *"is the maximum $\theta_0(n)$, attained only at the balanced complete-bipartite weight?"*, is still posed there as what is owed, and non-attainment in C6 needs precisely that equality case. [findings/INDEX.md](../findings/INDEX.md)'s "proved outright at every $n\ge4$" and diagonal-half.md's open question are in tension; C6 should not be recorded as CONFIRMED until that is reconciled.

**$n=4$ is fully proved, and worth keeping as the model case.** The Ricci-flat diagonal locus at $n=4$ is one-dimensional up to sign: $M_{01}=M_{23}=x$, $M_{02}=M_{13}=y$, $M_{03}=M_{12}=z$ with $x+y+z=0$ and $x^2+y^2+z^2=\tfrac12$. Then $\theta=18xyz$, maximised at $\theta_0(4)=\sqrt3/2$ exactly when two of $x,y,z$ coincide (the balanced product), and

$$\Delta=8(y-z)^2$$

on the branch $x>0>y,z$, which vanishes exactly at the maximiser. So on that circle $\sup\{\theta:\Delta>0\}=\theta_0(4)$ and is not attained, C6 at $n=4$, with no numerics.

---

# Addendum: C7 – C9

## C7, CONFIRMED, and it *is* criticality

From C1, $\tfrac12g_{ab}=s_a+s_b-2(M^2)_{ab}-2M_{ab}^2$ unconditionally. The off-diagonal part of the vertex equation reads $(M^2)_{ab}=\theta M_{ab}-M_{ab}^2$, and substituting gives $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ exactly.

**Two points the brief asked for.**

- **It needs criticality, and needs exactly its off-diagonal half.** The step above is reversible: C7 holds at the pair $(a,b)$ **if and only if** the vertex equation holds at $(a,b)$. C7 is not a consequence of criticality, it is criticality rewritten in defect language. Numerically, at random non-critical diagonal Weyl points at $n=6$ (criticality residual $0.22$–$0.31$) the C7 error is $0.88$–$1.24$. The *diagonal* half of the quoted equation is vacuous: $(M^{\circ2})_{aa}=0$ and $(M^2)_{aa}=s_a$, so $\mathop{\mathrm{diag}}(s)$ is pure bookkeeping.
- **It is strictly stronger than $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$, not a restatement.** Contract C7 with $\lambda_{ab}=M_{ab}$: $\sum_{a<b}M_{ab}g_{ab}=2\sum_a s_a(M\mathbf 1)_a-4\theta\sum_{a<b}M_{ab}^2=-4\theta$, using $M\mathbf 1=0$ once and the normalisation once. So C7 $\Rightarrow$ the record's identity on the diagonal locus, and C7 is $\binom n2$ equations to the record's one. The converse fails on logical grounds the record itself supplies: [target.md](../findings/target.md) records that $\sum\lambda g=-4\theta$ **holds at non-critical Weyl tensors** (I reproduce this: $\le8.9\times10^{-16}$ at four non-critical diagonal points where C7 is off by $\sim1.2$), whereas C7 is equivalent to criticality. They are not the same statement in either direction of strength.

Contraction dictionary, which is the useful way to file all of this: C7 with weight $w\equiv1$ gives **C3** ($\theta$ cancels, because $\sum_{a<b}M_{ab}=0$); with weight $\lambda$ it gives the record's **$-4\theta$ identity**; with weight $\mathbb 1[M_{ab}>0]$ it gives **C9**, and dropping $g\ge0$ from that gives **C8**.

Verified at $10^{-16}$ at $S^2{\times}S^2$, $S^3{\times}S^3$, $S^4{\times}S^4$, $S^5{\times}S^5$, $S^6{\times}S^6$, $S^3{\times}S^5$, $S^2{\times}S^4$, $S^4{\times}S^8$, $S^5{\times}S^7$ and the $C_5$ blow-up.

## C8, CONFIRMED, with three corrections

The inequality $2\theta M_{ab}\le s_a+s_b$ is $g_{ab}\ge0$ under C7, with equality iff $g_{ab}=0$ iff $a,b$ are twins. Both are right, and the division step is legitimate only on $M_{ab}>0$, giving $\theta\le\min_{M_{ab}>0}(s_a+s_b)/(2M_{ab})$ for $\theta>0$.

**1. "The claimed proof uses no defect machinery" is false.** The stated route (drop all but two coordinates of $\lVert M_a-M_b\rVert^2$ to get $\ge2M_{ab}^2$), is *literally* $g_{ab}\ge0$, since $\tfrac12g_{ab}=\lVert M_a-M_b\rVert^2-2M_{ab}^2$. The two proofs are the same proof. Claiming defect-independence here is a presentational error, and it hides that the discarded quantity is exactly the thing $\Delta$ measures.

**2. Not vacuous, but the hypothesis that saves it is criticality, not Ricci-flatness.** Counterexample on the diagonal locus (Ricci-flat, unit norm, row sums $2.8\times10^{-16}$, non-critical), $n=6$, entries as printed:

```
[[ 0.        0.530103 -0.022935 -0.030690 -0.252600 -0.223878]
 [ 0.530103  0.       -0.083896  0.074492 -0.175720 -0.344979]
 [-0.022935 -0.083896  0.        0.156436 -0.039524 -0.010082]
 [-0.030690  0.074492  0.156436  0.       -0.155666 -0.044572]
 [-0.252600 -0.175720 -0.039524 -0.155666  0.        0.623510]
 [-0.223878 -0.344979 -0.010082 -0.044572  0.623510  0.      ]]
```

$\theta=0.745003$ and at the pair $(2,3)$, $2\theta M_{23}-(s_2+s_3)=+0.142208>0$. So C8 is false for a general diagonal Weyl operator; criticality is doing real work. (The same search over 60000 random hollow symmetric matrices without Ricci-flatness reaches $+0.338548$.)

**3. It is NOT always sharp, and where it is not, it loses to a bound already on the record.** The brief's two equality checks pass, $S^{n/2}\times S^{n/2}$ and the $C_5$ blow-up both give the minimum equal to $\theta$ to $10^{-16}$, but that is because both have twin positive edges, not because the bound is tight in general. A retypeable strict witness, an **exact** diagonal critical point at $n=6$ (criticality residual $2.8\times10^{-17}$, row sums $2.8\times10^{-17}$, $\sum_{a<b}M_{ab}^2=1$ to nine digits): $M=\sqrt{2/21}\cdot Z$ with

$$Z=\tfrac12\begin{pmatrix}0&-1&-2&2&2&-1\\-1&0&2&2&-2&-1\\-2&2&0&-1&-1&2\\2&2&-1&0&-1&-2\\2&-2&-1&-1&0&2\\-1&-1&2&-2&2&0\end{pmatrix}.$$

Here every $s_a=\tfrac72 c^2$ with $c=\sqrt{2/21}$, every positive edge carries $M_{ab}=c$, and

$$\theta=c=0.308606700,\qquad \min_+\frac{s_a+s_b}{2M_{ab}}=\tfrac72c=1.080123450 ,$$

a factor $3.5$ of slack, with $\Delta=40/7=5.714286$ and $S_{\mathfrak{mmm}}=12$ (two triangles in $G^-$). 197 further strict-with-$\theta>0$ critical points were located at $n=6$ alone. At this point the record's own sharpened $\lambda$-bound from [target.md](../findings/target.md), $\theta\le(|\lambda_{\min}|M-\lambda_{\mathfrak p}^{\min}\Delta)/4$, returns $0.661300$, **strictly better than C8's $1.080123$**. C8 does beat the unsharpened $|\lambda_{\min}|(4(n-1)-\Delta-G_0)/4=1.102167$ there. So: C8 ties the record at every catalogued point and loses to it away from them.

**4. $\theta\le0$.** The underlying inequality $2\theta M_{ab}\le s_a+s_b$ holds for every pair at every diagonal critical point regardless of the sign of $\theta$ (it is just $g_{ab}\ge0$), but the quotient form is vacuous once $\theta\le0$, since the right-hand side is $\ge0$. Witness: an exact $n=5$ diagonal critical point with $\theta=-0.942809042$, $\Delta=16$, where the bound reads $\theta\le1.885618$, true, useless.

## C9, CONFIRMED, and it is C7 summed over the positive edges

Sum C7 over $\{a<b: M_{ab}>0\}$. The left side is $\Delta$ (C2); on the right, $\sum_+(s_a+s_b)=\sum_a d_a^+s_a$ and $\sum_+M_{ab}=\tfrac12\lVert M\rVert_1$, the last step because $M\mathbf 1=0$ makes the total entry sum zero, so the positive part is half the $\ell^1$ norm. Hence $\Delta=2\sum_a d_a^+s_a-2\theta\lVert M\rVert_1$, which is C9. Verified to $\le1.4\times10^{-14}$ at all ten catalogued diagonal critical points; error $0.07$–$0.49$ at non-critical diagonal Weyl points, as it must be.

So the honest answer to the question asked: **no, C9 is not more than C7 summed over the positive edges**, the only added ingredient is $\sum_+M_{ab}=\tfrac12\lVert M\rVert_1$, and that is a *second* use of $M\mathbf 1=0$, worth flagging against C3's "used exactly once" bookkeeping (the two proofs are different, so there is no contradiction, but the record should not generalise "once").

## The two questions

**Is "min over positive edges" the right contraction of C7?** Among all contractions that use only $g\ge0$ (that is, all nonnegative weightings $w$), **yes, and provably so**. Minimising $\sum_{a<b}w_{ab}(s_a+s_b)$ subject to $2\sum_{a<b}w_{ab}M_{ab}=1$, $w\ge0$ is a linear program whose feasible vertices are $w=\tfrac1{2M_{ab}}e_{ab}$ over the positive edges; the optimum is at a vertex. Run at the $n=6$ witness the LP returns $1.080123450$, exactly C8's minimum. Nothing strictly stronger exists in that class.

Strictly stronger contractions exist only by refusing to discard $g_{ab}$. Keeping one coordinate of the row difference gives, for every positive edge and every $c\notin\{a,b\}$,

$$\theta\ \le\ \frac{(s_a+s_b)-(M_{ac}-M_{bc})^2}{2M_{ab}} ,$$

which at the $n=6$ witness improves $1.080123$ to $0.732941$. Keeping all coordinates is no longer a bound but the identity $\theta=[(s_a+s_b)-\tfrac12g_{ab}]/(2M_{ab})$, exact at every positive edge (deviation $1.1\times10^{-16}$). So C8 sits at one end of a ladder whose other end is an identity, and the whole content of the ladder is how much of $g_{ab}$ you can bound from below.

**Can C8 be pushed to a bound on $\theta$ free of $M$'s entries?** Not usefully, and there is a structural reason rather than a technical one. C8 is an **equality** at $S^{n/2}\times S^{n/2}$, where its right-hand side is exactly $\theta_0(n)$. Any relaxation of that right-hand side to a function of $n$ alone is therefore either $\ge\theta_0(n)$, in which case it is at best the diagonal conjecture restated, and proving it *is* the open problem, or it is false at the maximiser. The cheap routes are hopeless by orders of magnitude: from C9, $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\Delta/2\le(n-1)\sum_as_a=2(n-1)$, and the only entry-free lower bound available for $\lVert M\rVert_1$ is $\lVert M\rVert_1\ge\lVert M\rVert_2^2/\lVert M\rVert_\infty\ge1$, giving $\theta\le2(n-1)$. The bound is degree-$1$ homogeneous in $M$ and the normalisation is degree $2$, so an entry-free form needs an extra inequality tying $\max_+M_{ab}$ to the row norms $s_a$, which is the coupling [diagonal-half.md](../findings/diagonal-half.md) already identifies as the missing ingredient ("the two halves are not independent, and the coupling is what a proof has to use"). C8 restates that gap; it does not close any of it.

---

## Summary of corrections owed to the record

1. C3 should be recorded as the general Weyl identity $\sum_\delta g_\delta=4(n-2)-4\mathop{\mathrm{tr}}(W^\#)=4(n-1)$, with the diagonal-locus deficit $-2\lVert M\mathbf 1\rVert^2$ as its specialisation, and with first Bianchi named as a second hypothesis that the diagonal restriction hides.
2. C4's second conjunct is redundant under its own reading of "block"; and the corollary "$\Delta=0$ with $\ker W=0$ $\Rightarrow$ generalised sphere product, all blocks of size $\ge2$" should be stated, since a singleton $G^+$ block forces a zero row.
3. C5 should be recorded quantitatively: $S_{\mathfrak{mmm}}=6\cdot\#\text{triangles}(G^-)$, and kept distinct from `S_structural = 3 x triangles`.
4. C2/C4/C5 are statements about the exact $\Delta$; `defect()`'s $\lambda>10^{-9}$ cut breaks the "only if" of C4 by an $O(1)$ margin at a genuine Weyl point (witness above).
5. C7 should be recorded as *equivalent* to the diagonal criticality equation, and as the unsummed parent of C3, of $\sum\lambda g=-4\theta$ on the diagonal locus, and of C9.
6. C8's "no defect machinery" gloss should be removed (it is $g_{ab}\ge0$) and its sharpness claim should be qualified: sharp exactly when some positive edge joins twins, and beaten by the record's sharpened $\lambda$-bound at the $n=6$ witness.
7. C6 should stay open pending reconciliation of INDEX.md's "proved outright at every $n\ge4$" with diagonal-half.md's still-posed uniqueness question; the $n=4$ case is closed here in exact form.
