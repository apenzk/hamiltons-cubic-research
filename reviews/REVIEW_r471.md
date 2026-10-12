# Review r471, Lemma L80, $N_v\succeq0$ with $\ker N_v=v^\perp\cap\mathfrak z(v)$

**Target.** [findings/isotropy-cap.md](../findings/isotropy-cap.md), the block `#### Lemma L80`. Restated in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) and in [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md).

**Verdict, per assertion.**

| assertion | verdict | hypotheses it actually needs |
| --- | --- | --- |
| $N_v\succeq0$ | **CONFIRMED** | none, every $v\in\mathfrak{so}(m)$, every $m$, degenerate and zero $v$ included |
| $\ker N_v=v^\perp\cap\mathfrak z(v)$ | **CONFIRMED** | none, as above |

**Neither assertion carries the $\mathfrak c\ne0$ / $p\ge2$ gap that corrected [Lemma L32](../findings/isotropy-cap.md) and [Lemma L81](../findings/isotropy-cap.md).** Those two count dimensions; L80 identifies a vanishing locus pointwise, and a pointwise identity has nothing to lose when the locus is $\{0\}$.

Everything below was reached from the definition at [isotropy-cap.md](../findings/isotropy-cap.md) line 196 and [conventions.md](../findings/conventions.md); no reference beyond a `notes.md` was opened.

---

## 1. $N_v$ is defined, and the statement is well posed

$N_v:=2\,v\otimes v-\mathrm{ad}(v)^2$, at [isotropy-cap.md](../findings/isotropy-cap.md) line 196, nineteen lines above L80, inside the Bianchi/Ricci-flat identity block, and repeated verbatim at [results.md](../results.md) line 442 and [stratum-two-negative.md](../findings/stratum-two-negative.md) line 134. **The defect recorded against a neighbouring result today does not recur here.**

- $v$ is a **bivector**, i.e. an element of $\mathfrak{so}(m)\cong\Lambda^2\mathbb R^m$; $N_v$ is an operator **on $\mathfrak{so}(m)$**, since $\mathrm{ad}(v)^2$ is.
- $v\otimes v$ is the rank-one operator $u\mapsto\langle v,u\rangle v$. It coincides with the $\mathrm{Sym}^2(\Lambda^2)$ reading used elsewhere in the file (`$W=\pm x\otimes x$`), so no ambiguity bites.
- **Two smaller well-posedness debts.** $\mathfrak z(v)$ (the centraliser of $v$ in $\mathfrak{so}(m)$), is used consistently across [isotropy-cap.md](../findings/isotropy-cap.md) and [stratum-two-negative.md](../findings/stratum-two-negative.md) but is defined in neither, and is absent from [conventions.md](../findings/conventions.md). And the definition of $N_v$ sits in the middle of a derivation rather than in a `**Statement.**`; L80's block has no `**Statement.**` and no `**Proof.**`, unlike the canonical [L32](../findings/isotropy-cap.md) and [L36](../findings/isotropy-cap.md) blocks in the same file, and its two body lines sit under a same-level `####` heading, so the lemma reads as a sibling section rather than as its own proof.

## 2. The kernel is an equality, and the block establishes one half of it explicitly

Write the block's line out. $\mathrm{ad}(v)$ is skew-adjoint for the ad-invariant pairing ([conventions.md](../findings/conventions.md), "the inner product being ad-invariant"), so $\langle u,\mathrm{ad}(v)^2u\rangle=-\lVert[v,u]\rVert^2$ and

$$\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2 .$$

**What that line proves, exactly:** the quadratic form is nonnegative, and its **vanishing set** is $\{u:\langle v,u\rangle=0\ \text{and}\ [v,u]=0\}=v^\perp\cap\mathfrak z(v)$, both directions, since a sum of two nonnegative terms vanishes iff both do.

**What it leaves unsaid** is the passage from the vanishing set of the form to the kernel of the operator:

- **$\supseteq$ is direct and needs nothing.** $N_vu=2\langle v,u\rangle v-[v,[v,u]]$, so $u\in v^\perp\cap\mathfrak z(v)\Rightarrow N_vu=0$. This inclusion never touches positivity.
- **$\subseteq$ is where the work is**, and it runs through the standard fact that a **symmetric** PSD operator has $\langle u,Au\rangle=0\Rightarrow Au=0$. Symmetry holds ($(\mathrm{ad}(v)^2)^{*}=(-\mathrm{ad}(v))^2=\mathrm{ad}(v)^2$ and $v\otimes v$ is symmetric) but the block asserts the kernel identification without naming either the symmetry or the PSD fact.

**A second route gives both inclusions with no PSD lemma at all**, and is the one [r60](REVIEW_r60.md) took: $N_v=2\,(v\otimes v)+(-\mathrm{ad}(v)^2)$ is a sum of two PSD operators, so its kernel is the intersection of theirs; $\ker(v\otimes v)=v^\perp$, and $\ker(-\mathrm{ad}(v)^2)=\ker\mathrm{ad}(v)=\mathfrak z(v)$ because $\ker A^2=\ker A$ for skew-adjoint $A$.

**Assessment: the block is compressed, not wrong.** One clause ("and $N_v$ is symmetric, so the form's null set is the kernel"), closes it.

## 3. No hypothesis is needed, and the L32 gap cannot reach here

The brief asks whether the $\mathfrak c\ne0$ correction to [L32](../findings/isotropy-cap.md) and the $p\ge2$ correction to [L81](../findings/isotropy-cap.md) have a counterpart here. **They do not**, and the reason is structural rather than lucky.

- **$v=0$.** $N_0=0$, and $0^\perp\cap\mathfrak z(0)=\mathfrak{so}(m)$. The equality holds trivially.
- **Degenerate $v$.** Nothing in the derivation uses the rank of $v$; the identity is pointwise in $u$.
- **$v^\perp\cap\mathfrak z(v)=0$.** This is the case that broke L32, at $x=e_{12}\in\mathfrak{so}(3)$. Here it simply says $N_v$ is **positive definite**, a true and stronger conclusion, not a failure. L32 broke because it asserted the *size* of a second centraliser; L80 asserts no dimension at all.

**The dimension, since the record will want it.** For $v\ne0$, $\mathfrak z(v)=\mathbb Rv\oplus(\mathfrak z(v)\cap v^\perp)$ orthogonally, so

$$\dim\ker N_v=\dim\mathfrak z(v)-1\ \ge\ \lfloor m/2\rfloor-1,$$

the bound because $\mathfrak z(v)$ contains a maximal torus through $v$. **So $\ker N_v=0$ exactly when $m\le3$**, the same boundary, and the same arithmetic, as the $\mathfrak c\ne0$ discharge written into [stratum-two-negative.md](../findings/stratum-two-negative.md) at the 2026-09-04 audit. The two are consistent.

## 4. It is not vacuous, in either assertion

- **$N_v\succeq0$ is not vacuous:** $N_v\ne0$ for $v\ne0$, since $\langle v,N_vv\rangle=2\lVert v\rVert^4>0$ (the $\mathrm{ad}$ term contributes nothing at $u=v$). So the operator is never the zero operator that would make positivity content-free.
- **The kernel is never everything:** $v\notin v^\perp$ for $v\ne0$, so $\ker N_v$ is a proper subspace. And it is never everything-but-a-line either, by §3 it has dimension $\dim\mathfrak z(v)-1$, which at $v=e_{12}\in\mathfrak{so}(m)$ is $\binom{m-2}2+1$, a large space. **The degenerate case is where the lemma says the most**, the reverse of the L32 situation.
- **What is genuinely easy** is positivity; the content sits in the kernel identification and in what §6 makes of it.

## 5. The record already holds the kernel under a second name, unjoined

**$\ker N_v$ and [Lemma L32](../findings/isotropy-cap.md)'s $\mathfrak c$ are the same subspace.** L32 sets $\mathfrak c=\mathfrak z(x)\cap x^\perp$; L80 concludes $\ker N_v=v^\perp\cap\mathfrak z(v)$. Same object, two names, forty lines apart in one file, with no cross-reference in either direction.

This is not cosmetic. In [Lemma L33](../findings/stratum-two-negative.md)'s proof the chain is *L80 gives $\ker N_x=\mathfrak c$* → *L32 applied to $\mathfrak c$* → *the $y_i$ collapse*, and **L32's repaired hypothesis $\mathfrak c\ne0$ is precisely "$N_x$ is singular"**. Stating the link would let the discharge be read off L80's dimension formula instead of re-derived. *Recommend one sentence in the L80 block naming $\ker N_v$ as L32's $\mathfrak c$.*

## 6. A strengthening the record is leaving on the table, the two sides are EQUAL, not contained

Two places describe the consequence of $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ as a **containment**: [isotropy-cap.md](../findings/isotropy-cap.md) ("kernel containment runs from the smaller side to the larger") and [petersen-wink notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) ("becomes a containment of centralisers"). **What the identity actually gives is an equality.**

Split the identity by sign: $\sum_{\lambda_\alpha>0}\lambda_\alpha N_{v_\alpha}=\sum_{\lambda_\alpha<0}\lvert\lambda_\alpha\rvert N_{v_\alpha}$, two PSD operators. The kernel of a positive combination of PSD operators is the intersection of their kernels, so

$$\bigcap_{\lambda_\alpha>0}\big(v_\alpha^\perp\cap\mathfrak z(v_\alpha)\big)\ =\ \bigcap_{\lambda_\alpha<0}\big(v_\alpha^\perp\cap\mathfrak z(v_\alpha)\big),$$

the zero-eigenvalue directions dropping out and therefore constrained by nothing. **Containment in one direction is true and strictly weaker.** [L33](../findings/stratum-two-negative.md) uses only the weak direction, so nothing downstream is wrong; but a reader who takes "containment" as the ceiling loses the reverse inclusion for free. *This is a strengthening, recorded as such, not a defect.*

## 7. Normalisation, L80 is immune, the identity it feeds is not

[conventions.md](../findings/conventions.md) carries two $\Lambda^2$ pairings differing by a factor $2$ and warns that builds have disagreed over exactly this.

- **L80's two conclusions are pairing-free.** Both hold for $c\,(v\otimes v)-\mathrm{ad}(v)^2$ at any $c>0$, and $\mathrm{ad}(v)$ is skew-adjoint for either pairing, both being multiples of the trace form. *At $c=0$ the kernel would be $\mathfrak z(v)$, so the kernel claim does need $c$ strictly positive, which $c=2$ supplies with room.*
- **The coefficient $2$ is not pairing-free.** It is $\mathcal A$'s eigenvalue on $\mathrm{Weyl}_m$ from [Lemma L79](../findings/isotropy-cap.md), and $\mathcal A=\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2$ scales as $1/s$ under $\langle\cdot,\cdot\rangle\mapsto s\langle\cdot,\cdot\rangle$ while $\sum_\alpha\lambda_\alpha v_\alpha\otimes v_\alpha=W$ does not. **So $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ holds in one normalisation only.**
- **Which one, and it checks out.** The pairing is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, in which $\{\varphi_{ab}\}_{a<b}$ is orthonormal. Two independent pins agree: [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ holds in it (by hand, $[\varphi_{12},\varphi_{1k}]=-\varphi_{2k}$ of norm $1$, over $2(n-2)$ non-vanishing brackets), and it forces $\mathcal A(\mathrm{Id})=-2(m-2)$, which is [L79](../findings/isotropy-cap.md)'s $\mathbb R\cdot\mathrm{Id}$ row. **No error, but the three copies of the identity name no pairing**, while [r61](REVIEW_r61.md) did. *Recommend the pairing be named at [isotropy-cap.md](../findings/isotropy-cap.md) line 196, [results.md](../results.md) line 442 and [stratum-two-negative.md](../findings/stratum-two-negative.md) line 134.*

## 8. Uses, and whether they sit inside the hypotheses

| site | use | inside hypotheses? |
| --- | --- | --- |
| [stratum-two-negative.md](../findings/stratum-two-negative.md), [L33](../results.md)'s proof | $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$, then $\ker N_x=\mathfrak c$ fed to L32 | **yes**, L80 has no hypotheses to violate; the PSD-sum step is valid, and L33's own $\mathfrak c\ne0$ debt is discharged there |
| [results.md](../results.md) line 442 | the identity only, inside L33's entry | yes; L80 itself is not a numbered entry in results.md, which carries a subset of the numbering |
| [petersen-wink notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) | novelty claim: the splitting is not in the source | **not checked**, settling it needs the arXiv text, which this brief forbids opening. [r60](REVIEW_r60.md) reports having checked it against the LaTeX source |

## 9. Bookkeeping defect, the index says no verdict, and two verdicts exist

[findings/INDEX-results.md](../findings/INDEX-results.md) line 95 reads *"**80** | Lemma | **Gate 2: no verdict on the record.** $N_v\succeq0$, with its kernel identified"*.

**That is false.** [REVIEW_r60.md](REVIEW_r60.md) confirms it in its verdict list, and [REVIEW_r61.md](REVIEW_r61.md) carries it as row **C2**, *"positivity and kernel of $N_v$ (CONFIRMED (and elementary), one line)"*. Both are on the record. *Recommend the row be updated to Gate 2 passed by r60 and r61, plus this review.*

## 10. Screen

Permitted under [analysis-only.md](../.claude/rules/analysis-only.md) as a screen of claims I was about to record; **it is a screen and is not offered as evidence for anything positive above**, each of which is proved in the text.

Built $\mathfrak{so}(m)$ in the $\tfrac12\operatorname{tr}$ pairing at $m=3,\dots,7$, generic $v$ and $v=e_{12}$: $\lambda_{\min}(N_v)\ge-1.3\times10^{-14}$ throughout, and $\dim\ker N_v=\dim\mathfrak z(v)-1=\dim(v^\perp\cap\mathfrak z(v))$ at every row, including $0$ at $m=3$ and $10$ at $m=7$, $v=e_{12}$. $\mathcal A(\mathrm{Id})=-2(m-2)$ exactly, and diagonal, at $m=4,5,6$.

---

## Summary of recommendations

1. **Add the missing clause** to L80's block: $N_v$ is symmetric, so the null set of the form is the kernel, this is the $\subseteq$ inclusion, and it is the only one that needs an argument.
2. **Record that L80 needs no hypothesis**, explicitly, since its two neighbours in the same file both lost one this week.
3. **Join $\ker N_v$ to [L32](../findings/isotropy-cap.md)'s $\mathfrak c$**, one sentence; it makes L33's discharge a corollary of L80's dimension count.
4. **Upgrade "containment" to equality** in [isotropy-cap.md](../findings/isotropy-cap.md) and the [petersen-wink notes](../references/petersen-wink-2019-bochner-technique/notes.md).
5. **Name the pairing** at the three copies of $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$; the coefficient $2$ depends on it and L80 does not.
6. **Fix [INDEX-results.md](../findings/INDEX-results.md) row 80**, which claims no Gate 2 verdict while two exist.
