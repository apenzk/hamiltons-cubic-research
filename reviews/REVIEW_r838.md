# Review r838: Lemma L197: the sharp form on the kernel at a critical point

**Verdict: CONFIRMED, and the result is nine days older than the block says.** Every derivation in [Lemma L197](../findings/target.md) is sound: $\ker W\subseteq\ker W^\#$ at every critical point, the diagonal identity, the bracket form, the one-sign reading and the balance all hold, and I fixed the block's unnamed constant at $1$. Five corrections. The boxed identity and the per-kernel-index equation are the $\lambda_k=0$ instance of [bounds.md](../findings/bounds.md)'s relation (C) and of its "$W^\#=\theta W-W^2$, so $W^\#$ is a polynomial in $W$", both on record since 2026-09-01 (commit `bf2dd5a4`) and both strictly stronger, and L197 cites neither. Wilking's proof of the sign is variational rather than by a square root, and needs $R\ge0$ only on $\operatorname{im}\mathrm{ad}_v$, which reopens the step the block declares unavailable. The block then takes a strict weakening of its own relation three times over, and against its closing pessimism I derive a conditional rank bound of exactly the shape [I68](../plan.md) wants.

*Reviewer r838, 2026-09-10. The brief was cold. **No screening and no computation of any kind was run**: every check below is closed form by hand, including the padded $W_{\mathbb{CP}^2}$ verification in §11. Log at [agent_logs/g2-kernel-r838.log](../agent_logs/g2-kernel-r838.log).*

## Claim table

| # | Claim under review | Verdict |
|---|---|---|
| 1 | $A=S\,\mathrm{ad}_vS$ skew, $\operatorname{tr}((\mathrm{ad}_vR)^2)=\operatorname{tr}(A^2)$, and that sign is the only step needing $R\succeq0$ | **ALGEBRA CONFIRMED, ATTRIBUTION AND SCOPE CORRECTED** |
| 2 | $\ker W\subseteq\ker W^\#$ from $W^2+W^\#=\theta W$ as operators | **CONFIRMED, AND NOT NEW** |
| 3 | $\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha\beta}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta$, obtained by matching term by term | **CONCLUSION CONFIRMED, STATED JUSTIFICATION INVALID** |
| 4 | $W^\#=\mathrm{const}\cdot\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\,c_{\alpha\beta}\otimes c_{\alpha\beta}$ | **CONFIRMED, CONSTANT $=+1$** |
| 5 | One sign gives PSD, kernel $=\operatorname{span}\{c_{\alpha\beta}\}^\perp$, image a subalgebra, and that is Hamilton's conclusion | **CONFIRMED, INDEX RANGE CORRECTED** |
| 6 | The balance, and its $\mathfrak{pp}+\mathfrak{mm}$ against $\mathfrak{pm}$ reading | **CONFIRMED** |
| 7 | $\binom n2-r$ conditions, low rank heavily constrained, the opposite direction from a rank bound | **DIRECTION CONFIRMED, COUNT OFF BY ONE DEPENDENCY, SCOPE A STRICT WEAKENING** |
| 8 | A rank bound needs a reason the balance fails at high rank, and nothing here supplies one | **PESSIMISM REFUTED: a conditional rank bound falls out in six lines (§8)** |
| 9 | Hypotheses used | **NO USE of $n\ge12$, $S=0$, non-diagonality or maximality. Bianchi and Ricci-flatness enter twice, both times unstated** |
| 10 | Falsifiers | **ONE LIVE: the $Q$-invariance of $\mathcal W_n$, which the block never names and on which the boxed identity rests** |

**One line to act on.** Keep the mathematics, cut the novelty claim: rewrite L197 as a corollary of [bounds.md](../findings/bounds.md)'s relation (C) at $\lambda_k=0$, and replace the closing pessimism with §8's conditional bound, which turns [I68c](../plan.md) from "no direction" into "prove $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$".

## Conventions

All of this is on $\mathfrak g=\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, which is $\mathrm{ad}$-invariant, so $c(x,y,z)=\langle[x,y],z\rangle$ is totally antisymmetric and $\mathrm{ad}_x^{\mathsf T}=-\mathrm{ad}_x$.

$W$ is a symmetric operator on $\mathfrak g$ with orthonormal eigenbasis $v_1,\dots,v_N$, $N=\binom n2$, eigenvalues $\lambda_\alpha$, and $c_{\alpha\beta}=[v_\alpha,v_\beta]$, $T_{\alpha\beta\gamma}=\langle c_{\alpha\beta},v_\gamma\rangle^2$. The inner product on operators is $\langle A,B\rangle=\operatorname{tr}(AB)$ for symmetric $A,B$, which is what makes $\langle W,W^\#\rangle=\sum_\gamma\lambda_\gamma\langle W^\#v_\gamma,v_\gamma\rangle$.

$\mathfrak p=\operatorname{ran}W_+$, $\mathfrak m=\operatorname{ran}W_-$, $\mathfrak k=\ker W$, $r=\operatorname{rank}W$, so $\dim\mathfrak k=N-r$. Sharp is Wilking's: $\langle R^\#x,y\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}_xR\,\mathrm{ad}_yR)$.

## Hypothesis inventory

| Hypothesis | Where it is used | Stated in the block? |
|---|---|---|
| $Q(\mathcal W_n)\subseteq\mathcal W_n$ | makes criticality the unprojected operator identity $W^2+W^\#=\theta W$, on which the whole boxed result rests | no |
| $\langle A,B\#C\rangle$ totally symmetric | makes $\nabla\langle W,Q(W)\rangle=3Q(W)$, hence criticality in that form | no |
| Criticality $W^2+W^\#=\theta W$ | §2, §3, §6, §7 | yes |
| $W$ symmetric | $\operatorname{ran}W=(\ker W)^\perp$ in §5, eigenbasis everywhere | implicitly |
| $\operatorname{tr}W=0$ | indefiniteness, hence the balance rather than the one-sign reading | yes |
| First Bianchi and Ricci-flatness | relation (B), used in §7's dependency count | no |
| $R\succeq0$ | only inside Hamilton's and Wilking's argument, nowhere in the block's own derivation | yes |
| $n\ge12$, $S=0$, non-diagonality, maximality | nowhere | not claimed |

## 1. The named step: the algebra is right, the attribution is not, and the correction is a live opening

**The algebra.** $\mathrm{ad}_v^{\mathsf T}=-\mathrm{ad}_v$ by invariance of $\langle\cdot,\cdot\rangle$, and $S^{\mathsf T}=S$, so
$$A^{\mathsf T}=(S\,\mathrm{ad}_v\,S)^{\mathsf T}=S^{\mathsf T}\mathrm{ad}_v^{\mathsf T}S^{\mathsf T}=-S\,\mathrm{ad}_v\,S=-A,$$
so $A$ is skew. **Confirmed.** With $R=S^2$, cyclicity of the trace moves one factor $S$ from the front to the back:
$$\operatorname{tr}\big((\mathrm{ad}_vR)^2\big)=\operatorname{tr}(\mathrm{ad}_vS^2\,\mathrm{ad}_vS^2)=\operatorname{tr}(S\,\mathrm{ad}_vS^2\,\mathrm{ad}_vS)=\operatorname{tr}(A^2)=-\operatorname{tr}(A^{\mathsf T}A)=-\lVert A\rVert^2 .$$
**Confirmed**, and hence $2R^\#(v,v)=-\operatorname{tr}((\mathrm{ad}_vR)^2)=\lVert A\rVert^2\ge0$. Note this holds at every $v$, with no use of $v\in\ker R$: under $R\succeq0$ the sharp form is PSD outright, which §4's bracket form makes obvious.

**Correction 1: this is not Wilking's proof, and Wilking's needs much less.** [paper.txt](https://arxiv.org/abs/1011.3561) lines 212 to 231 prove the sign from the cone condition alone. Differentiating $h\le R(\mathrm{Ad}_{\exp(tx)}v,\mathrm{Ad}_{\exp(t\bar x)}\bar v)$ twice at $t=0$ and replacing $x$ by $ix$ gives his (1),
$$0\le R(\mathrm{ad}_vx,\mathrm{ad}_{\bar v}\bar x)\quad\text{for all }x,$$
that is, **$R$ is nonnegative on $\operatorname{im}\mathrm{ad}_v$ only**. He then applies the lemma that the trace pairing of two nonnegative hermitian operators is nonnegative, to $-\mathrm{ad}_vR\,\mathrm{ad}_{\bar v}\succeq0$ and $R$ restricted to its image. Global semidefiniteness of $R$ appears nowhere in that proof. So "Wilking's proof of it is one line" attributes to him an argument he does not use, and the block's square-root proof, while correct, proves only the special case $C(S,0)$ where the cone is $\{R\succeq0\}$.

**Why the correction is worth more than the citation.** The block closes its norm-balance box with *"a Weyl tensor is never semidefinite, so that step is unavailable"*. Under Wilking's actual hypothesis the step needs $W\succeq0$ on the single subspace $[v,\mathfrak{so}(n)]$, which a trace-free operator can perfectly well satisfy. §8 turns that into a route.

**Correction 2: "IT IS THE ONLY ONE" is true of the sign and false of the strong maximum principle.** Hamilton 1986 is not in [references/](../references/) and the publisher blocks automated retrieval (the PDF URL returns HTTP 200 carrying a 1166-byte Incapsula challenge page), so I read the surrounding structure from [Beitz](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) §4.2, which carries Hamilton's Theorem 4.3 in full. Two further uses of $R\succeq0$ are structural there. The invariant set $C$ must be fibrewise convex and preserved by the ODE before the principle applies at all, which for $C=\{R\succeq0\}$ is the same sign statement but is a hypothesis of the theorem rather than a step of it. And the passage from the flow to the equality case uses that $x\mapsto R_x(v,v)$ has an interior minimum at the point, which is a consequence of $R\succeq0$ holding in a neighbourhood, not at the point. Read as a claim about the sign, the block's sentence is correct. Read as its headline says, it is not.

## 2. $\ker W\subseteq\ker W^\#$, and the record had it in a stronger form nine days earlier

**The derivation, in full.** Criticality is $Q(W)=W^2+W^\#=\theta W$ as an identity of symmetric operators on $\Lambda^2\mathbb R^n$, with $W^2$ the operator square. At $v\in\ker W$,
$$W^\#v=\theta\,Wv-W(Wv)=0-0=0 .$$
**Confirmed**, and the reading of $W^2$ is the operator square: it has to be, because $Q$ is the right-hand side of the Hamilton ODE $R'=R^2+R^\#$, and the Euler-Lagrange equation of $\langle W,Q(W)\rangle$ on the unit sphere of $\mathcal W_n$ is an equation between operators. Neither $\theta\cdot\mathrm{id}$ nor a quadratic-form reading survives the check at padded $W_{\mathbb{CP}^2}$ in §11, where the operator reading returns $\theta=\sqrt{3/2}$ on the nose.

**What the containment uses.** Only the operator equation. No first Bianchi, no trace-freeness, no dimension, no maximality: the same three lines hold for any symmetric $W$ on any inner-product space and any pair of operators with $W^2+X=\theta W$. [KernelSharp.lean](../lean/HamiltonsCubic/Results/KernelSharp.lean) types exactly that and is honest about what it leaves out.

**Correction 3, and it is the one that should change the block.** Two hypotheses are consumed upstream and named nowhere. First, criticality takes this form because $Q$ maps $\mathcal W_n$ to itself: if it did not, the Euler-Lagrange equation would read $P_{\mathcal W}(W^2+W^\#)=\theta W$ and the argument would give $P_{\mathcal W}(W^\#)v=0$, which is not the boxed statement. Second, $\nabla\langle W,Q(W)\rangle=3Q(W)$ needs the trilinear form $\langle A,B\#C\rangle$ to be totally symmetric. Both are on the record, and both are Weyl-space facts rather than free ones. **The block's "with no cone, no flow and no positivity" is right, and "no hypotheses" would not be.**

**And the result is not new.** [bounds.md](../findings/bounds.md) has carried, since commit `bf2dd5a4` of 2026-09-01:

> At a critical point $Q(W)=\theta W$ means $W^\#=\theta W-W^2$: **$W^\#$ is a polynomial in $W$** [...] So $W$ and $W^\#$ share eigenspaces, $W^\#$ acts on $E_a$ by the scalar $\theta\lambda_a-\lambda_a^2$.

At $a$ the zero eigenvalue that scalar is $\theta\cdot0-0=0$, which is the boxed identity. The record's statement is strictly stronger: it fixes $W^\#$ on **every** eigenspace and makes $W^\#$ commute with $W$, of which the kernel case is one line. So the block's *"the operator form is strictly stronger and costs nothing"* compares its new form against its own weaker first reading, while the record already held a form stronger than both. L197 cites neither [bounds.md](../findings/bounds.md) nor the relation, and [plan.md](../plan.md) records I68b as "Done, and stronger than asked" on that basis.

## 3. The diagonal entries: right answer, invalid inference

**The conclusion is correct**, and here is a derivation that does not go through matching. With $R=\sum_\alpha\lambda_\alpha v_\alpha\langle v_\alpha,\cdot\rangle$,
$$\mathrm{ad}_xR\,\mathrm{ad}_yR=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,[x,v_\alpha]\,\big\langle v_\alpha,[y,v_\beta]\big\rangle\big\langle v_\beta,\cdot\big\rangle,$$
so $\operatorname{tr}(\mathrm{ad}_xR\,\mathrm{ad}_yR)=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c(y,v_\beta,v_\alpha)\,c(x,v_\alpha,v_\beta)=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c(x,v_\alpha,v_\beta)c(y,v_\alpha,v_\beta)$ by antisymmetry in the last two slots. Hence
$$\langle W^\#x,y\rangle=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,\langle x,c_{\alpha\beta}\rangle\langle y,c_{\alpha\beta}\rangle,$$
using $c(x,v_\alpha,v_\beta)=\langle x,[v_\alpha,v_\beta]\rangle$ from cyclicity. Setting $x=y=v_\gamma$ gives $\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha\beta}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta$ exactly. It agrees with [bounds.md](../findings/bounds.md)'s relation (C), $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, which is this identity with $\langle W^\#v_k,v_k\rangle=\theta\lambda_k-\lambda_k^2$ substituted from criticality.

**Correction 4: the stated route to it is not valid.** Reading diagonal entries off a scalar identity is the claim that $\sum_\gamma\lambda_\gamma g_\gamma(\lambda)=\sum_\gamma\lambda_\gamma h_\gamma(\lambda)$ forces $g_\gamma=h_\gamma$, and it does not. Concretely, at $N\ge3$ take
$$e_1=\lambda_2\lambda_3,\qquad e_2=-\lambda_1\lambda_3,\qquad e_\gamma=0\ (\gamma\ge3),$$
a nonzero family of quadratics with $\sum_\gamma\lambda_\gamma e_\gamma\equiv0$. So $g_\gamma$ and $g_\gamma+e_\gamma$ produce the same scalar, and the matching determines the diagonal only up to that Koszul kernel.

**The charitable reading, which the words support.** If one adds that $\langle W^\#v_\gamma,v_\gamma\rangle$ is a quadratic form whose coefficient array is the restriction of a **totally symmetric** array, then matching the symmetrised monomial $\lambda_\alpha\lambda_\beta\lambda_\gamma$ is legitimate, because total symmetry pins the split of each monomial across the three slots. That extra premise is true and is exactly what $T=c'^2$ supplies. The block does not state it, and without it the step is a guess that happens to be right. **The claim stands, the sentence supporting it does not.**

## 4. The bracket form, with the constant fixed

From §3, for all $x,y$,
$$\boxed{\,W^\#=\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\,c_{\alpha\beta}\otimes c_{\alpha\beta}\,}$$
because the summand of $\tfrac12\sum_{\alpha\beta}$ is invariant under $\alpha\leftrightarrow\beta$ (the two sign changes of $c_{\beta\alpha}=-c_{\alpha\beta}$ cancel) and vanishes at $\alpha=\beta$. **The block's unnamed constant is $+1$**, with the plus sign, and leaving it unnamed is what let the box below it be stated with an unquantified "const" that no later step could have used.

Three checks, all closed form.

- **Against the pair cap.** $\operatorname{tr}W^\#=\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\lVert c_{\alpha\beta}\rVert^2$ with $\lVert c_{\alpha\beta}\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}\le2$, the cap [stratum-two-negative.md](../findings/stratum-two-negative.md) carries.
- **Against the cubic.** $\langle W,W^\#\rangle=\sum_\gamma\lambda_\gamma\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, the record's expansion, and since $T$ is hollow this is $3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$, matching [Lemma L49](../findings/target.md)'s coefficient $3=3!/2$.
- **Against the identity.** All $\lambda_\alpha=1$ gives $\langle\mathrm{Id}^\#x,x\rangle=\tfrac12\sum_\alpha\lVert[x,v_\alpha]\rVert^2=-\tfrac12\operatorname{tr}(\mathrm{ad}_x^2)=-\tfrac12B(x,x)=(n-2)\lVert x\rVert^2$, since $B(X,X)=(n-2)\operatorname{tr}(X^2)=-2(n-2)\langle X,X\rangle$ on $\mathfrak{so}(n)$. So $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, which is the record's normalisation and Böhm-Wilking's relation (A).

The form is also already in the record: [Lemma L155](../findings/bounds.md)'s proof works with exactly these bracket Gram sums with positive weights.

## 5. The one-sign reading

Each link, checked separately, with $\Sigma_{\ne0}=\{(\alpha,\beta):\alpha<\beta,\ \lambda_\alpha\lambda_\beta\ne0\}$.

1. **PSD.** If $\lambda_\alpha\lambda_\beta>0$ on $\Sigma_{\ne0}$ then $W^\#$ is a positive combination of rank-one projections, hence PSD. **Correct.**
2. **Its kernel.** For a sum of PSD rank-ones, $\langle W^\#x,x\rangle=\sum w_{\alpha\beta}\langle x,c_{\alpha\beta}\rangle^2$ vanishes iff $x\perp c_{\alpha\beta}$ for every pair of positive weight, so $\ker W^\#=\operatorname{span}\{c_{\alpha\beta}:(\alpha,\beta)\in\Sigma_{\ne0}\}^\perp$. **Correct, with the index range restricted.**
3. **Correction 5.** The block writes $\operatorname{span}\{c_{\alpha\beta}\}$ and $\operatorname{span}\{[v_\alpha,v_\beta]\}$ with no restriction. Read over all $\alpha,\beta$ that span is $[\mathfrak{so}(n),\mathfrak{so}(n)]=\mathfrak{so}(n)$ for $n\ge3$, and the conclusion would say $\mathfrak{so}(n)\subseteq\operatorname{ran}W$, that is, $W$ invertible, which is false at the block's own witness. Pairs meeting the kernel carry weight zero and drop out, so the intended range is $\Sigma_{\ne0}$, whose span is $[\operatorname{ran}W,\operatorname{ran}W]$.
4. **The containment's consequence.** $\ker W\subseteq\ker W^\#=[\operatorname{ran}W,\operatorname{ran}W]^\perp$ gives $[\operatorname{ran}W,\operatorname{ran}W]\subseteq(\ker W)^\perp=\operatorname{ran}W$, using symmetry of $W$. **Correct: the image is a subalgebra.**
5. **Is it Hamilton's conclusion?** Yes, and the two standard forms agree. Hamilton's equality case is stated as kernel invariance, $[\ker R,\operatorname{im}R]\subseteq\ker R$, which is what $A=S\,\mathrm{ad}_vS=0$ gives. Invariance of the inner product converts one into the other: for $x\in\ker R$ and $y,z\in\operatorname{im}R$, $\langle x,[y,z]\rangle=\langle[x,y],z\rangle$, so $[\ker R,\operatorname{im}R]\subseteq\ker R$ iff $[\operatorname{im}R,\operatorname{im}R]\perp\ker R$ iff $\operatorname{im}R$ is a subalgebra. The block's version is neither weaker nor stronger. **Confirmed.**

## 6. The balance

With $T\ge0$ and the containment's equation $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=0$ at $\lambda_\gamma=0$, splitting the sum by the sign of $\lambda_\alpha\lambda_\beta$ and moving the negative part across gives
$$\sum_{\lambda_\alpha\lambda_\beta>0}\lvert\lambda_\alpha\lambda_\beta\rvert T_{\alpha\beta\gamma}=\sum_{\lambda_\alpha\lambda_\beta<0}\lvert\lambda_\alpha\lambda_\beta\rvert T_{\alpha\beta\gamma}.$$
**Confirmed**, and trace-freeness with $W\ne0$ does force both signs to occur, so the one-sign case is empty on $\mathcal W_n$ and the balance is what remains.

**The $\mathfrak p,\mathfrak m$ translation is the right correspondence.** A pair has $\lambda_\alpha\lambda_\beta>0$ exactly when both indices are positive or both negative, which is $\mathfrak{pp}$ or $\mathfrak{mm}$, and $\lambda_\alpha\lambda_\beta<0$ exactly when the signs differ, which is $\mathfrak{pm}$. Pairs meeting $\mathfrak k$ carry weight zero. So the equation is $\lVert$weighted $\mathfrak{pp}$ and $\mathfrak{mm}$ brackets along $v_\gamma\rVert$ against the $\mathfrak{pm}$ ones, tested against every kernel direction. **Confirmed**, and the conclusion is basis-free inside each eigenspace, since any orthonormal eigenbasis may be chosen and the resulting statement is about the subspaces.

**One qualification on the [L155](../findings/bounds.md) citation.** L155's graded conditions are $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$, which constrain the $\mathfrak m$-components and the $\mathfrak k$-components of those brackets. The balance constrains the $\mathfrak k$-components alone, and only in aggregate. The two conditions overlap in that half and are transverse elsewhere, so "the same split and the graded conditions L155 is stated in" is accurate about the vocabulary and would be wrong if read as identifying the conditions. A graded critical point satisfies the balance with both sides zero, which is a consistency check rather than a coincidence.

## 7. The count: the direction survives, the number does not, and the scope is a third weakening

**The direction is right.** One scalar equation per kernel index, $\dim\mathfrak k=N-r$ of them, decreasing in $r$ and vacuous at $r=N$. So the containment alone can never exclude high rank, which is what [I68](../plan.md) wants excluded, and the block is right to say so before a cycle is spent on it. The comparison with [post F63](../findings/fence-posts.md) is loose (there the ceiling on $\operatorname{tr}W^3$ rises with $r$, which is a different mechanism) and fair as a shape.

**Correction 6: the equations are not independent, and exactly one dependency is provable.** Summing the kernel equations and using $\langle W^\#v_\gamma,v_\gamma\rangle=0$ on $\mathfrak k$,
$$\sum_{\gamma\in\mathfrak k}\langle W^\#v_\gamma,v_\gamma\rangle=\operatorname{tr}W^\#-\sum_{\gamma\notin\mathfrak k}\langle W^\#v_\gamma,v_\gamma\rangle=\operatorname{tr}W^\#-\sum_{\gamma\notin\mathfrak k}(\theta\lambda_\gamma-\lambda_\gamma^2)=\operatorname{tr}W^\#+\lVert W\rVert^2,$$
using $\operatorname{tr}W=0$ and $\lVert W\rVert=1$. The Böhm-Wilking trace $\operatorname{tr}W^\#=-\lVert W\rVert^2$ makes the right side vanish identically, so **the sum of the $N-r$ kernel equations is implied by the $r$ non-kernel criticality relations**. That trace is itself relation (B) contracted with $\lambda$: total symmetry turns $\sum_k\lambda_k\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lVert W\rVert^2$ into $2\operatorname{tr}W^\#=-2\lVert W\rVert^2$. So at most $N-r-1$ of them are new, and (B) is where first Bianchi and Ricci-flatness enter the count. The pair cap and total symmetry collapse nothing further: (A) contracts $T$ with a different weight and each kernel equation involves a coordinate slice $T_{\cdot\cdot\gamma}$ that no other kernel equation touches.

**Correction 7, and it is the block's own warning turned on itself: the containment is a strict weakening, used three times.**

1. From $W^\#=\theta W-W^2$ (record, 2026-09-01) to $\ker W\subseteq\ker W^\#$, dropping every non-kernel eigenspace.
2. From the operator containment to "one equation per kernel index", which is the diagonal. Here the weakening is harmless, and for a reason the block does not give: criticality makes $W^\#$ a polynomial in $W$, so $W^\#$ is diagonal in $W$'s eigenframe and the off-diagonal entries vanish automatically. Without that observation the reduction to the diagonal is unjustified, because an indefinite symmetric operator does not have its rows killed by its diagonal.
3. From the containment to the count, when the object the route needs to constrain is the full criticality system in the eigenframe: $N$ diagonal relations (C) at every index and $\binom N2$ off-diagonal vanishings $\sum_{\mu<\nu}\lambda_\mu\lambda_\nu\langle c_{\mu\nu},v_\alpha\rangle\langle c_{\mu\nu},v_\beta\rangle=0$. That system does not shrink as $r$ grows.

So "the count runs the wrong way" is a true statement about the weakest corollary of criticality, presented as a statement about what criticality gives. **The block's defence stands**: padded $W_{\mathbb{CP}^2}$ satisfies all $N-3$ kernel equations, verified in closed form in §11, so nothing here bounds $r$ from the kernel side alone.

## 8. Against the pessimism: a conditional rank bound, in six lines

The block's closing box asks for a reason the balance fails at high rank and says nothing here supplies one. Here is what the balance supplies in full, rather than what the block takes from it.

**Lemma (r838).** *At a critical point, every $v\in\ker W$ with $v\perp[\mathfrak p,\mathfrak m]$ satisfies $v\perp[\mathfrak p,\mathfrak p]$ and $v\perp[\mathfrak m,\mathfrak m]$.*

*Proof.* Choose an orthonormal eigenbasis with $v$ among the kernel vectors. The mixed side of §6's balance is $\sum_{\lambda_\alpha\lambda_\beta<0}\lvert\lambda_\alpha\lambda_\beta\rvert\langle[v_\alpha,v_\beta],v\rangle^2$, and every bracket occurring in it lies in $[\mathfrak p,\mathfrak m]$, so the hypothesis makes it zero. The same-sign side is then zero, is a sum of nonnegative terms with strictly positive weights $\lvert\lambda_\alpha\lambda_\beta\rvert>0$, and so vanishes termwise. Bilinearity carries $\langle[v_\alpha,v_\beta],v\rangle=0$ from the basis pairs to $[\mathfrak p,\mathfrak p]$ and $[\mathfrak m,\mathfrak m]$. $\square$

**Corollary.** *At a critical point, if $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$ then $\operatorname{ran}W$ is a Lie subalgebra of $\mathfrak{so}(n)$.* Every kernel vector is then orthogonal to $[\mathfrak p,\mathfrak m]$, so by the lemma it is orthogonal to $[\mathfrak p,\mathfrak p]+[\mathfrak m,\mathfrak m]$ as well, whence $[\operatorname{ran}W,\operatorname{ran}W]\perp\ker W$.

**And a subalgebra is a rank bound.** $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ is the compact real form, so every subalgebra is compact and reductive, and the maximal proper ones are $\mathfrak{so}(k)\oplus\mathfrak{so}(n-k)$, $\mathfrak u(n/2)$ and the irreducible ones. The largest is $\mathfrak{so}(n-1)$, of dimension $\binom{n-1}2=\binom n2-(n-1)$. So under the hypothesis,
$$\operatorname{rank}W\le\binom n2-(n-1)\qquad\text{or}\qquad\operatorname{rank}W=\binom n2 ,$$
which at $n=12$ reads $r\le55$ or $r=66$. That is a bound of exactly the shape [I68](../plan.md) asks for, it comes from the balance rather than from an extra input, and it converts [I68c](../plan.md) from "which subspaces can be $\ker W$" into the single named question **is $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$ at a critical point**. The full-rank alternative is not a defect of the route: at $r=\binom n2$ the kernel is trivial, and the record's other machinery applies.

**A second route, from §1's correction.** Wilking needs $R\ge0$ only on $\operatorname{im}\mathrm{ad}_v$. Fix $v\in\ker W$ and put $P=-\mathrm{ad}_vW\mathrm{ad}_v$, which is symmetric because $\mathrm{ad}_v$ is skew. Then $P\succeq0$ iff $W\succeq0$ on $[v,\mathfrak{so}(n)]$, and $\operatorname{im}P\subseteq[v,\mathfrak{so}(n)]$, so that single hypothesis supplies both of Wilking's. Criticality gives $\operatorname{tr}(PW)=-\operatorname{tr}((\mathrm{ad}_vW)^2)=2\langle W^\#v,v\rangle=0$, and $\operatorname{tr}(PW)=\operatorname{tr}(P^{1/2}WP^{1/2})$ with $P^{1/2}WP^{1/2}\succeq0$, so $P^{1/2}WP^{1/2}=0$ and $\operatorname{im}(\mathrm{ad}_vW\,\mathrm{ad}_v)\subseteq\ker W$. That is Hamilton's kernel invariance localised to one kernel direction, on a hypothesis about one subspace. Its cost is visible and worth recording: $W\succeq0$ on $[v,\mathfrak{so}(n)]$ needs $\dim[v,\mathfrak{so}(n)]=\binom n2-\dim\mathfrak z(v)$ to be at most the number of nonnegative eigenvalues, so it is plausible at a decomposable kernel bivector, where $\dim[v,\mathfrak{so}(n)]=2n-4$, and increasingly hard as the negative count grows. **That is a reason the mechanism bites differently at different ranks**, which is the thing the block says nothing supplies.

## 9. Scope

No step uses $n\ge12$, $S=0$, non-diagonality, or that $W$ is a maximiser rather than a critical point. Criticality is used at full strength and nothing beyond it in §2. First Bianchi and Ricci-flatness enter twice and are named nowhere in the block: through the $Q$-invariance of $\mathcal W_n$, which is what makes criticality an unprojected operator identity, and through relation (B), which powers §7's dependency. Trace-freeness is used only to rule out the one-sign case. The Lie-algebraic definition of $\#$ is used for §1 and §4, and the containment itself is independent of it.

## 10. Falsifiers, and what I did

- **$Q$ does not map $\mathcal W_n$ to itself.** This is the one hypothesis whose failure would take the boxed identity with it, since criticality would then be $P_{\mathcal W}(W^2+W^\#)=\theta W$ and only $P_{\mathcal W}(W^\#)v=0$ would follow. I checked the record treats it as established, and checked its first consequence by hand: $\operatorname{tr}Q(W)=\operatorname{tr}W^2+\operatorname{tr}W^\#=\lVert W\rVert^2-\lVert W\rVert^2=0$, so the scalar part of $Q(W)$ does vanish. **The block should name it.**
- **A critical point with $v\in\ker W$ and $W^\#v\ne0$.** Refuted by §2, given criticality as an operator identity. Not a live falsifier.
- **A collapse of the kernel equations to far fewer than $N-r$.** I looked for dependencies from total symmetry, the pair cap, the Killing marginal (A) and the per-row identity (B), and found exactly one, in §7. More would strengthen the block's own pessimism rather than refute it.
- **A critical point violating the balance.** Impossible: the balance is a rearrangement of an identity.
- **The one-sign reading being weaker than Hamilton's.** Checked both directions of the equivalence between kernel invariance and the image being a subalgebra in §5.5, so it is neither weaker nor stronger.

**What I did to look.** Rebuilt the sharp form from Wilking's definition (§3, §4), read his actual proof of the sign in [paper.txt](https://arxiv.org/abs/1011.3561), read Hamilton's maximum principle from [Beitz](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) after the publisher's bot wall blocked the original, cross-checked every constant against relations (A), (B), (C) in [bounds.md](../findings/bounds.md), against $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, and against the record's $\langle W,W^\#\rangle$ at padded $W_{\mathbb{CP}^2}$, and ran the closed-form verification in §11. **No numerical work of any kind.**

## 11. The known critical point, done by hand, which confirms four things at once

Padded $W_{\mathbb{CP}^2}$ has $\operatorname{ran}W$ the three-dimensional $\Lambda^2_+\cong\mathfrak{su}(2)$ inside $\mathfrak{so}(4)\subseteq\mathfrak{so}(n)$, spectrum $(2,-1,-1)/\sqrt6$. On a bracket-closed triple, $[v_\alpha,v_\beta]=\varepsilon_{\alpha\beta\gamma}\,c\,v_\gamma$ for one constant $c$, so §4's form gives
$$W^\#=c^2\big(\lambda_2\lambda_3\,v_1\otimes v_1+\lambda_1\lambda_3\,v_2\otimes v_2+\lambda_1\lambda_2\,v_3\otimes v_3\big),$$
**supported on $\operatorname{ran}W$**, so it kills the kernel outright at every $n$, the padding directions included, because $[\Lambda^2_+,\Lambda^2_+]\subseteq\Lambda^2_+$. Criticality at the two distinct indices reads
$$\tfrac46+\tfrac{c^2}6=\tfrac{2\theta}{\sqrt6},\qquad \tfrac16-\tfrac{2c^2}6=-\tfrac\theta{\sqrt6},$$
whose solution is $c^2=2$ and $\theta=3/\sqrt6=\sqrt{3/2}$. Four independent confirmations follow with no further input: the constant $+1$ in §4 and the operator reading of $W^2$ (both would break $\theta$), the pair cap saturated at $\lVert[v_\alpha,v_\beta]\rVert^2=c^2=2$ exactly as [stratum-two-negative.md](../findings/stratum-two-negative.md) reports for orthonormal pairs in $\Lambda^2_+$, the record's value $\langle W,W^\#\rangle=\sum_\gamma\lambda_\gamma\langle W^\#v_\gamma,v_\gamma\rangle=2/\sqrt6$ against $\operatorname{tr}W^3=1/\sqrt6$ summing to $\sqrt{3/2}$, and $\operatorname{tr}W^\#=\tfrac{c^2}6-\tfrac{4c^2}6=-1=-\lVert W\rVert^2$.

## Verdict

**CONFIRMED, with five corrections and one addition.** The mathematics of [Lemma L197](../findings/target.md) is sound throughout, and I found no false claim in it. What is wrong is around the mathematics: the result is the $\lambda_k=0$ case of a relation the record has carried in stronger form since 2026-09-01 and cites nowhere, the proof of the sign is attributed to Wilking who proves it differently and from a weaker hypothesis, the diagonal identity is reached by an inference that does not hold without an unstated premise, the bracket span is written over an index range that would make the conclusion false, and the count is presented as a verdict on criticality when it is a verdict on criticality's weakest corollary. The block's own pessimism is answerable: the balance gives a subalgebra under one bracket hypothesis, and a subalgebra of the compact $\mathfrak{so}(n)$ is a rank bound.
