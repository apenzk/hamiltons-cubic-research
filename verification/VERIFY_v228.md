# VERIFY_v228, Lemma L41, the $\lambda$-weighted identity and the bound it gives

**Cold read of [BRIEF_L41.md](BRIEF_L41.md).** The brief's four sections were the only text taken as given; everything else was located from the record itself. **No numerical work was done**, no script, no Sage, no evaluation. The two arithmetic screens below are exact closed-form checks on objects constructed for the purpose, run by hand, and are reported as screens. Log: [agent_logs/verify-L41-v228.log](../agent_logs/verify-L41-v228.log).

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta(W)$ | **PROVEN, HYPOTHESES CORRECTED.** True as $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$; the stated form needs $\lVert W\rVert=1$ and holds at no other scale |
| 2 | "in two lines from $A(W)=2W$ and the definition of $\#$" | **CONFIRMED, BUT THE RECORD NEVER WRITES THEM.** The two lines close; they are reconstructed in §3 and appear nowhere on the record |
| 3 | $\sum_\gamma g_\gamma=4(n-1)$ on all of $\mathcal W_n$, critical or not | **PROVEN, HYPOTHESES CORRECTED.** True as $4(n-1)\lVert W\rVert^2$; criticality is genuinely unused; the argument is on file at [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118) and is cited from nowhere in L41 |
| 4 | $\theta\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}4$ | **BROKEN AS WRITTEN.** True at $\lVert W\rVert=1$; **false at every other scale, and provably so**, at $2W$ the bracket goes negative and the bound asserts $\theta\le-17.1$ |
| 5 | equality "exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace" | **REFUTED, "only if" direction.** The correct clause is $\operatorname{supp}(g)\subseteq E_{\lambda_{\min}}\oplus\ker W$; padded $W_{\mathbb{CP}^2}$ (which the record itself lists as an equality point), has $G_0=32$ |
| 6 | the equality case "is the same statement as [Lemma L70](../findings/bounds.md)'s, in the coordinates of $g$ rather than of $D$" | **REFUTED.** L70's condition is strictly stronger; the two have different saturation sets on the one family L41's own last sentence names |
| 7 | "the bound saturates on the whole subalgebra family of Lemma L23, so it separates nothing there" | **CONFIRMED**, and proved here in three lines from $\mathfrak h$ being a subalgebra |
| 8 | $\Delta$ and $G_0$ defined on the record | **PARTLY.** $G_0$ is defined in the block. $\Delta$ is defined at [curvature-invariants.md:106](../findings/curvature-invariants.md#L106) and cited from neither the block nor the canonical entry; a third object carries the letter at [sym3-blocks.md:251](../findings/sym3-blocks.md#L251) |
| 9 | the positive / negative / kernel split is exhaustive | **CONFIRMED.** Candidate defect raised and **withdrawn**, see §9 |

**One-line summary.** The two identities are true and their two lines do close, but every displayed statement in L41 is off by a power of $\lVert W\rVert$ that the record's own neighbour lemmas [L70](../findings/bounds.md) and [L107](../findings/bounds.md) both write in; and two of the entry's four remaining clauses (the equality case and its identification with L70), are false, the first refuted by a point the entry's own source file lists as an equality witness.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), never restated.

- $\theta$ is "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$". $P(W)$ is "the cubic form $\langle W,Q(W)\rangle$", $Q(W)$ "Hamilton's quadratic map $W^2+W^\#$".
- The moments themselves are tabled, under $g_k$: "$g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, the squared **orbit-tangent** norm in direction $v_k$, manifestly $\ge0$ at every $W$ … **The first two moments are pinned**, $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$, both from (A) and (B) with the cubic identity and **neither needing criticality**."
- The three per-index relations, from [bounds.md:268](../findings/bounds.md#L268): "(A) is [Lemma L153](../findings/bounds.md) below, written on ordered pairs … **(B) is the per-row identity $A(W)=2W$**, Weyl-specific since it consumes first Bianchi *and* Ricci-flatness … (C) is criticality."
- (A) itself: "The row marginal is **[Lemma L153](../findings/bounds.md)**, in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$", with "$\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs".
- (B) in the form used below, from [target.md:626](../findings/target.md#L626): "$A(W)=2W$ is a **per-row** identity, $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$ for *every* $\alpha$".
- The cubic, from [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118): "$\sum\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=2\langle W,W^\#\rangle$ holds **off** $\mathrm{Weyl}_n$, free of Bianchi and Ricci-flatness".
- Structure constants: "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric** … so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide."
- $\Delta$, from [curvature-invariants.md:106](../findings/curvature-invariants.md#L106): "$\Delta(W):=\sum_{\delta\in\mathfrak p}g_\delta\ \in[0,\,4(n-1)]$", with $\mathfrak p$ the positive eigenspace; conventions.md glosses the same object as "the symmetry defect … traced over $\{\lambda>0\}$ only".
- $\mathfrak m,\mathfrak h$: "at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included."
- Norms: "$\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$" on $\mathfrak{so}(n)$, making $\{\varphi_{ab}\}_{a<b}$ orthonormal; and on the operator side "$\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$".
- The kernel trap, [W4](../findings/INDEX-traps.md): "the gradedness screen is vacuous when $\ker W\ne0$ … padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$."

## 1. Hypothesis inventory

**A pass with no inventory is not a pass.** Every input the argument consumes, whether or not L41 states it.

| # | input | stated in L41? | used? |
| --- | --- | --- | --- |
| H1 | $W\in\mathcal W_n$, first Bianchi and Ricci-flatness, via (B) | yes | **yes, essentially.** (B) is the only Weyl-specific input |
| H2 | $n\ge4$, the smallest $n$ with $\mathcal W_n\ne0$ | **no**, no dimension range appears | yes, tacitly |
| H3 | $\{v_\gamma\}$ an **orthonormal** eigenbasis of $W$ on $\Lambda^2\mathbb R^n$ under the half-trace pairing | "eigenbasis", orthonormality unsaid | yes, $T_{\gamma\alpha\beta}$ and the Prop 1.7 expansion both need it |
| H4 | [Lemma L153](../findings/bounds.md), the Killing row marginal $2(n-2)$ | **no, cited nowhere** | yes, for the mass identity only |
| H5 | [Petersen–Wink 1908.09958](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7, $g_\gamma=\sum(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ | **no, cited nowhere** | yes, for both identities |
| H6 | the cubic identity $\sum\lambda\lambda\lambda T=2\langle W,W^\#\rangle$ | folded into "the definition of $\#$" | yes |
| H7 | the trace pairing $\langle X,Y\rangle=\operatorname{tr}(XY)$ on $\mathrm{End}(\Lambda^2)$, in which $\lVert[\mathrm{ad}(v),W]\rVert$ is measured | **no**, conventions.md tables the pairing on $\Lambda^2$, not on operators over it | yes; §9 confirms this is the self-consistent choice |
| H8 | $\operatorname{tr}W=0$ and $W\ne0$, hence $\lambda_{\min}<0$ | **no** | yes, needed to read $\lambda_{\min}=-\lvert\lambda_{\min}\rvert$ |
| H9 | **$\lVert W\rVert=1$** | **no** | **yes, every display is false without it** |
| H10 | criticality, $Q(W)=\theta W$ | **yes**, in the canonical entry's opening clause | **no. Used at no step.** |

Two entries are the round's substance. **H9 is the missing hypothesis; H10 is the stated-and-unused one.** The record already knows both, at the neighbouring lemma: [L107](../findings/bounds.md)'s block says in terms "the bound holds at every $W\in\mathcal W_n$, not only at critical points … *So the record files as a critical-point bound something that holds everywhere*", and writes both moments with their norm factors, $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$. L41 states the same two moments without them.

## 2. The scale question, the round's first, answered for each identity

Under $W\mapsto tW$ with $t>0$: $\lambda_\gamma\mapsto t\lambda_\gamma$; $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2\mapsto t^2g_\gamma$, the eigenbasis being unchanged; $\Delta$ and $G_0$ are sums of $g$ and so also scale by $t^2$; $\lVert W\rVert\mapsto t\lVert W\rVert$; and $\theta=P/\lVert W\rVert^3$ is invariant.

**Are the stated forms true at any scale?** Each is true at $\lVert W\rVert=1$ and at no other, and each fails by a different power.

| display | left degree | right degree | corrected, homogeneous form |
| --- | --- | --- | --- |
| $\sum_\gamma g_\gamma=4(n-1)$ | $2$ | $0$ | $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ |
| $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta(W)$ | $3$ | $0$ | $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$, i.e. $-4\theta(W)\lVert W\rVert^3$ |
| $\theta\le\lvert\lambda_{\min}\rvert\frac{4(n-1)-\Delta-G_0}4$ | $0$ | mixed, $1+\{0,2\}$ | $\theta\le\lvert\lambda_{\min}\rvert\dfrac{4(n-1)\lVert W\rVert^2-\Delta-G_0}{4\lVert W\rVert^3}$ |

**The bound is the worst of the three, and it is worse than a missing normalisation.** Its bracket is *not homogeneous within itself*: the constant $4(n-1)$ is degree $0$ while $\Delta$ and $G_0$ are degree $2$, so the bracket is not merely mis-scaled, it changes sign. A closed-form witness is in §5.

**Is this the same correction section D makes at the neighbouring lemma?** The hypothesis is the same one ("**with $\lVert W\rVert=1$**), the identity holds at one scale only, its two sides being homogeneous of different degrees". The *severity* differs and L41's is greater. L70's mismatch is degree $1$ against degree $0$, so scaling by $t$ misses by a factor $t$, the block's own illustration, "Scaling a balanced $n=6$ product by $2$ reads $\sqrt{10}/3$ against $2\sqrt{10}/3$". L41's two identities miss by $t^2$ and $t^3$, and its bound crosses zero. **So the same clause repairs it, and the repair is more urgent here, not less.**

## 3. The identity, and the two lines the record has never written

The record asserts "in two lines from $A(W)=2W$ and the definition of $\#$" in four places, [results.md:190](../results.md#L190), [results.md:605](../results.md#L605), [target.md:329](../findings/target.md#L329), [target.md:704](../findings/target.md#L704), and [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118) repeats it as "proved in two lines". **No file performs the derivation.** Here it is; it closes.

**Line 0, the expansion (H5).** For $A=\mathrm{ad}(v_\gamma)$, the matrix entry of $[A,W]$ between eigenvectors is $\langle[A,W]v_\beta,v_\alpha\rangle=\lambda_\beta c_{\gamma\beta\alpha}-\lambda_\alpha c_{\gamma\beta\alpha}=(\lambda_\beta-\lambda_\alpha)c_{\gamma\beta\alpha}$, so summing squared entries in the orthonormal basis gives Prop 1.7,
$$g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}.$$

**Line 1, symmetrisation.** Weighting by $\lambda_\gamma$ and using the total symmetry of $T$ to average the three placements of the distinguished index,
$$\sum_\gamma\lambda_\gamma g_\gamma=\sum_{\alpha\beta\gamma}\lambda_\gamma(\lambda_\alpha-\lambda_\beta)^2T_{\alpha\beta\gamma}=\tfrac13\sum_{\alpha\beta\gamma}\Lambda_{\alpha\beta\gamma}T_{\alpha\beta\gamma},\qquad \Lambda_{\alpha\beta\gamma}=\sum_{\mathrm{cyc}}\lambda_\alpha(\lambda_\beta-\lambda_\gamma)^2,$$
and expanding the square gives the record's own algebraic identity $\Lambda_{\alpha\beta\gamma}=\sum_{i\ne j}\lambda_i\lambda_j^2-6\lambda_\alpha\lambda_\beta\lambda_\gamma$, the indices running over $\{\alpha,\beta,\gamma\}$.

**Line 2, the two inputs.** The six ordered pairs $(i,j)$ contribute equally under the symmetry of $T$, and $R_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}$ is symmetric, so
$$\sum_{\alpha\beta\gamma}\Big(\sum_{i\ne j}\lambda_i\lambda_j^2\Big)T_{\alpha\beta\gamma}=6\sum_{\alpha\beta}\lambda_\alpha^2\lambda_\beta R_{\alpha\beta}\overset{\text{(B)}}{=}6\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)=-12\operatorname{tr}(W^3),$$
while the cubic (H6) gives $-6\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=-12\langle W,W^\#\rangle$. Adding and dividing by $3$,
$$\boxed{\ \sum_\gamma\lambda_\gamma g_\gamma=-4\big(\langle W,W^2\rangle+\langle W,W^\#\rangle\big)=-4\langle W,Q(W)\rangle=-4P(W).\ }$$

**Three readings that follow at once.** The right-hand side is $P$, not $\theta$, confirming §2. Criticality appears nowhere, (B), (H5) and (H6) are the whole input, so the identity holds on all of $\mathcal W_n$, and **L41's canonical entry over-hypothesises by opening "Let $W\in\mathcal W_n$ be a critical point"**. And "the definition of $\#$" is doing more work than the phrase admits: it stands for (H6), an identity the record numbers and proves elsewhere.

**A remark for the plan, not a verdict.** Padding a Weyl tensor multiplies neither side: for $W$ supported on $\Lambda^2\mathbb R^k\subset\Lambda^2\mathbb R^n$, $\mathrm{ad}(v_\gamma)$ preserves the three blocks and $g_\gamma$ is $n$-independent at every $\gamma$ with $\lambda_\gamma\ne0$ (§5), so the boxed identity forces $P$ and hence $\theta$ to be padding-invariant, *provided* the padded tensor lies in $\mathcal W_n$, which is precisely conventions.md's owed L30 clause. **This is offered as a lead, not as a proof of that clause**, whose open half is the membership, not the value.

## 4. The universal claim $\sum_\gamma g_\gamma=4(n-1)$

**Derived, and criticality is genuinely unused.** From Prop 1.7 and the symmetry of $R$,
$$\sum_\gamma g_\gamma=\sum_{\alpha\beta}\big(\lambda_\alpha^2+\lambda_\beta^2-2\lambda_\alpha\lambda_\beta\big)R_{\alpha\beta}\overset{\text{(A)}}{=}2\cdot 2(n-2)\lVert W\rVert^2-2\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}\overset{\text{(B)}}{=}4(n-2)\lVert W\rVert^2+4\lVert W\rVert^2,$$
so $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$. Only (A) and (B) enter; **relation (C), criticality, is never touched, so "critical or not" is right in substance and wrong only in its normalisation.**

**The brief asks whether this universal claim is a claim with no witness. It is not, but the record makes it look like one.** The argument exists, at [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118), in exactly the form above: "the Killing form … makes every row marginal $\rho_\alpha=2(n-2)$, **[Lemma L153](../findings/bounds.md)** … and $A(W)=2W$ gives $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}=-2\lVert W\rVert^2$; expanding, $2\cdot2(n-2)+4=4(n-1)$." **L41's block cites it from nowhere**, and the block states the claim bare at the wrong scale. That is a citation defect, not a gap.

**And there is a live hypothesis attached to the neighbouring derivation that L41 inherits by silence.** The same passage carries a Casimir route to the same constant, and "**Two hypotheses Gate 2 added.** (i) **$n\ge5$.** 'A generator-independent invariant contraction must be a scalar' needs the adjoint of $\mathfrak{so}(n)$ irreducible, which fails at $n=4$". **That $n\ge5$ belongs to the Casimir route alone.** The (A)+(B) derivation above uses no irreducibility and is valid at $n=4$, which is consistent with the same passage's report that at $n=4$ "the total stays pinned at $12$" $=4(n-1)$. **So the claim survives at the smallest admissible $n$**, but L41 states no dimension range at all and points at a file where the visible hypothesis is $n\ge5$, H2 in the inventory.

## 5. The bound, and the padded-kernel trap

**Derived.** Split the index set by the sign of $\lambda_\gamma$ and write $G_-=\sum_{\lambda_\gamma<0}g_\gamma$. Since $g\ge0$,
$$\sum_\gamma\lambda_\gamma g_\gamma=\underbrace{\sum_{\lambda_\gamma>0}\lambda_\gamma g_\gamma}_{\ge0}+0+\sum_{\lambda_\gamma<0}\lambda_\gamma g_\gamma\ \ge\ \lambda_{\min}G_-=-\lvert\lambda_{\min}\rvert G_-,$$
using $\lambda_\gamma\ge\lambda_{\min}$ termwise on the negative part and $\lambda_{\min}<0$ (H8). With §3 and §4 this is
$$\theta\lVert W\rVert^3=-\tfrac14\sum_\gamma\lambda_\gamma g_\gamma\le\tfrac14\lvert\lambda_{\min}\rvert G_-=\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)\lVert W\rVert^2-\Delta-G_0}4,$$
which is the stated bound at $\lVert W\rVert=1$ and the corrected one otherwise.

**$\Delta$ and $G_0$ on the record.** $G_0$ is defined in the block itself. $\Delta$ is **not defined in the block at all**, and the canonical entry restates it in words rather than quoting, against conventions.md's own governing rule that "definitions and conventions are quoted, never restated". The definition does exist: [curvature-invariants.md:106](../findings/curvature-invariants.md#L106), "$\Delta(W):=\sum_{\delta\in\mathfrak p}g_\delta$". Three further readings of the letter are live and a consumer must not cross them, [L68](../findings/diagonal-half.md)'s is "summed over unordered positive pairs", a **factor $2$** away from the ordered sum L41's $4(n-1)$ budget requires; [sym3-blocks.md:251](../findings/sym3-blocks.md#L251) uses $\Delta$ for an apolarity invariant, $\Delta=\sum_aq_a^2$; and conventions.md tables only the symmetry-defect sense.

**The split is exhaustive.** $W$ is symmetric, so $\{\gamma:\lambda_\gamma=0\}$ is exactly an orthonormal basis of $\ker W$, and $\Delta+G_0+G_-=\sum_\gamma g_\gamma$. Consequently $4(n-1)\lVert W\rVert^2-\Delta-G_0=G_-\ge0$ and the corrected bound's right side is never negative.

### The scale failure, exhibited

The stated bound's bracket mixes degrees, so it is not merely mis-normalised, it goes negative. Take $W$ = padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$, scaled by $2$. From §6 the unscaled point has $\Delta=0$, $G_0=32$, $\lvert\lambda_{\min}\rvert=1/\sqrt6$; scaling doubles $\lambda$ and quadruples $g$, so $\lvert\lambda_{\min}\rvert=2/\sqrt6$ and $G_0=128$, while $4(n-1)=44$ is untouched. The stated bound reads
$$\theta\ \le\ \frac2{\sqrt6}\cdot\frac{44-0-128}4=-\frac{42}{\sqrt6}=-17.146\ldots,$$
against $\theta=\sqrt{3/2}$, which is scale-invariant. **The stated inequality is false by $18.4$ at $t=2$**, and the corrected form is exact there.

### What the bound gives at a padded critical point, and whether $G_0$ is computable there

**It gives an equality, and it gives it in terms of a quantity as hard as the answer.** At a padded point the bound is tight (§6), so it reduces to $\theta=\lvert\lambda_{\min}\rvert G_-/4$, which is the identity of §3 rearranged, carrying no information the identity did not. To use it as a *bound* one must know $G_0$, and $G_0$ is a sum of $\lVert[\mathrm{ad}(v),W]\rVert^2$ over an orthonormal basis of $\ker W$: it is bracket data $T_{\gamma\alpha\beta}$ at kernel indices, not spectral data. **So $G_0$ is computable in principle and never from the spectrum**, and it is exactly the term that carries all the sharpness: at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$, dropping $G_0$ collapses the bound to [L107](../findings/bounds.md)'s $\theta\le(n-1)\lvert\lambda_{\min}\rvert=11/\sqrt6=4.490$ against the true $1.2247$, slack by $3.27$.

**This is the same shape as trap [W4](../findings/INDEX-traps.md)**, "the gradedness screen is vacuous when $\ker W\ne0$ … padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$", and here the kernel does not merely make the statement vacuous: it makes the *equality clause false*, which is §6.

## 6. The equality case, REFUTED in the "only if" direction

**Both directions, from the derivation.** Equality in §5 needs both dropped terms to vanish:

- $\sum_{\lambda_\gamma>0}\lambda_\gamma g_\gamma=0$, i.e. $\Delta=0$;
- $\sum_{\lambda_\gamma<0}(\lambda_\gamma-\lambda_{\min})g_\gamma=0$, i.e. $g_\gamma=0$ at every $\gamma$ with $\lambda_{\min}<\lambda_\gamma<0$.

Neither condition constrains $\gamma\in\ker W$, a kernel index contributes $0$ to $\sum\lambda_\gamma g_\gamma$ and is *subtracted out of the budget* by the $-G_0$ term. Hence

$$\textbf{equality}\iff\operatorname{supp}(g)\subseteq E_{\lambda_{\min}}\oplus\ker W,$$

**not** $\operatorname{supp}(g)\subseteq E_{\lambda_{\min}}$. The "if" direction of the record's clause is sound; the "only if" is false.

### Discrepancy protocol

**(1) Located exactly.** Four sites carry the false clause: [results.md:190](../results.md#L190), [results.md:605](../results.md#L605), [target.md:335](../findings/target.md#L335) ("Equality holds exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace, *every eigenvector above the bottom is an infinitesimal symmetry*"), and [target.md:708](../findings/target.md#L708).

**(2) Exhibited concretely, in closed form.** Take $W$ = the Weyl tensor of $\mathbb{CP}^2$ padded into $\mathcal W_{12}$, a point the record treats as a critical point throughout and which [target.md:335](../findings/target.md#L335) itself names among the equality witnesses.

- **Spectrum.** $W_{\mathbb{CP}^2}$ is self-dual with $\Lambda^2$-spectrum proportional to $(2,-1,-1)$ on $\Lambda^2_+$ and $0$ on $\Lambda^2_-$; the normalisation $\sum\lambda^2=1$ gives the multiset $\tfrac1{\sqrt6}(2,-1,-1,0,0,0)$, so $\lambda_{\min}=-1/\sqrt6$, $\dim E_{\max}=1$, $\dim E_{\min}=2$, $\dim\ker W=3$ already at $n=4$, and $63$ of $66$ at $n=12$, matching trap [W4](../findings/INDEX-traps.md) exactly.
- **$\Delta=0$.** $E_{\max}$ is spanned by the Kähler form $J\in\mathfrak{su}(2)_+$. $\mathrm{ad}(J)$ annihilates $\Lambda^2_-=\mathfrak{su}(2)_-$ and preserves each of $\mathbb R J$ and $J^\perp\cap\Lambda^2_+$, on each of which $W$ is scalar, so $[\mathrm{ad}(J),W]=0$ and $g_J=0$. Padding does not disturb this: $\mathrm{ad}(J)$ preserves $\Lambda^2\mathbb R^4$, the mixed block and $\Lambda^2\mathbb R^{8}$, and $W$ vanishes on the last two.
- **$G_0>0$ under padding, by a general lemma.** *Let $W\ne0$ be supported on $\Lambda^2\mathbb R^k\subset\Lambda^2\mathbb R^n$ with $k<n$. Then some $v\in\ker W$ has $g_v>0$.* Take $v=e_i\wedge e_p$ with $i\le k<p$; it lies in $\ker W$. For $x\in\Lambda^2\mathbb R^k$, $\mathrm{ad}(v)x$ lands in the mixed block, which $W$ kills, so $[\mathrm{ad}(v),W]x=\mathrm{ad}(v)Wx$. If this vanished for **every** $i\le k$ then $\operatorname{im}W\subseteq\bigcap_{i\le k}\Lambda^2(e_i^\perp\cap\mathbb R^k)=0$, i.e. $W=0$. Hence $g_v>0$ for some kernel $v$. ∎
- **The arithmetic, exact.** At $n=4$ the same two computations give $\Delta=0$ and $G_0=0$ ($\mathrm{ad}(\Lambda^2_-)$ annihilates $\Lambda^2_+$ and preserves $\Lambda^2_-$, where $W=0$) so $G_-=4(4-1)=12$, carried two units of index at $g=6$ each. Padding leaves $g_\gamma$ unchanged at every $\gamma$ with $\lambda_\gamma\ne0$ (the same block argument), so at $n=12$: $\Delta=0$, $G_-=12$, and $G_0=4\cdot11-12=\mathbf{32}$.
- **Screen** (exact closed-form arithmetic, reported as a screen). The identity: $\sum\lambda_\gamma g_\gamma=\lambda_{\min}G_-=-12/\sqrt6=-2\sqrt6$, against $-4\theta=-4\sqrt{3/2}=-2\sqrt6$. **Equal.** The bound: $\lvert\lambda_{\min}\rvert(44-0-32)/4=\frac1{\sqrt6}\cdot3=\sqrt{3/2}=\theta$. **Equality, exactly.**

So equality holds while $g$ places $32$ of its $44$ units on $\ker W$ and only $12$ on $E_{\lambda_{\min}}$. **The clause is refuted.**

**(3) The opposite argued.** *Could "the $\lambda_{\min}$ eigenspace" be meant to absorb the kernel?* No: $\lambda_{\min}=-1/\sqrt6\ne0$, and the block defines $G_0$ over $\ker W$ as a separate bucket in the same display. *Could the witness fail because padded $W_{\mathbb{CP}^2}$ is not critical?* The clause still falls: [L107](../findings/bounds.md)'s block establishes that this whole $g$-route "holds at every $W\in\mathcal W_n$, not only at critical points", §3 and §4 confirm criticality is unused, and the padded tensor's membership in $\mathcal W_n$ is all the derivation asks, while [target.md:335](../findings/target.md#L335) independently lists padded $\mathbb{CP}^2$ as an equality point. *Could the record mean the clause only where $\ker W=0$?* Nothing says so, and the block's own $-G_0$ term exists precisely to handle $\ker W\ne0$. The candidate clears all three tests.

**Why the error is there, localised.** [L107](../findings/bounds.md)'s block states "the equality case is $\operatorname{supp}(g)\subseteq E_{\min}$", and **for L107's bound that is correct**, because $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ drops $\Delta$ and $G_0$ rather than subtracting them, so equality does force both to vanish. **L41's clause is L107's clause copied onto the strictly sharper bound, where it no longer holds.** The two bounds coincide exactly on $\{\Delta=G_0=0\}$, which is where every equality witness the record checked *except* the padded one lives.

## 7. The identification with Lemma L70, REFUTED

The canon claims the equality case "is the same statement as [Lemma L70](../findings/bounds.md)'s, in the coordinates of $g$ rather than of $D$; the record cites them as one piece of evidence."

**L70's condition, quoted.** "equality holds exactly when $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$, every one of its $2(n-2)$ units of bracket mass landing on a pair with one index at $\lambda_{\min}$ and the other at $\lambda_{\max}$, for every unit $v\in E_{\min}$."

**They are different conditions, and neither implies the other.**

- **L70 $\not\Rightarrow$ L41.** L70 constrains only the rows $v\in E_{\min}$. It says nothing about $T_{\gamma\alpha\beta}$ with all three indices outside $E_{\min}$, so nothing forces $g_\gamma=0$ at $\gamma\in E_{\max}$.
- **L41 $\not\Rightarrow$ L70.** Mass $T_{v\alpha\beta}$ with $v,\alpha,\beta$ all in $E_{\min}$ contributes $(\lambda_\alpha-\lambda_\beta)^2=0$ to every $g$, so L41's condition is blind to the $\mathfrak m\times\mathfrak m$ bracket mass, which is precisely the obstruction L70's own block identifies as the whole content of its equality case: "**The only surviving obstruction is the $\mathfrak m\times\mathfrak m$ mass, so saturation $\iff[\mathfrak m,\mathfrak m]\perp\mathfrak m\iff(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair.**"

**Discrepancy protocol.**

**(1) Located.** [results.md:605](../results.md#L605), sentence three.

**(2) Exhibited.** The separating object is the **maximal torus $\mathfrak{so}(2)^{n/2}$** at $n=6,8,10,12$, and equally $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$.

*L41's equality holds there, by three lines of algebra.* On [Lemma L23](../findings/bounds.md)'s family $W=\Pi_{\mathfrak h}-\tfrac rNI$ the spectrum is two-valued, $\lambda_{\max}=1-r/N$ on $\mathfrak h$ and $\lambda_{\min}=-r/N$ on $\mathfrak m$, with no kernel. Prop 1.7 then gives $g_\gamma=\sum(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ with a nonzero weight only on mixed pairs, so for $\gamma\in\mathfrak h$, $g_\gamma=(\lambda_{\max}-\lambda_{\min})^2\sum_{\alpha\in\mathfrak h,\beta\in\mathfrak m}T_{\gamma\alpha\beta}$, and that sum is $\lVert\Pi_{\mathfrak m}[v_\gamma,v_\alpha]\rVert^2$ summed over $\mathfrak h$, **zero, because $\mathfrak h$ is a subalgebra and $\mathfrak m=\mathfrak h^\perp$.** So $\Delta=0$, $G_0=0$, and equality holds **on the whole family, automatically.** This also proves claim 7 of the table: "The bound saturates on the whole subalgebra family of Lemma L23, so it separates nothing there" is **CONFIRMED**, and it is confirmed by an argument, not by a census.

*L70's equality fails there.* Its block's own table records slack $1.291$, $2.160$, $2.846$, $3.425$ at the tori $n=6,8,10,12$ and $0.836660$ at $\mathrm{ad}(\mathfrak{su}(3))$, against $0.000000$ at the balanced splits, and concludes "**The tori and $\mathrm{ad}(\mathfrak{su}(3))$ are genuine critical points and are strictly slack**". The Lie-theoretic reason is in the same block: a maximal torus is abelian, so $[\mathfrak m,\mathfrak m]\not\perp\mathfrak m$ in general and $(\mathfrak{so}(n),\mathfrak t)$ is not a symmetric pair.

**Two conditions with different zero sets on one family are not one statement.**

**(3) The opposite argued.** *Could "same statement in the coordinates of $g$" mean something looser, both being alignment conditions?* Then the operative sentence, "the record cites them as one piece of evidence", would be unjustified: that sentence exists to prevent double-counting, and it is only sound if the two really coincide. *Could the two agree on the subclass that matters?* They agree on $\{\Delta=G_0=0,\ \text{no intermediate negative mass},\ [\mathfrak m,\mathfrak m]\perp\mathfrak m\}$ (the balanced sphere products) and part everywhere else. *Is the contradiction internal to L41's own entry?* **Yes, and this is the sharpest form of the finding.** L41's last sentence says the bound "saturates on the whole subalgebra family … so it separates nothing there"; L70's block says its equality *does* separate that family, the balanced products from the tori. **The entry asserts, two sentences apart, both that its equality case separates nothing on the L23 family and that it is the same statement as one that separates it.** Cleared on all three tests.

**What this costs downstream.** L41's equality case is strictly weaker than L70's, and on the L23 family it is *automatic*. Any argument that reaches for "the $\lambda$-weighted bound saturates here" as evidence of the rigidity L70 supplies is reaching for nothing. [Post F40](../findings/fence-posts.md)'s correction (i), quoted in L70's block, already made exactly this point about the $\lambda$-weighted bound ("it saturates on the *whole* subalgebra family, six of eight saturations being ungraded") so **the record has the refutation of its own identification claim on file, one file away, and states the claim anyway.**

## 8. The remaining named traps, each answered

- **$\ker W\ne0$ and padded objects.** Answered in §5 and §6; this is where the round's principal defect sits. The $-G_0$ term is mass *on* the kernel, so the trap is structural rather than incidental: it makes the equality clause false, and it is what leaves the bound tight-but-uninformative at every padded point.
- **The boundary of every stated range, and the smallest admissible $n$.** L41 states **no range at all**, H2. The results hold at every $n\ge4$; the only visible in-file derivation of $4(n-1)$ carries a Gate-2 $n\ge5$ hypothesis belonging to the Casimir route alone (§4), so a reader following the block's own pointer would take $n\ge5$ and lose $n=4$, the one dimension where $W_{\mathbb{CP}^2}$ is unpadded. **Nothing here breaks at the boundary; the record's account of the boundary does.**
- **Odd $n$.** Nothing in L41 is parity-sensitive. $\Theta_n$'s odd/even split and $\theta_0(n)$ never enter; the bound is stated against $\lvert\lambda_{\min}\rvert$, not against a target constant. **Nothing found.**
- **The crossover $n=6+2\sqrt7$.** [Post F7](../findings/fence-posts.md) requires every candidate inequality to see it. L41's bound is not a candidate inequality in that sense, it produces no $n$-uniform ceiling, because "**Its weakness is that $\lvert\lambda_{\min}\rvert$ is uncontrolled**", the record's own words. So F7 does not bite, and the reason it does not bite is the reason the bound cannot close the conjecture. **Nothing found beyond what the record already says.**
- **A claim proven on a subfamily and used in general.** The identity's only support on the record is numerical, "verified to 12 digits at $n=5,6,7,8,10$", "Verified at 13 points". The *general* claim is nonetheless true, by §3. **The defect is that the record has been running a $12$-digit check where a three-line proof was available; no over-generalisation error results.**
- **A hypothesis stated but never used.** **Criticality**, H10, §3, §4. The canonical entry hypothesises it and no step consumes it. The record knows: L107's block says "the record files as a critical-point bound something that holds everywhere".
- **A step using a hypothesis never stated.** Four: $\lVert W\rVert=1$ (H9, §2), $\lambda_{\min}<0$ from $\operatorname{tr}W=0$ (H8), orthonormality of the eigenbasis (H3), and the operator pairing on $\mathrm{End}(\Lambda^2)$ (H7).
- **A universal claim with no witness.** The brief names $4(n-1)$ as exactly one. **It has an argument on file**, [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118), which L41 cites from nowhere; §4 rebuilds it. The claim that genuinely has **no argument anywhere on the record** is the $\lambda$-weighted identity, asserted as "two lines" in four places and derived in none. §3 supplies them; that is a report of what closes, not a repair of the record.
- **An imported theorem whose hypotheses were never checked.** [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 is load-bearing and **uncited in L41**. Checked here: it is a basis computation on a symmetric operator, needing only H3, with no algebra structure and hence no unital hypothesis of the kind that killed the earlier route. The record's other Petersen–Wink import is already hypothesis-checked in the right way, [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118) notes that Prop 1.3's sign conclusion "needs $R$ **2-nonnegative**, which a Weyl tensor is not, since $\operatorname{tr}W=0$ forces $\lambda_{\min}<0$", and takes only the contraction. **Nothing broken; one uncited dependency.**
- **Symbol collisions.** $\Delta$: three live objects and a factor-2 reading (§5), the brief's warning is correct, and the block's bare use is the worst case. $g$: safe, tabled at conventions.md under $g_k$ with this exact meaning. $A$: **$A(W)=2W$ is the per-row relation (B)**, and conventions.md tables an unrelated $A=\lambda_1$ in the two-negative relaxation, plus [isotropy-cap.md:295](../findings/isotropy-cap.md#L295)'s operator $\mathcal A$ whose sign was corrected once; L41 writes $A$ bare with no pointer. $\lambda$: safe here, $\lambda_{\min}$ is unambiguous, and none of the three senses of $\lambda_{\max}$ conventions.md flags is in play. $v_\gamma$: eigenvectors of $W$ in $\Lambda^2$, unambiguous in this block. $G_0$: defined in place, but the *neighbouring* $G_2$ is tabled as colliding with the exceptional group, no collision for $G_0$ itself. **The one that would change a number is $\Delta$.**

## 9. Candidates raised and withdrawn

Reported as withdrawn, with the reason, per the protocol.

| candidate | why withdrawn |
| --- | --- |
| "the positive/negative/kernel split is not exhaustive, so $4(n-1)-\Delta-G_0$ need not be $\ge0$" | It is exhaustive ($W$ symmetric makes $\{\lambda_\gamma=0\}$ a basis of $\ker W$) and the residue is exactly $G_-\ge0$. **Fails test (2): no failure can be exhibited.** |
| "the constant $4$ is wrong under conventions.md's half-trace norm $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$" | That pairing is on $\Lambda^2$; $[\mathrm{ad}(v),W]$ is an operator over it, and the trace pairing on $\mathrm{End}(\Lambda^2)$ is forced by $\lVert W\rVert^2=\operatorname{tr}(W^2)=\sum\lambda^2$ and $P=\langle W,Q(W)\rangle$. Screened at padded $W_{\mathbb{CP}^2}$ (§6): both sides give $-2\sqrt6$. The $4$'s are right. **The convention is nonetheless unnamed, logged as H7, not as a defect.** |
| "the two identities are inconsistent, since halving $g$ would halve both constants" | Both halve together and the ratio in the bound is invariant. Self-consistent. **Fails test (2).** |
| "criticality is needed after all, through relation (C)" | (C) enters neither derivation; L107's block states the same conclusion independently. **Fails test (2), and the opposite is provable.** |

## 10. What would falsify the statement, and what was done to look for it

**The object that would break the identity** is a $W\in\mathcal W_n$ with $\sum_\gamma\lambda_\gamma g_\gamma\ne-4P(W)$. It would force one of three inputs to fail: (B) $A(W)=2W$, Prop 1.7, or the cubic $\sum\lambda\lambda\lambda T=2\langle W,W^\#\rangle$. **Looked for it by rebuilding each input from conventions.md and following its own source**, (B) to [bounds.md:268](../findings/bounds.md#L268) and its Bianchi-plus-Ricci-flat scope, Prop 1.7 to a two-line basis computation reproduced in §3, the cubic to [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118), which records that it holds off $\mathrm{Weyl}_n$ entirely. **None found**, and the derivation of §3 shows none exists.

**The object that would break the bound**, given the identity, is a $W$ with some $g_\gamma<0$; $g_\gamma$ is a squared norm, so none exists. **The bound as *stated* is broken by any $W$ with $\lVert W\rVert\ne1$**, and one is exhibited in §5 at $t=2$.

**The object that would break the equality clause** is a $W$ attaining equality with $G_0>0$. **Found**, in closed form: padded $W_{\mathbb{CP}^2}\in\mathcal W_{12}$, $\Delta=0$, $G_0=32$, $G_-=12$, both sides $\sqrt{3/2}$ exactly (§6). **How it was looked for:** by reading the derivation's two dropped terms and asking which index classes each constrains, then testing the record's own catalogue of equality witnesses against the one class neither constrains, the kernel. The search was directed by trap [W4](../findings/INDEX-traps.md), which names padded $W_{\mathbb{CP}^2}$ as the record's standing large-kernel object.

**The object that would break the identification with L70** is a point where one equality holds and the other fails. **Found**, in both directions of failure: the maximal tori and $\mathrm{ad}(\mathfrak{su}(3))$, where L41 saturates by the subalgebra argument of §7 and L70 is slack by $0.84$ to $3.43$ on L70's own table. **How it was looked for:** by comparing which entries of $T_{\alpha\beta\gamma}$ each condition constrains, which isolates the $\mathfrak m\times\mathfrak m$ block as visible to L70 and invisible to L41, and then by looking for a family on which that block is the only difference, L23's, which L41's own last sentence names.

## Verdict

# BROKEN

**Two clauses of the canonical statement are false as written and a third is false outright.**

- **False as written, repairable by one hypothesis:** the identity, the mass and the bound all require $\lVert W\rVert=1$, unstated at all four sites, and the bound's bracket is not internally homogeneous, so it fails by more than a factor, it changes sign.
- **False as a conclusion:** the equality case. The correct clause is $\operatorname{supp}(g)\subseteq E_{\lambda_{\min}}\oplus\ker W$, and the record's own listed equality witness refutes the stated one.
- **False as a conclusion:** the identification with [L70](../findings/bounds.md). L41's condition is strictly weaker and is automatic on the L23 family; the entry contradicts itself two sentences apart.

**What survives, and it is most of the mathematics.** Both moment identities are true in their homogeneous forms, the record already carries them correctly at [conventions.md](../findings/conventions.md) and in [L107](../findings/bounds.md)'s block. The bound is true at unit norm. The two lines close, and §3 writes them for the first time on this record. Criticality is genuinely unused, so L41 proves more than it claims. Claim 7, that the bound saturates on the whole L23 family, is confirmed with a proof.

### The repaired statement

> Let $W\in\mathcal W_n$, $n\ge4$, $W\ne0$, with an orthonormal eigenbasis $\{v_\gamma\}$ of $\Lambda^2\mathbb R^n$, $Wv_\gamma=\lambda_\gamma v_\gamma$, and $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ in the trace pairing on $\mathrm{End}(\Lambda^2)$. Then $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$, **neither needing criticality**, both from [Lemma L153](../findings/bounds.md), the per-row identity $A(W)=2W$, the cubic $\sum\lambda\lambda\lambda T=2\langle W,W^\#\rangle$ and [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7. Writing $\Delta$ for the symmetry defect of [curvature-invariants.md](../findings/curvature-invariants.md), summed over **ordered** indices, and $G_0=\sum_{\gamma\in\ker W}g_\gamma$, at $\lVert W\rVert=1$
> $$\theta\ \le\ \lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}{4},$$
> **with equality exactly when $\operatorname{supp}(g)\subseteq E_{\lambda_{\min}}\oplus\ker W$.** The bound saturates on the whole subalgebra family of [Lemma L23](../findings/bounds.md), automatically, since $\mathfrak h$ is a subalgebra; **it is therefore strictly weaker than [Lemma L70](../findings/bounds.md)'s equality case, which separates that family, and the two must not be cited as one piece of evidence.**
