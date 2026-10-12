# r832: Gate 2 on L194, that L183's distinct branch is empty, and on L184, that the coincident case is empty at $\dim V=6$

*Cold brief. I was handed the two blocks and the givens, and read [findings/conventions.md](../findings/conventions.md), [findings/diagonal-half.md](../findings/diagonal-half.md) (L178 through L194), [findings/INDEX-results.md](../findings/INDEX-results.md), [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean), [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand and every constant is exact. One machine action was run, a screen on objects I constructed for the purpose, reported as a screen in section 9 and never as evidence for a positive claim. Every counterexample below is in closed form. Log: [agent_logs/g2-rank3-r832.log](../agent_logs/g2-rank3-r832.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | $\lVert\Phi(\omega)\rVert^2=\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2$, with Frobenius on $S^2$ | **CONFIRMED**, and the Frobenius reading is **LOAD-BEARING AND TABLED NOWHERE**. Under the record's own half-trace habit the sum is $1$ at one unit form and $\tfrac53$ at another |
| 2 | $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$, every $n$ | **CONFIRMED**, derived from the singular-value normal form in four lines. Constant $2$ correct. The norm must be $\lVert\cdot\rVert_\perp$: under the record's $\tfrac14\sum_{ijkl}$ rule the same two unit forms give $2$ and $\tfrac{26}3$ |
| 3 | Three collinear points of equal norm are not distinct, and all three coincide | **CONFIRMED.** The quadratic is reproduced exactly. The proof's own route reaches all-coincide from L183's disjunction alone, while the elementary-step box's route needs L183's exactly-two note, and has it |
| 4 | L183's joint collinearity survives changing the inner product | **CONFIRMED.** L183 fixes no inner product at all: its proof produces $\lambda_1(\Phi_1-\Phi_3)=-\lambda_2(\Phi_2-\Phi_3)$ in the direct sum, which is affine. **Jointness is load-bearing** and a factorwise reading falsifies L194 |
| 5 | Padded $W_{\mathbb{CP}^2}$ sits in the coincident branch, and nothing in the catalogue sits in the distinct branch | **BOTH CONFIRMED.** $\omega^2=-\tfrac12\mathrm{Id}_4$ and $\omega\wedge\omega=\mathrm{vol}_4$ hold across the whole of $\Lambda^+\mathbb R^4$, derived below and screened. **No catalogued object is in the distinct branch**, and none can be |
| 6 | L194 is stated at every $n$ | **CONFIRMED analytically at every $n$.** No step carries a dimension. **The Lean cover is $\dim=4$ and $\dim=6$ only**, so the standfirst's "typed with no gap" holds of the elementary step and not of the identity |
| 7a | L184 case 1, the $c_j^2$ pairwise distinct | **COMPLETE.** $s_{ij}=\eta_is_{1j}$ verified at $j=1$ and $j\ge2$ separately. Uses $\dim V=6$ only to have three planes, and transfers to every even $\dim V$ on the pairwise-distinct stratum, exactly as the block claims |
| 7b | L184 case 2, $A=cI_6$ | **COMPLETE.** $\star_V(J\wedge J)=2\epsilon_JJ$ rederived, constant and all three star signs $+$. **Linearity of $\star_V$ closes it and injectivity is inert**, which the case body still credits. $\dim V=6$ used correctly and is sharp |
| 7c | L184 case 3, spectrum $(a,a,b)$ | **COMPLETE**, and its short route is the one the block found second: $\tau_iJ_i$ all equal gives $\omega_i=\tau_i\tau_1\omega_1$ outright, whence $\lvert\langle\omega_1,\omega_2\rangle\rvert=1$. The printed $4a=-2b$ ending is sound but redundant. $\dim V=6$ used correctly via the $4+2$ split |
| 8 | L184's standing debts | **ALL FOUR DISCHARGED, plus $\epsilon_J$'s well-definedness.** (iv) and the $U(3)$ fact are load-bearing for case 2 and both are correct. **One debt is live and it is Lean-only**, named by [I40](../plan.md) |
| 9 | L194 with L184 empties rank three at $\dim V=6$ | **COMPOSITION CONFIRMED**, exactly and with no slack. **But L184's own entailment box and [INDEX-results.md](../findings/INDEX-results.md) row 184 both still say the distinct-and-collinear case is what survives at $\dim V=6$**, which L194 negates fifteen lines above |
| 10 | Falsifiers | **NONE FOUND.** Named, and the nearest live configurations exhibited in closed form: r809's near-miss pair, and the $\dim V=4$ family that makes L184's six sharp |

**One line.** *Both lemmas are sound and I would fold both: L194's sphere step is right, its constant is right, and the norm it needs is the one it names, while L184's three cases are each complete and the trichotomy exhausts. Two things need editing rather than rederiving: L184's entailment box and its ledger row still assert the branch L194 has since emptied, and the Frobenius inner product on $S^2(\mathbb R^n)$ that L194's identity requires appears in no conventions row, while the two rules the record does table for the neighbouring space both break the identity.*

## 0. Conventions, fixed once

- **On $\Lambda^2$**, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so a unit $2$-form has $\operatorname{tr}(\omega\omega^{\mathsf T})=2$ and $\operatorname{tr}(\omega^2)=-2$. This is [conventions.md](../findings/conventions.md) line 29 and `inner2` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean). Hence $\operatorname{tr}(\omega_1\omega_2)=-2\langle\omega_1,\omega_2\rangle$ and orthogonality of two $2$-forms is $\operatorname{tr}(\omega_1\omega_2)=0$.
- **A $2$-form is read both as a skew matrix and as $\sum_{i<j}\omega_{ij}e_i\wedge e_j$**, the two agreeing entrywise, and its support is $\operatorname{im}\omega=(\ker\omega)^\perp$.
- **The wedge coefficient**, which the whole of section 2 turns on: $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$ at $i<j<k<l$. [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) carries this as $2\,\mathtt{w4}$, and its identity is written $\operatorname{tr}(\omega^4)+4\sum \mathtt{w4}^2=2\langle\omega,\omega\rangle^2$, which is the same statement.
- **$\lVert\cdot\rVert_\perp$ on $\Lambda^4$** is $\sum_{i<j<k<l}$ of those coefficients squared, [conventions.md](../findings/conventions.md) line 124, six times smaller than the $\tfrac14\sum_{ijkl}$ rule of line 125.
- **On $S^2(\mathbb R^n)$**, Frobenius, $\lVert S\rVert^2=\operatorname{tr}(S^{\mathsf T}S)$. **L194's text names this and no conventions row carries it**, and section 1 shows the identity depends on it.
- **$A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$**, positive semidefinite of trace $2\lVert\omega_i\rVert^2$, and $\varepsilon_j$ is a unit area form of a plane, with $\varepsilon_j\wedge\varepsilon_j=0$ and $\varepsilon_j^2=-\mathrm{Id}$ on that plane.

## 0.1 Hypothesis inventory

**L194 consumes** the single equation $\sum_i\lambda_i\Phi(\omega_i)=0$ (L180 and L179, packaged by L183), every $\lambda_i\ne0$, and the **equality of the three norms $\langle\omega_i,\omega_i\rangle$**, which unit norm supplies. It also consumes an inner product on $S^2\oplus\Lambda^4$ in which the identity holds.

**L194 states and does not use** mutual orthogonality, and does not use $n$. So the true scope is: *any three $2$-forms of equal nonzero norm, carrying weights that are nowhere zero and annihilate the triple, have coinciding images*, which is exactly the scope [L183](../findings/diagonal-half.md)'s own box establishes for L183. Dropping the equal norms breaks L194 the same way it breaks L183, and by r780's same witness: rescaling $\omega_3\mapsto2\omega_3$ moves $\Phi_3$ to $4P$ while $\Phi_1=\Phi_2=P$, which is collinear, distinct-in-two, and not on one sphere.

**L184 consumes** the common square (which delivers the common support, the commuting of every $\omega_i$ with $A$, and the trichotomy), the common self-wedge (all three cases), $\dim V=6$ (all three cases, differently), and orthogonality once per case at the end. **It uses unit norm decoratively only**: $\operatorname{tr}A=2$ pins $c=\tfrac13$ in case 2 and $4a+2b=2$ in case 3, and neither number enters a contradiction.

**L184 derives rather than assumes** that each $\omega_i$ is supported on $V$: if $v\perp V$ then $\omega_i^2v=-Av=0$, so $\lVert\omega_iv\rVert^2=-\langle v,\omega_i^2v\rangle=0$. So the hypothesis "common six-dimensional support" is doing one job, fixing the dimension at six.

## 1. The sphere step, and the convention it needs

**The $S^2$ half is correct.** $\omega^2$ is symmetric at skew $\omega$, so $\operatorname{tr}((\omega^2)^{\mathsf T}\omega^2)=\operatorname{tr}(\omega^4)$, and the Frobenius square of the first component is $\operatorname{tr}(\omega^4)$ exactly. **The $\Lambda^4$ half is correct** under $\lVert\cdot\rVert_\perp$ by definition. So $\lVert\Phi(\omega)\rVert^2$ is the identity's left side in the inner product that is Frobenius on $S^2$ and $\lVert\cdot\rVert_\perp$ on $\Lambda^4$, and that hybrid is a genuine inner product, being a direct sum of two positive definite forms. **The argument needs nothing more of it**, since collinearity is affine.

**And the record's two neighbouring rules each break it.** Take two unit forms on $\mathbb R^6$, in singular values $\sigma=(1,0,0)$ and $\sigma'=(1,1,1)/\sqrt3$. Section 2 gives $\operatorname{tr}(\omega^4)=2\sum\sigma_j^4$ and $\lVert\omega\wedge\omega\rVert_\perp^2=2[(\sum\sigma_j^2)^2-\sum\sigma_j^4]$, so

| reading | at $\sigma$ | at $\sigma'$ |
|---|---|---|
| Frobenius on $S^2$, $\lVert\cdot\rVert_\perp$ on $\Lambda^4$ | $2+0=2$ | $\tfrac23+\tfrac43=2$ |
| **half-trace on $S^2$**, $\lVert\cdot\rVert_\perp$ on $\Lambda^4$ | $1+0=1$ | $\tfrac13+\tfrac43=\tfrac53$ |
| Frobenius on $S^2$, **$\tfrac14\sum_{ijkl}$ on $\Lambda^4$** | $2+0=2$ | $\tfrac23+8=\tfrac{26}3$ |

**Row two is the finding.** [conventions.md](../findings/conventions.md) warns at line 124 about the $\Lambda^4$ mismatch of row three and carries no row at all for $S^2(\mathbb R^n)$ as $\Phi$'s target, while lines 85 and 88 to 91 install the half-trace at the $\Lambda^2$ level as the record's habit and record that two reviewers once disagreed on a value for exactly this reason. **A reader carrying that habit across to $\Phi$'s first component gets a non-constant left side and L194 dissolves.** L194's own text says "Frobenius", so the lemma is unambiguous and this is a convention debt rather than an error: **the row belongs in [conventions.md](../findings/conventions.md) beside line 124**, and it is the same kind of debt line 124 was written to discharge.

## 2. The identity at every $n$, from the normal form

**Four lines, as the record says.** Every skew $\omega$ on $\mathbb R^n$ has an orthonormal frame in which $\omega=\sum_{j=1}^{m}\sigma_j\,e_{2j-1}\wedge e_{2j}$ with $\sigma_j\ge0$ and $m=\lfloor n/2\rfloor$, the remaining coordinate contributing nothing at odd $n$.

1. $\langle\omega,\omega\rangle=\tfrac12\operatorname{tr}(\omega\omega^{\mathsf T})=\tfrac12\cdot2\sum_j\sigma_j^2=\sum_j\sigma_j^2$.
2. $\omega$ has eigenvalues $\pm\mathrm i\sigma_j$, so $\omega^4$ has $\sigma_j^4$ twice each and $\operatorname{tr}(\omega^4)=2\sum_j\sigma_j^4$.
3. $\omega\wedge\omega=\sum_{j,k}\sigma_j\sigma_k\,\varepsilon_j\wedge\varepsilon_k$. The diagonal terms vanish, $2$-forms commute under $\wedge$, so each index set $\{2j-1,2j,2k-1,2k\}$ with $j<k$ carries the single coefficient $2\sigma_j\sigma_k$ and the sets are distinct. Hence $\lVert\omega\wedge\omega\rVert_\perp^2=\sum_{j<k}4\sigma_j^2\sigma_k^2=2\big[(\sum_j\sigma_j^2)^2-\sum_j\sigma_j^4\big]$.
4. Adding: $2\sum\sigma_j^4+2(\sum\sigma_j^2)^2-2\sum\sigma_j^4=2\langle\omega,\omega\rangle^2$.

**So the constant is $2$, the norm is $\lVert\cdot\rVert_\perp$, and no step sees $n$.** Step 3 is where the norm enters and it is the only place: replacing $\lVert\cdot\rVert_\perp$ by any other scaling multiplies only the second summand and destroys the cancellation of $\sum\sigma_j^4$, which is precisely why a mixed statement is false rather than rescaled. **The odd case is not special**: at $n=3$, $m=1$, the wedge is zero and the identity reads $2\sigma_1^4=2\sigma_1^4$.

**The record's own gloss checks out.** Line 124's "at singular values with $\sum\sigma_i^2=1$ the first term is $2\sum\sigma_i^4$ and the second $2(1-\sum\sigma_i^4)$" is steps 2 and 3 at unit norm.

## 3. Line meets sphere, and the passage to all three

**The quadratic reproduces exactly.** With $p(s)=\Phi_3+s(\Phi_2-\Phi_3)$ and $N=\lVert\Phi_3\rVert^2$,
$$\lVert p(s)\rVert^2=N+2s\langle\Phi_3,\Phi_2-\Phi_3\rangle+s^2\lVert\Phi_2-\Phi_3\rVert^2 .$$
$\lVert p(1)\rVert^2=N$ gives $2\langle\Phi_3,\Phi_2-\Phi_3\rangle=-\lVert\Phi_2-\Phi_3\rVert^2$, and substituting into $\lVert p(t)\rVert^2=N$ gives $-t\lVert\Phi_2-\Phi_3\rVert^2+t^2\lVert\Phi_2-\Phi_3\rVert^2=0$, that is $t(t-1)\lVert\Phi_2-\Phi_3\rVert^2=0$. **Both displayed lines of the block are right.**

**Two routes to all-coincide, and both are available.**

- *The proof's route*, which is the shorter one. On the distinct branch $\Phi_2\ne\Phi_3$, so $t\in\{0,1\}$, so $\Phi_1=\Phi_3$ or $\Phi_1=\Phi_2$, against distinctness. The branch is empty, and L183's disjunction leaves all-coincide. **This route does not need the exactly-two note.**
- *The elementary-step box's route*, which starts from bare collinearity and lands on "$t=0$, $t=1$, or $\Phi_2=\Phi_3$", each of which is only two images coinciding. **Here the note is indispensable**, and it is correct: $\Phi_i=\Phi_j$ with $\sum_k\lambda_k\Phi_k=0$ and $\lambda_i+\lambda_j=-\lambda_k$ gives $\lambda_k(\Phi_k-\Phi_i)=0$ with $\lambda_k\ne0$. It is stated for the pair $(1,2)$ in L183 and holds for every pair by relabelling, which is what the box's use of it requires.

**The degenerate parametrisation is handled.** The line through $\Phi_3$ and $\Phi_2$ needs $\Phi_2\ne\Phi_3$, which the distinct branch supplies, and the collinearity L183 produces is in exactly this form, $\Phi_1-\Phi_3=t(\Phi_2-\Phi_3)$, so no reparametrisation is smuggled in.

**The Lean file matches.** [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean)'s `eq_of_collinear_of_norm_eq` takes `x - z = t • (y - z)` with all three norms equal and returns `x = z ∨ x = y ∨ y = z`. I followed the term: `key` is the quadratic above, `h1` and `ht` are the two evaluations, `e2` is $t(t-1)\lVert y-z\rVert^2=0$, and the three disjuncts come out of `mul_eq_zero` twice. **It is sound and it is general, over any real inner product space, which is the right level.**

## 4. Norm dependence, and why jointness is load-bearing

**L183 fixes no inner product.** Its proof runs $\sum_i\lambda_i\Phi_i=0$, eliminates $\lambda_3$, and reads off $\lambda_1(\Phi_1-\Phi_3)=-\lambda_2(\Phi_2-\Phi_3)$. That is a linear relation in the vector space $S^2\oplus\Lambda^4$ and it mentions no pairing. **So L183's collinearity survives every change of inner product**, and L194 is free to choose the one its identity needs. The block's own sentence about this is correct as stated.

**What does not survive a weakening is jointness.** L183 says the collinearity is joint in the direct sum, "strictly stronger than collinear in each factor", and L194 depends on that entirely. Three points collinear factor by factor need not be collinear: in $\mathbb R\oplus\mathbb R$, take $(0,0)$, $(1,0)$, $(2,1)$, which are collinear in the first factor and trivially collinear in the second, and are not collinear jointly. **Under a factorwise reading the sphere argument has no line to intersect and L194 fails outright.** L183's derivation does produce the joint form, so the dependency is discharged, but it is the single hypothesis L194 cannot lose and its block does not name it as one.

## 5. The witness, and the catalogue

**Both claims about $\Lambda^+\mathbb R^4$ are correct, for every unit self-dual form and not only for a basis.** Take the standard $\Lambda^+$ frame $\tfrac1{\sqrt2}(e_{12}+e_{34})$, $\tfrac1{\sqrt2}(e_{13}-e_{24})$, $\tfrac1{\sqrt2}(e_{14}+e_{23})$, which is orthonormal under $\langle\cdot,\cdot\rangle$. As matrices these are $\tfrac1{\sqrt2}J_1,\tfrac1{\sqrt2}J_2,\tfrac1{\sqrt2}J_3$ with the $J_k$ the quaternionic triple, $J_k^2=-\mathrm{Id}_4$ and $J_kJ_l=-J_lJ_k$ for $k\ne l$. For $\omega=\sum_kc_k\tfrac1{\sqrt2}J_k$ with $\sum c_k^2=1$,
$$\omega^2=\tfrac12\sum_{k,l}c_kc_lJ_kJ_l=\tfrac12\sum_kc_k^2J_k^2=-\tfrac12\mathrm{Id}_4 ,$$
the cross terms cancelling in pairs by anticommutation. **That is the first claim, at every unit self-dual $\omega$.** For the second, on $\mathbb R^4$ the space $\Lambda^4$ is a line and $\omega\wedge\omega=\langle\omega,\star\omega\rangle\,\mathrm{vol}_4=\lVert\omega\rVert^2\mathrm{vol}_4=\mathrm{vol}_4$, since $\star\omega=\omega$ on $\Lambda^+$. **So all three images coincide**, and $\lVert\Phi\rVert^2=\operatorname{tr}(\omega^4)+1=1+1=2$, agreeing with section 2 at $\sigma=(1/\sqrt2,1/\sqrt2)$.

**Padding preserves it.** Embedding $\mathbb R^4\subset\mathbb R^n$ leaves $\omega^2$ the same matrix bordered by zeros and adds no new nonzero $4$-form coefficient, so the coincidence is unchanged at every $n$. **The witness is therefore a live inhabitant of L194's surviving branch at every $n$**, which is what makes the lemma non-vacuous rather than merely true.

**Nothing in the catalogue sits in the distinct branch, and nothing can.** The record's rank-three objects are padded $W_{\mathbb{CP}^2}$, its negative, and [L190](../findings/diagonal-half.md)'s five-parameter family of an arbitrary orthonormal $\Lambda^+\mathbb R^4$ basis with an arbitrary nonzero traceless weight vector. All of them are coincident by the display above, which holds across the whole of $\Lambda^+$ and so covers the family rather than a point. **A single distinct-branch object would refute L194 and I found none**, and section 10 says where I looked.

## 6. Scope

**No step of L194 carries a dimension.** L183 is stated at every $n$, the identity is proved at every $n$ in section 2, and the line-sphere step is dimension-free. **The claim "at every $n$" is correct.**

**The formalisation is narrower than the claim, and the standfirst reads wider than it is.** [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean) types the elementary step at full generality, and [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) types the identity at `Fin 4` and `Fin 6` alone, each by expanding and calling `ring`. L194's standfirst says "the load-bearing step is typed and proved with no gap". *Read charitably, and this is the reading the words support*, "the load-bearing step" is singular and names the line-sphere step, and [conventions.md](../findings/conventions.md) line 124 already records that the general-$n$ identity "is owed a numbered result and a Lean statement". **Read quickly it says the lemma is machine-checked, which it is not.** I report this as an accuracy note rather than a defect: the sentence is true, and one clause naming the identity's cover would stop it being read as more.

## 7. L184's three cases, attacked one at a time

**The setup is sound and its inputs are Weyl-free, as claimed.** $A=-\omega_i^2$ is common by hypothesis, so every $\omega_i$ commutes with $A$ and preserves each of its eigenspaces. $A$ is positive semidefinite always and positive definite on $V=\operatorname{im}A$. Because $\omega_1|_V$ is invertible and skew on a six-dimensional space, its eigenvalues are $\pm\mathrm ic_1,\pm\mathrm ic_2,\pm\mathrm ic_3$ with every $c_j>0$, so $A|_V$ has spectrum $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$. **The trichotomy on three positive reals is exhaustive**, and the block's correction that the evenness is a statement about $A|_V$ and not $A$ is right, the zero eigenvalue off $V$ having multiplicity $n-6$ of any parity.

### 7a. Case 1, pairwise distinct

**Complete, and its hypotheses are all stated.** The eigenspaces of $A|_V$ are three planes, and each $\omega_i$ preserves each and vanishes on $V^\perp$, so it is block diagonal, and a skew map on a plane is a multiple of its area form. $(\omega_i|_{P_j})^2=-c_j^2\mathrm{Id}$ forces the multiple to be $\pm c_j$, giving $\omega_i=\sum_js_{ij}c_j\varepsilon_j$ with $s_{ij}=\pm1$.

$\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k$, the diagonal terms vanishing. The three $\varepsilon_j\wedge\varepsilon_k$ are distinct basis $4$-forms, which is debt (i), so equality across $i$ gives $s_{ij}s_{ik}c_jc_k$ independent of $i$, and $c_jc_k>0$ cancels.

**The step from that to $\omega_i=\eta_i\omega_1$ checks out at both index ranges, which is worth doing explicitly because the block states it in one clause.** Put $\eta_i=s_{i1}s_{11}$. At $j=1$, $\eta_is_{11}=s_{i1}s_{11}^2=s_{i1}$. At $j\ge2$, independence at the pair $(1,j)$ reads $s_{i1}s_{ij}=s_{11}s_{1j}$, and multiplying by $s_{i1}$ gives $s_{ij}=s_{i1}s_{11}s_{1j}=\eta_is_{1j}$. **So $s_{ij}=\eta_is_{1j}$ for every $j$ and $\omega_i=\eta_i\omega_1$ exactly.** Then $\operatorname{tr}(\omega_1\omega_2)=\eta_2\operatorname{tr}(\omega_1^2)=-2\eta_2$, that is $\langle\omega_1,\omega_2\rangle=\eta_2=\pm1$, against orthogonality.

**$\dim V=6$ enters only as "three planes", and the argument transfers.** At $\dim V=2m$ with all $c_j^2$ distinct the same three lines run verbatim over $j=1,\dots,m$, so the entailment box's "only case 1's argument transfers, to the pairwise-distinct stratum" is correct. **A cross-check that the transfer is not vacuous**: at $\dim V=4$ it says a coincident orthonormal pair or triple cannot have $c_1^2\ne c_2^2$, and indeed the $\dim V=4$ witness has $c_1^2=c_2^2=\tfrac12$ and lives in case 2. The two agree.

**No Weyl input and no appeal to L181**, as the body now says. I checked that the body's own route is self-contained and that L181 appears in it only to be named as retired.

### 7b. Case 2, $A=cI_6$

**Complete.** $\omega_i/\sqrt c$ is skew and orthogonal, so a complex structure, and $\operatorname{tr}A=2$ gives $c=\tfrac13$. **I rederived $\star_V(J\wedge J)=2\epsilon_JJ$ rather than reading it off.** In a $J$-adapted frame $J=\varepsilon_1+\varepsilon_2+\varepsilon_3$, so $J\wedge J=2(e_{1234}+e_{1256}+e_{3456})$, and with $\mathrm{vol}=e_{123456}$ each star is the complementary area form with sign the parity of the shuffle: $e_{1234}\wedge e_{56}=\mathrm{vol}$, then $e_{1256}\wedge e_{34}$ needs $e_{34}$ moved past $e_{56}$, four transpositions, sign $+$, and $e_{3456}\wedge e_{12}$ needs $e_{12}$ moved past four indices, eight transpositions, sign $+$. **All three $+$, so $\star_V(J\wedge J)=2J$ at the positively oriented adapted frame and $-2J$ otherwise.** That is debt (iv) and it is right.

**$\epsilon_J$ is well defined and the block's attribution is the correct one.** Two $J$-adapted frames differ by an orthogonal map commuting with $J$, that is by an element of $U(3)$, and $\det_{\mathbb R}U=\lvert\det_{\mathbb C}U\rvert^2=1$, so $U(3)\subset SO(6)$ and every adapted frame carries the same orientation. **Connectedness of $SO(6)$ is a statement about a different set and does not supply this**, so the block's self-correction is right and its reversal of the earlier reviewer's substitute is right.

**Applying $\star_V$ to $J_i\wedge J_i=J_1\wedge J_1$ gives $\epsilon_iJ_i=\epsilon_1J_1$, hence $J_i=\pm J_1$**, and $\omega_i=\pm\omega_1$. **Linearity of $\star_V$ is all this uses.** The case body's "and nothing weaker survives, since $\star$ is injective" is a true statement about a fact that does no work, and the observation box eleven lines below says so in as many words. *The most charitable reading is that the body is naming the property that makes the conclusion sharp rather than the property the step consumes*, and under that reading it is not wrong, only redundant. **I report it as an internal inconsistency of justification and not of truth**, and it is one line to fix.

**The closing.** Under L184's strengthened statement there is no rank to speak of, so the operative contradiction is that $\omega_i=\pm\omega_1$ makes $\lvert\langle\omega_1,\omega_2\rangle\rvert=1$ against orthonormality. The body says "the three forms span a line, so the rank cannot be three", which is Weyl-flavoured wording in a block whose headline is that no Weyl hypothesis is used. **Orthonormality delivers linear independence, so the argument is fine and only the wording carries the residue.**

**The dimension is used where it is claimed and it is sharp.** $\star_V$ maps $\Lambda^4V\to\Lambda^2V$ only when $\dim V=6$, and $\binom{2m}4=\binom{2m}2$ holds at $2m=6$ alone. **The block's insistence that the constraint is on $\dim V$ and not on $n$ is correct**, since $\star_V$ is built from $V$'s metric and orientation.

### 7c. Case 3, spectrum $(a,a,b)$

**Complete, and shorter than it is printed.** $A|_V$ splits $V$ into a $4$-plane $Q$ at $a$ and a plane $P$ at $b$, both preserved, so $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i^2=-\mathrm{Id}_Q$ and $\tau_i=\pm1$. Then
$$\omega_i\wedge\omega_i=a\,J_i\wedge J_i\;+\;2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P ,$$
the $\varepsilon_P\wedge\varepsilon_P$ term vanishing because $\Lambda^4P=0$. The two surviving pieces lie in $\Lambda^4Q$ and $\Lambda^2Q\wedge\Lambda^2P$, independent summands of $\Lambda^4V$.

**The cross term carries it.** $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$, debt (ii), and $\sqrt{ab}\ne0$, so equality across $i$ gives $\tau_iJ_i$ all equal. **Writing $J:=\tau_1J_1$ gives $J_i=\tau_iJ$ directly, hence $\rho_i=\sigma_i\tau_i=+1$ for every $i$ and**
$$\omega_i=\tau_i(\sqrt a\,J\oplus\sqrt b\,\varepsilon_P)=\tau_i\tau_1\,\omega_1 ,$$
whence $\lvert\langle\omega_1,\omega_2\rangle\rvert=1$ against orthogonality. **That is the whole case**, and the block does reach it, in the sentence beginning "With $J:=\tau_1J_1$".

**The printed $4a=-2b$ ending is also sound.** With $\operatorname{tr}(J^2)=-4$ on $Q$ and $\varepsilon_P^2=-\mathrm{Id}_P$, $\operatorname{tr}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, so orthogonality is $4a\,\sigma_i\sigma_j=-2b\,\tau_i\tau_j$, that is $4a\,\rho_i\rho_j=-2b$. The sign count is correct in its own right: if $\rho_1\rho_2=\rho_1\rho_3=\rho_2\rho_3=k$ then multiplying the three gives $(\rho_1\rho_2\rho_3)^2=k^3$, so $k^3=1$ and $k=1$, whence $4a=-2b$ with $a,b>0$. **It is a second contradiction rather than the operative one**, and the block's own note that the $\rho_i$-constant sentence "retires the three-signs step" is accurate.

**The sequencing note is correct and is worth keeping.** Read alone the $\Lambda^4Q$ equality $a\,J_i\wedge J_i$ constant says $\eta_1=\eta_2=\eta_3$ for $J_i\wedge J_i=2\eta_i\mathrm{vol}_Q$, a real restriction on three signs. It becomes vacuous only after the cross term has delivered $J_i=\pm J$, since $(-J)\wedge(-J)=J\wedge J$. **So the corrected $\pm2$ costs nothing, exactly as the block says.**

**$\dim V=6$ is used as the $4+2$ splitting and nowhere else in this case**, and the claim that case 3 is strictly six-dimensional is right for that reason.

### 7d. And the pair audits already cover these bodies

**L191's proof is L184's three cases run on two forms**, and it passed Gate 2 with [r808](REVIEW_r808.md) and [r809](REVIEW_r809.md) both confirming all three. **So L184's case bodies have been read three times, not once**, and the present round is the first to read them as a triple statement with L194 standing beside them. *This also means L191 is not independent corroboration of L184*, which a ledger row could easily read it as: the two share one case analysis, and what L191 adds is that orthogonality is spent later than L184 spends it.

## 8. The debts

| debt | status | load-bearing? |
|---|---|---|
| (i) the $\varepsilon_j\wedge\varepsilon_k$ are independent | **discharged and correct.** At $j<k$ they are the distinct basis $4$-forms $e_{2j-1,2j,2k-1,2k}$ | **yes**, case 1 rests on it |
| (ii) $\alpha\mapsto\alpha\wedge\varepsilon_P$ injective on $\Lambda^2Q$ | **discharged and correct.** $Q\perp P$ and $\Lambda^2P$ is the line $\mathbb R\varepsilon_P$ | **yes**, case 3 rests on it |
| (iii) $\star_V:\Lambda^4V\to\Lambda^2V$ an isometry | **discharged and correct**, and the block is right that "injective" was the weaker word | **no.** Case 2 needs only that $\star_V$ is linear, which the same box says |
| (iv) the base constant is $2$ | **discharged and correct**, three star signs recomputed in section 7b | **yes**, case 2 rests on it |
| well-definedness of $\epsilon_J$ | **discharged and correctly attributed to $U(3)\subset SO(6)$** | **yes**, case 2 rests on it |

**None of the five is discharged by L194**, which touches none of them: L194's content is the identity and the line-sphere step, and neither meets a complex structure. **The one debt still live is a Lean debt and it is named by [I40](../plan.md)**, that $\star_V(J\wedge J)=2\epsilon_JJ$ is carried by the layer as an unproved `Prop`, which [INDEX-results.md](../findings/INDEX-results.md) row 191 also records. **That is a formalisation obligation and not an analytical one**: sections 7b's computation closes it on paper.

## 9. The composition, and the one thing that is stale

**The composition is exact.** L194 says every rank-three $W\in\mathcal W_n$ has $\Phi(\omega_1)=\Phi(\omega_2)=\Phi(\omega_3)$. By the definition of $\Phi$ that is "the squares coincide and the self-wedges coincide". The $\omega_i$ are eigenforms of a symmetric operator on $\Lambda^2$, hence orthonormal, and the common square delivers a common support, whose dimension is $\dim V$. **At $\dim V=6$ that is exactly L184's hypothesis, and L184 says no such triple exists. So there is no rank-three Weyl tensor with $\dim V=6$.**

**L184 covers exactly what L194 leaves at $\dim V=6$, and no less.** L194 leaves the coincident branch at every $n$, L184 empties it at $\dim V=6$, and the pair covers $\dim V=6$ and claims nothing above it. **There is no gap between them and no overhang**, and a subtlety that could have been one is closed by L194 itself: [L180](../findings/diagonal-half.md)(3) puts $V$ at the *minority-sign* form's support, while L184's $V$ is the *common* support, and under coincidence the two are the same subspace.

**The stale text.** L184's entailment box reads *"At $\dim V=6$ the coincident case is empty, and since L183 leaves only all-coincide or all-distinct-and-collinear, what remains there is the distinct-and-collinear case"*, and [INDEX-results.md](../findings/INDEX-results.md) row 184 reads *"So I38 is down to the distinct-and-collinear case"*. **L194 empties that case at every $n$, so both sentences are now false**, and L194 sits fifteen lines above the first of them in the same file with the corrected reading in its own closing box. *The charitable reading is the true one about how this arose*: the box is dated 2026-09-08 and L194 2026-09-10, and the box's headline promises no inflation about its own reach rather than about a later lemma's. **It is still what a reader of L184 alone takes away, and rows are what later work is built on**, which is the failure mode [r782](REVIEW_r782.md) already caught once in this same box. **Repair: both sentences become "the rank-three branch at $\dim V=6$ is empty, by L194 with this lemma".**

**One further stale line, smaller.** [INDEX-results.md](../findings/INDEX-results.md) row 184 still describes case 1 as *"all three are block-diagonal for one splitting and L181 gives $W=0$"*, the route the block's body retired in favour of the Weyl-free one. The row's later sentence records the retirement, so the row contradicts itself in one cell.

## 10. Falsifiers, and where I looked

**L194 falls if any of four things holds**, and I attacked each.

1. **A rank-three Weyl tensor with three distinct images.** *Impossible given the identity*, and the catalogue supplies none: section 5 shows the whole $\Lambda^+\mathbb R^4$ family, which is every rank-three object the record carries, is coincident at every $n$ after padding.
2. **The identity failing at some $n$.** Derived at every $n$ in section 2, and screened at $n=3,\dots,9$, of which $5,7,8,9$ are machine-checked nowhere.
3. **The constant being other than $2$, or the norm being the record's other one.** Both settled in closed form in section 1's table.
4. **L183's collinearity being factorwise.** Section 4 exhibits $(0,0),(1,0),(2,1)$ to show the distinction is real, and L183's derivation produces the joint form, so this route is closed.

**L184 falls if an orthonormal triple with a common six-dimensional support has both coincidences.** The nearest live configuration on the record is [r809](REVIEW_r809.md)'s near-miss, $\omega_{1,2}=\tfrac12(e^{12}+e^{34})\pm\tfrac1{\sqrt2}e^{56}$, which is orthonormal, has a common six-dimensional support and equal squares, and satisfies the orthogonality identity that case 3's printed ending turns on. **I recomputed its wedges and they differ in exactly the two cross-term components $e^{1256}$ and $e^{3456}$**, which is what the cross term is there to catch and is why the sequencing is load-bearing. **The other place to look is one dimension down**: at $\dim V=4$ the coincident triple exists, is inhabited by the whole $\Lambda^+$ family, and is the reason six is sharp rather than incidental. **I found no falsifier of either lemma.**

### The screen, reported as a screen

**One run, seconds of compute, on objects I constructed for the purpose, and no positive claim below rests on it.** All four checks agree with the closed-form derivations above, which are what the verdicts rest on.

- The identity at $n=3,\dots,9$ on two hundred random skew matrices each: maximum relative deviation $7\times10^{-16}$.
- The $\tfrac14\sum_{ijkl}$ reading on unit forms at $n=6$: values spread over $3.80$ to $6.96$ against the constant $2$ the $\lVert\cdot\rVert_\perp$ reading gives to ten places.
- Generic unit self-dual $\omega$ on $\mathbb R^4$, five hundred of them: $\lVert\omega^2+\tfrac12\mathrm{Id}_4\rVert_{\max}$ and $\lvert(\omega\wedge\omega)_{1234}-1\rvert$ both at $7\times10^{-16}$, $\lVert\Phi\rVert^2=2$, and the coincidence unchanged after padding to $n=8$.
- r809's pair: orthonormal, equal squares to machine zero, wedges differing in $e^{1256}$ and $e^{3456}$ by $\sqrt2$ each and nowhere else.

## 11. Verdict

**L194: CONFIRMED.** The sphere identity is right at every $n$ with the constant $2$, the norm it needs is the one it names, the line-sphere step is right and its Lean term is sound, and the passage to all-coincide is right by either of the two routes the block gives. **Fold it.** Two things to carry with it: the Frobenius inner product on $S^2(\mathbb R^n)$ that the identity requires belongs in [conventions.md](../findings/conventions.md), because the record's tabled habit for the neighbouring space breaks the identity rather than rescaling it, and the standfirst's "typed with no gap" is true of the elementary step while the identity is typed at $\dim 4$ and $\dim 6$ only.

**L184: CONFIRMED, all three cases.** Each is complete, each states its hypotheses, and each uses $\dim V=6$ where it claims to and for the reason it claims. All five declared debts are discharged correctly and three of them are load-bearing. **Fold it**, and edit two sentences that L194 has overtaken: L184's entailment box and [INDEX-results.md](../findings/INDEX-results.md) row 184 both still hand the distinct-and-collinear case to $\dim V=6$, and the joint conclusion is that the rank-three branch there is empty outright.

**No discrepancy was withdrawn**, and none of the four recorded above is a mathematical error in either lemma: two are stale text, one is an untabled convention, and one is a redundant justification.
