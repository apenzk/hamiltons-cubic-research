# Review r732, Lemma L161, $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$ at every $n\ge6$

**Verdict: CONFIRMED as a statement and as a proof, with the lemma's account of its own novelty REFUTED.** The citation holds at source, no hypothesis of Fox Theorem 1.3 fails against $(\mathcal W_n,\circ,\langle\cdot,\cdot\rangle)$, no unit is needed anywhere, no normalisation factor goes missing, and the evaluation is a rational-function identity in $p$ and $q$. What breaks is the sentence *"The step the record was missing is that $\kappa_n$ does not depend on $W$"*: the record owns that step, Gate 2 landed, in [second-order.md](../findings/second-order.md), whose own text says it had by then been re-derived unwittingly three times.

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| C1 | Fox Theorem 1.3 says what the lemma quotes, and applies to this algebra | **CONFIRMED at source** |
| C2 | No unit is required by Theorem 1.3 or anything its proof invokes | **CONFIRMED at source** |
| C3 | The irreducibility hypothesis holds at every $n\ge6$, both parities | **CONFIRMED**, $O(n)$ is what Fox uses and what is available; $SO(n)$ would also serve from $n=5$ |
| C4 | Commutative and metrized, from the definitions | **CONFIRMED**, Fox Theorem 5.4 proves both; the record's own conventions carry the same two facts |
| C5 | The $4\times$ normalisation gap costs the argument a factor | **REFUTED**, only proportionality is imported, so the factor cancels before it can be dropped |
| C6 | The ten summands are the whole of $\mathcal W_n$ | **CONFIRMED**, the dimensions sum to $\dim\mathcal W_n$ identically in $p,q$ |
| C7 | The ten $L_e$-values are correct, the four zeros genuinely zero | **CONFIRMED, and overdetermined**, trace-freeness forces the four zeros identically in $p,q$, and a compensated perturbation of $\lambda_m$ breaks $(p,q)$-independence |
| C8 | $\theta^2\mathop{\mathrm{tr}}(L_e^2)=\frac{(n-1)(2n-1)}4$ identically in $p,q$ | **CONFIRMED symbolically** |
| C9 | *"The step the record was missing is that $\kappa_n$ does not depend on $W$"* | **REFUTED**, the step is on the record and Gate 2 landed |
| C10 | *"Both hypotheses were already checked against this algebra in the reference notes"* | **REFUTED AS STATED**, the notes check them for $SO(n)$; Fox checks them himself, for $O(n)$, inside Theorem 1.3 |
| C11 | The scope $n\ge6$, and $n=4$ as Fox Theorem 1.5(2) | **CONFIRMED with a normalisation trap left open**, Fox's $21/16$ is $21/4$ in this record's metric, and the lemma prints neither conversion nor value |
| C12 | The citation to [L27](../findings/nondegeneracy.md) covers $n=6$ | **REFUTED AS STATED**, L27's statement excludes $(3,3)$, the only split $n=6$ has |

## C1, C2, the citation, read at source

The paper text is [fox-1901.04012.txt](https://arxiv.org/abs/1901.04012). Theorem 1.3 is at line 159 and reads, verbatim: *"Let $(V,h)$ be a Euclidean vector space of dimension at least 4. The algebra $(\mathrm{MC}_W(V^*),*)$ is exact and Killing metrized. Moreover: (1) The Killing form $\tau_*(X,Y)=\mathop{\mathrm{tr}}L_*(X)L_*(Y)$ is a nonzero multiple of $\langle\cdot,\cdot\rangle$. (2) If $\dim V>4$, then $(\mathrm{MC}_W(V^*),*)$ is simple."*

**The theorem is stated for this algebra, not for a general algebra the record must then fit.** $\mathrm{MC}_W(V^*)$ is the kernel of the Ricci trace inside the metric curvature tensors (the record's $\mathcal W_n$) and Lemma 5.7 (line 813) is what makes it a subalgebra. So the lemma's hypothesis-checking labour is Fox's, already done, and part (1) is exactly the clause L161 consumes.

**No unit, anywhere.** Fox defines *exact* at line 141 ($\mathop{\mathrm{tr}}L_\circ(x)=0$ for all $x$) and adds in the same sentence: *"Note that an exact algebra is nonunital."* Theorem 1.3 concludes exactness, so the theorem's own conclusion forbids a unit rather than presupposing one. Reading up the chain: Theorem 1.3's proof invokes Theorem 5.4 (commutativity, metrization, $O(h)$ automorphisms), Lemma 10.1 (a nontrivial idempotent, which supplies nontriviality of the multiplication), and Theorem 3.2. **Theorem 3.2's proof, at line 440, is four lines of Schur and uses no unit, no associativity, no power-associativity and no idempotent**, the idempotent appears only in an alternative argument for $\kappa\ne0$, and even there it is an idempotent, not a unit. *The route that died on a unital hypothesis died on the Peirce/Jordan cap, a different citation, and [L13](../findings/curvature-invariants.md)'s block already records that death and its reason.*

**The one thing the lemma leaves unsaid is that Theorem 3.2 needs no connectedness either.** Connectedness and simplicity of $G$ are hypotheses of Theorem 3.1 (simplicity of the algebra), which L161 does not consume. Since $O(n)$ is disconnected, that distinction is load-bearing and it comes out the right way.

## C3, irreducibility: which group, at which $n$

**Fox's proof of Theorem 1.3 names $O(n)$ and uses it for part (1).** Line 164: *"The group $O(n)=O(V,h)$ acts on $\mathrm{MC}_W(V^*)$ isometrically and irreducibly."* $SO(n)$ enters only for part (2), where Theorem 3.1 wants a connected simple group. **So the hypothesis needed is the one available, and the direction of the brief's worry is the harmless one:** $O(n)$-irreducibility is weaker to demand than $SO(n)$-irreducibility, and $O(n)$-irreducibility is what Theorem 3.2 is fed.

The record's own remark, *"the group is $O(n)$, not $SO(n)$"*, and the two-dimensional space of invariant symmetric forms, is an $n=4$ statement and is recorded as such at [second-order.md](../findings/second-order.md), which reports the commutant of $\mathcal W_n$ under $SO(n)$ as $1$ at $n=5\ldots10$ with $n=4$ returning $2$ as a control. **At every $n$ in L161's range both groups serve.**

**And real irreducibility is enough, which is worth stating because Fox's proof turns on it.** Theorem 3.2 defines $\mathcal A$ by $\tau_\circ(x,y)=h(\mathcal Ax,y)$, notes $\mathcal A$ is $G$-invariant and $h$-self-adjoint, hence semisimple with real eigenvalues, and concludes $\mathcal A=\kappa\,\mathrm{Id}$ from irreducibility over $\mathbb R$ alone. *An $h$-self-adjoint element of the commutant is a real scalar whether the commutant is $\mathbb R$, $\mathbb C$ or $\mathbb H$, since the fixed set of the adjoint involution on a real division algebra is $\mathbb R$*, so no absolute-irreducibility claim is needed and none is made. This is the same step [L27](../findings/nondegeneracy.md) uses on its summands, and there it is stated in exactly this generality.

## C4, commutative and metrized

Both are Fox Theorem 5.4 (line 762), proved rather than assumed: $X*Y=\widehat X(Y)$ is symmetric by the display (5.11), and (5.12) reads $\langle X*Y,Z\rangle=\langle X,Y*Z\rangle$ from self-adjointness of $\widehat Y$, *"show[ing] the complete symmetry of $\langle X*Y,Z\rangle$"*. **The record has both facts independently**, [conventions.md](../findings/conventions.md) tables $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ as *"the fully symmetric trilinear form"* with the symmetry argument given, and $\circ$ as the polarisation $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, which is symmetric by construction. Euclidean is the Frobenius metric's positive definiteness. Nontriviality is $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}\ne0$, on the record and independent of Fox's Lemma 10.1.

## C5, the normalisation, and why nothing goes missing

**The lemma imports proportionality, not a constant, so the $4\times$ never enters.** Fox's conclusion is that $\tau_*$ is *some* nonzero multiple of the complete-contraction metric; since that metric is a positive multiple of the record's Frobenius metric, $\tau_*$ is a multiple of the Frobenius metric too, and the multiple is then read off by evaluating at $W_{p,q}$ **in the record's own normalisation throughout**. The same immunity covers the product: if the record's $\circ$ were $c\,*$, then $L_\circ=cL_*$ and $\tau_\circ=c^2\tau_*$, still a multiple of the same metric. *So the omission the brief points at is an omission of something the argument does not use.*

**Where it would matter is the one place the lemma actually touches it, the $n=4$ line.** Fox's Remark 1.4 gives $\kappa=21/16$ at $\dim V=4$, in his metric; the lemma's own $\kappa_n$ at $n=4$ is $21/4$. Those agree exactly under the $4\times$ conversion, and that agreement is a genuine external anchor: it simultaneously confirms the conversion and the formula at a dimension outside the derivation's family, and it forces $c^2=1$ on the product normalisation. **The lemma cites Theorem 1.5(2) for $n=4$ and prints neither the value nor the conversion**, so a reader who follows the citation finds $21/16$ against a formula that says $21/4$ and has nothing on the page to reconcile them. [algebra.md](../findings/algebra.md) states the conversion; L161 should quote it.

## C6, C7, the spectrum, checked against the definitions and then overdetermined

With $d_m=\tfrac{m(m+1)}2-1$, $e_m=\tfrac{m(m-1)}2$, $\dim X_m=\tfrac{m(m^2-4)}3$ and $\dim\mathrm{Weyl}_m=\tfrac{m(m-3)(m+1)(m+2)}{12}$, the ten summand dimensions sum to $\dim\mathcal W_n$ **identically in $p$ and $q$**, verified symbolically. So the list is complete and the summands, being pairwise non-isomorphic irreducibles under $O(p)\times O(q)$, are orthogonal; $L_e$ is a scalar on each; and $\mathop{\mathrm{tr}}(L_e^2)$ is the dimension-weighted sum of squares. *The $1$ on $\langle W\rangle$ is right and is neither $\theta$ nor $1/\theta$: $L_e=\theta^{-1}L_W$ and $L_WW=Q(W)=\theta W$ at unit norm, so $L_eW=W$.*

**Two identities hold as rational functions in $p,q$ on the record's values, and each is an independent test of them.**

- $\mathop{\mathrm{tr}}(L_e)=1+\tfrac{pq}2+d_p\lambda_p+d_q\lambda_q+(e_pe_q-d_pd_q)\mu=0$.
- $\theta^2\mathop{\mathrm{tr}}(L_e^2)=\tfrac{(n-1)(2n-1)}4$.

**The four zeros are forced by the first, and not merely granted.** Carrying unknown values $a,b,c,d$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$, the trace is $\tfrac1{12}\big[a(p^4-7p^2-6p)+b(q^4-7q^2-6q)+4cpq(p^2-4)+4dpq(q^2-4)\big]$, and those four polynomials are linearly independent, so vanishing identically in $p,q$ gives $a=b=c=d=0$. *This is a check the lemma's chain does not use and which its two grants (the $\mathrm{Weyl}_p$ vanishing and the $X_p\otimes\mathbb R^q$ index computation), did not have available.*

**And $\lambda_m$ and $\mu$ are pinned jointly.** Perturbing $\lambda_m\mapsto\lambda_m+\epsilon$ on both $S^2_0$ summands and solving the trace identity for the compensating shift in $\mu$, the second moment at $n=12$ differs between the splits $(3,9)$ and $(6,6)$ by $\tfrac{11\epsilon(41773\epsilon+41118)}{13230}$, zero only at $\epsilon=0$ and at a spurious second root, which is itself killed at $n=14$ by comparing $(3,11)$ against $(7,7)$. **So the ingredient data is overdetermined by two identities and passes both**; a wrong $\lambda_m$ or $\mu$ would have to break the $(p,q)$-independence that Fox's theorem predicts.

*Screened, seconds of exact symbolic arithmetic on objects constructed for the purpose; reported as a screen, and the positive content above rests on the symbolic identities rather than on the screen.*

## C8, the evaluation

Verified as an identity of rational functions in $p,q$, not at sampled splits:

$$\theta^2\mathop{\mathrm{tr}}(L_e^2)=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}\left[1+\frac{pq}4+d_p\lambda_p^2+d_q\lambda_q^2+(d_pd_q+e_pe_q)\mu^2\right]=\frac{p^2}2+pq+\frac{q^2}2-\frac{3p}4-\frac{3q}4+\frac14,$$

which is $\tfrac{n^2}2-\tfrac{3n}4+\tfrac14=\tfrac{(n-1)(2n-1)}4$. The record's collapsed display for $\mathop{\mathrm{tr}}(L_e^2)$ agrees with the summand-by-summand sum.

**It is an identity, and its $(p,q)$-independence is a consequence rather than a coincidence.** Fox's theorem fixes $\kappa_n$ before a split is chosen, so constancy along $p+q=n$ is *predicted*; what the computation supplies is the value as a function of $n$, which nothing in the citation determines, Fox's own Remark 1.4 says so, and points at exactly this method: *"To calculate $\kappa$ it would suffice to calculate the eigenvalues on $\mathrm{MC}_W(V^*)$ of the operator $\widehat E$ associated with a nonzero idempotent."*

**$\theta^2$ is sourced and cross-checked.** [problem.md](../findings/problem.md) carries $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ from Nienhaus Proposition 2.25, and [graded-half.md](../findings/graded-half.md) derives it independently; it returns $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ at $p=q$ and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ at $p,q=\frac{n\mp1}2$, which are [conventions.md](../findings/conventions.md)'s two tabled values.

## C9, the novelty sentence, and this is where the lemma breaks

**L161 writes: *"The step the record was missing is that $\kappa_n$ does not depend on $W$."* The record was not missing it.** [second-order.md](../findings/second-order.md) carries a section titled *"Fox's trace identities, re-derived here"* which states

$$\mathop{\mathrm{tr}}(L_x)=0,\qquad\mathop{\mathrm{tr}}(L_xL_y)=\kappa_W\langle x,y\rangle,\qquad\kappa_W=\frac{(2n-1)(n-1)}4,$$

with the reason, *"the left side is an invariant form on an irreducible module"*, which is Fox's Theorem 3.2 argument, and the stamp *"Both identities are **Gate 2 landed**, audited independently by Reviewers 28 and 29"*. **Fifty lines earlier the same file writes: *"They have now been re-derived unwittingly three times in this project; the section below is the one that owns them."*** L161 is the fourth telling, and the only one that asserts the record lacked the step.

**The same sentence is in [plan.md](../plan.md)'s I58 row** (*"never used the fact that makes the answer point-independent"*) and it is false there too.

**What is genuinely new survives, and it is smaller than the lemma claims.** With $W$-independence already held, the even-$n$ proof came from summing Peirce families at the balanced product, which exists only at even $n$; the odd case needed nothing but an *unbalanced* split, and that is L161's actual step. The lemma should say so: **the missing step was that any $(p,q)$ with $p,q\ge3$ serves, not that the constant is point-independent.** *The correction strengthens nothing and weakens nothing in the conclusion; it changes what a later reader thinks the citation is for.*

## C10, C11, C12, three smaller defects

**C10.** *"Both hypotheses were already checked against this algebra in the reference notes"* is the weaker of the two available citations and it is checked for the wrong group. [notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md) verifies the hypotheses for $SO(n)$; Theorem 1.3's proof verifies them for $O(n)$ and does so inside the paper, for this algebra by name. **Cite Theorem 1.3's proof, which needs no external check at all.**

**C12.** L161 cites [L27](../findings/nondegeneracy.md) for the ten summands *"with $p,q\ge3$"*, but **L27's statement is $p,q\ge3$ with $(p,q)\ne(3,3)$, and $(3,3)$ is the only split $n=6$ admits.** So the lemma's own first dimension is outside the cited statement. *The substance survives*, L27's body says explicitly that at $(3,3)$ *"the decomposition holds and two scalars collide"*, the exclusion being about $\dim E(\tfrac12)$ and not about the summands or their eigenvalues, but the citation as written does not reach $n=6$ and should quote L27's body clause.

**C11.** The scope line is right: the evaluation needs $p,q\ge3$, every $n\ge6$ has the split $(3,n-3)$, and $n=5$ has none. *$\kappa_5$ is consumed nowhere*, the record's uses of the constant are [L13](../findings/curvature-invariants.md)'s ceiling and the moment bounds at $n\ge12$, but note that [second-order.md](../findings/second-order.md) prints $\kappa_5=9$ from the fitted closed form and reports the formula *"exact across $n=4\ldots13$"* by verification. **So after L161 the formula is proved at $n=4$ and at every $n\ge6$, and $n=5$ is the single dimension left standing on a numerical check, wedged between two proved ranges.** The lemma says $n=5$ *"is not settled here"*, which is accurate; it does not say that $n=5$ is now the only unsettled dimension, which is the useful form.

## The object that would falsify the lemma

**Two nonzero $W,W'\in\mathcal W_n$, some $n\ge6$, with $\mathop{\mathrm{tr}}(L_W^2)/\lVert W\rVert^2\ne\mathop{\mathrm{tr}}(L_{W'}^2)/\lVert W'\rVert^2$.** By Fox Theorem 3.2 such a pair exists only if $\mathcal W_n$ fails to be $O(n)$-irreducible, or $\circ$ fails to land in $\mathcal W_n$, or $\langle X\circ Y,Z\rangle$ fails total symmetry, so a falsifier is a reducing subspace, a product leaving the space, or an asymmetry, and not a second tensor with a different trace.

**Failing that, the sharp falsifier of the value is a split.** One pair $p,q\ge3$ at which $\theta^2\mathop{\mathrm{tr}}(L_e^2)\ne\frac{(n-1)(2n-1)}4$, which, the identity being symbolic in $p,q$, requires one of [L27](../findings/nondegeneracy.md)'s ten eigenvalues or $\theta^2$ to be wrong, and would then show up first as a disagreement between two splits of one $n$, e.g. $S^3\times S^9$ against $S^6\times S^6$ at $n=12$.

## What the lemma should read

Three edits, none touching the statement:

- Replace *"The step the record was missing is that $\kappa_n$ does not depend on $W$"* with the true delta: **the constant's $W$-independence is [second-order.md](../findings/second-order.md)'s, Gate 2 landed, and what was missing is that the evaluation may be taken at an unbalanced split, which is what reaches odd $n$.**
- Cite **Fox Theorem 1.3 and its proof** for the hypotheses, rather than the reference notes, and quote L27's body for $(3,3)$ so the citation reaches $n=6$.
- Add the normalisation conversion to the $n=4$ line: **Fox's $21/16$ is $\tfrac{21}4$ in this record's metric**, which is the formula's value at $n=4$ and is an external anchor rather than a restatement.
