# Reviewer 153, Gate 2 on the three-label discrepancy, the $\perp$-sum closure, and the subalgebra witnesses

**Headline: the discrepancy resolves, and it resolves in favour of B1 already being answered.** Two of the three labels name the *same* operator and I identify them representation-by-representation from [Petersen–Stanfield](https://arxiv.org/abs/2508.11236) p. 9, no computation, no coincidence of $\theta$. The third label was refuted on this record four cycles ago and [target.md](../findings/target.md) says so in bold; the discrepancy table quotes it as live anyway. The $\sqrt{6/5}$ point is an **irreducible critical point that is the Weyl operator of no symmetric space**, so the object [B1](../plan.md) says the programme has never constructed has been on file since Reviewer 78's census.

| claim | verdict |
|---|---|
| 1. Three incompatible labels on $\theta=\sqrt{6/5}$ | **RESOLVED**, one label dead (already), two labels are one point; no contradiction remains |
| 1b. Does the record hold B1's object? | **YES**, the $\sqrt{6/5}$ point itself, provably, and the argument is three lines |
| 2. $\perp$-sum isotropy arithmetic | **CORRECT in direction, unsourced in detail**, the five numbers have no artefact anywhere in the repo |
| 2b. Reviewer 127's scale-invariance, as generalised | **MISAPPLIED**, it is a statement about the diagonal locus and one quantity; the conclusion it is cited for needs no citation |
| 2c. "Reducibility is itself a strong symmetry" | **TOO STRONG**, a $\perp$-sum leaves a $\ge k$-dimensional space of equivariant tensors free where an irreducible point leaves $1$ |
| 3. Casimirs have two eigenvalues; three witnesses | **CONFIRMED**, and two of the three witnesses are redundant, the third telling of that |
| (b) Section 1 has no nonzero grade | **CORRECT as a grade reading**, but the item *numbering* is broken three ways and "the work goes to item 1" points at the retired item |

---

## CLAIM 1, the three labels, settled

### Label A, $Q_3=\widetilde G_2(\mathbb R^5)$, is dead and this record killed it

[target.md](../findings/target.md) carries this label **only inside the table that refutes it**. Its column headings are "as recorded" against "exact truth", and the exact truth is $\theta^2=15/26$, $\theta=0.759554525$, $S_{\mathfrak{mmm}}=30$. Reviewer 80 built $Q_3$ three independent ways ($SO(5)/(SO(2)\times SO(3))$, $Sp(2)/U(2)$, and a uniform $\widetilde G_2(\mathbb R^k)$ family) and target.md states the conclusion in bold: *"So $Q_3$ beats $\mathbb{CP}^3$ is false, it sits far below."*

**So the discrepancy table in [graded-half.md](../findings/graded-half.md) and its copy at [plan.md](../plan.md) §2 B1 both cite a refuted label as a live identification.** The line "at least one label is wrong" was answerable by reading the file it cites, in the paragraph it cites. This is question (a): the resolution of one third of the discrepancy was already on the record when the discrepancy was written down.

### Labels B and C name one operator, and the identification is exact

Not isospectrality, a match of eigenspaces as isotropy representations. Both sides are the same $\mathfrak{so}(3)$-decomposition of $\mathfrak{so}(6)$.

**Petersen–Stanfield's side.** Their p. 9 gives Jensen's second metric as $SU(2)^3/\Delta SU(2)$ with the metric induced by the Killing form of $SU(2)^3$, nearly Kähler, Einstein constant $\tfrac5{12}$. Their reductive complement splits as $\mathfrak p=\mathfrak p_1\oplus\mathfrak p_2$ with $\mathfrak p_1\cong\mathfrak p_2\cong\mathfrak{su}(2)$ as $\mathrm{Ad}(H)$-representations, and
$$\Lambda^2\mathfrak p=\Lambda^2\mathfrak p_1\oplus\Lambda^2\mathfrak p_2\oplus(\mathfrak p_1\wedge\mathfrak p_2)=\mathfrak{su}(2)^{\oplus3}\oplus\mathrm{Sym}^2_0(\mathfrak{su}(2))\oplus\mathbb R,$$
dimensions $3+3+3+5+1=15$. Their $R$ is $\tfrac1{48}$ times $\mathrm{diag}\big(\left[\begin{smallmatrix}9&5\\5&9\end{smallmatrix}\right],4,-2,4\big)$, so:

| block | $SO(3)$-type | $\dim$ | $R$ | $W=R-\tfrac1{12}\mathrm{Id}$ |
|---|---|---|---|---|
| diagonal of $\Lambda^2\mathfrak p_1\oplus\Lambda^2\mathfrak p_2$ | adjoint | $3$ | $\tfrac{14}{48}=\tfrac7{24}$ | $+\tfrac5{24}$ |
| anti-diagonal, plus $\Lambda^2$-part of $\mathfrak p_1\wedge\mathfrak p_2$, plus $\mathbb R$ | $3+3+1$ | $7$ | $\tfrac4{48}=\tfrac1{12}$ | $0$ |
| $\mathrm{Sym}^2_0$ part of $\mathfrak p_1\wedge\mathfrak p_2$ | $\mathrm{Sym}^2_0$ | $5$ | $-\tfrac2{48}=-\tfrac1{24}$ | $-\tfrac18$ |

($\operatorname{tr}R=\tfrac{30}{24}$ over $15$ gives mean $\tfrac1{12}$; Einstein forces $\mathrm{Ric}_0=0$, so the Weyl part is $R$ minus that multiple of the identity.)

**The record's side.** $(\mathfrak{su}(3),\mathfrak{so}(3))$ is used as a **subalgebra pair inside $\mathfrak{so}(6)$**, via $SU(3)\curvearrowright\mathbb C^3=\mathbb R^6$, with $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ extended by $0$. Here $\mathfrak{su}(3)=\mathfrak{so}(3)\oplus i\,\mathrm{Sym}^2_0(\mathbb R^3)$ with $p=\dim\mathfrak{so}(3)=3$, $q=5$, and the complement in $\mathfrak{so}(6)$ has dimension $15-8=7$. Restricting $SO(3)\subset SU(3)$ to $\mathbb R^6=\mathbb R^3\oplus\mathbb R^3$ (two copies of the standard representation),
$$\mathfrak{so}(6)=\Lambda^2\mathbb R^3\oplus\Lambda^2\mathbb R^3\oplus(\mathbb R^3\otimes\mathbb R^3)=\underbrace{3+3}_{\text{adjoint}}\ \oplus\ \underbrace{\mathbb R\oplus\Lambda^2\oplus\mathrm{Sym}^2_0}_{1+3+5},$$
the identical list. $\mathfrak{so}(3)$ is the diagonal adjoint, $\mathfrak m$ is $\mathrm{Sym}^2_0$, and the $7$-dimensional kernel is anti-diagonal adjoint $+$ $\Lambda^2$ $+$ trace. Trace-freeness $3a+5b=0$ forces $(a,b)\propto(5,-3)$, i.e. $(\tfrac5{24},-\tfrac18)$ at Jensen's normalisation.

**Conclusion.** $\Delta SU(2)\subset SU(2)^3$ acting on $\mathfrak p_1\oplus\mathfrak p_2$ and $SO(3)\subset SU(3)$ acting on $\mathbb R^3\oplus\mathbb R^3$ are the **same** $SO(3)\subset SO(6)$, the two block decompositions agree representation by representation, and the eigenvalues agree on each. **Labels B and C are one point.**

This matters because [REVIEW_r111](REVIEW_r111.md) correctly warned that value coincidence is not orbit identity here, $\mathbb{HP}^2$ and $S^3\times S^5$ are *isospectral* and distinct. That warning is answered: the identification above never uses $\theta$, and matching the isotropy representations is strictly more than matching spectra.

### The "symmetric?" column is a category error, and that is the whole discrepancy

A critical point of $P$ is an algebraic Weyl operator. **"Symmetric space" is a property of a realising Riemannian manifold, and the realisation is not unique**, so the column has no well-defined entry. There is no contradiction to resolve between B and C:

- as an algebra pair, $(\mathfrak{su}(3),\mathfrak{so}(3))$ **is** a symmetric pair, that is what makes $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ and hands the construction its $S=0$;
- as a metric, the operator is realised by Jensen's second Einstein metric on $S^3\times S^3$, which is **not** symmetric.

Both are true of the same $W$. The record already knew this and stated it: *"a non-symmetric homogeneous Einstein metric can have a graded Weyl operator ... gradedness is strictly weaker than symmetry of the underlying space."*

**Two subsidiary answers the brief asks for.**
- $SU(3)/SO(3)$ is indeed $\dim5$, and the row is **not** mislabelled. $n=6$ is the ambient dimension of the Weyl arena $\Lambda^2\mathbb R^6$, not the dimension of a quotient. The table's "dimension of the named space" column reads a subalgebra pair as a quotient.
- $\widetilde G_2(\mathbb R^5)$ and the measured point do **not** coincide: $\theta$ is an $O(6)$-invariant and $0.759554525\ne1.095445115$.

### DOES THE RECORD HOLD B1's OBJECT? Yes, and it is this point

[plan.md](../plan.md) §2 B1 asks for *an irreducible critical point that is not a symmetric space*, and says the programme has never constructed one. The $\sqrt{6/5}$ point is one. Three steps, all derivations:

**(1) Critical.** Residual $3\times10^{-16}$, on the record from two independent constructions.

**(2) Irreducible.** $\dim\mathrm{Weyl}_k=0$ for $k\le3$, so in a $\perp$-decomposition $\mathbb R^6=\mathbb R^{n_1}\oplus\mathbb R^{n_2}$ with both summands carrying nonzero Weyl one needs $n_i\ge4$, hence $n\ge8$. **So no critical point at $n=6$ or $n=7$ is a $\perp$-sum of two nonzero blocks at all.** The remaining route to reducibility is padding, and $W$ is unpadded: $\mathfrak{su}(3)$ acts irreducibly on $\mathbb R^6$, so it preserves no $\mathbb R^5$, so $W$ is not supported in $\Lambda^2\mathbb R^5$. *(The $7$-dimensional kernel is a kernel, not a padding, it is $\mathfrak{su}(3)^\perp$ inside $\mathfrak{so}(6)$, which meets every $\Lambda^2\mathbb R^5$.)*

**(3) Not a symmetric space, and this is finite.** Compact irreducible symmetric spaces of dimension $6$, from Cartan's list: $S^6$ (AI/BDI $(1,6)$), $\mathbb{CP}^3$ ($=SU(4)/S(U(1)\times U(3))=SO(6)/U(3)$), and $Q_3=\widetilde G_2(\mathbb R^5)=Sp(2)/U(2)$ (BDI $(2,3)$ $=$ CI $n{=}2$). No group-type entry exists, since no compact simple Lie group has dimension $6$. Their $\theta$: $0$, $\sqrt{10/9}=1.054092553$, $\sqrt{15/26}=0.759554525$. For the reducible ones this record already proves the maximum: [graded-half.md](../findings/graded-half.md)'s dimension count puts the minimum of $\lVert W\rVert^2$ over **all** reducible compact symmetric spaces at the balanced sphere product, i.e. $\theta\le\theta_0(6)=1.054092553$. **Every $6$-dimensional compact symmetric space has $\theta\le1.0541<1.0954451$**, and $\theta$ is an $O(6)$-invariant. $\square$

**So B1's object exists on the record, it is the point whose label the plan flagged as unresolved, and no construction is needed.** The plan's sentence *"the programme has never constructed one"* is false, and *"resolving it is cheaper than constructing a new point"* was right for a stronger reason than it knew.

**Two honest limits on this.** (i) B1's *operative* content (*"symmetry fixes every equivariant quantity before criticality is consulted"*), is a statement about $\mathrm{Stab}_{O(n)}(W)$, which for this point contains $SO(3)$, fraction $3/15=0.20$ against $\mathbb{CP}^3$'s $9/15=0.60$. It is markedly less symmetric than the catalogue, but it is not isotropy-free. (ii) The **24 kernel-free, unpadded, ungraded critical points at $n=6$** ([nondegeneracy.md](../findings/nondegeneracy.md), $\theta=0.104886$) are irreducible by step (2) above with nothing owed, and are far better candidates on isotropy. Whether they are non-symmetric needs the same finite check at their $\theta$, which I did not run. **B1 should be restated in terms of the stabiliser**, and once it is, [REVIEW_r147](REVIEW_r147.md)'s finding applies verbatim: the record answers it and the plan records it as open.

---

## CLAIM 2, the $\perp$-sum closure, commit 0380f5e

### The isotropy arithmetic: direction right, numbers unsourced

**The structural half is correct.** For $W=\bigoplus_ic_iW_i$ on orthogonal blocks with every $W_i$ kernel-free and the blocks pairwise non-isomorphic, the decomposition is recoverable from $W$, so any $g\in\mathrm{Stab}_{O(n)}(W)$ permutes blocks; distinctness kills the permutation, so $g$ preserves each block and $\mathrm{Stab}(W)=\prod_i\mathrm{Stab}_{O(n_i)}(W_i)$. **The kernel-free hypothesis is load-bearing and is not stated**: if two blocks carry kernel directions, rotations mixing those directions across blocks also fix $W$, and the stabiliser is strictly larger than the product. Given that, $\dim\mathrm{Stab}=\sum_is_i$ grows linearly in $k$ while $\dim\mathfrak{so}(n)$ grows quadratically, so the fraction $\to0$. That much is elementary and needs no measurement.

**The five numbers have no artefact.** `0.40, 0.20, 0.14, 0.11, 0.097` appear in [plan.md](../plan.md) line 257 and in the commit message of 0380f5e and **nowhere else in the repository**, no script, no findings file, no reviewer report. The commit touched `plan.md` alone, $+5$ lines. *One number, to show the sequence is not the natural reading: for $k$ equal blocks of size $m$ the fraction is $2ks/(km(km-1))$, so $f_2/f_1=(m-1)/(2m-1)$, which is $<\tfrac12$ for every $m$ and can never give the recorded $0.40\to0.20$; the blocks must therefore be unequal in an unstated way, which the argument could not settle from the record.* $f_1=0.40$ is consistent with $S^3\times S^3$ at $n=6$ ($\dim(\mathfrak{so}(3)+\mathfrak{so}(3))/\dim\mathfrak{so}(6)=6/15$), but I could not reconstruct the rest.

### Reviewer 127's scale-invariance is being carried outside its scope

[REVIEW_r127](REVIEW_r127.md) says: *"the harmonic-law coefficients $c_i=\lambda/\lambda_i$ make the ratio $\mu/\lambda=\mu_i/\lambda_i$ **scale-invariant**, so a direct sum inherits each block's verdict unchanged."* Read in place, that is about **one specific quantity** ($\mu$ an eigenvalue of the vertex matrix $K$), on the **diagonal locus**, and the "verdict" inherited is the maximal-failure test of that report's Claim 3. Nothing in it concerns symmetry, irreducibility, or the class of B1 verdicts.

**The plan's conclusion does not need it.** *A $\perp$-sum is reducible by construction*, so it fails B1's irreducibility requirement definitionally, one line, no citation. The r127 attribution adds an appearance of derivation to a tautology and, read literally, asserts a generalisation r127 did not make.

### "Reducibility is itself a strong symmetry" is too strong, and the record names the quantity

The brief asks whether some quantity a $\perp$-sum fails to fix is fixed by an irreducible symmetric point. **Yes, and it is precisely the one [plan.md](../plan.md) itself identifies as the failure mechanism**: *"an isotropy-irreducible point makes any equivariant symmetric $2$-tensor a multiple of the identity."*

- $\mathbb{CP}^m$ and $\mathbb{HP}^2$ have $\dim\mathrm{Weyl}^{\mathfrak k(W)}=1$ ([target.md](../findings/target.md)), one free equivariant parameter.
- A $\perp$-sum of $k$ distinct blocks has $\dim\mathrm{Weyl}^{\mathfrak k(W)}\ge k$, since each $W_i$ is separately invariant and they are linearly independent.

So the two symmetries are not comparable in the direction the plan needs: reducibility **weakens** the constraint that the plan blames for the failure mode, by a factor of $k$. What reducibility does supply is a distinguished splitting, which is a real obstruction to B1, but the honest statement is *"a $\perp$-sum is reducible, and B1 asks for irreducible"*, not *"reducibility is itself a strong symmetry."* The blanket form would, taken at face value, also indict the balanced sphere product $S^{n/2}\times S^{n/2}$, which is the conjectured maximiser.

**And the closure was unnecessary.** The commit is graded *dead-end* for closing the $\perp$-sum route to B1, while B1's object sat in the record, flagged four lines below in the very paragraph the same commit left standing.

---

## CLAIM 3, the subalgebra route to (H), commits c655487 and f358f5f

**The eigenvalue argument is correct and is one line.** $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $\Pi_{\mathfrak h}$ an orthogonal projection of rank $r$ takes $c(1-\tfrac rN)$ on $\mathfrak h$ and $-c\tfrac rN$ on $\mathfrak m$, and for $0<r<N$ both are nonzero and distinct. So a Casimir has **exactly two** eigenvalues and is **nonsingular**; any graded critical point with three or more, or with a kernel, is not one. **CONFIRMED.**

**The three witnesses check out, and two are logically redundant.**

| witness | $\theta$ | certificate | needed? |
|---|---|---|---|
| $\mathbb{CP}^3$, $n=6$ | $1.054092553$ | three eigenvalues | **no**, below $\sqrt{3/2}$ |
| the $\sqrt{6/5}$ point, $n=6$ | $1.095445115$ | eigenvalues $(\tfrac5{24},0,-\tfrac18)$, mults $(3,7,5)$; $7$-dimensional kernel | **no**, below $\sqrt{3/2}$, *and* excluded by the cap |
| $S^5\times S^7$, $n=12$ | $1.2282390$ | isotropy $\mathfrak{so}(5)+\mathfrak{so}(7)$, $r=31$, family $\theta=1.2742878$ | **yes, alone sufficient** |

The claim has exactly two forms: unrestricted, and restricted to $\theta>\sqrt{3/2}$. $S^5\times S^7$ sits at $1.2282390>1.2247449$ and refutes both. The other two sit below the threshold and can refute only the unrestricted form, which $S^5\times S^7$ already refutes. **So the witness set is $\{S^5\times S^7\}$ and the other two rows are illustration.** $S^5\times S^7$ also carries the cleaner certificate: it is a *symmetric pair*, hence graded with nothing owed, where the $\sqrt{6/5}$ row is graded only in the weak $S=0$ sense that [REVIEW_r152](REVIEW_r152.md) §3 already flagged.

**The $\sqrt{6/5}$ witness is doubly redundant**, by the record's own note: at $n=6$ the cap $r\le n(n-2)/4=6$ forces any critical Casimir to $\theta\le\theta_0(6)=1.054092553<\sqrt{6/5}$, so no eigenvalue count is needed there at all.

**Question (a), third telling.** [graded-half.md](../findings/graded-half.md) already says *"the conclusion rests on $S^5\times S^7$"*; [REVIEW_r152](REVIEW_r152.md) already says *"the route is fully closed, but by $S^5\times S^7$ rather than by Jensen, and that closure was available before this cycle."* This report is the third time it is being recorded. **And claim 1's point is claim 3's second witness**, they are the same operator, so the brief's suspicion is correct.

---

## Question (b), section 1's grades, and a numbering defect underneath them

**The grade reading is correct.** Items $1$–$4$ all carry $0$ and item $5$ is handed off, so no item in [SECTION 1](../plan.md) has a nonzero grade. Each zero is earned rather than eager:

| item | zero factor | is it right? |
|---|---|---|
| 1. (H)'s gap as a subalgebra classification | attackable $=0$ | **yes**, $S^5\times S^7$ closes both forms, verified above |
| 2. (G) | attackable $=0$, margin $=0$ | **yes on margin**, $\lambda_{\max}=\tfrac12$ is attained on the whole orbit at *every* critical point ([REVIEW_r148](REVIEW_r148.md)), so it is the generic value; attackable $=0$ is a claim about the *named* routes and the banner says the item lives |
| 3. The target | margin $=0$ | **yes**, attained at $W_{\mathbb{CP}^2}$ |
| 4. Second-kind dichotomy | margin $=0$ | **yes**, equality on the whole product family |

**But the item numbers are broken three ways, and one of the breaks is load-bearing.**

- **`### 5.` and `### 6.` each occur twice**, "THE DEGREE-SIX INVARIANT SOS" and "$P$ is bi-spectral" are both item 5; "Lemma L24 as an exclusion device" and "B1. The diagonal half" are both item 6. So *"the bi-spectral reformulation, item 5"* and the grading table's *"5. Degree-six SOS"* are both literally correct and mean different things.
- **"B1" names two different things.** Section 1 heading 6 is *"B1. The diagonal half"*; section 2's B1 is *"A non-symmetric critical point."* This report's claim 1 concerns the second.
- **"Where the proof stands" uses a superseded numbering.** It calls the residual *item 1* and the degree-six SOS *item 3*, where the graded table has item 1 $=$ (H)'s gap (**retired**) and item 3 $=$ the target. The closing sentence **"They stay on the list as destinations; the work goes to item 1"** therefore directs the work to a struck-through, grade-$0$, retired item. It should read *item 3*.

The reading the brief proposes (that a section with no nonzero grade is the signal to work section 2), is right, and section 2 is where claim 1 lands.

---

## Disagreements, stated explicitly

1. I disagree with [plan.md](../plan.md) §2 B1's *"an irreducible critical point that is not a symmetric space ... the programme has never constructed one."* It has one at $n=6$, $\theta=\sqrt{6/5}$, and the proof of non-symmetry is a three-line finite check over the dimension-$6$ Cartan list plus this record's own reducible-symmetric maximum.
2. I disagree that the three labels were ever mutually inconsistent. One was refuted on this record before the discrepancy was raised; the surviving two describe the same operator under an algebraic and a geometric realisation, and the "symmetric?" column has no well-defined entry for an algebraic critical point.
3. I disagree with 0380f5e's attribution of *"a $\perp$-sum inherits each block's verdict"* to Reviewer 127. That report's scale-invariance concerns one vertex-matrix ratio on the diagonal locus; the conclusion drawn here follows from the definition of a $\perp$-sum and needs no report.
4. I disagree with *"reducibility is itself a strong symmetry"* as a blanket. On the quantity the plan itself names (the dimension of the equivariant tensor space), reducibility is $k$ times **weaker** than the isotropy-irreducibility it is being equated with.
5. I disagree with plan.md line 93's framing that the three witnesses *"span every threshold the claim could carry."* One witness spans every threshold; the other two span none the first does not.
