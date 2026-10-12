# VERIFY_v229, Lemma L41, a $\lambda$-weighted identity and the bound it gives

**Verifier v229, cold on [BRIEF_L41.md](BRIEF_L41.md).** The brief was read before any other file and nothing outside it, [conventions.md](../findings/conventions.md), [target.md](../findings/target.md), [bounds.md](../findings/bounds.md), [bounds-relaxations.md](../findings/bounds-relaxations.md), [curvature-invariants.md](../findings/curvature-invariants.md), [diagonal-half.md](../findings/diagonal-half.md), [fence-posts.md](../findings/fence-posts.md) and the [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md) was consulted. **No numerical work of any kind was done, no script, no Sage, no evaluation.** Every figure below is closed form. Log: [agent_logs/verify-L41-v229.log](../agent_logs/verify-L41-v229.log).

## Claim table

| # | claim as written | verdict |
| --- | --- | --- |
| 1 | $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta(W)$ | **PROVEN, NORMALISATION CORRECTED.** True at $\lVert W\rVert=1$ only. Scale-covariant form: $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ |
| 2 | *"in two lines from $A(W)=2W$ and the definition of $\#$"* | **PROVEN, INGREDIENT LIST INCOMPLETE.** The two lines close, but they also consume Petersen–Wink Prop 1.7 and the total symmetry of $T$, neither named |
| 3 | $\sum_\gamma g_\gamma=4(n-1)$ on all of $\mathcal W_n$, critical or not | **PROVEN, NORMALISATION CORRECTED.** Correct form $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$. Criticality is genuinely unused |
| 4 | $\theta\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}4$ | **PROVEN, NORMALISATION CORRECTED.** True at $\lVert W\rVert=1$; internally inhomogeneous otherwise. Sign split is exhaustive. Holds at every $W$, not only critical ones |
| 5 | equality *"exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace"* | **BROKEN.** $\Leftarrow$ holds; $\Rightarrow$ is false. Counterexample in closed form: padded $W_{\mathbb{CP}^2}$, where equality holds with $G_0=4(n-4)>0$ |
| 6 | the equality case *"is the same statement as [L70](../findings/bounds.md)'s, in the coordinates of $g$ rather than of $D$"* | **BROKEN.** L41's equality class strictly contains L70's; the maximal torus separates them, and the record's own two blocks already contradict each other on this |
| 7 | *"saturates on the whole subalgebra family of [L23](../findings/ungraded-slack.md)"* | **PROVEN.** One line from $\mathfrak h$ being a subalgebra; derived below |
| 8 | $\Delta$, $G_0$ defined on the record | **HYPOTHESIS-DEBT.** $G_0$ appears nowhere in [conventions.md](../findings/conventions.md); $\Delta$ is tabled there in a normalisation that [diagonal-half.md](../findings/diagonal-half.md) says doubles it |
| 9 | $A(W)$ | **HYPOTHESIS-DEBT.** The one named ingredient of the proof is defined nowhere in [findings/](../findings/); the letter $A$ is tabled in [conventions.md](../findings/conventions.md) as $\lambda_1$ |

**One line:** the two identities and the inequality are all true and all three are stated at the wrong homogeneity (they hold at $\lVert W\rVert=1$ and nowhere else) while the equality clause and the identification with [L70](../findings/bounds.md) are both false, each refuted by an object already on the record.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $Q(W)$: *"Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"*.
- $P(W)$: *"the cubic form $\langle W,Q(W)\rangle$"*.
- $\theta$: *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"*.
- $\#$: *"the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$"*.
- $g_k$: *"$g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, the squared **orbit-tangent** norm in direction $v_k$, manifestly $\ge0$ at every $W$"*, and in the same entry: *"**The first two moments are pinned**, $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$, both from (A) and (B) with the cubic identity and **neither needing criticality**"*.
- $T$, third sense: *"the fully symmetric trilinear form"*; and $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ from the $A,d,G,A_0$ entry.
- $\Delta$: *"the symmetry defect. Discontinuous at eigenvalue zero-crossings, and traced over $\{\lambda>0\}$ only"*.
- Norm: from the $M$ entry, *"$W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$"* at a unit Weyl tensor.

The three per-index relations, quoted verbatim from [bounds.md](../findings/bounds.md) line 268:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad \text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),$$

with the same source recording *"(A)'s proof is L153's; **(B) is the per-row identity $A(W)=2W$**, Weyl-specific since it consumes first Bianchi *and* Ricci-flatness; (C) is criticality"*.

Petersen–Wink Prop 1.7, quoted from the [reference notes](../references/petersen-wink-2019-bochner-technique/notes.md): *"If $\{\Xi_\alpha\}$ is an **orthonormal** basis for $\Lambda^2V$ that diagonalizes $R$… $|LR|^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$"* (emphasis mine, on the word that L41's block drops).

## 1. Hypothesis inventory, what L41 states, what it uses

| ingredient | stated in L41? | used? | note |
| --- | --- | --- | --- |
| $W\in\mathcal W_n$ (first Bianchi + Ricci-flat) | yes | **yes**, twice, relation (B) consumes both | the only genuinely Weyl-specific input |
| $\lVert W\rVert=1$ | **no** | **yes**, three times, in claim 1, claim 3 and the bound | the round's first question; see §2 |
| $W$ critical | yes, in the canonical entry | **no** | stated and never used; the block and the landscape line already say *"on all of $\mathcal W_n$, critical or not"* for claim 3 and then quietly reimpose criticality for claim 1 |
| $\{v_\gamma\}$ **orthonormal** | **no** (the block says only *"eigenbasis"* | **yes**), (A) *"needs only $\lVert v_\alpha\rVert=1$"*, and Prop 1.7 states orthonormality in its own hypothesis | $g_{cv}=c^2g_v$, so claim 3 is false verbatim for a non-orthonormal eigenbasis |
| total symmetry of $T$ | **no** | **yes**, twice, the relabellings in §3 and §4 are where the whole argument turns | tabled at [conventions.md](../findings/conventions.md); [bounds.md](../findings/bounds.md) line 290 says the same, *"which is (B) with $f=\lambda^2$ **after relabelling under total symmetry**"* |
| Petersen–Wink Prop 1.7 | **no** | **yes**, it is the definition of $g_\gamma$ in $T$-coordinates | cited nowhere in either copy of the block |
| relation (A) / [L153](../findings/bounds.md) | **no** | **yes**, in claim 3 | |
| $\lambda_{\min}\le0$ | no | yes, in the bound (to write $\lambda_{\min}=-\lvert\lambda_{\min}\rvert$) | free on $\mathcal W_n$ from $\operatorname{tr}W=0$ at $W\ne0$, as [L70](../findings/bounds.md) records |
| $n\ge5$ | no | **no** on this route | the $n\ge5$ hedge at [bounds-relaxations.md](../findings/bounds-relaxations.md) line 118 attaches to the *Casimir* derivation of $4(n-1)$, which fails at $n=4$ because $\mathfrak{so}(4)$'s adjoint is reducible. The (A)+(B) route below is parity- and dimension-free and runs at $n=4$, which is why the same source can report the $n=4$ total *"stays pinned at $12$"* |

**Two hypotheses stated but unused (criticality, and (in the canonical entry), the eigenbasis being general), two used but unstated (unit norm, orthonormality), and three inputs used but not named (Prop 1.7, relation (A), total symmetry of $T$).**

## 2. The scale question, the round's first, and both stated forms fail it

Under $W\mapsto tW$ ($t>0$): the eigenvalues scale $\lambda_\gamma\mapsto t\lambda_\gamma$; $\mathrm{ad}(v_\gamma)$ is unchanged (the eigenvectors are still unit), so $[\mathrm{ad}(v_\gamma),W]\mapsto t[\mathrm{ad}(v_\gamma),W]$ and $g_\gamma\mapsto t^2g_\gamma$; and $\theta=P(W)/\lVert W\rVert^3$ is degree $0$ while $P$ is degree $3$.

- **Claim 1.** $\sum_\gamma\lambda_\gamma g_\gamma$ is homogeneous of degree $3$; $-4\theta$ of degree $0$. **The stated form is true at $\lVert W\rVert=1$ and at no other scale.** Correct statement: $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)=-4\theta(W)\lVert W\rVert^3$.
- **Claim 3.** $\sum_\gamma g_\gamma$ is degree $2$; $4(n-1)$ is degree $0$. **Same verdict.** Correct statement: $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$.
- **Claim 4, the bound.** Worse than the other two, because it is *internally* inhomogeneous: inside the bracket $4(n-1)$ is degree $0$ while $\Delta$ and $G_0$ are degree $2$. The bracket is not a well-formed expression at any scale but $1$. The scale-covariant statement is $P(W)\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)\lVert W\rVert^2-\Delta-G_0}4$, i.e. $\theta\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)\lVert W\rVert^2-\Delta-G_0}{4\lVert W\rVert^3}$.

**Is this the same correction Section D makes?** Yes for claims 1 and 4 as *stated*, and the record's own remedy at [L70](../findings/bounds.md) is verbatim the right one, *"**And it needs $\lVert W\rVert=1$**: under [conventions.md](../findings/conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ the left side is scale-invariant while the right is homogeneous of degree one, so the identity holds at one scale only."* The one difference is a matter of degree, and it matters for how the fix should be written: L70's two sides differ by one power of $\lVert W\rVert$, so there the unit-norm clause is the whole fix. Here the two identities have honest scale-covariant forms with no normalisation at all ($-4P(W)$ and $4(n-1)\lVert W\rVert^2$) which [conventions.md](../findings/conventions.md) already carries in the $g_k$ entry. **So L41 is the weaker case: it can be repaired either by adding $\lVert W\rVert=1$ or, better, by copying the two identities from the record's own conventions table, where they are already right.** The bound alone genuinely needs the unit-norm clause, its bracket mixing two degrees.

*The canon and the conventions table therefore disagree with each other today.* [conventions.md](../findings/conventions.md) line 50 carries $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$; [results.md](../results.md) lines 190 and 603 carry $4(n-1)$ and $-4\theta$. This is exactly the failure mode the conventions file exists to prevent, and the file that is right is the one nobody cites.

## 3. Claim 1, the two lines, produced

They close. Write $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, totally antisymmetric, so $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is totally symmetric. By Prop 1.7, $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$. Expand the square and use $\alpha\leftrightarrow\beta$ symmetry to merge the first two terms:

$$\sum_k\lambda_kg_k=2\underbrace{\sum_{k\alpha\beta}\lambda_k\lambda_\alpha^2T_{k\alpha\beta}}_{M_{210}}-2\underbrace{\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}}_{M_{111}}.$$

**Line one, $M_{210}$, and this is where $A(W)=2W$ enters.** Relabel under total symmetry so the squared weight sits on the free index, then apply (B) with free index $\alpha$:

$$M_{210}=\sum_\alpha\lambda_\alpha^2\sum_{k\beta}\lambda_kT_{\alpha k\beta}=\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)=-2\operatorname{tr}(W^3).$$

That (B) is the diagonal of $A(W)=2W$ is one further line: [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) state the operator identity $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$ on $\mathrm{Weyl}_n$, and pairing it with $v_k$ on both sides gives $-\sum_{\alpha\beta}\lambda_\alpha T_{k\alpha\beta}=2\lambda_k$, using $\langle\mathrm{ad}(v_\alpha)^2v_k,v_k\rangle=-\lVert[v_\alpha,v_k]\rVert^2$.

**Line two, $M_{111}$, and this is the definition of $\#$.** With $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ and bilinearity of $\#$ against $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$,

$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\big\langle W[v_\alpha,v_\beta],[v_\alpha,v_\beta]\big\rangle=\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=\tfrac12M_{111}.$$

**Closing.** $\sum_k\lambda_kg_k=-4\operatorname{tr}(W^3)-4\langle W,W^\#\rangle=-4\langle W,W^2+W^\#\rangle=-4P(W)$, the last step being the definition of $P$.

**Verdict.** The two lines are real, and the named ingredients are the load-bearing ones. What the block omits from its list is Prop 1.7 (which supplies $g$ in $T$-coordinates at all) and the total symmetry of $T$ (which is the relabelling in $M_{210}$; [bounds.md](../findings/bounds.md) line 290 states plainly that *"without (B) that moment looks free and the record's own identity looks underivable"*). The conclusion is $-4P(W)$, not $-4\theta$.

**Criticality is not used.** Relation (C) never appears. The canonical entry's *"Let $W\in\mathcal W_n$ be a critical point"* and the landscape line's *"at every critical point"* both understate the result; [conventions.md](../findings/conventions.md) and [bounds.md](../findings/bounds.md) line 387 already say so, the latter in bold, *"**relation (C) is not consumed**, so the bound holds at every unit $W\in\mathcal W_n$ and not only at critical points."*

## 4. Claim 3, the universal claim, derived, and criticality genuinely unused

**This was the item flagged as a universal claim with no witness. It has a proof, and the proof is three steps.** Same expansion, weight $1$:

$$\sum_kg_k=2\underbrace{\sum_{k\alpha\beta}\lambda_\alpha^2T_{k\alpha\beta}}_{M_{200}}-2\underbrace{\sum_{k\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}}_{M_{110}}.$$

$M_{200}$: relabel under total symmetry onto the free index and apply (A), $M_{200}=\sum_\alpha\lambda_\alpha^2\sum_{k\beta}T_{\alpha k\beta}=2(n-2)\sum_\alpha\lambda_\alpha^2=2(n-2)\lVert W\rVert^2$.

$M_{110}$: relabel and apply (B), $M_{110}=\sum_\alpha\lambda_\alpha\sum_{k\beta}\lambda_kT_{\alpha k\beta}=\sum_\alpha\lambda_\alpha(-2\lambda_\alpha)=-2\lVert W\rVert^2$.

Hence $\sum_kg_k=\big(4(n-2)+4\big)\lVert W\rVert^2=4(n-1)\lVert W\rVert^2$. This reproduces digit for digit the arithmetic [bounds-relaxations.md](../findings/bounds-relaxations.md) line 118 records, *"expanding, $2\cdot2(n-2)+4=4(n-1)$"*.

**Inputs: (A), (B), Prop 1.7, total symmetry, orthonormality, $W\in\mathcal W_n$. Criticality is genuinely unused, relation (C) does not appear.** So *"on all of $\mathcal W_n$, critical or not"* is correct, once $\lVert W\rVert^2$ is restored. It is not, however, universal on all of $\mathrm{Sym}^2(\Lambda^2)$: (B) consumes first Bianchi and Ricci-flatness, and [bounds-relaxations.md](../findings/bounds-relaxations.md) line 118 records the identity failing *off* $\mathrm{Weyl}_n$. **"Universal" here means universal on $\mathcal W_n$ at unit norm, and the block should say which.**

## 5. Claim 4, the bound, derived, and the split checked for exhaustiveness

Partition the index set by the sign of the eigenvalue: $\mathcal P=\{\lambda_\gamma>0\}$, $\mathcal N=\{\lambda_\gamma<0\}$, $\mathcal Z=\{\lambda_\gamma=0\}$. **The three are disjoint and cover every index**, and $\mathcal Z$ is exactly an orthonormal basis of $\ker W$, so with $\Delta=\sum_{\mathcal P}g_\gamma$ and $G_0=\sum_{\mathcal Z}g_\gamma$,

$$\sum_{\mathcal N}g_\gamma=4(n-1)\lVert W\rVert^2-\Delta-G_0 .$$

**The split is exhaustive.** Then, at $\lVert W\rVert=1$,

$$-4\theta=\sum_\gamma\lambda_\gamma g_\gamma=\underbrace{\sum_{\mathcal P}\lambda_\gamma g_\gamma}_{\ge0}+\underbrace{\sum_{\mathcal N}\lambda_\gamma g_\gamma}_{\ge\,\lambda_{\min}\sum_{\mathcal N}g_\gamma}+0\ \ge\ \lambda_{\min}\big(4(n-1)-\Delta-G_0\big),$$

using $g_\gamma\ge0$ throughout, $\lambda_\gamma>0$ on $\mathcal P$, and $\lambda_\gamma\ge\lambda_{\min}$ termwise on $\mathcal N$. With $\lambda_{\min}=-\lvert\lambda_{\min}\rvert$ this is the stated bound. **It holds. Its only defect is the normalisation of §2.**

Two remarks the block owes and does not carry.

- **The bound is never vacuous and never negative.** Its right side is $\lvert\lambda_{\min}\rvert\sum_{\mathcal N}g_\gamma/4\ge0$, so at $\theta<0$ it says nothing and at $\theta>0$ it is a genuine constraint. This differs from the sharpened form at [bounds-relaxations.md](../findings/bounds-relaxations.md) line 356, which *can* go negative.
- **It is [L107](../findings/bounds.md)'s $\Pi$-bound plus two discards restored.** Setting $\Delta=G_0=0$ returns $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ exactly. So L41 is pointwise at least as sharp as L107, and strictly sharper wherever $\Delta+G_0>0$. That relationship is the key to §6 and §7 and is stated nowhere in the block.

**Are $\Delta$ and $G_0$ defined on the record?**

- $G_0$: **it appears zero times in [conventions.md](../findings/conventions.md).** Its only definitions are the two inline `:=` clauses inside L41's own two copies ([target.md](../findings/target.md) lines 333 and 706), a definition restated twice in one file, against the conventions file's own governing rule that *"definitions and conventions are quoted, never restated"*. It is then used unglossed at [bounds-relaxations.md](../findings/bounds-relaxations.md) lines 59 and 356, [fence-posts.md](../findings/fence-posts.md) line 84 and [target.md](../findings/target.md) line 530.
- $\Delta$: **tabled, but in the wrong normalisation for this bound.** [conventions.md](../findings/conventions.md) line 49 tables it as *"the symmetry defect… traced over $\{\lambda>0\}$ only"* and sources it to [diagonal-half.md](../findings/diagonal-half.md), which in turn opens by saying [conventions.md](../findings/conventions.md) *"sources $\mathcal D_n$ and $\Delta$ back to this file"*, so the sourcing is circular. Worse, [diagonal-half.md](../findings/diagonal-half.md) line 108 records $\Delta$ *"summed over **unordered** positive pairs, against [conventions.md](../findings/conventions.md)'s ordered default, under which $\Delta$ doubles"*. **L41's bound needs the unordered reading**, the one [curvature-invariants.md](../findings/curvature-invariants.md) line 106 carries as $\Delta(W):=\sum_{\delta\in\mathfrak p}g_\delta\in[0,4(n-1)]$, because $\Delta$ has to be subtracted from a sum over an orthonormal basis of $\Lambda^2$ in which each bivector is counted once. **Read with the tabled default the bound is wrong by a factor of two on the $\Delta$ term.** This is the live form of the symbol collision the brief names, and it is the reason the range clause $[0,4(n-1)]$ is itself a silent unit-norm statement.

Both $\Delta$ and $G_0$ are also well defined independently of the basis chosen inside a degenerate eigenspace, since $v\mapsto\lVert[\mathrm{ad}(v),W]\rVert^2$ is a positive semidefinite quadratic form and these are its traces over $W$-invariant subspaces. **The block never says this, and it is what makes the statement meaningful at all when $\lambda_{\min}$ or $0$ is a repeated eigenvalue, which is every point the record cares about.**

## 6. Claim 5, the equality case, both directions, and the padded-kernel trap

**$\Leftarrow$ holds.** If $g$ is supported on $E_{\min}$ then $\Delta=G_0=0$ and $\sum_{E_{\min}}g_\gamma=4(n-1)$, so $-4\theta=\lambda_{\min}\cdot4(n-1)$ and both sides read $(n-1)\lvert\lambda_{\min}\rvert$.

**$\Rightarrow$ fails.** Subtracting the two displays of §5 gives the exact slack

$$\lvert\lambda_{\min}\rvert\big(4(n-1)-\Delta-G_0\big)-4\theta=\sum_{\mathcal P}\lambda_\gamma g_\gamma+\sum_{\mathcal N}(\lambda_\gamma-\lambda_{\min})g_\gamma,$$

a sum of nonnegative terms. **Equality holds exactly when $g_\gamma=0$ for every $\gamma$ with $\lambda_\gamma>0$ and for every $\gamma$ with $\lambda_{\min}<\lambda_\gamma<0$.** The kernel is unconstrained, because $G_0$ has already been subtracted out of the right-hand side. **The correct clause is: equality exactly when $g$ is supported on $E_{\min}\oplus\ker W$.**

### The witness, in closed form: any padded critical point

*This answers the brief's padded-object question directly, including whether $G_0$ can be computed there, it can, exactly, with no computation.*

Let $W_0\in\mathcal W_4$ be a unit critical point and $W=W_0\oplus0\in\mathcal W_n$ its padding, $n\ge5$. Split $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge\mathbb R^{n-4})\oplus\Lambda^2\mathbb R^{n-4}$, of dimensions $6$, $4(n-4)$, $\binom{n-4}2$. Each of the three blocks is $\mathrm{ad}(v)$-invariant for $v$ in the first or third block, and $W$ is supported on the first.

- $\gamma\in\Lambda^2\mathbb R^{n-4}$: $\mathrm{ad}(v_\gamma)$ annihilates $\Lambda^2\mathbb R^4$ and preserves every block, so it commutes with $W$ and $g_\gamma=0$.
- $\gamma\in\Lambda^2\mathbb R^4$: $[\mathrm{ad}(v_\gamma),W]$ vanishes off $\Lambda^2\mathbb R^4$ and equals its $n=4$ value on it, so these $g_\gamma$ are the $n=4$ ones and sum to $4(4-1)=12$ by claim 3 at $n=4$.
- The mixed block therefore carries $4(n-1)-12-0=4(n-4)$, and it lies inside $\ker W$.

$$\boxed{\ G_0=4(n-4)\ \text{ at every padded }W_0\oplus0,\ W_0\in\mathcal W_4\ }$$

**exactly, for every $n\ge4$, independent of which $W_0$ was padded.** So $G_0>0$ at every padded point above $n=4$, and it is the whole of the mass the kernel carries.

Now take $W_0=W_{\mathbb{CP}^2}$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$, trace zero, $\sum\lambda^2=6/6=1$, and $\theta=\sqrt{3/2}$, all on the record at [target.md](../findings/target.md) line 401. Its $\lambda_{\max}$ eigenvector spans the $\mathfrak u(1)$ centre of the $\mathfrak u(2)$ under which $W_{\mathbb{CP}^2}$ is invariant, so $[\mathrm{ad}(v_{\max}),W_0]=0$ and $\Delta=0$, as the record independently records at [diagonal-half.md](../findings/diagonal-half.md) line 159 and [curvature-invariants.md](../findings/curvature-invariants.md) line 112. Then

$$\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}4=\frac1{\sqrt6}\cdot\frac{4(n-1)-0-4(n-4)}4=\frac1{\sqrt6}\cdot\frac{12}4=\frac3{\sqrt6}=\sqrt{\tfrac32}=\theta .$$

**Equality holds, exactly, at every $n\ge4$, and $g$ is not supported on $E_{\min}$, carrying $4(n-4)>0$ units on the kernel.** The $\lambda$-weighted identity checks independently: the $E_{\min}$ mass is $12$, and $-\tfrac{12}{\sqrt6}=-2\sqrt6=-4\sqrt{3/2}=-4\theta$. **Claim 5 is refuted as an "exactly when".**

Two consequences the record should carry.

- **At a padded critical point the bound is $n$-free.** The $4(n-1)$ and the $-4(n-4)$ cancel to $12$, so the bound reads $\theta\le\lvert\lambda_{\min}\rvert(12-\Delta)/4$ at every padding of a $\mathcal W_4$ point, in every dimension. **The bound has no dimensional decay along a padded family, which is precisely why it cannot see the $n=6+2\sqrt7$ crossover**, see §8.
- **The diagnosis is a copied equality case.** [L107](../findings/bounds.md)'s $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ does *not* subtract $G_0$, so there kernel mass genuinely breaks equality and *"$g$ supported on $E_{\min}$"* is the right clause, [fence-posts.md](../findings/fence-posts.md) line 349 states it correctly for that bound. L41 subtracts $G_0$, is strictly sharper, and therefore has a strictly larger equality class. **The record has attached the weaker bound's equality clause to the sharper bound.**

## 7. Claim 6, the identification with L70 is false, and the record already says so

[L70](../findings/bounds.md) reads $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ with $D(v)=\tfrac12\sum_{ab}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2\ge0$, and *"equality holds exactly when $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$… for every unit $v\in E_{\min}$"*.

**The two conditions quantify over different things.** L41's is a statement about which eigenvectors *outside* $E_{\min}$ are infinitesimal symmetries of $W$ ($g_\gamma=0\iff[\mathrm{ad}(v_\gamma),W]=0$). L70's is a statement about where the bracket mass of the vectors *inside* $E_{\min}$ lands. They bound different quantities and are saturated on different sets.

**A closed-form separator: [L23](../findings/ungraded-slack.md)'s subalgebra family.** There $W_{\mathfrak h}=\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra, $r=\dim\mathfrak h$, $N=\binom n2$, so $E_{\max}=\mathfrak h$ and $E_{\min}=\mathfrak m=\mathfrak h^\perp$, with $\ker W=0$.

- **L41 saturates on the whole family, in one line.** For $v\in\mathfrak h$, $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ makes $\mathrm{ad}(v)$ preserve $\mathfrak h$; $\mathrm{ad}(v)$ is skew for the invariant inner product, so it also preserves $\mathfrak m$; hence it commutes with $\Pi_{\mathfrak h}$ and with $W_{\mathfrak h}$, giving $g_v=0$. So $\Delta=0$, $G_0=0$, and all the mass sits on $E_{\min}=\mathfrak m$, **the equality condition, from nothing but $\mathfrak h$ being a subalgebra.** *This proves the canonical entry's clause "the bound saturates on the whole subalgebra family of Lemma L23, so it separates nothing there", which the record carried as a measurement.*
- **L70 does not.** Its own block derives, on the same family, *"saturation $\iff[\mathfrak m,\mathfrak m]\perp\mathfrak m\iff(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair"*, and records the maximal torus $\mathfrak{so}(2)^{n/2}$ and $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ as *"genuine critical points… strictly slack, with the slack growing in $n$"*, at $1.291$, $2.160$, $2.846$, $3.425$ for $n=6,8,10,12$.

**So at the maximal torus L41's bound is an equality and L70's is slack by $1.291$ at $n=6$. Two statements that hold at different points are not one statement.** The record contains both halves of this contradiction, forty-five lines apart, and [L70](../findings/bounds.md)'s block even names it, *"[Post F40](../findings/fence-posts.md)'s correction (i) refuted 'saturated exactly at the balanced sphere products' for the $\lambda$-weighted bound: it saturates on the *whole* subalgebra family, six of eight saturations being ungraded. **The salvage bound survives that population**"*. **The identification clause on the canon is refuted by the very correction that produced L70.**

*What is true, and is presumably what the clause was reaching for:* L70's equality class is contained in L41's, so L70's saturating points are among L41's, and the two agree on the balanced sphere products. Containment is not identity, and the containment is strict.

## 8. The named traps, each answered

| trap | answer |
| --- | --- |
| **$\ker W\ne0$ and padded objects** | **The live defect of this round.** $G_0$ is mass on the kernel, and §6 computes it exactly, $G_0=4(n-4)$ at every padded $\mathcal W_4$ point, in closed form, with no computation. The bound is then $n$-free there and is attained with equality at padded $W_{\mathbb{CP}^2}$, which is what refutes claim 5 |
| **the boundary of every stated range** | $\Delta\in[0,4(n-1)]$: the lower end is attained on all of L23's family (§7), the upper end forces $\mathcal N=\mathcal Z=\emptyset$, impossible on $\mathcal W_n$ by $\operatorname{tr}W=0$. So the tabled range at [curvature-invariants.md](../findings/curvature-invariants.md) line 106 is not attained above, and is itself a silent unit-norm statement |
| **the smallest admissible $n$** | $n=4$. The (A)+(B) route runs there unchanged; the $n\ge5$ hedge in the record attaches to the *Casimir* derivation of $4(n-1)$, which fails at $n=4$ on the reducibility of $\mathfrak{so}(4)$'s adjoint. **The two derivations have different domains and the block names neither.** At $n=4$ the bound reads $\theta\le3\lvert\lambda_{\min}\rvert$ and is attained at $W_{\mathbb{CP}^2}$ |
| **odd $n$** | No parity dependence anywhere: (A), (B), Prop 1.7 and the sign split are all parity-free. Nothing found |
| **the crossover $n=6+2\sqrt7$** | **[Post F7](../findings/fence-posts.md) is not violated, because L41 does not claim to be a candidate inequality for Conjecture A.** It is a bound with no threshold and no $n$-dependence along padded families (§6). Since $\lvert\lambda_{\min}\rvert$ is uncontrolled, as [target.md](../findings/target.md) line 335 concedes, *"its weakness is that $\lvert\lambda_{\min}\rvert$ is uncontrolled"*, L41 cannot see the crossover, and the canon is right that *"it separates nothing there"* |
| **a claim proven on a subfamily and used in general** | **The provenance is exactly this, and it is a real defect.** The section [target.md](../findings/target.md) names as the argument (lines 327–335) contains no derivation at all: it asserts *"in two lines"* and then reports *"verified to 12 digits at $n=5,6,7,8,10$"* and *"verified at 13 points"*. **No copy of L41 anywhere carries the two lines.** They are reconstructible from [bounds.md](../findings/bounds.md) line 290 and [bounds-relaxations.md](../findings/bounds-relaxations.md) line 118, neither of which L41 links to; §3 and §4 above reconstruct them, and they close. So the mathematics survives, but the block's evidence is a finite numerical sample never including $n=4$, for a claim quantified over all $n$ and all of $\mathcal W_n$ |
| **a hypothesis stated but never used** | Criticality. See §1 and §3 |
| **a step using a hypothesis never stated** | Three: $\lVert W\rVert=1$ (§2), orthonormality of $\{v_\gamma\}$ (§1), total symmetry of $T$ (§3) |
| **a universal claim with no witness** | The $4(n-1)$ claim now has one, §4 derives it from (A), (B), Prop 1.7 and total symmetry, with no criticality. It is universal on $\mathcal W_n$ at unit norm, and false off $\mathcal W_n$, which the block does not say |
| **an imported theorem whose hypotheses were never checked** | Two imports, both unnamed in the block, both checked here. Petersen–Wink Prop 1.7 requires an **orthonormal** diagonalising basis, the hypothesis L41 drops. Böhm–Wilking Lemma 2.1 supplies (A) and (B) via $I\#I=(n-2)I$ and $W\#I=-W$; (B) additionally consumes first Bianchi and Ricci-flatness, so it holds on $\mathcal W_n$ and not off it. **Neither import assumes a unital algebra**, so the route that died on that ground does not reach here |
| **symbol collisions** | $\Delta$: the ordered/unordered factor of two, §5, live and load-bearing. $G_0$: absent from [conventions.md](../findings/conventions.md), §5. $A$: the proof's one named ingredient, $A(W)=\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2$, is defined only in the [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md); [conventions.md](../findings/conventions.md) line 39 tables the letter $A$ as $\lambda_1$, and [bounds.md](../findings/bounds.md) uses it for $\mathrm{ad}(v)$. $g$: [conventions.md](../findings/conventions.md) tables $g_k$; the letter is also the metric in the Petersen–Wink quotations and a group element at [target.md](../findings/target.md) line 530. $\lambda$: $\lambda_\gamma$ here against $\lambda_{\max}(L_e)$ throughout [diagonal-half.md](../findings/diagonal-half.md). $v_\gamma$: consistent, a unit eigenvector of $W$ in $\Lambda^2\cong\mathfrak{so}(n)$, though the block never says which space it lives in |

## 9. What would break it, and what I did to look

- **The identity, claims 1 and 3.** A falsifier is a $W\in\mathcal W_n$ with $\lVert W\rVert=1$ and $\sum_\gamma\lambda_\gamma g_\gamma\ne-4P(W)$, or $\sum_\gamma g_\gamma\ne4(n-1)$. **No such object exists**, the derivations of §3 and §4 being unconditional on $\mathcal W_n$. I looked in the three places one could hide: whether (B) secretly needs criticality (it does not, [bounds.md](../findings/bounds.md) attributes it to Bianchi plus Ricci-flatness, and [r331](../reviews/REVIEW_r331.md) is cited for Ricci-flatness alone being insufficient); whether the relabellings are legitimate ($T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ with $c$ totally antisymmetric, so yes); and whether $n=4$ breaks the argument (it does not on this route, only on the Casimir one).
- **The bound, claim 4.** A falsifier is a unit $W\in\mathcal W_n$ with $\theta>\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$. It would have to break the sign split, which is exhaustive, or $g\ge0$, which is manifest. **None exists.**
- **The equality clause, claim 5.** A falsifier is a $W$ attaining equality with $g$-mass off $E_{\min}$. **Found, in closed form: padded $W_{\mathbb{CP}^2}$ at every $n\ge5$, with $G_0=4(n-4)$ and $\Delta=0$, both sides reading $\sqrt{3/2}$.** I looked by writing the exact slack as a sum of nonnegative terms and reading off which indices it constrains; the kernel is the block it does not reach, and the record's own list of equality points contains a padded one.
- **The identification, claim 6.** A falsifier is a point saturating one bound and not the other. **Found: the maximal torus $\mathfrak{so}(2)^{n/2}$ at $n=6,8,10,12$**, saturating L41 by the one-line subalgebra argument of §7 and slack in L70 by $1.291$–$3.425$. More generally every non-symmetric member of L23's family separates them.
- **What would break my two refutations.** For §6: a proof that padding a $\mathcal W_4$ critical point does not stay in $\mathcal W_n$, or that $\mathrm{ad}$ of a mixed bivector commutes with $W_0\oplus0$. Neither can hold, padding preserves Bianchi, Ricci-flatness and criticality, and $\mathrm{ad}(e_1\wedge e_5)$ carries $e_1\wedge e_2$ to $-e_2\wedge e_5$, out of $\Lambda^2\mathbb R^4$ and into the kernel, so the commutator is nonzero on any eigenvector with nonzero eigenvalue. For §7: a demonstration that the maximal torus is a symmetric subalgebra of $\mathfrak{so}(n)$, which would contradict L70's own block.

## Verdict

**BROKEN.**

The two identities and the inequality are true and their proofs close in the lines the block claims, **once the normalisation is repaired**, all three are stated at the wrong homogeneity and hold at $\lVert W\rVert=1$ only, the fix being the one [conventions.md](../findings/conventions.md) already carries and nobody cites. Taken alone, those three would grade `PROVEN, hypotheses corrected`.

Two clauses of the recorded statement are false, and both are conclusions rather than hypotheses.

1. **The equality case is wrong.** It reads *"exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace"*; the truth is $E_{\min}\oplus\ker W$, since $G_0$ is subtracted from the right side. Refuted at padded $W_{\mathbb{CP}^2}$ with $G_0=4(n-4)$, in closed form, at every $n\ge5$. The defect is [L107](../findings/bounds.md)'s equality clause copied onto a strictly sharper bound.
2. **The identification with [L70](../findings/bounds.md) is wrong.** L41's equality class strictly contains L70's; the maximal torus saturates L41 and misses L70 by up to $3.425$. *The canon cites the two "as one piece of evidence", so the defect is not confined to a gloss, it double-counts.*

**And the record contains no written proof of L41 anywhere.** The provenance note points at a section that asserts *"in two lines"* and supplies a numerical table instead, at $n=5,6,7,8,10$ only. The two lines exist and are given in §3 and §4 above; what the record owes is that they be written down, together with the ingredients the block omits, Prop 1.7, relation (A), and the total symmetry of $T$, and the $\Delta$ normalisation settled against the factor of two in [diagonal-half.md](../findings/diagonal-half.md), and $G_0$ tabled in [conventions.md](../findings/conventions.md).
