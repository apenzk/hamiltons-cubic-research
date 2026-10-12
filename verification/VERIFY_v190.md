# VERIFY_v190, cold verification of Lemma L44

Cold read of [BRIEF_L44.md](BRIEF_L44.md) and of the sources it names. **No numerical work was done**, no script, no Sage, no Python, no floating-point evaluation; every comparison below is between exact rationals or exact surds, done by hand, and the one screen I ran was integer cross-multiplication on a claim I was about to record. Log: [agent_logs/verify-L44-v190.log](../agent_logs/verify-L44-v190.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Padded $W_{\mathbb{CP}^2}$ is critical with $\theta=\sqrt{3/2}$ at every $n\ge4$ | **PROVEN**, rebuilt from the $\mathfrak{so}(4)$ structure constants, §2 |
| 2 | $cI+W$ at the pinned $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$ lies on $\partial\Omega_0$ | **PROVEN**, re-derived from the boundary equation, §3 |
| 3 | The Weyl tensor itself does **not** lie on $\partial\Omega_0$ | **PROVEN**, and by three reasons where the block gives one, §3 |
| 4 | [L43](../findings/problem.md)'s collapse of $dF_R(\Phi(R))\le0$ to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ | **PROVEN**, rebuilt cold, and it is an identity on the whole Einstein slice, §4 |
| 5 | That collapse is "the block's only step" | **BROKEN as stated**, it is the only *cited* step; three further inputs carry the block, §4.3 |
| 6 | The criterion demands $\theta_0(n)$ at **both** parities; $\Theta_n$ is what the diagonal locus attains | **PROVEN**, no parity enters the collapse at any point, §5 |
| 7 | Elementary route: $n^2-13n+18<0$ at odd $n$, $n^2-12n+8<0$ at even $n$, roots $\tfrac{13+\sqrt{97}}2$ and $6+2\sqrt7$ | **PROVEN**, both polynomials and both roots, §6 |
| 8 | No integer lies between the two roots, so the threshold is $12$ at both parities | **PROVEN**, §6 |
| 9 | *Invariance $\Rightarrow G\le0$* "holds in two lines … and is now stated rather than assumed" | **HYPOTHESIS-DEBT**, the two lines are on no canonical page, §7 |
| 10 | "[Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s Lemma 2.3.4 supplies only the converse" | **REFUTED against the source**, 2.3.4 states *both* directions and the one L44 needs is its **first** half, §7 |
| 11 | Xu's (3.1)–(3.4) verify against the stored full text; the notes carry none of them | **PROVEN**, both halves, §8 |
| 12 | Criticality of the witness | **stated and never used**, §9 |

**Verdict: PROVEN, hypotheses corrected.** The mathematics of L44 is correct at every step I could rebuild, the repaired boundary placement is right, and the two polynomials and their roots are exact. Two prose defects stand: the block's account of Beitz's Lemma 2.3.4 has the two halves swapped, and "the block's only step" undercounts its inputs.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), never restated:

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$*".
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $\Omega_0$: "**[Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s invariant cone**, whose boundary is $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$. **A Weyl tensor never lies on it** ($\mathrm{ric}=0$ is where the defining function blows up and $\Omega_0$ is undefined), *so the boundary point a $W$ furnishes is $cI+W$ at the pinned $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$, and placing $W$ itself there is the error [L44](../findings/problem.md)'s audit found in three sites.*"
- $R_I,R_{\mathrm{ric}_0},R_W$: "the three $O(n)$-irreducible pieces … $R_{\mathrm{ric}_0}=0$ makes a slice **Einstein**; Ricci-flat additionally needs the scalar part, i.e. $c=0$, *which is the one value $c$ cannot take on $\partial\Omega_0$*".
- $\#$: "the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$", and $\mathrm{Ric}$ "the adjoint of $\cdot\wedge\mathrm{id}$, with $\lVert\mathrm{Ric}\rVert$ the Frobenius norm of the resulting symmetric matrix".
- Structure constants: "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric** … so $T_{abc}=c_{abc}^2$ is totally symmetric".
- $\lVert\cdot\rVert$ on $\mathfrak{so}(n)$: "$\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$".

Two conventions L44 and L43 consume that this file does **not** carry, and that I had to reconstruct in §3.1: the value of $\mathrm{ric}(I)$, and the $F$-threshold $\tfrac4{n-2}$ that goes with it.

## 1. Hypothesis inventory

| # | hypothesis | where the block gets it | checked at the padded witness? | used? |
| --- | --- | --- | --- | --- |
| H1 | $W$ is an algebraic Weyl operator on $\mathbb R^n$, $n\ge4$ | construction | **yes**, §2.3 verifies $\mathrm{ric}=0$ survives padding | yes |
| H2 | $\lVert W\rVert=1$ | implicit; the block drops $\lVert W\rVert^2$ from L43's inequality | yes | yes |
| H3 | $W$ is a critical point, $Q(W)=\theta W$ | stated in the canon and the block | **yes**, §2.2 | **no**, §9 |
| H4 | The slice is Einstein, $R_{\mathrm{ric}_0}=0$ | [L43](../findings/problem.md):541 | yes, $R=cI+W$ | yes |
| H5 | $c>0$, i.e. $\operatorname{scal}(R)>0$, the nappe-selecting clause | [problem.md](../findings/problem.md):60 | yes, $c=\tfrac1n\sqrt{2(n-2)/(n-1)}>0$ | yes |
| H6 | $\mathrm{ric}(R)\ne0$, so $F$ is defined and smooth near $R$ | never stated | yes, since $c>0$ | yes, silently |
| H7 | $Q(I)=(n-1)I$, i.e. $I^\#=(n-2)I$ | BW08 Lemma 2.1, via [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) | n/a | yes |
| H8 | $I\#W=-W$, whence $\Phi(I,W)=0$ | [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Prop 2.7(3); [L46](../findings/problem.md) step (C) | **yes**, needs only $W$ Weyl, which padding preserves | yes |
| H9 | $\operatorname{tr}Q(W)=0$ for Weyl $W$ | Hamilton's scalar identity, via [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) | yes | yes |
| H10 | $\lVert I\rVert^2=\binom n2$ | [L43](../findings/problem.md):539 | n/a | yes |
| H11 | $\partial\Omega_0$ is the $F$-level set $\tfrac4{n-2}$ | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96 | yes | yes |
| H12 | **invariance of $\Omega_0$ $\Rightarrow$ $G\le0$ at a boundary point** | **nowhere on the canonical record** |, | **yes, and it carries the whole conclusion** |
| H13 | $\Phi$ locally Lipschitz; $C=\{\operatorname{scal}>0\}$ open; $F$ smooth on $C$, Beitz 2.3.4's own hypotheses | never checked in the block | I checked them, §7.2: all three hold | yes, silently |
| H14 | $\Theta_n$ is the constant of the conjecture's conclusion at both parities | [L57](../results.md), [L0](../results.md) | n/a | yes, in the **elementary** route only |

**H12 and H13 are the debt.** H3 is the stated-and-unused hypothesis. H6 and H13 are steps that use a hypothesis never stated.

## 2. The witness, rebuilt from the $\mathfrak{so}(4)$ structure constants

I did not take $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ from the record. I rebuilt it.

### 2.1 The structure constants

With $L_{ij}:=E_{ij}-E_{ji}$, [conventions.md](../findings/conventions.md)'s norm "$\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$" makes each $L_{ij}$ a unit vector, so $\{L_{ij}\}_{i<j}$ is an orthonormal basis of $\Lambda^2\mathbb R^4$ and $\lVert I\rVert^2=\binom42=6$. Direct multiplication gives $L_{12}L_{23}=E_{13}$ and $L_{23}L_{12}=E_{31}$, hence

$$[L_{12},L_{23}]=E_{13}-E_{31}=L_{13},$$

so structure constants on index-sharing triples are $\pm1$. Take the self-dual triple

$$\omega_1=\tfrac{L_{12}+L_{34}}{\sqrt2},\qquad \omega_2=\tfrac{L_{13}-L_{24}}{\sqrt2},\qquad \omega_3=\tfrac{L_{14}+L_{23}}{\sqrt2},$$

each of unit norm. Expanding the bracket term by term, with $[L_{12},L_{13}]=-L_{23}$, $[L_{12},L_{24}]=L_{14}$, $[L_{34},L_{13}]=-L_{14}$ and $[L_{34},L_{24}]=L_{23}$,

$$[\omega_1,\omega_2]=\tfrac12\big(-L_{23}-L_{14}-L_{14}-L_{23}\big)=-(L_{14}+L_{23})=-\sqrt2\,\omega_3 .$$

So $c_{123}=-\sqrt2$ and $T_{123}=c_{123}^2=2$, totally symmetric by [conventions.md](../findings/conventions.md); $T$ vanishes on every triple that is not a permutation of $(1,2,3)$ inside one chirality, and $[\Lambda^+,\Lambda^-]=0$ kills the cross terms.

### 2.2 $\theta$ and criticality

$W_{\mathbb{CP}^2}$ is self-dual with $W^-=0$ and $W^+=\operatorname{diag}(2s,-s,-s)$ in the $\omega$-basis, trace-free, as a Weyl operator on $\mathbb R^4$ must be. Then $\lVert W\rVert^2=6s^2$, so $\lVert W\rVert=1$ fixes $s=1/\sqrt6$.

With $\#$ in [conventions.md](../findings/conventions.md)'s halved form, $(W^\#)_{cc}=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,T_{abc}$, giving

$$W^\#=\big(2\lambda_2\lambda_3,\ 2\lambda_1\lambda_3,\ 2\lambda_1\lambda_2\big)=\big(2s^2,\ -4s^2,\ -4s^2\big),$$

and off-diagonal and cross-chirality entries vanish because $\sum_{ab}\lambda_a\lambda_b c_{abc}c_{abd}=0$ for $c\ne d$ in the $\epsilon$-structure and $c_{a^+b^+c^-}=0$. Adding $W^2=(4s^2,s^2,s^2)$,

$$Q(W)=W^2+W^\#=(6s^2,-3s^2,-3s^2)=3s\cdot(2s,-s,-s)=3s\,W .$$

So $W$ **is** critical, with $\theta=3s=3/\sqrt6=\sqrt{3/2}$. Independently, $\operatorname{tr}W^3=6s^3$ and $\langle W,W^\#\rangle=\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_c T_{abc}=\tfrac12\cdot6\cdot2\cdot2s^3=12s^3$, so $P(W)=18s^3=18/(6\sqrt6)=\sqrt6/2=\sqrt{3/2}$, the two routes agree, and $Q(W)$ is trace-free so it stays in $\mathcal W_4$. **Claim 1's $n=4$ case: PROVEN.**

### 2.3 Padding, and this is where $\ker W\ne0$ is answered

Embed $\mathbb R^4\subset\mathbb R^n$ and extend $W$ by zero. Three things must survive, and each does for a reason:

- **$W$ stays Weyl.** $\mathrm{ric}(R)_{ij}=\sum_kR_{ikjk}$ is the $n=4$ Ricci when $i,j\le4$ and identically zero otherwise, so $\mathrm{ric}=0$ on $\mathbb R^n$.
- **$W^2$ is unchanged**, being supported on $\Lambda^2\mathbb R^4$.
- **$W^\#$ is unchanged.** $(W^\#)_{cd}=\tfrac12\sum_{ab}\lambda_a\lambda_bc_{abc}c_{abd}$ runs only over $a,b\in\Lambda^2\mathbb R^4$, where $\lambda\ne0$; and $[\mathfrak{so}(4),\mathfrak{so}(4)]\subseteq\mathfrak{so}(4)$ forces $c_{abc}=0$ for $c\notin\Lambda^2\mathbb R^4$. So $W^\#$ has no new entries, **the kernel directions receive nothing.**

Hence $Q(W)=\sqrt{3/2}\,W$ and $\lVert W\rVert=1$ at every $n\ge4$. **Claim 1: PROVEN at every $n\ge4$.**

**The $\ker W\ne0$ trap, answered step by step.** The padded witness has $\dim\ker W=\binom n2-3$ ($63$ of $66$ at $n=12$). Every step the block runs at it is either a norm ($\lVert W\rVert=1$), a linear-algebraic identity ($\mathrm{ric}=0$, $\operatorname{tr}Q(W)=0$, $\Phi(I,W)=0$), or the collapse of §4, which is a scalar identity in $\lVert W\rVert$ and $\langle W,Q(W)\rangle$. **None of them traces over eigenspaces, so none is vacuous on the kernel.** This matters because [INDEX-traps.md](../findings/INDEX-traps.md) **W4** records the one screen that *is* vacuous there, "the gradedness screen is vacuous when $\ker W\ne0$ … padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$", and L44 does not use it.

## 3. The boundary placement, both halves

### 3.1 The convention that makes the boundary equation come out

[conventions.md](../findings/conventions.md) fixes $\lVert I\rVert^2=\binom n2$ and $\partial\Omega_0:\ \tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$, but nowhere states $\mathrm{ric}(I)$. It is forced. With $\mathrm{Ric}$ "the adjoint of $\cdot\wedge\mathrm{id}$" and $\mathrm{id}\wedge\mathrm{id}=I$,

$$\langle\mathrm{ric}(I),\mathrm{id}\rangle=\langle I,\mathrm{id}\wedge\mathrm{id}\rangle=\lVert I\rVert^2=\tbinom n2,\qquad\text{so}\qquad \mathrm{ric}(I)=\tfrac{n-1}2\,\mathrm{id},\quad \lVert\mathrm{ric}(I)\rVert^2=\tfrac{n(n-1)^2}4 .$$

Against Beitz's $\Omega_0=\{\tfrac{n-2}4\lVert R\rVert^2\le\lVert\mathrm{ric}\rVert^2\}$, i.e. $F\le\tfrac4{n-2}$, this reproduces the tabled boundary exactly, since it makes $\lVert\mathrm{ric}(R_I)\rVert^2-\tfrac{n-2}4\lVert R_I\rVert^2=\tfrac n4\lVert R_I\rVert^2$, which is [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md)'s (1.2) at $a=0$.

**A factor-4 discrepancy between the two published sources, which I chased and which does not bite.** [Xu](https://arxiv.org/abs/2412.13633):805 prints $\tfrac1{2(n-1)}=F(I)\le F(R)\le\tfrac1{n-2}$ and calls $\partial\Omega(a)$ the level set $F^{-1}\big(\tfrac1{n-2+4a}\big)$, where Beitz has $\tfrac4{n-2+4a}$. The two differ exactly by $\mathrm{Ric}_{\text{Xu}}(I)=(n-1)\mathrm{id}$ against $\mathrm{ric}_{\text{Beitz}}(I)=\tfrac{n-1}2\mathrm{id}$. **Both conventions give the same pinned $c$**, §3.2's equation is invariant under scaling $\mathrm{ric}$ and the threshold together, and §4 shows the collapse cancels $\lVert\mathrm{ric}(I)\rVert^2$ identically, so it is immune to the choice. The record's $\tfrac4{n-2}$ is Beitz's, consistently.

### 3.2 $cI+W$ is on $\partial\Omega_0$, PROVEN

With $\lVert W\rVert=1$ and $R_I=cI$, the boundary equation reads

$$\tfrac{n-2}n=c^2\tbinom n2=c^2\tfrac{n(n-1)}2\ \Longrightarrow\ c^2=\tfrac{2(n-2)}{n^2(n-1)}\ \Longrightarrow\ c=\tfrac1n\sqrt{\tfrac{2(n-2)}{n-1}},$$

the positive root being selected by $\operatorname{scal}(R)>0$ ([problem.md](../findings/problem.md):60: "**the positive root, and $\operatorname{tr}(R)>0$ is what selects it**"). **Claim 2: PROVEN.** And then

$$c(n-1)=\tfrac{n-1}n\sqrt{\tfrac{2(n-2)}{n-1}}=\tfrac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$$

exactly, matching [conventions.md](../findings/conventions.md)'s closed form for $\theta_0$ with nothing else assumed.

### 3.3 The Weyl tensor itself is **not** on $\partial\Omega_0$, PROVEN, three ways

The block gives one reason. There are three, and they are independent:

1. **The block's own.** $\mathrm{ric}(W)=0$, so $F(W)=\lVert W\rVert^2/0$ is undefined for $W\ne0$; $\Omega_0$ is a sublevel set of $F$ and does not reach there.
2. **The clause the printed $F$-sublevel set omits.** $\operatorname{scal}(W)=0$, so $W$ fails $\operatorname{scal}(R)>0$ outright, and that clause is in the source's own definition ([problem.md](../findings/problem.md):54, [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)).
3. **It is not even in the closure.** $\epsilon I+W$ lies in $\Omega_0$ only for $\epsilon^2\binom n2\ge\tfrac{n-2}n\lVert W\rVert^2$, so $\epsilon$ is bounded away from $0$ and $W\notin\overline{\Omega_0}$ for $W\ne0$. **This is the one that closes the boundary-placement question properly**, since "not on the boundary" for a set defined by a blowing-up function invites the reply "but it is a limit point". It is not.

**Claim 3: PROVEN.** The repaired placement is right, and I checked all three sites the [LEDGER](../findings/LEDGER.md) says were wrong, [results.md](../results.md):102, [results.md](../results.md):282 and [problem.md](../findings/problem.md):213, each now says $cI+W$. No residual site places $W$ itself there.

## 4. Lemma L43's collapse, rebuilt cold

### 4.1 The criterion

From $F=A/B$ with $A=\lVert R\rVert^2$, $B=\lVert\mathrm{ric}(R)\rVert^2>0$, the quotient rule gives $dF_R(S)=\tfrac2B\big(\langle R,S\rangle-F(R)\langle\mathrm{ric}(R),\mathrm{ric}(S)\rangle\big)$, so with $S=\Phi(R)$,

$$G(R):=dF_R(\Phi(R))\le0\iff \langle R,\Phi(R)\rangle\le F(R)\,\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle .$$

This is [Xu](https://arxiv.org/abs/2412.13633)'s (3.1)–(3.2) verbatim, and it is what the [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) print. I derived it before reading either.

### 4.2 The collapse on the Einstein slice

Let $R=cI+W$ with $W$ Weyl. Bilinearity of $\#$, $I\#I=I^\#=(n-2)I$ and $I\#W=-W$ give

$$\Phi(cI+W)=\big(c^2I+2cW+W^2\big)+\big(c^2(n-2)I-2cW+W^\#\big)=c^2(n-1)I+Q(W),$$

the $\pm2cW$ pair cancelling, this **is** the record's "$\Phi(I,W)=W-W=0$", and it is the whole reason the slice survives the flow. Then, using $\operatorname{tr}W=0$ and $\operatorname{tr}Q(W)=0$,

$$\text{LHS}=\langle R,\Phi(R)\rangle=c^3(n-1)\tbinom n2+\langle W,Q(W)\rangle,$$

$$\text{RHS}=F(R)\cdot c\,\big\langle\mathrm{ric}(I),\,c^2(n-1)\mathrm{ric}(I)\big\rangle=F(R)\,c^3(n-1)\lVert\mathrm{ric}(I)\rVert^2 .$$

Now $F(R)=\dfrac{c^2\binom n2+\lVert W\rVert^2}{c^2\lVert\mathrm{ric}(I)\rVert^2}$, so **$\lVert\mathrm{ric}(I)\rVert^2$ cancels identically** and

$$\text{RHS}=c(n-1)\Big(c^2\tbinom n2+\lVert W\rVert^2\Big)=c^3(n-1)\tbinom n2+c(n-1)\lVert W\rVert^2 .$$

The $c^3(n-1)\binom n2$ term is common to both sides, and the criterion is, with **no residue whatsoever**,

$$\boxed{\ \langle W,Q(W)\rangle\ \le\ c(n-1)\,\lVert W\rVert^2\ }$$

**Claim 4: PROVEN.** Two things this shows that are worth stating positively. First, L43's "**the collapse is an identity on the whole slice, not merely a vanishing at the boundary**" is exactly right, I never used the boundary equation to get the boxed line, only the Einstein slice. Second, because $\lVert\mathrm{ric}(I)\rVert^2$ cancels, **the collapse is independent of the $\mathrm{ric}$ normalisation**, which is what makes §3.1's Beitz/Xu factor-4 harmless. On $\partial\Omega_0$ with $\lVert W\rVert=1$, §3.2's $c(n-1)=\theta_0(n)$ turns the box into $\langle W,Q(W)\rangle\le\theta_0(n)$, and in general into $\theta_0(n)\lVert W\rVert^3$.

**One shorthand in the block, harmless but worth naming.** [problem.md](../findings/problem.md):213 writes the collapse as "$\langle W,Q(W)\rangle\le c(n-1)=\theta_0(n)$", dropping the $\lVert W\rVert^2$ and printing $c(n-1)=\theta_0(n)$ as an identity. The dropped factor is the unit normalisation, which the witness satisfies; and $c(n-1)=\theta_0(n)$ holds **on the boundary only**, off it $c$ is free. Nothing downstream reads either wrongly, so I record this and do not raise it as a discrepancy.

### 4.3 "The block's only step", BROKEN as stated

The block says L43's collapse "is the block's only step". Reading it as *the only cited step*, it is true. Read as printed, it is false: at least three further inputs carry the conclusion, and none is inside L43.

| input | is it in L43? | where it actually lives |
| --- | --- | --- |
| $\theta(\text{padded }W_{\mathbb{CP}^2})=\sqrt{3/2}$ at every $n\ge4$ | **no** | rebuilt in §2; the record has it at [L2](../results.md) and via Nienhaus |
| **invariance $\Rightarrow G\le0$** | **no**, L43 collapses the criterion, it does not make the criterion necessary | nowhere; §7 |
| $\theta_0(n)<\sqrt{3/2}\iff n^2-12n+8<0$ over the integers | **no** | [L2](../results.md); §6 |

L43 itself *does* carry the boundary placement of §3.2 ("$\partial\Omega_0$ meets the slice at one ratio $c/\lVert W\rVert$"), so that one is fairly attributed. **Claim 5: BROKEN as stated, repaired by reading "only cited step".** This is the "step using a hypothesis never stated" trap in its mildest form: the second row is a genuine load-bearing step attributed to a lemma that does not contain it.

## 5. The parity claim, PROVEN, and it is the right distinction

The block's repair says the criterion demands $\theta_0(n)$ at **both** parities, and that $\Theta_n$ is what the diagonal locus attains rather than what the criterion demands. **Test: I re-read my own derivation of §4 for any parity-dependent step. There is none.** The inputs are $\lVert I\rVert^2=\binom n2$, $\mathrm{ric}(I)\propto\mathrm{id}$, $I\#I=(n-2)I$, $I\#W=-W$, $\operatorname{tr}Q(W)=0$, and the boundary equation. Every one is a rational identity in $n$ valid at every integer $n\ge4$, and

$$c(n-1)=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$$

is the closed form [conventions.md](../findings/conventions.md) insists on, "**and nothing more**". **No sphere product enters the derivation at any step**, so the constant cannot inherit the sphere product's parity. **Claim 6: PROVEN.**

**Why the distinction is not pedantry.** [conventions.md](../findings/conventions.md) records that the gloss "the value at the balanced sphere product" on $\theta_0$ "**stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant**", and [INDEX-traps.md](../findings/INDEX-traps.md) **W5** records $\Theta_n$ being read as a global maximum. L44 sits precisely where those two errors would meet, it uses $\theta_0$ in the cone route and $\Theta_n$ in the elementary route, at the same $n$, in the same paragraph, and it keeps them apart correctly. At $n=11$ the two differ: $\theta_0(11)^2=\tfrac{180}{121}$ against $\Theta_{11}^2=\tfrac{40}{27}$, and $\tfrac{180}{121}>\tfrac{40}{27}$ since $4860>4840$. **Both are below $\tfrac32$** ($360<363$ and $80<81$) so the two routes agree at $n=11$ for different reasons, which is exactly the overdetermination the block claims.

## 6. The elementary route, both polynomials, both roots, PROVEN

The route needs no cone theory: padded $W_{\mathbb{CP}^2}$ is a unit Weyl operator with $P=\sqrt{3/2}$, so $\sup\{P:\lVert W\rVert=1\}\ge\sqrt{3/2}$, and wherever $\Theta_n<\sqrt{3/2}$ the identification $\sup=\Theta_n$ is false. That is one line and uses only §2.

**Even $n$**, where $\Theta_n=\theta_0(n)$. Since $n^2>0$,

$$\frac{2(n-1)(n-2)}{n^2}<\frac32\iff 4(n-1)(n-2)<3n^2\iff 4n^2-12n+8<3n^2\iff n^2-12n+8<0 .$$

Discriminant $144-32=112=16\cdot7$, so the roots are $\tfrac{12\pm4\sqrt7}2=6\pm2\sqrt7$. **Upper root $6+2\sqrt7$, confirmed.**

**Odd $n$**, where $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ and $(n+1)(n-2)>0$ for $n\ge4$:

$$\frac{2(n-1)(n-3)}{(n+1)(n-2)}<\frac32\iff 4(n-1)(n-3)<3(n+1)(n-2)\iff 4n^2-16n+12<3n^2-3n-6\iff n^2-13n+18<0 .$$

Discriminant $169-72=97$, roots $\tfrac{13\pm\sqrt{97}}2$. **Upper root $\tfrac{13+\sqrt{97}}2$, confirmed**, and the block's displayed inequality $4(n-1)(n-3)<3(n+1)(n-2)$ is the right one. **Claim 7: PROVEN, both polynomials, both roots, and the parity-to-polynomial assignment is the correct way round.**

**No integer between the roots, PROVEN without decimals.** $6+2\sqrt7<\tfrac{13+\sqrt{97}}2$ iff $12+4\sqrt7<13+\sqrt{97}$ iff $4\sqrt7-1<\sqrt{97}$; squaring the positive quantities, $112-8\sqrt7+1<97$ iff $16<8\sqrt7$ iff $2<\sqrt7$, true. And both roots lie strictly between $11$ and $12$: $6+2\sqrt7>11\iff2\sqrt7>5\iff28>25$; $\tfrac{13+\sqrt{97}}2<12\iff\sqrt{97}<11\iff97<121$. **So $11<6+2\sqrt7<\tfrac{13+\sqrt{97}}2<12$, and no integer separates them.** The integer threshold is $12$ from both polynomials.

**The endpoints, checked exactly at both parities.**

| $n$ | parity | test | exact | fails? |
| --- | --- | --- | --- | --- |
| $4$ | even | $n^2-12n+8=16-48+8=-24$ | $\theta_0(4)^2=\tfrac34<\tfrac32$ | **yes** |
| $11$ | odd | $121-143+18=-4$ | $\Theta_{11}^2=\tfrac{40}{27}$, $80<81$ | **yes** |
| $11$ | odd, cone route | $\theta_0(11)^2=\tfrac{180}{121}$, $360<363$ | | **yes** |
| $12$ | even | $144-144+8=+8$ | $\theta_0(12)^2=\tfrac{55}{36}$, $110>108$ | no |
| $13$ | odd | $169-169+18=+18$ | $\Theta_{13}^2=\tfrac{120}{77}$, $240>231$ | no |

**The $n=11$ against $n=12$ trap, answered.** $n=11$ is *odd*, so a careless elementary reading would use $\theta_0(11)$ where $\Theta_{11}$ is meant. Both give failure here, but from different margins ($\tfrac32-\tfrac{180}{121}=\tfrac3{242}$ against $\tfrac32-\tfrac{40}{27}=\tfrac1{54}$) and only $\Theta$ is the elementary route's constant. $n=12$ is the first integer at which **both** hold, with margin $\tfrac{55}{36}-\tfrac32=\tfrac1{18}$. The block's "holds from $n=12$" also needs monotonicity, which the record does not display and which is one line: $\theta_0(n)^2=2(1-\tfrac1n)(1-\tfrac2n)$ is increasing in $n$, and $\tfrac{(n-1)(n-3)}{(n+1)(n-2)}=1-\tfrac{3n-5}{n^2-n-2}$ is increasing because $\tfrac{3n-5}{n^2-n-2}$ decreases on $n\ge4$. **So no $n\ge12$ falsifies the conclusion, at either parity**, which is the check that would have killed the programme had it come out otherwise.

**One quantifier note on the elementary route, and the block already carries it.** Conjecture A is stated for $n\ge12$, so at $4\le n\le11$ there is no claim to falsify; what the route proves is that the *identification* $\sup=\Theta_n$ fails there, hence the hypothesis cannot be weakened. That is a different conclusion from the cone route's "$\Omega_0$ is non-invariant", and the block says so in its own last sentence, "*The cone version earns its keep … and against the Ricci-flow statement that $\Omega_0$ is non-invariant there, neither of which the elementary witness gives.*" **The two routes are not two proofs of one statement; they are proofs of two statements that share a witness.** The block is honest about this and the heading's guard in [results.md](../results.md) is correct.

## 7. The direction the block supplies in prose

### 7.1 Are the two lines on the record anywhere? No.

The brief asks it plainly, so the answer is plain. **The two lines are on no page of the record.** I searched every markdown file for "normal component" and for the implication, and here is the complete set of what exists:

| where | what stands |
| --- | --- |
| [problem.md](../findings/problem.md):215, and [LEDGER.md](../findings/LEDGER.md):1115 | the sentence *"the direction holds in two lines, by evaluating the flow's normal component at the boundary point, and is now stated rather than assumed"*, **the sentence, not the two lines** |
| [problem.md](../findings/problem.md):70 | a *different* one-clause reason, "*it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$*", which is not a proof of the implication (it shows $\operatorname{scal}>0$ persists, which is a side condition, not the derivative inequality) |
| [REVIEW_r91](../reviews/REVIEW_r91.md):84 | the correction: *"[Xu](https://arxiv.org/abs/2412.13633) Proposition 2.2 states the **iff** … The necessity direction is therefore in hand from the same paper, and the scalar-curvature argument is not needed (nor does it, as written, establish necessity)"*, **filed in a review and never folded into the block** |

So [problem.md](../findings/problem.md) carries two different justifications of H12 in two places, one of which was refuted in review without the refutation reaching the text, and the block's own version is an assertion that an argument exists. **Claim 9: HYPOTHESIS-DEBT.** What is owed is four lines of prose in the block, or one citation.

### 7.2 And the block's account of Beitz is wrong, the direction it needs is Beitz's **first** half

This is the finding of this round. [diss_beitz.txt:1470](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) reads, verbatim:

> **Lemma 2.3.4.** Let $V$ be a vector space and $\Phi:V\to V$ a locally Lipschitz continuous map. Let further $C\subseteq V$ be an open set and $F:C\to\mathbb R$ a smooth function. **If the sublevel sets of $F$ are invariant under (2.2), then for all $v\in C$ we have that $dF_v(\Phi(v))\le0$.** *Conversely*, if $F$ satisfies (2.3) for all $v\in C$, then …

The direction L44 needs (invariance $\Rightarrow G\le0$), is the lemma's **first** clause, proved in the source in four lines immediately below it ("*let $a:=F(v)$ … $0\ge\frac d{dt}\big|_0F(f(t))=dF_v(\Phi(v))$*"). The block says Beitz "**supplies only the converse**". **The two halves are swapped.**

**The hypotheses, which the block never checks against the object and which I did.** $V=S^2_B(\mathfrak{so}(n))$; $\Phi=Q$ is a polynomial map, hence locally Lipschitz; $C=\{\operatorname{scal}>0\}$ is open; $F$ is smooth on $C$, [Xu](https://arxiv.org/abs/2412.13633):805 states exactly this, "*Since $\mathrm{Ric}(R)\ne0$ for all $R\in\mathrm{scal}^+$, the function $F$ is well-defined … Moreover, $F$ is smooth*". Beitz's proof also needs $f(t)$ to stay in $C$, which is free here: invariance of $\Omega_0$ puts $f(t)\in\Omega_0\subseteq C$. And it needs the sublevel set at the level $a=F(v)$; at the witness $F(R)=\tfrac4{n-2}$ exactly, so that sublevel set **is** $\Omega_0$, the one assumed invariant. **Every hypothesis holds at the padded witness.**

**Where this leaves the mathematics.** H12 is *true* and available from the record's own stored source in one citation, and separately from [Xu](https://arxiv.org/abs/2412.13633):435, Proposition 2.2, "*A closed convex $O(n)$-invariant subset $C\subset S^2_B(\mathfrak{so}(n))$ is invariant under the Hamilton ODE (2.28) **if and only if** for all $R\in\partial C$ we have $Q(R)\in T_RC$*". **Beitz 2.3.4 is the cleaner of the two here**, because Xu's needs $C$ closed and convex while $\Omega_0$ carries a strict $\operatorname{scal}>0$ and is not closed; Beitz's needs neither. **So the conclusion of L44 stands.** What fails is the block's sentence about its own source. **Claim 10: REFUTED against the source.**

## 8. Sources, and what a consumer can check from the notes alone

**Xu's (3.1)–(3.4): both halves of the block's own statement are correct.** They verify verbatim at [xu-2412.13633.txt:817–834](https://arxiv.org/abs/2412.13633), and (3.1) is exactly §4.1's quotient rule, which I derived before opening the file. And [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) carry **none** of them, the notes cover Conjecture 1 and (1.2), Theorem 1.1 with $\epsilon_n=\tfrac1n$, Proposition 2.7's five block rules, Lemma 2.8, Corollary 2.11 and Theorems 1.2–1.3. **Claim 11: PROVEN, both halves.**

**What a consumer can check from the notes alone, item by item.** This is the brief's question and it deserves the full list.

| the block cites | checkable from [Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) / [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md)? |
| --- | --- |
| $\Omega_a$'s definition and $\partial\Omega_0$ | **yes**, both notes carry it, and Xu's (1.2) gives the decomposed form |
| the criterion $dF_R(\Phi(R))\le0$ with $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ | **yes** from the Beitz notes, which print $G(R)\le0\iff P(R)\le F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$ |
| Xu (3.1)–(3.4) | **no**, absent from the notes; the block says so and is right |
| Xu Lemma 2.8 / Huisken's five-term expansion | **named** in the notes, not displayed; a consumer gets the pointer, not the identity |
| $\Phi(I,W)=0$, i.e. Prop 2.7(3) | **yes**, the notes print all five items |
| $\operatorname{scal}(Q(W))=0$ for Weyl $W$ | **yes**, the Beitz notes' identity table |
| $n\ge12$ is stated with the conjecture, not derived | **yes**, the Beitz notes say it in those words |
| **invariance $\Rightarrow G\le0$** | **no, and worse than no**, the [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) print only *"a sublevel set of a function $F$ is invariant when $dF_R(\Phi(R))\le0$"*, the sufficiency half, with no hint that 2.3.4 also states the necessity half. **This is where the block's error came from.** |

**The last row is the actionable finding of §8.** The notes' one-directional paraphrase of a two-directional lemma is what made the block believe it had a debt where it had a citation. Search-tool prose played no part in anything above: every source claim here is against the stored full text at a named line.

## 9. The named traps, each answered, including where I found nothing

- **$\ker W\ne0$.** Answered step by step in §2.3. The padded witness has kernel $\binom n2-3$, and no step of L44 traces over eigenspaces. **No finding.** The screen that *is* vacuous there ([INDEX-traps.md](../findings/INDEX-traps.md) **W4**) is not used by this block.
- **The boundary of every stated range.** $n=4$: $\dim\mathcal W_4=10\ne0$, $\theta_0(4)^2=\tfrac34$, criterion fails; $n=11$ and $n=12$ checked exactly in §6's table; $n=13$ checked as the first odd $n$ above threshold. **No finding.**
- **The smallest admissible dimension.** $n=4$. Below it $\mathcal W_n=0$ and the statement is vacuous. The block never states $n\ge4$ in its "$4\le n\le11$"; it is implied by the range itself. **No finding.**
- **Odd $n$.** §5 and §6. The cone route is parity-free by derivation; the elementary route uses the correct odd constant. **No finding**, this is the block's own repair and it survives.
- **$n=11$ against $n=12$.** §6's table, exact rationals, both parities' constants at $n=11$. **No finding.**
- **A claim proven on a subfamily and used in general.** The conclusion quantifies over $4\le n\le11$ and the witness exists at each such $n$ by padding, verified in §2.3 rather than assumed. **No finding.**
- **A hypothesis stated but never used.** **FINDING: criticality.** [results.md](../results.md):282 and the block both assert "$W$ is a critical point of $\mathcal W_n$", and neither route uses it. The cone route needs $\lVert W\rVert=1$, $\mathrm{ric}(W)=0$ and $\langle W,Q(W)\rangle>\theta_0(n)$; the elementary route needs $P(W)>\Theta_n$. **Criticality is true (§2.2) and decorative.** It is also the reason the sentence "critical point of $\mathcal W_n$" is a category error as printed, a critical point *of* a vector space; what is meant is a critical point of $P$ on that space's unit sphere. **Claim 12: stated and never used.** Harmless, and worth deleting or justifying.
- **A step using a hypothesis never stated.** **FINDING, three.** H6 ($\mathrm{ric}(R)\ne0$, so $F$ is differentiable at $R$, true because $c>0$); H13 (Beitz 2.3.4's own hypotheses, §7.2); and the monotonicity of $\theta_0$ and $\Theta$ that "holds from $n=12$" needs, supplied in §6. All three are true and none is written.
- **A universal claim with no witness.** The existential claims have their witness (§2); the universal ones ($\theta_0(n)\ge\sqrt{3/2}$ for $n\ge12$) are settled by the polynomials. **No finding.**
- **An imported theorem whose hypotheses were never checked against the object.** **FINDING: Beitz 2.3.4**, §7.2, never checked in the block, checked here, all hypotheses hold. On the named precedent, *"one route here died because a cited theorem assumes a unital algebra and $\mathcal W_n$ has no unit"*, I looked for the analogue and there is none, but the structure is present and handled correctly: $I\notin\mathcal W_n$, and the block does not pretend otherwise; it deliberately leaves $\mathcal W_n$ for $S^2_B(\mathfrak{so}(n))$ to form $cI+W$, which is exactly the move a unit-free space forces. **No finding on that axis.**
- **Symbol collisions**, from [conventions.md](../findings/conventions.md):
  - **$c$**, the file records that L44's pinned $\partial\Omega_0$ constant "collides with" L47's centre constant $c=\lambda/(n-1)=\tfrac1{2(n-1)}$ "twenty lines up" in the same file, in the syntactically identical role $R=cI+W$; $c_{abc}$ is a third sense. **The block names its own as "the pinned $c$" and displays its value.** No misreading is possible inside the block. **No finding.**
  - **$\Omega_0$**, one sense, and [conventions.md](../findings/conventions.md)'s row is written *about* this lemma's own repair. Consistent everywhere I looked. **No finding.**
  - **$F$**, L44 defines it inline as $\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, so it is safe; the record elsewhere uses $F$ as a frame label ($t_F$) and $\lVert\cdot\rVert_F$ for Frobenius. **Not tabled in [conventions.md](../findings/conventions.md)**, and by that file's own rule it should be. Minor.
  - **$R_I$**, used in [conventions.md](../findings/conventions.md)'s tabled sense throughout, as the scalar piece $cI$. **No finding.**
  - **$\Pi$**, the file's four unrelated objects. **L44 uses none of them.** Recorded as asked; no finding.
  - **$\Phi$**, the file's four senses. L44 uses sense *(ii)*, "**Hamilton's map $Q$ itself**, in [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md)'s notation", and it also writes $Q$ in the same block for the same map ("$dF_R(\Phi(R))\le0$" and "$\langle W,Q(W)\rangle$" in one sentence). Both letters for one object in one line is not an error but is the shape that produces one. Minor.

## 10. The discrepancy protocol, applied

Three candidates reached the protocol. One cleared all three tests; two are recorded as observations rather than defects.

**(a) "Beitz's Lemma 2.3.4 supplies only the converse", CLEARED, reported.**
1. *Located exactly*: [problem.md](../findings/problem.md):215, repeated at [LEDGER.md](../findings/LEDGER.md):1115 and in the brief's §C.
2. *Exhibited concretely*: [diss_beitz.txt:1470–1477](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) prints the necessity direction as the lemma's first clause, with its four-line proof, and introduces the other direction with the word "Conversely". Quoted in §7.2.
3. *Argued the opposite*: could "Lemma 2.3.4" mean a different numbering or edition? No, it is the record's own stored text, and it is the same lemma the [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) cite as the invariance mechanism. Could the first clause fail to apply to $\Omega_0$? No, every hypothesis checks (§7.2). Could the block mean "only the converse *is in our notes*"? That would be true, but it is not what it says, and it names the lemma rather than the notes. **The discrepancy stands.**

**(b) "L43's collapse is the block's only step", CLEARED as a prose defect, reported at §4.3.** Located at [problem.md](../findings/problem.md):213; exhibited by the three-row table of inputs absent from L43; the opposite argued as "only *cited* step", which is the reading that makes it true and which I record as the repair.

**(c) The $\tfrac4{n-2}$ against $\tfrac1{n-2}$ threshold between Beitz and Xu, WITHDRAWN.** Located at [xu-2412.13633.txt:805](https://arxiv.org/abs/2412.13633) against [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md). It fails test 2: no failure can be exhibited, because the two are one statement in two $\mathrm{ric}$ normalisations, they give the identical pinned $c$, and §4.2 shows $\lVert\mathrm{ric}(I)\rVert^2$ cancels out of the collapse identically. **Withdrawn: a convention difference, not a discrepancy.** It is worth a line in [conventions.md](../findings/conventions.md) all the same, since $\mathrm{ric}(I)$ is used and tabled nowhere.

## 11. What would falsify it, and what I did to look

**The object.** A dimension $n$ with $4\le n\le11$ at which $\Omega_0$ **is** invariant under the Hamilton ODE. By the block's own logic that object would have to defeat one of four things, so I looked for each:

| the falsifier would need | what I did |
| --- | --- |
| padded $W_{\mathbb{CP}^2}$ to fail $\theta=\sqrt{3/2}$, or to leave $\mathcal W_n$ under padding | **rebuilt it** from the $\mathfrak{so}(4)$ structure constants, both as $Q(W)=\theta W$ and as $P(W)=\operatorname{tr}W^3+\langle W,W^\#\rangle$, and checked each of $W^2$, $W^\#$ and $\mathrm{ric}$ separately under padding (§2) |
| $cI+W$ at the pinned $c$ to miss $\partial\Omega_0$ | re-derived $c$ from the boundary equation and confirmed the sign selection by the $\operatorname{scal}>0$ nappe (§3.2) |
| a residue surviving L43's collapse | redid the collapse from the quotient rule with $\lVert W\rVert$ and $c$ both free, and found the residue is exactly zero on the whole Einstein slice, the $c^3(n-1)\binom n2$ term common, $\lVert\mathrm{ric}(I)\rVert^2$ cancelling (§4.2) |
| invariance **not** to imply $G\le0$ at that boundary point | read Beitz's Lemma 2.3.4 at source, checked all four of its hypotheses against $Q$, $\{\operatorname{scal}>0\}$ and $F$, and found the direction is its first clause (§7.2) |

**A second object, for the other half.** An $n\ge12$ with $\Theta_n<\sqrt{3/2}$ would kill the conjecture outright and make the threshold wrong on the far side. I looked, and the monotonicity in §6 rules it out at both parities from the closed forms alone, with $\Theta_n^2\to2$.

**What I did not do.** No search, no sweep, no census, no numerical falsifier hunt, the programme's standing analysis-only rule. Every comparison above is exact integer arithmetic on rationals I formed for the purpose, and I report them as screens of claims I was about to record, never as evidence for a positive claim.

## 12. Verdict

**PROVEN, hypotheses corrected.**

The mathematics of L44 is correct. I rebuilt the witness from the $\mathfrak{so}(4)$ structure constants and it is critical with $\theta=\sqrt{3/2}$ at every $n\ge4$, kernel and all; the repaired boundary placement is right in both halves, and the Weyl tensor is excluded from $\partial\Omega_0$ by three independent reasons where the block gives one; L43's collapse leaves no residue and is an identity on the whole Einstein slice, normalisation-independent in $\mathrm{ric}$; the parity distinction is real and correctly drawn; and both polynomials, both roots and the absence of an integer between them check exactly.

**The corrections owed, in order of size:**

1. **[problem.md](../findings/problem.md):215 and [LEDGER.md](../findings/LEDGER.md):1115 state the wrong half of Beitz's Lemma 2.3.4.** The direction L44 needs is that lemma's *first* clause, proved in the source. The sentence should cite it instead of promising two lines, and the [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) should print both halves of 2.3.4 rather than the sufficiency half alone, the notes are where the error came from.
2. **H12 has no argument on the canonical record** and, until (1) lands, is a real debt: [problem.md](../findings/problem.md):70's scalar-curvature clause does not establish it and was refuted at [REVIEW_r91](../reviews/REVIEW_r91.md):84 without the refutation reaching the text.
3. **"L43's collapse is the block's only step" is false as printed**, read it as the only *cited* step, and name the other three inputs (§4.3).
4. **Criticality is stated and never used**, and "critical point of $\mathcal W_n$" should read "critical point of $P$ on the unit sphere of $\mathcal W_n$".
5. **[conventions.md](../findings/conventions.md) should carry $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$ and the $F$-threshold $\tfrac4{n-2}$**, which L43 and L44 both consume and which that file does not table; the Beitz/Xu factor-4 is exactly the kind of thing its own preamble exists to prevent.

None of these touches the conclusion. **$\Omega_0$ is non-invariant for $4\le n\le11$, and $n\ge12$ cannot be weakened.**
