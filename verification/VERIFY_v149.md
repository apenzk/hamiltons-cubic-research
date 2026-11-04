# VERIFY v149, Lemma L29: the signature-$(1,2)$ cap $\theta\le\sqrt{3/2}$, its dimension-freeness, its attaining object, and the three vanishing sign-blocks

**Cold brief, no numerical work.** Every value below is an exact hand evaluation; no script was run and no figure is taken from the record on trust. Log: [agent_logs/verify-L29-v149.log](../agent_logs/verify-L29-v149.log). Sources read in full: [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [findings/conventions.md](../findings/conventions.md), [results.md](../results.md):144 and :439–441 and :784, [lean/INDEX.md](../lean/INDEX.md):104, [findings/INDEX-traps.md](../findings/INDEX-traps.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/LEDGER.md](../findings/LEDGER.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/bounds-relaxations.md](../findings/bounds-relaxations.md), [findings/isotropy-cap.md](../findings/isotropy-cap.md), [ATTEMPTS.md](../ATTEMPTS.md).

## Claim table

| # | claim, as a consumer would read it alone | verdict |
|---|---|---|
| C1 | $W\in\mathrm{Weyl}_n$, $\lVert W\rVert=1$, exactly one positive and two negative eigenvalues $\Rightarrow\theta(W)\le\sqrt{3/2}$ | **PROVEN** |
| C2 | The bound carries no dimension restriction | **PROVEN** |
| C3 | The cap is attained, at spectrum $(2,-1,-1)/\sqrt6$ = padded $W_{\mathbb{CP}^2}$, at every $n\ge4$ | **PROVEN** |
| C4 | Three sign-blocks of the cubic "vanish structurally" | **PROVEN, under the hypothesis the statement carries**, not identically |
| C5 | "The single inequality is an identity on this stratum" | **PROVEN**, with one imported step ($r=4$) unflagged in the paragraph that uses it |
| C6 | The converse: equality forces the spectrum $(2,-1,-1)/\sqrt6$ | **PROVEN, and by a shorter route than any of the three the record names** |
| C7 | [results.md](../results.md):441 and :784, "the converse is Lemma L72" | **BROKEN**; refuted verbatim by the source block the same line points at |
| C8 | "Since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, no maximiser in that dimension range has this spectrum" | **GAP at odd $n$**, wrong constant, repairable, true for odd $n\ge13$ |
| C9 | The extension to $k=2$: "maximising the resulting bound over the whole two-parameter family returns $\sqrt{3/2}$" | **HYPOTHESIS-DEBT**, the two-parameter maximisation is asserted with no argument on file |
| C10 | The "Needed because" motivation, that the slack $S(W)$ vanishes on this stratum and padded $W_{\mathbb{CP}^2}$ lies in it | **GAP**, true but inert; trap [W4](../findings/INDEX-traps.md) voids the screen at exactly this object |

**Verdict: `GAP`.** The theorem is right, and I re-derived it end to end by three disjoint routes. What fails is the citable surround: one clause of the canonical statement in [results.md](../results.md) attributes the converse to a lemma the source file explicitly withdrew the credit from, an exclusion clause runs on $\theta_0(n)$ where the record's own conventions say the attained value is $\Theta_n$, and one advertised extension has no derivation anywhere on the record.

## 0. Conventions, fixed once

Taken from [findings/conventions.md](../findings/conventions.md) and quoted, never restated from memory.

- $N=\binom n2=\dim\Lambda^2\mathbb R^n$. $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl curvature operators on $\mathbb R^n$; $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$, so it is the zero space at $n\le3$ and the smallest admissible dimension with content is $n=4$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$. So $P(W)=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ and at $\lVert W\rVert=1$, $\theta=P(W)$.
- $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$.
- Inner product: $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$ at the $\Lambda^2$ level, so $\lVert\varphi_{ab}\rVert^2=1$ for $\varphi_{ab}=E_{ab}-E_{ba}$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal.
- $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ is **totally antisymmetric**, so $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is totally symmetric and **vanishes whenever two indices coincide**. This hollowness is the whole of the sign-block argument.
- Pair cap: $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ for orthonormal $v_\alpha,v_\beta$, which is [Lemma L31](../findings/stratum-two-negative.md). Row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs is [Lemma L153](../findings/bounds.md), **the one dimension-carrying input in the neighbourhood, and L29 never touches it.**
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$, **and nothing more**; $\Theta_n$ is the diagonal maximum, equal to $\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, where it is strictly smaller. The conventions file marks the gloss "$\theta_0(n)$ is the value at the balanced sphere product" as the error that regrew [L0](../findings/problem.md)'s refuted constant. **Section 7 below turns on this line.**
- Padding commutes with $Q$ and preserves both $\lVert\cdot\rVert$ and $\theta$.

## 1. The hypothesis inventory

### 1a. What the block carries

| # | hypothesis, as written | where it is used in the written proof |
|---|---|---|
| H1 | $W\in\mathrm{Weyl}_n$, symmetric on $\Lambda^2$, first Bianchi, Ricci-flat | only through **trace-freeness** ($\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$, so $\mathop{\mathrm{tr}}W=0$) and through the **spectral theorem** giving an orthonormal eigenbasis of $\Lambda^2$. **First Bianchi is never used** |
| H2 | $\lVert W\rVert=1$ | the normalisation $2(a^2+ab+b^2)=1$, and the identification $\theta=P(W)$ |
| H3 | exactly one positive and exactly two negative eigenvalues, **counted with multiplicity** | the three vanishing sign-blocks, and nothing else |
| H4 | the ordering $\lambda_1>0>-a\ge-b$ | nothing. The chain is maximised over all $t=b/a\ge0$, and §5 shows it holds at every real $t$ |

**H3's multiplicity reading is load-bearing and the block does not say so.** Under the other reading of "exactly one positive eigenvalue" (one *distinct* positive value at any multiplicity), the $(+++)$ and $(++-)$ blocks do not vanish and the proof collapses at its first step. This is the identical ambiguity that [Lemma L33](../findings/stratum-two-negative.md), forty lines below in the same file, was repaired for on 2026-09-06, with the note *"it is quoted in [results.md](../results.md) and in the report, where that convention does not travel."* L29's display $\lambda_1>0>-a\ge-b$ names three eigenvalues and so fixes the reading by exhibition ($-a\ge-b$ permits $a=b$, which is a negative eigenvalue of multiplicity two) so the statement is *not* ambiguous. **No finding: the reading is pinned by the display, and it survives the trip to [results.md](../results.md):441 because the display travels with it.**

**First Bianchi being unused makes the theorem stronger than the statement.** [Lemma L35](../findings/stratum-two-negative.md)'s block records this of its own chain (*"it holds for any trace-free symmetric operator on $\Lambda^2$ with the stated sign pattern"*) and L29's chain has the same property for the same reason. L29's block claims nothing about it. That is an understatement, not a defect.

### 1b. What it imports, each checked against the object it applies to

| import | its hypothesis | checked against |
|---|---|---|
| the pair cap, [L31](../findings/stratum-two-negative.md) | $X,Y\in\mathfrak{so}(n)$ **orthonormal** | $v_{N-1},v_N$ are orthonormal eigenvectors of a symmetric operator, distinct eigenvalues or not. **Holds.** Its root-system proof needs two angles, hence $n\ge4$, which is every $n$ where $\mathcal W_n\ne0$ |
| $T$ hollow and totally symmetric | ad-invariance of $\langle\cdot,\cdot\rangle$ on $\mathfrak{so}(n)$ | a convention, [conventions.md](../findings/conventions.md). **Holds unconditionally** |
| $\langle W,W^\#\rangle=\tfrac12\sum T\lambda\lambda\lambda$ | $W$ symmetric on $\Lambda^2$ with an orthonormal eigenbasis | derived in §2 below from the record's own $\#$ convention in two lines. Independently on record at [bounds-relaxations.md](../findings/bounds-relaxations.md):118, which adds that it *"holds off $\mathrm{Weyl}_n$, free of Bianchi and Ricci-flatness"*. **Holds** |
| $\mathop{\mathrm{tr}}W=0$ | $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ on $\Lambda^2$ and Ricci-flatness | **Holds** |
| [L33](../findings/stratum-two-negative.md), cited as "a second route" to the converse | a **one-dimensional** eigenspace on one side, and the eigenvector not a $4$-plane complex structure | H3 gives the one-dimensional positive eigenspace. At the attaining object $v_1$ **is** a $4$-plane complex structure, so L33 lands in its exception and returns $r=4$ rather than $W=0$. L33 in turn imports [L32](../findings/isotropy-cap.md), whose repaired hypothesis $\mathfrak c\ne0$ needs $n\ge4$. **Holds, with the exception clause doing the work** |
| [L30](../findings/stratum-two-negative.md), the padding descent | $\dim U<n$ | **fails at $n=4$**, where $\dim U=4=n$. L29's bound does not use L30, so nothing breaks; but any consumer chaining L29 through L30 must not do so at $n=4$ |
| [L35](../findings/stratum-two-negative.md), named as covering $k\ge3$ | at most two negative eigenvalues, any $m$ | **Holds.** Not circular: [LEDGER.md](../findings/LEDGER.md):1403 records that L35's proof *consumes* L29 for $k\le2$, and the packing argument covering $k\ge3$ does not. Worth stating, since the block cites L35 for coverage without saying the dependence runs the other way for $k\le2$ |

## 2. The cap, derived (pre-registered question 1, first half)

**Step 1, the cubic in an eigenbasis.** Write $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ over an orthonormal eigenbasis $\{v_\alpha\}_{\alpha=1}^N$ of $\Lambda^2$. By the record's $\#$,
$$W^\#=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,(v_\alpha v_\alpha^{\mathsf T})\#(v_\beta v_\beta^{\mathsf T})=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,[v_\alpha,v_\beta][v_\alpha,v_\beta]^{\mathsf T},$$
so pairing against $W$ and expanding $[v_\alpha,v_\beta]$ in the same basis,
$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\,\langle v_\gamma,[v_\alpha,v_\beta]\rangle^2=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma .$$
The block's display is right, and the sum is over **ordered** triples, the record's default. Since $T$ is hollow, only distinct triples survive and $\tfrac12\sum_{\text{ordered}}=3\sum_{\alpha<\beta<\gamma}$, which is [Lemma L35](../findings/stratum-two-negative.md)'s coefficient $3$, so the two blocks' bookkeeping agrees.

**Step 2, only $(+--)$ survives.** §3 below. The surviving block is the six orderings of $\{1,N-1,N\}$, each contributing $T_{1,N-1,N}\lambda_1(-a)(-b)$, so $\tfrac12\cdot6\cdot T_{1,N-1,N}\lambda_1ab=3T_{1,N-1,N}\lambda_1ab$. **The block's coefficient $3$ is right.**

**Step 3, the pair cap.** $T_{1,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2\le2$, the other summands being squares. So $\langle W,W^\#\rangle\le6\lambda_1ab$, against $\mathop{\mathrm{tr}}W^3=\lambda_1^3-(a^3+b^3)$ exactly, the remaining $N-3$ eigenvalues being zero.

**Step 4, collapse.** Trace-freeness gives $\lambda_1=a+b$, so $\lambda_1^3-(a^3+b^3)=3ab(a+b)$ and
$$P(W)\ \le\ 3ab(a+b)+6ab(a+b)=9ab(a+b).$$
Unit norm gives $(a+b)^2+a^2+b^2=2(a^2+ab+b^2)=1$. With $t=b/a$ this is $a^2(t^2+t+1)=\tfrac12$, so $a=\big(2(t^2+t+1)\big)^{-1/2}$ and
$$9ab(a+b)=9a^3t(t+1)=\frac{9\,t(t+1)}{2^{3/2}(t^2+t+1)^{3/2}}=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}}=f(t).$$
**Exactly the block's $f$.**

**Step 5, the maximum, by an identity rather than by calculus.** Square and clear:
$$\tfrac32-f(t)^2=\frac{48(t^2+t+1)^3-324\,t^2(t+1)^2}{32(t^2+t+1)^3}=\frac{3\big[4(t^2+t+1)^3-27t^2(t+1)^2\big]}{8(t^2+t+1)^3}.$$
Put $u=t^2+t$. The bracket is $4(u+1)^3-27u^2=4u^3-15u^2+12u+4$, and $\big((t-1)(t+2)(2t+1)\big)^2=(u-2)^2(4u+1)=4u^3-15u^2+12u+4$. **They are equal**, so
$$\tfrac32-f(t)^2=\frac{3\big((t-1)(t+2)(2t+1)\big)^2}{8(t^2+t+1)^3}\ \ge\ 0\quad\text{for every real }t,$$
$t^2+t+1>0$ always. Equality exactly at $t\in\{1,-2,-\tfrac12\}$, hence on $t\ge0$ exactly at $t=1$, i.e. $a=b$. **The cap and its equality case fall out of one factorisation; the block's stationary-point argument is correct but weaker than what is true.** The block's own calculus also checks: $(\log f)'=\frac{2t+1}{t(t+1)}-\frac{3(2t+1)}{2(t^2+t+1)}$, which on $t>0$ vanishes iff $2(t^2+t+1)=3(t^2+t)$, iff $t^2+t-2=0$, iff $t=1$. And $f(1)^2=\frac{162\cdot4}{16\cdot27}=\tfrac32$, $f(0)=0$, $f(t)\sim 9\sqrt2/(4t)\to0$.

This identity is [lean/INDEX.md](../lean/INDEX.md):104's contribution, marked **partial** there, and I reproduced it independently above before reading that row.

**C1: PROVEN.** **C6: PROVEN**, equality forces $t=1$, hence $a=b$, hence $\lambda_1=2a$ and $6a^2=1$, hence the spectrum is $(2,-1,-1)/\sqrt6$. See §8 for why this matters.

## 3. The three vanishing sign-blocks (pre-registered question 3)

The eigenvalues are $\lambda_1>0$, $-a,-b<0$ at indices $N-1,N$, and $N-3$ zeros. Terms carrying a zero index vanish, so every live index lies in $\{1,N-1,N\}$.

| block | what the block says | what it needs | verdict |
|---|---|---|---|
| $(+++)$ | *"needs three distinct positive indices while only one exists and $T$ vanishes on repeated indices"* | all three indices must be $1$; $T_{111}=0$ by hollowness | **correct**, and it needs H3's "exactly one positive **with multiplicity**" |
| $(++-)$ | same sentence | two indices equal to $1$; $T_{11\gamma}=0$ by hollowness | **correct**, same hypothesis |
| $(---)$ | *"needs three indices in a $2$-dimensional space, where a form antisymmetric in three indices is identically zero"* | $c$ restricted to $\mathrm{span}\{v_{N-1},v_N\}$ is an alternating $3$-form on a $2$-space | **correct**, and it needs H3's "exactly **two** negative" |

**"Structurally" means: identically, under the sign-count hypothesis the statement carries.** None of the three is an unconditional identity, and none is a numerical observation. Both readings the pre-registered question offers are half right, so I state the answer positively: each block vanishes as an algebraic identity once H3 is in force, with no further input, and each fails the moment H3 is relaxed by one eigenvalue.

**One redundancy worth recording.** The $(---)$ argument as given is a different argument from the other two, antisymmetry of $c$ on a subspace rather than hollowness of $T$ on repeated indices. Both are correct, and the second is the special case of the first at a fixed basis: with only $v_{N-1},v_N$ available, any triple repeats an index and hollowness alone kills it. So all three blocks vanish for the single reason *$T$ is hollow and there are fewer than three indices of the required sign*. **No finding: the block's two reasons are both sound; giving the third block its own reason costs nothing.**

**Basis-independence at $a=b$.** When the negative eigenvalue is repeated, $v_{N-1},v_N$ is only defined up to $SO(2)$. Under $v_2'=\cos\phi\,v_2+\sin\phi\,v_3$, $v_3'=-\sin\phi\,v_2+\cos\phi\,v_3$ we get $[v_2',v_3']=(\cos^2\phi+\sin^2\phi)[v_2,v_3]=[v_2,v_3]$, so $T_{1,N-1,N}$ is unchanged and the surviving block is well defined. **No finding: eigenvalue multiplicity two does not disturb the proof**, and it is the multiplicity the attaining object has.

**C4: PROVEN, under the hypothesis the statement carries.**

## 4. Dimension-freeness (pre-registered question 1, second half)

**Where $n$ could have entered, and did not.**

1. **The eigenbasis sum** runs over $N=\binom n2$ indices, which is where $n$ lives. It leaves because H3 makes $N-3$ of the eigenvalues zero and $T$ multiplies each term by an eigenvalue at every slot. **The only $n$-dependence in the identity is a summation range over vanishing terms.**
2. **The pair cap.** This is the step that *could* have carried $n$ and is the one to watch. [L31](../findings/stratum-two-negative.md) proves $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ from the roots of $\mathfrak{so}(n)$, then $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2$ by Cauchy–Schwarz on **two** angles. The number of angles is $\lfloor n/2\rfloor$ and the bound uses only that there are at least two of them and that they sum in square to $1$. **Adding angles cannot help, because they only take budget away from $s_1,s_2$.**
3. **The step that would have brought $n$ in, and which L29 declines to use.** The companion constraint on $T$ is the row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$, [Lemma L153](../findings/bounds.md), which is explicitly dimension-carrying. L29 uses the **pair** cap and never the marginal. This is the same structural point [L35](../findings/stratum-two-negative.md) makes of its own chain when it says the packing $G$ is *"free of $m$ and of $\binom m2$"*. **This is the honest answer to "at which step could the dimension have entered": at the marginal, and L29's chain does not contain that step.**
4. **Trace-freeness and unit norm** are conditions on three numbers. No $n$.

**At the smallest admissible $n$.** $\mathcal W_n=0$ for $n\le3$, so $n=4$ is the smallest with content, and there the statement is not merely true but exactly computable with no inequality at all. [findings/fence-posts.md](../findings/fence-posts.md):45 and [findings/nondegeneracy.md](../findings/nondegeneracy.md):363 give $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$. A nonzero trace-free symmetric $3\times3$ operator has at least one positive and one negative eigenvalue, so **H3 forces one chirality to vanish**; taking $W^-=0$ and $W^+$ with spectrum $(a+b,-a,-b)$ gives $\det W^+=ab(a+b)$ and $P=9ab(a+b)$ **exactly**, the same expression Step 4 above reached as an upper bound. Maximising under $2(a^2+ab+b^2)=1$ gives $\sqrt{3/2}$ at $a=b=1/\sqrt6$. **The cap is exact at $n=4$ by a route that shares no step with the block's chain.**

**At a large $n$.** Padding preserves $\lVert\cdot\rVert$ and $\theta$, so padded $W_{\mathbb{CP}^2}$ sits in $\mathcal W_{12}$ at $\theta=\sqrt{3/2}$ and the cap is attained there too; and the chain's four steps are verbatim the same, only the number of zero eigenvalues changing from $3$ to $63$. **C2: PROVEN, C3: PROVEN.**

## 5. The attaining object (pre-registered question 2)

Take $\mathbb R^4\subseteq\mathbb R^n$ and the standard orthonormal basis of $\Lambda^+$,
$$w_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\qquad w_2=\tfrac1{\sqrt2}(\varphi_{13}+\varphi_{42}),\qquad w_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}),$$
with $\varphi_{ab}=E_{ab}-E_{ba}$ and $\lVert\varphi_{ab}\rVert^2=1$ under the record's half-trace pairing, so each $\lVert w_i\rVert^2=\tfrac12(1+1)=1$. Set $W=\tfrac1{\sqrt6}\big(2\,w_1w_1^{\mathsf T}-w_2w_2^{\mathsf T}-w_3w_3^{\mathsf T}\big)$, zero on $\Lambda^-$, padded by zero into $\Lambda^2\mathbb R^n$.

**(i) It lies in $\mathcal W_n$.** $S^2_0(\Lambda^+)\subset\mathrm{Weyl}_4$ ([stratum-two-negative.md](../findings/stratum-two-negative.md):31, $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$), and padding preserves symmetry, first Bianchi and Ricci-flatness, each being linear ([lean/INDEX.md](../lean/INDEX.md) row L34). **Holds.**

**(ii) Exactly one positive and two negative eigenvalues.** Spectrum on $\Lambda^2\mathbb R^n$ is $\tfrac1{\sqrt6}(2,-1,-1)$ together with $N-3$ zeros. One positive with multiplicity one, two negative (one value at multiplicity two). **Holds, and it sits at the equality case $a=b$ of §2.**

**(iii) Unit norm.** $\lVert W\rVert^2=\tfrac16(4+1+1)=1$. **Holds.**

**(iv) Its $\theta$ is $\sqrt{3/2}$, by hand.** I compute the one live structure constant. Using $E_{ij}E_{kl}=\delta_{jk}E_{il}$, $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ for distinct $a,b,c$. Then
$$[w_1,w_2]=\tfrac12\big([\varphi_{12},\varphi_{13}]+[\varphi_{12},\varphi_{42}]+[\varphi_{34},\varphi_{13}]+[\varphi_{34},\varphi_{42}]\big)=\tfrac12\big(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23}\big)=-(\varphi_{14}+\varphi_{23})=-\sqrt2\,w_3 .$$
So $\lVert[w_1,w_2]\rVert^2=2$ (**the pair cap is attained, exactly, and $\sqrt2$ is the right constant**) and $T_{123}=\langle[w_1,w_2],w_3\rangle^2=2$. Hence
$$P(W)=\mathop{\mathrm{tr}}W^3+3T_{123}\lambda_1\lambda_2\lambda_3=\frac{8-1-1}{6\sqrt6}+3\cdot2\cdot\frac{2\cdot(-1)(-1)}{6\sqrt6}=\frac1{\sqrt6}+\frac2{\sqrt6}=\frac3{\sqrt6}=\sqrt{\tfrac32}.$$
**Holds, exactly.** Cross-checked twice: against [L35](../findings/stratum-two-negative.md)'s anchor ($\sum\lambda^3=1/\sqrt6$, $3T\lambda_1\lambda_2\lambda_3=2/\sqrt6$), and against the $n=4$ adjugate form $P=9\det W^+=9\cdot\tfrac2{6\sqrt6}=\tfrac3{\sqrt6}$. Three routes, one value.

**(v) What its kernel does to the hypothesis.** $\ker W$ has dimension $N-3$, three at $n=4$ (all of $\Lambda^-$), sixty-three of sixty-six at $n=12$. **To L29's own hypothesis it does nothing:** H3 counts eigenvalues of each sign and is silent on zeros, and §3 shows the zero indices drop out of the cubic term by term. **The kernel bites in three places nearby, and a consumer needs each.**

1. **It voids the block's own motivation.** The "Needed because" paragraph runs on the gradedness slack $S(W)=\sum_{\lambda<0}c'^2$, concluding it *"vanishes identically once $\dim\mathfrak m\le2$"* and that *"padded $W_{\mathbb{CP}^2}$ ... lies in that stratum."* Trap **W4** in [findings/INDEX-traps.md](../findings/INDEX-traps.md):22 reads: *"the gradedness screen is vacuous when $\ker W\ne0$, it traces only over $E_\pm$, so a point whose kernel carries most of $\mathfrak{so}(n)$ reports $S=0$ while admitting no grading; padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$. Trust it only at $\ker W=0$."* The trap names this exact object. So the motivation's $S=0$ is true and carries no information, and the paragraph does not say so. **C10: GAP**, motivation only, no load on the proof, but a consumer reading the paragraph for a reason to care about the stratum is reading a voided screen.
2. **It puts the object outside [L30](../findings/stratum-two-negative.md) at $n=4$.** $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N=\mathbb R^4$, so $\dim U=4=n$ and L30's hypothesis fails. From $n=5$ on it holds. L29 does not use L30, so nothing here breaks; the note is for consumers who chain the two.
3. **It is the exception clause of [L33](../findings/stratum-two-negative.md), not its conclusion.** $v_1=w_1$ satisfies $w_1^2=-\tfrac12 P_{\mathbb R^4}$, so $\sqrt2\,w_1$ is a complex structure on the $4$-plane. L33's conclusion $W=0$ is therefore *not* triggered; the object survives precisely by being L33's named exception. **A consumer citing L33 alongside L29 must carry the exception, or L33 deletes L29's attaining object.**

**C3: PROVEN.**

## 6. A universal claim with witnesses (check-list item 3)

*"One positive and two negative eigenvalues cap $\theta$"* is universal over the stratum. I took every structured family the record names and asked which has that sign pattern.

| family, as the record names it | signature | in the stratum? | $\theta$, exact | exceeds $\sqrt{3/2}$? |
|---|---|---|---|---|
| padded $W_{\mathbb{CP}^2}$, $(2,-1,-1)/\sqrt6$ | $(1,2)$ | **yes** | $3/\sqrt6=\sqrt{3/2}$ (§5) | no, **equals** it |
| $W^+=\mathrm{diag}(q+r,-q,-r)$, $W^-=0$, at $(q,r)=(2,1)$ | $(1,2)$ | **yes** | $9\cdot2\cdot1\cdot3/14^{3/2}=27\sqrt{14}/98$ | no: $(27\sqrt{14}/98)^2=5103/4802$ and $2\cdot5103=10206<14406=3\cdot4802$ |
| $W_4(q,r)=-(q+r)w_1w_1^{\mathsf T}+q\,w_2w_2^{\mathsf T}+r\,w_3w_3^{\mathsf T}$ | $(2,1)$ | **no**, two positives | $-\theta$ of the row above | outside H3 |
| [L34](../findings/stratum-two-negative.md)'s $m=6$ witness, $(-3,-1,1,1,1,1)/\sqrt{14}$ | $(4,2)$ | **no** | $-1.030865$ on record | outside H3 |
| [L34](../findings/stratum-two-negative.md)'s $m=8$ witness, $\{-1/\sqrt3\,(\times2),\,1/(2\sqrt3)\,(\times4)\}$ | $(4,2)$ | **no** | $-\sqrt3/2$ on record | outside H3 |
| [L33](../findings/stratum-two-negative.md)'s witness, $W^+=W^-=\mathrm{diag}(2,-1,-1)$ | $(2,4)$ | **no** |, | outside H3 |
| $\mathbb{CP}^m$, $m\ge3$ ([L28](../results.md)) | many eigenvalues | **no** | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ | outside H3 |
| $S^p\times S^q$ ([L27](../results.md)) | many eigenvalues | **no** |, | outside H3 |
| Fox's $\mathcal S^4(\alpha)$ and the $\mathbb B_r$ idempotents ([ATTEMPTS.md](../ATTEMPTS.md):303–505) | $\mathcal S^4(\alpha)$ is padded $W_{\mathbb{CP}^2}$; the rest have larger support | only the first | $\mathcal S^4(\alpha)$: $\sqrt{3/2}$; every other idempotent found strictly below | no |
| quaternionic-Kähler, $m\ge2$ ([ATTEMPTS.md](../ATTEMPTS.md):407–440) | full support | **no** | $1.115547$, $0.852944$, $0.745356$ on record | outside H3, and below anyway |

**The row that matters.** The second row is not an independent witness of the *bound*, it is a witness that the block's exact-value claim is right. Its two routes agree without rounding: $f(t)$ at $t=b/a=2$ is $\frac{9\sqrt2\cdot2\cdot3}{4\cdot7^{3/2}}=\frac{27\sqrt{14}}{98}$, and the block's $9qr(q+r)/\lVert W\rVert^3$ at $(2,1)$ is $\frac{54}{14\sqrt{14}}=\frac{27\sqrt{14}}{98}$. **Identical, exactly.** So the block's *"$\theta=f(t)$ exactly, not merely at the maximiser"* is confirmed at a second point of the family by hand.

**No object in the record's catalogue with signature $(1,2)$ exceeds the cap, and only one attains it.** By [L33](../findings/stratum-two-negative.md), every signature-$(1,2)$ element is a padded $\mathrm{Weyl}_4$ element, so the second row's family *is* the whole stratum and the table is a census rather than a sample.

## 7. Finding A, the exclusion clause runs on the wrong constant at odd $n$

**Locate.** [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):114, inside the canonical block, and again at :13 in the development form:

> **What it settles and what it does not.** Since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, no maximiser in that dimension range has this spectrum

> The bound is dimension-free, and since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, it **excludes this whole stratum at $n\ge12$**.

**Exhibit the failure, at $n=13$.** The inference needs an object whose $\theta$ exceeds $\sqrt{3/2}$; it supplies the number $\theta_0(n)$. [conventions.md](../findings/conventions.md) fixes $\theta_0(n)$ as *"the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, **and nothing more**"*, and states in the same row that it is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$. At $n=13$: $\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}$, and $264\cdot2=528>507=3\cdot169$, so indeed $\theta_0(13)>\sqrt{3/2}$, **but nothing on the record puts an attained value at $\theta_0(13)$.** The attained one is $\Theta_{13}^2=\frac{2\cdot12\cdot10}{14\cdot11}=\frac{120}{77}$, which is strictly smaller. **The written premise is a number that no object on this record realises at odd $n$, so the inference has no witness there.** The same row of [conventions.md](../findings/conventions.md) names this exact substitution as *"what regrew [L0](../findings/problem.md)'s refuted constant"*.

**Argue the opposite, the most charitable reading.** One could read $\theta_0(n)$ as shorthand for "the target constant of Problem P", correct at even $n$ and to be reinterpreted at odd $n$ by any reader who knows the two agree there. **That reading does not rescue the line, and it identifies the repair.** The inequality runs the wrong way for a rescue: $\Theta_n\le\theta_0(n)$, so *"$\sqrt{3/2}<\theta_0(n)$"* is **weaker** than what the conclusion needs, not stronger. A reader supplying the correction is supplying a step, not reading one.

**The repair, and it costs nothing.** Replace $\theta_0(n)$ by $\Theta_n$. The threshold does not move, and both halves are exact:
- **even $n\ge12$:** $\Theta_n^2=\theta_0(n)^2\ge\tfrac{55}{36}$, since $\theta_0(n)^2-\tfrac{55}{36}=\frac{17n^2-216n+144}{36n^2}$ and $17n^2-216n+144=(n-12)(17n-12)\ge0$ for $n\ge12$, **tangent at exactly $n=12$**. And $\tfrac{55}{36}>\tfrac32$ since $110>108$.
- **odd $n\ge13$:** $\Theta_n^2-\tfrac{120}{77}=\frac{2(17n^2-248n+351)}{77(n+1)(n-2)}$ and $17n^2-248n+351=(n-13)(17n-27)\ge0$ for $n\ge13$, **tangent at exactly $n=13$**. And $\tfrac{120}{77}>\tfrac32$ since $240>231$.
- **$n=11$, the last dimension below threshold, both constants agreeing:** $\theta_0(11)^2=\tfrac{180}{121}$ with $360<363$, and $\Theta_{11}^2=\tfrac{160}{108}=\tfrac{40}{27}$ with $80<81$. Both below $\tfrac32$, so *"from $n=12$"* is right under either constant.

**C8: GAP.** The conclusion is true at every $n\ge12$ and the threshold is unchanged; the written premise does not deliver it at odd $n$. **What a consumer may cite today is the even-$n$ half.**

## 8. Finding B, the converse clause: three incompatible attributions, one of them in the canonical file, and a claim in [LEDGER.md](../findings/LEDGER.md) that all were fixed

**Locate.** Four sites, read alone as a consumer would.

| site | what it says about "equality forces the spectrum" |
|---|---|
| [results.md](../results.md):441, the canonical statement | *"The converse (that equality forces that spectrum), **is Lemma L72**, listed in the closing section."* |
| [results.md](../results.md):784, the closing section | *"**Lemma L72**, ... **closing the converse clause of Lemma L29** by the criticality rows alone"* |
| [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):13, development form | *"is **reduced but not closed**: see the equality clause below"* |
| [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):512, inside the L72 block | *"The converse clause Lemma L29 left 'reduced but not closed' ... **is closed by it**"*, then, in the same sentence, *"so L72 is the weaker statement"*, and *"**What closes the clause is Lemma L31**"* |

Against these, [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):86, the blockquote sitting inside the canonical L29 block itself:

> **THE CREDIT ONCE GIVEN HERE TO LEMMA L72 IS WITHDRAWN, AND THE CONTAINMENT RUNS THE OTHER WAY.** L72 quantifies over **critical** points; this clause quantifies over **equality** points, and by this lemma together with L72 the critical points are a *subset* of the equality points, so L72 is the weaker statement and cannot close it.

and [findings/INDEX-results.md](../findings/INDEX-results.md):86, the Gate-2 row for L72: *"**It does not close L29's converse**: critical points are a subset of equality points, so this is the weaker statement. L31 closes it in three lines."*

**Exhibit the failure concretely.** L72 concludes about the set $C=\{$critical points of $\mathcal W_n$ with signature $(1,2)\}$. The converse clause quantifies over $E=\{W:\text{signature }(1,2),\ \lVert W\rVert=1,\ \theta(W)=\sqrt{3/2}\}$. L29 gives $C\subseteq E$ and supplies no reverse containment; a property forced on a subset is not forced on the superset. So results.md:441 hands a consumer, as the closure of a universal statement over $E$, a theorem about $C$. **The defect is inherited by every citation of results.md:441 that does not also open [findings/](../findings/).** This is exactly the failure mode the round brief names: the correction landed at findings/:86, four hundred lines from the statement that carries it.

**And the record believes it is fixed.** [findings/LEDGER.md](../findings/LEDGER.md):915: *"Five sites carried the misattribution ... **All corrected to [L31](../findings/stratum-two-negative.md)**."* Four sites in the table above still do not read L31. **The ledger's own closure claim is false as of this round.**

**Argue the opposite.** The most charitable reading of results.md:441 is that "is Lemma L72" points at *where in the record the converse is discussed* rather than asserting L72 proves it, and :784's *"closing the converse clause"* is a summary of what the L72 block itself once said. **It does not survive contact with :784**, which states the closure as fact and in the active voice, nor with the fact that the source block's withdrawal is written in capitals inside the very block :443 sends the reader to. Two consumer-facing sites agreeing with each other and with nothing else is a propagated defect, not a pointer.

**C7: BROKEN.** The attribution is false. **The mathematical content of the clause is true**, which is why this is a citation defect rather than a refutation:

**What actually closes it, read off the written proof.** §2 Step 5 is part of L29's own chain: $\theta=\sqrt{3/2}$ forces every inequality tight, hence $t=1$, hence $a=b$; then trace-freeness gives $\lambda_1=2a$ and unit norm gives $2(a^2+a^2+a^2)=1$, so $a=1/\sqrt6$ and the spectrum is $(2,-1,-1)/\sqrt6$. **One line, from trace-freeness and the normalisation alone.** The block's own words *"attained only at $a=b$"* already carry it. **C6: PROVEN.**

**A consequence for the development form's hedge, at [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):35.** That paragraph says the *iff* is *"**equivalent to**: no full-support rank-3 signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$"*, then hedges on numerics at $r=6,8,10$ *"with $r\ge12$ untested"*. **The same paragraph's preceding clause derives $r=4$** (*"forces $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$, hence $r=4$"*) so no $r\ge6$ equality point can exist and the "equivalent to" is vacuous. **The hedge, and the three numerical exclusions it rests on, are inert.** Nothing in the record depends on them, and the canonical block 50 lines below correctly says *"with no numerics"*.

## 9. Finding C, the $k=2$ extension has no derivation on file

**Locate.** [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):37, and the corresponding clause in the canonical block at :116–:118:

> maximising the resulting bound over the whole two-parameter family returns $\sqrt{3/2}$ again, attained only in the limit $\lambda_2\to0$, $a=b$

> **It reaches $k=2$ as well** ... What the extension actually turns on is the **joint** cap $T_{1,N-1,N}+T_{2,N-1,N}\le2$ rather than the per-index one, which alone would give $3a$ with maximum $1.5$.

**What is on file and what is not.** The two structural reasons are correct and I checked both. At $k=2$ the $(+++)$ block needs three distinct positive indices and only two exist, so hollowness kills it; the $(++-)$ block enters the cubic with $\lambda_p\lambda_q\lambda_-<0$ against $T\ge0$ and may be dropped from an upper bound. The joint cap is the pair cap read at the pair $(N-1,N)$: $T_{1,N-1,N}+T_{2,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}\le2$, so with $\lambda_1\ge\lambda_2$ the surviving block is at most $6\lambda_1ab$. **All of that is sound and all of it is written down.** What is *not* written down anywhere, not in the block, not in the development form, not in [LEDGER.md](../findings/LEDGER.md):617–621, which records [r514](../reviews/REVIEW_r514.md) reaching the same correction, not in [ATTEMPTS.md](../ATTEMPTS.md), is the maximisation itself:
$$\max\Big\{\lambda_1^3+\lambda_2^3-(a^3+b^3)+6\lambda_1ab\ :\ \lambda_1+\lambda_2=a+b,\ \lambda_1^2+\lambda_2^2+a^2+b^2=1,\ \lambda_1\ge\lambda_2>0,\ a,b>0\Big\}=\sqrt{\tfrac32},$$
attained only as $\lambda_2\to0$ with $a=b$. **That is the whole content of "it reaches $k=2$", and no argument for it is on the record.** I read [LEDGER.md](../findings/LEDGER.md):617 and :621, which report the extension as *"true but the stated reason wrong"* and name the joint cap, a verdict, not a derivation.

**Screen, reported as a screen and not as evidence.** Two exact hand evaluations of the objective, on points I chose for the purpose: at $\lambda_1=\lambda_2=a=b=\tfrac12$ (feasible: $\lambda_1+\lambda_2=1=a+b$, norm $4\cdot\tfrac14=1$) the objective is $\tfrac18+\tfrac18-\tfrac28+6\cdot\tfrac12\cdot\tfrac14=\tfrac34$; at $\lambda_2=0$, $a=b=1/\sqrt6$ it is $\sqrt{3/2}$. Consistent with the claim, and no evidence for it, a two-point screen decides nothing about a two-parameter maximum.

**Argue the opposite.** A charitable reading is that the $k=2$ maximisation is a routine calculus exercise whose omission is a matter of style. **It does not survive the block's own neighbouring warning**: the very next clause records that the *per-index* cap, an equally routine-looking substitution, *"alone would give $3a$ with maximum $1.5$"*, over the target. A one-line difference in which constraint is used moves the answer from $1.2247$ to $1.5$, so this is not a maximisation whose outcome a reader may assume.

**C9: HYPOTHESIS-DEBT.** What would have to be shown is exactly the displayed maximisation. **Until it is, a consumer may cite L29 at $k=1$ only**, which is what its Statement quantifies over, and what [results.md](../results.md):441 and :144 say. The $k\le2$ claim lives only in [findings/](../findings/) and is separately covered, at any $k$, by [Lemma L35](../findings/stratum-two-negative.md), whose own close carries a certified-numerical step its block declares *"not hand-checkable"*.

## 10. Comparing the forms (check-list item 4)

| form | what it claims | agrees with the proof? |
|---|---|---|
| [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):13, development | cap; *"with equality **at**"*; dimension-free; excludes the stratum at $n\ge12$ via $\theta_0(n)$; converse *"reduced but not closed"* | **cap and attainment yes; the $\theta_0$ clause is §7's gap; the converse status is refuted by the canonical block 56 lines below** |
| [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):69, canonical | cap; *"attained at"*; *"carries no dimension restriction"*; converse *"closed in three lines by L31 ... and with no numerics"*; L72 credit withdrawn; $k=2$ extension; $\theta_0$ clause | **the mathematics is right throughout.** Carries §7's gap and §9's debt |
| [results.md](../results.md):439–441, canonical statement | cap; *"attained at"*; *"carries no dimension restriction"*; converse *"is Lemma L72"* | **the first three yes; the fourth is §8's BROKEN clause** |
| [results.md](../results.md):144, landscape line | *"Dimension-free, attained at $(2,-1,-1)/\sqrt6$, padded $W_{\mathbb{CP}^2}$. Three sign-blocks of the cubic vanish structurally, the pair cap bounds the fourth, and trace-freeness collapses the estimate to one closed form with a single maximum."* | **fully correct, and the only site in the record that is.** It makes no converse claim, no $\theta_0$ claim, and no $k=2$ claim |
| [results.md](../results.md):784, closing section | L72 *"closing the converse clause of Lemma L29"* | **§8's BROKEN clause, second site** |
| [lean/INDEX.md](../lean/INDEX.md):104, row L29, **partial** | the one-variable half via the perfect-square factorisation; *"the converse at tensor level ... is L31/L33's"*; **Owed**: the reduction to one variable, the three vanishing sign-blocks, the pair cap, trace-freeness, the normalisation | **correct on every count, and it already carries the corrected attribution [results.md](../results.md) does not.** I derived the same factorisation independently in §2 before reading the row |

**A Lean row exists, so the counterfactual the brief asks for does not arise.** Recording what it would take to move that row from **partial** to **proved**, since it is the sharpest statement of what is formalised: the three sign-block vanishings (hollowness of $T$ plus the sign counts of H3), the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ at the pair $(N-1,N)$, $\mathop{\mathrm{tr}}W=0$, and $\lVert W\rVert=1$, after which the row's own identity closes it. The row names exactly these four. **No finding.**

**The one form that disagrees on mathematics rather than on citation** is the development form's *"reduced but not closed"* against the canonical *"closed ... with no numerics"*. §8 shows the canonical one is right.

## 11. The gap between what is proven and what is used, and what a consumer may cite

**What the written proof establishes.** For any $W$ on $\Lambda^2\mathbb R^n$ that is symmetric, trace-free, of unit norm, with exactly one positive and exactly two negative eigenvalues counted with multiplicity: $\theta(W)\le\sqrt{3/2}$, with equality iff the nonzero spectrum is $(2,-1,-1)/\sqrt6$. **First Bianchi and Ricci-flatness are used only through $\mathop{\mathrm{tr}}W=0$**, so the theorem is strictly stronger than the statement, in the same way [L35](../findings/stratum-two-negative.md) records of its own chain. The bound is attained, at every $n\ge4$, by padded $W_{\mathbb{CP}^2}$.

**What a consumer may cite, stated exactly.**

- **Citable as written:** the cap $\theta\le\sqrt{3/2}$ on the signature-$(1,2)$ stratum at unit norm, at every $n$; its dimension-freeness; its attainment at $(2,-1,-1)/\sqrt6$; and the converse, that equality forces that spectrum. **These are [results.md](../results.md):144's four claims, and that line is clean.**
- **Citable with the constant repaired:** *"the stratum is excluded at $n\ge12$"*, true at every $n\ge12$, but the argument must run on $\Theta_n$, not $\theta_0(n)$ (§7). At even $n$ the written form is already correct.
- **Not citable:** *"the converse is Lemma L72"* ([results.md](../results.md):441 and :784). The converse is L29's own equality case; L72 is a strictly weaker statement about critical points (§8).
- **Not citable:** *"the Lemma covers $k\le2$"* ([findings/](../findings/) only). The two-parameter maximisation carrying it has no argument on file (§9). For $k\ge2$ the citable result is [L35](../findings/stratum-two-negative.md), with its own certified-numerical step declared.
- **Not citable as information:** the motivation's $S(W)=0$ on this stratum. True, and voided at the attaining object by trap [W4](../findings/INDEX-traps.md) (§5v).

**Two chaining hazards for consumers, neither a defect of L29.** [L30](../findings/stratum-two-negative.md)'s hypothesis $\dim U<n$ fails at $n=4$ at the attaining object, so a padding descent may not be started there. And [L33](../findings/stratum-two-negative.md), cited by L29 as "a second route", returns $W=0$ unless its exception clause is carried, and the attaining object is that exception.

## 12. The named trap, each citable claim read alone (check-list item 6)

I re-read each claim as a consumer who opens one file and stops.

| claim, read alone | does a correction sit somewhere else? |
|---|---|
| [results.md](../results.md):144 | **no.** Clean in isolation |
| [results.md](../results.md):441, first three sentences | **no.** Clean in isolation |
| [results.md](../results.md):441, fourth sentence | **yes, §8.** The correction is in [findings/](../findings/), in capitals, inside the block :443 points at, and in [INDEX-results.md](../findings/INDEX-results.md):86. **The consumer inherits the defect** |
| [results.md](../results.md):784 | **yes, §8**, same correction, second inheritance |
| [findings/](../findings/):13, development statement | **yes**, twice: the converse status is corrected at :86, and the $\theta_0$ constant is corrected at [conventions.md](../findings/conventions.md) |
| [findings/](../findings/):35, the equality-clause hedge | **yes, §8**, and by its own preceding clause. Its three numerical exclusions are inert |
| [findings/](../findings/):114, the $\theta_0$ exclusion clause | **yes, §7**, corrected only at [conventions.md](../findings/conventions.md), which the block does not cite |
| [findings/](../findings/):512, inside the L72 block | **the correction is in the same sentence as the claim it corrects**, *"is closed by it"* followed nine words later by *"so L72 is the weaker statement"*. A consumer reading the italicised summary and stopping takes the wrong half |
| [findings/LEDGER.md](../findings/LEDGER.md):915, *"All corrected to L31"* | **the closure claim is itself false**, four sites in §8's table still do not read L31 |

**The signature failure is present here in its purest form.** [findings/](../findings/):86 withdraws the L72 credit in capitals, and the two [results.md](../results.md) sites that carry the withdrawn credit sit 355 and 12 lines from the file's own copy of the same block. The ledger then records the sweep as complete.

## 13. What would falsify the statement, and what I did to look for it

**The object.** A $W\in\mathrm{Weyl}_n$ at some $n\ge4$, with $\lVert W\rVert=1$, exactly one positive and exactly two negative eigenvalues, and $\theta(W)>\sqrt{3/2}$.

**What such an object would have to contain.** By §2 the chain is exact except at one step, so $\theta>\sqrt{3/2}$ forces $3T_{1,N-1,N}\lambda_1ab>6\lambda_1ab$, hence $T_{1,N-1,N}>2$, hence **orthonormal $X,Y\in\mathfrak{so}(n)$ with $\lVert[X,Y]\rVert^2>2$**. So the falsifier is not a Weyl tensor at all but a violation of the pair cap, which is why the whole statement rests on [L31](../findings/stratum-two-negative.md) and on nothing dimension-dependent.

**What I did.** I enumerated every structured family the record names (§6) and found exactly one with signature $(1,2)$: the padded self-dual family $\mathrm{diag}(q+r,-q,-r)$, which by [L33](../findings/stratum-two-negative.md) is the whole stratum, not a sample of it. I evaluated it exactly at its symmetric member ($\sqrt{3/2}$, three routes agreeing) and at $(q,r)=(2,1)$ ($27\sqrt{14}/98$, two routes agreeing, and $5103/4802<3/2$ by cross-multiplication). I attacked the pair cap directly by computing $[w_1,w_2]=-\sqrt2\,w_3$ in $\Lambda^+$, which shows the constant $2$ is attained and therefore cannot be lowered, and read [L31](../findings/stratum-two-negative.md)'s proof, whose Cauchy–Schwarz step uses only two of the $\lfloor n/2\rfloor$ angles and so cannot degrade with $n$. **I found no falsifier and no room for one at the only step where one could live.**

**A source I did not read.** Nothing in this round rests on Cartan, Helgason, Berger or Besse. The one classical citation in the neighbourhood, the Weitzenböck identity in [L33](../findings/stratum-two-negative.md)'s proof, cited to Besse §1.143, is **not** used by L29's chain, and [references/](../references/) holds no Besse entry, so any consumer who reaches L29's converse through L33 rather than through L31 or through the chain's own equality case **is resting on an unread source**. The route through the chain (§8) and the route through [L31](../findings/stratum-two-negative.md) both avoid it.

---

**Verdict: `GAP`.** The cap, its dimension-freeness, its attainment and its converse are proven, and I re-derived each independently. Three clauses around them do not stand as written: the converse attribution to [L72](../findings/stratum-two-negative.md) at two sites in [results.md](../results.md) (**BROKEN**), the exclusion clause's constant at odd $n$ (**GAP**, repair given), and the $k\le2$ extension (**HYPOTHESIS-DEBT**, the owed maximisation displayed).
