# VERIFY_v202, L21, a cold read

The brief [BRIEF_L21.md](BRIEF_L21.md) was read cold, with [conventions.md](../findings/conventions.md) alongside it. **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation, no re-diagonalisation of the four $F_\lambda$. Every derivation below is closed-form arithmetic performed by hand and written out in full so that a reader can check it without running anything. Log: [agent_logs/verify-L21-v202.log](../agent_logs/verify-L21-v202.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Section A carries a canonical statement | **BROKEN**, a heading and a proof pointer, no statement; the statement is reconstructed at §2 below |
| 2 | Section B's landscape line faithfully summarises it | **BROKEN**, it drops the dimension restriction ("in every dimension") and asserts the one unproved input ("do not vary with $n$") as established |
| 3 | Schur gives $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$ with no multiplicity-free hypothesis | **PROVEN, hypotheses corrected**: multiplicity-freeness is genuinely not needed; **absolute irreducibility is**, is never stated, and holds exactly for $m\ge5$ |
| 4 | The $SO(m)$-type census of $\mathcal W_n$ is six types with multiplicities $20,20,6,10,4,1$ | **PROVEN**, derived here by hand from the block decomposition, valid for every $m\ge5$ |
| 5 | $\dim V_{(2,1)}=\tfrac{m(m-2)(m+2)}3$ and $\dim V_{(2,2)}=\tfrac{m(m+1)(m+2)(m-3)}{12}=\dim\mathcal W_m$ | **PROVEN**, both re-derived, both strictly positive at every $m\ge4$ |
| 6 | The six rows sum to $\dim\mathcal W_n$ identically in $m$ | **PROVEN**, both quartics equal $m^4+16m^3+89m^2+194m+120$, worked in full at §5 |
| 7 | $4\cdot160+1\cdot300=940$ and $698+940=1638$ at $n=12$ | **PROVEN**, every entry recomputed by hand |
| 8 | Fifth row, "$0$ throughout" on the two higher types | **PROVEN**, the degree argument and the image argument are both valid and independent; each is dimension-free |
| 9 | $\mathop{\mathrm{im}}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$ | **PROVEN, notation broken**: true under one reading of the letter $A$, vacuous-and-false under the other, and the sentence uses both |
| 10 | $T_u(SO(n).u)=2\cdot\mathrm{triv}\oplus4\cdot\mathrm{vec}$, $\dim=4n-14$ | **PROVEN, hypotheses corrected**: two unstated inputs, one of which ($A\otimes B$ injective on $u$) is where $\ker u\ne0$ could have bitten; verified here that it does not |
| 11 | $T_u\mathcal O\subseteq E(\tfrac12\theta^*)$ | **PROVEN**, one line from equivariance; equality then rests on claim 13 |
| 12 | The stable range: $n-4\ge8$ (section C) against $n\ge9$ (section D) | **section D is right**; section C's obligation is over-strong, and so is [r485](../reviews/REVIEW_r485.md)'s $m\ge2k$ |
| 13 | Every $\dim M_\lambda$ and every $F_\lambda$ spectrum is identical across $n=10,12,14$ | **$\dim M_\lambda$: PROVEN here. $F_\lambda$ entries: HYPOTHESIS-DEBT**, three sampled dimensions, no argument on file, and no identification of $M_\lambda(n)$ with $M_\lambda(n')$ even proposed |
| 14 | The conclusion is $\alpha\le\tfrac13$ with equality attained | **both, conditional on claim 13**; and neither consumer needs attainment, see §8 |
| 15 | Trace consistency $\mathop{\mathrm{tr}}F_\lambda=0$ in all four blocks | **PROVEN independently**, $\mathop{\mathrm{tr}}F_u=0$ is dimension-free, and the table satisfies it block by block |

**One line.** The representation-theoretic half of L21 is correct and is proved here in closed form for every $n\ge9$, the six-type census, the multiplicities, the dimension identity, the fifth row's vanishing, the orbit's type, but the half the bound actually rests on, that the four $F_\lambda$ carry the tabulated spectra independently of $m$, has **no argument on file at all**, so the verdict is `HYPOTHESIS-DEBT` with the debt named exactly.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md):

- $\mathcal W_n$ is "the space of algebraic Weyl curvature operators on $\mathbb R^n$", with $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, "$10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- $Q(W)=W^2+W^\#$, "sending $\mathcal W_n$ to itself"; $P(W)=\langle W,Q(W)\rangle$; "at a critical point, $Q(W)=\theta W$".
- $\#$ is "the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$". **This is the definition every $\#$ computation below runs on**, and the conventions file warns that "under the other $\#$ in circulation its identity is false rather than rescaled".
- $T$, third sense: "the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$". Full symmetry is used once, at §9.
- $M(n)$: "padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$".

Two objects L21 runs on are **not** in that file and are defined only inline at [route-a.md:131](../findings/route-a.md#L131): "$\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$". $F_u$ is likewise defined only inline, at [route-a.md:139](../findings/route-a.md#L139): $F_u(h)=\tfrac12(uh+hu)+u\#h$, identified at [route-a.md:235](../findings/route-a.md#L235) with $u\circ h$, the polarisation of $Q$. **Both belong in the conventions table and are absent from it.**

Throughout: $\mathbb R^n=A\oplus B$ with $A=\mathbb R^4$ carrying $u$'s support and $B=\mathbb R^m$, $m=n-4$; $G=SO(m)$ acting on $B$ and fixing $A$ pointwise.

## 1. Hypothesis inventory

| # | hypothesis | stated? | used? | status |
| --- | --- | --- | --- | --- |
| H1 | $m=n-4\ge5$, i.e. $n\ge9$ | section D only; section C states $m\ge8$ | yes, throughout | the two statements conflict; §7 settles it for $m\ge5$ |
| H2 | $u$ is padded $W_{\mathbb{CP}^2}$, unit norm, supported in $\Lambda^2A$ | stated | load-bearing everywhere | but [route-a.md:220](../findings/route-a.md#L220) sets $u=W_{\mathcal S^4(\alpha)}$ for the consumer, §10 |
| H3 | $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$ | stated | gives the single eigenvalue $1$ | fine |
| H4 | $F_u$ is symmetric and maps $\mathcal W_n$ to $\mathcal W_n$ | **never stated** | twice, §6 and §8 | true; supplied at §6 |
| H5 | $F_u$ commutes with $G$ | stated, "verified at $3.9\times10^{-15}$" | the whole Schur step | true by a one-line argument, §3 |
| H6 | the $V_\lambda$ occurring are **absolutely** irreducible, $\mathrm{End}_G(V_\lambda)=\mathbb R$ | **never stated** | the Schur step | true for $m\ge5$, **false at $m=2$**, §3 |
| H7 | distinct isotypic components are mutually orthogonal | **never stated** | the fifth-row image argument | true (the inner product is $O(n)$-invariant) |
| H8 | $\dim\mathfrak{stab}_{\mathfrak{so}(4)}(u)=4$ | **never stated** | the orbit's "dimension $2$, trivial type" | asserted nowhere on file; §8 |
| H9 | $A\otimes B\subset\mathfrak{so}(n)$ acts injectively on $u$ | **never stated** | the orbit's "four copies of the vector type" | true; verified here at §8, and it is exactly where $\ker u\ne0$ could have bitten |
| H10 | the four $F_\lambda$ carry the tabulated spectra, with entries independent of $m$ | asserted from three sampled dimensions | **the entire conclusion** | **no argument on file**, §9 |

**A hypothesis stated and never used:** section C's "the types occurring are those in $\bigotimes^k\mathbb R^{n-4}$ for $k\le4$" is correct as a bound on $k$ (each $\Lambda^2\mathbb R^n$ contributes at most two $B$-factors, and $S^2$ of two of them at most four), but the only thing it is used for (converting $k\le4$ into $m\ge2k=8$), is the step §7 refutes. So the hypothesis is used, and used wrongly.

## 2. Section A has no statement, and what it would have to say

[results.md:713-715](../results.md#L713) is a heading followed by a proof pointer with nothing between them. Drawn from the argument as written, the canonical statement has to be:

> **Lemma L21.** Let $n\ge9$ and $m=n-4$. Let $u\in\mathcal W_n$ be the padded $\mathbb{CP}^2$ Weyl operator at unit norm, supported inside $\Lambda^2(\mathbb R^4)\subset\Lambda^2(\mathbb R^n)$, so that $Q(u)=\theta^*u$ with $\theta^*=\sqrt{3/2}$; let $F_u=u\circ(\cdot)$ and $\mathcal O=SO(n)\cdot u$. Then the largest eigenvalue of $F_u$ on $u^\perp\cap T_u\mathcal O^\perp$ inside $\mathcal W_n$ is exactly $\tfrac13\theta^*$. Equivalently $\alpha\le\tfrac13$, with equality attained, at every such $n$, and the proof needs no multiplicity-free hypothesis on any isotypic component.

Three features of that statement are supplied by the argument and appear in neither A nor B: the **range** $n\ge9$, the **identity of $u$** as the padded operator (H2), and that the claim is an equality rather than an inequality.

**Is section B a faithful summary?** No, in two respects.

- **It drops the range.** "holds in every dimension, structurally" is false as written: at $m=4$ ($n=8$) both $\Lambda^2B$ and $V_{(2,2)}=\mathcal W_4$ decompose, and at $m=2$ ($n=6$) the Schur step's stated *form* is false (§3). The record itself records exact verifications at $n=6$ and $n=8$, i.e. at two dimensions outside the range the argument has.
- **It asserts the unproved input as established.** "Four spaces of dimensions $20,20,6,10$ carry every nonzero eigenvalue and do not vary with $n$", the first clause is proved (§6), the second is claim 13, which has no argument on file. B states the debt as a result.

What B gets right: the mechanism ($u$ inside $\Lambda^2\mathbb R^4$ $\Rightarrow$ $SO(n-4)$-equivariance $\Rightarrow$ Schur with no multiplicity-free hypothesis) is a correct description of the argument, and the four dimensions are correct.

## 3. Schur over $\mathbb R$: multiplicity-freeness is not needed, absolute irreducibility is

**The record's step.** $\mathcal W_n=\bigoplus_\lambda M_\lambda\otimes V_\lambda$ $\Rightarrow$ $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$, because "multiplicities are exactly what the spaces $M_\lambda$ absorb".

**Against real Schur.** $F_u$ is a real symmetric operator commuting with $G$. Write $D_\lambda=\mathrm{End}_G(V_\lambda)$, which by the real form of Schur's lemma is $\mathbb R$, $\mathbb C$ or $\mathbb H$. For the isotypic component $\mathcal W_n^{(\lambda)}\cong M_\lambda\otimes_{D_\lambda}V_\lambda$,

$$\mathrm{End}_G\big(\mathcal W_n^{(\lambda)}\big)\;\cong\;\mathrm{End}_{D_\lambda}(M_\lambda).$$

Only when $D_\lambda=\mathbb R$ does this equal $\mathrm{End}_{\mathbb R}(M_\lambda)\otimes\mathrm{Id}_{V_\lambda}$, which is the record's displayed form. When $D_\lambda=\mathbb C$ the general $G$-equivariant endomorphism is $\sum_i(A_i\otimes\mathrm{Id}+B_i\otimes J)$ for the complex structure $J$ on $V_\lambda$, and is **not** of the form $F_\lambda\otimes\mathrm{Id}_{V_\lambda}$; when $D_\lambda=\mathbb H$ likewise with three anticommuting structures. So:

**The step needs absolute irreducibility of each $V_\lambda$, and the record never states it.** Multiplicity-freeness is indeed not needed, the record is right about that, and right about why.

**Does it have absolute irreducibility?** Yes, exactly on the range the argument needs. The types that occur (§4) are trivial, $B$, $\Lambda^2B$, $S^2_0B$, $V_{(2,1)}$, $V_{(2,2)}$: all are single-valued tensor representations of $SO(m)$, realised on real tensor spaces cut out by Young symmetrisers and trace-free projections defined over $\mathbb Q$, with irreducible complexification whenever the row-length condition $\ell(\nu)\le\lfloor m/2\rfloor$ holds. For $\ell(\nu)\le2$ that is $m\ge4$; and at $m=4$ exactly the borderline case $\ell(\nu)=2=\lfloor m/2\rfloor$ splits, $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ and $V_{(2,2)}=\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$. So $D_\lambda=\mathbb R$ for all six types precisely when $m\ge5$.

**Where it fails, concretely.** At $m=2$ ($n=6$) $G=SO(2)$ is abelian: its nontrivial real irreducibles are two-dimensional with $\mathrm{End}_G=\mathbb C$, and the displayed identity $F_u=\bigoplus F_\lambda\otimes\mathrm{Id}$ is simply false there. The record's exact finite-field verification at $n=6$ therefore verifies something the structural argument does not describe. At $m=6$ ($n=10$) the module $\Lambda^3\mathbb R^6$ is real-irreducible of **complex** type ($\star^2=(-1)^{3\cdot3}=-1$); it does not break the argument, because §4 shows it cancels out of $\mathcal W_n$ entirely, but it is the only place a complex-type module comes near this decomposition at an in-range dimension, and the record never mentions it.

**Verdict.** `PROVEN, hypotheses corrected`. Add H6 to the statement and restrict to $m\ge5$.

**A remark on H5.** The equivariance $[F_u,g]=0$ is carried on the record by a floating-point residual $3.9\times10^{-15}$ over generators. It needs no computation: $Q$ is $O(n)$-equivariant, $u$ is fixed by $G$ pointwise (it is supported in $\Lambda^2A$, on which $G$ acts trivially), so $F_u(g\cdot h)=u\circ(g\cdot h)=g\cdot(u\circ h)$. One line.

## 4. The $SO(m)$-type census of $\mathcal W_n$, derived by hand

$\Lambda^2\mathbb R^n=\Lambda_{AA}\oplus\Lambda_{AB}\oplus\Lambda_{BB}$ with $\Lambda_{AA}=\Lambda^2A$ (dim $6$), $\Lambda_{AB}=A\otimes B$ (dim $4m$), $\Lambda_{BB}=\Lambda^2B$. Hence $S^2(\Lambda^2\mathbb R^n)$ splits into six blocks, which I index by the number of $A$-indices ("**degree**"):

| degree | block | as an $SO(m)$-module |
| --- | --- | --- |
| $4$ | $S^2(\Lambda_{AA})$ | $21\cdot\mathrm{triv}$ |
| $3$ | $\Lambda_{AA}\otimes\Lambda_{AB}$ | $24\cdot B$ |
| $2$ | $\Lambda_{AA}\otimes\Lambda_{BB}\ \oplus\ S^2(\Lambda_{AB})$ | $6\cdot\Lambda^2B$; and $S^2(A\otimes B)=S^2A\otimes S^2B\oplus\Lambda^2A\otimes\Lambda^2B=10\cdot(S^2_0\oplus\mathrm{triv})\oplus6\cdot\Lambda^2B$ |
| $1$ | $\Lambda_{AB}\otimes\Lambda_{BB}$ | $4\cdot(B\otimes\Lambda^2B)=4\cdot\big(V_{(2,1)}\oplus\Lambda^3B\oplus B\big)$ |
| $0$ | $S^2(\Lambda_{BB})$ | $S^2(\Lambda^2B)=V_{(2,2)}\oplus\Lambda^4B\oplus S^2_0B\oplus\mathrm{triv}$ |

Now subtract, using the record's own $\mathcal W_n=S^2(\Lambda^2\mathbb R^n)\ominus S^2(\mathbb R^n)\ominus\Lambda^4\mathbb R^n$:

$$\Lambda^4(A\oplus B)=\Lambda^4A\ \oplus\ \Lambda^3A\otimes B\ \oplus\ \Lambda^2A\otimes\Lambda^2B\ \oplus\ A\otimes\Lambda^3B\ \oplus\ \Lambda^4B\;=\;\mathrm{triv}\ \oplus\ 4\cdot B\ \oplus\ 6\cdot\Lambda^2B\ \oplus\ 4\cdot\Lambda^3B\ \oplus\ \Lambda^4B,$$
$$S^2(\mathbb R^n)=S^2A\oplus(A\otimes B)\oplus S^2B\;=\;10\cdot\mathrm{triv}\ \oplus\ 4\cdot B\ \oplus\ S^2_0B\ \oplus\ \mathrm{triv}.$$

Multiplicity by multiplicity:

| type | in $S^2(\Lambda^2)$ | in $\Lambda^4\mathbb R^n$ | in $S^2\mathbb R^n$ | $\dim M_\lambda$ |
| --- | --- | --- | --- | --- |
| trivial | $21+10+1=32$ | $1$ | $10+1=11$ | $32-1-11=\mathbf{20}$ |
| $B$ (vector) | $24+4=28$ | $4$ | $4$ | $28-4-4=\mathbf{20}$ |
| $\Lambda^2B$ | $6+6=12$ | $6$ | $0$ | $12-6=\mathbf{6}$ |
| $S^2_0B$ | $10+1=11$ | $0$ | $1$ | $11-1=\mathbf{10}$ |
| $V_{(2,1)}$ | $4$ | $0$ | $0$ | $\mathbf{4}$ |
| $V_{(2,2)}$ | $1$ | $0$ | $0$ | $\mathbf{1}$ |
| $\Lambda^3B$ | $4$ | $4$ | $0$ | $0$ |
| $\Lambda^4B$ | $1$ | $1$ | $0$ | $0$ |

**The branching reproduces $20,20,6,10$ and the two unnamed multiplicities $4$ and $1$ exactly.** Section D's claim that "the same branching reproduces the block's own multiplicities $20,20,6,10$, so those four are consequences rather than measurements" is **correct**, and it is now checked rather than asserted.

Two robustness points that matter for §7. First, the cancellation of $\Lambda^3B$ and $\Lambda^4B$ is a cancellation of **identical modules** appearing with identical multiplicity in $S^2(\Lambda^2\mathbb R^n)$ and in $\Lambda^4\mathbb R^n$; it is therefore exact whatever those modules decompose into, so the census never needs $\Lambda^3B$ or $\Lambda^4B$ to be irreducible. This matters at $m=5$, where $\Lambda^3\cong\Lambda^2$ and $\Lambda^4\cong B$, and at $m=6$, where $\Lambda^3\mathbb R^6$ is of complex type. Second, the only irreducibility the census consumes is that of the six surviving types, which is $m\ge5$.

**Exhaustion, the load-bearing claim [r484](../reviews/REVIEW_r484.md) flagged, is therefore established**: six types, and no others.

## 5. The two unnamed types, and the identity in $m$

**Dimensions.** $S_{(2,1)}(\mathbb R^m)$ has dimension $\tfrac{m(m^2-1)}3$, and Littlewood restriction gives $S_{(2,1)}|_{SO(m)}=V_{(2,1)}\oplus V_{(1)}$, so $\dim V_{(2,1)}=\tfrac{m(m^2-1)}3-m=\tfrac{m(m^2-4)}3=\tfrac{m(m-2)(m+2)}3$, the record's factored form, and its algebra is right. Independently, from $B\otimes\Lambda^2B=V_{(2,1)}\oplus\Lambda^3B\oplus B$:

$$\dim V_{(2,1)}=\frac{m^2(m-1)}2-\frac{m(m-1)(m-2)}6-m=\frac{m(m-1)(3m-m+2)}6-m=\frac{m(m-1)(m+1)}3-m,$$

which is the same number. ✓ The two routes agree.

$\dim V_{(2,2)}=\tfrac{m(m+1)(m+2)(m-3)}{12}$ is literally the conventions file's $\dim\mathcal W_m=\frac{m(m-3)(m+1)(m+2)}{12}$, so the record's "which is the $\dim\mathrm{Weyl}_m$ formula itself" is **an identity of polynomials**, as claimed, and $V_{(2,2)}=\mathcal W_m$ is the standard identification of the Weyl module with the $SO(m)$-irreducible of highest weight $(2,2)$. ✓

**Positivity at every $m\ge4$.** $\dim V_{(2,1)}(4)=\tfrac{4\cdot2\cdot6}3=16>0$ and $\dim V_{(2,2)}(4)=\tfrac{4\cdot5\cdot6\cdot1}{12}=10>0$; both are increasing in $m$ beyond that. ✓ So the record's "the unnamed rows are a systematic omission and not an accident of $n=12$" is **correct**. (At $m=3$ the second vanishes and the first collides with $S^2_0$, outside the range either way.)

**At $n=12$, $m=8$.** $\dim V_{(2,1)}=\tfrac{8\cdot6\cdot10}3=160$; $\dim V_{(2,2)}=\tfrac{8\cdot9\cdot10\cdot5}{12}=\tfrac{3600}{12}=300$; $4\cdot160+1\cdot300=940$ ✓. The named four: $20\cdot1+20\cdot8+6\cdot28+10\cdot35=20+160+168+350=698$ ✓. And $698+940=1638=\dim\mathcal W_{12}$ ✓.

**The identity in $m$.** With $\dim V$ equal to $1,\ m,\ \tfrac{m(m-1)}2,\ \tfrac{(m-1)(m+2)}2,\ \tfrac{m(m-2)(m+2)}3,\ \tfrac{m(m+1)(m+2)(m-3)}{12}$ at multiplicities $20,20,6,10,4,1$:

$$\Sigma=20+20m+3m(m-1)+5(m-1)(m+2)+\frac{4m(m^2-4)}3+\frac{m^4-7m^2-6m}{12}.$$

Since $5(m-1)(m+2)=5m^2+5m-10$ and $3m(m-1)=3m^2-3m$, the first four terms give $10+22m+8m^2$; over a common denominator $12$,

$$\Sigma=\frac{120+264m+96m^2+16m^3-64m+m^4-7m^2-6m}{12}=\frac{m^4+16m^3+89m^2+194m+120}{12}.$$

Against the target, with $n=m+4$ so that $(n,n-3,n+1,n+2)=(m+4,m+1,m+5,m+6)$:

$$(m^2+5m+4)(m^2+11m+30)=m^4+16m^3+89m^2+194m+120.$$

**Equal, identically in $m$.** ✓ The record's "the sum is $\dim\mathrm{Weyl}_n$ identically in $m$" is **proved**, not sampled. It is worth being clear what this does and does not do: it certifies that the six-row census is **exhaustive**, and it says nothing whatever about any entry of any $F_\lambda$.

## 6. The fifth row: the degree argument and the image argument, checked separately

Both arguments are valid, and they are genuinely independent. Both are dimension-free.

**(a) The degree argument.** $u$ sits in the degree-$4$ block. For the anticommutator, $\tfrac12(uh+hu)$ is nonzero only where $h$ has a row in $\Lambda_{AA}$, so it preserves each of the six blocks and annihilates $S^2(\Lambda_{AB})$, $\Lambda_{AB}\otimes\Lambda_{BB}$ and $S^2(\Lambda_{BB})$. For the $\#$ term, the conventions' definition $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ makes $u\#h$ a combination of $[v,w][v,w']^{\mathsf T}$ with $v\in\Lambda_{AA}=\mathfrak{so}(4)$ and $w,w'$ in the slots of $h$. The bracket table is

$$[\Lambda_{AA},\Lambda_{AA}]\subseteq\Lambda_{AA},\qquad[\Lambda_{AA},\Lambda_{AB}]\subseteq\Lambda_{AB},\qquad[\Lambda_{AA},\Lambda_{BB}]=0,$$

the last being the record's $[\mathfrak{so}(4),\mathfrak{so}(m)]=0$. So $v\in\Lambda_{AA}$ sends each slot to a slot of the same degree-contribution, or to zero. **Hence $F_u$ preserves the degree** ✓, and **$F_u$ annihilates degrees $0$ and $1$** ✓, for degree $1$, one slot lies in $\Lambda_{BB}$ and is bracketed to zero; for degree $0$, both are.

The argument then needs the two higher types to sit **only** in degrees $\le1$. From §4's table: $V_{(2,2)}$ ($|\nu|=4$) needs four $B$-indices, available only in degree $0$; $V_{(2,1)}$ ($|\nu|=3$) needs at least three, available in degrees $0$ and $1$, and degree $0$ is $S^2(\Lambda^2B)=V_{(2,2)}\oplus\Lambda^4B\oplus S^2_0B\oplus\mathrm{triv}$, which contains no $(2,1)$. So $V_{(2,1)}$ occurs only in degree $1$ and $V_{(2,2)}$ only in degree $0$. ✓ **The record's "both higher isotypics sit at degree $0$ and $1$" is correct.**

*A subtlety the record steps over and which does not bite.* The degree grading is not separated by the $O(4)\times O(m)$-action alone (the type $(\mathrm{triv},\mathrm{triv})$ occurs in degrees $0$, $2$ and $4$) so one cannot simply assert that the grading restricts to $\mathcal W_n$ as a direct sum. The argument survives because each of the two types occurs in **exactly one** degree, so its isotypic component is contained in that degree whether or not the grading splits $\mathcal W_n$.

**(b) The image argument.** $\mathop{\mathrm{im}}(u\#\cdot)$ is spanned by $[v,w][v,w']^{\mathsf T}$ with $v\in\Lambda_{AA}$; by the bracket table, $[v,w]\in\Lambda_{AA}$ for $w\in\Lambda_{AA}$, $\in\Lambda_{AB}$ for $w\in\Lambda_{AB}$, and $=0$ for $w\in\Lambda_{BB}$. So $\mathop{\mathrm{im}}(u\#\cdot)\subseteq S^2(\Lambda_{AA})\oplus\Lambda_{AA}\otimes\Lambda_{AB}\oplus S^2(\Lambda_{AB})$. The anticommutator adds $\Lambda_{AA}\otimes\Lambda_{BB}$ and nothing else. Hence

$$\mathop{\mathrm{im}}F_u\;\subseteq\;S^2(\Lambda_{AA})\ \oplus\ \Lambda_{AA}\otimes\Lambda_{AB}\ \oplus\ \Lambda_{AA}\otimes\Lambda_{BB}\ \oplus\ S^2(\Lambda_{AB}),$$

whose $SO(m)$-content is trivial, vector, $\Lambda^2B$, and $\{\mathrm{triv},S^2_0,\Lambda^2\}$ respectively, **carrying neither higher type** ✓. Since $F_u$ is symmetric (H4) and distinct isotypic components are orthogonal (H7), $\ker F_u=(\mathop{\mathrm{im}}F_u)^\perp$ contains both higher isotypics, so $F_{V_{(2,1)}}=0$ and $F_{V_{(2,2)}}=0$. ✓

**A consistency check that falls out.** $V_{(2,1)}$ lives in $\Lambda_{AB}\otimes\Lambda_{BB}=A\otimes(B\otimes\Lambda^2B)$, giving it multiplicity $\dim A=4$, **independently reproducing the record's multiplicity $4$** from a completely different direction than §4's subtraction.

**Verdict on the fifth row: `PROVEN`, twice over, with no dimension in it, exactly as the record claims.** This is the strongest part of L21 and it is sound.

**Discrepancy: the letter $A$ carries two senses inside one sentence.** Located at [route-a.md:189](../findings/route-a.md#L189), the second blockquote of section D. The sentence opens "$F_u$ preserves the $A$-index degree … $u$ carries all four indices in $\mathbb R^4$, so $u\#h$ needs two $A$-indices from $h$", fixing $A=\mathbb R^4$; it closes "$\mathop{\mathrm{im}}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$". *Failure exhibited concretely:* under the opening reading, $AA\oplus AB\oplus BB=\Lambda^2A\oplus(A\otimes B)\oplus\Lambda^2B=\Lambda^2\mathbb R^n$ (all of it) so the containment is vacuously true and the rider "which carries neither type" is **false**, $S^2(\Lambda^2\mathbb R^n)$ containing both; and "$AC$" names nothing, there being no third index set. *The opposite argued:* under the reading $A=\Lambda_{AA}$, $B=\Lambda_{AB}$, $C=\Lambda_{BB}$ with pairs denoting blocks of $S^2$, the displayed set is exactly the four blocks derived above and the claim is true, but then "$u$ carries all four indices in $\mathbb R^4$" is unreadable. *Located, exhibited, opposed:* the collision is real, it is a defect of notation rather than of mathematics, and the repair is to name the blocks explicitly as above. Recorded, not withdrawn.

## 7. The stable range: section D is right, and section C's obligation is over-strong

Section C: "the decomposition is in the stable range once $n-4\ge8$", and closes "The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$". Section D's annotation: the governing bound is on **row length**, every partition having $\ell(\nu)\le2$, so Littlewood restriction needs $m\ge4$ and $SO(m)$-irreducibility $m\ge5$, valid at every $n\ge9$.

**The mathematics supports section D.** §4 derives the census with no appeal to tensor-degree stability at all. What it consumes is exactly three things: (i) $B\otimes\Lambda^2B=V_{(2,1)}\oplus\Lambda^3B\oplus B$ and $S^2(\Lambda^2B)=V_{(2,2)}\oplus\Lambda^4B\oplus S^2_0B\oplus\mathrm{triv}$ as *dimension-correct* decompositions; (ii) irreducibility and pairwise non-isomorphism of the six surviving types; (iii) the module-level cancellation of $\Lambda^3B$ and $\Lambda^4B$, which needs nothing. Condition (ii) is $\ell(\nu)\le\lfloor m/2\rfloor$ with $\ell\le2$, i.e. $m\ge4$ for the restriction rule and $m\ge5$ for irreducibility, since at $m=4$ both $\Lambda^2\mathbb R^4$ and $V_{(2,2)}=\mathcal W_4$ split under $\star$.

Dimension checks at the two boundary values, in closed form:

- $m=5$: $B\otimes\Lambda^2B$ has dimension $50=35+10+5=\dim V_{(2,1)}+\dim\Lambda^3+\dim B$ ✓, and $S^2(\Lambda^2\mathbb R^5)$ has dimension $55=35+5+14+1$ ✓. Both $V_{(2,1)}$ and $V_{(2,2)}$ have dimension $35$ here, **equal dimensions, distinct highest weights**, so a census that identified types by dimension would merge them at exactly the first admissible $n$.
- $m=6$: $90=64+20+6$ ✓ and $120=84+15+20+1$ ✓.

**So the range is $n\ge9$, and section C's stated obligation was over-strong.** So, for the same reason, is [r485](../reviews/REVIEW_r485.md)'s "$m\ge2k$ for $k\le4$, which is $n\ge12$", quoted in the [L20](../findings/route-a.md) block: that is the crude tensor-degree rule, and it is not what the decomposition consumes. Consequently [r484](../reviews/REVIEW_r484.md)'s complaint that the three exact verifications at $n=6,8,10$ all fall outside the range is **partly repaired**: $n=10$ ($m=6$) is inside; $n=8$ ($m=4$) and $n=6$ ($m=2$) remain outside, the latter badly (§3). One of the three exact verifications is in range.

**And the dispute is downstream-inert.** [L20](../findings/route-a.md) draws its contradiction only where $\Theta_n>\theta^*$, i.e. from $n\ge12$; [L134](../findings/route-a.md) is stated for $n\ge12$. Whether L21's range starts at $9$ or at $12$ therefore changes nothing either consumer needs. The contradiction in the record is real and should be resolved in favour of $n\ge9$; nothing else turns on it.

**And, as section D's second annotation says and I confirm:** classical stability governs the type set and the $\dim M_\lambda$ and constrains **no entry of any $F_\lambda$**. §4 gives $\dim M_\lambda=(20,20,6,10,4,1)$ for every $m\ge5$, that half of "the multiplicity spaces do not depend on $n$" is now proved. The other half is §9.

## 8. The orbit, and the direction of the conclusion

**Type and dimension.** As an $SO(m)$-module, $\mathfrak{so}(n)=\mathfrak{so}(4)\oplus(A\otimes B)\oplus\mathfrak{so}(m)=6\cdot\mathrm{triv}\oplus4\cdot\mathrm{vec}\oplus\Lambda^2B$. Then $T_u\mathcal O=\{[\mathrm{ad}\,\xi,u]:\xi\in\mathfrak{so}(n)\}\cong\mathfrak{so}(n)/\mathfrak{stab}(u)$, and:

- $\mathfrak{so}(m)$ kills $u$ (it fixes $\Lambda^2A$ pointwise) ✓, so the $\Lambda^2B$ summand contributes nothing, as claimed.
- $\mathfrak{so}(4)$ contributes $6-\dim\mathfrak{stab}_{\mathfrak{so}(4)}(u)$ trivial copies. The record says $2$, i.e. $\dim\mathfrak{stab}=4$, consistent with $W_{\mathbb{CP}^2}$ being $U(2)$-invariant and $\dim\mathfrak u(2)=4$. **This is H8: asserted nowhere on the record, and I found no proof of it on file.**
- $A\otimes B$ contributes $4m$, i.e. four vector copies, **only if it acts injectively on $u$** (H9), which is nowhere stated. This is exactly the $\ker W\ne0$ trap: padded $u$ has $\ker u\supseteq\Lambda^-\oplus\Lambda_{AB}\oplus\Lambda_{BB}$, of dimension $3+4m+\binom m2$, since $W_{\mathbb{CP}^2}$ is self-dual and so vanishes on $\Lambda^-$. **I checked it and it does not bite.** For $\omega\in\Lambda_{AB}$ one has $u\omega=0$, so $\big([\mathrm{ad}\,\xi,u]\big)\omega=-u\,\Pi_{\Lambda_{AA}}(\mathrm{ad}\,\xi\,\omega)$; taking $\xi=e_1\wedge f$ with $f\in B$, the elements $\mathrm{ad}\,\xi(e_i\wedge f)=\pm\,e_1\wedge e_i$ span $\{e_{12},e_{13},e_{14}\}$, and $a\,e_{12}+b\,e_{13}+c\,e_{14}\in\Lambda^-$ forces $a\,e_{34}+b\,e_{42}+c\,e_{23}=-(a\,e_{12}+b\,e_{13}+c\,e_{14})$, hence $a=b=c=0$. So that span meets $\ker u$ trivially and $[\mathrm{ad}\,\xi,u]\ne0$; by $SO(4)\times SO(m)$-equivariance and irreducibility of $A\otimes B$ under that group, the map is injective on all of $A\otimes B$. ✓

So $T_u\mathcal O=2\cdot\mathrm{triv}\oplus4\cdot\mathrm{vec}$ and $\dim=2+4(n-4)=4n-14$ ✓, **conditional on H8 alone**.

**$T_u\mathcal O\subseteq E(\tfrac12\theta^*)$ is structural and needs no table.** Differentiating $Q(g\cdot u)=g\cdot Q(u)=\theta^*(g\cdot u)$ at $g=e$ gives $2F_u(\dot h)=\theta^*\dot h$ for every $\dot h\in T_u\mathcal O$. The reverse containment (that the $\tfrac12\theta^*$-eigenspace is no larger), is a dimension count against the table: $2$ from the trivial row's $\tfrac12^{\times2}$ and $4m$ from the vector row's $\tfrac12^{\times4}$ times $\dim V=m$, total $2+4m$ ✓, and the $\Lambda^2$ and $S^2_0$ rows carry no $\tfrac12$, matching the orbit's absence of those types. **Block by block the match is exact**, so the record's "the $\tfrac12$-eigenspace *is* the orbit tangent space, block by block" is right, conditional on the table.

**The deletion arithmetic, checked.** Trivial row: $2+6+6+3+2+1=20=\dim M_{\mathrm{triv}}$ ✓; $u$ itself is the eigenvalue $1$ (it is $G$-invariant and $F_uu=Q(u)=\theta^*u$), the orbit takes the two $\tfrac12$'s, top remaining $\tfrac13$ with multiplicity $3$ ✓. Vector: $4+12+4=20$ ✓, orbit takes the four $\tfrac12$'s, top remaining $0$ ✓. $\Lambda^2$: $2+3+1=6$ ✓, top $\tfrac13$ ✓. $S^2_0$: $6+1+3=10$ ✓, top $\tfrac13$ ✓. Attained multiplicity of $\tfrac13\theta^*$ at $m=8$: $3\cdot1+1\cdot28+3\cdot35=3+28+105=136$ ✓, matching the record's "attained on $136$ dimensions at $n=12$". And the seven values $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}$ all occur across the four rows ✓, matching Nienhaus 4.14's full spectrum.

**The direction of the conclusion: it is both, and neither consumer needs the second.** The table, if correct, gives simultaneously $\alpha\le\tfrac13$ and $\alpha=\tfrac13$ somewhere. Reading the consumers:

- [L20](../findings/route-a.md) substitutes $\alpha\le\tfrac13$ into $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ to reach $m\le\psi(\varphi)$, **the bound**, and only the bound.
- [L134](../findings/route-a.md#L225) displays $\tfrac12\mathrm{Hess}(P|_S)_u[H,H]=3\theta^*(\langle L_eH,H\rangle-\tfrac12)\le3\theta^*(\tfrac13-\tfrac12)=-\tfrac{\theta^*}2$, again **the bound**. Concretely: were the true transverse maximum $\tfrac14$ rather than $\tfrac13$, the display would read $3\theta^*(\tfrac14-\tfrac12)=-\tfrac34\theta^*\le-\tfrac{\theta^*}2$ and L134(a) would still hold, a fortiori. **So the brief's framing that L134 "consumes $\tfrac13$ as attained" is not what its own display does.**

What attainment buys is **sharpness, not validity**: it says the radius $0.5748$ and the threshold $\theta^*/(2|\kappa_n|)$ are the exact ones this argument implies rather than conservative ones. The record's own hedge, "the number $0.5748$ needs the exact $\tfrac13$; the qualitative theorem survives for any $a<\tfrac12$", is the correct reading.

## 9. The $n$-independence: three data points, and no argument on file

**What is proved.** §4 proves the type set and $\dim M_\lambda=(20,20,6,10,4,1)$ for every $m\ge5$; §6 proves $F_\lambda=0$ on the two higher types for every $m\ge5$. Both are dimension-free.

**What is not.** That the four surviving $F_\lambda$ have entries (hence spectra), independent of $m$. The record's evidence for this is three sampled dimensions, $n=10,12,14$, produced by diagonalising matrices in floating point, plus exact finite-field work at $n=6,8,10$ of which only $n=10$ is in range.

**The precise shape of the gap.** $M_\lambda(n)=\mathrm{Hom}_{SO(m)}(V_\lambda,\mathcal W_n)$ is a *different vector space for each $n$*, and $F_\lambda$ is an operator on it. To compare $\mathop{\mathrm{spec}}F_\lambda(n)$ with $\mathop{\mathrm{spec}}F_\lambda(n')$ one needs an **identification** $M_\lambda(n)\cong M_\lambda(n')$ intertwining the two operators. **The record proposes none.** Equality of dimensions (which §4 now proves), supplies no such identification and therefore, on its own, licenses nothing about the spectra. The section-D annotation says this in one clause ("classical stability governs the type set and $\dim M_\lambda$, and constrains no entry of $F_\lambda$") and is right.

**So the finding is: this claim has no argument on file.** What would have to be proved, stated so the debt is discharge-able:

1. A natural basis of $M_\lambda$, indexed by a set independent of $m$ (contractions of $A$-tensors with $\delta_B$ and the $\Lambda^2$ pairings), under which
2. every entry of $F_\lambda$ is a rational function of $m$ of bounded degree, and
3. those rational functions are constant, for which the record's own suggestion, "rational rank certificates $\dim\ker(F_\lambda-r\theta^*)$ per claimed eigenvalue, no eigenvectors and no floating point, plus a degree bound in $m$", is the right shape.

[r486](../reviews/REVIEW_r486.md)'s reduction, that $m$ can enter only through $g_m$-normalisations and the trace-free projection, which reach the trivial block alone, leaving one $20\times20$, is a claim about where the debt sits, and I record it as the record's, not mine.

**An independent, dimension-free corroboration, derived here.** $\mathop{\mathrm{tr}}F_u=\sum_i\langle u\circ e_i,e_i\rangle=\sum_iT(u,e_i,e_i)=\langle u,\sum_iQ(e_i)\rangle$ using the full symmetry of $T$ ([conventions.md](../findings/conventions.md), $T$ third sense). The element $\sum_iQ(e_i)\in\mathcal W_n$ is $O(n)$-invariant and $\mathcal W_n$ is $O(n)$-irreducible and nontrivial for $n\ge5$, so $\sum_iQ(e_i)=0$ and **$\mathop{\mathrm{tr}}F_u=0$ at every $n$.** The tabulated spectra satisfy this **block by block**: trivial $-2-1+0+1+1+1=0$; vector $-2+0+2=0$; $\Lambda^2$ $-\tfrac13+\tfrac13=0$; $S^2_0$ $-1+1=0$. Four independent linear conditions, all met, none of them forced by the arithmetic already checked. This is reported as a screen and as corroboration, never as proof of claim 13, vanishing traces are consistent with $m$-dependent entries.

**And the sharpest closed-form test the record has not run.** The tabulated spectra force

$$\frac{\mathop{\mathrm{tr}}(F_u^2)}{\theta^{*2}}=4\cdot1+2\cdot m+\tfrac16\cdot\tfrac{m(m-1)}2+\tfrac12\cdot\tfrac{(m-1)(m+2)}2=4+2m+\frac{m(m-1)}{12}+\frac{(m-1)(m+2)}4,$$

a specific quadratic in $m$ (value $\tfrac{253}6$ at $m=8$). Independently, $\mathop{\mathrm{tr}}(F_u^2)=\sum_{i,j}T(u,e_i,e_j)^2$ is a quadratic $O(n)$-invariant of $u$ on the absolutely irreducible $\mathcal W_n$, hence equals $c(n)\lVert u\rVert^2$ with $c(n)=\lVert T\rVert^2/\dim\mathcal W_n$ and $\lVert T\rVert^2=\sum_{i,j,k}T(e_i,e_j,e_k)^2$ an invariant of the cubic form alone. **A closed form for $\lVert T\rVert^2$ would turn the $m$-independence claim into a single scalar identity in $m$, checkable by hand and independent of every sampled diagonalisation.** The record carries no such closed form, so I name it as the cheapest available discharge rather than closing it.

## 10. The traps, each answered by name

- **$\ker W\ne0$ and padded objects.** Live and load-bearing here: $\ker u$ has dimension $3+4m+\binom m2$, the $3$ coming from $W_{\mathbb{CP}^2}$ being self-dual so that $W^-=0$. It is what makes the anticommutator vanish on three of six blocks (§6a) (the argument *uses* the kernel rather than being endangered by it) and it is the one place the orbit claim could have failed (§8, H9). Checked; survives.
- **$n=9$.** Inside the range, by §7. The tightest point: $V_{(2,1)}$ and $V_{(2,2)}$ both have dimension $35$ at $m=5$, and $\Lambda^3\cong\Lambda^2$, $\Lambda^4\cong B$, the census survives only because the $\Lambda^3,\Lambda^4$ cancellation is module-level.
- **$n=10$.** Inside. $\Lambda^3\mathbb R^6$ is real-irreducible of complex type; it cancels, so H6 is not violated. This is the only exact verification on the record that is in range.
- **$m=4$ ($n=8$).** Outside: $\Lambda^2\mathbb R^4$ and $V_{(2,2)}=\mathcal W_4$ both split, so the six-type census is false there. **$m=5,6$ are inside.**
- **$m=2$ ($n=6$).** Outside, and worse than outside: $SO(2)$ is abelian, $\mathrm{End}_{SO(2)}=\mathbb C$ on every nontrivial real irreducible, so the Schur step's *stated form* fails. The record's exact $n=6$ verification is evidence for a statement, not for this argument.
- **The crossover $n=6+2\sqrt7\approx11.29$.** It plays no role inside L21, which is a spectral statement at each $n$ separately. Its effect is to make §7's range dispute inert: both consumers run at $n\ge12$.
- **A claim proven on a subfamily and used in general.** This is the central defect, §9: three sampled dimensions for all $n\ge9$. Note that the record states the subfamily honestly ("$n{=}10/12/14$" in both table headers) and then draws the general conclusion in the surrounding prose without marking the step.
- **A hypothesis stated but never used.** Section C's $k\le4$ bound: correct, and its only use is the step §7 refutes.
- **A step using a hypothesis never stated.** Five: H4, H6, H7, H8, H9 (§1). Of these, H6 is the one that would change the shape of the argument if it failed, and H8 is the one still without a proof anywhere on file.
- **A universal claim with no witness.** "the sum is $\dim\mathrm{Weyl}_n$ identically in $m$" is universal, and §5 supplies the witness in closed form. "Every $F_\lambda$ spectrum is identical" is universal and has no witness, §9.
- **An imported theorem whose hypotheses were never checked.** Two. *Nienhaus 4.14*, the record itself, at [route-a.md:139](../findings/route-a.md#L139), states that the citation does not carry the claim and that 4.14's own Schur step needs multiplicity-freeness; L21 exists to replace it, and does replace it for the parts §4-§6 prove. *Real Schur's lemma*, imported by L21 itself, with its hypothesis (absolute irreducibility) unchecked: the same failure mode one level down (§3). **The unital-algebra trap is not present**: L21 cites no algebra theorem, and $\mathcal W_n$'s lack of a unit is nowhere consumed here.
- **Symbol collisions from [conventions.md](../findings/conventions.md).** $\alpha$, here $\sqrt{2/3}\langle F_uV,V\rangle$, against the cubic coefficient and the eigenframe index the conventions table flags. $u$, here the competitor, against "the orbit acceleration $u$" in the conventions' $\Pi$ row. $F$, here $F_u$, against L17's equality cone $\{F=0\}$ **in the same file**, and against the cone threshold $F=\tfrac4{n-2+4a}$. $M_\lambda$, against $M(n)$ the global maximum and against $M$ the sectional matrix. $\theta^*$, consistent, but **absent from the conventions table**. And **$m$**: $n-4$ in sections C and D, and $\sqrt{2/3}\max P$ in L20's proof. The worst instance is one sentence of section E which uses both: *"that their entries do not depend on $m=n-4$. And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them."* Two senses of $m$, twelve words apart. Plus the local $A$ collision of §6.
- **Which object $u$ is.** [route-a.md:220](../findings/route-a.md#L220) sets $u=W_{\mathcal S^4(\alpha)}$ for L134 while L21 runs on padded $W_{\mathbb{CP}^2}$; the record's own escalation note says [problem.md](../findings/problem.md) distinguishes them and [second-order.md](../findings/second-order.md) equates them. **L21's argument has no premise at all unless $u$ is supported in $\Lambda^2\mathbb R^4$**, without that, $SO(n-4)$ does not fix $u$, $F_u$ does not commute with it, and there is no isotypic decomposition. This is already escalated on the record and I confirm it rather than reporting it as new: L21 commits to the padded reading.

## 11. What would break it, and what I did to look

**The falsifier.** A unit $h\in\mathcal W_n$ at some $n\ge9$ with $h\perp u$, $h\perp T_u\mathcal O$ and $\langle F_uh,h\rangle>\tfrac13\theta^*$. By §3-§6 such an $h$ can be taken inside a single isotypic component and, by §6, that component is one of the four named ones. So the falsifier reduces to: **an $m\ge5$ at which one of the four matrices $F_{\mathrm{triv}}(m)$, $F_{\mathrm{vec}}(m)$, $F_{\Lambda^2}(m)$, $F_{S^2_0}(m)$ (of sizes $20,20,6,10$), has an eigenvalue exceeding $\tfrac13\theta^*$ on the complement of the $1$- and $\tfrac12$-eigendirections.** By [r486](../reviews/REVIEW_r486.md)'s reduction the trivial block is where to look first.

**What I did to look for it.** No computation of any kind, the programme is analysis-only and this round carries no per-task approval, and re-diagonalising the sampled $F_\lambda$ is precisely the move the brief forbids. Instead I checked, by hand and in closed form, every consequence the record's table has that does not require its entries: the six-type census and its exhaustion (§4), the two unnamed dimensions and their positivity (§5), the quartic identity $\Sigma=\dim\mathcal W_n$ in $m$ (§5), the arithmetic $698+940=1638$ and $4\cdot160+300=940$ (§5), each row's multiplicities summing to its $\dim M_\lambda$ (§8), the $136$-dimensional $\tfrac13$-eigenspace at $n=12$ (§8), the orbit's type, dimension $4n-14$ and injectivity on $A\otimes B$ (§8), the vanishing of $F_u$ on the two higher types by two independent routes (§6), and the blockwise trace identity $\mathop{\mathrm{tr}}F_\lambda=0$ against the dimension-free $\mathop{\mathrm{tr}}F_u=0$ (§9). **Every one of them holds.** None of them can exclude the falsifier, because all of them are statements about the *decomposition* and none constrains a single entry of a single $F_\lambda$. The one closed-form test that would bite is the $\mathop{\mathrm{tr}}(F_u^2)$ identity of §9, and it needs a closed form for $\lVert T\rVert^2$ that the record does not carry.

## Verdict

**`HYPOTHESIS-DEBT`.**

The lemma's structural half is correct and is now proved rather than sampled: for every $n\ge9$, $\mathcal W_n$ carries exactly six $SO(n-4)$-types with multiplicities $20,20,6,10,4,1$; the two higher types are annihilated by $F_u$ outright, by an argument with no dimension in it; the Schur step is valid with no multiplicity-free hypothesis, once absolute irreducibility is added to the statement; the orbit is $2\cdot\mathrm{triv}\oplus4\cdot\mathrm{vec}$ of dimension $4n-14$ and lies inside the $\tfrac12\theta^*$-eigenspace structurally; and the six rows sum to $\dim\mathcal W_n$ identically in $m$.

**The half the bound rests on has no argument on file.** That the four surviving $F_\lambda$ carry the tabulated spectra, and that their entries do not move with $m$, is supported by three sampled dimensions and by no derivation; and no identification of $M_\lambda(n)$ with $M_\lambda(n')$ (without which the spectra at two dimensions are not even comparable), is proposed anywhere. Until that is supplied, $\alpha\le\tfrac13$ is an assertion with a proof of everything around it.

**Corrections the record owes, in order of size.**

1. **Section A must state the lemma.** §2 gives the statement its own argument supports, including the range $n\ge9$ and the identification of $u$.
2. **The canonical table has six rows**, naming $V_{(2,1)}$ at multiplicity $4$ and $V_{(2,2)}=\mathcal W_{n-4}$ at multiplicity $1$ with spectrum $0$. Section C's five-row table is the closer of the two; section D's four-row table omits $940$ of $1638$ dimensions while its neighbouring sentence claims "multiplicities summing to $\dim\mathrm{Weyl}_n$ exactly", which is false against its own table and true against the six-row one.
3. **The stable range is $n\ge9$**, on row length; section C's closing obligation and [r485](../reviews/REVIEW_r485.md)'s $m\ge2k$ are both over-strong, and the dispute changes nothing for [L20](../findings/route-a.md) or [L134](../findings/route-a.md), which run at $n\ge12$.
4. **Section B is not a faithful summary**, it drops the range and states the debt as a result.
5. **Add H4, H6, H7, H8, H9 to the hypotheses**, and $\theta^*$ and $F_u$ to [conventions.md](../findings/conventions.md).
6. **Repair the $A$-collision** of §6 by naming the four blocks.
7. **L134 consumes the bound, not the attained value**, the record's own display uses $\le$, so the "consumes the numerical $\tfrac13$" description overstates what it needs; attainment governs sharpness of the radius and the threshold only.
