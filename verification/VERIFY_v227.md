# VERIFY_v227, Lemma L41, a cold reading

The brief [BRIEF_L41.md](BRIEF_L41.md) was read cold, sections A–D, before any other file. **No numerical work of any kind was done**, no script, no Sage, no Python, no numeric evaluation; the programme's analysis-only rule was in force and no per-task computation approval was held. Every witness below is exhibited in closed form, and the two places where a recorded figure is quoted ($G_0=16$ at $n=8$, L70's slack $2(m-2)\theta$) are quoted as corroboration of a closed form derived here, never as its evidence. Log: [agent_logs/verify-L41-v227.log](../agent_logs/verify-L41-v227.log).

## Claim table

| # | Claim, as written | Verdict |
|---|---|---|
| C1 | The scale question, both identities as stated | **BROKEN AS WRITTEN.** Identity 1 needs $\lVert W\rVert=1$; identity 2 needs a factor $\lVert W\rVert^2$, which the clause "on all of $\mathcal W_n$" makes unavoidable |
| C2 | $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta(W)$, "in two lines from $A(W)=2W$ and the definition of $\#$" | **PROVEN at $\lVert W\rVert=1$.** The two lines close. They close from three inputs, not two, the third is unnamed |
| C3 | $\sum_\gamma g_\gamma=4(n-1)$ on all of $\mathcal W_n$, critical or not | **BROKEN AS WRITTEN; PROVEN as $4(n-1)\lVert W\rVert^2$.** Criticality is genuinely unused. The proof needs [Lemma L153](../findings/bounds.md), which L41 names nowhere |
| C4 | $\theta\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}4$ | **PROVEN at $\lVert W\rVert=1$.** The three-way split is exhaustive and the right side is nonnegative |
| C5 | Equality exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace | **BROKEN.** "If" holds; "only if" fails at padded $W_{\mathbb{CP}^2}$ for every $n\ge5$, where $G_0=4(n-4)>0$. Correct set: $E_{\min}\oplus\ker W$ |
| C6 | The equality case "is the same statement as [Lemma L70](../findings/bounds.md)'s, in the coordinates of $g$ rather than of $D$" | **BROKEN.** The two equality sets differ. $W_{\mathbb{CP}^3}$ and the maximal tori attain L41's and miss L70's |
| C7 | The bound saturates on the whole subalgebra family of [Lemma L23](../results.md) | **PROVEN**, in one line, and it is the entry's own refutation of C6 |
| C8 | Are $\Delta$ and $G_0$ defined on the record? | **GAP for $\Delta$.** It is glossed in [results.md](../results.md) alone, absent from the block, and [conventions.md](../findings/conventions.md) tables the letter against a different object |
| C9 | The padded-kernel trap | **ANSWERED.** The bound degenerates to the $\Pi$-bound under padding unless $G_0$ is known; $G_0$ is computable there, and equals $4(n-4)$ at padded $W_{\mathbb{CP}^2}$ |

**Verdict: BROKEN.** The mathematics survives, both identities and the bound are true and provable at unit norm, and criticality is not needed for any of them, but three clauses of the entry as written are false: the two normalisations, the equality case, and the identification with L70. Two of the three had already been found and never repaired.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\mathcal W_n$: "the space of algebraic Weyl curvature operators on $\mathbb R^n$", **a linear space**.
- $P(W)$: "the cubic form $\langle W,Q(W)\rangle$"; $Q(W)=W^2+W^\#$.
- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$", **defined at every $W\ne0$, scale-invariant**.
- "Critical point" is $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$", so the phrase carries $\lVert W\rVert=1$ inside it.
- $g_k$, $G_2$: "$g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$ … **The first two moments are pinned**, $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$, both from (A) and (B) with the cubic identity and **neither needing criticality**".
- Structure constants: "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric** … so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide."
- $\#$: "$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$".
- The Killing row marginal is **[Lemma L153](../findings/bounds.md)**, "in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$".
- $\Delta$: "the symmetry defect. Discontinuous at eigenvalue zero-crossings, and traced over $\{\lambda>0\}$ only", sourced to [diagonal-half.md](../findings/diagonal-half.md), **which is not the object L41 needs**; see §7.
- $\mathfrak m$, $\mathfrak h$: "at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$", and the letter carries three incompatible senses.

**The first of these lines already contains this round's headline corrections.** The conventions table carries both moments in their scale-correct form, and says criticality is not needed; the canonical entry and the block carry neither correction.

## 1. The hypothesis inventory

*A pass with no inventory is not a pass. "Stated" means stated in section A, B or C of the brief.*

| # | Hypothesis or input | Stated? | Used? | Note |
|---|---|---|---|---|
| H1 | $W\in\mathcal W_n$, an algebraic Weyl operator | **yes** | **yes, essentially** | Consumed through H6, which needs first Bianchi *and* Ricci-flatness ([bounds.md](../findings/bounds.md), [r331](../reviews/REVIEW_r331.md) Q1). Off $\mathcal W_n$ the identities are false, not merely rescaled |
| H2 | $\lVert W\rVert=1$ | **no** | **yes, by all three displays** | The whole of §2. Present inside "critical point" at [results.md](../results.md); absent from the block, which has no criticality hypothesis at all |
| H3 | $W$ critical, $Q(W)=\theta W$ | yes, in A and B | **no** | Consumed only as a carrier of H2. Replacing it by H2 strengthens the lemma; see §3 |
| H4 | $\{v_\gamma\}$ an **orthonormal** eigenbasis of $W$, read in $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ | "eigenbasis" only | **yes** | Orthonormality and the $\mathfrak{so}(n)$ identification are both load-bearing ($\mathrm{ad}(v_\gamma)$ is meaningless without the second) and neither is written |
| H5 | $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ totally symmetric | **no** | **yes, twice** | Available at [conventions.md](../findings/conventions.md); the block does not quote it |
| H6 | $A(W)=2W$, i.e. $\operatorname{tr}(W\,\mathrm{ad}(v_\alpha)^2)=2\lambda_\alpha$ | **yes, as an input** | **yes, twice** | Named but **never defined and never cross-referenced** from L41. The letter $A$ is heavily overloaded; see §7 |
| H7 | The $\#$ normalisation | **yes** | **yes** | Quoted correctly from [conventions.md](../findings/conventions.md) |
| H8 | [Lemma L153](../findings/bounds.md), $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ | **no** | **yes, load-bearing for C3** | The single largest omission. The entry asserts $\sum g=4(n-1)$ with no source of any kind |
| H9 | $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$, Petersen–Wink Prop 1.7 | **no** | **yes** | Cited in [bounds-relaxations.md](../findings/bounds-relaxations.md) and in [conventions.md](../findings/conventions.md), not from L41. It is one line of algebra and needs no Weyl hypothesis ([r70](../reviews/REVIEW_r70.md)) |
| H10 | $n\ge4$ | **no** | **yes** | $\mathcal W_n=0$ for $n\le3$, so the statement is vacuous there rather than false. The record's *alternative* proof of C3, the Casimir route, additionally needs $n\ge5$; see §4 |
| H11 | $\lambda_{\min}<0<\lambda_{\max}$ | **no** | **yes** | From $\operatorname{tr}W=0$ at $W\ne0$. It is what makes $\lvert\lambda_{\min}\rvert>0$ and what makes $E_{\min}\cap\ker W=0$, which is the whole of §6 |
| H12 | $\Delta:=\sum_{\lambda_\gamma>0}g_\gamma$ | glossed in A only | **yes** | Absent from the block, absent from the landscape line, and the letter is tabled against a different object; see §7 |
| H13 | $g_\gamma\ge0$ | **yes** | **yes** | Immediate from the definition; "manifestly $\ge0$ at every $W$" per [conventions.md](../findings/conventions.md) |

## 2. The scale question, which is the round's first

**Both stated identities are false at every scale but one, and the corrections are not the same correction.**

Under $W\mapsto tW$ the eigenbasis is unchanged and $\lambda_\gamma\mapsto t\lambda_\gamma$, so $[\mathrm{ad}(v_\gamma),tW]=t[\mathrm{ad}(v_\gamma),W]$ and $g_\gamma\mapsto t^2g_\gamma$. Hence

$$\sum_\gamma\lambda_\gamma g_\gamma\ \mapsto\ t^3\sum_\gamma\lambda_\gamma g_\gamma,\qquad \sum_\gamma g_\gamma\ \mapsto\ t^2\sum_\gamma g_\gamma,$$

while $\theta$ is homogeneous of degree $0$ and $4(n-1)$ of degree $0$. So the first identity equates degree $3$ with degree $0$ and the second degree $2$ with degree $0$. **Neither can hold on a scaling ray unless both sides vanish.**

**The corrected forms, which §3 and §4 prove:**

$$\boxed{\ \sum_\gamma\lambda_\gamma g_\gamma=-4P(W)\ },\qquad\boxed{\ \sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2\ },\qquad\boxed{\ P(W)\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)\lVert W\rVert^2-\Delta-G_0}4\ }$$

each homogeneous of the right degree, each valid on the whole of $\mathcal W_n$, and each reducing to the stated display at $\lVert W\rVert=1$, where $P=\theta$.

**Are the stated forms true at any scale?** Yes, at $\lVert W\rVert=1$ and there only, except on the measure-zero set where the identity degenerates ($\theta=0$ for the first; the second, $4(n-1)\lVert W\rVert^2=4(n-1)$, forces $\lVert W\rVert=1$ outright at every $n\ge2$).

**Is Section D's correction the right one here?** Section D repairs [Lemma L70](../findings/bounds.md) by inserting "**with $\lVert W\rVert=1$**" into the hypothesis, with the reason "the identity holds at one scale only, its two sides being homogeneous of different degrees". That is exactly the diagnosis here, and inserting the same clause repairs L41's first identity and its bound. **It does not repair the second identity**, because that clause is stated as reaching *past* the unit sphere ("on all of $\mathcal W_n$, critical or not") and a hypothesis $\lVert W\rVert=1$ contradicts the clause instead of fixing it. **So L41 needs Section D's correction plus one more**: the $\lVert W\rVert^2$ factor on the universal clause. That is the one place this lemma's normalisation differs from its neighbour's.

**Discrepancy protocol.**
1. *Located.* [results.md:190](../results.md) (both identities), [results.md:605](../results.md) (both, and the bound), [target.md:704–706](../findings/target.md) (both, and the bound), [target.md:327–333](../findings/target.md) (the originating passage), [bounds-relaxations.md:118](../findings/bounds-relaxations.md) (the first identity again).
2. *Exhibited concretely, in closed form.* Take any $W\in\mathcal W_n$ with $\theta(W)\ne0$ (padded $W_{\mathbb{CP}^2}$ at $n=8$ serves, $\theta=\sqrt{3/2}$) and set $W'=2W$. Then $\sum_\gamma g_\gamma(W')=4\sum_\gamma g_\gamma(W)=16(n-1)$, against the asserted $4(n-1)$; and $\sum_\gamma\lambda_\gamma g_\gamma(W')=8\cdot(-4\theta)=-32\theta$, against the asserted $-4\theta(W')=-4\theta$. No arithmetic beyond the homogeneity degrees is involved.
3. *The opposite argued.* Could $\mathcal W_n$ silently mean its unit sphere? [conventions.md](../findings/conventions.md) defines it as the linear space, and the sentence in question is the one that *extends* the claim off the critical set, where nothing else pins the norm; [results.md:190](../results.md) states it with no norm anywhere in the line. Could the block's "$W$" be unit by context? The block (section C) opens "Write $g_\gamma=\ldots$ in an eigenbasis of $W$" with no hypothesis at all (not even criticality) so no reading recovers it. **Not withdrawn.**

## 3. The identity, and the two lines

**Setting.** $W$ is a symmetric operator on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $\{v_\gamma\}$ an orthonormal eigenbasis, $Wv_\gamma=\lambda_\gamma v_\gamma$. Writing $[\mathrm{ad}(v_\gamma),W]$ in that basis,

$$\big\langle v_\alpha,[\mathrm{ad}(v_\gamma),W]v_\beta\big\rangle=(\lambda_\beta-\lambda_\alpha)\,c_{\gamma\beta\alpha},\qquad\text{so}\qquad g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$$

H9, one line, and the form [conventions.md](../findings/conventions.md) tables.

**Line 1.** Expand $(\lambda_\alpha-\lambda_\beta)^2$ and use the total symmetry of $T$ (H5) to fold the two square terms together:

$$\sum_\gamma\lambda_\gamma g_\gamma=\sum_{\alpha\beta\gamma}\lambda_\gamma(\lambda_\alpha^2+\lambda_\beta^2-2\lambda_\alpha\lambda_\beta)T_{\gamma\alpha\beta}=2U-2V,\quad U:=\sum_{\alpha\beta\gamma}\lambda_\alpha^2\lambda_\gamma T_{\gamma\alpha\beta},\quad V:=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}.$$

**Line 2.** Summing $T$ over one free index gives $\sum_\beta T_{\gamma\alpha\beta}=\lVert[v_\gamma,v_\alpha]\rVert^2$, and skew-adjointness of $\mathrm{ad}$ gives $\lVert[v_\alpha,v_\gamma]\rVert^2=-\langle\mathrm{ad}(v_\alpha)^2v_\gamma,v_\gamma\rangle$, so

$$\sum_\gamma\lambda_\gamma\lVert[v_\alpha,v_\gamma]\rVert^2=-\operatorname{tr}\!\big(W\,\mathrm{ad}(v_\alpha)^2\big)=-2\lambda_\alpha$$

by H6. Hence $U=\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)=-2\operatorname{tr}(W^3)$. For $V$, the $\#$ normalisation (H7) gives $W^\#=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta[v_\alpha,v_\beta][v_\alpha,v_\beta]^{\mathsf T}$, so $\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma c_{\alpha\beta\gamma}^2=\tfrac12V$. Therefore

$$\sum_\gamma\lambda_\gamma g_\gamma=-4\operatorname{tr}(W^3)-4\langle W,W^\#\rangle=-4\big\langle W,W^2+W^\#\big\rangle=-4P(W).$$

**The two lines close.** They close from **three** inputs, not the two named: $A(W)=2W$, the definition of $\#$, and the total symmetry of $T$, plus the eigenbasis expansion H9, which is the writing-down step. The claim "in two lines" is fair as a claim about length and understates the inputs.

**Cross-check against the record's own algebra, not against a number.** [target.md](../findings/target.md)'s four proved identities give $M_{\alpha\beta}=\tfrac12\langle W[v_\alpha,v_\beta],[v_\alpha,v_\beta]\rangle$ off the diagonal, $M_{\alpha\alpha}=\lambda_\alpha$, and $\langle\lambda,M\lambda\rangle=P$. Since $c_{\alpha\alpha\gamma}=0$, that reads $\operatorname{tr}(W^3)+\tfrac12V=P$, i.e. $V=2\langle W,W^\#\rangle$, the same value, obtained from an independent recorded identity.

**Criticality.** Nothing above uses $Q(W)=\theta W$. What "critical point" supplies at [results.md:605](../results.md) is $\lVert W\rVert=1$, smuggled in through [conventions.md](../findings/conventions.md)'s definition of the phrase; that is the *only* content of H3 the argument consumes. **So the hypothesis is not unused so much as used for the wrong reason**, and the correct statement replaces "critical point" by "$\lVert W\rVert=1$", strictly stronger, and it is what the block, which states no criticality, actually needs.

## 4. The universal claim, $\sum_\gamma g_\gamma=4(n-1)$

Same expansion, weight $1$:

$$\sum_\gamma g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2\lVert[v_\alpha,v_\beta]\rVert^2 = 2\sum_\alpha\lambda_\alpha^2\underbrace{\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2}_{=\,2(n-2)\ \text{by L153}}\;-\;2\sum_\alpha\lambda_\alpha\underbrace{\sum_\beta\lambda_\beta\lVert[v_\alpha,v_\beta]\rVert^2}_{=\,-2\lambda_\alpha\ \text{by }A(W)=2W}$$

$$=\;4(n-2)\lVert W\rVert^2+4\lVert W\rVert^2\;=\;4(n-1)\lVert W\rVert^2 .$$

**Criticality is genuinely unused**, the entry's own "critical or not" is right, and [conventions.md](../findings/conventions.md) says the same of both moments. What *is* used, and is stated nowhere in L41, is **[Lemma L153](../findings/bounds.md)** (H8). The entry asserts $\sum g=4(n-1)$ flatly, and the block asserts it inside a "With …" clause, with no proof, no pointer, and no source.

**The smallest admissible $n$.** My derivation runs at every $n$ with $\mathcal W_n\ne0$, i.e. $n\ge4$: L153 holds "at any $n\ge2$" and $A(W)=2W$ is a statement about $\mathcal W_n$. **The record's other proof of the same fact does not.** [bounds-relaxations.md](../findings/bounds-relaxations.md) derives $4(n-1)$ as the Casimir constant of $\mathrm{Weyl}_n$ and records a Gate-2 hypothesis "**$n\ge5$** … which fails at $n=4$", the adjoint of $\mathfrak{so}(4)$ being reducible. **L41 cites neither route**, so a reader who reconstructs the Casimir one inherits an $n\ge5$ restriction the statement does not carry and does not need. That is a live confusion, not a defect in the claim.

**A universal claim with no witness.** The brief names this one, and it is the right target: as written the claim is *refuted* by every rescaling (§2). As corrected it is an identity with a one-line proof, so the witness question dissolves, but the entry's version is a universal quantifier over a linear space attached to a degree-$2$ quantity, and that is precisely the shape that fails silently.

## 5. The bound

At $\lVert W\rVert=1$. Split the index set by the sign of $\lambda_\gamma$ into $\{\lambda>0\}$, $\{\lambda<0\}$ and $\{\lambda=0\}$, **exhaustive and pairwise disjoint**, and the third is exactly an orthonormal basis of $\ker W$, so with $\Delta=\sum_{\lambda>0}g_\gamma$, $G_0=\sum_{\ker W}g_\gamma$ and $G_-=\sum_{\lambda<0}g_\gamma$ we have $\Delta+G_-+G_0=4(n-1)$. Then

$$-4\theta=\sum_\gamma\lambda_\gamma g_\gamma=\underbrace{\sum_{\lambda>0}\lambda_\gamma g_\gamma}_{(a)\ \ge\ 0}+\underbrace{\sum_{\lambda<0}\lambda_\gamma g_\gamma}_{(b)\ \ge\ \lambda_{\min}G_-}+\ 0\ \ \ge\ \lambda_{\min}G_-=-\lvert\lambda_{\min}\rvert\big(4(n-1)-\Delta-G_0\big),$$

so $\theta\le\lvert\lambda_{\min}\rvert\big(4(n-1)-\Delta-G_0\big)/4$. **Correct as stated, at unit norm.**

Two remarks the entry does not make. First, $4(n-1)-\Delta-G_0=G_-\ge0$, so the right side is never negative, the bound is never vacuous by sign. Second, step (a) discards the entire positive-eigenspace contribution; [bounds-relaxations.md](../findings/bounds-relaxations.md) already carries the sharpened member $\theta\le(\lvert\lambda_{\min}\rvert M-\lambda_{\mathfrak p}^{\min}\Delta)/4$ with $M=4(n-1)-\Delta-G_0$, obtained by keeping (a). **So L41 as numbered is the weakened member of a two-member family whose sharp member is on the record.** That is a scoping remark, not a defect.

**Dropping $\Delta$ and $G_0$ altogether gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert$**, which is [Lemma L107](../findings/bounds.md), the $\Pi$-bound, [post F40](../findings/fence-posts.md) states the identification. L41 therefore *refines* L107, which matters for §6.

## 6. The equality case, both directions, BROKEN

**Sufficiency holds.** If $g$ is supported on $E_{\lambda_{\min}}$ then $\Delta=G_0=0$, $G_-=4(n-1)$, and $\sum\lambda_\gamma g_\gamma=\lambda_{\min}\cdot4(n-1)$, so $\theta=(n-1)\lvert\lambda_{\min}\rvert$ and both sides agree.

**Necessity fails.** Equality forces equality in (a) *and* in (b) above, that is

$$g_\gamma=0\ \text{ for every }\gamma\text{ with }\lambda_\gamma>0,\qquad\text{and}\qquad g_\gamma=0\ \text{ for every }\gamma\text{ with }\lambda_{\min}<\lambda_\gamma<0,$$

with $g$ on $\ker W$ **wholly unconstrained**, the kernel terms are killed by their own weight $\lambda_\gamma=0$, not by $g_\gamma$. So the correct characterisation is

$$\boxed{\ \text{equality}\iff g\ \text{is supported on}\ E_{\lambda_{\min}}\oplus\ker W\ }$$

and the stated condition is strictly stronger than the truth. **The tell is inside the display itself**: under the stated equality condition $G_0$ is identically zero, so writing $G_0$ into a bound whose equality case forbids it would be writing a term that vanishes exactly when it is needed.

**Discrepancy protocol.**

1. *Located.* [results.md:190](../results.md), [results.md:605](../results.md), [target.md:708](../findings/target.md), all three carry the same words.

2. *Exhibited concretely, in closed form.* Take $W$ the Weyl operator of $\mathbb{CP}^2$, unit norm, padded into $\Lambda^2\mathbb R^n$ for any $n\ge5$. Its spectrum on $\Lambda^2\mathbb R^4$ is $\tfrac1{\sqrt6}(2,-1,-1)$ on $\Lambda^+$ and $0$ on $\Lambda^-$, so $\lambda_{\max}=2/\sqrt6$, $\lambda_{\min}=-1/\sqrt6$, and $-1/\sqrt6$ is the **only** negative eigenvalue, making condition (b) vacuous. For (a): $W$ is $U(2)$-invariant, so $\mathrm{Ad}(u)W\mathrm{Ad}(u)^{-1}=W$ for $u\in U(2)$ and differentiating gives $[\mathrm{ad}(v),W]=0$ for every $v\in\mathfrak u(2)$; the $\lambda_{\max}$ eigenvector is the Kähler form $J\in\mathfrak u(2)$, so $g_{\lambda_{\max}}=0$ and $\Delta=0$. **Equality therefore holds.** Now $\theta=\sqrt{3/2}$ gives $G_-=4\theta/\lvert\lambda_{\min}\rvert=4\cdot\tfrac{\sqrt6}2\cdot\sqrt6=12$, whence

$$G_0=4(n-1)-\Delta-G_-=4n-16=4(n-4)\;>\;0\quad\text{for every }n\ge5 .$$

   So $g$ carries strictly positive mass on $\ker W$ and is **not** supported on $E_{\lambda_{\min}}$. Two independent confirmations that this closed form is the right one: at $n=4$ it returns $G_0=0$, which is forced directly by $[\Lambda^+,\Lambda^-]=0$, every $v\in\Lambda^-=\ker W$ has $\mathrm{ad}(v)$ annihilating $\Lambda^+$ and preserving $\Lambda^-\subseteq\ker W$, so $[\mathrm{ad}(v),W]=0$; and at $n=8$ it returns $16$, which is the figure [bounds-relaxations.md](../findings/bounds-relaxations.md) records ("$16$ of $28$ in the kernel"). *That the record's kernel mass appears at $n\ge5$ and not at $n=4$ is the padding trap doing exactly what §9 says it does.*

3. *The opposite argued.* Could "the $\lambda_{\min}$ eigenspace" be read to include $\ker W$? No: $\operatorname{tr}W=0$ at $W\ne0$ forces $\lambda_{\min}<0<\lambda_{\max}$ (Section D's own clause) so $E_{\lambda_{\min}}\cap\ker W=0$ and the two are disjoint by the lemma's own standing facts. Could "supported on" mean "supported on, after discarding the kernel"? That is the corrected statement, not the written one, and it would make the phrase mean something different in L41 from what it means four lines earlier in the same display. **Not withdrawn.**

**Already found, never repaired.** [bounds-relaxations.md:346](../findings/bounds-relaxations.md) states: "[Lemma L41](../findings/target.md) and its canon copy **state their equality case wrongly** … it should read $E_{\min}\oplus\ker W$." I agree with that correction and confirm it is complete, the $E_{\min}\oplus\ker W$ form also disposes of the middle-negative case, which that note does not separately mention. The defect has been on the record and neither the canonical entry, nor the landscape line, nor the block was changed. [LEDGER.md](../findings/LEDGER.md) carries L41 as "**CONFIRMED**, both rebuilding the identities from $T$-symmetry. *Two statement defects recorded*", the verdict is right about the identities and the two defects were never propagated to the statement.

## 7. The identification with Lemma L70, BROKEN

**What L70 says.** [bounds.md](../findings/bounds.md): at every critical point and every unit $v\in E_{\min}$, $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ with $D(v)=\tfrac12\sum_{a,b}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2\ge0$, and "**equality holds exactly when $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$** … for every unit $v\in E_{\min}$."

**They are different statements.** L41's condition ranges over *which rows* $\gamma$ carry $g_\gamma>0$ and says nothing about the pair distribution inside a row; L70's condition ranges over *the pair distribution* inside the $E_{\min}$ rows and says nothing about any other row. Neither implies the other, and their solution sets differ.

**Discrepancy protocol.**

1. *Located.* [results.md:605](../results.md): "The equality case is the same statement as Lemma L70's, in the coordinates of $g$ rather than of $D$; the record cites them as one piece of evidence."

2. *Exhibited concretely, in closed form, three witnesses.*

   **(i) $W_{\mathbb{CP}^m}$, $m\ge3$, at $n=2m$.** [nondegeneracy.md](../findings/nondegeneracy.md) gives the closed form $e=W/\theta=-\tfrac1{2m-1}P_{\mathfrak m}+\tfrac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\tfrac{2(m-1)}{2m-1}P_\omega$. *L41 equality holds*: $W$ is $U(m)$-invariant, so $[\mathrm{ad}(v),W]=0$ for every $v\in\mathfrak u(m)=\mathfrak{su}(m)\oplus\mathbb R\omega$, which is exactly the strictly-positive eigenspace at $m\ge3$; hence $\Delta=0$. All three eigenvalues are nonzero at $m\ge3$, so $\ker W=0$ and $G_0=0$; and $-\theta/(2m-1)$ is the only negative eigenvalue, so condition (b) is vacuous. *L70 equality fails*: $\lambda_{\min}+(n-2)\lambda_{\max}=\tfrac\theta{2m-1}\big(-1+2(m-1)\cdot2(m-1)\big)=\theta\,\tfrac{(2m-3)(2m-1)}{2m-1}=(2m-3)\theta$, so the slack is $2(m-2)\theta>0$ for every $m\ge3$, the closed form [nondegeneracy.md](../findings/nondegeneracy.md) records, re-derived here. **$\mathbb{CP}^3$ attains L41's equality and misses L70's by exactly $2\theta$.**

   **(ii) The maximal torus $\mathfrak{so}(2)^{n/2}$, and the whole of [Lemma L23](../results.md)'s family.** See §8: every member attains L41's equality by a one-line argument. [bounds.md](../findings/bounds.md)'s own table records the tori at L70-slack $1.291$, $2.160$, $2.846$ at $n=6,8,10$ and $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ at $0.836660$, against $0.000000$ at the balanced splits, and the accompanying sentence, "so it separates the balanced sphere products from the rest of the subalgebra family", is the direct negation of L41's own closing sentence about the same family.

   **(iii) The structural version.** [Lemma L71](../findings/bounds.md) proves that a critical point at unit norm, $n\ge5$, saturating L70 **is** the balanced sphere product $S^{n/2}\times S^{n/2}$. L41's equality set contains $\mathbb{CP}^3$, $\mathbb{CP}^4$, the maximal tori and padded $W_{\mathbb{CP}^2}$, none of which is one. **So the two equality sets are not merely differently phrased; L70's is a single point per even $n$ and L41's is an infinite family.**

3. *The opposite argued.* Could "the same statement" survive at the *sharp* member of L70's family rather than the weakened boxed one? [bounds.md](../findings/bounds.md) states the two agree whenever $\dim E_{\min}\ge2$, and $\dim E_{\min}=m(m+1)=12$ at $\mathbb{CP}^3$, so witness (i) is untouched. Could "the same statement" mean only a family resemblance, both saying the mass sits at the bottom? The sentence continues "the record cites them as one piece of evidence", which is an operative claim about how the evidence is counted, so a resemblance will not carry it. **Not withdrawn.**

**What is true instead.** [bounds.md](../findings/bounds.md) records that "**both of this record's standing spectral bounds are one system read twice, [Lemma L70](../findings/bounds.md) at the $\lambda_{\min}$ row, the $\Pi$-bound at the $\lambda_{\max}$ row**". L41's bound is the $\Pi$-bound refined by $\Delta$ and $G_0$ (§5). **So L70 and L41 are two different rows of one pinned system, and that is the accurate relation**, siblings, with different equality sets, and not one statement in two coordinate systems.

**Impact.** Citing them as one piece of evidence *understates* the evidence, since L41's equality set strictly contains L70's, the conservative direction, and no recorded result is damaged by it today. The live risk is one inference away: L70's equality case has a strong consequence, L71's rigidity theorem, and anyone who reads the identification forward would conclude that an L41 equality point is a balanced sphere product. **$\mathbb{CP}^3$, the maximal tori and padded $W_{\mathbb{CP}^2}$ all refute that.** I found no site making the inference; the false premise is what should go.

## 8. The L23 clause, which the entry gets right

*"The bound saturates on the whole subalgebra family of Lemma L23, so it separates nothing there."* **Proven, in one line.** L23's $W_{\mathfrak h}$ is the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra, $\mathfrak m=\mathfrak h^\perp$, $0<r<N$. For $v\in\mathfrak h$, $\mathrm{ad}(v)$ preserves $\mathfrak h$ (a subalgebra) and hence $\mathfrak m$ (ad-invariance of the inner product), so it commutes with every operator constant on each, with $W_{\mathfrak h}$ in particular. So $g_v=0$ on $\mathfrak h=E_{\max}$, giving $\Delta=0$; the two eigenvalues $c(1-r/N)>0$ and $-cr/N<0$ are both nonzero, giving $\ker W=0$ and $G_0=0$; and there is one negative eigenvalue, so condition (b) is vacuous. **Equality holds at every member.** This corroborates [post F40](../findings/fence-posts.md)'s correction (i) analytically, where that correction was measured.

**And it is the entry's own refutation of §7**, two sentences later in the same paragraph: L41 saturates on the whole family, L70 separates the balanced splits from the rest of it, so the two equality cases cannot be one statement. **The canonical entry contradicts itself inside three sentences.**

## 9. The traps, answered by name

**$\ker W\ne0$ and padded objects.** At a padded critical point ($W$ supported on $\Lambda^2\mathbb R^k\subset\Lambda^2\mathbb R^n$), $\theta$, $\lambda_{\min}$ and $\Delta$ are padding-invariant while $4(n-1)$ grows linearly in $n$, so the bound's leading term runs away and **$G_0$ is the term that must absorb it**. Concretely at padded $W_{\mathbb{CP}^2}$: $\theta=\sqrt{3/2}$ and $\lvert\lambda_{\min}\rvert=1/\sqrt6$ at every $n$, while $\theta\le(n-1)/\sqrt6$, the $\Delta=G_0=0$ reading, which is [Lemma L107](../findings/bounds.md), is already slack at $n=5$ and vacuous by $n=12$. **The whole of the bound's content at a padded point is $G_0$**, and a consumer who cannot evaluate $G_0$ has the $\Pi$-bound and nothing more. *Can $G_0$ be computed there?* Yes, in closed form: §6 gives $G_0=4(n-4)$ at padded $W_{\mathbb{CP}^2}$, from $\Delta=0$, the single negative eigenvalue, and $G_-=4\theta/\lvert\lambda_{\min}\rvert=12$. But note what that computation consumes, it reads $G_0$ off the *equality*, so it computes $G_0$ from $\theta$ rather than $\theta$ from $G_0$. **Computing $G_0$ independently means summing $\lVert[\mathrm{ad}(v),W]\rVert^2$ over the padded directions, which is bracket data the bound's other terms do not carry**, and that is the sense in which this bound "converts the open question from one variable to two", three, at a padded point.

**Boundaries of every stated range.** L41 states no range at all: no $n$, no norm, no spectral hypothesis. The ranges it needs are $n\ge4$ (H10) and $\lVert W\rVert=1$ (H2), neither written.

**The smallest admissible $n$.** $n=4$. The statement is fine there; **the record's Casimir proof of $\sum g=4(n-1)$ is not**, needing $n\ge5$ by [bounds-relaxations.md](../findings/bounds-relaxations.md)'s own Gate-2 hypothesis. The Killing-marginal proof of §4 covers $n=4$. Since L41 cites neither proof, the reader is left to pick, and one of the two picks is wrong at the smallest admissible dimension.

**Odd $n$.** Nothing in the identities, the bound or the equality case depends on parity, unlike [Lemma L71](../findings/bounds.md), whose saturation is impossible at odd $n\ge5$ because $\dim\mathfrak m=n^2/4\notin\mathbb Z$. **That asymmetry is itself a check on §7**: an equality case that is empty at every odd $n\ge5$ cannot be the same statement as one attained at odd $n$ by the maximal torus. *Nothing found against L41 itself here.*

**The crossover $n=6+2\sqrt7$.** Not in scope. No quantity in L41 changes character at any $n$; the bound's shape is uniform. *Nothing found.*

**A claim proven on a subfamily and used in general.** The originating passage records the identity as "verified to 12 digits at $n=5,6,7,8,10$" and the bound as "verified at 13 points". §3 and §4 supply general derivations, so the claims are not resting on the sample, but the block presents a pointer where an argument belongs, and the sample omits $n=4$, which is where the alternative proof fails.

**A hypothesis stated but never used.** H3, criticality, used only as a carrier of $\lVert W\rVert=1$ (§3).

**A step using a hypothesis never stated.** H8, [Lemma L153](../findings/bounds.md), load-bearing for the $4(n-1)$ claim and named nowhere in L41. Also H5, H9 and the $\Lambda^2\cong\mathfrak{so}(n)$ identification in H4.

**A universal claim with no witness.** The $4(n-1)$ claim, as the brief names it. §4.

**An imported theorem whose hypotheses were never checked.** *Nothing found against L41.* The block imports nothing by name. Two imports sit behind it and both are clean here: **Petersen–Wink Prop 1.7** supplies H9 and "needs no Weyl hypothesis" ([r70](../reviews/REVIEW_r70.md)); **Petersen–Wink Prop 1.3** is the published form of the $\lambda$-weighted contraction, and [bounds-relaxations.md](../findings/bounds-relaxations.md) flags that its *sign* conclusion $\Lambda_{\alpha\beta\gamma}\ge0$ needs $R$ 2-nonnegative, "which a Weyl tensor is not, since $\operatorname{tr}W=0$ forces $\lambda_{\min}<0$", **L41 consumes the contraction's value and not its sign conclusion**, so the failed hypothesis is not one L41 relies on. The unital-algebra failure mode the brief recalls has no analogue here. What L41 *does* silently import is H6, whose hypotheses are real (first Bianchi **and** Ricci-flatness) and are met, since $W\in\mathcal W_n$ is stated.

**Symbol collisions.**

| symbol | finding |
|---|---|
| $\Delta$ | **Real defect.** The block uses it undefined; the canonical entry glosses it as "the mass on the strictly positive eigenspace"; [conventions.md](../findings/conventions.md) tables $\Delta$ as the symmetry defect sourced to [diagonal-half.md](../findings/diagonal-half.md), where it is $\sum_{M_{ab}>0}g_{ab}$, a **pair-indexed** sum on the diagonal locus, not a sum over eigen-rows. The object L41 needs is [curvature-invariants.md](../findings/curvature-invariants.md)'s $\Delta=\sum_{\mathfrak p}\lVert[\mathrm{ad}(v_\delta),W]\rVert^2$, and [sym3-blocks.md](../findings/sym3-blocks.md) carries a third $\Delta$. **The record has an instance of exactly this going wrong**: [curvature-invariants.md](../findings/curvature-invariants.md) records a block that "names the wrong defect, and that is what breaks it", separated by padded $W_{\mathbb{CP}^2}$ at $\Delta=0$ against $\delta^2=1/9$ |
| $A$ | **Real defect.** "$A(W)=2W$" appears with no definition and no cross-reference. [conventions.md](../findings/conventions.md) tables $A=\lambda_1$ in the two-negative relaxation and $A\in\mathrm{Sym}_0$ in $D_A$/$H_A$; [bounds.md](../findings/bounds.md)'s Hilbert–Schmidt derivation writes $A=\mathrm{ad}(v)$; and [bounds-relaxations.md](../findings/bounds-relaxations.md) sets $A:=\sum_{\mathfrak m}\lvert\lambda_\gamma\rvert g_\gamma$ **thirty lines from its own copy of L41's bound**. The record also writes the operator as $\mathcal A$ in several places. It is tabled nowhere |
| $G_0$ | Defined in the block, $G_0:=\sum_{\gamma\in\ker W}g_\gamma$ ✔; **not** defined in the landscape line [results.md:190](../results.md), which uses it bare; not tabled in [conventions.md](../findings/conventions.md). No collision found |
| $g$ | Tabled correctly in [conventions.md](../findings/conventions.md) as $g_k$ ✔. Two nearby uses of the letter to watch: [diagonal-half.md](../findings/diagonal-half.md)'s **pair-indexed** $g_{ab}$, and $g$ for a group element at [target.md](../findings/target.md). Low risk here because L41 defines $g_\gamma$ in place |
| $\lambda$ | Unambiguous inside L41, the $\Lambda^2$ spectrum, fixed by "eigenbasis of $W$". Two adjacent traps are avoided: [conventions.md](../findings/conventions.md)'s warning that $\lambda_{\max}$ carries three senses in [results.md](../results.md) at six lines' distance, and that on the diagonal locus the $\Lambda^2$ spectrum is the multiset of **entries** of $K$ rather than its eigenvalues. *Nothing found against L41* |
| $v_\gamma$ | The identification $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ that makes $\mathrm{ad}(v_\gamma)$ meaningful is used and never stated (H4). Checked against the one convention L41 quotes: the $v,w$ of $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ are bivectors too, so **no collision at the citation** |

## 10. What would falsify the statement, and what I did to look for it

**For the identities (C2, C3).** A falsifier is a $W\in\mathcal W_n$ at unit norm with $\sum_\gamma\lambda_\gamma g_\gamma\ne-4P(W)$ or $\sum_\gamma g_\gamma\ne4(n-1)$. §3 and §4 derive both from four facts, so such a $W$ would have to break one of them: $A(W)=2W$ off $\mathcal W_n$ (which is a known and recorded failure, so H1 is not decorative), [Lemma L153](../findings/bounds.md), the total antisymmetry of $c_{abc}$ (forced by ad-invariance of the inner product), or the $\#$ normalisation. **I looked by checking each input's own scope on the record**, L153 "at any $n\ge2$", $A(W)=2W$ "consumes first Bianchi *and* Ricci-flatness", Prop 1.7 "needs no Weyl hypothesis", and by cross-checking the derived value $V=2\langle W,W^\#\rangle$ against [target.md](../findings/target.md)'s independently proved $\langle\lambda,M\lambda\rangle=P$. No falsifier exists; **the only falsifiers are the rescalings of §2, which falsify the statement as written and not the mathematics**.

**For the bound (C4).** A falsifier is a $W$ with $\theta>\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$ at unit norm. Given C2 and C3 and $g\ge0$, none exists; the two discarded steps are both one-sided in the safe direction, and I checked the split is exhaustive (§5) rather than assuming it.

**For the equality case (C5), found.** The falsifier is a $W$ attaining equality with mass off $E_{\lambda_{\min}}$. **I looked for it structurally**, by reading the derivation's two equality conditions and asking which index sets they leave free (the kernel is free by construction) then looking on the record for a point with $\ker W\ne0$ and $\Delta=0$. **Padded $W_{\mathbb{CP}^2}$ at every $n\ge5$**, with $G_0=4(n-4)>0$, derived in closed form from the $U(2)$-invariance and the spectrum $\tfrac1{\sqrt6}(2,-1,-1,0,0,0)$.

**For the identification (C6), found.** The falsifier is a $W$ in one equality set and not the other. **I looked by comparing the two equality conditions as conditions**, then testing the comparison at three families whose closed forms the record already carries. **$W_{\mathbb{CP}^m}$ at $m\ge3$** (L41 equality, L70 slack exactly $2(m-2)\theta$), **the maximal tori**, and **the whole of L23's family** (L41 equality by §8; L70 separates within it). Any one of the three suffices.

**What I did not do.** No sweep, no census, no falsifier hunt by evaluation, and no run of any kind. Every witness above is a closed-form object built from data already on the record.

## 11. Verdict

**BROKEN.**

**What survives, and should replace the entry.** *Let $W\in\mathcal W_n$, $n\ge4$, with $\lVert W\rVert=1$ and orthonormal eigenbasis $\{v_\gamma\}$ of $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$; write $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2\ge0$. Then $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta(W)$ and $\sum_\gamma g_\gamma=4(n-1)$, from $A(W)=2W$, [Lemma L153](../findings/bounds.md), the total symmetry of $T$ and the definition of $\#$; neither needs criticality. On the whole of $\mathcal W_n$ the scale-free forms are $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ and $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$. With $\Delta:=\sum_{\lambda_\gamma>0}g_\gamma$ and $G_0:=\sum_{\gamma\in\ker W}g_\gamma$, $\theta\le\lvert\lambda_{\min}\rvert\big(4(n-1)-\Delta-G_0\big)/4$, with equality exactly when $g$ is supported on $E_{\lambda_{\min}}\oplus\ker W$. The bound saturates on the whole subalgebra family of [Lemma L23](../results.md), so it separates nothing there; its equality case is **not** [Lemma L70](../findings/bounds.md)'s ($W_{\mathbb{CP}^3}$ and the maximal tori attain the first and miss the second), the two being different rows of the one pinned system.*

**What must change, in order of severity.**

1. **The identification with L70 is false and must be struck** ([results.md:605](../results.md)), together with "the record cites them as one piece of evidence". It is one inference away from transporting [Lemma L71](../findings/bounds.md)'s rigidity onto $\mathbb{CP}^3$.
2. **The equality case is false and must read $E_{\min}\oplus\ker W$** at all three sites. Already found at [bounds-relaxations.md:346](../findings/bounds-relaxations.md) and never propagated.
3. **The normalisation.** Insert $\lVert W\rVert=1$ (Section D's own repair, made at the neighbouring lemma) and give the "on all of $\mathcal W_n$" clause its $\lVert W\rVert^2$.
4. **Cite [Lemma L153](../findings/bounds.md)** for the $4(n-1)$ claim, and say which of the two proofs is meant, since the Casimir one carries an $n\ge5$ the statement does not.
5. **Define $\Delta$ in the block** and table it, or rename it; and give $A(W)$ a definition and a cross-reference.
6. Replace "critical point" by "$\lVert W\rVert=1$", which is all the proof uses and is strictly stronger.
