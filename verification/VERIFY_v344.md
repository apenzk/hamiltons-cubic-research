# Verifier v344, Lemma L113: the moment-elimination sentence, the provenance of positivity and support, pinned class against pinned data, the F42 extension, the "only sources" sentence, the feasibility equivalence, the Lean declarations and the boundary

**Cold brief ([BRIEF_L113.md](BRIEF_L113.md)), no numerical work, no scripts written, no Lean build run, every value below exact.** The cited lines of [bounds.md](../findings/bounds.md) (258-264, 508, 526, 562, 566), [conventions.md](../findings/conventions.md) (50), [fence-posts.md](../findings/fence-posts.md) (417, 419, 423) and [bounds-relaxations.md](../findings/bounds-relaxations.md) (47, 51, 53) were printed and match the brief verbatim. Prop 1.7 was read at [notes.md](../references/petersen-wink-2019-bochner-technique/notes.md). Log at [agent_logs/verify-L113-v344.log](../agent_logs/verify-L113-v344.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's bolded sentence "moment analysis of the $g$-distribution cannot leave the pinned class" is a proposition | GAP |
| 2 | "Positivity of $g$ and the support of its measure are consequences of the spectrum alone", with $m_0=4(n-1)$ and $m_1=-4\theta$ from (A), (B) and the cubic identity, (C) unused | CONFIRMED AS ALGEBRA |
| 3 | Passage A carries a proof, and the `Lemma` label is supported | GAP |
| 4 | "Pinned class" (Passage A) is the object "pinned data" (Passage D), and $g$-moment analysis exhausts it | REFUTED AS STATED |
| 5 | L113 is "a theorem-shaped extension of post F42" | REFUTED AS STATED |
| 6 | "The only sources on the table are the Jacobi identity and first Bianchi", "the single open door" | REFUTED AS STATED |
| 7 | $g\ge0$, $\sum_kg_k=4(n-1)$, $\sum_k\lambda_kg_k=-4\theta$ is feasible exactly when $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ | CONFIRMED (needs $\theta\ge0$, $\lambda_{\min}\le0\le\lambda_{\max}$, $\lVert W\rVert=1$) |
| 8a | [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) formalises any part of Passage A | REFUTED AS STATED |
| 8b | [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean): `feasible_iff`, `feasible_iff_theta`, `moment_add`, `moment_smul` as read | CONFIRMED AS ALGEBRA |
| 8c | "A convex image cannot separate a non-convex class from its complement" is typed and true | GAP |
| 9 | Boundary: $\lVert W\rVert\ne1$, repeated and simple $\lambda_{\min}$, $\ker W\ne0$, small $n$, odd $n$, $n=6+2\sqrt7$ | CONFIRMED (normalisation must be stated) |

**The round should replace Passage A by the stated projection theorem of Section 1 (proven by `feasible_iff`), delete or rewrite the "only sources" and "single open door" sentences in light of L109, drop the F42 "extension" framing, and either delete L113.lean or mark it as unrelated scaffolding.**

## 0. Conventions, fixed once

- $W\in\mathcal W_n$ acts on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=n(n-1)/2$, orthonormal eigenbasis $\{v_k\}$, eigenvalues $\lambda_k$, $\lVert W\rVert^2=\sum_k\lambda_k^2$, $\mathop{\mathrm{tr}}W=\sum_k\lambda_k=0$, so $\lambda_{\min}\le0\le\lambda_{\max}$ for every $W$ and $\lambda_{\min}<0<\lambda_{\max}$ for $W\ne0$.
- $T_{abc}=c_{abc}^2\ge0$ totally symmetric, $T_{kaa}=0$. Relations (A), (B), (C) as in Passage B.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, $m_j=\sum_k\lambda_k^jg_k$, $\Delta=\lambda_{\max}-\lambda_{\min}$.
- A critical point is $Q(W)=\theta W$ on $\lVert W\rVert=1$, $\theta=P(W)$. Since $P$ is cubic, $-W$ is critical with $-\theta$ whenever $W$ is critical with $\theta$, so both signs of $\theta$ occur.
- $\mathcal W_n=0$ for $n\le3$, so the smallest admissible dimension is $n=4$.
- The $g$-cone at fixed spectrum is $\mathcal K(\lambda)=\{(m_0,m_1)=(\sum g_k,\sum\lambda_kg_k): g\in\mathbb R^N_{\ge0}\}$.
- CP² witness spectrum: the Fubini-Study Weyl tensor has $W^-=0$ and $W^+$ with eigenvalues proportional to $(2,-1,-1)$, so on $\Lambda^2$ the unit-norm spectrum is $a(2,-1,-1,0,0,0)$ with $a=1/\sqrt6$. Its negative $-W$ has spectrum $a(-2,1,1,0,0,0)$, with $\lambda_{\min}=-2a$ simple and $\ker W$ of dimension 3.

## Hypothesis inventory

**Hypotheses the statement carries.** Passage A states none. Read in context it needs the following, and none is written into the block:

| Hypothesis | Where it is needed | Stated in Passage A | Used by the argument |
|---|---|---|---|
| $W$ critical, $\lVert W\rVert=1$ | $m_0=4(n-1)$ and $m_1=-4\theta$ (otherwise $m_0=4(n-1)\lVert W\rVert^2$, $m_1=-4P(W)$) | no | yes, implicitly |
| $\theta\ge0$ | the one-sided form $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ as the complete consequence (Section 7) | no | yes, implicitly |
| $\mathop{\mathrm{tr}}W=0$ | $\lambda_{\min}\le0\le\lambda_{\max}$ | no | yes, implicitly |
| "moment inequality built from positivity and support" means valid for every $g\ge0$ supported in the spectrum | the elimination (Section 1) | no, undefined | yes, it is the whole scope |
| $n\ge4$ | nonempty $\mathcal W_n$ | no | no |

**Theorems the passages import, and their hypotheses against the object.**

- **(A), (B)** (Passage B): hold at every $W$, no criticality. Used for $m_0$ (both) and $m_1$ ((B) only). Checked in Section 2.
- **(C)**: needs criticality. **Unused** by every step of the $g$-moment argument. This is correct, and it is also the reason the $g$-moment class is strictly smaller than the pinned system (Section 4).
- **Cubic identity** (Passages B, C): needed for $m_1=-4P(W)$ in the form $\sum\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\langle W,W^\#\rangle$ in the record's normalisation (Section 2). Its statement is not quoted in the brief. Taken as given through L107.
- **L107** (Passage C, a given): its hypotheses are (A), (B), $T\ge0$, the cubic identity. Its conclusion at unit norm is what Section 7 finds as the complete consequence. L113 does not cite it. It should.
- **L109** (Passage E, a given): hypotheses Prop 1.7, $T\ge0$, row marginal (A). Applies at every $W$. **Not used by L113, and it contradicts L113's "only sources" sentence** (Section 6).
- **Post F42** (Passage D): cited as the parent. Its conclusion is withdrawn in both directions (Section 5).
- **Prop 1.7** (Petersen-Wink, read at source in the notes): $\lvert LR\rvert^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$ for $R$ symmetric on $\Lambda^2V$ diagonalised by $\{\Xi_\alpha\}$ and every $L\in\mathfrak{so}(V)$. Applied with $L=v_\gamma$ and $R=W$. Hypotheses (orthonormal eigenbasis, $L$ skew) hold. It gives the formula for $g_\gamma$, and positivity of $g_\gamma$ as a squared norm.

**Unused and unstated.** (C) is carried by the pinned system and unused, correctly. Unit norm, $\theta\ge0$ and $\mathop{\mathrm{tr}}W=0$ are used and unstated.

## 1. Is Passage A a proposition

**Located.** Line 526: "*any* pair of moment inequalities built from them, however the free moment enters, can only return a pinned conclusion once the free moment is eliminated. **Moment analysis of the $g$-distribution cannot leave the pinned class.**"

**Terms.** None of "moment inequality built from them", "pinned conclusion" or "pinned class" is defined in Passages A-F. Three readings:

- **R1, pinned = expressed in $(\lambda,\theta,n)$.** A conclusion from which the free moments have been eliminated is by construction an inequality in $(\lambda,\theta,n)$. The sentence is then true of every argument whatsoever, including a proof of the conjecture itself, which is a bound on $\theta$ in terms of $n$. Under R1 the sentence has no content and cannot be the obstruction the passage draws from it.
- **R2, pinned = implied by the pinned system $\{T\ge0,(A),(B),(C)\}$.** $g\ge0$ follows from $T\ge0$, $m_0$ from (A), (B), $m_1$ from (B) and the cubic identity, so anything derived from these is implied by the pinned system. True, one line, and weak (Section 4 shows the containment is strict).
- **R3, no stronger than L107 and its mirror.** This is the content worth stating, and it is true.

**The proposition that R3 names, and its proof.** Fix $n\ge4$ and a spectrum $\lambda$ with $\lambda_{\min}<\lambda_{\max}$. Let $d\ge2$ and let $\Phi_1,\dots,\Phi_r:\mathbb R\times\mathbb R\times\mathbb R^{d-1}\to\mathbb R$ be any functions such that $\Phi_i(m_0(g),m_1(g),m_2(g),\dots,m_d(g))\ge0$ for every $g\in\mathbb R^N_{\ge0}$. If $R(c,s)$ is any relation such that $\exists\,x\in\mathbb R^{d-1}:\ \Phi_i(c,s,x)\ge0\ \forall i$ implies $R(c,s)$, then $R(c,s)$ holds on all of $\mathcal K(\lambda)$, and $\mathcal K(\lambda)=\{(c,s): c\ge0,\ c\lambda_{\min}\le s\le c\lambda_{\max}\}$. *Proof.* For $(c,s)$ in that set, the two-atom vector $g_j=t$ at an index with $\lambda_j=\lambda_{\max}$, $g_i=c-t$ at an index with $\lambda_i=\lambda_{\min}$, $t=(s-c\lambda_{\min})/\Delta\in[0,c]$, has $m_0=c$, $m_1=s$, and $x=(m_2(g),\dots,m_d(g))$ satisfies every $\Phi_i$. The reverse inclusion is $\lambda_{\min}\le\lambda_k\le\lambda_{\max}$ summed against $g\ge0$. So at $c=4(n-1)$, $s=-4\theta$, every such conclusion is implied by $-(n-1)\lambda_{\max}\le\theta\le(n-1)\lvert\lambda_{\min}\rvert$.

**Arity.** "Pair" is too narrow. The statement holds for any finite family $\Phi_1,\dots,\Phi_r$ and any number of free moments $m_2,\dots,m_d$. A pair is what eliminates one free moment, and the passage itself notes that "all free content sits at $G_2$ and above", so $m_3,m_4,\dots$ are free as well.

**Record.** Located: quoted above. Failure: under R1 the sentence is vacuous (every $\theta$-bound, including the conjecture's, is a "pinned conclusion"), and no reading is fixed by the text. Opposite: under R3 the sentence is true and its proof is five lines, already typed as `feasible_iff`. **Verdict GAP: the proposition is not stated, and the statement above is what would have to be written.**

## 2. "Consequences of the spectrum alone"

**Located.** Line 526, first sentence.

**Positivity.** $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2\ge0$ by Prop 1.7, or termwise from $T\ge0$. It uses none of (A), (B), (C) and no criticality. It is a structural fact about every $W$, not a consequence of the spectrum.

**Support.** $\mathop{\mathrm{supp}}\sum_kg_k\delta_{\lambda_k}\subseteq\{\lambda_k\}$. Containment follows from the spectrum. The actual support, $\{\lambda_k:g_k>0\}$, depends on $T$ (a $v_k$ in the centraliser of $W$ has $g_k=0$). The argument needs only containment.

**$m_0$.** Expand $(\lambda_\alpha-\lambda_\beta)^2$:
$$m_0=2\sum_\alpha\lambda_\alpha^2\sum_{k\beta}T_{\alpha k\beta}-2\sum_\alpha\lambda_\alpha\sum_{k\beta}\lambda_\beta T_{\alpha\beta k}=2\cdot2(n-2)\lVert W\rVert^2-2\sum_\alpha\lambda_\alpha(-2\lambda_\alpha)=4(n-1)\lVert W\rVert^2,$$
by (A) then (B). No (C).

**$m_1$.**
$$m_1=2\sum_\alpha\lambda_\alpha^2\sum_{k\beta}\lambda_kT_{\alpha k\beta}-2\sum\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=-4\sum\lambda^3-2\sum\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta},$$
by (B) alone. Equality with $-4P(W)=-4\sum\lambda^3-4\langle W,W^\#\rangle$ is the cubic identity $\sum\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\langle W,W^\#\rangle$ in the record's normalisation. (A) and (C) do not enter. At a critical point on the unit sphere, $m_1=-4\theta$.

**Record.** Located: "consequences of the spectrum alone". Failure: positivity comes from $T\ge0$, and $m_1=-4\theta$ needs $\theta$, which is data beyond the spectrum. Opposite: read "the spectrum" as the record's pinned pair $(\lambda,\theta)$, and positivity as a fact that holds at every $W$ and so needs no data. Under that reading every step checks. **Verdict CONFIRMED AS ALGEBRA, with the wording "the spectrum alone" corrected to "$T\ge0$, (A), (B), the cubic identity, $\lVert W\rVert=1$ and $\theta$".**

## 3. Does Passage A carry a proof

**Located.** The block at lines 508 and 526 is a heading and one paragraph opening "**The moral**". The bolded sentence is reached by "so" from the positivity-and-support sentence.

**What is on file.** No definition of the class of admissible inequalities, no statement that $\mathcal K(\lambda)$ is the two-sided cone, no elimination step, no citation of L107 (the conclusion the elimination lands on). The step from "positivity and support are pinned" to "any inequality built from them returns a pinned conclusion" is exactly the projection statement of Section 1, and it is asserted rather than argued. The result has no entry in [results.md](../results.md) (brief, Definitions).

**What would have to be proved.** The projection statement of Section 1: $\mathcal K(\lambda)$ equals the cone $c\lambda_{\min}\le s\le c\lambda_{\max}$, with the two-atom witness for the inclusion that matters.

**Record.** Located. Failure: the passage is labelled "The moral", has one inferential "so", and the heading calls it a Lemma. Opposite: [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) `feasible_iff` proves the missing step, so the record holds a proof, in Lean, of the reading R3. The Lemma label is supported only if the block is rewritten to state R3 and point there. **Verdict GAP.**

## 4. "Pinned class" against "pinned data"

**Located.** Passage A: "cannot leave the pinned class". Passage D line 419: "*pinned data*: everything a critical point's spectrum and $\theta$ already determine", a set of contractions $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$. Passage D line 423: "the pinned class is far stronger than this post claimed".

**They are different objects.** Pinned data is a set of numbers. A statement about inequalities needs the implication class: the set of relations in $(\lambda,\theta,n)$ implied by $\{T\ge0,(A),(B),(C)\}$. Line 423 uses "pinned class" in this second sense, as a relaxation.

**The $g$-moment class is strictly inside that implication class.** L109 (Passage E) derives from $T\ge0$ and (A) at one row that $g_\gamma\le u:=2(n-2)\Delta^2$. At $\lVert W\rVert=1$ with $N\ge2$, $\Delta^2\le2(\lambda_{\max}^2+\lambda_{\min}^2)\le2$, so $u\le4(n-2)<4(n-1)=m_0$ for every $n\ge4$. Hence no single atom can carry the whole mass. At a spectrum with $\lambda_{\min}$ simple, the point $\theta=(n-1)\lvert\lambda_{\min}\rvert$ of the $g$-moment cone needs $g=4(n-1)\,e_{\min}$, which L109 excludes. The capped maximum is strictly smaller.

**Closed-form witness.** Spectrum of $-W_{\mathrm{CP}^2}$ at unit norm, $a(-2,1,1,0,0,0)$, $a=1/\sqrt6$, $n=4$. Moment cone: $\theta\le3\cdot2a=6a$. L109: $u=2\cdot2\cdot(3a)^2=36a^2=6$, $m_0=12$. Maximising $-\sum\lambda_kg_k$ subject to $0\le g_k\le6$, $\sum g_k=12$ puts $6$ at $-2a$ and $6$ at eigenvalue $0$, giving $-m_1\le12a$, so $\theta\le3a<6a$. The pinned system with T-level rows excludes $\theta\in(3a,6a]$ at this spectrum, and $g$-moment analysis does not.

**Record.** Located: both lines quoted. Failure: the identification of "moment analysis of $g$" with "the pinned class" is false under the only sense a statement about inequalities can use, by the witness above. Opposite: under R2 of Section 1, "cannot leave the pinned class" says only containment, which is true. The sentence then understates the pinned class rather than misdescribing $g$-analysis. The heading's framing (moment analysis is the pinned class's boundary) and the "single open door" conclusion depend on the identification, so the charitable reading does not rescue the passage. **Verdict REFUTED AS STATED.**

## 5. "A theorem-shaped extension of post F42"

**Located.** Line 526: "**The moral, and it is a theorem-shaped extension of [post F42](../findings/fence-posts.md).**" Passage D line 423: "**THIS POST'S CONCLUSION IS WITHDRAWN IN BOTH DIRECTIONS.** ... *So the pinned class is far stronger than this post claimed, and "sharpening inside it cannot work" is unsupported.*"

**Direction.** F42's (withdrawn) scope is every route through the pinned data. L113's scope is moment analysis of $g$, which by Section 4 is a strict sub-relaxation of the pinned system. A statement about a sub-relaxation is a special case of F42's scope, not an extension of it.

**Status of the parent.** The parent's conclusion is withdrawn, and the withdrawal note says sharpening inside the pinned class is open. Passage A's "single open door" re-asserts the withdrawn substance for the pinned class as a whole.

**Record.** Located. Failure: the parent is withdrawn, and L113 restricts rather than extends it. Opposite: "extension" could mean "a rigorous version of F42's idea for one family". That version (R3) is true, but it does not carry the withdrawn post's conclusion, and the passage uses it to carry exactly that conclusion. **Verdict REFUTED AS STATED.**

## 6. "The only sources on the table are the Jacobi identity and first Bianchi"

**Located.** Line 526: "The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see, and the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself** ... *That is now the single open door*".

**Against Passage E.** L109's cap $g_\gamma\le2(n-2)\Delta^2$ is a realizability constraint on the $g$-distribution. By Section 4 it is invisible to positivity and support (the moment cone admits $g_\gamma=4(n-1)>u$). It is on the table (Passage E). It comes from Prop 1.7, $T\ge0$ and (A), not from Jacobi or Bianchi. It constrains $G_2$: the set of $(m_0,m_1,m_2)$ realised by $0\le g\le u$ is a proper subset of that realised by $g\ge0$, since $g=4(n-1)e_{\min}$ is removed. It changes the conclusion: Section 4's witness excludes $\theta\in(3a,6a]$. The first-order check of L109 itself: $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\le\Delta^2\sum_{\alpha\beta}T_{\gamma\alpha\beta}=2(n-2)\Delta^2$ by $T\ge0$ and (A). It follows.

**Record.** Located. Failure: L109 is a second source, shown in closed form at the $-W_{\mathrm{CP}^2}$ spectrum. Opposite: read "helps" as "leaves the pinned class in sense R2". L109 is itself implied by the pinned system, so it does not "help" in that sense, and the sentence then claims that Jacobi and Bianchi are the only constraints outside the pinned system. Under that reading there is no argument on file for the exclusivity ("only"), and the "single open door" still contradicts Passage D's withdrawal note that sharpening inside the pinned class is open. **Verdict REFUTED AS STATED (literal reading, witness L109). Under the charitable reading, GAP: what would have to be proved is that every constraint on $T$ beyond $\{T\ge0,(A),(B),(C)\}$ comes from Jacobi or Bianchi, and that the pinned system cannot prove the target bound.**

## 7. The complete consequence of the two-moment system

**Claim.** $g\ge0$, $\sum_kg_k=c:=4(n-1)$, $\sum_k\lambda_kg_k=s:=-4\theta$ is feasible iff $\theta\le(n-1)\lvert\lambda_{\min}\rvert$.

**Derivation.** By Section 1, feasible iff $c\lambda_{\min}\le s\le c\lambda_{\max}$, that is
$$-(n-1)\lambda_{\max}\ \le\ \theta\ \le\ (n-1)\lvert\lambda_{\min}\rvert,$$
using $c>0$ ($n\ge2$) to divide and $\lambda_{\min}\le0$ to write $-\lambda_{\min}=\lvert\lambda_{\min}\rvert$. The left inequality is automatic exactly when $\theta\ge-(n-1)\lambda_{\max}$, which $\theta\ge0$ and $\lambda_{\max}\ge0$ guarantee. So the one-sided iff needs $\theta\ge0$ (or the two-sided form).

**Sign conditions, every one.** $n\ge2$ gives $c>0$. $\lambda_{\min}\le0$ gives the absolute value. $\lambda_{\max}\ge0$ and $\theta\ge0$ give the automatic left side. $\lVert W\rVert=1$ gives $c=4(n-1)$ (Section 9).

**Candidate: without $\theta\ge0$ the iff fails.** Located: the brief's item 7 states the iff with no sign on $\theta$, and Passage C's L107 is one-sided. Failure: spectrum $a(2,-1,-1,0,0,0)$, $a=1/\sqrt6$, $n=4$, $c=12$, feasible iff $-6a\le\theta\le3a$. At $\theta=-7a$, $\theta\le3a$ holds and $s=28a>24a=c\lambda_{\max}$, so the system is infeasible. Negative $\theta$ occurs at genuine critical points ($-W$ whenever $W$ is critical). Opposite: at a critical point with $\theta<0$ the left inequality is L107 applied to $-W$, so no true bound is lost, and the Lean statement carries $\theta\ge0$. The finding stands as a hypothesis correction to the prose form of the equivalence, not as an error in L107. **Verdict CONFIRMED with $\theta\ge0$ stated, or in the two-sided form for all $\theta$.** Against Passage C: the complete consequence of the system is L107 together with its mirror, and nothing more.

## 8. The Lean declarations against Passage A

**8a, [L113.lean](../lean/HamiltonsCubic/Results/L113.lean).**

| Declaration | What it states | Relation to Passage A |
|---|---|---|
| moment_of_combination | for $m:\mathbb R\to\mathbb R$ satisfying the linearity hypothesis, $m(\alpha T_1+(1-\alpha)T_2)=\alpha m(T_1)+(1-\alpha)m(T_2)$ | the hypothesis instantiated at $(\alpha,1-\alpha)$, proof term `hlin α (1 - α) T₁ T₂`. $T_i$ are reals, not tensors. Unrelated |
| constraints_convex | for reals $T_1=T_2=c$, both $\ge0$, $\alpha\in[0,1]$: the combination is $\ge0$ and equals $c$ | the hypotheses force $T_1=T_2$, so the combination is $c$ itself. Degenerate |
| reachable_convex | linear $m$, $m(T_i)=v_i$ imply $m$ of the combination is the combination of $v_i$ | restatement of the first declaration |
| unused_hypothesis | $(A\to B\to C')\to A\to B\to C\to C'$ for arbitrary propositions | propositional weakening, no mathematics |
| closure_with_content | $\exists S\subseteq\mathbb N,\ 0\in S\wedge1\notin S$ | trivial, unrelated |

Located: Passage F lines quoted in the brief. Failure: none of the five mentions $\lambda$, $g$, a moment, a pinned class or an inequality. Opposite: they may be intended as scaffolding for a convexity argument about linear images of $T$. Even so, none states such an argument about any object in the lemma. **Verdict REFUTED AS STATED: L113.lean formalises nothing of Passage A.**

**8b, [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean), read as quoted, not built.**

- `Feasible lam c s` is $\exists g\ge0$ with $\sum g=c$, $\sum\lambda g=s$. It matches the system of Section 7 with $\lambda$ an arbitrary vector.
- `feasible_iff` (hypotheses: `hne` nonempty index set, `hc : 0 < c`): Feasible iff $c\cdot\inf\lambda\le s\le c\cdot\sup\lambda$. The forward direction sums $\lambda_{\min}\le\lambda_k\le\lambda_{\max}$ against $g\ge0$. The backward direction splits on $\lambda_{\min}=\lambda_{\max}$ (one atom $c$, with $s=c\lambda_{\min}$ forced by `hlo`, `hhi`) and otherwise uses the two-atom witness $t=(s-c\lambda_{\min})/\Delta$, with $0\le t\le c$ from `hlo`, `hhi`. I followed each step: $\sum g=t+(c-t)=c$, $\sum\lambda g=\lambda_{\max}t+\lambda_{\min}(c-t)=s$. The case split in `hstep` rules out $k=i=j$ by `hij`. The algebra follows. `hc` is used for the orientation of the witness (it is not needed for the iff at $c=0$, where both sides force $s=0$).
- `feasible_iff_theta` (hypotheses `hne`, `hn : 2 ≤ n`, `hθ : 0 ≤ θ`, `hmin : inf ≤ 0`, `hmax : 0 ≤ sup`): Feasible at $c=4(n-1)$, $s=-4\theta$ iff $\theta\le(n-1)\lvert\inf\lambda\rvert$. `hn` gives $c>0$, `hmin` gives the absolute value, and `hθ`, `hmax`, `hn` together give the right-hand inequality in the backward direction. Every hypothesis is used, and together they are exactly the sign conditions of Section 7.
- `moment`, `moment_add`, `moment_smul`: $m_j$ as a function of an arbitrary $T$ is additive and homogeneous. True by linearity of the sum. No symmetry of $T$ and no relation (A)-(C) is assumed, which is harmless for linearity.
- The `example`: $\lambda=(1,-1)$, $g=(2,2)$ gives $\sum g=4$, $\sum\lambda g=0$. Correct, and not a Weyl spectrum ($N=2$ is no $n(n-1)/2$).

**Gap between Lean and claim.** $N$ and $n$ are independent in `feasible_iff_theta` (no $N=n(n-1)/2$), $\lambda$ is not tied to a Weyl tensor, `hn` admits $n=2,3$ where $\mathcal W_n=0$, and no declaration connects `Feasible` to the actual $g_k$ (positivity, $m_0$, $m_1$ remain the L107 givens). No declaration states the elimination over free moments of Section 1, though `feasible_iff` is its only nontrivial ingredient. **Verdict CONFIRMED AS ALGEBRA for what is typed, and it is the correct reading R3 of Passage A in its LP core.**

**8c, "a convex image cannot separate a non-convex class from its complement".** Located: brief item 8. The phrase is not the type of any declaration in Passage F (docstrings were removed from the brief). Two readings:

- *Preimage reading*: if $m$ is linear and $C$ convex, $m^{-1}(C)$ is convex, so no test "$m(x)\in C$" carves out a non-convex set exactly. True, one line.
- *Image reading*: no linear $m$ has $m(K)\cap m(K^c)=\emptyset$ for non-convex $K$. False. In $\mathbb R^2$, $K=\{x:x_1\in\{0\}\cup[2,3]\}$ is non-convex, $m(x)=x_1$, $m(K)=\{0\}\cup[2,3]$ and $m(K^c)=\mathbb R\setminus(\{0\}\cup[2,3])$ are disjoint.

No class in the passages is shown to be non-convex, and "pinned class" is undefined. **Verdict GAP: untyped, true only in the preimage reading, and not connected to any object in the lemma.**

## 9. The boundary

- **$\lVert W\rVert\ne1$.** Off the sphere the system reads $m_0=4(n-1)\lVert W\rVert^2$, $m_1=-4P(W)$, feasible iff $-(n-1)\lambda_{\max}\lVert W\rVert^2\le P(W)\le(n-1)\lvert\lambda_{\min}\rvert\lVert W\rVert^2$. Both sides have degree 3 under $W\mapsto tW$, so the statement is scale-consistent. Passage C's "$\theta\le(n-1)\lvert\lambda_{\min}\rvert$ at every $W$" needs $\theta$ read as $P(W)/\lVert W\rVert^2$ or unit norm. At $W=0$, $c=0$ and the cone is $\{s=0\}$. The normalisation must be written into L113.
- **Repeated eigenvalues.** $\mathcal K(\lambda)$ depends only on $\lambda_{\min},\lambda_{\max}$, so multiplicities do not change the moment conclusion. They do change the L109-capped conclusion: with $\lambda_{\min}$ of multiplicity $\mu$, the cap binds iff $\mu u<4(n-1)$.
- **Simple $\lambda_{\min}$.** The moment-cone extreme point $\theta=(n-1)\lvert\lambda_{\min}\rvert$ requires $g=4(n-1)e_{\min}$, which L109 forbids for every $n\ge4$ at unit norm (Section 4). So equality in L107 is impossible at a simple $\lambda_{\min}$. This is the edge at which "moment analysis = pinned class" breaks.
- **$\ker W\ne0$.** Atoms at $0$ enter $m_0$ and no $m_j$ with $j\ge1$. Since $\lambda_{\min}\le0\le\lambda_{\max}$ always, the cone is unchanged. The $-W_{\mathrm{CP}^2}$ witness has $\dim\ker W=3$ and the Section 4 argument goes through, with the second atom placed at eigenvalue $0$. Nothing found against L113.
- **Small $n$.** $n=4$ is the smallest admissible dimension. The cap inequality $u\le4(n-2)<4(n-1)$ holds there ($8<12$). The Lean `hn : 2 ≤ n` is looser than needed and harmless.
- **Odd $n$.** No step depends on parity. Nothing found.
- **$n=6+2\sqrt7$.** No step of L113, L107 or L109 has an $n$-threshold. Nothing found.

**Verdict CONFIRMED, with the normalisation to be stated.**

## Withdrawn candidates

- **"The Lean proof of feasible_iff may fail at the degenerate branch."** Located at `by_cases heq`. Exhibit: for $\lambda_{\min}=\lambda_{\max}$, `hlo` and `hhi` force $s=c\lambda_{\min}$, and the one-atom $g$ realises it. The step follows. Withdrawn: no failure exhibits.
- **"hmax is an unused hypothesis in feasible_iff_theta."** Located at the backward `nlinarith`. The right inequality $-4\theta\le4(n-1)\lambda_{\max}$ needs $\lambda_{\max}\ge0$ (with $\theta\ge0$, $n\ge1$). Withdrawn: the hypothesis is used.
- **"$m_0$ uses (C)."** Section 2 shows (A) and (B) suffice. Withdrawn.
- **"$m_1$ uses (A)."** Section 2 shows (B) and the cubic identity suffice. Passage B's "both from (A) and (B)" is collective and correct. Withdrawn.
- **"The elimination claim fails when several moments are free."** Section 1's proof holds for any finite family and any $d$. Withdrawn, recorded only as the arity note.

## The falsifying object, and the search for it

**For the sound reading R3.** A falsifier is a spectrum $\lambda$ and a family of inequalities valid on every $g\ge0$ supported in the spectrum such that eliminating $m_2,\dots,m_d$ yields a bound on $\theta$ strictly stronger than $-(n-1)\lambda_{\max}\le\theta\le(n-1)\lvert\lambda_{\min}\rvert$. The two-atom witness realises every $\theta$ in that range with every valid inequality satisfied, so no falsifier exists. Diagonal, padded ($\ker W\ne0$), sphere-product and $\mathrm{CP}^m$ spectra all have $\lambda_{\min}<0<\lambda_{\max}$ and fall under the same witness.

**For the stated passage.** The falsifier of "moment analysis of $g$ is the pinned class" and of "the only sources are Jacobi and Bianchi" is a pinned-system constraint that $g$-positivity and support do not see and that changes the conclusion. L109 at a spectrum with simple $\lambda_{\min}$ is one, and $-W_{\mathrm{CP}^2}$, spectrum $a(-2,1,1,0,0,0)$, excludes $\theta\in(3a,6a]$ in closed form. I looked for it by reading Passage E against Passage A's scope. The witness is a relaxation-level statement at a realised spectrum, which is the level at which Passage A speaks. It is not a claim about the actual $\theta$ of $-W_{\mathrm{CP}^2}$.

## Overall verdict

**GAP.**

- The block is a moral with an undefined class, no definitions and no proof. The provable content (Section 1, the projection onto $(m_0,m_1)$ is the two-sided cone, so eliminated conclusions are no stronger than L107 and its mirror) is true, and `feasible_iff` proves its LP core.
- "Moment analysis = pinned class", "extension of F42" and "the only sources are Jacobi and Bianchi, the single open door" are refuted as stated. L109 is a pinned-system constraint that positivity and support miss, strictly sharper at simple $\lambda_{\min}$, and F42 is withdrawn.
- Hypotheses to write in: unit norm, $\theta\ge0$ for the one-sided form, $\mathop{\mathrm{tr}}W=0$, $n\ge4$, and the scope "valid for every $g\ge0$ supported in the spectrum".
- [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) is unrelated to the claim. [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) is correct as algebra and decoupled from Weyl tensors.
