# Review r665, Lemma L115, $\lambda_{\max}(M)=\theta$ at every global maximiser

*Reviewer A of a pair on identical briefs. Review number 665. Target: [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) line 268, `#### Lemma L115`, with its two body blocks at lines 270–274 and 276–278. Analysis only: no computation was run, and none of what follows rests on any.*

## Verdict

**GAP.** The equality is **true**, I prove it, unconditionally, at every *coordinate-diagonal* global maximiser, and verify it by hand at the two global maximisers the record names ($W_{\mathbb{CP}^2}$ at $n=4$, its padding at $n=6$). But **the block's derivation does not establish it**: [Lemma L24](../findings/second-order.md)'s cap lives on $\mathcal W_n\cap W^\perp$, while $\lambda_{\max}(M)$ maximises over the whole eigenframe-diagonal algebra, whose elements are generically neither trace-free nor Bianchi. The step *"L24 … so $\lambda_{\max}(L_e|_{\mathcal D})=1$"* silently enlarges L24's domain, and the enlargement is not free.

Three consequences the record needs separately:

| clause | verdict |
| --- | --- |
| $\lambda_{\max}(M)=\theta$ at every global maximiser | **GAP**, derivation invalid as written; proved here on the diagonal locus; residual obligation named below |
| $\theta\ge\max_\alpha\lambda_\alpha$ there | **CONFIRMED, and free**, it is $\max\lambda_\alpha\le\lVert\lambda\rVert=1<\sqrt{3/2}\le\theta$, one line, needing neither L24 nor $M$; and it is **strictly** true, never an equality |
| *"$\sup_W\lambda_{\max}(M)\le\theta_0$ … is strictly stronger than Conjecture A"* | **REFUTED as argued**, the witness offered does not witness it, the record's own measurements point the other way, and at odd $n\ge13$ the comparison inverts |

**The equality and the route conclusion are separate claims, and the record may cite neither as it stands**: the first because its proof has a hole (repairable, and repaired here in the case that matters most), the second because it does not follow from the first.

## 0. Which $M$, and where the record defines it

The heading writes a bare $M$. It is **none of the three senses [conventions.md](../findings/conventions.md) tables**. It is the $N\times N$ matrix, $N=\binom n2$,

$$M_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma,\qquad T_{\alpha\beta\gamma}=c'^2_{\alpha\beta\gamma},$$

in an eigenframe $\{v_\alpha\}$ of $W$ with $Wv_\alpha=\lambda_\alpha v_\alpha$. Its **only definition on the record is in another file**, [second-order.md](../findings/second-order.md), the block *"$P$ is a Rayleigh quotient, and $\theta$ is an eigenvalue of its own matrix"*, line 531, which [bounds-relaxations.md](../findings/bounds-relaxations.md) never cites. So the count of live senses is now **four**, not three:

| sense | where |
| --- | --- |
| $M(n)$, the global maximum of $P$ | [conventions.md](../findings/conventions.md), tabled |
| $M$ or $K$, the $n\times n$ sectional matrix | [conventions.md](../findings/conventions.md), tabled |
| $M=4(n-1)-\Delta-G_0$, a **scalar** | [Lemma L119](../findings/bounds-relaxations.md), **fifty lines below L115 in the same file** |
| $M_{\alpha\beta}$, the Rayleigh matrix above | [second-order.md](../findings/second-order.md); used unnamed here |

[Lemma L119](../findings/bounds-relaxations.md)'s own audit box already records *"the bare $M$ in the heading collides with $M(n)$"*. The identical defect is in L115's heading, in the same file, uncorrected, and here it is worse: the two bare $M$'s inside one file are **a matrix and a scalar**.

**Same paragraph, same problem, for $\mathcal D$**: line 272 writes $\lambda_{\max}(L_e|_{\mathcal D})$ with $\mathcal D$ defined nowhere in the block, while [conventions.md](../findings/conventions.md) tables $\mathcal D_n=\{S \text{ symmetric, hollow}, S\mathbf1=0\}$, a space of $n\times n$ matrices, and, as §2 shows, **precisely the sub-object whose omission is the gap**. And *"Lemma L24"* at line 272 is a **bare mention with no link**, the block's one dependency, in a file where every other result reference is a link.

**A fifth reading is created and destroyed by the same sentence.** $M$ is frame-dependent at any $W$ with a repeated $\Lambda^2$ eigenvalue, because "the eigenframe" is then a choice and $T$ changes with it. At padded $W_{\mathbb{CP}^2}$ in $n=6$ the kernel is $12$-dimensional; rotating $w_1\mapsto(w_1+\varphi_{15})/\sqrt2$ inside it changes $M_{v,\varphi_{25}}$ from the covariant value $c/(2\sqrt2)$ to $c/4$, so $M$ does **not** transform as a bilinear form under the choice. The block writes *"a maximal abelian subspace"* (indefinite article) and then treats $\lambda_{\max}(M)$ as a function of $W$ alone. Every canonical point of this programme is degenerate, so the ambiguity is live wherever the lemma is used.

## 1. What is free, what is content

Write $L_W=W\circ(\cdot)$ on $S^2(\Lambda^2\mathbb R^n)$, $e=W/\theta$, $L_W=\theta L_e$, and let $\mathcal D=\mathop{\mathrm{span}}\{v_\alpha\otimes v_\alpha\}$ be the eigenframe-diagonal algebra, $\dim\mathcal D=N$. The block's own identity, which I re-derived and confirm, is

$$\langle x,Mx\rangle=\langle W,X^2+X^\#\rangle=\langle L_WX,X\rangle,\qquad X=\textstyle\sum_\alpha x_\alpha\,v_\alpha\otimes v_\alpha,$$

so $\lambda_{\max}(M)$ is the top eigenvalue of the **compression** of $L_W$ to $\mathcal D$ (a compression, not a restriction: $\mathcal D$ is not $L_W$-invariant, and the block's notation $L_e|_{\mathcal D}$ hides that).

**Three facts, each with its own hypothesis.**

1. **$\lambda_{\max}(M)\ge\theta$ at every unit $W$.** Take $x=\lambda$: $\lVert\lambda\rVert^2=\mathop{\mathrm{tr}}(W^2)=1$ and $\langle\lambda,M\lambda\rangle=P(W)=\theta$. **No criticality, no maximality.** This is the direction [post F15](../findings/bounds-relaxations.md) already states.
2. **$M\lambda=\theta\lambda$ at every critical point.** $(M\lambda)_\alpha=\langle Q(W)v_\alpha,v_\alpha\rangle$, and $Q(W)=\theta W$ is diagonal in the eigenframe, so $(M\lambda)_\alpha=\theta\lambda_\alpha$. So $\theta$ is an **eigenvalue** of $M$ at every critical point; [second-order.md](../findings/second-order.md) line 537 says exactly this, and the L115 block (which needs it), does not.
3. **The content of L115 is therefore one inequality**: $\lambda_{\max}(M)\le\theta$, equivalently "$\lambda$ is a *top* eigenvector of $M$". Everything else is free.

*Answering the brief's question directly:* the equality is two inequalities, $\ge$ is free at every unit $W$, $\le$ is the whole content, and it is the only place maximality can enter.

**Simplicity of $1$ is not used, and cannot be.** What the argument needs is $\langle L_eY,Y\rangle\le\lVert Y\rVert^2$ off $W$; L24 supplies $\le\tfrac12$, twice the margin required. Simplicity is moreover a *consequence* of that cap, [second-order.md](../findings/second-order.md) derives it in one clause, *"the bound gives it at once"*, so quoting it as an input inverts the dependency. The margin means the Weyl half of clause 1 survives a hypothesis **strictly weaker than maximality of any kind**: any $W$ with $\lambda_{\max}(L_e|_{W^\perp})\le1$ will do.

## 2. The gap

**L24's domain is $\mathcal W_n$.** [results.md](../results.md) and [second-order.md](../findings/second-order.md) both state it as *"the Hessian of $P$ restricted to the unit sphere of $\mathrm{Weyl}_n$"*, and [Lemma L125](../findings/second-order.md), the same statement rearranged, quantifies explicitly over *"every $Y\in\mathcal W_n$"*. It says nothing about directions outside $\mathcal W_n$, and it cannot: $P$ is maximised over $\mathcal W_n$, so the second variation exists only there.

**$\mathcal D\not\subseteq\mathcal W_n$, and the failure is not marginal.** $v_\alpha\otimes v_\alpha$ has trace $1$, so it is not even trace-free; generic elements of $\mathcal D$ also fail Bianchi. At $n=6$, $\dim\mathcal D=15$ against $36$ Weyl conditions on $S^2(\Lambda^2)$, so at a $W$ with no special structure $\mathcal D\cap\mathcal W_n=\mathbb RW$, **the entire content of L115 beyond the free direction then lies outside L24's reach.**

**This exact trap has already been paid for once in the neighbouring file.** [second-order.md](../findings/second-order.md) line 568 records the r301 dispute: *"$H_A=D_AW+WD_A$ does not stay in $\mathcal W_n$ … computing $L_e$ on the raw $H_A$ therefore measures a different operator, which is what produced the five unrecognisable values … the projection is mandatory."* L115 applies $L_e$ to raw non-Weyl directions and quotes L24 for the result.

**The clean form of the residual obligation.** Given $Q(\mathcal W_n)\subseteq\mathcal W_n$ (the record's standing convention, which criticality itself needs), $L_W$ preserves $\mathcal W_n$ and, being self-adjoint, preserves $\mathcal W_n^\perp$. Splitting $X=X_{\mathcal W}+X_\perp$ kills the cross term, so

$$\lambda_{\max}(M)\ \le\ \max\Big(\underbrace{\lambda_{\max}\big(L_W|_{\mathcal W_n}\big)}_{=\,\theta\ \text{at a maximiser, by L24}},\ \underbrace{\lambda_{\max}\big(L_W|_{\mathcal W_n^\perp}\big)}_{\textbf{nothing on the record}}\Big).$$

**L115 is exactly one bound short: a cap on the multiplication operator over the non-Weyl part of $S^2(\Lambda^2)$.** No such cap exists anywhere in [findings/](../findings/).

**The two clauses need incompatible readings of $\mathcal D$.** Read $\mathcal D$ as its Weyl part $\mathcal D\cap\mathcal W_n$ and clause 1's derivation is valid as written, but clause 2 then dies, because its witness $x=e_\alpha$, i.e. $X=v_\alpha\otimes v_\alpha$, is **not** in that set. Read $\mathcal D$ as the full diagonal algebra, which is what "$\lambda_{\max}(M)$" and the whole B3/[F15](../findings/bounds-relaxations.md) apparatus mean, and clause 2 follows but clause 1 does not. **One sentence cannot have it both ways, and the block uses each reading once.**

## 3. The repair, and where it is complete

On the **diagonal locus** the missing bound is available by hand, and this is the case the record's canonical points inhabit.

Let $W$ be coordinate-diagonal with sectional matrix $K$ ($K$ hollow, $K\mathbf1=0$ by Ricci-flatness, $\lVert K\rVert_F^2=t\le2$). Coordinate-diagonal operators correspond to hollow symmetric $S$, they satisfy Bianchi automatically, and such an operator is **Weyl exactly when $S\mathbf1=0$**, so inside $\mathcal D$ the Weyl condition is $n$ linear equations, no more. Their orthogonal complement inside $\mathcal D$ is exactly the $n$-dimensional family

$$S(u)_{ij}=u_i+u_j\ (i\ne j),\qquad u\in\mathbb R^n,$$

since $\langle S(u),Z\rangle_F=2u^{\mathsf T}(K^Z\mathbf 1)=0$ for every Weyl $Z$. On it the Rayleigh quotient is computable in closed form. With $\langle x,Mx\rangle=\tfrac12\big[\sum_{i\ne j}K_{ij}S_{ij}^2+\mathop{\mathrm{tr}}(KS^2)\big]$ and $\lVert x\rVert^2=\tfrac12\lVert S\rVert_F^2$, using $K\mathbf1=0$ and $K$ hollow throughout,

$$\sum_{i\ne j}K_{ij}S(u)_{ij}^2=2u^{\mathsf T}Ku,\qquad \mathop{\mathrm{tr}}\big(KS(u)^2\big)=(n-4)\,u^{\mathsf T}Ku,\qquad \lVert S(u)\rVert_F^2=2(n-2)\lVert u\rVert^2+2\sigma^2$$

with $\sigma=\mathbf1^{\mathsf T}u$, giving

$$\boxed{\ \frac{\langle x,Mx\rangle}{\lVert x\rVert^2}\bigg|_{S(u)}=\frac{(n-2)\,u^{\mathsf T}Ku}{2(n-2)\lVert u\rVert^2+2\sigma^2}\ \le\ \tfrac12\lambda_{\max}(K)\ \le\ \tfrac12\lVert K\rVert_F\le\tfrac1{\sqrt2}\ .}$$

**At a global maximiser $\theta=M(n)\ge\sqrt{3/2}=1.2247>0.7072$**, the padded-$W_{\mathbb{CP}^2}$ lower bound tabled in [conventions.md](../findings/conventions.md), so the non-Weyl half is dominated with room to spare, and with the Weyl half handed over by L24:

> **Lemma L115′ (what is actually proved).** At every **coordinate-diagonal global maximiser**, $\lambda_{\max}(M)=\theta$, attained at $x=\lambda$. The proof is L24 on $\mathcal D\cap\mathcal W_n$ together with $\tfrac12\lambda_{\max}(K)\le\tfrac1{\sqrt2}<\sqrt{3/2}\le\theta$ on the complement.

Two remarks this repair forces.

- **Global maximality now earns its keep, and did not before.** L24 holds at every *local* maximiser, [second-order.md](../findings/second-order.md) uses it that way, e.g. *"no $S^2\times S^q$ is a local maximum (its four-set block breaches L24"*) so **the block's own argument, if it worked, would prove the statement at every local maximiser and the heading's quantifier would be too narrow.** In the corrected argument the non-Weyl half needs $\theta\ge\lambda_{\max}(K)/2$, for which $\theta\ge1/\sqrt2$ suffices and which global maximality supplies. So the quantifier is right for the wrong reason: it is idle in the argument given and load-bearing in the argument that works.
- **It also settles a case the block treats as evidence.** At a balanced sphere product $S^m\times S^m$ with $m\ge4$ the same split gives $\lambda_{\max}(M)=\theta$ **unconditionally**, by [Lemma L27](../findings/nondegeneracy.md)'s $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ on the Weyl half and $\tfrac12\lambda_{\max}(K)=\tau<\theta=\tau(2-\tfrac1m)$ on the other, where $\tau=\sqrt{(m-1)/(2m-1)}$, no maximality used.

**Hand verification at the two global maximisers the record names.**

- **$n=4$, $W_{\mathbb{CP}^2}$.** In the basis $u_1,u_2,u_3$ of $\Lambda^2_+$ and $w_1,w_2,w_3$ of $\Lambda^2_-$, $\lambda=(2c,-c,-c,0,0,0)$ with $c=1/\sqrt6$, and $T_{\alpha\beta\gamma}=2$ on permutations of $(123)$ and of $(456)$, zero otherwise (from $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)=4$ split over two partners). Hence $M=cA\oplus0$ with $A=\begin{pmatrix}2&-1&-1\\-1&-1&2\\-1&2&-1\end{pmatrix}$, $\mathop{\mathrm{spec}}(A)=\{3,0,-3\}$ with top eigenvector $(2,-1,-1)\propto\lambda$. So $\lambda_{\max}(M)=3c=\sqrt{3/2}=\theta$ **exactly**, and $\max_\alpha\lambda_\alpha=2c=0.8165$. ✔
- **$n=6$, padded $W_{\mathbb{CP}^2}$.** With the eigenframe $\{u_i\},\{w_i\},\{\varphi_{i5}\},\{\varphi_{i6}\},\varphi_{56}$, every cross-block entry of $M$ vanishes because the relevant brackets land where $W$ does, and $M$ is block diagonal with tops $3c$, $0$, $\tfrac12\lambda_{\max}(K^{(4)})=c$, $c$, $0$. So $\lambda_{\max}(M)=3c=\theta$. ✔ *(This is one choice of eigenframe; see §0.)*

**The repair also explains the block's own headline coincidence.** At the $C_5$ blow-up, $\lambda_{\max}(M)=0.809017>1/\sqrt2$, so the top **cannot** come from the non-Weyl part and must sit in $\mathcal D\cap\mathcal W_n$, where it equals $\theta\cdot\lambda_{\max}(L_e|_{W^\perp})=0.670820\times1.206011=0.809017$. The *"matching to seven digits"* the block reports as a corroboration is a consequence of the split it omits.

## 4. The second clause

$\theta\ge\max_\alpha\lambda_\alpha$ at a global maximiser is **true**, and the block derives it from a machine it does not need.

$$\max_\alpha\lambda_\alpha\ \le\ \Big(\sum_\alpha\lambda_\alpha^2\Big)^{1/2}=\lVert W\rVert=1\ <\ \sqrt{3/2}\ \le\ M(n)=\theta .$$

- **It needs neither L24, nor $M$, nor L115**, only $\sum\lambda^2=1$ and the tabled $M(n)\ge\sqrt{3/2}$.
- **It is strict everywhere, with a uniform margin $\theta-\max_\alpha\lambda_\alpha\ge\sqrt{3/2}-1=0.2247$.** Equality can occur at **no** global maximiser, at any $n$. The block's *"the largest eigenvalue of a maximiser is at most its own $\theta$"* is therefore a weaker statement than the truth, and a reader who takes the equality case as open is misled.
- **The normalisation is load-bearing and is named nowhere.** $\lambda$ scales linearly in $W$ while $\theta=P(W)/\lVert W\rVert^3$ is scale-free, so the inequality is a statement about $\lVert W\rVert_{\Lambda^2}=1$ in the half-trace pairing, i.e. $\sum\lambda_\alpha^2=1$. Under the record's other live $\Lambda^2$ normalisation, $\lvert W\rvert^2=4\lVert W\rVert_F^2$ ([conventions.md](../findings/conventions.md)), the left side doubles to a bound of $2$ and the clause is no longer available. **The same omission sinks the first clause's statement too**: $\lambda_{\max}(M)$ scales linearly in $W$ and $\theta$ does not, so *"$\lambda_{\max}(M)=\theta$"* is false off the unit sphere. This is [Lemma L119](../findings/bounds-relaxations.md)'s defect verbatim (*"the unit-norm hypothesis was dropped"*), repeated fifty lines above it.

## 5. "And that settles what the route is worth"

The route is **B3**, the proposal to prove Conjecture A by bounding $\sup_W\lambda_{\max}(M)$; it was retired by the originating commit and its identities kept.

**What follows from L115 (granting the equality):** the *pointwise-at-maximisers* target, "$\lambda_{\max}(M)\le\theta_0$ at every maximiser", is literally "$\theta\le\theta_0$ at every maximiser", Conjecture A with the letters changed. **This much is correct**, and it is the block's real content: *the reformulation buys nothing.* The conclusion is the narrow one (**the route yields no shortcut**), not that the route is closed. What closes it is [post F15](../findings/bounds-relaxations.md)'s frame-realisability argument, which is independent of L115.

**What does not follow, and the block asserts it in bold.** *"So $\sup_W\lambda_{\max}(M)\le\theta_0$ … is strictly stronger than Conjecture A: the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$."*

- The implication $\sup_W\lambda_{\max}(M)\le\theta_0\Rightarrow$ Conjecture A holds ✔ (from $\lambda_{\max}(M)\ge\theta$ pointwise).
- **Strictness needs a Weyl tensor with $\lambda_{\max}(M)>\theta_0$, and the witness offered is not one.** At the $C_5$ blow-up $\lambda_{\max}(M)=0.809017$ against $\theta_0(10)=1.2$: the point satisfies the stronger statement comfortably. What its ratio $1.206$ shows is that $\lambda_{\max}(M)>\theta$ *pointwise* off maximisers, a different claim, and one that does not separate the two suprema.
- **The record's own measurements point the other way.** [second-order.md](../findings/second-order.md) line 541 reports $\sup_W\lambda_{\max}(M)=\sqrt{3/2}=M(n)$ at $n=6,8,10$ by full-gradient ascent, i.e. the two suprema were *found equal*, which is evidence against strictness, not for it. [Post F15](../findings/bounds-relaxations.md)'s $52\%$ overshoot is an LP optimum at a spectrum that is **not a Weyl spectrum**, so it cannot supply the witness either, F15 says so itself.

**The brief's test, does this block make the "tight at the maximiser, therefore no escape" move?** The findings block does not; **its unnumbered twin in [report/](../report/) does**, and states it as a general rule: *"if the bound is tight at the known or conjectured extremiser, its global supremum equals the original one, and proving it is at least as hard"* ([07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1295). **That step is a non sequitur.** Pointwise tightness at the maximiser plus $B\ge\theta$ gives $\sup B\ge\sup\theta$ only; equality of the suprema is an extra global claim about the slack elsewhere, exactly the claim the $C_5$ ratio shows is not automatic. So the two copies of this content assert **opposite** conclusions ("strictly stronger" against "the suprema coincide"), and **neither is derived**. What is actually established is the containment: $\sup\lambda_{\max}(M)\ge M(n)$, with equality unknown.

**The parity check the brief asks for, and it bites here.** Conjecture A's target is $\Theta_n$, equal to $\theta_0(n)$ **at even $n$ only** ([conventions.md](../findings/conventions.md), [problem.md](../findings/problem.md)). At odd $n\ge13$, $\Theta_n<\theta_0(n)$, so "$\sup_W\lambda_{\max}(M)\le\theta_0$" delivers only $\theta\le\theta_0(n)$, which is **weaker** than Conjecture A, not stronger. The sentence is therefore an even-$n$ statement written without the hypothesis. *The same $\theta_0$-for-$\Theta_n$ substitution sits in [second-order.md](../findings/second-order.md) line 541 ("$M(n)\le\sup\lambda_{\max}(M)=\theta_0(n)$, which is Conjecture A") and in the report twin; this is spread, not a local slip.*

**The sub-heading itself,** *"tight where it matters and slack elsewhere"*, is an accurate description of the phenomenon ($=\theta$ at maximisers, $>\theta$ at $C_5$). The error is in what is inferred from it, in both directions, in two places.

## 6. Hypotheses, stated in full

For clause 1 as repaired: $W\in\mathcal W_n$ satisfying the first Bianchi identity and trace-free (both used, via $\mathcal D\cap\mathcal W_n$ and $K\mathbf1=0$); $\lVert W\rVert=1$ in the half-trace $\Lambda^2$ pairing (used twice, and stated nowhere in the block); $Q(W)=\theta W$ with $\theta>0$ (for $L_eW=W$ and for $M\lambda=\theta\lambda$); $Q(\mathcal W_n)\subseteq\mathcal W_n$ (for the orthogonal split; the record's standing convention, and I checked it holds on the diagonal locus, where Ricci-flatness of $Q(W)$ reduces to $K\mathbf1=0$); **global** maximality, used only as $\theta\ge\sqrt{3/2}$, local maximality suffices for the Weyl half; and, for the general case, the missing cap $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$. For clause 2: $\sum\lambda_\alpha^2=1$ and $M(n)\ge\sqrt{3/2}$, nothing else.

## 7. Provenance, duplication, pointers

**Provenance, `git`-checked.** The content originates at commit `dd1fec71` *(2026-08-23, "feat(conjecture-a): the Rayleigh bound is L_W on the commutant, and it is tight at the maximiser")*, whose body carries **"Gate 2 pending: no reviewer agents were spawned this cycle"** and the trailer `Deliverable: dead-end`. The **number** L115 was attached nine days later by commit `c14052fc` *(2026-09-02, "docs(bounds): place headings for Lemmas L107–L119")*, a bulk heading pass, the same mechanism [Lemma L117](../findings/bounds.md)'s audit found responsible for a mislabel (*"the label came from a bulk heading commit"*). That explains the block's shape: **the L115 heading at line 268 has no body of its own**, the argument living under the sibling heading *"And that settles what the route is worth"* at line 270. So this review is L115's first audit, matching [INDEX-results.md](../findings/INDEX-results.md) row 115, *"Gate 2: no verdict on the record"*.

**The re-filing note, and my reading is stated because the readings disagree.** `git log -S` gives the path **FINDINGS.md → live-front.md → bounds.md → bounds-relaxations.md**; [second-order.md](../findings/second-order.md) **never held this text**. The note at line 286, *"Re-filed here 2026-09-02 from second-order.md"*, sits after a `---` below the F15 section and before the next `##`.

- *Reading A, the note closes the section above it.* Then it is **false**: the source was [bounds.md](../findings/bounds.md).
- *Reading B, the note introduces the section below it.* This is supported by the file's own pattern: the note at line 301 says *"from target.md"* and the section at 303 declares *"From findings/target.md"*; the note at 286 says *"from second-order.md"* and the section at 288 declares *"From findings/second-order.md"*. Under this reading the note is **correct and does not concern L115**, which then carries no provenance note at all.

**I adopt reading B**, on the strength of the two independent matches, and record the defect as *the file's re-filing notes are positioned so that reading A makes one of them false*. Under reading A the note is a fifteenth copy of the boilerplate and is wrong.

**Duplication.** One unnumbered twin: [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) lines 1291–1299. It carries the same derivation, **omits the second clause**, and (as §5 shows), **justifies the shared "strictly stronger" claim by the opposite argument**. Only one of the two can be repaired in place; the record needs to decide which is canonical. The parent block in [second-order.md](../findings/second-order.md) is **not** a duplicate: it owns $M$'s definition and the $M\lambda=\theta\lambda$ identity, and stops short of the lemma, but it never points at L115, and L115 never points at it.

**Pointers.** *"Lemma L24"* at line 272 is unlinked, the block's single dependency. $\mathcal D$ and $M$ are undefined in the file and collide with tabled objects. The two file pointers that are present resolve: [b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py), [b0_transport_lp_vector.py](../scripts/route-b/b0_transport_lp_vector.py) and the [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) all exist.

**Scope and blast radius.** Nothing in [findings/](../findings/), [results.md](../results.md) or [plan.md](../plan.md) consumes L115, the only references are its own heading, the file header list, and [INDEX-results.md](../findings/INDEX-results.md). **The gap is contained**, and the retired route it justifies does not depend on it ([post F15](../findings/bounds-relaxations.md) closes B3 on its own grounds).

## 8. What I recommend the record do

1. **Keep the equality, restate its scope.** The citable statement today is L115′ of §3: *at every coordinate-diagonal global maximiser*, plus *at every balanced sphere product with $m\ge4$, unconditionally*. The general case is open pending a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$, which should be filed as the named residual obligation.
2. **Replace clause 2's derivation with its one-line proof**, and record that it is strict with margin $\ge0.2247$ and consumes no maximality beyond $\theta>1$.
3. **Withdraw "strictly stronger than Conjecture A"** and replace it with what holds: the sup target implies Conjecture A, whether it is *strictly* stronger is open, and the record's own ascent data at $n=6,8,10$ suggests the two suprema coincide. Add the even-$n$ hypothesis wherever $\theta_0$ stands in for $\Theta_n$.
4. **Fix the report twin's rule**, which as written licenses the inference this pair of audits was briefed to look for.
5. **Table the Rayleigh matrix $M$ in [conventions.md](../findings/conventions.md)**, with its frame-dependence at degenerate spectra, and give the L115 heading a body.

---

*No computation was performed for this review. Every number above, $3c=\sqrt{3/2}$, $\mathop{\mathrm{spec}}(A)=\{3,0,-3\}$, $\tfrac12\lambda_{\max}(K)\le1/\sqrt2$, the $S^m\times S^m$ block matrix and its eigenvalues $\{\theta,0\}$, and $0.670820\times1.206011=0.809017$, was derived by hand from the definitions in [conventions.md](../findings/conventions.md).*
