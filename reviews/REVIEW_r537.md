# REVIEW r537, Lemma L128

**Target.** Lemma L128, "the branching clause: block-checkable nondegeneracy at a pure critical point, and the isolation it gives", [findings/second-order.md](../findings/second-order.md) at `#### Lemma L128` (line 773) down to the next heading.

**Reviewer.** r537, independent adversarial audit, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts were run. Every number below is pen-and-paper block algebra on objects constructed for the purpose, checked three ways against the record's own anchors.

**Conventions fixed first, against [conventions.md](../findings/conventions.md).** Half-trace pairing, $\lVert\varphi_{ab}\rVert^2=1$; $t=\sum_{a\ne b}M_{ab}^2\le2$ over **ordered** pairs, $=2$ at a pure point; $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$, so $84$ at $n=6$ and $1638$ at $n=12$; "diagonal" is diagonal in the coordinate $2$-planes of a frame, never diagonal as a $\Lambda^2$ operator.

**VERDICT: PLAUSIBLE.** Parts (i), (ii) and (iii) are **confirmed**, each re-derived cold; (iv)'s statement is true and its **proof contains one unjustified step** that is repairable in a line. The lemma's substance survives intact. The most consequential thing found is not in L128 at all: **L128's box is right and its input [Lemma L11](../findings/nondegeneracy.md), restated 2026-09-04, is wrong**, the $\min(p,q)=2$ family is Morse–Bott *nondegenerate*, derived in full below.

---

## Findings

### F1, Part (i) is CONFIRMED, and holds far more widely than stated (Q2)

Derived cold. $\rho(E_{jk})$ sends $e_{ji}\mapsto e_{ki}$, $e_{ki}\mapsto-e_{ji}$, and kills $e_{jk}$ and every $e_{ab}$ with $a,b\notin\{j,k\}$. With $We_{ab}=M_{ab}e_{ab}$,
$$[\rho(E_{jk}),W]_{\alpha\beta}=(M_\beta-M_\alpha)\rho(E_{jk})_{\alpha\beta}.$$
Two consequences fall out at once:

- **Diagonal entries vanish identically** ($\alpha=\beta$ gives $M_\alpha-M_\alpha$), so the commutator has no trivial-character component, hence none in $\mathcal D_n$.
- **$\rho(E_{jk})$ joins only $2$-planes sharing an index**, so it never connects a disjoint pair, hence no four-set component.

**The brief's question is answered in the strongest direction: the claim needs neither a maximiser, nor criticality, nor even $\theta>0$, diagonality alone.** It is therefore true at a general pure critical point a fortiori. The block's own proof is the same argument and is correct.

Two facts the block leaves implicit and that a reader needs:

- $\sum_{i\notin\{j,k\}}o^{jk}_i=\sum_i(M_{ki}-M_{ji})=-M_{kj}+M_{jk}=0$ by zero row sums, so $o^{jk}$ lies inside the Ricci cut $\mathbf1^\perp$ that [Lemma L122](../findings/second-order.md) identifies. **Ricci-flatness is load-bearing for (i) as used**, and the Scope paragraph does list it.
- $T_W\mathcal O=\bigoplus_{\{j,k\}}\mathbb Ro^{jk}$ with $\dim T_W\mathcal O=\#\{\{j,k\}:o^{jk}\ne0\}$. **The $pq$-dimensionality is a sphere-product fact, not a general one**, and the block correctly never claims otherwise.

### F2, Part (ii) is CONFIRMED; the block decomposition is complete, checked at two dimensions

Re-derived: $P$ cubic gives $\nabla P=3Q$, $D^2P_W=6W\circ(\cdot)=6\theta L_e$, and the sphere's multiplier contributes $-\langle\nabla P,W\rangle\mathrm{Id}=-3\theta\,\mathrm{Id}$, so $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, matching [Lemma L24](../findings/second-order.md). $L_e$ is self-adjoint with $L_ee=Q(e)=e$, so $W^\perp$ is invariant and $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$. **The criterion excludes the value $\tfrac12$ and does not bound the spectrum, correct, and correctly explained in the block.**

**The blocks exhaust $W^\perp$**, which the block asserts through [Lemma L120](../findings/second-order.md) and which I checked independently by dimension: $\tfrac{n(n-3)}2+2\binom n4+(n-3)\binom n2$ gives $9+30+45=84$ at $n=6$ and $54+990+594=1638$ at $n=12$, both equal to $\dim\mathcal W_n$. Since $W\in\mathcal D_n$ spans the trivial character, $W^\perp$ cuts $\mathcal D_n$ and nothing else, so (ii)'s "$\mathcal D_n\cap W^\perp$" is exactly right, and it is the clause [Lemma L120](../findings/second-order.md)'s own box says every citation gets wrong.

**One wording gap, not a defect.** In a pair block with $o^{jk}=0$ (every within-factor block of a sphere product), "simple with eigenvector $o^{jk}$" is unsatisfiable, so the disjunction correctly collapses to "absent". That is the right criterion, but the block never says the degenerate case is what forces the first disjunct, and a reader checking a within-factor block has to work it out.

### F3, Part (iii) is CONFIRMED, ambient argument and all

$F(X)=3(Q(X)-P(X)X)$ is a polynomial field on $\mathcal W_n$; it is **not homogeneous** (degrees $2$ and $4$), which is exactly what cuts the radial direction out and makes $\ker dF_W=T_W\mathcal O$ possible in the ambient space. Computed cold:
$$dF_W=6\theta L_e-3\theta\,\mathrm{Id}-9\theta\,W\otimes W,$$
manifestly self-adjoint, sending $W\mapsto-6\theta W$ and restricting to $6\theta(L_e-\tfrac12)$ on $W^\perp$, all three as the block states. $\mathcal O\subseteq F^{-1}(0)$ by $SO(n)$-equivariance of $Q$ and invariance of $P$. The implicit-function step is valid: $\Pi_{V'}dF_W|_{V'}=dF_W|_{V'}$ by self-adjointness, $G^{-1}(0)$ is locally a $\dim\mathcal O$-manifold containing $F^{-1}(0)$, and an embedded submanifold of equal dimension inside it is open in it, so $\mathcal O=F^{-1}(0)$ near $W$. Equivariance then gives the open set $\bigcup_g gU\supseteq\mathcal O$ directly; the compactness appeal is convenience, not necessity.

**One imprecise paraphrase.** (iii)'s second sentence ("*only where a non-orbit block carries $\tfrac12$ exactly*"), omits one of the two failure modes (ii) admits: a **pair** block in which $\tfrac12$ is repeated, the orbit direction plus another. That block is an orbit block, so the paraphrase misses it. The precise version is in the lemma's own closing paragraph ("*the pair half is a simplicity statement*"), so nothing downstream is hurt.

### F4, Part (iv): the conclusion holds, one proof step does not (DEFECT, repairable in a line)

> **"$A$ is closed in the compact $S$, hence compact."**

$A=\{\text{non-pure critical}\}\cap\{\theta\ge c\}$. "Non-pure" is the complement of $B$, and $B$ is compact, so **non-purity is an open condition and $A$ is the intersection of closed sets with an open one.** Nothing elementary makes $A$ closed. Worse, "$A$ is closed" is *equivalent to the lemma's own conclusion*: $\overline A\cap B=\varnothing$ says precisely that no limit of $A$ is pure. **The step is the theorem asserted as a premise.**

**The conclusion survives untouched**, because the step is never used. $\overline A$ is closed in the compact $S$ hence compact for free; $B$ is compact by the block's own correct one-liner (continuous image of $O(n)\times(\mathcal D_n\cap S)$); the disjointness argument uses neither. Disjoint compacts give $d(\overline A,B)>0$, and $d(A,B)\ge d(\overline A,B)$.

**Repair:** replace the clause with "*$\overline A$ is closed in the compact $S$, hence compact*", and delete nothing else. The statement's own "*and both are compact*" then reads correctly of $\overline A$ and $B$, and $A$'s compactness follows a posteriori.

*A related over-claim downstream:* [ATTEMPTS.md:3715](../ATTEMPTS.md) says "*[Lemma L128](../findings/second-order.md)(iv) needs $B=O(n)\cdot(\mathcal D_n\cap S)$ compact, which is now proved rather than assumed, the separation argument's second compact set was the one nobody had checked*". L128(iv) proves $B$'s compactness itself in its first clause. The set that was never checked is $A$, and it is still not.

### F5, MAJOR, on an input: $S^2\times S^4$ is Morse–Bott NONDEGENERATE, so L128's box is right and [Lemma L11](../findings/nondegeneracy.md)'s statement of 2026-09-04 is wrong

L128's box asserts, and needs, that

> *$S^2\times S^4$ at $n=6$ is pure, critical and Morse–Bott nondegenerate ([Lemma L11](../findings/nondegeneracy.md)), while its $(2,2)$ four-set blocks sit at $\mu_{2,4}=\tfrac23>\tfrac12$*

the witness that (ii) must exclude the **value** $\tfrac12$ rather than bound the spectrum. But [Lemma L11](../findings/nondegeneracy.md)'s statement, corrected today, says the opposite:

> **STATEMENT, CORRECTED 2026-09-04.** *For $p,q\ge3$ with $(p,q)\ne(3,3)$ … **The exceptions are two families, not one**, $(3,3)$, and every product with $\min(p,q)=2$.*

**I derived the whole $L_e$ spectrum at $S^2\times S^4$ by hand and L128 is right.** Sectional matrix with $\gamma=-1$: $\alpha=4$, $\beta=\tfrac23$, $\theta=5$ in that scale (unit-norm $\theta^2=0.9375$, matching the record). Criticality verified entry by entry through $M^{\circ2}+M^2=\theta M$, all three entry types. Then, block by block, with $L_e=L_M/\theta$:

| block family | count | $L_e$-spectrum |
| --- | --- | --- |
| four-set, $(2,2)$-split | $6$ | $\{+\tfrac23,-\tfrac23\}$ |
| four-set, $(1,3)$ and $(0,4)$ | $9$ | $\{0,0\}$, the three opposite-pair sums coincide, so $\Sigma=0$ |
| pair, within $F_1$ | $1$ | $(-\tfrac23)^3$ |
| pair, within $F_2$ | $6$ | $\{\tfrac13,-\tfrac23,0\}$ |
| pair, cross | $8$ | $\{\tfrac12\ \text{simple},0,0\}$, the $\tfrac12$ on $o^{jk}\propto(-3,1,1,1)$ |
| $\mathcal D_6\cap W^\perp$ | $1$ | $\{(-\tfrac23)^3,(\tfrac13)^3,0^2\}$ |

The $\mathcal D_6$ row is the one nothing on the record prints; I obtained it from $(M\circ x)_{ab}=M_{ab}x_{ab}+\tfrac12(Mx+xM)_{ab}$ and the $S_2\times S_4$ isotypic split of $\mathcal D_6$ into $3+1+3+2$.

**So $\dim E(\tfrac12)\cap W^\perp=8=pq=\dim\mathcal O$: the point is Morse–Bott nondegenerate.** Three independent cross-checks, none of which was used to build the table:

1. $\operatorname{tr}L_e=0$ exactly: $0-2-2+4=0$.
2. Dimensions: $9+30+45=84=\dim\mathcal W_6$.
3. **Multiplicities reproduce [Lemma L27](../findings/nondegeneracy.md)'s summands**, including its known failure: $18$ eigenvectors at $-\mu=-\tfrac23$ against $\dim(S^2_0(\mathbb R^2)\otimes S^2_0(\mathbb R^4))=18$; $9$ at $\lambda_4=\tfrac13$ against $\dim S^2_0(\mathbb R^4)=9$; $6$ at $+\mu$ against $\dim(\Lambda^2\otimes\Lambda^2)=6$; $8$ at $\tfrac12$ against $\dim(\mathbb R^2\otimes\mathbb R^4)=8$. Summing L27's ten dimensions gives $86$, **exactly the $86$-against-$84$ over-count [Lemma L126](../findings/second-order.md) records at $p=2$**, and my table locates the surplus $2$ precisely at $S^2_0(\mathbb R^2)$, which drops out of $\mathcal W_n$.

**It generalises to every $S^2\times S^q$.** Redoing the same four computations symbolically in $q$ (with $\alpha=q$, $\beta=2/(q-1)$, $\theta=q+1$): four-set $\pm\mu_{2,q}$ with $\mu_{2,q}=\tfrac q{2(q-1)}$, never $\tfrac12$; within-$F_1$ pair block exactly $-\mu_{2,q}$; within-$F_2$ pair blocks $\{\lambda_q,-\mu,0^{q-3}\}$ with $\lambda_q=\tfrac{q-2}{2(q-1)}<\tfrac12$; cross-factor $\{\tfrac12,0^{q-2}\}$ with the $\tfrac12$ on the orbit; and $\mathcal D_n\cap W^\perp=\{(-\mu)^{q-1},\lambda_q^{\,q-1},0^{q(q-3)/2}\}$, dimensions summing to $(q+2)(q-1)/2=n(n-3)/2$. **No non-orbit $\tfrac12$ anywhere.**

**Where L11 goes wrong, precisely.** Its proof reads [Lemma L26](../findings/nondegeneracy.md)'s "*the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$*" as a *kernel* excess. It is not: $\tfrac1{2(n-3)}$ is the amount by which $\mu_{2,q}$ **exceeds** $\tfrac12$. An eigenvalue strictly above $\tfrac12$ makes the point a **saddle**, it fails [Lemma L24](../findings/second-order.md), which is [Lemma L126](../findings/second-order.md)'s "*no $S^2\times S^q$ is a local maximum*", and leaves the Hessian kernel exactly the orbit. **Degeneracy needs the value $\tfrac12$ attained, which is the very distinction L128(ii) exists to make**, so L11's correction reintroduces at $p=2$ the error that L128's own box records two reviewers refuting.

**L11 contradicts itself twice on this, independently of me.** Its own surviving paragraph reads "*$S^2\times S^4$ at the same $n=6$ **is nondegenerate***", and [nondegeneracy.md:611](../findings/nondegeneracy.md) reads "*The $n=6$ exception ($S^3\times S^3$, kernel $18$ against orbit $9$) remains the **only** failure on record*".

**Suggested repair to L11, for whoever owns it**, the correction was right that the old statement was incomplete, and wrong about what the second family is: *for $p,q\ge2$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate; $(3,3)$ is the only degenerate two-block product. Separately, every product with $\min(p,q)=2$ fails [Lemma L24](../findings/second-order.md) and is a saddle, by $\mu_{2,q}>\tfrac12$, a distinct failure from degeneracy.*

**Impact on L128: none adverse.** Both of L128's uses of L11, the box's witness, and "*that is the one two-block sphere product [Lemma L11](../findings/nondegeneracy.md) excepts*", are substantively correct and now point at a statement that denies them.

### F6, The withdrawn material is genuinely gone (Q4)

- **Strict inequalities.** (ii) is stated purely as exclusions of the value $\tfrac12$; the box explains the repair and names the witness. **Nothing in the current text needs the strict form.** [Corollary L128.1](../findings/second-order.md) does use strict inequalities ($(p-2)/(2(p-1))<\tfrac12$, $\Sigma\ne\theta^2$ via $\mu\ne\tfrac12$), which is a legitimate *sufficient* route to exclusion, not a relapse.
- **The affine slice.** (iii)'s proof is ambient and uses no slice and no Lyapunov–Schmidt; the closing box says so explicitly and correctly ("*(iii) supplies what was missing and needs neither*").
- **Citations.** Checked every one. [ATTEMPTS.md:3397](../ATTEMPTS.md) ("*the $\ne$ repair, not a bound*"), [ATTEMPTS.md:3453](../ATTEMPTS.md) (which cites the repair as precedent against a fresh relapse) and [ATTEMPTS.md:3659](../ATTEMPTS.md) (a strict bound offered as *sufficient* for the $\ne$ clause) are all clean. **No live citation depends on either withdrawn form.**

### F7, What is isolated, and does isolation follow from nondegeneracy (Q5)

**What:** the critical orbit $\mathcal O=SO(n)\cdot W$, in the norm topology on $S(\mathcal W_n)$, from **every other critical point**, not merely from non-pure ones, and not merely from points of higher value. **It does follow**, and by a proof rather than by juxtaposition: nondegeneracy is the invertibility hypothesis of the implicit function theorem applied to $F$, and isolation is that theorem's conclusion (F3). The chain is (ii) $\Rightarrow\ker dF_W=T_W\mathcal O\Rightarrow$ local graph $\Rightarrow\mathcal O=F^{-1}(0)$ locally. Nothing is asserted alongside.

**"Block-checkable" is honest but uneven.** Two of the three families are genuinely small ($\binom n4$ blocks of dimension $2$ and $\binom n2$ of dimension $n-3$) while $\mathcal D_n\cap W^\perp$ has dimension $\tfrac{n(n-3)}2-1$, i.e. $53$ at $n=12$. It is one block, so the criterion is finite, but it is not a small check. The record knows this: the passage immediately above the lemma is headed "**THE $\mathcal D_n$ BLOCK IS A LIVE THIRD CLAUSE**".

### F8, Frame dependence, and L37 (Q1)

"**Pure (frame-diagonal)**" means $We_{ab}=M_{ab}e_{ab}$ in the coordinate $2$-planes of *some* orthonormal frame of $\mathbb R^n$, [conventions.md](../findings/conventions.md)'s "diagonal", and [plan.md:51](../plan.md) uses the two words interchangeably. **It is not the same as $W$ being diagonal as an operator on $\Lambda^2$**: purity implies a $\Lambda^2$ eigenbasis, but of *decomposable* bivectors from one frame, and [conventions.md](../findings/conventions.md) flags conflating the two as the trap that "makes the diagonal case look liftable". L128 uses the strong sense throughout and never trades on the weak one.

**Does any claim depend on the frame?** The *decomposition* does, the Scope paragraph says so ("**one fixed eigenframe**, since the decomposition is the sign group's of that frame"). **The criterion's truth value does not**, and this is worth stating in the block because it is not obvious: (ii) is an *iff* whose left side, $\ker\mathrm{Hess}=T_W\mathcal O$, is frame-free, so two frames diagonalising the same $W$ give two different block decompositions that must return the same verdict. Likewise (iv)'s set $B=O(n)\cdot(\mathcal D_n\cap S)$ is $O(n)$-invariant by construction.

**[Lemma L37](../findings/target.md) is not needed and is correctly not cited**, the brief's hint rests on a premise that does not apply here. L128 *hypothesises* a frame rather than deciding whether one exists, and [findings/LEDGER.md:696](../findings/LEDGER.md) makes the same point about the non-diagonal set generally: "*The non-diagonal set is $O(n)$-invariant by construction, so well-posedness never rested on L37. **What L37 buys is decidability without an $O(n)$ search***". A *consumer* of L128 that must certify a given $W$ is pure would want L37; L128 itself does not.

### F9, Corollary L128.1: arithmetic confirmed, headline over-reaches its own hypothesis

I derived the sphere-product value in closed form to check the corollary's numbers:
$$\theta^2=\frac{2(n-1)(p-1)(q-1)}{pq\,(n-2)},$$
which reproduces $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at $p=q$, and $\theta^2=1.596764$ at $S^5\times S^{43}$, the figure [post F61](../findings/second-order.md) prints. Every claim in the corollary's "gap is empty" sentence checks out: $p=2$ gives $(n-1)(n-3)/(n-2)^2\nearrow1$; $p=3$ gives $\to4/3$, i.e. $2/\sqrt3$; $p=4$ gives $\to3/2$ strictly from below; $p=5$ reaches $\tfrac32$ exactly at $n\ge12$ (the threshold is $n^2-7n-54\ge0$, i.e. $n\ge11.64$). **So "every sphere product clearing $\sqrt{3/2}$ at $n\ge12$ has $\min(p,q)\ge5$" is confirmed.**

**The headline over-reaches.** "*every two-block sphere product at $n\ge12$ satisfies the criterion*" is asserted, then the body says "**Assume $p,q\ge3$**". By F5 the headline is in fact **true** including $p=2$, but it is unproved there in the block, and the reader is left to notice that the body is narrower than the title.

### F10, What the citations use (Q6), and one miscitation

Classified every citation outside the review files. **Part (i) is cited nowhere outside the lemma**, consistent with its "on record, restated for use" billing.

| citation | what it takes |
| --- | --- |
| [plan.md:90](../plan.md) | **MISCITE, see below** |
| [plan.md:182](../plan.md) (I18) | (ii) + (iii) |
| [plan.md:184](../plan.md) | Corollary L128.1 |
| [plan.md:186](../plan.md) (I18e) | (ii), pair half |
| [plan.md:208](../plan.md) | delivery record, no content |
| [findings/INDEX.md:49](../findings/INDEX.md) | (i)+(ii)+(iii)+L128.1, accurate |
| [findings/INDEX-results.md:146](../findings/INDEX-results.md) | title only; see F11 |
| [findings/LEDGER.md:171](../findings/LEDGER.md) | records a *removed* L128.1 miscitation in L133 |
| [findings/LEDGER.md:866](../findings/LEDGER.md) | (iii), as the reinstatement of L127's withdrawn clause |
| [second-order.md:761](../findings/second-order.md) | (iii) |
| [second-order.md:769](../findings/second-order.md) | (iv), the closed threshold |
| [second-order.md:1220](../findings/second-order.md) | the box's $S^2\times S^4$ witness |
| [ATTEMPTS.md:2991](../ATTEMPTS.md), [3397](../ATTEMPTS.md), [3403](../ATTEMPTS.md), [3453](../ATTEMPTS.md), [3659](../ATTEMPTS.md), [3978](../ATTEMPTS.md) | (ii), six times, the workhorse |
| [ATTEMPTS.md:3004](../ATTEMPTS.md), [3067](../ATTEMPTS.md), [3135](../ATTEMPTS.md) | Corollary L128.1 |
| [ATTEMPTS.md:3391](../ATTEMPTS.md) | (ii), pair half |
| [ATTEMPTS.md:3711](../ATTEMPTS.md), [3715](../ATTEMPTS.md) | (iv)'s compact $B$, and over-claims, see F4 |

> **THE MISCITATION.** [plan.md:90](../plan.md) reads "*near a Morse–Bott critical manifold the exponent is $\tfrac12$ ([Lemma L128](../findings/second-order.md)(ii))*". **L128 contains no Łojasiewicz statement of any kind**, (ii) is the block criterion for $\ker\mathrm{Hess}=T_W\mathcal O$ and says nothing about a gradient inequality or its exponent. The Łojasiewicz-exponent-$\tfrac12$ fact at a Morse–Bott manifold is a standard result and needs its own source. L128(ii) supplies the *hypothesis* of that result, never the result.

### F11, Record hygiene: four link and title defects

- **Three broken anchors, two distinct stale titles.** Only one of the four anchor strings in use matches the heading. [second-order.md:769](../findings/second-order.md) and [second-order.md:1220](../findings/second-order.md) both truncate to `…-at-a-pure-critical-point`, dropping `-and-the-isolation-it-gives`; [second-order.md:879](../findings/second-order.md) and [second-order.md:912](../findings/second-order.md) (inside L133, three uses) point at `lemma-l128--the-branching-clause-of-the-sign-character-decomposition`, **a title L128 has never carried in its current form**.
- **Index title mismatch.** [findings/INDEX-results.md:146](../findings/INDEX-results.md) names the result "*…and the isolation **and uniform separation** it gives*" against the heading's "*…and the isolation it gives*". The index's version is the better one (it is the only place (iv) appears in a title) but the two should agree.

---

## Verdict

**PLAUSIBLE.** Every mathematical claim in L128 that I could reach is true, and (i)–(iii) are confirmed by independent derivation. The gap that keeps it off CONFIRMED is narrow and named:

**The named gap:** (iv)'s proof asserts "*$A$ is closed in the compact $S$, hence compact*". $A$'s defining condition of non-purity is **open**, and $A$'s closedness is logically equivalent to the conclusion being proved. The step is unused and the repair is one clause ("*$\overline A$ is closed in the compact $S$, hence compact*"), after which (iv) is a complete argument.

**Two things a maintainer should act on beyond the target:**

1. **[Lemma L11](../findings/nondegeneracy.md)'s statement of 2026-09-04 is refuted at $\min(p,q)=2$** (F5), by a full hand derivation of the $S^2\times S^4$ spectrum with three independent cross-checks, and by L11's own two surviving contrary sentences. L128 is on the right side of this and its citations of L11 should not be weakened to match L11's current text.
2. **[plan.md:90](../plan.md) cites L128(ii) for a Łojasiewicz exponent it does not contain** (F10).
