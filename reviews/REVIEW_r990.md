# Review r990: the Osserman closure, and the reclassification of a `sorry`

Gate 2, independent adversarial review of the eleven claims in [BRIEF_I67_I107_unreviewed.md](BRIEF_I67_I107_unreviewed.md). Cold read: the findings files, fence posts, screens and Lean sources under review were not opened, and the verdicts below argue from the brief's definitions alone.

Log: [agent_logs/r990-osserman-adjugate.log](../agent_logs/r990-osserman-adjugate.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | kernel direction + Osserman forces $W=0$ | **CONFIRMED**, and it holds for every algebraic curvature tensor |
| 2 | a nonzero Osserman Weyl tensor has no kernel direction | **CONFIRMED**, and not vacuous |
| 3 | padded $W_{\mathbb{CP}^2}$ is not Osserman for $n>4$, is Osserman at $n=4$ | **CONFIRMED**, both halves |
| 4 | the Osserman-classification route has a false warrant | **PLAUSIBLE**, and the statement needs "for $n>4$" |
| 5 | $\varepsilon_J=\mathrm{Pf}(J)$, value $-1$ at $\varphi_{01}+\varphi_{23}+\varphi_{45}$ | **PLAUSIBLE**, the identification holds and the value $-1$ does not reproduce |
| 6 | both signs occur, one per $SO(6)$ orbit | **CONFIRMED** |
| 7 | $\langle\star(X\wedge X),Z\rangle=12\,\mathrm{triple}(Z,X,X)$ | **CONFIRMED**, once the inner product is fixed |
| 8 | the adjugate law holds at every skew $X$ | **CONFIRMED** as a statement, and the record's evidence for it is a screen |
| 9 | the `sorry`'s stated justification is false | **CONFIRMED**, and it survives claim 8 being only screened |
| 10 | the fifteen $\sigma(X)_{ij}$ are signed complementary Pfaffians | **CONFIRMED** |
| 11 | $\mathrm{Pf}(X)=\tfrac13\sum_{a<b}\sigma(X)_{ab}X_{ab}$ | **CONFIRMED** |

Nothing here is refuted outright. Two rows carry corrections that change what the item may assert: claim 5's sign, and the status of the evidence behind claim 8.

## Claim 1, line by line

Six steps, and the brief is right to ask which symmetry carries the last one.

1. **A kernel direction kills the Jacobi operator.** $J(x)_{ab}=\sum_{ij}W_{aibj}x^ix^j$, and $\sum_i W_{aibj}x^i=-\sum_i W_{iabj}x^i=0$ because $W(x,\cdot,\cdot,\cdot)=0$. This uses **antisymmetry in the first index pair** and nothing else.
2. **So the Osserman spectrum is $n-1$ zeros**, since $J(x)|_{x^\perp}=0$ for the normalised kernel direction. Whether Osserman is read with multiplicities or as a set makes no difference, because a set $\{0\}$ still forces every eigenvalue to be $0$.
3. **From "every eigenvalue is zero" to "the operator is zero" needs $J(y)$ symmetric.** $J(y)_{ba}=W_{biaj}y^iy^j=W_{ajbi}y^iy^j=J(y)_{ab}$, by the **pair symmetry** $W_{abcd}=W_{cdab}$. This step is load-bearing rather than decorative: an operator with zero spectrum and no symmetry is merely nilpotent, and there are plenty of nonzero ones.
4. **The brief's suspicion that "vanishing on $y^\perp$" is weaker than "$J(y)=0$" is correct in form and empty in substance**, because $J(y)y=0$ always: contract $W_{aibj}y^iy^j$ with $y^b$ and use **antisymmetry in the second index pair**. So $J(y)$ vanishes on $y^\perp$ and on $y$, hence everywhere, for every $y$ by homogeneity of degree two.
5. **Polarise.** $W_{aibj}y^iy^j=0$ for all $y$ gives $W_{aibj}+W_{ajbi}=0$, that is, $W$ is antisymmetric under exchange of slots two and four.
6. **Close.** First Bianchi in the form $W_{aibj}+W_{abji}+W_{ajib}=0$. Step 5 gives $W_{ajib}=-W_{abij}$, and antisymmetry of the last pair gives $W_{abji}=-W_{abij}$, so $W_{aibj}=2W_{abij}$. That relation says "exchanging slots two and three doubles", so applying it to $W_{abij}$ gives $W_{abij}=2W_{aibj}$, hence $W_{aibj}=4W_{aibj}$ and $W=0$.

**The symmetry that carries the last step is the first Bianchi identity**, used twice against the antisymmetry of the final index pair. **Tracelessness is never used anywhere in the chain.** So the correct statement is stronger than the claim: *any* algebraic curvature tensor with a kernel direction and constant Jacobi spectrum vanishes, and being Weyl is irrelevant. That strengthening is free and the item should take it, because it removes the need to check the trace conditions on any candidate.

Screened as a linear-algebra control rather than by sampling: for $n=3,4,5$ the system of Riemann symmetries plus first Bianchi has null space of dimension exactly $n^2(n^2-1)/12$, and adjoining the polarised condition of step 5 leaves the null space of dimension zero. The first half of that is the assertion that the setup is right, the second is claim 1.

## Claim 2, and whether it says anything

Immediate contrapositive of claim 1, so CONFIRMED.

**What vacuity would look like.** The claim is about the class of nonzero Osserman Weyl tensors. It would say nothing if that class were empty, and it would exclude everything if every Weyl tensor carried a kernel direction. Neither holds: $W_{\mathbb{CP}^2}$ at $n=4$ is nonzero, traceless and Osserman (section on claim 3), and it has no kernel direction. So the class is inhabited and the claim has content.

**What it does not give.** It is a one-way filter. Having no kernel direction is far from being Osserman, so claim 2 can exclude candidates and can never certify one.

## Claim 3, both halves

**The $n>4$ half, CONFIRMED and structural.** The padded tensor is supported on a fixed $4$-block, so every $x$ in the orthogonal complement satisfies $W(x,\cdot,\cdot,\cdot)=0$ and is a kernel direction, and the complement is nonzero exactly when $n>4$. The padded tensor is nonzero because $W_{\mathbb{CP}^2}$ is. Claim 2 then applies.

**This generalises, and the generalisation matters for claim 4.** The argument uses nothing about $\mathbb{CP}^2$. *Every* padded tensor has kernel directions, so no padded example of anything is ever Osserman in the larger dimension. The failure is a property of padding rather than of this instance.

**The $n=4$ control, CONFIRMED, and it needs the Einstein step.** For constant holomorphic sectional curvature $c$, the Jacobi operator of the full curvature tensor has spectrum $\{c,\,c/4,\,c/4\}$ on $x^\perp$ at every unit $x$, the eigenvalue $c$ on $Jx$ and $c/4$ on the complex-orthogonal $2$-plane. That is constant, so $R$ is Osserman. $\mathbb{CP}^2$ is Einstein, so $R$ differs from $W$ by a multiple of the constant-curvature tensor, whose Jacobi operator is a fixed multiple of the identity on $x^\perp$ for every unit $x$. **Subtracting a constant multiple of the identity shifts a spectrum without disturbing its constancy**, so $W$ is Osserman too. The shift is pinned by tracelessness of $W$, which forces $\mathrm{tr}\,J_W(x)|_{x^\perp}=\mathrm{Ric}_W(x,x)=0$, giving the Weyl Jacobi spectrum $\{c/2,\,-c/4,\,-c/4\}$, which indeed sums to zero.

So the honest answer to the brief's question is: **it follows from rank-one symmetric together with Einstein**, and the Einstein observation is a genuine step rather than a restatement. Rank-one symmetric alone gives the Osserman property of $R$, and the passage to $W$ is the shift argument above. Screened by constructing the $n=4$ tensor from the complex space form, asserting the Riemann symmetries, first Bianchi and vanishing traces of the Weyl part, and asserting that the spectrum on $x^\perp$ agrees across sixty unit $x$. Controls asserted alongside: constant curvature gives $W=0$ under the same code path, and a generic algebraic curvature tensor fails the same Osserman test, so the test discriminates.

## Claim 4, what it closes and what it leaves standing

**PLAUSIBLE.** The mathematical component is CONFIRMED and the verdict on the route is contingent on the route's warrant being what the brief says it is, which a cold reviewer cannot see.

**What claim 4 closes.** If the route's reason for applying the Osserman classification to non-diagonal maximisers was that the equality case is Osserman, that reason is gone for $n>4$, and by the generalisation under claim 3 it is gone for every padded equality case, so the route cannot be repaired by choosing a different padded instance.

**What it does not close.**

- **The target statement is untouched.** Being non-Osserman is no obstruction to being a maximiser, so padded $W_{\mathbb{CP}^2}$ attaining $\theta=\sqrt{3/2}$ survives its instance failing the Osserman test intact.
- **A route can have more than one warrant.** Falsifying the stated one closes the stated argument rather than the classification programme.
- **The $n=4$ case keeps its warrant**, because there the instance genuinely is Osserman. **Claim 4 as written is unqualified and should carry "for $n>4$"**, otherwise it reads as closing a route that is still open in the one dimension where the instance behaves.

## Claim 5, the identification holds and the sign does not reproduce

**First half, CONFIRMED, two lines.** From the adjugate law at $J$, $J\sigma(J)=-\mathrm{Pf}(J)\mathrm{Id}$. Multiply on the left by $J$ and use $J^2=-\mathrm{Id}$: $-\sigma(J)=-\mathrm{Pf}(J)J$, so $\sigma(J)=\mathrm{Pf}(J)J$ and $\star(J\wedge J)=2\,\mathrm{Pf}(J)\,J$, that is $\varepsilon_J=\mathrm{Pf}(J)$. The identity is convention-free: under $J\mapsto-J$ the left side is unchanged because $\sigma$ is quadratic, and the right side is unchanged because $\mathrm{Pf}$ is odd and $J$ flips.

**Second half, not reproducible as displayed.** Reading $\varphi_{01}+\varphi_{23}+\varphi_{45}$ with the brief's own conventions, that is $X_{01}=X_{23}=X_{45}=+1$ and $\varepsilon_{012345}=+1$, the brief's own Pfaffian formula gives $\mathrm{Pf}(J)=+1$ and hence $\star(J\wedge J)=+2J$, not $-2J$. Two independent evaluations agree: directly from $\tfrac1{48}\sum\varepsilon XXX$, where all $48$ surviving terms equal $+1$, and from claim 10, where $\sigma(J)_{01}=\mathrm{Pf}(J|_{\{2,3,4,5\}})=J_{23}J_{45}=+1=J_{01}$.

**The trap is real and worth recording.** $\mathrm{Pf}$ has degree three on $\mathbb{R}^6$, so $\mathrm{Pf}(X^{T})=\mathrm{Pf}(-X)=-\mathrm{Pf}(X)$: in dimension six, and unlike dimensions $4$ and $8$, transposing flips the Pfaffian. The claimed $-1$ is exactly what the opposite form-to-matrix convention delivers, $J_{ab}=\langle Je_a,e_b\rangle$ in place of $J_{ab}=\langle e_a,Je_b\rangle$. Both are current, and the brief displays neither. **The record must state which it uses, and under the brief's own index conventions the value is $+1$.** The implication inside the claim is sound either way, because the value and the conclusion flip together.

## Claim 6, both signs, one per orbit

**CONFIRMED.**

- **The dichotomy, re-derived.** $J$ skew with $J^2=-\mathrm{Id}$ gives $J^{T}J=-J^2=\mathrm{Id}$, so $J$ is orthogonal with eigenvalues $\pm i$ of multiplicity three each, hence $\det J=1$ and $\mathrm{Pf}(J)^2=\det J=1$.
- **Both signs occur.** $-J$ is a complex structure whenever $J$ is, and $\mathrm{Pf}(-J)=-\mathrm{Pf}(J)$ by oddness. So $\varepsilon_J$ is genuinely two-valued, and the witness is constructed rather than sampled.
- **One per orbit.** $\mathrm{Pf}(gXg^{T})=\det(g)\,\mathrm{Pf}(X)$, so $\mathrm{Pf}$ is an $SO(6)$ invariant and flips under every orientation-reversing $g$. The orthogonal complex structures form $O(6)/U(3)$ with $U(3)\subset SO(6)$, which has two components, each a single $SO(6)$ orbit $SO(6)/U(3)$, and $\mathrm{Pf}$ is precisely the label separating them.

**The brief's sampling warning lands exactly here.** A screen that conjugates by $Q$ from a QR factorisation never visits both orbits by accident: at $\det Q=+1$ it stays in one, and at $\det Q=-1$ it hops deterministically. The correct control is the deliberate pair $J$ and $-J$, or conjugation by an explicit reflection, which is what I used.

## Claim 7, derived independently, and the constant

Write $T=X\wedge X$, so $T_{cdef}=2(X_{cd}X_{ef}-X_{ce}X_{df}+X_{cf}X_{de})$. Contract each term against $\varepsilon_{abcdef}$ and relabel the dummies.

- **Second term.** Rename $d\leftrightarrow e$. Then $X_{ce}X_{df}$ becomes $X_{cd}X_{ef}$ and $\varepsilon_{abcdef}$ becomes $\varepsilon_{abcedf}=-\varepsilon_{abcdef}$, which cancels the explicit minus in $T$. Equal to the first term.
- **Third term.** Send $(c,d,e,f)\mapsto(c,e,f,d)$, a $3$-cycle on the last three slots and therefore even. Then $X_{cf}X_{de}$ becomes $X_{cd}X_{ef}$ at unchanged sign. Equal to the first term.

Hence $\star(X\wedge X)_{ab}=\tfrac{2\cdot3}{24}\sum\varepsilon_{abcdef}X_{cd}X_{ef}=\tfrac14\sum\varepsilon_{abcdef}X_{cd}X_{ef}$, and contracting with $Z_{ab}$ over **both** free indices gives $\tfrac{48}{4}\mathrm{triple}(Z,X,X)=12\,\mathrm{triple}(Z,X,X)$. **The constant $12$ is right and the brief's account of why is right.**

**The correction: the brief never defines $\langle\cdot,\cdot\rangle$, and the constant depends on it.** Under $\langle A,B\rangle=\sum_{a,b}A_{ab}B_{ab}$ it is $12$. Under the $2$-form convention $\langle A,B\rangle=\sum_{a<b}A_{ab}B_{ab}$ it is $6$. Claim 11 pins the intended reading, so the record is internally consistent, and the convention belongs in the statement rather than in the reader's head. Both conventions checked in exact rational arithmetic at random integer skew $X$ and $Z$.

## Claim 11

From claim 7 at $Z=X$, with $\sigma=\tfrac12\star(X\wedge X)$, the full double sum gives $4\sum_{a<b}\sigma(X)_{ab}X_{ab}=12\,\mathrm{triple}(X,X,X)=12\,\mathrm{Pf}(X)$, so $\mathrm{Pf}(X)=\tfrac13\sum_{a<b}\sigma(X)_{ab}X_{ab}$. **CONFIRMED, and it is the cross-check that fixes claim 7's convention.**

## Claim 10, the statement rather than the proof

Fix $a<b$ and let $S=\{0,\dots,5\}\setminus\{a,b\}=\{s_1<s_2<s_3<s_4\}$. Only permutations of $S$ survive in $\sigma(X)_{ab}=\tfrac18\sum\varepsilon_{abcdef}X_{cd}X_{ef}$, and $\varepsilon_{abcdef}=s\cdot\mathrm{sgn}(cdef\mid s_1s_2s_3s_4)$ with $s=\mathrm{sgn}(a,b,s_1,s_2,s_3,s_4)$. The $4!$ permutations collect into the three perfect matchings of $S$, each arising eight times at equal sign, and $\sum_{\sigma\in S_4}\mathrm{sgn}(\sigma)M_{\sigma_1\sigma_2}M_{\sigma_3\sigma_4}=8\,\mathrm{Pf}(M)$, which cancels the $\tfrac18$ exactly.

So $\sigma(X)_{ab}=s\cdot\mathrm{Pf}(X|_S)$ with no residual factor. **The closed form is the right one and the sign is the permutation's**, namely the sign of $(a,b)$ followed by the complement in increasing order. Checked against the $\varepsilon$ definition on all thirty-six entries at random integer $X$ in exact arithmetic.

## Claim 8, true, and only screened

**The law is true, and here are two proofs, neither using a normal form.**

1. **The classical route.** By claim 10, $\sigma(X)_{ab}$ is the signed Pfaffian of the complement of $\{a,b\}$, so $X\sigma(X)=-\mathrm{Pf}(X)\mathrm{Id}$ *is* the Pfaffian Laplace expansion in matrix form: the diagonal entries are the expansion of $\mathrm{Pf}(X)$ along a row, and the off-diagonal entries are the companion orthogonality relations, which vanish. Equivalently $\mathrm{adj}(X)=-\mathrm{Pf}(X)\sigma(X)$ for skew $X$ of even size, which together with $X\,\mathrm{adj}(X)=\det(X)\mathrm{Id}=\mathrm{Pf}(X)^2\mathrm{Id}$ is the same statement.
2. **The route that settles it by finitely many points, correctly.** Every entry of $D(X)=X\sigma(X)+\mathrm{Pf}(X)\mathrm{Id}$ is **multilinear**, of degree at most one in each of the fifteen free entries. The reason is sharp: $\sigma(X)_{kj}$ is a Pfaffian on the complement of $\{k,j\}$, so it contains no entry carrying the index $k$, and the factor $X_{ik}$ in $\sum_k X_{ik}\sigma(X)_{kj}$ therefore cannot recur inside $\sigma$. A polynomial of degree at most one in each variable that vanishes on $\{0,1\}^{15}$ vanishes identically. Evaluating $D$ at all $32768$ vertices in exact integer arithmetic gives zero at every one, so **the law is proved**, by a bounded check that runs in under a second.

**The record's evidence is a screen, and the brief's doubt is exactly right.**

- Both sides are homogeneous cubics in fifteen variables, and that space has dimension $\binom{17}{3}=680$. Evaluation at $300$ points imposes at most $300$ linear conditions on it, so even in general position the samples leave a space of dimension at least $380$ of cubics consistent with the data. **The dimension count alone defeats the inference, before any question of genericity arises.**
- Floating-point sampling weakens it further, because a residual under a tolerance is not a zero.
- What would close it, in increasing order of strength: a Schwartz-Zippel bound over a named finite set with exact arithmetic, which buys a probability rather than a proof; the multilinear argument plus the $2^{15}$ exact evaluations above, which is a decision procedure; or the Laplace expansion, which is a proof a reader can check without a machine.

Two controls asserted alongside the sweep, both passing: the same sweep separates the true law from the perturbation $\mathrm{Pf}\mapsto\mathrm{Pf}+1$, so it is not vacuously satisfied, and a non-skew $X$ breaks the law, so skewness is load-bearing rather than ornamental.

**Verdict CONFIRMED for the mathematics, with the correction that the item should stop citing the samples as the warrant** when a complete finite check costs a second and an expansion proof costs a paragraph.

## Claim 9, and whether it survives claim 8 being only screened

**CONFIRMED, and yes it survives.** Both halves need care, because the brief is right that "the statement is polynomial, so the normal form is unnecessary" is an argument about the statement rather than about the evidence.

**Why it survives.** Claim 9 asserts that a proof exists which uses neither the skew normal form nor $SO(6)$-equivariance. What it needs from claim 8 is that the law is a polynomial identity in the fifteen entries, and that follows from the definitions and from claim 10, which is the one machine-checked row in the table. It does not need the $300$ samples at all. The samples are evidence about the law's *truth*, while claim 9 is a statement about its *provability*, and the two are independent.

**The residual dependence, named.** Claim 9 does need claim 8 to be **true**, because if the law failed there would be no proof to find by any route and the reclassification would be moot. That dependence is discharged above, where the law is proved outright, so claim 9 no longer rests on a screen at any point.

**The sharpening the wording needs.** The quoted justification is not false as a description of *one* strategy: a frame-adapted verification really does need the normal form and equivariance to be transported to every $\omega$, and that part is accurate. What is false is the necessity it implies, the step from "this strategy needs them" to "the `sorry` cannot be discharged in this layer". **So the correction is to state claim 9 as "the stated prerequisites are those of the chosen strategy and not of the theorem"**, which is both true and less likely to be read as an accusation of error against the quoted text.

**One practical caveat the item should carry.** Replacing a mathematical gap by a $32768$-case decision procedure moves the difficulty from mathematics into elaboration cost inside the proof assistant, and that cost is real even though it is not a gap. The Laplace-expansion route is the better target for formalisation: it is a handful of terms per entry rather than tens of thousands of cases, and it consumes the fifteen already-proved $\sigma$ entries of claim 10 directly as its inputs.

## What is machine-checked, and what is not

Worth the remark the brief invites at row 1. **Of the eleven rows, exactly one is typed**: claim 10, the fifteen $\sigma$ entries. The layer carries no Jacobi operator, so claims 1 to 4 cannot even be *stated* in it, and claims 7 and 8, which everything in part B is built on, are untyped. The distribution is the wrong way round: the machine-checked row is the one that is most mechanical by hand, and the rows carrying the argument rest on prose. That is the largest structural risk in the item, and it is separate from every verdict above, all of which are about the mathematics rather than its formalisation.

## Vacuity checks

The brief asks what each claim would look like if it were empty. Working through them:

- **Claim 2** would be vacuous if no nonzero Osserman Weyl tensor existed, or if every Weyl tensor carried a kernel direction. The $n=4$ instance refutes both.
- **Claim 3** would be vacuous if the padded tensor were zero, since a zero tensor trivially has kernel directions and is trivially Osserman. Asserted nonzero.
- **Claim 6** would be vacuous if only one sign of $\mathrm{Pf}$ were realised on complex structures. The deliberate pair $J$ and $-J$ refutes it, and a QR-sampled control would not have.
- **Claims 7 and 11** would be vacuous if $\mathrm{triple}(Z,X,X)$ vanished identically. At $Z=X$ it is $\mathrm{Pf}(X)$, which is $\pm1$ at any complex structure.
- **Claim 8** would be vacuous if the law held for trivial reasons, for instance if $\sigma$ were identically zero or if the identity held off the skew locus too. Both controls assert otherwise.

## Method

All screens are exact: integer or rational arithmetic on objects constructed for the purpose, each run in under a second, and each control stated as an assertion that fails the run rather than as a printed expectation. The part A linear-algebra check uses a rank computation at a fixed tolerance, which is the one place a floating-point judgement enters, and its control is that the unconstrained null space returns the known dimensions $6$, $20$ and $50$ exactly.
