# VERIFY_v216, Lemma L71, saturation forces the balanced sphere product

**Cold read of [BRIEF_L71.md](BRIEF_L71.md), sections A–C, against [conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md)'s Lemma L70 block, and the four filed Cartan sources.** No numerical work of any kind was done: no script, no Sage, no Python, no numeric evaluation. Every number this report asserts is closed-form arithmetic performed by hand on an object constructed for that purpose, and is reported as a screen. Log: [agent_logs/verify-L71-v216.log](../agent_logs/verify-L71-v216.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Saturation of [L70](../findings/bounds.md) gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$ | **HOLDS** |
| 2 | $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is a subalgebra | **HOLDS** |
| 3 | $\mathfrak r$ centralises $\mathfrak g'$; $\mathfrak h$ normalises it; Jacobi gives the normalisation outright | **HOLDS** |
| 4 | $\mathfrak g'$ is an ideal, hence $=\mathfrak{so}(n)$, hence $\mathfrak r=0$ and $\mathfrak h=[\mathfrak m,\mathfrak m]$ | **HOLDS** |
| 5 | "$W$ has exactly two eigenvalues" is **derived, not assumed** (the ideal argument removes the hypothesis | **HOLDS), the rescue is sound end to end** |
| 6 | $\mathfrak{so}(n)$ simple at every $n\ge3$ except $n=4$; $n=3$ excluded for vacuity | **HOLDS** |
| 7 | $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, so $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair | **HOLDS** |
| 8 | $\dim\mathfrak h=\tfrac{n(n-2)}4$ from (A), (B), the support split and tracelessness | **HOLDS, and non-circular** |
| 9 | $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{n^2}4+t^2-\tfrac n2$ forces $t=0$ at every even $n$; $\mathfrak u(n/2)$ excluded | **HOLDS** |
| 10 | The $n=8$ conjugacy step, route 1, "$\det=+1$, hence inner, hence Cartan up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy" | **BROKEN AS WRITTEN, repairable in one clause** |
| 11 | The $n=8$ conjugacy step, route 2, the weight pattern $(1^4,(-1)^4)$ agrees on $V$, $S^+$, $S^-$ | **HOLDS** |
| 12 | The Cartan import's hypotheses against the object | **HOLDS mathematically; two bridge steps are in no filed source** |
| 13 | No critical point saturates at odd $n\ge5$, from $\dim\mathfrak m=n^2/4\notin\mathbb Z$ | **HOLDS** |
| 14 | $\theta=\theta_0(n)$ exactly at every saturating point | **HOLDS, recovered independently here** |
| 15 | $n=4$: $\mathfrak g'$ one $\mathfrak{so}(3)$ factor, $\mathfrak r$ the other, at $W_{\mathbb{CP}^2}$ | **HOLDS** |
| 16 | The unit-norm hypothesis, which the scalar saturation condition needs and neither statement prints | **HYPOTHESIS-DEBT, implied by the record's own $\theta$, and owed in writing** |
| 17 | Other numerical claims of the "noise of a tautology" kind | **TWO MORE FOUND** |
| 18 | "defect" and "deficiency" carry two different normalisations in one block | **CONFIRMED COLLISION** |
| 19 | The $0.866$ attributed both to $-(S^2\times S^2)$ and to the search minimum over points with a nonzero non-extreme eigenvalue | **WITHDRAWN, cannot be exhibited without computation** |

**Verdict: PROVEN, hypotheses corrected.** The lemma is true as stated for $n\ge5$ and the two-eigenvalue conclusion is genuinely derived; one of the two routes the block offers for the $n=8$ conjugacy step does not carry its conclusion as written, and the block's own dimension-16 example refutes the implication it uses.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), line 38:

> $\mathfrak m$, $\mathfrak h$, $\mathfrak r$, at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included. **$\mathfrak m$ carries three incompatible senses across the record**, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context.

> $\theta$, $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$.

> $\theta_0(n)$, **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**.*

And the two symbols the brief flags as live in this block: $t$ is [conventions.md](../findings/conventions.md)'s per-frame $\lVert K(F)\rVert_F^2$ everywhere else on the record, while L71 uses it for the half-difference $p-\tfrac n2$ of the symmetric-pair split; $p$ and $q$ collide with [stratum-two-negative.md](../findings/stratum-two-negative.md)'s two senses each and with [isotropy-cap.md](../findings/isotropy-cap.md)'s torus rank. Inside L71 all three are unambiguous, but none is tabled in that sense. $\mathfrak g'$ is tabled nowhere at all.

## Hypothesis inventory

Everything the argument consumes, with where each enters and whether the statement prints it.

| hypothesis | where consumed | printed in the statement? |
| --- | --- | --- |
| $W\in\mathcal W_n$, $W\ne0$ | gives $\operatorname{tr}_{\Lambda^2}W=0$, hence $\lambda_{\min}<0<\lambda_{\max}$ | yes |
| $W$ critical, $Q(W)=\theta W$ | L70's identity; $W^\#$ a polynomial in $W$, hence $D$ eigenspace-constant | yes |
| $\lVert W\rVert=1$ | L70's boxed identity is homogeneous of degree one on the right and scale-invariant on the left | **no, see §9** |
| $\lambda_{\min}<0<\lambda_{\max}$ strictly | makes $\lambda_{\min}\lambda_{\max}$ the *strict* corner minimum, which is what turns $D(v)=0$ into a support statement | no; L70 supplies it from $\operatorname{tr}W=0$ |
| $D(v)=0$ for one unit $v\in E_{\min}$ | the whole equality case; eigenspace-constancy upgrades one $v$ to all | yes, as $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ |
| $\mathfrak m\ne0$ | makes $\mathfrak g'$ a *nonzero* ideal | no; automatic, $E_{\min}\ne0$ at $W\ne0$ |
| $\mathfrak{so}(n)$ simple | the ideal $\Rightarrow$ everything step | yes, via $n\ge5$ |
| relation (A), $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$ | the dimension count | no |
| relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$ | the eigenvalue ratio $(n-2)h=nm$ | no |
| total symmetry of $T_{abc}$ | the "mass splits evenly across the support" step | no |
| Cartan's classification of involutions of the compact $\mathfrak{so}(n)$, up to $\mathrm{Aut}(\mathfrak g)$ | uniqueness of the pair | yes |
| $\mathrm{Out}(D_m)=\mathbb Z/2$ for $m\ne4$, $=S_3$ for $m=4$ | the $\mathrm{Aut}$-versus-$SO(n)$ passage | implicitly, via the triality paragraph |
| $\mathfrak h$ determines $W$ | to reach "$W$ **is** the Weyl tensor of $S^{n/2}\times S^{n/2}$" from "$\mathfrak h$ is conjugate to the block" | no, see §8 |

**A hypothesis stated but never used:** none found. Every hypothesis in the statement is consumed. **A step using a hypothesis never stated:** the unit norm (§9), the two Wang–Ziller relations and the total symmetry of $T$ (§5), and the passage from $\mathfrak h$ to $W$ (§8). None of the four is false; each is owed in writing.

## 1. Saturation to brackets, derived

$D(v)=\tfrac12\sum_{a,b}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2$ with $c_{vab}=\langle[v,v_a],v_b\rangle$ in an eigenbasis $\{v_a\}$ of $W$ on $\Lambda^2\cong\mathfrak{so}(n)$. Each weight $c_{vab}^2\ge0$ and each factor $\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\ge0$, so $D(v)=0$ forces every term to vanish: $c_{vab}=0$ whenever $\lambda_a\lambda_b>\lambda_{\min}\lambda_{\max}$.

The factor is **strictly** positive off the corner. On $\mathcal W_n$ at $W\ne0$ tracelessness gives $\lambda_{\min}<0<\lambda_{\max}$, and then for $x,y\in[\lambda_{\min},\lambda_{\max}]$: if $x,y$ have the same sign, $xy\ge0>\lambda_{\min}\lambda_{\max}$; if $x<0<y$ then $xy\ge\lambda_{\min}y\ge\lambda_{\min}\lambda_{\max}$, the first step needing $y>0$ and the second $\lambda_{\min}<0$, and both are equalities only at $x=\lambda_{\min}$, $y=\lambda_{\max}$; a kernel index gives $xy=0>\lambda_{\min}\lambda_{\max}$. So $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ **iff** $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$, which is the block's "supported on $E_{\min}\otimes E_{\max}$", now with the *only if* earned rather than asserted.

Reading the three relations off, for fixed $v\in\mathfrak m$:

- $v_a\in\mathfrak m$: the pair $(a,b)$ can only be a corner if $v_b\in\mathfrak h$, so $\langle[v,v_a],v_b\rangle=0$ for every $v_b\notin\mathfrak h$, i.e. $[v,\mathfrak m]\subseteq\mathfrak h$. Linear in $v$, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$.
- $v_a\in\mathfrak h$: symmetrically $[v,\mathfrak h]\subseteq\mathfrak m$, so $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$.
- $v_a\in\mathfrak r$: no $b$ makes $(a,b)$ a corner, so $[v,v_a]=0$ outright. Hence $[\mathfrak m,\mathfrak r]=0$, **and this is where the kernel is handled**, $\mathfrak r$ containing it by [conventions.md](../findings/conventions.md).

The hypothesis is stated for one unit $v$; L70's own blockquote establishes that $W^\#=\theta W-W^2$ at a critical point, so $D$ is constant on the unit sphere of $E_{\min}$ and one $v$ gives all. **HOLDS.**

*The weakened-versus-sharp caveat in L70 does not reach here.* L70 flags that its boxed bound is the weakened member of a per-row family. That is a statement about the bound; L71's hypothesis is the vanishing of $D$, which is defined by the identity and is unconditional. L70 says so, and independently $\dim E_{\min}\ge n/2\ge3$ at $n\ge5$ puts $\lambda_{\min}$ at multiplicity $\ge2$, where L70 records the two conditions as agreeing.

## 2–3. Subalgebra, centraliser, normaliser, all four Jacobi steps check

- $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $[[\mathfrak m,\mathfrak m],\mathfrak m]\subseteq[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$. Direct.
- $[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]$. For $u,v\in\mathfrak m$ and $Z\in[\mathfrak m,\mathfrak m]$, Jacobi gives $[[u,v],Z]=[u,[v,Z]]-[v,[u,Z]]$, and $[v,Z]\in[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, so each term is in $[\mathfrak m,\mathfrak m]$. The block writes the chain as $\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]$, which compresses a two-term sum into one containment; the content is right.
- $[\mathfrak r,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak r,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak r,\mathfrak m]]=0$, using $[\mathfrak r,\mathfrak m]=0$ twice. Exact Jacobi, no slack.
- $[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak h,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak h,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]+[\mathfrak m,\mathfrak m]=[\mathfrak m,\mathfrak m]$, using only $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$. This is the identity $[h,[u,v]]=[[h,u],v]+[u,[h,v]]$ applied once, so **the claim that Jacobi gives it outright is correct**, no extra input is smuggled in.

**HOLDS.** Both containments the brief asked me to check are exact, and both are single applications of Jacobi.

## 4–5. The ideal, and the central question: is the two-eigenvalue conclusion derived?

**It is derived.** The chain, with every input named:

1. $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h\oplus\mathfrak r$ as an orthogonal direct sum, because $W$ is symmetric on $\Lambda^2$ and these are its eigenspaces. **No hypothesis.**
2. $[\mathfrak m,\mathfrak g']\subseteq\mathfrak g'$ from §2; $[\mathfrak h,\mathfrak g']\subseteq\mathfrak g'$ and $[\mathfrak r,\mathfrak g']=0$ from §3.
3. Hence $[\mathfrak{so}(n),\mathfrak g']\subseteq\mathfrak g'$: $\mathfrak g'$ is an ideal.
4. $\mathfrak m\ne0$ since $E_{\min}\ne0$, so $\mathfrak g'\ne0$; $\mathfrak{so}(n)$ simple gives $\mathfrak g'=\mathfrak{so}(n)$.
5. $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]\subseteq\mathfrak m\oplus\mathfrak h$, so $\mathfrak m\oplus\mathfrak h=\mathfrak{so}(n)$, forcing $\mathfrak r=0$ and $[\mathfrak m,\mathfrak m]=\mathfrak h$.
6. $\mathfrak r=0$ means every eigenvalue of $W$ is $\lambda_{\min}$ or $\lambda_{\max}$, and both eigenspaces are nonzero. **Exactly two eigenvalues.**

**$\mathfrak r=0$ is never used upstream of step 5.** I traced each input backwards: step 1 uses symmetry of $W$; step 2 uses the three relations of §1, which come from $D(v)=0$ and the strict corner minimum, which come from criticality and $\operatorname{tr}W=0$; step 4 uses simplicity. Nowhere does the spectrum's length enter. **The circularity the blockquote records is genuinely removed, and the ideal step is what removes it.** The record's defect (i) is correctly diagnosed and correctly repaired.

*What made the old version circular is worth stating positively:* the predecessor established only that $\mathfrak r$ **centralises** $\mathfrak g'$, which leaves $\mathfrak g'$ a subalgebra of the centraliser rather than an ideal of $\mathfrak{so}(n)$; simplicity says nothing about subalgebras. The one added line ($\mathfrak h$ normalises $\mathfrak g'$), is exactly the difference between a subalgebra and an ideal, and it is free from $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$.

## 6. $\mathfrak r=0$, simplicity, and the boundary dimensions

- $\mathfrak{so}(3)\cong\mathfrak{su}(2)$: simple. $\mathfrak{so}(4)\cong\mathfrak{su}(2)\oplus\mathfrak{su}(2)$: not simple. $\mathfrak{so}(5)\cong\mathfrak{sp}(2)$, $\mathfrak{so}(6)\cong\mathfrak{su}(4)$, and $\mathfrak{so}(n)$ for $n\ge7$: simple. So **"every $n\ge3$ except $n=4$" is correct**, and $n=4$ is the sole failure of simplicity in the stated range.
- **$n=3$**: $\dim\mathcal W_3=\tfrac{3\cdot0\cdot4\cdot5}{12}=0$, so $\mathcal W_3=0$ and there is no critical point to speak of. The block's reason for excluding $n=3$ (vacuity, not a failure of simplicity), is right, and it is right to say so, because the naive reader would otherwise assume simplicity is what fails there.
- **$n=4$**, checked against the block's own witness. At $W_{\mathbb{CP}^2}$ the $\Lambda^2(\mathbb R^4)$ spectrum is $\tfrac1{\sqrt6}(2,-1,-1,0,0,0)$ with the nonzero part supported on $\Lambda^+$. So $\mathfrak m$ is the $2$-dimensional $\lambda=-1/\sqrt6$ space inside $\mathfrak{su}(2)_+$, $\mathfrak h$ the remaining line of $\mathfrak{su}(2)_+$, and $\mathfrak r=\Lambda^-=\mathfrak{su}(2)_-$, which is $\ker W$. Then $[\mathfrak m,\mathfrak m]$ is the third direction of $\mathfrak{su}(2)_+$, so $\mathfrak g'=\mathfrak{su}(2)_+$ and $\mathfrak r=\mathfrak{su}(2)_-$, **exactly as the block says**, and the three relations all hold ($[\mathfrak m,\mathfrak r]=0$ because the two factors commute). The exception is structural and the witness realises it.
- **$n=5$**, the low end of the stated range: $\mathfrak{so}(5)$ is simple, so the ideal argument runs and gives $\dim\mathfrak m=25/4\notin\mathbb Z$, no saturating point. Consistent with the block's "$92$ critical points at $n=5$, none saturating".
- **$\ker W\ne0$**: covered at step 1 of §1 (a kernel index gives $xy=0$, strictly above the corner) and killed by $\mathfrak r=0$ at $n\ge5$. The block's statement that $\ker W=0$ is a *corollary* of $\mathfrak r=0$ rather than stronger is correct, $\ker W\subseteq\mathfrak r$ by definition. And it is indeed **false at $n=4$**, $W_{\mathbb{CP}^2}$ having a $3$-dimensional kernel, as computed above.
- **Padded objects**: padded $W_{\mathbb{CP}^2}$ in $\mathbb R^n$ has $\lambda_{\min}=-1/\sqrt6$, $\lambda_{\max}=2/\sqrt6$, $\theta=\sqrt{3/2}$, so $\lambda_{\min}+(n-2)\lambda_{\max}-\theta=\tfrac{2n-8}{\sqrt6}$ and $D(v)=\lvert\lambda_{\min}\rvert\cdot\tfrac{2n-8}{\sqrt6}=\tfrac{n-4}3$, **the block's $(n-4)/3$ recovered in closed form**, zero exactly at $n=4$ and positive for every $n\ge5$. The padded competitor cannot saturate, so it raises no conflict with the lemma even though it carries the larger $\theta$ below the crossover.

## 7. The symmetric pair

$[\mathfrak h,\mathfrak h]=[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]=\mathfrak h$, by §2's third bullet, or equally by §3's normalisation with $\mathfrak h=[\mathfrak m,\mathfrak m]$. Both routes work and neither needs anything new. With $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ already in hand, $\sigma:=\mathrm{id}_{\mathfrak h}\oplus(-\mathrm{id}_{\mathfrak m})$ is an involutive automorphism of $\mathfrak{so}(n)$ and $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **HOLDS.** The block never writes $\sigma$ down; the classification it then invokes is a classification *of involutions*, so naming $\sigma$ would cost one clause and would make the import's object explicit.

Defect (ii)'s diagnosis (that $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ is needed and was previously underived), is correct: without it "symmetric pair" is not established, and no other line of the block supplies it.

## 8. $\dim\mathfrak h=\tfrac{n(n-2)}4$, and the uniqueness step

### 8.1 The dimension, derived and checked for circularity

Write $m=\lvert\lambda_{\min}\rvert>0$, $h=\lambda_{\max}>0$, $M=\dim\mathfrak m$, $H=\dim\mathfrak h$, $N=\binom n2$.

Take relation (B) at a row $k=v\in\mathfrak m$: $\sum_{\beta\gamma}\lambda_\beta T_{v\beta\gamma}=-2\lambda_v=2m$. Saturation puts the whole mass of $T_{v\cdot\cdot}$ on ordered pairs with one index in $\mathfrak m$ and one in $\mathfrak h$. That set is symmetric under swapping the two indices and $T$ is totally symmetric, so **exactly half the mass has $\beta\in\mathfrak m$**, which is what "$T$'s mass splitting evenly across the support" means, and it is a consequence of total symmetry rather than an assumption. Relation (A) fixes the total at $2(n-2)$, so each half is $n-2$:

$$-m(n-2)+h(n-2)=2m\quad\Longrightarrow\quad (n-2)h=nm .$$

That is the block's ratio, and it is the same statement as the converse clause's $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$. **Only now** does $\mathfrak r=0$ enter: with no third eigenvalue, $\operatorname{tr}_{\Lambda^2}W=Hh-Mm=0$, so $Hh=Mm$, so $Hn=(n-2)M$, i.e. $M=\tfrac{n}{n-2}H$. With $H+M=N=\tfrac{n(n-1)}2$,

$$H\cdot\frac{2n-2}{n-2}=\frac{n(n-1)}2\quad\Longrightarrow\quad H=\frac{n(n-2)}4,\qquad M=\frac{n^2}4 .$$

**Not circular.** The inputs are (A), (B), total symmetry of $T$, the support statement, $\mathfrak r=0$ and $\operatorname{tr}W=0$. The conclusion being tested (that $\mathfrak h$ is the balanced $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$), appears nowhere among them. The block's sequencing warning ("only after $\mathfrak r=0$") is exactly the right one: the ratio is available before, the dimensions only after.

The block's own control confirms it. At $W_{\mathbb{CP}^2}$, $n=4$: $m=1/\sqrt6$, $h=2/\sqrt6$, and $(n-2)h=4/\sqrt6=nm$, **the ratio holds**. But $H=1$ against $n(n-2)/4=2$, **the dimension formula correctly fails**, because $\mathfrak r\ne0$ there and the trace step is unavailable. The control isolates precisely the step that needs $\mathfrak r=0$.

### 8.2 $\theta=\theta_0(n)$, recovered independently

$\lVert W\rVert^2=Hh^2+Mm^2=\tfrac{n(n-2)}4\cdot\tfrac{n^2m^2}{(n-2)^2}+\tfrac{n^2}4m^2=\tfrac{n^2m^2}4\cdot\tfrac{2n-2}{n-2}=1$, so $m^2=\tfrac{2(n-2)}{n^2(n-1)}$. And $\theta=\lambda_{\min}+(n-2)\lambda_{\max}=-m+nm=(n-1)m$, so

$$\theta^2=(n-1)^2m^2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 ,$$

matching [conventions.md](../findings/conventions.md)'s closed form exactly. The converse clause's "$\theta=(n-1)\lvert\lambda_{\min}\rvert$" is the middle step of this, and its "$\ge\theta_0(n)$ with equality for $n\ge5$" is right: equality holds whenever $\mathfrak r=0$, which $n\ge5$ forces, while at $n=4$ the $W_{\mathbb{CP}^2}$ branch gives $\theta=3/\sqrt6=\sqrt{3/2}>\sqrt3/2=\theta_0(4)$.

### 8.3 The identity and the forcing

$\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\binom p2+\binom q2=\tfrac{p^2+q^2-(p+q)}2$. With $p=\tfrac n2+t$, $q=\tfrac n2-t$: $p^2+q^2=\tfrac{n^2}2+2t^2$ and $p+q=n$, giving $\tfrac{n^2}4+t^2-\tfrac n2$. **Identity correct.** The target $\tfrac{n(n-2)}4=\tfrac{n^2}4-\tfrac n2$ gives $t^2=0$, so $t=0$, at every even $n$ at once and with no case list. **Forcing correct**, and defect (iv)'s claim that the $n=6\ldots16$ case list was unnecessary is right. $\dim\mathfrak u(n/2)=n^2/4$ exceeds the target by $n/2>0$, so it is excluded. Those two are the whole of Cartan's list for $\mathfrak{so}(n)$ ([holland-ion](../references/holland-ion-2012-symmetric-spaces/notes.md), Ch. 8 §2.1 and §2.3, and the notes there record that a reader stopping at §2.1 sees only the even–even splits and would think the odd–odd ones absent).

### 8.4 The $\mathrm{Aut}$-versus-$SO(n)$ gap, where it is real, and where the block's route 1 fails

**The gap is real only at $n=8$, and the block is right to put it there.** For $n$ even and $\ne8$, [ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md) Prop. 4.43 and Ex. 4.45 give $\mathrm{Aut}(\mathfrak{so}(n))/\mathrm{Int}\cong\mathrm{Sym}(D_{n/2})=\mathbb Z/2$, realised by conjugation with $\mathrm{diag}(-1,1,\dots,1)\in O(n)$, so $\mathrm{Aut}$-conjugacy is $O(n)$-conjugacy, and the standard block $\mathfrak{so}(\tfrac n2)\oplus\mathfrak{so}(\tfrac n2)$ is normalised by a reflection, so its $O(n)$-orbit and its $SO(n)$-orbit coincide. Nothing is lost. At $n=8$, $\mathrm{Sym}(D_4)=S_3$ and $O(8)$ realises only the $\mathbb Z/2$, so $\mathrm{Aut}$-conjugacy is strictly coarser.

**Route 2, the weight test, is valid.** Take $\tau=\mathrm{diag}(-1_4,1_4)=\exp(\pi(H_1+H_2))$ with $H_i$ the generator of rotation in the $i$-th coordinate $2$-plane. On $V$ the weights are $\pm e_i$, giving eigenvalue $e^{\pm i\pi}=-1$ for $i=1,2$ and $+1$ for $i=3,4$: pattern $((-1)^4,(+1)^4)$. On $S^\pm$ the weights are $\tfrac12(\epsilon_1,\dots,\epsilon_4)$ with $\prod\epsilon_i=\pm1$, and the eigenvalue is $i^{\epsilon_1+\epsilon_2}$, which is $-1$ when $\epsilon_1=\epsilon_2$ and $+1$ when $\epsilon_1=-\epsilon_2$. In each half-spin representation, $\epsilon_1=\epsilon_2$ leaves $\epsilon_3\epsilon_4$ determined, giving $2+2=4$ weights at $-1$, and $\epsilon_1=-\epsilon_2$ gives the other $4$ at $+1$. **So the pattern is $(1^4,(-1)^4)$ on $V$, $S^+$ and $S^-$ alike**, and it is insensitive to the sign ambiguity of the $Spin(8)$ lift. Any $\phi\in\mathrm{Aut}(\mathfrak{so}(8))$ therefore sends $\tau$ to an element acting on $V$ as an involution with $4$-dimensional eigenspaces, hence $SO(8)$-conjugate to $\tau$ itself; so the $\mathrm{Aut}$-class of $\sigma_0=\mathrm{Ad}(\tau)$ is a single $\mathrm{Inn}$-class, and Cartan's $\mathrm{Aut}$-level conclusion upgrades to $SO(8)$-conjugacy. **This route carries the lemma.**

**Route 1, the determinant, does not carry its conclusion as written.** The sentence is

> Its determinant: $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ has $\det=+1$ and is **inner**, so Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy

**Located**: [bounds.md](../findings/bounds.md), and it appears three times, in the four-defects blockquote, again verbatim in the uniqueness paragraph, and in condensed form in [results.md](../results.md)'s L71 statement ("its determinant is $+1$, so $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ is inner and Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy").

**Exhibited concretely, in closed form**: take $\tau_2=\mathrm{diag}(-1_2,1_6)$. Then $\det\tau_2=+1$, so $\mathrm{Ad}(\tau_2)$ is inner by exactly the criterion route 1 uses, and its fixed algebra is $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$, of dimension $1+15=16$. If "inner $\Rightarrow$ Cartan up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy" were sound, the $\mathrm{Aut}$-class of $\mathrm{Ad}(\tau_2)$ would be a single $SO(8)$-class. **The block's very next sentence says it is not**, the $\mathfrak u(4)\leftrightarrow\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ swap at dimension $16$ is recorded there as moving, and it does move: $D_4/P_1$ is the quadric $\widetilde{Gr}_2(\mathbb R^8)=SO(8)/(SO(2)\times SO(6))$ and $D_4/P_3\cong D_4/P_4$ are the spinor varieties $SO(8)/U(4)$, and triality permutes the three minuscule nodes. So route 1's implication has a counterexample inside $\mathfrak{so}(8)$ that the block itself records.

**Arguing the opposite.** Is there a reading under which route 1 stands? Yes, and it is one clause away. Innerness is an invariant of $\mathrm{Aut}$-conjugation, and [etingof](../references/etingof-2024-real-forms-involutions/notes.md) §41.4 item 5 enumerates the *inner* involutions of $\mathfrak{so}(2n)$ completely and uniformly in $n$, as $\mathrm{Ad}(g)$ with $g\in SO(2n)$, $g^2=\pm1$: $g^2=1$ gives even-dimensional eigenspaces and $\mathfrak k=\mathfrak{so}(2p)\oplus\mathfrak{so}(2q)$, and $g^2=-1$ gives $\mathfrak k=\mathfrak u(n)$. At $n=8$ the inner classes therefore carry $\dim\mathfrak k\in\{16,12,16\}$ for $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$, $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, $\mathfrak u(4)$. **Innerness together with $\dim\mathfrak k=12$ leaves only $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, and all such $g$ are $SO(8)$-conjugate** because the $(4,4)$ eigenspace split lets a $\det=-1$ conjugator be corrected inside $O(4)\times O(4)$. That is a sound route 1, it is independent of route 2, and it uses only a source the record already holds. What it needs is the dimension step, which the block **explicitly disowns two sentences earlier** ("the $n=8$ question is settled by **conjugacy, not by dimension**"; [results.md](../results.md): "*Dimension does not decide this*"). Those disownings are correct about the argument they name (dimension *alone*, across inner and outer classes together, does not decide, witness $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ against $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $13$, both outer), but as written they forbid the reader from supplying the missing clause.

**Discrepancy stands, all three tests cleared.** The failure is confined to the wording of route 1; the lemma's conclusion survives on route 2 and on the repaired route 1. The parallel clause "which is exactly why dimension $12$ is safe and $13$ is not" is wrong for the same reason: innerness is not what makes $12$ safe. Dimension $21$ is also outer and also unsafe, the $\mathrm{Aut}$-class of $\mathfrak{so}(1)\oplus\mathfrak{so}(7)$ contains the $Spin(7)\subset SO(8)$ embedding acting irreducibly on $\mathbb R^8$, so "outer, therefore unsafe" is a correlation the block reads as a mechanism.

### 8.5 The Cartan import, hypotheses checked against the object

The theorem imported is: *involutions of a compact simple Lie algebra are classified up to conjugacy in $\mathrm{Aut}(\mathfrak g)$, and for $\mathfrak{so}(N)$ the fixed algebras are $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=N$, together with $\mathfrak u(N/2)$ at even $N$.* Its hypotheses against L71's object:

| hypothesis of the import | the object here | met? |
| --- | --- | --- |
| $\mathfrak g$ simple | $\mathfrak{so}(n)$, $n\ge5$ | yes |
| $\mathfrak g$ compact real form | $\mathfrak{so}(n)$ acting on $\Lambda^2\mathbb R^n$ | yes |
| $\sigma\in\mathrm{Aut}(\mathfrak g)$, $\sigma^2=\mathrm{id}$ | $\sigma=\mathrm{id}_{\mathfrak h}\oplus(-\mathrm{id}_{\mathfrak m})$, an automorphism by §7's three relations | yes |
| conjugacy is taken in $\mathrm{Aut}(\mathfrak g)$ | the lemma consumes $SO(n)$-conjugacy | **no, §8.4 is exactly this passage** |

**No unmet hypothesis of the kind that killed the unital-algebra route.** The import's own object is an involution, and the record constructs one; there is no silent identification of $\mathcal W_n$ with an algebra it is not.

**Two bridge steps are in no filed source**, and the record's own [CARTAN-SEARCH.md](../references/CARTAN-SEARCH.md) says so for one of them. First: [etingof](../references/etingof-2024-real-forms-involutions/notes.md) classifies real forms of the *complex* $\mathfrak g$ with $\mathfrak k=\mathfrak{gl}_n(\mathbb C)$ rather than $\mathfrak u(n)$, and the passage to the compact form "is standard and is set up in the same lecture, but is not written out". Second: [ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md)'s notes state plainly that reading Prop. 4.43 as "$\mathrm{Aut}$-conjugacy of involutions is $O(n)$-conjugacy for $n\ne8$" is a step past what is printed. Both steps are standard; neither is on the record with a citation. That is a citation debt, not a mathematical gap.

### 8.6 From $\mathfrak h$ to $W$

The lemma concludes that $W$ **is** the Weyl tensor of $S^{n/2}\times S^{n/2}$, not merely that $\mathfrak h$ is conjugate to the block. That last step is: with two eigenvalues, $W=h\Pi_{\mathfrak h}-m\Pi_{\mathfrak m}=(h+m)\Pi_{\mathfrak h}-m\,\mathrm{Id}$, so $W$ is determined by $\mathfrak h$ together with $h$ and $m$, and §8.1–8.2 pin $h$ and $m$ from $\dim\mathfrak h$ and $\lVert W\rVert=1$. Conjugating $\mathfrak h$ by $g\in O(n)$ conjugates $W$ by $\mathrm{Ad}(g)$ on $\Lambda^2$. So $SO(n)$-conjugacy of $\mathfrak h$ does deliver the conclusion. **The step is sound and the block does not write it**; it is the fourth unstated input in the inventory.

## 9. The unit norm

L70's block is explicit: *"**And it needs $\lVert W\rVert=1$**: under [conventions.md](../findings/conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ the left side is scale-invariant while the right is homogeneous of degree one, so the identity holds at one scale only."* Neither L71 statement prints it. [results.md](../results.md) goes further and glosses the hypothesis as "the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$", then says "the hypothesis is checkable from $(\lambda,\theta)$ alone", **true only at unit norm**, since replacing $W$ by $cW$ leaves $\theta$ fixed and scales the right-hand side by $c$.

**Arguing the opposite**, as the protocol requires: the record's own normalisation does force it. From $Q(W)=\theta W$ and $\theta=P(W)/\lVert W\rVert^3$ one gets $P(W)=\langle W,Q(W)\rangle=\theta\lVert W\rVert^2=P(W)/\lVert W\rVert$, so $\lVert W\rVert=1$ whenever $P(W)\ne0$. So the hypothesis is implied rather than missing, and the finding is **HYPOTHESIS-DEBT** at the level of the write-up: the one place the record flags the normalisation as load-bearing is the place the consumer omits it, and the "checkable from $(\lambda,\theta)$ alone" gloss is false without it.

## 10. Parity, and the shape of the statement at odd $n$

$\dim\mathfrak m=n^2/4$ is not an integer at odd $n$, so no critical point saturates at odd $n\ge5$. **HOLDS**, and the derivation is available at odd $n$ because $\mathfrak{so}(n)$ is simple there, nothing in §§1–8.1 assumed $n$ even.

**A presentational defect.** Both the [bounds.md](../findings/bounds.md) blockquote and the [results.md](../results.md) statement assert, for all $n\ge5$, "$W$ is the Weyl tensor of the balanced sphere product $S^{n/2}\times S^{n/2}$", and only afterwards conclude that odd $n$ admits no saturating point. Read in order, the statement names an object that does not exist at odd $n$. The intended reading is a reductio and the mathematics is right; the sentence should be ordered so the parity conclusion precedes the identification, or the identification should carry "$n$ even".

## 11. The numbers

**The one already disowned.** $\lVert[\mathfrak h,[\mathfrak m,\mathfrak m]]$ off $[\mathfrak m,\mathfrak m]\rVert\le7\times10^{-16}$, measured at the balanced products where $\mathfrak h=[\mathfrak m,\mathfrak m]$ holds by construction. The block's own reading ("the noise of a tautology rather than corroboration"), is correct.

**Two more of exactly that kind, not so labelled.**

- "$[\mathfrak m,\mathfrak m]=\mathfrak h$ *exactly* (dimensions $6,12,20,30$ at $n=6,8,10,12$)". Those are $n(n-2)/4$ evaluated at four points ($6\cdot4/4$, $8\cdot6/4$, $10\cdot8/4$, $12\cdot10/4$), measured at the balanced sphere products, which are the theorem's own output. It confirms the arithmetic of the formula and says nothing about the implication.
- "$\dim\mathfrak m+\dim[\mathfrak m,\mathfrak m]=N$". Same population, same objection: it is $\mathfrak r=0$ restated at points where $\mathfrak r=0$ by construction.

**What is not of that kind.** The controls are measured *off* the saturating set and are genuine: the maximal tori putting $82\%$–$89\%$ of $[\mathfrak m,\mathfrak m]$ outside $\mathfrak h$, and padded $W_{\mathbb{CP}^2}$ carrying $\lVert[\mathfrak m,\mathfrak r]\rVert=2.8$ and deficiency $(n-4)/3$, the latter reproduced in closed form in §6 above. They establish that the hypothesis is not vacuous, which is the one thing an output-point measurement cannot do.

**The searches add nothing once the proof stands.** "~$200$ critical points at $n=4$–$8$ and $92$ at $n=5$, none saturating off the family" supports a universal claim that §§1–8 prove outright for $n\ge5$; a finite search is not a witness for a universal statement, and here it does not need to be. Unlike the L70 block, which names [run_salvage_equality_case.py](../scripts/runs/run_salvage_equality_case.py), the L71 block cites no script for any of its figures.

**A normalisation collision, confirmed.** The block uses *deficiency* and *defect* for two quantities differing by a factor $\lvert\lambda_{\min}\rvert$, and both readings are recoverable from the block's own numbers. Padded $W_{\mathbb{CP}^2}$: "deficiency $(n-4)/3$" is $D(v)$. The $n=4$ figures: $-W_{\mathbb{CP}^2}$ has $\lambda_{\min}=-2/\sqrt6$, $\lambda_{\max}=1/\sqrt6$, $\theta=-\sqrt{3/2}$, so $\lambda_{\min}+2\lambda_{\max}-\theta=\sqrt{3/2}=1.224744871$ (**the block's number**) while $D(v)$ there is $\tfrac2{\sqrt6}\sqrt{3/2}=1$. Likewise $-(S^2\times S^2)$ has $\lambda_{\min}=-2/\sqrt{12}$, $\lambda_{\max}=1/\sqrt{12}$, $\theta=-\sqrt3/2$, giving $\sqrt3/2=0.866025404$ (the block's number), under the unweighted reading. So "defect" is $\lambda_{\min}+(n-2)\lambda_{\max}-\theta$ and "deficiency" is $\lvert\lambda_{\min}\rvert$ times it, in one block, with no note. Neither is in [conventions.md](../findings/conventions.md). *This is the same class as the collisions that file already tables, and it should be added there.*

**One candidate discrepancy, withdrawn.** The value $0.866025404$ is given as $-(S^2\times S^2)$'s defect, and $0.866$ is given as "the smallest defect among points carrying a nonzero non-extreme eigenvalue". But $-(S^2\times S^2)$ has exactly two eigenvalues, both extreme, so it is not in the second population, the coincidence of $\sqrt3/2$ in both roles suggests a conflated transcription. I cannot exhibit the failure without recomputing the search population, which this loop does not do, so under the discrepancy protocol it is **withdrawn**, reported here as an ambiguity the block should resolve by naming the population.

## 12. Traps, answered by name

| trap | finding |
| --- | --- |
| $\ker W\ne0$ and padded objects | handled: kernel pairs are strictly above the corner minimum, $\ker W\subseteq\mathfrak r$, and padded $W_{\mathbb{CP}^2}$'s deficiency $(n-4)/3$ is positive for $n\ge5$ |
| $n=3$ | $\mathcal W_3=0$; the block's reason for exclusion is vacuity and it is the right one |
| $n=4$ | sole failure of simplicity; the classification is complete and $W_{\mathbb{CP}^2}$ realises it, with $\mathfrak g'=\mathfrak{su}(2)_+$, $\mathfrak r=\mathfrak{su}(2)_-$ |
| $n=5$ | simplicity holds, the argument runs, $\dim\mathfrak m=25/4$ excludes saturation |
| odd $n$ | correct conclusion, mis-ordered sentence (§10) |
| the crossover $n=6+2\sqrt7$ | **no conflict.** Below it, padded $W_{\mathbb{CP}^2}$ carries $\theta=\sqrt{3/2}>\theta_0(n)$, so the saturating point is not the maximiser there, but L71 claims only a classification of saturating points and says so ("serves as no step of a proof of the conjecture"), and the padded competitor's deficiency is $(n-4)/3\ne0$, so it never saturates. The trap would bite only a version of L71 that claimed saturation implies maximality; this one does not |
| proven on a subfamily, used in general | L70's Lie-theoretic reading of saturation is stated **before** its Lemma L23 two-eigenvalue paragraph and independently of it; L71 consumes the general form. No subfamily leakage found |
| a hypothesis stated but never used | none |
| a step using a hypothesis never stated | four: unit norm, relations (A) and (B), total symmetry of $T$, and the passage from $\mathfrak h$ to $W$. All true, all owed in writing |
| the two-eigenvalue circularity | **removed.** §4 traces every input backwards; $\mathfrak r=0$ enters nowhere upstream |
| a universal claim with no witness | the searches (§11) are corroboration of a proved statement, not its support; no universal claim rests on them |
| an imported theorem whose hypotheses were never checked | Cartan's hypotheses are met (§8.5); the conjugating group is the one real mismatch and the block addresses it, with route 1 failing (§8.4) |
| symbol collisions | $t$, $p$, $q$ used in senses tabled nowhere; $\mathfrak g'$ tabled nowhere; and the defect/deficiency normalisation collision found here (§11) |

## 13. What would falsify it, and what I did to look

**The object.** A critical point $W\in\mathcal W_n$, $\lVert W\rVert=1$, $n\ge5$, with $D(v)=0$ on $E_{\min}$, whose $\mathfrak h=E_{\max}$ is **not** $O(n)$-conjugate to the block $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$. By §§1–8.3 such a $W$ must have $\mathfrak r=0$, $\dim\mathfrak h=\tfrac{n(n-2)}4$, and $\mathfrak h$ the fixed algebra of an involution, so it can exist only where $\mathrm{Aut}$-conjugacy fails to be $O(n)$-conjugacy, i.e. only at $n=8$, and only if the balanced involution's $\mathrm{Aut}$-class splits into more than one $SO(8)$-class.

**Where I looked.** At the one place it could live. The $\mathrm{Aut}$-class of $\sigma_0$ at $D_4$ splits iff triality moves its $\mathrm{Inn}$-class, and two independent invariants say it does not: the weight pattern $(1^4,(-1)^4)$ is the same on $V$, $S^+$ and $S^-$, so every element of $\mathrm{Out}=S_3$ returns an involution acting on $V$ with $4$-dimensional eigenspaces; and innerness plus $\dim\mathfrak k=12$ leaves exactly one class in [etingof](../references/etingof-2024-real-forms-involutions/notes.md)'s enumeration of the inner involutions of $\mathfrak{so}(8)$. I checked the same two invariants against the cases the record says do move, $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ against $\mathfrak u(4)$ at dimension $16$, and $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ against $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $13$, and the weight test separates the first pair while the innerness test does not, which is what exposed route 1. **No falsifier found, and the search space for one is a single conjugacy class at a single dimension.**

## Verdict

**PROVEN, hypotheses corrected.**

The lemma is true as stated for $n\ge5$. The two-eigenvalue conclusion is derived and not assumed: the ideal argument is what removes the hypothesis, and it removes it completely. The corrections owed to the write-up:

1. **Route 1 to $SO(8)$-conjugacy is invalid as written** and must gain the clause "and $\dim\mathfrak g^\sigma=12$, so by the enumeration of the inner involutions of $\mathfrak{so}(8)$ only $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ remains". It appears three times, twice in [bounds.md](../findings/bounds.md), once in [results.md](../results.md), and the surrounding disavowals of dimension arguments have to be narrowed to the argument they actually mean.
2. **$\lVert W\rVert=1$ must be printed** wherever the scalar saturation condition is, and the "checkable from $(\lambda,\theta)$ alone" gloss qualified.
3. **Relations (A), (B) and the total symmetry of $T$** should be named as inputs to the dimension count, and the passage from $\mathfrak h$ to $W$ written down.
4. **The odd-$n$ clause should be ordered** so the non-existence precedes the identification.
5. **"defect" and "deficiency" differ by $\lvert\lambda_{\min}\rvert$** in one block and belong in [conventions.md](../findings/conventions.md); the $0.866$ attribution should name its population.
6. **Two figures beyond the disowned $7\times10^{-16}$ are output-point tautologies** and should be marked as such: the $6,12,20,30$ dimensions and $\dim\mathfrak m+\dim[\mathfrak m,\mathfrak m]=N$.
