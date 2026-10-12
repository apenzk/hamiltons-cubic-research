# Review r839 on Lemma L197: the kernel containment and the count it draws from it

*Gate 2, reviewer r839, cold brief. I read no other reviewer's log or report and wrote nothing to [INDEX.md](INDEX.md). One screen was run, seconds of arithmetic on a padded $W_{\mathbb{CP}^2}$ I built myself, as transcription insurance on figures I had already derived by hand. It is named at every point it appears and is evidence for nothing. Log at [agent_logs/g2-kernel-r839.log](../agent_logs/g2-kernel-r839.log).*

## Claim table

| # | Claim under review | Verdict |
|---|---|---|
| 1 | $A=S\,\mathrm{ad}_vS$ is skew and $\operatorname{tr}((\mathrm{ad}_vR)^2)=\operatorname{tr}(A^2)$ | **CONFIRMED** |
| 1b | "The step needing $R\ge0$ is that sign, AND IT IS THE ONLY ONE"; "the sign comes from a square root of $R$ existing, and from nothing else" | **REFUTED AS A DESCRIPTION OF THE SOURCES, HARMLESS TO L197** |
| 2 | $\ker W\subseteq\ker W^\#$ at every critical point, criticality being the operator equation | **CONFIRMED, AND IT IS A STRICT WEAKENING OF WHAT THE SAME LINE GIVES** |
| 3 | $\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha\beta}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta$ | **CONFIRMED, BY A DIFFERENT PROOF; THE BLOCK'S "matching term by term" IS NOT A DERIVATION** |
| 4 | $W^\#=\mathrm{const}\cdot\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\,c_{\alpha\beta}\otimes c_{\alpha\beta}$ | **CONFIRMED, CONSTANT FIXED AT $+1$** |
| 5 | One sign gives PSD, kernel $=\operatorname{span}\{c_{\alpha\beta}\}^\perp$, hence $\operatorname{span}\{[v_\alpha,v_\beta]\}\subseteq\operatorname{ran}W$ | **VACUOUS AS STATED; TRUE AND NON-VACUOUS ONLY UNDER THE INDEX RESTRICTION THE BLOCK OMITS** |
| 6 | The two-sign balance, and its $\mathfrak{pp}/\mathfrak{mm}$ against $\mathfrak{pm}$ reading | **CONFIRMED; THE [L155](../findings/bounds.md) CITATION IS LOOSE AND THE GRADED CLASS MAKES THE BALANCE $0=0$** |
| 7 | $\binom n2-r$ conditions at rank $r$, so low rank is heavily constrained and high rank barely at all, the opposite direction from a rank bound | **THE ARITHMETIC UNDERCOUNTS AND THE INFERENCE IS REFUTED** |
| 7b | The equations are independent | **REFUTED: THE BLOCK'S OWN $W_{\mathbb{CP}^2}$ DEFENCE PROVES THEY COLLAPSE** |
| 8 | A rank bound needs a reason the balance fails at high rank, and nothing here supplies one | **UNDERSTATED PESSIMISM ON THE STATED RELATION, AND WRONG ABOUT THE FULL ONE** |
| 9 | Scope: no $n\ge12$, no Bianchi, no $S=0$, no non-diagonality, critical point rather than maximiser | **CONFIRMED WITH ONE QUALIFICATION: BIANCHI ENTERS THROUGH $Q(\mathcal W_n)\subseteq\mathcal W_n$** |
| 10 | Falsifiers | **NAMED; NONE FOUND FOR THE MATHEMATICS, ONE FOUND FOR THE HEADLINE INFERENCE** |

## The line someone can act on

**Every equation in L197 is true, and its headline conclusion is an artefact of discarding the non-kernel rows of a relation this record has carried since 2026-09-04**: [relation (C)](../findings/bounds.md) reads $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ at **every** index $k$, so criticality supplies $\binom n2$ diagonal equations at every rank, and "high rank barely constrained" describes the block's weakening rather than criticality.

## Conventions

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, the record's normalisation from [conventions.md](../findings/conventions.md). The $\tfrac12$ sits at the $\Lambda^2$ level and the operator-level product is plain trace, so $\langle A,B\rangle=\operatorname{tr}(A^{\mathsf T}B)$ for $A,B$ acting on $\Lambda^2$.
- $\{v_\alpha\}$ is an orthonormal eigenbasis of $W$ with $Wv_\alpha=\lambda_\alpha v_\alpha$, $N:=\binom n2$, $r:=\operatorname{rank}W$, $c_{\alpha\beta\gamma}:=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ totally antisymmetric, $T_{\alpha\beta\gamma}:=c_{\alpha\beta\gamma}^2$ totally symmetric and zero on repeated indices, $c_{\alpha\beta}:=[v_\alpha,v_\beta]$.
- Sums over Greek indices run over ordered tuples unless the display says $\alpha<\beta$.
- $\#$ is Wilking's: $\langle R^\#x,y\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}_xR\,\mathrm{ad}_yR)$. With this $\tfrac12$ and this norm, $\mathrm{id}^\#=(n-2)\,\mathrm{id}$, which is the halved [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) product the record pins the convention against.
- $\mathfrak r:=\operatorname{ran}W$, $\mathfrak k:=\ker W$, $\mathfrak p:=\operatorname{ran}W_+$, $\mathfrak m:=\operatorname{ran}W_-$.

## Hypothesis inventory

| Hypothesis | Where L197 needs it | Status in the block |
|---|---|---|
| $Q(W)=\theta W$ as operators on $\Lambda^2$ | items 2, 3, 6, 7, and everything downstream of the box | stated, and stated correctly |
| $Q$ maps $\mathcal W_n$ into itself | the Lagrange condition has no projection term, so criticality is the full operator equation rather than its $\mathcal W_n$-component | used silently, and this is where first Bianchi and trace-freeness enter |
| $\operatorname{tr}W=0$ | the one-sign case is empty, and $\operatorname{tr}W^\#=-\lVert W\rVert^2$ | stated for the first, unused for the second |
| $\lVert W\rVert=1$ | $\theta=\langle W,Q(W)\rangle$ without a denominator, and $\lambda_{\max}<1$ | assumed throughout, unstated |
| $\theta>\lambda_{\max}$ | needed for $\ker W^\#=\ker W$ and for the signature statement in section 8, free from $\theta\ge1$ by [post F53](../findings/INDEX-traps.md) | absent, because the block never reaches those statements |
| $W$ a maximiser | nowhere | correctly absent |
| $n\ge12$, $S=0$, non-diagonality | nowhere | correctly absent |
| $R\succeq0$ | only inside the discussion of Hamilton's and Wilking's argument, which L197 does not use | correctly quarantined |

## 1. The named step, and what Wilking's proof actually uses

**The algebra is right.** $\mathrm{ad}_v$ is skew for the invariant inner product: $\langle[v,X],Y\rangle=-\langle X,[v,Y]\rangle$ is $\mathrm{ad}$-invariance of $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, which holds because that form is a negative multiple of the Killing form on the compact real form. With $R=S^2$, $S$ symmetric for the same inner product,
$$A^{\mathsf T}=(S\,\mathrm{ad}_v\,S)^{\mathsf T}=S\,\mathrm{ad}_v^{\mathsf T}\,S=-S\,\mathrm{ad}_v\,S=-A,$$
so $A$ is skew. Cyclicity gives the second half in one line:
$$\operatorname{tr}(A^2)=\operatorname{tr}(S\,\mathrm{ad}_v\,S\,S\,\mathrm{ad}_v\,S)=\operatorname{tr}(\mathrm{ad}_v\,S^2\,\mathrm{ad}_v\,S^2)=\operatorname{tr}\big((\mathrm{ad}_vR)^2\big),$$
and $\operatorname{tr}(A^2)=-\operatorname{tr}(A^{\mathsf T}A)=-\lVert A\rVert^2\le0$. So $2R^\#(v,v)=-\operatorname{tr}((\mathrm{ad}_vR)^2)\ge0$. **CONFIRMED**, with one point of care the block leaves implicit: $S$ must be symmetric for the *same* inner product that makes $\mathrm{ad}_v$ skew, which is what lets the two structures meet in one trace.

**The claim about the sources is false, and the true statement is more useful than the false one.** Locate it exactly: *"THE STEP THAT NEEDS $R\ge0$, NAMED, AND IT IS THE ONLY ONE"*, closing *"So the sign comes from a square root of $R$ existing, and from nothing else in the argument."* [Wilking](https://arxiv.org/abs/1011.3561)'s proof of the Claim, at lines 212 to 232 of [paper.txt](https://arxiv.org/abs/1011.3561), contains no square root of $R$. He differentiates $h\le R(\mathrm{Ad}_{\exp(tx)}v,\mathrm{Ad}_{\exp(t\bar x)}\bar v)$ twice at a minimum and gets
$$0\le R(\mathrm{ad}_vx,\mathrm{ad}_{\bar v}\bar x)\qquad\text{for all }x,$$
which is nonnegativity of $R$ **on the image of $\mathrm{ad}_v$ alone**, and then applies the elementary fact that the trace pairing of two nonnegative hermitian operators is nonnegative, in the extended form where the second operator need only be nonnegative on the first one's image.

That difference is not cosmetic. Write $P:=-\mathrm{ad}_vR\,\mathrm{ad}_v$, symmetric because $\mathrm{ad}_v$ is skew, and note $\langle Px,x\rangle=\langle R\,\mathrm{ad}_vx,\mathrm{ad}_vx\rangle$. Then
$$-\operatorname{tr}\big((\mathrm{ad}_vR)^2\big)=\operatorname{tr}(PR)=\operatorname{tr}\big(P^{1/2}RP^{1/2}\big)=\sum_i\big\langle R\,P^{1/2}e_i,\,P^{1/2}e_i\big\rangle ,$$
and every $P^{1/2}e_i$ lies in $\operatorname{im}P\subseteq\operatorname{im}\mathrm{ad}_v$. So the sign follows from
$$\boxed{\ \langle Rx,x\rangle\ge0\ \text{ for } x\in\operatorname{im}(\mathrm{ad}_v)\ }$$
and a global square root is sufficient rather than necessary. **The block's own conclusion is drawn from the sufficient condition and therefore overshoots**: it writes *"A Weyl tensor is never semidefinite, so that step is unavailable"*, when what the step wants is semidefiniteness on one subspace, a property a Weyl tensor is not forbidden to have.

**And a second, independent use of nonnegativity sits in the maximum principle itself.** Wilking's Theorem 5.6 in the appendix defines the null set $N(p,t)=\{X\in S(p,t):R(X,\bar X)=0\}$ and runs Brendle–Schoen's Proposition 4 on the function $u(v)=R(v,\bar v)$. That apparatus needs $u\ge0$ with $u^{-1}(0)$ its minimum level set, which is the cone condition $R\in C(S)$ and not the Claim. Read as a statement about the strong maximum principle, *"it is the only one"* is false twice over.

**Arguing the opposite, which is why this is recorded as a correction and not a break.** The most charitable reading is that the block means the only step in the *algebraic* fragment it borrows, the fragment that survives when the flow and the cone are replaced by criticality. Under that reading the sentence is defensible, and nothing in L197's mathematics depends on it: sections 2 to 7 never invoke Hamilton, Wilking or any positivity. The correction is to the block's account of the literature and to the strength of its own negative conclusion, and its blast radius is the sentence quoted plus the *"so that step is unavailable"* clause in the following blockquote.

## 2. The containment, and the relation it is a shadow of

**Derivation.** Criticality of $\theta(W)=\langle W,Q(W)\rangle/\lVert W\rVert^3$ on the unit sphere of $\mathcal W_n$ is $\nabla P(W)=\mu W$ with $P(W)=\langle W,Q(W)\rangle$. Since $P$ is the cubic whose polarisation is $Q$, $\nabla P=3Q(W)$, and $Q$ mapping $\mathcal W_n$ into itself is exactly what makes the $\mathcal W_n$-gradient equal the ambient one with no projection. Pairing against $W$ at $\lVert W\rVert=1$ fixes $\mu=3\theta$, so
$$W^2+W^\#=\theta W\qquad\text{as operators on }\Lambda^2 .$$
$W^2$ is the operator square. At $v\in\ker W$ we get $W^2v=W(Wv)=0$ and $\theta Wv=0$, hence $W^\#v=0$. **CONFIRMED.** The step is pure linear algebra, and $W\in\mathcal W_n$ is used only to license the operator form of the Lagrange condition, and never again.

**What the same line gives in full, which is where this review's main finding starts.** From $W^\#=\theta W-W^2$ the sharp form is a *polynomial in $W$*. Consequently, on the $\lambda$-eigenspace of $W$,
$$W^\#\big|_{E_\lambda}=\lambda(\theta-\lambda)\,\mathrm{id},$$
so $W^\#$ and $W$ commute, share every eigenspace, and $\ker W\subseteq\ker W^\#$ is the single case $\lambda=0$ of $N$ cases. **This record already holds all of it.** [bounds.md](../findings/bounds.md) states *"At a critical point $W^\#=\theta W-W^2$, so $W^\#$ is a polynomial in $W$"*, lists relation (C) as $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ for every $k$, calls it *"literally the diagonal of $Q(W)=\theta W$"*, and carries the off-diagonal half as $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$. [post F53](../findings/INDEX-traps.md) states $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$ outright. [stratum-two-negative.md](../findings/stratum-two-negative.md) uses *"the three non-kernel rows of $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$"*.

So L197's box is a corollary of a recorded identity, and its novelty is presentational. That is not a defect in the mathematics. It becomes a defect at section 7, where the block reasons from the corollary as though the parent were unavailable.

## 3. The diagonal-entry identity, proved rather than matched

**The block's justification does not stand as written.** *"Matching term by term in $\lambda_\gamma$"* reads a matrix entry off a scalar equation. It can be made valid, by fixing the orthonormal basis $\{v_\alpha\}$, letting $\lambda$ range freely, and differentiating the polynomial identity in $\lambda_\gamma$ using $\nabla\langle W,W^\#\rangle=3W^\#$ and total symmetry of $T$. But that route has a cost the block does not price: the perturbation $\lambda_\gamma\mapsto\lambda_\gamma+t$ leaves $\mathcal W_n$, so it is legitimate only once one knows the cubic expansion holds for every symmetric operator diagonal in the basis, with no Weyl hypothesis. The record does say so, at [stratum-two-negative.md](../findings/stratum-two-negative.md): *"an identity requiring no Weyl hypothesis"*. The block cites the expansion and not that clause.

**The direct proof avoids the question.** With $Wv_\delta=\lambda_\delta v_\delta$ and $[v_\gamma,v_\delta]=\sum_\epsilon c_{\gamma\delta\epsilon}v_\epsilon$,
$$\operatorname{tr}\big((\mathrm{ad}_{v_\gamma}W)^2\big)=\sum_\delta\big\langle[v_\gamma,W[v_\gamma,Wv_\delta]],v_\delta\big\rangle=\sum_{\delta\epsilon}\lambda_\delta\lambda_\epsilon\,c_{\gamma\delta\epsilon}\,c_{\gamma\epsilon\delta}=-\sum_{\delta\epsilon}\lambda_\delta\lambda_\epsilon T_{\gamma\delta\epsilon},$$
the last step by antisymmetry of $c$ in its last two slots. Wilking's definition then gives
$$\langle W^\#v_\gamma,v_\gamma\rangle=-\tfrac12\operatorname{tr}\big((\mathrm{ad}_{v_\gamma}W)^2\big)=\tfrac12\sum_{\delta\epsilon}T_{\gamma\delta\epsilon}\lambda_\delta\lambda_\epsilon .$$
**CONFIRMED.** Contracting against $\lambda_\gamma$ returns $\langle W,W^\#\rangle=\tfrac12\sum T\lambda\lambda\lambda$, so the record's cubic expansion is the trace of this identity and the two are consistent. Setting $W=\mathrm{id}$ and using the Killing row mass $\sum_{\delta\epsilon}T_{\gamma\delta\epsilon}=2(n-2)$ returns $\mathrm{id}^\#=(n-2)\mathrm{id}$, the convention check the record pins the $\tfrac12$ against.

## 4. The bracket form, with the constant fixed

**Polarise the computation of section 3.** For $\gamma\ne\eta$ the same expansion gives $\operatorname{tr}(\mathrm{ad}_{v_\gamma}W\,\mathrm{ad}_{v_\eta}W)=-\sum_{\delta\epsilon}\lambda_\delta\lambda_\epsilon c_{\gamma\delta\epsilon}c_{\eta\delta\epsilon}$, hence
$$\langle W^\#v_\gamma,v_\eta\rangle=\tfrac12\sum_{\delta\epsilon}\lambda_\delta\lambda_\epsilon\big\langle[v_\delta,v_\epsilon],v_\gamma\big\rangle\big\langle[v_\delta,v_\epsilon],v_\eta\big\rangle,$$
which is exactly
$$\boxed{\ W^\#=\tfrac12\sum_{\delta,\epsilon}\lambda_\delta\lambda_\epsilon\,c_{\delta\epsilon}\otimes c_{\delta\epsilon}=\sum_{\delta<\epsilon}\lambda_\delta\lambda_\epsilon\,c_{\delta\epsilon}\otimes c_{\delta\epsilon}\ }$$
**So the block's unnamed constant is $+1$ in the $\alpha<\beta$ form**, and $\tfrac12$ over ordered pairs. The sign is positive, and no other constant is consistent with section 3, whose diagonal is the $\gamma=\eta$ case.

**Three checks, all closed form.** Against the cubic expansion: contracting the display with $W$ returns $\tfrac12\sum T\lambda\lambda\lambda$. Against the pair cap: $\operatorname{tr}W^\#=\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\lVert c_{\alpha\beta}\rVert^2$, while $Q$ preserving trace-freeness forces $\operatorname{tr}W^\#=-\lVert W\rVert^2$ and trace-freeness of $W$ gives $2\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta=-\lVert W\rVert^2$. Subtracting,
$$\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\big(\lVert[v_\alpha,v_\beta]\rVert^2-2\big)=0 ,$$
which is the record's deficit balance in [stratum-two-negative.md](../findings/stratum-two-negative.md) recovered from the bracket form alone, and it holds at every $W\in\mathcal W_n$ with no criticality. Against $W_{\mathbb{CP}^2}$: at spectrum $(2,-1,-1)/\sqrt6$ on an $\mathfrak{su}(2)=\Lambda^2_+$ triple, every orthonormal pair brackets to norm-squared exactly $2$, and I computed $[v_1,v_2]=-\sqrt2\,v_3$ by hand in $\mathfrak{so}(4)$. The bracket form then returns eigenvalues $c^2\lambda_2\lambda_3=1/3$ and $c^2\lambda_1\lambda_2=-2/3$ twice, matching $\lambda(\theta-\lambda)$ at $\theta=\sqrt{3/2}$ term by term. *Screen, transcription insurance only: on a $W_{\mathbb{CP}^2}$ I built in $\mathfrak{so}(4)$, the bracket form with constant $1$ reproduces $W^\#$ to machine precision, $W^\#=\theta W-W^2$ holds, $\operatorname{tr}W^\#=-1$, $\langle W,W^\#\rangle=2/\sqrt6$, $\operatorname{tr}W^3=1/\sqrt6$, the row masses are $2(n-2)=4$, and the pair caps take the two values $0$ and $2$.*

## 5. The one-sign reading, which is empty in the form given

**Each link, checked.** A sum $\sum_iw_i\,u_i\otimes u_i$ with every $w_i>0$ is positive semidefinite, and $\langle Ax,x\rangle=\sum_iw_i\langle u_i,x\rangle^2$ vanishes exactly when $x\perp u_i$ for every $i$, so its kernel is $\operatorname{span}\{u_i\}^\perp$. Both **CONFIRMED**. Taking orthogonal complements in $\ker W\subseteq\ker W^\#=\operatorname{span}\{c_{\alpha\beta}\}^\perp$ gives $\operatorname{span}\{c_{\alpha\beta}\}\subseteq(\ker W)^\perp=\operatorname{ran}W$, **CONFIRMED** for symmetric $W$.

**The failure, located and exhibited.** The hypothesis is *"if every $\lambda_\alpha\lambda_\beta>0$"*. That forces every $\lambda_\alpha\ne0$, so $\ker W=0$, the containment is $0\subseteq\ker W^\#$, and the conclusion $\operatorname{span}\{[v_\alpha,v_\beta]\}\subseteq\operatorname{ran}W=\Lambda^2$ is true of every full-rank $W$ whatever its brackets do. **The one-sign paragraph, read literally, derives nothing.** Read with the span over all pairs and a nontrivial kernel, it is worse than vacuous: $\operatorname{span}\{[v_\alpha,v_\beta]\}_{\alpha,\beta}=[\mathfrak{so}(n),\mathfrak{so}(n)]=\mathfrak{so}(n)$ would force $r=N$ outright.

**The statement that works, and it is Hamilton's.** Take $\lambda_\alpha\ge0$ for every $\alpha$, which is the semidefiniteness Hamilton has and is compatible with a kernel. Then $W^\#\succeq0$ with $\ker W^\#=\operatorname{span}\{c_{\alpha\beta}:\lambda_\alpha\lambda_\beta>0\}^\perp$, and the containment gives
$$[\operatorname{ran}W,\operatorname{ran}W]\subseteq\operatorname{ran}W ,$$
the image is a subalgebra. **That is Hamilton's conclusion exactly**, neither weaker nor stronger, and it is the theorem the [step 9 sweep](../plan.md) recorded as the field's one structural low-rank result. So the block reaches the right destination with an index range that is missing from the span and a hypothesis that empties the kernel. **Arguing the opposite**: the charitable reading supplies the restriction $\lambda_\alpha\lambda_\beta>0$ to the span silently, and under it the sentence is true and non-vacuous whenever some $\lambda_\alpha=0$. The fix is one clause, and the paragraph's role in the block survives it.

## 6. The balance, and the $\mathfrak p$, $\mathfrak m$ translation

**Verified.** $T\ge0$ and $T_{\alpha\alpha\gamma}=0$ let $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=0$ split by the sign of $\lambda_\alpha\lambda_\beta$ into
$$\sum_{\lambda_\alpha\lambda_\beta>0}\lvert\lambda_\alpha\lambda_\beta\rvert T_{\alpha\beta\gamma}=\sum_{\lambda_\alpha\lambda_\beta<0}\lvert\lambda_\alpha\lambda_\beta\rvert T_{\alpha\beta\gamma},$$
pairs meeting the kernel dropping out and diagonal pairs vanishing identically. The correspondence is right: $\lambda_\alpha\lambda_\beta>0$ is both indices in $\mathfrak p$ or both in $\mathfrak m$, $\lambda_\alpha\lambda_\beta<0$ is one of each, and $T_{\alpha\beta\gamma}$ at $\gamma\in\mathfrak k$ measures the component of the bracket along a kernel direction. So it is $\mathfrak{pp}$ and $\mathfrak{mm}$ against $\mathfrak{pm}$, weighted, tested against each kernel direction. **CONFIRMED.**

**Two corrections to the sentence that follows it.** First, the quoted conditions $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ are the equality clause of the inequality at [bounds.md](../findings/bounds.md) line 57, while [L155](../findings/bounds.md)'s own box states $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$. The block attributes one to the other. Second, and with content: **on L155's graded class the balance is $0=0$**. Grading puts every bracket of $\mathfrak p\oplus\mathfrak m$ back inside $\mathfrak p\oplus\mathfrak m$, so $T_{\alpha\beta\gamma}=0$ for every $\gamma\in\mathfrak k$ and both sides vanish. The balance therefore carries no information on the class the block points at as its next setting, and all of its content lives off that locus. That is worth stating before the next cycle reaches for the graded case as *"the natural next screen"*.

## 7. The count, which is the block's most consequential claim

**The arithmetic undercounts its own relation.** $\ker W\subseteq\ker W^\#$ says $W^\#v=0$ for every $v\in\mathfrak k$, not merely $\langle W^\#v,v\rangle=0$. In any basis adapted to $\mathfrak k\oplus\mathfrak r$ that is the whole kernel block plus the mixed block of a symmetric operator,
$$\tbinom{N-r+1}{2}+(N-r)r\quad\text{scalar equations},$$
against the block's $N-r$, which is only the diagonal of the first. The block states the operator form and then counts the scalar form, which is the same weakening it warns about two paragraphs earlier.

**The inference is refuted.** *"One equation per kernel index means $\binom n2-r$ conditions at rank $r$, so LOW rank is heavily constrained and high rank barely at all, the opposite direction from a rank bound."* The premise measures the containment. The containment is the $\lambda_\gamma=0$ slice of relation (C), which holds at **every** index:
$$\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),\qquad k=1,\dots,N,$$
and, with the off-diagonal half $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, criticality supplies $\binom{N+1}{2}$ scalar equations at every rank whatever. **So the count of criticality conditions does not fall as $r$ rises. Only the count of the conditions the block kept does.** Reading "high rank is barely constrained" off that is reading a property of the weakening as a property of criticality. [Post F63](../findings/fence-posts.md), which the block cites for the shape of the argument, says the opposite in its own last line: *"A rank bound at a non-diagonal critical point must come from the criticality equation or the sharp term"*, and the non-kernel rows are precisely the part of the criticality equation the block discarded.

**Independence: the equations collapse, and the block's own defence is the proof.** Three collapses, in increasing order of severity.

1. *Basis dependence.* The $N-r$ equations are indexed by a choice of orthonormal basis of $\mathfrak k$, while the containment is basis-free. Every other basis gives another $N-r$ equations of the same form. So the list is a slice of an $O(N-r)$-orbit and cannot be the content.
2. *One exact linear dependency among the $N$ diagonal rows.* Summing relation (C) over $k$ gives $2\operatorname{tr}W^\#=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\lVert c_{\alpha\beta}\rVert^2$ on the left and $2(\theta\operatorname{tr}W-\lVert W\rVert^2)=-2$ on the right. Both sides hold on all of $\mathcal W_n$ from trace-freeness, the bracket form and $Q(\mathcal W_n)\subseteq\mathcal W_n$, with no criticality. So at most $N-1$ of the $N$ rows are criticality content.
3. *The decisive one.* Take the block's defence at face value. At padded $W_{\mathbb{CP}^2}$, $r=3$, so the containment supplies $\binom{N-2}{2}+3(N-3)$ equations, of order $N^2/2$, while the free data is $3$ eigenvalues and a $3$-frame in $\Lambda^2\mathbb R^n$, of dimension $3N-3$. A naive count of equations against unknowns would forbid rank-three critical points at every $n\ge6$. **One exists.** So the equations are massively dependent, and no conclusion about the direction of constraint can be drawn from their number in either direction. The block's defence, offered to show the conditions are satisfiable in bulk, in fact destroys the count it was defending.

**Arguing the opposite.** The most charitable reading is narrow and survives: *as a family of conditions on $\mathfrak k$ alone, the containment is empty at $r=N$ and largest at $r$ small.* That is true and is worth one sentence. What does not survive is the step from there to *"the opposite direction from a rank bound"*, since the object that would give a rank bound is criticality, not its kernel slice.

## 8. What the route needs, and what is already available

**On the stated relation the block's pessimism is right and understated, and the record already carries the reason with a witness.** The kernel equations are a subfamily of the per-row conditions in relation (C). [Post F43](../findings/bounds-relaxations.md) records that no per-row condition closes $d\ge3$, and its witness is decisive here for a second reason: the $n=12$ spectrum $(-m)^{\times30},(1.2m)^{\times20},(0.375m)^{\times16}$ is **kernel-free** and passes every row at $\theta=1.2917>\theta_0(12)=1.2360$. At a kernel-free point the containment is vacuous, so it adds exactly nothing to a configuration that already clears the target. The route as stated is fenced by a post the block does not cite, with a witness on record. *The witness is a spectrum and realisability as a Weyl tensor is open, so this fences the route and not the conjecture.*

**Against the block's pessimism, three things the full relation gives for free, none of them per-row.** All three need $\theta>\lambda_{\max}$, which is free whenever $\theta\ge1$: trace-freeness and $\lVert W\rVert=1$ give $\lambda_{\max}<1$, [post F53](../findings/INDEX-traps.md)'s own line.

1. **The containment is an equality.** $W^\#=W(\theta-W)$ with $\theta-W\succ0$, so $\ker W^\#=\ker W$ and $\operatorname{rank}W^\#=\operatorname{rank}W$. The block's $\subseteq$ is $=$.
2. **The signature is preserved.** $W^\#$ has eigenvalue $\lambda_\alpha(\theta-\lambda_\alpha)$, of the sign of $\lambda_\alpha$. So $W^\#$ is positive definite on $\mathfrak p$, negative definite on $\mathfrak m$, zero on $\mathfrak k$. **This is the definiteness the block hopes to recover "on one summand at a time", and it is already there**, with no grading hypothesis and no L155.
3. **The range is inside the span of its own brackets.** $\operatorname{ran}W^\#\subseteq\operatorname{span}\{c_{\alpha\beta}:\lambda_\alpha\lambda_\beta\ne0\}=\operatorname{span}[\mathfrak r,\mathfrak r]$ from the bracket form of section 4, and $\operatorname{ran}W^\#=\mathfrak r$ from (1). Hence
$$\boxed{\ \operatorname{ran}W\subseteq\operatorname{span}[\operatorname{ran}W,\operatorname{ran}W]\ \text{ at every critical point with }\theta>\lambda_{\max}\ }$$
a perfectness condition on $\mathfrak r$, and **the containment opposite to Hamilton's**, obtained with no positivity anywhere. It is exactly of the type [I68c](../plan.md) asks for, a condition on which subspaces can occur, and it is stated on $\mathfrak r$ rather than on $\mathfrak k$, which is the same statement since the two are orthogonal complements. It is nonvacuous: it forbids $\mathfrak r$ abelian, and more generally forbids any vector of $\mathfrak r$ orthogonal to all brackets of $\mathfrak r$. At padded $W_{\mathbb{CP}^2}$, $\mathfrak r=\Lambda^2_+\cong\mathfrak{su}(2)$ is perfect and the condition holds with equality.

**Whether that closes anything: no, and honestly.** At $r=N$ the condition reads $\mathfrak{so}(n)\subseteq[\mathfrak{so}(n),\mathfrak{so}(n)]$, which is true, so it too is weakest at high rank. What it changes is the shape of [I68c](../plan.md): the unclassified object is not "which subspaces can be $\ker W$" but "which subspaces $\mathfrak r$ satisfy $\mathfrak r\subseteq\operatorname{span}[\mathfrak r,\mathfrak r]$ with a prescribed sign-split $\mathfrak p\oplus\mathfrak m$", and that is a question about $\mathfrak r$, on which the record has L155's graded classification to hand. **This is a live handle and it costs no computation to state.**

## 9. Scope and hypotheses

Answering the brief item by item. **$n\ge12$**: used nowhere, every step being dimension-free, and $n$ enters only through $N=\binom n2$ in the counts and through $2(n-2)$ in the row mass, neither of which the block invokes. **First Bianchi**: used once, silently, at the point where criticality is written as an unprojected operator equation, which needs $Q(\mathcal W_n)\subseteq\mathcal W_n$, and also in $\operatorname{tr}W^\#=-\lVert W\rVert^2$, which the block does not use but section 4's check does. **$S=0$**: nowhere. **Non-diagonality**: nowhere, and the block does not claim it. **Maximiser rather than critical point**: nowhere, since every statement holds at every critical point, and the block says so correctly. **Unit norm**: assumed throughout without being stated, in $\theta=\langle W,Q(W)\rangle$ and in $\lambda_{\max}<1$. That omission has cost this record a cycle before, at [Lemma L29](../findings/stratum-two-negative.md) and [Lemma L70](../findings/bounds.md), and it should be written into L197's statement.

## 10. What would falsify the block, and what I did

**Named falsifiers.** (i) A critical point with $W^\#v\ne0$ for some $v\in\ker W$, which would break the box and with it the whole block. This is impossible given the operator form of criticality, and the only way in would be criticality meaning $Q(W)=\theta\cdot\mathrm{id}$ or a quadratic-form identity, which the brief flags as a first-draft error and which I checked against the Lagrange derivation in section 2. (ii) A constant other than $+1$ in the bracket form, or the opposite sign, which would break sections 5 to 7 wholesale. (iii) An orthonormal pair in $\mathfrak{so}(n)$ with $\lVert[v_\alpha,v_\beta]\rVert^2>2$, which would break the pair cap the checks in section 4 lean on. (iv) A rank at which the number of criticality conditions genuinely falls, which would rescue the block's count.

**What I did.** I rebuilt every identity from Wilking's definition rather than from the block, which is how the bracket-form constant and the diagonal identity were fixed independently. I read Wilking's proof of the Claim and his appendix rather than the block's account of them, which is what produced the correction in section 1. I checked the block's count against the record's relations (A), (B) and (C) in [bounds.md](../findings/bounds.md), which is what refuted it. I looked for a falsifier of (iv) by computing the condition count at both ends, $r=N$ and $r=3$, in closed form. I ran one screen, on a padded $W_{\mathbb{CP}^2}$ I constructed in $\mathfrak{so}(4)$, as transcription insurance on figures already derived by hand: it agreed with all of them and is evidence for none of them.

**No falsifier of the mathematics was found.** The falsifier of the headline inference is the record's own relation (C), and the falsifier of the route as stated is [post F43](../findings/bounds-relaxations.md)'s kernel-free witness.

## Verdict

**SOUND, WITH ITS HEADLINE INFERENCE REFUTED.** Every equation in L197 is true, the box is correct, the bracket form's constant is $+1$, and the balance is verified. Three things owe a correction. The account of where nonnegativity enters Wilking's and Hamilton's arguments is wrong, and the true account weakens the block's own reason for saying the mechanism is unavailable. The one-sign paragraph is vacuous as written and needs one index restriction to become Hamilton's theorem. And the count, which the brief calls the block's most consequential claim, measures a strict weakening of criticality and then reports its weakness as criticality's: relation (C) holds at every index, so the number of conditions is rank-independent, and the block's own $W_{\mathbb{CP}^2}$ defence shows the count carries no information in either direction. **Against that, the full relation gives three consequences for free that the block says the record lacks**, the strongest being $\operatorname{ran}W\subseteq\operatorname{span}[\operatorname{ran}W,\operatorname{ran}W]$ at every critical point above $\theta=1$, which is a classification handle for [I68c](../plan.md) and needs no positivity, no grading and no computation.
