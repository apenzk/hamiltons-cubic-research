# Review r556, Lemma L54, the two diagonals and rigidity at $t=2$

Reviewer r556, independent adversarial audit. Target: `Lemma L54, the two diagonals, and rigidity at $t=2$` in [findings/bispectral.md](../findings/bispectral.md), together with the section `Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall` that the block points at.

Analysis-only footing: no computation was run beyond screens of claims about to be recorded, and any screen is labelled as such.

## Status

**Complete.** Overall verdict at the foot of the file.

## Verdict summary

| # | defect | verdict |
| --- | --- | --- |
| 1 | The block names **NPW's** basis $\{\varphi_{ij},\psi_k\}$, in which its own norm identity $\sum d^2=\tfrac32t$ is **false**. NPW's $\psi_k$ is an explicit staircase basis fixed independently of $W$; the identity needs the $\psi$'s to be $K$'s eigenvectors. Hand witness at $n=4$, $t=2$ below. | **REFUTED as written, REPAIRABLE** |
| 2 | "$t\le2$ with equality exactly when $W$ is coordinate-diagonal **in some frame**" substitutes the extremal $\max_Ft_F$ into a frame-wise argument | **REPAIRED** (say $t_F$, "in that frame") |
| 3 | "identically in $n$" and "at EVEN $n$ only" attached to the same display | **REPAIRED** (the identity is parity-free; the *relevance* is even-only) |
| 4 | The $\varphi$-diagonal claim is presented as measured; it is a three-line derivation | **CONFIRMED, and derived here** |
| 5 | The cap $\mu_1(K)\le\sqrt{t(n-2)/(n-1)}$ and its equality case | **CONFIRMED, equality case derived at $S^m\times S^m$** |
| 6 | $t\le2$ is unnumbered, its proof living only in a blockquote of [conventions.md](../findings/conventions.md) | **finding, not a defect in L54** |
| 7 | NPW Prop 3.10's $\psi_k$ is transcribed into [references/…/notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) with the paper's own typo: as printed it is neither trace-free nor unit-norm | **REPAIRED** ($-k\mapsto-(n-k)$) |
| 8 | $\varphi$ names two different objects inside one sentence of the block; $d$ names two different things inside [bispectral.md](../findings/bispectral.md) | **finding** |

## The definitions I fixed before deriving

From [conventions.md](../findings/conventions.md):

- **Index order** is Li's $iklj$: $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with $u\odot v=u\otimes v+v\otimes u$.
- **$K$** is symmetric hollow $n\times n$, $K_{ab}=W_{abab}$ for $a\ne b$, and **$t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ over ORDERED pairs**.
- **$\mu=\operatorname{spec}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$, so $\sum\mu^2=1$; $\omega=\operatorname{spec}(\mathring W)$, $\sum\omega^2=3$.**
- **$\theta_0(n)^2=2(n-1)(n-2)/n^2$**, and **$\Theta_n$ is the DIAGONAL maximum**, equal to $\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$.
- **$M$ carries two objects** (the $\Lambda^2$ operator and the sectional matrix) and $\mathring W$ is the $S^2_0$ operator. L54 uses $M$ in the first sense.

**What the conventions file leaves undefined, and L54 needs.** $d$, $d_\varphi$, $d_\psi$ appear in no row of [conventions.md](../findings/conventions.md); they are introduced only inside [bispectral.md](../findings/bispectral.md), and inconsistently, at [bispectral.md:41](../findings/bispectral.md#L41) the full $\mathring W$ diagonal is called $K'=(K,d)$, so there **$d$ is the $\psi$-part alone**, while from [bispectral.md:256](../findings/bispectral.md#L256) onward $d=(d_\varphi,d_\psi)$ is the **whole** diagonal. Both spellings are live in one file. Same class as the $\mu$, $B$ and $M$ collisions the conventions file already tables.

**And $\varphi$ names two objects inside the block's own single sentence.** "$\varphi_{ij}$" of the NPW basis is $(e_i\odot e_j)/\sqrt2\in S^2_0$; "the $\varphi$-basis of $\Lambda^2$" is the bivector basis $e_i\wedge e_j$ that [conventions.md](../findings/conventions.md) writes $\varphi_{ab}=E_{ab}-E_{ba}$. Two spaces, one letter, twenty words apart.

## 1. Does the block state its heading's claim, and is its proof reachable?

**The pointer is correct; the argument at the far end is not the block's.** The block at [bispectral.md:444](../findings/bispectral.md#L444) is a locator plus one sentence; the section it names, `Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall`, sits at [bispectral.md:254](../findings/bispectral.md#L254), 190 lines above. That section does carry the mathematics, but the rigidity sentence itself is **not** in it. It is in the *next* section, [bispectral.md:305](../findings/bispectral.md#L305), under `Both-sided Schur–Horn: the two diagonals rebuilt`. So the block's own headline clause is proved in a section the block does not name.

**And the section the block does name uses $\mu$ in a different sense than the block does.** At [bispectral.md:258](../findings/bispectral.md#L258) the section's chain reads $\mu=-\omega_{\min}\ge\mu_1(K)$, $\mu$ a **scalar**. The block's $\mu\succ d_\varphi$ and $\sum\mu^2=1$ need $\mu=\operatorname{spec}(M)$ on $\Lambda^2$, a **vector**. A block whose entire argument is a pointer sends its reader into a passage where its principal symbol means something else. [conventions.md](../findings/conventions.md) already tables this collision; L54 is the block it damages most, because L54 has nothing but the pointer.

## 2. The two diagonals, rebuilt from the definitions

Fixing $u\odot v=u\otimes v+v\otimes u$, so $\varphi_{ab}=(E_{ab}+E_{ba})/\sqrt2$ with $\lVert\varphi_{ab}\rVert_F=1$, and Li's order $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$.

**The $\varphi$-diagonal, in three lines and with no measurement.** With $h=\varphi_{ab}$, $h_{kl}=(\delta_{ka}\delta_{lb}+\delta_{kb}\delta_{la})/\sqrt2$, so

$$(\mathring Wh)_{ab}=\tfrac1{\sqrt2}\bigl(W_{aabb}+W_{abab}\bigr)=\tfrac1{\sqrt2}W_{abab},$$

the first term dying on the antisymmetry of the first index pair, and $(\mathring Wh)_{ba}=\tfrac1{\sqrt2}W_{baba}=\tfrac1{\sqrt2}W_{abab}$. Hence $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=\tfrac1{\sqrt2}\bigl[(\mathring Wh)_{ab}+(\mathring Wh)_{ba}\bigr]=W_{abab}=K_{ab}$. **So brief question (6) resolves in the record's favour: the claim is derived, not measured**, it needs only the pair antisymmetry, holds for every algebraic curvature tensor and every $n$, and the script cites and the $2\times10^{-16}$ residuals in [bispectral.md:256](../findings/bispectral.md#L256) are corroboration of a three-line identity rather than its grounds. The same computation is NPW Proposition 3.10's own "straightforward computation".

**The $\Lambda^2$ side is the same computation one degree down.** $\langle M\varphi_{ab},\varphi_{ab}\rangle=W_{abab}=K_{ab}$ with $\varphi_{ab}=e_a\wedge e_b$ orthonormal under the half-trace pairing [conventions.md](../findings/conventions.md) fixes. Derived, not measured.

**The diagonal block.** For $h=\operatorname{diag}(v)$ and $h'=\operatorname{diag}(w)$, $(\mathring Wh)_{ij}=\sum_kW_{ikkj}v_k$, so

$$\langle\mathring Wh,h'\rangle=\sum_{i,k}W_{ikki}v_kw_i=-\sum_{i,k}K_{ik}v_kw_i=-w^{\mathsf T}Kv,$$

using $W_{ikki}=-K_{ik}$ for $i\ne k$ and $W_{iiii}=0$. So $\Pi_{\mathrm{diag}}\mathring W\Pi_{\mathrm{diag}}=-K$, and since $K\mathbf1=0$ (trace-freeness of $W$: $\sum_bW_{abab}=\mathrm{Ric}_{aa}=0$) this restricts to $-K\vert_{\mathbf1^\perp}$ on the traceless diagonal part. **Confirmed, and again derived rather than measured.**

## 3. Finding 1, the block names a basis in which its own norm identity is FALSE. REFUTED as written.

**NPW's $\psi_k$ is an explicit staircase basis, fixed before $W$ is looked at.** [Proposition 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) reads, in the paper's own notation,

$$\psi_k=\frac1{\sqrt{(n-k+1)(n-k)}}\Bigl(-(n-k)\,e^k\otimes e^k+\sum_{l=k+1}^ne^l\otimes e^l\Bigr),\qquad k=1,\dots,n-1 .$$

These depend on the frame alone. **The identity $\sum d_\psi^2=t$ holds precisely when the $\psi$'s diagonalize $K$**: for any orthonormal basis $\{v_k\}$ of $\mathbf1^\perp$, $\sum_k\langle Kv_k,v_k\rangle^2\le\lVert K\vert_{\mathbf1^\perp}\rVert_F^2=t$ with equality only in an eigenbasis. The section knows this and says so twice, *"the $\psi$'s **may be taken as** $K$'s eigenvectors"* at [bispectral.md:236](../findings/bispectral.md#L236), *"**Taking** the $\psi$'s as $K$'s eigenvectors"* at [bispectral.md:302](../findings/bispectral.md#L302). **The numbered block drops the hypothesis and replaces it with a named basis that violates it.**

**Witness, by hand, at $n=4$ and at $t=2$, the rigidity case itself.** Every $K\in\mathcal D_4$ has $K_{12}=K_{34}=a$, $K_{13}=K_{24}=b$, $K_{14}=K_{23}=c$ with $a+b+c=0$; take $a=\tfrac12$, $b=-\tfrac12$, $c=0$, which is a genuine coordinate-diagonal Weyl tensor. Then $\lVert K\rVert_F^2=t=2$, and $K$'s eigenvalues on $\mathbf1^\perp$ are $2a,2b,2c=1,-1,0$, so the **eigenvector** choice gives $\sum d_\psi^2=2=t$ and $\sum d^2=\tfrac32t=3=\sum\omega^2$, as the section claims.

In NPW's basis, with $\psi_1\propto(-3,1,1,1)$, $\psi_2\propto(0,-2,1,1)$, $\psi_3\propto(0,0,-1,1)$ as diagonal vectors, the same $K$ gives

| | $\psi_1$ | $\psi_2$ | $\psi_3$ | $\sum d_\psi^2$ |
| --- | --- | --- | --- | --- |
| $-\psi_k^{\mathsf T}K\psi_k$ | $0$ | $-\tfrac12$ | $+\tfrac12$ | $\tfrac12$ |

against $t=2$. So $\sum d^2=\tfrac t2+\tfrac12=\tfrac32$, **not** $\tfrac32t=3$. The block's premise "equal norms on both sides" fails in the basis the block names, at the very configuration the block's conclusion is about, and with $\sum\omega^2=3$ against $\sum d^2=\tfrac32$ the conclusion $\omega=d$ is false there too.

*(Reproduced by a route sharing nothing with the file's: $\mathcal D_4$ solved from the row-sum equations by hand, the $\psi_k$ read off NPW's printed formula, three $2$-by-$2$ Rayleigh quotients evaluated by hand. No script, no sample.)*

**Repair, one clause.** Replace *"In the Nienhaus–Petersen–Wink basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$"* by *"In the orthonormal basis of $S^2_0$ given by NPW's $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ together with the eigenvectors of $K$ on $\mathbf1^\perp$"*. Everything else in the block survives verbatim. **The $\varphi$ half of NPW's basis is the right one and needs no change**; only the $\psi$ half must be re-chosen per $W$.

**It propagates to the report.** [report/sections/06b-bispectral.tex:131](../report/sections/06b-bispectral.tex#L131) carries the block's sentence word for word, so the printed PDF states the same false thing. [results.md:252](../results.md#L252) and [results.md:728](../results.md#L728) likewise.

**Verdict: REFUTED as written; REPAIRED by the one clause above.** The mathematics the block is trying to state is correct.

## 4. Finding 2, the frame quantifier. REPAIRED.

The block says *"$t\le2$ with equality exactly when $W$ is coordinate-diagonal in some frame"*. What [conventions.md](../findings/conventions.md) proves is the **frame-wise** statement: $t_F=2\lVert\operatorname{diag}_FM\rVert^2\le2\lVert M\rVert_F^2=2$ by Cauchy–Schwarz, with equality iff $M$ is diagonal in the pair basis of $F$. The rigidity argument then needs $t$ and $d$ read in **one and the same** frame; substituting $t=\max_Ft_F=2$ while evaluating $d$ in an arbitrary frame is exactly the trap [conventions.md](../findings/conventions.md) records under *"$t$ IS PER-FRAME UNLESS SAID OTHERWISE"*. Write $t_F=2$ and "diagonal in **that** frame". **The conclusion survives** (the maximising frame is the one to work in) and both directions of the "exactly when" are one Cauchy–Schwarz equality case, so the two implications the brief asks about are both discharged by the same line.

## 5. Finding 3, "identically in $n$" against "at EVEN $n$ only". REPAIRED.

**The displayed identity is parity-free.** Substituting $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$,

$$\frac{n\,\theta_0(n)}{n-1}=\frac{\sqrt{2(n-1)(n-2)}}{n-1}=\sqrt{\frac{2(n-2)}{n-1}},$$

at every integer $n\ge3$, with no parity anywhere in it. The section at [bispectral.md:266](../findings/bispectral.md#L266) prints the display with **identically in $n$**, then opens the next line with **at EVEN $n$ only**, attaching the restriction to the identity. **So the brief's reading is right: an identity that always holds is being conflated with a relevance that holds only at even $n$.** What is even-only is that $\theta_0(n)$ is the value to beat; at odd $n$ the target is $\Theta_n$, and the section's own ratio is correct,

$$\frac{\mathrm{cap}^2}{\bigl(\tfrac n{n-1}\Theta_n\bigr)^2}=\frac{2(n-2)}{n-1}\cdot\frac{(n-1)(n+1)(n-2)}{2n^2(n-3)}=\frac{(n-2)^2(n+1)}{n^2(n-3)}=\frac{n^3-3n^2+4}{n^3-3n^2}>1,$$

reproduced here independently and matching the file digit for digit. **The wrong sentence is the bolded "at EVEN $n$ only" as placed.** It should read: the identity holds at every $n$; what is even-only is that reaching $n\theta_0(n)/(n-1)$ suffices.

## 6. Finding 4, the cap and its equality case. CONFIRMED.

$K$ symmetric, $K\mathbf1=0$, $\lVert K\rVert_F^2=t$ gives $n-1$ eigenvalues on $\mathbf1^\perp$ with $\sum\lambda_i=\operatorname{tr}K=0$ and $\sum\lambda_i^2=t$. Then $\lambda_1=-\sum_{i\ge2}\lambda_i$ and Cauchy–Schwarz gives $\lambda_1^2\le(n-2)\sum_{i\ge2}\lambda_i^2=(n-2)(t-\lambda_1^2)$, so

$$\mu_1(K)\le\sqrt{\frac{t(n-2)}{n-1}},$$

with **equality iff $\lambda_2=\dots=\lambda_{n-1}$**. Confirmed.

**And the equality case is attained, by derivation rather than by the file's measurement.** At $S^m\times S^m$ with $n=2m$ and $W=G^{(1)}+G^{(2)}-cG$, $c=(m-1)/(2m-1)$, the sectional matrix is $K=\bigl(\begin{smallmatrix}A&B\\B&A\end{smallmatrix}\bigr)$ with $A=(1-c)(J_m-I_m)$ and $B=-cJ_m$. Its spectrum is $0$ on $(\mathbf1,\mathbf1)$, $(m-1)+c=2m(m-1)/(2m-1)$ on $(\mathbf1,-\mathbf1)$, and $-(1-c)=-m/(2m-1)$ with multiplicity $2m-2$ on $\{(u,\pm u):u\perp\mathbf1\}$. **The $2m-2$ lower eigenvalues on $\mathbf1^\perp$ are all equal**, which is exactly the equality condition, and indeed $\lVert K\rVert_F^2=2m^2(m-1)/(2m-1)$ makes $\sqrt{t(n-2)/(n-1)}=2m(m-1)/(2m-1)=\mu_1(K)$. The row sums vanish identically, which independently confirms the record's $c$.

**The chain around it is correct too.** $-d_{\min}=\max\{\max_{a<b}(-K_{ab}),\mu_1(K)\}$ follows from $d_\psi=-\operatorname{spec}(K\vert_{\mathbf1^\perp})$; $\omega\succ d$ gives $\omega_{\min}\le d_{\min}$; and the five-line unconditional cap at [bispectral.md:272](../findings/bispectral.md#L272) checks out line by line, $h=\operatorname{diag}(v)$ in its own eigenframe, $\langle\mathring Wh,h\rangle=-v^{\mathsf T}K^Fv$ by §2 above, $t_F\le2$ in **every** frame, so $\mu\le\sqrt{2(n-2)/(n-1)}$ **unconditionally in $n$ and in $W$**. The identity $\mu=\max_F\mu_1(K^F)$ also holds, the $\ge$ half coming from the chain at every $F$ and the $\le$ half from the eigenframe of $h$, **and the $\ge$ half is another place the $K$-eigenvector choice of $\psi$ is load-bearing.**

## 7. The external report, and what the record owns

**The record proves its cap independently, and the two agree where they overlap.** the external report (unpublished, held in the private record) reaches $\mu^2\le2(n-2)/(n-1)$ **for even $n$** through a fourth-moment lemma; the record's five lines at [bispectral.md:272](../findings/bispectral.md#L272) reach the same inequality through $K\mathbf1=0$ in the bottom eigenvector's own eigenframe, by a different route, and are self-contained. **So [bispectral.md:280](../findings/bispectral.md#L280) is right that the record does not lean on that document for this.**

**But "exactly the second-kind projection estimate" over-claims by one parity.** The external report's odd-$n$ statement is the strictly sharper

$$\mu^2\le\frac{2n^2(n-3)}{(n-1)(n+1)(n-2)},$$

which is precisely $\tfrac{n-1}n\mu\le\Theta_n$, the form [target.md:266](../findings/target.md#L266) actually consumes in the dichotomy $\mathrm{CD}_n$. The record's cap is the **even half** of the projection estimate; the odd half is neither proved nor reproduced here. The section says as much three paragraphs later (*"Its reach is EVEN $n$"*), so the file contradicts itself within one screen: line 280 identifies the cap **with** the estimate, and line 286 restricts it to half of it. **Repair: line 280 should read "which is the even-$n$ half of the second-kind projection estimate".**

## 8. What cites it, and whether the uses are inside its hypotheses

Grepping the statement rather than the identifier: the operative content, $\sum d_\varphi^2=t/2$, $\sum d^2=\tfrac32t$, $\mu\succ d_\varphi$, $\omega\succ d$, $d_\psi=-\operatorname{spec}(K\vert_{\mathbf1^\perp})$, is consumed at [bispectral.md:236](../findings/bispectral.md#L236), [252](../findings/bispectral.md#L252), [256](../findings/bispectral.md#L256), [258](../findings/bispectral.md#L258), [302](../findings/bispectral.md#L302), [305](../findings/bispectral.md#L305), [337](../findings/bispectral.md#L337), [358](../findings/bispectral.md#L358); at [results.md:252](../results.md#L252), [712](../results.md#L712), [728](../results.md#L728); at [report/sections/06b-bispectral.tex:131](../report/sections/06b-bispectral.tex#L131), [135](../report/sections/06b-bispectral.tex#L135), [163](../report/sections/06b-bispectral.tex#L163); and in [REVIEW_r479](REVIEW_r479.md), [REVIEW_r480](REVIEW_r480.md), [REVIEW_r483](REVIEW_r483.md), [ELIM-stratum.md](ELIM-stratum.md).

**Nobody uses the vector reading, brief question (1) resolves benignly.** Every consumer I can find uses $\mu=d_\varphi$ and $\omega=d$ either as multiset equalities or as norm equalities:

- [ELIM-stratum.md:190](ELIM-stratum.md#L190) reads it explicitly as *"Karamata with equal sums and equal norms under strict convexity"*, the multiset reading, which is what Schur–Horn plus strict convexity of $x\mapsto x^2$ actually delivers.
- [REVIEW_r480:32](REVIEW_r480.md#L32) uses only $\lVert\mathring W_{\mathrm{off}}\rVert_F^2=3-\tfrac32t=3\lVert M_{\mathrm{off}}\rVert_F^2$, a norm consequence.
- [REVIEW_r479:59](REVIEW_r479.md#L59) runs the argument in the safe direction, deducing $t\ge2$ from $\sum(K')^2=3$ and $\sum(K')^2\le\tfrac32t$, and it is careful to write $\le$, which is the correct general statement and the one my §3 witness makes strict.

**And the stronger reading, though unused, is true.** At $t_F=2$ the Cauchy–Schwarz equality case says $M$ is diagonal in the $\varphi$-basis outright, so $\mu$ and $d_\varphi$ agree entry by entry; and $\mathring W$ is then block-diagonal, since for coordinate-diagonal $W$ every $\langle\mathring W\varphi_{ab},\varphi_{cd}\rangle$ with $(a,b)\ne(c,d)$ and every $\langle\mathring W\varphi_{ab},\operatorname{diag}(v)\rangle$ vanishes on the pair-matching condition. **So the block's "outright" is true, but for a reason the block does not give**: it is the diagonality that $t_F=2$ already means, not the majorization rigidity the block cites. The Schur–Horn route reaches only the multiset. *A one-line addition would close the gap; as it stands the block asserts more than its stated argument gives.*

**No consumer uses the cap at odd $n$**, and no residue of the withdrawn *"$\mu$ is uncapped"* claim survives, §7's retraction at [bispectral.md:272](../findings/bispectral.md#L272) is complete, and the parity restriction added later is correctly scoped as a limit on the proof rather than on the inequality.

## 9. Finding 5, NPW Proposition 3.10 is transcribed with the paper's own typo

[references/…/notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) reproduces the paper's

$$\psi_k=\frac1{\sqrt{(n-k+1)(n-k)}}\Bigl(-k\,e^k\otimes e^k+\sum_{l=k+1}^ne^l\otimes e^l\Bigr).$$

**As printed this is neither trace-free nor unit-norm**: its trace is $-k+(n-k)$, zero only at $n=2k$, and its unnormalised square norm is $k^2+(n-k)$, against the $(n-k+1)(n-k)$ the printed normalizer expects. Both defects are cured by the single substitution $-k\mapsto-(n-k)$, which gives trace $-(n-k)+(n-k)=0$, square norm $(n-k)^2+(n-k)=(n-k)(n-k+1)$ matching the normalizer exactly, and orthogonality $\langle\psi_k,\psi_{k'}\rangle\propto-(n-k')+(n-k')=0$ for $k<k'$. **Three independent checks, all agreeing.** The typo is the paper's, the same characters appear in [the PDF text at line 1133](https://arxiv.org/abs/2206.14218), so the notes should carry the correction with a marker rather than the transcription. Nothing downstream uses the explicit form, so no result moves.

## 10. Finding 6, $t\le2$ is load-bearing and unnumbered

L54's rigidity rests entirely on $t\le2$ and its equality case, and the record proves it **only inside a blockquote of [conventions.md](../findings/conventions.md)**. It appears in no numbered block and in no row of [INDEX-results.md](../findings/INDEX-results.md). The proof is two lines and correct in both directions, $t_F=2\lVert\operatorname{diag}_FM\rVert^2$, Cauchy–Schwarz against $\lVert M\rVert_F=1$, equality iff the off-diagonal mass is zero, but a conventions file is where definitions live, and this is a theorem carrying a lemma. **Recommend numbering it**, with the frame quantifier stated as §4 requires.

## Overall verdict

**REFUTED as written, and REPAIRED by one clause.**

The mathematics L54 is reaching for is correct and, where the record calls it measured, it is in fact derivable in three lines, I rebuilt both diagonals, the norm identities, the cap and the cap's equality case by hand, from the definitions, without touching a script. The defect is that the numbered block names **NPW's** basis, whose $\psi$-half is a $W$-independent staircase, while its own norm identity $\sum d^2=\tfrac32t$ requires the $\psi$'s to be $K$'s eigenvectors. The $n=4$, $t=2$ witness in §3 gives $\sum d^2=\tfrac32$ against the claimed $3$, at exactly the configuration the block's conclusion is about. Three smaller repairs follow: the frame quantifier (§4), the parity placement (§5), and the even-half scoping of the projection estimate (§7). The 27 consumers are all inside the repaired statement's hypotheses, and the retractions the section carries are complete.
