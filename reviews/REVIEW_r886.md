# Review r886, the small-orbit obstruction: Claims A (orbit dimension of $S^2\times S^{n-2}$), B ($d^\ast(n)-(2n-4)\in\{3,4\}$), C (no $(G3)$-derived bound improves on the standing bound), D (no $SO(n-1)$-invariant Weyl tensor)

**Standfirst.** The brief was cold: I worked from the definitions and givens supplied in the session brief at the absolute path /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r885-r886.md and read no findings file, plan, route or other review. Every number below is exact rational arithmetic in Python's [fractions](https://docs.python.org/3/library/fractions.html) at $n=4,\dots,2000$ plus closed-form polynomial identities that close the remaining $n$, and every structural statement is a representation-theoretic count done by hand and stated with its hypotheses. Log: [agent_logs/review-r886-orbitmin.log](../agent_logs/review-r886-orbitmin.log).

## Claim table

| Claim | Verdict | Reason in a clause |
| --- | --- | --- |
| **A**, orbit dimension $=2n-4$ | **CONFIRMED** | $\dim SO(n)-\dim(SO(2)\times SO(n-2))=2n-4$ exactly, and $(G7)$ pins the stabiliser's identity component for $n\ge5$. At $n=4$ the same value holds by a separate route, because $(G7)$'s maximality is false there ($SO(2)^2\subsetneq U(2)\subsetneq SO(4)$). |
| **A**, value $\theta^2=\frac{(n-1)(n-3)}{(n-2)^2}<1$ | **CONFIRMED** | $(G6)$ at $p=2$ gives exactly this, it is positive for $n\ge4$ and falls short of $1$ by $\frac1{(n-2)^2}$. |
| **B**, gap clause | **CONFIRMED, and extended** | $d^\ast(n)=2n-1$ for $7\le n\le24$ and $d^\ast(n)=2n$ for $n\ge25$, both proved in closed form, so the gap is $3$ then $4$ for every $n\ge7$ and the "checked to $1000$" worry is discharged rather than inherited. |
| **B**, asymptotic clause $d^\ast(n)=2n-1+o(1)$ | **REFUTED AS STATED** | $d^\ast$ is an integer and equals $2n$ for every $n\ge25$, so $d^\ast(n)-(2n-1)=1$ eventually rather than $o(1)$: it is the *real* threshold that is $2n-1+\tfrac2{n-1}-o(n^{-2})$. |
| **C**, the consequence | **CONFIRMED AS ALGEBRA, scope overstated** | The first sentence is valid for every $n\ge4$ and is nearly immediate from A and B, and the second sentence overreaches: positive excess is one way to pay the debt at the small-orbit points, an exact value or any other bound there is another, and the target inequality does not have to be proved through the trace-form bound at all. |
| **D**, no nonzero $SO(n-1)$-invariant Weyl tensor | **CONFIRMED, offered reasoning REFUTED AS STATED** | The conclusion holds for all $n\ge4$, but the Kulkarni-Nomizu step is a non-sequitur: it needs the count $\dim S^2(\Lambda^2\mathbb R^n)^{SO(n-1)}$, which is $2$ only for $n\ge6$, and at $n\in\{4,5\}$ a third invariant exists and must be killed by the first Bianchi identity. |
| **D**, the inference $d>n-1$ | **REFUTED at $n=4$, HYPOTHESIS-DEBT for $n\ge5$** | At $n=4$ the $U(2)$-invariant Kähler Weyl tensor is a critical point with $d=2\le n-1$. For $n\ge5$ the inference needs the classification of connected $H\subseteq SO(n)$ with $\dim H\ge\dim SO(n-1)$, whose $n=8$ member $Spin(7)$ is a genuine extra case (excluded below by a separate count). |

**One line the cycle can act on.** The small-orbit obstruction is real and the arithmetic is exact, so the debt is "excess $\ge3$ at $S^2\times S^{n-2}$ for $7\le n\le24$ and $\ge4$ for $n\ge25$", which is a *small* demand against the $m\le4(\kappa/\theta^2-1)\approx2n^2$ that the trace conditions permit at that point: compute $p$ and $m$ there directly instead of arguing about whether $(G3)$ suffices, and repair Claim D, whose stated conclusion is false at $n=4$.

## 0. Conventions, fixed once

Quoted from the brief.

- $n\ge4$ an integer. $\mathcal W_n$ is the space of Weyl tensors in dimension $n$: algebraic curvature tensors that are Ricci-flat and satisfy the first Bianchi identity. $D:=\dim\mathcal W_n$.
- The norm is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$. A **critical point** is $W$ with $\lVert W\rVert=1$ and $Q(W)=\theta W$; then $\theta=P(W)$.
- $O(n)$ acts orthogonally on $\mathcal W_n$. For a critical point $W$, $d:=\dim(O(n)\cdot W)$ is its orbit dimension.
- $L_x$ is the multiplication operator of the commutative nonassociative algebra on $\mathcal W_n$ whose cubic form is $P$; for $\theta\ne0$, $e:=W/\theta$ is an idempotent. $m:=\dim E_{1/2}(L_e)$.
- $(G4)$: with $p=\dim E_1(L_e)$ and $k=D-p-m$, $\theta^2\le\kappa(n)\big/\big(p+\tfrac m4+\tfrac{(2p+m)^2}{4k}\big)=:B(n,p,m)$, and $p=1$ throughout.
- $d^\ast(n)$ is the least integer $d$ with $B(n,1,d)\le S(n)^2$.

## Hypothesis inventory

Every hypothesis carried by the claims and by what I import, checked against the object it is applied to.

| # | Hypothesis | Applies to | Status against that object | Used by the argument? |
| --- | --- | --- | --- | --- |
| H1 | $n\ge4$, so that $\mathcal W_n\ne0$ | all claims | Holds: $D(4)=10$, $D(5)=35$, $D(6)=84$ from $(G1)$, all matching the known dimensions of the Weyl module | Yes |
| H2 | $p,q\ge2$ in $(G6)$ | the family $S^2\times S^{n-2}$ | Forces $n\ge4$, and at $n=4$ the family is $S^2\times S^2$ and $\theta^2=3/4$ | Yes, silently: Claim A never says the family starts at $n=4$ |
| H3 | $SO(2)\times SO(n-2)$ maximal connected in $SO(n)$, from $(G7)$ | stabiliser of the $S^2\times S^{n-2}$ Weyl tensor | **Fails at $n=4$**: $SO(2)\times SO(2)\subsetneq U(2)\subsetneq SO(4)$. Holds for $n\ge5$ | Yes, load-bearing for $d=2n-4$ |
| H4 | No nonzero $O(n)$-invariant vector in $\mathcal W_n$, from $(G7)$ | excluding $\mathrm{Stab}^0=SO(n)$ | Needs the *$SO(n)$*-invariant version. Free for odd $n$ ($-I$ acts trivially and $O(n)=SO(n)\times\{\pm I\}$), and for even $n$ it needs the absence of a $\det$-twisted invariant, which holds (§6.2) | Yes, load-bearing, and stated one notch too weak |
| H5 | $\theta\ne0$, so $e=W/\theta$ exists | $(G2)$, $(G4)$, hence $d^\ast$ | Holds at the $S^2\times S^{n-2}$ point, where $\theta^2\ge3/4>0$. Fails at $\theta=0$ critical points, where the trace-form bound says nothing | Yes for the comparison, and harmless (§7.2) |
| H6 | $p=\dim E_1(L_e)=1$ | the comparison $B$ versus $S^2$ | $p\ge1$ always since $L_ee=e$. $B$ is strictly decreasing in $p$ (checked: $B(12,p,20)=10.41,8.92,7.80,6.93,6.24$ for $p=1..5$), so $p=1$ is the worst case and the conservative choice | Yes, and legitimately |
| H7 | $k=D-p-m>0$ | $(G4)$'s Cauchy-Schwarz step | Holds throughout the range used, $d^\ast\approx2n\ll D\approx n^4/12$ | Yes |
| H8 | $L_e$ symmetric with real spectrum | $(G4)$ | Given by the metrised algebra structure, not audited here | Yes, imported |
| H9 | $(G5)$ bounds $\theta$, $(G4)$ bounds $\theta^2$ | the word "improvement" | $B\le S^2\iff\sqrt B\le S$, so the comparison is the right one for the upper bound on $\theta$. $(G4)$ is nonetheless new information about $\theta<0$, where a one-sided $(G5)$ says nothing | Not used, and it qualifies Claim C (§4.3) |
| H10 | Connected $H\subsetneq SO(n)$ with $\dim H\ge\dim SO(n-1)$ is conjugate to $SO(n-1)$ | Claim D's inference $d>n-1$ | **False at $n=4$** ($U(2)$, dimension $4>3$) and **incomplete at $n=8$** ($Spin(7)$, dimension $21=21$). Holds otherwise | Yes, load-bearing and unstated |
| H11 | $Q$ is $O(n)$-equivariant | the fixed-point criticality argument of §6.4 | Holds, $Q$ is built from the $O(n)$-invariant algebra structure | Yes, by me |

## 1. Claim A's orbit dimension (item 1)

### 1.1 The arithmetic

$$\dim SO(n)-\dim\big(SO(2)\times SO(n-2)\big)=\frac{n(n-1)}2-1-\frac{(n-2)(n-3)}2=\frac{(n^2-n)-(n^2-5n+6)}2-1=\frac{4n-6}2-1=2n-4.$$

Checked at $n=4,5,8,12,20$: $4,6,12,20,36$. The figure $2n-4$ is right, and it is worth recording what it is: $2n-4=2(n-2)=\dim\mathrm{Gr}(2,n)$, the dimension of the Grassmannian of $2$-planes, which is what the orbit essentially is.

### 1.2 Is the stabiliser exactly $SO(2)\times SO(n-2)$?

The Weyl tensor of a product metric at a point depends only on the orthogonal splitting $\mathbb R^n=\mathbb R^2\oplus\mathbb R^{n-2}$, so it is fixed by the isotropy of that splitting, which contains $SO(2)\times SO(n-2)$. That group is connected, hence sits inside $\mathrm{Stab}^0$, and so $\mathrm{Stab}^0$ is a connected subgroup containing it. By $(G7)$'s maximality, $\mathrm{Stab}^0\in\{SO(2)\times SO(n-2),\,SO(n)\}$. The second would make $W$ an $SO(n)$-invariant nonzero vector of $\mathcal W_n$, and $d=\dim SO(n)-\dim\mathrm{Stab}^0=2n-4$ follows once that is excluded.

What $(G7)$ gives and does not give:

- It gives maximality, which is exactly the step that turns "the stabiliser contains this group" into "the orbit has this dimension". Without maximality one gets only $d\le2n-4$, which is the direction Claim C wants, so the exposure here is benign.
- It gives *$O(n)$*-invariance in the second clause, and the argument needs *$SO(n)$*-invariance to be excluded. For odd $n$ the two coincide, because $-I\notin SO(n)$ is central with $\det=-1$, giving $O(n)=SO(n)\times\{\pm I\}$, and $-I$ acts trivially on a $4$-tensor. For even $n$ the $SO(n)$-invariants form an $O(n)$-submodule on which $O(n)/SO(n)$ could act by $\det$, and ruling that out needs §6.2's observation that the only $\det$-twisted candidate is a $4$-form, available only at $n=4$, where the first Bianchi identity kills it.
- It gives nothing about components, and nothing is needed: $O(2)\times O(n-2)$ and $SO(2)\times SO(n-2)$ have the same dimension, and $O(n)\cdot W$ is a finite union of $SO(n)$-orbits of equal dimension.
- It fails at $n=4$. $SO(2)\times SO(2)$ is a maximal torus of $SO(4)$ and sits inside $U(2)$, which sits inside $SO(4)$, so maximality is false and the argument as offered proves nothing at the smallest admissible $n$. **Claim A survives at $n=4$ by a different route**: $\mathcal W_4=S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$ (dimension $5+5=10=D(4)$, consistent with $(G1)$), every $g\in SO(4)$ preserves the splitting, so $\mathrm{Stab}(W)=\mathrm{Stab}(W^+)\cap\mathrm{Stab}(W^-)$. For $S^2\times S^2$ both halves are nonzero of Kähler type, with eigenvalues proportional to $(2,-1,-1)$ on $\Lambda^2_\pm$, so each stabiliser has identity component $SO(2)$ in the respective $SO(3)$ factor, giving $\dim\mathrm{Stab}^0=2$ and $d=6-2=4=2n-4$.

### 1.3 Which direction an error would move Claim C

A larger stabiliser gives a smaller orbit and strengthens Claim C, a smaller one weakens it. Since only the inclusion $\mathrm{Stab}^0\supseteq SO(2)\times SO(n-2)$ is needed for $d\le2n-4$, and that inclusion is immediate from the product structure, **Claim C is insensitive to the maximality half of $(G7)$**. No finding here beyond the $n=4$ repair.

## 2. Claim A's value, and that the tensor is nonzero (item 2)

$(G6)$ at $p=2$, $q=n-2$:

$$\theta^2=\frac{2(n-1)(2-1)(n-3)}{(n-2)\cdot2(n-2)}=\frac{(n-1)(n-3)}{(n-2)^2},$$

which is Claim A's value exactly. It is $<1$ because $(n-1)(n-3)=(n-2)^2-1$, so the deficit is exactly $\frac1{(n-2)^2}$: $\theta^2=3/4,\,8/9,\,15/16,\,24/25,\,35/36,\,99/100$ at $n=4,5,6,7,8,12$, increasing to $1$ from below. No finding.

Nonzero, and where the family lives:

- $\theta^2>0$ requires $n-3\ge1$, so the family exists for $n\ge4$ and the value is nonzero throughout. Since $\lVert W\rVert=1$ by the normalisation in the definition of a critical point, $W\ne0$ is automatic, and $\theta\ne0$ is the stronger statement that matters: it is what makes $e=W/\theta$ and hence $m$ defined at all (H5).
- Independently: the product of two round spheres of dimension $\ge2$ has nonvanishing Weyl tensor, so the tensor is a genuine nonzero element of $\mathcal W_n$ and not a degenerate member of the family.
- Claim A says "the Weyl tensor of $S^2\times S^{n-2}$" without a range for $n$. It should carry $n\ge4$, and the $n=4$ case needs §1.2's separate argument. One presentational finding, no mathematical one.

## 3. Claim B as arithmetic (item 3)

### 3.1 The comparison reduces to one clean inequality

With $p=1$, $B(n,1,d)\le S(n)^2$ is equivalent to $1+\frac d4+\frac{(2+d)^2}{4(D-1-d)}\ge\frac{\kappa(n)(n+1)}{(n-1)^2}=\frac{(2n-1)(n+1)}{4(n-1)}$. Multiplying by $4$ and using $\frac{(2n-1)(n+1)}{n-1}=2n+3+\frac2{n-1}$:

$$\boxed{\;d+\frac{(2+d)^2}{D-1-d}\;\ge\;2n-1+\frac2{n-1}\;}$$

This is exact, and the reduction is where the value $2n-1$ in Claim B comes from. I confirmed it reproduces $d^\ast$ computed brute-force from $(G4)$ at $n=4,5,6,7,8,12,20,25,50,100,1000$, agreeing at every one.

### 3.2 Exact values

| $n$ | $D$ | $\kappa(n)$ | $S(n)^2$ | $d^\ast(n)$ | $2n-4$ | gap | $\theta^2$ at $S^2\times S^{n-2}$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | 10 | 21/4 | 9/5 | 4 | 4 | **0** | 3/4 |
| 5 | 35 | 9 | 8/3 | 7 | 6 | **1** | 8/9 |
| 6 | 84 | 55/4 | 25/7 | 10 | 8 | **2** | 15/16 |
| 7 | 168 | 39/2 | 9/2 | 13 | 10 | 3 | 24/25 |
| 8 | 300 | 105/4 | 49/9 | 15 | 12 | 3 | 35/36 |
| 12 | 1638 | 253/4 | 121/13 | 23 | 20 | 3 | 99/100 |
| 20 | 13090 | 741/4 | 361/21 | 39 | 36 | 3 | 323/324 |
| 24 | 27300 | 1081/4 | 529/25 | 47 | 44 | 3 | 483/484 |
| 25 | 32175 | 294 | 288/13 | 50 | 46 | **4** | 528/529 |
| 50 | 519350 | 4851/4 | 2401/51 | 100 | 96 | 4 | 2303/2304 |
| 1000 | 83332749500 | 1997001/4 | 998001/1001 | 2000 | 1996 | 4 | 996003/996004 |

The four values the brief asked for: $d^\ast(8)=15$, $d^\ast(12)=23$, $d^\ast(20)=39$, $d^\ast(50)=100$, with gaps $3,3,3,4$. Supporting exact fractions at $n=8$: $B(8,1,12)=\tfrac{1435}{228}=6.2938\ldots>S(8)^2=\tfrac{49}9=5.4\overline4$, $B(8,1,14)=\tfrac{29925}{5386}=5.5552\ldots>\tfrac{49}9$, and $B(8,1,15)=\tfrac{1988}{379}=5.2453\ldots\le\tfrac{49}9$. So $d^\ast(8)=15$ with the change of sign between $14$ and $15$, and the gap clause holds at $n=8$.

Two facts the brief did not state and the record should: **the gap is $3$ only up to $n=24$ and $4$ from $n=25$ on**, and **at $n\le6$ the gap is $0$, $1$ or $2$**, so Claim B's restriction to $n\ge8$ is doing real work. At $n=4$ the gap is exactly $0$, meaning $B(4,1,4)=\tfrac{105}{76}=1.3816<\tfrac95=S(4)^2$ strictly, so an orbit bound $d\ge4$ at $n=4$ would make the trace-form bound a strict improvement. (That escape is closed by §6.4, which shows $d=2$ occurs at $n=4$.)

### 3.3 Closing all $n$, so that no asymptotic debt remains

Both thresholds are polynomial, and I verified the two expansions symbolically against the definitions at $n=4..199$.

**$d^\ast\ge2n-1$ for $n\ge7$.** The failure of $d=2n-2$ is $\;4n^2/(D-2n+1)<1+\frac2{n-1}$, that is $g(n):=(n+1)(D-2n+1)-4n^2(n-1)>0$, and $12\,g(n)=n^5+n^4-55n^3+11n^2-18n+12=n^3(n^2+n-55)+11n^2-18n+12$. For $n\ge7$, $n^2+n-55\ge1>0$ and $11n^2-18n+12>0$, so $g>0$. ($12g(7)=768$, the margin being genuinely thin at the left end, and $g(6)<0$, which is why $d^\ast(6)=10=2n-2$.)

**$d^\ast\le2n$ always.** At $d=2n$ the left side of §3.1 is $2n+\text{(positive)}$, exceeding $2n-1+\frac2{n-1}$ whenever $\frac2{n-1}<1$, that is $n\ge4$.

**The gap is $3$ exactly when $d=2n-1$ already works**, that is $\frac{(2n+1)^2}{D-2n}\ge\frac2{n-1}$, that is $f(n):=2(D-2n)-(n-1)(2n+1)^2\le0$, and $6f(n)=n^4-24n^3-7n^2-12n+6=n^3(n-24)-7n^2-12n+6$. For $n\ge25$, $n^3(n-24)\ge n^3\ge25n^2>7n^2+12n-6$, so $f>0$ and the gap is $4$. Explicit check: $f\le0$ for $4\le n\le24$ and $f>0$ for every $n$ in $[25,2000]$, with $f(25)=1826$ growing.

Hence, in closed form and for **every** $n$:

$$d^\ast(n)=\begin{cases}2n-1,&7\le n\le24,\\2n,&n\ge25,\end{cases}\qquad d^\ast(n)-(2n-4)=\begin{cases}3,&7\le n\le24,\\4,&n\ge25.\end{cases}$$

So Claim B's gap clause is **confirmed on its stated range and extended to all $n\ge7$**, and the objection the brief anticipated (a claim checked to $1000$ and asserted for all $n$) does not arise, because the quartic settles the tail.

### 3.4 The asymptotic clause is off by one

The brief's own asymptotic reasoning is sound as far as the *real* threshold goes: the correction $\frac{(2+d)^2}{D-1-d}$ is $O(n^2/n^4)=O(n^{-2})$ at $d\asymp n$, so the real solution of §3.1 is $2n-1+\frac2{n-1}-O(n^{-2})$. But $d^\ast$ is defined as the least *integer*, the offset $\frac2{n-1}$ is positive and dominates the $O(n^{-2})$ correction for $n\ge25$, and therefore the least integer is $2n$, not $2n-1$. "Asymptotically $d^\ast(n)=2n-1+o(1)$" is false for every $n\ge25$: the true statement is $d^\ast(n)=2n$ for $n\ge25$, and $2n-1+\frac2{n-1}-o(n^{-2})$ for the real threshold. **Finding, recorded as REFUTED AS STATED.** It does not touch Claim C, which needs only $2n-4<d^\ast$, and the correction moves $d^\ast$ *up*, so Claim C is strengthened by one.

### 3.5 Can the gap close at any $n$?

No, for $n\ge7$, by §3.3: the gap is exactly $3$ or exactly $4$ and never $0$, so $2n-4<d^\ast(n)$ for every $n\ge5$. The one place it closes is $n=4$, where $d^\ast(4)=4=2n-4$. Claim B's "so $2n-4<d^\ast(n)$ throughout" is therefore true on its stated range and for all $n\ge5$, and false at $n=4$ with equality.

## 4. Claim C's logic (item 4)

### 4.1 What A and B establish, on the brief's own three readings

- **(i) $\min_W d\le2n-4$.** Established. A exhibits one critical point with $d=2n-4$, so the minimum over critical points is at most that. This is all that A and B deliver about the population of orbit dimensions.
- **(ii) every critical point has $d\le2n-4$.** Not established, and false in general. Kernel-supported critical points already have $d\approx n'n$ (§7.1), and nothing in A or B bounds $d$ from above at other points. Anyone citing A and B for (ii) is misciting them.
- **(iii) no bound from $(G3)$ can discharge the debt.** Established, and it is (iii) that is needed. The reasoning: $(G3)$ is a pointwise statement $m(W)\ge d(W)$, so the strongest conclusion it supports through the monotone $B$ is $\theta(W)^2\le B(n,1,d(W))$ at each critical point. A *uniform* bound over critical points is therefore at least $\sup_WB(n,1,d(W))\ge B(n,1,2n-4)>S(n)^2$, the last inequality being exactly $2n-4<d^\ast(n)$. Knowing the whole distribution of $d$ does not help, because the supremum is controlled by the smallest $d$ that occurs, and A pins one.

So Claim C's first sentence follows, and it follows from (i) alone plus B: (ii) is never needed. The chain is $\;A\Rightarrow(i)\;$, $\;(i)+B\Rightarrow(iii)\;$, and (iii) is the claim.

### 4.2 Where it overreaches

Claim C's second sentence, "Any proof that it improves must supply positive excess at the small-orbit critical points, at every $n$", is true only under the narrow reading "any proof that *the trace-form bound itself*, applied uniformly with $p=1$, improves". Three ways out that the sentence forbids and the mathematics does not:

1. **The value is known at those points.** At $S^2\times S^{n-2}$, $\theta^2=\frac{(n-1)(n-3)}{(n-2)^2}<1\ll S(n)^2\approx n$. A proof of a better uniform bound on $\theta$ may handle small-orbit points by classification and exact evaluation and use the trace-form bound only where $d\ge d^\ast$. Such a proof supplies no excess anywhere and still improves on $(G5)$. Claim C forbids it by wording alone.
2. **$p$ is not $1$ at those points.** $B$ is strictly decreasing in $p$ (H6), and $p=\dim E_1(L_e)$ at the highly symmetric point $S^2\times S^{n-2}$ is plausibly larger than $1$. Larger $p$ at a fixed $m=d$ can bring $B$ below $S^2$ with excess exactly zero. This is information about that point rather than about $(G3)$, so Claim C's first sentence survives, and its second sentence is wrong to name excess as the only currency.
3. **The bound is two-sided.** $(G5)$ as given bounds $\theta$ from above only, while $(G4)$ bounds $\theta^2$. At critical points with $\theta<0$, $(G3)$ plus $(G4)$ deliver $\theta\ge-\sqrt{B}$, which is new whatever the comparison with $S(n)^2$ says. "No improvement" is therefore false read as "no new information".

### 4.3 Verdict on C

The first sentence is **CONFIRMED AS ALGEBRA** for every $n\ge4$ (including $n=4$: see §6.4, where a critical point with $d=2<4=d^\ast(4)$ exists, so the $n=4$ escape route opened in §3.2 is closed). The second sentence should be rewritten as: *any proof that proceeds through the trace-form bound at $p=1$ at the small-orbit critical points must supply positive excess there, at every $n\ge5$.* Recorded as a scope finding rather than a mathematical one.

## 5. Is Claim C vacuous or circular? (item 5)

Not circular: A, B and C have no shared premise beyond $(G4)$'s monotonicity, and C is a statement about what $(G3)$ implies rather than about the truth of the target inequality.

Not vacuous, but weaker than it looks, for a reason the brief anticipated and a second reason it did not.

**The excess at $S^2\times S^{n-2}$ may be large.** What would have to be known is the pair $(p,m)$ at that point, and both are computable in closed form and in finite time: decompose $\mathcal W_n$ into $SO(2)\times SO(n-2)$ isotypic pieces and diagonalise $L_e$ on each. This is a structured finite computation on an object in hand rather than a search, so it is the obvious next move. Claim C survives not knowing it, because Claim C is a statement about $(G3)$ and not about the point: even if $m=100d$ there, $(G3)$ still yields only $m\ge d$, and a proof that uses the larger value has imported something beyond $(G3)$, which is precisely what Claim C asserts must happen. So C is close to a tautology once A and B are in hand, and its value is as a bookkeeping statement about which hypothesis is doing the work.

**What the trace conditions already permit.** At the $S^2\times S^{n-2}$ point, $(G2)$ gives $\mathop{\mathrm{tr}}L_e^2=\kappa/\theta^2=\frac{(2n-1)(n-2)^2}{4(n-3)}$, which is $27$ at $n=8$, $\tfrac{575}9$ at $n=12$, $\tfrac{3159}{17}$ at $n=20$ and $\tfrac{57024}{47}$ at $n=50$, growing like $n^2/2$. Since $\mathop{\mathrm{tr}}L_e^2\ge p+\tfrac m4$, the trace permits any $m$ up to $4(\kappa/\theta^2-1)$, which is $104$ at $n=8$ and $\approx2n^2$ asymptotically, against a demand of $m\ge d^\ast=2n-1$ or $2n$. **The debt is excess $\ge3$ (for $7\le n\le24$) or $\ge4$ (for $n\ge25$) against an arithmetically permitted excess of order $n^2$.** That is a small demand, and it makes the obstruction Claim C names look much more like a gap in the write-up than a wall.

**A limitation of the route that Claim C does not name.** Paying the debt buys only equality with $(G5)$ at these points, not sharpness: $B(n,1,2n-4)\to\frac{2n-1}2$ while the true $\theta^2\to1$ there, so the trace-form bound overshoots by a factor $\asymp n$ at exactly the points under discussion ($6.2939$ against $35/36$ at $n=8$, and $998.50$ against $0.999999$ at $n=1000$). The cause is that the Cauchy-Schwarz step of $(G4)$ assumes the $k$ eigenvalues are equal, whereas here $\sum\lambda_i\approx-n$ while $\sum\lambda_i^2\approx n^2/2$, so they are badly spread. Raising $m$ cannot fix that, and any route aiming at $\theta^2\approx1$ rather than $\theta^2\lesssim n$ needs a different inequality on the $k$-block.

## 6. Claim D's reasoning (item 6)

### 6.1 The $SO(n-1)$-invariant symmetric $2$-tensors

Write $\mathbb R^n=V'\oplus\mathbb Rv$ with $V'=\mathbb R^{n-1}$. Then $S^2(\mathbb R^n)=S^2V'\oplus(V'\otimes v)\oplus\mathbb Rv^2$, and taking $SO(n-1)$-invariants: $\dim(S^2V')^{SO(n-1)}=1$ (the metric, since $S^2V'=\mathbb R\oplus S^2_0V'$ with $S^2_0V'$ irreducible and nontrivial for $n-1\ge2$), $(V')^{SO(n-1)}=0$ for $n-1\ge2$, and $\mathbb R v^2$ contributes $1$. Total $2$, spanned by $g$ and $v\otimes v$. **Correct as stated, for all $n\ge3$.** No finding.

### 6.2 The Kulkarni-Nomizu step, which is where the reasoning breaks

The offered reasoning says that *therefore* every invariant algebraic curvature tensor is $a\,g\wedge g+b\,g\wedge(v\otimes v)$. That "therefore" is a non-sequitur: nothing makes an invariant element of $S^2(\Lambda^2\mathbb R^n)$ a Kulkarni-Nomizu product of invariant $2$-tensors, and the classification of invariant $2$-tensors is the wrong input. The right input is the direct count the brief asked for. With $\Lambda^2\mathbb R^n=\Lambda^2V'\oplus(V'\wedge v)\cong\mathfrak{so}(n-1)\oplus V'$,

$$S^2(\Lambda^2\mathbb R^n)^{SO(n-1)}=S^2(\mathfrak{so}(n-1))^{SO(n-1)}\;\oplus\;\mathrm{Hom}(\mathfrak{so}(n-1),V')^{SO(n-1)}\;\oplus\;S^2(V')^{SO(n-1)},$$

and each summand is computable by Schur:

| $n$ | $S^2(\mathfrak{so}(n-1))^{G}$ | $\mathrm{Hom}(\Lambda^2V',V')^{G}$ | $S^2(V')^{G}$ | total |
| --- | --- | --- | --- | --- |
| $\ge6$ | $1$ ($\mathfrak{so}(n-1)$ simple, Killing form only) | $0$ (non-isomorphic irreducibles) | $1$ | **2** |
| $5$ | $2$ ($\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$) | $0$ | $1$ | **3** |
| $4$ | $1$ ($\mathfrak{so}(3)$ simple) | $1$ ($\Lambda^2\mathbb R^3\cong\mathbb R^3$) | $1$ | **3** |

The Kulkarni-Nomizu span is $2$-dimensional exactly: $g\wedge g$ and $g\wedge(v\otimes v)$ are independent, and $(v\otimes v)\wedge(v\otimes v)=0$ identically, since the four terms cancel in pairs.

So the conclusion is immediate for $n\ge6$, by the count alone, and at $n\in\{4,5\}$ **there is a third invariant in $S^2(\Lambda^2)$ that the offered reasoning does not see**. In both cases it is the $4$-form direction: at $n=4$ the mixed $\mathrm{Hom}(\Lambda^2\mathbb R^3,\mathbb R^3)$ invariant is the volume form $\varepsilon$ of $\mathbb R^4$, and at $n=5$ the extra invariant of $S^2(\mathfrak{so}(4))$ is the Hodge involution of $\Lambda^2\mathbb R^4$, again $\varepsilon$. Both are excluded by the first Bianchi identity, which for a totally antisymmetric $\varphi\in S^2(\Lambda^2)$ gives

$$b(\varphi)_{ijkl}=\varphi_{ijkl}+\varphi_{iklj}+\varphi_{iljk}=3\varphi_{ijkl},$$

because $(jkl)\mapsto(klj)$ and $(jkl)\mapsto(ljk)$ are even. So $b(\varphi)=0$ forces $\varphi=0$, and the invariant algebraic curvature tensors are the Kulkarni-Nomizu span at $n=4$ and $n=5$ too. (Consistency check at $n=4$: $S^2(\Lambda^2\mathbb R^4)$ has dimension $21$, the first Bianchi map onto $\Lambda^4\mathbb R^4\cong\mathbb R$ has $20$-dimensional kernel, and the Ricci-flat part has dimension $10=D(4)$, matching $(G1)$.)

**Finding.** The classification asserted in Claim D is **true for all $n\ge4$**, and the reasoning offered for it is **invalid as stated**, missing the dimension count entirely and missing a real extra invariant at the two smallest $n$. **The smallest $n$ for which the offered argument is valid, once the count is supplied, is $n=6$. With the Bianchi step added it is valid for all $n\ge4$.**

### 6.3 The Weyl part of $g\wedge h$

Zero for every symmetric $h$, at every $n\ge4$: the standard orthogonal decomposition of algebraic curvature tensors is $\mathbb R\,(g\wedge g)\oplus\{g\wedge h_0:h_0\in S^2_0\}\oplus\mathcal W_n$, the first two summands being exactly the image of $h\mapsto g\wedge h$, and the Weyl part is the projection onto the third. No finding.

So "no nonzero $SO(n-1)$-invariant Weyl tensor" is **CONFIRMED for every $n\ge4$**.

### 6.4 The inference "so $d>n-1$ at every critical point", which fails at $n=4$

The inference is not immediate, and the brief does not flag the step it needs. If $d\le n-1$ then $\dim\mathrm{Stab}^0\ge\frac{n(n-1)}2-(n-1)=\frac{(n-1)(n-2)}2=\dim SO(n-1)$, and the conclusion needs: *a connected proper subgroup of $SO(n)$ of dimension at least $\dim SO(n-1)$ is conjugate to $SO(n-1)$* (H10). That is a classification import, and it has exceptions.

- **Reducible case, clean.** $H\subseteq SO(p)\times SO(q)$ with $p+q=n$ has $\dim H\le\frac{p(p-1)}2+\frac{q(q-1)}2$, maximised over $p\ge1$ at $p=1$, and the $p=2$ value falls short by $n-3$. So among reducible subgroups only $SO(n-1)$ reaches the bound.
- **$n=8$, $Spin(7)$.** $Spin(7)\subset SO(8)$ acts irreducibly with $\dim Spin(7)=21=\dim SO(7)$, so H10 is *incomplete* at $n=8$, which is exactly where Claim B's range starts. The case is nonetheless harmless, by the same method as §6.2: $\Lambda^2\mathbb R^8=\Lambda^2_7\oplus\Lambda^2_{21}$ under $Spin(7)$, so $S^2(\Lambda^2)^{Spin(7)}=S^2(\mathfrak{so}(7))^{G}\oplus\mathrm{Hom}(\mathfrak{so}(7),\mathbb R^7)^G\oplus S^2(\mathbb R^7)^G$ has dimension $1+0+1=2$, spanned by the identity of $\Lambda^2$ and the Cayley $4$-form $\Phi$ (which acts with distinct eigenvalues on the two summands, hence is independent of the identity). The first Bianchi identity kills the $\Phi$ direction by the same $b(\varphi)=3\varphi$ computation, leaving $\mathbb R\cdot\mathrm{Id}_{\Lambda^2}=\mathbb R\,(g\wedge g)$, whose Weyl part vanishes. So no nonzero $Spin(7)$-invariant Weyl tensor exists and $d=7$ is excluded at $n=8$, **but the record must say so**, because Claim D's argument as written does not.
- **$n=4$, where the conclusion is false.** $U(2)\subset SO(4)$ has dimension $4>3=\dim SO(3)$, so the bound H10 rests on fails outright. And the failure is realised: let $J$ be a compatible complex structure with Kähler form $\omega\in\Lambda^2_+$, and let $W_K$ be the normalised trace-free part of $\omega\otimes\omega$ inside $S^2_0(\Lambda^2_+)$, that is the Kähler-type Weyl tensor with eigenvalues proportional to $(2,-1,-1)$ on $\Lambda^2_+$ and zero on $\Lambda^2_-$. Then:
  - $W_K\in\mathcal W_4$, since $\mathcal W_4=S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$ (§6.2's dimension check).
  - The $U(2)$-fixed subspace of $\mathcal W_4$ is **exactly one-dimensional**: $U(2)$ maps onto $SO(2)\subset SO(3)_+$ and onto all of $SO(3)_-$, and $S^2_0(\mathbb R^3)$ has a $1$-dimensional $SO(2)$-invariant subspace (the weight-zero line, spanned by $\mathrm{diag}(2,-1,-1)$) and no $SO(3)$-invariant vector.
  - Hence $W_K$ **is a critical point**: $Q$ is $O(4)$-equivariant (H11), so $Q(W_K)$ is $U(2)$-invariant, so it lies in that same line, so $Q(W_K)=\theta W_K$ for some $\theta$. No numerical input is needed, and the conclusion is independent of whether $\theta$ happens to vanish.
  - Its orbit dimension is $2$: $\mathrm{Stab}^0\supseteq U(2)$, the subalgebras of $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ have dimensions $0,1,2,3,4,6$ with no $5$, so $U(2)$ is maximal connected in $SO(4)$, and $\mathrm{Stab}^0=SO(4)$ is excluded because both summands of $\mathcal W_4$ are nontrivial irreducibles. So $d=6-4=2$.

  **$d=2\le n-1=3$ at a critical point of $\mathcal W_4$. Claim D's stated conclusion is REFUTED at $n=4$.**

Two consequences worth carrying. First, Claim D must be restated with a range, $n\ge5$, and with H10 and the $Spin(7)$ case discharged explicitly. Second, the $n=4$ escape route that §3.2 opened (where $d^\ast(4)=2n-4$, so an orbit bound alone would have sufficed) is closed by this same point: $B(4,1,2)=\tfrac{147}{58}=2.5345>\tfrac95$, so at $n=4$ too the $(G3)$ route yields nothing, and Claim C holds at $n=4$ for a reason entirely different from the one Claim A supplies.

## 7. $\ker W\ne0$, $\theta=0$, smallest $n$, odd $n$ (item 7)

### 7.1 Critical points with a kernel

If $W$ vanishes on a subspace, it is supported on some $\mathbb R^{n'}\subset\mathbb R^n$ with $4\le n'<n$, where it is a Weyl tensor of $\mathcal W_{n'}$ (the Ricci trace over $\mathbb R^n$ equals the trace over $\mathbb R^{n'}$). Both $W^2$ and $W^\#$ are built from contractions, which restrict to $\mathbb R^{n'}$, so $Q$ and hence criticality and $\theta$ are inherited unchanged from $\mathcal W_{n'}$: such points exist whenever $\mathcal W_{n'}$ has critical points. Their orbits are *larger*, not smaller: the stabiliser contains $SO(n-n')$ acting on the kernel, and

$$d=n'(n-n')+d_{n'}(W)\ \ge\ n'(n-n'),$$

the first term being the dimension of the Grassmannian of $n'$-planes. The most dangerous case is the smallest support with the smallest inner orbit, $n'=4$ with §6.4's point: $d=4(n-4)+2=4n-14\ge2n=d^\ast$ for $n\ge7$. At $n=8$ the kernel points give $d\ge15=d^\ast(8)$ for $n'=4,5,6$ ($18$, $\ge15$, $\ge20$ respectively). So **kernel points do not lower the minimum orbit dimension for $n\ge7$, and $(G3)$ already covers them**. Nothing above changes.

### 7.2 $\theta=0$

Then $e=W/\theta$ does not exist, $m$ and $p$ are undefined, and $(G2)$ and $(G4)$ say nothing at all. This is harmless for the programme, since $\theta=0\le S(n)$ trivially, and it is harmless for Claim C, whose content is about the $\theta\ne0$ points. It is a live caveat for Claim D, whose conclusion is about *every* critical point including $\theta=0$ ones: §6.4's refutation needs no assumption on $\theta$, so it stands either way.

### 7.3 The smallest admissible $n$

$n=4$ is different in every respect, and none of the four claims is safe there: $(G7)$'s maximality fails (§1.2), the gap in B is $0$ rather than $3$ or $4$ (§3.2), Claim D is false (§6.4), and Claim A survives only by a separate argument. The record should state $n\ge5$ for A and D and $n\ge7$ for B.

### 7.4 Odd $n$

Nothing changes, with one step to watch: the upgrade of $(G7)$'s $O(n)$-invariance to $SO(n)$-invariance (H4) is *free* for odd $n$, because $O(n)=SO(n)\times\{\pm I\}$ and $-I$ acts trivially on a degree-$4$ tensor, and for even $n$ it needs the absence of a $\det$-twisted invariant. That absence holds: an $SO(n)$-invariant that is not $O(n)$-invariant must involve the volume form, which cannot enter a $4$-tensor without self-contraction unless $n=4$, and the $n=4$ candidate $\varepsilon$ fails the first Bianchi identity (§6.2). The parity is therefore a presentational matter, not a mathematical one.

## 8. The near-miss (item 8)

The gap is $3$ or $4$ against quantities of size $2n$, and I take the brief's instruction to resist asserting either explanation. What can be argued:

- **The leading $2n$ has a partial common cause, in the loosest sense.** On the orbit side, $2n-4=2(n-2)=\dim\mathrm{Gr}(2,n)$, a Grassmannian dimension. On the bound side, §3.1 shows the threshold is $4\kappa(n)/S(n)^2-4=\frac{(2n-1)(n+1)}{n-1}-4$, forced by $\kappa\sim n^2/2$ against $S^2\sim n$. These are unrelated inputs that both happen to be linear in $n$ with slope $2$: a codimension count on one side, a ratio of two spectral quantities on the other.
- **Against a structural identity: the gap is not constant.** It is $3$ for $7\le n\le24$ and $4$ for $n\ge25$, and the crossover sits at the root of a quartic, $n^4-24n^3-7n^2-12n+6$ (§3.3). A structural explanation linking $\dim\mathrm{Gr}(2,n)$ to $4\kappa/S^2$ would give a constant offset, and an offset that flips once at $n=25$ because a $O(n^{-2})$ correction crosses a $\frac2{n-1}$ offset is the signature of two independent quantities passing each other.
- **Against the bound being nearly sharp at that point.** If the near-agreement of $d^\ast$ with $2n-4$ reflected the trace-form bound almost capturing the small-orbit point, one would need $B(n,1,2n-4)\approx\theta^2$ there. In fact $B(n,1,2n-4)\to\frac{2n-1}2\asymp n$ while $\theta^2\to1$, a factor $\asymp n$ apart (§5). The two quantities are within $4$ of each other while the bound they compare is off by a factor of $n$, which is the clearest evidence that the closeness is numerological.

**Verdict for item 8: on the evidence available, a coincidence of two unrelated closed forms**, with the flip at $n=25$ as the positive argument and no derivation linking the two offered in either direction.

## 9. What would falsify Claim C, and what I did to look (item 9)

The object is: **a proof that every critical point of $\mathcal W_n$ has orbit dimension at least $d^\ast(n)$** (that is $2n-1$ for $7\le n\le24$, $2n$ for $n\ge25$), since that, with $(G3)$ and $(G4)$, would deliver $\theta^2\le B(n,1,d^\ast)\le S(n)^2$ from $(G3)$ alone and contradict Claim C. Equivalently, by §4.1, the falsifier is the negation of (i): the non-existence of critical points with $d\le2n-4$.

What I did to look for it:

- **Attacked A's orbit dimension from both sides.** Recomputed $2n-4$ from the two group dimensions, verified the inclusion $\mathrm{Stab}^0\supseteq SO(2)\times SO(n-2)$ from the product structure alone (which already gives $d\le2n-4$ without $(G7)$), and checked the $n=4$ case separately when $(G7)$ turned out to fail there. The inequality that Claim C needs survives every route.
- **Attacked B's arithmetic exactly, then closed the tail.** Reproduced $d^\ast$ at $n=4..2000$ in exact rationals, reduced the comparison to a single inequality, and proved $d^\ast\in\{2n-1,2n\}$ by two polynomial positivity arguments, so no large-$n$ escape exists.
- **Searched the small-orbit population for something smaller than $2n-4$, which would strengthen rather than falsify C**, and found $d=2$ at $n=4$ (§6.4). Checked that kernel-supported points give $d\ge4n-14$, which does not compete for $n\ge7$ (§7.1).
- **Did not find, and did not look exhaustively for, a critical point with $n-1<d<2n-4$ at general $n$.** That is a census of a family, which the standing rule places outside what I may open, and it is not needed: Claim C needs only one point below $d^\ast$, which A supplies.

**No falsifier exists unless Claim A is wrong, and Claim A is right.** What *can* still overturn the practical force of Claim C is the pair $(p,m)$ at $S^2\times S^{n-2}$, which is a closed-form computation on an object in hand, and which §5 shows needs only $m-d\ge3$ or $4$ against an arithmetically permitted $\approx2n^2$.

## Verdict for the whole

**Claims A and C stand, Claim B stands with its asymptotic clause refuted and its range extended, and Claim D is refuted at $n=4$ and owes two imports elsewhere.**

The mathematics of the obstruction is sound: there is a critical point with orbit dimension exactly $2n-4$ and value $\theta^2=\frac{(n-1)(n-3)}{(n-2)^2}<1$, the threshold $d^\ast(n)$ is $2n-1$ for $7\le n\le24$ and $2n$ for $n\ge25$ in closed form, and therefore $(G3)$ alone cannot make the trace-form bound improve on the standing bound at any $n\ge4$. Four things must change in the record: the asymptotic clause of B becomes $d^\ast(n)=2n$ for $n\ge25$, Claim C's second sentence is narrowed to proofs that route through the trace-form bound at $p=1$, Claim D acquires the range $n\ge5$ together with the dimension count that its Kulkarni-Nomizu step actually needs and the $Spin(7)$ and large-subgroup imports that its conclusion actually needs, and Claim A acquires the $n=4$ caveat where $(G7)$ is false. The recommendation for the cycle is to stop arguing about $(G3)$ and compute $p$ and $m$ at $S^2\times S^{n-2}$, because the debt is $3$ or $4$ against a permitted $\approx2n^2$, while noting that discharging it buys agreement with $(G5)$ at those points and not sharpness, the trace-form bound being $\asymp n$ times the true value there.
