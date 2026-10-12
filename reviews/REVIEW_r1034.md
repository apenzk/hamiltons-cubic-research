# Review r1034, I106b's criticality reduction and I77's closure on post F10

**Reviewer r1034, cold on the six claims of the brief.** Every derivation below was redone from the definitions rather than checked against the source's algebra. Log: [r-i106b-a.log](../agent_logs/r-i106b-a.log).

| claim | verdict |
|---|---|
| 1, `A` has rank at most 2 | **CONFIRMED** |
| 2, criticality is the per-pair system | **CONFIRMED**, as an equivalence, derived independently and agreeing to the sign |
| 3, equal `ν` imposes nothing | **CONFIRMED**, with the group-theoretic reason the note does not give |
| 4, the face Jacobian rank does not rise | **REFUTED as stated.** Vacuous at generic `ν`, false at the degenerate `ν` that produces the reported $11$, and the conclusion it was meant to support has a one-line proof that needs none of it |
| 5, the critical-point-free route is blocked | **CONFIRMED as stated**, and the sentence it is carried with, that the second-order condition must do the whole separation, is **REFUTED** |
| 6, the pair cap alone is dominated by F10 | **CONFIRMED** about the programme it literally names, **REFUTED** as a closure of [I77](../plan.md) |

## Claim 1, rank at most 2: CONFIRMED

$A_{ik}=\beta\nu_k^2u_i+\nu_kc_i=u_ia_k+c_ib_k$ with $a_k=\beta\nu_k^2$ and $b_k=\nu_k$, so $A=ua^{\mathsf T}+cb^{\mathsf T}$ is a sum of two outer products and $\operatorname{rank}A\le2$. Nothing else is needed and no hypothesis on $Q$, $\beta$ or the spectrum enters.

## Claim 2, the per-pair system: CONFIRMED, and it is an equivalence

**Rederived from $Q^{\mathsf T}(A\circ Q)$ symmetric, with no reference to the source's steps.**

$$M_{lm}=\big(Q^{\mathsf T}(A\circ Q)\big)_{lm}=\sum_iQ_{il}A_{im}Q_{im}=a_m\sum_iu_iQ_{il}Q_{im}+b_m\sum_ic_iQ_{il}Q_{im}=a_mX_{lm}+b_mY_{lm},$$

with $X=Q^{\mathsf T}UQ$ and $Y=Q^{\mathsf T}CQ$. Both are symmetric because $U$ and $C$ are, so

$$M_{lm}-M_{ml}=(a_m-a_l)X_{lm}+(b_m-b_l)Y_{lm}=(\nu_m-\nu_l)\big[\beta(\nu_l+\nu_m)X_{lm}+Y_{lm}\big],$$

using $a_m-a_l=\beta(\nu_m-\nu_l)(\nu_m+\nu_l)$ and $b_m-b_l=\nu_m-\nu_l$. **This is the source's boxed form exactly, index for index and sign for sign.** Screened as an identity against the matrix form over two hundred draws at $k=3\ldots7$: $5.3\times10^{-15}$ for the difference against $2.6$ for the sum, so the sign is pinned and not merely the magnitude.

**Both directions hold, so it is an equivalence and not an implication.** Three links, each reversible.

- $\mathrm df_Q[Q\Omega]=2\langle A\circ Q,Q\Omega\rangle=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$, since $\langle B,Q\Omega\rangle=\operatorname{tr}(B^{\mathsf T}Q\Omega)=\langle Q^{\mathsf T}B,\Omega\rangle$.
- $\{Q\Omega:\Omega\ \text{skew}\}$ is the whole tangent space of $O(k)$ at $Q$, and $\langle M,\Omega\rangle=0$ for every skew $\Omega$ holds exactly when the skew part of $M$ vanishes, which is $M=M^{\mathsf T}$.
- $M-M^{\mathsf T}$ is antisymmetric, so its diagonal vanishes identically and quantifying over $l<m$ loses nothing.

**Two things the source's wording leaves implicit and a successor will want.** The factorisation needs no orthogonality at all: $X$ and $Y$ are symmetric for every real $Q$, so the per-pair identity is an identity on all of $\mathbb R^{k\times k}$. Orthogonality enters at one place only, identifying the tangent space, which is where the source's own `first_order_antisymm` already sits.

## Claim 3, equal `ν` imposes nothing: CONFIRMED, with a reason and a consequence

**It is immediate from the factorisation**: at $\nu_l=\nu_m$ the outer factor is zero, and separately $a_l=a_m$ and $b_l=b_m$, so the pair's equation reads $0=0$ whatever $X$ and $Y$ do.

**The structural reason, which the note does not give and which is worth more than the algebra.** At $\nu_l=\nu_m$ columns $l$ and $m$ of $A$ are equal, and $f(Q)=\sum_{i,k}A_{ik}Q_{ik}^2$ is then invariant under right multiplication by the $SO(2)$ rotating those two columns, because $(Q_{il}\cos t+Q_{im}\sin t)^2+(-Q_{il}\sin t+Q_{im}\cos t)^2=Q_{il}^2+Q_{im}^2$. **So the $\Omega_{lm}$ direction is a symmetry direction of $f$ and its equation is forced to be trivial.** At a value of multiplicity $r$ the symmetry group is a full $O(r)$, so no critical point is isolated and the criticality Jacobian loses one rank per coincident pair.

**The brief asks whether this breaks claim 4's rank count, and the answer runs the other way twice.** A degenerate $\nu$ deletes equations, so the criticality variety only grows and zero-diagonal critical points persist a fortiori. What the degeneracy does break is claim 4's own evidence, and it does so decisively: see below.

## Claim 4, the Jacobian ranks: REFUTED as stated

**The conclusion the table is drawn for is true. The table does not establish it, in either row, and at the configuration that reproduces the reported $11$ it establishes the opposite.** Four findings, the first analytical and the rest screens.

### Every permutation matrix is a critical point, for every `A`, at every `k`

At a permutation $Q$ with $Q_{i\sigma(i)}=1$, the product $Q_{il}Q_{im}$ is nonzero only when $l=m=\sigma(i)$, so $M_{lm}=\sum_iQ_{il}Q_{im}A_{im}$ is **diagonal**, hence symmetric, hence critical. Equivalently $X$ and $Y$ are diagonal there, so every per-pair equation reads $0=0$. **The cyclic shift is a zero-diagonal permutation at every $k\ge2$, so the face carries a critical point at every $k$ and for every $A$, with no numerics and no genericity.** Screened at $0.00\times10^{0}$ asymmetry over $150$ draws at $k=3\ldots7$.

**This is strictly stronger than the table's conclusion and makes the table redundant.** It also supplies the robustness the table reaches for: these points do not move with $A$ at all, so no perturbation of $\beta$, $\nu$, $u$ or $c$ removes them.

### The $k=4$ row is forced by the column count

$\dim O(4)=6$, so the Jacobian has $6$ columns and its rank cannot exceed $6$ whatever equations are stacked into it. **The reported $6$ against $6$ is arithmetic, not measurement**: criticality alone already attains the ceiling, so adjoining the four face equations could not have raised it. Reproduced here: at every one of $118$ face critical points found at $k=4$, both ranks are $6$.

### At generic `ν` the $k=6$ row is forced the same way, and the reported $11$ is a degenerate-`ν` number

At generic $\nu$ the criticality Jacobian at a face critical point has rank $15=\dim O(6)$, so both ranks are again pinned at the column count. **The reported $11$ is not reproducible at generic $\nu$.** It is reproducible at a degenerate one: at $\nu$ with multiplicity pattern $(3,2,1)$ the criticality rank is **exactly $11$**, matching the coincident-pair count $\binom32+\binom22=4$ that claim 3 predicts.

| $\nu$ at $k=6$ | columns | rank, criticality | rank, criticality and face |
|---|---|---|---|
| generic | $15$ | $15$ | $15$ |
| multiplicities $(2,1,1,1,1)$ | $15$ | $14$ | $15$ |
| multiplicities $(2,2,1,1)$ | $15$ | $13$ | $15$ |
| multiplicities $(3,1,1,1)$ | $15$ | $12$ | $14$ |
| **multiplicities $(3,2,1)$** | $15$ | $\mathbf{11}$ | $\mathbf{14}$ |
| multiplicities $(3,3)$ | $15$ | $9$ | $13$ |

### At that configuration the face equations DO raise the rank, at $56$ of $58$ points

Solving for face critical points at $k=6$ with $\nu$ of multiplicity $(3,2,1)$ from sixty random starts, the criticality rank is $11$ at every solution found, and the rank with the face adjoined is distributed $11\!:\!2$, $12\!:\!24$, $13\!:\!15$, $14\!:\!16$, $15\!:\!1$. **The reported outcome is the rarest one, at two of fifty-eight.** At the $(2,2,1,1)$ pattern the same run gives $13\!:\!15$, $14\!:\!27$, $15\!:\!4$, so the equality is again the minority.

### What that leaves

- **"Adding the face equations does not raise the rank" is vacuous wherever the criticality rank already equals the column count, and false at a typical point wherever it does not.** The brief's own worry, that a rank at one solution is a local statement that can drop on a subvariety, is understated: here the rank does not drop at the reported value, it **rises**, at almost every point of the configuration that produces it.
- **"The face constraints are dependent on criticality where these points sit" does not follow from a rank taken in $Q$ alone.** Dependence of the differentials at a point gives $G$ constant along $\ker\mathrm dF$ only under a constant-rank hypothesis near that point, which is unchecked, and at $k=4$ that kernel is zero so the statement is empty. Persistence under varying $A$ is a question about the projection of $\{(Q,A):F=0,G=0\}$ to $A$-space and the table never enters it.
- **The script is not committed.** [3b8232ba](../reviews/2026-09-17-I106b-face.md) adds only [ATTEMPTS.md](../ATTEMPTS.md), [plan.md](../plan.md) and the note, so the table cannot be replayed from the record. [screen_I106b_face.py](../scripts/misc/screen_I106b_face.py) computes gradients and maximisers and carries no rank code.

**Verdict.** The row "the face carries critical points, and robustly" is **CONFIRMED by the permutation argument**. The row "the Jacobian rank does not increase when the face equations are adjoined" is **REFUTED as evidence for it**, and the sentence "zero-diagonal critical points are therefore not a codimension accident" should be rederived from the permutations, where it is unconditional.

## Claim 5, what is ruled out: CONFIRMED as stated, and the sentence beside it is REFUTED

**Claim 5 is correct, and it was already correct before claim 4 was run, twice over.** The face is not critical-point-free, because the cyclic-shift permutation is on it for every $A$, and because the note's own screen records maximisers landing on the face at $8$ of $12$ trials at $k=4$, and a maximiser of a smooth function on a compact manifold is a critical point. **So claim 4 adds nothing to claim 5.**

**What claim 4 rules out, precisely.** Exactly one route: proving [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) by showing its hypotheses `hzero` and `hmax` are jointly unsatisfiable because nothing on the face is critical. That route is dead at every $k\ge2$ and for every $A$.

**What it leaves open, and the note closes it without grounds.** "The theorem now needs the second-order condition to do the whole separation" is **REFUTED**. A first-order route survives and is the natural one:

> **every zero-diagonal critical point of $f$ is a signed permutation matrix.**

That statement implies [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) immediately with $P=Q$, because every permutation matrix satisfies the file's own `Splits` at $k\ge2$: take $R=\{i\}$ and $C=\{\sigma(i)\}$, and both quantifier clauses hold. **No second-order condition enters.**

*Screened, and reported as a screen.* Solving criticality together with the face from random starts at generic $\nu$, every solution found was a signed permutation: $118$ of $118$ at $k=4$ and $109$ of $109$ at $k=6$, measured as $\max\big|\,|Q|-\operatorname{round}|Q|\,\big|<10^{-8}$. **This refutes nothing and proves nothing. It says the surviving first-order route is worth an attempt, which the note had ruled out on the strength of the table claim 4 rests on.**

*And the counting is consistent with it*: the combined system has $\binom k2+k$ equations on a $\binom k2$-dimensional manifold, overdetermined by $k$, so a solution set that is nonempty for every $A$ has to come from structure rather than from dimension, and the permutations are that structure.

## Claim 6, the domination of I77's pair cap by post F10: REFUTED as a closure

**Checked as a logical argument about programmes, with no computation, which is what the brief asks.**

### As a statement about the programme it names, it is valid

[Post F10](../findings/fence-posts.md)'s programme is over $T_{abc}$ in the eigenframe under nonnegativity, total symmetry, the row marginals $2(n-2)$, the pair caps $\le2$ and $\operatorname{tr}(W^\#)=-1$, and it ceilings near $0.80\sqrt{n-2}$. A programme whose only constraints on $T$ are nonnegativity, total symmetry and the pair caps has a feasible set containing F10's, over the same variables and the same objective, so its optimum is at least F10's. **It is also bounded, which the closure does not say and which the argument needs**: the caps give $T_{abc}\le S_{ab}\le2$ entrywise on their own, so dropping the marginals does not send the programme to $+\infty$ and the comparison is between two finite numbers.

### As a closure of I77, it fails, because it closes a different programme

**The piece I77 had open is the pair cap used ALONGSIDE relation (B), and the record says so in the paragraph directly above the closure.** [diagonal-half.md](../findings/diagonal-half.md) carries, verbatim: *"the pair cap ... governs the rows the (B) engine cannot reach"*, and *"that is why [r871](REVIEW_r871.md) named BOTH (B) and the pair cap and why they are not alternatives: (B) governs the rows at positive eigenvalues and the cap governs the rows at negative ones."* **Relation (B) is not in F10's constraint set**, which [fence-posts.md](../findings/fence-posts.md) states outright: *"[Post F10](../findings/fence-posts.md)'s marginal LP carries (A)"*, with (B) added later by [r326](REVIEW_r326.md)'s repair. So the programme with (B) and the pair cap **adds** a constraint F10 lacks while dropping two it has, and the two are incomparable. **Dropping constraints enlarges a feasible set only when nothing is added, and here something is.**

### The record's own numbers show the pair cap bites exactly where (B) fails

Both of the (B)-augmented programme's recorded breaking points are **infeasible for the pair cap**, so adding it strictly cuts them.

| recorded point | the quantity the cap governs | cap | verdict |
|---|---|---|---|
| [r878](REVIEW_r878.md) §8.1, the $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$ optimum at $7\sqrt3/6=2.0207$ | $S_{PM}=3$ | $\le2$ | violates the cap |
| [r878](REVIEW_r878.md) §5's contracted-(B) optimum, $t_{123}=4$ | $S_{12}\ge t_{123}=4$ | $\le2$ | violates the cap |

At the first, the objective is $12d^3+72d^3\,t_{PMM}$ with $t_{PMM}\le S_{PM}/3$, so the cap replaces $t_{PMM}\le1$ by $t_{PMM}\le2/3$ and the value falls from $84d^3=2.0207$ to at most $60d^3=1.4434$. *That is a ceiling on the cap-augmented value at that one spectrum, computed by hand from [r878](REVIEW_r878.md)'s own display, and it is still above $\theta_0(12)=1.2360$. What it establishes is that the cap is live on the object the closure treats as settled, not that the augmented programme closes.*

### A second gap, which the record names and the closure steps over

The closure sits in [diagonal-half.md](../findings/diagonal-half.md), whose subject is the decomposable locus, where the record's own [I75](../plan.md) block proves the cap **sharpens from $2$ to $1$**. The same file's successor note lists as a way out *"the PAIR CAP, a genuine $T$-inequality this relaxation never used and one that halves on the decomposable locus"*. **A programme carrying the cap at $1$ imposes a constraint strictly stronger than F10's cap at $2$, so it is not a sub-relaxation of F10 and the domination says nothing about it.**

### What should replace the closure

**The closure is right that a pair-cap-only programme is dead, and it should be narrowed to that.** [I77](../plan.md)'s row should record the open piece as the (B)-and-pair-cap programme, with the two recorded cap-infeasible optima as the reason it is not dominated, and with the decomposable-locus cap of $1$ named separately. **The grade of $0$ recorded against the item on this argument is not carried by it.**

*The general sentence the closure leans on, F10's own "a route that relaxes alignment into marginals is already dead", does cover every programme in $T$ alone, including the (B)-augmented one. That is a sound reason to expect the item to fail, and it is a different reason from the one recorded: it is a fence about what $T$ can see, and it applies with no appeal to feasible-set containment.*

## One scope limit that caps all six claims

**The setup the brief quotes puts $\hat U$ and $C$ both diagonal in one frame, so every claim above is a statement about the commuting case.** The same note records, further down, that R28's object is the coupled pair $(R,S)=((E^{\mathsf T}P)^{\circ2},(F^{\mathsf T}P)^{\circ2})$ with $G=E^{\mathsf T}F$ fixed, precisely because $\hat U$ and $C$ have different eigenframes. **A single $Q$ with $U$ and $C$ both diagonal is the case $G$ is a signed permutation, which [r978](REVIEW_r978.md) and [r979](REVIEW_r979.md) pin to $[\hat U,C]=0$.** So claims 1 to 5 are true of the object they are stated about and that object is one stratum of R28's, which is a limit on their reach rather than a defect in them.

## The Lean table

| claim | declaration that types it |
|---|---|
| 1 | **None, and the brief's "untypable" is too strong.** $A=\operatorname{vecMulVec}u\,a+\operatorname{vecMulVec}c\,b$ types directly, and Mathlib has [Matrix.rank_vecMulVec](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Rank.html) giving rank at most $1$ for each summand, with [rank_add_le](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Dimension/LinearMap.html) for the sum. No smooth structure and no new axiom. |
| 2 | **The brief's "NONE EXISTS" is wrong.** `first_order_apply` and `coeff_factor` in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) already type the per-pair form entrywise in its commutator disguise, with $\tilde U=X$, $\tilde C=Y$, $a=\beta\nu^{\circ2}$, $b=\nu$, and `first_order_antisymm` types the half that makes it an equivalence. **One link is missing and it is a base-layer statement**: that $M-M^{\mathsf T}=-\big([\operatorname{diag}a,X]+[\operatorname{diag}b,Y]\big)$ at $M=Q^{\mathsf T}(A\circ Q)$, $A=ua^{\mathsf T}+cb^{\mathsf T}$, $X=Q^{\mathsf T}UQ$, $Y=Q^{\mathsf T}CQ$. It needs `Matrix.hadamard_apply`, `Matrix.mul_apply` and `ring`, and nothing else. |
| 3 | **Typable and untyped.** It is the $\nu_i=\nu_j$ instance of `coeff_factor` composed with $b_i-b_j=\nu_i-\nu_j$, one line. |
| 4 | none, and none can. Correct in the brief. |
| 5 | none for the inference. **The statement the inference leaves open IS typable** as `∀ Q, Q * Qᵀ = 1 → (∀ i, Q i i = 0) → (critical) → (∃ σ, signed permutation)`, and the step from it to [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) is `Splits` at $R=\{i\}$, $C=\{\sigma(i)\}$, which is provable in the current layer today. |
| 6 | none, it is an inference about routes. |

**No Lean was compiled for this review**, the toolchain being single-holder and the findings being statements about what is typable rather than new declarations.

## The analysis-only rule

**It was given to me in the brief and I honoured it.** No sweep, no census, no optimisation of unknown cost and no unbounded falsifier hunt was run. Everything computed here is a screen on objects I constructed for the purpose: the per-pair identity over two hundred random instances, the criticality of permutation matrices, and the Jacobian ranks at $k=4$ and $k=6$ at a fixed handful of $\nu$ patterns. Each finished in seconds, each is reported as a screen, and **none of them carries a positive claim**: the positive statements of this review are claim 1's rank count, claim 2's factorisation, claim 3's symmetry argument, the permutation criticality of the face, and claim 6's constraint-set comparison, all of which are derivations. Script: [r1034_screen.py](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/r1034_screen.py).
