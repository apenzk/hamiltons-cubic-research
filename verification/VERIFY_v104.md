# Verify v104, L4's generator criterion, the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$, and the clause "None is coordinate-diagonalizable"

**Verifier v104, cold brief.** Target: the text quoted under *"The brief as dispatched"* in [ROUND_L04b.md](ROUND_L04b.md), taken from [ungraded-slack.md](../findings/ungraded-slack.md):119 and :121, together with the canonical form at [results.md](../results.md):116. **No numerical work was done**: no script was run, and every number below is a hand evaluation in exact arithmetic, with the decimal given only as a rounding of a stated rational or surd. Log: [agent_logs/verify-L04-v104.log](../agent_logs/verify-L04-v104.log).

## Claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| C1 | the criterion: $(\Lambda^4\mathbb R^n)^K=0$ **and** $\dim\mathcal W_n^K=1$ $\Rightarrow$ the $K$-invariant $W$ is critical | **TRUE, AND ONE HYPOTHESIS IS INERT**, $\dim\mathcal W_n^K=1$ carries it alone; $(\Lambda^4)^K=0$ is unused, and two hypotheses the block never states are load-bearing |
| C2 | "Every member has just two eigenvalues" | **HYPOTHESIS-DEBT**, no argument on file, and it cannot follow from the criterion's own mechanism |
| C3 | the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$ | **DERIVED, and the derivation is correct**, [L23](../findings/ungraded-slack.md), thirty lines below; rebuilt here in full. It is *not* derived for the family C1 generates |
| C4 | "checked against held-out spaces it was never fitted to" as the stated support | **MISLEADING BUT NOT FALSE**, the block's own offered support is test-point agreement; the derivation exists elsewhere in the same file |
| C5 | "None is coordinate-diagonalizable … the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$" | **BROKEN**, refuted by the family's own stated maximiser at every even $n$, by inspection |
| C6 | "for the Lie-group members that is proven rather than numerical" | **TRUE for the bi-invariant simple members**, on a rank argument; the isotropy-irreducible members have no argument on file |
| C7 | the maximum $n(n-2)/4$ "attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$" | **QUANTIFIER MISSING**, attainment needs $n$ even; the bound holds at every $n$ |
| C8 | "zero-padding preserves everything, so they persist into $n=12$" | **SCOPE DEFECT**, padded objects satisfy neither the criterion's hypothesis nor the closed form; exhibited at $SU(3)$, $0.836660$ against $0.502865$ |
| C9 | $\theta$ "increases with $\dim\mathfrak h$" | **TRUE at fixed $n$ only**; the block states it unqualified |
| C10 | [results.md](../results.md):116, read alone: "a new, provably non-diagonalizable family" | **BROKEN, and uncorrected at the citation site**, the record's own correction sits in two other files |

**One line.** The criterion is true and provable from strictly less than it assumes; the closed form is genuinely derived and I rebuilt it; and the non-diagonalizability clause is false at the very object the block names as the family's maximiser, in a form a reader can see without arithmetic.

**Verdict: BROKEN**, for the block as a whole, on C5/C10. The criterion alone (C1) and the closed form alone (C3) are citable; the paragraph containing them is not.

## 0. Conventions, fixed once

Read from [conventions.md](../findings/conventions.md), not from memory.

- $\mathcal W_n$ is the space of algebraic Weyl operators on $\Lambda^2\mathbb R^n$; $Q(W)=W^2+W^\#$ is Hamilton's quadratic map, sending $\mathcal W_n$ to itself ([conventions.md](../findings/conventions.md):15); $P(W)=\langle W,Q(W)\rangle$ (:16); $\theta=P(W)/\lVert W\rVert^3$ (:17).
- **"Critical point" means $Q(W)=\theta W$** on $\{\lVert W\rVert=1\}$ ([conventions.md](../findings/conventions.md):119). The weaker bracket form $[W,Q(W)]=0$ is a different statement and is not what the block claims.
- **"Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$**, explicitly *not* diagonal as an operator on $\Lambda^2\mathbb R^n$ ([conventions.md](../findings/conventions.md):53). This is the sense C5 must be read in, and it is the sense that makes C5 checkable by inspection.
- $N=\binom n2$, $r=\dim\mathfrak h$, $\mathfrak m=\mathfrak h^\perp$ in $\mathfrak{so}(n)=\Lambda^2\mathbb R^n$, $\kappa=2(n-2)$ the Killing constant, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ in an orthonormal basis of $\mathfrak{so}(n)$; $c_{abc}$ is totally antisymmetric, so $c_{abc}^2$ is totally symmetric. $S_{XYZ}$ denotes $\sum c_{abc}^2$ over $a\in X$, $b\in Y$, $c\in Z$.
- Sources consulted in [references/](../references/): [fox-2019-nonassociative-curvature-algebra](../references/fox-2019-nonassociative-curvature-algebra/notes.md) (the Weyl tensors form an algebra under the product whose cubic form is $P$, this is the $Q$-closure of $\mathcal W_n$), and [wolf-1968-isotropy-irreducible](../references/wolf-1968-isotropy-irreducible/notes.md).

## 1. Hypothesis inventory

### 1.1 What the block's criterion states

> "If $K\subseteq SO(n)$ satisfies $(\Lambda^4\mathbb R^n)^K=0$ and $\dim\mathcal W_n^K=1$, the $K$-invariant $W$ is a critical point automatically, by equivariance"

Stated hypotheses: **(H1)** $K\subseteq SO(n)$; **(H2)** $(\Lambda^4\mathbb R^n)^K=0$; **(H3)** $\dim\mathcal W_n^K=1$.

### 1.2 What the argument "by equivariance" actually consumes

The three-line argument the words point at is: $Q$ is $O(n)$-equivariant $\Rightarrow$ $Q$ is $K$-equivariant $\Rightarrow$ $Q(\mathcal W_n^K)\subseteq\mathcal W_n^K$, and by (H3) that space is $\mathbb R W$, so $Q(W)=\theta W$ with $\theta=\langle W,Q(W)\rangle=P(W)$ at $\lVert W\rVert=1$.

That consumes **(H3)** and two further hypotheses **the block never states**:

- **(H4) $Q$ is $O(n)$-equivariant.** True, $W\mapsto W^2$ is conjugation and $W\mapsto W^\#$ is built from the $\mathrm{Ad}$-invariant structure constants of $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$. On the record at [conventions.md](../findings/conventions.md):41(ii).
- **(H5) $\mathcal W_n$ is $Q$-closed.** Without it $Q(W)$ need not lie in $\mathcal W_n$ and (H3) says nothing about it. This is Fox's theorem; the source **is** in [references/](../references/) and I read it, [fox-2019-nonassociative-curvature-algebra/notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md):7 states that the Weyl curvature tensors form an algebra whose cubic form is exactly this project's $P$, which is the closure statement. The block cites nothing for it.

**(H1) is used only through (H4)**, and weakly: (H4) holds for $K\subseteq O(n)$ just as well, so $K\subseteq SO(n)$ is a needless restriction. §6.3 shows that restriction actually bites at the family's own maximiser.

### 1.3 (H2) is unused, Question 1 answered

**$(\Lambda^4\mathbb R^n)^K=0$ appears in the statement and nowhere in the argument.** It is:

- **not used**: the derivation above never mentions $\Lambda^4$;
- **not necessary**: the record holds a counterexample. Take $K=U(m)\subset SO(2m)$. Then $\omega\wedge\omega\ne0$ for $m\ge2$ with $\omega$ the Kähler form, so $(\Lambda^4\mathbb R^{2m})^{U(m)}\ne0$ and (H2) fails. Yet [L28](../findings/nondegeneracy.md):504 states, and proves by the $GL_m\subset O_{2m}$ branching rule at $\lambda=(2,2)$, that *"the $\mathfrak u(m)$-invariant line in $\mathrm{Weyl}_{2m}$ is spanned by a critical $W_{\mathbb{CP}^m}$"*, i.e. (H3) holds and the conclusion holds while (H2) fails. **If (H2) were load-bearing, L28 would be false.**
- **not sufficient on its own**: $(\Lambda^4)^K=0$ places a candidate inside $\mathcal W_n$ but says nothing about the dimension of $\mathcal W_n^K$, so it cannot replace (H3).

**What would have to be true for (H2) to be necessary.** It would have to be that $\dim\mathcal W_n^K=1$ fails to force $Q(W)\in\mathcal W_n^K$, i.e. that either (H4) or (H5) fails, since those two plus (H3) give the conclusion outright. Both hold. Alternatively (H2) would be necessary if no $K$ with $(\Lambda^4)^K\ne0$ ever had $\dim\mathcal W_n^K=1$; $U(m)$ refutes that.

**Where (H2) does do work.** In the *other* generator, [L23](../findings/ungraded-slack.md)'s *"Producing members"* paragraph, whose hypotheses are $K$-irreducibility of $\mathfrak h$ and $\mathfrak m$ **with $\mathfrak h\not\cong\mathfrak m$**, $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, and $(\Lambda^4\mathbb R^n)^K=0$. There the candidate $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is an element of $S^2(\Lambda^2)$ that is not yet known to be a Weyl operator, and $(\Lambda^4)^K=0$ makes $\mathrm{Alt}$ of it (a $K$-invariant $4$-form), vanish. **So (H2) is a hypothesis about *producing* $W$, and the block has transplanted it onto a statement about *criticality*, where it is inert.** The block also omits $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, which is what makes the candidate Ricci-flat, and omits the inequivalence $\mathfrak h\not\cong\mathfrak m$, without which Schur gives a *plane* of invariants and (H3) fails.

### 1.4 Hypotheses of every imported result

| imported | where it is used | hypotheses | checked against the object |
| --- | --- | --- | --- |
| $Q$-closure of $\mathcal W_n$ (Fox) | C1 | none beyond $W\in\mathcal W_n$ | holds |
| $O(n)$-equivariance of $Q$ | C1 | none | holds |
| [L23](../findings/ungraded-slack.md)'s closed form | C3 | $\mathfrak h$ a subalgebra, $0<r<N$, $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, **and $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ assumed** | **the block states none of the four**; $0<r<N$ and the two-eigenvalue form are both violated by the padded members the block admits (§5) |
| [L23](../findings/ungraded-slack.md)'s cap $r\le n(n-2)/4$ | C7 | same, plus $S_{\mathfrak{mmm}}\ge0$ | holds where the closed form holds |
| [L28](../findings/nondegeneracy.md) | my §1.3 only | $m\ge3$ | holds |

## 2. Question 2, $\Pi_{\mathfrak h}$ at the family's own maximiser, in the basis $\{e_i\wedge e_j\}$

### 2.1 The claim, located exactly

[ungraded-slack.md](../findings/ungraded-slack.md):119, final sentence:

> "None is coordinate-diagonalizable, and for the Lie-group members that is proven rather than numerical, the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, which is exactly why $S^3\times S^3$ *is* diagonal, so the argument recovers its own boundary case."

And [results.md](../results.md):116:

> "producing a new, **provably non-diagonalizable** family with a closed-form $P$."

### 2.2 The failure, exhibited concretely

Let $n=2p$ be even and let $V_1=\mathrm{span}(e_1,\dots,e_p)$, $V_2=\mathrm{span}(e_{p+1},\dots,e_{2p})$. Take $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(p)$ block-diagonally, which the block's own next paragraph ([ungraded-slack.md](../findings/ungraded-slack.md):121) names as the family's maximiser. Under the identification $\mathfrak{so}(n)=\Lambda^2\mathbb R^n$,

$$\mathfrak h=\Lambda^2V_1\oplus\Lambda^2V_2=\mathrm{span}\{\,e_i\wedge e_j:\ i<j\le p\ \text{ or }\ p<i<j\,\},\qquad \mathfrak m=V_1\otimes V_2=\mathrm{span}\{\,e_i\wedge e_j:\ i\le p<j\,\}.$$

Both summands are spanned by **members of the basis $\{e_i\wedge e_j\}_{i<j}$ itself**. Hence, ordering that basis with the $\mathfrak h$-indices first,

$$\Pi_{\mathfrak h}=\begin{pmatrix}I_r&0\\0&0\end{pmatrix},\qquad W_{\mathfrak h}=c\Big(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\Big)=c\,\mathrm{diag}\Big(\underbrace{\tfrac{N-r}N,\dots}_{r},\ \underbrace{-\tfrac rN,\dots}_{N-r}\Big)$$

is a **diagonal $0/1$ matrix and a diagonal matrix respectively, in the coordinate $2$-plane basis of the standard orthonormal frame**, which is exactly [conventions.md](../findings/conventions.md):53's definition of coordinate-diagonal. Dimensions check: $r=2\binom p2=p(p-1)=\tfrac{n(n-2)}4$, the block's own cap, and $N-r=p^2=n^2/4$.

**So every balanced-split member is coordinate-diagonal, at every even $n$, with no computation and no frame search.** The concrete instances: at $n=6$, $\mathfrak{so}(3)\oplus\mathfrak{so}(3)\cong\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, $r=6$, $N=15$, the case the block carves out as "the lone exception"; at $n=8$, $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, $r=12$, $N=28$; at $n=10$, $r=20$, $N=45$; and so on. **The one-line argument does not distinguish $n=6$ from any other even $n$**, so the exception is not lone, it is the whole balanced tower, of which $n=6$ is the smallest member.

### 2.3 Argue the opposite, the most charitable reading

Three readings were tried and each fails.

- **"Member" excludes the balanced split.** Refuted by the block itself, one sentence later: *"the balanced sphere product is itself a member and the family's maximiser"* ([ungraded-slack.md](../findings/ungraded-slack.md):121). The maximiser of a family is in it.
- **"Coordinate-diagonalizable" means diagonal as an operator on $\Lambda^2\mathbb R^n$ in some eigenbasis**, under which the claim would be about something else. Refuted by [conventions.md](../findings/conventions.md):53, which fixes the coordinate-$2$-plane sense and explicitly warns against exactly this conflation. Under the operator reading the claim would be *vacuously false* for every symmetric operator, so the charitable reading is the coordinate one, and that is the one that fails.
- **"$\mathfrak{su}(2)\oplus\mathfrak{su}(2)$" is shorthand for "the balanced tower".** The words forbid it: *"the lone exception"*, and the reason given is *"which is exactly why $S^3\times S^3$ **is** diagonal"*, a single named space at a single $n$. And the sentence's rhetorical point, *"the argument recovers its own boundary case"*, requires the exception to be isolated; if the whole tower is diagonal there is no boundary case to recover.

**Verdict on C5: BROKEN.** The record already knows: [problem.md](../findings/problem.md):158 carries *"**Some members are coordinate-diagonalizable**, the balanced sphere product is one, and the $3$-block product just named is another (Reviewer 118, correcting this line)."* The correction is in a third file, and neither [ungraded-slack.md](../findings/ungraded-slack.md):119 nor [results.md](../results.md):116 carries it. See §7.

### 2.4 A spillover the record's own replacement claim inherits

[problem.md](../findings/problem.md):158 replaces the false clause with: *"What holds is the weaker statement it was reaching for: their positive eigenspaces contain **no** decomposable bivector at all."* **That replacement is false at the same object.** At the balanced split the positive eigenspace is $E_{\max}=\mathfrak h=\Lambda^2V_1\oplus\Lambda^2V_2$, which contains $e_1\wedge e_2$, decomposable. So the repair, read as a universal over members, fails at the member that refuted the original. I record this and do not repair it; it is true of the bi-invariant simple members (§6.1) and false of the balanced ones.

## 3. Question 3, is the closed form derived or fitted?

**Answer: derived, on file, thirty lines below the block that states it, and the derivation is correct. I rebuilt every step.** The block's own offered support ("checked against held-out spaces it was never fitted to") is test-point agreement and would not carry it; the derivation is at [L23](../findings/ungraded-slack.md), same file, under *"Lemma L23, the conjecture on the subalgebra family, and gradedness as the cap"*.

### 3.1 Setting up, from the definitions

Let $\mathfrak h\subseteq\mathfrak{so}(n)$ be a subalgebra, $r=\dim\mathfrak h$, $0<r<N$, $W=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with eigenvalues $u=c(1-\tfrac rN)$ on $\mathfrak h$ and $v=-c\tfrac rN$ on $\mathfrak m$.

**Unit norm fixes $c$.** $ru^2+(N-r)v^2=c^2\big[r\tfrac{(N-r)^2}{N^2}+(N-r)\tfrac{r^2}{N^2}\big]=c^2\tfrac{r(N-r)}{N^2}\big[(N-r)+r\big]=c^2\tfrac{r(N-r)}N$. So $c=\sqrt{N/(r(N-r))}$ and

$$u=c\,\frac{N-r}N=\sqrt{\frac{N-r}{rN}},\qquad v=-\frac{r}{N-r}\,u,\qquad ru+(N-r)v=0.$$

**The two structure-constant relations.** Since $\mathfrak h$ is a subalgebra and the form is invariant, $c_{abc}=0$ whenever two indices lie in $\mathfrak h$ and one in $\mathfrak m$. Writing $T_3=S_{\mathfrak{hhh}}$, $T_0=S_{\mathfrak{mmm}}$ and $S_{\mathfrak{hmm}}=\sum_{a\in\mathfrak h,\,b,c\in\mathfrak m}c_{abc}^2$, the Killing normalisation $\sum_{b,c}c_{abc}^2=\kappa$ for every $a$ gives, summing over $a\in\mathfrak h$ and over $a\in\mathfrak m$ separately and using total symmetry of $c_{abc}^2$,

$$S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r,\qquad 2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r),$$

which are L23's two relations. *(The factor $2$ in the second is the two placements of the single $\mathfrak h$-index among $b,c$; the $\mathfrak{hh}\mathfrak m$ term is absent for the reason just given.)*

**The two scalar equations.** With $Q(W)=W^2+W^\#$ and $(W^\#)_{aa}=\tfrac12\sum_{b,c}c_{abc}^2w_bw_c$ on a $W$ diagonal in the $\varphi$-basis: for $a\in\mathfrak h$ the $b,c$ sum splits into $(\mathfrak h,\mathfrak h)$ and $(\mathfrak m,\mathfrak m)$ only, and for $a\in\mathfrak m$ into $(\mathfrak m,\mathfrak m)$ and the two mixed placements. Averaging each over its block and imposing $Q(W)=\theta W$ gives exactly L23's pair:

$$u^2+\tfrac1{2r}\big(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2\big)=\theta u,\qquad v^2+\tfrac1{2(N-r)}\big(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2\big)=\theta v.$$

**So the two equations L23 asserts are the block-averaged traces of the eigen-equation, and they follow from $Q=W^2+W^\#$ and the two relations. Checked, not assumed.**

### 3.2 The elimination, carried out

Substitute $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ into the first and $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}$ into the second, multiply by $2r$ and $2(N-r)$, and write $\sigma=1+\kappa/2=n-1$. Using $u-v=u\tfrac N{N-r}$ and $u+v=u\tfrac{N-2r}{N-r}$ and dividing the second by $v\ne0$:

$$(\mathrm A)\quad 2\sigma ru-S_{\mathfrak{hmm}}\,\frac{uN(N-2r)}{(N-r)^2}=2r\theta,\qquad (\mathrm B)\quad -\sigma ru+S_{\mathfrak{hmm}}\,\frac{uN}{N-r}=(N-r)\theta .$$

The claimed solution is $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$. Substituting into (B): $-\sigma ru+2\sigma ru=\sigma ru$, and the right side is $(N-r)\cdot\sigma ur/(N-r)=\sigma ru$. **Equal.** Substituting into (A): $2\sigma ru-2\sigma ru\tfrac{N-2r}{N-r}=2\sigma ru\cdot\tfrac{r}{N-r}$, and the right side is $2r\cdot\sigma ur/(N-r)$. **Equal.** The $2\times2$ system is non-degenerate for $0<r<N$, so this is the solution, not merely a solution.

### 3.3 The closed form itself

$$\theta=\frac{\sigma ur}{N-r}=(n-1)\,\frac r{N-r}\sqrt{\frac{N-r}{rN}}=(n-1)\sqrt{\frac r{N(N-r)}}.$$

That is L23's form written one way. The block writes it as $\tfrac2n\sqrt{rN/(N-r)}$. **The two are identical**, and the identity is exactly $N=\binom n2$:

$$\frac{(n-1)\sqrt{r/(N(N-r))}}{\tfrac2n\sqrt{rN/(N-r)}}=\frac{n(n-1)}{2N}=\frac{n(n-1)}{2\cdot\tfrac{n(n-1)}2}=1 .$$

So C3 is derived. **Two hand checks against the block's own printed values, exact:**

- $\mathfrak h=\mathfrak{su}(3)$ acting on itself, $n=8$, $r=8$, $N=28$, $N-r=20$: $\theta^2=\tfrac4{64}\cdot\tfrac{8\cdot28}{20}=\tfrac1{16}\cdot\tfrac{56}5=\tfrac{7}{10}$, $\theta=\sqrt{7/10}=0.836660\ldots$, printed $0.8367$. ✔
- $\mathfrak h=\mathfrak{sp}(3)\subset\mathfrak{so}(14)$ for $SU(6)/Sp(3)$, $r=21$, $N=91$, $N-r=70$: $\theta^2=\tfrac4{196}\cdot\tfrac{21\cdot91}{70}=\tfrac1{49}\cdot\tfrac{273}{10}=\tfrac{39}{70}$, $\theta=\sqrt{39/70}=0.746420\ldots$, printed $0.7464$. ✔

Both rationals agree with the two values [lean/INDEX.md](../lean/INDEX.md):38 records as kernel-checked, $7/10$ and $39/70$.

### 3.4 The cap and the maximum, checked

Back-substitution gives $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$, matching L23. It is a sum of squares, so $\ge0$, so $r\le\tfrac{(n-2)N}{2(n-1)}=\tfrac{n(n-2)}4$. At that value $N-r=\tfrac{n(n-1)}2-\tfrac{n(n-2)}4=\tfrac{n^2}4$ and

$$\theta^2=\frac4{n^2}\cdot\frac{rN}{N-r}=\frac4{n^2}\cdot\frac{\tfrac{n(n-2)}4\cdot\tfrac{n(n-1)}2}{\tfrac{n^2}4}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .$$

**Exact.** At $n=6$: $r=6$, $N=15$, $\theta^2=10/9$; at $n=8$: $r=12$, $N=28$, $\theta^2=21/16$; both equal $\theta_0(n)^2$.

### 3.5 What the derivation does *not* cover, and the answer to C4

**The derivation's hypothesis set is $\{\mathfrak h$ a subalgebra, $0<r<N$, $W=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, $Q(W)=\theta W\}$. None of those four is a hypothesis of the block's criterion.** In particular:

- **Criticality is an input, not an output.** L23 derives $\theta$ *from* $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$. So the closed form says nothing about a $W_{\mathfrak h}$ that is not critical, which is why the block's own non-members ($\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and the rest) must not be evaluated with it.
- **The two-eigenvalue form is an input.** The criterion outputs a spanning $W$ of an invariant line, with no control on its spectrum. C2 is the missing bridge, and §6.4 shows it cannot be built from the criterion's own mechanism.

**C4: not false, but the block's stated support is the weaker one.** A reader who stops at :119 sees only "checked against held-out spaces it was never fitted to" (agreement at test points), with no pointer to L23. The derivation is thirty lines below under a different lemma number, and [results.md](../results.md):312's proof pointer for L4 does route a consumer into this file.

## 4. Quantifier order, scope, and every edge of the range

### 4.1 The block states no range for $n$ or $r$ at all

The closed form is printed as $P/\lVert W\rVert^3=\tfrac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$, $N=\binom n2$, and **no admissible range**. L23 states $0<r<N$; the block drops it.

- **$r\to N$.** At $r=N$, $\mathfrak h=\mathfrak{so}(n)$, $W_{\mathfrak h}=c(\mathrm{Id}-\mathrm{Id})=0$ and the expression is undefined ($\theta\to\infty$). The object is not merely singular, it is the zero operator, which is not on the unit sphere.
- **$r\to0$.** $\mathfrak h=0$ gives $W=0$ again; the formula returns $\theta\to0$, a finite wrong answer rather than a visible singularity, which is the worse edge of the two. [lean/INDEX.md](../lean/INDEX.md):82 records the same failure quantitatively at $r=1$: $7/108$ at $n=8$ against $\theta^2=3/2$.
- **Neither edge is reachable among members**, because the cap $r\le n(n-2)/4$ and $r\ge1$ bind first, but the block states neither the cap's role as a range restriction nor $r\ge1$.
- **Smallest admissible $n$.** $\mathcal W_n=0$ for $n\le3$, so (H3) is unsatisfiable there and the criterion is vacuous. At $n=4$ the family's maximiser is $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, $r=2=\tfrac{4\cdot2}4$, $N=6$, $\theta^2=\tfrac4{16}\cdot\tfrac{2\cdot6}4=\tfrac34$, $\theta=\tfrac{\sqrt3}2=0.866025$, which is [conventions.md](../findings/conventions.md):21's $\Theta_4=0.866$. The block gives no lower bound on $n$.
- **$\ker W\ne0$.** For $0<r<N$ the two eigenvalues $c(1-\tfrac rN)$ and $-c\tfrac rN$ are both nonzero, so an unpadded member has trivial kernel. **The padded members do not**, see §4.3, where that is exactly what breaks the closed form.

### 4.2 Odd $n$, the maximum's quantifier (C7)

> "the answer is $n(n-2)/4$, attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$"

Stated for all $n$, with no parity condition. **For odd $n$, $n(n-2)$ is odd, so $n(n-2)/4$ is not an integer and no subalgebra attains it**; and $\mathfrak{so}(n/2)$ is not defined. At $n=9$ the cap is $63/4=15.75$, so $r\le15$ and $\theta<\theta_0(9)$ strictly. L23 states this correctly (*"for $n$ odd the cap is not an integer and the inequality is strict"*) and **L4's block omits it**. The *bound* $r\le n(n-2)/4$ holds at every $n$; only attainment needs $n$ even.

*Argue the opposite:* one could read "$\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$" as itself carrying the parity, since the symbol is undefined otherwise. That reading rescues the sentence's second half but not its first: *"the answer is $n(n-2)/4$"* is a statement about the supremum being attained, and it is false at odd $n$. **Verdict: quantifier missing, repairable in three words.**

### 4.3 Padding, the block's own admission breaks its own closed form (C8)

> "zero-padding preserves everything, so they persist into $n=12$"

placed one clause before "Every member has just two eigenvalues, giving the closed form …".

**Concretely.** Take the $SU(3)$ member, $n=8$, $r=8$, $N=28$, $\theta=\sqrt{7/10}=0.836660$. Pad $W$ by zero into $\Lambda^2\mathbb R^{12}$. The record's padding lemma ([ungraded-slack.md](../findings/ungraded-slack.md), the constructive-existence paragraph) states that padding carries $\theta$ across unchanged, so the padded object is critical at $n=12$ with $\theta=0.836660$. But:

- **Its spectrum has three values**, $u$ with multiplicity $8$, $v$ with multiplicity $20$, and $0$ with multiplicity $\binom{12}2-\binom82=66-28=38$. So it is not $c(\Pi_{\mathfrak h'}-\tfrac{r'}{N'}\mathrm{Id})$ for any subalgebra $\mathfrak h'\subseteq\mathfrak{so}(12)$, and **"Every member has just two eigenvalues" is false of it.**
- **The closed form returns the wrong number for it.** At $n=12$, $r=8$, $N=66$, $N-r=58$: $\theta^2=\tfrac4{144}\cdot\tfrac{8\cdot66}{58}=\tfrac1{36}\cdot\tfrac{528}{58}=\tfrac{22}{87}$, so $\theta=\sqrt{22/87}=0.502865\ldots$ against the true, padding-preserved $0.836660$. Cross-multiplying to keep it exact: $\tfrac{22}{87}$ versus $\tfrac7{10}$ is $220$ versus $609$, not equal, and not close.
- **The criterion's own hypothesis fails after padding.** With $K$ acting on $\mathbb R^{12}=\mathfrak{su}(3)\oplus\mathbb R^4$ and trivially on the $\mathbb R^4$, $\Lambda^2\mathbb R^{12}$ acquires the $K$-fixed summand $\Lambda^2\mathbb R^4$, and $\mathcal W_{12}^K$ is far from one-dimensional. **So padded objects are not produced by the criterion**; they are produced by the separate padding lemma.

*Argue the opposite:* the charitable reading is that "persist into $n=12$" claims only that the *critical points* persist, not that they remain members of the two-eigenvalue family, which is true and is what the padding lemma gives. **That reading is available and I adopt it**, so C8 is not a false statement. What it is, is a scope defect: the clause "preserves **everything**" sits immediately before two universal claims over "every member", and a consumer who takes padded objects as members will apply the closed form and get $0.503$ where the truth is $0.837$. **Verdict: SCOPE DEFECT, one word ("everything") doing the damage.**

### 4.4 "$\theta$ increases with $\dim\mathfrak h$" (C9)

From the closed form, $\theta^2=\tfrac4{n^2}\cdot\tfrac{rN}{N-r}=\tfrac{2(n-1)}n\cdot\tfrac r{N-r}$, and $r\mapsto r/(N-r)$ has derivative $N/(N-r)^2>0$ on $(0,N)$. **So $\theta$ is strictly increasing in $r$, at fixed $n$, since $N$ and the prefactor both depend on $n$.** The block states it unqualified and then immediately uses it across a chain of members at different $n$. The block's own two members contradict the unqualified reading: $r=8$ at $n=8$ gives $0.836660$, while $r=21$ at $n=14$ gives $0.746420$, larger $r$, smaller $\theta$. **Verdict: true at fixed $n$, false as written; the maximum argument in :121 is at fixed $n$ and so is unharmed.**

## 5. The universal claims, tried against one object from each structured family the record names

Two universals: **"None is coordinate-diagonalizable"** and **"Every member has just two eigenvalues"**. The block names five structured families. I took one object from each.

| family named by the block | object | two eigenvalues? | coordinate-diagonal? |
| --- | --- | --- | --- |
| bi-invariant metric, compact simple group | $\mathfrak{su}(3)\subset\mathfrak{so}(8)$ via $\mathrm{ad}$, $r=8$, $N=28$ | yes, $\theta^2=7/10$ | **no**, argued below, so the block's clause holds here |
| isotropy-irreducible symmetric space | $\mathfrak{sp}(3)\subset\mathfrak{so}(14)$ for $SU(6)/Sp(3)$, $r=21$, $N=91$ | yes, $\theta^2=39/70$ | **no argument on file** |
| symmetric pair, balanced split | $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, any even $n$ | yes | **YES, refutes the universal (§2)** |
| symmetric pair, unbalanced split | $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p\ne q$ | yes, but **not a member** | yes, and irrelevant |
| padded object | $SU(3)$ member padded to $n=12$ | **no, three values, kernel of dimension $38$** | inherits $\mathfrak{su}(3)$'s answer |

### 5.1 The bi-invariant simple members, the block's clause survives here (C6)

If $W$ is diagonal in the basis $\{e_i\wedge e_j\}$ of some orthonormal frame, then **every eigenspace of $W$ is spanned by a subset of that basis**, so every eigenspace contains a decomposable bivector. Contrapositive: an eigenspace containing no decomposable bivector certifies non-diagonality, with no frame search.

At $\mathfrak h=\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$, $E_{\max}=\mathfrak h$ and its elements are the operators $\mathrm{ad}(X)$, $X\in\mathfrak{su}(3)$. A nonzero $\mathrm{ad}(X)$ has kernel the centraliser $\mathfrak z(X)$, whose dimension is $4$ when $X$ has a repeated eigenvalue and $2$ otherwise; so $\mathrm{rank}\,\mathrm{ad}(X)\ge8-4=4$ for every $X\ne0$. A decomposable bivector has rank $2$. **So $\mathfrak h$ contains no decomposable bivector and the $\mathfrak{su}(3)$ member is not coordinate-diagonal.** The same rank count runs for any compact simple $\mathfrak g$ with $\mathrm{rank}\,\mathfrak g\ge2$, which is exactly the "proven rather than numerical" the block claims for the Lie-group members. **C6 is earned for that sub-population.**

*I supply no argument for the isotropy-irreducible members.* Whether $\mathfrak{sp}(3)\subset\mathfrak{so}(14)$ contains a rank-$2$ element is not settled anywhere I found, and the block's claim covers them. **That half of C6 is HYPOTHESIS-DEBT: what would have to be shown is that the isotropy representation's image contains no rank-$2$ skew element.**

### 5.2 Unbalanced splits are not members, and the record is right about it

For a symmetric pair $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, so $S_{\mathfrak{mmm}}=0$, and §3.4's identity then **forces** $r=n(n-2)/4$. With $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p+q=n$, $r=\binom p2+\binom q2$, and $\binom p2+\binom q2=\tfrac{n(n-2)}4$ reduces to $(p-q)^2=0$. **So among the orthogonal splits only the balanced one can carry a critical two-eigenvalue Casimir**, and the block's non-member figures ($\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ at $n=8$, $r=13>12$; $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ at $n=12$, $r=31>30$) are correctly outside. Note that these all *also* have $\Pi_{\mathfrak h}$ diagonal in $\{e_i\wedge e_j\}$, so diagonality is not what distinguishes members from non-members, which is a second reason C5 was never going to hold.

### 5.3 "Every member has just two eigenvalues" (C2), no argument on file, and none is possible from the criterion's mechanism

The criterion's whole content is: $Q$ is equivariant, $\mathcal W_n$ is $Q$-closed, $\dim\mathcal W_n^K=1$. **That mechanism cannot imply a two-eigenvalue spectrum, because the record holds a $K$ satisfying all three whose invariant $W$ has three eigenvalues**: $K=U(3)\subset SO(6)$, where [L28](../findings/nondegeneracy.md) gives $\dim\mathcal W_6^{U(3)}=1$ and criticality, and [LEDGER.md](../findings/LEDGER.md):24 records the spectrum directly, *"the sphere product has two distinct eigenvalues, $\mathbb{CP}^3$ has three"*.

$U(3)$ fails the block's $(\Lambda^4)^{K}=0$, so it is not a counterexample to C2 *as the block scopes it*. **But it settles the shape of the debt**: any proof of C2 must use $(\Lambda^4)^K=0$, the hypothesis §1.3 shows is inert everywhere else in the block, and no such proof is on the record. **Verdict on C2: HYPOTHESIS-DEBT. What would have to be shown: that $(\Lambda^4\mathbb R^n)^K=0$ together with $\dim\mathcal W_n^K=1$ forces the spanning $W$ to be an affine function of a projector onto a subalgebra.** Until that is shown, the closed form C3 attaches to L23's family and not to the criterion's.

*(The converse direction is on the record and is sound: [LEDGER.md](../findings/LEDGER.md):933 notes $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is affine in a projector, hence has exactly two eigenvalues at $0<r<N$, with $\mathfrak h$ recoverable as an eigenspace, so three eigenvalues excludes every $\mathfrak h$ at once. That is the implication the record proves, and it runs the other way from C2.)*

## 6. Comparing the forms

I read four forms of L4 and one Lean row.

| form | where | what it carries that the others do not |
| --- | --- | --- |
| **A, the block** | [ungraded-slack.md](../findings/ungraded-slack.md):119, :121 | the examples, the padding clause, the closed form, the "held-out spaces" support sentence, the maximum, the $0.8367$ simple-isotropy ceiling. **The only form carrying the full false clause with its named exception.** |
| **B, the glance line** | [results.md](../results.md):116 | the shortest form: criterion, "**provably non-diagonalizable** family", "closed-form $P$". **Carries the falsehood with no examples, no exception, and no correction, the most citable and the most defective.** |
| **C, the proof pointer** | [results.md](../results.md):312 | *"Lemma L4, a generator for critical points, and a new family. **Proof:** [ungraded-slack.md](../findings/ungraded-slack.md)"*. Carries no mathematics; routes the consumer into A, which is where the falsehood is. |
| **D, the corrected form** | [problem.md](../findings/problem.md):158, item 12 | the only form with the correction: *"**Some members are coordinate-diagonalizable**, the balanced sphere product is one, and the $3$-block product just named is another (Reviewer 118, correcting this line)."* It also drops the $(\Lambda^4)^K=0$ mis-scoping less than A does, states $K$ as *"the full, possibly disconnected, isotropy group"*, gives the true maximum $\theta_0(n)$, and scopes $0.8367$ correctly to *"members with $\mathfrak h$ **simple**"*. **Its own replacement clause is false, §2.4.** |
| **E, the Gate-2 box** | [ungraded-slack.md](../findings/ungraded-slack.md):106–110 | the refutations, sitting **above** A in the same file. Carries the $U(m)$/L28 refutation of (H2)'s necessity, the balanced-tower refutation of C5, the parity quantifier and the fixed-$n$ quantifier. |

### 6.1 The Lean row

[lean/INDEX.md](../lean/INDEX.md):38, *"[L4](../results.md)'s two named points"*, [L4.lean](../lean/HamiltonsCubic/Results/L4.lean), **proved**, kernel-checked. It formalises **only the two arithmetic evaluations** $\theta^2=7/10$ at $SU(3)$, $n=8$ and $\theta^2=39/70$ at $SU(6)/Sp(3)$, $n=14$, from the closed form taken as given. Its own disclaimer: *"**Not claimed**: the generator criterion, or the identification of $r$ with $\dim\mathfrak h$"*.

**So no Lean row claims the criterion, the two-eigenvalue property, or the non-diagonalizability clause.** Two adjacent rows touch the family from other directions, [L23bound.lean](../lean/HamiltonsCubic/Results/L23bound.lean) at :82 (the cap is saturated at the balanced products) and [L105.lean](../lean/HamiltonsCubic/Results/L105.lean) at :151 (which proves $\theta^2$ **strictly increasing in $r$**, C9's fixed-$n$ form), but neither reaches C1, C2 or C5.

**What a row would have to claim.** For the criterion: *let $V$ be a finite-dimensional real inner-product space carrying an orthogonal $K$-action and a $K$-equivariant map $Q:V\to V$; if $\dim V^K=1$ and $W$ spans it with $\lVert W\rVert=1$, then $Q(W)=\langle W,Q(W)\rangle\,W$.* That is the whole of C1, it is Schur-free linear algebra, and it makes visible that $(\Lambda^4)^K=0$ has no place in it. For C5, a row would have to claim the negation of what §2 exhibits, so no row should be written; a row for the *true* statement would have to say *no eigenspace of $W$ contains a decomposable bivector*, restricted to the bi-invariant simple members.

### 6.2 The $K\subseteq SO(n)$ scope, against the maximiser

A and B both quantify over $K\subseteq SO(n)$. L23's *"Producing members"* box says the maximiser needs $K=N_{O(n)}(\mathfrak h)$, the full normaliser **in $O(n)$**, and that *"Taking $K$ connected is not enough, $\mathfrak{so}(4)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(8)$ then fails two of the three conditions and the equality case is lost at $n=8$; the $O(4)\times O(4)$ reflections and the block swap restore it."* The reflections have determinant $-1$. **Whether $N_{O(n)}(\mathfrak h)\cap SO(n)$ still gives $\dim\mathcal W_n^K=1$ is not settled anywhere I read**, so I record it rather than resolve it: **HYPOTHESIS-DEBT, the criterion as quantified ($K\subseteq SO(n)$) is not shown to reach the object A names as the family's maximiser.**

## 7. The named trap, each citable claim read alone

The failure mode this record is warned about is a correction landing *beside* the statement it corrects. **It has fired here, twice, and in the worst possible direction.**

- **The Gate-2 box (form E) sits at lines 106–110 of [ungraded-slack.md](../findings/ungraded-slack.md); the block it refutes (form A) sits at 119 and 121, below it, verbatim and uncorrected.** The brief I was given quotes A with provenance stripped (which is exactly what a consumer copying the paragraph would produce) and A reads as a live claim, with a confident rhetorical flourish (*"so the argument recovers its own boundary case"*) that makes the false clause look like the block's strongest point.
- **[results.md](../results.md):116 (form B) carries no correction of any kind.** Read alone, as the results index is meant to be read, it says: *"producing a new, **provably non-diagonalizable** family"*. That is false, and the reader has no signal. Form C, the proof pointer at :312, sends them to A, which repeats it.
- **The correction exists in a third file** ([problem.md](../findings/problem.md):158) which neither A, B nor C references for this point.

**Count: the false clause is live at three sites** (A twice, B once), the correction is at one site that none of them points to, and **the correction's own replacement clause is false at the same object** (§2.4). A consumer citing "L4" from the results index inherits a refuted claim with no way to notice.

## 8. The gap between what is proven and what is used, what a consumer may cite

**Proven, and citable as written:**

1. **The criticality criterion, in its weaker true form.** Let $K\subseteq O(n)$ act orthogonally on $\mathbb R^n$. If $\dim\mathcal W_n^K=1$, spanned by a unit $W$, then $Q(W)=\theta W$ with $\theta=P(W)$, using only $O(n)$-equivariance of $Q$ and $Q$-closure of $\mathcal W_n$ (Fox). Cite it in **this** form, not the block's: the block's $(\Lambda^4\mathbb R^n)^K=0$ is inert and makes the statement apply to strictly fewer groups than the truth.
2. **The closed form, with L23's hypotheses attached.** For $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra with $0<r<N$, if $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is unit and satisfies $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then $\theta=\tfrac2n\sqrt{rN/(N-r)}$. Rebuilt in §3; correct.
3. **The cap and its equality case**, $r\le n(n-2)/4$ at every $n$, attained only at $n$ even and only at the balanced split among orthogonal splits.
4. **$\theta$ strictly increasing in $r$, at fixed $n$.**
5. **The two printed values**, $\theta^2=7/10$ and $39/70$.
6. **Non-diagonality of the bi-invariant simple members**, on the rank-$\ge4$ argument of §5.1.

**Used but not proven, a consumer must not cite these:**

| claim as used | status |
| --- | --- |
| $(\Lambda^4)^K=0$ is a hypothesis of the criterion | inert; keep it only if C2 is ever proved from it |
| "Every member has just two eigenvalues" | **no argument on file**; the closed form's applicability to the criterion's family rests entirely on it |
| the closed form applies to *the criterion's* family | **follows only from the unproven C2**; as proved it applies to L23's family |
| "None is coordinate-diagonalizable" | **false** |
| $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is the lone exception | **false**; it is the smallest member of a tower all of whose members are exceptions |
| the maximum is attained at $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ | needs $n$ even |
| padded objects are members | **false** as members of the two-eigenvalue family; true as critical points, by a different lemma |
| the criterion reaches the maximiser with $K\subseteq SO(n)$ | not shown (§6.2) |
| non-diagonality of the isotropy-irreducible members | **no argument on file** |

**The structural gap in one sentence.** The criterion produces an invariant line; the closed form describes a two-eigenvalue Casimir. **Nothing on the record joins them**, and the missing bridge is exactly C2.

## 9. What would break these statements, and what I did to look for it

- **C5 (already broken).** What would *rescue* it is a proof that $\Lambda^2V_1\oplus\Lambda^2V_2$ is not the $+$ eigenspace of a family member, i.e. that the balanced split is not a member. The block itself asserts the opposite one sentence later, and §5.2 shows the balanced split is the *unique* orthogonal split that can be one. **No rescue exists.**
- **C1.** The object that would falsify it: a $K$ with $\dim\mathcal W_n^K=1$ whose spanning $W$ has $Q(W)\notin\mathbb R W$. That requires $Q(W)\notin\mathcal W_n$, i.e. a failure of Fox's closure theorem. **I read [fox-2019-nonassociative-curvature-algebra/notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md) and it states the closure; no such object can exist.**
- **C2.** The object that would falsify it: a $K\subseteq SO(n)$ with $(\Lambda^4\mathbb R^n)^K=0$ and $\dim\mathcal W_n^K=1$ whose spanning $W$ has three or more eigenvalues. **I looked for one on the record and did not find it.** The nearest object, $U(m)$ with $W_{\mathbb{CP}^m}$ at three eigenvalues ([LEDGER.md](../findings/LEDGER.md):24), fails $(\Lambda^4)^K=0$ by $\omega\wedge\omega\ne0$, so it does not falsify C2, **it only shows that C2 cannot be derived from the criterion's mechanism.** Constructing such a $K$ would be a computation, and under the analysis-only footing I did not open one.
- **C3.** The object that would falsify it: a subalgebra $\mathfrak h$ with $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ and $\theta\ne\tfrac2n\sqrt{rN/(N-r)}$. §3.2 shows the $2\times2$ system is non-degenerate for $0<r<N$, so no such object exists; the derivation is not merely consistent, it is forced.
- **C7.** Falsified by an odd $n$ with a subalgebra of dimension $n(n-2)/4$, impossible, since that is not an integer at odd $n$.
- **C8.** Already exhibited: the padded $SU(3)$ member, $\theta=\sqrt{7/10}$ against a closed-form $\sqrt{22/87}$.

## 10. No finding

Recorded so silence is not read as a pass.

- **No finding on the two printed decimals.** $0.8367$ and $0.7464$ are correct roundings of $\sqrt{7/10}$ and $\sqrt{39/70}$.
- **No finding on the cap's arithmetic.** $S_{\mathfrak{mmm}}\ge0\iff r\le n(n-2)/4$ is exact, and $r=n(n-2)/4\Rightarrow\theta=\theta_0(n)$ is exact.
- **No finding on Wolf.** The block's *"isotropy-irreducible symmetric spaces with $b_4=0$"* is a class, not a citation; [wolf-1968-isotropy-irreducible](../references/wolf-1968-isotropy-irreducible/notes.md) **is** in references/ and I read it, but it classifies the **nonsymmetric** isotropy-irreducible spaces, so it does not support the block's symmetric-space claim. **The claim that the named members have $b_4=0$ rests on cohomology facts I found nowhere on the record and in no read source**; I state that rather than supply them.
- **No finding on the $0.8367$ simple-isotropy ceiling.** It is outside the two lines I was briefed on ([ungraded-slack.md](../findings/ungraded-slack.md):119 carries the value, :121 the ceiling claim); the value is correct, and the ceiling is an enumeration claim I did not audit.

## Verdict

**BROKEN**, for the block as dispatched, on C5 and C10, the non-diagonalizability clause is false at the family's own stated maximiser at every even $n$, by inspection, and it is live and uncorrected at three sites including the results index.

Within it, separately:

- **C1: PROVEN, hypotheses corrected.** True under $\dim\mathcal W_n^K=1$ alone (plus equivariance and $Q$-closure, both unstated); $(\Lambda^4\mathbb R^n)^K=0$ is unused and not necessary.
- **C3: PROVEN.** Derived at L23 and rebuilt here in full, including the two scalar equations the block-averaged eigen-equation gives.
- **C2: HYPOTHESIS-DEBT.** What would have to be shown: that $(\Lambda^4\mathbb R^n)^K=0$ with $\dim\mathcal W_n^K=1$ forces the spanning $W$ to be affine in a projector onto a subalgebra.
- **C6 (isotropy-irreducible half) and §6.2: HYPOTHESIS-DEBT**, each with its missing statement named above.
- **C7, C9: quantifiers missing**, repairable in a few words each.
- **C8: SCOPE DEFECT.**
