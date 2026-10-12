# Review r660, Lemma L116, $b(W^\#)=-b(W^2)$ on every curvature operator

**Review number: r660.** Reviewer B of an independent pair on identical briefs (the other takes r659; neither report, log nor intermediate state was read). Target: [findings/bounds-relaxations.md:246](../findings/bounds-relaxations.md#L246). Analysis only, no computation was run, and no positive claim below rests on one.

## Verdict

**CONFIRMED.** The identity is true, its hypothesis is stated correctly, and the literature attribution is faithful and in fact *understated*, Böhm–Wilking assert the stronger fact outright on their p. 6, which the block does not use. The self-historical clause *"before it was used"* checks out. Six defects, all of scope, normalisation or filing; one of them (D3) is a genuine correction to a stated scope, and one (D4) is an overclaim in the sentence that gives the Lemma its programme value.

## 0. The readings I adopt

The record's own file does not table three of the four objects this Lemma is written in, so I state my readings and the consequences of the alternatives.

| object | reading adopted | where it comes from | under the other reading |
| --- | --- | --- | --- |
| $\#$ | **Böhm–Wilking's, with the $\tfrac12$**: $\langle(R\,\#\,S)h,h\rangle=\tfrac12\sum_{\alpha\beta}\langle[Rb_\alpha,Sb_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$, eq. (4) | [notes.md](../references/boehm-wilking-2008-space-forms/notes.md), quoting the paper; pinned independently below | Hamilton's $\#_H=2\#_{\mathrm{BW}}$ makes the display **false by a factor 2**, the true statement becomes $b(W^{\#_H})=-2\,b(W^2)$ |
| $b$ | the **projection onto $\Lambda^4$** inside $S^2(\Lambda^2)$, i.e. the first-Bianchi defect; $b(R)=0\iff R\in S^2_B$ | forced by the block's own sentence and by the script's [wedge_map](../scripts/lib/b_bianchi_constraint.py#L41) | see D1/D2, the record's only tabled $\Lambda^4$ projection is $\mathrm{Alt}$, which carries a $\tfrac13$ the script's $b$ does not |
| $\wedge$ | $v\wedge v\in\Lambda^4$, in whatever fixed positive multiple makes $b(v\otimes v)=v\wedge v$ | the display is a proportionality; the constant is nowhere on the record | any other positive constant leaves the *identity* intact and changes the *numbers* |
| the pairing | $\tfrac12\operatorname{tr}$ at the $\Lambda^2$ level, the record's default | [conventions.md](../findings/conventions.md) | irrelevant to the identity, load-bearing for the digits |

**The $\#$ normalisation is pinnable from the record without new computation, and I pin it twice.** [notes.md](../references/boehm-wilking-2008-space-forms/notes.md) records $W\,\#\,I=-W$ and $I\,\#\,I=(n-2)I$ verified against [weyl.py](../scripts/lib/weyl.py) *with no rescaling*; under Hamilton's $\#$ those would read $-2W$ and $2(n-2)I$. Independently, tri-symmetry gives $\operatorname{tr}(2(W\#W)I)=\operatorname{tr}(2(W\#I)W)=-2\operatorname{tr}(W^2)$, so $\operatorname{tr}(W^\#)=-1$ at $\lVert W\rVert=1$, the record's standing value, and it holds only in BW's normalisation. **So the record is BW-normalised and the display is right as written**; a reader still cannot confirm that from [conventions.md](../findings/conventions.md), which is D1's real cost. This agrees with the note already sitting at [bounds.md:423](../findings/bounds.md#L423), *"it needs $W^\#$ in the half-sum reading, pinned by three occurrences on the record and tabled in none."*

## 1. The literature claim, checked against the source, and it is understated

**Does $S^2_B$ mean what the block says? Yes, verbatim.** [boehm-wilking-math0606187.txt:64–65](https://arxiv.org/abs/math/0606187):

> We denote by $S^2_B(\mathfrak{so}(n))$ the vectorspace of curvature operators, that is the vectorspace of selfadjoint endomorphisms of $\mathfrak{so}(n)$ satisfying the Bianchi identity.

and, from §1 of the same file, the equivalent characterisation the identity actually turns on: *"An endomorphism $R\in S^2(\mathfrak{so}(n))$ satisfies the first Bianchi identity if and only if $R$ is an element in $S^2_B(\mathfrak{so}(n))=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$"*, so $S^2_B$ is exactly the orthogonal complement of the $\Lambda^4$ summand, and $b$ is the projection onto that complementary summand. **The block's description is faithful.**

**"The sum preserves Bianchi", whose statement?** The block reaches it by inference: the ODE is *stated on* $S^2_B$, therefore $R\mapsto R^2+R^\#$ carries $S^2_B$ into itself. That inference is sound (Hamilton's maximum principle is asserted for closed convex $C\subseteq S^2_B$ invariant under $\dot R=R^2+R^\#$, which presupposes the vector field is tangent to $S^2_B$), and [notes.md](../references/boehm-wilking-2008-space-forms/notes.md) already labels it as an inference under the honest heading *"What this does and does not say"*. **So: this record's inference, correctly flagged as one, not a misattribution.**

**But the paper says it outright, twice, on p. 6, and neither the block nor the notes use those lines.** In the proof of Theorem 2:

> ... as $W\,W_2+W_2\,W+2\,W\,\#\,W_2$ lies in $\langle W\rangle$ and $R\in\langle\mathrm{Ric}_0\rangle$

and, three lines earlier, for $R,W\in\langle W\rangle$:

> It follows from formula (6) for the Ricci curvature of $R^2+R^\#$ that $(R\pm W)^2+(R\pm W)^\#$ has vanishing Ricci tensor. Hence $(R\pm W)^2+(R\pm W)^\#$ is a Weyl curvature operator ...

The first, polarised at $W_2=W$, is $2(W^2+W^\#)\in\langle W\rangle$; the second is the same statement unpolarised. **Both give $Q(W)\in\langle W\rangle\subseteq S^2_B$ directly, a published assertion, stronger than "preserves Bianchi", and exactly what L116 needs.** The block would be strictly better served by citing p. 6 than by inferring from the placement of the ODE. Recorded as an improvement, not a defect.

**"$R^\#$ alone does not", the record's, and true.** The paper makes no claim either way about $R^\#$ in isolation. The record's assertion that it fails is correct and is witnessed by the block's own $\mathbb{CP}^3$/$\mathbb{CP}^4$ figures; it is also forced by the identity itself, since $b(W^\#)=-b(W^2)$ with $b(W^2)\ne0$ somewhere is the same sentence. Note that **$R^2$ alone equally fails**, the block says this implicitly and never says it, which slightly obscures that the two defects are symmetric partners rather than one anomaly.

**"Before it was used", VERIFIED.** `git log -S 'b(W^2)=0' --all` and `git log -S 'b(W^\#)' --all` both bottom out at commit `46195d1d` (2026-08-23), the commit that *introduces the correction*; the string never appears in any earlier tree. A repo-wide grep for `b(W^2)` finds the wrong version only inside the correction's own prose and inside [b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py), where it is quoted as the thing being refuted. **Nothing on the record rests on the wrong version. Blast radius zero, as the heading claims.**

## 2. The identity, derived, and its hypothesis pinned by a witness

### 2.1 It is one fact with the literature claim, not two

$b$ is linear, so

$$b(W^\#)=-b(W^2)\iff b(W^2+W^\#)=0\iff Q(W)\in S^2_B .$$

**The equivalence is immediate and exact.** So the brief's suspicion is right: the "literature claim" and the "identity" are the same proposition written twice. The block presents them adjacently and in the right logical order (the second is offered as *"what holds instead"*) but it **never states that they are equivalent**, which leaves a reader to suppose the display carries content beyond the preservation statement. It does not. Recorded under D4.

There is also a **second, cheaper route that the block does not mention and that proves less than the heading**: at a *critical* point, $W^\#=\theta W-W^2$, so $b(W^\#)=\theta\,b(W)-b(W^2)=-b(W^2)$ using only $b(W)=0$. This is one line and needs no literature at all, but it holds only on the critical set, whereas the heading claims *every* curvature operator. [ELIM-bounds.md:39](ELIM-bounds.md#L39) already records exactly this observation. The block's route is the stronger one and is the right one; the two should not be conflated.

### 2.2 A derivation of the strong form

Representation theory does **not** deliver it. $\Phi(R,S):=\tfrac12(RS+SR)+R\#S$ is $O(n)$-equivariant and symmetric, and by the total symmetry of BW's $\mathrm{tri}$ the claim $\pi_{\Lambda^4}\Phi(S^2_B,S^2_B)=0$ is equivalent to $\Phi(S^2_B,\Lambda^4)\subseteq\Lambda^4$. Schur settles only the $\langle I\rangle$ corner: $\Lambda^4\otimes\langle I\rangle\cong\Lambda^4$ and $\Lambda^4$ has multiplicity one in $S^2(\mathfrak{so}(n))$, so $\Phi(I,\Lambda^4)\subseteq\Lambda^4$ for free. For $\langle W\rangle$ it does not, because $\Lambda^4$ occurs in $S^2(\langle W\rangle)$ in general. **The vanishing is a coefficient identity with content**, which is also [ELIM-bounds.md:117](ELIM-bounds.md#L117)'s independent reading.

A complete argument the record can hold, short of Hamilton's index computation:

1. Every $R\in S^2_B$ is the curvature operator at a point of some metric, normal coordinates $g_{ij}=\delta_{ij}-\tfrac13R_{ikjl}x^kx^l$, first Bianchi being exactly what makes $R$ an algebraic curvature tensor.
2. Run Ricci flow briefly from that metric. In a moving frame $\partial_tR=\Delta R+2(R^2+R^\#)$, and $R_t$ is a genuine curvature tensor at every $t$, so $b(R_t)\equiv0$ as a section.
3. $b$ is a parallel bundle map built from the metric alone, so it commutes with $\Delta$. Differentiating at $t=0$: $0=\partial_t b(R)=\Delta\big(b(R)\big)+2\,b(Q(R))=2\,b(Q(R))$.

Hence $b(Q(R))=0$ on all of $S^2_B$. **For the record's purposes the cleanest fix is simply to cite BW p. 6**, which asserts the Weyl case outright.

### 2.3 The closed form is correct, and it is not frame-dependent

$W=\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$ gives $W^2=\sum_\alpha\lambda_\alpha^2\,v_\alpha\otimes v_\alpha$, and $b$ is linear, so $b(W^2)=\sum_\alpha\lambda_\alpha^2\,b(v_\alpha\otimes v_\alpha)$ with $b(v\otimes v)$ a positive multiple of $v\wedge v$, in index form the Bianchi sum $v_{ij}v_{kl}+v_{ik}v_{lj}+v_{il}v_{jk}$, which is the wedge square. **The display is therefore the spectral decomposition of $W^2$ pushed through a linear map, and nothing more.**

**It is not the defect shape the brief warns about.** For any orthonormal basis $\{u_\beta\}$ of $\Lambda^2$ and $A=\sum A_{\beta\gamma}u_\beta\otimes u_\gamma$ symmetric, $b(A)=\sum A_{\beta\gamma}\,u_\beta\wedge u_\gamma$; the eigenframe is a convenience, not a hypothesis. Within a degenerate eigenspace the expression is invariant under $O$-changes of basis, since $\sum_\beta(\sum_\alpha O_{\beta\alpha}v_\alpha)\wedge(\sum_\gamma O_{\beta\gamma}v_\gamma)=\sum_\alpha v_\alpha\wedge v_\alpha$ by orthogonality. **Frame-free left side, frame-free right side. No defect here.** The record already holds the degree-one sibling in the same shape, $b(W)=\sum_\alpha\lambda_\alpha(v_\alpha\wedge v_\alpha)=0$, in [b_bianchi_constraint.py](../scripts/lib/b_bianchi_constraint.py)'s own description, and L116 is its degree-two analogue, uncited either way.

### 2.4 The hypothesis, exactly, and a witness that it is needed

- **Trace-freeness: NOT needed.** The argument runs on all of $S^2_B=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$, so the identity holds for every curvature operator, Weyl or not. The heading says "on every curvature operator", which is **wider than the record's usage and exactly right**, a rare case in this record where the heading does not undersell.
- **Bianchi for $W$ itself: NEEDED**, and here is the witness, by hand at $n=4$.

Take $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ and $\star=\Pi_+-\Pi_-$, which spans $\Lambda^4(\mathbb R^4)$ ([conventions.md](../findings/conventions.md): *"Inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto the Hodge star"*). Brackets vanish across the two factors, and $\star$ acts as $\pm1$ on each, so in BW's eq. (4) every surviving $(\alpha,\beta)$ pair lies in a single factor and picks up $(\pm1)^2=+1$ for $\star\#\star$ and $\pm1$ for $I\#\star$. Hence

$$\star\,\#\,\star=I\,\#\,I=(n-2)I=2I,\qquad I\,\#\,\star=2\star,\qquad \star^2=I .$$

For $R=I+t\star$ (so $b(R)=t\star\ne0$ for $t\ne0$):

$$R^2=(1+t^2)I+2t\star,\qquad R^\#=2I+4t\star+2t^2I,\qquad Q(R)=(3+3t^2)\,I+6t\,\star .$$

So $b(Q(R))=6t\,\star\neq0$. **The cancellation fails off $S^2_B$**, and the hypothesis "curvature operator" is doing real work. *(A curiosity worth one line: at $t\to\infty$, i.e. $R=\star$ itself, $Q(\star)=I+2I=3I$ and the cancellation accidentally holds. So $b(R)=0$ is sufficient but not necessary, the heading names the right hypothesis, not a characterisation.)*

## 3. Consequences

**What the identity constrains.** Since $W\in\mathcal W_n$ gives $b(W)=0$, the identity constrains **only the sum**: $b(W^2)$ and $b(W^\#)$ are each nonzero in general and neither is separately pinned by Bianchi. What the display adds is that $b(W^\#)$ is *computable* from $(\lambda,\text{frame})$, being $-\sum\lambda_\alpha^2(v_\alpha\wedge v_\alpha)$. The block's emphasis (*"with both sides genuinely nonzero"*), is the right one and is what stops the reader from collapsing the statement to $0=0$.

**The $\mathbb{CP}^3$/$\mathbb{CP}^4$ figures.** I cannot re-run them and do not. Qualitatively they are consistent: the Kähler form is an eigen-bivector of the Fubini–Study Weyl operator and $\omega\wedge\omega\ne0$ for $m\ge2$, so the frame is non-decomposable and vanishing of the sum would be a coincidence. **The digits themselves are unverified here** (D2 explains why they are also uninterpretable as written).

**Does anything on the record use $W^\#$ alone as a curvature operator? No, I found no surviving instance.** The sweep and its results:

| candidate | verdict |
| --- | --- |
| [bounds-relaxations.md:291](../findings/bounds-relaxations.md#L291), *"$\operatorname{tr}(W^\#)=-1$, which holds because $Q$ preserves the trace-free Weyl space"* | **correct**: it invokes $Q$, i.e. the sum, never $W^\#$ alone |
| [bounds.md:181](../findings/bounds.md#L181), *"$\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ identically on $\mathcal W_n$"* | **correct**, and it is L116's trace-component sibling; [r358:51](REVIEW_r358.md#L51) already noted L116 is *"the same fact one level finer, on the Bianchi component"* |
| [ELIM-bounds.md:15](ELIM-bounds.md#L15), argues the per-row identity does **not** apply to $W^2$ because $W^2\notin\mathcal W_n$ | **correct, and it is a consumer of L116 in the right direction** |
| [r331:53](REVIEW_r331.md#L53), *"$b(W)=0$ does not constrain $b(W^2)$"* | **correct** |
| [nondegeneracy.md:409](../findings/nondegeneracy.md#L409), padding *"forces $W^\#$ back into the block"* | a support statement, not a Bianchi one; **clean** |

**This is the most valuable negative I can return: the error L116 exists to prevent is not present anywhere on the record.**

## 4. Defects

### D3, the degeneracy is the entire coordinate-diagonal locus, not $S^3\times S^3$ *(substantive; the one I would fix first)*

[bounds-relaxations.md:280](../findings/bounds-relaxations.md#L280) says *"At $S^3\times S^3$ both $b(W^2)$ and $b(W^\#)$ vanish outright, so a screen run only there returns zero twice."* **True, and far too narrow.** The real statement:

> $b(W^2)=b(W^\#)=0$ at **every** coordinate-diagonal $W$, i.e. on the whole of $\mathcal D_n$.

Two lines. If $W$ is diagonal in a coordinate pair basis $\{e_i\wedge e_j\}$ then every eigenvector is **decomposable**, and $v\wedge v=0$ for decomposable $v$, so the closed form of §2.3 gives $b(W^2)=0$ immediately. For $W^\#$, BW's own text after eq. (4) settles it: *"Inspection of (4) shows that also $R^2+R^\#$ is diagonal with respect to this basis"*, with $(R^2+R^\#)_{ij}=R_{ij}^2+\sum_{k\ne i,j}R_{ik}R_{jk}$, so $W^\#$ is coordinate-diagonal too, and $b$ annihilates every coordinate-diagonal operator (its kernel contains everything supported on fewer than four distinct indices, visible directly in [wedge_map](../scripts/lib/b_bianchi_constraint.py#L41), which skips $|\{i,j,k,l\}|<4$).

Why this matters beyond bookkeeping:

- $S^3\times S^3$ is *coordinate-diagonal*, so the block's warning generalises to a class the record already names and studies heavily ([diagonal-half.md](../findings/diagonal-half.md), $\mathcal D_n$ in [conventions.md](../findings/conventions.md)).
- **Every screen of this identity restricted to diagonal points is vacuous**, including the two-block slice $S^m\times S^m$, which is precisely the configuration where [the same file](../findings/bounds-relaxations.md#L291) reports the bracket-transportation LP is exactly tight. So the proposed handle contributes nothing at the one place the relaxation currently works, and must earn its keep entirely off the diagonal locus. The block does not say this.

### D4, *"the handle fence post F15 says is missing"* overclaims

The sentence at [:254](../findings/bounds-relaxations.md#L254) asserts that the cancellation is *"a relation between $\lambda$ and the frame that no marginal of $T$ can see, so it is the handle fence post F15 says is missing."*

- **The first half is right.** $v_\alpha\wedge v_\alpha$ and the unsquared $\langle[v_\alpha,v_\beta],v_\gamma\rangle$ are sign-carrying frame data, invisible to $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ and its marginals. [ELIM-bounds.md:39](ELIM-bounds.md#L39) endorses the same reading independently.
- **The second half does not follow.** F15's conclusion is *"frame-realizability has to enter"*. The cancellation **is** frame-realizability, it is $b(W)=0$ propagated through $Q$, per §2.1, so calling it *the handle* renames the obstruction rather than supplying a way past it. The record already held the same content: [b_bianchi_constraint.py](../scripts/lib/b_bianchi_constraint.py) records that penalising $\sum\lambda_\alpha(v_\alpha\wedge v_\alpha)=0$ *"closes the whole gap between the relaxation and $\mathrm{Weyl}_6$"*. Combined with D3, the honest statement is: **a relation of the right kind, empty on the diagonal locus, and not yet a handle.**

### D1, $b$ is a fourth collision on the letter, and the Bianchi map is defined nowhere

[conventions.md](../findings/conventions.md) tables $b$ as *"in the orbit calculus $b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$"*, and warns that [second-order.md](../findings/second-order.md) uses $b$ for a *scalar* forty-four lines above. **L116's $b$ (the first-Bianchi defect, a $\Lambda^4$-valued map), is a third sense and is tabled nowhere.** The block introduces it with no definition, in a file whose companions carry $\mathrm{Alt}$ under a different symbol for the same projection. This is exactly the class of collision the conventions file exists to catch, and it is live.

### D2, the normalisation of $b$ is unstated, so $0.962$ and $0.953$ are uninterpretable

The record's computational $b$ ([wedge_map](../scripts/lib/b_bianchi_constraint.py#L41)) is the **unnormalised** signed Bianchi sum over each $4$-set, summed over ordered pair-splittings, with an $\ell^2$ norm over $4$-sets. [conventions.md](../findings/conventions.md)'s only $\Lambda^4$ projection is $\mathrm{Alt}$, which *"carries its $\tfrac13$"* and satisfies $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$. **The two differ by a fixed positive factor that appears nowhere on the record.** Consequences:

- The *identity* is untouched, both sides scale together, so the display is right under either.
- The *figures* are not. $0.962$ against $\lVert W\rVert=1$ would violate $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$ intuitions if read as an $\mathrm{Alt}$-norm of $W^2$; read in the script's convention it is unremarkable. **A reader cannot tell which, and no other number on the record is comparable to them.** Same class as the $\varphi_{ab}$ norm and the $\sum\lambda^2=1$ vs $2$ collisions already tabled.

### D5, the same fact sits unnumbered elsewhere, with three consumers, none of which cite L116

[problem.md:70](../findings/problem.md#L70) records, from Reviewer 90: *"$\Phi$ preserves the first Bianchi identity, without it $\Phi(W)$ could carry a $\Lambda^4$ component and '$\Phi(W)$ is Weyl' would not follow (standard Hamilton fact)."* That is L116, unnumbered and with a better attribution. It is then consumed at:

- [bounds.md:181](../findings/bounds.md#L181), *"proved on the record at problem.md ... together with $\Phi$ preserving first Bianchi, and **the whole deficiency section stands on it**"*;
- [graded-half.md:249](../findings/graded-half.md#L249), *"problem.md already carries it ... plus Hamilton's Bianchi preservation"*, where it withdraws a caveat as vacuous;
- [fence-posts.md:420](../findings/fence-posts.md#L420), *"circularity through $Q$ preserving $\mathcal W_n$"*.

**Not a duplicate under another number** (the brief's specific question) but a duplicate across a number and a bare fact, with the numbered version orphaned and the unnumbered one load-bearing. `git log -S` dates L116's commit to 2026-08-23 and problem.md's note to 2026-08-26, so **L116 came first and was not found three days later**. Neither side cross-references the other. The fix is one clause in each direction.

### D6, L116's own citations are filed under L115

The block's material is split by another Lemma. Reading order in the file: L116 heading at [:246](../findings/bounds-relaxations.md#L246), its correction and display at [:248–254](../findings/bounds-relaxations.md#L248), then *"What $M$ actually is"* at [:256](../findings/bounds-relaxations.md#L256), then **L115's heading at [:268](../findings/bounds-relaxations.md#L268)**, two L115 subsections, and only then, at [:280](../findings/bounds-relaxations.md#L280), *"A degenerate point that would have confirmed the false version"*, which is L116's content and **the only place either of L116's two pointers appears** ([b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py) and the [BW notes](../references/boehm-wilking-2008-space-forms/notes.md)). As filed, L116 cites nothing and L115 cites L116's sources. Both Lemmas also sit inside a `##` section owned by fence post F15, with no section of their own.

## 5. Pointers and record hygiene

| check | result |
| --- | --- |
| [b_rayleigh_identities.py](../scripts/route-b/b_rayleigh_identities.py) | **resolves** |
| [BW notes.md](../references/boehm-wilking-2008-space-forms/notes.md) | **resolves**, and its quoted definitions match the PDF text dump |
| [conventions.md](../findings/conventions.md) | **resolves** (in the file's trailer) |
| L116 in [INDEX-results.md:134](../findings/INDEX-results.md#L134) | present, *"Gate 2: no verdict on the record"*, this review is one half of that verdict |
| L116 row in [results.md](../results.md) | **absent**, as for L110, L114, L115 and L119 from the same file. File-wide backlog already charged by [r574](REVIEW_r574.md#L170) and [r614](REVIEW_r614.md#L198); **not charged here** |
| boilerplate provenance note (*"Re-filed here 2026-09-02 from second-order.md"*) | consistent with `git log`: the block was authored 2026-08-23 in the flat record and moved by the split commits. **Clean** |

## 6. Summary of recommendations

1. **Fix D3**, replace "$S^3\times S^3$" with "every coordinate-diagonal $W$", give the two-line reason, and say that this empties the identity on the two-block slice where the LP is already tight.
2. **Soften D4**, the cancellation is frame-realizability restated, so drop "is the handle" for "is the frame-realizability content in a form the LP could in principle carry, off the diagonal locus".
3. **Table $b$ and its normalisation** in [conventions.md](../findings/conventions.md) (D1, D2), and restate the two figures in the tabled convention or drop them.
4. **Cite BW p. 6** (*"$(R\pm W)^2+(R\pm W)^\#$ is a Weyl curvature operator"*), in place of, or beside, the inference from the ODE's placement.
5. **Cross-reference [problem.md:70](../findings/problem.md#L70) and L116** in both directions (D5), and move the [:280](../findings/bounds-relaxations.md#L280) paragraph back above L115's heading (D6).
6. Add the one-line critical-point route of §2.1, explicitly marked as proving less than the heading, so a later reader does not substitute it for the strong form.

---

*Reviewer B, r660. Derived cold from [conventions.md](../findings/conventions.md), the [Böhm–Wilking source](https://arxiv.org/abs/math/0606187) and the definitions; no computation run, per the standing analysis-only rule. The $n=4$ witness in §2.4 and the diagonal-locus argument in D3 are hand calculations and are stated so that they can be checked without a machine.*
