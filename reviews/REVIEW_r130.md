# Gate 2 review 130, the vertex matrix as a graph Laplacian

Cold review of commit 546757b, commit 5da5126, commit b764ebf, commit f135fc1, commit 6d0b5bf, commit 2ecd2b0 and the sections they add to [findings/diagonal-half.md](findings/diagonal-half.md) and [findings/target.md](findings/target.md). Every convention was rebuilt from the brief's definitions before the record's scripts were opened; the sharp product's sign was fixed independently by demanding $I\#I=(n-2)I$, which reproduces the record's "$c^2=1$ on triangles" normalisation.

## Verdicts

| Claim | Verdict |
|---|---|
| A, $K^2-\lambda K=L(K_{ab}^2)$, PSD | CONFIRMED as an identity; **OVERSTATED** in scope, twice |
| B ($E$ hollow for every $W$, every $\lambda$ | CONFIRMED and **vacuous**), true of any real symmetric hollow matrix |
| C, closed form for $E_{ab}$ at a critical point | CONFIRMED, to $1.2\times10^{-16}$, including at off-locus critical points |
| D, $(W^2)_{(ab),(ab)}=K_{ab}^2+\lVert F_{(ab)}\rVert^2$ | CONFIRMED unconditionally |
| E, both brackets vanish together on the locus | CONFIRMED; the normalisation the brief flagged resolves in the record's favour |
| F, $W\#I=-W$, $\operatorname{tr}(W^\#)=-\lVert W\rVert^2$, summed equation vacuous | CONFIRMED, with the numbered lemma statement below |
| G, the PSD statement fails off the locus, and fails maximally | **FALSE as concluded.** Witnesses below. The measurements are right; the sentence drawn from them is not |
| H, counting corollary $r\le2/\lambda^2$, $r=1$ at $\theta_0(12)$ | CONFIRMED; the factor-of-two hazard does not bite. Two silent hypotheses |

## A, the Laplacian identity

The derivation reconstructs exactly. The off-diagonal half of $K^{\circ2}+K^2=\lambda K+D$ gives $(K^2-\lambda K)_{ab}=-K_{ab}^2$ for $a\ne b$; hollowness gives $(K^2-\lambda K)_{aa}=\sum_bK_{ab}^2$. That is $L(w)$ with $w_{ab}=K_{ab}^2$, and $v^{\mathsf T}L(w)v=\tfrac12\sum w_{ab}(v_a-v_b)^2\ge0$. Verified at $S^3{\times}S^3$, $S^4{\times}S^4$, $S^3{\times}S^4$, $S^6{\times}S^6$: $\lVert K^2-\theta K-L\rVert_\infty\le6\times10^{-17}$.

Two scope errors, both in the same sentence at the end of the new material.

- **It uses criticality essentially.** The diagonal entry is criticality-free; the off-diagonal entry $-K_{ab}^2$ is the vertex equation at $(ab)$ and nothing else. Away from a critical point $\lambda$ has no definition, so the statement is not merely unproved off criticality, it is not posed. The correct scope is **diagonal critical points**, and the write-up says so in its own derivation ("On the diagonal locus the criticality equation is …") before contradicting itself in the closing sentence.
- **Naming it a Laplacian adds no proof.** $L(K^{\circ2})=\operatorname{diag}(\operatorname{diag}K^2)-K^{\circ2}$ holds for any symmetric hollow $K$ by definition, so "$K^2-\lambda K$ is a Laplacian" *is* the criticality equation rearranged, and the PSD proof is the same $\tfrac12\sum w(v_a-v_b)^2$ display already at [diagonal-half.md:112](findings/diagonal-half.md#L112). The commit says as much and is right to; the value is the name, not the argument.

## B, hollowness of $E$

True, and true of far more than Weyl tensors: for **any** real symmetric hollow $K$ and any scalar, $(K^2)_{aa}=\sum_bK_{ab}^2$ is the definition of $L$'s diagonal and $\lambda K_{aa}=0$. Verified at random $\lambda$ and random Weyl tensors, $n=5,6,7$: $\max|E_{aa}|\le7\times10^{-18}$.

The consequence drawn is where it goes soft. "So the diagonal of $K^2-\lambda K$ is the same function of $K$ off the locus as on it, and every bit of the off-locus failure is carried by off-diagonal entries" is a restatement of how $E$ was defined, $L$ was *built* to match that diagonal. Nothing about the off-locus failure is localised that was not localised by writing the definition down. The brief's item 3 asks whether "for every scalar $\lambda$" is coherent: it is coherent and it is the reason the claim is empty. A statement whose truth is independent of $\lambda$, of criticality, and of the Weyl symmetries is a statement about hollow matrices.

## C and D, the off-diagonal closed form

$D$ is exact and needs nothing: the row of $M$ at $(ab)$ has diagonal entry $K_{ab}$ and off-diagonal entries $F_{(ab),(cd)}$, so $(M^2)_{(ab),(ab)}=\sum_{(cd)}M_{(ab),(cd)}^2$. Verified to $2.8\times10^{-17}$ at random Weyl tensors, $n=5,6$.

$C$ follows from reading $Q(W)=\lambda W$ at $((ab),(ab))$, which gives $\lambda K_{ab}-K_{ab}^2=\lVert F_{(ab)}\rVert^2+(W^\#)_{(ab),(ab)}$, and then $E_{ab}=(K^2)_{ab}-\lambda K_{ab}+K_{ab}^2$. Verified to $1.2\times10^{-16}$ at sphere products **and at rotated (off-locus) critical points**.

commit 546757b's correction is not cosmetic and it is correct. Feeding a random non-critical Weyl tensor and a random $\lambda$ into the formula gives $\max|E_{ab}-\text{formula}|=0.28$ at $n=5$ and $0.27$ at $n=6$, the pre-correction wording, which put hollowness and the closed form under one criticality-free banner, was a real error and is now fixed.

## E, the triangle identification

The brief's item 2 is the right thing to check and it passes. The sign of $\#$ is not free: taking Hamilton's expression at face value gives $I\#I=-(n-2)I$, and only the opposite sign reproduces both the standard $I\#I=(n-2)I$ and the record's $\theta(w)=\sum w^3+3\sum_{\text{tri}}$. In that normalisation, for diagonal $W$,

$$(W^\#)_{(ab),(ab)}=\sum_{c}w_{ac}w_{cb}=(K^2)_{ab},$$

coefficient exactly $1$, with the cross-check $\langle W^\#,W\rangle=3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$ because each triangle is counted three times. Both brackets in C therefore vanish together on the locus. No rescaled-weights escape hatch exists.

## F, $W\#I=-W$ and the vacuous summed equation

Böhm–Wilking Lemma 2.1, located and read: for $R\in S^2_B(\mathfrak{so}(n))$, $R+R\#I=(n-1)R_I+\tfrac{n-2}2R_{\mathrm{Ric}_0}$, the right-hand side being the $\mathrm{Ric}\wedge\mathrm{id}$ part. The hypothesis is membership of $S^2_B$ (symmetric with first Bianchi) which Weyl tensors satisfy, so $\mathrm{Ric}=0$ gives $W\#I=-W$ with no extra condition. Verified to $1.8\times10^{-16}$ at random Weyl tensors, $n=5,6,7$. Sanity anchor: at $R=I$ the lemma returns $I\#I=(n-2)I$, matching my independently fixed sign.

The trace bridge is sound: $\operatorname{tr}(W^\#)=\mathrm{tri}(W,W,I)=\mathrm{tri}(W,I,W)=\langle W\#I,W\rangle=-\lVert W\rVert^2$, using the total symmetry of $\mathrm{tri}$, which holds in this convention. Verified to $2.2\times10^{-16}$. A second, independent route exists on the diagonal locus and is worth recording because it uses no lemma at all: $\operatorname{tr}W^\#=\sum_{a<b}\sum_cw_{ac}w_{cb}=\tfrac12\big[\sum_c(\textstyle\sum_aw_{ac})(\sum_bw_{cb})-\sum_{a,c}w_{ac}^2\big]=-\lVert W\rVert^2$ by zero row sums.

Vacuity of the summed vertex equation follows: $\lVert W\rVert^2+\operatorname{tr}(W^\#)=\lambda\operatorname{tr}W$ reads $1-1=0$. Confirmed. One presentational nit in [findings/target.md](findings/target.md): the gloss "i.e. $t/2+(1-t/2)=1$" is written under an equation whose right-hand side is $0$, so the display and its gloss report different quantities.

## G, FALSE as concluded, and the measurements were never a test

The tabulated numbers are all reproducible. The conclusion drawn from them is refuted by explicit witnesses, and the phenomenon they record is forced by a bound with no criticality in it.

### Witnesses: critical points off the diagonal locus where the statement HOLDS

$O(n)$ acts on the problem, $Q$ is equivariant, and $\theta$ is invariant, so a rotated sphere product is a critical point of the same $\theta$ that is **not** on the diagonal locus. Rotating $S^3{\times}S^3$ ($n=8$, $\theta=1.145644$) by $\exp(\varepsilon A)$ along a fixed random $A$:

| $\varepsilon$ | $\lVert F\rVert$ | $t=\operatorname{tr}K^2$ | $\min\operatorname{spec}(K^2-\theta K)$ | PSD | eigenvalues in $(0,\theta)$ |
|---|---|---|---|---|---|
| $0.20$ | $0.1148$ | $1.9737$ | $-2.0\times10^{-17}$ | yes | $0$ |
| $0.50$ | $0.2815$ | $1.8415$ | $-5.0\times10^{-17}$ | yes | $0$ |
| $0.80$ | $0.4353$ | $1.6211$ | $+3.9\times10^{-17}$ | yes | $0$ |
| $1.20$ | $0.6101$ | $1.2557$ | $-1.17\times10^{-1}$ | no | $1$ |

Criticality holds exactly along the whole path: $\lVert Q(W)-\theta W\rVert_\infty\le1.1\times10^{-16}$ and $\theta=1.145643924$ to nine digits at every $\varepsilon$. The same picture at $S^2{\times}S^3$ ($n=7$, PSD through $\lVert F\rVert=0.36$) and $S^6{\times}S^6$ ($n=14$, PSD through $\lVert F\rVert=0.26$).

So **$K^2-\lambda K\succeq0$ holds on an open neighbourhood of the diagonal locus inside the critical set**. The sentence "$K^2-\lambda K\succeq0$ is a property of the diagonal locus, not of criticality" is false, and the sub-question it closed is still open.

The mechanism paragraph fails with it. "Off the locus … the weights are no longer squares, and nothing keeps them nonnegative, so the free positivity argument is not weakened off the locus, it is simply unavailable." The effective weights $w_{ab}=-(K^2-\theta K)_{ab}$ stay strictly positive out to $\varepsilon=0.5$ ($\min w=+0.0064$), and at $\varepsilon=0.8$ five of $28$ are negative while the matrix is **still PSD**. Availability of the one-line argument and truth of the statement come apart in both directions.

### The catalogue's "maximal failure" is one line of arithmetic

"Every positive eigenvalue lies in $(0,\lambda)$" is the same statement as $\mu_1(K)<\lambda$, since $K$ is traceless and nonzero. And $\mu_1(K)^2\le\operatorname{tr}K^2=t$. So

$$\boxed{\;t<\lambda^2\ \Longrightarrow\ \text{every positive eigenvalue of }K\text{ lies in }(0,\lambda),\;}$$

with no criticality, no vertex equation, no $W^\#$ and no $C^{pq}$ anywhere in it. Every point in the table satisfies the hypothesis, in closed form:

| point | $t$ | $\lambda^2$ | $\mu_1(K)$ | $r$ |
|---|---|---|---|---|
| padded $W_{\mathbb{CP}^2}$, $n=6,8,12$ | $1$ | $3/2$ | $\sqrt{2/3}=0.8165$ | $1$ |
| $\mathbb{CP}^3$ | $3/4$ | $1.1111$ | $0.4743$ | $2$ |
| $\mathbb{CP}^4$ | $3/5$ | $0.9722$ | $0.3381$ | $3$ |
| $\mathbb{CP}^5$ | $1/2$ | $0.9000$ | $0.2635$ | $4$ |
| $\mathbb{CP}^6$ | $3/7$ | $0.8556$ | $0.2162$ | $5$ |

Derived, then checked to five digits. For $\mathbb{CP}^m$ with $n=2m$: $K_{ab}=3(n-2)/(n-1)$ on $J$-pairs and $-3/(n-1)$ otherwise, so $K=\tfrac3{n-1}[(n-1)P+I-J]$ with $P$ the $J$-pairing; hence spectrum $\{0,\ \tfrac{3n}{n-1}^{(m-1)},\ \tfrac{3(2-n)}{n-1}^{(m)}\}$, giving $r=m-1$ exactly, and after normalising by $\lVert W\rVert^2=12m(m^2-1)/(2m-1)$,

$$t=\frac3{m+1},\qquad \mu_1(K)=\sqrt{\frac{3m}{(2m-1)(m^2-1)}}\ \sim\ \frac{\sqrt{3/2}}{m}.$$

$\mu_1$ decays like $1/m$ while $\lambda$ stays $O(1)$, so "$1$ of $1$, $2$ of $2$, … $5$ of $5$" is the observation that a decaying quantity is below a bounded one. Likewise the $500$ random frames: at padded $W_{\mathbb{CP}^2}$ I measure $t\le0.544$ over $300$ frames at $n=6$, $\le0.376$ at $n=8$, $\le0.149$ at $n=12$, against $\lambda^2=1.5$, so $\mu_1\le0.74$ and $500/500$ is arithmetically forced. It restates that a tensor supported on a $4$-plane keeps almost no $\Lambda^2$-diagonal mass in a generic frame of $\mathbb R^{12}$.

### The record's own script had the diagnosis in it

Opened after forming the above. [scripts/review_r127_frames.py:31](scripts/review_r127_frames.py#L31) already prints the range of $t$ over each frame sweep, and [scripts/review_r127_frames.py:28](scripts/review_r127_frames.py#L28) already asserts that a random frame preserves both $\lambda$ and the criticality residual, so the record knew it was generating critical points off the diagonal locus, and it printed the quantity that explains every entry of the table. Two things were missing: the comparison of that printed $t$ against $\lambda^2$, and any frame rotation small enough to stay inside the region where the statement survives. The sweeps use uniform random $O(n)$, which lands far from the locus with probability one.

### What should replace the conclusion

The contrapositive is the useful statement, and it is derived rather than measured:

$$K^2-\lambda K\succeq0\ \Longrightarrow\ t\ \ge\ \lambda^2 ,$$

i.e. at least $\lambda^2/2$ of $\lVert W\rVert^2$ (about $76\%$ at $\lambda=\theta_0(12)$), must sit on the $\Lambda^2$ diagonal, with $t=2$ exactly on the locus and $t<2$ strictly off it. So the PSD property is a **frame-dependent near-diagonality condition**, not a locus-membership condition, and its failure margin is governed by $t$. Every catalogue point violates the necessary condition outright, which is why the catalogue never tested the question it was pointed at. The condition is necessary and not sufficient: $S^2{\times}S^3$ loses PSD at $t=1.40$ with $\lambda^2=1.20$, $S^6{\times}S^6$ at $t=1.68$ with $\lambda^2=1.59$.

## H, the counting corollary

Correct, and the factor-of-two hazard the brief flags does not bite. On the diagonal locus $\lVert W\rVert^2=\sum_{a<b}w_{ab}^2=1$, so $\lVert K\rVert_F^2=\operatorname{tr}K^2=2\sum_{a<b}K_{ab}^2=2$, the ordered sum, measured as $2.00000$ at four sphere products. $2/\lambda^2$ runs $1.256$–$1.524$ across them and $r=1$ in every case. Two hypotheses go unstated:

- $r\ge1$ is needed for "forces $r=1$" and is never said. It is free ($\operatorname{tr}K=0$ with $K\ne0$) but it is a step.
- The bound is only usable where $t$ is near $2$, which by the section above means near the diagonal locus. Off it $t$ shrinks and $r\le t/\lambda^2$ becomes vacuous or false, exactly as $\mathbb{CP}^6$ shows. The corollary inherits G's restriction rather than standing beside it.

Also: "$r=1$ at $\theta_0(12)$" is a statement about a critical point achieving the conjectured value, not about diagonal critical points generally. The write-up says "at the conjectured value" and is clean; the commit message drops the qualifier.

## Literature

Nothing here is a re-derivation of a named theorem, and nothing is missed. The two ingredients are textbook and are used correctly: a weighted Laplacian with nonnegative weights is PSD via $v^{\mathsf T}Lv=\tfrac12\sum w_{ab}(v_a-v_b)^2$ (Fiedler; any spectral graph theory text), and $M^2-\lambda M\succeq0\iff\operatorname{spec}(M)\cap(0,\lambda)=\emptyset$ is elementary. What is **not** a matrix-theory theorem is the identity $K^2-\lambda K=L(K^{\circ2})$ itself: for a general symmetric hollow zero-row-sum $K$ it is false, and here it holds only because it *is* the criticality equation rearranged. Searching the Seidel / association-scheme / signless-Laplacian literature for a gap theorem of this shape returns nothing applicable, the constraint that makes it work is the vertex equation, not the combinatorial structure. So the "standard name" is correctly claimed as a name and correctly not claimed as a citation.

## The single most load-bearing defect

**The closing sentence of commit f135fc1 ("$K^2-\lambda K\succeq0$ is a property of the diagonal locus, not of criticality"), is false, and the plan closed a live sub-question on it.** Rotated sphere products are critical points with $\lVert F\rVert$ up to $0.44$ where the statement holds with an empty gap and exact criticality residual $10^{-16}$. The catalogue that produced the opposite verdict consists entirely of points with $t<\lambda^2$, where the conclusion is forced by $\mu_1\le\sqrt t$ and carries no information about criticality at all.

**The fix.** Replace the conclusion with the derived necessary condition $t\ge\lambda^2$, state that the PSD property survives on a neighbourhood of the locus in the critical set, and re-open the sub-question in the form the catalogue could not reach:

> does $K^2-\lambda K\succeq0$ hold at every critical point with $t\ge\lambda^2$, and in particular on the whole connected component of the critical set containing the diagonal locus?

A search for the boundary should sweep $t$ downward from $2$ along paths of genuine critical points, which the rotation family supplies for free, rather than sampling a symmetric catalogue whose $t$ is an order of magnitude too small to be a test.
