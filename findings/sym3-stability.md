# The block table is stable from $n=12$, and $12$ is the threshold

## What is claimed

The decomposition of $\mathrm{Sym}^3(\mathcal W_n)$ into $O(n)$-irreducibles (which blocks occur, with which multiplicities), is **the same for every $n\ge12$**, and $n=12$ is exactly where that begins. At $n\ge12$ the table is $71$ blocks, $184$ multiplicities, $477$ unknowns; at $n=10$ it is $64$, $182$, $493$.

## The argument

1. **Six rows.** $\mathcal W_n$ is the $O(n)$-irreducible labelled by the partition $(2,2)$, which has two rows. In the stable range the $O(n)$ tensor product is the **Newell–Littlewood** rule (it carries the trace contractions that Littlewood–Richardson lacks) and it cannot raise the row count above the sum of its inputs'. So every constituent of $\mathrm{Sym}^3(\mathcal W_n)$ has $\lambda'_1\le 6$.

2. **The labelling condition.** A partition $\lambda$ labels an irreducible of $O(n)$ exactly when $\lambda'_1+\lambda'_2\le n$, the first two **column** lengths, boundary inclusive. Outside that range Littlewood's modification rules rewrite or cancel the label, which is what makes small-$n$ decompositions move.

3. **The maximum is $12$.** Over the constituents, $\max(\lambda'_1+\lambda'_2)=12$, attained at $(2,2,2,2,2,2)$ (six rows of length two, so both column lengths are $6$), with multiplicity $1$. *The bound is two lines: $\lambda'_2\le\lambda'_1\le6$ gives $\le12$, and equality forces $\lambda'_1=\lambda'_2=6$, six parts each at least two, which at total weight $12$ makes every part exactly two, so the attaining label is unique. It is inadmissible at $n=11$ and admissible at $n=12$, while every other constituent is already admissible at $11$: the threshold turns on this one label ([Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean)).*

4. **From labels to multiplicities.** **Koike–Terada**: the universal character ring maps onto $R(O(n))$ by a *ring* homomorphism commuting with $\mathrm{Sym}^3$, so a decomposition computed once in the stable ring specialises to every $n$ above the threshold. Without this step, stability of the label *set* would not give stability of the *multiplicities*.

Hence for $n\ge12$ every constituent is already a legitimate $O(n)$ label, no modification rule fires, and the table cannot move. **$n=12$ is the threshold itself.**

## Why $n=10$ differs, by three mechanisms

Seven blocks are missing at $n=10$, and the failed label accounts for one of them. Two come from the modification rule ($(2,2,2,2,2,2)$ and the $(2,2,2,2,2)$ block it cancels against) and five from **associate pairs** $[\lambda]$, $[\lambda]\otimes\det$ that restrict to the same $SO(10)$ irreducible, so these $n=10$ counts treat each such pair as one block; under $O(10)$'s own labelling the two are distinct irreducibles. Neither mechanism operates at $n\ge12$.

## Verification

Two reviewers, independently, on identical briefs, by routes sharing no code with the derivation or with each other.

| route | result |
|---|---|
| Littlewood's inverse restriction formula in the ring of symmetric functions, no modification rule | $71/184/477$, and $64/182/493$ at $n=10$ |
| Weyl character formula, block by block | $n=11\to70/183$, $n=12\to77/191$ (SO), $n=13\to71/184$, zero mismatches |
| $\sum m_\lambda\dim_{O(n)}[\lambda]=\binom{\dim\mathcal W_n+2}{3}$ on one fixed table | holds at $n=12,13,14,16,18$; **fires** at $n=10$ |
| the same identity for $\mathrm{Sym}^2$ at $n=8$ and $\mathrm{Sym}^4$ at $n=16$ | the $n=4k$ boundary confirmed at $k=2,3,4$ |

The $n=12$ count of $77$ rather than $71$ is the six six-row labels splitting at $\ell=n/2$, so the self-associate boundary labels are present as full $O(12)$ irreducibles. The boundary is pinned by the Weyl tensor itself: $\dim\mathcal W_3=0$ where $\lambda'_1+\lambda'_2=n+1$, and at $n=4$, $\dim\mathcal W_4=10$ with $\lambda'_1+\lambda'_2=4=n$, no room for an off-by-one in either direction.

[run_n12_stability.py](../scripts/runs/run_n12_stability.py), [REVIEW_r224.md](../reviews/REVIEW_r224.md), [REVIEW_r225.md](../reviews/REVIEW_r225.md).

## Scope: what the theorem does not give

It fixes the **shape** of the certificate problem (which blocks, which multiplicities, how many unknowns), at every $n\ge12$. It does **not** make the constraint data $n$-independent: the $89$ invariant sextics, the covariants and the orbit constraint are computed at a given $n$, and the theorem says nothing about their values.

**So a certificate built at $n=12$ settles Conjecture A at $n=12$, and Lemma L254 below records one.** Transferring it upward is a separate question, and the programme has no route to it.

#### Lemma L63, the $n=12$ block table

*Verified `HYPOTHESIS-DEBT`, narrowed and relabelled, [ROUND_L63](../verification/ROUND_L63.md). The dimension and the fusion arithmetic are typed in [L63Statement.lean](../lean/HamiltonsCubic/Results/L63Statement.lean).*

**Lemma.** $\dim\mathcal W_{12}=1638$, from the closed form $\dim\mathcal W_n=\tfrac1{12}n(n+1)(n+2)(n-3)$, and Weyl's dimension formula for $D_6$ gives $1638$ at the weight $(2,2,0,0,0,0)$. *The identification of $\mathcal W_{12}$ with that irreducible is classical and has no source filed; a matching dimension does not pin it, $(1^6)$ and $(1^5,-1)$ both having dimension $462$.* $\dim\mathrm{Sym}^3\mathcal W_{12}=\binom{1640}3=733\,813\,080$.

**Observation at $n=12$, from a decomposition run with no argument on file.** $\mathrm{Sym}^3(\mathcal W_{12})$ carries $77$ $SO(12)$-constituents with $191$ multiplicities; twelve are chiral, in six pairs with $\lambda_6\ne0$ at multiplicities $2,1,1,1,1,1$. *Given that census*, an orientation-reversing element fuses each chiral pair, and if no non-chiral constituent occurs as both $[\lambda]$ and $[\lambda]\otimes\det$, $O(12)$ sees $71$ blocks and $184$ multiplicities, the arithmetic $77-6=71$, $191-7=184$ being exact.

*The stability argument in this file's opening sections proves a different statement, that the table is the same for every $n\ge12$, and supplies none of these figures.*

*Lemma L64, the transfer mechanism, is proved in [fence-posts.md](fence-posts.md) under post F32 and its block lives there.*

---

*Re-filed here 2026-09-02 from [sym3-blocks.md](sym3-blocks.md) by the parallel sort of [findings/](.). Conventions: [conventions.md](conventions.md).*

## Separating the $71$ $O(12)$ blocks: six invariants, and $\mathrm{Pf}^2$ as the sixth
*From findings/sym3-blocks.md. Belongs in sym3-stability.md because its subject is the stable-range $n\ge12$ block table (the $71$ $O(12)$ blocks against the $77$ $SO(12)$ constituents) which that file owns as Lemma L63, rather than the $n=5$ separation this file proves.*

**At $n=12$ SIX invariants separate the $71$ $O(12)$ blocks, and the sixth is $\mathrm{Pf}^2$.** *Reviewer 178 caught the count: $p_2,\dots,p_{10}$ are $p_1,\dots,p_5$ in the variables $\ell_i^2$, so Newton gives only $e_1,\dots,e_5$ of that six-element multiset. **$e_6$ needs $p_{12}$**, and $e_6=\prod_i\ell_i^2=\mathrm{Pf}^2$.*

**That correction makes the statement right rather than weaker.** $\rho(D_6)=(5,4,3,2,1,0)$ has $\rho_6=0$, so $\ell_6=\lambda_6$; the invariants $p_2,\dots,p_{12}$ are $p_1,\dots,p_6$ in the variables $\ell_i^2$, so Newton returns **every** elementary symmetric function $e_1,\dots,e_6$ and the multiset $\{\ell_i^2\}$ is recovered outright, *injectivity, where "functions of $\{\ell_i^2\}$" alone would only give well-definedness, which is 177's objection to the earlier wording*. That multiset is the $O(12)$ label **under a hypothesis worth stating**, *an $O(12)$ label with more than six rows, the $\det$-twist of one with $\lambda_6=0$, restricts to the same $SO(12)$ module and would be invisible here; it does not arise because every constituent of $\mathrm{Sym}^3([2,2])$ has at most six rows in the stable range*, since $\ell_1>\dots>\ell_5>|\ell_6|\ge0$ recovers $\lambda$ with $\lambda_6\ge0$. **$\mathrm{Pf}^2$ is $O(12)$-invariant while $\mathrm{Pf}$ is not**, which is why excluding $\mathrm{Pf}$ costs no separating power, and the earlier "five Casimirs" was the same list with $e_6$ dropped.

*The exclusion is not vacuous.* **Reviewer 177 exhibits the six chirality pairs with $\lambda_6\ne0$**, $(2,2,2,2,2,\pm2)$, $(3,3,2,2,1,\pm1)$, $(4,4,1,1,1,\pm1)$, $(3,2,2,1,1,\pm1)$, $(4,2,1,1,1,\pm1)$ and $(2,2,1,1,1,\pm1)$ at multiplicity $2$, giving $65+2\cdot6=77$ $SO(12)$ constituents against $65+6=71$ $O(12)$ blocks, with $\sum m_\lambda d_\lambda=733\,813\,080=\binom{1640}3$ exactly. **$\mathrm{Pf}$ separates the two halves of each pair, so including it would split blocks that must stay fused; $\mathrm{Pf}^2$ does not.** *And "six is the $SO$ count" was backwards, reviewer 177. **Both rings need six.** The $W(D_6)$-invariants are $p_2,\dots,p_{10}$ plus $\mathrm{Pf}$; the $O(12)$-invariants are $p_2,\dots,p_{12}$. The two lists differ in their sixth element alone, and either $p_{12}$ or $\mathrm{Pf}^2$ may serve as that sixth generator.* **They are not equal**, *reviewer 179*: $p_{12}=\sum_i\ell_i^{12}$ and $\mathrm{Pf}^2=\prod_i\ell_i^2$ are different polynomials, and at the trivial block $\ell=\rho=(5,4,3,2,1,0)$ gives $\mathrm{Pf}^2=0$ against $p_{12}=261\,453\,379$. **What is true is that $\mathrm{Pf}^2=e_6(\ell^2)$ and $p_{12}=p_6(\ell^2)$ generate the same extension of $\mathbb Q[p_2,\dots,p_{10}]$ by Newton**, so either completes the $O(12)$ list. *The degree bookkeeping holds: $W(D_6)$ has degrees $2,4,6,8,10$ and $6$; $W(B_6)$ has $2,4,6,8,10,12$.*

## The value at $n=12$, on a certificate built outside this project

#### Lemma L254, Conjecture A at $n=12$, by an exact sum-of-squares certificate

*Recorded 2026-09-26 by the user's decision. **Gate 2: no verdict.** A machine certificate from an outside project, replayed here end to end; its qualification is stated below and travels with every citation.*

**Statement.** On $\mathcal W_{12}$, with the full four-index norm and $Q(R)_{ijkl}=\sum_{p,q}\big(R_{ijpq}R_{klpq}+2R_{ipkq}R_{jplq}-2R_{iplq}R_{jpkq}\big)$ as fixed in the outside $n=12$ SOS certificate (unpublished, held in the private record),

$$f_{12}(R)=\tfrac{55}{36}\lvert R\rvert^6-\langle Q(R),R\rangle^2$$

is a sum of $170$ positive rational multiples of squared norms of $O(12)$-equivariant cubic maps, over $65$ of the $71$ blocks of [Lemma L63](#lemma-l63-the-n12-block-table). Hence $\langle Q(R),R\rangle\le\Theta_{12}\lvert R\rvert^3$ on $\mathcal W_{12}$, attained at $S^6\times S^6$, so $M(12)=\Theta_{12}$. **The constant is the record's**: the certificate's convention gives a two-sphere product the ratio $11(p-1)(q-1)/(5pq)$, which at $p=q=6$ is $\tfrac{55}{36}=\Theta_{12}^2$.

**The equality case is not claimed.** That the balanced orbit is the only maximiser does not follow, as for [L61](sym3-blocks.md).

**What it rests on.**

- **An outside generator's operator tables.** The identity is verified exactly, over $\mathbb Q$ and at the primes $1000003$ and $1000033$, against a $22{,}915\times477$ table of sextic invariants that the outside project built. Replayed here end to end from its parent archives, every validator passing, and on a second backend in Sage (the outside $n=12$ SOS certificate (unpublished, held in the private record)).
- **Its conventions, independently checked only in part.** The translation from Gram coordinates to polynomials (the contraction seeds, the seminormal bases and the block scales $\kappa_\lambda$) is checked against explicit tensors only for the target and for blocks of output rank at most $4$: $45$ Gram values and four tensors, one of them non-diagonal. The outside project recorded and corrected two errors in exactly this layer. **An independent computation of the $71$ scales $\kappa_\lambda$ is the check that would lift this qualification.**
- **No proof a reader can check by hand**, the property that closed [R1](../routes.md).

The certificate is the outside $n=12$ SOS certificate (unpublished, held in the private record). The operator tables are on disk beside it, outside version control, with their digests in the outside $n=12$ SOS certificate (unpublished, held in the private record).
