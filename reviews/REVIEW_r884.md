# Reviewer r884: the trace-form bound $\theta^2\le\kappa(n)/f(d,k)$ and the floor claimed for it (Claims 1–5)

Cold brief, worked from the definitions and givens alone: I read no findings file, no plan, no route, and no other review. Everything below is derived from (G1)–(G4) as stated, plus one imported structural fact I flag explicitly (self-adjointness of $L_e$).

I computed. Every value is exact rational arithmetic unless marked as a float rounding of an exact value. Three computations: the Claim 3 and Claim 4 arithmetic in `fractions.Fraction`, the comparison of the new bound against the standing $(n-1)/\sqrt{n+1}$, and an explicit five-dimensional model of the self-dual half of $\mathcal W_4$ in which I located two critical points in closed form and diagonalised $L_e$ at each. That model was validated against both trace identities of (G2) before any claim was read off it: $\operatorname{tr}L_X=1.5\cdot10^{-16}$ and $\operatorname{tr}(L_XL_Y)=5.689721082133507$ against $\tfrac{21}{4}\langle X,Y\rangle=5.689721082133508$ at a random pair. Nothing here is a numerics-established positive claim: the two critical points are exhibited in closed form and their spectra are rational, and the arithmetic of Claims 3 and 4 is exact with a polynomial certificate.

Log: [agent_logs/review-r884-traceform.log](../agent_logs/review-r884-traceform.log).

## Claim table

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | $\theta^2\le\kappa(n)/f(d,k)$ under the stated spectral shape | **CONFIRMED AS ALGEBRA** | two trace moments plus Cauchy–Schwarz on the unknown block, applied in the correct direction, with equality iff all $\mu_i$ coincide |
| H | the spectral shape "$1$ with multiplicity $1$, $\tfrac12$ with multiplicity $d$" | **REFUTED AS STATED** | an exact $n=4$ critical point has $1$ with multiplicity $2$, though the conclusion of Claim 1 survives because both clauses may be weakened to lower bounds |
| 2 | $f$ strictly increasing in $d$ | **CONFIRMED** | $\partial_d f=\tfrac14+\tfrac{2+d}{2k}>0$, and also increasing along $k=D-1-d$ |
| 3 | $\kappa(12)/f(66,1571)>\tfrac32$ | **CONFIRMED** | exactly $397463/114594=3.4684451\ldots$ |
| 4 | $\kappa(n)/f(d,D-1-d)>\tfrac32$ for all $n\ge5$, $d\le n(n-1)/2$ | **CONFIRMED** | monotonicity reduces it to $d=n(n-1)/2$, where the certificate $5n^6-9n^5-103n^4+153n^3+38n^2+252n-48>0$ holds for $n\ge5$ |
| 4′ | $n=4$ is genuinely excluded | **CONFIRMED** | the certificate is $-3744$ at $n=4$, and the bound there is $63/94$ at $d=6$ and already $105/76<\tfrac32$ at $d=4$ |
| 5 | this bound cannot certify $\theta\le\sqrt{3/2}$ for $n\ge5$, best value $\to4$ from below | **CONFIRMED** | reading (i) only, which is what the sentence says, and the $\to4^-$ limit checks, $3.97442255$ at $n=100$ |
| 5′ | the stronger reading, that no bound from (G2)+(G3) reaches $\sqrt{3/2}$ | **REFUTED AS STATED** | the same method reaches it at $n=4$ for $d\ge4$, and (G2) holds at every element rather than only at $e$ |
| 8 | the bound is worth more than the standing $(n-1)/\sqrt{n+1}$ | **HYPOTHESIS-DEBT** | it wins only for $d\gtrsim2n$, while the only orbit-dimension lower bound available is $d\ge n-1$, at which it loses by roughly a factor $2$ |

**One line for the cycle.** The bound is correct and its floor is correct, so the route it was meant to serve is dead for $n\ge5$, but two repairs are visible and cheap: carry the multiplicity $p$ of the eigenvalue $1$ as a variable, which makes the bound *exact* at an $n=4$ critical point ($\kappa/\,[\,p+\tfrac d4+\tfrac{(2p+d)^2}{4k}]=3/4=\theta^2$ at $p=2,d=4$), and record as a hypothesis debt the missing lower bound $d\gtrsim2n$ without which the bound is weaker than what the record already has.

## 0. Conventions, fixed once

Quoted from the brief.

- "$n\ge4$ an integer. $\mathcal W_n$ is the space of Weyl tensors in dimension $n$: algebraic curvature tensors that are Ricci-flat and satisfy the first Bianchi identity. $D:=\dim\mathcal W_n$."
- "The norm is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$ (the 'Frobenius normalisation')."
- "$Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$, a cubic form on $\mathcal W_n$."
- "A **critical point** is $W$ with $\lVert W\rVert=1$ and $Q(W)=\theta W$ for a scalar $\theta$; then $\theta=P(W)$."
- "$O(n)$ acts on $\mathcal W_n$ orthogonally. $d:=\dim\big(O(n)\cdot W\big)$, the dimension of the orbit of $W$."
- "$L_x$ denotes the multiplication operator of the commutative nonassociative algebra on $\mathcal W_n$ whose cubic form is $P$; for $\theta\ne0$ set $e:=W/\theta$, which is an idempotent of that algebra."
- (G2): "$\operatorname{tr}L_x=0$, and $\operatorname{tr}(L_xL_y)=\kappa(n)\langle x,y\rangle$ with $\kappa(n)=\frac{(2n-1)(n-1)}{4}$ … Consequently at an idempotent $e=W/\theta$, where $\lvert e\rvert^2=1/\theta^2$, one has $\operatorname{tr}(L_e^2)=\kappa(n)/\theta^2$."
- (G3): "$L_ee=e$ … and the tangent space to the $O(n)$-orbit of $W$ lies in the $\tfrac12$-eigenspace of $L_e$. … The orbit tangent is never zero, since $\mathcal W_n$ carries no $O(n)$-invariant vector."
- $k:=D-1-d$ and $f(d,k):=1+\frac d4+\frac{(2+d)^2}{4k}$.

## 1. Hypothesis inventory

Every hypothesis carried by the claims and by what they import, each checked against the object it applies to, with a column saying whether the argument actually consumes it.

| Hypothesis | Carried by | Status on the objects at hand | Used? |
|---|---|---|---|
| $\lVert W\rVert=1$ and $Q(W)=\theta W$ | all claims | holds by definition of critical point | yes, via $\lvert e\rvert^2=1/\theta^2$ |
| $\theta\ne0$ | Claims 1, 5 | needed to define $e=W/\theta$ at all | yes, essentially |
| $\theta>0$ | Claim 1 as written | strictly stronger than needed | **no**: see §4 |
| $L_e$ self-adjoint, hence real spectrum and $\operatorname{tr}(L_e^2)=\sum\lambda_i^2$ | imported, unstated in the brief | holds, because $\langle x\circ y,z\rangle$ is the full polarisation of the cubic $P$ and is therefore totally symmetric, and verified numerically in the $n=4$ model ($L_X$ symmetric) | **yes, load-bearing**: Cauchy–Schwarz over $\mathbb R$ fails for a complex-conjugate pair, where $\sum\lambda_i^2$ can even be negative |
| $\operatorname{tr}L_e=0$ | (G2) | given | yes, supplies the first moment |
| $\operatorname{tr}(L_e^2)=\kappa(n)/\theta^2$ | (G2) | given, and independently reproduced at $n=4$, where $\operatorname{tr}(L_e^2)=7/2$ against $\kappa(4)/\theta^2=(21/4)/(3/2)=7/2$ at the $\theta=\sqrt{3/2}$ point and $7$ against $7$ at the $\theta=\sqrt3/2$ point | yes, supplies the second moment |
| $1$ is an eigenvalue of $L_e$ | (G3), $L_ee=e$ | holds, $e\ne0$ | yes |
| multiplicity of $1$ is **exactly** $1$ | Claim 1 | **fails** at an exhibited critical point (§3) | no: only "at least $1$" is used |
| $\tfrac12$-eigenspace has dimension **exactly** $d$ | Claim 1 | holds exactly at both $n=4$ critical points I found, but (G3) gives only the inclusion, so equality is an extra assumption in general | no: only "at least $d$" is used |
| $d\ge1$ | (G3), orbit tangent nonzero | holds | not by the inequality, though it matters for §9 |
| $k=D-1-d\ge1$ | implicit in $f$, which divides by $k$ | **forced**, not assumed: $k=0$ would give $\operatorname{tr}L_e=1+\tfrac d2>0$, contradicting (G2) | yes |
| $0\le d\le n(n-1)/2$ | Claim 4 | holds, and is a hard cap since $d\le\dim O(n)$. At $n=4$ the true ceiling for *critical* points is $4$, not $6$ (§7) | yes, as the range quantified over |
| $\kappa(n)>0$ | (G2) | $(2n-1)(n-1)/4>0$ for $n\ge4$ | yes, to divide by $f$ preserving the sense |
| the Frobenius normalisation, rather than the metric four times it | (G2)'s parenthesis | matters: the two differ by a factor $4$ in $\kappa$ and would move Claims 3 and 4 wholesale | yes, and my $n=4$ model reproduces $\kappa(4)=21/4$, so the convention used here is the stated one |
| $d\gtrsim2n$ at every critical point | **not** carried by any claim, but needed for the bound to beat (G4) | unproved, and the best available lower bound $d\ge n-1$ is far short of it | this is the debt of §10 |

## 2. Does Claim 1 follow?

Yes. Let the spectrum of $L_e$ be $1$ once, $\tfrac12$ with multiplicity $d$, and $\mu_1,\dots,\mu_k$ with $k=D-1-d$. The two identities of (G2) at $e$ read

$$\operatorname{tr}L_e=1+\frac d2+\sum_{i=1}^k\mu_i=0,\qquad \operatorname{tr}(L_e^2)=1+\frac d4+\sum_{i=1}^k\mu_i^2=\frac{\kappa(n)}{\theta^2}.$$

The first fixes the first moment of the unknown block, $\sum_i\mu_i=-\frac{2+d}{2}$. Cauchy–Schwarz against the all-ones vector, $\big(\sum_i\mu_i\big)^2\le k\sum_i\mu_i^2$, then gives

$$\sum_{i=1}^k\mu_i^2\ \ge\ \frac{1}{k}\Big(\frac{2+d}{2}\Big)^2=\frac{(2+d)^2}{4k},$$

so $\dfrac{\kappa(n)}{\theta^2}\ \ge\ 1+\dfrac d4+\dfrac{(2+d)^2}{4k}=f(d,k)$, and since $f(d,k)\ge1>0$ and $\kappa(n)>0$, inverting gives $\theta^2\le\kappa(n)/f(d,k)$.

**Which inequality does the work, and in which direction.** Cauchy–Schwarz, used as a *lower* bound on $\sum\mu_i^2$ from a *fixed* $\sum\mu_i$. The direction is right: a lower bound on $\operatorname{tr}(L_e^2)=\kappa/\theta^2$ is an upper bound on $\theta^2$. The one place a sign could have been fumbled is the inversion, and it is correct because both sides are positive.

**Equality.** The step is an equality exactly when all $\mu_i$ are equal, that is $\mu_i=-\frac{2+d}{2k}$ for every $i$. At $n=12$, $d=66$ that means $1571$ eigenvalues all equal to $-34/1571$, alongside $1$ and $\tfrac12^{(66)}$. Combined with the Peirce-type structure an idempotent forces on a multiplication operator, that is a very rigid spectrum, so equality should be expected to be unattained and the bound to be lossy. §5 measures the loss at a real critical point: a factor $3.5$ in the Cauchy–Schwarz step at $n=4$ and a factor $160$ at $n=12$.

**No finding on the derivation itself.** I re-derived it independently and reached the stated inequality with the stated constant.

## 3. The spectral shape as a hypothesis: REFUTED AS STATED, conclusion survives

This is the item where the brief's claim is wrong and the claim's conclusion is nonetheless safe. Both failure modes the brief names occur or are permitted, and neither hurts, because the derivation of §2 consumes only *lower* bounds on the two multiplicities.

**The general form.** Let $\lambda_1,\dots,\lambda_r$ be eigenvalues of $L_e$ known with multiplicities $m_1,\dots,m_r$, put $M=\sum m_i$, $S_1=\sum m_i\lambda_i$ and $k=D-M\ge1$. The same two moments give

$$\frac{\kappa(n)}{\theta^2}\ \ge\ \sum_i m_i\lambda_i^2+\frac{S_1^2}{D-M}. \tag{$\ast$}$$

Claim 1 is $(\ast)$ at $r=2$ with $(\lambda,m)=(1,1),(\tfrac12,d)$.

**Case A: the $\tfrac12$-eigenspace is strictly larger than the orbit tangent,** multiplicity $m>d$. Then $(\ast)$ gives $\theta^2\le\kappa/f(m,D-1-m)$, and since $f(\cdot,D-1-\cdot)$ is strictly increasing (§6), $\kappa/f(m,D-1-m)<\kappa/f(d,D-1-d)$. So the statement of Claim 1 **still holds**, as a strictly weaker consequence of a sharper true bound. The hypothesis of exact equality is free.

**Case B: the eigenvalue $1$ has multiplicity $p>1$.** Then $(\ast)$ with $(1,p),(\tfrac12,d)$ gives

$$\theta^2\ \le\ \frac{\kappa(n)}{f_p(d,p)},\qquad f_p(d,p):=p+\frac d4+\frac{(2p+d)^2}{4(D-p-d)},$$

and $f_p$ is increasing in $p$, so again the stated bound **still holds** and is not the sharpest available. Claim 1's conclusion is therefore a statement about *every* critical point with $\theta\ne0$, not only about ones with a spectral coincidence. What is *not* about every critical point is Claim 1's stated hypothesis.

**And Case B is real, not hypothetical.** In the five-dimensional model of the self-dual half of $\mathcal W_4$ (see §5 for its construction and validation), the element $W=(A,C)$ with $A=C=\operatorname{diag}(-1,-1,2)/\sqrt{12}$ satisfies $\lVert W\rVert=1$ and $Q(W)=\theta W$ with $\theta=\sqrt3/2=\theta_0(4)$ of (G4), and its orbit dimension is $d=4$ by rank computation. Its $L_e$ spectrum is exactly

$$\{\,1,1,\ \tfrac12,\tfrac12,\tfrac12,\tfrac12,\ -1,-1,-1,-1\,\},\qquad \textstyle\sum\lambda=0,\ \sum\lambda^2=7=\kappa(4)/\theta^2=(21/4)/(3/4).$$

The eigenvalue $1$ has multiplicity $2$. So the clause "$1$ with multiplicity $1$" is false at a genuine critical point, which is why the H row above is REFUTED AS STATED rather than merely unnecessary.

**The payoff, and the recommendation for the cycle.** At that point the refined bound is *attained*: $p=2$, $d=4$, $k=D-p-d=4$ gives $f_p=2+1+\frac{(4+4)^2}{16}=7$ and $\kappa(4)/7=3/4=\theta^2$ exactly, because the four remaining eigenvalues are all $-1$ and Cauchy–Schwarz is an equality. The plain Claim 1 bound at the same point is $\kappa(4)/f(4,5)=105/76=1.3816\ldots$, a factor $1.84$ loose. Carrying $p$ as a variable costs nothing and turns a lossy inequality into an exact identity at the one critical point where I could check it. That is the cheapest improvement visible from this brief.

## 4. $\theta>0$, $\theta=0$, $\theta<0$

**Positivity is spent nowhere.** The derivation of §2 uses $\theta\ne0$, to form $e=W/\theta$, and then only $\lvert e\rvert^2=1/\theta^2$, which is even in $\theta$. The conclusion bounds $\theta^2$. So Claim 1 holds verbatim for $\theta<0$, and the hypothesis $\theta>0$ can be replaced by $\theta\ne0$ at no cost.

There is a cleaner reason, worth recording. $Q$ is homogeneous of degree $2$, so $W\mapsto-W$ carries critical points to critical points with $\theta\mapsto-\theta$, while $L_{-W}=-L_W$ and hence

$$e(-W)=\frac{-W}{-\theta}=e(W),\qquad L_{e(-W)}=L_{e(W)}.$$

The idempotent, and therefore the entire spectrum, the orbit dimension and the bound, are invariant under the sign flip. A critical point with $\theta<0$ is the same idempotent seen twice. In the $n=4$ model this is visible directly: $A=\operatorname{diag}(1,1,-2)/\sqrt6$ gives $\theta=-\sqrt{3/2}$ with the identical $L_e$ spectrum $\{1,\tfrac12^{(2)},-1^{(2)},0^{(5)}\}$.

**At $\theta=0$.** Then $Q(W)=0$, $e$ is undefined, $L_e$ does not exist, and every claim above is silent by hypothesis. Read as a statement about $\theta^2$ it is trivially true, $0\le\kappa/f$, and carries no information. Claims 3, 4 and 5 are unaffected because they are arithmetic about the right-hand side. Two remarks:

- at $n=4$ there are **no** critical points with $\theta=0$: in the model, $Q(W)=0$ forces $3A^2=\operatorname{tr}(A^2)I_3$ on each half, so $A^2=\lambda I$ with $\lambda\ge0$ and the three eigenvalues of $A$ all equal $\pm\sqrt\lambda$ while summing to zero, which forces $\lambda=0$ and $A=0$, and likewise $C=0$, contradicting $\lVert W\rVert=1$;
- for general $n$ the useful substitute at $\theta=0$ is the same identity applied to $W$ itself rather than $e$: $\operatorname{tr}(L_W^2)=\kappa(n)$ with $\operatorname{tr}L_W=0$ and $L_WW=Q(W)=0$, so $0$ is an eigenvalue and $\sum\lambda_i^2=\kappa(n)$ over the remaining $D-1$. That constrains the spectrum without saying anything about $\theta$, which is already known.

## 5. $\ker W\ne0$ and the padded tensor: the orbit dimension is $d=4n-14$

Nothing in the derivation of §2 refers to $\ker W$: the two trace identities of (G2) hold at every element, the inclusion of (G3) holds at every critical point with $\theta\ne0$, and $f$ sees only $d$ and $D$. So a kernel changes nothing structurally. It changes the *numbers*, through $d$, and that is worth computing rather than assuming.

**Construction and validation of the $n=4$ model.** Ricci-flatness kills the mixed block of the curvature operator on $\Lambda^2(\mathbb R^4)=\Lambda^2_+\oplus\Lambda^2_-$, so $\mathcal W_4=S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$, of dimension $5+5=10=D$ as (G1) requires. Writing $W=(A,C)$ with $A,C$ symmetric trace-free $3\times3$ in orthonormal bases of $\Lambda^2_\pm$, the Frobenius normalisation gives $\lVert W\rVert^2=\operatorname{tr}(A^2)+\operatorname{tr}(C^2)$, and the product acts blockwise as

$$X\circ Y=\tfrac32(XY+YX)-\operatorname{tr}(XY)\,I_3,\qquad Q(X)=X\circ X=3X^2-\operatorname{tr}(X^2)I_3 .$$

Before using it I checked it against (G2) on the five-dimensional half at a random pair: $L_X$ is symmetric, $\operatorname{tr}L_X=1.5\cdot10^{-16}$, and $\operatorname{tr}(L_XL_Y)=5.689721082133507$ against $\tfrac{21}{4}\operatorname{tr}(XY)=5.689721082133508$. Both trace identities hold with the stated $\kappa(4)=21/4$, in the stated normalisation. That is two independent nontrivial constants reproduced, and it also pins down that $L_W$ annihilates the opposite half (otherwise $\operatorname{tr}(L_W^2)$ would exceed $\kappa$).

**The $\theta=\sqrt{3/2}$ point, in closed form.** Take $A=\operatorname{diag}(-1,-1,2)/\sqrt6$, $C=0$. Then $\operatorname{tr}(A^2)=1$, and

$$Q(A)=3A^2-I=\operatorname{diag}(-\tfrac12,-\tfrac12,1)=\sqrt{\tfrac32}\,A,$$

so this is a critical point with $\theta=P(W)=\sqrt{3/2}=1.224744871\ldots$, confirming the brief's given at $n=4$ rather than assuming it. Note $\sqrt{3/2}\ne\theta_0(4)=\sqrt3/2$: these are two different critical points, and (G4)'s $\theta_0$ family is the second one, found in §3.

**Orbit dimension.** Under $\mathfrak{so}(4)=\mathfrak{so}(3)_+\oplus\mathfrak{so}(3)_-$ acting by conjugation on the two blocks, the tangent space at $(A,0)$ is $\{([X_+,A],0)\}$, because $\mathfrak{so}(3)_-$ moves only the vanishing block. Rank computation gives $d=2$, matching $3-\dim O(2)=2$ by hand. For the padded tensor in $\mathbb R^n$, $n\ge4$, with $W$ supported on a $4$-dimensional subspace and nondegenerate there, the stabiliser subalgebra is $\mathfrak{stab}_{\mathfrak{so}(4)}(W)\oplus\mathfrak{so}(n-4)$ of dimension $4+\tfrac{(n-4)(n-5)}{2}$, since an off-diagonal generator maps $\mathbb R^4$ into the complement and moves $W$. Hence

$$d=\frac{n(n-1)}2-\frac{(n-4)(n-5)}2-4=4n-10-4=\boxed{4n-14},$$

which returns $2$ at $n=4$, in agreement with the direct rank computation, and gives $6$ at $n=5$, $34$ at $n=12$.

**The claims tested against it.** With $\theta^2=3/2$:

| $n$ | $d=4n-14$ | $k$ | $\kappa/f(d,k)$ | $\sum\mu_i^2$ forced | Cauchy–Schwarz floor |
|---|---|---|---|---|---|
| 4 | 2 | 7 | $147/58=2.5345$ | $2$ | $4/7=0.5714$ |
| 5 | 6 | 28 | $2.9302$ | $7/2$ | $0.5714$ |
| 6 | 10 | 73 | $3.4434$ | $17/3$ | $0.4932$ |
| 8 | 18 | 281 | $4.4827$ | $12$ | $0.3559$ |
| 12 | 34 | 1603 | $6.5192$ | $98/3=32.667$ | $0.2021$ |

Every row satisfies $\theta^2=3/2\le\kappa/f$, so the padded tensor is **not** a counterexample to Claim 1, and the margin is large and growing. The last two columns show why: the true $\sum\mu_i^2$ exceeds the Cauchy–Schwarz floor by a factor $3.5$ at $n=4$ and $160$ at $n=12$. The single inequality in the derivation is where essentially all of the bound's strength is thrown away.

At $n=4$ the whole spectrum is available and rational: $L_e$ has $\{1,\ \tfrac12,\tfrac12,\ -1,-1,\ 0,0,0,0,0\}$, with $\sum\lambda=0$ and $\sum\lambda^2=7/2=\kappa(4)/\theta^2$. Here the multiplicity of $\tfrac12$ is exactly $d=2$ and the multiplicity of $1$ is exactly $1$, so Claim 1's spectral shape is *satisfied exactly* at this point. The five zeros are the opposite chirality half, annihilated by $L_W$: a genuine kernel of $L_e$, contributing nothing to either moment and everything to the slack.

## 6. Claim 2's direction, and which end binds

$$\frac{\partial f}{\partial d}\Big|_k=\frac14+\frac{2(2+d)}{4k}=\frac14+\frac{2+d}{2k}>0\quad(k\ge1,\ d\ge0),$$

so $f$ is strictly increasing in $d$ at fixed $k$: **CONFIRMED**. The claim as used needs slightly more, since $k=D-1-d$ moves with $d$, and it survives:

$$\frac{d}{dd}f(d,D-1-d)=\frac14+\frac{2(2+d)(D-1-d)+(2+d)^2}{4(D-1-d)^2}>0\qquad(0\le d<D-1),$$

both the numerator terms being positive. So $d\mapsto f(d,D-1-d)$ is strictly increasing, and $d\mapsto\kappa/f$ strictly decreasing.

**Which end binds, said explicitly.** $\kappa/f$ is an *upper* bound on $\theta^2$, so the *strongest* statement is the *smallest* $\kappa/f$, which occurs at the *largest* $d$. The bound is therefore weakest at small orbit dimension and strongest at $d=n(n-1)/2$. A reviewer wanting to show the bound *never* certifies $\theta\le\sqrt{3/2}$ must check the strongest case, that is the **largest** $d$, and show even that exceeds $3/2$. Claim 3 evaluates at $d=66=\dim SO(12)$, the maximum, so it is evaluated at the correct, binding end. Claim 4 quantifies over the whole range, which monotonicity collapses to that same endpoint. No finding: the claim's phrasing and both its uses are the right way round.

## 7. Claims 3 and 4 as arithmetic

**Claim 3, exactly.** $\kappa(12)=\frac{23\cdot11}{4}=\frac{253}{4}$, $D=\frac{12\cdot13\cdot14\cdot9}{12}=1638$, $k=1638-1-66=1571$, and

$$f(66,1571)=1+\frac{33}{2}+\frac{68^2}{4\cdot1571}=\frac{35}{2}+\frac{1156}{1571}=\frac{57297}{3142},\qquad \frac{\kappa(12)}{f}=\frac{253\cdot3142}{4\cdot57297}=\frac{397463}{114594}=3.4684451\ldots$$

Greater than $3/2$. **CONFIRMED.** The brief's "$3.46844\ldots$" agrees to the digits it prints, and the exact value continues $\ldots451$, so a report quoting six decimals should write $3.468445$.

**Claim 4, with a certificate.** Monotonicity (§6) reduces the claim to $d=m:=n(n-1)/2$. Writing $12k=n^4-13n^2-12$ (checked: $1571$ at $n=12$, $24$ at $n=5$, $3$ at $n=4$) and $2+m=\frac{n^2-n+4}{2}$, the inequality $\kappa/f>\tfrac32$, that is $3f<2\kappa$, rearranges to

$$\frac{3(n^2-n+4)^2}{4k}<\frac{5n^2-9n-20}{2}\iff 18(n^2-n+4)^2<(n^4-13n^2-12)(5n^2-9n-20),$$

that is

$$5n^6-9n^5-103n^4+153n^3+38n^2+252n-48>0.$$

For $n\ge7$: $5n^6-9n^5\ge(5\cdot7-9)n^5=26n^5\ge182n^4>103n^4$, so the first three terms already sum to more than $79n^4>0$ and the rest is positive. The values at $n=5$ and $n=6$ are $6912$ and $65688$. So Claim 4 holds for every $n\ge5$: **CONFIRMED**. The endpoint values run $9/5$, $220/93$, $3796/1393$, $28455/9572$, … at $n=5,6,7,8$, increasing towards $4$.

**Is $n=4$ genuinely excluded? Yes, and interestingly so.** The certificate is $-3744$ at $n=4$. Explicitly, with $D=10$:

| $d$ | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|---|
| $\kappa(4)/f(d,9-d)$ | $189/40$ | $24/7$ | $147/58$ | $126/67$ | $105/76$ | $84/85$ | $63/94$ |
| decimal | $4.725$ | $3.4286$ | $2.5345$ | $1.8806$ | $\mathbf{1.3816}$ | $0.9882$ | $0.6702$ |

From $d=4$ on, the bound is below $3/2$ and so **does** certify $\theta\le\sqrt{3/2}$ at $n=4$. This is not a contradiction with the existence of a $\theta=\sqrt{3/2}$ critical point, because that point has $d=2$ (§5), where the bound reads $2.5345$. It is instead a consistency test that the claims pass, and a sharp one: a critical point with $\theta^2=3/2$ forces $f(d,9-d)\le\kappa(4)/(3/2)=7/2$, hence $d\le3$, and the actual value is $d=2$.

**Is $d\le n(n-1)/2$ the right constraint?** It is a hard *cap*, since $d\le\dim O(n)$, so Claim 4 cannot be defeated by a larger $d$. And a smaller true ceiling only helps, because $f$ increases in $d$: restricting the range shrinks $f_{\max}$ and raises $\min_d\kappa/f$, leaving Claim 4 true on a subrange. So the choice of ceiling is safe in the direction that matters. A smaller ceiling does exist at $n=4$, and the argument for it is short enough to be worth recording: the critical equation on each block is $3A^2-\operatorname{tr}(A^2)I=\theta A$, so every eigenvalue of $A$ is a root of the single quadratic $3t^2-\theta t-\operatorname{tr}(A^2)=0$, hence at most two distinct values occur among three eigenvalues and $A$ has a repeated eigenvalue. Each nonzero block therefore has stabiliser containing an $O(2)$, and $d\le6-1-1=4$ when both blocks are nonzero, $d\le2$ when one vanishes. Rank computation confirms $d\in\{2,4\}$ at the two critical points and $d=6$ only at non-critical points. So at $n=4$ the critical ceiling is $4$, not $6$, and the relevant entry of the table above is $105/76$ rather than $63/94$.

## 8. Claim 5's reach

**Reading (i), "this particular bound never reaches $\sqrt{3/2}$ for $n\ge5$": CONFIRMED**, and this is what the sentence literally says, since its subject is "the bound of Claim 1". It follows from Claims 1, 2 and 4 with nothing added.

**The limit: CONFIRMED.** At $d=m$ the third term of $f$ tends to $\frac{(n^2/2)^2}{4\cdot n^4/12}=\frac34$, so $f=\frac{n(n-1)}8+\frac74+o(1)$ and

$$\frac{\kappa(n)}{f}=\frac{4n^2-6n+2}{n^2-n+14+o(1)}\longrightarrow4 .$$

From below, and strictly: $\kappa<4f$ reduces to $0<\tfrac14n+\tfrac{27}4+(\text{positive})$. Exact values $3.97442255$ at $n=100$, $3.99794402$ at $n=1000$, $3.99979944$ at $n=10000$. So the strongest form of the bound is asymptotically $\theta\le2$, never attaining it. Since $4>3/2$, no $n$ rescues the route.

**Reading (ii), "no bound obtainable from (G2) and (G3) reaches it": REFUTED AS STATED.** Three reasons, in increasing order of force.

1. The method itself is not intrinsically incapable: at $n=4$ it *does* certify $\theta\le\sqrt{3/2}$ whenever $d\ge4$ (§7). What defeats it for $n\ge5$ is a ratio, $\dim O(n)\sim n^2/2$ against $D\sim n^4/12$, not the shape of the argument.
2. Claim 1 uses (G2) only at the single element $e$, and only its two lowest moments. (G2) is stated "at every element", which is strictly more information, for instance $\operatorname{tr}(L_xL_y)$ for $x,y$ in the orbit tangent or in the $\mu$-eigenspaces.
3. Claim 1 uses (G3) only through the *dimension* $d$, discarding the fact that the $\tfrac12$-eigenspace *contains the orbit tangent*, which is a specific subspace on which the algebra acts.

**What the claims do support, in its sharpest correct form.** Reading (ii) is true for the narrow input actually used, and that is worth recording as the reason the route is closed rather than merely stalled. Given only $\sum\mu_i=-\frac{2+d}2$ and $k\ge2$, for every $S_2\ge\frac{(2+d)^2}{4k}$ there exist $k$ reals with $\sum\mu_i=-\frac{2+d}2$ and $\sum\mu_i^2=S_2$. So no inequality derived from those two moments plus the multiplicity data alone can beat $f(d,k)$: Claim 1 is *optimal* for its input, and improving it requires new input, not a cleverer inequality.

**What extra input would be needed for (ii) proper.** Quantitatively: the bound certifies $\theta^2\le\tfrac32$ exactly when $f>\tfrac23\kappa\sim\tfrac{n^2}3$. With $d=cn^2$ one gets $f\sim\frac{cn^2}4+3c^2$, so $c>\tfrac43$ is needed against the $c=\tfrac12$ that $\dim O(n)$ supplies: a factor $8/3$ short. Three concrete routes, each a statement someone would have to prove:

- the $\tfrac12$-eigenspace has dimension at least $\tfrac43n^2$, considerably more than the orbit tangent gives;
- the eigenvalue $1$ has multiplicity $p\gtrsim n^2/3$, which enters $f_p$ linearly (§3);
- a **third** trace identity, some $\operatorname{tr}(L_x^3)=c_1P(x)+c_2\ldots$, adding a third moment. With three moments the feasible set for the $\mu$ block shrinks genuinely, and the sharpness argument above no longer applies.

## 9. Vacuity check

**What vacuity would look like.** Claim 1 would be empty if $f(d,k)\le0$, making the right-hand side negative or infinite; or if $\kappa(n)\le0$; or if its hypotheses were unsatisfiable, so that the quantifier ranged over nothing; or if $\kappa/f$ always exceeded a bound already free of charge, which is the weaker "relatively vacuous" failure mode.

**It is not vacuous.** $f(d,k)=1+\frac d4+\frac{(2+d)^2}{4k}\ge1$ and $\kappa(n)=\frac{(2n-1)(n-1)}4\ge\frac{21}4$ for $n\ge4$, so the bound is always a finite positive constraint. The hypotheses are satisfiable: the $n=4$ padded point of §5 satisfies Claim 1's spectral shape *exactly*, with $d=2$, $p=1$, and the bound is a true nontrivial inequality there ($3/2\le147/58$). And it is not relatively vacuous either, since for $d$ above the threshold of §10 it is strictly stronger than (G4)'s standing bound.

**Consistency of the two identities with some $\theta$, as asked, by exhibition.** At $n=12$, $d=66$ take

$$\lambda=1\ (\times1),\qquad \tfrac12\ (\times66),\qquad -\tfrac{34}{1571}\ (\times1571).$$

Then $\sum\lambda=1+33-34=0$ and $\sum\lambda^2=1+\frac{66}4+1571\cdot\frac{34^2}{1571^2}=\frac{35}2+\frac{1156}{1571}=\frac{57297}{3142}$, which is $\kappa(12)/\theta^2$ for $\theta^2=397463/114594$. Both identities hold, so the system is consistent and the bound is exactly the equality case. Two remarks on what this does and does not show: it is a *formal* spectrum, and whether any $W\in\mathcal W_{12}$ realises it is untouched by this check, and $k\ge1$ is not an assumption but a consequence, since $k=0$ would force $\operatorname{tr}L_e=1+\frac d2>0$ against (G2).

## 10. Is the bound worth anything, and what would break it

**Comparison with the standing bound of (G4),** $\theta^2\le(n-1)^2/(n+1)$, in exact arithmetic. $d^\ast$ is the least $d$ at which the new bound is the stronger of the two.

| $n$ | standing $(n-1)^2/(n+1)$ | new at $d=n-1$ | new at $d=\dim SO(n)$ | new wins iff $d\ge d^\ast$ | $2n$ |
|---|---|---|---|---|---|
| 5 | $8/3=2.667$ | $3.913$ | $1.800$ | $7$ | 10 |
| 6 | $25/7=3.571$ | $5.712$ | $2.366$ | $10$ | 12 |
| 8 | $49/9=5.444$ | $9.311$ | $2.973$ | $15$ | 16 |
| 12 | $121/13=9.308$ | $16.751$ | $3.468$ | $23$ | 24 |
| 20 | $361/21=17.190$ | $32.170$ | $3.764$ | $39$ | 40 |
| 50 | $2401/51=47.078$ | $91.520$ | $3.938$ | $100$ | 100 |

So $d^\ast\approx2n$, and asymptotically this is exact: $\kappa/f>\frac{(n-1)^2}{n+1}$ fails once $1+\frac d4\gtrsim\frac{\kappa(n+1)}{(n-1)^2}\sim\frac n2$. For large $d$ the new bound is enormously better, $3.47$ against $9.31$ at $n=12$, and it is the only one of the two that stays bounded as $n\to\infty$. That is a real gain, and it is the reason the bound is worth keeping even though the route it was built for is closed.

**Does a lower bound on $d$ valid at every critical point exist? One is needed, and the available one is too weak.** By (G3) the orbit tangent is nonzero, so the stabiliser is a *proper* closed subgroup of $SO(n)$, and for $n\ge5$ the proper connected subgroup of largest dimension is $SO(n-1)$, of codimension $n-1$ (the alternatives $SO(p)\times SO(q)$ and $U(n/2)$ have codimension $pq\ge2(n-2)$ and $\approx n^2/4$). Hence

$$d\ \ge\ n-1\qquad\text{at every critical point},\ n\ge5,$$

which is a factor of roughly $2$ short of $d^\ast\approx2n$, and at $d=n-1$ the new bound reads $(2n-1)(n-1)/(n+3)\sim2n$ against the standing $\sim n$: it **loses by a factor of about two**. The one critical-point family whose orbit dimension I computed independently, the padded tensor with $d=4n-14$ (§5), clears $2n$ for $n\ge7$ and fails it at $n=5,6$.

**Hypothesis debt, named precisely.** For the new bound to be an unconditional improvement on (G4), the following must be proved: *at every critical point of $P$ on the unit sphere of $\mathcal W_n$, $n\ge5$, the stabiliser $\operatorname{Stab}_{O(n)}(W)$ has codimension $d\ge d^\ast(n)$ in $O(n)$*, with $d^\ast(n)$ the threshold tabulated above, $d^\ast\approx2n$. Anything weaker than that leaves the new bound conditional on the orbit dimension of the point it is applied to, and it must then be quoted with $d$ as a hypothesis rather than as a theorem about critical points.

**The object that would falsify Claim 1,** and what I did to look for it. It would be a critical point $W$, $\theta\ne0$, orbit dimension $d$, whose $L_e$ has $1$ as an eigenvalue and $\tfrac12$ with multiplicity at least $d$, yet $\theta^2>\kappa(n)/f(d,D-1-d)$. No such object can exist without falsifying a given: the derivation is two moment identities and one Cauchy–Schwarz, so such a $W$ would refute (G2), or (G3), or the self-adjointness of $L_e$. I looked in the three places where the derivation could have been leaky, and found nothing: at a point where the $\tfrac12$-eigenspace exceeds the orbit tangent (§3, Case A: bound holds, and is improvable), at a point where $1$ has higher multiplicity (§3, Case B: found one explicitly at $n=4$, bound holds and the refined version is *exact*), and at a point with a large kernel (§5, the padded tensor: bound holds with a factor $160$ to spare at $n=12$). I also tested the two obvious $n=4$ critical points, both in closed form, and both satisfy the bound.

**The object that would falsify Claim 5** is a sharper inequality drawn from the same givens. Reading (i) is immune, being arithmetic. Reading (ii) I actively refuted, by exhibiting the $n=4$ regime where the same method succeeds, and I bounded how much room is left in the *narrow* version of (ii) by showing the Cauchy–Schwarz step is sharp as a two-moment problem, so any improvement must come from a third moment or a larger known eigenspace, both named in §8.

## Verdict

The mathematics of Claims 1 through 4 is correct, and Claim 5 is correct as written. Claim 1's *hypothesis* is wrong as stated and its *conclusion* is stronger than stated: the phrase "the spectrum consists of $1$ with multiplicity $1$, $\tfrac12$ with multiplicity $d$, and $k$ further eigenvalues" should be replaced by "$1$ is an eigenvalue and the $\tfrac12$-eigenspace has dimension at least $d$", after which the bound holds at every critical point with $\theta\ne0$, positive or negative. Recorded as it stands, the claim invites the reading that it applies only to points with a spectral coincidence, and an exhibited $n=4$ critical point with $\theta=\sqrt3/2$ and eigenvalue $1$ of multiplicity $2$ would then fall outside it, when in fact it is the point where the refined bound is exact.

Three things the record should carry out of this audit. First, the route through this bound to $\theta\le\sqrt{3/2}$ is closed for $n\ge5$, with the polynomial certificate of §7 as the proof and the asymptote $\theta\le2$ as the ceiling. Second, the refinement $f_p(d,p)=p+\frac d4+\frac{(2p+d)^2}{4(D-p-d)}$ is free, and it is attained at a real critical point, which is the first place in this audit where the method produces an equality rather than an inequality. Third, the bound's utility relative to (G4) rests on an unproved lower bound $d\gtrsim2n$ on orbit dimension, against an available $d\ge n-1$: until that gap is closed the bound is a conditional statement about points of large orbit dimension, and should be quoted with $d$ in the hypothesis.
