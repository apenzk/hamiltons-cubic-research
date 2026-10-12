# VERIFY v110, L52: the shared-frame majorization inequality, its "exact iff diagonal in one shared frame", the Jensen route that replaces Karamata, and the second display $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$

**Cold brief, verifier v110, round [L52](ROUND_L52.md).** No numerical work was performed: no script was run, no solver, no sampling. Every number in this report is an exact hand evaluation of a closed form, and every number I quote *from* the record is labelled as the record's measurement rather than as evidence. Log: [agent_logs/verify-L52-v110.log](../agent_logs/verify-L52-v110.log). Sources read: [findings/bispectral.md](../findings/bispectral.md) (the L52 block, the L54 block, [Lemma L94](../findings/bispectral.md), post F26, the boxed cap), [results.md](../results.md):248 and :721, [findings/LEDGER.md](../findings/LEDGER.md):330–338, [lean/INDEX.md](../lean/INDEX.md) rows for L52, L54, CubicConvexity and DoublyStochastic, [reviews/REVIEW_r479.md](../reviews/REVIEW_r479.md) and [reviews/REVIEW_r480.md](../reviews/REVIEW_r480.md) (read because the record cites them for the second display), [findings/conventions.md](../findings/conventions.md), [findings/problem.md](../findings/problem.md), and [references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md).

## Claim table

| # | The claim, as a consumer meets it | Verdict |
|---|---|---|
| C1 | The displayed inequality $\theta\le\tfrac32[p_3(K)+3M_+(1-p_2(K))]-\tfrac12[p_3(K')+3m(p_2(K')-3)]$, in one fixed frame | **PROVEN, hypotheses corrected** |
| C2 | "The bound is **exact if and only if both operators are diagonal in one shared frame**" | **GAP**, true only after the $\psi$-basis is fixed; false for admissible choices of $K'$ as the words stand |
| C3 | "**Karamata is not needed**", the row-by-row Jensen derivation of the *inequality* | **PROVEN** |
| C4 | The Jensen route's *equality* case: "tightness in every row makes each row a point mass under strict convexity, **so $U$ is a permutation**" | **BROKEN as written**, false whenever $\mu$ has a repeated eigenvalue; the shared-frame conclusion nevertheless survives |
| C5 | The headline "**the two spectra do not couple usefully through a shared frame**" ([results.md](../results.md):248, :721) | **BROKEN**, not entailed by the bound, and refuted by the same file; uncorrected where a consumer reads |
| C6 | The operative clause "off it, loses to a one-line estimate and to the moment relaxation it was built to improve" ([results.md](../results.md):248) | **BROKEN**, false on a neighbourhood of the diagonal family |
| C7 | The second display is supported by "$\tfrac92(1.632993)(0.5)=3.674235$ … the block's penalty sum exactly" | **PROVEN, derived, not screened**, but the derivation is in [REVIEW_r480](../reviews/REVIEW_r480.md):44 and nowhere in the record proper |
| C8 | The second display's coefficient $\tfrac92(M_++m)(1-t_F/2)$ | **PROVEN**, exact by hand from [Lemma L54](../results.md)'s two norm identities |
| C9 | "L52 is a **reduction of Conjecture A to a lower bound on the frame-optimised diagonal mass $t_F$**" | **GAP**, the only lower bound that serves is $t_F=2$ itself, at every $W$ with $\theta>\Theta_n/2$ |
| C10 | [results.md](../results.md):721 read alone, as a citable statement | **BROKEN**, the normalisation the display's constants $1$ and $3$ encode is stated nowhere in the entry |
| C11 | "The true statement is quantitative: the coupling loses exactly when $t_F<\tfrac43$" | **GAP**, a one-variable reading of a two-variable criterion the record itself displays |

**One-line summary.** The inequality is correct and the Jensen route genuinely retires Karamata from it; the equality case is correct only once the $\psi$-basis is stipulated and only if "point mass" is read up to eigenvalue multiplicity; and every defect that survives is a defect of the *statement a consumer cites*, not of the mathematics behind it.

**Verdict: GAP.**

## 0. Conventions, fixed once

- $n\ge4$ and $W\in\mathrm{Weyl}_n$, an algebraic Weyl tensor; $M$ is $W$ acting on $\Lambda^2\mathbb R^n$ with $\lVert M\rVert_F=1$ and spectrum $\mu$ ($N_1=\binom n2$ entries); $\mathring W$ is the curvature operator of the second kind on $S^2_0$ in Li's order $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$ ($N_2=\tbinom{n+1}2-1$ entries).
- $p_k(x)=\sum_ix_i^k$. [Lemma L50](../results.md) supplies $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ with $\sum\mu=\sum\omega=0$, $p_2(\mu)=1$, $p_2(\omega)=3$.
- $F$ is an orthonormal frame of $\mathbb R^n$; $K^F$ is the hollow symmetric matrix $K_{ij}=W_{ijij}$, which satisfies $K^F\mathbf1=0$; $t_F:=\lVert K^F\rVert_F^2=2\sum_{i<j}W_{ijij}^2$; $d_\varphi$ is the vector $(K_{ij})_{i<j}$ and $d_\psi$ the $\psi$-block diagonal, $K'=(d_\varphi,d_\psi)$.
- $M_+$ is any real with $\mu_i\le M_+$ for all $i$; $m$ is any real with $\omega_i\ge-m$ for all $i$. Both are automatically positive, since $\sum\mu=0$ with $p_2(\mu)=1$ forces $\max\mu>0$ and $\sum\omega=0$ with $p_2(\omega)=3$ forces $\min\omega<0$.
- $x\prec y$ means $x$ is majorized by $y$. $\Theta_n$ is the *diagonal* maximum of [conventions.md](../findings/conventions.md), equal to $\theta_0(n)$ at even $n$ and to $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$.

## 1. The hypothesis inventory

A pass without this table is not a pass. "Block" is the L52 canonical block at [bispectral.md](../findings/bispectral.md):87–90; "Canon" is [results.md](../results.md):721.

| Hypothesis | Where it is needed | Block | Canon |
|---|---|---|---|
| $W\in\mathrm{Weyl}_n$ (algebraic Weyl, trace-free) | to have $p_2(\omega)=3$ at all, and for $K\mathbf1=0$ downstream | no | no |
| $\lVert M\rVert_F=1$ | the display's literal constants: the "$1$" in $(1-p_2(K))$ is $p_2(\mu)$ and the "$3$" in $(p_2(K')-3)$ is $p_2(\omega)$ | no (stated 70 lines above, at the file's head) | **no** |
| $n\ge4$ | $\mathrm{Weyl}_n\ne0$; and [Lemma L57](../results.md) for the second display | no | no |
| [Lemma L50](../results.md), $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ | the object being bounded is $\theta$ at all | imported silently | imported silently |
| $\mu_i\le M_+$ for every $i$ | concavity domain of $g(t)=t^3-3M_+t^2$, and the $K$ side lies in it too | yes | yes |
| $\omega_i\ge-m$ for every $i$ | convexity domain of $f(t)=t^3+3mt^2$, and the $K'$ side lies in it too | yes | yes |
| one fixed orthonormal frame $F$ | $K$, $K'$, $t_F$ are all frame-dependent | yes | yes |
| **a choice of orthonormal basis of $S^2_0$ extending $\{\varphi_{ij}\}$**, the $\psi_k$ | $K'$ is not a function of $F$; the $\psi$-block carries a further $O(n-1)$ of freedom | **no** | **no** |
| $\psi_k$ = eigenbasis of $K$ on $\mathbf1^\perp$ | the *equality case*, $\sum d^2=\tfrac32t_F$, and the second display's coefficient | no (only in the L54 block) | no (only at [results.md](../results.md):728) |
| NPW Prop 3.10, $g(\mathcal R\phi_{ij},\phi_{ij})=R_{ijij}$ | the $\mathring W$ half of the frame dictionary | cited | cited |
| Schur's theorem: a diagonal is majorized by the spectrum | $K\prec\mu$, $K'\prec\omega$ | named | named |
| Karamata / Hardy–Littlewood–Pólya **with its equality case** | the route the canon states | named | named |
| Jensen + Birkhoff (double stochasticity of $(\lvert U_{ij}\rvert^2)$) | the route the block prefers | named, with [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) | **absent** |
| [Lemma L57](../results.md) / $\Theta_n$ as the diagonal maximum | the first term of the *second* display | absent | absent |
| [Lemma L94](../findings/bispectral.md), $t_F\le2$ with equality iff coordinate-diagonal | the range of $t_F$, and "exact at $t_F=2$" | absent from the L52 block | absent |

**Which hypotheses the written proof actually uses.** Rows 5, 6, 7, 11 and 12 (or 13) alone carry the displayed inequality; rows 1, 2 and 4 are used *silently* and are the ones a consumer cannot recover; row 8/9 is used without being stated anywhere in either form of L52; rows 14 and 15 are used only by the second display, which names neither.

**Sources.** NPW is in [references/](../references/) and Proposition 3.10 is transcribed in its [notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) with the $\phi_{ij}=\tfrac1{\sqrt2}(e^i\otimes e^j+e^j\otimes e^i)$ normalisation the block uses, read, not remembered. What the block does **not** show is that NPW's $\mathcal R$ and Li's $iklj$-ordered $\mathring W$ agree in sign; the record treats the index order as load-bearing for [L50](../results.md) and silent here, and if the two conventions differed by the sign the record itself says flips $\mathring W$, then $K'$ would be $-K'$ and the $\omega$-side inequality would reverse. **No finding of error** (I have no reason to think they differ) but the compatibility is asserted, not shown. Schur's theorem, Karamata/HLP and Birkhoff are not in [references/](../references/): those three claims rest on unread sources, textbook though they are.

## 2. Question 1a, does the inequality follow? Yes.

I check the direction of each convexity claim against the range it is asserted on, since that is where a sign error would live.

**The $\omega$ side.** $f(t)=t^3+3mt^2$ has $f''(t)=6t+6m=6(t+m)$, so $f''\ge0$ exactly on $[-m,\infty)$: **convex there**, as asserted. Both vectors lie in that range: $\omega_i\ge-m$ by hypothesis, and every entry of $K'$ is a Rayleigh quotient $\langle\mathring Wv,v\rangle$ with $\lvert v\rvert=1$, hence $\ge\lambda_{\min}(\mathring W)=\min_i\omega_i\ge-m$. With $K'\prec\omega$ and $f$ convex, Karamata gives $\sum_if(K'_i)\le\sum_if(\omega_i)$, that is
$$p_3(K')+3m\,p_2(K')\ \le\ p_3(\omega)+3m\,p_2(\omega)=p_3(\omega)+9m,$$
using $p_2(\omega)=3$. Rearranged, $p_3(\omega)\ge p_3(K')+3m(p_2(K')-3)$, the block's second display, sign for sign.

**The $\mu$ side.** $g(t)=t^3-3M_+t^2$ has $g''(t)=6(t-M_+)\le0$ exactly on $(-\infty,M_+]$: **concave there**, as asserted. Both vectors lie in that range: $\mu_i\le M_+$ by hypothesis and $K_i=\langle M\varphi_i,\varphi_i\rangle\le\lambda_{\max}(M)=\max_i\mu_i\le M_+$. With $K\prec\mu$ and $g$ concave, $\sum_ig(K_i)\ge\sum_ig(\mu_i)$, that is $p_3(K)-3M_+p_2(K)\ge p_3(\mu)-3M_+$, using $p_2(\mu)=1$; rearranged, $p_3(\mu)\le p_3(K)+3M_+(1-p_2(K))$.

**Assembly.** $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$; the first term is bounded above by the $\mu$ display and the second, carrying a *negative* coefficient, by the *lower* bound on $p_3(\omega)$. Both moves go the right way, and adding them gives the block's display exactly. **C1 holds.**

**Both penalties are non-negative**, so the display is a genuine relaxation and not an accident of sign: $p_2(K)\le p_2(\mu)=1$ and $p_2(K')\le p_2(\omega)=3$ (majorization implies domination of $p_2$), and $M_+,m>0$ by §0. Their sum is $\tfrac92M_+(1-p_2(K))+\tfrac32m(3-p_2(K'))=\tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2+\tfrac32m\lVert\mathring W_{\mathrm{off}}\rVert_F^2$, which reproduces the block's own penalty identity at [bispectral.md](../findings/bispectral.md):51 exactly.

**Range edges.** $\ker W\ne0$ changes nothing: a zero eigenvalue lies strictly inside both domains $(-\infty,M_+]$ and $[-m,\infty)$ and Schur is indifferent to it. Non-tight constants change nothing either: any $M_+\ge\max\mu$ and any $m\ge-\min\omega$ serve, the domains only growing. The *attained* endpoints ($\mu_i=M_+$, $\omega_i=-m$, where $g''$ and $f''$ vanish), are the interesting edge, and they are treated in §3. The smallest admissible $n$ is $4$, which the statement never gives; at $n\le3$ the statement is vacuous rather than false, so this is an omission and not an error.

**Verdict C1: PROVEN, hypotheses corrected**, the correction being that $W\in\mathrm{Weyl}_n$ and $\lVert M\rVert_F=1$ must be restored to the statement, since the constants $1$ and $3$ are $p_2(\mu)$ and $p_2(\omega)$ and are otherwise unrecoverable.

## 3. Question 1b, the equality case, and which route it needs

### 3.1 The Karamata route, checked

Both penalties being non-negative and the total slack being their sum plus the two Karamata slacks, equality in the display forces equality in **each** of the two majorization steps separately.

- $f$ is **strictly** convex on $[-m,\infty)$: $f''=6(t+m)$ vanishes only at the single point $t=-m$, and a $C^2$ function with $f''\ge0$ vanishing on a set with empty interior is strictly convex. So $K'\prec\omega$ with $\sum f(K')=\sum f(\omega)$ forces $K'^\downarrow=\omega^\downarrow$, whence $\sum_i(K'_i)^2=\sum_i\omega_i^2=\lVert\mathring W\rVert_F^2$ and the off-diagonal of $\mathring W$ vanishes in the chosen basis.
- $g$ is **strictly** concave on $(-\infty,M_+]$ by the mirror argument, $g''=6(t-M_+)$ vanishing only at $t=M_+$. The same two steps give $K^\downarrow=\mu^\downarrow$ and then $M$ diagonal in the $\varphi$-basis.

The converse is immediate: if both are diagonal then $K^\downarrow=\mu^\downarrow$, $K'^\downarrow=\omega^\downarrow$, both penalties vanish and the display reads $\theta\le\theta$.

**A written-argument gap, small but real.** The block justifies the equality case with "*by strict convexity of $t^3+3mt^2$ and the equality case of Karamata*", and the earlier prose at [bispectral.md](../findings/bispectral.md):59 spells out only the $\omega$ half, "*$f$ is strictly convex on $[-m,\infty)$ and Hardy–Littlewood–Pólya equality forces $K'=\omega$*". The strict **concavity** of $t^3-3M_+t^2$, which is what forces $M$ itself to be diagonal, is asserted nowhere in either form. The word "both" in the conclusion therefore rests on one of its two halves. [REVIEW_r480](../reviews/REVIEW_r480.md):24 does carry both halves, so the argument exists in the record, it is the *block* that carries one half and the conclusion of two.

**The attained endpoint survives.** [CubicConvexity.lean](../lean/HamiltonsCubic/Results/CubicConvexity.lean)'s row in [lean/INDEX.md](../lean/INDEX.md) states the gap identity $a\,g(x)+b\,g(y)-g(ax+by)=ab(x-y)^2(x+y+u+3m)$ and asks $x,y>-m$ for strictness, whereas the objects only supply $x,y\ge-m$, $m$ read off the spectrum makes $\omega_{\min}=-m$ attained. The hypothesis mismatch is harmless: writing the bracket as $(x+m)+(y+m)+(u+m)$, each summand is $\ge0$, and $x\ne y$ forces at least one of $x,y$ strictly above $-m$, so the bracket is strictly positive whenever the factor $(x-y)^2$ is non-zero. **No finding**, recorded because the range edge is attained and the Lean row's stated hypothesis is the strict one.

### 3.2 The Jensen route, the inequality (C3)

$M=U\operatorname{diag}(\mu)U^{\mathsf T}$ with $U$ orthogonal gives $K_i=M_{ii}=\sum_jU_{ij}^2\mu_j$, and $S_{ij}=\lvert U_{ij}\rvert^2$ is doubly stochastic. For convex $f$, $f(K_i)\le\sum_jS_{ij}f(\mu_j)$ row by row, and summing over $i$ and using the **column** sums $\sum_iS_{ij}=1$ gives $\sum_if(K_i)\le\sum_jf(\mu_j)$. No Abel summation, no sorting, no Karamata: **C3 is PROVEN**, and the claim that only double stochasticity remains imported is accurate for the inequality.

Two scope notes a consumer needs. First, this route is written for the $\mu$/$M$ side, where the operative function is the **concave** $g$; the same row-by-row argument applies with the inequality reversed, but the block's sentence names "strict convexity" while its formula $K_i=\sum_j\lvert U_{ij}\rvert^2\mu_j$ is the $M$ side. Second, Karamata is not in fact retired from the file: [bispectral.md](../findings/bispectral.md):65 uses "*Karamata applied to the convex $t^3+3mt^2$*" to prove the $\psi$-basis choice optimal. The retirement is of Karamata from the *bound*, which is what the sentence claims, and it is correct as such.

### 3.3 The Jensen route, the equality case (C4)

**Locate.** [bispectral.md](../findings/bispectral.md):87 and [lean/INDEX.md](../lean/INDEX.md) row [DoublyStochastic](../lean/HamiltonsCubic/Results/DoublyStochastic.lean): "*tightness in every row makes each row a point mass under strict convexity, so $U$ is a permutation, which is the shared frame*".

**Exhibit the failure.** Jensen equality for a strictly convex $f$ at weights $S_{i\cdot}$ over the points $\mu_j$ forces the weight to be concentrated on a set where $\mu$ is **constant**, not on a single index. Whenever $\mu$ has a repeated eigenvalue the conclusion "$U$ is a permutation" is false. Concretely, at $\mu_1=\mu_2$ take $S=\tfrac12\begin{pmatrix}1&1\\1&1\end{pmatrix}\oplus I_{N_1-2}$, realised by the Hadamard rotation of $U$ in the plane of the first two eigenvectors: $S$ is doubly stochastic, every row is tight in Jensen, and $U$ is not a permutation. Repeated $\Lambda^2$-eigenvalues are the rule and not the exception here: the record's own [Lemma L67](../results.md) gives the balanced sphere product a second-kind spectrum with three eigenvalues of multiplicities $(m-1)(m+2)$, $m^2$ and $1$, and its $\Lambda^2$ spectrum is likewise highly degenerate; [bispectral.md](../findings/bispectral.md):256 already records that "*a reimplementation that picked the wrong basis inside $K$'s degenerate eigenspaces fails to reproduce the identity*", so the record knows these degeneracies are live.

**Argue the opposite.** The most charitable reading is that "point mass" means a point mass on the *value*, and that "permutation" is shorthand for "permutation up to the eigenvalue-multiplicity blocks". Under that reading the intended conclusion survives intact, because on a multiplicity block $M$ is a scalar multiple of the identity and any rotation inside the block leaves $M$ diagonal. So the **conclusion** (both operators diagonal in the shared frame), is right; the **stated reason** is not.

**Verdict C4: BROKEN as written**, non-fatal. What a repair owes: replace "so $U$ is a permutation" by "so each row of $S$ is supported in one level set of $\mu$", and then conclude diagonality from $\sum K^2=\sum\mu^2$ rather than from the shape of $U$.

### 3.4 Which route the equality case actually needs

**Neither, in the end.** Both routes reach it, and the cheapest argument on file is neither: [bispectral.md](../findings/bispectral.md):305 and the L54 block at :477 obtain the same rigidity from equal sums *and equal norms* on both sides of the majorization at $t_F=2$, with no convexity at all, and [REVIEW_r479](../reviews/REVIEW_r479.md):51 states that explicitly, "*obtained without Karamata, without strict convexity, and without the support constants*". So the equality case is a corollary of [Lemma L54](../results.md) and [Lemma L94](../findings/bispectral.md), and L52's own contribution over L54 is the displayed inequality alone. The Jensen route is what the *bound* needs; the equality case needs only the norm identity.

### 3.5 C2, the equality case is stated without the datum it quantifies over

**Locate.** [results.md](../results.md):721 and [bispectral.md](../findings/bispectral.md):87: "*Writing $K$ for the sectional vector and $K'$ for the full $\mathring W$ diagonal*" … "*The bound is **exact if and only if both operators are diagonal in one shared frame***".

**Exhibit the failure.** A frame $F$ of $\mathbb R^n$ determines the $\binom n2$ vectors $\varphi_{ij}$, which span only part of $S^2_0$; the remaining $n-1$ dimensions require a further choice, an $O(n-1)$ of freedom, and "the full $\mathring W$ diagonal" is not a function of $F$. The record knows this, [bispectral.md](../findings/bispectral.md):65 says so verbatim, and the L54 block at :477 says the eigenbasis "*is load-bearing and NPW's own staircase $\psi_k$ will not serve … so a hollow nonzero $K$ is never diagonal in it*", but neither the L52 block nor [results.md](../results.md):721 carries the stipulation. Concretely, take any coordinate-diagonal unit $W$ in its own frame, say the Weyl tensor of $S^m\times S^m$. Its $\psi$-block is $-K$ restricted to $\mathbf1^\perp$; $K$ is hollow with $K\mathbf1=0$, so if $K\vert_{\mathbf1^\perp}$ were a scalar $\lambda I$ then $K=\lambda(I-\tfrac1n\mathbf1\mathbf1^{\mathsf T})$, whose diagonal $\lambda(1-\tfrac1n)$ must vanish by hollowness, forcing $\lambda=0$ and $K=0$, impossible for a unit tensor. So $K\vert_{\mathbf1^\perp}$ is never scalar, and there exist orthonormal bases of $\mathbf1^\perp$ that fail to diagonalise it. Choosing such $\psi$'s leaves $\sum_i(K'_i)^2<\sum_i\omega_i^2$, so $K'^\downarrow\ne\omega^\downarrow$, so the strictly convex Karamata step is **strict** and the bound is **not** exact, at a $W$ which is diagonal in a shared frame in every sense the sentence offers.

**Argue the opposite.** The charitable reading is that "the full $\mathring W$ diagonal" tacitly means the diagonal in the L54 basis, and that "both operators are diagonal" means diagonal in *that* basis, in which case the biconditional is exactly right. That reading is available to anyone who has read the L54 block. It is not available at [results.md](../results.md):721, where L52 is the citable statement and L54 sits seven lines below with its own hypotheses and its own frame.

**Verdict C2: GAP.** What would have to be added: "*fix also an orthonormal basis $\{\psi_k\}$ of the diagonal complement; the bound and its equality case are relative to $\{\varphi_{ij},\psi_k\}$, and $\sum d^2=\tfrac32t_F$ requires the $\psi_k$ to be an eigenbasis of $K$ on $\mathbf1^\perp$*".

**A candidate I withdraw.** I considered reading "*exact if and only if both operators are diagonal in one shared frame*" as an existential over frames (a property of $W$ rather than of the frame at hand), under which it would be plainly false, since a coordinate-diagonal $W$ read in a rotated frame has a strictly larger bound while remaining diagonalisable in *some* frame. **Withdrawn:** the sentence opens "In any orthonormal frame", so the universally quantified frame is in scope, and "one shared frame" most naturally emphasises *shared between the two operators* rather than *existing*. The reading that convicts is not the most charitable one the words support.

## 4. Question 2, does the headline follow from the bound?

**It does not, and the same page carries its refutation.**

**What the bound establishes.** For each frame, a valid upper bound on $\theta$ in terms of the shared diagonal $K$ and the two support constants, exact exactly on the coordinate-diagonal locus. That is a *coupling of the two spectra through a shared frame that works*. It is weaker than the headline in one sense (it is an inequality, not a structure theorem) and it is the **opposite** of the headline in the sense that matters: the headline denies that the coupling is useful, and the bound is the coupling.

**What else on the same page bears on it.** Three things, all of which I checked by hand rather than taking on the record's word.

1. **The boxed cap at [bispectral.md](../findings/bispectral.md):278 is itself a shared-frame coupling, and the file says it proves the estimate [target.md](../findings/target.md) leans on.** Its chain runs: the bottom eigenvector $h$ of $\mathring W$ is diagonal in *its own* eigenframe $F$, $h=\operatorname{diag}(v)$; there $\langle\mathring Wh,h\rangle=-v^{\mathsf T}K^Fv$; so $-\omega_{\min}\le\mu_1(K^F)\le\sqrt{t_F(n-2)/(n-1)}\le\sqrt{2(n-2)/(n-1)}$. The last quantity is exactly $n\theta_0(n)/(n-1)$: substituting $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ gives $n\theta_0(n)/(n-1)=\sqrt{2(n-1)(n-2)}/(n-1)=\sqrt{2(n-2)/(n-1)}$, **identically in $n$, with no parity condition**, an exact identity, verified here by squaring both sides, not by evaluation. That chain passes through $K^F$, the object L52 couples through, and it delivers the even half of the projection estimate. So the file uses a shared-frame coupling to prove a result it needs, under a heading saying shared-frame couplings are useless.
2. **The exactness at $t_F=2$ makes the coupling the sharpest bound available there**, since every valid upper bound is $\ge\theta$ and this one equals it.
3. **[Post F26](../findings/INDEX-traps.md), on the same page at [bispectral.md](../findings/bispectral.md):244**, already owns the negative: no bound exact at $t=2$ and monotone below it can close, and L52's bound is one (§6 below). So the negative half of L52 is an instance of a registered post, not a finding of its own.

**Verdict C5: BROKEN.** The headline is not a proposition the block proves; it is a route appraisal, it is contradicted by the same file, and it is carried verbatim and uncorrected at [results.md](../results.md):248 and :721, which is where a consumer reads.

### 4.1 C6, the operative clause, checked independently

**Locate.** [results.md](../results.md):248: "*The bound is an identity on the diagonal family and, off it, loses to a one-line estimate and to the moment relaxation it was built to improve*"; the same clause is in the block's "What it costs".

**Exhibit the failure.** Four steps, each hand-checked here.

- *The one-line bound $\theta\le\tfrac32(M_++m)$ is strictly loose at every unit Weyl tensor.* Its proof is termwise: $\mu_i\le M_+$ gives $\mu_i^3\le M_+\mu_i^2$ and $\omega_i\ge-m$ gives $-\omega_i^3\le m\omega_i^2$, so $\theta\le\tfrac32M_+p_2(\mu)+\tfrac12\cdot3m\,p_2(\omega)/3=\tfrac32M_++\tfrac32m$. Equality needs $\mu_i^3=M_+\mu_i^2$ for every $i$, i.e. $\mu_i\in\{0,M_+\}$, whence $\mu_i^2=M_+\mu_i$ termwise and $1=p_2(\mu)=M_+\sum_i\mu_i=0$, a contradiction with no case split.
- *The coupling is exact at $t_F=2$*, by §3 and [Lemma L94](../findings/bispectral.md).
- *Both are continuous in $W$ at a fixed frame.* $K^F$ is linear in $W$; the $\psi$-block contribution $\sum_kf(d_{\psi_k})$ equals $\sum f$ over the eigenvalues of $-K^F\vert_{\mathbf1^\perp}$ and so is continuous even where the eigenbasis jumps; $M_+=\max\mu$ and $m=-\min\omega$ are continuous; $\theta$ is polynomial.
- *The diagonal locus has empty interior.* It has dimension $\tfrac{n(n-1)}2+\tfrac{n(n-3)}2=n(n-2)$ (the frame orbit plus the hollow zero-row-sum matrices), against $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$, which is strictly larger already at $n=4$ ($8<10$) and at $n=5$ ($15<35$).

So at a coordinate-diagonal $W_0$ the coupling equals $\theta(W_0)$ while the one-line bound strictly exceeds it, and by continuity the coupling strictly beats the one-line bound on a whole neighbourhood, which contains non-diagonal tensors. The clause is false there.

**Argue the opposite.** The charitable reading is "at the points the record evaluated", padded $W_{\mathbb{CP}^2}$ and its random samples, all of which the record places at $t_F=1$ and below. As a report of those measurements the clause is accurate. As the universal it is written as, at [results.md](../results.md):248 with no qualification, it is false. **Verdict C6: BROKEN.**

## 5. Question 3, is the second display derived or screened?

$$\theta\ \le\ (t_F/2)^{3/2}\,\Theta_n+\tfrac92(M_++m)\big(1-t_F/2\big).$$

**Where its argument is.** Not in the L52 block, and not in [results.md](../results.md) at all: [bispectral.md](../findings/bispectral.md):78 and [LEDGER.md](../findings/LEDGER.md):332 both present it with the single support "*screened against this record's own six digits, $\tfrac92(1.632993)(0.5)=3.674235$*". The derivation exists in [REVIEW_r480](../reviews/REVIEW_r480.md):32–46, which the record cites for the audit; I read it before recording anything about what is on file. It has two halves, and I checked both by hand.

**Half one, the penalty collapse (C8), exact.** [Lemma L54](../results.md) gives $\sum d_\varphi^2=t_F/2$ and $\sum d^2=\tfrac32t_F$. With $p_2(\mu)=1$ and $p_2(\omega)=3$,
$$\lVert M_{\mathrm{off}}\rVert_F^2=1-\tfrac{t_F}2,\qquad \lVert\mathring W_{\mathrm{off}}\rVert_F^2=3-\tfrac32t_F=3\Big(1-\tfrac{t_F}2\Big),$$
so the two off-diagonal masses are locked at a ratio of $3$, and the block's own penalty sum becomes
$$\tfrac92M_+\Big(1-\tfrac{t_F}2\Big)+\tfrac32m\cdot3\Big(1-\tfrac{t_F}2\Big)=\tfrac92(M_++m)\Big(1-\tfrac{t_F}2\Big).$$
**The coefficient $\tfrac92$ is right**, and the collapse is algebra, not agreement. It carries one inherited hypothesis, which the display does not state: $\sum d^2=\tfrac32t_F$ holds only with the $\psi_k$ taken as $K$'s eigenvectors on $\mathbf1^\perp$; in any other basis it is a strict inequality and the coefficient is an over-estimate of the second penalty. This is C2's defect propagating into the second display.

**Half two, the first term.** $\theta_{\mathrm{diag}}(K^F):=\tfrac32p_3(K)-\tfrac12p_3(K')$ is homogeneous of degree $3$ in $K^F$, so $\theta_{\mathrm{diag}}(K^F)=(t_F/2)^{3/2}\theta_{\mathrm{diag}}(\widehat K)$ with $\widehat K=K^F/\sqrt{t_F/2}$ hollow, symmetric, $\widehat K\mathbf1=0$ and $\lVert\widehat K\rVert_F^2=2$, the vertex matrix of a unit coordinate-diagonal Weyl tensor, whence $\theta_{\mathrm{diag}}(\widehat K)\le\Theta_n$ by the diagonal maximum. **This step is [Lemma L57](../results.md) and nothing in the L52 material names it**; the display therefore imports the whole diagonal case, at $n\ge4$ and both parities, without saying so. Its one range edge: at $t_F=0$, which the record says is attained, "*minimising properly gives $\min_F\lVert K(F)\rVert_F=0$ … for every tensor tested*" ([bispectral.md](../findings/bispectral.md):224), the rescaling divides by zero, though the inequality survives because $\theta_{\mathrm{diag}}=0$ there.

**The screen, evaluated exactly.** The record's padded-$W_{\mathbb{CP}^2}$ column closes exactly, in units of $\sqrt6/8=0.30618622$, given its two measurements $t_F=1$ and $M_++m=\sqrt{8/3}=\tfrac23\sqrt6$:

| quantity | exact value | the record's digits |
|---|---|---|
| $\theta=\sqrt{3/2}$ | $4\sqrt6/8$ | $1.224745$ |
| $\theta_{\mathrm{diag}}=(1/2)^{3/2}\cdot\tfrac{\sqrt3}2$ | $\sqrt6/8$ | $0.306186$ |
| penalty $\tfrac92(M_++m)(1/2)=\tfrac94\cdot\tfrac23\sqrt6$ | $12\sqrt6/8=\sqrt{27/2}$ | $3.674235$ |
| true slack $27/(4\sqrt6)$ | $9\sqrt6/8$ | $2.755676$ |
| bound | $13\sqrt6/8$ | $3.980421$ |

Every relation the record asserts about this column holds as an identity: $4+9=13$ (slack plus value is the bound), $1+12=13$ (surrogate plus penalty is the bound), and $12-9=3=2\times1.5$, the record's "*two dropped terms contributing $-0.459279$ each*" being $\tfrac32\sqrt6/8$ each. So the six-digit agreement the record offers as the display's support is a *consequence* of an identity, not evidence for one, but a reader of [bispectral.md](../findings/bispectral.md):78 or [LEDGER.md](../findings/LEDGER.md):332 is shown only the agreement.

**Verdict C7: PROVEN, derived, not screened**, with the derivation living in a cited review rather than in the record, and with two unstated imports ($\psi$-eigenbasis, [Lemma L57](../results.md)).

## 6. C9, "a reduction of Conjecture A to a lower bound on $t_F$"

**Locate.** [bispectral.md](../findings/bispectral.md):79 and [LEDGER.md](../findings/LEDGER.md):332: "*So L52 is a reduction of Conjecture A to a lower bound on the frame-optimised diagonal mass $t_F$*", with the LEDGER recording "**Owed:** *state the reduction as the result*".

**Exhibit the failure.** Write $s=t_F/2\in[0,1]$, $C=\tfrac92(M_++m)$, $B(s)=s^{3/2}\Theta_n+C(1-s)$. Two exact facts:

- $C\ge3\theta$, because the one-line bound gives $\theta\le\tfrac32(M_++m)=\tfrac13C$.
- $B'(s)=\tfrac32\Theta_n\sqrt s-C\le\tfrac32\Theta_n-C$ on $[0,1]$.

So whenever $\theta>\Theta_n/2$ we have $C\ge3\theta>\tfrac32\Theta_n$, hence $B'<0$ throughout $[0,1]$, hence $B(s)>B(1)=\Theta_n$ for **every** $s<1$. The display therefore certifies $\theta\le\Theta_n$ at such a $W$ only at $t_F=2$ exactly, and $t_F=2$ is coordinate-diagonality ([Lemma L94](../findings/bispectral.md)), where [Lemma L57](../results.md) already gives the conclusion. The class $\theta>\Theta_n/2$ contains every counterexample candidate and every near-maximiser, which is the entire population Conjecture A is about.

**Argue the opposite.** The charitable reading is that "a lower bound on $t_F$" means "a lower bound, whose necessary value is $2$", a reduction in the logical sense, which it is. That reading is available, and it is exactly what [post F26](../findings/INDEX-traps.md) says two paragraphs later: "*no bound exact at $t=2$ and monotone below it can close*", the monotonicity being the $B'<0$ just computed. So the record holds the positive framing and the computation that empties it within four lines of each other, and the LEDGER's "Owed" would move the emptier of the two into the canon.

**Verdict C9: GAP.** What a consumer may cite is the display; what they may **not** cite is that it reduces Conjecture A to any threshold below $t_F=2$.

**C11, in the same breath.** [bispectral.md](../findings/bispectral.md):75 states "*The true statement is quantitative: the coupling loses exactly when $t_F<\tfrac43$*". The record's own decomposition, which I re-derive here, is
$$\text{coupling}-\tfrac32(M_++m)=\theta_{\mathrm{diag}}+\tfrac32(M_++m)\big(2-\tfrac32t_F\big),$$
obtained by writing $\tfrac92(M_++m)(1-\tfrac{t_F}2)-\tfrac32(M_++m)=\tfrac32(M_++m)[3(1-\tfrac{t_F}2)-1]$. The sign of the left side depends on **two** quantities, $t_F$ and $\theta_{\mathrm{diag}}$, and $\theta_{\mathrm{diag}}$ is the $\theta$ of a diagonal Weyl tensor and so takes both signs. "$t_F>\tfrac43$" is therefore necessary only when $\theta_{\mathrm{diag}}\ge0$, and it is never sufficient: at padded $W_{\mathbb{CP}^2}$'s own recorded numbers the break-even is $\tfrac32t_F-2=\theta_{\mathrm{diag}}/\big(\tfrac32(M_++m)\big)=\tfrac{\sqrt6/8}{12\sqrt6/8\cdot\frac13}=\tfrac18$, i.e. $t_F=\tfrac{17}{12}$, not $\tfrac43$. **Verdict C11: GAP**, "exactly when" is a one-variable reading of a two-variable criterion, and the charitable reading ("with $\theta_{\mathrm{diag}}$ neglected") is not the one the words give.

## 7. Comparing the forms, and the Lean row

| Form | Carries | Omits |
|---|---|---|
| [bispectral.md](../findings/bispectral.md):87–90, the canonical block | statement, display, Karamata equality case, the "Karamata is not needed" Jensen route, the Lean citations, "What it costs" | $W\in\mathrm{Weyl}_n$; $\lVert M\rVert_F=1$; $n\ge4$; the $\psi$-basis; the strict **concavity** the $\mu$ half of the equality case needs |
| [results.md](../results.md):721, the canonical form | statement, display, Karamata equality case | everything the block omits, **plus** the Jensen correction and the audit box, so a consumer here still reads Karamata as load-bearing |
| [results.md](../results.md):248, the glance line | the refuted headline; "Schur–Horn plus support bounds"; the refuted operative clause | the bound itself; and it retains "Schur–**Horn**" where Reviewer 290's correction (only Schur's half is used), is already folded into the block |

**Lean.** [lean/INDEX.md](../lean/INDEX.md)'s L52 row is **partial** and formalises three of the *audit's* counts, the cap identity $(n\theta_0(n)/(n-1))^2=2(n-2)/(n-1)$, the strict-looseness of the one-line bound, the dimension count, together with the penalty bracket $(9/2)^2(8/3)\cdot\tfrac14=27/2$, which I confirm exactly: $\tfrac{81}4\cdot\tfrac83\cdot\tfrac14=\tfrac{54}4=13.5$, and $\sqrt{13.5}=3.6742346$, the record's $3.674235$. **No Lean row asserts the displayed inequality or its equality case.** A row that did would have to claim, with no geometry in it: *for real vectors with $K\prec\mu$, $K'\prec\omega$, $\mu_i\le M_+$, $\omega_i\ge-m$, $p_2(\mu)=1$ and $p_2(\omega)=3$, the display holds, with equality iff $K^\downarrow=\mu^\downarrow$ and $K'^\downarrow=\omega^\downarrow$*, the analytic content already sitting in [CubicConvexity.lean](../lean/HamiltonsCubic/Results/CubicConvexity.lean) and [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean), with Schur's theorem the one remaining import.

## 8. The gap between what is proven and what is used, and what a consumer may cite

**May be cited.** In a fixed orthonormal frame $F$ of $\mathbb R^n$ and a fixed orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$, for $W\in\mathrm{Weyl}_n$ with $n\ge4$ and $\lVert M\rVert_F=1$, and for any constants with $\mu_i\le M_+$ and $\omega_i\ge-m$: the displayed inequality, and its exactness precisely when $M$ and $\mathring W$ are both diagonal in that basis. Taking the $\psi_k$ to be an eigenbasis of $K^F$ on $\mathbf1^\perp$, also the one-parameter form $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$, which additionally imports [Lemma L57](../results.md).

**May not be cited.** That the two spectra do not couple usefully through a shared frame; that the bound loses to the one-line estimate off the diagonal family; that a lower bound on $t_F$ short of $2$ would close Conjecture A; that the coupling loses exactly when $t_F<\tfrac43$; and (for any purpose where the constants must be supplied by an argument), the numbers $3.9804$ and $5.5901$, which the block itself labels as read off the true spectra or as the honest cost.

**The named trap, each claim read alone as a consumer would.** [results.md](../results.md):248 read alone gives a reader a false universal (C6), a refuted headline (C5) and a superseded attribution (Schur–Horn). [results.md](../results.md):721 read alone gives a display whose constants $1$ and $3$ are unexplained (C10), an equality case quantified over a datum the entry never introduces (C2), and Karamata as the load-bearing import when the block has replaced it. The correction to every one of these is in [bispectral.md](../findings/bispectral.md), the audit box sits directly *above* the block whose statement it corrects, and the block below it repeats the uncorrected wording, so the file that a citation resolves to reproduces the defect it was written to fix. **Verdict C10: BROKEN as a citable statement.**

## 9. What would falsify this report, and what I did to look for it

- **Against C1.** A unit $W\in\mathrm{Weyl}_n$, a frame, and admissible $M_+,m$ with the display's right side strictly below $\theta$. It would have to break Schur's theorem or the direction of one convexity claim. I checked both second derivatives, both domains, that both diagonals lie inside their domains (via the Rayleigh-quotient bound, not via majorization), both attained endpoints, and the sign each display enters $\theta$ with. Found none.
- **Against C2.** I looked for the opposite object (a proof that "the full $\mathring W$ diagonal" is determined by the frame) and found the record asserting the reverse at [bispectral.md](../findings/bispectral.md):65 and :477. The falsifier I exhibit is any coordinate-diagonal unit $W$ with $\psi$'s not diagonalising $K\vert_{\mathbf1^\perp}$, and I show such $\psi$'s always exist by proving $K\vert_{\mathbf1^\perp}$ is never scalar for $K\ne0$ hollow with zero row sums.
- **Against C4.** A proof that $\mu$ is always simple would kill it. $\mu$ has $\binom n2$ entries summing to zero and the record's own [Lemma L67](../results.md) exhibits multiplicities $(m-1)(m+2)$ and $m^2$ on the second-kind side at the sphere product, so simplicity is not available.
- **Against C9.** A $W$ with $\theta\le\Theta_n/2$ and $t_F<2$ at which the display still returns $\le\Theta_n$, such $W$ exist and are exactly where the "reduction" reading keeps content, which is why the finding is a GAP in the claim's scope rather than a refutation of the display.
- **What I did not do.** No computation of any kind. Every figure above is an exact evaluation of a closed form; the two inputs $t_F=1$ and $M_++m=\sqrt{8/3}$ at padded $W_{\mathbb{CP}^2}$ are the record's measurements, used only to check that the record's own column is internally consistent, never as evidence for a claim.

## Verdict

**GAP.** The displayed inequality is correct once $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$ and $n\ge4$ are restored; the Jensen route genuinely removes Karamata from it; the equality case is correct once the $\psi$-basis is stipulated and once "point mass" is read up to eigenvalue multiplicity; and the second display is derived rather than screened, in a review the record cites. What fails is the statement a consumer meets: the headline at [results.md](../results.md):248 and :721 is refuted by its own file, the operative clause is false on a neighbourhood, the normalisation carrying the display's constants is stated nowhere in the canonical entry, and the reduction to "a lower bound on $t_F$" admits only the bound $t_F=2$.
