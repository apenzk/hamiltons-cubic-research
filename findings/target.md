# The non-diagonal target: the set, the tests, and the census

The target $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$ (**criticality is part of the statement, and the record carried it without for a long time**), its exact reformulations ($\xi$-Gram, the Rayleigh matrix, $\Theta_3=-2\theta$), the two-eigenvalue symmetric-pair formula, the $\ker\Phi_W$ diagonality test, the census and what it does and does not cover, the middle band, and the second-order saturating set.

Part of [findings/INDEX.md](INDEX.md), the index that says which file to open. The live front is covered by three files; the other two are [bispectral.md](bispectral.md) and [bounds.md](bounds.md).

---

#### The diagonal proof's ENGINE lifts to any critical point, and its corrections push the wrong way

**Derived, checked, and the route closes on a mechanism.**

Taking the $(ab),(ab)$ diagonal of $Q(W)=\lambda W$ in the *coordinate* basis of $\Lambda^2$, with $K_{ab}=W_{abab}$ the vertex matrix:

$$\boxed{\ K_{ab}^2+R_{ab}+(W^{\#})_{abab}=\lambda K_{ab},\qquad R_{ab}:=\sum_{(cd)\ne(ab)}W_{abcd}^2\ \ge0\ }$$

**exact at any critical point**, residual $\le1.1\times10^{-16}$ at six, with $\sum R=1-t/2$ where $t=\lVert K\rVert_F^2$. At a diagonal point $R=0$ and this *is* the record's $S^{\circ2}+S^2=\lambda S+D$, **so $R$ is precisely the non-diagonal defect in the equation the diagonal proof runs on.**

Pairing with $v\otimes v$, $v$ the top eigenvector of $K$ with $Kv=\mu_Kv$, and using $(W^{\#})_{abab}=\langle A^a,A^b\rangle-\sum_{pq}W_{apbq}W_{bpaq}$ with $A^a_{pq}:=W_{apaq}$:

$$\lambda\mu_K=\lVert G\rVert_F^2+\sum_{ab}R_{ab}v_av_b+\Big[\sum_{ab}K_{ab}^2v_av_b-\sum_{ab}v_av_b\operatorname{tr}\big((B^{ab})^2\big)\Big],\qquad G:=\sum_av_aA^a .$$

**$\operatorname{diag}(G)=Kv=\mu_Kv$ always**, so $\lVert G\rVert_F^2=\mu_K^2+\lVert G_{\text{off}}\rVert_F^2$. On the diagonal locus $A^a=\operatorname{diag}(K_{a\cdot})$, forcing $G$ diagonal and $R=0$, and the identity collapses to $\lambda\mu=\mu^2-\mathrm{Dir}$, **the diagonal proof exactly**.

#### The totally-summed vertex equation is an identity, and the reason is published

*Reviewer 126, checking a contraction before it was used.* $\operatorname{tr}(W^{\#})=-\lVert W\rVert^2$ for **every** Weyl tensor, [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/), confirmed here to $3\times10^{-16}$ at $n=5,6,7,8$. Summing the vertex equation over all $(ab)$ therefore gives

$$\sum_{ab}K_{ab}^2+\sum_{ab}R_{ab}+\operatorname{tr}(W^{\#})=\lambda\operatorname{tr}M=0,$$

**The citation is right, but it reaches the trace through an operator identity that is stronger and is worth having on its own.** Lemma 2.1 reads $R+R\#I=\mathrm{Ric}\wedge\mathrm{id}$, so **every Weyl tensor satisfies $W\#I=-W$**, an identity on all of $\Lambda^2$, verified here to $2\times10^{-15}$ at $n=5,6,7$. The trace form follows from it in one step by the symmetry of $\mathrm{tri}(A,B,C)=\langle A\#B,C\rangle$: $\operatorname{tr}(W^{\#})=\mathrm{tri}(W,W,I)=\mathrm{tri}(W,I,W)=\langle W\#I,W\rangle=-\lVert W\rVert^2$. *$W\#I=-W$ is Ricci-flatness rewritten in the sharp product, and it is the form in which sharp-product contractions can actually be evaluated.*

i.e. $t/2+(1-t/2)=1$. **An identity in the normalisation, carrying no information at all.** So the summed contraction of the vertex equation is not a constraint, and only *weighted* contractions can be, which is what the $v\otimes v$ pairing is. *Recorded because checking a contraction for vacuity costs one line and the record has been caught by this shape before, at [fence post F18](fence-posts.md).*

#### The frame-dependence has an exact witness: $K$ VANISHES at the champion

*Reviewer 126, and confirmed here independently.* For Fubini–Study, $K_{ab}=3s\big(J_{ab}^2-\tfrac1{n-1}\big)$, so **$K=0$ exactly when $\lvert J_{ab}\rvert$ is constant off the diagonal**. A **skew conference matrix** $C$ of order $n$ ($C^{\mathsf T}=-C$, $CC^{\mathsf T}=(n-1)I$, entries $0,\pm1$), delivers precisely that: $J=C/\sqrt{n-1}$ satisfies $J^2=-I$, so it is a genuine orthogonal complex structure, and $J_{ab}^2=\tfrac1{n-1}$ with zero spread.

| | $n=4$ ($\mathbb{CP}^2$) | $n=8$ ($\mathbb{CP}^4$) |
|---|---|---|
| $\lVert J^2+I\rVert$, $J$ orthogonal | $2\times10^{-16}$ | $2\times10^{-16}$ |
| criticality residual | $1.7\times10^{-16}$ | $2.2\times10^{-16}$ |
| $\lambda$ | $\mathbf{1.224745=\sqrt{3/2}}$ | $0.986013$ |
| $\lVert K\rVert_F^2$ | $4.3\times10^{-32}$ | $5.4\times10^{-31}$ |

**At $n=4$ this is the point attaining $\sqrt{3/2}$ (the champion of the whole non-diagonal target) and in this frame its vertex matrix is identically zero.** So $\mu_K=0$ at a genuine non-diagonal critical point, and **every route bounding $\lambda$ by a multiple of an eigenvalue of $K$ is not weak there but VACUOUS**: the right-hand side is $0$ while $\lambda=\sqrt{3/2}$. Skew conference matrices exist only for $n\equiv0\bmod4$, which is why the witness appears at $4$ and $8$.

#### And the obstruction is a norm budget, so it is frame-free

*The same reviewer, and this is the part that generalises.* $K$ is symmetric with $K\mathbf1=0$, so on $\mathbf1^\perp$ it is trace-free with Frobenius square $t\le2$, giving $\mu_1\le\sqrt{t(n-2)/(n-1)}$. **Any** bound of the shape $\lambda\le c\,\mu_1$ therefore reaches $\theta_0(n)$ only if $c^2t\le2(n-1)^2/n^2$, and at the natural constant $c=\tfrac{n-1}n$ that forces $t=2$, which is **exactly the diagonal locus**, with equality. Verified: $\mu_1$ attains the cap and $\lambda=\tfrac{n-1}n\mu_1$ to $2\times10^{-16}$ at every balanced sphere product. Off the locus the required constant blows up, $2.22$, $2.92$, $3.60$ at $\mathbb{CP}^{3,4,5}$, and $\ge1.36$ even after optimising the frame.

**So the vertex matrix is a complete instrument on the diagonal locus and a provably incomplete one off it, and the reason is a Cauchy–Schwarz budget rather than any particular failed inequality.** *This is what closes the route, and it supersedes "both corrections are non-negative", which is false, at $\mathbb{CP}^{2,3,4,5}$ the term named as the driver, $\lVert G_{\mathrm{off}}\rVert^2$, is exactly zero, and $\sum R_{ab}v_av_b$ is negative in $99$–$100\%$ of random draws because $K\mathbf1=0$ forces $v\perp\mathbf1$.*

## Post F29, $\lambda\le\mu_{\max}(K)$ in a fixed frame cannot bound $\theta$, because $\lambda$ is $O(n)$-invariant and $\mu_{\max}(K)$ is not

#### Why it does not extend, and the reason is FRAME-DEPENDENCE, not sign

*Reviewer 125 refuted the mechanism first recorded here while confirming the verdict; the corrected account follows, reproduced independently.*

**There are five corrections, not two:**

$$\lambda\mu_K-\mu_K^2=\underbrace{\lVert G_{\rm off}\rVert^2}_{\ge0}+\underbrace{v^{\mathsf T}Rv}_{\text{unsigned}}-\underbrace{\mathrm{Dir}}_{\ge0}-\underbrace{\Sigma_A}_{\ge0}-\underbrace{\Sigma_B}_{\text{unsigned}},$$

with $\mathrm{Dir}=v^{\mathsf T}(D-K^{\circ2})v$ a graph-Laplacian form and $\Sigma_A=\sum_av_a^2\lVert A^a_{\rm off}\rVert^2$. **"Both corrections are non-negative and add" is false**, and at padded $W_{\mathbb{CP}^2}$ even the middle term $\sum\operatorname{tr}((C^{pq}h)^2)=-1/6$ is negative, so term-by-term positivity is unavailable anywhere, and it fails hardest exactly where it was claimed: at $\mathbb{CP}^3$ and $\mathbb{CP}^4$, the only points cited for it, $\lVert G_{\rm off}\rVert^2=\Sigma_A=0$ **exactly**, and $76\%$ and $62\%$ of the excess is $-\Sigma_B$, a term never named. And $v^{\mathsf T}Rv$ is *negative* at random Weyl tensors (confirmed here at $58/60$, $60/60$, $59/60$, $60/60$ for $n=5,6,7,8$) so the claimed direction is the minority outcome.

**What actually closes the route is that $\mu_{\max}(K)$ is not an invariant of $W$.** $\lambda$ is $O(n)$-invariant; $K$ depends on the frame. At $S^3\times S^3$ the bound $\lambda\le\mu_{\max}(K)$ holds in the canonical frame, $1.264911$ against $\lambda=1.054093$, and over $3000$ random frames it holds in **one**, with median $\mu_{\max}(K)=0.3031$ and minimum $0.0708$. *A "bound" that survives in one frame in three thousand is a statement about the frame.* The sign-free version of the same fact: $t=2-2\sum R\le2$ with equality only on the diagonal locus, so $\mu_{\max}(K)\le\sqrt t$, and the bound would need $\sum R\le1-\lambda^2/2\approx0.25$ against measured $0.92$–$0.97$.

#### What fence post F29 closes, and what it leaves open

It closes **$\lambda\le\mu_{\max}(K)$ in a fixed frame**, false at five critical points by factors $2.2$–$5.9$, and *not* every route through the vertex equation. **Still open and unused:** a **general** test vector rather than $K$'s top eigenvector. On the diagonal locus a general $v$ upgrades the scalar statement to the matrix one $K^2-\lambda K\succeq0$, i.e. **$K$ has no eigenvalue in $(0,\lambda)$**, strictly more than the diagonal proof extracts. Other contractions of the vertex equation are also untried.

*The top eigenvector is load-bearing only at the division step, and it needs $\mu_{\max}(K)>0$, which hollowness gives via $\operatorname{tr}K=0$. The bottom eigenvector forces the corrections negative with no computation, since $\lambda\mu_{\min}<0<\mu_{\min}^2$ (which by itself refutes "both non-negative") but yields the vacuous $\lambda\ge\mu_{\min}$.*

#### The lift needs no projection, and the obstruction to it is named

**Derived on paper; the check below is a check of a derivation, not its source.**

The source routes through $Z(h)$, the Weyl projection of $h_{ik}h_{jl}-h_{il}h_{jk}$. **That detour is unnecessary.** The map $R\mapsto\mathring R$ is *linear*, so applying it to $Q(W)=\lambda W$ gives

$$(W^2)^{\!\circ}+(W^{\#})^{\!\circ}=\lambda\,\mathring W,$$

and evaluating at a unit bottom eigenvector, $\mathring Wh=-\mu h$:

$$\boxed{\ \lambda\mu\;=\;-\big\langle (W^2)^{\!\circ}h,h\big\rangle\;-\;\big\langle (W^{\#})^{\!\circ}h,h\big\rangle\ }$$

exactly, with no projection and no inequality spent. This is the honest non-diagonal counterpart of the diagonal identity $\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$.

**THE OBSTRUCTION, and it is why the diagonal proof does not lift as written.** The diagonal argument works because there the $W^2$ term contributes *exactly* $\mu^2$: $v$ is an eigenvector of $S$, so $v^{\mathsf T}S^2v=\mu^2$. The lift would need the same, i.e.

$$(W^2)^{\!\circ}\;=\;(\mathring W)^2,$$

**and that is false.** $W^2$ is a composition of operators on $\Lambda^2$, while $\mathring W$ acts on $S^2_0$; the two live on different summands and composition in one does not descend to the other. In indices, $\langle(W^2)^{\!\circ}h,h\rangle=\tfrac12\sum W_{ikpq}W_{pqlj}h_{kl}h_{ij}$ against $\lVert\mathring Wh\rVert^2=\sum_{ij}(\sum_{kl}W_{iklj}h_{kl})^2$, different contractions of the same pair of $W$'s.

**The diagonal case is special precisely because both pictures collapse onto one vertex matrix there**, so $v$ is simultaneously an eigenvector of the $\Lambda^2$ operator and of the second-kind one. Off the diagonal locus they are different vectors in different spaces.

#### THE DIAGONAL ARGUMENT LIFTS: $\lambda\mu=\mu^2-\mathrm{LOSS}$ at every critical point, in closed form

**Derived on paper, then checked**, exact at every critical point tested, and it *correctly fails* at a non-critical Weyl tensor, which is the control confirming criticality is load-bearing. **Gate 2 owed.**

Set, for each index pair $(p,q)$,

$$u^{pq}_{ik}:=W_{ikpq}\in\mathfrak{so}(n),\qquad C^{pq}_{ij}:=W_{ipjq},\qquad N_{ik}:=\sum_{m,p,q}W_{impq}W_{kmpq}\succeq0 .$$

Applying the linear map $R\mapsto\mathring R$ to $Q(W)=\lambda W$ and evaluating at a unit bottom eigenvector $\mathring Wh=-\mu h$ gives $\lambda\mu=-\langle(W^2)^{\!\circ}h,h\rangle-\langle(W^{\#})^{\!\circ}h,h\rangle$, and both pieces have closed forms:

$$\big\langle (W^2)^{\!\circ}h,h\big\rangle=\tfrac14\sum_{pq}\lVert[u^{pq},h]\rVert_F^2-\tfrac12\operatorname{tr}(Nh^2),\qquad \big\langle (W^{\#})^{\!\circ}h,h\big\rangle=\sum_{pq}\Big[\operatorname{tr}\big((C^{pq}h)^2\big)-\langle C^{pq},h\rangle^2\Big].$$

**The second sum is $\mu^2$ exactly**, and that is the step that makes it a lift: $C^{pq}_{ij}=W_{ipjq}=-W_{pijq}$, so $\langle C^{pq},h\rangle=-(\mathring Wh)_{pq}=\mu h_{pq}$ and $\sum_{pq}\langle C^{pq},h\rangle^2=\mu^2\lVert h\rVert^2=\mu^2$. Hence

$$\boxed{\ \lambda\mu=\mu^2-\mathrm{LOSS},\qquad \mathrm{LOSS}=\tfrac14\sum_{pq}\lVert[u^{pq},h]\rVert_F^2+\sum_{pq}\operatorname{tr}\big((C^{pq}h)^2\big)-\tfrac12\operatorname{tr}(Nh^2)\ }$$

**the exact non-diagonal counterpart of the diagonal $\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$**, with every term explicit in $W$ and $h$ and no inequality yet spent.

#### The literature does not carry branch 1, and the search is recorded so it is not repeated

Branch 1 compares a **first-kind** eigenvalue $\lambda$ to the bottom of the **second-kind** spectrum. The four stored second-kind sources, [Li 2021](../references/li-2021-nonnegative-second-kind/), [Li 2022](../references/li-2022-product-manifolds-second-kind/), [Li 2024](../references/li-2024-sphere-theorems-second-kind/), [Dai–Fu 2023](../references/dai-fu-2023-einstein-second-kind/), relate the two kinds only through **$\alpha$-nonnegativity implications** (Li 2021 Theorem 1.8: $n$-nonnegative of the second kind implies $(k(n-k)+1)$-nonnegative for every $1\le k\le n-1$), which is a cone-membership statement and carries no spectral comparison. A web sweep for an eigenvalue inequality between the kinds returns Dirac-operator estimates and Bochner conditions, nothing on point. **The inequality has to be proved here.**

#### On the Kähler family the two branches are exactly complementary, and $\theta\mu$ has a closed form

**PROVED, from the published second-kind spectrum, it was recorded as an observation and is now a derivation.**

$$\theta\cdot\mu\;=\;\frac1{m-1}\qquad\text{at }\mathbb{CP}^m .$$

| $m$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ |
|---|---|---|---|---|---|---|
| $\theta$ | $1.2247449$ | $1.0540926$ | $0.9860133$ | $0.9486833$ | $0.9249625$ | $0.9085135$ |
| $\mu$ | $0.8164966$ | $0.4743416$ | $0.3380617$ | $0.2635231$ | $0.2162250$ | $0.1834498$ |
| $\theta\mu$ | $1$ | $1/2$ | $1/3$ | $1/4$ | $1/5$ | $1/6$ |

**The proof, and it needs no external quotation.** On $\mathbb{CP}^m$ the Fubini–Study tensor gives $\mathring R=\mathrm{Id}+3\mathcal J$ on $S^2_0$, where $\mathcal Jh=JhJ$ satisfies $\mathcal J^2=\mathrm{Id}$, so the spectrum is $\{4,-2\}$ immediately, with multiplicities $m(m+1)$ on the complex-symmetric part and $m^2-1$ on the trace-free Hermitian part. *Reviewer 133 derived this in one line; [Bourguignon–Karcher 1978](../references/bourguignon-karcher-1978-pinching/) agree and are now corroboration rather than a dependency, which matters because that paper's published pair carries the *opposite* sign, [BK](../references/bourguignon-karcher-1978-pinching/) contracts slots 1 and 3, so its operator is $-\mathring W$ and its §5.3 table reads $-4$ at $n(n+1)$ against Li's $+4$.* **The $iklj$ order is likewise determined rather than chosen**: it is the order making the round sphere satisfy $\mathring R=+\mathrm{Id}$ on $S^2_0$, a one-line check against $S^n$. And $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$ is an **identity** for every Weyl tensor, following from the first Bianchi identity, not a normalisation convention. Passing to the trace-free part subtracts $c=\mathrm{trace}/\dim=2(m+1)^2/((2m-1)(m+1))=2(m+1)/(2m-1)$, so $\mathring W$ has bottom $-2-c=-6m/(2m-1)$ and top $4-c=6(m-1)/(2m-1)$, with

$$\lVert\mathring W\rVert_F^2=\frac{36\,m(m+1)(m-1)}{2m-1}.$$

Normalising to $\lVert\mathring W\rVert_F^2=3$ gives $\boxed{\ \mu(\mathbb{CP}^m)=\sqrt{\tfrac{3m}{(m^2-1)(2m-1)}}\ }$, *reached independently by Gate 2 reviewer 132, so two routes agree.* With the record's $\theta^2=(m+1)(2m-1)/\big(3m(m-1)\big)$ ([algebra.md](algebra.md)),

$$\theta^2\mu^2=\frac{(m+1)(2m-1)}{3m(m-1)}\cdot\frac{3m}{(m^2-1)(2m-1)}=\frac{m+1}{(m-1)(m^2-1)}=\frac1{(m-1)^2}. \qquad\blacksquare$$

*Two independent checks:* the closed forms reproduce the measured table at $m=2,\dots,7$ to seven digits; and $\mathrm{LOSS}=\mu^2-\theta\mu$ gives $2/3-1=-1/3$ at $\mathbb{CP}^2$, matching the $\mathrm{LOSS}(\mathbb{CP}^2)=-1/3$ already on file.

**What it settles about branch 1.** Substituting $\mu=1/((m-1)\theta)$, branch 1 at $\mathbb{CP}^m$ would require $\theta^2\le\tfrac{2m-1}{2m(m-1)}$, against the actual values:

| $m$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ |
|---|---|---|---|---|---|---|
| $\theta^2$ | $1.5000$ | $1.1111$ | $0.9722$ | $0.9000$ | $0.8556$ | $0.8254$ |
| branch 1 needs $\le$ | $0.7500$ | $0.4167$ | $0.2917$ | $0.2250$ | $0.1833$ | $0.1548$ |

**So branch 1 fails on the entire Kähler family, by a factor of two at $m=2$ and by a widening margin after.** *It fails there for a reason that does not threaten the dichotomy: every $\mathbb{CP}^m$ has $\theta\le\sqrt{3/2}$, with equality exactly at $\mathbb{CP}^2$, so branch 2 covers the whole family and $\mathbb{CP}^2$ sits precisely on the boundary between the two branches.* **The two branches are exactly complementary here, and that is why the $\max$ is not removable.**

#### Branch 1 has never been tested where it does any work, and that is a fact about the catalogue

**Branch 1 is only *needed* above $\sqrt{3/2}$**, below it branch 2 covers the point outright.

**Within the symmetric class, "above $\sqrt{3/2}$" forces a two-factor round-sphere product, and that is a THEOREM the record already owns**, not an enumeration. *Gate 2, reviewer 133, which is also the correction: two successive attempts to establish this by listing values were both incomplete. The first scanned the index only; the second claimed a full walk of [findings/](.) and still missed $S^{12}\times S^{12}$ at $1.325498$, **the record's own maximum**, written twice in [graded-half.md](graded-half.md), along with $1.248376$ and $1.270978$ from [route-a.md](route-a.md) and some sixty splits in all. A census is the wrong instrument here and is dropped.* The residue outside that class is the ungraded population, whose ceiling is $0.900828$, far below the threshold.

*A falsifier was hunted for and does not exist:* numerically across the whole record, symbolically over every closed-form family on its admissible range, and by construction, orthogonal sums obey $1/\theta^2=\sum1/\theta_i^2$ and therefore **always lower** $\theta$, so no direct sum can climb above the threshold.

**And branch 1 is an EQUALITY at every sphere product**, a theorem rather than a table: on the locus $\omega=d$ exactly and $\mu_1(K)=n\lambda/(n-1)$, giving $\lambda=\tfrac{n-1}n\mu$ identically for all $p,q\ge2$ (*Gate 2, reviewer 132*). Confirmed above the threshold where it matters, $S^5\times S^7$ and $S^6\times S^6$ both to $10^{-15}$, criticality residual $2\times10^{-15}$.

**So every point at which branch 1 is required is a point at which it holds with zero margin.** *The stronger reading (that a point where branch 1 does non-trivial work would be a counterexample), is **FALSE**, and was mine: a critical point with $\sqrt{3/2}<\theta<\theta_0(n)$ and branch 1 strict is no counterexample at all, since the conjecture only asserts $\theta\le\theta_0(n)$. Reviewer 133.* What survives is the weaker and still useful statement: branch 1 is saturated on the whole product family, so **no lossy step is available in any proof of it**.

**And the saturation has a structural cause, which removes the vertex matrix from the story entirely.** *Reviewer 133.* At **any** Einstein product of round spheres with $k\ge2$ factors, the trace directions inside $S^2_0$ carry $\mathring R=-\lambda_E$ exactly, giving $\mu/\theta=n/(n-1)$ **identically**. So branch 1 is saturated **at reducibility**, and needs no vertex matrix to see it. *The same fact explains the Kähler failure in one stroke: $\mathbb{CP}^m$ is irreducible, so it has no such trace direction, and branch 1 fails there.* **Reducible saturates, irreducible fails, that is the mechanism, and it is a statement about structure rather than about a catalogue.**

#### The dichotomy's two branches ARE reducible versus irreducible, and on the symmetric class both are proved

Composing two results the record already holds:

| | hypothesis | conclusion | source |
|---|---|---|---|
| **branch 2** | compact **irreducible** symmetric space | $\lVert W\rVert^2\ge\tfrac16$, i.e. $\theta\le\sqrt{3/2}$, attained only at $\mathbb{CP}^2$ | [graded-half.md](graded-half.md), from Petersen–Stanfield |
| **branch 1** | **reducible**, Einstein product of round spheres, $k\ge2$ factors | $\mu/\theta=n/(n-1)$ **identically**, so branch 1 holds with equality | *Gate 2, reviewer 133*: the trace directions in $S^2_0$ carry $\mathring R=-\lambda_E$ exactly |

**So on the symmetric class the dichotomy is not a conjecture, it is a theorem, and the case split is reducibility.** An irreducible point is covered by branch 2 because its Weyl norm is bounded below; a reducible one saturates branch 1 because reducibility manufactures the trace directions that force $\mu/\theta=n/(n-1)$. *Neither half needs the vertex matrix, and neither is a statement about a catalogue.*

**That locates the entire remaining problem outside the symmetric class.** For a non-symmetric critical point neither hypothesis is available: there is no lower bound on $\lVert W\rVert^2$ to invoke, and no product structure to manufacture trace directions. **The crux is therefore not "prove branch 1" but "handle the non-symmetric population", and every route in [plan.md](../plan.md) reaches exactly that point.** *This is also why the symmetric catalogue has been such a poor guide: the dichotomy is fully proved on it, so no amount of computing there can bear on what remains.*

*Owed, and it would widen branch 1's proved half:* does the trace-direction argument extend from products of round spheres to **any** reducible Einstein product? The mechanism uses only that each factor is Einstein and that $S^2_0$ contains the factor-trace directions, so the obstruction (if any), is in matching the Einstein constants.

#### Branch 1 read as CONCENTRATION, which says what any proof of it must look like

Since $\sum_a\nu_a=0$ and $\sum_a\nu_a^2=\lVert\mathring W\rVert_F^2=3$ at unit norm, the bottom eigenvalue obeys $\mu=-\nu_{\min}\le\sqrt3$, and **branch 1 is exactly a statement about how much of the second-kind mass sits at the bottom**: $\lambda\le\tfrac{n-1}n\mu$ can cover a point with $\lambda>\sqrt{3/2}$ only if $\mu>\tfrac n{n-1}\sqrt{3/2}$, i.e. only if the bottom eigenvalue carries $\mu^2/3$ of $\lVert\mathring W\rVert_F^2$.

| | $S^3{\times}S^3$ | $S^3{\times}S^4$ | $S^4{\times}S^4$ | $S^4{\times}S^5$ | $S^5{\times}S^5$ | $S^6{\times}S^6$ |
|---|---|---|---|---|---|---|
| $\lambda$ | $1.054093$ | $1.095445$ | $1.145644$ | $1.171080$ | $1.200000$ | $1.236033$ |
| $\mu$ | $1.264911$ | $1.278019$ | $1.309307$ | $1.317465$ | $1.333333$ | $1.348400$ |
| $\mu\big/\tfrac n{n-1}\lambda$ | $1.0000$ | $1.0000$ | $1.0000$ | $1.0000$ | $1.0000$ | $1.0000$ |
| bottom mass share | $53.3\%$ | $54.4\%$ | $57.1\%$ | $57.9\%$ | $59.3\%$ | $\mathbf{60.6\%}$ |

**Branch 1 is an EQUALITY at every sphere product, unbalanced ones included, not merely tight at the balanced family.** That is the constraint on any proof: an inequality saturated on a whole two-parameter family admits **no lossy step anywhere**, every Cauchy–Schwarz, every discarded term, every triangle inequality must be an equality across all of $S^p\times S^q$. *This is the structural reason the five broken Gate 2 rounds broke: each spent slack that the product family has none of.*

**The share tends to $2/3$.** $\theta_0(n)\to\sqrt2$, so $\mu\to\sqrt2$ and $\mu^2/3\to2/3$. At $n=12$ a counterexample needs its bottom second-kind eigenvalue above $59.5\%$ of the mass while the champion sits at $60.6\%$, the two branches of the dichotomy pass within $1.1$ percentage points of each other there, which is what makes the case split delicate rather than routine.

#### It is NOT a reduction: $\mathrm{LOSS}=\mu(\mu-\lambda)$ identically

**Gate 2, Reviewer 122, and it is immediate algebra from the boxed identity itself.** Rearranging $\lambda\mu=\mu^2-\mathrm{LOSS}$ gives

$$\mathrm{LOSS}=\mu^2-\lambda\mu=\mu(\mu-\lambda),$$

so **$\mathrm{LOSS}\ge\mu^2/n$ and $\lambda\le\tfrac{n-1}n\mu$ are one statement written twice**, and every $\mathrm{LOSS}$ value tabulated above is $\mu^2-\lambda\mu$ computed the long way. *The three-term decomposition is a proof **strategy**, not a reduction to anything easier*, the claim that it "reduces the route to one explicit inequality in three concrete quantities" is withdrawn. **This is the same error as [fence post F28](INDEX.md), one cycle later: a quantity that is tight at the extremiser is the original problem.**

**And the follow-on that was proposed is provably dead**, *both reviewers, independently, by different routes.* "Drop the commutator mass" gives $\lambda\le\tfrac12\lambda_{\max}(N)=\sqrt{8/3}=1.632993$ at padded $W_{\mathbb{CP}^2}$ **at every $n$**, exactly $+33.3\%$ over $\sqrt{3/2}$ with $\tfrac12\operatorname{tr}(Nh^2)=\tfrac12\lambda_{\max}(N)$ so *all* the loss is the commutator; and $\lambda\le\mu$ at every balanced sphere product, exactly $+\tfrac1{n-1}$ over $\Theta_n$, verified in closed form at $n=6,8,10,12$. **The commutator mass is load-bearing at both equality families.** *Retired.*

#### And branch 1 fails on an open set, not at one point

This file framed the failure as "$\mathrm{LOSS}<0$ at padded $W_{\mathbb{CP}^2}$", which understates it. Reviewer 121 finds $\mathrm{LOSS}<\mu^2/n$ **on an open neighbourhood of the padded $\mathbb{CP}^2$ orbit at every $n$**, perturbations of size $0.05$–$0.5$, margins $-0.44$ to $-0.21$, *and* at an ordinary $n=5$ critical point at $\theta^2=24/35$, margin $-0.2057$. **$\theta=0.828079$ is the record's own recurring ceiling** for non-diagonal high-$\theta$ hunts, so the failure set reaches a point the project already knows. *And since criticality appears nowhere in $\mathrm{LOSS}$'s three terms, no criticality-free estimate can reach it.*

**The route's remaining margin is nil by construction.** $\mathrm{CD}_n$ is an *equality* on both branches' extremal families (gap $\le7\times10^{-16}$ at $S^6\times S^6$ and at $\mathbb{CP}^2$) so no lossy step is admissible anywhere in a proof of it.

#### And on the target set specifically, $\mathrm{CD}_n$ IS the target

Reviewer 122 showed the second branch is provably vacuous at $n=4$, inert through $n=11$, and first fires at $n=12$ **on the diagonal locus**. The target excludes exactly that locus, so the question is whether $\tfrac{n-1}n\mu$ ever reaches $\sqrt{3/2}$ at a *non-diagonal* point. Over every non-diagonal point this project holds:

| | $\mathbb{CP}^m$, $m=2\dots6$, all paddings | $S^k\times S^k\perp\mathbb{CP}^2$, $n=10,12,14$ |
|---|---|---|
| $\tfrac{n-1}n\mu$ | $0.198$–$0.748$ | $0.863$–$0.884$ |

**Branch two fires at $0$ of $11$**, maximum $0.884$ against $\sqrt{3/2}=1.2247$. So on everything on record, $\mathrm{CD}_n$ restricted to the target set reads $\lambda\le\sqrt{3/2}$, **the target verbatim**, with the second branch contributing nothing.

*What this does and does not establish.* It does not prove $\mathrm{CD}_n$ is vacuous on the target: a non-diagonal critical point with $\mu>\tfrac n{n-1}\sqrt{3/2}$ would give the branch work to do, and none is known either way. What it establishes is that **no point anyone has produced distinguishes $\mathrm{CD}_n$ from the target**, so adopting it buys a mechanism with no demonstrated content. *Recorded as the honest status of item 1 rather than as a closure.*

#### What survives, and two of it are upgrades#### What survives, and two of it are upgrades

- **The identity itself**, at every eigenvector, is correct, steps 1–5 rederived by hand at Gate 2, residuals $\le3\times10^{-17}$.
- **A criticality-free form**: $\mathrm{LOSS}(h)=\mu^2+\langle Q(W)^{\!\circ}h,h\rangle$ holds at **every** Weyl tensor and every eigenvector, not only critical ones. *The "control" recorded earlier tested the $\lambda\mu$ form, not the identity.*
- **$\mathrm{LOSS}=\mu^2/n$ at $S^p\times S^q$ is now a THEOREM for all $p,q\ge2$**, proved at Gate 2 twice over, symbolically by reducing $W$ to three scalars on $\Lambda^2V_1\oplus V_1\wedge V_2\oplus\Lambda^2V_2$, and by Cauchy–Schwarz from $\mathrm{LOSS}=\sum_{i<j}s_{ij}^2(v_i-v_j)^2$ on the diagonal locus. **But the equality family is strictly larger than the sphere products**, Reviewer 121 exhibits non-sphere-product, non-critical $4+4$ block tensors at $n=8$ with exact equality, so equality does *not* characterise them.
- $\mathrm{LOSS}(h)$ depends on $h$ only through its eigenvalue, and $\sum_a\mathrm{LOSS}(h_a)=\lVert\mathring W\rVert_F^2=3$.

#### An unstated hypothesis the chain needed

Step 1 uses $\mathring{(\cdot)}$ applied to $Q(W)=\lambda W$, but criticality on the sphere in $\mathrm{Weyl}_n$ gives only $\Pi_{\mathcal W}Q(W)=\lambda W$, and $\Pi_{\mathcal W}$ **does not commute with the ring map**. The step is saved because $Q(W)$ is automatically Ricci-flat for Weyl $W$ (residual $\le7\times10^{-17}$, $n=4$–$7$), *a fact the derivation used silently and never stated.*

#### The $W^2$ term in closed form, and what it leaves#### The $W^2$ term in closed form, and what it leaves

**Derived, then checked**, residual $\le3\times10^{-16}$ at seven points including random Weyl tensors.

Write $u^{pq}\in\mathfrak{so}(n)$ for the matrix $(u^{pq})_{ik}=W_{ikpq}$. Since $(W^2)_{ijkl}=\tfrac12\sum_{pq}W_{ijpq}W_{pqkl}$,

$$\big\langle (W^2)^{\!\circ}h,h\big\rangle=\tfrac12\sum_{pq}\operatorname{tr}\big((u^{pq}h)^2\big).$$

For $A$ antisymmetric and $h$ symmetric, $Ah=\tfrac12[A,h]+\tfrac12\{A,h\}$ with $[A,h]$ **symmetric** and $\{A,h\}$ **antisymmetric**, so the cross trace vanishes and $\operatorname{tr}((Ah)^2)=\tfrac14(\lVert[A,h]\rVert_F^2-\lVert\{A,h\}\rVert_F^2)$. Their sum is $4\lVert Ah\rVert_F^2=4\operatorname{tr}((-A^2)h^2)$, so eliminating the anticommutator gives

$$\boxed{\ \big\langle (W^2)^{\!\circ}h,h\big\rangle=\tfrac14\sum_{pq}\big\lVert[u^{pq},h]\big\rVert_F^2\;-\;\tfrac12\operatorname{tr}(Nh^2),\qquad N_{ik}:=\sum_{m,p,q}W_{impq}W_{kmpq}\ }$$

with $N$ **positive semidefinite** and $\operatorname{tr}N=\lvert W\rvert^2$, both checked. *Numerically $\operatorname{tr}N=4$, not $1$, since $\lvert W\rvert^2=4\lVert W\rVert_F^2$ under this file's $\Lambda^2$ normalisation.* Dropping the commutator mass,

$$-\big\langle (W^2)^{\!\circ}h,h\big\rangle\ \le\ \tfrac12\operatorname{tr}(Nh^2)\ \le\ \tfrac12\lambda_{\max}(N).$$

**Combined with the criticality identity**, $\ \lambda\mu\le\tfrac12\lambda_{\max}(N)-\langle(W^{\#})^{\!\circ}h,h\rangle$. *So the whole route now rests on the $\#$ term alone*, **and that sentence is the R14 pattern, unflagged until [ELIM-target](../reviews/ELIM-target.md)**: substituting $(W^\#)^{\!\circ}=\theta\mathring W-(W^2)^{\!\circ}$ cancels $\lambda\mu$ from both sides and returns exactly the $W^2$ bound spent one line earlier. *The display is true and carries nothing.*, which is what [fence post F1](fence-posts.md) has always said carries the value, and it is the alignment term that no invariant sees.

#### One step of this was WRONG and the check caught it

$N$ is **equivariant, not invariant**: $N(gWg^{\mathsf T})=gN(W)g^{\mathsf T}$. **But at $n=4$ it is a multiple of the identity for *every* Weyl tensor**, the classical $C_{ipqr}C_{jpqr}=\tfrac14\lvert C\rvert^2\delta_{ij}$, confirmed here to $1.6\times10^{-16}$ at random $\mathrm{Weyl}_4$ and at $\mathbb{CP}^2$ itself (Reviewer 122, correcting this line). It fails only from $n\ge5$: relative deviations $0.25$–$0.58$ at random tensors and at padded $W_{\mathbb{CP}^2}$. The first version of this derivation asserted $N=\lvert W\rvert^2I/n$ from an "$O(n)$-invariance" argument and read it off symmetric examples. *This is the sample-varies-in-the-feature rule: an object built from $W$ transforms with $W$, so a pattern across symmetric points is a property of the symmetry.* At padded $W_{\mathbb{CP}^2}$, $h$ is a top eigenvector of $N$ and $\tfrac12\operatorname{tr}(Nh^2)=\tfrac12\lambda_{\max}(N)=\tfrac12$ exactly, at every $n$.

**$N$ has no name found in the search**, and none in this record; recorded as notation rather than as a discovery.

**So the work is the defect $(W^2)^{\!\circ}-(\mathring W)^2$**, and the two terms of the boxed identity are what must be bounded, the $W^2$ term from below by something near $\mu^2$, and the $\#$ term by whatever the alignment allows. *That is where this route's content sits, and nothing in the source addresses it: its own attempt at the same gap, the metric-action gap, is paused with the decisive estimate missing.*

#### CANDIDATE: the second-kind bottom eigenvector as a test direction, and a dichotomy shape the fence posts do not cover, Gate 2 owed

**Reported in outside material (unpublished, held in the private record); the identity was rebuilt and verified here, the dichotomy screened.** Let $h$ be a unit bottom eigenvector of $\mathring W$ on $S^2_0$, $\mathring Wh=-\mu h$, and $Z(h)$ the Weyl projection of $h_{ik}h_{jl}-h_{il}h_{jk}$. Then

$$\langle W,Z(h)\rangle=\tfrac\mu2\quad\text{exactly},$$

verified at $S^3\times S^3$, $S^3\times S^4$, $S^4\times S^4$ and padded $W_{\mathbb{CP}^2}$ to $10^{-15}$ in the repo's own second-kind convention. At a critical point this gives $\langle Q(W),Z(h)\rangle=\lambda\mu/2$, **the non-diagonal lift of the diagonal step $\lambda\mu=\mu^2-\sum s^2(v_i-v_j)^2$**, and it uses the eigenvector, not an invariant, so it passes the filter every closed route failed.

**The dichotomy $\mathrm{CD}_n$**: $\lambda\le\max\{\sqrt{3/2},\ \tfrac{n-1}n\mu\}$ at every critical point. With the projection estimate $\tfrac{n-1}n\mu\le\Theta_n$, **proved at both parities**, the even half by the eigenvalue-spread cap at [bispectral.md](bispectral.md) and the odd half by the vertex-space Cauchy--Schwarz there, which is where the two once diverged, *exactly tight at every balanced product here, ratio $1.0000$*, it closes the conjecture. **Where each branch holds on the catalogue:**

| point | $\lambda$ | $\tfrac{n-1}n\mu$ | branch |
|---|---|---|---|
| every $S^p\times S^q$ | $=\tfrac{n-1}n\mu$ **exactly** |, | second-kind, with equality |
| $\mathbb{CP}^m$, $m=2\dots6$, any padding | $\le1.2247$ | $0.20$–$0.75$ | $\sqrt{3/2}$ only |
| $S^k\times S^k\perp\mathbb{CP}^2$, $n=10,12,14$ | $0.80$–$0.86$ | $0.86$–$0.88$ | both |

**What it is and is not.** On the catalogue $\mathrm{CD}_n$ never bites: every point with $\lambda>\sqrt{3/2}$ is a sphere product, where the second branch is an equality. So as a *statement* it is the target plus a named mechanism; its content is the claim that at a hypothetical non-diagonal point above $\sqrt{3/2}$, the bottom eigenvector of $\mathring W$ is a good enough test direction. The source's own attempt at that (a "metric-action gap"), is **paused with the decisive estimate missing**. What this project has that it lacks: the bi-spectral identity, the per-row identity, the $g$-vector machinery, and Lemma L24.

#### Criticality is a hypothesis of the target, and dropping it makes the statement false

**Gate 2, Reviewer 118, reproduced here independently.** Written as $\sup\{\theta:S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$ over the unit sphere, which is how this file, [findings/INDEX.md](INDEX.md), [plan.md](../plan.md) and [bounds.md](bounds.md) all carried it, the claim is **false at every even $n\ge12$**.

**The argument is a dimension count, not a search.** At $n=12$ the $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$-graded subspace of $\mathrm{Weyl}_{12}$ has dimension **$834$** of $1638$, and $S\equiv0$ on all of it, since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ holds identically there. The coordinate-diagonal locus (hollow symmetric with vanishing row sums), has dimension $\binom{12}2-12=\mathbf{54}$, **derived at [Lemma L177](diagonal-half.md)**, $K_{12}$ is connected and non-bipartite, so its unsigned incidence matrix has full rank $12$ and the locus is that matrix's kernel. **So the non-diagonal $S=0$ points fill an $834$-dimensional space around $S^{6}\times S^{6}$**, $\theta$ is continuous, and $\theta(S^6\times S^6)=\theta_0(12)=1.236033>\sqrt{3/2}$.

Explicitly, perturbing inside that subspace by $10^{-3}$: $\theta=1.236031$, $S_{\mathfrak{mmm}}=2\times10^{-28}$, non-diagonal, and **criticality residual $1.3\times10^{-3}$**, the point is not critical, which is exactly the hypothesis that was missing.

**What this costs and what it does not.** The intended statement (over *critical* points), is untouched, and it is the one the Route R2 architecture and the plan's own falsifier line always carried. What was wrong is every written form of it, and a reviewer briefed from those forms is auditing a false statement. *The lesson is the one the skill already states about narrowings and inherited claims: a target carried across cycles is an assertion, and its hypotheses are the first thing to lose.*


#### The $\xi$-Gram form of $\theta$, an exact reformulation, and where Xu's route loses

*Filed here rather than as a fence post: Reviewer 94 is right that it is an exact reformulation, not a closed route.* Xu's (2.53) and (2.54) are **identities**, so with $M=\sum_{p,q,r,s}\xi^{pqrs}\otimes\xi^{pqrs}$, positive semidefinite, $\operatorname{tr}M=16(n-1)\lVert W\rVert^2$, $\operatorname{tr}(WM)=-16\langle Q(W),W\rangle$, Conjecture A is exactly

$$\big\lvert\operatorname{tr}(W\widehat M)\big\rvert\le\frac{\theta_0(n)\lVert W\rVert}{n-1}\sim\frac{\sqrt2}n\lVert W\rVert,\qquad\widehat M=M/\operatorname{tr}M .$$

Xu's (2.55) supplies only $\approx\lVert W\rVert$, needed/used is $0.2108$, $0.1124$, $0.0688$, $0.0280$ at $n=6,12,20,50$, so **that route owes a factor growing like $n/\sqrt2$**, and the $M$-form also deletes a triangle-inequality step his chain carries. Closing it means using that $M$ is *quadratic in $W$*. As a restatement it is Conjecture A rewritten, neither easier nor harder; its value is the measurement.

#### The Rayleigh matrix, exactly, and the fence post that closes the obvious route to it

#### Four identities, each proved

In an eigenbasis $\{v_\alpha\}$ of $W$, writing $b_{\alpha\beta}=[v_\alpha,v_\beta]$ and expanding $\sum_\gamma\langle b_{\alpha\beta},v_\gamma\rangle^2\lambda_\gamma=\langle Wb_{\alpha\beta},b_{\alpha\beta}\rangle$:

1. $M_{\alpha\beta}=\tfrac12\langle W[v_\alpha,v_\beta],[v_\alpha,v_\beta]\rangle$ off the diagonal, the entries are basis-free in the pair of eigenvectors.
2. $M_{\alpha\alpha}=\lambda_\alpha$ **exactly**, since $[v,v]=0$: the diagonal of $M$ is the spectrum itself.
3. $\operatorname{tr}M=\operatorname{tr}W=0$, so $M$ is trace-free and $\lambda_{\max}(M)\ge0$.
4. $\sum_\beta M_{\alpha\beta}=\lambda_\alpha-\tfrac12\operatorname{tr}\big(W\,\mathrm{ad}(v_\alpha)^2\big)=0$, **the per-row Ricci identity gives $\operatorname{tr}(W\,\mathrm{ad}(v_\alpha)^2)=2\lambda_\alpha$, so $M\mathbf 1=0$ exactly** ([ELIM-target](../reviews/ELIM-target.md), verified here). *The useful upgrade: $M$ is hollow-corrected with zero row sums, so the $K$-matrix norm budget applies to it verbatim.*

All four screen at $10^{-16}$, alongside $\langle\lambda,M\lambda\rangle=P$ and $M\lambda=\theta\lambda$ at a critical point.

#### $\theta$ IS a named invariant: $\Theta_3=-2\,\theta$, the stable cubic of the graphical calculus. THE CONSTANT WAS RECORDED AS $32$ AND IS WRONG BY A FACTOR OF $16$ AND A SIGN

[Weingart arXiv:2404.16355](../references/graphical-calculus-stable-invariants-2024/notes.md) Lemma 6.2 defines $\Theta_3(R):=g_{\Lambda^2\otimes\Lambda^2}(q(R)\star R,\,R)$ with $q(R)\star:=\tfrac14\sum_{\mu\nu}(dE_\mu^\sharp\wedge dE_\nu^\sharp)\star\,R_{E_\mu,E_\nu}\star$. **The proportionality with a universal constant, at every $n$, with no Ricci correction, is CONFIRMED** by both Gate 2 reviewers independently, that is the mathematically substantive part and it stands. The value is not $32$:

$$\Theta_3(W)=-2\,\theta(W).$$

Both reviewers pinned every sign using Weingart's *own* calibration identities, $q(R)\star X=\tfrac12\mathrm{Ric}\,X$ on the defining representation (residual $3\times10^{-17}$; the opposite sign misses by $0.44$) and $q(R)\star=\tfrac12\mathrm{Der}_{\mathrm{Ric}}-R^{\mathrm{alt}}$ on $\Lambda^2$ (residual $2\times10^{-15}$; opposite sign misses by $22$), and Reviewer 69 added two more: $q(R)\star$ on $\Lambda^p$ of the round sphere returning $p(n-p)/2\cdot\mathrm{Id}$, and $q(R)\star R=0$ as a **full tensor** on five locally symmetric spaces. Reviewer 70 corroborated through Hamilton: the paper's eq (46) $Q(R)$ satisfies $q(R)\star R=-Q_{\mathrm{Ham}}(R)$ on Ricci-flat tensors with $\tfrac14\langle Q_{\mathrm{Ham}},R\rangle=2\theta$, i.e. $Q_{\mathrm{Ham}}=2(W^2+W^\#)$, the expected Ricci-flow reaction term. The error in [b_theta3_identification.py](../scripts/lib/b_theta3_identification.py) localises exactly:

| convention | ratio to $\theta$ |
|---|---|
| paper's $\tfrac14$, $\{e_i\wedge e_j\}_{i<j}$ orthonormal | $-2$ |
| naive full 4-index contraction | $-8$ |
| drop Definition 6.1's $\tfrac14$ (what the script did) | $-32$ |
| also flip the sign of $R_{E_\mu,E_\nu}$ (what the script did) | $+32$ |

#### The magnitude is convention-dependent; the sign is not

it survives flipping the sign convention for $R$, since $\Theta_3$ is cubic. *Weingart is internally inconsistent about it*: Lemma 6.2 writes $\Theta_3:=+g(q(R)\star R,R)$ and line 2154 writes $-$; Definition 6.1 is the self-consistent one, confirmed by Hamilton's flow direction. **Fence post F19's conclusion flips on this sign, so the convention in use must always be named.**

**A NEW IDENTITY AND THE FIRST BOUND OF THE SHAPE THE ROUTE NEEDS**, found by both reviewers independently and absent from the record. From $A(W)=2W$ and the definition of $\#$, in two lines,

$$\sum_\gamma\lambda_\gamma\,g_\gamma=-4\,\theta(W),\qquad g_\gamma:=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2,$$

verified to 12 digits at $n=5,6,7,8,10$. Combined with $g_\gamma\ge0$ and $\sum_\gamma g_\gamma=4(n-1)$, Reviewer 69 obtained

$$\theta\ \le\ |\lambda_{\min}|\cdot\frac{4(n-1)-\Delta-G_0}{4},\qquad G_0:=\sum_{\gamma\in\ker W}g_\gamma$$

**an upper bound on $\theta$ decreasing in $\Delta$, which is exactly the shape [plan.md](../plan.md)'s target asks for.** Verified at 13 points, with **equality at every symmetric-space point** ($S^3\times S^3$, $S^6\times S^6$, $S^5\times S^7$, $\mathbb{CP}^3$, $\mathbb{CP}^4$, padded $\mathbb{CP}^2$) and slack only where $\Delta>0$ (the $C_5$ blow-up: $0.671$ against $0.894$) or at random points ($\approx0$ against $\approx1.2$). Equality holds exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace, *every eigenvector above the bottom is an infinitesimal symmetry*. **Its weakness is that $|\lambda_{\min}|$ is uncontrolled**, so it converts the open question from one variable to two, $(\Delta,\lambda_{\min})$. That is the live lead.

#### The $(\mathfrak{su}(m),\mathfrak{so}(m))$ derivation generalises to EVERY symmetric pair, giving $\theta$ in four Lie-theoretic invariants

Nothing in it used $\mathfrak{su}(m)$, only that $(\mathfrak g,\mathfrak k)$ is a symmetric pair inside $\mathfrak{so}(n)$. With $p=\dim\mathfrak k$, $q=\dim\mathfrak m$ and the two-eigenvalue graded ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ ($ap+bq=0$, $a^2p+b^2q=1$, so $a^2=q/(p(p+q))$):

$$\boxed{\ \theta^2=\frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}\ }$$

with **$S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ identically for any symmetric pair**, confirmed on 16 pairs across four Cartan series. *The record's gloss that this "is what puts the class in the target set" had the mechanism backwards* (Gate 2): $(\mathfrak{so}(2k),\mathfrak{so}(k)+\mathfrak{so}(k))$ is a symmetric pair with $S=0$ whose two-eigenvalue point is **exactly the Weyl tensor of $S^k\times S^k$**, at $\theta_0(2k)^2=2-3/k+1/k^2$, which **exceeds $\sqrt{3/2}$ from $k=6$ on** and tends to $\sqrt2$. **So the class contains $S=0$ points above the threshold, and what excludes them from the live target is DIAGONALITY, not $S$.** For $\mathfrak g$ simple with Killing constant $c$ (meaning $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$), summing over an orthonormal basis of $\mathfrak k$ gives

$$S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=c\,p,$$

so $\theta$ depends on only **four** invariants of the pair: $p$, $q$, $S_{\mathfrak{kkk}}$, $c$. **Verified against the one family derived independently**: for $(\mathfrak{su}(m),\mathfrak{so}(m))$ with $S_{\mathfrak{kkk}}=(m-2)p$ and $c=2m$, the relation gives $S_{\mathfrak{kmm}}=(m+2)p$, which equals $mq$ identically, and the general formula returns $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$, matching exactly ([b_symmetric_pair_general.py](../scripts/route-b/b_symmetric_pair_general.py)).

#### And $c$ is classical table data, not a free parameter, this part is a THEOREM, not a fit

$B=2h^\vee(\,,)_{\rm norm}$ and $\mathrm{tr}_{\mathbb R}\rho(X)\rho(Y)=2I_\rho(\,,)_{\rm norm}$ give $\langle X,Y\rangle=-I_\rho(\,,)_{\rm norm}$, hence $c=2h^\vee(\mathfrak g)/I_\rho$ in two lines. Gate 2 added four independent exact checks with $c$ computed intrinsically as $-B/\langle,\rangle$: $G_2\subset\mathfrak{so}(7)$ as the 14-dimensional stabiliser of the octonionic 3-form gives $8$; $\mathfrak{so}(3)$ on $\mathrm{Sym}^2_0(\mathbb R^3)$ (where the index is far from 1, the sharpest test), gives exactly $2/5$; and every adjoint rep gives $2$ identically.

#### Two corrections

*The index normalisation was mis-stated by a factor 2*: the quoted $I=1,1,2$ are **half** the standard Dynkin index of the complexified representation ($2,2,4$), so **anyone applying the rule with indices from Slansky or LiE gets every $c$ wrong by a factor 2**. Correct: $c=4h^\vee/D_{\rho\otimes\mathbb C}$, or $c=2h^\vee/I$ with $I$ normalised so the $\mathfrak{so}(n)$ vector has index 1. And *$S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ fails whenever $\mathfrak k$ is not simple*: a centre contributes nothing since $[\mathfrak z,\mathfrak k]=0$, and **every Hermitian symmetric pair has a centre in $\mathfrak k$**, witness $(\mathfrak{so}(6),\mathfrak u(3))$, where $S_{\mathfrak{kkk}}/p=48/9=16/3$ and $h^\vee(\mathfrak u(3))$ is undefined. The correct form is $S_{\mathfrak{kkk}}=\sum_i c_i\dim\mathfrak k_i$ over the simple ideals. The rule as stated reproduces:

| $\mathfrak g$, $\rho$ | $h^\vee$ | $I_\rho$ | $c=2h^\vee/I_\rho$ | known |
|---|---|---|---|---|
| $\mathfrak{so}(n)$, standard | $n-2$ | $1$ | $2(n-2)$ | the record's $\rho_\alpha=\lVert\mathrm{ad}\,v\rVert_F^2$ |
| $\mathfrak{su}(m)$, $\mathbb C^m_{\mathbb R}$ | $m$ | $1$ | $2m$ | derived here |
| $\mathfrak{so}(m)\subset\mathfrak{su}(m)$, $\mathbb R^m\oplus\mathbb R^m$ | $m-2$ | $2$ | $m-2$ | $S_{\mathfrak{kkk}}=(m-2)p$ |

#### "A finite arithmetic problem over Cartan's list" is OVERSTATED, and it misses the hard step

The ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ is **generically not a Weyl tensor at all**: of 16 pairs Gate 2 built, only **three** pass Ricci-flat + Bianchi + criticality, $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{so}(2k),\mathfrak{so}(k)+\mathfrak{so}(k))$ and $(\mathfrak{su}(2),\mathfrak{so}(2))$. $(\mathfrak{so}(2m),\mathfrak u(m))$ and $(\mathfrak{sp}(2),\mathfrak u(2))$ fail Bianchi; $(\mathfrak{so}(p+q),\mathfrak{so}(p)+\mathfrak{so}(q))$ with $p\ne q$ fails Ricci-flatness. Trace-freeness is necessary and far from sufficient. **The real content of "which pairs threaten $\sqrt{3/2}$?" is which $(\mathfrak g,\mathfrak k,\rho)$ give a Weyl operator at all**, a question the record never posed.

#### And [Reviewer 81](../reviews/REVIEW_r81.md) showed the reduction cannot work even in principle, twice over

*Here $p,q$ are the SPHERE dimensions, not [L39](#lemma-l39-the-two-eigenvalue-formula-for-an-arbitrary-symmetric-pair)'s $\dim\mathfrak k,\dim\mathfrak m$, the two senses sit in one file.* *Admissibility is provably not a function of the four invariants*: $(\mathfrak{so}(6),\mathfrak{so}(2){+}\mathfrak{so}(4))$ and $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2){+}\mathfrak u(2)))$ have **identical** $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})=(7,8,24,32)$ and identical $\theta^2=9245/8232$, yet fail differently, Ricci $0.69$/Bianchi $0$ against Ricci $0$/Bianchi $0.345$. *And $\rho$ is a free infinite parameter*: $(\mathfrak{su}(2),\mathfrak u(1))$ on 1, 2, 3 copies of $\mathbb C^2$ keeps $(p,q)=(1,2)$ while $\theta^2$ runs $3/2,\ 2/3,\ 25/54$. Finally, **$\mathfrak g$ semisimple with non-isomorphic factors has no single $c$**, $\mathfrak{so}(3){+}\mathfrak{so}(5)$ in $\mathfrak{so}(8)$ gives $c\in\{2,6\}$ and the Killing relation fails outright. **The unrestricted maximum over the class is $\sqrt2$, not $\sqrt{3/2}$.** *Scope, stated plainly:* the **two-eigenvalue** ansatz only. $\mathbb{CP}^m$ and $\mathbb{HP}^2$ have three distinct eigenvalues, are not of this form, and still need their own arguments.

#### Reviewer 78's $Q_3$, $Q_5$, $Q_6$ were MISLABELLED, and this record propagated the error for one commit

*Gate 2, [Reviewer 80](../reviews/REVIEW_r80.md); verified here by building $SO(5)/(SO(2)\times SO(3))$ from Lie data.* The real complex quadrics are nothing like what was recorded:

| | as recorded | exact truth | $S_{\mathfrak{mmm}}$ |
|---|---|---|---|
| $Q_3=G_2(\mathbb R^5)$ | $\sqrt{6/5}=1.095445$, $S=0$ | $\theta^2=\mathbf{15/26}$, $\theta=0.759554525$ | $\mathbf{30}$ |
| $Q_5=G_2(\mathbb R^7)$ | $1.035098$, $S\approx0$ | $\theta^2=\mathbf{45/92}$, $\theta=0.699378606$ | $\mathbf{252}$ |
| $Q_6=G_2(\mathbb R^8)$ | $1.024695$, $S\approx0$ | $\theta^2=\mathbf{33/70}$, $\theta=0.686606562$ | $\mathbf{480}$ |

Reviewer 80 built $Q_3$ three independent ways, $SO(5)/(SO(2)\times SO(3))$, $Sp(2)/U(2)$, and a uniform $G_2(\mathbb R^k)$ family validated at $k=4,6$, all giving $15/26$; the independent check here reproduces $0.759554525$ and $S=30.000000$ to nine digits. **So "$Q_3$ beats $\mathbb{CP}^3$" is false**, it sits far below. The quadrics are Weyl and exactly critical; they simply have $S\ne0$.

#### What survives, because it was verified directly rather than taken from the review

The $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family is real, built from this record's own `su_m_family`: non-diagonal ($\dim\ker\Phi_W=1$), $S_{\mathfrak{mmm}}\le2\times10^{-29}$, critical to $5\times10^{-16}$, with

$$\theta^2=\frac{T}{T-1}=\frac{\dim\mathfrak m+1}{\dim\mathfrak m},\qquad T=\binom{m+1}{2},$$

**and it is now DERIVED, symbolically in $m$, not pattern-matched.** The two-eigenvalue graded ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ with $ap+bq=0$ and $a^2p+b^2q=1$, $p=\dim\mathfrak k=\binom m2$, $q=\dim\mathfrak m=T-1$. **Two of the four block masses vanish identically**, from the symmetric-pair relations $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$: $S_{\mathfrak{kkm}}=0$ and $S_{\mathfrak{mmm}}=0$, the second is *why* $S=0$ holds on the whole family. The survivors are integers with closed forms, $S_{\mathfrak{kkk}}=(m-2)p$ (the Killing form of $\mathfrak{so}(m)$) and $S_{\mathfrak{kmm}}=mq$. Then $\theta=\mathrm{tr}(W^3)+\tfrac12[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}]$, and eliminating $b=-ap/q$, $a^2=q/(p(m^2-1))$ gives **exactly**

$$\theta^2=\frac{m(m+1)}{(m-1)(m+2)}=\frac{X}{X-2},\qquad X=m(m+1)=2T,$$

whose difference from $T/(T-1)$ simplifies to $0$ identically in $m$. **Monotonicity is then immediate**: $X/(X-2)$ strictly decreases in $X$, so $\theta$ **decreases in $m$** and $\theta\to1$.

#### THE CAP WAS RECORDED WRONG, and the correction is structural rather than numerical

*Gate 2, [Reviewer 82](../reviews/REVIEW_r82.md); verified here.* Because $\theta$ decreases in $m$, the family's maximum is at its **smallest** member, and the construction runs verbatim at $m=2$, where $p=\dim\mathfrak{so}(2)=1$, $q=2$, and it yields a genuine Weyl operator: Ricci-flat, Bianchi, critical, **non-diagonal**, $S=0$, at $\theta=1.224744871$. The closed form at $m=2$ is exactly $\mathbf{3/2}$. **The record's "$\sup_m\theta=\sqrt{6/5}$ at $m=3$" silently started the family at $m=3$ and never said why.**

#### And that $m=2$ member is $W_{\mathbb{CP}^2}$ itself

identical eigenvalues $(0.816497,-0.408248,-0.408248,0,0,0)$, its $\mathfrak k$ and $\mathfrak m$ being $\mathrm{span}\{e_{01}+e_{23}\}$ and $\mathrm{span}\{e_{02}-e_{13},e_{03}+e_{12}\}$, a $\mathfrak u(1)$ in the self-dual $\mathfrak{su}(2)$. **So the scope claim "$\mathbb{CP}^m$ is not of this form" is false at exactly the member that sets the threshold.** ($\mathbb{CP}^m$'s $P_{\mathfrak{su}}$ coefficient $(m-2)/((m+1)(2m-1))$ vanishes *only* at $m=2$.)

#### What this costs and what it buys

It costs the cap: **the class's own supremum is $\sqrt{3/2}$, attained, so this formula can never bound the class strictly below the target.** What it buys is better than a cap, a *structural* statement: **the conjectured equality case $W_{\mathbb{CP}^2}$ is the smallest member of a natural infinite family, and $\theta$ decreases monotonically along it.** The equality case is no longer an isolated coincidence. What is withdrawn is only the claim that this family **is** Reviewer 78's $Q_m$, those labels were wrong, and the nine-digit "match" was against values that do not belong to the quadrics.

**The characterisation is still refuted, by $\mathbb{HP}^2$ alone**, and its certificate is analytic rather than numerical: its top eigenspace is spanned by the quaternionic structures $I,J,K$, and every nonzero $aI+bJ+cK$ is an invertible quaternion, hence of bivector rank $8$. **The record's rank certificate is structurally blind to this**, it inspected only *simple* eigenvalues, and this eigenvalue has multiplicity 3.

#### The mechanism, and why it cannot break the bound

$\mathbb{HP}^2$ and $S^3\times S^5$ are **isospectral** at $n=8$ (identical Weyl spectra and identical $\theta=\sqrt{56/45}$) as are $\mathbb{CP}^4$ and $S^2\times S^6$ at $\theta^2=35/36$. These are **triality pairs**: the outer automorphism of $\mathfrak{so}(8)$ preserves the bracket (hence $\#$) and the inner product (hence $W^2$), so it preserves $\theta$ and $S$ while lying outside $O(8)$, one member diagonal, the other not. That is exactly how a point escapes the "$\mathbb{CP}^m$ + paddings + sums" list, **and it exists only at $n=8$**, where the diagonal maximum is $S^4\times S^4$ at $\sqrt{21/16}=1.145644<\sqrt{3/2}$.

#### The sum law is stronger than recorded, and the stronger form is a real reduction

$\circ$-orthogonality is **automatic** ($[\mathfrak{so}(n_1),\mathfrak{so}(n_2)]=0$ kills the polarised $\#$); $Q$ maps block-supported operators into the same block, so criticality of the sum **forces** criticality of each summand rather than assuming it; and $S(W)=S(W_1)+S(W_2)$. Hence $\tfrac1{\theta^2}=\tfrac1{\theta_1^2}+\tfrac1{\theta_2^2}$ and $|\theta|<\min(|\theta_1|,|\theta_2|)$ strictly. **So the supremum over the non-diagonal $S=0$ set is attained at block-indecomposable points, and sums may be dropped from the search entirely.** As previously worded ("the entire summed family is capped with no enumeration"), it was circular, capping a sum only by its summands.

#### Two claims struck for want of evidence

`reviews/REVIEW_r78.md` was **never written**, and this file linked to it twice, so the $\sim20$-subalgebra sweep and the 3000-start Newton run have no artefact. And "154 distinct critical values at $n=6$, none with $S=0$" is **false**: $\mathbb{CP}^3$ is an $n=6$ critical point with $S=2\times10^{-30}$ and $\theta^2=10/9$ exactly. Reviewer 80 reproduced the artefact, 1200 starts, 651 converged, maximum $\theta$ found $0.408$, $\mathbb{CP}^3$ never appearing. **Random-start Newton on $\mathrm{Weyl}_6$ does not reach the high-$\theta$ basin, so such an enumeration is evidence of completeness in neither direction.** *The bound still stands on Reviewer 80's own 26-space hunt, where $S=0$ holds only at $\mathbb{CP}^m$ and $\mathbb{HP}^2$ and nothing exceeds $\sqrt{3/2}$.*

#### And "$\mathbb{CP}^m$'s symmetry explains the equality case" is OVERSTATED

$\mathbb{HP}^2$ also has $\dim\mathrm{Weyl}^{\mathfrak k(W)}=1$ ($\mathfrak k=\mathfrak{so}(5)\oplus\mathfrak{so}(3)$, $\dim13$) and is **not** the maximum. The one-line mechanism explains **criticality**, not **maximality**; maximality still rests on Lemma L28's closed form plus the census.

#### The non-diagonal census's CHARACTERISATION is refuted; its BOUND survives

*Gate 2, Reviewer 78 (report never filed; see [reviews/REVIEW_r80.md](../reviews/REVIEW_r80.md)); verified here.* The claim "the non-diagonal $S=0$ points are $\mathbb{CP}^m$, its paddings and $\circ$-orthogonal sums" is **wrong**, at least four families lie outside it:

| point | $n$ | $\theta$ | $S_{\mathfrak{mmm}}$ | diagonality |
|---|---|---|---|---|
| $\mathbb{HP}^2=Sp(3)/(Sp(2)\!\cdot\!Sp(1))$ | 8 | $1.115546702=\sqrt{56/45}$ | $9\times10^{-29}$ | **non-diag**, $\ker\Phi=1$ |
| $(\mathfrak{su}(3),\mathfrak{so}(3))$ | 6 | $1.095445115=\sqrt{6/5}$ | $1\times10^{-31}$ | non-diag |
| $(\mathfrak{su}(5),\mathfrak{so}(5))$ | 10 | $1.035098339$ | $6\times10^{-30}$ | non-diag |
| $(\mathfrak{su}(6),\mathfrak{so}(6))$ | 12 | $1.024695077$ | $2\times10^{-29}$ | non-diag |

*The last three rows were originally attributed to the complex quadrics $Q_3$, $Q_5$, $Q_6$. **That attribution is refuted**, the real quadrics have $\theta^2=15/26$, $45/92$, $33/70$ with $S=30,252,480$ (see above). The points at these values are the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family, and $\mathbb{HP}^2$ is the only member of this list outside it.*

#### The claim "$Q_3$ beats $\mathbb{CP}^3$ at the same $n$" is WITHDRAWN

the real $Q_3$ sits at $0.7596$, far *below* $\mathbb{CP}^3$'s $1.0541$. What does hold at $n=6$ is that the $(\mathfrak{su}(3),\mathfrak{so}(3))$ point reaches $1.0954$, above $\mathbb{CP}^3$, so "$\mathbb{CP}^m$ tops the non-diagonal points at each $n$" is still false, but by a different witness than the one recorded.

#### The bound is untouched

Reviewer 78 searched $\sim20$ subalgebras $K\subset\mathfrak{so}(n)$ for $n\le12$ with a full critical-point solve inside each invariant space, plus a 3000-start Newton enumeration on the sphere of $\mathrm{Weyl}_6$ (154 distinct critical values, **none** with $S=0$), and found nothing above $\sqrt{3/2}$. **$\sup\{\theta:S=0,\text{ non-diagonal}\}=\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$, survives.**

#### And it supplies the one-line reason $\circ$-orthogonal sums can never threaten it

For $W=aW_1\oplus bW_2$ on complementary blocks, criticality forces $a\theta_1=b\theta_2=\theta$ with $a^2+b^2=1$, i.e.
$$\frac1{\theta^2}=\frac1{\theta_1^2}+\frac1{\theta_2^2}\quad\Longrightarrow\quad\theta<\min(\theta_1,\theta_2)\ \text{strictly},$$
so the entire summed family is capped by $\theta(\mathbb{CP}^2)$ with no enumeration at all.

#### A correctness bug in the decision procedure, now fixed

$\mathbb{CP}^2{+}\mathbb{CP}^2$ embedded in $n=12$ returned `undetermined`: no simple eigenvalue, so the rank certificate is silent, and $\dim\ker\Phi=12=n$, so the dimension certificate is silent. **The `undetermined` branch misread its own theorem**, criterion (b) is an *iff*, and the distinct-sum locus is Zariski-open, non-empty exactly when $W$ is diagonal, so repeated failure of random draws proves non-diagonality with probability 1. Every $A$ in that kernel has $a_1=a_2=a_3=a_4$ (spread $1.1\times10^{-16}$), hence $a_1+a_2=a_3+a_4$ identically and no distinct-sum $A$ can exist. **The census was silently folding `undetermined` into "diagonal" and would have dropped such points from the target set.**

#### Two of this record's own claims corrected

Fence post F22's table quoted $\theta$ at two operators with criticality residual $0.58$ and $0.41$, so "an order of magnitude spread" was unsupported *on the critical set*, but the conclusion is **strengthened**, not weakened, by a one-line argument: $\delta_{\mathrm{Id}}(X)=2X$, so $\mathrm{Id}\in\ker\Phi_W$ always, and $\dim\ker\Phi_W=1$ forces $\ker\Phi_W=\mathbb R\cdot\mathrm{Id}$ *exactly*, $\mathbb{CP}^3$ and $\mathbb{CP}^5$ have literally the same kernel, so no refinement of it can track $\theta$. And "the equality case is symmetry-forced" holds **only at unpadded $\mathbb{CP}^m$**: $\dim\mathrm{Weyl}^{\mathfrak k(W)}$ is $2$ at padded $\mathbb{CP}^2$ (the equality case at $n=8,10,12$), $3$ at padded $\mathbb{CP}^3$, $4$–$9$ at the sums, and $2$ at $Q_3$, $Q_5$, $Q_6$. **$\dim\mathrm{Weyl}^K=1$ is sufficient for criticality and far from necessary.**

#### $\mathbb{CP}^m$ is critical *because* its symmetry pins it: $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$

([b_cpm_symmetry_isolated.py](../scripts/route-b/b_cpm_symmetry_isolated.py)) Measured as the nullity of $W\mapsto[\mathrm{ad}(X),W]$ over a basis of $\mathfrak u(m)=\{X\in\mathfrak{so}(2m):XJ=JX\}$ restricted to $\mathrm{Weyl}_n$: **$1$ of $10$, $1$ of $84$, $1$ of $300$** at $m=2,3,4$. So $\mathbb{CP}^m$ is the *unique* $U(m)$-invariant Weyl tensor up to scale, and criticality then follows **with no computation**, $Q$ is $O(n)$-equivariant, so $Q(W)$ is again $U(m)$-invariant, hence a multiple of $W$.

#### This explains the census's equality case rather than observing it

The extremal problem restricted to $U(m)$-invariant tensors is *zero-dimensional*, so $\theta$ is a function of $m$ alone, which is exactly the closed form $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, maximised at $m=2$ at exactly $\tfrac32$, cited to [algebra.md](algebra.md), whose Fox derivation covers every even $r=2m$ **from $r=4$**, *at $r=2$ the closed form has $m=1$ in its denominator and $\theta$ is undefined, so the range once written here as $r\ge2$ overstated it by one member*, rather than to [Lemma L28](nondegeneracy.md), which is stated from $m\ge3$. The maximum of the non-diagonal $S=0$ census being $\sqrt{3/2}$ at $W_{\mathbb{CP}^2}$ is therefore forced, not coincidental.

#### A correction to the recorded subalgebra family's reading

Item 12 asks for $(\Lambda^4\mathbb R^n)^K=0$ **and** $\dim\mathcal W_n^K=1$, concluding a *two-eigenvalue* critical point. $\mathbb{CP}^m$ has **three** eigenvalues and is outside that family, yet it is critical, because **the equivariance argument uses only $\dim\mathcal W_n^K=1$**. The $(\Lambda^4)^K=0$ hypothesis is doing other work there; it does not carry criticality.

*What this does not buy, stated so it is not mistaken for progress:* nothing about non-diagonal $S=0$ points with **no** symmetry, which is where the target's proof has to live.

## Post F22, $\ker\Phi_W$ decides diagonality but carries no information about $\theta$, so it cannot characterise the target set's maximum

Reviewer 75's operator $\Phi_W(A)=[W,\delta_A]$, $\delta_A(X)=AX+XA$, is the first frame-independent grip the programme has had on diagonality, and the plan named it as the handle for *characterising* the non-diagonal $S=0$ critical set rather than enumerating it. **Measured, it does not track $\theta$:**

| | $\dim\ker\Phi_W$ | $\theta$ |
|---|---|---|
| $\mathbb{CP}^2,\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ | $1,1,1,1$ | $1.2247$, $1.0541$, $0.9860$, $0.9487$ |
| **random Weyl**, $n=6,8$ | $1,1$ | $0.0879$, $0.0353$ |
| $\mathbb{CP}^2{+}\mathbb{CP}^2$, $\mathbb{CP}^2{}^{\times3}$ | $2,3$ | $0.8660$, $0.7071$ |
| padded $\mathbb{CP}^2$ ($n=8$), padded $\mathbb{CP}^3$ | $11$, $4$ | $1.2247$, $1.0541$ |
| $S^5\times S^7$, $S^6\times S^6$, $C_5$ | $43,42,15$ | $1.2282$, $1.2360$, $0.6708$ |

$\dim\ker\Phi_W=1$ is the **generic** value, it holds at every $\mathbb{CP}^m$ *and* at random Weyl tensors, whose $\theta$ differ by an order of magnitude. So the invariant separates diagonal from non-diagonal cleanly and separates nothing else. **Use it to define the target set, not to bound $\theta$ on it.** *The literature carries $\delta_A$ as standard machinery, the derivation extension of a symmetric endomorphism, as in [the standard Laplace operator's](https://arxiv.org/pdf/1708.04775) $\mathrm{Ric}(h)(X,Y)=-h(\mathrm{Ric}X,Y)-h(X,\mathrm{Ric}Y)$, but not $\ker\Phi_W$ as a diagonality criterion, which appears to be Reviewer 75's.*

#### The coverage census is REFUTED, and so is the B-band target it served

*Gate 2, [Reviewer 75](../reviews/REVIEW_r75.md) and [Reviewer 76](../reviews/REVIEW_r76.md), agreeing independently.*

#### 1. The target is false

$S^5\times S^7$ at $n=12$: $\theta=1.228239158>\sqrt{3/2}$, $\dim\mathfrak m=35<36$, $S_{\mathfrak{mmm}}=0$ exactly, critical at $4\times10^{-16}$. Reviewer 76 built it over $\mathbb Q$ and found $Q(W)$ exactly diagonal with $Q(W)_{aa}/W_{aa}=\tfrac{11}{35}$ at all 66 entries, so $\theta^2=\tfrac{264}{175}$ and the excess is $\tfrac3{350}$, no floating point is load-bearing. Both reviewers derived $\theta^2(S^p\times S^q)=\frac{2(p-1)(q-1)(n-1)}{pq(n-2)}$ independently. **$25$–$28$ catalogued band points exceed $\sqrt{3/2}$ at $n\le24$**, maximum $1.324617$ at $S^{11}\times S^{13}$, *above* the recorded ceiling by $8.2\%$, not $3.2\%$ below it. Detail at [b_band_target_refuted.py](../scripts/route-b/b_band_target_refuted.py).

#### 2. The census's own falsifier fires, padded $\mathbb{CP}^3$ is covered by nothing

The gradedness test $S_{\mathfrak{mmm}}=S_{\mathfrak{mpp}}=0$ is correct **only when $\ker W=0$**, because $T_{abc}$ is totally symmetric. Four rows have large kernels, and the full block decomposition over $(\mathfrak p,\mathfrak m,\mathfrak z)$ gives $T_{\mathfrak{mzz}}=24$ at padded $\mathbb{CP}^3$, $[\mathfrak z,\mathfrak z]$ hits $\mathfrak m$, and **no assignment of the kernel yields a $\mathbb Z_2$-grading**. Likewise $32$, $140$, $96$ at the three direct sums (which keep B2). So padded $\mathbb{CP}^3$ has **no B1** (non-diagonal, proved), **no B2** ($\dim E(1)=1$), **no H**, a band point covered by none of the three. *This is exactly the trap [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py)'s own header warns about, and the census reported the kernel dimension without using it.*

#### 3. "Covered by B1" is a different inequality from the target

B1's grant is $\sup\{\theta:S=0,\text{diagonal}\}<\theta_0(n)$, strictly weaker than $\sqrt{3/2}$ at every $n\ge12$, and $S^5\times S^7$ is B1-covered *and* above the threshold. The B1 column could never have delivered the band target. Similarly the **entire H column is vacuous**: all twelve rows have $\theta<\sqrt{3/2}$, where H's hypothesis is false.

#### 4. Two counting errors

"Four of the twelve band points live at $n=8,10$", it is **nine** (or five on the coverage reading). And twelve hand-picked points is not a census of a set containing an infinite family.

#### What survives, and it is a real gain

Reviewer 75 supplied the **necessary-and-sufficient** diagonality test this record lacked: with $\delta_A(X)=AX+XA$ and $\Phi_W(A)=[W,\delta_A]$, *$W$ is diagonal in some frame iff some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$*, with the hard certificate $\dim\ker\Phi_W<n\Rightarrow$ non-diagonal. Installed at [b_frame_independent_diagonality.py](../scripts/lib/b_frame_independent_diagonality.py); it decides every catalogued row and **removes "undetermined" entirely**. *Implementing only the dimension corollary was not enough, that wrongly called padded $W_{\mathbb{CP}^2}$ diagonal, contradicting its own rank-4 simple eigenvector; the distinct-sums search is load-bearing.* The test also re-proves the correction to Reviewer 74 **without appeal to construction**: applied to a generic $SO(10)$ rotation of the $C_5$ blow-up with no knowledge of provenance, it returns diagonal and reconstructs a frame at $3.5\times10^{-15}$.

#### And the band is asymptotically extremal, not "nearly tight"

$\theta/\theta_0(n)$ along $S^{n/2-1}\times S^{n/2+1}$ runs $0.9937$, $0.9976$, $0.9988$, $0.9997$, $0.99996$ at $n=12,16,20,30,60$, with $\theta^2\to2$. There is no gap between the middle of the band and the cap in either coordinate, so the "two horns, not a slope" picture is wrong.

#### The claim that the band's hard stratum has no known witness is RETRACTED, it is inhabited by $\mathbb{CP}^m$ for every $m\ge3$, which sits in this record's own tables

*Gate 2, [Reviewer 73](../reviews/REVIEW_r73.md); verified here with the repository's unmodified [dim_E1](../scripts/lib/b_band_witness_census.py) and [full_profile](../scripts/lib/b_circulant_band_witnesses.py).*

| point | $n$ | $\theta$ | $\dim\mathfrak m$ | cap | $S_{\mathfrak{mmm}}$ | $\dim E(1)$ | off-diagonal |
|---|---|---|---|---|---|---|---|
| $\mathbb{CP}^3$ | 6 | $1.054093$ | $6$ | $9$ | $1.0\times10^{-30}$ | $\mathbf 1$ | $0.263523$ |
| $\mathbb{CP}^4$ | 8 | $0.986013$ | $12$ | $16$ | $4.8\times10^{-30}$ | $\mathbf 1$ | $0.197203$ |
| $\mathbb{CP}^5$ | 10 | $0.948683$ | $20$ | $25$ | $7.5\times10^{-29}$ | $\mathbf 1$ | $0.158114$ |

Every condition is provable rather than measured. $\dim\mathfrak m=m(m-1)=\dim\mathfrak{so}(2m)-\dim\mathfrak u(m)$, so $\mathfrak m$ is the tangent space of the symmetric pair $SO(2m)/U(m)$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak u(m)\perp\mathfrak m$, giving $S=0$; $3\le m(m-1)<m^2=\lfloor(2m)^2/4\rfloor$ for every $m\ge3$; the top eigenvalue is simple with the **Kähler form** as eigenvector, of bivector rank $2m\ge6$, so $W$ is non-diagonal *in every orthonormal frame*, not merely the coordinate one; and $\dim E(1)=1$ with a wide margin, the next $L_e$ eigenvalue being $0.625$ and $0.600$.

#### A second witness, and it reaches further than $\mathbb{CP}^m$

(Reviewer 74). The $C_5$ blow-up conjugated by a generic $g\in SO(10)$: $\theta=0.670820$, criticality $3.2\times10^{-16}$, $\dim\mathfrak m=20<25$, $S=4.7\times10^{-29}$, $\dim E(1)=1$, max off-diagonal $0.102$. **It is not graded ($S_{\mathfrak{mpp}}=80$, not $0$) so it escapes step H as well as B1 and B2.** *The reason first given here, "because $\Delta=12>0$", is an invalid converse and is withdrawn*: $\Delta=0\Rightarrow$ graded is proved, its converse is not, and a graded critical point with $\Delta=1.512$ is now catalogued at $n=8$ ([bounds.md](bounds.md)). The conclusion survives on $S_{\mathfrak{mpp}}$, which is what actually tests gradedness, whereas $\mathbb{CP}^m$ for $m\ge3$ has $\Delta=0$, $G_0=0$, $\ker W=0$ and $S=0$, hence is graded by this record's own lemma and is already H's territory. Five of the twenty-two circulant band points have $\dim E(1)=1$, so the rotation yields a family rather than a point.

#### And it exposes a definitional bug

The census tested non-diagonality by $\max|W-\mathrm{diag}\,W|$, which is **frame-dependent**, the only frame-dependent condition in the stratum's definition, so any point can be rotated to satisfy it. The correct test is the one $\mathbb{CP}^m$ meets: **the simple top eigenvector has bivector rank $>2$**, which is frame-independent. *The stratum's definition is corrected accordingly.*

#### $\mathbb{CP}^2$ is what hid this

: it escapes at the *lower* end, $\dim\mathfrak m=2<3$, and it was used as the indecomposable control. Meanwhile [findings/INDEX.md](INDEX.md) already stated "$\dim\mathfrak m$ is $\dots6,12$ at $\mathbb{CP}^3$ and $\mathbb{CP}^4$ against caps $9,16$" eleven hundred lines from the claim that nothing catalogued lies in the band.

#### So the proposed split is dead

: the stratum is inhabited by an infinite family, and B1 (diagonal) plus B2 (decomposable) do **not** cover the band. *The band target itself is unthreatened*, $\mathbb{CP}^3$ sits at $1.054093=\theta_0(6)$, below $\sqrt{3/2}$, but the route to it via emptiness is gone. **And the script's docstring overreached further than the record did**: "every constructible band witness is diagonal or $\circ$-decomposable" asserts about *all* constructions what was checked for two.

#### A second, older error surfaced by the same review, and it inverts the band's picture

This file recorded the band's measured values as "low, $0.671$ at the $C_5$ blow-up, and $1.0560$, $1.1315$ from ascent". **Every unbalanced sphere product is in the band and much higher**: $S^4\times S^6$ at $\theta=\mathbf{1.185854}$ ($n=10$, $\dim\mathfrak m=24<25$), $S^3\times S^7$ at $1.133893$, $S^3\times S^5$ at $1.115547$, $\mathbb{CP}^3$ at $1.054093$. Balanced products sit *at* the cap and are outside; unbalanced ones fall one to four short and are inside. **The true measured maximum on the band is $1.185854$, within $3.2\%$ of $\sqrt{3/2}$ and $1.2\%$ of $\theta_0(10)$. The band is nearly tight, not slack**, and the two-horns picture that motivated treating it as slack is wrong.

#### The second-order condition's saturating set is exactly $\{$sphere products$\}\cup\{\mathbb{CP}^2\}$, the conjectured maximiser family plus the one boundary point

Screened across eleven catalogued points ([b_second_order_screen.py](../scripts/lib/b_second_order_screen.py)), $\lambda_{\max}(L_e|_{e^\perp})$ against Lemma L24's $\tfrac12$:

| point | $n$ | $\theta$ | $\theta/\sqrt{3/2}$ | $\lambda_{\max}$ off $e$ | $\#>\tfrac12$ | |
|---|---|---|---|---|---|---|
| $\mathbb{CP}^2$ | 4 | $1.224745$ | $1.0000$ | $0.50000000$ | 0 | saturates |
| $\mathbb{CP}^2$ padded | 8 | $1.224745$ | $1.0000$ | $0.50000000$ | 0 | saturates |
| $S^3\times S^3$ | 6 | $1.054093$ | $0.8607$ | $0.50000000$ | 0 | saturates |
| $S^4\times S^4$ | 8 | $1.145644$ | $0.9354$ | $0.50000000$ | 0 | saturates |
| $S^3\times S^5$ | 8 | $1.115547$ | $0.9108$ | $0.50000000$ | 0 | saturates |
| $S^5\times S^5$ | 10 | $1.200000$ | $0.9798$ | $0.50000000$ | 0 | saturates |
| $\mathbb{CP}^3$ | 6 | $1.054093$ | $0.8607$ | $0.62500000$ | 8 | **violates** |
| $\mathbb{CP}^4$ | 8 | $0.986013$ | $0.8051$ | $0.60000000$ | 15 | **violates** |
| $C_5$ blow-up | 10 | $0.670820$ | $0.5477$ | $\mathbf{1.20601133}$ | 30 | **violates** |
| random | 6 | $0.159833$ | $0.1305$ | $4.88497598$ | 38 | **violates** |
| random | 8 | $0.016496$ | $0.0135$ | $36.79629576$ | 148 | **violates** |

#### Three things this settles

(i) The $C_5$ blow-up, the highest-$\theta$ point on $\{S=0\}$ with $\Delta>0$, and the padding-free witness both Gate 2 reviewers recommended, **is excluded as a global maximiser**, and its $1.20601133$ reproduces the record's independently computed $\lambda_{\max}(M)/\theta=1.206011$. (ii) The violation is not marginal anywhere: the smallest excess among violators is $0.10$ at $\mathbb{CP}^4$ and random points miss by factors of $10$ to $74$. (iii) **$\theta$ does not predict the verdict**, $\mathbb{CP}^3$ and $S^3\times S^3$ share $\theta=1.054093$ exactly and land on opposite sides, so this is genuinely new information, not a repackaging of the value.

#### The $E(\tfrac12)$ multiplicity does NOT refine the discriminator, only $\lambda_{\max}\le\tfrac12$ does

A natural sharpening of the characterisation would add "and $\dim E(\tfrac12)$ equals the orbit dimension". Measured, it separates nothing:

| point | $\lambda_{\max}$ off $e$ | $\dim E(\tfrac12)$ | orbit | excess |
|---|---|---|---|---|
| $\mathbb{CP}^2$, $\mathbb{CP}^2$ padded | $0.50000000$ | $2$, $18$ | $2$, $18$ | $0$ |
| $S^4\times S^4$, $S^3\times S^5$, $S^5\times S^5$ | $0.50000000$ | $16$, $15$, $25$ | same | $0$ |
| $S^3\times S^3$ | $0.50000000$ | $18$ | $9$ | $\mathbf{9}$ |
| $\mathbb{CP}^3$, $\mathbb{CP}^4$ | $0.625$, $0.600$ | $6$, $12$ | $6$, $12$ | $0$ |
| $[3,3,3]$ | $1.00000000$ | $81$ | $27$ | $54$ |

#### Excess $0$ holds on both sides of the discriminator

at the saturating $S^4\times S^4$ *and* at the violating $\mathbb{CP}^3$, $\mathbb{CP}^4$, so it carries no separating information. The two nonzero rows are the already-known exceptions: $S^3\times S^3$ is the degenerate two-block case Lemma L27 excludes at $(3,3)$, and $[3,3,3]$ is $\circ$-decomposable. *So the second-order discriminator is the eigenvalue bound alone, and any attempt to strengthen it through the $\tfrac12$-eigenspace's dimension is closed.* **And excess $\ge0$ is a theorem, not an observation** (Reviewer 71): differentiating $Q(W_t)=\theta W_t$ along an orbit gives $e\circ\dot W=\tfrac12\dot W$, so **every orbit tangent lies in $E(\tfrac12)$**. The excess is therefore exactly "$\tfrac12$-eigenvectors beyond the symmetry directions". Gate 2 adds $[2,2,2,2]$ at excess $96$.

#### The Lemma L24 characterisation is REFUTED, in both directions, and the exception is not confined to $n=8$

*Gate 2, [Reviewer 71](../reviews/REVIEW_r71.md) and [Reviewer 72](../reviews/REVIEW_r72.md), agreeing independently and each reproducing it with this repository's own [Le_matrix](../scripts/lib/review_r34_core.py).* The conjecture, equality in Lemma L24 picks out the $SO(n)$-orbits, up to triality at $n=8$, of two-block sphere products with $p,q\ge3$ together with $\mathbb{CP}^2$, fails because **padded $\mathbb{HP}^2$ saturates at every $n\ge8$**:

| point | $n$ | crit. residual | $\lambda_{\max}(L_e|_{e^\perp})$ | $\#>\tfrac12$ |
|---|---|---|---|---|
| $\mathbb{HP}^2$ | 8 | $1.4\times10^{-15}$ | $0.50000000$ | $0$ |
| $\mathbb{HP}^2$ padded | **10** | $1.4\times10^{-15}$ | $\mathbf{0.50000000}$ | $\mathbf 0$ |
| $\mathbb{HP}^2$ padded | **12** | $1.4\times10^{-15}$ | $\mathbf{0.50000000}$ | $\mathbf 0$ |

**Padded $\mathbb{HP}^2$ does not violate at $1.0172$**, which was the sole ground for confining the triality exception below Conjecture A's range. It came from Weyl-projecting the *full* curvature tensor in dimension $10$, where the Ricci trace runs over $10$ coordinates, a different operator, at $\theta=1.085966$. Padding the $n=8$ Weyl part preserves $\theta=1.11554670$ and preserves criticality, since $(\mathrm{pad}\,W)^\#=\mathrm{pad}(W^\#)$.

#### And it fails the other way too, because padding acts oppositely on the two families

Padded $\mathbb{CP}^2$ and $\mathbb{HP}^2$ saturate; padded *sphere products* (the conjecture's own family), **violate**, at exactly $\tfrac12+\tfrac1{2(n-3)}$: $0.60000000$ for $S^3\times S^3$ at $n=8$, $0.57142857$ for $S^3\times S^5$ and $S^4\times S^4$ at $n=10$, $0.55555556$ for $S^5\times S^5$ at $n=12$. So if padded points are family members the "⇐" direction fails, and if they are not the "⇒" direction fails.

#### What survives

The triality identification is *confirmed*, by a stronger test than was originally run: Reviewer 71 built $\tau$ explicitly as the spin representation on $\Delta_+=\mathbb O$, exactly orthogonal, and the Casimir of the top eigenspace on $\mathbb R^8$ (an $O(8)$ invariant), is $(-2,-2,-2,0^5)$ for $S^3\times S^5$ against $(-\tfrac34)^{\times8}$ for both $\tau(S^3\times S^5)$ and $\mathbb{HP}^2$. Different orbits, related by the outer automorphism. **The exhaustive falsification sweep also stands**: nothing else saturates, $\mathbb{HP}^3$, four Grassmannians, $SO(8)/U(4)$, $Sp(3)/U(3)$, $\mathbb{CP}^5$, $SU(4)/SO(4)$, $SU(3)/SO(3)$, the $\mathfrak{su}(3)$ bi-invariant, and all fourteen $8$-cycle circulants, whose only saturating member is $S^4\times S^4$ itself.

#### Three defects in the screen that produced the original table

(i) Three of the nine $\ge3$-block rows were computed at **non-critical** operators (residuals $0.22$, $0.17$, $0.11$), where Lemma L24 has no content and even the numbers were wrong, honest restriction gives $0.786$, $0.943$, $0.960$ against the recorded $1.179$, $1.132$, $1.112$. (ii) The strip rule kept $e$'s own eigenvalue whenever $\lambda_{\max}>1$, inflating every such count by one: the $C_5$ blow-up is **29**, not $30$. (iii) The counts $9$ and $16$ for $\mathbb{CP}^{3,4}$ are $m^2$ where the truth is $m^2-1$, i.e. **8** and **15**, and this file carried both numbers nine lines apart. *All three are fixed in [b_second_order_screen.py](../scripts/lib/b_second_order_screen.py), which now restricts to $e^\perp$ explicitly and refuses non-critical input through the new [critical_screened](../scripts/lib/weyl_screen.py).* Also: $[3,3,3]$ and $[4,4,4]$ fail **both** clauses of Lemma L24, not simplicity "rather than" the bound; and $[2,6]$ is not an independent row, it is $\mathbb{CP}^4$ under triality.

#### The $W_{\mathbb{CP}^2}$ standing filter is WITHDRAWN, its inference is unsound and its evidence table was padded

*Gate 2, both reviewers, independently.* The filter said: a bound tight at $W_{\mathbb{CP}^2}$ has no room left and cannot separate the band from $\sqrt{3/2}$.

**The inference does not follow**, because $W_{\mathbb{CP}^2}$ is **not in the band**: its spectrum is $(-0.408248^{\times2},0^{\times3},0.816497)$, so $\dim\mathfrak m=2$ at $n=4$ and at every padding, while the band requires $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$. A bound tight at a point outside a set can be strict on the set. **Two counterexamples, one of them the record's own row 1:** the target statement "$\theta\le\sqrt{3/2}$ on the band" is tight at $W_{\mathbb{CP}^2}$ and separates the band by definition, so taken literally the filter rejects the theorem the programme is proving; and Lemma L24 is exactly tight there while nevertheless excluding $\mathbb{CP}^{m\ge3}$, $S^2\times S^{n-2}$, the $C_5$ blow-up and every $\ge3$-block product. More generally any bound $\theta\le\sqrt{3/2}\,f(\dim\mathfrak m)$ with $f(2)=1$ and $f(k)<1$ for $k\ge3$ is tight there and separates.

#### The six rows were really three, one circular

$\theta=\sqrt{3/2}$ is tautological ($\sqrt{3/2}$ *is* that point's value); Lemma L24's $0.500000$ is shared with **six other points**; the Berger row quoted values at $\mathbb{CP}^{3,4}$ under a "value at $W_{\mathbb{CP}^2}$" header *and* those values were wrong; the $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ row is embedding-dependent and fails at padded $W_{\mathbb{CP}^2}$ (ratio $0.3333$); Ge's estimate is vacuous on $\mathrm{Weyl}_n$ by this record's own note; and "$\ker W=0$ fails there" is a category error, being outside a hypothesis is the opposite of a bound being tight.

#### The record also contradicted itself about it within six minutes

: [plan.md](../plan.md) said the second-order condition "cannot separate either", and [b_second_order_screen.py](../scripts/lib/b_second_order_screen.py) said it "PASSES that filter", justified as "strictly slack away from $W_{\mathbb{CP}^2}$", refuted by the table printed directly above that sentence. *What survives is the Simons/Willmore reading:* $W_{\mathbb{CP}^2}$ is the named equality model and the target is a gap statement. **Tightness at an equality model is what a sharp proof looks like, not what a spent one looks like**, which is the opposite of what the filter asserted.

#### A sharp new inequality from the per-row identity: $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ on $\mathrm{Weyl}_n$, with equality exactly at $\mathbb{CP}^m$

Reviewer 70's observation that $A(W)=2W$ is a **per-row** identity, $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$ for *every* $\alpha$, residual $2\times10^{-16}$, failing off $\mathrm{Weyl}_n$, is strictly stronger than the $\lambda_\alpha$-weighted trace the record had been using, and it is not carried by the LP class whose ceiling Reviewers 67/68 closed. Taking $\alpha=\arg\max$ and splitting over $\mathfrak p$, $\mathfrak m$, $\ker$: the $\mathfrak p$-sum is nonnegative, so $\sum_{\mathfrak m}|\lambda_\beta|R_{\alpha_1\beta}\ge2\lambda_{\max}$; then $|\lambda_\beta|\le|\lambda_{\min}|$ and $\sum_{\mathfrak m}R_{\alpha_1\beta}\le2(n-2)$ by **[Lemma L153](bounds.md)**, the constant [post F18](bounds-relaxations.md) also runs on. Three lines give

$$\lambda_{\max}\ \le\ (n-2)\,|\lambda_{\min}| .$$

Never violated across eleven points; **equality to $10^{-16}$ at every $\mathbb{CP}^m$ tested, $m=2\ldots6$** (Gate 2 extended the record's three points), against ratios $0.12$–$0.38$ at the sphere products and the $C_5$ blow-up and $0.14$–$0.31$ at random Weyl tensors ([b_per_row_eigenvalue.py](../scripts/route-b/b_per_row_eigenvalue.py)). Equality forces all three steps tight: the top eigenvector's bracket mass lands **entirely** in $\mathfrak m$, only on the bottom of the spectrum, with no overlap with $\mathfrak p$. **The extremisers are again the Kähler points**, the same ones that set the $\sqrt{3/2}$ threshold and make Berger's inequality near-tight in fence post F21. *It is not the ingredient the $\lambda$-weighted bound needs*, since it bounds $|\lambda_{\min}|$ from **below**; it is recorded because it is sharp, new, and outside the closed class. **Two caveats from Gate 2.** The row marginal $\sum_\beta R_{\alpha\beta}=2(n-2)$ is a *theorem*, not a measurement, $-\mathrm{tr}(\mathrm{ad}\,v_\alpha)^2=-(n-2)\mathrm{tr}(v_\alpha^2)$. And "strictly below $1$ everywhere else" rests on nine points: maximising the ratio over $\mathrm{Weyl}_6$ and $\mathrm{Weyl}_8$ reaches $0.99906$ at $n=6$, so it is **untested rather than proved**. The equality is also embedding-dependent, padded $W_{\mathbb{CP}^2}$ gives $0.3333$, so "sharp at $\mathbb{CP}^m$" means sharp at $n=2m$ only.

#### Lemma L37, diagonality is decided by a single kernel

*Neither direction is argued anywhere in [findings/](.). **The pointer that stood here named a section about the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family, whose only contact with this lemma is one parenthesis applying it.** The proof is below.*

For $W\in\Weyl_n$ let $\delta_A(X)=AX+XA$ for symmetric $A$, and let $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in *some* orthonormal frame if and only if some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$. In particular $\dim\ker\Phi_W<n$ certifies non-diagonality outright. *Diagonal* here means diagonal on the coordinate $2$-planes of the frame.

**Proof.** $\delta_A$ preserves the skew matrices and is the derivation extension $u\wedge v\mapsto Au\wedge v+u\wedge Av$, so in $A$'s eigenframe $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$.

*If $W$ is diagonal in some frame $\{f_i\}$*, take $A=\sum_i2^if_if_i^{\mathsf T}$: its sums $2^i+2^j$ over $i<j$ are pairwise distinct by uniqueness of binary representations (**so the distinctness is achievable at every $n$ and is never a genericity obstruction**) and $\delta_A$ commutes with $W$, both being diagonal in that frame's $\varphi_{ij}$, so $A\in\ker\Phi_W$.

*Conversely*, let $A\in\ker\Phi_W$ have pairwise-distinct sums. **Distinctness of the sums IS simple spectrum on $\Lambda^2$**, the eigenvalues there being exactly the $a_i+a_j$ for $i<j$, so the eigenlines are the $\mathbb R\varphi_{ij}$; *distinctness of the $a_i$ themselves, which follows for $n\ge3$, is needed separately and only to make "$A$'s eigenframe" well defined.* **The two do not imply one another in the other direction** ($A=\mathrm{diag}(0,1,2,3)$ has distinct $a_i$ and repeated sums, spectrum $\{1,2,3,3,4,5\}$) and $[W,\delta_A]=0$ makes $W$ preserve each of them, which is diagonality in $A$'s eigenframe.

*The corollary.* A diagonal $W$ has the whole $n$-dimensional space of matrices diagonal in its frame inside $\ker\Phi_W$, so $\dim\ker\Phi_W<n$ excludes diagonality. **The threshold is $n$ because $A$ ranges over $\mathrm{Sym}^2$**; over $\mathrm{Sym}_0$ it would be $n-1$, and the two must not be interchanged. **It needs neither criticality nor $W\in\mathcal W_n$**, *and neither does the equivalence above it, which holds for every linear operator on $\Lambda^2\mathbb R^n$; the block once scoped that admission to the corollary alone.* **And the corollary is not vacuous**: $\dim\ker\Phi_{W_{\mathbb{CP}^2}}=1<4$ at $n=4$, a value the record holds as a measurement. $\square$

**The $n=2$ case is outside the converse's step and inside the statement.** At $n=2$ there is one pair, so $\mathrm{Id}$ has vacuously distinct sums with $a_1=a_2$ and the step to distinct $a_i$ fails. *The equivalence still holds there, for an unrelated reason*: $\Lambda^2\mathbb R^2$ is a line, so every $W$ is diagonal and both sides are true. **So the statements carry no range and the proof carries the case.**

**The equivalence is generic-or-never at every kernel dimension, and only the corollary is one-directional.** On the linear subspace $\ker\Phi_W$ the distinct-sums condition is the non-vanishing of $D(A)=\operatorname{disc}(\chi_{\delta_A})$, **which is polynomial in $A$ because $A\mapsto\delta_A$ is linear**, *the condition as stated in eigenvalues is not, and the bridge was asserted rather than written*. So $D$ either vanishes identically on $\ker\Phi_W$ or is non-zero on a dense Zariski-open subset of it, and *"some $A$ with distinct sums"* reduces to **one generic test** rather than an $O(n)$ search, including at $\dim\ker\Phi_W=n$ where the corollary says nothing. *"Decided outright" overstated this: what follows is the dichotomy, not a decision procedure.*

**The quantifier is load-bearing.** $\mathrm{Id}\in\ker\Phi_W$ always and has all sums equal, so the criterion must ask for *some* $A$ with distinct sums rather than all. **And the test is frame-independent**: $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$, so both the dimension and the distinct-sums clause are $O(n)$-invariant. *Two conjugations sit under one letter here: $g$ acts on $\Lambda^2$ in $gWg^{-1}$ and on $\mathrm{Sym}^2$ in $g(\ker\Phi_W)g^{-1}$, and $g\in O(n)$ is used throughout and stated nowhere.*

> **BOTH WITNESSES ARE NOW ON FILE, IN CLOSED FORM.** *[Lemma L163](#lemma-l163-l37s-two-witnesses-in-closed-form) gives $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\,\mathrm{Id}$, so the non-vacuity $\dim\ker\Phi_W=1<4$ is derived rather than measured; and $\dim\ker\Phi_{W_0\oplus0}\ge1+\binom{n-m+1}2$, so padded $W_{\mathbb{CP}^2}$ at $n=8$ has $11>8$ while non-diagonal, which is the one-directionality witness.* **Three rows the record held as measurements now follow from the formula.**


#### Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

**Statement.** Let $(\mathfrak g,\mathfrak k)$ be a symmetric pair inside $\mathfrak{so}(n)$ with $\mathfrak g=\mathfrak k\oplus\mathfrak m$ **orthogonal in the ambient $\Lambda^2$ metric**, $p=\dim\mathfrak k\ge1$, $q=\dim\mathfrak m\ge1$, and let $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ be the two-eigenvalue point, **extended by zero on $\mathfrak g^\perp$** and assumed to lie in $\mathcal W_n$. Then $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ and

$$\theta^2=\frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}.$$

**When $\mathfrak g$ is simple with Killing constant $c$, three invariants suffice** ($S_{\mathfrak{kmm}}=cq/2$ and hence $S_{\mathfrak{kkk}}=c(p-q/2)$ are both determined) and the display reduces exactly to

$$\theta^2=\frac{\big(cq(3p-q)-4p(p-q)\big)^2}{16\,p^3q(p+q)},$$

by $3p^2+2pq-q^2=(3p-q)(p+q)$, which pulls one factor of $(p+q)$ out of the numerator. *The record long said $\theta$ depends on $p,q,S_{\mathfrak{kkk}},c$; that is true and one invariant too many, the $\mathfrak k$-row of a two-row system having been used and the $\mathfrak m$-row left unread.* **Keep the four-invariant display as the general statement** (it survives where $\mathfrak g$ is not simple, which this record exercises), **and the three-invariant one wherever simplicity holds.**

**Both vanishings are properties of the decomposition, free of $W$ and of any grading.** $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ kills $S_{\mathfrak{kkm}}$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ kills $S_{\mathfrak{mmm}}$. *$[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ enters neither; it closes the Killing split and is itself a consequence of $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$ with ad-invariance.* **The denominator is produced rather than asserted**, by $a^6=q^3/(p^3(p+q)^3)$.

**Two corollaries.** $q\le2p$ for every symmetric pair with $\mathfrak g$ simple and $c>0$, **with equality exactly when $\mathfrak k$ is abelian**, the smallest admissible pair $(\mathfrak{su}(2),\mathfrak u(1))$ at $(p,q)=(1,2)$ realising it at $\theta^2=\tfrac32$. And at the balanced pair $(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$ with $p=k(k-1)$, $q=k^2$ and $c=4(k-1)$ **forced**, the numerator collapses to $4k^2(k-1)^2(2k-1)$ and the formula returns $\theta^2=\frac{(k-1)(2k-1)}{k^2}=\frac{2(n-1)(n-2)}{n^2}$ exactly. *That needs $k\ge3$: at $k=2$ the pair's $\mathfrak g=\mathfrak{so}(4)$ is not simple, and the $\mathfrak k$-abelian equality case coincides with the same boundary.*

> **WHAT IS OWED: FOUR LOAD-BEARING HYPOTHESES, NONE OF THEM ONCE STATED HERE.** *The $\Lambda^2$ metric normalisation, since $c$ scales inversely with it and $n$ appears nowhere in the formula, that normalisation is what $\mathfrak g\subseteq\mathfrak{so}(n)$ is doing; the extension by zero on $\mathfrak g^\perp$, without which the spectrum is $(a,b,0)$ rather than two-valued at every proper $\mathfrak g$, harmless for the value and fatal for any criticality reading; $p,q\ge1$, present in [L39.lean](../lean/HamiltonsCubic/Results/L39.lean) and absent from the prose; and **$W\in\mathcal W_n$ itself.*** **The last is the one that matters**: the formula values an operator that is generically not a Weyl tensor, and this copy dropped the guard [results.md](../results.md) carries. *Also owed: $\mathfrak k\perp\mathfrak m$ in the AMBIENT form, used at every step, $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ inside $\mathfrak{so}(12)$ with its factors at different multiplicities and the swap involution has $\mathfrak k\not\perp\mathfrak m$ and $S_{\mathfrak{mmm}}\ne0$.*

> **AND THE ARGUMENT ONCE GIVEN FOR ADMISSIBILITY IS CIRCULAR.** *That the formula "overshoots the true $\theta$" at unbalanced sphere pairs presupposes Conjecture A, which is what this programme is proving.* **The non-circular witness is the direct failure of Ricci-flatness.** *And "overshoots every time" is false as written*: $(\mathfrak{so}(9),\mathfrak{so}(8))$ has $p=28$, $q=8$, $c=14$ and $\theta^2=\tfrac7{18}$, **a factor of three below $\Theta_9^2=\tfrac{48}{35}$.** The near-balanced statement it means is true (the gap is $\frac{24k^4-6k^3-5k^2+4k-1}{4k^4(2k+1)(k+1)(2k-1)}>0$) and has no argument on file. *The recorded figures are exact where they apply: $\tfrac{64009}{46080}$ against $\tfrac{48}{35}$ at $\mathfrak{so}(4)\oplus\mathfrak{so}(5)$, and $\tfrac{961}{960}$ against $\tfrac89$ at $n=5$, the latter an excess on $\theta^2$ rather than on $\theta$.*

**The constant, and where its table data breaks.** $c=2h^\vee(\mathfrak g)/I_\rho$, dual Coxeter number over Dynkin index, **generic-$m$ data that fails at small members.** At $\mathfrak{so}(3)$ the row returns $4$ against the true $c=2$; at $\mathfrak{so}(m)$ the pair $h^\vee=m-2$, $I_\rho=2$ fails at $m=3$ and at $m=4$, where $\mathfrak{so}(4)$ is not simple and $h^\vee$ is undefined. *A metric-doubling argument, $\lVert X\oplus X\rVert^2=2\lVert X\rVert^2$ so $c\mapsto c/2$, rescues $c=m-2$ at both.* **No value in the $c$ column moves; the $h^\vee$ and $I_\rho$ cells do.**

*The weights $(1,3,3,1)$ are multinomial and close only in the ordered reading. **[L114](bounds-relaxations.md)'s $6/4/2$ is not the unordered form of this**: ordered, $6/4/2$ is $(1,2,1)$ (three terms, one row) while $(1,3,3,1)$ is that row plus its twin, which L114's own file states.*

#### Observation L40, the surviving target, measured

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the evidence is the census and the closure argument in this file, at the sections beginning "What survives" and the symmetric-space sweep**, the section once named here holds the $\operatorname{tr}(W^\#)$ identity and no census.*

Over the **catalogued** critical points $\mathcal C$, membership decided by [Lemma L37](#lemma-l37-diagonality-is-decided-by-a-single-kernel) rather than by frame inspection,
$$\sup\{\theta:W\in\mathcal C,\ Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\sqrt{3/2},$$
**attained at $W_{\mathbb{CP}^2}$ and at every padding of it**. Diagonal controls are correctly excluded, $S^5\times S^7$ at $1.228239$ among them, the strongest available control, since it sits *above* $\sqrt{3/2}$ and is the point whose misclassification would break the measurement.

> **THIS BOUNDS THE RESIDUAL FROM BELOW, AND THE RESIDUAL NEEDS THE OTHER DIRECTION.** A supremum over a catalogue gives $\sup_{\mathcal N}\theta\ge\sqrt{3/2}$ over the full non-diagonal set $\mathcal N$, while the statement that would close the conjecture is $\sup_{\mathcal N}\theta\le\sqrt{3/2}$. **L40 reaches that direction not at all.** *The first version displayed the set-builder unrestricted and with an equality, leaving the catalogue qualifier in the surrounding prose; [results.md](../results.md) carries the correct reading ("a measurement over a catalogue, proving nothing about points outside it") and this block was the only statement of it in the record that dropped the scope.*
>
> **THE CORROBORATION IS ONE HUNT, NOT THREE.** Read as "three independent hunts agree: a $26$-space symmetric-space sweep, and closure sweeps at $n=6$ and $n=8$". **The $n=6$ run is struck 247 lines above in this file** as evidence of completeness in neither direction, and the report's status table logs it the same way. **The two closure sweeps are not independent evidence at all**: padding preserves $\theta$, and a $\circ$-orthogonal sum satisfies $\lvert\theta\rvert<\min(\lvert\theta_1\rvert,\lvert\theta_2\rvert)$ strictly, so the supremum over the closure **equals** the supremum over the catalogue by proof, they could not have topped out anywhere else. What stands is one symmetric-space list.
>
> **The attainment is a theorem, not this measurement.** $\theta^2=3/2$ holds exactly at $W_{\mathbb{CP}^2}$ by the closed form; the $-6.7\times10^{-16}$ once printed here is about three ulp, which certifies a failure to separate rather than an equality, is blind to a violator at $10^{-6}$, and named no run. *Gate 2, [r547](../reviews/REVIEW_r547.md) and [r548](../reviews/REVIEW_r548.md) on identical briefs, agreeing.*
>
> **Nothing above $n=12$ is measured**, which is where the conjecture lives.


#### Lemma L41, a $\lambda$-weighted identity, and the bound it gives

**Statement.** Let $W\in\mathcal W_n$ with eigenbasis $\{v_\gamma\}$ **orthonormal**, and write $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$. Then

$$\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2\quad\text{on all of }\mathcal W_n,\qquad \sum_\gamma\lambda_\gamma g_\gamma=-4P(W)\quad\text{on all of }\mathcal W_n.$$

**Both are scale-covariant as written and neither is scale-invariant.** *The forms $\sum g_\gamma=4(n-1)$ and $\sum\lambda_\gamma g_\gamma=-4\theta$, equate degree two and degree three with degree zero and hold at $\lVert W\rVert=1$ alone.* **[conventions.md](conventions.md) already tables both correctly**, so the canon contradicted its own conventions file.

> **NEITHER IDENTITY NEEDS CRITICALITY, AND A REPAIR HERE ONCE SAID OTHERWISE.** *Both come from (A) and (B) with the cubic identity, as [conventions.md](conventions.md) records*, the chain is $\sum_\gamma\lambda_\gamma g_\gamma=\sum_{\gamma\alpha\beta}\lambda_\gamma(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$, and every step in it, Petersen-Wink Proposition 1.7, the orthonormality it supplies, the total symmetry of $T$, and $A(W)=2W$, **holds at every $W\in\mathcal W_n$.** *What the $\theta$ form needs is **unit norm and nothing more***, since [conventions.md](conventions.md) **defines** $\theta:=P(W)/\lVert W\rVert^3$ rather than deriving it from $Q(W)=\theta W$, **so criticality buys nothing in either form**, and an earlier repair here named it as the residue when the residue is the normalisation. **The two copies and this file now agree**, a contradiction between them having been flagged at Gate 2.

**Proof, in two lines from three ingredients.** $A(W)=2W$; [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Proposition 1.7, whose hypotheses hold here and which supplies $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ **together with the orthonormality of the eigenbasis**; and the total symmetry of $T$. *The first identity additionally consumes [Lemma L153](bounds.md), and needs no criticality, that claim is genuine.* **All four were used and none was named.**

**The bound, at unit norm.** With $\Delta$ the $g$-mass on $\{\lambda>0\}$ and $G_0$ the mass on $\ker W$, the split into $\{\lambda>0\}$, $\{\lambda<0\}$, $\{\lambda=0\}$ being exhaustive,

$$\theta\;\le\;\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}{4},\qquad \lVert W\rVert=1 .$$

> **THE UNIT-NORM HYPOTHESIS IS NOT COSMETIC HERE, AND THE BOUND IS THE WORST OF THE THREE.** *Its bracket mixes $4(n-1)$, of degree zero, with $\Delta$ and $G_0$, of degree two, so it is ill-formed at every other scale and **changes sign**.* **At $2\times$ padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ the bracket reads $44-128=-84$ and the bound asserts $\theta\le-17.1$.**

> **THE EQUALITY CLAUSE HOLDS IN ONE DIRECTION ONLY, AND THE RECORD ALREADY KNEW.** *"Exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace" fails the only-if half*: the exact slack is $\sum_{\lambda>0}\lambda_\gamma g_\gamma+\sum_{\lambda<0}(\lambda_\gamma-\lambda_{\min})g_\gamma$, which **leaves the kernel unconstrained**, $G_0$ having already been subtracted. **The true class is $E_{\lambda_{\min}}\oplus\ker W$.** *Witness in closed form: padded $W_{\mathbb{CP}^2}$ at every $n\ge5$ has $\Delta=0$ by $U(2)$-invariance, one negative eigenvalue, and $G_0=4(n-4)>0$ (equality holds with kernel mass), reading $0$ at $n=4$, $16$ at $n=8$ and $32$ at $n=12$, both sides then exactly $\sqrt{3/2}$.* **The clause is [L107](bounds.md)'s, correct for its own weaker bound and copied onto this sharper one**, and [bounds-relaxations.md](bounds-relaxations.md) already records that it should read $E_{\min}\oplus\ker W$. *That correction was never propagated here.*

> **AND THE EQUALITY CASE IS NOT [L70](bounds.md)'S IN OTHER COORDINATES.** *L41's equality is blind to the $\mathfrak m\times\mathfrak m$ bracket mass, which is the whole of L70's condition.* **L41 saturates automatically on all of [L23](../results.md)'s subalgebra family**, one line, since $\mathrm{ad}(v)$ commutes with $\Pi_{\mathfrak h}$ for $v\in\mathfrak h$, so $g$ vanishes on $\mathfrak h$, **where L70 needs $(\mathfrak{so}(n),\mathfrak h)$ symmetric and its own table has the maximal tori slack by $1.29$ to $3.43$.** $W_{\mathbb{CP}^m}$ at $m\ge3$ attains L41's equality and misses L70's by $2(m-2)\theta$. *So citing the two as one piece of evidence double-counts, and the live risk is transporting [L71](bounds.md)'s rigidity onto $\mathbb{CP}^3$.*

*Symbols: $\Delta$ here is the $g$-mass on the positive eigenspace, defined at [curvature-invariants.md](curvature-invariants.md) and cited from neither copy, **[conventions.md](conventions.md) tables the letter against a different, pair-indexed object whose unordered reading doubles it**, so a reader taking the tabled default gets this bound wrong by a factor of two. $G_0$ is tabled nowhere. $A(W)$ is defined only in the Petersen–Wink notes, and the letter $A$ collides with four other uses on the record.*

#### Lemma L163, [L37](#lemma-l37-diagonality-is-decided-by-a-single-kernel)'s two witnesses, in closed form

*[I61](../plan.md), Gate 2: [r737](../reviews/REVIEW_r737.md) and [r738](../reviews/REVIEW_r738.md), identical briefs, both `GAP` on the form the first version took.*

**Statement.** (a) For every $m\ge2$, $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}$; in particular $\dim\ker\Phi_W=1<4$ at $n=4$, so [L37](#lemma-l37-diagonality-is-decided-by-a-single-kernel)'s corollary is not vacuous. (b) For $W_0$ on $\Lambda^2\mathbb R^m$ zero-padded to $\Lambda^2\mathbb R^n$ with $k=n-m$,

$$\dim\ker\Phi_{W_0\oplus0}\;=\;\dim\ker\Phi_{W_0}+\binom{k+1}2+k\,\dim K(W_0),\qquad K(W_0)=\{c:W_0(c\wedge\mathbb R^m)=0\},$$

**an equality.** (c) Padded $W_{\mathbb{CP}^2}$ at $n=8$ has $\dim\ker\Phi_W=11>8=n$ **and is non-diagonal**, which is the witness that L37's corollary runs one way only.

**Proof of (a).** Split $A=\tfrac{\operatorname{tr}A}4\mathrm{Id}+A_0$; $\delta_{\mathrm{Id}}$ is central, so only $A_0$ matters. **For trace-free symmetric $A_0$, $\delta_{A_0}$ exchanges $\Lambda^+$ and $\Lambda^-$**, and trace-freeness is exactly what does it: diagonalising $A_0$ by $g\in SO(4)$, which preserves $\Lambda^\pm$, gives $\delta_{A_0}(e_{12}+e_{34})=(a_1+a_2)(e_{12}-e_{34})$ using $a_3+a_4=-(a_1+a_2)$, and likewise on the other two pairs, so $\beta=\operatorname{diag}(a_1{+}a_2,\,a_1{+}a_3,\,a_1{+}a_4)$. Hence $[W,\delta_{A_0}]$ is off-diagonal with lower-left block $W^-\beta-\beta W^+$; at $W_{\mathbb{CP}^2}$, $W^-=0$ and $W^+$ is invertible, so $\beta W^+=0$ forces $\beta=0$, and $A_0\mapsto\delta_{A_0}$ is injective for $n\ge3$. *At general $m$ the same conclusion follows by $J$-parity on the $(1,1)/(2,0)$ decomposition, the $\mathbb{CP}^m$ Weyl spectrum being $\tfrac{4(m^2-1)}{2m-1}$, $\tfrac{2m-4}{2m-1}$, $-\tfrac{2(m+1)}{2m-1}$ at multiplicities $1$, $m^2-1$, $m(m-1)$, pairwise distinct throughout, and reading $(4,-2,-2,0,0,0)$ at $m=2$.* $\square$

**Proof of (c), which the bound could not give.** By (b), $\ker\Phi_W=\mathbb R\,\mathrm{Id}_4\oplus\operatorname{Sym}^2(V)$ at $n=8$, of dimension $1+10=11$. **Every element is $A=a\,\mathrm{Id}_4\oplus B$, whose sum $a_i+a_j$ equals $2a$ six times over on the first block**, so no kernel element has pairwise-distinct sums, and [L37](#lemma-l37-diagonality-is-decided-by-a-single-kernel)'s equivalence gives non-diagonality **directly**. *Independently, $\mathbb R\omega$ is a simple eigenspace with $\omega\wedge\omega\ne0$, which discharges the Plücker figure [diagonality.md](diagonality.md) holds as a measurement.* $\square$

> **THE FIRST VERSION STATED (b) AS AN INEQUALITY, AND THAT IS THE ONE FORM FROM WHICH (c) CANNOT BE ARGUED.** *A lower bound gives a large kernel and says nothing about whether that kernel contains an $A$ with distinct sums (which is diagonality) so the witness was asserted.* **The inequality is also strict**, and the record supplies the witness: $W_0=W_{\mathbb{CP}^2}\oplus0$ on $\Lambda^2\mathbb R^6$ padded to $n=8$ has $\dim K(W_0)=2$ and true kernel $4+3+4=11$ against the bound's $4$. *Equality holds exactly when $\ker\Phi_{W_0}=\mathbb R\,\mathrm{Id}$ and $K(W_0)=0$.*

> **AND "IT REPRODUCES THREE MEASURED ROWS" WAS FALSE.** *A lower bound derives no value.* **The unpadded row is vacuous** (at $k=0$ the display collapses to $\mathrm{Id}\in\ker\Phi_W$, true of every operator), *and the $\mathbb{CP}^3$ row consumes no property of $W_{\mathbb{CP}^3}$ at all.* **One row was derived, not three.** Under the equality above all four are theorems, and the exact kernel dimensions at padded $\mathbb{CP}^2$ read $2,4,7,11,16$ for $n=5\ldots9$.

*Part (a) consumes $\mathrm{ric}=0$ where it writes $W=W^+\oplus W^-$, worth naming, since [L37](#lemma-l37-diagonality-is-decided-by-a-single-kernel) directly above makes a point of needing neither criticality nor $W\in\mathcal W_n$.*

**Provenance, and the adjudication error it records.** *[ROUND_L37](../verification/ROUND_L37.md)'s three verifiers all held $\dim\ker\Phi_W=11$, **an equality at one object**. [I61](../plan.md) kept the general padding form and discarded the rest as "the same argument at one object".* **Widening to arbitrary $W_0$ forced the equality down to an inequality, and the inequality is the one form from which non-diagonality cannot be argued.** *The generality did not have to be paid for: the exact identity above is as general as the bound.*

#### Lemma L45, off the slice: five surviving triples, and one new coupling

*The argument is the off-slice paragraph of [problem.md](problem.md#the-diagonal-case-located-in-the-literature-and-it-covers-less-than-assumed). Verified `PROVEN, hypotheses corrected`, [ROUND_L45](../verification/ROUND_L45.md).*

For $n\ge4$ and general $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$, five of the ten distinct triples of the cubic vanish and five survive, with multiplicities $1,3,1,3,1$ from the total symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ (Böhm–Wilking eq. (5)):
\[
\langle R,\Phi(R)\rangle=\underbrace{c^3(n-1)\|I\|^2+3c\langle I,\Phi(Y)\rangle+\langle Y,\Phi(Y)\rangle}_{W\text{-even}}
+\underbrace{3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle}_{W\text{-odd}} .
\]
Against the slice exactly one new surviving triple contains $W$, the triple $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ in Böhm–Wilking's normalisation of $\mathrm{Ric}$ and $\wedge$, the $3$ its multiplicity and $\tfrac1{n-2}$ its trilinear value; every $I$--$W$ pairing vanishes. The $\Omega_0$ constraint depends only on $\|W\|$, so $cI+Y-W\in\Omega_0$ whenever $cI+Y+W$ is, and demanding the criterion at both signs gives the two-sided bound
\[
\big|\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\big|\;\le\;\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even},
\qquad \mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle .
\]
with $\mathrm{RHS}_{\rm even}$ and $\mathrm{RHS}_{\rm odd}$ the $W$-even and $W$-odd parts of $F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$. It is a bookkeeping identity for the general criterion and proves no case of the conjecture by itself.


#### Lemma L49, the collapse space, and its dimension

*Verified `GAP`, narrowed to what is proved, [ROUND_L49](../verification/ROUND_L49.md). The characterisation is machine-checked in [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean).*

In an eigenframe $\{v_\alpha\}$ of $W$, with $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$ on $\mathfrak{so}(n)$ and Böhm–Wilking's $\#$, write $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ with $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. Say that $T$ **collapses** when a single $c$ gives $\theta=c\sum_\alpha\lambda_\alpha^3$ for **every** spectrum $\lambda$ with $\sum_\alpha\lambda_\alpha=0$, $T$ held fixed. The condition is linear in $T$, so the collapsing $T$ form a subspace, and **it is exactly the $T$ constant on distinct triples, at every $N\ge3$**: the trace-free spike spectrum $e_i+e_j-2e_k$ isolates one triple and forces $T_{ijk}=c-1$, and at $\sum\lambda=0$, $3e_3=p_3$ gives the converse with $c=1+T$.

**Open, and not consequences of this lemma.** *(i)* That the number of independent trace conditions governing the collapse space is the number of irreducible summands of $\mathcal W_n$ under $SO(n)$; under $O(4)$, $\mathcal W_4$ is irreducible. *(ii)* That constant $T$ on distinct triples is realised by no $\mathfrak{so}(n)$, $n\ge4$. *(iii)* Whether the cubic is a function of the spectrum alone at a critical point, for $n\ge5$ or at $n=4$: the lemma fixes $T$ and ranges $\lambda$ over every trace-free spectrum, which the Weyl spectra a frame realises do not fill. *The eigenframe display and its coefficient $3$ at this normalisation are derived in no passage of this file; under $\langle A,B\rangle=-\operatorname{tr}(AB)$ the coefficient reads $6$.*

---

#### Lemma L197, RETIRED into relation (C), and the count drawn from it was refuted

*Derived 2026-09-10, **GATE 2 by [r838](../reviews/REVIEW_r838.md) and [r839](../reviews/REVIEW_r839.md)**, both confirming every equation and both refuting the conclusion drawn from them. The statement is retired rather than corrected: it is nine days old and strictly weaker than what the record already carried.*

**IT IS THE $\lambda_k=0$ CASE OF SOMETHING ALREADY ON FILE.** *Criticality is $W^\#=\theta W-W^2$, so $W^\#$ is a POLYNOMIAL IN $W$ and $\ker W\subseteq\ker W^\#$ follows in one line.* **In the record's notation that is [relation (C)](bounds.md)**, $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ **at EVERY index $k$**, which the record calls literally the diagonal of $Q(W)=\theta W$ and has carried since 2026-09-01. *The kernel rows are its $\lambda_k=0$ slice.*

> **AND THE COUNT DRAWN FROM IT WAS FALSE, BY EXACTLY THAT WEAKENING.** *The block counted $\binom n2-r$ conditions at rank $r$ and concluded that high rank is barely constrained, so the identity runs against a rank bound.* **Criticality supplies $\binom n2$ diagonal equations at every rank**, so "high rank barely constrained" described the block's own weakening rather than criticality. *[Post F63](fence-posts.md), which the block cited, says a rank bound must come from the criticality equation, which is exactly the rows the block discarded.* **Both reviewers reached this independently.**

> **THE STEP THAT NEEDS $R\succeq0$ IS NAMED CORRECTLY BUT LOCATED WRONGLY.** *[Wilking](https://arxiv.org/abs/1011.3561) gets the sign from second variation on the $\mathrm{Ad}$-orbit, not from a square root, so what he needs is $R\succeq0$ ON $\operatorname{im}\mathrm{ad}_v$ ALONE.* **So the block's reason the mechanism is unavailable to an indefinite Weyl tensor is too strong**, and the equality-case step is unavailable only globally.

> **THREE CONSEQUENCES ARE FREE AT EVERY CRITICAL POINT WITH $\theta>\lambda_{\max}$, hence whenever $\theta\ge1$** ([r839](../reviews/REVIEW_r839.md), its own derivation and unaudited). *$\ker W^\#=\ker W$ EXACTLY rather than one containment; $W^\#$ definite on $\operatorname{ran}W_+$ and on $\operatorname{ran}W_-$ separately, which is the definiteness the block hoped to recover from [L155](bounds.md); and $\operatorname{ran}W\subseteq\operatorname{span}[\operatorname{ran}W,\operatorname{ran}W]$*, **the containment OPPOSITE to Hamilton's.**

> **A CONDITIONAL RANK BOUND, WHICH IS WHAT THE ROUTE ASKED FOR** ([r838](../reviews/REVIEW_r838.md), its own derivation and unaudited). *Every kernel vector orthogonal to $[\mathfrak p,\mathfrak m]$ is orthogonal to $[\mathfrak p,\mathfrak p]$ and $[\mathfrak m,\mathfrak m]$, so $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$ makes $\operatorname{ran}W$ a SUBALGEBRA of the compact $\mathfrak{so}(n)$*, **capping the rank at $\binom n2-(n-1)$ or forcing invertibility.** *That turns [I68c](../plan.md) into one named question: whether $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$.*

> **THE NAMED QUESTION IS EQUIVALENT TO ITS OWN CONCLUSION, WHICH IS WHY IT IS NOT A SMALLER ONE.** *The balance at a kernel vector $v$ splits by sign into $\mathfrak{pp}$ and $\mathfrak{mm}$ mass on one side and $\mathfrak{pm}$ mass on the other, all three nonnegative:* $$\sum_{\alpha,\beta\in\mathfrak p}\lambda_\alpha\lambda_\beta\langle[v_\alpha,v_\beta],v\rangle^2+\sum_{\alpha,\beta\in\mathfrak m}\lambda_\alpha\lambda_\beta\langle\cdot\rangle^2=2\sum_{\alpha\in\mathfrak p,\beta\in\mathfrak m}\lvert\lambda_\alpha\lambda_\beta\rvert\langle\cdot\rangle^2 .$$ **So $v\perp[\mathfrak p,\mathfrak m]$ forces the right side to zero, hence both terms on the left to zero**, which is [r838](../reviews/REVIEW_r838.md)'s step and it is immediate. *But the converse is equally immediate: $\operatorname{ran}W$ a subalgebra gives $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$.* **The two are EQUIVALENT, so "is $[\mathfrak p,\mathfrak m]\subseteq\operatorname{ran}W$?" is the subalgebra question restated and not a reduction of it.**

> **AND EVEN GRANTED, THE BOUND IS FAR TOO WEAK FOR [I68](../plan.md).** *A proper subalgebra of $\mathfrak{so}(n)$ has codimension at least $n-1$, the largest being $\mathfrak{so}(n-1)$, so the cap is $\operatorname{rank}W\le\binom n2-(n-1)$ or $W$ is invertible.* **At $n=12$ that reads rank at most $55$ against $\binom{12}2=66$**, where [I68](../plan.md) needs a bound low enough for the rank-three theorem to bite. *So the subalgebra property, which is the whole of what the mechanism can deliver, does not reach the item even when assumed.*

> **WHAT THAT LEAVES.** *The route's value is not a rank bound. It is that $\operatorname{ran}W$ being a subalgebra is exactly the GRADED condition the record already treats, $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ and its companions, where the sphere products live* ([L155](bounds.md), [bounds.md](bounds.md)). **So the mechanism connects the ungraded half to the graded one rather than bounding a rank**, and an item wanting it should say so. *Recorded as a dead end for [I68](../plan.md) and a live connection for the graded/ungraded split.*

> **AND THE ROUTE AS STATED IS FENCED** ([r839](../reviews/REVIEW_r839.md)). *[Post F43](bounds-relaxations.md)'s witness is KERNEL-FREE and passes every row at $\theta=1.2917>\theta_0(12)$, so the containment adds nothing there.* **A kernel-side argument cannot reach a witness with no kernel**, which is the shape [post F13](fence-posts.md) already records in another setting.

> **THREE FURTHER DEFECTS, EACH FOUND BY BOTH READERS.** *The term-by-term matching that read off diagonal entries is NOT a valid inference, [r838](../reviews/REVIEW_r838.md) exhibited the Koszul kernel $e_1=\lambda_2\lambda_3$, $e_2=-\lambda_1\lambda_3$ leaving the scalar unchanged, and the conclusion survives only by direct derivation from Wilking's definition.* **The bracket form's unnamed constant is $+1$ over $\alpha<\beta$.** *And exactly one of the kernel equations is redundant, its sum following from the non-kernel rows with $\operatorname{tr}W^\#=-\lVert W\rVert^2$, which is relation (B).*

## Working notes carried by the plan

*These were accumulated inside [plan.md](../plan.md)'s items, where a task list had grown into a second copy of the record. They are working notes rather than results: where one disagrees with a numbered block above, the block is the record.*

### From [I1](../plan.md)

**Why it is here.** The rubric's `attackable` factor is a multiplicand, so an item with no known method sinks below every item that has one, and [SKILL.md](../.claude/skills/research-loop/SKILL.md) names that failure exactly: *a plan can carry a full section of live work in which each item closes a real named step, while the steps that would close the problem outright carry no item at all*. **R16's first three links are auxiliary**: [I22](../plan.md#done), [I18](../plan.md#section-1-advance-the-proofs) and [I5](../plan.md#section-1-advance-the-proofs) could all close and the conjecture would be exactly as open. *A day of work went to them because they graded above this.*

**The margin any proposal must beat is $0.3\%$.** $\sqrt{3/2}=1.224745$ against the **diagonal** band point $S^5\times S^7$ at $\sqrt{264/175}=1.228239$, a gap of $0.0035$. So an inequality valid at every critical point must consume non-diagonality to three parts in a thousand at $n=12$, and no closed route prices it: [L37](target.md) makes non-diagonality a *non-existence* statement, and [F26](bispectral.md) proves every bound exact at $t=2$ and monotone below it runs the wrong way.

**The handle opened on 2026-09-03 is CLOSED the same day** ([post F53](INDEX-traps.md), [r405](../reviews/REVIEW_r405.md), [r406](../reviews/REVIEW_r406.md)): $\operatorname{tr}W=0$ and $\lVert W\rVert=1$ give $0<\lambda_{\max}<1<\theta$, so **every** unit Weyl operator in the band has an eigenvalue in $(0,\theta)$, criticality not needed. [Lemma L129](diagonal-half.md)'s gap is about the **sectional** matrix and has no $\Lambda^2$ analogue, and the $\#$-positivity reading dies with it. *The item has no live handle again, and that is the honest state.*

**And the $\#$-term reduction proposed on 2026-09-03 is refuted at padded $W_{\mathbb{CP}^2}$**, $\langle W,W^\#\rangle=2/\sqrt6$ against the demanded $0.2476$, at the non-diagonal $S=0$ critical point that **attains** this item's supremum ([r407](../reviews/REVIEW_r407.md), [r408](../reviews/REVIEW_r408.md)). *A sufficient condition false at the equality case of its own conclusion cannot be proved.* **And [post F11](second-order.md) already carries the split with the same numbers and the opposite conclusion: any route must treat $\operatorname{tr}W^3$ and $\langle W,W^\#\rangle$ together.*

**What would retire it**: a route. *None is known, and [post F53](INDEX-traps.md) closed the only one proposed this session before it was a day old.*

**Its theorem types as `unsupported`, and the missing piece is [B1](../plan.md#section-2-build-what-the-proofs-need) rather than mathematics.** *The constant is removable, $\theta^2\le\tfrac32$ is exactly $2P(W)^2\le3\lVert W\rVert^6$, since $\theta=P/\lVert W\rVert^3$, **but the squared form is $\lvert\theta\rvert\le\sqrt{3/2}$ and implies the claim without being implied by it**, so what a statement carries is the disjunction $P(W)\le0\lor2P(W)^2\le3\lVert W\rVert^6$. The negative branch is not empty: $Q(-W)=Q(W)$ with $P$ odd makes the critical set symmetric under $\theta\mapsto-\theta$.* **And removing the constant does not remove the need for $\mathbb R$**: a rational critical $W$ has $\theta\in\mathbb Q$, so $2P^2=3$ is unreachable and a $\mathbb Q$-statement is never sharp, the attaining point $\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ is not a $\mathbb Q$-point.

