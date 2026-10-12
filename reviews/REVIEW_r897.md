# Reviewer r897: is the Fox product closed on the Weyl module?

This round checked an argument being made, so the finding under audit is the claim recorded in [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) and in commit `20849418` that $L_e$ is not known to be an operator on $\mathcal W_n$ at all. **The claim is an over-correction and I refute it.** $\circ$ is closed on $\mathcal W_n$, the record already states it in three findings files with a source, and one of those files already calls it proved.

I read: [findings/conventions.md](../findings/conventions.md), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean), [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean), commit `20849418`, [findings/problem.md](../findings/problem.md), [findings/bounds.md](../findings/bounds.md) (Lemma L206), [findings/graded-half.md](../findings/graded-half.md), [findings/algebra.md](../findings/algebra.md), [findings/second-order.md](../findings/second-order.md), the [Fox](../references/fox-2019-nonassociative-curvature-algebra/notes.md) and [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) notes, and [run_lw_trace_identities.py](../scripts/lib/run_lw_trace_identities.py). I read no other reviewer's report or log.

I computed, in a script written from the definitions alone and importing nothing from [scripts/](../scripts/). The script sits in this session's scratchpad and its full output is appended to my log. Exact rational arithmetic throughout at $n=4$, with the normalisation anchor $\mathrm{id}^\#=(n-2)\,\mathrm{id}$ discharged exactly at $n=4,5,6$ before any $\#$ value was read off. The positive claims below are closed-form or exact-rational, and the $n=5,6,7$ figures are labelled as screens.

Log: [agent_logs/review-r897-closure.log](../agent_logs/review-r897-closure.log).

## Claim table

| # | Item | Verdict | Reason |
|---|---|---|---|
| 0 | the equivalence "$\circ$ closed $\iff$ $Q(\mathcal W_n)\subseteq\mathcal W_n$" | **CONFIRMED** | all four `IsWeyl` clauses are linear in $R$, so $\mathcal W_n$ is a subspace, and the polarisation runs both ways |
| 1 | each of the four `IsWeyl` clauses on $Q(X)$ | **ALL FOUR CONFIRMED** | skew-to-skew and symmetry by relabelling the $\#$ index formula, Bianchi by Hamilton's lemma, Ricci by Fox Lemma 5.7 and by exact arithmetic on all of $\mathcal W_4$ |
| 2 | Ricci-flatness of $Q(X)$, with the two halves separated | **CONFIRMED, AND NEITHER HALF VANISHES** | $\mathrm{Ric}(X^2)_{ab}=\tfrac12\sum_{c,k,l}X_{ackl}X_{bckl}$ is a Gram matrix, nonzero at every $X\ne0$, and $\mathrm{Ric}(X^\#)$ is its exact negative on $\mathcal W_n$ |
| 3 | first Bianchi for $Q(X)$ | **CONFIRMED FOR THE SUM, REFUTED TERMWISE** | the record's own cancellation $b(X^\#)=-b(X^2)$, with both sides nonzero at $\mathbb{CP}^3$, so the brief's expectation that the sum splits into Bianchi-free terms is right to be suspicious and the sum still closes |
| 4 | the deciding object | **NO WITNESS EXISTS AT $n=4$** | $Q(W_{S^2\times S^2})=\tfrac34W$ exactly, and all $55$ products $E_u\circ E_v$ over a basis of $\mathcal W_4$ land in $\mathcal W_4$ exactly, which is closure on the whole module |
| 5 | which reading the record uses | **THE UNPROJECTED ONE, AND IT IS ENTITLED TO IT** | no implementation projects, [run_lw_trace_identities.py](../scripts/lib/run_lw_trace_identities.py) cites Fox for closure in its own docstring, and [graded-half.md](../findings/graded-half.md) withdrew the projection caveat as vacuous on 2026-09-10 |
| 6 | what $\operatorname{tr}L_e$ would mean if closure failed | **THE $\mathcal W_n$ TRACE REPRODUCES $\kappa(n)$, THE AMBIENT ONE DOES NOT** | exactly $\operatorname{tr}(L_e^2)=7=\kappa(4)/\theta^2$ over $\mathcal W_4$ against $8$ over the $21$-dimensional ambient space, and L206 survives the compression reading anyway |
| N | **NEW, and it is the one defect I found**: the Lean `FoxClosed` does not state closure | **REFUTED AS A STATEMENT OF CLOSURE** | the existential sits under `∀ Z`, so the witness may depend on $Z$, and at $n=4$ the evaluation map $W\mapsto WZ$ is already surjective at $Z=\varphi_{01}$, making the proposition vacuous |

**One line the cycle can act on: closure holds, it is on the record with a source, so withdraw the `FoxClosed` hypothesis from the three theorem statements and replace the Lean file's prose, and if a closure proposition is kept at all, restate it with the existential above the `∀ Z` because as written it is vacuous.**

## 0. The equivalence, settled before it is used

All four clauses of `IsWeyl` are linear conditions on $R$: skew-to-skew is the vanishing of the symmetric part of $R X$ at each skew $X$, the symmetry clause is $\mathrm{inner2}(RX,Y)-\mathrm{inner2}(X,RY)=0$, `bianchi` is a sum of three matrix entries, and `Ric` is a sum of entries. So $\mathcal W_n$ is a linear subspace, which [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) already builds it as.

Then $Q(X)=X\circ X$ gives one direction: closure of $\circ$ forces $Q(\mathcal W_n)\subseteq\mathcal W_n$. And $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ gives the other: for $X,Y\in\mathcal W_n$ the sum $X+Y$ lies in $\mathcal W_n$ because it is a subspace, so all three terms on the right lie in $\mathcal W_n$, and so does the combination. **The two statements are equivalent, with no hypothesis beyond linearity of the four clauses.** I use the $Q$ form below and my computation checks the $\circ$ form directly anyway.

## 1. The four clauses, one at a time

**Skew to skew: no finding.** In the matrix model a curvature operator is an $N\times N$ matrix on the pair basis, $N=\binom n2$, and it acts on $\Lambda^2$ by construction. Reading the Lean model instead, where $R$ is a map on all of `Matrix ι ι ℝ`: `compOp R X = R (R X)` sends skew to skew whenever $R$ does, and `sharpOp` returns a linear combination of the $\varphi_{ij}$, which is skew for every input. So the clause holds for both halves of $Q$ separately and for the sum.

**Symmetry: no finding, and it costs one relabelling.** $X^2$ is symmetric because $X$ is. For $\#$, the index formula is $(X^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\epsilon\zeta}c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}X_{\gamma\epsilon}X_{\delta\zeta}$. Swapping the names $\gamma\leftrightarrow\epsilon$ and $\delta\leftrightarrow\zeta$ in $(X^\#)_{\beta\alpha}$ returns $\tfrac12\sum c_{\beta\epsilon\zeta}c_{\alpha\gamma\delta}X_{\epsilon\gamma}X_{\zeta\delta}$, which is $(X^\#)_{\alpha\beta}$ once $X=X^{\mathsf T}$ is used. **Confirmed explicitly at every object I computed: `sym_defect` is exactly $0$ at $Q(W_{S^2\times S^2})$ and at all $55$ basis products.**

**First Bianchi: no finding for the sum.** This is Hamilton's lemma, the fact that makes the ODE $\dot R=R^2+R^\#$ well posed on $S^2_B$ at all. The record holds it through the [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md), which state it in exactly the form needed and flag the trap: *"the ODE is stated on $S^2_B$, so $R\mapsto R^2+R^\#$ carries $S^2_B$ into itself"*, and *"the paper makes no such claim for $R^\#$ on its own, and it is false"*. See section 3.

**Ricci-flatness: no finding, and it is the only clause that needed a computation.** Section 2.

## 2. Ricci-flatness, with the two halves separated as the brief asks

**$\mathrm{Ric}(X^2)$ in closed form, and it is a Gram matrix.** With $X_{ijkl}=\langle X\varphi_{ij},\varphi_{kl}\rangle$ and $\mathrm{Ric}(S)_{ab}=\sum_c S_{acbc}$, insert the resolution of identity over the orthonormal pair basis:

$$\mathrm{Ric}(X^2)_{ab}=\sum_c\langle X^2\varphi_{ac},\varphi_{bc}\rangle=\sum_c\sum_{k<l}X_{ackl}X_{klbc}=\tfrac12\sum_{c,k,l}X_{ackl}\,X_{bckl}.$$

**So $\mathrm{Ric}(X^2)=G(X)$ is the Gram matrix of the $n$ slices $X_{a\cdot\cdot\cdot}$, positive semidefinite, with $G_{aa}=\tfrac12\sum_{c,k,l}X_{ackl}^2$ strictly positive at every $X$ whose $a$-th slice is nonzero.** It is therefore never zero for $X\ne0$, and its trace is pinned: $\operatorname{tr}G=\tfrac12\cdot4\lVert X\rVert^2=2\lVert X\rVert^2$, using $\lVert X\rVert^2=\tfrac14\sum_{ijkl}X_{ijkl}^2$. **Ricci-flatness of $X$ buys nothing here**, and first Bianchi buys nothing either: the expression is a sum of squares on the diagonal. This is the honest content of the cycle's worry, and it is correct as far as it goes.

**$\mathrm{Ric}(X^\#)$ is its exact negative on $\mathcal W_n$, which is the whole of the cancellation.** Verified exactly at $n=4$ on five objects, in `fractions.Fraction`:

| $X$ | $\mathrm{Ric}(X^2)$ diagonal | $\mathrm{Ric}(X^\#)$ diagonal | $\mathrm{Ric}(X^2)=G(X)$ | sum zero |
|---|---|---|---|---|
| $W_{S^2\times S^2}$, $\lVert W\rVert^2=\tfrac34$ | $\tfrac38,\tfrac38,\tfrac38,\tfrac38$ | $-\tfrac38$ four times | exact | exact |
| three basis elements of $\mathcal W_4$ | $2,2,2,2$ | $-2$ four times | exact | exact |
| $\sum_{u=1}^{10}u\,E_u$ | $924$ four times | $-924$ four times | exact | exact |

**The trace part of this cancellation is free and the rest is not.** $\operatorname{tr}\mathrm{Ric}(S)=\sum_{a,c}S_{acac}=2\operatorname{tr}_{\Lambda^2}S$, so the diagonal sum of the table is the record's own identity $\operatorname{tr}(X^\#)=-\operatorname{tr}(X^2)$ on $\mathcal W_n$, which [bounds.md](../findings/bounds.md) and [second-order.md](../findings/second-order.md) both carry. **The full matrix statement is strictly more**, and I checked that it is not hiding behind scalarity: at $n=5$ and $n=6$, on random Weyl tensors, $\mathrm{Ric}(W^2)$ has off-diagonal entries up to $0.081$ and $0.065$ and diagonal spread $0.179$ and $0.068$ against mean $2/n$, so it is genuinely not a multiple of the identity there. *At $n=4$ it happens to be $\tfrac12\lVert X\rVert^2\,\mathrm{id}_4$ on all of $\mathcal W_4$, which is why the $n=4$ table above reads as one number per row, and that is an $n=4$ coincidence rather than the mechanism.*

**The source the record already holds for the general statement, quoted off disk.** [Fox Lemma 5.7](../references/fox-2019-nonassociative-curvature-algebra/notes.md), transcribed verbatim into the notes on 2026-09-10: $\rho(X*Y)=\tfrac12(X\hat\cdot\rho(Y)+Y\hat\cdot\rho(X))$ and $s(X*Y)=\langle\rho(X),\rho(Y)\rangle$, *"In particular, the subspace $\mathrm{MC}_W(V^*)=\ker\rho$ is a subalgebra"*. That is exactly the closure claimed missing, for the polarised product rather than for $Q$, and it kills both the trace-free Ricci component and the scalar component at once. [Böhm–Wilking eq. (6)](../references/boehm-wilking-2008-space-forms/notes.md) is the second, independent source, quoted at [problem.md](../findings/problem.md): $\mathrm{Ric}(\Phi(R))_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, zero on a Ricci-flat $R$. **Representation theory does not settle it without a computation**, because $S^2(\mathcal W_n)$ contains a copy of $S^2_0(\mathbb R^n)$ through the contraction $W_{iabc}W_{jabc}$, which is the Gram matrix above, so an equivariant obstruction is available and has to be computed away rather than argued away. That is why the literature statement is load-bearing and why I checked $\mathcal W_4$ exhaustively rather than appealing to Schur.

## 3. First Bianchi, and why the termwise reading fails while the sum closes

The brief's expectation is right: **the four-index form of $Q(X)$ is not a sum of terms each Bianchi-free.** The record's own [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) say so in the sharpest available way, that $R\#R$ alone does not preserve the Bianchi subspace and that the defect cancels against $R^2$'s, *"see the Conjecture A record for the cancellation $b(R^\#)=-b(R^2)$, both sides nonzero at $\mathbb{CP}^3$ and $\mathbb{CP}^4$"*. So the sum preserves it and neither summand does, exactly parallel to section 2's Ricci cancellation.

**Checked exactly rather than cited.** `max|Bianchi|` is exactly $0$ at $Q(W_{S^2\times S^2})$ and at all $55$ products $E_u\circ E_v$ over a basis of $\mathcal W_4$. At $n=5,6,7$ the screen gives $2.8\times10^{-17}$, $2.4\times10^{-17}$ and $2.7\times10^{-17}$ on random unit Weyl tensors, against $\lVert Q(W)\rVert$ of $0.83$, $0.57$ and $0.49$.

*One caveat about $n=4$ that I state so the exact work is not overread: at $n=4$ the Bianchi condition on a symmetric operator is the single scalar $\langle R,\star\rangle=0$, so $n=4$ exercises the Bianchi clause thinly. The Ricci clause at $n=4$ is ten conditions and is exercised fully. Hamilton's lemma is the general-$n$ input, and it is a literature fact the record holds, not something my arithmetic establishes.*

## 4. The deciding object, and there is no witness

**The simplest Weyl tensor the record names, $S^2\times S^2$ at $n=4$, in the pair basis over $\{(01),(02),(03),(12),(13),(23)\}$ with blocks $\{0,1\}$ and $\{2,3\}$:**

$$W=\operatorname{diag}\big(\tfrac12,-\tfrac14,-\tfrac14,-\tfrac14,-\tfrac14,\tfrac12\big),\qquad \lVert W\rVert^2=\tfrac34 .$$

It is Weyl exactly: symmetry defect $0$, $\max\lvert\mathrm{Ric}\rvert=0$, $\max\lvert\mathrm{Bianchi}\rvert=0$, $\operatorname{tr}=0$. And

$$Q(W)=\operatorname{diag}\big(\tfrac38,-\tfrac3{16},-\tfrac3{16},-\tfrac3{16},-\tfrac3{16},\tfrac38\big)=\tfrac34\,W,$$

exactly, with symmetry defect $0$, $\max\lvert\mathrm{Ric}\rvert=0$, $\max\lvert\mathrm{Bianchi}\rvert=0$ and $\operatorname{tr}=0$. **So the deciding object satisfies all four clauses, and it does so by being an eigenvector**: $P(W)=\tfrac9{16}$ and $\theta^2=P(W)^2/\lVert W\rVert^6=\tfrac34=\theta_0(4)^2$, the programme's own value at the balanced product.

**That single point is weak evidence on its own, because an eigenvector of $Q$ is trivially in $\mathcal W_n$ once $W$ is, so I did the whole module.** A basis of $\mathcal W_4$ built from the linear conditions alone has $\dim=10$, matching $n(n+1)(n+2)(n-3)/12$. **All $55$ products $E_u\circ E_v$, $u\le v$, satisfy all four clauses exactly, with zero failures**, and each was additionally reconstructed exactly as a rational combination of the basis. Since $\mathcal W_4$ is a linear subspace and $\circ$ is bilinear, **closure on a basis is closure on the whole of $\mathcal W_4$. No witness exists at $n=4$, and none can.**

**The structural reason, at $n=4$, in one line.** Every element of $\mathcal W_4$ commutes with the Hodge star (checked exactly, $\star^2=\mathrm{id}$ and $[E_u,\star]=0$ for all ten), so $\mathcal W_4=S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$, and $Q$ acts blockwise by $A_\pm\mapsto3A_\pm^2-\operatorname{tr}(A_\pm^2)\,\mathrm{id}_3$, whose blocks are again trace-free because $\operatorname{tr}(3A^2-\operatorname{tr}(A^2)\mathrm{id}_3)=0$. *That is a closed-form proof of closure at $n=4$ covering the whole module, checkable by hand, and the record already carries the blockwise formula at [r851](REVIEW_r851.md).*

**Screens at higher $n$, reported as screens.** Random unit Weyl tensors at $n=5,6,7$ with $\dim\mathcal W_n=35,84,168$ matching the formula: $\max\lvert\mathrm{Ric}(Q(W))\rvert\le9.8\times10^{-17}$ and $\max\lvert\mathrm{Bianchi}(Q(W))\rvert\le2.8\times10^{-17}$. These agree with the closed-form conclusion and establish nothing on their own.

## 5. The projection reading, and it is the writing that is wrong rather than the mathematics

**The record uses the UNPROJECTED product, in prose and in code, and it is entitled to.** What I found, by grep over [findings/](../findings/), [reviews/](../reviews/) and [scripts/](../scripts/):

- **No implementation projects.** [run_lw_trace_identities.py](../scripts/lib/run_lw_trace_identities.py) builds $L_W$ as the $D\times D$ matrix $E\,\mathrm{Qform}(W)\,E^{\mathsf T}$ over an orthonormal basis of $\mathcal W_n$, and its own docstring says why that is legitimate rather than a compression: *"THAT $L_W$ MAPS $\mathcal W_n$ TO ITSELF AT ALL is not an extra assumption: Fox … shows the Weyl (Ricci-flat) tensors form a closed nonassociative subalgebra under $B(\cdot,\cdot)$"*, adding that it revalidates closure numerically rather than trusting the citation.
- **The projection caveat was raised on the record and explicitly withdrawn.** [graded-half.md](../findings/graded-half.md) carries *"That caveat is VACUOUS and is withdrawn. $Q$ maps $\mathcal W_n$ into $\mathcal W_n$"*, with the Böhm–Wilking route and Hamilton's Bianchi preservation named, dated to 2026-09-10, and with the corollary that a projected-critical residual $N=Q(W)-\theta W$ lies in $\mathcal W_n$ and in $\mathcal W_n^\perp$, hence vanishes. **That is the same withdrawal the Lean file has now reintroduced as an open question.**
- **The claim's premise, that the record states closure nowhere, is false in three files.** [conventions.md](../findings/conventions.md) tables $Q(W)$ as *"sending $\mathcal W_n$ to itself"* and, under the letter $\Phi$, names the reason. [problem.md](../findings/problem.md) carries it as a literature-input row: *"BW08 eq. (6) … so $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$: $\Phi$ preserves Weyl"*. [bounds.md](../findings/bounds.md) states in bold that it is *"not a parenthetical: proved on the record at problem.md … and the whole deficiency section stands on it"*. Seven earlier reviewers reached the same verdict independently: [r90](REVIEW_r90.md), [r121](REVIEW_r121.md), [r322](REVIEW_r322.md), [r488](REVIEW_r488.md), [r697](REVIEW_r697.md), [r731](REVIEW_r731.md) and [r851](REVIEW_r851.md), with [r731](REVIEW_r731.md) naming Fox's Lemma 5.7 by number.

**So the defect is in the writing of one Lean file, not in the mathematics, and not in the record's prose either.** The grep that would have caught it was not run before the claim was committed, which is the failure mode [findings/INDEX.md](../findings/INDEX.md) instruction 3 exists to prevent and which [graded-half.md](../findings/graded-half.md) already booked once under the same heading.

## 6. What $\operatorname{tr}L_e$ means, and which trace gives $\kappa(n)$

**The $\mathcal W_n$ trace reproduces $\kappa(n)$ exactly and the ambient trace does not.** At the $S^2\times S^2$ point, with $e=W/\theta=\tfrac43W$ (rational, and $Q(e)=e$ exactly, checked):

| trace, taken over | dimension | $\operatorname{tr}L_e$ | $\operatorname{tr}(L_e^2)$ | matches $\kappa(4)/\theta^2=7$ |
|---|---|---|---|---|
| $\mathcal W_4$ | $10$ | $0$ exactly | $7$ exactly | yes |
| all symmetric operators on $\Lambda^2\mathbb R^4$ | $21$ | $0$ exactly | $8$ exactly | no |

with $\operatorname{spec}L_e=\{1^{(2)},\tfrac12^{(4)},(-1)^{(4)}\}$ exactly, reproducing [Lemma L206](../findings/bounds.md)'s recorded spectrum at that point, and $\theta^2=\tfrac34$. **So $\kappa(n)$ is a statement about the $\mathcal W_n$ trace**, which is the reading [L206](../findings/bounds.md), [algebra.md](../findings/algebra.md) and [second-order.md](../findings/second-order.md) all take. The screen at higher $n$ gives $\operatorname{tr}(L_W^2)/\lVert W\rVert^2$ equal to $9.00000000$, $13.75000000$ and $19.50000000$ at $n=5,6,7$ against $(2n-1)(n-1)/4=9$, $13.75$ and $19.5$.

**And here is the part that sharpens the cycle's own worry into something smaller than it claimed.** Had closure failed, the natural object would be the compression $\Pi_{\mathcal W}(e\circ\cdot)$ on $\mathcal W_n$, and **its matrix in an orthonormal basis of $\mathcal W_n$ is literally the same matrix $[\langle E_u,e\circ E_v\rangle]$**, because the projection only removes components orthogonal to every $E_u$. So both traces, self-adjointness (the trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ stays totally symmetric under compression), and even the eigenvalue-$1$ clause $L_ee=e$ (which needs only projected criticality) would be unchanged. **L206's two hypotheses and its three-line derivation are therefore robust to the reading, and would have been statements about the compression rather than about nothing.** What closure actually buys is elsewhere: that criticality is $Q(W)=\theta W$ as an operator equation with no projection, which is what licenses applying $\mathring{\ }$ to it and reading it entrywise, the step [r121](REVIEW_r121.md) and [r322](REVIEW_r322.md) both flagged. **So the commit's "not well-posed" is wrong twice over: closure holds, and even without it the two identities would have been well-posed.**

## N. The one defect I did find, in the Lean statement itself

[WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) writes

```
def FoxClosed (ι) : Prop :=
  ∀ X Y : CurvLin ι, X ∈ weylModule ι → Y ∈ weylModule ι →
    ∀ Z : Matrix ι ι ℝ, ∃ W : CurvLin ι, W ∈ weylModule ι ∧ foxProd … Z = W Z
```

**The existential sits under the `∀ Z`, so the witness $W$ may depend on $Z$.** That is not the statement that the product is a Weyl operator, which would need `∃ W, W ∈ weylModule ι ∧ ∀ Z, …`. As written it says only that at each $Z$ separately the product's value is attained by some Weyl operator, and **that is vacuous at $n=4$**: the evaluation map $W\mapsto WZ$ from $\mathcal W_4$ to $\Lambda^2\mathbb R^4$ has rank $6$ of $6$ at $Z=\varphi_{01}$, so any value whatsoever is attained there. At the self-dual $Z=\varphi_{01}+\varphi_{23}$ the rank is $3$, and the image is exactly the $\Lambda^2_+$ where the true product lands, so that $Z$ is satisfiable too. **A second reason the shape is weak: `IsWeyl` constrains $R$ only on skew inputs, so an element of `weylModule` is unconstrained on the symmetric complement and the freedom at non-skew $Z$ is larger still.**

So the three theorems in that file take a hypothesis that is true and empty, which is worse than taking a false one, because it will discharge without supplying anything. **If a closure proposition is kept, the quantifier order has to be fixed.** Better, since closure is a theorem: drop the hypothesis and prove `Qop`-closure from the two components, with Hamilton's Bianchi lemma and Fox's Lemma 5.7 as the named literature inputs, exactly as [problem.md](../findings/problem.md)'s input table already records them.

## 7. What would break this verdict, and what I did to look for one

**What would break it: a single $X\in\mathcal W_n$ at some $n\ge5$ with $\mathrm{Ric}(Q(X))\ne0$ or $\mathrm{Alt}(Q(X))\ne0$, exhibited in closed form.** My exact work is at $n=4$, and $n=4$ is special in three ways I have named: $\mathcal W_4$ splits under the Hodge star so $Q$ acts by a blockwise closed form, the Bianchi condition there is a single scalar, and $\mathrm{Ric}(X^2)$ is a multiple of the identity on all of $\mathcal W_4$. **None of those three holds at $n\ge5$**, so a reader entitled to be sceptical of $n=4$ alone is entitled to ask for the general argument, and the general argument is the literature's, not mine.

**What I did to look for one.** I checked whether representation theory forces the conclusion and found that it does not: $S^2(\mathcal W_n)$ contains $S^2_0(\mathbb R^n)$ through precisely the Gram contraction of section 2, so a genuine equivariant obstruction is available and the vanishing is a computation. That is the place a counterexample would live, and it is where Fox's Lemma 5.7 and Böhm–Wilking's eq. (6) each do the work. I then screened $n=5,6,7$ on random Weyl tensors and found the two residuals at $10^{-17}$, which refutes nothing but would have found a generic failure. I did not run a search for a witness, and a bounded search is not what would settle it: the statement is a polynomial identity, so either the two published derivations are right or one of them has an error, and **the item worth one cycle is transcribing Fox's proof of Lemma 5.7 from his (5.4) and Theorem 5.4, or deriving $\mathrm{Ric}(X^\#)=-G(X)$ on $\mathcal W_n$ directly, so that the record owns the general-$n$ statement instead of quoting it.** *That is a derivation, not a run.*

**What I did not check.** Whether [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean)'s `weylTrace` agrees with the $\mathcal W_n$ trace I computed, beyond reading its definition as `LinearMap.trace` on the submodule, which it is. And I did not verify the record's $\kappa(n)$ closed form beyond $n=7$.

## Verdict

**REFUTED. The claim recorded in commit `20849418` is a false alarm and should be withdrawn.**

$\circ$ is closed on $\mathcal W_n$. At $n=4$ this is exact and complete: every product of two elements of a basis of $\mathcal W_4$ lies in $\mathcal W_4$, by rational arithmetic, and the blockwise form $A_\pm\mapsto3A_\pm^2-\operatorname{tr}(A_\pm^2)\mathrm{id}$ proves it in closed form. At general $n$ it is two literature facts the record already holds and cites in three files, Hamilton's Bianchi-preservation lemma and Fox's Lemma 5.7, the second transcribed verbatim onto disk two days before the claim was written. **$L_e$ is an operator on $\mathcal W_n$, the two trace identities were well-posed, and the debt the record was carrying, that they are unproved, is the correct one.**

**The claim is not worthless.** Its diagnosis of the mechanism is right: neither $X^2$ nor $X^\#$ preserves Ricci-flatness or first Bianchi on its own, the Ricci obstruction is a nonzero Gram matrix at every $X\ne0$, and only the sum cancels it. **The error is the inference from "neither half survives" to "the sum is not known to", when the record already says in bold that the sum does and names the source.**

**What to change.** Retract the finding from [lean/INDEX.md](../lean/INDEX.md) and from the commit's standing, rewrite [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean)'s two prose blocks, and remove the `hclosed` binder from the three theorems, citing [problem.md](../findings/problem.md)'s input table. If closure is to be stated in Lean as an obligation to prove rather than assumed, **state it as `∃ W, W ∈ weylModule ι ∧ ∀ Z, …`**, since the current order makes the proposition vacuous.
