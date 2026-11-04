# Review r659, Lemma L116, $b(W^\#)=-b(W^2)$ on every curvature operator

*Reviewer A of a two-reviewer pair on identical briefs (companion: r660, unread). Target: [findings/bounds-relaxations.md:246](../findings/bounds-relaxations.md#L246). Derived cold from the definitions; analysis only, no computation run.*

## Verdict

**CONFIRMED, the identity is true, and it is true on a strictly wider set than the heading names. But it is not the block's discovery, its citation is circular, its provenance note is false, and its closed form is contradicted in sign elsewhere on the record.**

The displayed cancellation is *the problem statement*, not a correction the literature forces: [README.md:14](../README.md#L14) already posits $Q$ "sending $W_n$ to itself", and [conventions.md](../findings/conventions.md) tables the same. The one genuinely new object in the block is the closed form for $b(W^2)$, and that is the part the block presents as an afterthought.

| # | defect | severity |
| --- | --- | --- |
| D1 | The re-filing note at [:286](../findings/bounds-relaxations.md#L286) says the section came from [second-order.md](../findings/second-order.md); git says [bounds.md](../findings/bounds.md) | **false provenance**, verified |
| D2 | *"A correction the literature forces"* cites a gloss written in the same commit, which points back at this record | **circular citation** |
| D3 | *"before it was used"*, the same fact was already on the record in [r122](REVIEW_r122.md) | hedge false |
| D4 | [ELIM-bounds.md:39](ELIM-bounds.md) states the closed form with the **opposite sign** | contradiction, one is wrong |
| D5 | Neither $b$, $\#$ nor $\wedge$ is in [conventions.md](../findings/conventions.md); the tabled $b$ is a different object, and the claim is false under the other bivector norm | normalisation unpinned |
| D6 | *"on every curvature operator"* understates: at $n=4$ trace-freeness suffices instead of Bianchi | scope narrow, harmless |

**No live misuse found.** The record does not use $W^\#$ alone as a curvature operator anywhere I could find; every consumer already guards it.

---

## 1. The readings I adopt, and what changes under the other one

The block states none of these, and [conventions.md](../findings/conventions.md) tables none of them. I fix them as follows and flag each as my choice.

| symbol | reading adopted | where it comes from |
| --- | --- | --- |
| pairing on $\Lambda^2$ | $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ orthonormal and $\mathop{\mathrm{tr}}(v^2)=-2$ at a unit bivector | [conventions.md](../findings/conventions.md), "Norms and pairings", the record's settled choice |
| $\#$ | Böhm–Wilking equation (4) **with its $\tfrac12$**: $\langle(R\#S)h,h\rangle=\tfrac12\sum_{\alpha\beta}\langle[Rb_\alpha,Sb_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$; equivalently $(R^\#)_{\mu\nu}=\tfrac12c_{\gamma\delta\mu}c_{\alpha\beta\nu}R_{\gamma\alpha}R_{\delta\beta}$ | [boehm-wilking notes](../references/boehm-wilking-2008-space-forms/notes.md), transcribed from p. 3–4 |
| $b$ | the orthogonal projection $S^2(\Lambda^2\mathbb R^n)\to\Lambda^4\mathbb R^n$, i.e. a positive multiple of the tabled $\mathrm{Alt}$ | forced by Böhm–Wilking's own decomposition, §1 |
| $\wedge$ | the exterior product $\Lambda^2\times\Lambda^2\to\Lambda^4$, with $\langle\cdot,\cdot\rangle_{\Lambda^4}=\tfrac1{4!}\sum_{ijkl}$ | the only reading under which $v_\alpha\wedge v_\alpha$ is a nonzero object |

**Two of these carry real content.**

- **$\wedge$ cannot be the wedge on $\Lambda^2(\mathfrak{so}(n))$**, because $v\wedge v=0$ there for every vector and the closed form would read $0=0$. It has to be the exterior product of $2$-forms landing in $\Lambda^4\mathbb R^n$, where $v\wedge v\ne0$ exactly when $v$ is **indecomposable**, see §3. The block never says which, and one of the two readings makes its own headline vacuous.
- **The $\tfrac12$ in $\#$ is load-bearing and the claim breaks without it.** Böhm–Wilking say the $\tfrac12$ "stems from the fact that we are using the scalar product $-\tfrac12\mathop{\mathrm{tr}}(AB)$ instead of $-\mathop{\mathrm{tr}}(AB)$", so the $\tfrac12$ and the half-trace pairing are one package. Take the pairing apart and the structure constants rescale: under **plain Frobenius**, the orthonormal bivectors are $\varphi/\sqrt2$, so $\tilde c=c/\sqrt2$, so $\tilde c^2=c^2/2$ and $R^\#$ **halves**. The identity then reads $b(R^\#)=-\tfrac12 b(R^2)$ and the display as written is **false**. So the block's headline is pinned to conventions.md's tabled pairing and says so nowhere.

**And $b$ collides with a tabled symbol.** [conventions.md](../findings/conventions.md)'s only $b$ entry is *"in the orbit calculus $b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$"*, a different object entirely, with the table's own note that a third $b$ (a scalar) sits in [second-order.md](../findings/second-order.md). The Bianchi map $b$ of this Lemma is a **fourth** use, and it is undefined anywhere on the record. That belongs in the table.

*One normalisation is free.* The identity $b(W^\#)=-b(W^2)$ is homogeneous of degree one in $b$, so any positive scaling of $b$ leaves it alone. Only the **closed form** ties $b$'s normalisation to $\wedge$'s, and neither is stated, so the right-hand side is determined only up to a positive constant. I read $b$ as normalised so that $b(v\otimes v)=v\wedge v$, which is the only reading making the display literally true.

## 2. The literature claim

### 2a. $S^2_B$ does mean what the block says. Quoted.

From [the transcription](https://arxiv.org/abs/math/0606187), p. 2:

> We denote by $S^2_B(so(n))$ the vectorspace of curvature operators, that is the vectorspace of selfadjoint endomorphisms of $so(n)$ satisfying the Bianchi identity.

**Confirmed verbatim.** The paper also supplies exactly the structure the Lemma needs, one page later:

> $S^2(so(n))=\langle I\rangle\oplus\langle Ric_0\rangle\oplus\langle W\rangle\oplus\Lambda^4(\mathbb R^n)$ … An endomorphism $R\in S^2(so(n))$ satisfies the first Bianchi identity if and only if $R$ is an element in $S^2_B(so(n))=\langle I\rangle\oplus\langle Ric_0\rangle\oplus\langle W\rangle$.

**That line is what makes $b$ well posed**, and the block does not quote it: $S^2_B$ is the orthogonal complement of $\Lambda^4$ in $S^2(\mathfrak{so}(n))$, so "the Bianchi defect" is exactly the $\Lambda^4$ component and $b$ is exactly the projection onto it. Every statement in the Lemma is a statement about one summand of a published decomposition.

### 2b. "The sum preserves Bianchi, $R^\#$ alone does not" is this record's inference, and it is right

The paper states Hamilton's principle for a convex $C\subseteq S^2_B$ invariant under $\dot R=R^2+R^\#$. For that to be well posed the vector field must be tangent to $S^2_B$, so $b(R^2+R^\#)=0$ on $S^2_B$. **That is an inference, sound and one line long, and the paper nowhere writes it out.** The block presents it as what the paper *defines and states*, which overstates by one step.

The negative half ("$R^\#$ alone does not"), is **neither the paper's nor a sound inference from it**. Nothing in the tangency argument separates the two terms; it is a fact about $\#$ that has to be established on its own, and §3 establishes it.

### 2c. The citation is circular

The block's pointer is [the Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md). The relevant paragraph there is not the paper's:

> **What this does and does not say.** … The paper makes no such claim for $R^\#$ on its own, and it is false, **see the Conjecture A record** for the cancellation $b(R^\#)=-b(R^2)$ …

`git show 46195d1d` puts that gloss and the L116 block **in the same commit**, whose own message reads *"correct a step before it was used"*. So the heading *"A correction the literature forces"* cites a note the same commit wrote, which forwards the reader back to the block. **The literature forces the positive half and says nothing about the negative half.** [D2]

### 2d. What was inferred wrongly, and whether it was used

The false step the block names is *"$Q(W)=\theta W$ is Bianchi, hence $b(W^2)=0$"*. I could find no surviving instance of it.

**But *"before it was used"* is false as a claim of priority.** [REVIEW_r122.md:195](REVIEW_r122.md) already carries the whole fact, and carries it better:

> **$W^2$ and $W^\#$ individually violate the first Bianchi identity**, only their sum is an algebraic curvature tensor. Measured Bianchi defect $1.2\times10^{-2}$–$6.1\times10^{-2}$ at random Weyl tensors, **equal and opposite for the two pieces**, versus $\le2\times10^{-17}$ for $Q(W)$. So neither $(W^2)^{\!\circ}$ nor $(W^\#)^{\!\circ}$ is the second-kind operator *of* anything, and no bound quoted for curvature operators of the second kind applies to either piece separately.

That is L116 plus its operative consequence, on the record before the block was written, uncited by it. [D3] The honest reading of the heading is "corrected in this file before this file used it", which is a much smaller claim.

### 2e. And the cancellation is a premise of the problem, not a finding

[README.md:14](../README.md#L14): *"let $Q(W)=W^2+W^\#$ be Hamilton's quadratic map, **sending $W_n$ to itself**"*, echoed by [conventions.md](../findings/conventions.md)'s $Q$ entry. $b(Q(W))=0$ on $\mathcal W_n$ **is** that sentence, restricted to one summand. So on the Weyl space (the only place the programme works), L116 is a corollary of the problem statement. Its content beyond that is (i) the extension from $\mathcal W_n$ to all of $S^2_B$, and (ii) the closed form. Only (ii) is new, and the block frames it as a rider.

## 3. The identity, derived

### 3a. What the claim reduces to

$b$ is linear, so
$$b(W^\#)=-b(W^2)\iff b(W^2+W^\#)=0\iff Q(W)\in S^2_B .$$
**The identity and the literature claim are the same statement, not two.** The block presents them as premise and consequence (*"What holds on every curvature operator is the cancellation"*) which reads as though the second were derived from the first. It is the first, rewritten by linearity. The brief's suspicion is confirmed.

**At a critical point the whole thing collapses to nothing.** $Q(W)=\theta W$ gives $b(W^\#)=\theta b(W)-b(W^2)=-b(W^2)$ in one line from $b(W)=0$, with no theorem consumed, as [ELIM-bounds.md](ELIM-bounds.md) already notes. So all of the Lemma's content lives **off** the critical set, which is where the heading's "on every curvature operator" is doing its work, and where the block supplies no proof at all.

### 3b. Complete derivation at $n=4$, with the sharp hypothesis

At $n=4$ the whole computation closes by hand. $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$, $\Lambda^4\mathbb R^4$ is one-dimensional, and the projection onto it is a nonzero multiple of
$$\beta(A):=\mathop{\mathrm{tr}}(A|_{\Lambda^+})-\mathop{\mathrm{tr}}(A|_{\Lambda^-}),$$
since $\Lambda^4$ is spanned by $\star=\Pi_{SD}-\Pi_{ASD}$ ([conventions.md](../findings/conventions.md), "Structure constants, brackets and padding").

**Structure constants.** From $A=E_{12}-E_{21}$, $B=E_{13}-E_{31}$ one gets $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, hence $[\varphi_{ab},\varphi_{ac}]=-\varphi_{bc}$. With $u^\pm_1=\tfrac1{\sqrt2}(\varphi_{12}\pm\varphi_{34})$, $u^\pm_2=\tfrac1{\sqrt2}(\varphi_{13}\pm\varphi_{42})$, $u^\pm_3=\tfrac1{\sqrt2}(\varphi_{14}\pm\varphi_{23})$, four bracket terms give
$$[u^+_1,u^+_2]=-\sqrt2\,u^+_3,\qquad c_{\alpha\beta\gamma}=-\sqrt2\,\epsilon_{\alpha\beta\gamma}\ \text{ on }\mathfrak{su}(2)_\pm .$$
*Control:* $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[u_1,u_2]\rVert^2=2$, the equality case of the tabled pair cap; and $\tfrac12\sum_{\gamma\delta}c^2_{\gamma\delta\mu}=n-2=2$, the tabled relation (A). Both match [conventions.md](../findings/conventions.md) with no rescaling.

**Write a general $R\in S^2(\mathfrak{so}(4))$ in blocks**, $R=\begin{pmatrix}A&C\\C^{\mathsf T}&B\end{pmatrix}$ against $\Lambda^+\oplus\Lambda^-$. Then $b(R)=0\iff\mathop{\mathrm{tr}}A=\mathop{\mathrm{tr}}B$.

- **Square.** $\beta(R^2)=\mathop{\mathrm{tr}}(A^2+CC^{\mathsf T})-\mathop{\mathrm{tr}}(B^2+C^{\mathsf T}C)=\mathop{\mathrm{tr}}A^2-\mathop{\mathrm{tr}}B^2$; the off-diagonal block cancels.
- **Sharp.** In $(R^\#)_{\mu\mu}=\tfrac12c_{\gamma\delta\mu}c_{\alpha\beta\mu}R_{\gamma\alpha}R_{\delta\beta}$ with $\mu\in\Lambda^+$, both $c$'s force all four indices into $\Lambda^+$, so **only $A$ enters** and $\#$ is computed inside $\mathfrak{su}(2)$. With $c=-\sqrt2\epsilon$,
$$A^\#=\epsilon_{\gamma\delta\mu}\epsilon_{\alpha\beta\nu}A_{\gamma\alpha}A_{\delta\beta}=2\mathop{\mathrm{cof}}(A),\qquad\mathop{\mathrm{tr}}(A^\#)=2e_2(A)=(\mathop{\mathrm{tr}}A)^2-\mathop{\mathrm{tr}}(A^2).$$

Subtracting the two blocks and adding:

$$\boxed{\ b(R^2)+b(R^\#)\ \propto\ (\mathop{\mathrm{tr}}A)^2-(\mathop{\mathrm{tr}}B)^2=\mathop{\mathrm{tr}}(R)\cdot b(R)\ }\qquad(n=4,\ \text{every }R\in S^2(\mathfrak{so}(4))).$$

Three things fall out.

1. **The identity is CONFIRMED at $n=4$**: $b(R)=0$ kills the right-hand side, so $b(R^\#)=-b(R^2)$ on every curvature operator.
2. **The hypothesis is wider than the heading.** $\mathop{\mathrm{tr}}(R)=0$ kills it just as well, so the identity holds on $\{b(R)=0\}\cup\{\mathop{\mathrm{tr}}R=0\}$, a strictly larger set than $S^2_B$, and the union of two linear subspaces neither of which contains the other. [D6]
3. **Some hypothesis is genuinely needed, with a witness.** Take $R=\Pi_+$: $A=I_3$, $B=0$, so $\beta(R^2)=3$, $A^\#=2I_3$, $\beta(R^\#)=6$, sum $9\ne0$, matching $\mathop{\mathrm{tr}}(R)b(R)=3\cdot3$. So the Lemma is **not** an identity of all self-adjoint endomorphisms of $\mathfrak{so}(n)$, and the qualifier "curvature operator" is doing real work.

**Both sides are nonzero exactly when $\lVert W^+\rVert\ne\lVert W^-\rVert$**, since for Weyl $W$ (so $\mathop{\mathrm{tr}}W^\pm=0$) the two displays read $\beta(W^2)=\lVert W^+\rVert^2-\lVert W^-\rVert^2$ and $\beta(W^\#)=-\lVert W^+\rVert^2+\lVert W^-\rVert^2$. At $\mathbb{CP}^2$, $W^-=0$ and the defect is maximal. This is the block's "genuinely nonzero" claim, proved rather than measured, at a point one dimension below the ones it quotes.

### 3c. General $n$: true, and the record owes a proof or a citation

For $n\ge5$ the $\pm$ splitting is gone and I have no hand derivation. The statement is **Hamilton's theorem** that $R\mapsto R^2+R^\#$ preserves the algebraic curvature operators, and it is what Böhm–Wilking's setup presupposes; it is also a premise of this programme's own problem statement at [README.md:14](../README.md#L14). So the identity stands, on citation rather than on anything in the block.

**Why no shortcut exists.** The symmetry of Böhm–Wilking's $\mathrm{tri}(R_1,R_2,R_3)$ gives $\langle Q(R,R),\Phi\rangle=\langle Q(R,\Phi),R\rangle$ for $\Phi\in\Lambda^4$, which is the same statement moved sideways, not a proof. And representation theory cannot supply it: $R\mapsto b(R^2)$ is a **nonzero** quadratic $O(n)$-equivariant map $\mathcal W_n\to\Lambda^4$ (nonzero by §3b at $n=4$), so $\Lambda^4$ occurs in $S^2(\mathcal W_n)$ and Schur permits both terms to be nonzero. The cancellation is a coefficient identity that must be computed or cited, exactly the point [ELIM-bounds.md](ELIM-bounds.md) makes about the Ricci half of the same statement. **What is owed here is a one-line citation to Hamilton, and the block instead cites a note that cites the block.**

## 4. The closed form

### 4a. It is frame-free, and the block's phrasing hides that

Written in an eigenframe, the display invites the brief's worry. It is unfounded here, for two reasons.

- $W^2=\sum_\alpha\lambda_\alpha^2\,v_\alpha\otimes v_\alpha$ is the spectral decomposition **of an intrinsic operator**, and $b$ is linear on $S^2(\Lambda^2)$. Any orthonormal eigenbasis of $W$ diagonalises $W^2$ with the same eigenvalues and reassembles the same operator, so the right-hand side is the value of a frame-free map. Degenerate eigenvalues change the basis and not the operator.
- The consistency check this forces is sharp and it passes: for **any** orthonormal basis $\{u_\alpha\}$ of $\Lambda^2$, $\sum_\alpha u_\alpha\wedge u_\alpha=b(\mathrm{Id})=0$, because $\mathrm{Id}$ is the round sphere's curvature operator and satisfies Bianchi. I verify it independently in §4c.

So this is **not** the record's live frame-dependence defect. What is fair to charge is presentation: the display reads as a formula in a frame, and one added clause (that it is $b$ of the operator $W^2$, evaluated in a frame), would settle it.

### 4b. The sign, and a live contradiction on the record

Under the tabled $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ and $R=v\otimes v$,
$$\mathrm{Alt}(v\otimes v)_{ijkl}=\tfrac13\big(v_{ij}v_{kl}+v_{ik}v_{lj}+v_{il}v_{jk}\big)=\tfrac16\,(v\wedge v)_{ijkl},$$
a **positive** multiple. So $b(W^2)=+\sum_\alpha\lambda_\alpha^2(v_\alpha\wedge v_\alpha)$ and the block's sign is right.

**[ELIM-bounds.md](ELIM-bounds.md) §S3 has it the other way round**, writing *"the object $b(W^2)=-\sum_\alpha\lambda_\alpha^2(v_\alpha\wedge v_\alpha)$"*, and repeats the object in its closing instruction. The two cannot both hold under any single normalisation of $b$ and $\wedge$: they differ by a sign on a quantity the same two documents agree is nonzero. It reads as a transcription slip, the block's chain is $b(W^\#)=-b(W^2)=-\sum(\cdots)$, and ELIM took the last term onto the wrong member. **The block is right and ELIM-bounds.md is wrong**, and one of them has to be repaired. [D4]

### 4c. What the object actually is, and a sharper statement of the block's own claim

The block says the identity is *"a relation between $\lambda$ and the frame that no marginal of $T$ can see"*. That is right, and it can be made exact. For $u,v\in\Lambda^2\mathbb R^n$ skew, expanding $(u\wedge u)_{ijkl}=2(u_{ij}u_{kl}+u_{ik}u_{lj}+u_{il}u_{jk})$ against the same for $v$ and collecting the $3$ aligned and $6$ crossed contractions gives
$$\langle u\wedge u,\ v\wedge v\rangle_{\Lambda^4}=\tfrac12\mathop{\mathrm{tr}}(uv)^2-\mathop{\mathrm{tr}}(uvuv).$$
With $\mathop{\mathrm{tr}}(v_\alpha v_\beta)=-2\delta_{\alpha\beta}$ and $\mathop{\mathrm{tr}}(uvuv)=\mathop{\mathrm{tr}}(u^2v^2)-\lVert[u,v]\rVert^2$, and $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}$,
$$\langle v_\alpha\wedge v_\alpha,\ v_\beta\wedge v_\beta\rangle=2\delta_{\alpha\beta}+\sum_\gamma T_{\alpha\beta\gamma}-\mathop{\mathrm{tr}}(v_\alpha^2v_\beta^2),$$
$$\boxed{\ \lVert b(W^2)\rVert^2=2\sum_\alpha\lambda_\alpha^4+\sum_{\alpha\beta\gamma}\lambda_\alpha^2\lambda_\beta^2\,T_{\alpha\beta\gamma}-\sum_{\alpha\beta}\lambda_\alpha^2\lambda_\beta^2\mathop{\mathrm{tr}}(v_\alpha^2v_\beta^2)\ }$$

**Two exact checks, both by hand, both passing.**

- *Decomposability.* At $\alpha=\beta$, hollowness of $T$ gives $\lVert v\wedge v\rVert^2=2-\mathop{\mathrm{tr}}(v^4)=2(1-\sum_is_i^4)$ at singular values $s$ with $\sum s_i^2=1$, zero exactly when $v$ is decomposable, the classical criterion. At $v=\varphi_{12}$ it returns $0$; at $v=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ it returns $1$, and directly $v\wedge v=e_{1234}$ of norm $1$.
- *$b(\mathrm{Id})=0$.* Summing over a full orthonormal basis, $\sum_\alpha v_\alpha^2=-(n-1)\mathrm{Id}$ gives $\sum_{\alpha\beta}\mathop{\mathrm{tr}}(v_\alpha^2v_\beta^2)=n(n-1)^2$, while $2N=n(n-1)$ and $\sum_{\alpha\beta\gamma}T=n(n-1)(n-2)$. The three cancel identically: $n(n-1)[1+(n-2)-(n-1)]=0$. This tests both coefficients of the pairing formula at once, at every $n$.

**What this sharpens.** The block's "no marginal of $T$ can see it" is true but understates the structure: the $T$-dependence enters through the *full* tensor, and the **only ingredient outside $T$ altogether is the Gram data $\mathop{\mathrm{tr}}(v_\alpha^2v_\beta^2)$**. That, and not $b(W^2)$ in the abstract, is the handle fence post [F15](../findings/bounds-relaxations.md#L240) says is missing, a statement a successor can act on, unlike the block's. *This is a positive extension, not a defect charge.*

### 4d. The hypothesis in the heading

*"On every curvature operator"* means Böhm–Wilking's $S^2_B$, and under that reading it is **correct**: the identity needs Bianchi for $R$ and needs neither trace-freeness nor Ricci-flatness, so it holds on $\langle I\rangle\oplus\langle Ric_0\rangle\oplus\langle W\rangle$ and not only on $\mathcal W_n$. But the record's habitual object is $\mathcal W_n$ and "curvature operator" is **not** in [conventions.md](../findings/conventions.md), so a reader will plausibly narrow it to Weyl. One clause ("curvature operator in Böhm–Wilking's sense, $S^2_B$, Bianchi only"), fixes it. And §3b shows even that is not sharp at $n=4$, where trace-freeness is an alternative sufficient hypothesis. [D6]

## 5. Consequences

**Only the sum is constrained.** For $W\in\mathcal W_n$, $b(W)=0$ makes the identity *equivalent* to $b(Q(W))=0$; it pins $b(W^\#)$ **given** $b(W^2)$ and conversely, and constrains neither alone. The separate content is entirely in the closed form of §4, which is a formula for $b(W^2)$ and says nothing about $W^\#$ that the cancellation does not already say.

**Consumers.** [ELIM-bounds.md](ELIM-bounds.md) is the only place that draws on it, twice and correctly: §S3 grades it a genuine survivor of the elimination test, and its "one serious item" identifies L116 as the **Bianchi half** of the unproved claim that $Q$ preserves $\mathcal W_n$, asking for the Ricci half $\mathrm{Ric}(W^\#)=-\mathrm{Ric}(W^2)$. That request is partly answered by [README.md:14](../README.md#L14), which posits the whole thing as a premise of the problem, worth recording where ELIM-bounds asks the question.

**No surviving misuse of $W^\#$ as a curvature operator.** I checked every place the record forms $W^\#$ or $W^2$ outside $Q$:

| site | what it does | verdict |
| --- | --- | --- |
| [bispectral.md:112](../findings/bispectral.md#L112), [:148](../findings/bispectral.md#L148) | *"$W^\#$ is not a Weyl tensor"*, $60\%$ of the norm outside, projection kept on **both** sides | correct, and independent of L116 |
| [target.md:80](../findings/target.md#L80), [:104](../findings/target.md#L104), [:248](../findings/target.md#L248) | applies the **linear** map $R\mapsto\mathring R$ to $Q(W)=\lambda W$ | legitimate: $\mathring{\ }$ needs pair symmetry only, and [r122](REVIEW_r122.md) confirms self-adjointness there without Bianchi |
| [target.md:90](../findings/target.md#L90) | states and then **refutes** $(W^2)^{\!\circ}=(\mathring W)^2$ | correct |
| [bounds.md:227](../findings/bounds.md#L227) | $W^\#=\theta W-W^2$ at a critical point | correct, and criticality is stated |
| [ELIM-bounds.md:15](ELIM-bounds.md) | refuses to apply the per-row Weyl identity to $W^2$ *because* $W^2\notin\mathcal W_n$ | the intended use, correct |

**The valuable-outcome hunt comes back empty.** No place quotes a second-kind spectral bound for $(W^\#)^{\!\circ}$ or $(W^2)^{\!\circ}$, which is the failure mode [r122](REVIEW_r122.md) named. L116 stays housekeeping.

## 6. The checklist items

- **Provenance [D1].** The trailing note at [:286](../findings/bounds-relaxations.md#L286) reads *"Re-filed here 2026-09-02 from second-order.md"*. `git show 2d66938e --stat` for that date lists `bounds.md -418`, `bounds-relaxations.md +350`, `curvature-invariants.md +81` and **does not touch second-order.md at all**; `git grep -l "Lemma L116" 2d66938e^` returns `findings/bounds.md`. **The note is false**, and the likely cause is visible two lines below, where the *next* section correctly names second-order.md as its source. One more confirmed copy for the brief's tally.
- **Hedges.** *"the literature forces"*, half true, §2b/§2c. *"before it was used"*, false as priority, §2d; true as a statement about this file only. *"on every curvature operator"*, true, not sharp, §4d.
- **Does the file settle it elsewhere?** Partly, and against the block's framing: the same file's [F15](../findings/bounds-relaxations.md#L240) is what the Lemma claims to supply a handle for, and the two sit adjacent with no cross-reference from F15 forward.
- **Duplication.** No second **numbered** statement of the identity. But three unnumbered statements of the same fact predate or accompany it, [README.md:14](../README.md#L14) and [conventions.md](../findings/conventions.md)'s $Q$ entry as a premise, [r122](REVIEW_r122.md) as a measurement, [bispectral.md:112](../findings/bispectral.md#L112) as a working caveat. [r358](REVIEW_r358.md) correctly reads L116 as the trace identity $\mathop{\mathrm{tr}}(W^2)+\mathop{\mathrm{tr}}(W^\#)=0$ "one level finer", which is a **different** summand and not a duplicate.
- **Pointers.** [b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py) and [the Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) both resolve. The notes pointer resolves to a circular target, §2c.
- **Indexing.** [INDEX-results.md](../findings/INDEX-results.md) row **116** reads *"Gate 2: no verdict on the record"*, this review is the first. [results.md](../results.md) carries **no L116 row** (zero matches), the file-wide backlog [r574](REVIEW_r574.md) and [r614](REVIEW_r614.md) already charge for L104, L105, L107, L109, L110, L114, L115 and L119.
- **Heading shape.** The L116 heading carries no body; the body sits under the next `####`. [r594](REVIEW_r594.md) already grades this a house pattern of this file, so it is not charged here.
- **Numbers not checked.** $0.962$ at $\mathbb{CP}^3$ and $0.953$ at $\mathbb{CP}^4$ are single-script figures with no normalisation attached; under this programme's analysis-only footing I ran nothing. The *qualitative* claim they support (both sides nonzero), I proved independently at $n=4$, §3b.

## 7. What I would change

1. **Repair the false re-filing note** at [:286](../findings/bounds-relaxations.md#L286): the source is [bounds.md](../findings/bounds.md).
2. **Replace the circular citation** with Hamilton's theorem, or with [README.md:14](../README.md#L14), the premise the programme already grants. Drop *"the literature forces"*, which the paper does not do for the negative half.
3. **Fix the sign in [ELIM-bounds.md](ELIM-bounds.md) §S3** and its closing instruction, or state a normalisation under which both are true. There is none.
4. **Table $b$, $\#$ and $\wedge$ in [conventions.md](../findings/conventions.md)**, noting that $b$ is a fourth use of that letter and that the identity halves under the plain-Frobenius bivector norm.
5. **Say what the hypothesis is** (Bianchi, in Böhm–Wilking's sense, needing neither trace-freeness nor Ricci-flatness) and add the $n=4$ refinement $b(Q(R))=\mathop{\mathrm{tr}}(R)\,b(R)$, which contains the Lemma and a witness for its necessity.
6. **Promote §4c's norm formula**, which turns *"no marginal of $T$ can see it"* into a named object, $\mathop{\mathrm{tr}}(v_\alpha^2v_\beta^2)$.
