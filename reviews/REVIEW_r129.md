# Gate 2 review 129, the vertex matrix as a graph Laplacian

Cold review of commits `546757b`, `5da5126`, `b764ebf`, `f135fc1`, `6d0b5bf`, `2ecd2b0` against [findings/diagonal-half.md](findings/diagonal-half.md) and [findings/target.md](findings/target.md). Every derivation below was done from the definitions before any of the project's scripts were opened; the one numerical run in this review checks a witness constructed by hand.

## Verdict table

| Claim | Verdict | One line |
|---|---|---|
| **A**, on the diagonal locus $K^2-\lambda K=L(K_{ab}^2)\succeq0$ | **CONFIRMED at diagonal CRITICAL points; the summary sentence at [diagonal-half.md:154](findings/diagonal-half.md#L154) is FALSE** | witness below: a coordinate-diagonal Weyl tensor at $n=8$ with an eigenvalue inside $(0,\theta)$ |
| **B**, $E$ is hollow for every Weyl tensor and every scalar | **CONFIRMED, and content-free** | true for every hollow symmetric matrix; the two sides are equal on the diagonal by construction |
| **C**, $E_{ab}=[(K^2)_{ab}-(W^{\#})_{(ab),(ab)}]-\lVert F_{(ab)}\rVert^2$ at a critical point | **CONFIRMED** | rederived independently; it is the vertex equation transposed, and $\lVert F_{(ab)}\rVert^2$ *is* $R_{ab}$ by definition |
| **D**, $(W^2)_{(ab),(ab)}=K_{ab}^2+\lVert F_{(ab)}\rVert^2$ | **CONFIRMED, and redundant** | "the diagonal of $A^2$ is the squared row norm"; no Weyl content, and claim C does not need it |
| **E**, both brackets vanish together on the locus | **OVERSTATED** | they vanish separately, under the *single* hypothesis of diagonality, and only in the forward direction |
| **F**, $W\#I=-W$; $\operatorname{tr}(W^{\#})=-\lVert W\rVert^2$; the summed vertex equation is vacuous | **CONFIRMED, and derivable without the citation** | I reproduce the operator identity from the structure constants plus Schur, and cross-check the lemma's constant at $R=I$ |
| **G**, the PSD statement fails maximally off the locus | **CONFIRMED, but it is a restatement of an inequality already at [target.md:48](findings/target.md#L48)** | $\mu_{\max}(K)\le\sqrt t$ with $t=2-2\sum R$ forces total failure whenever $\sum R>1-\lambda^2/2$; the census measures a consequence |
| **H**, $r\le2/\lambda^2$, forcing $r=1$ at $\theta_0(12)$ | **CONFIRMED, and needlessly narrow** | $2/\theta_0(n)^2=n^2/((n-1)(n-2))<2$ for *every* $n\ge6$; and the contrapositive gives an unconditional reduction the record does not state |

Convention audit (brief item 1): no factor of two is loose. $\lVert W\rVert^2=\sum_{a<b,c<d}W_{abcd}^2=1$ is the unordered $\Lambda^2$ sum, $t=\lVert K\rVert_F^2=2\sum_{a<b}K_{ab}^2$ is the ordered $n\times n$ sum, and $t\le2\lVert W\rVert^2=2$ is exactly the relation [stratum-two-negative.md:198](findings/stratum-two-negative.md#L198) records. **H survives the convention.** $R_{ab}$ and $\lVert F_{(ab)}\rVert^2$ are both unordered row sums over $(cd)\ne(ab)$, so C and D are consistent with it too.

---

## A, the scope sentence is false, with a witness

The derivation is right and I reproduce it. On the diagonal locus criticality reads $K^{\circ2}+K^2=\lambda K+D$, so $K^2-\lambda K=D-K^{\circ2}$, whose diagonal is $s_a=\sum_bK_{ab}^2$ and whose off-diagonal entry is $-K_{ab}^2$: that is $L(w)$ with $w_{ab}=K_{ab}^2$ verbatim, and $v^{\mathsf T}L(w)v=\tfrac12\sum w_{ab}(v_a-v_b)^2\ge0$. Naming it a Laplacian is fair and the write-up is honest that this is corroboration rather than a new result.

**But [diagonal-half.md:118](findings/diagonal-half.md#L118) and [diagonal-half.md:154](findings/diagonal-half.md#L154) contradict each other.** Line 118 says the off-diagonal entry is $-K_{ab}^2$ "precisely because the vertex equation holds at $(ab)$", i.e. because the point is critical. Line 154 then concludes "$K^2-\lambda K\succeq0$ is a property of the diagonal locus, not of criticality." The operative hypothesis is *diagonality **and** criticality*, and the second sentence drops half of it. This is precisely the separation commit `546757b` was written to enforce two paragraphs earlier, so the charitable reading ("of the locus, among critical points") is not available: the commit set made the distinction explicit and then left the summary line on the wrong side of it.

**The wider statement is false, not merely unproved.** Every hollow symmetric $K$ with $K\mathbf1=0$ is the vertex matrix of a coordinate-diagonal Weyl tensor, first Bianchi holds vacuously for a $\Lambda^2$-diagonal operator and Ricci-flatness is exactly the row-sum condition, so the diagonal locus is that whole matrix set, and the natural reading of $\lambda$ off criticality is $\lambda=\theta(K)=\tfrac12(\sum_{a,b}K_{ab}^3+\operatorname{tr}K^3)$.

Take $n=8$ and put a scaled copy of the four-vertex weight

$$A(c):\quad A_{12}=A_{34}=2c,\qquad A_{13}=A_{14}=A_{23}=A_{24}=-c$$

on $\{1,2,3,4\}$ at scale $c_1$ and on $\{5,6,7,8\}$ at scale $\delta$. Row sums vanish, $\lVert K\rVert_F^2=24(c_1^2+\delta^2)$, the blocks contribute no cross triangles so $\theta=36(c_1^3+\delta^3)$, and each block contributes spectrum $\{0,4c,-2c,-2c\}$. Normalising $c_1=\sqrt{(2-24\delta^2)/24}$ and letting $\delta\to0$ gives $\theta\to36/12^{3/2}=0.866025$ while the second block's positive eigenvalue $4\delta\to0$. **So $4\delta$ sits inside $(0,\theta)$ and $K^2-\theta K$ has a negative direction.** No search was needed; the numerical run only confirms the arithmetic:

| $\delta$ | $\lVert K\rVert_F^2$ | max row sum | $\theta$ | positive eigenvalue in $(0,\theta)$ | $\lambda_{\min}(K^2-\theta K)$ | criticality residual |
|---|---|---|---|---|---|---|
| $0.05$ | $2.000000000000$ | $0$ | $0.831848$ | $0.200000$ | $-0.126370$ | $0.068$ |
| $0.01$ | $2.000000000000$ | $0$ | $0.864503$ | $0.040000$ | $-0.032980$ | $0.017$ |
| $0.001$ | $2.000000000000$ | $0$ | $0.866010$ | $0.004000$ | $-0.003448$ | $0.002$ |

The last column is $\max\lvert K^{\circ2}+K^2-\theta K-D\rvert$, so these points are genuinely non-critical, as claim A itself demands, since a critical one would have to satisfy the inequality.

**Why this matters rather than being pedantry.** B1 on the diagonal locus is an optimisation over exactly this matrix set, and the obvious next move is to add $K^2-\theta K\succeq0$ as a valid inequality to a relaxation over all admissible $K$. Read as line 154 states it, that move is licensed; it is not. The constraint is valid only when the criticality equation is also imposed.

*Fix:* replace line 154 with "a property of diagonal **critical** points, not of criticality alone", and record the $n=8$ two-block witness so the wider reading cannot be re-derived by a later reader.

## B and D, correct, and empty

$E:=(K^2-\lambda K)-L(K_{ab}^2)$ has, off the diagonal, $E_{ab}=(K^2)_{ab}+K_{ab}^2-\lambda K_{ab}$, which is the residual of the diagonal criticality equation at $(ab)$. **$E$ depends on $W$ only through $K$ and $\lambda$.** Its diagonal is $(K^2)_{aa}-\sum_{b\ne a}K_{ab}^2-\lambda K_{aa}$, which vanishes for *any* hollow symmetric matrix, no Weyl tensor, no Ricci-flatness, no criticality, and indeed no $\lambda$. So B is true in far greater generality than stated, and the "confirmed to $10^{-17}$ at random Weyl tensors, $n=5,6,7$" is a numerical check of three lines of algebra on random hollow symmetric matrices.

The stated payload ("every bit of the off-locus failure is carried by off-diagonal entries"), is therefore a tautology twice over: the two matrices being compared agree on the diagonal by construction, and no matrix with a non-negative diagonal ever exhibits its indefiniteness there. Nothing is localised.

On brief item 3: "for every scalar $\lambda$" is coherent, since $\lambda$ enters $E$ only through $-\lambda K$ whose diagonal vanishes. It is also the point at which the widening becomes empty, $E$ has content only when $\lambda$ is the critical value, so widening to all scalars widens into the region where the object has no purpose. Correct and worth one clause, not a paragraph.

D is "the $\alpha\alpha$ entry of $A^2$ is the squared norm of row $\alpha$", for any symmetric $A$. It is used in deriving the vertex equation from $Q(W)=\lambda W$, which is where it belongs; C does not need it, because $R_{ab}:=\sum_{(cd)\ne(ab)}W_{abcd}^2$ *is* $\lVert F_{(ab)}\rVert^2$ by definition.

## C, confirmed

From [target.md:15](findings/target.md#L15), $\lambda K_{ab}-K_{ab}^2=R_{ab}+(W^{\#})_{(ab),(ab)}$. Substituting into $E_{ab}=(K^2)_{ab}+K_{ab}^2-\lambda K_{ab}$ gives $E_{ab}=[(K^2)_{ab}-(W^{\#})_{(ab),(ab)}]-R_{ab}$ exactly. Commit `546757b` is right that this half uses criticality and the hollowness half does not; that correction is sound.

## E, overstated, and the advertised deliverable is a tautology

Two separate points.

**The brackets do not vanish "together".** For a coordinate-diagonal $W$ the structure constants are supported on triangles, so $(W^{\#})_{(ab),(ab)}=\sum_cK_{ac}K_{cb}=(K^2)_{ab}$, using $K_{aa}=K_{bb}=0$ to extend the sum over all $c$. That is an algebraic identity for *every* diagonal $W$, critical or not. And $F=0$ is diagonality restated. So both brackets vanish under one hypothesis, independently, and the coupling the word "together" suggests is not there. The converse also fails: an off-locus point could have $(K^2)_{ab}=(W^{\#})_{(ab),(ab)}$ accidentally, so E gives an implication and not a criterion.

**The claimed answer to plan item 1 is circular.** Line 147 offers the pair of vanishing brackets as "a condition separating diagonal from non-diagonal criticality that is an equation rather than a census". But $R_{ab}=0$ for all $(ab)$ says every off-diagonal entry of $W$ on $\Lambda^2$ vanishes, which is the definition of the diagonal locus. Worse, the record already carries this in a sharper and cheaper form: $\sum R=1-t/2$, so $R=0\iff t=2\iff W$ coordinate-diagonal, at [target.md:17](findings/target.md#L17) and [stratum-two-negative.md:198](findings/stratum-two-negative.md#L198). The "equation rather than a census" is $t=2$, and it was already on the record.

**Brief item 2 resolves cleanly, and in the record's favour.** The normalisation is self-consistent, and there are two independent ways to see it. Writing $(A\#B)_{\alpha\alpha}=\tfrac12\sum_{\beta\gamma}c^2_{\alpha\beta\gamma}A_{\beta\beta}B_{\gamma\gamma}$ with $c^2=1$ on triangles gives $(W^{\#})_{(ab),(ab)}=(K^2)_{ab}$ *and* $(W\#I)_{(ab),(ab)}=-K_{ab}$ simultaneously. A raw $c^2=1$ without the $\tfrac12$ would double both. Since the record asserts both independently, the two claims cross-validate the convention, and no rescaling of the Laplacian weights is needed.

## F, confirmed, and stronger than the citation makes it look

$W\#I=-W$ does not need Böhm–Wilking. The map $A\mapsto A\#I$ is linear and $O(n)$-equivariant; $\mathrm{Weyl}_n$ is $O(n)$-irreducible and occurs exactly once in $S^2(\Lambda^2)=S^2_B\oplus\Lambda^4$ (the Weyl representation has Young diagram $(2,2)$, $\Lambda^4$ has $(1,1,1,1)$, so they are inequivalent). By Schur, $W\#I=c_nW$. Evaluating on the diagonal locus pins the constant with no representation theory: $(W\#I)_{(ab),(ab)}=\tfrac12\sum_{c\ne a,b}(K_{ac}+K_{cb})=\tfrac12(-K_{ab}-K_{ab})=-K_{ab}$, using zero row sums. So $c_n=-1$ at every $n$.

I also checked the *cited* constant independently, which the record does not. At $R=I$ the same structure-constant count gives $I\#I=(n-2)I$, so $R+R\#I=(n-1)I$, and for the round sphere $\mathrm{Ric}=(n-1)\,\mathrm{id}$ makes $\mathrm{Ric}\wedge\mathrm{id}$ act on $e_a\wedge e_b$ by $\tfrac12(\mathrm{Ric}_{aa}+\mathrm{Ric}_{bb})=n-1$. **Lemma 2.1 as quoted is consistent at $R=I$**, and setting $\mathrm{Ric}=0$ recovers $W\#I=-W$. Brief item 4's worry about hypotheses does not bite: the lemma is applied to a genuine algebraic curvature operator satisfying first Bianchi, which every Weyl tensor does.

The trace bridge needs only full symmetry of $\mathrm{tri}(A,B,C)=\langle A\#B,C\rangle$, which is standard, and the one-step chain $\operatorname{tr}(W^{\#})=\mathrm{tri}(W,W,I)=\langle W\#I,W\rangle=-\lVert W\rVert^2$ is correct. The vacuity conclusion follows: $t/2+(1-t/2)-1=0$, with $\sum_{a<b}R_{ab}=1-t/2$ itself an identity.

*One notational hazard.* [target.md:31](findings/target.md#L31) writes the right-hand side as $\lambda\operatorname{tr}M$. The quantity that actually vanishes is $\sum_{a<b}K_{ab}$, which is the $\Lambda^2$ trace of $W$ and vanishes by **Ricci-flatness**, not the $n\times n$ trace of $M$, which vanishes by hollowness. Elsewhere in the record $M$ is uniformly the $n\times n$ matrix, so the sentence reads as if hollowness were the reason. Right answer, wrong stated reason.

## G, true, tautological, and already in closed form one file over

The table is correct but it measures a consequence of an inequality the record already has. At any critical point, $\operatorname{tr}K=0$ and $\sum\mu_a^2=t=2-2\sum R$, so

$$\mu_{\max}(K)\ \le\ \sqrt{\tfrac{n-1}{n}\,t}\ \le\ \sqrt t .$$

Whenever $\lambda^2>t$, i.e. $\sum R>1-\lambda^2/2$, **every** eigenvalue is below $\lambda$, so every positive one lies in $(0,\lambda)$ and the statement fails totally, automatically, with no eigenvalue computation and no census. That threshold is $\approx0.25$ at the record's $\lambda$, against measured $\sum R=0.92$–$0.97$ at the non-diagonal points. This is written out verbatim at [target.md:48](findings/target.md#L48). The "500 of 500 random frames" result is the same fact once more: $t$ is frame-dependent and only reaches $2$ in a diagonalising frame.

So on brief item 6: the total failure is **not** an artefact of the symmetric catalogue, it is forced at any critical point whose off-diagonal mass exceeds $1-\lambda^2/2$, symmetric or not. But neither is it "as badly as it can" in any informative sense; the phrase suggests a discovered extremity where there is an inevitability. **The real open question the table hides is the complement:** a *partial* failure needs $t>\lambda^2$, i.e. a critical point at least $\sim76\%$ coordinate-diagonal by $\Lambda^2$ mass. Whether any non-diagonal critical point is that close to the locus is untested, and it is the only regime in which the census could have said something.

## H, true, and the record understates it twice

$\theta_0(n)^2=2(n-1)(n-2)/n^2$, so

$$\frac{2}{\theta_0(n)^2}=\frac{n^2}{(n-1)(n-2)},$$

which is $1.8$ at $n=6$ and $1.309$ at $n=12$ (reproducing both numbers the record quotes) and is $<2$ for every $n>3+\sqrt5$, hence for every $n\ge6$. **So $r=1$ at $\lambda=\theta_0(n)$ at every $n\ge6$, not only at $n=12$**, and the "checked across eight products, $2/\lambda^2$ running $1.31$–$1.80$" is a check of a closed form.

The contrapositive is worth more than the corollary and is not stated. On the diagonal locus $t=2$ exactly, so $r\ge2$ forces $2\lambda^2\le2$, i.e. $\lambda\le1$. Since $\theta_0(6)=1.054093>1$ and $\theta_0(n)$ increases to $\sqrt2$:

> **At every $n\ge6$, a diagonal critical point with two or more positive eigenvalues of $K$ has $\theta\le1<\theta_0(n)$. Any diagonal critical point with $\theta>1$ (in particular any competitor for the maximum), has exactly one positive eigenvalue.**

That is an unconditional reduction of B1 on the diagonal locus to the $r=1$ case, and it lands where [diagonal-half.md:224](findings/diagonal-half.md#L224) needs it: the spectral cap $T_{\max}$ is attained only at "one large positive against $n-2$ equal negatives", which has $r=1$, so the branch that must be excluded is now excluded by a two-line argument instead of by the unproved trade-off $E-E_0\le T_{\max}-T$.

## Literature check

No hit for the combined statement, and I do not think one exists. The two halves are textbook and should be cited as such rather than presented as a naming discovery:

1. **A weighted Laplacian with non-negative weights is PSD.** Godsil–Royle, *Algebraic Graph Theory*, Lemma L13.1.1 ($L=NN^{\mathsf T}$ for the oriented incidence matrix $N$); Fiedler, *Algebraic connectivity of graphs*, Czech. Math. J. **23** (1973) 298–305, §1. Restated in the lecture notes surfaced by the search, [Gallier, Chapter 17](https://www.cis.upenn.edu/~cis5150/cis515-14-graphlap.pdf) and [MIT 18.409 notes](https://ocw.mit.edu/courses/18-409-topics-in-theoretical-computer-science-an-algorithmists-toolkit-fall-2009/7c5d4c779c64e9ed3a5783a80b7eb0a5_MIT18_409F09_scribe2.pdf).
2. **$p(K)\succeq0\iff p\ge0$ on $\mathrm{spec}(K)$** for symmetric $K$, the spectral theorem, so $K^2-\lambda K\succeq0\iff$ no eigenvalue in $(0,\lambda)$. Horn–Johnson, *Matrix Analysis*, §4.1.
3. **The one place where a named theorem genuinely applies** is the record's own association-scheme section, where $M^{\circ2}=\theta M-M^2+\tfrac2nI$ puts $M$'s minimal polynomial at degree $\le3$: Bose–Mesner, and [Seidel's introduction to association schemes](https://www.maths.tcd.ie/EMIS/journals/SLC/opapers/s26seidel.pdf). That is already cited at [diagonal-half.md:201](findings/diagonal-half.md#L201) and it is cited correctly.

One free observation the record misses. A hollow symmetric $K$ with $K\mathbf1=0$ **is itself** a weighted Laplacian, for the signed weights $w_{ab}=-K_{ab}$: $L(w)_{aa}=\sum_b w_{ab}=0=K_{aa}$ and $L(w)_{ab}=-w_{ab}=K_{ab}$. So the object being squared is a signed-graph Laplacian and $K^2-\lambda K$ is an unsigned one, which is exactly why the negative-edge and triangle-free language of [diagonal-half.md:19](findings/diagonal-half.md#L19) is the natural vocabulary rather than a coincidence.

---

## The single most load-bearing defect

**[diagonal-half.md:154](findings/diagonal-half.md#L154) states $K^2-\lambda K\succeq0$ as a property of the diagonal locus, and it is false there.** The $n=8$ two-block witness above is a coordinate-diagonal Weyl tensor of unit norm, row sums exactly zero, with an eigenvalue $4\delta$ strictly inside $(0,\theta)$ and $\lambda_{\min}(K^2-\theta K)<0$. The hypothesis that is doing the work is diagonality **and** criticality, as [diagonal-half.md:118](findings/diagonal-half.md#L118) correctly says one screen earlier. The commit set separated the criticality-free half of the $E$ identity from the criticality-using half and then left the section's concluding sentence unseparated, so the record now asserts both readings.

*What fixes it:* rewrite line 154 as "a property of diagonal **critical** points", and record the witness. The stakes are concrete, B1 on the diagonal locus is an optimisation over precisely the hollow, zero-row-sum matrices, and the PSD statement read as line 154 states it would be added to a relaxation as a valid inequality. It is not one.

*Runner-up, and the more expensive one to leave standing:* claims B, D and E carry no information. B and D are identities for arbitrary symmetric and arbitrary hollow symmetric matrices; E's advertised deliverable (the non-census separator of diagonal from non-diagonal criticality that plan item 1 asks for), is the tautology $R=0$, which the record already holds in the sharper form $t=2$. Marking item 1 as answered on the strength of it would close a question that is still open.
