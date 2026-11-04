# r818: Gate 2 on L192, the weighted Laplacian reading of the two Weyl conditions

*Cold brief: I was given the block and the four givens, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L179 through L192), [findings/conventions.md](../findings/conventions.md), [lean/INDEX.md](../lean/INDEX.md), [L192Statement.lean](../lean/HamiltonsCubic/Results/L192Statement.lean), [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean) and [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand and every constant is exact. Two machine actions were screens on objects I constructed for the purpose, a Lean build and an axiom print, reported as screens in §7 and never as evidence for a positive claim. **Mid-round correction taken**: the Pfaffian on $\Lambda^2\mathbb R^6$ IS now built, in [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean), and §7 attacks it in place of the brief's "check it is absent" item. Log: [agent_logs/g2-l192-r818.log](../agent_logs/g2-l192-r818.log).*

| Claim | Verdict |
|---|---|
| **(1)** Ricci-flatness IS $L[w(x)^2]=0$ | **CONFIRMED as an equivalence**, in both directions and trivially, because $L[w^2]$ is the *constant* matrix $2\sum_i\lambda_i\omega_i^2$. The word IS is earned. **The gloss "an identity between matrix-valued quadratic forms on $\mathbb R^3$" is wrong about its own object**: $w(x)^2$ is the matrix-valued quadratic form, $L[w^2]=0$ is an identity between constant matrices |
| **(2)** at $\dim V=6$, first Bianchi IMPLIES $L[\mathrm{Pf}(w(x))]=0$ | **CONFIRMED.** Every constant checks: $C(\omega,\omega,\omega)=6\mathrm{Pf}(\omega)$ in the record's own Pfaffian convention, $\partial_i^2C(w,w,w)=6C(\omega_i,\omega_i,w)$, and the two sixes cancel, so the coordinate form $\sum_i\lambda_ic_{iik}=0$ carries no stray factor |
| **The stated gap**, Bianchi being 15 conditions where harmonicity tests the 3-dimensional span | **CONFIRMED, and it is exactly the gap.** Bianchi $\iff\star B=0$, harmonicity $\iff\star B\perp\mathop{\mathrm{span}}\{\omega_i\}$, with $B=\sum_i\lambda_i\omega_i\wedge\omega_i$. Ranging $\eta=w(x)$ over all $x$ recovers the span and nothing more, by linearity of $B\wedge(\cdot)$ |
| **Strictness**, the words "an implication and not an equivalence" | **CONFIRMED for orthonormal triples**, by the closed-form witness in §4: $\omega_1=e_{12}$, $\omega_2=e_{34}$, $\omega_3=\tfrac1{\sqrt2}(e_{13}+e_{56})$, $\lambda=(1,1,-2)$, spanning six dimensions, harmonic with $B\ne0$. **PLAUSIBLE and unestablished on the Ricci-flat class**, where the block's justification is a dimension count and no witness is exhibited or available |
| **$c_{111}=6\mathrm{Pf}(\omega_1)\ne0$** | **REFUTED as written.** In the $(+,+,-)$ pattern the block itself lists, the minority form is $\omega_3$, and L180(3) then bounds $\mathrm{Pf}(\omega_3)$ away from zero while $\mathrm{Pf}(\omega_1)$ may vanish, a rank-four non-decomposable $\omega_1$ being permitted by [L189](../findings/diagonal-half.md). **Repairable by relabelling** the minority form to index 1, which the block never does and which its two displayed sign patterns contradict |
| **The $\dim V=4$ box**, and "the operator that annihilates it is $L$ only when $m=3$" | **REFUTED.** At $\dim V=2m$ the identity is $L[\mathrm{Pf}(w)]=\tfrac1{(m-2)!}\star\!\big(B\wedge w^{\wedge(m-2)}\big)$, so Bianchi implies harmonicity at **every** $m\ge2$. At $m=2$ the test element is $1$ and harmonicity is **equivalent** to Bianchi outright, so the $\dim V=4$ instance is the strongest case rather than the empty one |
| **"the question is now about a cubic form in three variables rather than about a tensor in fifteen"** | **OVERSTATED**, and at odds with the block's own strictness paragraph. A necessary consequence does not replace the question. The record already holds the *equivalent* dim-six form, $\sum_i\lambda_i\mathrm{Padj}(\omega_i)=0$, and L192's condition is exactly its orthogonal projection onto the span |
| **Carry-over from a neighbouring configuration** | **ONE FOUND**, and it is the $\dim V=4$ box: the $m=3$ mechanism is read as degenerating at $m=2$ when it in fact sharpens. A second, milder one is the closing box's unqualified "signature-$(+,-,-)$", which is one of the statement's two patterns |
| **Lean, `cube_second_diff`** | **Faithful.** It is the identity the proof uses, not a weakening: for a cubic the second difference **equals** the second derivative |
| **Lean, `pf6` at $1/48$** | **CONFIRMED.** $2^mm!=48$ at $m=3$, `levi6` is the standard symbol with $\epsilon_{012345}=+1$, and `pf6` returns $c_1c_2c_3$ on a normal-form triple, which is the record's own convention. **`triple6` is $C/6$, not $C$**, and the two agree exactly on the second difference |
| **Lean, the symmetrised Bianchi hypothesis** | **CONFIRMED as neither stronger nor weaker than [L179](../findings/diagonal-half.md)(b).** `triple6` is symmetric in fact, so the three summed orders are $3\,\mathrm{triple6}(\omega_i,\omega_i,\eta)$, and quantifying $\eta$ over *all* matrices costs nothing because a symmetric $\eta$ contracts `levi6` to zero. **Nothing is smuggled in** |
| **Lean, `bianchi_implies_harmonic`'s conclusion** | **TRUE and correctly typed, but it is the tautological half.** Quantified over every $w$, the conclusion is *equivalent* to the hypothesis, so the theorem is the identity plus linearity. **The lossy content of L192(2), that the test is confined to the span, is still not typed**, and typing it needs the span restriction the theorem drops |
| **Symmetry used quietly?** | **NO.** Every theorem in [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean) proves from trilinearity alone, `pf6_second_diff` keeps the three orders apart, and `bianchi_implies_harmonic` consumes them in that same unsymmetrised shape |

**One line.** *Both numbered statements survive intact, with every constant verified and (1) an honest equivalence, and the two defects are in the boxes rather than in the Statement: $c_{111}\ne0$ is asserted at an index the block's own $(+,+,-)$ pattern does not support, and the $\dim V=4$ box gives a false reason for a true observation, missing that the same mechanism at $m=2$ is an exact equivalence with first Bianchi. Both are repairable in a sentence each, and the general-$m$ identity in §5 is worth folding, since it hands the open $\dim V=8$ branch the same reformulation with $w\wedge w$ as the test element. The new Pfaffian layer is sound at every point the correction asked about. $1/48$ is right, `levi6` is the standard symbol, the symmetrisation smuggles nothing, and symmetry is nowhere used quietly, with one thing the row must say: quantified over all $w$, `bianchi_implies_harmonic`'s conclusion is equivalent to its hypothesis, so the strict half of L192(2) is still owed.*

## 0. Conventions, fixed once

- A $2$-form is a skew matrix, $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$, the convention [L180](../findings/diagonal-half.md) fixes by $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$.
- $\mathrm{Pf}$ is normalised by $\omega^{\wedge m}=m!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$ on $\mathbb R^{2m}$, equivalently $\mathrm{Pf}(\sum_jc_j\varepsilon_j)=\prod_jc_j$. **This is the record's own convention and I checked it against two independent uses**: $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$ on $\Lambda^2\mathbb R^6$ with $\sigma(\omega)=\tfrac12\star(\omega\wedge\omega)$, which returns $c_1c_2c_3$; and [L189](../findings/diagonal-half.md)'s $\det(NN^{\mathsf T})=\mathrm{Pf}(N)^4$ at $\dim V=8$, which is $\det N=\mathrm{Pf}(N)^2$. [conventions.md](../findings/conventions.md) fixes no Pfaffian, so these two are the record's definition in practice and they agree.
- $B:=\sum_i\lambda_i\,\omega_i\wedge\omega_i\in\Lambda^4V$, the left side of first Bianchi in [L179](../findings/diagonal-half.md)(b). At $\dim V=6$, $\star B=2\sum_i\lambda_i\mathrm{Padj}(\omega_i)$, the object the record's line at $\dim V=6$ already names.
- $\mathrm{vol}=e^{123456}$ on $V$, all $\omega_i\in\Lambda^2V$ by [L180](../findings/diagonal-half.md)(3), and $\mathrm{Pf}$ throughout means $\mathrm{Pf}_V$.

## 1. Claim (1) is an equivalence, and the block misdescribes it

**Located.** The Statement's item 1 and the first line of the Proof.

$w(x)^2=\sum_{i,j}x_ix_j\,\omega_i\omega_j$ is a matrix-valued quadratic form. $\partial_i^2$ kills every cross term and returns $2\omega_i^2$ from $x_i^2\omega_i^2$, so

$$L\big[w(x)^2\big]=2\sum_i\lambda_i\omega_i^2,$$

**a constant matrix, independent of $x$.** Hence $L[w^2]=0\iff\sum_i\lambda_i\omega_i^2=0$, which is [L180](../findings/diagonal-half.md)(1)'s Ricci-flatness, in both directions and with no hypothesis spent. The quantifier worry in the brief dissolves the moment one notices the $x$-independence: there is no quantifier over $x$ to lose.

**The one defect is descriptive.** "an identity between matrix-valued quadratic forms on $\mathbb R^3$" names the wrong pair of objects. The quadratic form is $w(x)^2$, the input. The identity $L[w^2]=0$ is between constant matrices, which is precisely why the equivalence is exact and why item 1 costs nothing. **The correct gloss is stronger than the one written**, so the fix improves the block.

## 2. Claim (2): every constant, recomputed

**Located.** The Proof's item 2.

- $C$ is well defined and totally symmetric on $\Lambda^2V$, since $2$-forms commute under $\wedge$ (even degree) and $\Lambda^6V$ is one-dimensional. **Correct.**
- $C(\omega,\omega,\omega)=6\,\mathrm{Pf}(\omega)$: it is $\omega^{\wedge3}=3!\,\mathrm{Pf}(\omega)\mathrm{vol}$, §0's convention. Checked on $\omega=\varepsilon_1+\varepsilon_2+\varepsilon_3$: $\omega^{\wedge3}=6\,e^{123456}$ against $\mathrm{Pf}=1$. **Correct.**
- $\mathrm{Pf}(w(x))=\tfrac16C(w,w,w)$, a cubic form in $x$. **Correct.**
- $\partial_i^2C(w,w,w)=6\,C(\omega_i,\omega_i,w)$: $\partial_i C(w,w,w)=3C(\omega_i,w,w)$ by symmetry, then $\partial_i$ again gives $6C(\omega_i,\omega_i,w)$. **Correct.**
- The two sixes cancel: $L[\mathrm{Pf}(w)]=\tfrac16\sum_i\lambda_i\cdot6\,C(\omega_i,\omega_i,w)=\sum_i\lambda_i\,C(\omega_i,\omega_i,w)$, exactly as displayed. **No stray factor reaches the coordinate box.**
- $\sum_i\lambda_iC(\omega_i,\omega_i,w(x))=\sum_kx_k\sum_i\lambda_ic_{iik}$, a **linear** form in $x$, so harmonicity is exactly the three equations $\sum_i\lambda_ic_{iik}=0$. **The coordinate box is right**, including the count of $\binom{3+3-1}{3}=10$ independent entries of a symmetric $3\times3\times3$ array.
- The implication itself: $\sum_i\lambda_iC(\omega_i,\omega_i,w)\,\mathrm{vol}=B\wedge w$, and Bianchi is $B=0$. **Correct.**

**Argued the opposite.** For (2) to fail one would need $B=0$ with $B\wedge w\ne0$, which is impossible, or a factor slip making the displayed $L[\mathrm{Pf}(w)]$ disagree with $\sum_i\lambda_ic_{iik}x_k$. Neither survives the recomputation above.

**One scoping omission.** With $n>6$ the symbol $\mathrm{Pf}(w(x))$ read in $\mathbb R^n$ is identically zero and (2) is vacuous. The block means $\mathrm{Pf}_V$, which is legitimate because [L180](../findings/diagonal-half.md)(3) puts all three forms in $\Lambda^2V$, but it never says so. **One clause fixes it.**

## 3. The gap is exactly what the block says it is

$\Lambda^4V\times\Lambda^2V\to\Lambda^6V$ is a perfect pairing, both sides fifteen-dimensional, so Bianchi $\iff B\wedge\eta=0$ for every $\eta\in\Lambda^2V$ $\iff\star B=0$. Harmonicity is that same test against $\eta=w(x)$, and since $x\mapsto w(x)$ is a linear isomorphism onto the span and $\eta\mapsto B\wedge\eta$ is linear, **ranging over all $x$ recovers the span and not one dimension more**. So harmonicity $\iff\star B\perp\mathop{\mathrm{span}}\{\omega_1,\omega_2,\omega_3\}$: three of fifteen conditions, the lost twelve being the span's orthogonal complement. **The block's account of the loss is exact.**

**Could Ricci-flatness close the twelve?** It would have to force $\star B$ into the span. Nothing in [L180](../findings/diagonal-half.md) does: Ricci-flatness is an identity in $S^2(\mathbb R^n)$ and $\star B$ ranges over $\Lambda^2V$ with no stated coupling. The block claims no such closure, and I found no route to one.

## 4. Strictness, exhibited in closed form, and where it stops

The block asserts "an implication and not an equivalence" on a dimension count alone, which is a heuristic. **For orthonormal triples it is genuinely strict, and here is the witness**, on $V=\mathbb R^6$:

$$\omega_1=e^{12},\qquad\omega_2=e^{34},\qquad\omega_3=\tfrac1{\sqrt2}\big(e^{13}+e^{56}\big),\qquad\lambda=(1,1,-2).$$

- **Orthonormal**: distinct basis $2$-vectors throughout, $\lVert\omega_3\rVert^2=\tfrac12+\tfrac12=1$.
- **Weights sum to zero, none vanishes**, and the supports span all six dimensions ($\{1,2\}\cup\{3,4\}\cup\{1,3,5,6\}$).
- **Bianchi fails**: $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=0$ and $\omega_3\wedge\omega_3=e^{1356}$, so $B=-2\,e^{1356}\ne0$.
- **Harmonicity holds**: $B\wedge\omega_1$ repeats $e^1$, $B\wedge\omega_2$ repeats $e^3$, and $B\wedge\omega_3$ repeats either $e^1e^3$ or $e^5e^6$. All three vanish, so every $\sum_i\lambda_ic_{iik}=0$.

Equivalently $\star B\propto e^{24}$, orthogonal to all three forms, which is the mechanism §3 predicts.

**What this does not do, and the block should not be read as having it.** The witness is **not Ricci-flat**: the $e_6e_6$ entry of $\sum_i\lambda_iA_i$ is $-1$. Strictness on the Ricci-flat class is a different question, and it is **open**, for the reason that makes the whole item interesting: nobody knows the class at $\dim V=6$ is inhabited, so within it "implication, not equivalence" is currently unfalsifiable. **I tried to promote the witness and failed in the one direction that was cheap**: the Ricci-flat scalar family $\omega_i=\tfrac1{\sqrt3}J_i$, forced by $2A_1=A_2+A_3$ at $\lambda=(2,-1,-1)$ with $A_1=\tfrac13\mathrm{Id}$, has $\star B=\tfrac2{\sqrt3}(2\epsilon_1\omega_1-\epsilon_2\omega_2-\epsilon_3\omega_3)$ lying **inside** the span, so there harmonicity forces Bianchi outright. That is one family, not a theorem, and I opened no search for others. **Verdict: strictness CONFIRMED as a statement about the tests, PLAUSIBLE and unproven on the constrained class.**

## 5. The $\dim V=4$ box is refuted, and the general-$m$ identity replaces it

**Located.** The box "WHY THIS IS A $\dim V=6$ STATEMENT AND NOT A GENERAL ONE".

At $\dim V=2m$, with $\mathrm{Pf}(w)=\tfrac1{m!}\star(w^{\wedge m})$ and $\partial_i(w^{\wedge m})=m\,\omega_i\wedge w^{\wedge(m-1)}$:

$$\partial_i^2\big(w^{\wedge m}\big)=m(m-1)\,\omega_i\wedge\omega_i\wedge w^{\wedge(m-2)},\qquad\boxed{\;L\big[\mathrm{Pf}(w)\big]=\tfrac1{(m-2)!}\,\star\!\big(B\wedge w^{\wedge(m-2)}\big)\;}$$

for every $m\ge2$. **So first Bianchi implies harmonicity at every even dimension, not only at six.** What is special at $m=3$ is only that the test element $w^{\wedge(m-2)}$ is $w$ itself, so the test set is the span.

Three consequences, each contradicting a clause of the box:

- **"the operator that annihilates it is $L$ only when $m=3$" is false** on either reading. $L$ annihilates $\mathrm{Pf}(w)$ under Bianchi at all $m$, and the $m$ at which harmonicity is *equivalent* to Bianchi is $m=2$, not $m=3$.
- **At $\dim V=4$ the reformulation is at its strongest, not its weakest.** There $m-2=0$, the test element is $1$, and $L[\mathrm{Pf}(w)]=\star B=2\sum_i\lambda_i\mathrm{Pf}(\omega_i)$, whose vanishing is the whole of first Bianchi, $\Lambda^4\mathbb R^4$ being one-dimensional. The box's "$L$ applied to it returns a constant" is true. The inference "which is why the reformulation says nothing" reverses the truth. It says nothing **new** because [L178](../findings/diagonal-half.md) has closed $\dim V=4$ already, which is a fact about the record and not about the operator.
- **At $\dim V=8$, the record's other open dimension, the reformulation survives** with $B$ tested against $\{w\wedge w\}$, at most the six-dimensional image of $S^2$ of the span inside $\Lambda^4$. That is a strictly better instrument than the block's account admits it can have, and it costs one line to record.

**Argued the opposite.** Is $w^{\wedge(m-2)}$ ever ill-defined or the differentiation invalid? No: $w(x)$ is linear in $x$ with values in $\Lambda^2V$, wedge is bilinear, and $2$-forms commute, so the product rule collapses as displayed. Checked the boxed formula at $m=3$ against the block's own display: $\star(B\wedge w)$, agreeing.

## 6. $c_{111}\ne0$ is asserted at the wrong index in one of the two sign patterns

**Located.** The box "IN COORDINATES IT IS THREE LINEAR EQUATIONS ON ONE SYMMETRIC ARRAY", last sentence, and the closing box's "signature-$(+,-,-)$ Laplacian with $c_{111}\ne0$".

The Statement fixes the two patterns as $(+,-,-)$ **or** $(+,+,-)$, both with $\lambda_1>0$.

- In $(+,-,-)$ the minority sign is $+$, carried by $\omega_1$, so [L180](../findings/diagonal-half.md)(3) gives $V=\mathop{\mathrm{supp}}\omega_1$, and at $\dim V=6$ that is rank six, so $\det\omega_1\ne0$ and $c_{111}=6\mathrm{Pf}(\omega_1)\ne0$. **True.**
- In $(+,+,-)$ the minority sign is $-$, carried by $\omega_3$. L180(3) then gives $V=\mathop{\mathrm{supp}}\omega_3$ and $c_{333}\ne0$, and says **nothing** about $\omega_1$, whose support may be a four-dimensional subspace of $V$, which is permitted, since [L189](../findings/diagonal-half.md) forces non-decomposability, which floors the rank at four and does not raise it to six. Then $\mathrm{Pf}(\omega_1)=0$ and $c_{111}=0$. **The box's claim is false there.**

**The defect is real but shallow.** L180(3) itself says "up to relabelling", so fixing the minority form at index 1 repairs everything: the pattern becomes $(+,-,-)$ or $(-,+,+)$, the second being the first up to overall sign, and $L$ and $-L$ have the same kernel, so harmonicity is unaffected and $L$ is Lorentzian in both. **The block instead lists two patterns that both put $+$ first, and then uses an index only the first supports.** The closing box compounds it by dropping the second pattern silently.

**Suggested repair, one sentence**: *index the triple so that $\omega_1$ carries the minority sign, which L180(3) permits, and then $L$ is Lorentzian up to overall sign and $c_{111}=6\mathrm{Pf}(\omega_1)\ne0$.*

Two smaller notes on the same boxes. Calling $L[\cdot]=0$ **harmonicity** for an operator the block itself calls Lorentzian is a wave equation, not a Laplace equation, and the mean-value and maximum-principle intuitions a reader brings to the word do not apply. And the closing box's "the question is now about a cubic form in three variables rather than about a tensor in fifteen" is an overclaim of the kind the block's own strictness paragraph forbids: **the equivalent dim-six form is already on the record**, $\sum_i\lambda_i\mathrm{Padj}(\omega_i)=0$, and since $\star B=2\sum_i\lambda_i\mathrm{Padj}(\omega_i)$, L192's condition is exactly that equation projected onto the span. The reformulation is a projection of a recorded equation, and it is worth saying which one.

## 7. Lean, including the Pfaffian the layer has since acquired

**Screens** (seconds of compute on objects constructed for the purpose, reported as screens and not as evidence for any positive claim): `lake build HamiltonsCubic.Results.L192Statement` completes, 8715 jobs, **no errors and no `sorry`**, the only warnings being style linters in [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean) and an unscoped `maxHeartbeats` plus an unused `simp` argument in [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean). `#print axioms` on `pf6_second_diff`, `bianchi_implies_harmonic` and `cube_second_diff` returns `[propext, Classical.choice, Quot.sound]` for all three, so **kernel-clean on the three standard axioms**, as the correction states.

### 7.1 `cube_second_diff` and `SymTri`

- **It states the identity the proof uses, not a weakening.** For a one-variable cubic $g$, the symmetric second difference $g(1)-2g(0)+g(-1)$ **equals** $g''(0)$ exactly, the $t^3$ terms cancelling with the $t^1$ terms. So the typed $6\,C(\omega,\omega,w)$ is the value of $\partial_i^2C(w,w,w)$, not an approximation to it.
- **It is stated for arbitrary $w,\omega$**, where the block needs only $w=w(x)$ and $\omega=\omega_i$, so it is **more general** than the use. The docstring's $w\,x=x_0\bullet\omega_0+\dots$ is narrative only.
- **The `SymTri` hypotheses suffice**: additivity and homogeneity in slot one plus the two transpositions generate the rest, which `cube_expand` closes by `ring`.

### 7.2 Is $1/48$ the Pfaffian's normalisation, and does `pf6` match the record?

**Both yes, and I checked the symbol rather than trusting the docstring.**

- `sgnR x y` is $+1$, $-1$, $0$ by trichotomy, and `levi6` is the product of `sgnR` over all fifteen ordered pairs of the six indices. That is $0$ on a repeat and the sign of the permutation otherwise, with $\epsilon_{012345}=+1$ since every pair is ascending. **It is the standard symbol.**
- $\mathrm{Pf}=(2^mm!)^{-1}\sum\mathrm{sgn}\prod$ reads $2^3\cdot3!=48$ at $m=3$. **Correct.**
- **Evaluated by hand on a normal-form triple**, $X_{01}=c_1$, $X_{23}=c_2$, $X_{45}=c_3$ and skew: exactly $48$ terms survive, being $3!$ assignments of pairs to slots times $2^3$ intra-pair orders, and **every one of them equals $c_1c_2c_3$**: flipping a pair flips both `levi6` and one entry, and permuting three disjoint pairs is an even permutation of six indices. So $\mathrm{pf6}(X)=c_1c_2c_3$, which is §0's convention and hence the record's. *I did not machine-check a concrete value. The argument above is by hand and the definition is transparent enough to make that safe.*
- **The relation to the block's $C$ is $\mathrm{triple6}=C/6$, and it is worth writing down.** For $2$-forms, $\alpha\wedge\beta\wedge\gamma=\tfrac18\sum\epsilon_{abcdef}\alpha_{ab}\beta_{cd}\gamma_{ef}\,\mathrm{vol}$, so $C=\tfrac{48}{8}\,\mathrm{triple6}=6\,\mathrm{triple6}$, consistently with $C(\omega,\omega,\omega)=6\mathrm{Pf}$ and $\mathrm{triple6}(X,X,X)=\mathrm{Pf}$. The file's docstring hedges this as *"up to the normalisation fixed here"*. **The coordinate box's $c_{ijk}$ is six times the Lean object**, and since harmonicity is homogeneous the two state the same three equations. Recording $c_{iik}=6\,\mathrm{triple6}(\omega_i,\omega_i,\omega_k)$ would remove the one place a factor could later be mismatched.

### 7.3 The symmetrised Bianchi hypothesis smuggles nothing in

The hypothesis is $\forall\eta:\ \sum_i\lambda_i\big(T(\omega_i,\omega_i,\eta)+T(\omega_i,\eta,\omega_i)+T(\eta,\omega_i,\omega_i)\big)=0$ with $T=\mathrm{triple6}$. **This was flagged as the item most likely to be wrong, and it is right.**

- **`triple6` is symmetric in fact**, the file's header justification being correct: exchanging slots one and two applies the permutation $(a\,c)(b\,d)$ to `levi6`'s six indices, a product of two transpositions and so even. Hence each hypothesis instance is $3\sum_i\lambda_iT(\omega_i,\omega_i,\eta)$, and by §7.2 that is $\tfrac12(\sum_i\lambda_i\omega_i\wedge\omega_i)\wedge\eta/\mathrm{vol}$. **[L179](../findings/diagonal-half.md)(b) implies it at every $\eta$**, so the hypothesis is not stronger than Bianchi. It is not weaker either: run the same line backwards.
- **Quantifying $\eta$ over all matrices rather than skew ones costs nothing**, which is the second place a strengthening could have hidden. `levi6` is antisymmetric in each of the three pairs $(a,b)$, $(c,d)$, $(e,f)$, so a symmetric $\eta$ contracts to zero in whichever slot it occupies and only $\eta$'s skew part is ever seen. Testing against all matrices is therefore testing against $\Lambda^2$.
- **A smaller observation.** The proof consumes `hB` at the single instance $\eta=w$, so the theorem would hold from the weaker hypothesis stated at $w$ alone. The universal form is the honest one to write, since it is what L179(b) gives.

### 7.4 Does the conclusion say what L192 claims? Yes, and slightly more, which costs it the content

- **The second difference is the right stand-in for $\partial_i^2$**, exactly and not approximately, by the cubic argument of §7.1: at $w=w(x)$ the quantity $\mathrm{pf6}(w+\omega_i)-2\mathrm{pf6}(w)+\mathrm{pf6}(w-\omega_i)$ **equals** $\partial_i^2\mathrm{Pf}(w(x))$, so the weighted sum is $L[\mathrm{Pf}(w(x))]$ on the nose.
- **Quantifying over every $w$ rather than the span is a strengthening of the conclusion**, and this is the point worth recording. By §7.3's own argument run in reverse, the conclusion *at every $w$* is equivalent to the hypothesis: both say $\sum_i\lambda_iT(\omega_i,\omega_i,\cdot)$ vanishes identically. **So `bianchi_implies_harmonic` is Bianchi implying Bianchi**, and its mathematical content is `pf6_second_diff` plus one line of linearity, which is what its own docstring says it is.
- **What is therefore still untyped is the lossy half**, the half L192's Statement is about: that Bianchi implies harmonicity *when $w$ is restricted to the span*, together with the failure of the converse there. Typing that needs $w=\sum_jx_j\omega_j$ in the conclusion and would then be a strictly weaker theorem than the one on file. **The row should say this**, since a reader who sees `bianchi_implies_harmonic` alongside the block's "an implication and not an equivalence" will reasonably expect the Lean theorem to be the strict one, and it is the tautological one.

### 7.5 Is symmetry used quietly anywhere?

**No, and I checked every declaration in both files.** In [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean) the six trilinearity lemmas each unfold `triple6` and rearrange one slot, and `pf6_second_diff` states its right-hand side with the three orders **kept apart** precisely so that symmetry is not needed. In [L192Statement.lean](../lean/HamiltonsCubic/Results/L192Statement.lean), `bianchi_implies_harmonic` rewrites by `pf6_second_diff` and then matches `hB` term for term in that same unsymmetrised shape. The `SymTri` section does assume symmetry, but as **structure fields of an abstract form**, never of `triple6`, and nothing connects the two namespaces. **The file's own header is accurate.**

### 7.6 Two notes with no correctness content

- **The [lean/INDEX.md](../lean/INDEX.md) row is now stale** and says the Pfaffian is not built. Its replacement should carry §7.4's scoping: the identity and the tautological implication are typed, the span restriction is not.
- **`L66Statement.Pf T X = T X X X` is a name collision** with no Pfaffian content, and an instructive one: it is literally $C(w,w,w)$ for an `E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ`, where multilinearity comes free and only symmetry needs hypothesising. The hand-rolled `SymTri` could be retired in its favour.

## 8. Falsifiers, and what I did to look for each

| Claim | What would falsify it | What I did |
|---|---|---|
| (1) is an equivalence | An $x$-dependence in $L[w^2]$, leaving the vanishing weaker than $\sum_i\lambda_i\omega_i^2=0$ | Expanded $w(x)^2$ in full, and every cross term dies under $\partial_i^2$, so the output is constant. Both directions then read off L180(1) |
| (2)'s constants | Any of $6\mathrm{Pf}$, the $\tfrac16$, or the $6$ in $\partial_i^2$ being wrong, which would put a factor in $\sum_i\lambda_ic_{iik}=0$ | Recomputed all three, checked $\mathrm{Pf}$'s normalisation against two independent record uses ($\sigma\circ\sigma$ at $\dim6$, $\det=\mathrm{Pf}^2$ at $\dim8$), and verified $C(\omega,\omega,\omega)=6$ on $\varepsilon_1+\varepsilon_2+\varepsilon_3$ |
| The gap is exactly the span | $\eta=w(x)$ over all $x$ testing more than the span, or the $\Lambda^4\times\Lambda^2$ pairing being degenerate | Linearity of $B\wedge(\cdot)$ and the perfect pairing. The loss is precisely the twelve-dimensional $\mathop{\mathrm{span}}^\perp$ |
| Strictness | Harmonicity forcing $B=0$ for every orthonormal triple | Built the explicit witness of §4 and checked all three wedges by hand. **Did NOT find a Ricci-flat witness**, and say so. The one Ricci-flat family cheap enough to test by hand, the scalar one, has $\star B$ inside the span and so fails harmonicity unless Bianchi holds |
| $c_{111}\ne0$ | A permitted configuration in one of the two sign patterns with $\mathrm{Pf}(\omega_1)=0$ | Traced the minority index through both patterns of L180(3), and in $(+,+,-)$ the bound lands on $\omega_3$, and L189's non-decomposability floors $\omega_1$ at rank four without reaching six |
| The $\dim V=4$ box | The general-$m$ identity failing, or $L[\mathrm{Pf}(w)]$ at $m=2$ being anything other than the whole of Bianchi | Derived $L[\mathrm{Pf}(w)]=\tfrac1{(m-2)!}\star(B\wedge w^{\wedge(m-2)})$ for all $m\ge2$, checked it against the block's own display at $m=3$, and evaluated it at $m=2$, where it is $\star B$ |
| Carry-over | A dim-six fact used at another width, the failure mode of [L187](../findings/diagonal-half.md) and [L190](../findings/diagonal-half.md) | Checked each step for its width dependence. The dim-six facts ($\star(J\wedge J)=2\epsilon_JJ$, $\mathrm{Padj}$) are unused, and L180(3) is dimension-free. The one carry is in the opposite direction, the $m=3$ mechanism mis-read at $m=2$ |
| Lean fidelity | `cube_second_diff` proving something weaker than $\partial_i^2C(w,w,w)=6C(\omega_i,\omega_i,w)$, or a `sorry`, or a nonstandard axiom | Read the file, checked that the second difference of a cubic equals its second derivative exactly, grepped for `sorry`, screened the build and the axiom print |
| `pf6`'s normalisation | $1/48$ being the wrong constant, or `levi6` carrying a nonstandard sign or a stray factor, either of which would put a factor into $\sum_i\lambda_ic_{iik}=0$ | Read `sgnR` and `levi6` to their definitions, confirmed $\epsilon_{012345}=+1$, and evaluated $\mathrm{pf6}$ by hand on a normal-form triple: all $48$ surviving terms equal $c_1c_2c_3$. Also fixed $\mathrm{triple6}=C/6$ against the wedge, so the two normalisations cannot be confused later |
| The symmetrised hypothesis | An $\eta$, or a slot order, at which the summed form asks for more than [L179](../findings/diagonal-half.md)(b) gives | Proved `triple6`'s symmetry independently, which collapses the three orders to $3T(\omega_i,\omega_i,\eta)$, then checked the two places a strengthening could hide, the slot orders and the quantifier over non-skew $\eta$, the latter dying on `levi6`'s antisymmetry in each pair |
| The conclusion saying what L192 claims | The second difference differing from $\partial_i^2$ at a cubic, or the $\forall w$ form being weaker than the span form | Both checked. The difference is exact, and the $\forall w$ form is *stronger*, so strong that it is equivalent to the hypothesis, which is why the strict half of L192(2) remains untyped |
| Quiet use of symmetry | Any declaration in either file whose proof needs `triple6` symmetric | Read every declaration in both files. The six trilinearity lemmas touch one slot each, `pf6_second_diff` keeps the three orders apart by design, and `bianchi_implies_harmonic` consumes them in that shape. `SymTri`'s symmetry fields are on an abstract form and never on `triple6` |

## 9. What I recommend, in order

1. **Reindex.** State that $\omega_1$ is the minority form, then keep $c_{111}\ne0$ and say $L$ is Lorentzian up to overall sign. Without this the coordinate box is false in one of the two patterns the Statement itself lists.
2. **Replace the $\dim V=4$ box** with the general-$m$ identity of §5, noting that $m=2$ is an equivalence and $m=4$ tests $B$ against $w\wedge w$. This corrects a false statement and hands $\dim V=8$ an instrument.
3. **Say $\mathrm{Pf}$ means $\mathrm{Pf}_V$**, one clause, since at $n>6$ the ambient reading makes (2) vacuous.
4. **Downgrade the closing box's last sentence** to what §3 supports: the question acquires a necessary condition on a cubic form in three variables, and the equation it is a projection of, $\sum_i\lambda_i\mathrm{Padj}(\omega_i)=0$, is already on the record.
5. **Fix the item-1 gloss** to "an identity between constant matrices", which is the reason the equivalence is exact.
6. **Rewrite the [lean/INDEX.md](../lean/INDEX.md) row** for the new layer, saying that `pf6` is the standard Pfaffian at $1/48$, that `triple6` is $C/6$, and that `bianchi_implies_harmonic`'s $\forall w$ conclusion is equivalent to its hypothesis, so the span-restricted implication and the failure of its converse remain untyped.

*Nothing above touches the two numbered statements, which stand as written.*
