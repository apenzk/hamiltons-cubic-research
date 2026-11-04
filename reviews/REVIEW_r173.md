# Gate 2, reviewer r173: the $n=5$ block structure, the parity claim, and the orbit constraint

Cold adversarial review of [plan.md](../plan.md) item 3c, [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage), [REVIEW_r171.md](REVIEW_r171.md), [REVIEW_r172.md](REVIEW_r172.md), and commits `40bdc9a`, `d84c242`, `9b2efcd`. Deliverable: derivation. The $n\ge12$ plethysm was not run; the $n=5$ work is character theory plus one $625$-entry tensor contraction.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $24$ blocks, dims summing to $7770$, mults $4,4,3,2^{\times9},1^{\times12}$, $65$ unknowns | **verified exactly**, two independent routes; every entry of the table reproduces |
| 2 | at most four vectors per block; group averaging "neither needed nor desirable" | **half right**, the multiplicity bound sizes the SDP correctly but does not price the projection, and the stated reason for rejecting averaging is wrong |
| 3a | the trivial block $()_1$ is forced to zero, $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$ | **verified, and upgraded to exact**, $\mathop{\mathrm{tr}}(M^2)=24$, $\mathop{\mathrm{tr}}(M^3)=48$, $\theta^2=3/2$ in rational arithmetic |
| 3b | the vector block $(1)_5$ "carries no cubic covariant of $\mathrm{Weyl}_5$ by parity" | **REFUTED.** The block is present with **multiplicity $1$**, and its covariant is exhibited below. Parity excludes the vector $[1]$ and nothing else; the block that occurs is $[1]\otimes\det=\Lambda^4\mathbb R^5$ |
| 4 | the orbit constraint is unconditional | **the narrow implication is right and both earlier reviewers were loose**, but the claim is a statement about the SDP's feasible set, so it is vacuous rather than false if the SDP is infeasible |
|, | the orbit-evaluation span is $3570$, $45.9\%$ | **rebuilt from the definition and confirmed**, rank stable across four tolerances |

**One block was silently deleted, and it should not have been.** The conclusion survives (that block's single unknown is zero) but by the orbit constraint, which is the mechanism the item already had, rather than by parity.

---

## 1. The parity claim, in full

### 1.1 What parity does prove

$\mathrm{Weyl}_5$ is a submodule of $V^{\otimes4}$, $V=\mathbb R^5$, so $-\mathrm{Id}\in O(5)$ acts on it by $(-1)^4=+1$: **trivially**. The record holds this twice already, [algebra.md](../findings/algebra.md) records that $-\mathrm{Id}$ is an isometric algebra isomorphism and that the group acting irreducibly is $O(n)$ rather than $SO(n)$, and reviewer 170's own script header states it verbatim. Hence $-\mathrm{Id}$ acts trivially on $\mathrm{Sym}^3(\mathrm{Weyl}_5)\subset V^{\otimes12}$ as well, and every $O(5)$-constituent of $\mathrm{Sym}^3$ must have $-\mathrm{Id}$ acting trivially.

For $n=5$ odd, $O(5)=SO(5)\times\{\pm\mathrm{Id}\}$ and $\det(-\mathrm{Id})=-1$. On the $O(5)$-irreducible $[\mu]$ (the one realised inside $V^{\otimes|\mu|}$) $-\mathrm{Id}$ acts by $(-1)^{|\mu|}$, and on $[\mu]\otimes\det$ by $(-1)^{|\mu|+1}$. So the constituents of $\mathrm{Sym}^3(\mathrm{Weyl}_5)$ are exactly the $[\mu]$ with $|\mu|$ **even** together with the $[\mu]\otimes\det$ with $|\mu|$ **odd**.

The vector representation is $[1]$, $|\mu|=1$: $-\mathrm{Id}$ acts by $-1$, so $[1]$ is excluded. Equivalently and more directly: an $O(5)$-equivariant cubic map $v:\mathrm{Weyl}_5\to V$ obeys $v(W)=v((-\mathrm{Id})\cdot W)=-v(W)$, so $v=0$. **That much of the claim is correct.**

### 1.2 What parity does not prove, and the reductio

Parity kills $[1]$ **and its det-twist survives**. $[1]\otimes\det\cong\Lambda^4V$ has dimension $5$ and $-\mathrm{Id}$ acts on it by $(-1)^4=+1$. It is not excluded by anything.

Which of the two the label $(1)_5$ names is not free, because the same table lists ten blocks whose labels have **odd** weight, $(6,3)_{770}$, $(5,4)_{429}$, $(5,2)_{390}$, $(4,3)_{231}$, $(4,1)_{154}$, $(3,2)_{105}$, $(5,0)_{91}$, $(2,1)_{35}$, $(3,0)_{30}$ and $(1,0)_5$ itself. If "parity" were a rule about these labels it would delete all ten: $17$ of the $41$ multiplicities and $25$ of the $65$ unknowns, including the multiplicity-$3$ block $(3,2)_{105}$ that item 3c's own table keeps. **An argument that would delete a third of the table proves too much**, so it cannot be the argument that deletes $(1)_5$.

The resolution is that the table's labels are $SO(5)$ highest weights in the $e$-basis, which is what a $B_2$ character computation returns. Every dimension in it is the $B_2$ Weyl-dimension $\tfrac16(a-b+1)(a+b+2)(2a+3)(2b+1)$ of $(a,b)$, checked on all $24$ entries. For $n$ odd the two $O(5)$-irreducibles $[\mu]$ and $[\mu]\otimes\det$ restrict to the *same* $SO(5)$-irreducible, so an $SO(5)$ label carries no parity information at all. Parity then works in the other direction: since $-\mathrm{Id}$ is trivial on $\mathrm{Sym}^3$, **exactly one member of each pair can occur**, and the $O(5)$ label is recovered from the $SO(5)$ one by $|\mu|$'s parity. The $SO(5)$ and $O(5)$ block lists are in bijection with equal multiplicities, and the dimension-$5$ block is $[1]\otimes\det$, not $[1]$.

### 1.3 The block is present, with multiplicity $1$

Two independent computations, in [r173_n5_blocks.sage](../scripts/reviewers/r173/r173_n5_blocks.sage):

- `WeylCharacterRing("B2")(2,2).symmetric_power(3)`, the module is $[2,2]=2e_1+2e_2=4\omega_2$, dimension $35$;
- Weyl integration on the $B_2$ torus: $h_3$ from the power sums of the $35$ weights, then $\tfrac18\,\mathrm{CT}\big[h_3\cdot\chi_\lambda^*\cdot\prod_{\alpha\in\Phi}(1-x^\alpha)\big]$, which never calls `symmetric_power` at all.

Both give $\dim\mathrm{Sym}^3=7770$, $24$ blocks, and

$$\boxed{\ \mathop{\mathrm{mult}}\big((1,0)_5\big)=1\ }$$

alongside $\mathop{\mathrm{mult}}\big(()_1\big)=1$, $\mathop{\mathrm{mult}}\big((2,2)_{35}\big)=4$, $\mathop{\mathrm{mult}}\big((4,2)_{220}\big)=4$, $\mathop{\mathrm{mult}}\big((3,2)_{105}\big)=3$.

### 1.4 The covariant, exhibited

Multiplicity $1$ means one cubic covariant up to scale. It is

$$T^e(W)\ =\ \varepsilon^{abcde}\,W_{ab}{}^{fg}\,W_{cd}{}^{hi}\,W_{fghi}.$$

It is a genuine element of $\mathrm{Hom}(\mathrm{Sym}^3\mathrm{Weyl}_5,\Lambda^4V)$: exchanging the first two factors relabels $\varepsilon^{abcde}\mapsto\varepsilon^{cdabe}$, an even permutation, and $W_{fghi}\mapsto W_{hifg}=W_{fghi}$, so $T$ is symmetric in its three arguments. Under $g\in O(5)$ it transforms as $T(gW)=\det(g)\,g\,T(W)$, which is precisely $[1]\otimes\det$.

Evaluated in [r173_pseudovector_covariant.py](../scripts/reviewers/r173/r173_pseudovector_covariant.py) on six random Weyl tensors of $\mathbb R^5$ (each checked for antisymmetry, pair symmetry, first Bianchi and tracelessness at $10^{-15}$), $T$ is nonzero every time, $\max|T|=2.5\times10^3$. **So the block carries a cubic covariant, and $65$ was the right unknown count.**

### 1.5 The conclusion survives, by the orbit constraint

Deleting the block was still the right arithmetic, for the reason that kills the trivial block. On the padded $W_{\mathbb{CP}^2}$,

$$T(W_0)=\Big(0,0,0,0,\tfrac{2}{\sqrt6}\Big),\qquad |T(W_0)|=0.81649658\ne0,$$

so $G_{(1)_5}\,T(W_0)=0$ forces the single scalar of that block to zero. The direction is forced by isotropy and the value by self-duality:

- $g=\mathrm{diag}(1,1,1,1,-1)$ fixes $W_0$ and has $\det=-1$, so $T(W_0)=-g\,T(W_0)$, killing the first four components;
- $W_{\mathbb{CP}^2}$ is self-dual, so no orientation-reversing element of $O(4)$ fixes it, and nothing forces the fifth component to vanish. Measured on the padded tensor: $\mathop{\mathrm{tr}}((W^+)^3)=384$, $\mathop{\mathrm{tr}}((W^-)^3)=0$, and $T^5$ is exactly that $n=4$ pseudo-scalar.

**Net effect on the record: one line of item 3c is wrong and the number it produces is right.** The correct statement is *"the $5$-dimensional block is $\Lambda^4\mathbb R^5$, not the vector; it carries one cubic covariant; its unknown is forced to zero by the orbit constraint, since that covariant does not vanish at $W_{\mathbb{CP}^2}$."*

---

## 2. Claim 4, the orbit constraint is unconditional, in one reading only

**The implication is valid and needs no nonnegativity.** If $F(W)=v(W)^{\mathsf T}Gv(W)$ with $G\succeq0$ and $F(W_0)=0$, then $\lVert G^{1/2}v(W_0)\rVert^2=0$, so $Gv(W_0)=0$, and by $O(5)$-invariance $G$ annihilates the whole orbit span. $F\ge0$ appears nowhere. Against reviewers 171 and 172, item 3c is right on this point.

**And the zero is stronger than "exhibited".** [plan.md](../plan.md) presents $F(W_0)=-8.9\times10^{-16}$ as a numerical exhibit. It is a theorem the record already owns: [algebra.md](../findings/algebra.md) derives $\theta(S^r)^2=\frac{2(r+2)(r-1)}{3r(r-2)}$ from Fox's norm identity (10.4), which is $3/2$ at $r=4$, and Fox's Lemma 10.1 makes $S^4$ an idempotent, so $Q(W_0)=\theta W_0$ holds exactly and the $\mu\lvert W\wedge Q(W)\rvert^2$ term vanishes identically rather than to $1.1\times10^{-16}$. Reproduced here in rational arithmetic from the Fubini–Study tensor, [r173_exact_theta.py](../scripts/reviewers/r173/r173_exact_theta.py): the Weyl projection satisfies all four symmetries exactly, $\mathop{\mathrm{tr}}(M^2)=24$, $\mathop{\mathrm{tr}}(M^3)=48$, hence $\mathop{\mathrm{tr}}(M^3)^2/\mathop{\mathrm{tr}}(M^2)^3=1/6$ exactly and $\theta^2=9\cdot\tfrac16=\tfrac32$. So $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$ and $F(W_0)=0$ are both exact.

**Where the framing still overreaches.** "$45.9\%$ of $\mathrm{Sym}^3$ forced into $\ker G$" quantifies over feasible $G$. If $F$ is not a sum of squares of cubics the feasible set is empty and the sentence is true but empty, which is what reviewers 171 and 172 were reaching for with "conditional". The right formulation is the one that survives both readings: *the equality $Gv(W_0)=0$ is a valid constraint to impose on the search, and imposing it cannot remove a certificate that exists*. As a statement about the search space it is unconditional; as a statement about a certificate it presupposes one. Item 3c uses it in the first sense, so the use is sound and the word "UNCONDITIONAL" is doing more work in the prose than in the mathematics.

**The span is confirmed.** $\langle v(A),v(B)\rangle=\langle A,B\rangle^3$ for the Veronese $v(W)=W^{\otimes3}$, so the span's dimension is the rank of the entrywise cube of a Gram matrix of orbit samples, no $7770$-dimensional object is built. With $4800$ Haar samples of $SO(5)$, [r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py) gives rank $3570$ at every relative tolerance from $10^{-6}$ to $10^{-12}$, hence $\mathop{\mathrm{rank}}G\le4200$ and $45.946\%$. **Both figures rebuilt from the definition rather than reproduced arithmetically.**

---

## 3. Claim 1, the block table, checked entry by entry

Verified exactly. $\dim\mathrm{Sym}^3=7770=\binom{37}{3}$, $24$ blocks, multiplicities summing to $41$, $\sum m(m+1)/2=65$, $\sum m\cdot d=7770$.

| mult | blocks | count |
|---|---|---|
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ | $2$ |
| $3$ | $(3,2)_{105}$ | $1$ |
| $2$ | $(5,2)_{390}$, $(4,3)_{231}$, $(4,4)_{165}$, $(4,1)_{154}$, $(3,1)_{81}$, $(4,0)_{55}$, $(2,1)_{35}$, $(3,0)_{30}$, $(2,0)_{14}$ | $9$ |
| $1$ | $(6,4)_{810}$, $(6,3)_{770}$, $(6,2)_{625}$, $(5,3)_{455}$, $(6,6)_{455}$, $(5,4)_{429}$, $(5,1)_{260}$, $(6,0)_{140}$, $(5,0)_{91}$, $(3,3)_{84}$, $(1,0)_{5}$, $(0,0)_{1}$ | $12$ |

Every figure in item 3c's table matches, including "largest multiplicity-$1$ block $(6,4)_{810}$". The trivial multiplicity is $1$, against $2$ in the stable range, as the item says.

**$(2,2)_{35}$ is not an error and not a coincidence.** $\mathrm{Weyl}_5$ *is* the block $(2,2)_{35}$, and multiplicity $4$ says there are four independent cubic covariants $\mathrm{Weyl}_5\to\mathrm{Weyl}_5$, the expected companions of the Fox product $W\circ W\circ W$. The genuine hazard is the other $35$: $(2,1)_{35}$ has the same dimension, occurs with multiplicity $2$, and is a different block, as an $O(5)$-module it is $[2,1]\otimes\det$ where $(2,2)$ is $[2,2]$. Reviewer 170 flagged that pair; the caution is right and the table handles it correctly.

**The stable list is consistent with all of this and does not contradict the parity reading.** [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) run here gives $71$ blocks, $184$ multiplicities, $477$ unknowns, and **every stable label has even $|\mu|$**, as it must, since $\mathrm{Sym}^3\subset V^{\otimes12}$. So the parity argument is exactly right in the stable range and at every even $n$, where $[1]$ genuinely cannot occur. It fails only at $n=5$, where the modification rules fold a partition of even weight and four rows, $[1,1,1,1]$ (stable multiplicity $3$), onto a two-row $SO(5)$ label of odd weight. **The defect is localised to the $n=5$ calibration and does not touch $n\ge12$.**

---

## 4. Claim 2, "at most four vectors per block" is the wrong measure

**What the multiplicity profile does size, correctly:** the SDP itself. $65$ scalar unknowns in $24$ blocks, two $4\times4$, one $3\times3$, nine $2\times2$, twelve scalars, against $\dim\mathrm{Sym}^6(\mathrm{Weyl}_5)^{O(5)}=14$ constraints, the $14$ reproduces here by Weyl integration, alongside $0,1,1,4,5$ at $k=1,\dots,5$. That part of the item is right, and at this size exact arithmetic is not in question.

**What it does not size:** the block projection, which item 3c itself calls "the one substantial step remaining". Writing $F=\sum_\lambda\langle G_\lambda,\Pi_\lambda(W)\rangle$ needs the symmetry-adapted basis, and that is $\sum_\lambda m_\lambda d_\lambda=7770$ vectors, not $41$. The $41$ highest-weight vectors determine them, each block's copies are generated from its highest-weight vector by lowering operators, exactly, over $\mathbb Q$, but generating $810$-dimensional and $770$-dimensional blocks is where the work is, and "at most four vectors per block" prices only the seed.

**"Group averaging would introduce approximation" is false as a reason.** Averaging over $O(5)$ with Haar measure would, but nobody needs Haar: the isotypic projector is the exact rational polynomial $\prod_{\nu\ne\lambda}\frac{C-c_\nu}{c_\lambda-c_\nu}$ in the Casimir $C$, and the lowering operators used by the highest-weight route are themselves the exact form of the same averaging. The conclusion (use highest-weight vectors), is the right call, on cost rather than on exactness.

---

## 5. The brief's three questions

**(a) Asserted as new, already on the record.** Three items.

- $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ presented as an exhibited numeric at $8.9\times10^{-16}$. [algebra.md](../findings/algebra.md) already has it in closed form and proved, via Fox's (10.4); the numeric is weaker than what the record holds.
- "$-\mathrm{Id}$ acts trivially on $\mathrm{Weyl}_5$", used to license the parity claim, is stated in [algebra.md](../findings/algebra.md) and in reviewer 170's script header.
- The $24$-block table is reviewer 170's computation; commit `40bdc9a` presents it without attribution, where the neighbouring paragraph credits 170 for the orbit constraint.

**(b) Is grade $6$ right? Yes, $3\times2\times1$ stands.** `closes` $=3$: a certificate at $n=12$ closes Problem P, unchanged. `margin` $=1$: I can now say this exactly rather than numerically, $F(W_0)=0$ holds in rational arithmetic, and equality is at the single orbit, so the sharpness is the goal's own. `attackable` $=2$: sub-step 1 is done and now independently verified, and the $n\ge12$ projection is still unpriced. The one thing that would move the grade is that the $n=5$ projection is unpriced too (the block data is not the projection) but that is a calibration, not the closing step, so it does not change the score.

**(c) How much smaller than $65$, exactly.** Two answers, and item 3c conflates them.

*The two named blocks are exactly two parameters.* $()_1$ and $(1)_5$ both have multiplicity $1$, so each is a single scalar and each is forced to zero, the trivial one by $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6\ne0$, the vector one by $T(W_0)=\tfrac2{\sqrt6}e_5\ne0$. That leaves $63$, and the item's phrase "smaller than $65$ parameters" is worth exactly $2$.

*The orbit constraint as a whole is worth much more, and the bracket is derivable.* Write $G=\bigoplus_\lambda G_\lambda\otimes I_{d_\lambda}$. By Burnside the cyclic module generated by $v(W_0)$ is $\bigoplus_\lambda U_\lambda\otimes V_\lambda$ with $U_\lambda$ the column space of the $\lambda$-isotypic component of $v(W_0)$, so

$$\sum_\lambda u_\lambda d_\lambda=3570,\qquad u_\lambda\le m_\lambda,\qquad \text{survivors}=\sum_\lambda\frac{(m_\lambda-u_\lambda)(m_\lambda-u_\lambda+1)}2 .$$

Exact dynamic programming over that single equation, [r173_surviving_params.py](../scripts/reviewers/r173/r173_surviving_params.py), gives $[9,57]$ with no side condition, and $[9,\mathbf{56}]$ once $u_{()_1}=1$ is imposed, **which is item 3c's bracket exactly, so the "exact integer search" behind it reproduces.** Adding the vector block, $u_{(1)_5}=1$, which §1.5 proves, tightens it to

$$\boxed{\ \text{between } 9 \text{ and } 54 \text{ surviving parameters against } 14 \text{ constraints}\ }$$

*And the sharp value is reachable without the full projection.* $v(W_0)$ is invariant under $H=\mathrm{Stab}_{O(5)}(W_0)$, so $u_\lambda\le\min(m_\lambda,\dim V_\lambda^H)$. Here $H^\circ\cong U(2)$, the $\mathbb{CP}^2$ isotropy, sitting in $SO(4)\subset SO(5)$ with $\dim H=4$ and orbit dimension $6$, extended by the reflection in the padding direction. The numbers $\dim V_\lambda^H$ are a branching computation on $24$ blocks of dimension at most $810$, far cheaper than the symmetry-adapted basis, and they would replace the bracket by a number.

---

## Scripts

All under [scripts/reviewers/r173/](../scripts/reviewers/r173/), each runnable alone.

| script | what it settles |
|---|---|
| [r173_n5_blocks.sage](../scripts/reviewers/r173/r173_n5_blocks.sage) | the $24$-block table with $O(5)$ labels; $\mathop{\mathrm{mult}}((1,0)_5)=1$ |
| [r173_pseudovector_covariant.py](../scripts/reviewers/r173/r173_pseudovector_covariant.py) | the covariant $T$ is nonzero, and $T(W_{\mathbb{CP}^2})=\tfrac2{\sqrt6}e_5$ |
| [r173_exact_theta.py](../scripts/reviewers/r173/r173_exact_theta.py) | $\mathop{\mathrm{tr}}(M^2)=24$, $\mathop{\mathrm{tr}}(M^3)=48$, $\theta^2=3/2$ in $\mathbb Q$ |
| [r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py) | orbit span $=3570$ from the Veronese kernel |
| [r173_surviving_params.py](../scripts/reviewers/r173/r173_surviving_params.py) | the $[9,56]$ bracket reproduces, and tightens to $[9,54]$ |
