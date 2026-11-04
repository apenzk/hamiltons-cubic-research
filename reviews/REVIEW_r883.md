# Reviewer r883: the trace-form bound $\theta^2\le\kappa(n)/f(d,k)$ and the $3/2$ floor claimed for it (Claims 1–5)

Cold brief, worked from the definitions and the givens (G1)–(G4) and from nothing else in the record. I derived Claim 1 myself from the two trace identities, then built an independent closed-form model of the $n=4$ algebra to test the hypotheses against real objects, and computed Claims 3 and 4 in exact rational arithmetic. Everything numerical here is exact: Claim 3's value is $397463/114594=3.4684451192907\ldots$, the $n=4$ scan is $\{189/40,\,24/7,\,147/58,\,126/67,\,105/76,\,84/85,\,63/94\}$ for $d=0,\dots,6$, and the two $n=4$ critical values are $\theta^2=3/2$ and $\theta^2=3/4$. The only compute was seconds of rational arithmetic on objects constructed for the purpose, within the standing screening allowance. Log: [agent_logs/review-r883-traceform.log](../agent_logs/review-r883-traceform.log). The arithmetic script is at the absolute path `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/r883_exact.py`.

## Claim table

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | $\theta^2\le\kappa(n)/f(d,k)$ under the stated spectral shape | **CONFIRMED** | Cauchy–Schwarz on the two trace moments, applied in the right direction, and the stated hypothesis is strictly stronger than the derivation uses |
| 2 | $f$ strictly increasing in $d$, bound weakest at smallest $d$ | **CONFIRMED** | $\partial_d f=\tfrac14+\tfrac{2+d}{2k}>0$ at fixed $k$, and the composite $d\mapsto f(d,D-1-d)$ is increasing as well, so the direction survives the coupling |
| 3 | $\kappa(12)/f(66,1571)=3.46844\ldots>3/2$ | **CONFIRMED** | exact value $397463/114594$, and $d=66$ is the binding (largest) end |
| 4 | $\kappa(n)/f(d,D-1-d)>3/2$ for every $n\ge5$, $0\le d\le n(n-1)/2$ | **CONFIRMED** | proved for all $n\ge5$, not sampled: $n=5$ gives $9/5$ directly, $n\ge6$ by the chain in §6, and $n=4$ is genuinely excluded, failing from $d=4$ upward |
| 5 | the bound cannot certify $\theta\le\sqrt{3/2}$ at any $n\ge5$, best value $\to4$ | **CONFIRMED AS ALGEBRA** | reading (i) holds and the limit $4$ from below is right, while the wording reaches toward (ii), which the givens do not support, and $\theta=0$ points are certified trivially |
| F1 | *finding*: the literal spectral shape of Claim 1 | **REFUTED AS STATED** | at the $n=4$ two-block critical point the eigenvalue $1$ has multiplicity $2$, so a real critical point falls outside Claim 1's hypothesis while satisfying its conclusion |
| F2 | *finding*: the bound beats the standing $(n-1)/\sqrt{n+1}$ only for $d\ge d^\ast(n)\approx2n$ | **HYPOTHESIS-DEBT** | the best available lower bound at every critical point is $d\ge n-1<d^\ast(n)$, so the bound is unusable as a theorem until $d\ge d^\ast(n)$ is proved, and at $n=5$ that is false: the padded critical point has $d=6<d^\ast(5)=7$, where (G4)'s $16/6$ beats the new $126/43$ |

**Summary for the cycle.** Keep Claims 2–4 as proved and restate Claim 1 with "at least" multiplicities so it covers every critical point, then demote Claim 5 to a statement about this bound alone and record the $d\ge d^\ast(n)\approx2n$ lower bound on orbit dimension as the blocking debt, because without it the bound is weaker than the standing $(n-1)/\sqrt{n+1}$ at exactly the orbit dimensions the record can guarantee, and at $n=5$ the padded critical point with $d=6$ shows the debt to be false there outright.

## 0. Conventions, fixed once

Quoted from the brief.

> $n\ge4$ an integer. $\mathcal W_n$ is the space of Weyl tensors in dimension $n$: algebraic curvature tensors that are Ricci-flat and satisfy the first Bianchi identity. $D:=\dim\mathcal W_n$.
>
> The norm is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$ (the "Frobenius normalisation").
>
> $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$, a cubic form on $\mathcal W_n$.
>
> A **critical point** is $W$ with $\lVert W\rVert=1$ and $Q(W)=\theta W$ for a scalar $\theta$; then $\theta=P(W)$.
>
> $O(n)$ acts on $\mathcal W_n$ orthogonally. $d:=\dim\big(O(n)\cdot W\big)$, the dimension of the orbit of $W$.
>
> $L_x$ denotes the multiplication operator of the commutative nonassociative algebra on $\mathcal W_n$ whose cubic form is $P$; for $\theta\ne0$ set $e:=W/\theta$, which is an idempotent of that algebra.
>
> **(G2)** The algebra's two trace identities hold at every element: $\mathop{\mathrm{tr}}L_x=0$, and $\mathop{\mathrm{tr}}(L_xL_y)=\kappa(n)\langle x,y\rangle$ with $\kappa(n)=\frac{(2n-1)(n-1)}{4}$ [...] Consequently at an idempotent $e=W/\theta$, where $\lvert e\rvert^2=1/\theta^2$, one has $\mathop{\mathrm{tr}}(L_e^2)=\kappa(n)/\theta^2$.
>
> **(G3)** At every critical point with $\theta\ne0$: $L_ee=e$, so $1$ is an eigenvalue of $L_e$ on the line $\mathbb RW$; and the tangent space to the $O(n)$-orbit of $W$ lies in the $\tfrac12$-eigenspace of $L_e$. The second holds with no further hypothesis, in particular without maximality. The orbit tangent is never zero, since $\mathcal W_n$ carries no $O(n)$-invariant vector.

And $k:=D-1-d$, $f(d,k):=1+\frac d4+\frac{(2+d)^2}{4k}$.

## Hypothesis inventory

**Carried by Claim 1, and checked.**

| Hypothesis | Status against the objects | Used by the derivation |
|---|---|---|
| $W$ a critical point, $\lVert W\rVert=1$ | holds by definition | yes, through $\lvert e\rvert^2=1/\theta^2$ |
| $\theta>0$ | positivity is never spent, $\theta\ne0$ is what is needed (§3) | only $\theta\ne0$ |
| $d$ is the orbit dimension | holds, and the orbit tangent at $W$ has dimension exactly $d$ | yes, as the multiplicity of $\tfrac12$ |
| $1$ has multiplicity exactly $1$ | **fails** at the $n=4$ two-block critical point, where it is $2$ (§2) | no, multiplicity at least $1$ suffices |
| $\tfrac12$ has multiplicity exactly $d$ | holds at both $n=4$ critical points, unverified in general | no, multiplicity at least $d$ suffices |
| $k=D-1-d\ge1$, so that $f$ is defined | forced by the identities themselves (§9) | yes, as the divisor in Cauchy–Schwarz |
| the $\mu_i$ are real | holds, because $L_e$ is self-adjoint (below) | yes, decisively |

**Imported, and checked.**

- **(G2)**, whose hypothesis is that $x$ lies in $\mathcal W_n$ and the algebra is the one whose cubic form is $P$. I verified the constant $\kappa(4)=21/4$ independently at two distinct $n=4$ critical points with different $\theta$, obtaining $\mathop{\mathrm{tr}}(L_e^2)=7/2$ against $\kappa(4)/(3/2)=7/2$ and $\mathop{\mathrm{tr}}(L_e^2)=7$ against $\kappa(4)/(3/4)=7$, and I verified $\mathop{\mathrm{tr}}L_x=0$ in the same model. Both are used.
- **(G3)**, whose hypothesis is a critical point with $\theta\ne0$. I verified both halves at the $n=4$ one-block point by computing the orbit tangent as $[\mathfrak{so}(3),A]=\mathop{\mathrm{span}}(e^s_{13},e^s_{23})$ and finding it equal to the $\tfrac12$-eigenspace. Both halves are used.
- **Self-adjointness of $L_x$** with respect to $\langle\cdot,\cdot\rangle$. This is an unlisted hypothesis of Claim 1 that the brief does not state, and the derivation cannot proceed without it, since a non-self-adjoint $L_e$ admits complex eigenvalues and then $\sum\mu_i^2\ge(\sum\mu_i)^2/k$ is false. It holds: the product is the polarisation of the cubic form $P$, so $\langle x\cdot y,z\rangle$ is totally symmetric in $x,y,z$, which is exactly $\langle L_xy,z\rangle=\langle y,L_xz\rangle$. Recommend stating it.
- **Cauchy–Schwarz** in the form $\sum_{i=1}^k\mu_i^2\ge\frac1k\big(\sum_i\mu_i\big)^2$, whose hypotheses are real $\mu_i$ and $k\ge1$. Both hold.
- **$d\le n(n-1)/2$** for Claim 4, whose content is $d=\dim O(n)-\dim\mathop{\mathrm{Stab}}(W)\le\dim O(n)$. Holds.
- **Codimension of proper closed subgroups of $SO(n)$** for the accounting in §8 only, giving $d\ge n-1$ at $n\ge5$. Imported from the classification of maximal connected subgroups, spot-checked against $U(m)\subset SO(2m)$ (codimension $m^2-m$, which exceeds $n-1$ for $m\ge3$) and $Spin(7)\subset SO(8)$ (codimension $7=n-1$). No verdict rests on it.

**Carried by my own $n=4$ model, and checked.** The model is $\mathcal W_4\cong\{(A,B)\}$ with $A,B$ trace-free symmetric $3\times3$ matrices on $\Lambda^2_\pm$, product $A\circ A'=\tfrac32(AA'+A'A)-\mathop{\mathrm{tr}}(AA')I$ blockwise, so $Q(A)=3A^2-\mathop{\mathrm{tr}}(A^2)I$. Its one free convention is the normalisation of $\#$, which I did not assume: it is pinned by three independent agreements with the brief's own givens, namely $\kappa(4)=21/4$ reproduced at two different critical points, $\theta_0(4)=\sqrt3/2$ reproduced as the two-block critical value, and $\theta=\sqrt{3/2}$ reproduced as the one-block critical value that the brief states is attained at $n\ge4$.

## 1. Does Claim 1 follow?

Yes. The derivation is three lines and I reproduce it without reference to the record.

Let $W$ be a critical point with $\theta\ne0$ and $e=W/\theta$. Write the spectrum of $L_e$ as one copy of $1$, $d$ copies of $\tfrac12$, and a remaining bucket $\mu_1,\dots,\mu_k$ with $k=D-1-d$. By (G3) the first two buckets are genuine: $\mathbb RW$ sits in the $1$-eigenspace and the $d$-dimensional orbit tangent sits in the $\tfrac12$-eigenspace, and the two are independent because they belong to different eigenvalues of a self-adjoint operator.

The first trace identity gives
$$0=\mathop{\mathrm{tr}}L_e=1+\frac d2+\sum_{i=1}^k\mu_i,\qquad\text{so}\qquad \sum_{i=1}^k\mu_i=-\Big(1+\frac d2\Big)=-\frac{2+d}{2}.$$

The second gives
$$\frac{\kappa(n)}{\theta^2}=\mathop{\mathrm{tr}}(L_e^2)=1+\frac d4+\sum_{i=1}^k\mu_i^2 .$$

Cauchy–Schwarz on the vector $(\mu_1,\dots,\mu_k)$ against $(1,\dots,1)$ gives $\sum\mu_i^2\ge\frac1k(\sum\mu_i)^2=\frac{(2+d)^2}{4k}$. Substituting,
$$\frac{\kappa(n)}{\theta^2}\ \ge\ 1+\frac d4+\frac{(2+d)^2}{4k}\ =\ f(d,k),$$
and since $\kappa(n)>0$ and $f(d,k)>0$ this rearranges to $\theta^2\le\kappa(n)/f(d,k)$. **Claim 1 confirmed.**

**Which inequality does the work, and in which direction.** Cauchy–Schwarz, used to *lower*-bound $\sum\mu_i^2$ and hence to lower-bound $\mathop{\mathrm{tr}}(L_e^2)=\kappa/\theta^2$, which upper-bounds $\theta^2$. The direction is right. The one place a sign could go wrong is the rearrangement, and it is safe because both sides are positive.

**Equality.** The step is an equality exactly when all $\mu_i$ are equal, that is $\mu_i=-\frac{2+d}{2k}$ for every $i$. Nothing in (G2) or (G3) forces that, and §4 shows it fails badly at a real critical point: at the $n=4$ one-block point the bucket is $\{-1,-1,0,0,0,0,0\}$ with $\sum\mu_i^2=2$ against the Cauchy–Schwarz floor $4/7$. The exact $f$ there is $1+\tfrac12+2=\tfrac72$, which returns $\kappa(4)/\tfrac72=3/2=\theta^2$ on the nose, so the entire gap between the true value $3/2$ and the bound's $147/58$ is Cauchy–Schwarz slack and nothing else.

## 2. Is the spectral shape safe?

The shape is not needed, and it is not safe as literally written. Both halves matter.

**The derivation needs only "at least".** Inspect §1 again: the bucket $\mu_1,\dots,\mu_k$ is never described, only counted and summed. So the argument goes through verbatim under the weaker hypothesis that $1$ is an eigenvalue with multiplicity **at least** $1$ and $\tfrac12$ with multiplicity **at least** $d$, with everything else, including any further copies of $1$ or $\tfrac12$, thrown into the bucket of size $k=D-1-d$. Under (G3) that weaker hypothesis holds at **every** critical point with $\theta\ne0$. So the bound of Claim 1 is a statement about all critical points, and only its hypothesis makes it look like a statement about ones with a spectral coincidence.

**Case A, the $\tfrac12$-eigenspace strictly larger than the orbit tangent**, say of dimension $m>d$. The stated bound $\theta^2\le\kappa/f(d,D-1-d)$ still holds, by the paragraph above. It also becomes a *different and strictly stronger* statement, because $\theta^2\le\kappa/f(m,D-1-m)$ holds by the same derivation and $f$ is increasing in its first slot along $k=D-1-d$ (§5), so $\kappa/f(m,\cdot)<\kappa/f(d,\cdot)$. Nothing fails.

**Case B, $1$ with multiplicity above one.** This is not hypothetical. In the $n=4$ model take $W=(A,B)$ with both blocks nonzero. Each nonzero block must satisfy $3A^2-\mathop{\mathrm{tr}}(A^2)I=\theta A$, so its eigenvalues satisfy one quadratic and there are at most two distinct ones, forcing the pattern $(p,p,-2p)$ with $\theta=-3p$ and $\lVert A\rVert^2=6p^2=\tfrac23\theta^2$. With both blocks nonzero, $\lVert A\rVert^2+\lVert B\rVert^2=1$ gives $\tfrac43\theta^2=1$, hence $\theta^2=3/4$ and $\theta=\sqrt3/2=\theta_0(4)$. Since $Q$ is blockwise, $L_W(A',0)=(M_A(A'),0)$ and $L_W(0,B')=(0,M_B(B'))$, so $(A,0)$ and $(0,B)$ are *separately* eigenvectors of $L_e$ with eigenvalue $1$. Computing the rest, the full spectrum of $L_e$ is
$$\{\,1,1,\ \tfrac12,\tfrac12,\tfrac12,\tfrac12,\ -1,-1,-1,-1\,\},$$
with $\mathop{\mathrm{tr}}L_e=2+2-4=0$ and $\mathop{\mathrm{tr}}(L_e^2)=2+1+4=7=\kappa(4)/(3/4)$, both identities exact. Orbit dimension: the stabiliser is $O(2)\times O(2)$ inside $SO(3)_+\times SO(3)_-$, of dimension $2$, so $d=6-2=4$, matching the multiplicity of $\tfrac12$.

So a real critical point has $1$ with multiplicity $2$ and falls outside Claim 1's literal hypothesis. Its conclusion nevertheless holds: $k=5$, the bucket is $\{1,-1,-1,-1,-1\}$ summing to $-3=-(1+d/2)$ as required, and $\theta^2=3/4\le\kappa(4)/f(4,5)=105/76=1.3816\ldots$. **Finding F1: Claim 1's hypothesis is refuted as stated and should be rewritten with "at least", which costs nothing and buys universality.**

## 3. Where positivity is spent, and the degenerate signs

**Positivity is spent nowhere.** Three checks. First, $\lvert e\rvert^2=1/\theta^2$ is even in $\theta$. Second, $L_ee=e$ reads $Q(W)/\theta^2=W/\theta$, which is the criticality equation divided by $\theta^2$ and is sign-free. Third, the $\tfrac12$-eigenvalue on the orbit tangent comes from differentiating the equivariance $Q(gW)=gQ(W)$: for $\xi\in\mathfrak{so}(n)$ and $v=\xi\cdot W$ one gets $2L_Wv=\xi\cdot Q(W)=\theta v$, so $L_ev=\tfrac12v$, again sign-free. Hence Claim 1 holds under $\theta\ne0$ and the correct reading of its conclusion is a bound on $\lvert\theta\rvert$.

There is a cleaner way to say it. Since $Q$ is quadratic, $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$, so $-W$ is a critical point with $-\theta$, and its idempotent is $(-W)/(-\theta)=W/\theta=e$, the *same* $e$. The $\pm$ pair shares one idempotent and therefore one $L_e$ and one spectrum, so Claim 1 for $\theta<0$ is literally the same inequality as for $\theta>0$, not an extension of it.

**At $\theta=0$.** Then $e$ is undefined, $L_e$ is undefined, and Claims 1–5 say nothing whatsoever. This is harmless for the programme, since $\theta=0\le\sqrt{3/2}$ holds trivially, but it does mean Claim 5's "at any critical point" is loose: the points it cannot certify are the ones with $\theta\ne0$, and the $\theta=0$ points need no certificate. In the $n=4$ model there are no $\theta=0$ critical points at all, because $3A^2=\mathop{\mathrm{tr}}(A^2)I$ forces eigenvalues $\pm c$ which cannot sum to zero in odd count unless $c=0$.

## 4. $\ker W\ne0$ and the padded tensor

Nothing changes in the derivation, which never looks at $W$ beyond $\lVert W\rVert=1$ and $Q(W)=\theta W$. The padded family is the sharpest available stress test, and it passes. It also carries the most consequential structural fact in this audit, so I compute it rather than assume it.

**The padded object is a genuine critical point at every $n\ge4$.** Take $W_0\in\mathcal W_4$ the one-block point: $W_0=(A,0)$ with $A=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(-1,-1,2)$. From $3A^2-\mathop{\mathrm{tr}}(A^2)I=\theta A$ with $\lVert A\rVert^2=1$ one gets $\theta=3/\sqrt6=\sqrt{3/2}$, which is the brief's stated attainment. Embed $\mathbb R^4\subset\mathbb R^n$ and extend $W_0$ by zero. Both $W^2$ and $W^\#$ are built from contractions over indices on which $W$ is supported, so $Q$ of the padded tensor is the padding of $Q(W_0)$, the Ricci trace $\sum_{i=1}^nW_{ijil}$ collapses to the $4$-block and still vanishes, and the norm is unchanged. So the padded tensor is a critical point of $\mathcal W_n$ with $\theta=\sqrt{3/2}$ for every $n\ge4$.

**Its orbit dimension, computed.** $W_0$ has no kernel vector in $\mathbb R^4$: a kernel vector would exhibit $W_0$ as a Weyl tensor in dimension $3$, and $\mathcal W_3=0$. So the kernel of the padded tensor is exactly the orthogonal complement of the $4$-plane, which is therefore canonically attached to $W$ and preserved by the stabiliser. Hence $\mathop{\mathrm{Stab}}=\mathop{\mathrm{Stab}}_{O(4)}(W_0)\times O(n-4)$, and $\mathop{\mathrm{Stab}}_{O(4)}(W_0)$ is the preimage of $\mathop{\mathrm{Stab}}_{SO(3)}(A)=O(2)$ times the whole $SO(3)_-$ acting on the zero block, of dimension $1+3=4$. Therefore
$$d\;=\;\frac{n(n-1)}2-4-\frac{(n-4)(n-5)}2\;=\;(4n-10)-4\;=\;4n-14,$$
which is $2$ at $n=4$ in agreement with the direct computation below, $6$ at $n=5$, and $34$ at $n=12$.

**The bound at those points, exactly.** $\kappa(n)/f(4n-14,D-1-(4n-14))$ equals $147/58=2.5345$ at $n=4$, $126/43=2.9302$ at $n=5$, $365/106=3.4434$ at $n=6$, $9835/2194=4.4827$ at $n=8$, $405559/62210=6.5192$ at $n=12$. All exceed $\theta^2=3/2$, so the padded family refutes nothing.

**What it does do is make Claim 4's floor partly unavoidable.** Since a critical point with $\theta^2=3/2$ exists at $d=4n-14$ for every $n\ge4$, any correct bound whatever must be at least $3/2$ at that orbit dimension. So the failure to certify $\theta\le\sqrt{3/2}$ at $d=4n-14$ is not a deficiency of the method: it is forced, and the only bound that could certify there is one that is *sharp* there. The deficiency is elsewhere, at $d$ near $n(n-1)/2$, where the bound reads $3.4684$ at $n=12$ and $3/2$ would be permitted by no known obstruction.

**The $n=4$ spectrum in full,** since it is the one place I can exhibit everything. With $a=t(-1,-1,2)$, $t=1/\sqrt6$ and $\theta=3t$, the four directions of the self-dual block plus $W$ itself give, using $M_A(A')=\tfrac32(AA'+A'A)-\mathop{\mathrm{tr}}(AA')I$:

- the diagonal direction $v\propto(1,1,-2)$ is $W$ itself, with $L_e$-eigenvalue $1$,
- the diagonal direction $(1,-1,0)$ gives $-1$,
- the off-diagonal $e^s_{12}$ gives $\tfrac32(a_1+a_2)/\theta=-1$,
- the off-diagonal directions $e^s_{13}$ and $e^s_{23}$ give $\tfrac32(a_1+a_3)/\theta=\tfrac12$ each,
- the whole anti-self-dual block, five dimensions, is annihilated by $L_W$ and gives $0$.

So
$$\mathop{\mathrm{spec}}L_e=\{1,\ \tfrac12,\tfrac12,\ -1,-1,\ 0,0,0,0,0\},$$
with $\mathop{\mathrm{tr}}L_e=1+1-2=0$ and $\mathop{\mathrm{tr}}(L_e^2)=1+\tfrac12+2=\tfrac72=\kappa(4)/(3/2)$. The orbit tangent is $[\mathfrak{so}(3),A]=\mathop{\mathrm{span}}(e^s_{13},e^s_{23})$, of dimension $2$, equal to the $\tfrac12$-eigenspace, so $d=2=4\cdot4-14$ and the literal spectral shape of Claim 1 holds exactly here.

**A by-product worth recording.** The same analysis classifies the $n=4$ critical set completely: every nonzero block has eigenvalue pattern $(p,p,-2p)$ with $\lVert{\cdot}\rVert^2=\tfrac23\theta^2$, so one block gives $\theta^2=3/2$ with $d=2$ and two blocks give $\theta^2=3/4=\theta_0(4)^2$ with $d=4$, and there is nothing else. In particular the maximum of $\lvert\theta\rvert$ at $n=4$ is exactly $\sqrt{3/2}$, and the orbit dimension $d=6$ never occurs at an $n=4$ critical point.

## 5. Claim 2's direction, and which end binds

**Verified, twice over.** At fixed $k$, $\partial f/\partial d=\tfrac14+\frac{2(2+d)}{4k}=\tfrac14+\frac{2+d}{2k}>0$ for $d\ge0$ and $k\ge1$, so $f$ is strictly increasing in $d$. **Claim 2 confirmed.**

The statement as written is about fixed $k$, which is not the coupling that occurs, since $k=D-1-d$ falls as $d$ rises. Fortunately the composite is increasing too, and more strongly: in $g(d):=f(d,D-1-d)=1+\frac d4+\frac{(2+d)^2}{4(D-1-d)}$ the second term rises with $d$ and the third rises in numerator and falls in denominator simultaneously, so $g$ is strictly increasing on $0\le d\le D-2$. I checked this exactly for $n=12$ at every $d$ from $0$ to $1637$. So Claim 2's conclusion survives the substitution, and the gap in its statement is cosmetic rather than a defect.

**Which end binds, said explicitly.** $\kappa/g$ is strictly *decreasing* in $d$. Therefore:

- To **use** the bound at a given critical point you must use that point's own $d$, and small $d$ gives a weak bound. At $n=12$, $\kappa/g(0)=63.21$ while $\kappa/g(66)=3.47$.
- To decide whether the bound can **ever** certify $\theta^2\le3/2$ you need $\min_d\kappa/g(d)$, which sits at the **largest** admissible $d$. So Claims 3, 4 and 5 must be evaluated at $d=n(n-1)/2$, and Claim 3 correctly does so with $d=66=\dim SO(12)$.

A reviewer who read Claim 2 as "larger $d$ makes the bound stronger, and large $d$ is generic, so the bound is strong" would conclude the opposite of Claim 5. The reconciliation is that both are true: the bound *is* strongest at large $d$, and it is still not strong enough there, which is exactly Claim 4.

## 6. Claims 3 and 4 as arithmetic

**Claim 3, exact.** $n=12$ gives $\kappa=\frac{23\cdot11}4=\frac{253}4$, $D=\frac{12\cdot13\cdot14\cdot9}{12}=1638$, $k=1638-1-66=1571$, and
$$f(66,1571)=1+\frac{66}4+\frac{68^2}{4\cdot1571}=\frac{35}2+\frac{1156}{1571}=\frac{57297}{3142},\qquad \frac{\kappa(12)}{f}=\frac{253}{4}\cdot\frac{3142}{57297}=\frac{397463}{114594}.$$
That fraction is in lowest terms ($114594=2\cdot3\cdot71\cdot269$ shares no factor with $397463$) and equals $3.4684451192907\ldots$, so the brief's $3.46844\ldots$ is right, with excess $\frac{112786}{57297}=1.96844\ldots$ over $3/2$. **Confirmed.**

**Claim 4, proved rather than sampled.** By §5 it suffices to check $d=m:=n(n-1)/2$. Write $\kappa-\tfrac32g(m)=\Big[\kappa-\tfrac{3m}8\Big]-\tfrac32-T$ with $T:=\frac{3(2+m)^2}{8(D-1-m)}$, and compute
$$\kappa-\frac{3m}8=\frac{(2n-1)(n-1)}4-\frac{3n(n-1)}{16}=(n-1)\cdot\frac{4(2n-1)-3n}{16}=\frac{(n-1)(5n-4)}{16}.$$
Now bound $T$. Since $2+m=\frac{n^2-n+4}2\le\frac{n^2}2$ for $n\ge4$, we have $3(2+m)^2\le\frac34n^4$. And $D=\frac{n(n^3-7n-6)}{12}$ with $1-\frac7{n^2}-\frac6{n^3}$ increasing, so $D\ge\frac{84}{125}\cdot\frac{n^4}{12}=\frac{7n^4}{125}$ for $n\ge5$, and since $\frac{7n^4}{125}\ge n^2$ for $n\ge5$ we get $m+1\le\frac{n^2}2\le\frac D2$ and hence $D-1-m\ge\frac D2$. Therefore
$$8(D-1-m)\ \ge\ 4D\ \ge\ \frac{28n^4}{125}\ =\ 0.224\,n^4\ >\ \frac{3}{16}n^4,\qquad\text{so}\qquad T\ <\ 4 .$$
It remains to have $\frac{(n-1)(5n-4)}{16}>\frac32+4=\frac{11}2$, that is $(n-1)(5n-4)>88$, which holds for $n\ge6$ ($5\cdot26=130$). For $n=5$ the crude bound $T<4$ is too weak, and the direct value settles it: $\kappa(5)=9$, $D=35$, $m=10$, $k=24$, $f=1+\tfrac52+\tfrac{144}{96}=5$, so $\kappa/f=\tfrac95=1.8>\tfrac32$. **Claim 4 confirmed for every $n\ge5$.** Values at $d=m$: $\tfrac95$, $\tfrac{220}{93}=2.3656$, $\tfrac{3796}{1393}=2.7251$, $\tfrac{28455}{9572}=2.9727$, $\tfrac{15572}{4941}=3.1516$, $\tfrac{123804}{37685}=3.2852$, $\tfrac{228480}{67441}=3.3879$, $\tfrac{397463}{114594}=3.4684$ for $n=5,\dots,12$.

**Is $n=4$ genuinely excluded?** Yes, and for a reason. At $n=4$, $D=10$ is small, so $\frac{(2+d)^2}{4k}$ is large and the bound collapses. The exact scan is $189/40,\ 24/7,\ 147/58,\ 126/67,\ 105/76,\ 84/85,\ 63/94$ for $d=0,\dots,6$, which crosses $3/2$ between $d=3$ and $d=4$. So the $n=4$ statement is the reverse of Claim 4 for $d\ge4$, and there the bound is strong enough to certify $\theta\le\sqrt{105/76}=1.1754<\sqrt{3/2}$. This is consistent with §4: the only $n=4$ critical points with $d=4$ have $\theta^2=3/4$, comfortably under $105/76$, and the $\theta^2=3/2$ point has $d=2$ where the bound reads $147/58=2.5345$. There is no contradiction, and $n=4$ must stay outside Claim 4.

**Is $d\le n(n-1)/2$ the right constraint?** It is the right *unconditional* one, since $d=\dim O(n)-\dim\mathop{\mathrm{Stab}}(W)$. A smaller ceiling does hold at $n=4$: by the classification in §4, every nonzero block forces a repeated eigenvalue and hence an $O(2)$ in the stabiliser, so $d\le4$ at $n=4$ critical points and $d=6$ never occurs. For $n\ge5$ the givens supply no smaller ceiling and I found none. The good news is that Claim 4 is robust to this: $\kappa/g$ is decreasing in $d$, so shrinking the admissible range of $d$ can only *raise* the floor. Any future ceiling $d\le d_{\text{ceil}}<n(n-1)/2$ strengthens Claim 4 and strengthens Claim 5 with it.

## 7. Claim 5's reach

Two readings, and the claims support only the first.

- **(i) This particular bound never reaches $\sqrt{3/2}$ at $n\ge5$.** Supported, and it is exactly Claim 4 read through Claim 2. The asymptotic is right too: at $d=m$ the numerator is $\frac{(2n-1)(n-1)}4=\frac{n^2}2-\frac{3n}4+\frac14$ and $4\times$ the denominator is $\frac{n^2}2-\frac n2+4+\frac{(2+m)^2}{D-1-m}$, whose last term tends to $3$, so the ratio tends to $4$, and the difference numerator minus $4\times$ denominator is $-\frac n4-\frac74-\frac14\cdot\frac{(2+m)^2}{D-1-m}<0$, giving approach from below. Exactly: $1.8$ at $n=5$, $3.2852$ at $n=10$, $3.7641$ at $n=20$, $3.9378$ at $n=50$, $3.9744$ at $n=100$, $3.997944$ at $n=1000$, $3.9997994$ at $n=10^4$. So $\theta\le2$ in the limit. **Confirmed.**
- **(ii) No bound obtainable from (G2) and (G3) reaches it.** Not supported, and the record should not drift into it. (G2) and (G3) carry strictly more information than the two moments $\mathop{\mathrm{tr}}L_e$ and $\mathop{\mathrm{tr}}(L_e^2)$ that Claim 1 consumes, and §1 localises the entire loss in a single Cauchy–Schwarz step whose slack is enormous at the one point where I can measure it: $\sum\mu_i^2=2$ against a floor of $4/7$ at the $n=4$ one-block point, a factor of $3.5$.

**What extra input would be needed for (ii).** Any one of these would change the arithmetic qualitatively, and each is a concrete thing to go and prove.

- **A third moment.** A closed form for $\mathop{\mathrm{tr}}(L_e^3)$, or any identity for $\mathop{\mathrm{tr}}(L_x^3)$ on this algebra, replaces Cauchy–Schwarz with a three-moment problem on the bucket, whose optimum is strictly better whenever the true spectrum is not flat.
- **A one-sided eigenvalue bound.** In both $n=4$ critical points the bucket lies in $[-1,0]$. If $\mu_i\ge-1$ holds in general then $\sum\mu_i^2\le\lvert\sum\mu_i\rvert=\frac{2+d}2$, which is the wrong direction, but the companion constraint $\mu_i\le\mu_{\max}$ with $\mu_{\max}<\tfrac12$ would concentrate the negative mass and raise $\sum\mu_i^2$ above the flat value.
- **A known further eigenspace.** Both $n=4$ points have large fixed-eigenvalue blocks ($0$ with multiplicity $5$, or $-1$ with multiplicity $4$) that the bucket treatment discards. An a priori lower bound on the multiplicity of some eigenvalue bounded away from zero would raise $f$ directly.

**Two smaller precision points on Claim 5's wording.** First, "at any critical point" should read "at any critical point with $\theta\ne0$", since $\theta=0$ points carry no $e$ and need no certificate (§3). Second, "the best value the bound can take" is an envelope over *admissible* $d$, not over *realised* $d$, and the two differ: at $n=4$ the value at $d=6$ is unreachable because no critical point has $d=6$. Whether $d=n(n-1)/2$ is realised at any $n\ge5$ critical point is open, so the limit $4$ is an upper envelope of what the bound could say rather than a value it is known to take.

## 8. Is the bound worth anything?

It is worth something at large orbit dimension and nothing at the orbit dimensions the record can currently guarantee. Comparing in $\theta^2$, the standing bound of (G4) is $(n-1)^2/(n+1)$.

| $n$ | $(n-1)^2/(n+1)$ | new bound at $d=0$ | crossover $d^\ast$ | new bound at $d^\ast$ | new bound at $d=n-1$ | $d_{\max}$ | new bound at $d_{\max}$ |
|---|---|---|---|---|---|---|---|
| 5 | 2.6667 | 8.7429 | 7 | 2.5714 | 3.9130 | 10 | 1.8000 |
| 6 | 3.5714 | 13.5863 | 10 | 3.4434 | 5.7124 | 15 | 2.3656 |
| 8 | 5.4444 | 26.1625 | 15 | 5.2454 | 9.3107 | 28 | 2.9727 |
| 12 | 9.3077 | 63.2114 | 23 | 9.2379 | 16.7506 | 66 | 3.4684 |
| 20 | 17.1905 | 185.2358 | 39 | 17.1811 | 32.1702 | 190 | 3.7641 |
| 50 | 47.0784 | 1212.7477 | 100 | 46.6352 | 91.5197 | 1225 | 3.9378 |
| 100 | 97.0396 | 4925.2494 | 200 | 96.5712 | 191.2696 | 4950 | 3.9744 |

Reading the table: because $\kappa/g$ is decreasing in $d$, the new bound wins exactly for $d\ge d^\ast(n)$, and $d^\ast(n)$ grows like $2n$ (the leading-order condition $1+\frac d4>\frac{\kappa(n+1)}{(n-1)^2}\approx\frac n2$ gives $d^\ast\approx2n-4$, against $23$ at $n=12$ and $200$ at $n=100$). Where it wins it wins by a lot, ending at roughly $4$ against roughly $n$.

**So a lower bound on $d$ valid at every critical point is needed, and the available one falls short.** What (G3) supplies is only $d\ge1$, from the absence of an invariant vector. Sharpening that with the classification of maximal connected subgroups of $SO(n)$ gives $d\ge n-1$ for $n\ge5$, since a proper closed subgroup has codimension at least $n-1$ there, and that value is attained by $SO(n-1)$ and by $Spin(7)\subset SO(8)$. But $n-1<d^\ast(n)\approx2n$ for every $n\ge5$, and the table's "new bound at $d=n-1$" column is worse than (G4) in every row, by a factor near $2$. Even the best structural lower bound of this kind therefore leaves the new bound strictly weaker than the bound the record already has.

**Finding F2, stated as the debt.** To make Claim 1 into a usable theorem one must prove: *at every critical point of $\mathcal W_n$ with $\theta\ne0$, the orbit dimension satisfies $d\ge d^\ast(n)$*, where $d^\ast(n)$ is the least $d$ with $g(d)>\kappa(n)(n+1)/(n-1)^2$, equal to $7$ at $n=5$, $23$ at $n=12$, and asymptotic to $2n$. Absent that, Claim 1 is a conditional statement whose hypothesis is unverified at exactly the points that matter, and the honest status of the whole line is HYPOTHESIS-DEBT rather than a bound. Note the direction of difficulty: large $d$ means *small* stabiliser, so the debt asks for a proof that critical Weyl tensors carry little symmetry, and the padded family of §4 bounds how much of that is available, since it realises $d=4n-14$ at every $n\ge4$.

**And at $n=5$ the debt is not merely open, it is false, with a closed-form witness.** The padded critical point at $n=5$ has $d=4\cdot5-14=6$, while $d^\ast(5)=7$. So no theorem can assert $d\ge d^\ast(5)$ at every $n=5$ critical point, and at that very point the new bound reads $\kappa(5)/g(6)=126/43=2.9302$ against (G4)'s $(n-1)^2/(n+1)=16/6=2.6667$. The standing bound is the better of the two there. This settles the "worth anything" question in the concrete: the new bound is **not** a uniform improvement on (G4), and the first place it loses is exhibited rather than estimated. From $n=6$ upward the padded point sits at or above $d^\ast$ ($d=10=d^\ast(6)$, $d=18>15=d^\ast(8)$, $d=34>23=d^\ast(12)$), so the debt stays open there, and any proof of it must be $n$-dependent and nearly tight against $4n-14$.

## 9. Vacuity check

**What vacuity would look like.** Two forms. Form one: no critical point satisfies the hypothesis, so Claim 1 quantifies over the empty set. Form two: the two trace identities together with the assumed spectral shape are mutually inconsistent, so the hypothesis is contradictory and the conclusion is free.

**Neither holds, and I exhibit the witness.** The $n=4$ one-block critical point of §4 has
$$\mathop{\mathrm{spec}}L_e=\{\underbrace{1}_{\text{mult }1},\ \underbrace{\tfrac12,\tfrac12}_{\text{mult }d=2},\ \underbrace{-1,-1,0,0,0,0,0}_{k=7}\},$$
which is *exactly* the shape Claim 1 assumes, with $d=2$ the true orbit dimension. It satisfies both identities on the nose: $\mathop{\mathrm{tr}}L_e=1+1-2=0$, and $\mathop{\mathrm{tr}}(L_e^2)=1+\tfrac12+2=\tfrac72$ against $\kappa(4)/\theta^2=\frac{21/4}{3/2}=\frac72$. The bucket sums to $-2=-(1+d/2)$ as the first identity demands. So the hypothesis class is nonempty, the identities are consistent with a real $\theta$, and Claim 1 is non-vacuous.

**One structural remark that comes free.** The first identity forces $\sum\mu_i=-\frac{2+d}2<0$, so every critical point with $\theta\ne0$ has at least one eigenvalue of $L_e$ strictly negative, and $k\ge1$ is therefore forced rather than assumed: if $k$ were $0$ the identity would read $0=-\frac{2+d}2$, impossible. The divisor in $f$ is always legitimate.

## 10. What would break it

**Falsifier for Claim 1.** A critical point $W\in\mathcal W_n$ with $\theta\ne0$, orbit dimension $d$, and $\theta^2>\kappa(n)/f(d,D-1-d)$. By §1 such an object requires at least one of: a non-self-adjoint $L_e$ (hence a complex conjugate pair in the bucket, which breaks the Cauchy–Schwarz step), an orbit tangent of dimension below $d$ or not contained in the $\tfrac12$-eigenspace, or a wrong $\kappa(n)$. Each of those is a falsifier of an *import*, not of the deduction, which is why my verdict on Claim 1 is confirmation of the algebra and my two findings sit on the hypotheses instead.

**What I did to look for it.** At $n=4$ I derived the complete critical set in closed form, two $O(4)$-orbits up to sign with $\theta^2\in\{3/2,3/4\}$ and $d\in\{2,4\}$, computed both spectra of $L_e$ in full, and checked both against the bound: slack factors of $1.69$ and $1.84$ respectively. I verified $\kappa(4)=21/4$ and $\mathop{\mathrm{tr}}L_x=0$ in that model independently. For $n\ge5$ I constructed the padded family in closed form, computed its orbit dimension as $4n-14$ from the stabiliser rather than assuming it, and checked the bound at $n=5,6,8,12,20$. I did **not** search for critical points at $n\ge5$ beyond the padded family, because that is a census of a family with no bound on where it looks and the standing rule reserves it for explicit approval. Nothing I constructed comes close to violating Claim 1.

**Falsifier for Claim 5, reading (i).** An $n\ge5$ and a $d\le n(n-1)/2$ with $\kappa(n)/f(d,D-1-d)\le3/2$. §6 rules this out for every $n\ge5$ by proof, so reading (i) has no falsifier. **Falsifier for reading (ii),** which I hold to be unsupported: any of the three extra inputs named in §7, since each would give a bound derived from (G2) and (G3) that the two-moment estimate cannot see. Producing one of those is the constructive form of refuting the strong reading, and it is where I would spend the next cycle.

## Verdict

**The mathematics of Claims 1 through 4 is correct, and the conclusion drawn in Claim 5 is correct about this bound and only about this bound.** Claim 1 follows from the two trace identities by a single Cauchy–Schwarz step in the right direction, and it follows under a hypothesis strictly weaker than the one stated, namely multiplicity at least $1$ for the eigenvalue $1$ and at least $d$ for $\tfrac12$, which by (G3) holds at every critical point with $\theta\ne0$. Rewriting the hypothesis that way is a strict improvement and is also necessary, because the literal version is refuted by the $n=4$ two-block critical point where the eigenvalue $1$ has multiplicity $2$. Claim 2 is right and its direction is right, with the binding end at the largest $d$. Claims 3 and 4 are exact, and Claim 4 admits a short proof for every $n\ge5$ rather than a sample, with $n=4$ genuinely excluded for a structural reason. Claim 5 holds as a statement about the two-moment estimate, it should not be read as a statement about what (G2) and (G3) can yield, and its wording needs the $\theta\ne0$ restriction and the distinction between admissible and realised $d$.

**The load-bearing weakness is not in any of the five claims.** It is that the bound beats the record's standing $(n-1)/\sqrt{n+1}$ only for $d\gtrsim2n$, while the best lower bound on orbit dimension available at every critical point is $d\ge n-1$, and at $n=5$ the padded critical point with $d=6$ shows the required $d\ge7$ to be false outright, with (G4) winning there. So the bound is a conditional statement whose hypothesis is unverified from $n=6$ upward and refuted at $n=5$, and the entire Cauchy–Schwarz slack, measured at $3.5$-fold at the one point where I could measure it, is where any improvement must come from.
