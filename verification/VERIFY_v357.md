# Verifier v357, Lemma L115: $\lambda_{\max}(M)=\theta$ at global maximisers, the restricted display, the strictness remark, the by-product $\theta\ge\max_\alpha\lambda_\alpha$, and the Lean files

Cold brief ([BRIEF_L115.md](BRIEF_L115.md)). No numerical work was done and no scripts were written. Every value below is exact or is a value quoted from the record and labelled as such. The cited lines were printed and match the brief verbatim. Log: [agent_logs/verify-L115-v357.log](../agent_logs/verify-L115-v357.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Heading clause 1: $\lambda_{\max}(M)=\theta$ at every global maximiser | GAP |
| 2 | The step from Lemma L24 to $\lambda_{\max}(L_e\vert_{\mathcal D})=1$ (the record's own GAP grade) | CONFIRMED (the step is a gap) |
| 3 | Display: $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser and every $S^m\times S^m$, $m\ge4$ | GAP |
| 4 | A cap on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$ would close clause 1 | GAP |
| 5a | $\sup_W\lambda_{\max}(M)\le\theta_0$ implies Conjecture A | CONFIRMED |
| 5b | ... and is strictly stronger, witnessed by the $C_5$ blow-up | GAP (the cited witness does not witness) |
| 6a | $\operatorname{diag}M=\lambda$ | CONFIRMED AS ALGEBRA |
| 6b | Heading clause 2: $\theta\ge\max_\alpha\lambda_\alpha$ at a global maximiser | CONFIRMED (strictly, by the route using $\lVert\lambda\rVert=1$ and $M(n)\ge\sqrt{3/2}$) |
| 6c | Clause 2 by the route on file ($\operatorname{diag}M=\lambda$ plus clause 1) | GAP |
| 7 | The pointwise statement at maximisers is Conjecture A rewritten | GAP (one direction proven, the converse is clause 1) |
| 8 | Passage B facts: $M$ symmetric, $P=\langle\lambda,M\lambda\rangle$, $\theta\le\lambda_{\max}(M)$, $M\lambda=\theta\lambda$ at a critical point | CONFIRMED AS ALGEBRA |
| 9 | Passage B measured values ($C_5$ blow-up $0.809017$ and $0.670820$, suprema $\sqrt{3/2}$ at $n=6,8,10$) | HYPOTHESIS-DEBT |
| 10 | Lean: clause 2 by route 2 | CONFIRMED AS ALGEBRA |
| 11 | Lean: clause 1 | GAP (no declaration types $M$, $\theta$, $P$, a Weyl tensor or a maximiser) |

**What the round should do:** renumber L115 as the by-product alone, proven by $\lambda_\alpha\le\lVert\lambda\rVert=1<\sqrt{3/2}\le M(n)=\theta$, move clause 1 and the restricted display to an open statement with the missing cap written out, and delete the $C_5$ blow-up as a witness of strictness.

## 0. Conventions, fixed once

- $\mathcal W_n\subset\operatorname{Sym}(\Lambda^2\mathbb R^n)$ with the Frobenius inner product, $N=\dim\Lambda^2=n(n-1)/2$. $\mathcal W_n=0$ for $n\le3$, so the smallest admissible dimension is $n=4$.
- $Q(X)=X^2+X^\#$ on all of $\operatorname{Sym}(\Lambda^2)$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $L_W=W\circ(\cdot)$, $L_e=L_W/\theta$, $T(A,B,C)=\langle A,B\circ C\rangle$.
- $\{v_\alpha\}$ an orthonormal eigenbasis of $W$ with $Wv_\alpha=\lambda_\alpha v_\alpha$, $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, and $c'^2_{\alpha\beta\gamma}$ its square. $\mathcal D$ is the set of operators diagonal in $\{v_\alpha\}$, identified isometrically with $\mathbb R^N$ by $x\mapsto\sum_\alpha x_\alpha v_\alpha\otimes v_\alpha$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. The crossover: $\theta_0(n)^2<3/2$ if and only if $n^2-12n+8<0$, that is $n<6+2\sqrt7$, so $4\le n\le11$ lies below and $n\ge12$ above ($\theta_0(11)^2=180/121<3/2<220/144=\theta_0(12)^2$). No integer sits on the crossover.
- Normalisation check used throughout: with $[e_i\wedge e_k,e_j\wedge e_k]=\pm e_i\wedge e_j$, the unit Weyl tensor of $\mathbb{CP}^2$, eigenvalues $(2t,-t,-t)$ on $\Lambda^+$ and $0$ on $\Lambda^-$ with $t=1/\sqrt6$, has $\sum\lambda^3=6t^3$ and $c'^2=2$ on the $\Lambda^+$ triple, so $P=6t^3+12t^3=3/\sqrt6=\sqrt{3/2}$, matching the brief's value.

## Hypothesis inventory

| Hypothesis | Carried by | Checked against the object | Used by the written proof |
|---|---|---|---|
| $W\in\mathcal W_n$, $\lVert W\rVert=1$, so $\lVert\lambda\rVert=1$ | statement | yes | Passage B's Rayleigh bound, route 2 of clause 2 |
| $W$ a global maximiser, $P(W)=M(n)$ | statement (both clauses), display (first disjunct) | yes | clause 2 route 2 uses $\theta=M(n)\ge\sqrt{3/2}$. Clause 1 has no written proof, so nothing uses it there. Any L24 argument needs only local maximality |
| $n\ge4$ | unstated | $\mathcal W_n=0$ below | implicitly, for $M(n)\ge\sqrt{3/2}$ via padded $\mathbb{CP}^2$ |
| an eigenframe $\{v_\alpha\}$ chosen | Passage B definition of $M$ | frame is non-unique at repeated eigenvalues and on $\ker W$ | the statement never fixes which frame, see Section 9 |
| L24: $W$ critical | L24 | global maximiser is critical by Lagrange, since $Q$ maps $\mathcal W_n$ to itself | cited |
| L24: $\theta=P(W)>0$ | L24 | $\theta=M(n)\ge\sqrt{3/2}>0$ | cited |
| L24: $W$ a local maximiser | L24 | holds at global maximisers. At $S^m\times S^m$ no quoted passage states it | the display's second disjunct would need it and it is unstated there |
| coordinate-diagonal | display | yes | no written argument uses it |
| $m\ge4$ | display | $S^m\times S^m$ at $m=4,5$ is not a global maximiser ($\theta_0(8)^2=21/16$, $\theta_0(10)^2=36/25$, both $<3/2$) | no written argument uses it |
| padded $W_{\mathbb{CP}^2}$ has $P=\sqrt{3/2}$ at every $n\ge4$ | given | normalisation confirmed above, padding by zero preserves Bianchi and zero Ricci | route 2 of clause 2 (Lean `theta_gt_lambda` takes it as the free hypothesis hθ) |

Findings from the inventory: global maximality in clause 1 is stated and no argument uses it (the only argument pattern in view, L24, needs local maximality). Local maximality of $S^m\times S^m$ is used by any L24-based reading of the display and is stated nowhere in the quoted lines.

## 1. Clause 1 unrestricted: $\lambda_{\max}(M)=\theta$ at every global maximiser

**The half that is proven.** $\theta\le\lambda_{\max}(M)$ at any unit $W$ (Section 8). So clause 1 amounts to the upper bound $\langle x,Mx\rangle\le\theta\lvert x\rvert^2$ for all $x\in\mathbb R^N$.

**What the record offers.** Line 286 names the only route, the step from L24 to $\lambda_{\max}(L_e|_{\mathcal D})=1$, and grades it GAP. Line 290 says "The unrestricted form is not citable". So the numbered heading at line 268 asserts, as the lemma, a statement its own body declares uncited.

**Three-step record.** Located: line 268 against lines 286 and 290. Exhibited: the heading has no quantifier restriction, the body restricts to coordinate-diagonal maximisers and $S^m\times S^m$ and calls the rest not citable. Charitable reading: the heading is a title for a section whose content is the restricted display. Even so, a numbered result must state what is proven, and the restricted display itself has no argument (Section 3). The finding stands as GAP: clause 1 has no argument on file, and what would have to be proved is $\sup_{x\in\mathcal D,\lvert x\rvert=1}T(W,x,x)\le\theta$ at every global maximiser and in every eigenframe.

No counterexample was found (Section 12), so REFUTED is not available.

## 2. The step from Lemma L24 to $\lambda_{\max}(L_e|_{\mathcal D})=1$

**What $\lambda_{\max}(L_e|_{\mathcal D})$ means.** $\mathcal D$ is not $L_e$-invariant, so the object is the compression $\pi_{\mathcal D}L_e\iota_{\mathcal D}$. Following the algebra: for $X=\operatorname{diag}(x)$, $(WX+XW)/2=\operatorname{diag}(\lambda_\alpha x_\alpha)$ and $(W\#X)_{\alpha\alpha}=\tfrac12\sum_{\beta,\gamma}c'^2_{\alpha\beta\gamma}\lambda_\gamma x_\beta$, so $\pi_{\mathcal D}L_W\iota_{\mathcal D}=M$ exactly. Hence $\lambda_{\max}(L_e|_{\mathcal D})=1$ is the same statement as $\lambda_{\max}(M)=\theta$. This identification is CONFIRMED AS ALGEBRA, and it is not written in the quoted lines.

**Does L24 reach $\mathcal D$?** L24 bounds $L_e$ on $\mathcal W_n\cap W^\perp$ only. $\mathcal D\not\subset\mathcal W_n$ in every frame: $\operatorname{Id}_{\Lambda^2}=\sum_\alpha v_\alpha\otimes v_\alpha\in\mathcal D$, and $\operatorname{Id}$ is the curvature operator of the round sphere with Ricci tensor $(n-1)g\ne0$. So the step reads L24 outside its domain. The record's GAP grade is CONFIRMED.

**What $\mathcal D\cap\mathcal W_n$ is.** It always contains $W$. In the coordinate frame of a coordinate-diagonal $W$, a coordinate-diagonal operator with entries $a_{ij}$ satisfies Bianchi automatically (all components with four distinct indices vanish), its Ricci tensor is $\operatorname{diag}(\sum_ja_{ij})$, so $\mathcal D\cap\mathcal W_n$ is the space of symmetric zero-diagonal $n\times n$ matrices with zero row sums, of dimension $n(n-3)/2$, and its orthogonal complement in $\mathcal D$ is the $n$-dimensional Ricci-type space $\{a_{ij}=h_i+h_j\}$ (orthogonality: $\sum_{i<j}a_{ij}(h_i+h_j)=\sum_ih_i\sum_ja_{ij}=0$). For a general frame no description is on file, and none is claimed beyond "generically neither trace-free nor Bianchi".

## 3. The restricted display

**Locate.** Line 288: "$\lambda_{\max}(M)=\theta$ at every COORDINATE-DIAGONAL global maximiser, and at every $S^m\times S^m$, $m\ge4$", introduced by "So" at the end of line 286.

**What argument is on file.** None. The sentence the "So" follows says only that a step is a gap. Nothing positive follows from that. The obstruction line 286 names is that elements of $\mathcal D$ are "neither trace-free nor Bianchi". Restricting to coordinate-diagonal $W$ removes the Bianchi half only: the coordinate-frame $\mathcal D$ still contains the $n$-dimensional Ricci-type space of Section 2, including $\operatorname{Id}$, on which L24 says nothing. So even the charitable reading (coordinate-diagonal is where L24 reaches) does not deliver the display.

**What would have to be proved**, for the coordinate-diagonal disjunct: (i) L24's cap on $\mathcal D\cap\mathcal W_n\cap W^\perp$, which holds at a local maximiser, (ii) that the cross terms $T(W,Y,X_h)$ between $Y\in\mathcal D\cap\mathcal W_n$ and the Ricci-type $X_h$ vanish, which would follow from $L_W\mathcal W_n\subseteq\mathcal W_n$ and the total symmetry of $T$ on $\operatorname{Sym}(\Lambda^2)$, and (iii) a cap $T(W,X_h,X_h)\le\theta\lvert X_h\rvert^2$ on the Ricci-type block. Item (iii) is the missing content and is nowhere on file.

**Why global maximality and $m\ge4$.** No reason is on file for either. Global maximality is stronger than the local maximality any L24 argument uses. The second disjunct covers $S^4\times S^4$ and $S^5\times S^5$, which are not global maximisers ($\theta_0(8)^2=21/16<3/2$ and $\theta_0(10)^2=36/25<3/2$, and padded $\mathbb{CP}^2$ reaches $\sqrt{3/2}$). So the display quietly drops "global" for its second disjunct and would need local maximality of $S^m\times S^m$, which is stated nowhere in the quoted lines.

**What happens at $m\le3$.** The display is silent. A closed-form screen at $S^2\times S^2$ (Section 12) finds $\lambda_{\max}(M)=\theta$ in the coordinate frame, so $m\ge4$ is not where the equality first fails in that frame. The bound is unexplained rather than sharp. At $m=3$ nothing was checked.

**Three-step record.** Located (line 288), exhibited (the Ricci-type directions, $\operatorname{Id}\in\mathcal D\setminus\mathcal W_n$ in the coordinate frame, and $S^4\times S^4$ outside the global class), charitable reading argued and failing. Verdict GAP.

## 4. "A cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$ would close it"

**Locate.** Line 290.

**Assessment.** The claim gives no value for the cap and no argument. Read with the value $\theta$, that is $\lambda_{\max}(L_e|_{\mathcal W_n^\perp})\le1$ with the complement taken in $\operatorname{Sym}(\Lambda^2)$, it would suffice provided three facts are on file, and none of them is in the quoted lines: (a) $T$ is totally symmetric on $\operatorname{Sym}(\Lambda^2)$, so $L_W$ is self-adjoint there, (b) $L_W$ maps $\mathcal W_n$ into $\mathcal W_n$, hence $\mathcal W_n^\perp$ into $\mathcal W_n^\perp$, so a decomposition $X=X_{\mathcal W}+X_\perp$ of $X\in\mathcal D$ carries no cross term, (c) L24 upgraded to $\lambda_{\max}(L_W|_{\mathcal W_n})\le\theta$, which uses $T(W,W,Z)=\theta\langle W,Z\rangle=0$ for $Z\perp W$. Read with any value above $\theta$ (for example L24's own normalisation read as $L_W$ rather than $L_e$), it does not close anything. The cap is sufficient and not necessary, since only the compression to $\pi_{\mathcal W_n^\perp}\mathcal D$ enters.

**Three-step record.** Located, the failure is the absent value and argument (a claim with no argument on file), charitable reading supplies $\theta$ and then (a) to (c) are still owed. Verdict GAP.

## 5. "$\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A"

**5a, stronger.** At a global maximiser $M(n)=\theta\le\lambda_{\max}(M)\le\sup_W\lambda_{\max}(M)$ by Passage B's boxed bound. So the target implies $M(n)\le\theta_0(n)$. CONFIRMED.

**5b, strictly, and its witness.** Locate: line 294, "the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$". Strictness needs a unit $W$ with $\lambda_{\max}(M)>\theta_0(n)$ in a dimension where Conjecture A might hold. The witness gives $\lambda_{\max}(M)/\theta>1$, which shows only that the Rayleigh bound is slack at that point. Its recorded $\lambda_{\max}(M)=0.809017$ (from a run, and equal to $(1+\sqrt5)/4$ to six digits) lies below $\theta_0(4)=\sqrt3/2$, and $\theta_0$ is increasing in $n$ since $\theta_0^2=2(1-1/n)(1-2/n)$. Exact comparison: $(1+\sqrt5)/4<\sqrt3/2\iff6+2\sqrt5<12\iff\sqrt5<3$. So the $C_5$ blow-up sits below $\theta_0(n)$ at every $n\ge4$ and does not witness strictness in any dimension. Charitable reading: "strictly stronger" means only "not obviously equivalent". Under that reading the assertion is informal, and it sits against Passage B, which conjectures $\sup\lambda_{\max}(M)=\theta_0(n)$ for $n\ge12$, the statement under which target and Conjecture A are both true. No $W$ with $\lambda_{\max}(M)>\theta_0(n)$ at $n\ge12$ is on file. Verdict GAP.

**Range.** At $4\le n\le11$ the target is false in closed form: padded $\mathbb{CP}^2$ gives $\sup_W\lambda_{\max}(M)\ge\sqrt{3/2}>\theta_0(n)$. Passage B places Conjecture A at $n\ge12$. So the comparison is meaningful only for $n\ge12$, and line 294 does not say so. Odd $n$ changes nothing in 5a. At odd $n\ge13$ no balanced sphere product exists, so Passage B's "equality at the balanced sphere product" is an even-$n$ statement, and nothing on file addresses whether $\theta_0(n)$ is attained there.

## 6. The by-product $\theta\ge\max_\alpha\lambda_\alpha$

**6a, $\operatorname{diag}M=\lambda$.** $M_{\alpha\alpha}=\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\alpha\gamma}\lambda_\gamma$, and $c'_{\alpha\alpha\gamma}=\langle[v_\alpha,v_\alpha],v_\gamma\rangle=0$. Holds in every orthonormal eigenframe. The record asserts it without this line. CONFIRMED AS ALGEBRA.

**6c, route on file.** $\lambda_\alpha=\langle e_\alpha,Me_\alpha\rangle\le\lambda_{\max}(M)=\theta$. The inequality uses exactly the upper half of clause 1, the half the record calls not citable. The half that is proven, $\theta\le\lambda_{\max}(M)$, points the wrong way for this. GAP.

**6b, route using only $\lVert\lambda\rVert=1$ and $M(n)\ge\sqrt{3/2}$.** $\lambda_\alpha\le\lvert\lambda_\alpha\rvert\le\lVert\lambda\rVert=1<\sqrt{3/2}\le M(n)=\theta$. Strict, with margin $\theta-\lambda_\alpha\ge\sqrt{3/2}-1$, at every global maximiser and every $n\ge4$ including odd $n$ and $\ker W\ne0$. The hypotheses used: unit norm, global maximality (for $\theta=M(n)$), and the given padded $\mathbb{CP}^2$ value. CONFIRMED. The clause is true and trivial, and its content does not depend on $M$ at all.

## 7. "The pointwise statement at maximisers ... is Conjecture A rewritten, neither easier nor harder"

Reading "the pointwise statement" as $\lambda_{\max}(M(W^\ast))\le\theta_0$ at global maximisers $W^\ast$: it implies $M(n)\le\theta_0$ by $\theta\le\lambda_{\max}(M)$ (proven). The converse, from $M(n)\le\theta_0$ to $\lambda_{\max}(M)\le\theta_0$ at maximisers, needs $\lambda_{\max}(M)\le\theta$ there, which is clause 1. So the equivalence rests on the result the record calls not citable. Restricted to coordinate-diagonal maximisers it would rest on the display, which also has no argument, and nothing on file says maximisers are coordinate-diagonal. At $4\le n\le11$ both sides are false in closed form (padded $\mathbb{CP}^2$) if Conjecture A is posed there, so the equivalence is trivially true there and says nothing. Verdict GAP.

## 8. Passage B facts imported

- $M$ symmetric: $c'^2_{\alpha\beta\gamma}=c'^2_{\beta\alpha\gamma}$ since $c'$ is antisymmetric in its first two indices. CONFIRMED.
- $P=\langle\lambda,M\lambda\rangle$: in the eigenframe $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma$, so $\langle W,W^\#\rangle=\tfrac12\sum c'^2\lambda\lambda\lambda$. The coordinate formula for $\#$ is not in the quoted lines, and the normalisation check in Section 0 is consistent with it. CONFIRMED AS ALGEBRA.
- $\theta\le\lambda_{\max}(M)$ at any unit $W$ with $\theta=P(W)$: Rayleigh with $\lVert\lambda\rVert=1$. CONFIRMED.
- $M\lambda=\theta\lambda$ at a critical point: $(M\lambda)_\alpha=\lambda_\alpha^2+(W^\#)_{\alpha\alpha}=Q(W)_{\alpha\alpha}=\theta\lambda_\alpha$, in every eigenframe. CONFIRMED AS ALGEBRA.
- "equals $\theta$ to six digits at every point except the $C_5$ blow-up", "$0.809017$ against $0.670820$", "supremum $\sqrt{3/2}$ at $n=6,8,10$ by full-gradient ascent": supported only by runs. HYPOTHESIS-DEBT. The lower bound $\sup\lambda_{\max}(M)\ge\sqrt{3/2}$ is exact (padded $\mathbb{CP}^2$). The upper bound is the debt.

## 9. Quantifier order and scope

- Clause 1 reads "for every global maximiser $W$, for the eigenframe of $W$, $\lambda_{\max}(M)=\theta$". The frame quantifier is unstated. At repeated eigenvalues (both eigenvalues of $S^m\times S^m$ repeat, with multiplicities $m(m-1)$ and $m^2$) and on $\ker W$ (padded objects) the frame is non-unique and $M$, built from $c'$ in that frame, is not determined by $W$. The proven facts of Section 8 hold in every frame. The unproven upper half would need "every frame" to be usable as stated. See withdrawn candidate W1.
- The display's two disjuncts carry different quantifiers: "every coordinate-diagonal global maximiser" and "every $S^m\times S^m$, $m\ge4$", the second without maximality. See Section 3.
- The strictness remark and the equivalence remark carry no range in $n$. See Sections 5 and 7.

## 10. The edges

| Edge | Finding |
|---|---|
| $n\le3$ | $\mathcal W_n=0$, statement vacuous. $n\ge4$ is never stated |
| $n=4$ | route 2 of clause 2 holds ($\mathbb{CP}^2$ itself). Clause 1 has no argument. Coordinate-frame $\mathcal D\cap\mathcal W_4$ has dimension $2$ |
| odd $n$ | clause 2 holds. No balanced sphere product exists, so the display's second disjunct is even-$n$ only. Nothing else on file changes |
| crossover $6+2\sqrt7$ | not an integer. The target of Section 5 is false at $n\le11$ and the strictness and equivalence remarks are stated without this range |
| $m\le3$ | display silent. Screen at $m=2$ finds no failure in the coordinate frame |
| repeated eigenvalues | frame quantifier unstated (Section 9) |
| $\ker W\ne0$ | padded $\mathbb{CP}^2$ screen finds $\lambda_{\max}(M)=\theta$ in the adapted frame (Section 12). Other kernel frames not examined |

## 11. The Lean files against the record

**[L115.lean](../lean/HamiltonsCubic/Results/L115.lean).**

- `lambda2_six`, `ambient_dim`, `weyl_six`: natural-number identities $15$, $120$, $84$. They are the dimensions of $\Lambda^2\mathbb R^6$, $\operatorname{Sym}(\Lambda^2\mathbb R^6)$ and $\mathcal W_6$, but nothing in the file connects the numerals to those spaces.
- `intersection_share_ambient`, `intersection_share_weyl`, `share_bracket`: rational inequalities $1/120<1/100<1/84<12/1000$. The quantity $1/100$ is unexplained in the quoted passages and presumably a measured share, so it corresponds to no claim of Passages A or B.
- `cap_on_subspace_transfers_nothing`: exists $f:\mathbb Q^2\to\mathbb Q$ bounded on the line $\{(t,0)\}$ and unbounded. A true toy illustrating that a cap on a subspace need not extend. It involves no Weyl tensor, $L_e$ or $\mathcal D$, and it does not show the specific step of Section 2 fails.
- `true_claim_bad_argument`: from $C$ and $\lnot H$ derive $(H\to C)\wedge C$. A propositional tautology with no content about L115.

**[L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean).**

- `IsTopRayleigh A t` is $\forall x,\ x^\top Ax\le t\,x^\top x$. For symmetric $A$ this is $\lambda_{\max}(A)\le t$, an upper bound and not the equality $\lambda_{\max}=t$. No symmetry hypothesis is carried, so for general $A$ it bounds the symmetric part. Harmless for $M$, which is symmetric.
- `theta_ge_diag`: from $A_{\alpha\alpha}=\lambda_\alpha$ and `IsTopRayleigh A θ` derive $\lambda_\alpha\le\theta$. This is route 6c with the missing half of clause 1 taken as the hypothesis `hlam`. It formalises the implication, not the by-product.
- `theta_gt_lambda`, `theta_sub_lambda_ge`: from $\sum\lambda_a^2=1$ and $\sqrt{3/2}\le\theta$ derive $\lambda_\alpha<\theta$ and $\theta-\lambda_\alpha\ge0.2247$. This is route 6b as real arithmetic, with $\theta\ge\sqrt{3/2}$ a free hypothesis. The link $\theta=M(n)\ge\sqrt{3/2}$ is untyped. Direction and binders agree with clause 2. CONFIRMED AS ALGEBRA.
- `c5_exceeds_nonWeyl_cap`: $1/\sqrt2<0.809017$. Neither a "non-Weyl cap" of $1/\sqrt2$ nor any claim using it appears in Passages A or B, and $0.809017$ is a run output. Unrelated to the quoted claims.
- `witLam` and the closing example: a non-vacuity witness for `theta_gt_lambda` on `Fin 2`. It is not a Weyl spectrum (a Weyl operator has $N\ge6$ eigenvalues). Harmless.
- **Clause 1 is not typed anywhere.** No declaration mentions $P$, $Q$, $c'$, $M(\lambda)$, criticality, a maximiser, or the equality $\lambda_{\max}(M)=\theta$. The files were read as quoted and were not compiled.

## 12. The falsifying object, and the search for it

**What would falsify clause 1:** a global maximiser $W$ and an eigenframe with some $x\in\mathbb R^N$, $\langle x,Mx\rangle>\theta\lvert x\rvert^2$, necessarily with $x$ having a component outside $\mathcal W_n$. For the display, the same at a coordinate-diagonal global maximiser in its coordinate frame, or at $S^m\times S^m$, $m\ge4$.

**Screens, closed form, reported as screens and not as evidence for clause 1.**

- **Padded $\mathbb{CP}^2$ at every $n\ge4$, frame $\{\omega_1,\omega_2,\omega_3\}\cup\Lambda^-\cup\{e_i\wedge e_k\}_{i\le4<k}\cup\{e_k\wedge e_l\}_{4<k<l}$.** The $\Lambda^+$ block of $M$ is $t\begin{pmatrix}2&-1&-1\\-1&-1&2\\-1&2&-1\end{pmatrix}$ with spectrum $\{3t,-3t,0\}$, top eigenvector $\lambda$ and $3t=\sqrt{3/2}=\theta$. The $\Lambda^-$ and $e_k\wedge e_l$ blocks are zero. For each $k>4$ the block on $\{e_i\wedge e_k\}_{i\le4}$ is $\tfrac t4(2A_1-A_2-A_3)$ with $A_j$ the three perfect matchings of $\{1,2,3,4\}$, spectrum $\{0,t,-t/2,-t/2\}$. All cross blocks vanish because the relevant brackets leave $\Lambda^2\mathbb R^4$ or $[\Lambda^+,\Lambda^-]=0$. So $\lambda_{\max}(M)=\theta$ in this frame, including on $\ker W$. Kernel frames mixing different $k$ were not examined.
- **$S^2\times S^2$, coordinate frame.** Unit Weyl entries $w_s=1/\sqrt3$ within blocks and $w_c=-1/(2\sqrt3)$ across, $\theta=\sqrt3/2$. $\mathcal D\cap\mathcal W_4=\operatorname{span}(W,Y)$ with $y_{13}=y_{24}=1$, $y_{14}=y_{23}=-1$, and $T(W,Y,Y)=-2\sqrt3$, $\lvert Y\rvert^2=4$. On the Ricci-type block $T(W,X_h,X_h)=\tfrac{n-2}2h^\top wh$ with $\lvert X_h\rvert^2=(n-2)\lvert h\rvert^2+(\sum h)^2$, and at $S^m\times S^m$ the top eigenvalue of $w$ on $\mathbf 1^\perp$ is $2\sqrt{m-1}/\sqrt{2m-1}$, which is $\tfrac m{2m-1}\cdot2\theta$ with $\theta=\sqrt{(m-1)(2m-1)}/m$. So the Ricci-type block stays below $\theta$ at every $m\ge2$, and at $m=2$ $\lambda_{\max}(M)=\theta$ in the coordinate frame.
- **The $C_5$ blow-up** is a critical point, not a maximiser, and its recorded values are run outputs. It is outside clause 1's scope.

No falsifier was found. The screens cover two objects in one frame each and do not cover the Ricci-type block of a general coordinate-diagonal maximiser, $S^m\times S^m$ at $m\ge3$ on $\mathcal D\cap\mathcal W_n$, non-coordinate maximisers, or other frames.

## 13. Withdrawn candidates

- **W1, "$\lambda_{\max}(M)$ is ill-defined at repeated eigenvalues".** Located: the definition of $M$ "in an eigenbasis of $W$" (Passage B) and clause 1's silence on the frame. Exhibit: non-uniqueness of the frame is exhibited ($S^m\times S^m$ multiplicities, padded kernels), but no pair of frames with different $\lambda_{\max}(M)$ was exhibited in closed form. Fails step 2, withdrawn as a defect. It is kept in Section 9 as an unstated quantifier the restatement must fix.
- **W2, "the display is false at $m\le3$".** The display makes no claim at $m\le3$, and the $m=2$ screen finds equality. Fails step 2, withdrawn.
- **W3, "L24 is misapplied at global maximisers".** Its three hypotheses (critical, $\theta>0$, local maximiser) all hold there (inventory). Fails step 3, withdrawn.
- **W4, "the by-product is false".** Route 6b proves it strictly. Fails step 2, withdrawn. The defect is in the route on file only (6c).

## Overall verdict

**GAP.** Clause 2 of the heading is true, strictly, by a two-line argument the Lean file types as algebra, but the route written in the record passes through clause 1. Clause 1, the lemma's main content, has no argument on file, and the record itself calls it not citable. The restricted display that replaces it has no argument either: coordinate-diagonal $\mathcal D$ still contains the Ricci-type directions L24 does not reach. The strictness remark cites a witness lying below $\theta_0(n)$ at every $n$.
