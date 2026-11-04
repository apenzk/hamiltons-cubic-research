# r804, Gate 2 on L188 (full rank at $\dim V=8$, the factoring of first Bianchi, and the constant norm ratio)

*Cold brief: I was given the three claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md) and [L188Statement.lean](../lean/HamiltonsCubic/Results/L188Statement.lean) from scratch. **No numerical work was done**; every derivation below is by hand and every value is exact. Two machine actions are reported as screens and never as evidence for a positive claim: an exact-arithmetic check over $\mathbb Q$ of the three identities I use ($\omega^{\wedge4}=4!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$, $\det\omega=\mathrm{Pf}(\omega)^2$, and strict monotonicity of $\det$ under a rank-two positive-semidefinite bump), and `lake build HamiltonsCubic.Results.L188Statement`, which completed over 8710 jobs with no `sorry` and two unused-hypothesis warnings. Log: [agent_logs/g2-l188-r804.log](../agent_logs/g2-l188-r804.log).*

| Claim | Verdict |
|---|---|
| **1**, both non-decomposable forms have full rank eight, via $\mathrm{Pf}(\omega_1)=c^2\mathrm{Pf}(\omega_2)$ | **CONFIRMED**, the Pfaffian step, the constant and the [L180](../findings/diagonal-half.md)(3) import all hold |
| **2**, first Bianchi factors as $\alpha\wedge\beta=0$, with $\lVert\alpha\rVert^2=\lVert\beta\rVert^2=1+c$ and $\langle\alpha,\beta\rangle=1-c$ | **CONFIRMED**, the degree argument is right and $c>0$ is a theorem here, not an assumption |
| **3**, $\lambda_1A_1-\lvert\lambda_2\rvert A_2$ is positive semidefinite of rank exactly two, giving a constant norm ratio on a six-dimensional space | **CONFIRMED**, $P_3\subseteq V$ holds, so the subspace is six-dimensional |
| **Inhabitation of the configuration at $\dim V=8$** | **REFUTED, THE BRANCH IS EMPTY**, by one determinant taken of the lemma's own two equations |
| **The block's forward-looking claim**, that "whether $\alpha\wedge\beta=0$ is satisfiable at these norms" is open and that the two constraints "have not been used together" | **REFUTED**, used together they are contradictory, and §4 does it in five lines |
| **The Lean layer as corroboration** | **REFUTED**, `factor_norms` states no norm and proves $1+c-(1-c)=2c$; `full_rank_of_pf` never uses $c\ne0$ |

**One line.** *All three claims are correct, and the lemma is the FOURTH consecutive result of this line to be correct about a class that is empty: Bianchi forces $\det(\lambda_1A_1)=\det(\lvert\lambda_2\rvert A_2)$ while Ricci forces $\det(\lambda_1A_1)>\det(\lvert\lambda_2\rvert A_2)$, so the two-non-decomposable branch is empty at every $\dim V\equiv0\pmod4$, which, with [r802](REVIEW_r802.md)'s $\tau$ route at $\dim V\equiv2\pmod4$, empties the two-non-decomposable case **at every dimension** and leaves three as the only surviving case of [I38](../plan.md)'s census.*

## 0. Conventions, fixed once

- $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$ with the $\omega_i$ orthonormal in $\Lambda^2\mathbb R^n$, every $\lambda_i\ne0$, $W$ Ricci-flat and satisfying first Bianchi. $V$ is the span of the supports.
- A $2$-form is read as a skew matrix; $\mathop{\mathrm{supp}}\omega$ is its image and $\mathop{\mathrm{rank}}\omega=\dim\mathop{\mathrm{supp}}\omega$. **Decomposable** $\iff\omega\wedge\omega=0\iff\mathop{\mathrm{rank}}\le2$.
- $A_i=\omega_i\omega_i^{\mathsf T}=-\omega_i^2\succeq0$, with $\mathop{\mathrm{tr}}A_i=2\lVert\omega_i\rVert^2=2$, as in [L180](../findings/diagonal-half.md)(1).
- On an oriented $2m$-dimensional space, $\omega^{\wedge m}=m!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$ and $\det\omega=\mathrm{Pf}(\omega)^2$. Screened exactly at $m=4$ over $\mathbb Q$ on four integer skew matrices: the top coefficient equalled $24\,\mathrm{Pf}$ and the Bareiss determinant equalled $\mathrm{Pf}^2$ in every case.
- The configuration: $\omega_1,\omega_2$ non-decomposable with opposite-signed weights, $\omega_3$ decomposable with unit plane $P_3$, and $\dim V=8$.

## 1. The hypothesis inventory, including two the block leaves unstated

Both are theorems in this branch, so nothing breaks; both are load-bearing and neither is written down.

- **The sign pattern is $(+,-,-)$ with $\omega_1$ the minority form.** Claim 1 cites [L180](../findings/diagonal-half.md)(3) as putting $V=\mathop{\mathrm{supp}}\omega_1$, and Claim 3 writes $\lambda_1A_1=\lvert\lambda_2\rvert A_2+\lvert\lambda_3\rvert\Pi_3$; both need $\omega_1$ to carry the sign that stands alone. *That it does is one line: if $\omega_3$ carried the minority sign then [L180](../findings/diagonal-half.md)(3) would make $V=P_3$ a plane, against $\dim V\ge4$. So the minority form is one of the two non-decomposable ones, and the labelling is a relabelling.*
- **The opposite-signed hypothesis is itself a theorem.** *Were $\lambda_1,\lambda_2$ of one sign, Ricci would read $\lvert\lambda_3\rvert\Pi_3=\lambda_1A_1+\lambda_2A_2$ with a rank-two left side and a right side of rank at least four, $\omega_1$ being non-decomposable.* [r803](REVIEW_r803.md) records the same count.
- **$c>0$, so $\sqrt c$ is real.** $c=-\lambda_2/\lambda_1=\lvert\lambda_2\rvert/\lambda_1>0$ under that sign pattern. *[L187](../findings/diagonal-half.md) needed only $c\ne0$ and [r803](REVIEW_r803.md) said so; L188's $\sqrt c$ genuinely needs positivity, and the block writes $\sqrt c$ without establishing it.* **The attack item is answered: $c>0$ is established, not assumed, and the block should say where.**
- **$c<1$, unremarked and free.** The trace of Ricci is $\lambda_1=\lvert\lambda_2\rvert+\lvert\lambda_3\rvert$ with $\lambda_3\ne0$, so $c\in(0,1)$ and $\langle\alpha,\beta\rangle=1-c>0$: the two factors of Claim 2 are never orthogonal.

## 2. Claim 1, the Pfaffian step is right, constant included

**Bianchi has two terms.** $\omega_3$ decomposable gives $\omega_3\wedge\omega_3=0$, so [L179](../findings/diagonal-half.md)(b)'s $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ reads $\lambda_1\,\omega_1\wedge\omega_1=\lvert\lambda_2\rvert\,\omega_2\wedge\omega_2$, that is $\omega_1\wedge\omega_1=c\,(\omega_2\wedge\omega_2)$.

**Wedging with itself.** Both sides are $4$-forms and an equality of elements may be wedged with itself freely, so $\omega_1^{\wedge4}=c^2\,\omega_2^{\wedge4}$. On the oriented eight-dimensional $V$ this is $24\,\mathrm{Pf}(\omega_1)\,\mathrm{vol}=24\,c^2\,\mathrm{Pf}(\omega_2)\,\mathrm{vol}$, and the $4!$ cancels: **$\mathrm{Pf}(\omega_1)=c^2\,\mathrm{Pf}(\omega_2)$, with the constant exactly as the block states.** *The attack item asked whether $\omega^{\wedge4}\propto\mathrm{Pf}\cdot\mathrm{vol}$ carries the constant claimed; it does, because the same universal $m!$ sits on both sides.*

**The [L180](../findings/diagonal-half.md)(3) import.** That lemma says the support of the minority-sign form **is** $V$; here that form is $\omega_1$ by §1, so $\mathop{\mathrm{rank}}\omega_1=\dim V=8$ and $\mathrm{Pf}(\omega_1)\ne0$. Then $\mathrm{Pf}(\omega_2)=c^{-2}\mathrm{Pf}(\omega_1)\ne0$ and $\mathop{\mathrm{rank}}\omega_2=8$. **The import is used within its hypotheses and is not circular.**

**Everything restricts to $V$.** [L180](../findings/diagonal-half.md)(3)'s proof gives $\mathop{\mathrm{supp}}\omega_2+\mathop{\mathrm{supp}}\omega_3=\mathop{\mathrm{supp}}\omega_1=V$, so all three forms lie in $\Lambda^2V$ and both the Ricci identity and the Bianchi identity restrict to $V$ with nothing lost. *This matters for §4, where the determinant is taken on $V$ and would be zero on any larger ambient space.*

**Verdict: CONFIRMED.**

## 3. Claims 2 and 3, both correct, with one imprecision in Claim 3's gloss

**Claim 2.** For $2$-forms $\omega_1\wedge\omega_2=\omega_2\wedge\omega_1$, the degree product $2\cdot2$ being even, so
$$(\omega_1-\sqrt c\,\omega_2)\wedge(\omega_1+\sqrt c\,\omega_2)=\omega_1\wedge\omega_1+\sqrt c\,(\omega_1\wedge\omega_2-\omega_2\wedge\omega_1)-c\,(\omega_2\wedge\omega_2)=\omega_1\wedge\omega_1-c\,(\omega_2\wedge\omega_2)=0.$$
**The degree argument is right.** $\lVert\alpha\rVert^2=1+c-2\sqrt c\,\langle\omega_1,\omega_2\rangle=1+c$ and likewise for $\beta$; $\langle\alpha,\beta\rangle=\lVert\omega_1\rVert^2-c\lVert\omega_2\rVert^2=1-c$. Both factors are nonzero, and $\lVert\alpha\rVert^2=1+c>0$ says so without appealing to independence. **CONFIRMED.**

**Claim 3.** A unit decomposable $\omega_3=u\wedge v$ with $u,v$ orthonormal has $\omega_3\omega_3^{\mathsf T}=\Pi_3$, the orthogonal projection onto $P_3$, screened exactly and true by the two-line computation $\omega_3^2=-uu^{\mathsf T}-vv^{\mathsf T}$. So Ricci is $\lambda_1A_1-\lvert\lambda_2\rvert A_2=\lvert\lambda_3\rvert\Pi_3$, which **is** positive semidefinite of rank exactly two, $\lambda_3$ being nonzero. At $x\perp P_3$ the right side annihilates and $\lambda_1\lVert\omega_1x\rVert^2=\lvert\lambda_2\rvert\lVert\omega_2x\rVert^2$, so the squared ratio is $c$ and the ratio is $\sqrt c=\sqrt{\lvert\lambda_2\rvert/\lambda_1}$; $\omega_2$ full rank keeps the denominator away from zero. **$P_3\subseteq V$** by §2's last paragraph, so $P_3^\perp\cap V$ has dimension $8-2=6$ as claimed. **CONFIRMED.**

*One imprecision, worth a word in the block.* The gloss "two positive definite matrices differing by a rank-two term" is true of $A_1,A_2$ **as operators on $V$**; on an ambient $\mathbb R^n$ with $n>8$ they are positive semidefinite with kernel $V^\perp$. Nothing downstream uses the stronger reading.

## 4. Inhabitation, the branch is EMPTY, and the two constraints the block wants combined are what does it

*The block asks for the two constraints to be used together and says they have not been. Used together they contradict each other. The whole of what follows is inside L188's own hypotheses and uses no fact the block does not already have.*

**Rescale so that the two identities carry the same coefficients.** On $V$ put $N=\sqrt{\lambda_1}\,\omega_1$ and $M=\sqrt{\lvert\lambda_2\rvert}\,\omega_2$, both real since $\lambda_1>0>\lambda_2$. Then

- **Ricci** is $\lambda_1A_1=\lvert\lambda_2\rvert A_2+\lvert\lambda_3\rvert\Pi_3$, that is $$NN^{\mathsf T}=MM^{\mathsf T}+k\,\Pi_3,\qquad k=\lvert\lambda_3\rvert>0;$$
- **first Bianchi** is $\lambda_1\,\omega_1\wedge\omega_1=\lvert\lambda_2\rvert\,\omega_2\wedge\omega_2$, that is $$N\wedge N=M\wedge M.$$

**The same two square roots linearise both equations. That coincidence is the whole argument.**

**Bianchi forces the determinants EQUAL.** $\dim V=8=2m$ with $m=4$ even, so $m/2$ is an integer and $(N\wedge N)^{\wedge2}=N^{\wedge4}$. Hence $N^{\wedge4}=M^{\wedge4}$, so $\mathrm{Pf}(N)=\mathrm{Pf}(M)$, so $\det N=\mathrm{Pf}(N)^2=\mathrm{Pf}(M)^2=\det M$, and since $\det N^{\mathsf T}=\det N$,
$$\det(NN^{\mathsf T})=(\det N)^2=(\det M)^2=\det(MM^{\mathsf T}).$$

**Ricci forces them STRICTLY UNEQUAL.** $N$ is invertible on $V$, its rank being $\dim V=8$ by [L180](../findings/diagonal-half.md)(3), so $\det(NN^{\mathsf T})>0$; by the display above $\det(MM^{\mathsf T})>0$ too, so $MM^{\mathsf T}\succ0$ on $V$. Then
$$\det(NN^{\mathsf T})=\det(MM^{\mathsf T})\cdot\det\!\big(I+k\,(MM^{\mathsf T})^{-1}\Pi_3\big)=\det(MM^{\mathsf T})\cdot\prod_{i}(1+\mu_i),$$
the $\mu_i$ being the eigenvalues of $k\,(MM^{\mathsf T})^{-1/2}\Pi_3(MM^{\mathsf T})^{-1/2}\succeq0$, of which two are strictly positive. **So $\det(NN^{\mathsf T})>\det(MM^{\mathsf T})$.** Screened exactly over $\mathbb Q$ on four integer instances: $\det(X+\tfrac32\Pi)$ exceeded $\det X$ every time, and $\det X$ equalled $\mathrm{Pf}(M)^4$ every time.

**Contradiction, so the configuration does not exist at $\dim V=8$.**

**The argument is dimension-generic in exactly the missing range.** The only place $\dim V=8$ enters is $m$ even, which is what makes $N^{\wedge m}$ a power of $N\wedge N$. **So the two-non-decomposable branch is empty at every $\dim V\equiv0\pmod4$** (at $4$, $8$, $12$, $16$, $\dots$), recovering [L187](../findings/diagonal-half.md)'s $\dim V=4$ by a second route and closing the whole of $\{8,12,\dots\}$ that [r802](REVIEW_r802.md) left open. *With [r802](REVIEW_r802.md)'s $\tau$ route emptying $m$ odd, i.e. $\dim V\in\{6,10,14,\dots\}$, **the two-non-decomposable case is empty at every dimension**.*

**The sign labelling does not matter.** If instead $\omega_2$ carries the minority sign, put $N=\sqrt{\lvert\lambda_2\rvert}\,\omega_2$ and $M=\sqrt{\lambda_1}\,\omega_1$: Ricci reads $NN^{\mathsf T}=MM^{\mathsf T}+\lambda_3\Pi_3$ and Bianchi still reads $N\wedge N=M\wedge M$. **The same contradiction, with the roles swapped.**

**And $P_3\not\subseteq V$ is not an escape.** Restricted to $V$ the projection term is $P_V\Pi_3P_V\succeq0$, and it is nonzero: were $P_3\perp V$, the $P_3$-component of Ricci would read $\lambda_3\Pi_3=0$ against $\lambda_3\ne0$. *So the strict inequality survives even without [L180](../findings/diagonal-half.md)(3)'s containment.*

### Arguing the opposite, which is what this section owes

*The strongest reading that would save the branch.* One could hope that $M$ is singular, so that $\det(MM^{\mathsf T})=0$ and the strictness argument has no purchase. **It has no purchase and no need of it**: Bianchi already gives $\det(MM^{\mathsf T})=\det(NN^{\mathsf T})>0$, $N$ being invertible on $V$. *So the emptiness does not even consume Claim 1, Claim 1 is the same determinant identity stopped one line early.* **That is the precise relation between this section and the lemma: L188(1) reads $\mathrm{Pf}(\omega_1)=c^2\mathrm{Pf}(\omega_2)$ and concludes both are nonzero; taking instead the determinant of Ricci alongside it closes the branch.**

*A second reading.* One could hope the argument proves too much and would also empty the three-non-decomposable case, where $W_{\mathbb{CP}^2}$ lives. **It does not.** With three non-decomposable forms, first Bianchi is a three-term relation $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ and no equality of two wedge-squares is available, so no determinant identity follows. *Checked against padded $W_{\mathbb{CP}^2}$ directly: its three unit eigenforms $\hat\omega_i$ satisfy $\hat\omega_i\hat\omega_i^{\mathsf T}=\tfrac12\mathrm{Id}_4$ and $\hat\omega_i\wedge\hat\omega_i=\mathrm{vol}$, so Ricci and Bianchi both reduce to $\sum_i\lambda_i=0$ and both hold. **The conventions of §0 reproduce a genuine Weyl tensor, and §4 leaves it alone.***

*A third reading.* One could hope that $\lambda_3=0$ is admissible, making $k=0$ and the inequality non-strict. **Rank exactly three forbids it.**

## 5. The Lean layer carries none of this, and one theorem states nothing

The build screen is clean (8710 jobs, exit 0, no `sorry`) and it corroborates nothing about L188, for the same reason [r803](REVIEW_r803.md) gave for [L187](../findings/diagonal-half.md).

- `factor_of_comm` and `bianchi_factors` are `ring` and `rw` over a `CommRing`. **That is honest and the module docstring says so**: commutativity is the one property the factoring uses.
- **`factor_norms` states no lemma.** Its statement is $1+c-(1-c)=2c$; **no norm, no inner product and no $2$-form appear in it**, and its hypothesis $0<c$ is unused, the build warns that the variable name `hc` is not explicitly referenced, at line 59. *The docstring calls it "the norms of the two factors", which the type does not say.*
- **`full_rank_of_pf` does not use $c\ne0$** either (line 64 carries the same warning) because $p_1=c^2\cdot0=0$ regardless. **The direction that has content is the contrapositive**, $\mathrm{Pf}(\omega_1)\ne0\Rightarrow\mathrm{Pf}(\omega_2)\ne0$, and that is the one needing $c\ne0$; the file types the direction that does not.
- `norms_agree_off_plane` is $a=b+0$ and `ratio_const` is a `field_simp`. **Neither knows about $\Pi_3$, $P_3^\perp\cap V$ or positive semidefiniteness**, which the file's own "What is NOT typed here" concedes.

**So [lean/INDEX.md](../lean/INDEX.md) row 188 should not read as corroboration**, and the row's claim that the file "carries the factoring identity in the one property it uses" is right about `factor_of_comm` and wrong about the file, two of whose five theorems assume hypotheses they never use.

## 6. Falsifiers, what would break each claim, and what I did to look

| Claim | What would falsify it | What I did |
|---|---|---|
| **1**, the Pfaffian step | $\omega^{\wedge4}$ not proportional to $\mathrm{Pf}\cdot\mathrm{vol}$, or a constant differing between the two sides, or $\mathrm{Pf}$ picking up a factor under $\omega\mapsto c\,\omega$ that breaks the $c^2$ | Derived $\omega^{\wedge4}=4!\,\mathrm{Pf}\,\mathrm{vol}$ and $\det=\mathrm{Pf}^2$ by hand; **screened both exactly over $\mathbb Q$ on four integer skew $8\times8$ matrices**, the top wedge coefficient against $24\,\mathrm{Pf}$ and the Bareiss determinant against $\mathrm{Pf}^2$; agreement in every case. **No defect.** |
| **1**, the [L180](../findings/diagonal-half.md)(3) import | L180(3) naming a different form's support, or holding only under hypotheses this branch lacks | Read L180(3) and its proof in full; checked that the minority form here must be non-decomposable, and that the relabelling to $\omega_1$ is free. **No defect, but the sign pattern is unstated in the block.** |
| **2**, the cancellation | $2$-forms failing to commute, or $\sqrt c$ imaginary | Recomputed the four cross terms by degree; traced $c=\lvert\lambda_2\rvert/\lambda_1$ back to the sign pattern and got $c\in(0,1)$ from the trace of Ricci. **No defect; $c>0$ is a theorem the block does not state.** |
| **3**, the rank and the dimension | $\omega_3\omega_3^{\mathsf T}$ not a projection, or $P_3\not\subseteq V$ making the subspace smaller than six | Computed $\omega_3^2=-\Pi_3$ by hand and screened it exactly; took $P_3\subseteq V$ from L180(3)'s own range identity. **No defect.** |
| **Inhabitation** | a witness, two full-rank orthonormal $2$-forms on $\mathbb R^8$ with a plane, Ricci-flat, Bianchi | **No search was run and none is needed**: §4 exhibits the obstruction in closed form from the lemma's own two equations. I attacked it three ways ($M$ singular, over-reach onto the three-non-decomposable case, and $\lambda_3=0$) and it survived all three. **The branch is empty.** |
| **§4 itself** | the two rescalings failing to linearise both equations simultaneously, or $m$ odd sneaking in | Re-derived $N\wedge N=M\wedge M$ and $NN^{\mathsf T}=MM^{\mathsf T}+k\Pi_3$ from scratch twice, once per sign labelling; isolated the single use of $\dim V=8$ as "$m$ even"; checked the result against [r802](REVIEW_r802.md)'s $\tau$ route, which covers precisely the complementary residue. **No falsifier.** |

## Overall verdict

**PROVEN, hypotheses corrected**, *and the lemma is VACUOUS*.

*All three claims are correct as stated, with two unstated hypotheses (the $(+,-,-)$ sign pattern and $c>0$) that are theorems in this branch and should be written into the block. The finding that matters is the fourth: **the configuration L188 describes does not exist**. Bianchi and Ricci, rescaled by the same two square roots, give equal and strictly unequal determinants for $\lambda_1A_1$ and $\lvert\lambda_2\rvert A_2$; the argument needs only $\dim V\equiv0\pmod4$, so it closes the whole range [r802](REVIEW_r802.md) left open. **The two-non-decomposable case of [I38](../plan.md)'s census is therefore empty at every dimension, and three non-decomposable image forms is the only surviving case**, the census reaches the collapse that [L186](../findings/diagonal-half.md)'s block once claimed prematurely, now with all four verdicts earned. Three rows need correcting before anything is built on them: [findings/INDEX-results.md](../findings/INDEX-results.md) rows 187 and 188, [lean/INDEX.md](../lean/INDEX.md) row 188, and [I38](../plan.md)'s line in [plan.md](../plan.md).*
