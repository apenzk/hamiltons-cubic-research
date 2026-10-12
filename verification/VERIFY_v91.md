# VERIFY v91, L00-r2: the cone bridge at $a=0$, the constant $\theta_0(n)$, the $n\ge12$ witness, and whether Problem $P$ and Conjecture A are one statement

**Cold brief.** Verifier v91 on round [L00-r2](ROUND_L00r2.md), checking [findings/problem.md](../findings/problem.md):9–111 as dispatched. **No numerical work was done: no script was run, and every value below is an exact hand evaluation, most of them as squares so that no radical is ever approximated.** Every source claim was checked against the text held in [references/](../references/), Jäger, Beitz, Böhm–Wilking and Xu are all on disk with full extractions, and each cited item was read there rather than from memory. Log: [agent_logs/verify-L00r2-v91.log](../agent_logs/verify-L00r2-v91.log).

## Claim table

| # | Claim as the block states it | Verdict |
|---|---|---|
| 1 | Jäger Theorem A, quoted verbatim: even $n\ge16$, $W\in\langle W\rangle_d$, $\|W\|=1$, $Q(W)=\theta W$, $\theta\ge\theta_0(n)$ | **PROVEN**, verbatim at source |
| 2 | The next sentence of Jäger reads "the conjecture is that this is also true for all even integers $n\ge12$" | **PROVEN**, verbatim at source |
| 3 | Jäger's $\langle W\rangle_d$ setup is the hollow symmetric matrix with vanishing row sums | **PROVEN**, verbatim at source |
| 4 | Beitz Remark 6.3.15 states the conjecture in cone-invariance form, $a\in[0,\tfrac n4]$ | **PROVEN**, verbatim at source |
| 5 | "The thesis (p. 96) shows $R\in\Omega_a$ **is equivalent to**" the three-term decomposition inequality | **BROKEN**, the source's $\Omega_a$ carries a second clause, $\mathrm{scal}(R)>0$, and the block's sentence deletes it while calling the result an equivalence |
| 6 | The $a\to0$ row of the block's table: $\tfrac{n-2}n\|R_W\|^2\le\|R_I\|^2$ with $R_{\mathrm{ric}_0}$ unconstrained | **BROKEN**, the source displays $\Omega_0$ at $a=0$ explicitly, *with* `and tr(R) > 0`; the block's row drops that conjunct |
| 7 | $a>\tfrac n4$ empty; $a=\tfrac n4$ is the ray $\mathbb R_{>0}\cdot I$; $\Phi(I)=(n-1)I$ | **PROVEN**, rebuilt by hand and verbatim at source |
| 8 | The collapse: $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, every cross term vanishes, $\|\mathrm{ric}(I)\|^2$ cancels, criterion becomes $\langle W,Q(W)\rangle\le c(n-1)\|W\|^2$ | **PROVEN**, rebuilt in full below, exactly, with no residue |
| 9 | $c=\tfrac1n\sqrt{\tfrac{2(n-2)}{n-1}}$ and $c(n-1)=\theta_0(n)$ | **PROVEN, hypotheses corrected**: the positive root is selected by $\mathrm{scal}>0$, which the block never states |
| 10 | $n\ge12$ is necessary: $\Omega_0$ is non-invariant for $4\le n\le11$, and nowhere else | **PROVEN, hypotheses corrected**: true once $\mathrm{scal}>0$ is restored; false as an exact range without it, the cone then being non-invariant at every $n\ge4$ |
| 11 | Sharpness at even $n$ only; odd sphere-product maximum $\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}$, giving $\tfrac{40}{27},\tfrac{120}{77},\tfrac{21}{13}$ | **PROVEN**, all four exact |
| 12 | Off the slice: ten triples, five vanish, five survive, with $(Y,Y,W)=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ | **PROVEN**, rebuilt by hand; BW08 Lemma 2.2's Ricci-type hypothesis is satisfied by $Y$ |
| 13 | The expansion agrees term for term with Xu Lemma 2.8 (2.34), coefficient $\tfrac3{n-2}$ included | **PROVEN**, verbatim at source, and Xu's attribution to Huisken is verbatim too |
| 14 | The two-sided parity inequality $\lvert\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\rvert\le\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$ | **PROVEN**, rebuilt, and its precondition $cI+Y-W\in\Omega_0$ holds |
| 15 | The convention reconciliation: same norm, Beitz's $\mathrm{ric}$ a factor $\tfrac12$, Xu's $F(I)=\tfrac1{2(n-1)}$ against Beitz's $\tfrac2{n-1}$, a factor $4$ | **PROVEN**, all three numbers read at their own sources; the factor $\tfrac12$ against BW08 is consistent with everything checked but was not independently re-derived |
| 16 | BW08 defines $P=\tfrac13\langle R,Q(R)\rangle$, a factor $3$ against this project's $P$ | **PROVEN**, verbatim at source |
| 17 | "**Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice**" | **GAP**, the slice criterion quantifies over *every* unit Weyl operator; Conjecture A as the record holds it in print quantifies over *critical points only*. The block names one gap between the two statements and omits this one |
| 18 | The slice criterion and Conjecture A share the constant $\theta_0(n)$ | **GAP at odd $n$**, the record's own repaired form of Conjecture A is at $\Theta_n$, and $\Theta_{13}^2=\tfrac{120}{77}<\tfrac{264}{169}=\theta_0(13)^2$ |
| 19 | "The gap it papers over ($n=12,14$, and all odd $n$) sits exactly at the threshold under study" | **GAP**, stale: [results.md](../results.md):35 and :84 record the diagonal case as this record's own theorem at every $n\ge4$, both parities, "the dependence on it is gone" |
| 20 | The unnamed inputs, named: $\Phi$ preserves first Bianchi; invariance $\Rightarrow G\le0$ | **PROVEN** as an inventory; the second is a one-clause sketch carrying the whole necessity direction |

**Verdict: `GAP`.** *The mathematics of the bridge is right and I rebuilt every step of it by hand; two of its citable sentences are not, and in both cases the correction already exists on the record, beside the block rather than in it.*

---

## 0. Conventions, fixed once

Throughout, $n\ge4$; $\mathcal A_n=S^2_B(\mathfrak{so}(n))$ is the space of algebraic curvature operators, that is, self-adjoint operators on $\Lambda^2\mathbb R^n$ satisfying the first Bianchi identity, with $\langle A,B\rangle=\mathrm{tr}(A\circ B)$ and the orthogonal splitting $R=R_I+R_{\mathrm{ric}_0}+R_W$. $I$ is the identity operator on $\Lambda^2$, so $\|I\|^2=\dim\Lambda^2\mathbb R^n=\tfrac{n(n-1)}2$. $\#$ is Hamilton's product, $R^\#=R\#R$, $Q(R)=R^2+R^\#$, and $\Phi$ is the polarisation, $\Phi(A,B)=\tfrac12(AB+BA)+A\#B$, so that $\Phi(R,R)=Q(R)$. I write $\Phi(X)$ for $\Phi(X,X)$ where the block does. $P(R)=\langle R,Q(R)\rangle$ is this project's cubic, and $\theta=P(W)$ at a unit critical point. $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; $\Theta_n$ is the maximum of $P$ over sphere products, equal to $\theta_0(n)$ at even $n$ and to $\sqrt{2(n-1)(n-3)/((n-2)(n+1))}$ at odd $n$. $F(R)=\|R\|^2/\|\mathrm{ric}(R)\|^2$ and $G(R)=dF_R(\Phi(R))$. Every comparison of two positive reals below is carried out on their squares, so that no root is ever evaluated.

Two conventions the block reconciles and I adopt as it does: Beitz's $\mathrm{ric}$ is half Böhm–Wilking's $\mathrm{Ric}$, so $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$; and Böhm–Wilking's $P$ is a third of this project's.

---

## 1. The hypothesis inventory

*A pass without one is not a pass. Every hypothesis the block carries, every hypothesis of every result it imports, each checked against the object it applies to, and then which the written argument uses.*

### 1.1 Hypotheses the block carries in its own voice

| Hypothesis | Where it appears | Checked against the object | Used? |
|---|---|---|---|
| $R=cI+W$, i.e. $R_{\mathrm{ric}_0}=0$ | "Take the slice $R_{\mathrm{ric}_0}=0$" | Satisfiable: the Weyl block and $\langle I\rangle$ are both nonzero for $n\ge4$ | **Yes**, it is what makes five of the ten triples drop out |
| $\|W\|=1$ | "Normalising $\|W\|=1$" | A normalisation, no content, since the criterion is homogeneous of degree $3$ in $R$ | Yes, to write $c(n-1)$ rather than $c(n-1)\|W\|^2$ |
| $R\in\partial\Omega_0$ | The $c$ computation | Nonempty for every $n\ge4$ | **Yes**, it pins $c$ against $\|W\|$ |
| $c>0$ | **Nowhere stated** | Forced by $\mathrm{scal}(R)>0$, which the block also never states | **Yes, silently**, the block takes the positive square root of $c^2$ |
| $n\ge4$ | Only implicitly, in the range "$4\le n\le11$" | At $n=3$ the Weyl block is zero and the whole derivation is vacuous | Yes, unstated |
| $W$ is a critical point | **Nowhere** in the reviewed range, except in the Jäger paragraph | The slice criterion is a statement about all $W$ | **No**, and see §5, where this is the finding |

### 1.2 Hypotheses of every imported result

| Import | Its hypotheses, read at the source | Does the object satisfy them? | Does the argument use it? |
|---|---|---|---|
| **Jäger Theorem A** ([diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):111–115) | $n\ge16$; $n$ **even**; $W\in\langle W\rangle_d$ (diagonal in the standard basis); $\|W\|=1$; $W^2+W^\#=\theta W$; $\theta\ge\theta_0(n)$ | Only for diagonal $W$ at even $n\ge16$, three restrictions the block itself enumerates | Cited, not used in the bridge |
| **Jäger, $Q$ preserves $\langle W\rangle_d$** (same page: "if $W\in\langle W\rangle_d$, the same is also true for $W^2+W^\#$") | none beyond $W\in\langle W\rangle_d$ | ✓ | **Used and not named**, it is what makes a constrained critical point of $P|_{\langle W\rangle_d}$ satisfy the unconstrained equation $Q(W)=\theta W$, which is the step the block compresses into "every maximizer is critical" |
| **BW08 Lemma 2.1** ([boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187):216) | $R\in S^2_B(\mathfrak{so}(n))$, i.e. first Bianchi | ✓ for $W$ and for $Y$ | **Yes**, gives $W\#I=-W$, hence $\Phi(I,W)=0$ |
| **BW08 eq. (6)** (:203) | "if $e_1,\dots,e_n$ denotes an orthonormal basis of **eigenvectors of Ric**" | Vacuous when $\mathrm{Ric}(W)=0$: every orthonormal basis is then an eigenbasis | **Yes**, gives $\mathrm{Ric}(Q(W))=0$. The frame hypothesis is omitted by the block and is harmless here |
| **BW08 eq. (5)** (:186) | $R_i\in S^2_B(\mathfrak{so}(n))$ | ✓ | Cited; the block correctly says it is **not** load-bearing |
| **BW08 Lemma 2.2** (:237) | $R$ is **of Ricci type**, $R=R_I+R_{\mathrm{Ric}_0}$ | ✓ for $Y=R_{\mathrm{ric}_0}$, which has $R_I=0$ | **Yes**, off the slice only |
| **Beitz $\Omega_a$** ([diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf):5440ff) | $n\ge3$, $a\in[0,\tfrac n4]$, and **$\mathrm{scal}(R)>0$ as part of the definition** | ✓, but the block drops the clause | **Yes, and mis-stated**, see §3 |
| **Beitz $F$** (:5501, eq. 6.24) | Defined **only on $\mathrm{scal}^+$**; the sublevel description $\Omega_a=F^{-1}((-\infty,\tfrac4{n-2+4a}])$ is stated **for $a>0$** | The block works at $a=0$, the one value the sublevel phrasing excludes; the primary definition does cover $a=0$ | **Yes** |
| **Beitz Lemma 2.3.4** (via [notes.md](../references/beitz-2018-bianchi-convexity/notes.md):17) | Supplies $G\le0\Rightarrow$ invariance | The block needs the converse | **Yes**, the block says so and supplies a one-clause argument |
| **Beitz Lemma 6.3.16** | invariance for $a\in[\tfrac n4-\varepsilon,\tfrac n4]$ | ✓ | Cited for scope only |
| **Hamilton, $\mathrm{scal}(Q(R))=2\|\mathrm{ric}(R)\|^2$** ([notes.md](../references/beitz-2018-bianchi-convexity/notes.md):36) | none | ✓ | Yes, gives $\mathrm{scal}(Q(W))=0$ |
| **Hamilton, $\Phi$ preserves first Bianchi** | standard | ✓ | **Yes**, the block names it as an input it had not named |
| **Xu Prop. 2.7** ([xu-2412.13633.txt](https://arxiv.org/abs/2412.13633):491) | $R,S$ in the named blocks | ✓ | Yes, for the block-vanishing table |
| **Xu Lemma 2.8 (2.34)** (:519) | $R\in S^2(\mathfrak{so}(n))$ | ✓ | Cited as agreement |
| **Nienhaus, Conjecture A** ([notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):7) | $W$ unit Weyl **and a critical point of $P$**; $n\ge12$, or $8\le n\le11$ with the $\mathbb{CP}^2$ exception | The block's conclusion has no criticality hypothesis at all | **Not used, and the mismatch is not stated**, §5 |

### 1.3 The one-line reading

*The written argument uses eight of these and states five.* The three it uses without stating are $\mathrm{scal}>0$ (equivalently $c>0$), $Q$-invariance of the diagonal locus, and the eigenbasis frame in BW08 eq. (6). The first is load-bearing and is treated in §3; the other two are harmless here and are recorded so that a later consumer does not have to rediscover them.

---

## 2. The derivation, rebuilt in full

*Every step below was carried out by hand, on paper, from the definitions in §0. It is reproduced in full because the round asks for it and because the collapse is the block's whole content.*

### 2.1 The cone in decomposition form

Beitz's normalisation, which the block quotes, is $\|\mathrm{ric}(R)\|^2=\tfrac{n-1}2\|R_I\|^2+\tfrac{n-2}4\|R_{\mathrm{ric}_0}\|^2$. The membership inequality $\big(\tfrac{n-2}4+a\big)\|R\|^2\le\|\mathrm{ric}(R)\|^2$ then reads, using $\|R\|^2=\|R_I\|^2+\|R_{\mathrm{ric}_0}\|^2+\|R_W\|^2$ and multiplying by $4$,

$$(n-2+4a)\big(\|R_I\|^2+\|R_{\mathrm{ric}_0}\|^2+\|R_W\|^2\big)-2(n-1)\|R_I\|^2-(n-2)\|R_{\mathrm{ric}_0}\|^2\le0 .$$

Collecting: the $\|R_I\|^2$ coefficient is $n-2+4a-2n+2=4a-n$; the $\|R_{\mathrm{ric}_0}\|^2$ coefficient is $n-2+4a-(n-2)=4a$; the $\|R_W\|^2$ coefficient is $n-2+4a$. Dividing by $4$ gives exactly the block's display,

$$\frac{4a-n}4\|R_I\|^2+a\|R_{\mathrm{ric}_0}\|^2+\Big(\frac{n-2}4+a\Big)\|R_W\|^2\le0 .$$

**Confirmed.** The three table rows follow: at $a>\tfrac n4$ all three coefficients are positive so only $R=0$ survives and the set is empty; at $a=\tfrac n4$ the first coefficient vanishes and the other two are positive, leaving $R_{\mathrm{ric}_0}=R_W=0$, a ray; at $a=0$ the middle coefficient vanishes, leaving $\tfrac{n-2}n\|R_W\|^2\le\|R_I\|^2$ with $R_{\mathrm{ric}_0}$ free. And $Q(I)=I^2+I^\#=I+(n-2)I=(n-1)I$, so the ray is invariant. All as the block has it, **except for the positivity clause** (§3).

### 2.2 The collapse on the slice

$\Phi(I,W)=\tfrac12(IW+WI)+I\#W=W+I\#W$, and BW08 Lemma 2.1 applied to $W$ gives $W+W\#I=(n-1)W_I+\tfrac{n-2}2W_{\mathrm{Ric}_0}=0$, so $W\#I=-W$ and $\Phi(I,W)=0$. Hence

$$\Phi(cI+W)=c^2\Phi(I,I)+2c\,\Phi(I,W)+\Phi(W,W)=c^2(n-1)I+Q(W) .$$

Pairing against $R=cI+W$, and using $\langle W,I\rangle=\mathrm{tr}\,W=0$ and $\langle I,Q(W)\rangle=\mathrm{tr}\,Q(W)=\mathrm{scal}(Q(W))=0$,

$$\langle R,\Phi(R)\rangle=c^3(n-1)\|I\|^2+\langle W,Q(W)\rangle .$$

On the right-hand side of the criterion, $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ and $\mathrm{ric}(\Phi(R))=c^2(n-1)\mathrm{ric}(I)$, while $F(R)=\big(c^2\|I\|^2+\|W\|^2\big)/\big(c^2\|\mathrm{ric}(I)\|^2\big)$. Therefore

$$F(R)\big\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\big\rangle=\frac{c^2\|I\|^2+\|W\|^2}{c^2\|\mathrm{ric}(I)\|^2}\cdot c^3(n-1)\|\mathrm{ric}(I)\|^2=c(n-1)\big(c^2\|I\|^2+\|W\|^2\big).$$

$\|\mathrm{ric}(I)\|^2$ has cancelled identically, as the block says, and the $c^3(n-1)\|I\|^2$ term is common to both sides. The criterion $G\le0$ is therefore, with **no residue whatsoever**,

$$\langle W,Q(W)\rangle\ \le\ c(n-1)\|W\|^2 .$$

**Confirmed, and note what the derivation shows that the block does not quite say**: this is an identity on the whole slice, not only at $\partial\Omega_0$. The bound is weakest at the smallest admissible $c$, which is the boundary, so testing at $\partial\Omega_0$ is testing the binding case, and the block's restriction to the boundary loses nothing. (The canonical [Lemma L43](../findings/problem.md):497 does say this; the block under review does not.)

### 2.3 The constant

On $\partial\Omega_0$ with $\|W\|=1$: $R_I=cI$ and $R_W=W$, so $\tfrac{n-2}n\cdot1=c^2\cdot\tfrac{n(n-1)}2$, giving

$$c^2=\frac{2(n-2)}{n^2(n-1)},\qquad c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}\quad\text{(positive root)},$$

$$c(n-1)=\frac{n-1}n\sqrt{\frac{2(n-2)}{n-1}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

**Confirmed exactly.** And the square check the block records, $\big(c(n-1)\big)^2=\tfrac{(n-1)^2}{n^2}\cdot\tfrac{2(n-2)}{n-1}=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$, holds by hand without evaluating any root. The selection of the **positive** root is the point of §3.

### 2.4 The threshold polynomial

$$\theta_0(n)^2-\frac32=\frac{4(n-1)(n-2)-3n^2}{2n^2}=\frac{4n^2-12n+8-3n^2}{2n^2}=\frac{n^2-12n+8}{2n^2}.$$

The roots are $6\pm2\sqrt7$; over the integers $n\ge4$ the quadratic is negative at $n=4$ ($-24$) through $n=11$ ($-3$) and positive at $n=12$ ($+8$). So the criterion at the padded $W_{\mathbb{CP}^2}$, namely $\sqrt{3/2}\le\theta_0(n)$, fails exactly on $4\le n\le11$. **Confirmed; the block's arithmetic is exact and its range is right.**

### 2.5 The odd-$n$ values

$\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}$ gives $\tfrac{2\cdot10\cdot8}{9\cdot12}=\tfrac{160}{108}=\tfrac{40}{27}$ at $n=11$; $\tfrac{2\cdot12\cdot10}{11\cdot14}=\tfrac{240}{154}=\tfrac{120}{77}$ at $n=13$; $\tfrac{2\cdot14\cdot12}{13\cdot16}=\tfrac{336}{208}=\tfrac{21}{13}$ at $n=15$. **All three confirmed exactly**, and they agree with the record's own catalogue.

And the gap never closes, which the block asserts without a formula: $\theta_0^2-\Theta_n^2=2(n-1)\big[\tfrac{n-2}{n^2}-\tfrac{n-3}{(n-2)(n+1)}\big]$, whose numerator over $n^2(n-2)(n+1)$ is $(n-2)^2(n+1)-n^2(n-3)=(n^3-3n^2+4)-(n^3-3n^2)=4$. So

$$\theta_0(n)^2-\Theta_n^2=\frac{8(n-1)}{n^2(n-2)(n+1)}>0\quad\text{at every }n\ge4 .$$

**Confirmed by hand**, and it matches the record's [L0](../results.md) and [L16](../results.md) rows exactly. This is the arithmetic behind claim 18.

### 2.6 Off the slice

With $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ symmetric and $R=cI+Y+W$, the cube expands into ten distinct triples with multinomial weights:

$$T(R,R,R)=c^3T(I,I,I)+3c^2T(I,I,Y)+3c^2T(I,I,W)+3cT(I,Y,Y)+6cT(I,Y,W)+3cT(I,W,W)+T(Y,Y,Y)+3T(Y,Y,W)+3T(Y,W,W)+T(W,W,W).$$

Five vanish, each for a stated reason: $T(I,I,Y)=(n-1)\langle Y,I\rangle=0$ and $T(I,I,W)=(n-1)\langle W,I\rangle=0$ by tracelessness; $T(I,Y,W)=\langle Y,\Phi(I,W)\rangle=0$ by $\Phi(I,W)=0$; $T(I,W,W)=\mathrm{tr}\,Q(W)=0$; $T(Y,W,W)=\langle Y,Q(W)\rangle=0$ because $Q(W)$ is Weyl and $Y$ is not. The five survivors are $(I,I,I)$, $(I,Y,Y)$, $(Y,Y,Y)$, $(Y,Y,W)$, $(W,W,W)$, giving exactly the block's display. **Confirmed**, and the coefficient claim is confirmed too: BW08 Lemma 2.2 applied to the Ricci-type $Y$ gives $\big(Q(Y)\big)_W=\tfrac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$, so $3T(Y,Y,W)=3\langle W,\Phi(Y)\rangle=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$, matching Xu's third term including its coefficient.

### 2.7 The parity argument

$\Omega_0$'s constraint at $a=0$ involves $W$ only through $\|R_W\|^2$, so $cI+Y-W$ is in it whenever $cI+Y+W$ is. On the right, $\mathrm{ric}(R)$ is $W$-independent, $F$ is $W$-even, and the only $W$-dependent piece of $\Phi(R)$ with nonzero Ricci is $2\Phi(Y,W)$, which by Xu (5) lands in $\langle\mathrm{Ric}_0\rangle$ and is $W$-odd. Writing the criterion at both signs as $L_e+L_o\le R_e+R_o$ and $L_e-L_o\le R_e-R_o$ and adding the two rearrangements gives $\pm(L_o-R_o)\le R_e-L_e$, i.e. the block's display. **Confirmed.** And the consistency check is right: at $Y=0$ both $T(Y,Y,W)$ and $R_o$ vanish and the inequality is $\lvert\langle W,Q(W)\rangle\rvert\le R_e-L_e$, which reduces to §2.2 on the positive branch.

---

## 3. Discrepancy 1, the cone's positivity clause is deleted from a sentence that calls itself an equivalence

**Locate it exactly.** Two places, both in the reviewed range.

> "**The cone family in decomposition form, and which end is hard.** The thesis (p. 96) shows $R\in\Omega_a$ **is equivalent to** $\frac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+\big(\frac{n-2}4+a\big)\lVert R_W\rVert^2\le0$"

and the table row directly beneath it,

> "| $\to0$ | $\frac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$, with $R_{\mathrm{ric}_0}$ **unconstrained** | the whole content |"

and once more where the definition is quoted outright, in the ATTRIBUTION paragraph: "states $\Omega_a=F^{-1}\big((-\infty,\tfrac4{n-2+4a}]\big)$".

The source, read directly at [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf):5440ff, says something narrower in the first case and something different in the second:

> "$\Omega_a:=\{R\in\mathcal A_n\mid \big(\tfrac{n-2}4+a\big)\|R\|^2\le\|\mathrm{ric}(R)\|^2$ **and** $\mathrm{scal}(R)>0\}$."
>
> "Remark 6.3.10. … from Remark 1.1.16, we obtain that $\big(\tfrac{n-2}4+a\big)\|R\|^2\le\|\mathrm{ric}(R)\|^2$ is equivalent to $\tfrac{4a-n}4\|R_I\|^2+a\|R_{\mathrm{ric}_0}\|^2+\big(\tfrac{n-2}4+a\big)\|R_W\|^2\le0$."

Beitz asserts the equivalence of the **inequality**, not of membership. And she then writes $\Omega_0$ out at exactly the value the block works in:

> "For $a=0$, we have that $\Omega_0=\{R\in\mathcal A_n\mid\tfrac{n-2}n\|R_W\|^2\le\|R_I\|^2$ **and** $\mathrm{tr}(R)>0\}$."

The block's table row is that display with one of its two conjuncts deleted. The third quotation is also incomplete on its own terms: $F$ is defined at (6.24) only on $\mathrm{scal}^+:=\{R\mid\mathrm{scal}(R)>0\}$, and the sublevel-set description is stated "for $a>0$", the one value of $a$ it does not cover being the block's.

**Exhibit the failure concretely.** $F$ is even in $R$, so the set the block prints is a double cone. Take $n=12$ and $W$ the unit Weyl operator of $S^6\times S^6$, for which $\langle W,Q(W)\rangle=\theta_0(12)>0$, and put $R=-c_0I+W$ with $c_0=\tfrac1{12}\sqrt{\tfrac{2\cdot10}{11}}>0$. Then $\|R_I\|^2=c_0^2\|I\|^2$ is unchanged, so $R$ lies on the block's printed boundary. The collapse of §2.2 is an algebraic identity in $c$ and applies verbatim, giving the demanded inequality

$$\langle W,Q(W)\rangle\le(-c_0)(n-1)\|W\|^2=-\theta_0(12),$$

which is false, the left side being $+\theta_0(12)$. The same construction runs at every $n\ge4$ and at every sphere product. So on the block's printed cone, $\Omega_0$ is non-invariant **at every dimension**, and the block's two headline range claims ("$\Omega_0$ is provably non-invariant for $4\le n\le11$" and "the bridge is sharp at $a=0$"), are both false as exact statements. Restoring $\mathrm{scal}(R)>0$ removes the second nappe, since $\mathrm{scal}(cI+W)=c\,\mathrm{scal}(I)$ forces $c>0$, and both claims become true.

**Argue the opposite.** The most charitable reading the words support is that "$\Omega_a$" is being used as a name for the $F$-sublevel condition alone, with positivity understood from the $a=\tfrac n4$ row of the block's own table, which does say $\mathbb R_{>0}\cdot I$, a single ray rather than a line. That reading is available, and it is probably what the author had in mind. It does not survive contact with the three rules of this round, for two reasons. First, the sentence is framed as a report of what the source shows and it is not what the source shows: the source's equivalence is of the inequality, and the source's $\Omega_0$ display carries `and tr(R) > 0` in the same line. Second, and decisively, **the record has already found this exact defect and fixed it elsewhere**: [findings/problem.md](../findings/problem.md):497, the canonical Lemma L43 block, reads

> "*The cone also carries $\operatorname{scal}(R)>0$, which the printed $F$-sublevel set omits: $F$ is even in $R$, so without that clause the set is a double cone whose $c<0$ nappe reads $\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^3$, false at every sphere product.*"

and [results.md](../results.md):276 writes the definition as $\Omega_a=\{\operatorname{scal}(R)>0\}\cap F^{-1}(\cdot)$, and [HamiltonsCubic/Results/L43.lean](../lean/HamiltonsCubic/Results/L43.lean) makes it quantitative under the heading "The dropped cone clause". **All three land beside the block, not in it.** Lemma L43's own header names this block as its argument, "The argument is in this file under *'The diagonal case: located in the literature, and it covers less than assumed'*", so the corrected statement and the defective argument are the same result, 390 lines apart in one file, and the argument is the half a consumer reads.

**Candidate stands.** This is the round's named trap, instantiated exactly.

---

## 4. Discrepancy 2, the diagonal-case gap is presented as live, and the record closed it

**Locate it exactly.**

> "So the assumption granted in the problem statement is stronger than anything published, and the gap it papers over ($n=12,14$, and all odd $n$) sits exactly at the threshold under study."

**Exhibit the failure concretely.** [results.md](../results.md):35 states "**The diagonal case is a theorem at every $n\ge4$, both parities, by this record's own argument** (Lemma L57) … The published grant is Jäger's Theorem A at even $n\ge16$, and **the dependence on it is gone**", and :84 says "the grant is a courtesy rather than a dependency", with $n=12,14$ separately closed by Lemma L1. [findings/INDEX.md](../findings/INDEX.md):19 says the same and adds that the grant "is no longer load-bearing". A reader who takes this block as the record's account of the grant, which [findings/INDEX.md](../findings/INDEX.md):45 says it is, listing [problem.md](../findings/problem.md) as the file for "what the granted diagonal case covers in print", comes away believing $n=12,14$ and odd $n$ are open holes at the threshold. They are recorded as closed.

**Argue the opposite.** The sentence is, read strictly, about *the literature*: what is published covers less than what was granted, and that is exactly true and was verified verbatim in §1.2. The block is a literature section and is entitled to report the literature. This is a real defence, and it is why the verdict here is `GAP` rather than `BROKEN`: nothing in the sentence is false about print. What fails is the last clause, "sits exactly at the threshold under study" is a claim about *this programme's* position, not about print, and that claim is stale. One sentence naming Lemma L57 would close it.

**Candidate stands, narrowed to the final clause.**

---

## 5. Discrepancy 3, "Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice", the two pre-registered questions answered

### 5.1 Question 1: are the two statements the same, or does one grant what the other assumes?

**Locate it exactly.**

> "**Scope, stated plainly.** $a=0$ leaves $R_{\mathrm{ric}_0}$ **unconstrained**, so the full cone conjecture is strictly more than Conjecture A; **Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice.** What is settled is that the target constant is right, not that the two statements coincide."

The block names exactly one gap between the two statements (the $R_{\mathrm{ric}_0}$ direction) and asserts that on the slice they coincide.

**Exhibit the failure concretely, in two independent ways.**

*(a) The quantifier.* Conjecture A as this record holds it in print is Nienhaus's, transcribed at [references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):7:

> "Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a **critical point** of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n$. If either $n\ge12$, or $8\le n\le11$ and $W\notin\dots$"

with the note beneath it: "**The criticality hypothesis is part of the conjecture.**" The slice criterion the block derives carries no criticality hypothesis: §2.2's conclusion is quantified over **every** unit Weyl operator, since every such $W$ gives a point $c_0I+W\in\partial\Omega_0$. So the two statements are not the same, and the direction of the difference is the one that matters for use: the slice criterion **implies** Conjecture A on the slice, and Conjecture A does **not** imply the slice criterion. Anyone wanting to conclude cone invariance from Conjecture A needs the extra step "the supremum of $P$ on the unit sphere is attained at a critical point", which is precisely [Lemma L0](../results.md):775, whose own row says its $\Leftarrow$ direction "gives $\sup\le\Theta_n$" and whose Lagrange condition [lean/INDEX.md](../lean/INDEX.md):216 records as "imported".

*(b) The constant, at odd $n$.* The slice criterion demands $\theta_0(n)$ at both parities, the constant $c(n-1)$ having no parity in it. The record's repaired Conjecture A is at $\Theta_n$: [results.md](../results.md):11 says the identification holds "at the constant $\Theta_n$, *refuted at $\theta_0(n)$*", and :775 records that two reviewers on identical briefs both refuted the $\theta_0$ form because at odd $n$ it "asserted Conjecture A's own negation". Exactly, at $n=13$: $\theta_0(13)^2=\tfrac{2\cdot12\cdot11}{169}=\tfrac{264}{169}$ and $\Theta_{13}^2=\tfrac{120}{77}$, and $264\cdot77=20328>20280=120\cdot169$, so $\theta_0(13)^2>\Theta_{13}^2$ strictly. The slice criterion is therefore **strictly weaker** than Conjecture A at every odd $n\ge13$, by §2.5's identity $\theta_0^2-\Theta_n^2=8(n-1)/\big(n^2(n-2)(n+1)\big)$, which never vanishes.

**Argue the opposite.** Two defences are available and both have force. The block's very next sentence hedges ("What is settled is that the target constant is right, not that the two statements coincide") and its "Sharpness at even $n$ only" paragraph says outright that $\theta_0$ is attained only at even $n$ and calls the result "the Conjecture A **bound**, sharp at even $n$", which is the correct careful phrasing and is the repair the record's L0 audit demanded. Second, "Conjecture A" in the literature (Jäger's remark, Beitz's Remark 6.3.15) is stated for **even** $n$ only, so at even $n$ the constants do coincide and (b) is a statement about the record's extension rather than about print.

What neither defence reaches is (a). The criticality hypothesis is in the printed statement the record itself transcribed, the block's sentence asserts coincidence flatly, and the round's own instruction is to read each citable claim alone as a consumer would. Read alone, "Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice" states an identification in both directions that the record separates elsewhere and does not separate here.

**Candidate stands.**

**Answer to Question 1, stated plainly.** *They are not the same statement, and the gap has three components; the block states one of them where a reader would look.* The granted half (Jäger's Theorem A), covers in print: even $n\ge16$, diagonal $W$ only, unit norm, and only operators already satisfying $Q(W)=\theta W$ with $\theta\ge\theta_0(n)$, concluding equality and rigidity. What the conjecture needs is: every $n\ge12$ of either parity, every unit Weyl operator (with criticality as a hypothesis in the printed form), and the constant $\Theta_n$. Between the block's slice criterion and Conjecture A the differences are (i) $R_{\mathrm{ric}_0}$ off the slice (**stated in the block**; (ii) all $W$ against critical $W$), **stated only at [results.md](../results.md):775**, in the L0 row's parenthetical "*The reduction moves the quantifier from $\mathcal W_n$ to the critical set and is separate from the cone bridge of Lemma L43*"; (iii) $\theta_0$ against $\Theta_n$ at odd $n$, **stated in the block's sharpness paragraph but not carried into its scope paragraph**, two paragraphs later.

### 5.2 Question 2: does the $n\ge12$ threshold come from the same place in both?

**Yes, and it is one polynomial, but it enters the two sources as a hypothesis and the block as a conclusion, which is what makes the block's contribution real rather than circular.**

- In print it is a **hypothesis**, twice: Beitz Remark 6.3.15, read at [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf):5626, says "for $n\ge12$ the cones $\Omega_a$ are invariant"; Jäger's remark says "for all even integers $n\ge12$". Neither says why.
- In the block it is a **conclusion**: the padded $W_{\mathbb{CP}^2}$ puts $cI+W$ on $\partial\Omega_0$, and §2.4's arithmetic makes the criterion fail there exactly on $4\le n\le11$.

The two meet because the criterion's demand at that witness is precisely $\sqrt{3/2}\le\theta_0(n)$, i.e. $n^2-12n+8\ge0$, and that is the same polynomial that separates $W_{\mathbb{CP}^2}$ from the balanced sphere product in Conjecture A's own $8\le n\le11$ exception. [lean/INDEX.md](../lean/INDEX.md):51 records the same identification independently and kernel-checked: "one inequality carries three headline results, stated independently in three files". **So there is one threshold, not two**, and the block converts a hypothesis into a conclusion legitimately.

Three caveats, each recorded because it is unstated in the block. First, the necessity is at $a=0$ only; Beitz's conjecture quantifies over $a\in[0,\tfrac n4]$, so necessity at one $a$ does suffice for the conjunction, but the block does not say that is why. Second, the necessity depends entirely on §3, without $\mathrm{scal}>0$ the range is not $4\le n\le11$ but every $n$. Third, the constant in the witness argument is $\theta_0$ at both parities while Conjecture A's odd-$n$ threshold in the record's own [CrossingAll](../lean/HamiltonsCubic/Results/CrossingAll.lean) row crosses $\sqrt{3/2}$ at $n=13$, not $12$; these are different quantities ($\theta_0$ against $\Theta_n$) and the block's claim is about the right one, but a consumer comparing the two files without noticing the substitution would see a contradiction that is not there. The canonical [Lemma L44](../findings/problem.md):200 does state this, "*The criterion demands $\theta_0(n)$ at both parities … $\Theta_n$ is what the diagonal locus attains, never what the criterion demands*", and, again, that statement is beside the block, not in it.

---

## 6. The three forms compared

*Which forms I checked, and what each carries that the others do not.*

| Form | What it says | What it carries that the others do not |
|---|---|---|
| [findings/problem.md](../findings/problem.md):9–111, the block under review | The full derivation: cone form, collapse, $\theta_0$, the witness, off-slice expansion, parity, attributions | **The only place the derivation appears in full.** It alone carries the off-slice ten-triple accounting, the parity inequality, and the convention reconciliation across Beitz/Xu/BW08. It alone **omits** $\mathrm{scal}>0$ |
| [findings/problem.md](../findings/problem.md):497, canonical Lemma L43 | The collapse as a statement, plus three corrections | Carries $\mathrm{scal}>0$ explicitly; carries "the collapse is an identity on the whole slice, not merely a vanishing at the boundary"; carries the Einstein-not-Ricci-flat point; records Gate 2 by two reviewers |
| [results.md](../results.md):100, :274–276, the canon | L43 in one paragraph | Writes $\Omega_a=\{\operatorname{scal}(R)>0\}\cap F^{-1}(\cdot)$, the clause the block drops; names the Einstein slice; notes the collapse "does not reach $a$ strictly between $0$ and $n/4$" |
| [results.md](../results.md):11, :775, Lemma L0 | Problem $P$ and Conjecture A "are one statement, at the constant $\Theta_n$" | **The quantifier gap**, "the reduction moves the quantifier from $\mathcal W_n$ to the critical set and is separate from the cone bridge"; the $\theta_0$-form refutation by two reviewers; that the $\Leftarrow$ direction gives only $\sup\le\Theta_n$ |
| [lean/HamiltonsCubic/Results/L43.lean](../lean/HamiltonsCubic/Results/L43.lean), row at [lean/INDEX.md](../lean/INDEX.md):119 | **partial** | Every binder read. `boundary_ratio` takes `hn : 1 < n`, `hnrm : nrm ≠ 0`, `hbdry`; `ratio_forces_zero` adds `hθ : 0 < θ₀`. The file's own header states what is **not** claimed: "**Owed**: the collapse itself, which needs Böhm–Wilking's $F$ and Beitz's cone, the base layer has no types for either, and the $\lVert\mathrm{ric}(I)\rVert^2$ cancellation stays imported." **So Lean checks the two side-corrections and not the bridge.** Its dropped-cone-clause docstring is the clearest statement of §3's defect anywhere on the record |
| [lean/INDEX.md](../lean/INDEX.md):51–52, :264, :77 | Crossover, SymmetricTheorem, L44, MaxCrossing | The threshold's shared-hinge status, kernel-checked; that the symmetric-space theorem's $n\ge12$ "is not a convenience"; L44's "**Owed**: the padding map, which the record uses to carry the value to every $n$", **an input the block uses silently when it says the padded $W_{\mathbb{CP}^2}$ "keeps $\theta=\sqrt{3/2}$ at every $n$"** |

**A Lean statement cannot hide a hypothesis, and this one does not**: L43.lean's four theorems are pure rational-arithmetic facts about a ratio, and their binders are exactly `1 < n`, `0 < θ₀`, `nrm ≠ 0`. Nothing about cones, $F$, or invariance is inside the kernel. A consumer who reads "L43 is in Lean" and infers the bridge is machine-checked would be wrong, and the row says so plainly.

---

## 7. Quantifier order, scope, and the edges of every range

*Answered item by item, including where I find nothing.*

- **Quantifier order.** The criterion is "$\forall R\in\partial\Omega_0$, $G(R)\le0$"; the collapse turns this into "$\forall$ unit Weyl $W$, $\langle W,Q(W)\rangle\le\theta_0(n)$". The order is correct and the block does not reverse it. **The one quantifier defect is the comparison with Conjecture A**, §5.1(a).
- **The smallest admissible dimension.** The block states no lower bound; its ranges begin at $4$ without a reason. Beitz's family is defined for $n\ge3$. At $n=3$, $\langle W\rangle=0$ and both the derivation and the witness argument are vacuous, so $n\ge4$ is the right floor, but a consumer has to supply it. BW08 Lemma 2.1's proof handles $n=4$ separately and then embeds, so the kernel claim is safe at $n=4$; I checked this at the source. **Finding: an unstated floor, harmless.**
- **Odd $n$.** Addressed by the block's "Sharpness at even $n$ only" paragraph, correctly, and then dropped in the scope paragraph. §5.1(b).
- **Reducible and non-compact cases.** The block is purely algebraic (cones of algebraic curvature operators under an ODE) so reducibility and compactness do not arise in it. They arise for the *symmetric-space* theorem that consumes the same threshold ([results.md](../results.md):36 records that Einstein was load-bearing and had been dropped there). **No finding within this block; the neighbouring row is where that hypothesis lives.**
- **$\ker W\ne0$.** Nowhere restricted, and rightly: the block's own witness is a zero-padded $W_{\mathbb{CP}^2}$, whose kernel has dimension $\binom n2-\binom42$ at $n>4$. Degenerate $W$ is squarely inside the statement. **No finding.**
- **The boundary versus the interior.** The collapse holds on the whole slice (§2.2) and is weakest at $\partial\Omega_0$, so the block's restriction to the boundary loses nothing. The block does not say this; L43 does. **No defect, an omission of the reason.**
- **$\mathrm{ric}(R)=0$.** $F$ is undefined on pure Weyl tensors, they are where the denominator vanishes. The block's phrase "the Weyl tensor itself does not [sit on $\partial\Omega_0$]" is correct but gives no reason; [Lemma L44](../findings/problem.md):200 supplies it ("having $\mathrm{ric}=0$, which is where $F$ blows up and $\Omega_0$ is undefined"). **Beside, again.**

---

## 8. Silence, discharged

*Items I checked and on which I have no finding, stated so that the silence is not mistaken for an omission.*

- **No finding: the collapse uses no hypothesis the statement omits, beyond $\mathrm{scal}>0$.** §2.2 is an identity; I rebuilt it and it needs only bilinearity of $\Phi$, $\Phi(I,W)=0$, $\mathrm{tr}\,Q(W)=0$, and $\mathrm{ric}(W)=0$. The block's claim that the full symmetry of $T$ is not load-bearing is **correct**: nothing above uses $T(A,B,C)=T(B,C,A)$.
- **No finding on the convention arithmetic.** Beitz's $F(I)=\tfrac2{n-1}$ is verbatim at :5534 with $\|I\|^2=\tfrac{n(n-1)}2$ and $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$; Xu's $F(I)=\tfrac1{2(n-1)}$ is verbatim at :813; the ratio is $4$ and the block's explanation (Xu's $\mathrm{Ric}$ is twice Beitz's $\mathrm{ric}$, so $F$ scales by $\tfrac14$) is confirmed independently by the two thresholds, $\tfrac4{n-2+4a}$ against $\tfrac1{n-2+4a}$. The block's warning that this "is load-bearing for any figure quoting $\lVert\mathrm{ric}\rVert$ or $\mathrm{scal}$ across the two sources" is right and I verified that it genuinely cancels in §2.2.
- **No finding on the fabricated-citation caution.** The block records that a search layer invented a "Conjecture A" mention in arXiv:2407.13847 and that the phrase does not occur. That is a caution, not a claim, and it is the right discipline; I did not need to re-check it because nothing rests on it.
- **No finding on Xu's status.** The block classifies its own off-slice expansion as agreement rather than novelty and traces it to Huisken via Xu. Verified verbatim: Xu writes "this identity was not written down as an independent lemma in [16]". The block's self-classification is accurate.
- **Not checked, and it matters to no claim here:** that Beitz's $\mathrm{ric}$ is a factor $\tfrac12$ against BW08's $\mathrm{Ric}$ *by her Definition 1.1.10*. I confirmed the value $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$ from the (6.24) passage directly, which is what §2.2 uses, and it cancels there regardless. I did not read Definition 1.1.10 itself.

---

## 9. What a reader may take from this block

*The round asks for this exactly, because every other row of the record assumes the two statements coincide.*

**A reader may take:**

1. The constant $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is **forced** by Böhm–Wilking's invariance criterion for $\Omega_0$ restricted to the Einstein slice $R=cI+W$ with $\mathrm{scal}(R)>0$, with no sphere product entering the derivation. §2.2–2.3, rebuilt here from the definitions.
2. On that slice, the criterion is **exactly** $\langle W,Q(W)\rangle\le\theta_0(n)\|W\|^3$, with no residue, at every unit Weyl $W$.
3. Given (1)–(2) and the fact that the padded $W_{\mathbb{CP}^2}$ is a unit Weyl operator with $\theta=\sqrt{3/2}$, the cone $\Omega_0$ is **non-invariant for $4\le n\le11$** and the criterion at that witness is satisfied from $n=12$. The threshold is therefore forced, not assumed.
4. Off the slice, one and only one new triple appears, $(Y,Y,W)$, with coefficient $\tfrac3{n-2}$; the resulting identity is Xu's (2.34); and the parity argument on top of it is this record's.

**A reader may NOT take:**

1. That the block's printed cone is Beitz's. It is Beitz's cone with $\mathrm{scal}(R)>0$ deleted, and on the printed one every claim in (3) is false. §3.
2. That the $a=0$ criterion and Conjecture A are the same statement. They differ by the $R_{\mathrm{ric}_0}$ direction (stated), by the criticality quantifier (not stated here), and by the constant at odd $n$ (stated two paragraphs earlier and not carried through). §5.
3. That the bridge is machine-checked. [lean/INDEX.md](../lean/INDEX.md):119 records L43 as **partial** and owes "the collapse itself".
4. That $n=12,14$ and odd $n$ are open in the diagonal case. §4.
5. That the padded $W_{\mathbb{CP}^2}$ "keeps $\theta=\sqrt{3/2}$ at every $n$" is established here. It is asserted; [lean/INDEX.md](../lean/INDEX.md):264 records the padding map as owed.

---

## 10. What would break this block, and what I did to look for it

**The object that would falsify it.** A unit Weyl operator $W_\star$ in some dimension $n_\star\ge12$ with $\langle W_\star,Q(W_\star)\rangle>\theta_0(n_\star)$ and $c_\star I+W_\star$ on $\partial\Omega_0$ with $c_\star>0$: it would refute the block's claim that the criterion's demand is exactly Conjecture A's constant, and would refute the Böhm–Wilking conjecture with it. Equivalently, at the level of the derivation rather than the conjecture: any curvature operator on the slice at which $\Phi(I,W)\ne0$, or any $Q(W)$ carrying a nonzero $\langle\mathrm{Ric}_0\rangle$ component, either of which would leave a residue in §2.2 and break the "no residue at all" claim.

**What I did to look for it.** I rebuilt §2.2 from the definitions rather than checking the block's algebra, so a residue would have shown up as a term I could not cancel; none did, and the cancellation of $\|\mathrm{ric}(I)\|^2$ is exact and structural rather than numerical. I checked $\Phi(I,W)=0$ against BW08 Lemma 2.1 at the source, including its proof's treatment of $n=4$ and its embedding argument for $n\ge5$, so the kernel claim holds at the bottom of the range as well as generically. I checked $Q(W)\in\langle W\rangle$ twice, once through BW08 eq. (6) as the block does and once through Xu Prop. 2.7(4), which proves it independently. I searched the record for a Weyl operator recorded above $\theta_0$ at $n\ge12$ and found the opposite: [results.md](../results.md):7 records everything measured on the non-diagonal side as sitting at or below $\sqrt{3/2}$, and the highest non-diagonal value on file, $S^5\times S^7$ at $1.228239$ ([results.md](../results.md):549), is below $\theta_0(12)$, whose square is $\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}$ against $1.228239^2$, and $\tfrac{55}{36}=1.5\overline{27}$ exceeds $\tfrac{2(n-1)(k-1)(l-1)}{(n-2)kl}$ at $(k,l)=(5,7)$, which is $\tfrac{2\cdot11\cdot4\cdot6}{10\cdot35}=\tfrac{528}{350}=\tfrac{264}{175}$; and $55\cdot175=9625>9504=264\cdot36$, so $\theta_0(12)^2>\theta_{5,7}^2$ strictly, by hand and without a root. **No falsifier found.**

**The source that would falsify it.** A printed statement of Conjecture A without a criticality hypothesis, which would dissolve §5.1(a). I looked in the only three sources that state the conjecture and that this record holds: Beitz Remark 6.3.15 (cone form, no $P$ at all), Jäger's remark after Theorem A (diagonal, even $n\ge12$, quantified over "all operators $W\in\langle W\rangle$", **no criticality**, but also no $\mathbb{CP}^2$ exception and no odd $n$), and Nienhaus (criticality explicit). **Jäger's phrasing is the closest thing to a defeater**, and it cuts the other way for the block: quantified over all $W\in\langle W\rangle$ it is *stronger* than Nienhaus's, so the block's "Conjecture A is its slice" is wrong against one printed form by being too weak and against the other by being too strong. Neither printed form matches the slice criterion.

---

## Verdict

# `GAP`

*The derivation is right and I rebuilt every line of it; two of the block's citable sentences are not, and the record already holds both corrections, beside this block rather than in it.*

**What would have to change for `PROVEN`.** Three sentences, all of which exist elsewhere on the record and none of which requires new mathematics:

1. Restore `and scal(R) > 0` to the cone, in the "equivalent to" sentence, in the $a\to0$ table row, and in the quoted $F$-sublevel definition, and say in one clause that it is what selects $c>0$ in §2.3. The wording is at [findings/problem.md](../findings/problem.md):497.
2. In the scope paragraph, add the quantifier gap alongside the $R_{\mathrm{ric}_0}$ gap, and carry the odd-$n$ constant forward from the sharpness paragraph. The wording is at [results.md](../results.md):775.
3. Add one clause to the "reconciling" paragraph saying that Lemma L57 has since closed the diagonal case at every $n\ge4$, so the gap the grant papers over is a gap in print rather than in the record. The wording is at [results.md](../results.md):84.
