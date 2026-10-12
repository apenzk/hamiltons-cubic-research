# Review r666, Lemma L115, $\lambda_{\max}(M)=\theta$ at every global maximiser, with $\theta\ge\max_\alpha\lambda_\alpha$ there

**Verdict: GAP.** The equality is very probably true and it is *not proved by the argument given*. [Lemma L24](../findings/second-order.md) constrains the Rayleigh quotient of $L_e$ on $W^\perp$ **inside $\mathcal W_n$**; the space $\mathcal D$ that $\lambda_{\max}(M)$ maximises over is the eigenframe-diagonal operators on $\Lambda^2$, and **that space is not inside $\mathcal W_n$**, $v_\alpha\otimes v_\alpha$ has trace $1$ while every Weyl operator is trace-free. So on all but a small subspace of the directions the claim quantifies over, L24 says nothing. Three further results: the **free** half of the equality is stronger than the block states (criticality gives $M\lambda=\theta\lambda$ outright, not $\lambda_{\max}(M)\ge\theta$); the quantifier should be **local** maximiser, not global; and the second clause is **strict**, with an exact closed-form gap this file's own [L110](../findings/bounds-relaxations.md) already supplies. Against that, **B3's target as the block states it ($\sup_W\lambda_{\max}(M)\le\theta_0$), is FALSE at every $n\le11$** on the record's own catalogue, and the corrected form sits in another file, in an unnumbered twin of this very block that was never cross-referenced.

Reviewer B of an independent pair on identical briefs. **Analysis only: nothing below was computed.** Every number, $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$, $\operatorname{spec}M=\{\pm\sqrt{3/2},0^{\times4}\}$ at $n=4$, the padding block's $\{0,\tfrac1{\sqrt6},-\tfrac1{2\sqrt6}^{\times2}\}$ at $n=6$, $\theta-\lambda_{\max}=\tfrac{\sqrt6}6$, is derived by hand from $\mathfrak{so}(4)\subset\mathfrak{so}(6)$ structure constants and checked against three figures already on the record ($\theta=\sqrt{3/2}$, the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2=2$, and $\lambda_{\max}(M)=0.809017$ at the $C_5$ blow-up).

**Reading convention used throughout.** A `####` heading owns the prose from itself to the next `####`; a `##` section contains its subordinate `####` blocks. Both conclusions below that depend on this are stated under both readings.

---

## 0. Which $M$, the brief's first question

**A fourth sense, and the block never says so.** [conventions.md](../findings/conventions.md) tables two: $M(n)$, the global maximum of $P$ on the unit sphere, and $M$ (or $K$), the $n\times n$ **sectional** matrix, with the standing warning that *"the letter $M$ carries two objects, and their norms differ by $\sqrt2$"*. [L119](../findings/bounds-relaxations.md), 24 lines below L115 in the same file, uses a third, the scalar $M=24$ at the $C_5$ blow-up. **L115's $M$ is none of these.** It is

$$M_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma,\qquad T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2,$$

the $N\times N$ symmetric matrix, $N=\binom n2$, that turns the cubic into a quadratic form: $P(W)=\langle\lambda,M\lambda\rangle$ in $W$'s own eigenbasis. **Its definition is in [second-order.md](../findings/second-order.md), in the block *"$P$ is a Rayleigh quotient, and $\theta$ is an eigenvalue of its own matrix"*, and L115's block cites neither that block nor that file.** What stands in for a definition here is the preceding `####` block *"What $M$ actually is"*, which gives the variational form and not the matrix; a reader who starts at L115's heading has a bare $M$ two headings after $M=24$ meant something else.

**$\operatorname{diag}M=\lambda$**, asserted in the block and true: $T$ vanishes whenever two indices coincide ([conventions.md](../findings/conventions.md)), so the correction term dies on the diagonal. Uncited, one line, correct.

**And $\mathcal D$ is undefined and collides.** The display at [:272](../findings/bounds-relaxations.md#L272) writes $\lambda_{\max}(L_e|_{\mathcal D})$. [conventions.md](../findings/conventions.md) tables $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$, the *vertex matrices of coordinate-diagonal Weyl operators*, an $n\times n$ space, all of whose members are Weyl. The $\mathcal D$ meant here is the $\binom n2$-dimensional space of $\Lambda^2$ operators diagonal in $W$'s eigenframe, **almost none of whose members are Weyl.** The difference between those two spaces is exactly where this lemma's proof fails.

---

## 1. The derivation

### 1.1 What is free, and it is more than the block claims

For any unit $W$ and any choice of eigenframe, put $X=\sum_\alpha x_\alpha\,v_\alpha\otimes v_\alpha$, so that $\lVert X\rVert=\lVert x\rVert$ and $\langle x,Mx\rangle=\langle W,Q(X)\rangle=\langle L_WX,X\rangle$. Taking $x=\lambda$ gives $X=W$ and

$$\langle\lambda,M\lambda\rangle=\langle W,Q(W)\rangle=P(W)=\theta,$$

so $\lambda_{\max}(M)\ge\theta$ **at every unit $W$ whatever**, no criticality, no maximality, no Bianchi. That is the direction [post F15](../findings/bounds-relaxations.md) already uses.

**At a critical point it is strictly better than that, and the block understates it.** $Q(W)=\theta W$ is diagonal in the eigenbasis, so $M\lambda=\theta\lambda$ **exactly**: $\theta$ is an eigenvalue of $M$ with $\lambda$ as eigenvector, not merely a Rayleigh value. [second-order.md](../findings/second-order.md) states this ("*at a critical point $\theta$ is already an eigenvalue of $M$, not merely bounded by one*"). L115's block, which is the child of that block by 50 minutes of git history, does not carry it, and it is what makes the lemma's content precise:

> **L115 says: at a maximiser, the eigenvalue $\theta$ of $M$ is the top one.** The content is one inequality, $\lambda_{\max}(M)\le\theta$; everything else is free.

### 1.2 The content half, and where it breaks

The block's step is: L24 caps every eigenvalue of $L_e$ off $W$ at $\tfrac12$, hence $\lambda_{\max}(L_e|_{\mathcal D})=1$, hence $\lambda_{\max}(M)=\theta\cdot1$.

The shape of that argument is right. Split a unit $X\in\mathcal D$ as $X=aW+Z$ with $Z\in\mathcal D\cap W^\perp$ and $a^2+\lVert Z\rVert^2=1$. Since $L_eW=W$ and $L_e$ is self-adjoint, the cross term is $2a\langle Z,W\rangle=0$ and

$$\langle L_eX,X\rangle=a^2+\langle L_eZ,Z\rangle\le a^2+c\,(1-a^2),$$

for any constant $c$ bounding the quotient on $\mathcal D\cap W^\perp$. With $c\le1$ this is $\le1$, attained only at $a^2=1$, i.e. $X=\pm W$; multiplying by $\theta$ gives $\lambda_{\max}(M)=\theta$ attained at $x=\pm\lambda$. Two observations before the objection:

- **The needed constant is $1$, not $\tfrac12$.** The derivation spends a $\tfrac12$ where a $1$ would do, so it has a factor-two cushion, which matters below, because whatever repairs the gap need only reach $1$.
- **"$1$ simple" is used, but it is not an extra input.** L24's own text derives simplicity *from* the $\tfrac12$ cap ("*the bound gives it at once*"). What the argument here actually needs is that no direction of $\mathcal D\cap W^\perp$ reaches the $1$-eigenvalue, which is the same cap read on a different subspace. So: simplicity is used, at the attainment step, and it is a restatement of the cap rather than a second ingredient.

**The objection. $\mathcal D\not\subseteq\mathcal W_n$, and L24 lives inside $\mathcal W_n$.** L24 is the second-order condition for $P$ restricted to the unit sphere **of $\mathrm{Weyl}_n$**; its conclusion $\langle L_eZ,Z\rangle\le\tfrac12\lVert Z\rVert^2$ is a statement about $Z\in\mathcal W_n\cap W^\perp$ and about nothing else. But

$$\operatorname{tr}(v_\alpha\otimes v_\alpha)=1\ne0=\operatorname{tr}(\text{any Weyl operator}),$$

so no basis direction of $\mathcal D$ is Weyl, and $\mathcal D\cap\mathcal W_n$ is cut out of the $\binom n2$-dimensional $\mathcal D$ by trace-freeness (1 condition), Ricci-flatness ($\binom{n+1}2$) and the first Bianchi identity ($\binom n4$, already more conditions than $\dim\mathcal D$ from $n=7$ up). **The maximisation defining $\lambda_{\max}(M)$ ranges over the whole of $\mathcal D$; maximality of $W$ constrains it only on $\mathcal D\cap\mathcal W_n$.** The step as written applies a hypothesis outside the space where it holds.

This is not the pedantic version of the objection. What L24 legitimately delivers here is

$$\lambda_{\max}\big(M\big|_{\mathcal D\cap\mathcal W_n}\big)=\theta\quad\text{at every local maximiser,}$$

and the record nowhere computes $\dim(\mathcal D\cap\mathcal W_n)$ at any point. **Where that dimension is $1$ the restricted statement degenerates to the free inequality of §1.1 and carries no content at all.** At padded $W_{\mathbb{CP}^2}$ in $n=4$ it is $4$ (diagonal trace-free on $\Lambda^+$ plus the same on $\Lambda^-$, since $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$), so there the restricted statement has three directions of real content, and the full statement needs three more that L24 cannot reach.

### 1.3 The claim itself checks at both maximisers the record knows

Derived by hand, not measured. At $n=4$, take the self-dual frame $v_1^+=(\varphi_{12}+\varphi_{34})/\sqrt2$, $v_2^+=(\varphi_{13}+\varphi_{42})/\sqrt2$, $v_3^+=(\varphi_{14}+\varphi_{23})/\sqrt2$ and its anti-self-dual twin. From $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{bd}\varphi_{ac}-\delta_{ac}\varphi_{bd}+\delta_{ad}\varphi_{bc}$ one gets $[v_1^+,v_2^+]=-\sqrt2\,v_3^+$ and $[v^+,v^-]=0$, hence $T=2$ on each SD triple and $\sum_\gamma T_{\alpha\beta\gamma}=2$, the pair cap of [conventions.md](../findings/conventions.md), attained, which is the control this construction had no freedom to pass. With $W=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ ([second-order.md](../findings/second-order.md)'s own entries) the formula of §0 gives $M=0_{3\times3}\oplus\tfrac1{\sqrt6}\begin{pmatrix}-1&2&-1\\2&-1&-1\\-1&-1&2\end{pmatrix}$, whose spectrum is $\{\sqrt{3/2},\,0^{\times4},\,-\sqrt{3/2}\}$ with top eigenvector $\lambda$. So $\lambda_{\max}(M)=\theta=\sqrt{3/2}$ ✓, and $P(W)=\sqrt{3/2}$ falls out of the same computation as a check on the normalisation.

At $n=6$ the padding contributes two $4\times4$ blocks $\{(i5)\}$ and $\{(i6)\}$, $i\le4$ (the mixed generators), with all other cross-blocks vanishing because $[\varphi_{ij},\varphi_{k5}]$ and $[\varphi_{i5},\varphi_{j6}]$ carry no self-dual component. Each block is $-u(J-I)+3uP$ with $u=\tfrac1{4\sqrt6}$ and $P$ the pairing $(1\,4)(2\,3)$, spectrum $\{0,\,4u,\,-2u,-2u\}=\{0,\,\tfrac1{\sqrt6},\,-\tfrac1{2\sqrt6}^{\times2}\}$. Every value is below $\sqrt{3/2}$, so $\lambda_{\max}(M)=\theta$ at $n=6$ too. **Both of these are maximisers on the record's own values**, [conventions.md](../findings/conventions.md) gives $M(4)=M(6)=\sqrt{3/2}$, attained by padded $W_{\mathbb{CP}^2}$.

Note what the $n=6$ computation shows about the gap: the four directions $\{(i5)\}$ are **not Weyl**, they are orthogonal to $W$, and their Rayleigh quotient reaches $\tfrac1{\sqrt6}/\theta=\tfrac13\le\tfrac12$. L24 could not have told us that, and it happened to be true.

### 1.4 The quantifier is too narrow

**L24's hypothesis is $\mathrm{Hess}\le0$, which is local maximality.** Its scope paragraph reasons about "*a local maximiser with $\theta<0$*", [second-order.md:39](../findings/second-order.md#L39) uses it for a local statement, and [bounds.md:80](../findings/bounds.md#L80) records the standing trap in the other direction, that L24 is *not* a fact about critical points. So everything L115 derives holds **at every local maximiser**, and "at every global maximiser" is an under-claim, not an error. The distinction is live rather than cosmetic: the objects the programme actually has to exclude are local maxima above $\Theta_n$, and as written L115 says nothing about them.

The record also fixes where the true boundary lies. [second-order.md](../findings/second-order.md) reports $\lambda_{\max}(M)=\theta$ *across the whole catalogue* except the $C_5$ blow-up, where $\lambda_{\max}(M)=0.809017$ against $\theta=0.670820$, and the $C_5$ blow-up is precisely a critical point that fails L24 ($\lambda_{\max}(L_e|_{W^\perp})=1.206011$, and $1.206011\times0.670820=0.809017$, which reproduces that figure by hand). **So the property holds far beyond maximisers and is not implied by criticality; local maximality is the hypothesis that fits the evidence, and it is the one the argument uses.**

### 1.5 Hypotheses, stated as the brief asks

| hypothesis | where it enters | droppable? |
|---|---|---|
| $\lVert W\rVert=1$ | $M$ is linear in $W$ and $\theta$ is scale-free, so both clauses read $\lambda_{\max}(M)=s\theta$ at $\lVert W\rVert=s$ | **no**, both clauses are false off it, and the block states it only through the word "maximiser" |
| $W\in\mathcal W_n$: Bianchi, Ricci-flat, trace-free | places the variation inside $\mathcal W_n$, which is what L24 is about; $\operatorname{tr}W=0$ also forces $\lambda_{\min}<0$, used for strictness in §2 | no |
| criticality $Q(W)=\theta W$ | gives $M\lambda=\theta\lambda$ and $L_eW=W$, hence the splitting | no |
| $\mathrm{Hess}\le0$ (local maximality) | the only place L24 enters | no, this is the content |
| $\theta>0$ | dividing by $\theta$; automatic at a local maximiser by L24's scope | no, but free |
| **Bianchi for the deformation $Z$** | **missing**, assumed by the step, false for most of $\mathcal D$ | this is the gap |

---

## 2. The second clause, CONFIRMED, and it is strict, and it needs less than the block spends

**As derived in the block:** $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)\ge M_{\alpha\alpha}$ for a symmetric matrix, so $\lambda_{\max}(M)=\theta$ gives $\theta\ge\max_\alpha\lambda_\alpha$. Formally correct, **and it inherits the whole of §1.2's gap**, because the test vector is $x=e_\alpha$, i.e. $X=v_\alpha\otimes v_\alpha$, which is the single most emphatically non-Weyl direction in $\mathcal D$ (trace $1$). As routed through L115, the second clause is exactly the part of the claim L24 cannot support.

**The normalisation, which the brief is right to flag.** $\lambda_\alpha$ has degree $1$ in $W$ and $\theta=P(W)/\lVert W\rVert^3$ has degree $0$, so "$\theta\ge\max_\alpha\lambda_\alpha$" is a statement *only* at $\lVert W\rVert=1$, under the record's operator normalisation $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$ ([conventions.md](../findings/conventions.md)). The block names no normalisation; it is carried silently by "maximiser". This is the same slip [r613](REVIEW_r613.md)/[r614](REVIEW_r614.md) charged against [L119](../findings/bounds-relaxations.md) 24 lines below, where the unit-norm hypothesis was dropped in the sentence widening the scope.

**A clean derivation that avoids the gap entirely, from this file's own L110.** At a critical point, $Q(W)=\theta W$ read on the diagonal is $\lambda_\gamma^2+(W^\#)_{\gamma\gamma}=\theta\lambda_\gamma$, and [L110](../findings/bounds-relaxations.md) records $Q_\gamma=2(W^\#)_{\gamma\gamma}$. Hence for every $\gamma$ with $\lambda_\gamma>0$

$$\boxed{\ \theta-\lambda_\gamma=\frac{Q_\gamma}{2\lambda_\gamma}=\frac{(W^\#)_{\gamma\gamma}}{\lambda_\gamma}\ }\qquad Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}.$$

Since $\operatorname{tr}W=0$ forces $\lambda_{\max}>0$, the second clause is **equivalent, at every critical point, to $Q_\gamma\ge0$ on the top row**, no maximality, no L24, no non-Weyl directions. Checked at padded $W_{\mathbb{CP}^2}$: the top row is $v_3^+$, $Q_\gamma=2\lambda_1\lambda_2T=2\cdot\tfrac16\cdot2=\tfrac23$, so $\theta-\lambda_{\max}=\tfrac{2/3}{2\cdot2/\sqrt6}=\tfrac{\sqrt6}6=0.408248$, against $\sqrt{3/2}-\tfrac2{\sqrt6}=1.224745-0.816497$ ✓.

**Is it strict? Yes at every maximiser, and the block writes $\ge$.** Two independent routes:

- From the equality clause: $\theta=\lambda_\alpha$ would make $x=e_\alpha$ a top eigenvector of $M$, i.e. would put $v_\alpha\otimes v_\alpha$ at Rayleigh quotient $1$; §1.2's attainment analysis puts $1$ only at $X=\pm W$, so $W$ would be $\pm v_\alpha\otimes v_\alpha$, rank one, impossible for a trace-free $W\ne0$.
- From the boxed identity: strictness $\iff Q_{\gamma}>0$ on the top row $\iff(W^\#)_{\gamma\gamma}>0$ there.

**Where equality could occur:** exactly at critical points whose top eigenrow has $Q_\gamma=0$, i.e. whose $T$-support pairs the other eigenvalues so that $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$ cancels. No catalogued point does ($\tfrac23$ at padded $W_{\mathbb{CP}^2}$) and the first route rules it out at maximisers outright. **Recommend the heading read $\theta>\max_\alpha\lambda_\alpha$.**

---

## 3. "That settles what the route is worth", the route survives, one sentence in it does not

**Which route.** B3, the Rayleigh route: bound $\theta$ by proving $\sup_W\lambda_{\max}(M)\le\theta_0$. It is named nowhere in the block except as the bare string "B3's target as posed", and **[routes.md](../routes.md) contains no B3** (zero matches) although [plan.md:218](../plan.md#L218) lists B3 among the retired items and says *"every closure with its reason and clearance criterion is in [routes.md](../routes.md) and [findings/INDEX.md](../findings/INDEX.md)"*. [findings/INDEX.md](../findings/INDEX.md) has no B3 either. **The pointer chain for this route's closure is broken at both ends.**

**Does the block commit the non sequitur the brief warns about? No.** *"Equality at the maximiser, therefore no escape"*, refuted in [L110](../findings/bounds-relaxations.md)'s own block 60 lines above, is not the move made here. The conclusion drawn is the narrower and correct one: B3's pointwise target coincides with Conjecture A at the maximiser, so **the route is no shortcut**, its identities stand, and the report's copy says so in the same words ("*retired as a shortcut; its identities stand*"). No claim is made that a proof cannot come this way. Credit where due: this is the one block of the three I read today that stops at the right place.

**And the closure does not need the gapped half.** Reading the logic:

- **"No easier"** (B3's pointwise statement implies Conjecture A), follows from the **free** inequality $\theta\le\lambda_{\max}(M)$ of §1.1 alone.
- **"Neither easier nor harder"** (the equivalence), needs $\lambda_{\max}(M)\le\theta$, which is exactly what §1.2 finds unproved.

**So the route verdict is citable and the equivalence is not.** That is the separation the brief asks for, stated plainly: *the equality is unproved; the conclusion that B3 is no shortcut does not depend on it.*

### 3.1 The target constant is wrong at every $n\le11$, and wrong in the other direction at odd $n\ge13$

This is the block's most serious defect after §1.2, and it is decidable by hand from values already on the record.

$\lambda_{\max}(M)\ge\theta$ at every unit Weyl $W$, so $\sup_W\lambda_{\max}(M)\ge M(n)$. [conventions.md](../findings/conventions.md) gives $M(n)\ge\sqrt{3/2}=1.224745$ at every $n\ge4$, from padded $W_{\mathbb{CP}^2}$. Against $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$:

| $n$ | 4 | 6 | 8 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|
| $\theta_0(n)$ | $0.866025$ | $1.054093$ | $1.145644$ | $1.200000$ | $1.219718$ | $1.236033$ |
| $\sup_W\lambda_{\max}(M)\ge$ | $1.224745$ | $1.224745$ | $1.224745$ | $1.224745$ | $1.224745$ | $1.236033$ |

**So "$\sup_W\lambda_{\max}(M)\le\theta_0$" is false at every $n\le11$**, and the block asserts it with no dimension qualifier. [second-order.md](../findings/second-order.md), the parent block, §5.2 below, says the correct thing: the supremum is $\max(\sqrt{3/2},\theta_0(n))$, measured at $n=6,8,10$, *"From $n=12$ the ordering reverses"*, and its conclusion is scoped **"then for $n\ge12$"**. The numbered block dropped the scope its own parent carried. This is the same shape as [problem.md:485](../findings/problem.md#L485)'s standing note that *"Conjecture A means its $n\ge12$ clause alone"*, and as the $\mathbb{CP}^2$ exception clause at $8\le n\le11$.

**And at odd $n\ge13$ the constant is the wrong one entirely.** [conventions.md](../findings/conventions.md) and [problem.md:474](../findings/problem.md#L474) both record that Conjecture A concludes at $\Theta_n$, which equals $\theta_0(n)$ **at even $n$ only**, with $\Theta_n<\theta_0(n)$ at odd $n$. So at odd $n\ge13$, "$\sup\lambda_{\max}(M)\le\theta_0$" does **not** imply Conjecture A and the block's *"strictly stronger than Conjecture A"* fails in that direction. problem.md has already paid for exactly this substitution once ("*THE CONSTANT WAS THE EVEN-$n$ EVALUATION OF THE RIGHT ONE*"); L115's block reintroduces it.

**Finally, "strictly stronger" is under-witnessed even at even $n\ge12$.** The witness offered is the $C_5$ blow-up "carrying ratio $1.206$ while its $\theta$ sits far below $\theta_0$", but $\lambda_{\max}(M)=0.809017$ there against $\theta_0(10)=1.2$, so that point satisfies the B3 target comfortably and separates nothing. It witnesses that the *pointwise* inequality $\theta\le\lambda_{\max}(M)$ is slack off maximisers, which is a different statement. To witness that the sup-statement is strictly stronger one needs a unit **Weyl** $W$ with $\lambda_{\max}(M)>\theta_0(n)$ at some $n\ge12$, and the record has none: [post F15](../findings/bounds-relaxations.md)'s $52\%$ overshoot is at an LP feasible point, and that block says in its own sentence that *"the whole overshoot sits at spectra that are not Weyl spectra"*.

---

## 4. Scope, what consumes L115

**Nothing.** Outside its own block, "L115" appears in [findings/](../findings/) only in [bounds-relaxations.md:5](../findings/bounds-relaxations.md#L5)'s holdings line, [INDEX.md:43](../findings/INDEX.md#L43) and [INDEX-results.md:133](../findings/INDEX-results.md#L133). Its one substantive consumer is the twin paragraph in [report/sections/07-gradedness-split.tex:1293](../report/sections/07-gradedness-split.tex#L1293). **[post F15](../findings/bounds-relaxations.md), which sits in the same `##` section and is the nearest thing to a consumer, uses only the free inequality** (*"Since $\lambda_{\max}(M)\ge\langle\lambda,M\lambda\rangle$ at unit $\lambda$"*) so it needs neither the equality nor the second clause. **Blast radius of the gap: the report paragraph, and the "neither easier nor harder" half of the route verdict. Nothing else.**

**Indexing.** [INDEX-results.md:133](../findings/INDEX-results.md#L133) carries L115 as *"Gate 2: no verdict on the record"*, accurate, and this review is the first (paired with r665). [results.md](../results.md) carries no L115 row; that is the file-wide backlog already charged by [r574](REVIEW_r574.md#L170) and [r614](REVIEW_r614.md#L198) for L104, L105, L107, L109, L110, L114, L115, L116, L119, and is **not charged here**.

---

## 5. Provenance, duplication, pointers

### 5.1 Provenance, the one self-historical claim is FALSE as placed

The `##` section holding L115 closes at [:286](../findings/bounds-relaxations.md#L286) with *"Re-filed here 2026-09-02 from [second-order.md](../findings/second-order.md) by the parallel sort of findings/."* Checked with `git log -S` on four distinct strings from the section (the L115 sentence, the F15 sentence, the "maximal abelian subspace" definition, the closing degenerate-point paragraph). **Every one returns the same trail, and second-order.md is not on it:**

| commit | date | file |
|---|---|---|
| dd1fec71 `feat(conjecture-a): the Rayleigh bound is L_W on the commutant, and it is tight at the maximiser` | 2026-08-23 09:17 | FINDINGS.md |
| 51ab61f8 `refactor(findings): split the record into an index and one file per subject` | 2026-08-24 | findings/live-front.md |
| ea7c61c4 `docs(findings): split the live front in three` | 2026-08-26 | findings/bounds.md |
| 2d66938e `refactor(findings): bounds.md splits by the question each part answers` | 2026-09-02 | findings/bounds-relaxations.md |

**So the claim is false under the reading that the trailer closes its section, and false under the reading that it closes only the paragraph above it**, the degenerate-point paragraph has the identical trail.

**The mechanism, which makes this a formatting defect rather than a fabrication.** The very next section, [:289–290](../findings/bounds-relaxations.md#L289), opens with its own line *"From findings/second-order.md. Belongs in bounds.md because…"*; the section after it opens with *"From findings/target.md"*, and the trailer at [:301](../findings/bounds-relaxations.md#L301) above it says *"from target.md"*. **Each trailer states the provenance of the section BELOW it.** They are headers printed as footers, one section out of step. Consequence for L115: **the F15/L116/L115 section carries no provenance line of its own, and the line a reader will attach to it belongs to someone else.** The 15 surviving copies of this boilerplate should be re-read with that offset in mind.

**One provenance fact worth adding rather than removing.** The origin commit's own message ends *"Gate 2 pending: no reviewer agents were spawned this cycle"*, and the number L115 was placed on this prose ten days later by c14052fc `docs(bounds): place headings for Lemmas L107-L119`. **The heading was written by a numbering pass over unreviewed prose**, which is exactly why "at every global maximiser" and the missing $n\ge12$ scope were never caught.

### 5.2 Duplication, two twins, and the unnumbered one is the better text

- **[second-order.md](../findings/second-order.md), *"$P$ is a Rayleigh quotient, and $\theta$ is an eigenvalue of its own matrix"*.** The parent, c9d28816, 2026-08-23 08:27, **fifty minutes before** L115's own commit. It carries the definition of $M$, the stronger $M\lambda=\theta\lambda$, the catalogue evidence, the $C_5$ exception, and the **correct** supremum $\max(\sqrt{3/2},\theta_0(n))$ with its $n\ge12$ scope. The 2026-09-02 split sent parent and child to different files. **Neither cross-references the other, and the numbered one is the weaker and, on the target constant, the wrong one.** This is precisely the pattern the brief names, except that here it is the *twin* that is right and the *numbered* block that needs correcting.
- **[report/sections/07-gradedness-split.tex:1293](../report/sections/07-gradedness-split.tex#L1293).** An unnumbered prose copy of L115 carrying the identical L24 step (*"By Lemma 24 every eigenvalue off $W$ is $\le\tfrac12$ at a global maximizer, so $\lambda_{\max}(M)=\theta$ there exactly"*) and the identical $\theta_0$ target. **It inherits both defects and must be corrected with the block.**

### 5.3 Pointers

| pointer | resolves? |
|---|---|
| "Lemma L24" at [:272](../findings/bounds-relaxations.md#L272) | **bare text, no link**, in a file that links its lemmas elsewhere; the canonical statement is [second-order.md](../findings/second-order.md) |
| "B3" | **no target**, absent from [routes.md](../routes.md) and [findings/INDEX.md](../findings/INDEX.md), though [plan.md:218](../plan.md#L218) points at both |
| $M$, $\mathcal D$, $\operatorname{diag}M=\lambda$ | undefined in the block; $M$'s definition is in another file, $\mathcal D$ nowhere |
| the block's only two links ([b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py), [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md)) | resolve, but they sit in the paragraph after L115's two sub-blocks and are **L116's** citations, not L115's |

**And L115's body is split across two `####` blocks after its heading**, the second of which (*"The Rayleigh bound is tight where it matters and slack elsewhere"*), carries the lemma's **second clause** under a heading that reads as a route assessment. A reader taking the heading-owns-to-next-heading convention finds the first clause under L115 and the second under something else.

---

## 6. What would close the gap

Stated so the next cycle need not re-derive it. **Analysis, no computation required for (a) or (b).**

- **(a) The cheapest repair, restate the lemma.** Write it as $\lambda_{\max}(M|_{\mathcal D\cap\mathcal W_n})=\theta$, which is what L24 gives, at every **local** maximiser. Then say what §4 establishes: post F15 and the route verdict need only the free inequality, so nothing downstream loses anything. The cost is that the restricted statement may be vacuous wherever $\mathcal D\cap\mathcal W_n=\mathbb RW$, and the record should say at which points it is not, $\dim=4$ at padded $W_{\mathbb{CP}^2}$, $n=4$, computed in §1.2.
- **(b) The full claim needs a bound on the non-Weyl diagonal directions**, and only up to the constant $1$ rather than $\tfrac12$: for unit $Z\in\mathcal D\cap W^\perp$, $\langle L_eZ,Z\rangle\le1$. The factor-two cushion of §1.2 is the room available. Two hand data points exist already: the four mixed-generator directions at padded $W_{\mathbb{CP}^2}$, $n=6$, reach $\tfrac13$ (§1.3), and at the $C_5$ blow-up the maximum over $\mathcal D$ coincides with the maximum over $\mathcal W_n\cap W^\perp$ to seven digits, so the non-Weyl part raises nothing there.
- **(c) What a computation would decide, if one is ever authorised.** Whether $\lambda_{\max}(M|_{\mathcal D\cap\mathcal W_n})<\lambda_{\max}(M)$ at any catalogued critical point. Equal at every point ⟹ the extra directions are inert and (b) is worth attacking; strictly smaller anywhere ⟹ L115 as stated is strictly stronger than L24 can reach and (a) is the only honest form. **I have not run it, and this review does not depend on it.**

---

## 7. Verdicts, itemised

| claim | verdict |
|---|---|
| $\lambda_{\max}(M)\ge\theta$ at a unit $W$ | **CONFIRMED, and free**, no criticality, no maximality |
| $M\lambda=\theta\lambda$ at a critical point | **CONFIRMED**, stronger than the block states, and already on the record in [second-order.md](../findings/second-order.md) |
| $\lambda_{\max}(M)\le\theta$ at a maximiser | **GAP**, L24 is applied on $\mathcal D$, which is not inside $\mathcal W_n$; true at both maximisers the record knows, by hand |
| "at every global maximiser" | **UNDER-CLAIMED**, the argument gives every *local* maximiser |
| "$1$ simple" is the engine | **used**, at the attainment step; it is a restatement of the $\tfrac12$ cap, not a second input |
| $\theta\ge\max_\alpha\lambda_\alpha$ | **CONFIRMED and STRICT**, but as routed it inherits the gap; the clean route is $\theta-\lambda_\gamma=Q_\gamma/(2\lambda_\gamma)$ from [L110](../findings/bounds-relaxations.md), which needs criticality alone |
| unit-norm hypothesis | **unstated**; both clauses are false without it |
| "B3 is no shortcut" | **CONFIRMED**, and it rests only on the free inequality |
| "neither easier nor harder" | **NOT CITABLE** until the gap closes |
| "$\sup_W\lambda_{\max}(M)\le\theta_0$ is B3's target" | **REFUTED at every $n\le11$**, by $M(n)\ge\sqrt{3/2}>\theta_0(n)$ there; the parent block scopes it to $n\ge12$ and this one dropped the scope |
| "strictly stronger than Conjecture A" | **fails at odd $n\ge13$** ($\theta_0>\Theta_n$), and is **under-witnessed** at even $n\ge12$, the $C_5$ point offered does not separate the two statements |
| provenance trailer at [:286](../findings/bounds-relaxations.md#L286) | **FALSE as placed**, under both section readings; the trailers in this file are one section out of step |
| duplication | **two twins**, [second-order.md](../findings/second-order.md) (the parent, and the better text) and [report/sections/07-gradedness-split.tex:1293](../report/sections/07-gradedness-split.tex#L1293) (inherits both defects) |
