# r825: Gate 2 on the refutation of the $\dim V=6$ parameter count

*Cold brief: I was given the note and the refutation verbatim, and read [findings/diagonal-half.md](../findings/diagonal-half.md) around the box and through the rank-three census (L176 through L191) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand and every dimension is exact. No screens were needed and none were run. Log: [agent_logs/g2-equivariance-r825.log](../agent_logs/g2-equivariance-r825.log).*

**VERDICT: CONFIRMED.** *The refutation's conclusion stands and is stronger than it claims. Three corrections are owed: its stabiliser bound is loose by five, one of its inferences runs backwards, and its closing sentence about the record is not honest.*

| Claim of the refutation | Verdict |
|---|---|
| **R1**: the count subtracts $35$ from $40$ and reads $5$, which is the dimension only where $F$ is a submersion | **CONFIRMED**, and the failure is far larger than the refutation says: $S$ contains an explicit **twelve-dimensional** family, so "$5$" is wrong by $7$ and is refuted without any equivariance argument at all |
| **R2**: $F$ is $O(6)$-equivariant, its zero set is invariant, and $\mathfrak g\cdot p\subseteq\ker dF_p$ at every solution | **CONFIRMED.** Every hypothesis the step needs holds here, and the step needs neither smoothness of $S$ nor a tangent space to $S$. The refutation's word *tangent* is loose and the operative inequality is right |
| **R3**: a triple of nonzero forms has stabiliser of dimension at most $9$, so every orbit has dimension at least $6$ | **CONFIRMED but LOOSE BY FIVE.** The stabiliser of a **triple** is the centraliser of a $3$-plane in $\mathfrak{so}(6)$ and has dimension at most $\mathbf 4$, so every orbit has dimension at least $\mathbf{11}$, the rank is at most $29$, and at least $\mathbf 6$ of the $35$ constraints are dependent at every solution |
| **R4**: therefore $\dim S\ge40-34=6$ | **THE INFERENCE IS BACKWARDS.** A rank bound gives an **upper** bound on the local dimension of a fibre, never a lower one ($F(x)=\lVert x\rVert^2$ has rank $0$ and a point for a zero set). The conclusion is true for a different and trivial reason, the orbit sitting **inside** $S$, and the true bound is $\dim S\ge12$ |
| **R5**: the orbit argument built on the count is *circular* | **MISLABELLED.** The note's argument is self-undermining rather than circular: it computes $5$ from an independence assumption that its own conclusion denies. It is also simply **false**, by exhibit |
| **R6**: the count says nothing about emptiness | **CONFIRMED, and provable rather than merely asserted.** The branch is an **open** subset of $S$, and $S$ is inhabited in dimension $12$. So no parameter count over this space can bear on the branch: any count concluding emptiness also empties the padded locus, which is inhabited |
| **R7**: the corrected count is consistent with the solution set being one orbit, which is the shape a successor should use | **UNSUPPORTED.** The one component of $S$ the record can compute is a **one-parameter family of $11$-dimensional orbits**, not a single orbit, and its quotient is the weight circle |
| **R8**: the branch's emptiness at $\dim V=6$ is open *with nothing pointing either way* | **THE FIRST HALF IS RIGHT AND THE SECOND IS NOT HONEST.** Every sub-case of $\dim V=6$ the record has decided has come out **empty** ([L184](../findings/diagonal-half.md), [L185](../findings/diagonal-half.md), [L186](../findings/diagonal-half.md), [L189](../findings/diagonal-half.md), [L191](../findings/diagonal-half.md)). What carries no weight is the count, not the record |
| **The count's own arithmetic** ($45-6=39$, $+1$, $20+15=35$) | **ALL THREE CORRECT.** I found no fourth automatic dependency among the $35$ beyond the trace |

**One line.** *The refutation's conclusion is right and its route is the weaker of the two available: the count dies to a twelve-dimensional family of solutions the record already owns, and the reason no count can settle this branch is that the branch is cut out by an OPEN condition, which a dimension count cannot see. Its equivariance argument is correct, its stabiliser bound is loose by five, and one of its inferences runs the wrong way. The sentence to rewrite is "nothing pointing either way".*

## 0. The setting, fixed once

$X$ is the parameter space the note counts: orthonormal triples $(\omega_1,\omega_2,\omega_3)$ in $\Lambda^2\mathbb R^6$ together with a unit weight vector $\lambda$ with $\sum_i\lambda_i=0$ and every $\lambda_i\ne0$. $F:X\to S^2_0\mathbb R^6\oplus\Lambda^4\mathbb R^6\cong\mathbb R^{35}$ is $F(\omega,\lambda)=\bigl(\sum_i\lambda_i\omega_i^2,\ \sum_i\lambda_i\,\omega_i\wedge\omega_i\bigr)$, and $S=F^{-1}(0)$.

Conventions are [L180](../findings/diagonal-half.md)'s: $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$, so $\mathop{\mathrm{tr}}(\omega\eta)=-2\langle\omega,\eta\rangle$ and $A_i=-\omega_i^2$ is positive semidefinite of trace $2$.

**The branch under discussion is $S\cap U$, where $U=\{\dim(\mathop{\mathrm{im}}\omega_1+\mathop{\mathrm{im}}\omega_2+\mathop{\mathrm{im}}\omega_3)=6\}$.** By [L180](../findings/diagonal-half.md) that span is a single form's image, so $U=\{\mathop{\mathrm{rank}}\omega_{i_0}=6\}$ either way. **$U$ is OPEN in $X$**, the rank of a matrix being lower semicontinuous and $6$ the maximum. This is used in §5 and it is the whole of the matter.

## 1. The count's arithmetic: three numbers, all correct

**Located.** [findings/diagonal-half.md](../findings/diagonal-half.md), the box beginning *"A PARAMETER COUNT SAYS TO EXPECT EMPTINESS"*.

$\dim V_3(\mathbb R^{15})=3\cdot15-\tfrac{3\cdot4}{2}=45-6=39$, which is the note's $45-6$. The unit traceless weights are a circle in the plane $\sum\lambda_i=0$, dimension $1$, giving $40$.

The $S^2$ target has dimension $21$ and its trace is automatic: $\mathop{\mathrm{tr}}(\sum_i\lambda_i\omega_i^2)=-\sum_i\lambda_i\lVert\omega_i\rVert^2_{\mathrm F}=-2\sum_i\lambda_i=0$, which uses **both** unit norms and traceless weights and so is genuine on $X$. That leaves $20$. The $\Lambda^4$ target has $\binom64=15$. Total $35$, and $40-35=5$.

**I looked for a fourth automatic dependency and found none.** A further linear functional annihilating the image of $F$ would have to be $O(6)$-natural and vanish identically on $X$. In $S^2$ the only $O(6)$-invariant functional is the trace, already spent. In $\Lambda^4$, transporting by $\star$ to $\Lambda^2$ turns Bianchi into $2\sum_i\lambda_i\,\mathrm{Padj}(\omega_i)$, and the candidate pairings are $\langle\mathrm{Padj}(\omega_i),\omega_j\rangle$, which is $3\,\mathrm{Pf}(\omega_i)$ at $i=j$ by [L187](../findings/diagonal-half.md)'s `inner_sigma_self` and is unconstrained at $i\ne j$. Pairing with the volume form gives $2\sum_i\lambda_i\mathrm{Pf}(\omega_i)$, which vanishes on no locus forced by $X$.

**So the count is arithmetically clean, and it is still false.** That is §2.

## 2. The decisive exhibit: $S$ is at least twelve-dimensional at $\dim V=6$

**This is the concrete refutation of the count, and it is built entirely from results the record already holds.**

Take any $4$-dimensional subspace $P\subset\mathbb R^6$ with an orientation, and any orthonormal basis $\omega_1,\omega_2,\omega_3$ of $\Lambda^+P\subset\Lambda^2P\subset\Lambda^2\mathbb R^6$. The embedding is isometric, so the triple is orthonormal in $\Lambda^2\mathbb R^6$. Every unit $\omega\in\Lambda^+P$ has $\omega^2=-\tfrac12\Pi_P$ and $\omega\wedge\omega=\mathrm{vol}_P$: the first because $\omega=\tfrac1{\sqrt2}(e^{12}+e^{34})$ in an adapted frame, the second because $\omega\mapsto\omega\wedge\omega$ is $SO(4)$-equivariant into the trivial $\Lambda^4P$ and $SO(4)$ is transitive on the unit sphere of $\Lambda^+P$. This is [L183](../findings/diagonal-half.md)'s own account of $n=4$ and [L190](../findings/diagonal-half.md)'s inhabited family.

Hence, for **every** unit traceless $\lambda$,
$$\sum_i\lambda_i\omega_i^2=-\tfrac12\Bigl(\sum_i\lambda_i\Bigr)\Pi_P=0,\qquad \sum_i\lambda_i\,\omega_i\wedge\omega_i=\Bigl(\sum_i\lambda_i\Bigr)\mathrm{vol}_P=0 .$$

**Counting this family.** The Grassmannian $Gr(4,6)$ has dimension $8$, the orthonormal bases of the $3$-dimensional $\Lambda^+P$ form an $O(3)$ of dimension $3$, and the weight circle is $1$:
$$8+3+1=\mathbf{12}.$$

**So $\dim S\ge12$ against the count's $5$.** The count is not merely unjustified, it is wrong by seven, and refuted by an object the record has carried since [L178](../findings/diagonal-half.md). **Nothing in this exhibit uses equivariance, submersions, stabilisers or orbits.**

**This also settles what the count's "$5$" could ever have meant.** It is the expected dimension under an independence hypothesis, and the hypothesis fails on a set of dimension $12$.

**The note's sentence dies with it.** *"Any solution with finite stabiliser needs a $15$-dimensional orbit inside a $5$-dimensional set"* compares an orbit against a number that is not the dimension of the set. And the solutions the record can name have stabiliser of dimension $4$, so the finite-stabiliser hypothesis is not the generic case here either.

## 3. R2, the equivariance step: correct, with the hypotheses it needs

**Located.** *"The map is $O(6)$-equivariant and its zero set is invariant, so at every solution the orbit is tangent to the zero set and lies in the kernel of the differential."*

**The step needs exactly four things, and all four hold.**

1. **$X$ is a smooth manifold and $F$ is smooth on it.** $V_3(\Lambda^2\mathbb R^6)\times S^1$ is a compact smooth manifold and $F$ is polynomial. ✓
2. **$G=O(6)$ acts smoothly on $X$, preserving it.** The action is $g\cdot(\omega_i,\lambda)=(g\omega_ig^{\mathsf T},\lambda)$. The $\Lambda^2$ inner product is $O(6)$-invariant, so orthonormality is preserved, and the weights are untouched. ✓
3. **$F$ is equivariant for a LINEAR action on the target.** $(g\omega g^{\mathsf T})^2=g\omega^2g^{\mathsf T}$, which uses $g^{\mathsf T}g=I$, and $(\Lambda^2g\,\omega)\wedge(\Lambda^2g\,\omega)=\Lambda^4g\,(\omega\wedge\omega)$, which is functoriality and needs nothing. The trace-free subspace of $S^2$ is invariant. ✓
4. **$0$ is a fixed point of the target action**, so $S$ is the full preimage of a fixed point and is invariant. ✓

**Then the conclusion follows from a curve and needs no tangent space to $S$.** For $A\in\mathfrak{so}(6)$, $t\mapsto F(\exp(tA)\cdot p)$ is identically $0$, so differentiating at $t=0$ gives $dF_p(\widehat A_p)=0$ where $\widehat A_p=\tfrac{d}{dt}\big|_0\exp(tA)\cdot p$. The span of these is $T_p(G\cdot p)$, of dimension $\dim G-\dim G_p$. Hence
$$\mathop{\mathrm{rank}}dF_p\le 40-\dim(G\cdot p).$$

**The refutation's phrase *"the orbit is tangent to the zero set"* is the loose part.** $S$ carries no tangent space where it is singular, and singular is exactly where this argument says it is. The repair is one word: the orbit lies **inside** the zero set, and differentiating along it gives the kernel statement. The inequality the refutation actually uses is correct as written.

**$O(6)$ against $SO(6)$ changes nothing of dimension.** Both have dimension $15$, the extra component adds no tangent directions, and $\{\pm I\}$ acts trivially on $\Lambda^2$ so the effective group is $15$-dimensional as well. A **disconnected** stabiliser likewise changes nothing: $\dim G_p=\dim(G_p)^\circ$, and $(G_p)^\circ\subseteq SO(6)$, which is why the refutation is right to argue over connected subgroups. Orientation-reversing $g$ preserve both constraints, the $\Lambda^4$ action being honest at any determinant.

## 4. R3, the stabiliser: correct as stated, and loose by five

**The refutation's own argument checks out.** A connected subgroup of $SO(6)$ of dimension $\ge10$ lies in a maximal connected proper one. Through $Spin(6)\cong SU(4)$ those are $Sp(2)=Spin(5)\to SO(5)$ (dimension $10$), $S(U(3)\times U(1))\to U(3)$ (dimension $\mathbf 9$, which the brief asks to check and which is right), $S(U(2)\times U(2))\to SO(4)\times SO(2)$ ($7$), $SO(4)\to SO(3)\times SO(3)$ ($6$), and $SO(3)$ ($3$). The maximal proper subgroups of $SO(5)$ top out at $SO(4)$, dimension $6$. So dimension $\ge10$ leaves $SO(6)$ and $SO(5)$ alone, as claimed. Neither fixes a nonzero $2$-form: $\Lambda^2\mathbb R^6=\mathfrak{so}(6)$ is the adjoint, irreducible and nontrivial, and under $SO(5)$ acting as $5+1$ it is $\Lambda^2\mathbb R^5\oplus\mathbb R^5=\mathfrak{so}(5)\oplus\mathbb R^5$, two nontrivial irreducibles.

**But the refutation stops one step short, and the sharp bound is much better.** $\Lambda^2\mathbb R^6$ **is** the adjoint representation, so for a connected $H$ the fixed forms are the centraliser: $(\Lambda^2\mathbb R^6)^H=\mathfrak z_{\mathfrak{so}(6)}(\mathfrak h)$. The stabiliser of the triple fixes each $\omega_i$, so with $\mathfrak a=\mathop{\mathrm{span}}(\omega_1,\omega_2,\omega_3)$, a genuine $3$-plane by orthonormality,
$$\mathfrak g_p=\mathfrak z_{\mathfrak{so}(6)}(\mathfrak a).$$

**Claim: $\dim\mathfrak z(\mathfrak a)\le4$ for every $3$-plane $\mathfrak a\subset\mathfrak{so}(6)$.** Put $\mathfrak h=\mathfrak z(\mathfrak a)$, so $\mathfrak a\subseteq\mathfrak z(\mathfrak h)$ and $\dim\mathfrak z(\mathfrak h)\ge3$. Subalgebras of a compact algebra are reductive, and I ran the list:

| $\dim\mathfrak h$ | the algebra | $\dim\mathfrak z(\mathfrak h)$ |
|---|---|---|
| $10$ | $\mathfrak{so}(5)$ | $0$ |
| $9$ | $\mathfrak u(3)$ | $1$, the Kähler form |
| $8$ | $\mathfrak{su}(3)$ | $1$ |
| $7$ | $\mathfrak{so}(4)\oplus\mathfrak{so}(2)$ | $1$ |
| $6$ | $\mathfrak{so}(4)$, or $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ on $3+3$ | $1$, resp. $0$ |
| $5$ | $\mathfrak{su}(2)_\alpha\oplus\ker\alpha$, the only reductive shape of rank $\le3$ | $2$ |

The $\mathfrak u(3)$ row is the one to check by hand: $\Lambda^2\mathbb R^6\otimes\mathbb C=\Lambda^2\mathbb C^3\oplus(\mathbb C^3\otimes\overline{\mathbb C^3})\oplus\Lambda^2\overline{\mathbb C^3}$, where $\Lambda^2\mathbb C^3\cong\overline{\mathbb C^3}\otimes\det$ has central character $z^2$ and contributes nothing, and $\mathbb C^3\otimes\overline{\mathbb C^3}=\mathfrak{gl}_3$ contributes the scalars. The dimension-$5$ row: any dimension-$5$ reductive subalgebra of rank $\le3$ is $\mathfrak{su}(2)\oplus\mathbb R^2$ with the $\mathbb R^2$ centralising the $\mathfrak{su}(2)$, hence $\mathbb R^2=\ker\alpha$ and $\mathfrak h$ of full rank $3$, so $\mathfrak z(\mathfrak h)\subseteq\mathfrak t$, and the only roots vanishing on the $2$-plane $\ker\alpha$ are $\pm\alpha$, giving $\mathfrak z(\mathfrak h)=\ker\alpha$ of dimension $2$.

**So $\dim\mathfrak h\ge5$ forces $\dim\mathfrak z(\mathfrak h)\le2<3$, and therefore $\dim\mathfrak g_p\le4$.** The bound is attained: $\mathfrak a=\Lambda^+P$ has $\mathfrak z(\mathfrak a)=\mathfrak{su}(2)_-\oplus\mathfrak{so}(2)$, dimension $4$, which is exactly the padded family of §2.

**The consequences, all stronger than the refutation's.**
$$\dim(G\cdot p)\ge\mathbf{11},\qquad \mathop{\mathrm{rank}}dF_p\le\mathbf{29},\qquad \#\{\text{dependencies among the }35\}\ \ge\ \mathbf 6 .$$
The refutation's $6/34/1$ becomes $11/29/6$. **The refutation's "finite stabiliser" case never occurs at all**: no triple in $\Lambda^2\mathbb R^6$ has a finite stabiliser, so its own "$15$-dimensional orbit, rank $\le25$" paragraph describes an empty case, as does the note's.

**The clean form of the inequality, which is the note and the refutation read at two rows.** Writing $d=\dim(G\cdot p)$, the corank of $dF_p$ in the $35$-dimensional target is at least $d-5$. **The note's "$5$" is precisely the amount of orbit the target can absorb before the constraints must be dependent.** The note read the inequality as a contradiction and the refutation read it as an escape, and it is one inequality.

## 5. R6, the overreach: the refutation is right, and for a better reason than it gives

**I tried to rescue the note's conclusion by every route the brief names, and the rescue fails for a reason that is itself the finding.**

**Attempt: the slice count.** Take a slice $N$ transverse to the orbit at a solution, $\dim N=40-d\le29$. The equivariance-forced degeneracy is removed on $N$, so the naive expectation applies there and gives $\dim(N\cap S)=40-d-35=5-d\le-6$. Read as a prediction, this says *expect emptiness*, and more strongly than the note did.

**And that prediction is FALSE, on the record's own family.** At the padded locus of §2, $d=11$ exactly, so the slice count predicts $-6$ and the truth is $1$, the weight circle. **The equivariant count is off by seven at the one place in this problem where the answer is known.** The reason is visible: on $\Lambda^+P$ every $\omega^2$ and every $\omega\wedge\omega$ is constant, so the $35$ constraints collapse wholesale for structural reasons that no count sees.

**Attempt: restrict to the branch.** This is where the argument closes. The branch is $S\cap U$ with $U$ open (§0). **Adding an open condition changes no dimension count**: $X$ still has dimension $40$, $F$ still has $35$ components, the orbit dimension is unchanged. So the count for the branch and the count for the whole of $S$ are the **same count**, and the whole of $S$ is inhabited in dimension $12$. Therefore:

> **No parameter count over this parameter space can bear on the branch. A count concluding "expect emptiness" concludes it for $S$, and $S$ is inhabited.**

**That is R6, proved rather than asserted.** The refutation says the count says nothing about emptiness and offers the submersion failure as the reason. The reason above is stronger and is immune to every repair of the count, because it identifies the mismatch as *open condition against dimension count* rather than *dependent constraints against independent ones*.

**Argue the opposite, as the protocol requires.** The best case for the note is that the count was always meant for the sub-branch and that one should count on the sub-branch's own parameters, say by fixing $\omega_1$ of rank $6$ in normal form and counting what is left. I tried that reading, and it does not survive: fixing a normal form is fixing a slice through the orbit, which is §5's first attempt, and it is the calculation that misses by seven at the padded locus. Any count that would empty the branch also empties the padded locus, because the two differ by an open condition, and the padded locus is inhabited. **I found no version of the count that distinguishes them.**

## 6. R4 and R5, two internal defects of the refutation

**R4, the inference $\dim S\ge40-34=6$, runs the wrong way.** For smooth $F$ with $\mathop{\mathrm{rank}}dF_p=r$, some $r$ components have independent differentials at $p$, so near $p$ the set $S$ is **contained** in a submanifold of codimension $r$. That is $\dim_pS\le40-r$, an upper bound. The lower bound the refutation writes is false in general: $F(x)=\lVert x\rVert^2$ on $\mathbb R^{40}$ has rank $0$ at the origin and a single point for its zero set, and the equivariant version fails too, $F(x)=(\lVert x\rVert^2-1)^2$ on $\mathbb R^2$ with $SO(2)$ having rank $0$ at every solution and a $1$-dimensional zero set against the claimed $2$.

**The conclusion survives for a trivial reason and should be written that way.** $G\cdot p\subseteq S$ and $G\cdot p$ is a manifold, so $\dim_pS\ge\dim(G\cdot p)\ge11$. **No rank argument is involved, and the correct constant is $11$ rather than $6$.**

**R5, "circular", is a mislabel.** The note's argument has the form *compute $5$ under an independence assumption, then exhibit an orbit contradicting it*. That is a false premise, not a circle. **And by §2 the note's conclusion is false outright**, which is a cleaner thing to say than either.

## 7. R7 and R8, the two forward-looking sentences

**R7 is unsupported.** *"A solution set of exactly one orbit is the shape the count is now consistent with."* The one component of $S$ the record can compute is a $1$-parameter family of $11$-dimensional orbits, the parameter being the weight circle, which is $12$-dimensional in all. **So the shape the record actually exhibits is a family of orbits, and the successor's hypothesis should be a family, not a single orbit.** Consistency with a count is in any case not evidence for a shape.

**R8's second half is not honest against the record.** Emptiness of the branch is genuinely open, and the refutation is right that the count is no reason to expect it. But *"nothing pointing either way"* is a claim about the whole record and it is false there:

- [L185](../findings/diagonal-half.md): the all-decomposable case is empty at **every** width.
- [L186](../findings/diagonal-half.md): exactly one non-decomposable image form is empty.
- [L189](../findings/diagonal-half.md): exactly two non-decomposable is empty at **every** dimension.
- [L184](../findings/diagonal-half.md) and [L191](../findings/diagonal-half.md): the coincident case, and the rank-two branch, are empty at $\dim V=6$.
- [L181](../findings/diagonal-half.md): the block-structured analogue is empty at every $n$, every rank and every number of blocks.

**Every sub-case of $\dim V=6$ this programme has decided has come out empty, and the surviving rank-three case is a single one, the images distinct and collinear.** That is not proof and it is not nothing. **The honest sentence is that the count carries no weight, while the record's own $\dim V=6$ results all point one way**, and the box should say the first without claiming the second.

## 8. What I would write into the record

Keep the refutation's core and replace three sentences.

1. **Keep** R1 and R2, with *tangent to* replaced by *contained in*, and add the §2 exhibit as the primary refutation of the count: $S$ has a $12$-dimensional component at $\dim V=6$, the padded $\Lambda^+$ family, so "$5$" is false by $7$.
2. **Replace** the stabiliser paragraph with the centraliser argument: $\mathfrak g_p=\mathfrak z(\mathfrak a)$ for the $3$-plane $\mathfrak a$, of dimension at most $4$, so every orbit is at least $11$-dimensional, the rank is at most $29$, and at least $6$ of the $35$ constraints are dependent at every solution. **Drop the finite-stabiliser paragraph, which describes a case that cannot occur.**
3. **Replace** *"$\dim S\ge40-34=6$"* with *"$G\cdot p\subseteq S$, so $\dim S\ge11$ at any solution"*, which needs no rank bound.
4. **Strengthen** R6 to the open-condition statement of §5, which is what actually closes the matter.
5. **Rewrite** the last sentence: the count carries no weight on this branch, and the record's five emptiness results at $\dim V=6$ do point toward emptiness without proving it.

## 9. Falsifiers, and what I did to look for them

| Claim I record | What would falsify it | What I did |
|---|---|---|
| $\dim S\ge12$ at $\dim V=6$ (§2) | A failure of $\omega^2=-\tfrac12\Pi_P$ or $\omega\wedge\omega=\mathrm{vol}_P$ at some unit $\omega\in\Lambda^+P$, or the embedding $\Lambda^2P\hookrightarrow\Lambda^2\mathbb R^6$ failing to be isometric, or a hidden redundancy collapsing $8+3+1$ | Verified both identities in an adapted frame and again by $SO(4)$-equivariance into the trivial $\Lambda^4P$, checked the norm convention against [L180](../findings/diagonal-half.md)'s $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$, and checked the count against the orbit decomposition, $11+1=12$ with the orbit dimension computed independently in §4 |
| $\dim\mathfrak z(\mathfrak a)\le4$ for every $3$-plane (§4) | A reductive $\mathfrak h\subseteq\mathfrak{so}(6)$ with $\dim\mathfrak h\ge5$ and $\dim\mathfrak z(\mathfrak h)\ge3$ | Enumerated reductive subalgebras of dimension $5$ through $10$ through the $\mathfrak{su}(4)$ picture and computed each centraliser, the two nontrivial rows being $\mathfrak u(3)$ by weights and $\mathfrak{su}(2)_\alpha\oplus\ker\alpha$ by roots. Checked attainment at $\mathfrak a=\Lambda^+P$, where the bound is met |
| The equivariance step (§3) | Any of the four hypotheses failing here, or the conclusion needing $S$ to be smooth | Checked all four against this $X$, $F$ and action, and replaced the tangent-space route with the curve route, which needs none of it |
| R4 is backwards (§6) | A theorem making $\dim_pS\ge n-\mathop{\mathrm{rank}}dF_p$ true for smooth maps, equivariant or not | Exhibited two counterexamples, one of them $SO(2)$-equivariant with orbits of positive dimension, which is the case the refutation is in |
| No count can settle the branch (§5) | A parameter count that distinguishes $S\cap U$ from $S$, or a proof that $U$ is closed in $S$ | $U$ is a maximal-rank locus, hence open, and open conditions are invisible to dimension counts. I tried the slice count and it misses the known answer by seven at the padded locus |
| R8's second half is dishonest (§7) | A $\dim V=6$ result in the record pointing toward the branch being inhabited | Read the rank-three census and the rank-two line. Every decided sub-case at $\dim V=6$ is an emptiness, and the only inhabited family the record holds anywhere in this problem is at $\dim V=4$ |

**Computation.** *None was run. The standing analysis-only rule was in force, the screening allowance was available and unused, and every dimension above is a hand count.*
