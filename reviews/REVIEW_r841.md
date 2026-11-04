# Review r841: the uncontracted criticality rows, and the per-eigenvalue bound drawn from one of them

*Reviewer of an independent pair on identical briefs, and I did not read the sibling's log or report, and I have not touched [reviews/INDEX.md](INDEX.md). Target: the three blockquotes at [bounds.md:270](../findings/bounds.md#L270), [bounds.md:272](../findings/bounds.md#L272) and [bounds.md:276](../findings/bounds.md#L276), quoted in my brief verbatim as they stand on disk. Derived cold from the brief's givens, with the record read afterwards only to check whether what I found was already on it. Analysis-only footing observed: the single machine call below re-checked, in exact and floating arithmetic, figures I had already derived by hand in closed form, and it is reported as a screen and never as evidence. Log: [agent_logs/g2-rows-r841.log](../agent_logs/g2-rows-r841.log).*

## Claim table

| # | Claim as the block states it | Verdict |
| --- | --- | --- |
| C1 | Pairing (C) with any weight $w_k$ returns $\sum_kw_k\cdot2\lambda_k(\theta-\lambda_k)$, "a relation among power sums and nothing else" | **PROVEN for spectral weights, UNDERSTATED as a diagnosis**. The true statement is that no contraction of (A), (B) or (C) sees $T$ at all, and the block's own next move shows why that does not close the rows off |
| C2 | $\lambda^{\mathsf T}T^{(k)}\lambda=2\lambda_k(\theta-\lambda_k)$ at $T^{(k)}_{\alpha\gamma}=T_{\alpha k\gamma}$ | **PROVEN**, placement immaterial by total symmetry, but the middle slot is the placement that should have made the block's own oversight visible |
| C3 | $\sum_\gamma T_{\alpha k\gamma}=\lVert[v_\alpha,v_k]\rVert^2\le2$ is the pair cap | **PROVEN**, it is [Lemma L31](../findings/stratum-two-negative.md) at the pair $(\alpha,k)$ and no other contraction of it |
| C4 | $\lambda_{\max}(T^{(k)})\le2$, hence $\lvert\lambda^{\mathsf T}T^{(k)}\lambda\rvert\le2\lVert\lambda\rVert^2=2$ | **PROVEN AND LOOSE**. The mixed signs are harmless, but $\lVert\lambda\rVert^2$ is the wrong norm: row and column $k$ of $T^{(k)}$ vanish identically, so the same step gives $2(1-\lambda_k^2)$ |
| C5 | $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ at every $k$, hence $\theta\le\lambda_{\max}+1/\lambda_{\max}$ | **PROVEN**, $\lambda_{\max}>0$ is available, the index is the right one, and both are **strictly weaker than the same step gives** |
| C6 | Screen at padded $W_{\mathbb{CP}^2}$: products $\tfrac13,-\tfrac23,-\tfrac23$, bound $2.041$ | **PROVEN EXACT**. The bound is $5/\sqrt6=2.0412414\ldots$, and the padded zero eigenvalues contribute a fourth product $0$ that the screen does not list |
| C7 | $\lambda+1/\lambda\ge2$, so "the display never returns better than $\theta\le2$ however the spectrum falls", which "is why this use alone cannot reach the target" | **BROKEN**. The arithmetic is right about the display and the conclusion drawn from it is false. The block's own per-index inequality gives $\theta\le1/\lvert\lambda_{\min}\rvert-\lvert\lambda_{\min}\rvert$ at a negative index, with no floor at $2$, and once the vanishing row is used the maximal index gives $\theta\le1/\lambda_{\max}$, whose floor is $1$ |
| C8 | The loss is in bounding $\lambda_{\max}(T^{(k)})$ by the cap, and a use that survives must keep (A) alongside the cap | **HALF RIGHT**. The prescription is correct and I supply the bound it asks for, while the stated reason misidentifies the waste and (A) provably does **not** improve the spectral-radius step |
| C9 | Scope | **CLEAN**. Nothing needs $n\ge12$, $S=0$, non-diagonality, maximality, or first Bianchi beyond trace-freeness |
| N1 | *New, and not on the record*: $\theta\,\lambda_{\max}\le1$ at every critical point, with **equality at padded $W_{\mathbb{CP}^2}$** | **PROVEN**, from the block's own two inputs, corroborated in closed form across the whole $\mathbb{CP}^m$ family and the balanced products |

## Summary

The block proves everything it displays and then draws its one structural conclusion from a display that throws away $\lambda_k^2$: restoring it turns $\theta\le\lambda_{\max}+1/\lambda_{\max}$ into $\theta\le1/\lambda_{\max}$, which is saturated exactly at $W_{\mathbb{CP}^2}$, so the "ceiling $2$" paragraph must be replaced rather than repaired.

## 0. Conventions, fixed once

$\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ carries $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, $N=\dim\Lambda^2=n(n-1)/2$, and $(v_\alpha)_{\alpha=1}^N$ is an orthonormal eigenbasis of $W$ with $W v_\alpha=\lambda_\alpha v_\alpha$, $\sum_\alpha\lambda_\alpha=0$ and $\sum_\alpha\lambda_\alpha^2=1$. Write

$$c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle,\qquad T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2,\qquad R_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2 .$$

$\langle\cdot,\cdot\rangle$ is $\mathrm{ad}$-invariant, so $c$ is **totally antisymmetric** and $T$ is totally symmetric and nonnegative. Both facts are in the brief's givens, and the antisymmetry of $c$ is the one the block never spends. $T^{(k)}$ is the symmetric matrix $T^{(k)}_{\alpha\gamma}=T_{\alpha k\gamma}$ and $r^{(k)}_\alpha=\sum_\gamma T^{(k)}_{\alpha\gamma}=R_{\alpha k}$ is its row sum. Criticality is $Q(W)=W^2+W^\#=\theta W$ at $\lVert W\rVert=1$. Values quoted as exact are exact, and $\theta_0(n)$ is the balanced-product value tabulated at [INDEX-values.md](../findings/INDEX-values.md).

## Hypothesis inventory

| Input | Where it is used below | Source |
| --- | --- | --- |
| $c$ totally antisymmetric, $T$ totally symmetric and nonnegative | §2, §4, and the whole of the improvement | brief's given, [conventions.md](../findings/conventions.md) |
| Pair cap $R_{\alpha\beta}\le2$ | §3, §4 | [Lemma L31](../findings/stratum-two-negative.md), given as proven |
| (A) $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$ | §8 only | [Lemma L153](../findings/bounds.md#L321) |
| (B) $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$ | nowhere in the block, §8 here | $W\#I=-W$, consumes first Bianchi and Ricci-flatness |
| (C) $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ | §2, §5 | criticality |
| $\sum\lambda_\alpha=0$, $\sum\lambda_\alpha^2=1$ | §4 ($\lVert\hat\lambda\rVert^2$), §5 ($\lambda_{\max}>0$) | definition of $\mathcal W_n$ and unit norm |
| Parseval on $(v_\gamma)$ | §3 | orthonormality |

Nothing else enters. In particular **no step of the block, and no step of the improvement, uses first Bianchi beyond trace-freeness**, so both hold for any unit trace-free symmetric operator on $\Lambda^2$ satisfying $W^2+W^\#=\theta W$.

## 1. Contracting the rows, and what that argument does and does not establish

Pair (C) against weights $w_k$:

$$\sum_kw_k\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\theta\sum_kw_k\lambda_k-2\sum_kw_k\lambda_k^2 .$$

**Verified.** With $w_k=\lambda_k^m$ the right side is $2\theta p_{m+1}-2p_{m+2}$ in the power sums $p_j=\sum_\alpha\lambda_\alpha^j$, so the block's sentence is correct. It is also weaker than the fact underneath it, which is worth stating positively: **each single relation already has a right side free of $T$**, so every linear combination does, and the observation needs no contraction to make.

*Does an eigenvector-dependent weight escape it?* A weight is a scalar attached to an index, and $v_k$ is determined by $k$, so $w_k=f(v_k)$ is admissible. It escapes the letter of the claim and not its substance. Taking $f(v)=\langle v,Xv\rangle$ for a fixed operator $X$ on $\Lambda^2$ gives

$$\sum_k\langle v_k,Xv_k\rangle\cdot2\lambda_k(\theta-\lambda_k)=2\mathop{\mathrm{tr}}\!\big(X(\theta W-W^2)\big),$$

which is **not** a power sum, since it sees the eigenframe. It is still a function of $W$ alone and of no bracket datum. So the accurate form of the claim is: *the right side of any contraction of (A), (B) or (C) is determined by $W$, never by $T$*. That is the statement the record needs, and it is the one [R14](../routes.md)'s circularity note already makes at [bounds.md:258](../findings/bounds.md#L258).

*Does contracting (A) or (B) change the answer?* No, and both are weaker still. Contracting (A) returns $2(n-2)\sum_kw_k$, a constant free even of the spectrum. Contracting (B) returns $-2\sum_kw_k\lambda_k$, one power sum.

**What the paragraph does not establish, and reads as if it did.** "Contracting them cannot give more than the spectrum" is a statement about *equalities*. The rows are also usable one-sidedly, and the block's very next paragraph does exactly that, extracting a genuine $\theta$-bound from a single row. So the dichotomy the paragraph sets up, contraction against individual structure, has a third term it does not name: **one row, used as an inequality**. That is where the block's own result lives, and where the improvement in §4 lives too.

**And there is content in these relations that the $T$-framework cannot express.** (A), (B) and (C) are the diagonals, in $W$'s eigenbasis, of three *operator* identities: $I\#I=(n-2)I$, $W\#I=-W$ and $W^\#=\theta W-W^2$, the last being the record's own reading at [bounds.md:258](../findings/bounds.md#L258). Off the diagonal, for $k\ne l$,

$$\sum_{\beta\gamma}c_{k\beta\gamma}c_{l\beta\gamma}=0,\qquad \sum_{\beta\gamma}\lambda_\beta\,c_{k\beta\gamma}c_{l\beta\gamma}=0,\qquad \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma\,c_{k\beta\gamma}c_{l\beta\gamma}=0$$

whenever $\lambda_k\ne\lambda_l$, the first from $\sum_{\beta\gamma}c_{k\beta\gamma}c_{l\beta\gamma}=-\mathop{\mathrm{tr}}(\mathrm{ad}\,v_k\,\mathrm{ad}\,v_l)=2(n-2)\delta_{kl}$, which is the Killing form and reproduces (A) at $k=l$. These $3\times\binom N2$ relations have right side zero, so they carry **no spectral information whatsoever**, and they are invisible to $T$ because they involve the signs of $c$ rather than its squares. [I71](../plan.md#L119) asks what the rows carry beyond the spectrum; part of the answer is that the sign data of $c$ is constrained by relations the record's own $T$-formalism cannot even write down.

## 2. The quadratic-form reading, and what the index placement hides

$T^{(k)}_{\alpha\gamma}:=T_{\alpha k\gamma}$. By total symmetry $T_{\alpha k\gamma}=T_{k\alpha\gamma}$, so

$$\lambda^{\mathsf T}T^{(k)}\lambda=\sum_{\alpha\gamma}\lambda_\alpha\lambda_\gamma T_{\alpha k\gamma}=\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),$$

which is (C). **Verified, and the slot does not matter** for the value: all three placements give the same matrix, and $T^{(k)}$ is symmetric because $T$ is.

The placement matters for what a reader sees. Total antisymmetry of $c$ makes $c_{\alpha\beta\gamma}$ vanish whenever two indices coincide, so

$$\boxed{\;T^{(k)}_{k\gamma}=T^{(k)}_{\alpha k}=T^{(k)}_{\alpha\alpha}=0\;}$$

for every $\alpha,\gamma$: **row $k$, column $k$ and the entire diagonal of $T^{(k)}$ are zero.** The middle-slot placement is the one that displays this, since $T_{\alpha k\gamma}$ has its repeated index in plain sight in all three cases, and the block still writes $\lVert\lambda\rVert^2$ two lines later. This is the whole of the defect in §4 and §7.

## 3. The row sums are the pair cap, and at the pair the form is taken at

$$\sum_\gamma T^{(k)}_{\alpha\gamma}=\sum_\gamma\langle[v_\alpha,v_k],v_\gamma\rangle^2=\lVert[v_\alpha,v_k]\rVert^2=R_{\alpha k}\le2 .$$

The middle equality is Parseval in the orthonormal basis $(v_\gamma)$ of $\Lambda^2$. **This is [Lemma L31](../findings/stratum-two-negative.md) at the ordered pair $(\alpha,k)$, contracted over the third slot, and it is no other contraction of it.** The distinction worth recording: (A) is the *further* contraction $\sum_\alpha R_{\alpha k}=2(n-2)$ of the same marginals, so the cap and (A) are one marginal read at two levels, which is why the block's §8 prescription is at least internally coherent.

## 4. The bound on the form, where the constant $2$ is loose

**The mixed signs are a red herring.** Nothing in the step needs a Perron vector. For any symmetric $M$ with nonnegative entries and any $x$, nonnegativity plus $\pm2x_\alpha x_\gamma\le x_\alpha^2+x_\gamma^2$ gives, termwise,

$$\Big\lvert\sum_{\alpha\gamma}M_{\alpha\gamma}x_\alpha x_\gamma\Big\rvert\;\le\;\sum_{\alpha}M_{\alpha\alpha}x_\alpha^2+\sum_{\alpha<\gamma}M_{\alpha\gamma}(x_\alpha^2+x_\gamma^2)\;=\;\sum_\alpha\Big(\sum_\gamma M_{\alpha\gamma}\Big)x_\alpha^2 .\tag{4.1}$$

This is the block's inequality with the row sums kept individually, and it needs neither $\lambda_{\max}(M)$ nor a sign condition on $x$. The block's route is also sound: for symmetric nonnegative $M$, Gershgorin puts every eigenvalue in $[2M_{\alpha\alpha}-r_\alpha,\,r_\alpha]$ for some $\alpha$, so $\lvert\lambda_{\max}(M)\rvert\le\max_\alpha r_\alpha$, and $\lvert x^{\mathsf T}Mx\rvert\le\max_\alpha r_\alpha\cdot\lVert x\rVert^2$. Both give $2$ under the cap alone.

**But $\lVert\lambda\rVert^2$ is the wrong norm.** By §2, $r^{(k)}_k=0$, so the $k$-th coordinate of $\lambda$ is absent from the form. Writing $\hat\lambda$ for $\lambda$ with its $k$-th entry deleted, $\lVert\hat\lambda\rVert^2=1-\lambda_k^2$ and (4.1) gives

$$\big\lvert\lambda^{\mathsf T}T^{(k)}\lambda\big\rvert\;\le\;\sum_{\alpha\ne k}R_{\alpha k}\,\lambda_\alpha^2\;\le\;2\big(1-\lambda_k^2\big).\tag{4.2}$$

**So the right constant is not $2$ but $2(1-\lambda_k^2)$, and (4.1) is sharper again.** The record already owns the sharper instrument: the proof of [Lemma L143](../findings/bounds.md#L31), two hundred and forty lines above this block in the same file, bounds a $T$-form by exactly the termwise $\mu_\beta\mu_\gamma\le\tfrac12(\mu_\beta^2+\mu_\gamma^2)$ step of (4.1) against the same two marginals. The block reached past it for a spectral-radius argument that is strictly worse.

*Arguing the opposite.* The only reading on which $2\lVert\lambda\rVert^2$ is the best available is one where $T^{(k)}$ has a nonvanishing $k$-th row, which would require $c_{k k\gamma}\ne0$ and contradict the antisymmetry the block itself quotes when calling $T$ totally symmetric. There is no such reading.

## 5. The conclusion, at the right index, and its sharp form

From $\lvert\lambda^{\mathsf T}T^{(k)}\lambda\rvert\le2$ and (C), $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ at every $k$. **Verified.** Since $\sum\lambda_\alpha=0$ and $\sum\lambda_\alpha^2=1$, there is at least one $\lambda_\alpha>0$ and at least one $\lambda_\alpha<0$, so $\lambda_{\max}>0$ is available and $\lambda_{\max}\le\lVert\lambda\rVert=1$. Dividing by $\lambda_{\max}>0$,

$$\lambda_{\max}(\theta-\lambda_{\max})\le1\;\Longrightarrow\;\theta\le\lambda_{\max}+\frac1{\lambda_{\max}} .$$

**Verified, and the index is the best one for this display**: on $(0,1]$ the map $x\mapsto x+1/x$ decreases, so among positive eigenvalues the largest gives the smallest bound.

Now run the same two lines from (4.2). At $\lambda_k>0$,

$$\lambda_k(\theta-\lambda_k)\le1-\lambda_k^2\;\Longrightarrow\;\lambda_k\theta\le1\;\Longrightarrow\;\theta\le\frac1{\lambda_k},$$

sharpest at $\lambda_k=\lambda_{\max}$, and at $\lambda_k=-\mu<0$ the same inequality reads $\mu(\theta+\mu)\le1-\mu^2$, giving $\theta\le1/\mu-2\mu$. Hence, at every critical point,

$$\boxed{\;\theta\;\le\;\min\Big\{\frac1{\lambda_{\max}},\;\frac1{\lvert\lambda_{\min}\rvert}-2\lvert\lambda_{\min}\rvert\Big\},\qquad\text{in particular}\qquad \theta\,\lambda_{\max}\le1 .\;}\tag{5.1}$$

If $\theta<\lambda_{\max}$ the first bound holds trivially, since $\lambda_{\max}\le1\le1/\lambda_{\max}$, so no case is lost.

**$\theta\lambda_{\max}\le1$ is not on the record.** The nearest statement is [bounds-relaxations.md:276](../findings/bounds-relaxations.md#L276), which argues $\lambda_{\max}\le\lVert\lambda\rVert=1<\sqrt{3/2}\le\theta$ at a maximiser. (5.1) replaces $\lambda_{\max}\le1$ by $\lambda_{\max}\le1/\theta\le\sqrt{2/3}=0.816497$, so the margin that block calls "at least $0.2247$" is in fact at least $\sqrt{3/2}-\sqrt{2/3}=0.408248$, and more at larger $\theta$.

## 6. The screen, recomputed in closed form

$\lambda=(2,-1,-1)/\sqrt6$ padded by zeros, $\theta=\sqrt{3/2}=3/\sqrt6$. Then $\theta-\lambda_1=3/\sqrt6-2/\sqrt6=1/\sqrt6$ and $\theta-\lambda_2=\theta-\lambda_3=4/\sqrt6$, so

$$\lambda_1(\theta-\lambda_1)=\tfrac26=\tfrac13,\qquad \lambda_2(\theta-\lambda_2)=\lambda_3(\theta-\lambda_3)=-\tfrac46=-\tfrac23 .$$

**The three products are exactly as stated.** The displayed bound is

$$\lambda_{\max}+\frac1{\lambda_{\max}}=\frac2{\sqrt6}+\frac{\sqrt6}2=\frac{4+6}{2\sqrt6}=\frac5{\sqrt6}=2.041241\ldots,$$

**so $2.041$ is exact to the digits printed**, and $\theta=1.224745$ sits below it with slack $0.816$. Two remarks the screen omits. First, the padded zero eigenvalues supply $N-3$ further products, all $0$, at which the per-index bound is vacuous, so the conjunction over $k$ is informative only on the support. Second, at this point the negative-index reading of §7 returns $\sqrt6-1/\sqrt6=5/\sqrt6$ as well, the same number by the arithmetic identity $2/\sqrt6+\sqrt6/2=\sqrt6-1/\sqrt6$, which is a coincidence of this spectrum and not a general fact.

**Where the sharp bound (5.1) lands at the same point**: $1/\lambda_{\max}=\sqrt6/2=1.224745=\theta$ **exactly**, and $1/\lvert\lambda_{\min}\rvert-2\lvert\lambda_{\min}\rvert=\sqrt6-2/\sqrt6=1.632993$. The first is an equality.

**Why the equality is structural rather than numerical.** On the $\Lambda^+$ triple carrying $W_{\mathbb{CP}^2}$, take the orthonormal frame $X_1=(L_{12}+L_{34})/\sqrt2$, $X_2=(L_{13}+L_{42})/\sqrt2$, $X_3=(L_{14}+L_{23})/\sqrt2$ with $L_{ij}$ the standard $\mathfrak{so}(n)$ generators, orthonormal for $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$. Then $[X_1,X_2]=-\sqrt2\,X_3$, so $R_{12}=R_{13}=2$: **the pair cap is saturated on the support**, $T^{(1)}$ restricted to $\{2,3\}$ is $\begin{psmallmatrix}0&2\\2&0\end{psmallmatrix}$, and $\lambda^{\mathsf T}T^{(1)}\lambda=2\cdot2\cdot\lambda_2\lambda_3=\tfrac23=2\lambda_1(\theta-\lambda_1)$, which recovers $\theta=3/\sqrt6$ from (C) with no numerics. Every inequality used in §4 and §5 is an equality here: the cap at $R_{12}=R_{13}=2$, the termwise step (4.1) because $\lambda_2=\lambda_3$, and (4.2) because the remaining coordinates of $\lambda$ vanish. **The active set is fully saturated, so (5.1) cannot be improved to $\theta\lambda_{\max}\le c$ for any $c<1$, at any $n\ge4$**, since padding changes neither $\lambda$ nor $\theta$.

## 7. The ceiling claim

**The arithmetic is right and the conclusion is false.**

*Right*: $\lambda+1/\lambda\ge2$ on $\lambda>0$ by AM–GM, so the display as written never returns a bound below $2$. Equality needs $\lambda_{\max}=1$, which trace-freeness forbids, so the infimum $2$ is approached and not attained, as $\lambda\to(\Lambda,-\Lambda/m,\ldots,-\Lambda/m)$ with $\Lambda=\sqrt{m/(m+1)}\to1$.

*Not the whole story, in three ways.*

**(i) A non-maximal index does better, and the block's own inequality says so.** At $\lambda_k=-\mu<0$, $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ reads $\mu(\theta+\mu)\le1$, so

$$\theta\le\frac1\mu-\mu,$$

whose value at $\mu=\lvert\lambda_{\min}\rvert$ has **no floor at $2$**: at $\lvert\lambda_{\min}\rvert=1/\sqrt2$ it returns $\theta\le0.707107$, and as $\lvert\lambda_{\min}\rvert\to1$ it returns $\theta\to0$. The dividing step flips the inequality because $\lambda_k<0$, which is exactly the case the block's display drops.

**(ii) The sharp form of the same step has ceiling $1$, not $2$.** By (5.1), $\theta\le1/\lambda_{\max}$ and $\lambda_{\max}\le1$, so the sharpened display never returns worse than $\theta\le1/\lambda_{\max}$ and never better than $\theta\le1$. Since $1<\sqrt{3/2}$, **no ceiling argument can show that this use fails to reach the target**: the ceiling is below the record's own threshold value.

**(iii) The conjunction adds nothing by summation, and everything by minimisation.** Summing (C) over $k$ gives $\sum_k\lambda_k(\theta-\lambda_k)=\theta\cdot0-1=-1$ identically, so the contraction of the family is vacuous, which is §1's point turned on the family itself. What the family does give is the minimum in (5.1), and by (i) that minimum is often set by the negative end.

**What actually stops this route, stated positively.** The bound degrades as the spectrum flattens, and the flat spectra are precisely the conjectured maximisers. At the balanced product $S^{p}\times S^{p}$ at $n=2p+2$, tracelessness and unit norm applied to the two-valued spectrum with $\lvert\lambda_{\min}\rvert/\lambda_{\max}=(n-2)/n$ at multiplicity $r=n(n-2)/4$ ([bounds.md:701](../findings/bounds.md#L701)) give $\lambda_{\max}^2=2/\big((n-1)(n-2)\big)$ and hence

$$\theta_0(n)\,\lambda_{\max}=\frac2n\qquad\text{exactly},$$

so (5.1) is loose there by a factor $n/2$, returning $7.416$ against $\theta_0(12)=1.236033$. **That factor of $n/2$, and not a ceiling of $2$, is the reason a single row cannot close the target**, and it is a sharper diagnosis because it says where to look: the route is exact at concentrated spectra and loses linearly in $n$ at flat ones.

## 8. The located loss, and the improvement (A) actually buys

**The block's stated reason does not hold.** (A) says $\sum_{\alpha}R_{\alpha k}=2(n-2)$ while the cap says $R_{\alpha k}\le2$, so at most $n-2$ of the $N-1$ nonzero rows can sit at the cap, and the block reads that as forcing $\lambda_{\max}(T^{(k)})<2$. It does not. Take $M$ supported on any $m\le n-2$ indices as $\tfrac2{m-1}(J-I)$ there and zero elsewhere: entries nonnegative, diagonal zero, every row sum exactly $2$, total mass $2m\le2(n-2)$, and $\lambda_{\max}(M)=2$. **(A) and the cap are simultaneously consistent with $\lambda_{\max}(T^{(k)})=2$**, so keeping (A) alongside the cap cannot improve the spectral-radius step by any amount. The waste the block locates is real as a fact about rows and inert as a bound.

**The prescription is nevertheless right, through a different step.** Keep the row sums individually as in (4.1) rather than collapsing them into $\lambda_{\max}(T^{(k)})$. Then (A) enters as a budget on $\{R_{\alpha k}\}$ and the cap as a per-row ceiling, and the maximum of $\sum_{\alpha\ne k}R_{\alpha k}\lambda_\alpha^2$ over that polytope is attained by spending the whole budget at the cap on the largest $\lambda_\alpha^2$. Writing $\sigma^{(k)}_{n-2}$ for the sum of the $n-2$ largest $\lambda_\alpha^2$ over $\alpha\ne k$,

$$\boxed{\;\big\lvert\lambda_k(\theta-\lambda_k)\big\rvert\;\le\;\tfrac12\sum_{\alpha\ne k}R_{\alpha k}\lambda_\alpha^2\;\le\;\sigma^{(k)}_{n-2}\;\le\;1-\lambda_k^2\;}\tag{8.1}$$

and at $k$ maximal, $\theta\le\big(\lambda_{\max}^2+\sigma^{(\max)}_{n-2}\big)/\lambda_{\max}$. **That is the improved bound the item asks for**: it is strict whenever more than $n-1$ eigenvalues are nonzero, which is the flat regime of §7, and it collapses to $1-\lambda_k^2$ exactly when the spectrum has at most $n-2$ nonzero entries off $k$, which is why $W_{\mathbb{CP}^2}$ saturates every member of the chain at once.

**The right instrument, named.** $\lambda^{\mathsf T}T^{(k)}\lambda$ is **linear** in $T^{(k)}$, so the sharpest bound obtainable from any set of linear constraints on $T^{(k)}$ is a linear programme, and $\lambda_{\max}(T^{(k)})$ is a nonlinear detour that discards the objective's structure. (8.1) is that linear programme under nonnegativity, the cap and (A). **(B) is a further linear constraint on the same matrix and is not used even in (8.1)**: written in the same notation the three relations are three moments of one matrix,

$$\mathbf 1^{\mathsf T}T^{(k)}\mathbf 1=2(n-2),\qquad \mathbf 1^{\mathsf T}T^{(k)}\lambda=-2\lambda_k,\qquad \lambda^{\mathsf T}T^{(k)}\lambda=2\lambda_k(\theta-\lambda_k),$$

so (A), (B) and (C) are one object read against $\mathbf 1$ and $\lambda$, and a route that uses only the third is using one entry of a $2\times2$ moment matrix.

*One structural consequence of that reading, recorded because it closes off an obvious next attempt.* $P:=2I-T^{(k)}$ is diagonally dominant with zero diagonal off the cap, hence positive semidefinite, and with $\hat{\mathbf 1}=\mathbf 1-e_k$, tracelessness gives $\hat{\mathbf 1}^{\mathsf T}\hat\lambda=-\lambda_k$, so

$$\hat{\mathbf 1}^{\mathsf T}P\hat\lambda=2(-\lambda_k)-(-2\lambda_k)=0 .$$

**The cross term vanishes identically**, so Cauchy–Schwarz for $P$ against the pair $(\hat{\mathbf 1},\hat\lambda)$ returns $0\le(\ldots)(\hat\lambda^{\mathsf T}P\hat\lambda)$ and no information. (B) buys nothing through the semidefinite route, and a successor should spend it in the linear programme instead.

## 9. Scope

**Nothing needs $n\ge12$, $S=0$, non-diagonality, or maximality.** Criticality enters once, as (C). Trace-freeness enters twice, for $\lambda_{\max}>0$ and for $\lVert\hat\lambda\rVert^2=1-\lambda_k^2$; unit norm enters for the same second use and to read $P(W)$ as $\theta$. First Bianchi enters only through the definition of $\mathcal W_n$ and is never used as an identity, so §§2–5 hold for any unit trace-free symmetric operator on $\Lambda^2$ with $W^2+W^\#=\theta W$. The improvement (8.1) additionally consumes (A), which is [Lemma L153](../findings/bounds.md#L321) and is the Killing form of $\mathfrak{so}(n)$, valid at every $n\ge3$; the record's own note at [bounds.md:387](../findings/bounds.md#L387) about the ordered-pair conversion applies and I have used the ordered-pair constant $2(n-2)$ throughout. Degeneracy of $\lambda_{\max}$ is harmless: the argument fixes one index, not one eigenvector, and every statement is invariant under rotating within an eigenspace because $T$ is defined from whatever orthonormal eigenbasis is chosen.

## 10. What would falsify the block, and what I did

| Falsifier | Status |
| --- | --- |
| A critical point with $\lvert\lambda_k(\theta-\lambda_k)\rvert>1$ at some $k$ | would refute (C) or the cap, both given. Not found in closed form. |
| A critical point with $\theta\lambda_{\max}>1$, which would refute (5.1) and hence one of the two givens | Checked in closed form against every catalogued family for which the record supplies $\lambda_{\max}$: the $\mathbb{CP}^m$ family, where [nondegeneracy.md:554](../findings/nondegeneracy.md#L554) gives $\lambda_{\max}=\theta\cdot2(m-1)/(2m-1)$ and $\theta^2=(m+1)(2m-1)/\big(3m(m-1)\big)$, so $\theta\lambda_{\max}=\dfrac{2(m+1)}{3m}\le1$ **with equality exactly at $m=2$**; and the balanced products, where $\theta_0(n)\lambda_{\max}=2/n$. Both hold, one at equality. |
| $T^{(k)}$ with a nonvanishing $k$-th row or diagonal, which would restore the block's constant $2$ | forbidden by total antisymmetry of $c$, which the brief gives. |
| (A) forcing $\lambda_{\max}(T^{(k)})<2$, which would vindicate the block's §8 reason | refuted by the closed-form witness in §8. |

**What I did not do**: no search over critical points, no linear programme, no sweep, no numerics beyond the one screen. **The screen**: a single call re-evaluating, in floating arithmetic, the closed forms of §6, §7 and §10 that I had already derived by hand, namely the three products, $5/\sqrt6$, $1/\lambda_{\max}$ at $W_{\mathbb{CP}^2}$, $2(m+1)/(3m)$ for $m=2,\ldots,7$, and $2/n$ at $n=6,8,10,12$. It confirmed the hand derivations to sixteen digits and is reported as a screen.

## Verdict: **GAP**

Every inequality the block displays is true, every derivation it gives is valid, and its two conclusions rest on a display that discards $\lambda_k^2$.

- **Sound as written**: the contraction observation (§1), the quadratic-form reading (§2), the identification of the row sums with the pair cap (§3), the bound $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ and its reading at $\lambda_{\max}$ (§4, §5), and the screen, which is exact (§6).
- **The gap**: the same step gives $\theta\le1/\lambda_{\max}$, which is **saturated at padded $W_{\mathbb{CP}^2}$ at every $n\ge4$** and strictly sharpens the record's own $\lambda_{\max}\le1$ at [bounds-relaxations.md:276](../findings/bounds-relaxations.md#L276) to $\lambda_{\max}\le1/\theta\le\sqrt{2/3}$.
- **Broken**: the paragraph at [bounds.md:276](../findings/bounds.md#L276). The ceiling of this use is $1$ and not $2$, a negative index escapes the floor of $2$ altogether, and the true obstruction is a factor $n/2$ at flat spectra, exact at the balanced products where $\theta_0(n)\lambda_{\max}=2/n$.
- **Owed to (A) and (B)**: the prescription "keep (A) alongside the cap" is correct and its stated reason is not, since (A) provably leaves $\lambda_{\max}(T^{(k)})\le2$ untouched. Kept termwise instead, (A) gives (8.1). (B) is still unspent, and the semidefinite way of spending it returns nothing because its cross term vanishes identically.
