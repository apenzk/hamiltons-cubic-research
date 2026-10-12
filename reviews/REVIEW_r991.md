# Gate 2 review r991: the Osserman closure, and the reclassification of a `sorry`

Reviewer `r991`, independent, cold read from [reviews/BRIEF_I67_I107_unreviewed.md](BRIEF_I67_I107_unreviewed.md) alone. The findings files, the fence posts, the screens and the Lean sources under review were not opened.

Log: [agent_logs/r991-osserman-adjugate.log](../agent_logs/r991-osserman-adjugate.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | kernel direction $\Rightarrow J(x)=0$, Osserman $\Rightarrow$ constant spectrum $0$ $\Rightarrow W=0$ | CONFIRMED, two silent steps named below |
| 2 | a nonzero Osserman Weyl tensor has no kernel direction | CONFIRMED, non-vacuous but thin |
| 3 | padded $W_{\mathbb{CP}^2}$ has kernel directions for $n>4$ and is not Osserman, while $n=4$ is | CONFIRMED, both halves |
| 4 | the Osserman-classification route has a false warrant | CONFIRMED for $n>4$, **the reach is narrower than "closed"** |
| 5 | $\varepsilon_J=\mathrm{Pf}(J)$, value $-1$ at $J=\varphi_{01}+\varphi_{23}+\varphi_{45}$ | **REFUTED in its value**, identification confirmed |
| 6 | both signs of $\mathrm{Pf}(J)$ occur, one per $SO(6)$ orbit | CONFIRMED |
| 7 | $\langle\star(X\wedge X),Z\rangle=12\,\mathrm{triple}(Z,X,X)$ | CONFIRMED, under one of the two inner products |
| 8 | the adjugate law holds at every skew $X$, both sides being cubic in the $15$ entries | CONFIRMED as a statement, **the cited evidence does not reach it** |
| 9 | the `sorry`'s stated justification is false: neither normal form nor equivariance | CONFIRMED, on a warrant the item does not currently cite |
| 10 | $\sigma(X)_{ij}$ is the signed Pfaffian of the complementary four-set | CONFIRMED |
| 11 | $\mathrm{Pf}(X)=\tfrac13\sum_{a<b}\sigma(X)_{ab}X_{ab}$ | CONFIRMED |

## Claim 7, the pairing constant

Derived independently, and the brief's sketch is structurally right. Write $S_1=\sum_{cdef}\varepsilon_{abcdef}X_{cd}X_{ef}$.

- The second wedge term equals $-S_1$: renaming the dummies $d\leftrightarrow e$ turns $X_{ce}X_{df}$ into $X_{cd}X_{ef}$ and costs one transposition inside $\varepsilon$.
- The third equals $+S_1$: the relabelling $(d,e,f)\mapsto(f,d,e)$ is a $3$-cycle, even.
- So the bracket contracts to $S_1-(-S_1)+S_1=3S_1$, and $(\star(X\wedge X))_{ab}=\tfrac{2\cdot3}{24}S_1=\tfrac14 S_1$.

Contracting against $Z$ and comparing with $\mathrm{triple}=\tfrac1{48}\sum$ gives the factor $48/4=12$. The constant is right.

**Correction, and it is load-bearing.** The value $12$ holds only when $\langle A,Z\rangle=\sum_{a,b}A_{ab}Z_{ab}$ runs over *both* indices freely. Under the other common convention, $\sum_{a<b}$, the same derivation gives $6$. The brief never fixes the inner product, so claim 7 as written is ambiguous by a factor of two, and the Lean statement that discharges this gap must pin the convention in its own text. Claims 7 and 11 cross-check each other here: the $\tfrac13$ of claim 11 follows from the $12$ only under the full double sum, so the two rows are consistent, and together they fix the intended reading.

## Claim 11

Confirmed, and it does follow from claim 7 at $Z=X$. Since $\mathrm{triple}(X,X,X)=\mathrm{Pf}(X)$ by definition, claim 7 gives $\sum_{a,b}(\star(X\wedge X))_{ab}X_{ab}=12\,\mathrm{Pf}(X)$. Halving for $\sigma=\tfrac12\star(X\wedge X)$ gives $6\,\mathrm{Pf}(X)$, and restricting to $a<b$ halves it again, because the summand is symmetric in $a\leftrightarrow b$ (both factors are skew). Hence $\mathrm{Pf}(X)=\tfrac13\sum_{a<b}\sigma(X)_{ab}X_{ab}$.

## Claim 10, statement only

Confirmed as the right closed form, with the sign being exactly the permutation's. For $a<b$ with complement $C=\{p<q<r<s\}$,

$$\sigma(X)_{ab}=\varepsilon_{abpqrs}\,\mathrm{Pf}(X_C),\qquad \mathrm{Pf}(X_C)=X_{pq}X_{rs}-X_{pr}X_{qs}+X_{ps}X_{qr}.$$

The derivation is one line from the above: $\sigma(X)_{ab}=\tfrac18 S_1$, the sum $S_1$ runs over the $24$ orderings of $C$, and $\tfrac18\sum_{\tau\in S_4}\mathrm{sgn}(\tau)X_{\tau p\tau q}X_{\tau r\tau s}$ is the $4\times4$ Pfaffian on the nose. The normalisations agree: $\tfrac1{48}=\tfrac1{2^3 3!}$ and $\tfrac18=\tfrac1{2^2 2!}$ are the standard Pfaffian constants in six and four variables, so no stray factor is hiding in the fifteen theorems.

## Claims 8 and 9, the evidence question

**Claim 8's statement is true, and both sides are indeed homogeneous cubics in the fifteen entries.** $\sigma$ is quadratic and $X$ linear, so $X\sigma(X)$ is cubic, and $\mathrm{Pf}$ is cubic.

**The cited evidence does not reach the statement, and the shortfall is quantitative rather than philosophical.** Let $D(X)=X\sigma(X)+\mathrm{Pf}(X)\mathrm{Id}$, whose every entry is a homogeneous cubic in $15$ variables. Such a form has $\binom{17}{3}=680$ coefficients. Each sampled matrix contributes exactly one linear condition per entry of $D$. So $300$ samples impose $300$ conditions on $680$ unknowns, and leave a space of dimension at least $380$ of degree-three forms agreeing with every observed value. **The sample count is not merely short of a proof, it is short of the interpolation count**, so no amount of genericity in the draw rescues it: the linear algebra cannot close even in the best case. Floating-point draws make it weaker still, since what is observed is a residual under a tolerance rather than a zero.

Three things would close it, in descending order of sense:

- **The expansion.** The identity is a finite one in $15$ variables at degree $3$. Expanded in exact rational arithmetic it collapses to zero in about a second. This is what I did, and it is recorded below as a screen.
- **A Schwartz–Zippel certificate over $\mathbb F_p$.** A single point drawn uniformly from $\mathbb F_p^{15}$ misses a nonzero $D$ with probability at most $3/p$. This is the only way a *sampling* argument becomes rigorous, and it needs exact arithmetic, which float sampling does not supply.
- **A grid.** Vanishing on $S^{15}$ with $|S|=4$ forces $D\equiv0$ by the Combinatorial Nullstellensatz. Valid, and $4^{15}$ evaluations, so a certificate nobody runs.

**The analytical proof, which is what the deliverable should carry.** Claim 10 identifies $\sigma(X)_{ab}$ as the signed complementary Pfaffian, which is precisely the Pfaffian cofactor of the pair $(a,b)$. The adjugate law is then the pair of classical Pfaffian expansion identities: the row expansion $\mathrm{Pf}(X)=\sum_{k\ne i}(-1)^{\ldots}X_{ik}\mathrm{Pf}(X_{\widehat{ik}})$, which produces the diagonal, and the alien-cofactor identity $\sum_k(\pm)X_{jk}\mathrm{Pf}(X_{\widehat{ik}})=0$ for $j\ne i$, which produces the vanishing off-diagonal and holds because that sum is the row expansion of the Pfaffian of a matrix with a repeated row. **Neither uses a normal form and neither uses equivariance.**

**Claim 9 is confirmed, and the answer to the brief's question is that it would NOT have been, on the screened evidence alone.** The justification quoted in the `sorry` asserts a necessity: that carrying a frame-adapted check to every $\omega$ *needs* the real skew normal form together with $SO(6)$-equivariance. A necessity claim is refuted by exhibiting one proof that uses neither, which the expansion above does. Had claim 8 remained screened, no proof would have been exhibited, and claim 9 would have rested on "the statement is polynomial, so some expansion proof must exist", which is sound only if the statement is true, and truth is exactly what a sample set short of the interpolation count fails to deliver. **On screened evidence claim 9 is PLAUSIBLE. With the expansion in hand it is CONFIRMED.** The distinction is not pedantry, because the item's recorded warrant is currently the sample set, and that warrant should be replaced by the expansion.

**One correction to claim 9's reach.** The quoted justification names the wrong obstacle rather than no obstacle. The mathematics needs no normal form, but a Lean proof by expansion still faces proof-term size, since each of the $36$ entries is a cubic assembled from a $6^4$ contraction. That is a cost, not a missing theory, and it is discharged by reusing the fifteen typed $\sigma$ entries of claim 10 rather than re-expanding the contraction. The `sorry` should be reclassified as an engineering cost and not as a Mathlib gap, which is what claim 9 says, so claim 9 stands with its reason sharpened.

## Claims 5 and 6, the sign

**Claim 6 is confirmed.** $\mathrm{Pf}(gXg^{\mathsf T})=\det(g)\,\mathrm{Pf}(X)$, so $\mathrm{Pf}$ is an $SO(6)$ invariant of an orthogonal complex structure and changes sign under the other component of $O(6)$. The orthogonal complex structures on $\mathbb R^6$ form $O(6)/U(3)$, whose two connected components are the two $SO(6)$ orbits, each a copy of $SO(6)/U(3)\cong\mathbb{CP}^3$. The Pfaffian separates them, taking $+1$ on one and $-1$ on the other, so $\varepsilon_J$ is genuinely two-valued and the target identity cannot be stated with a fixed sign. The brief's sampling warning bites precisely here: an orthogonal matrix drawn from a QR factorisation can land in $\det=-1$ every time, which would exhibit one orbit while reporting on two.

**Claim 5 splits, and half of it is wrong.**

- **The identification $\varepsilon_J=\mathrm{Pf}(J)$ is confirmed**, and derives cleanly from the two GIVENs. From $J^2=-\mathrm{Id}$ we get $J^{-1}=-J$, so the adjugate law gives $\sigma(J)=-\mathrm{Pf}(J)J^{-1}=\mathrm{Pf}(J)\,J$, whence $\star(J\wedge J)=2\sigma(J)=2\,\mathrm{Pf}(J)\,J$.
- **The value $-1$ at $J=\varphi_{01}+\varphi_{23}+\varphi_{45}$ is wrong, and so is the consequence $\star(J\wedge J)=-2J$.** Under the brief's own definitions the value is $+1$ and $\star(J\wedge J)=+2J$.

The arithmetic is short enough to state. In $\mathrm{Pf}(J)=\tfrac1{48}\sum\varepsilon_{abcdef}J_{ab}J_{cd}J_{ef}$, a term survives only when the three index pairs are $\{01\},\{23\},\{45\}$ in some order and orientation, giving $3!\cdot2^3=48$ surviving terms. Reordering the pairs is an even permutation and changes nothing. Flipping one pair costs a sign in $\varepsilon$ and a sign in the corresponding $J$ entry, which cancel. So all $48$ terms equal $+1$ and $\mathrm{Pf}(J)=+1$. Independently, claim 10 gives $\sigma(J)_{01}=J_{23}J_{45}=1$ with $\sigma(J)_{23}=\sigma(J)_{45}=1$ and the other twelve entries zero, so $\sigma(J)=J$, and then $J\sigma(J)=J^2=-\mathrm{Id}$ forces $\mathrm{Pf}(J)=+1$ through the adjugate law.

**The caveat that keeps this from being a bare arithmetic slip.** A global sign flip in the orientation convention, meaning $\varepsilon_{012345}=-1$ or $\varphi_{ab}$ carrying $-1$ in its $(a,b)$ entry, flips $\sigma(J)$ and $\mathrm{Pf}(J)$ together and would make the recorded value right. What is convention-free is the *relation* $\varepsilon_J=\mathrm{Pf}(J)$, and what is convention-dependent is the value at a named $J$. **Under the conventions the brief itself writes down, the value is $+1$.** Since the entire purpose of $\varepsilon_J$ is to track a sign across two orbits, a recorded value that is right only under an unstated convention flip is a defect worth fixing rather than a harmless one, and the fix is to state the orientation convention wherever the value is asserted.

## The screen behind the part B rows

Exact rational arithmetic over the fifteen free entries, about one second, every check an assertion and no printed expectations. It verified: the fifteen closed forms of claim 10; the adjugate law expanding to zero identically; the pairing constant as $12$ under the full double sum and $6$ under $a<b$; claim 11's $\tfrac13$; $\mathrm{Pf}(J)=+1$ with $\sigma(J)=J$ and $\star(J\wedge J)=2J$; and both signs of $\mathrm{Pf}$ arising by conjugating $J$ with an explicit $O(6)$ element whose determinant is asserted to be $-1$. It also asserted the negative control that the law fails once a single entry is perturbed off the skew locus. A symbolic expansion over free variables is stronger than sampling, being a ring computation rather than a set of evaluations, but it is still a machine computation, and the derivation the record should carry is the Pfaffian expansion argument given above.

## Claim 1, line by line

The chain is correct at every link. Two links are load-bearing and are not stated in the brief's phrasing, and one hypothesis in the definition is never used.

**Step 1, a kernel direction kills the Jacobi operator.** With $\sum_a W_{abcd}x^a=0$ for all $b,c,d$, the contraction $\sum_i W_{aibj}x^i$ has $x$ in slot two, and first-pair antisymmetry gives $W_{aibj}=-W_{iabj}$, so it equals $-\sum_i W_{iabj}x^i=0$. Hence $J(x)=0$. **Only the antisymmetry of the first index pair is used**, and the step is sound.

**Step 2, the Osserman hypothesis transfers it.** The kernel condition is homogeneous in $x$, so $x/\lVert x\rVert$ is a unit kernel direction and the spectrum of $J(x)|_{x^\perp}$ is $n-1$ zeros. Osserman then gives the all-zero spectrum at every unit $y$.

**Step 3, zero spectrum to zero operator, which is where the brief's doubt is well placed.** Zero spectrum gives only nilpotency for a general operator. Two facts close the gap, and both deserve to be named because the brief's phrasing passes over them:

- $J(y)$ is symmetric, and **the pair-exchange symmetry $W_{abcd}=W_{cdab}$ is what makes it so**: $J(x)_{ba}=\sum W_{bjai}x^jx^i=\sum W_{aibj}x^jx^i=J(x)_{ab}$ after relabelling. A real symmetric operator with every eigenvalue zero is zero, since it is diagonalisable.
- $J(y)y=0$ for every $W$ whatsoever, so vanishing on $y^\perp$ is vanishing outright. Here $\sum_b J(x)_{ab}x^b=\sum W_{aibj}x^ix^jx^b$ pairs the last-pair antisymmetry $W_{aibj}=-W_{aijb}$ against the symmetric $x^jx^b$, giving zero.

So the brief's alternative, that constant spectrum $0$ might only give vanishing on $y^\perp$ and that this might be weaker, is answered: the two coincide, because $y$ is in the kernel of $J(y)$ for free.

**Step 4, every $J(y)=0$ forces $W=0$, and the first Bianchi identity carries it.** Polarising the identity $\sum_{ij}W_{aibj}y^iy^j=0$ in $y$ gives

$$W_{aibj}+W_{ajbi}=0 \quad\text{for all } a,b,i,j. \tag{P}$$

First Bianchi, cyclic in the last three slots, reads $W_{aibj}+W_{abji}+W_{ajib}=0$. Last-pair antisymmetry with (P) gives $W_{ajib}=-W_{ajbi}=+W_{aibj}$, so Bianchi collapses to

$$W_{abji}=-2\,W_{aibj}. \tag{$\star$}$$

Now apply ($\star$) again under the substitution $(a,i,b,j)\mapsto(a,b,j,i)$, which gives $W_{ajib}=-2W_{abji}$. Chaining,

$$W_{aibj}=W_{ajib}=-2\,W_{abji}=4\,W_{aibj},$$

so $3W_{aibj}=0$ and $W=0$. **The Weyl symmetry that carries the final step is the first Bianchi identity**, used together with the antisymmetry of the last index pair. Pair-exchange is spent earlier, on the symmetry of $J$.

**Two corrections.** First, **the trace-free condition is never used**, at any step. Claim 1 is a statement about algebraic *curvature* tensors, and the classical fact it instantiates is that such a tensor is determined by its Jacobi operators. Recording it as a Weyl fact understates it and hides that it applies to the full curvature tensor too. Second, the argument divides by $3$, which is free over $\mathbb R$ and would need saying if the layer ever typed this over a general field.

**On the Lean column.** Claims 1 to 4 are untyped because the layer carries no Jacobi operator. Claim 1 is the cheapest of the four to type: it is four lines of index algebra over a tensor with the symmetries already present, with no analysis and no Mathlib gap. That it is missing while fifteen $\sigma$ entries are machine-checked is a statement about where effort went, not about difficulty.

## Claim 2, and the vacuity test

Immediate as the contrapositive of claim 1, given that $W\ne0$. **What vacuity would look like here, and it is worth stating in both directions.**

- *Vacuous by an empty subject.* If no nonzero Osserman Weyl tensor existed, the claim would quantify over nothing. It does not: the $n=4$ $\mathbb{CP}^2$ Weyl tensor is nonzero and Osserman, as claim 3's control establishes.
- *Vacuous by an empty exclusion*, which is the brief's worry. If every Weyl tensor of interest had a kernel direction, claim 2 would exclude everything and say nothing.

Neither holds, but the honest reading inverts the brief's fear. **A kernel direction is the non-generic condition**, since it asks for a nonzero solution of $n^3$ linear equations in $n$ unknowns, so a generic $W$ has none and claim 2's conclusion is generically empty of content. The force of claim 2 is therefore entirely in its application to one specific non-generic tensor, the padded one, which lies in the thin set precisely because padding put it there. That is enough for the use claim 3 makes of it, and it is not enough for any broader structural conclusion about maximisers.

## Claim 3, both halves

**The $n>4$ half is confirmed.** Take $x\ne0$ orthogonal to the $4$-block $B$. Every component $x^a$ with $a\in B$ vanishes, and $W_{abcd}=0$ whenever any index lies outside $B$, so $\sum_a W_{abcd}x^a=0$. Such an $x$ exists because $n-4\ge1$, and the padded tensor is nonzero, so claim 2 applies and it is not Osserman.

**A check the brief does not ask for, and which the claim needs.** The padded tensor must still be an algebraic Weyl tensor on $\mathbb R^n$, or the argument attacks an object outside the class the Osserman classification speaks about. It is: the Riemann symmetries and Bianchi are inherited blockwise, and the $n$-dimensional traces reduce to the $4$-dimensional ones, which vanish. So the padding preserves trace-freeness and the object is legitimately in the class.

**A route to the same conclusion that does not lean on the Osserman reasoning.** $J(x)=0$ for $x\perp B$ while $J(y)\ne0$ for suitable $y\in B$, so two unit vectors carry different spectra and Osserman fails directly. This uses only step 3 of claim 1, to know that $W\ne0$ forces some $J(y)\ne0$, and none of steps 1, 2 or 4. Given that claims 1 to 4 are untyped, that redundancy is worth keeping on the record.

**The $n=4$ control passes, and it does follow from rank-one symmetric rather than needing its own check, but the Einstein property is what carries it.** $\mathbb{CP}^2$ with the Fubini-Study metric is a rank-one symmetric space, so its full curvature tensor is Osserman. For an Einstein metric the curvature decomposition leaves only the Weyl part and a constant-curvature summand, and that summand contributes a fixed multiple of the identity to $J(x)|_{x^\perp}$. So $J_W(x)|_{x^\perp}$ is $J_R(x)|_{x^\perp}$ shifted by a constant, and constancy of the spectrum passes from $R$ to $W$. **Without the Einstein property the inheritance fails**, because the traceless-Ricci summand contributes an $x$-dependent operator, so the control is not the triviality it looks like.

## Claim 4, what it closes and what it does not

**Confirmed that the warrant is false, for $n>4$.** The supporting instance was to be a maximiser lying inside the Osserman class, and claim 3 removes it.

**What claim 4 closes.** The stated warrant, namely that the non-diagonal equality case is an Osserman tensor and therefore the Osserman classification is the right instrument for classifying non-diagonal maximisers. If the route's premise is the universal one, that every non-diagonal maximiser is Osserman, then the padded tensor refutes that premise outright for $n>4$, which is strictly more than a false warrant. The brief does not say which of the two the route asserted, so the stronger reading cannot be adopted here.

**What claim 4 does not close, and this is the correction.**

- **Dimension $4$.** There the equality case is the unpadded $\mathbb{CP}^2$ Weyl tensor, which is Osserman. The warrant survives intact in the base dimension, so "the route is closed" is false as an unqualified statement and true only for $n>4$.
- **The natural repair.** The failure is an artefact of padding and nothing else: the padded tensor restricted to its own support $B$ is Osserman, and it is the extension by zero that manufactures the kernel directions. So the informative conclusion is that **Osserman-ness is not preserved by padding**, and a route through the Osserman classification should be run in the dimension of the support rather than in $\mathbb R^n$. Claim 4 does not exclude that version of the route.
- **The target.** Nothing about Conjecture A is touched. A route's warrant failing is evidence about the search and never about the theorem, so the target statement survives its supporting instance being wrong, without qualification.

## What the item still owes

Claim 7 is the declared gap, and it is the cheapest one to discharge, by the same contraction bookkeeping that already produced the fifteen typed $\sigma$ entries of claim 10. The statement must fix its inner product when it is typed, since the constant is $12$ under the full double sum and $6$ under $a<b$.
