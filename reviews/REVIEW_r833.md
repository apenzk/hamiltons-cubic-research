# Review r833: Gate 2 on L194 (the distinct branch is empty) and L184 (the coincident case at $\dim V=6$ is empty)

*Cold brief: I worked from [BRIEF](/tmp/brief_r833.md) and my own derivations, opening [findings/](../findings/) only after the two blocks were reconstructed by hand, and I read neither the sibling reviewer's log nor its report. **Two SCREENS were run**, seconds of exact rational arithmetic on objects I wrote down myself: one re-checking the $\Phi$-sphere identity at $n=2,\dots,9$ against a normal-form derivation I had already completed, one re-checking the padded $W_{\mathbb{CP}^2}$ images and [r809](REVIEW_r809.md)'s case-3 near-miss. Both are reported as screens in sections 2, 5 and 7c and are cited for nothing positive. No search, sweep, census, optimisation or falsifier hunt was run. Log: [agent_logs/g2-rank3-r833.log](../agent_logs/g2-rank3-r833.log).*

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | $\lVert\Phi(\omega)\rVert^2=\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2$, with Frobenius on $S^2$ | **CORRECT, AND THE NORM IS NAMED CORRECTLY** |
| 2 | $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$ and every $n$ | **CORRECT, DERIVED FROM THE NORMAL FORM, CONSTANT $2$ CONFIRMED** |
| 3 | Three points of equal norm on one line are not distinct, and all three then coincide | **CORRECT, AND ALL THREE FOLLOW BY A SHORTER ROUTE THAT NEEDS NO SEPARATE NOTE** |
| 4 | L183's collinearity survives a change of inner product on $S^2\oplus\Lambda^4$ | **CORRECT, AND STRONGER THAN CLAIMED: L183 FIXES NO INNER PRODUCT AT ALL THERE** |
| 5 | Padded $W_{\mathbb{CP}^2}$ has $\omega^2=-\tfrac12\mathrm{Id}_4$, $\omega\wedge\omega=\mathrm{vol}_4$, and nothing in the catalogue sits in the distinct branch | **BOTH CONFIRMED, NO COUNTEREXAMPLE ANYWHERE IN THE RECORD** |
| 6 | L194 holds at every $n$ with no dimension restriction | **CORRECT** |
| 7a | L184 case 1, the $c_j^2$ pairwise distinct | **COMPLETE, HYPOTHESES ALL STATED, USES $\dim V=6$ ONLY FOR THE THREE-PLANE COUNT** |
| 7b | L184 case 2, $A=cI_6$ | **COMPLETE, AND USES $\dim V=6$ EXACTLY WHERE IT CLAIMS TO** |
| 7c | L184 case 3, spectrum $(a,a,b)$ | **COMPLETE, THE CROSS-TERM SEQUENCING IS LOAD-BEARING AND CORRECTLY ORDERED** |
| 7d | The trichotomy is exhaustive and Weyl-free | **CORRECT** |
| 8 | L184's declared debts, and which are load-bearing | **NONE IS DISCHARGED BY L194; (i) AND (ii) ARE LOAD-BEARING, (iii) IS DECORATIVE, (iv) IS LOAD-BEARING IN A STRICTLY WEAKER FORM THAN STATED** |
| 9 | L194 plus L184 empty the rank-three branch at $\dim V=6$ | **THE COMPOSITION IS VALID AND EXACT, AND IT CAN BE ROUTED THROUGH THE AUDITED L191 INSTEAD** |
| 10 | Falsifiers | **NAMED FOR BOTH, NONE FOUND, AND FOR L194 NONE CAN EXIST GIVEN L183** |
| D1 | L184's block header reads "**Unaudited**" | **STALE AND PROPAGATING: L184 HAS HAD TWO GATE 2 ROUNDS** |
| D2 | [lean/INDEX.md](../lean/INDEX.md)'s PhiSphere row: "does not state the identity at any dimension but four" | **STALE: `phi_sphere6` IS IN THE FILE** |
| D3 | `L194Statement.lean` holds the finite-stabiliser exhibit, not L194 | **REAL NAVIGATIONAL COLLISION, LOW SEVERITY** |
| D4 | The elementary-step box parametrises "the line through $\Phi_3$ and $\Phi_2$" | **WITHDRAWN as a defect, recorded as a wording note** |

## One line someone can act on

**Both lemmas are CONFIRMED and neither needs a mathematical repair**, and the one edit worth making is to L194's closing box: its emptiness at $\dim V=6$ is not conditional on an unaudited lemma, because [L191](../findings/diagonal-half.md) is Gate 2 passed and its hypotheses are exactly what L194 delivers.

## Conventions, fixed before anything was derived

| object | reading used here | source |
|---|---|---|
| $\langle X,Y\rangle$ on $\Lambda^2$ | $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so a unit bivector has $\operatorname{tr}(\omega\omega^{\mathsf T})=2$ and $\operatorname{tr}(\omega^2)=-2$ | [conventions.md](../findings/conventions.md), and `inner2` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) |
| $\lVert\cdot\rVert_\perp$ on $\Lambda^4$ | multi-index-orthonormal, $\sum_{i<j<k<l}$ of the components of $\omega\wedge\omega$ | [conventions.md](../findings/conventions.md) |
| $\lVert\cdot\rVert$ on $\Lambda^4$, the record's other one | $\tfrac14\sum_{ijkl}$, six times larger on the same array | [conventions.md](../findings/conventions.md) |
| norm on $S^2(\mathbb R^n)$ | plain Frobenius, $\operatorname{tr}(SS)$ at symmetric $S$, which is the record's reading for $\mathrm{Ric}$ and for the sectional matrix $K$ | [conventions.md](../findings/conventions.md) |
| $(\omega\wedge\omega)_{ijkl}$ | $2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, which is `2 * w4` of [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) | [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) |
| $V$ | the common support, $\operatorname{im}\omega_i=\operatorname{im}A$, always of even dimension | [L180](../findings/diagonal-half.md) |

**The $\tfrac12$ belongs at the $\Lambda^2$ level and does not travel to $S^2$.** *That is the one convention on which section 1 turns, and getting it wrong makes the sphere claim false rather than rescaled.*

## Hypothesis inventory

**L194 consumes, in this order:** L183's dichotomy (which itself consumes L179(b), L180(1), $\sum\lambda_i=0$, every $\lambda_i\ne0$, and equal nonzero norms); the unit norm $\langle\omega_i,\omega_i\rangle=1$ for the value $2$; and one inner product on $S^2\oplus\Lambda^4$, namely Frobenius $\oplus\ \lVert\cdot\rVert_\perp$. **Mutual orthogonality of the $\omega_i$ is stated and unused**, inherited from L183 where it is also unused. **No dimension hypothesis appears anywhere.**

**L184 consumes:** three $2$-forms, pairwise orthonormal under $\tfrac12\operatorname{tr}$; a common support of dimension exactly six; $\omega_1^2=\omega_2^2=\omega_3^2$; $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$. **$\operatorname{tr}A=2$ is used only to fix $c=\tfrac13$ in case 2 and $4a+2b=2$ in case 3, and neither value is used in a contradiction.** *Case 1 uses unit norm nowhere at all.* **Orthogonality is spent exactly once per case, at the last line.** *No Weyl hypothesis appears, and the block is right to say so.*

## 1. The sphere step, and the norm on $S^2$

$\omega$ skew gives $(\omega^2)^{\mathsf T}=(\omega^{\mathsf T})^2=(-\omega)^2=\omega^2$, so $\omega^2$ is symmetric and $\lVert\omega^2\rVert_F^2=\operatorname{tr}((\omega^2)^{\mathsf T}\omega^2)=\operatorname{tr}(\omega^4)$. **So $\lVert\Phi(\omega)\rVert^2=\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2$ exactly, with Frobenius on the first factor and $\lVert\cdot\rVert_\perp$ on the second.** The block states both and is right to state both.

**The factor that would break it, named as the brief asks.** *If the record's $\Lambda^2$ rule $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ were carried over to $S^2$ by analogy, the first term would be $\tfrac12\operatorname{tr}(\omega^4)$ and the total would read $\tfrac12\cdot2\sum\sigma_i^4+2(1-\sum\sigma_i^4)=2-\sum\sigma_i^4$ at unit norm, which is not constant.* **The half-trace convention is a $\Lambda^2$ convention and does not travel**, and [conventions.md](../findings/conventions.md) already uses plain Frobenius on symmetric matrices for $\mathrm{Ric}$ and for $K$, so the record is internally consistent here.

## 2. The identity, from the singular-value normal form

**Derivation, at every $n$ and every skew $\omega$.** Put $\omega$ in the real skew normal form $\omega=\sum_{i=1}^{p}\sigma_i\,e_{2i-1}\wedge e_{2i}$ with $\sigma_i\ge0$ and $p=\lfloor n/2\rfloor$, the remaining direction at odd $n$ being killed.

- $\omega^2$ acts as $-\sigma_i^2$ on each plane, so $\operatorname{tr}(\omega^4)=\sum_i 2\sigma_i^4$.
- $\omega^{\mathsf T}\omega=-\omega^2$ has the same doubled spectrum, so $\langle\omega,\omega\rangle=\tfrac12\sum_i2\sigma_i^2=\sum_i\sigma_i^2$.
- $\omega\wedge\omega=\sum_{i,j}\sigma_i\sigma_j\,e_{2i-1,2i,2j-1,2j}=2\sum_{i<j}\sigma_i\sigma_j\,e_{2i-1,2i,2j-1,2j}$, the diagonal terms vanishing, and the surviving index sets are pairwise distinct. Hence $\lVert\omega\wedge\omega\rVert_\perp^2=\sum_{i<j}4\sigma_i^2\sigma_j^2=2\big[(\sum_i\sigma_i^2)^2-\sum_i\sigma_i^4\big]$.

Adding the first and the third, $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\sum\sigma_i^4+2(\sum\sigma_i^2)^2-2\sum\sigma_i^4=2(\sum\sigma_i^2)^2=2\langle\omega,\omega\rangle^2$. $\square$

**The constant is $2$ and the norm is $\lVert\cdot\rVert_\perp$**, exactly as the block and [conventions.md](../findings/conventions.md) say. *The derivation is four lines and is homogeneous of degree four, so it holds off the unit sphere as well, which is what makes it usable without renormalising.* At $n\le3$ every quadruple index set is empty and both sides read $2\sigma_1^4$, so the identity is true there too rather than vacuous.

> **SCREEN.** *Exact rational arithmetic on three random integer skew matrices at each of $n=2,\dots,9$, on matrices I generated for this purpose: the identity held in every instance. Reported as a screen, cited for nothing.* **A second screen shows why the norm has to be named**: replacing $\lVert\cdot\rVert_\perp^2$ by the record's $\tfrac14\sum_{ijkl}$ rule multiplies the wedge term by six, and the ratio $\big(\operatorname{tr}(\omega^4)+6\lVert\omega\wedge\omega\rVert_\perp^2\big)/2\langle\omega,\omega\rangle^2$ came out different at every sample. *In closed form the six-times version is $12-10\sum\sigma_i^4$ at unit norm, constant only where $\sum\sigma_i^4$ is.*

**So the block's warning is exact rather than cautious**, and [conventions.md](../findings/conventions.md)'s "false rather than rescaled" is the right description.

**And the inner product is essentially unique.** *Taking $\alpha\cdot(\text{Frobenius on }S^2)\oplus\beta\cdot\lVert\cdot\rVert_\perp^2$ gives $2\alpha\sum\sigma_i^4+2\beta[(\sum\sigma_i^2)^2-\sum\sigma_i^4]$, constant on the unit sphere exactly at $\alpha=\beta$.* **So among the inner products that scale the two summands independently, the identity's is the only one, up to overall scale, that makes $\Phi$ land on a sphere.** *That is worth recording because it explains why the naming cannot be treated as bookkeeping.*

## 3. The line-meets-a-sphere step

**The algebra as the block states it is correct.** With $v=\Phi_2-\Phi_3$ and $p(s)=\Phi_3+sv$, the condition $\lVert p(1)\rVert=\lVert p(0)\rVert$ reads $2\langle\Phi_3,v\rangle+\lVert v\rVert^2=0$, and $\lVert p(t)\rVert=\lVert p(0)\rVert$ reads $2t\langle\Phi_3,v\rangle+t^2\lVert v\rVert^2=0$. Substituting the first into the second gives $-t\lVert v\rVert^2+t^2\lVert v\rVert^2=t(t-1)\lVert v\rVert^2=0$, so $t=0$, $t=1$ or $\Phi_2=\Phi_3$. **Each alternative puts two of the three points together, which the distinct branch forbids, so that branch is empty.**

This is exactly `eq_of_collinear_of_norm_eq` in [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean), stated over an arbitrary real inner product space and proved with no `sorry`. *I read the proof term by term: `key` is the quadratic expansion, `h1` and `ht` are the two equal-norm instances, `e1` and `e2` are the two displayed identities, and the case split on `mul_eq_zero` returns the three-way disjunction.* **The Lean is strictly better posed than the prose**, because it takes the collinearity as $x-z=t\cdot(y-z)$, which is meaningful when $y=z$, where "the line through $\Phi_3$ and $\Phi_2$" is not.

**On combining with L183's exactly-two-coincident note.** The combination is valid: L183's dichotomy is all-coincide or all-distinct, so a conclusion that two coincide contradicts the second alternative and leaves the first. **But the note is not needed, and a shorter route gives all three at once.**

> **THE DIRECT ROUTE, WHICH USES $\lambda_3\ne0$ INSTEAD OF A SEPARATE NOTE.** *Set $v_i=\Phi_i-\Phi_3$. Then $\sum\lambda_i\Phi_i=0$ with $\sum\lambda_i=0$ is $\lambda_1v_1+\lambda_2v_2=0$, and equal norms give $2\langle\Phi_3,v_i\rangle=-\lVert v_i\rVert^2$ for $i=1,2$. Pairing the first relation with $\Phi_3$ gives $\lambda_1\lVert v_1\rVert^2+\lambda_2\lVert v_2\rVert^2=0$, and $v_1=-(\lambda_2/\lambda_1)v_2$ turns that into $\tfrac{\lambda_2}{\lambda_1}(\lambda_1+\lambda_2)\lVert v_2\rVert^2=0$. **Since $\lambda_1+\lambda_2=-\lambda_3\ne0$ and $\lambda_2\ne0$, $v_2=0$, hence $v_1=0$: all three images coincide.*** *No case split, no exclusion of a fourth configuration, and the branch structure of L183 is not consumed at all.*

**That is a strengthening rather than a correction.** The block's route is sound as written.

## 4. Norm dependence, and what L183 actually fixes

**The block's claim is right, and understates itself.** *Collinearity is an affine notion and survives any change of inner product, while lying on a sphere does not, which is why the identity's own inner product has to be named.* **But L183's conclusion is not merely norm-independent, it is inner-product-free**: its proof reads $\sum_i\lambda_i\Phi(\omega_i)=0$ with $\sum_i\lambda_i=0$ and every $\lambda_i\ne0$ as an affine dependence, and affine dependence of three vectors in a real vector space is a statement of linear algebra that mentions no pairing on $S^2\oplus\Lambda^4$ whatever.

**The only inner product L183's derivation fixes is $\Lambda^2$'s**, and it fixes it twice: orthonormality of the $\omega_i$ is stated there (and unused), and the unit norms are genuinely consumed, tracelessness being Ricci's trace only because $\operatorname{tr}(\omega_i^2)=-2$. **Neither of those is an inner product on the target $S^2\oplus\Lambda^4$**, so there is no clash with the identity's, and no conversion step is owed. *The argument needs one inner product on the target in which the three images have equal norm, and section 2 exhibits one.*

## 5. The witness, and the catalogue

**Both claims verified in closed form.** Write $I=e_{01}+e_{23}$, $J=e_{02}+e_{31}$, $K=e_{03}+e_{12}$ for the standard basis of $\Lambda^+\mathbb R^4$. These are the quaternion units: $I^2=J^2=K^2=-\mathrm{Id}_4$ and they anticommute pairwise, so for $\omega=aI+bJ+cK$ all cross terms cancel and $\omega^2=-(a^2+b^2+c^2)\mathrm{Id}_4$. And $\langle\omega,\omega\rangle=\tfrac12\operatorname{tr}(\omega^{\mathsf T}\omega)=2(a^2+b^2+c^2)$, so unit norm is $a^2+b^2+c^2=\tfrac12$ and $\omega^2=-\tfrac12\mathrm{Id}_4$. **Each of $I\wedge I$, $J\wedge J$, $K\wedge K$ is $2e_{0123}$ and every cross wedge vanishes on a repeated index**, so $\omega\wedge\omega=2(a^2+b^2+c^2)e_{0123}=\mathrm{vol}_4$ at unit norm. *Both hold on the whole of the unit sphere of $\Lambda^+\mathbb R^4$ and not only at a basis.*

**Consistency check against section 2:** $\operatorname{tr}(\omega^4)=\operatorname{tr}(\tfrac14\mathrm{Id}_4)=1$ and $\lVert\mathrm{vol}_4\rVert_\perp^2=1$, summing to $2=2\langle\omega,\omega\rangle^2$. *The witness sits on the sphere at the right radius, which is the cheapest possible test of the constant.*

> **SCREEN.** *Symbolic in $a,b,c$ over the rationals on the matrices above, confirming $\omega^2+(a^2+b^2+c^2)\mathrm{Id}_4=0$ and $(\omega\wedge\omega)_{0123}=2(a^2+b^2+c^2)$. Reported as a screen. The closed-form derivation above is what carries the claim.*

**Does anything in the catalogue sit in the distinct branch? No.** *The record's only inhabited rank-three case is [L190](../findings/diagonal-half.md)'s five-parameter family at $\dim V=4$: any orthonormal basis of $\Lambda^+\mathbb R^4$ with any nonzero traceless weight vector, and every member has coincident images by the computation above.* **Every other rank-three sub-case the record has attacked closed empty** ([L185](../findings/diagonal-half.md), [L186](../findings/diagonal-half.md), [L189](../findings/diagonal-half.md)), and [diagonal-half.md](../findings/diagonal-half.md) states in its own words that no witness above $\dim V=4$ exists anywhere in the record. **So no counterexample is available, and given L183 none can be**, section 3 having closed the branch outright rather than merely failing to populate it.

**A corroboration the block does not claim.** *L194 reproves [L189](../findings/diagonal-half.md) given [L185](../findings/diagonal-half.md): coincidence forces $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$, and a form is decomposable exactly when its self-wedge vanishes, so the image forms are either all decomposable or none is.* **All-decomposable is empty by L185, so all three are non-decomposable**, which is L189's statement by a route using no determinant and no dimension parity. *That the two agree is worth one line in the record.*

## 6. Scope

**No step of L194 uses a dimension restriction, and the "at every $n$" is earned.** Section 2's derivation is normal-form and dimension-free; L183's affine-dependence argument is dimension-free; the elementary step lives in an arbitrary real inner product space and is typed that way in [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean). *At $n\le3$ the statement is vacuous because $\mathcal W_n=0$ there, rather than false.*

**One honest caveat on the machine check, which the block already carries.** [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) closes the identity at $\dim=4$ (`trace_pow_four_add_pf_sq`) and at $\dim=6$ (`phi_sphere6`) by `ring` after the skew substitutions. *The general-$n$ statement is not typed, needing a $\Lambda^4$ the layer carries at no $n$.* **Section 2 is the general proof and it is four lines**, so the gap is in the formalisation and not in the mathematics.

## 7. L184, one case at a time

**The setup first.** $A=-\omega_i^2$ is common by hypothesis, and $\ker\omega=\ker\omega^2$ for skew $\omega$ gives $V=\operatorname{im}\omega_i=\operatorname{im}A$ for each $i$, so the three forms share a support for a reason and $A|_V$ is positive definite. **$\omega_i$ commutes with $\omega_i^2=-A$, hence preserves every eigenspace of $A$**, and this is the whole of why the second and third forms respect a splitting read off the first. *$\omega_i|_V$ is skew and invertible with eigenvalues $\pm\mathrm ic_j$, so every eigenvalue of $A|_V$ has even multiplicity and $\dim V=6$ gives the multiset $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$.* $\operatorname{tr}A=-\operatorname{tr}(\omega_i^2)=2$ at unit norm. **The trichotomy on how many of $c_1^2,c_2^2,c_3^2$ agree is exhaustive for any three positive reals**, and every input to it is Weyl-free, as the block says. *The evenness qualifier that r781 added, that multiplicities are even on $V$ and not on $\mathbb R^n$ where zero has multiplicity $n-6$, is present and correct in the block as it stands.*

### 7a. Case 1, the $c_j^2$ pairwise distinct: COMPLETE

$A|_V$'s eigenspaces are three planes $P_1,P_2,P_3$, each preserved by every $\omega_i$, and $\omega_i|_{P_j}$ is skew on a plane with square $-c_j^2$, hence $s_{ij}c_j\varepsilon_j$ with $s_{ij}=\pm1$ and $\varepsilon_j$ the area form. So $\omega_i=\sum_j s_{ij}c_j\varepsilon_j$ and $\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k$. **The $\varepsilon_j\wedge\varepsilon_k$ are distinct basis $4$-forms, so equality across $i$ is coefficientwise**, and $c_jc_k>0$ cancels, leaving $s_{ij}s_{ik}$ independent of $i$.

**The sign bookkeeping checks.** With $\eta_i=s_{i1}s_{11}$: at $j=1$, $\eta_is_{11}=s_{i1}s_{11}^2=s_{i1}$; at $j\ne1$, independence at the pair $(1,j)$ gives $s_{i1}s_{ij}=s_{11}s_{1j}$, so $s_{ij}=s_{i1}s_{11}s_{1j}=\eta_is_{1j}$. **Hence $\omega_i=\eta_i\omega_1$ and $\operatorname{tr}(\omega_1\omega_2)=\eta_2\operatorname{tr}(\omega_1^2)=-2\eta_2\ne0$, against orthogonality.** $\square$

**The wedge hypothesis is genuinely load-bearing here and the block is right to say so.** *Orthogonality alone does not close this case: at $c^2=(\tfrac12,\tfrac3{10},\tfrac15)$ and sign patterns $(+,+,+)$ and $(+,-,-)$ one gets $\operatorname{tr}(\omega_1\omega_2)=-2(\tfrac12-\tfrac3{10}-\tfrac15)=0$, so the pair is orthonormal with a common six-dimensional support and equal squares. It is the equal wedges that fail there, the sign products being $(+,+,+)$ against $(-,-,+)$.* **So the retirement of the appeal to [L181](../findings/diagonal-half.md) is not merely permitted but required**, and the block's reason for it, that L181's conclusion is about a $W\in\mathcal W_n$ and cannot reach a bare triple, is correct.

**Dimension use:** only that there are three planes, that is, $\dim V=6$. *The argument transfers verbatim to $\dim V=2m$ whenever all $m$ values $c_j^2$ are distinct, which is what the entailment box says.*

### 7b. Case 2, $A=cI_6$: COMPLETE

$\operatorname{tr}A=6c=2$ gives $c=\tfrac13$, so $J_i=\sqrt3\,\omega_i$ satisfies $J_i^2=-\mathrm{Id}_6$ and $J_i^{\mathsf T}J_i=\mathrm{Id}_6$, a compatible complex structure. **Equal wedges give $J_i\wedge J_i$ equal, and applying $\star_V$ to the equality gives $\epsilon_iJ_i=\epsilon_1J_1$, hence $J_i=\pm J_1$ and $\omega_i=\pm\omega_1$.** The three forms then span a line, contradicting linear independence, and equally $\operatorname{tr}(\omega_1\omega_2)=\mp2\ne0$ contradicts orthogonality. $\square$

**The star is $V$'s, and the block's insistence on that is correct.** *$\star_V:\Lambda^4V\to\Lambda^2V$ needs $\dim V-4=2$, and the dimension count $\binom{2m}{4}=\binom{2m}{2}$ holds exactly at $4=2m-2$, that is $m=3$.* **So $\dim V=6$ is used exactly where the block claims and nowhere else.**

**The block's own note that injectivity is cited and never used is right.** *Applying any linear map to both sides of an equality is enough, and [L191](../findings/diagonal-half.md) says the same.* Debt (iii) is therefore decorative, and section 8 prices it that way.

### 7c. Case 3, spectrum $(a,a,b)$ with $a\ne b$: COMPLETE

$A|_V$ splits $V=Q\oplus P$ with $\dim Q=4$, $\dim P=2$, both preserved by every $\omega_i$, so $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i$ a compatible complex structure on $Q$ and $\tau_i=\pm1$. Then
$$\omega_i\wedge\omega_i=a\,J_i\wedge J_i\ +\ 2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P,$$
the $\varepsilon_P\wedge\varepsilon_P$ term vanishing because $\Lambda^4P=0$. **The two surviving pieces live in $\Lambda^4Q$ and in $\Lambda^2Q\otimes\Lambda^2P$, which are independent summands of $\Lambda^4V$**, so equality across $i$ holds in each separately.

**The cross term carries the conclusion.** $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$ because $Q\perp P$ makes it $\alpha\mapsto\alpha\otimes\varepsilon_P$ under the natural splitting, and $\sqrt{ab}\ne0$, so $\tau_iJ_i$ is independent of $i$. **Setting $J:=\tau_1J_1$ gives $J_i=\tau_iJ$, hence $\omega_i=\tau_i(\sqrt a\,J\oplus\sqrt b\,\varepsilon_P)=\tau_i\tau_1\,\omega_1$**, and $\operatorname{tr}(\omega_1\omega_2)=-2\tau_1\tau_2\ne0$ closes it. $\square$

**The $\Lambda^4Q$ leg is vacuous only in that order, and the block is right that the sequencing is load-bearing.** *Read alone, $a\,J_i\wedge J_i$ equal says $\eta_1=\eta_2=\eta_3$ for $J\wedge J=2\eta\,\mathrm{vol}_Q$, which is a real restriction. Read after the cross term, $J_i=\pm J$ and $(-J)\wedge(-J)=J\wedge J$, so it says nothing.* **And $\eta=\pm1$ rather than $+1$ always is correct**: in a $J$-adapted frame of $Q$, $J=\varepsilon_1+\varepsilon_2$ and $J\wedge J=2\varepsilon_1\wedge\varepsilon_2$, which is $\pm2\,\mathrm{vol}_Q$ according to whether the frame's orientation is $Q$'s.

**The case body's own closing route is also correct.** $\operatorname{tr}(J^2)=-4$ on $Q$ and $\operatorname{tr}(\varepsilon_P^2)=-2$ give $\operatorname{tr}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, so orthogonality is $4a\,\sigma_i\sigma_j=-2b\,\tau_i\tau_j$ at all three pairs. **With $\rho_i=\sigma_i\tau_i$ the common value is $\rho_i\rho_j$, and multiplying the three equal pairwise products gives $(\rho_1\rho_2\rho_3)^2=k^3$, so $k=1$** and $4a=-2b$, impossible at $a,b>0$. *The three-signs step is sound for a triple, and the block's own warning that it fails for a pair is right.*

> **SCREEN, on [r809](REVIEW_r809.md)'s configuration, which I reconstructed from the block's description rather than from that report.** *$\omega_{1,2}=\tfrac12(e_{01}+e_{23})\pm\tfrac1{\sqrt2}e_{45}$ is orthonormal under $\tfrac12\operatorname{tr}$, has $\omega_1^2=\omega_2^2$, and both have rank six. Its wedges differ in exactly two components, $(0,1,4,5)$ and $(2,3,4,5)$, which are the cross term and nothing else.* **So the block's claim that orthogonality is the wrong instrument there and the cross term the right one is confirmed**, and the sequencing note is not decoration.

### 7d. Exhaustiveness

**Correct, and Weyl-free.** *Three positive reals either are pairwise distinct, all equal, or exactly two equal, and the three cases are those.* **The strengthened statement drops the tensor, and nothing in the split needed one**: the doubling is skewness, the definiteness is $V=\operatorname{im}A$, and $\operatorname{tr}A=2$ is the unit norm. *The corollary to a rank-three Weyl tensor is immediate because equal squares already force the common support, so there is no reconciliation step.*

## 8. L184's declared debts

| debt | status | load-bearing? |
|---|---|---|
| (i) the $\varepsilon_j\wedge\varepsilon_k$ are independent | **discharged and correct**: for $j<k$ they are the distinct basis $4$-forms $e_{2j-1,2j,2k-1,2k}$ | **YES**, case 1 reads equal wedges coefficientwise and has nothing without it |
| (ii) $\alpha\mapsto\alpha\wedge\varepsilon_P$ injective on $\Lambda^2Q$ | **discharged and correct** | **YES**, it is what turns the cross-term equality into $\tau_iJ_i$ constant |
| (iii) $\star_V$ is an isomorphism $\Lambda^4V\to\Lambda^2V$ | **discharged and correct** | **NO**, decorative: applying a linear map to an equality suffices, as the block itself and [L191](../findings/diagonal-half.md) both note |
| (iv) $\star_V(J\wedge J)=2\epsilon_JJ$, constant, base sign, and $\epsilon_J$ well defined | **discharged by the frame computation, and reduced further by [L193](../findings/diagonal-half.md)** | **PARTLY**: see below, the load-bearing content is strictly weaker than what is stated |

**None of the four is discharged by L194, and L194 touches none of them.** *L194's inputs are L183, the $\Phi$-sphere identity and one inner product, and it has no complex structure and no Hodge star anywhere in it.* **So the two lemmas owe nothing to each other in this direction**, and the brief's item 8 answers in the negative throughout.

**The frame computation for (iv) is correct as written.** In a $J$-adapted frame, $J=\varepsilon_1+\varepsilon_2+\varepsilon_3=e_{01}+e_{23}+e_{45}$ and $J\wedge J=2(e_{0123}+e_{0145}+e_{2345})$, the diagonal terms vanishing. With $\mathrm{vol}=e_{012345}$: $\star e_{0123}=e_{45}$, $\star e_{0145}=e_{23}$ (the reordering moves $e_{23}$ past $e_{45}$, two transpositions of two elements each, sign $+$), and $\star e_{2345}=e_{01}$. **All three signs are $+$, so $\star(J\wedge J)=2J$ at the matching orientation and $-2J$ otherwise.** *And the $U(3)$ argument for $\epsilon_J$'s well-definedness is the right one: two $J$-adapted orthonormal frames differ by a $J$-unitary map, and $\det_{\mathbb R}U=\lvert\det_{\mathbb C}U\rvert^2>0$, so the induced orientation is frame-independent. Connectedness of $SO(6)$ is a different statement and does not supply this, exactly as the block says.*

> **BUT CASE 2 NEEDS STRICTLY LESS THAN (iv), AND THIS IS WORTH RECORDING.** *All the argument uses is that $\star_V(J\wedge J)$ is a NONZERO REAL MULTIPLE OF $J$, with no claim about which multiple.* **Given that alone, $J_i\wedge J_i=J_1\wedge J_1$ gives $\kappa_iJ_i=\kappa_1J_1$, so $J_i=cJ_1$ for a real $c$, and $J_i^2=J_1^2=-\mathrm{Id}$ forces $c^2=1$, hence $J_i=\pm J_1$.** *The constant $2$, the base sign, and the two-valuedness and well-definedness of $\epsilon_J$ are all decorative for the conclusion.* **And the surviving half has a one-line derivation that needs no frame at all**: $\star_V$ and $J\mapsto J\wedge J$ are $SO(6)$-equivariant, so $\star_V(J\wedge J)$ is fixed by the stabiliser $U(3)$ of $J$, and the $U(3)$-invariants of $\Lambda^2\mathbb R^6=\mathbb RJ\oplus\mathfrak{su}(3)\oplus(\Lambda^{2,0}\oplus\Lambda^{0,2})_{\mathbb R}$ are the line $\mathbb RJ$. It is nonzero because $\star_V$ is injective and $J\wedge J\wedge J=6\,\mathrm{vol}\ne0$. *Recorded as a remark on what the debt costs, not as a substitute for the block's computation, which is correct and shorter to check.*

**Which leaves the debts in this shape:** (i) and (ii) are short, correct and load-bearing; (iii) is correct and unused; (iv) is correct, and only its weakest clause is used. *[lean/INDEX.md](../lean/INDEX.md) already confines the debt to the case that needs it, `scalar_case_empty` taking `StarWedgeIdentity` as an explicit hypothesis, and [L193](../findings/diagonal-half.md)'s `starWedge_of_adjugate` reduces it further.* **Nothing here is left owing that the conclusion rests on.**

## 9. The joint conclusion

**The composition is valid, and it is exact rather than approximate.** L194 says every rank-three $W\in\mathcal W_n$ has $\Phi(\omega_1)=\Phi(\omega_2)=\Phi(\omega_3)$, that is, equal squares and equal self-wedges. The eigenforms are orthonormal by construction, and equal squares give $\operatorname{im}\omega_i=\operatorname{im}A=V$ for each $i$, so at $\dim V=6$ every hypothesis of L184 is met and each $\omega_i$ has rank exactly six. **L184 then returns a contradiction, so the rank-three branch is empty at $\dim V=6$.**

**L184 covers exactly the branch L194 leaves, and no less.** *Its hypotheses are the orthonormality, the common six-dimensional support and the two coincidences, all of which L194 supplies; it uses nothing further, and in particular no Weyl condition, so it also covers strictly more than the corollary needs.* **The reach is exactly $\dim V=6$**: $\dim V$ is even because $V$ is the image of a skew map, $\dim V=2$ puts three orthonormal forms in a one-dimensional $\Lambda^2V$, $\dim V=4$ is INHABITED by the $\Lambda^+\mathbb R^4$ family, and $\dim V\ge8$ is untouched because the trichotomy is a split on the three values that six dimensions supply.

> **AND THE CONDITIONALITY IN L194'S CLOSING BOX IS AVOIDABLE, WHICH IS THIS REVIEW'S ONE ACTIONABLE EDIT.** *The box reads "the rank-three branch at $\dim V=6$ is empty, CONDITIONAL ON L184, which is itself unaudited and says so".* **Apply [L191](../findings/diagonal-half.md) to the pair $(\omega_1,\omega_2)$ instead**: its hypotheses are a common six-dimensional support, $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$, which are precisely what L194 delivers, and its conclusion $\omega_2=\pm\omega_1$ contradicts $\langle\omega_1,\omega_2\rangle=0$ at once. *L191 is Gate 2 passed by [r808](REVIEW_r808.md) and [r809](REVIEW_r809.md).* **So the composition rests on an audited lemma and the qualifier can go**, and the third form is not even needed.

## 10. Falsifiers, and what I did to look for them

**L194 would be falsified by** a rank-three $W\in\mathcal W_n$ whose three images are distinct and collinear, equivalently by three orthonormal $2$-forms and nonzero weights summing to zero with $\sum\lambda_i\Phi(\omega_i)=0$ and the $\Phi(\omega_i)$ not all equal. *Equivalently again, by a skew $\omega$ at which $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2\ne2\langle\omega,\omega\rangle^2$, or by an error in L183's dichotomy.* **What I did:** derived the identity from the normal form at every $n$ (section 2), so no such $\omega$ exists; screened it at $n=2,\dots,9$; re-derived the elementary step and read the Lean term by term; re-derived L183's affine-dependence step from the givens; and checked the record's catalogue of rank-three objects, where the only inhabited family is coincident. **Given L183 and the identity, no falsifier can exist**, so the search is closed by proof rather than by failure to find one.

**L184 would be falsified by** three orthonormal $2$-forms on $\mathbb R^n$ with a common six-dimensional support, equal squares and equal self-wedges. **What I did:** re-derived all three cases independently of the block before comparing, checked the trichotomy is exhaustive, and probed the two places a near-miss could hide. *Case 1 has an orthonormal near-miss with equal squares at $c^2=(\tfrac12,\tfrac3{10},\tfrac15)$ that fails only on the wedges (section 7a), and case 3 has [r809](REVIEW_r809.md)'s, which fails only on the cross term (section 7c).* **Both confirm the block's account of which hypothesis does the work in each case, and neither survives the full hypothesis set.** *No search, sweep or falsifier hunt was run, the standing rule reserving those.*

## Discrepancies

**D1. L184's block header says "Unaudited" and it has had two Gate 2 rounds.** *Located:* [findings/diagonal-half.md](../findings/diagonal-half.md), the italic provenance line immediately under the L184 heading: "*Derived 2026-09-08 while L183's Gate 2 ran. **Unaudited**, and the three cases below are separable*". *Exhibited:* [findings/INDEX-results.md](../findings/INDEX-results.md)'s row 184 reads "GATE 2: every case SOUND" and then "SECOND GATE 2 on the strengthened statement and case 1's Weyl-free route"; [reviews/INDEX.md](INDEX.md) carries [r781](REVIEW_r781.md) and [r782](REVIEW_r782.md) as Gate 2 on L184, the second verdicted "UPHELD ON CORRECTION"; the block's own mechanism box credits both by name; and the same file states elsewhere that L184 closes the coincident case "GATE 2 PASSED". *Argued the opposite:* the sentence is a derivation note in the past tense, so "Unaudited" could be read as frozen provenance describing 2026-09-08. **That reading fails on the format**, because the identical italic slot in L185, L190 and L191 carries live Gate 2 status, and it fails on consequence, because L194's closing box reads it as live and inherits a conditional from it, as did this brief. **REAL, documentation, and propagating.**

**D2. [lean/INDEX.md](../lean/INDEX.md)'s PhiSphere row says the identity is stated at no dimension but four.** *Located:* the "I69 (Phi sphere)" row, "**WHAT IT DOES NOT STATE**: the identity at any dimension but four." *Exhibited:* [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) carries `phi_sphere6`, the same identity over all fifteen index sets at $\dim=6$, closed by `ring`; and [conventions.md](../findings/conventions.md) says in terms that the file "proves the identity at $\dim=4$ and $\dim=6$". *Argued the opposite:* the row may simply predate `phi_sphere6`, in which case it is stale rather than wrong in intent. **It is still false as it stands and it contradicts the conventions file**, and the row is the thing a reader consults for what is typed. **REAL, documentation, low severity.**

**D3. `L194Statement.lean` holds the finite-stabiliser exhibit rather than L194.** *Located:* [lean/HamiltonsCubic/Results/L194Statement.lean](../lean/HamiltonsCubic/Results/L194Statement.lean), indexed in [lean/INDEX.md](../lean/INDEX.md) as "finite-stabiliser exhibit" with "**statement: NOT a numbered result**", while the numbered L194's Lean is [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean). *Exhibited:* the index row itself records the history, "an earlier version of this row cited `L194` before [findings/INDEX-results.md](../findings/INDEX-results.md) had assigned it", and [findings/INDEX-results.md](../findings/INDEX-results.md) has since assigned 194 to this lemma. *Argued the opposite:* the index already flags it, so a reader who consults the index is not misled, and the exhibit earns no id so no result is misnumbered. **The filename is nonetheless what a reader greps for**, and two different objects now answer to `L194` on disk. **REAL, navigational, low severity, no mathematical content.**

**D4, WITHDRAWN as a defect.** *The elementary-step box parametrises "the line through $\Phi_3$ and $\Phi_2$", which is not determined when $\Phi_2=\Phi_3$, yet $\Phi_2=\Phi_3$ is one of its own three conclusions.* **Withdrawn because the box runs inside L183's distinct branch, where $\Phi_2\ne\Phi_3$ is a hypothesis**, so the parametrisation is legitimate and the third alternative is simply the one that cannot arise. *Recorded as a wording note only: [CollinearSphere.lean](../lean/HamiltonsCubic/Results/CollinearSphere.lean) states the collinearity as $x-z=t\cdot(y-z)$, which is well posed at $y=z$, and the prose would read better in that form.*

## Verdict

**L194: CONFIRMED.** *The identity is true at every skew $\omega$ and every $n$, the constant is $2$, the norm is $\lVert\cdot\rVert_\perp$ and naming it is load-bearing rather than pedantic. The $S^2$ factor is Frobenius and the record's half-trace rule correctly does not travel there. The elementary step is correct and machine-checked with no gap. The witness sits in the surviving branch. No step uses a dimension restriction. Nothing in the record's catalogue falsifies it, and given L183 nothing can.* **Two things are stronger than the block claims**: L183's collinearity is inner-product-free rather than merely norm-independent, and the weighted route of section 3 gives all three images equal in one step without the exactly-two-coincident note.

**L184: CONFIRMED, all three cases.** *The trichotomy is exhaustive and Weyl-free, each case closes, each states its hypotheses, and each uses $\dim V=6$ where and only where it says it does. The cross-term sequencing in case 3 is load-bearing and correctly ordered, and the near-miss confirms it. Of the four declared debts, (i) and (ii) are load-bearing and correct, (iii) is decorative, and (iv) is correct with only its weakest clause consumed.*

**The joint conclusion holds: the rank-three branch is empty at $\dim V=6$, inhabited at $\dim V=4$, and open at $\dim V\ge8$.** **The one edit owed is L194's closing box**, which should route the composition through [L191](../findings/diagonal-half.md) rather than L184 and drop the conditional, and L184's header should stop saying it is unaudited.
