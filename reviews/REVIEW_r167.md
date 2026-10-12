# Review r167, the SOS block enumeration of item 3c

Cold audit of [sub-step 1 of item 3c](../plan.md) and [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage), commit `75a8185`. Everything below was rederived from the definitions; the code under review was read but never imported. Reviewer scripts in [scripts/reviewers/r167/](../scripts/reviewers/r167/).

## Verdict table

| # | Claim audited | Verdict |
|---|---|---|
| 1 | `2*omega_2` in `D_r` coroots style is the Weyl module `[2,2]` | **CONFIRMED** for $r\ge4$; the label is exactly $2e_1+2e_2$ |
| 2 | "$\mathrm{Sym}^3(\mathrm{Weyl}_n)$ into **$O(n)$**-irreducibles gives 77 blocks at $n=12$" | **REFUTED.** $77$ is the $\mathbf{SO(12)}$ count. The $O(12)$ count is $\mathbf{71}$ |
| 3 | trivial multiplicity $2$, matching [fence post F2g](../findings/fence-posts.md) | value **CONFIRMED** independently; its **provenance overstated** two ways |
| 4 | the block count is the deliverable of sub-step 1 | **REFUTED.** The deliverable is the multiplicity profile, which the script computed and discarded |
|, | "sub-step 1 is done" | **half done.** Sub-step 1 asks for the *stable* decomposition; the script produced two $n$-specific $SO(2r)$ counts. The stable decomposition is supplied below |

**The headline number is wrong, and the number is stable, not growing.** $\mathrm{Sym}^3(\mathrm{Weyl}_n)$ has **$71$ $O(n)$-irreducible blocks for every $n\ge12$**, the labels and multiplicities do not depend on $n$ at all. The largest block is $9\times9$ and the whole symmetry-reduced SDP has **$477$ free parameters**.

## What was reproduced before anything was attacked

[chirality_n6_n8.sage](../scripts/reviewers/r167/chirality_n6_n8.sage) reruns $n=8$ from the brief's own recipe: $\dim W=300$, $\dim\mathrm{Sym}^3=4\,545\,100$, **72 blocks**, trivial multiplicity $2$. Every figure in the record's $n=8$ row is reproduced. The $n=12$ row was not rerun, see the method below, which reaches it in seconds.

## Claim 1, `2*omega_2` is `[2,2]`: confirmed for $r\ge4$

For $D_r$ with $r\ge4$, node $2$ lies on the chain, $\omega_2=e_1+e_2$, so $2\omega_2=(2,2,0,\dots,0)$, the Young label $[2,2]$ on the nose, not a dimension coincidence. Since $\ell([2,2])=2<r$, the $O(2r)$-irreducible $[2,2]$ restricts *irreducibly* to $SO(2r)$ and the two labels name the same space. The dimension identity $(n+2)(n+1)n(n-3)/12$ is then a consequence, not the evidence. **Sage's `WeylCharacterRing` convention is the one this implies.** No defect.

## Claim 2, $O(n)$ versus $SO(n)$: the count is the wrong group's, and by exactly six

`WeylCharacterRing("D6")` is the character ring of $SO(12)$. The record's own text says "decomposed into $O(n)$-irreducibles" and "the orthogonal character ring is the right home"; both are wrong about the group.

**The mechanism.** $O(2r)$-irreducibles are labelled by partitions $\lambda$ with $\lambda'_1+\lambda'_2\le2r$. On restriction to $SO(2r)$:

- $\ell(\lambda)<r$: irreducible, and $\lambda$ shares its image with its associate $\lambda^A$ (which has $2r-\lambda'_1>r$ rows). Two $O$-blocks **fuse** into one $SO$-block.
- $\ell(\lambda)=r$: $\lambda$ is self-associate and **splits** into the mirror pair $(\lambda_1,\dots,\lambda_{r-1},\pm\lambda_r)$. One $O$-block becomes two $SO$-blocks.

So the two counts differ in both directions and neither dominates. The question is which of the two effects fires here.

**Both fire, and the arithmetic is exact.** A method that never expands a character settles it, [sym3_weyl_stable.sage](../scripts/reviewers/r167/sym3_weyl_stable.sage):

1. $V^{GL}_{[2,2]}(\mathbb R^n)\big|_{O(n)}=[2,2]\oplus[2]\oplus[0]$ and $V^{GL}_{[2]}\big|_{O(n)}=[2]\oplus[0]$, so the Weyl module is the **virtual $GL$ class $s_{22}-s_2$** restricted. (Dimensions: $1716=1638+77+1$ at $n=12$; $105=84+20+1$ at $n=6$, the same $105$ the record's first attempt tripped over.)
2. Restriction $GL(n)\to O(n)$ is a homomorphism of $\lambda$-rings, so $\mathrm{Sym}^3(\mathrm{Weyl}_n)=\mathrm{restrict}\big(h_3[s_{22}-s_2]\big)$.
3. $h_3[s_{22}-s_2]$ has $39$ Schur terms, **all of length $\le6$**.
4. Littlewood's restriction rule $V^{GL}_\mu|_{O(n)}=\sum_\lambda\big(\sum_{\beta\text{ even rows}}c^\mu_{\lambda\beta}\big)[\lambda]$ is valid whenever $\ell(\mu)\le n/2$, hence for every $n\ge12$, exactly the range the item cares about.

The result: **$71$ $O(n)$-irreducibles, all multiplicities positive, labels and multiplicities independent of $n$ for $n\ge12$.** Since every $\lambda$ has $\ell(\lambda)\le6$, no $\lambda$ has an associate in the module and **no fusion occurs at $n=12$**. Six labels have exactly $6$ rows, so at $n=12$ each splits:

| self-associate label | multiplicity |
|---|---|
| $[2,2,1,1,1,1]$ | $2$ |
| $[2,2,2,2,2,2]$ | $1$ |
| $[3,2,2,1,1,1]$ | $1$ |
| $[3,3,2,2,1,1]$ | $1$ |
| $[4,2,1,1,1,1]$ | $1$ |
| $[4,4,1,1,1,1]$ | $1$ |

$$\#SO(12)\text{-blocks}=71+6=\mathbf{77}.$$

**That reproduces the record's number exactly, by an algorithm that shares no step with it**, and identifies it as the $SO(12)$ count. The $O(12)$ count is $71$.

**Five independent checks on the method**, all passing:

- $\sum_\lambda m_\lambda\dim_{O(12)}[\lambda]=733\,813\,080=\binom{1640}{3}$, with $\dim_O=2\dim_{SO}$ on the six $6$-row labels;
- the same sum at $n=14$ and $n=16$: $4\,874\,429\,560$ and $24\,883\,123\,720$, both $=\binom{D+2}{3}$;
- the doubling rule checked concretely: $\Lambda^6(\mathbb R^{12})=[1^6]$ has $\dim_{SO}=462$ for each chirality and $2\cdot462=924=\binom{12}{6}$;
- the identical pipeline run at $\mathrm{Sym}^2$ reproduces a direct `D6` computation **block for block**, $13$ blocks, profile $[2,1^{12}]$, total $1\,342\,341$;
- trivial multiplicity $2$, and the trivial multiplicity of the *ambient* $\mathrm{Sym}^3(V^{GL}_{[2,2]})|_{O(12)}$ comes out $8$, matching a hand count of the six invariants in the complement ($\lvert W\rvert^2$; $\mathrm{tr}\,S^3$; $\lvert S\rvert^2$; $1$; $S\subset\mathrm{Sym}^2W$; $[2,2]\subset\mathrm{Sym}^2S$).

**A falsifiable prediction the record can cheaply test.** From $n=14$ on, $\ell(\lambda)\le6<r$, nothing splits, and the $SO(2r)$ count equals the $O$ count. So a `D7` run would report **$71$ blocks, fewer than the $77$ at $n=12$**. The apparent growth $72\to77$ in the record's table is an artifact of the group, not a fact about the module.

**How much this costs the route: less than it looks.** The polynomial is $O(n)$-invariant, hence also $SO(n)$-invariant, so an $SO(12)$-symmetry-adapted SOS is *valid*, merely coarser. It buys $77$ PSD blocks with $485$ free parameters instead of $71$ with $477$; the two chiral blocks of each split pair carry the same matrix, forced by the reflection. **The defect is the label and the reported number, not the feasibility of the route.** Both chiralities are of real type here ($\ast^2=+1$ on $\Lambda^6\mathbb R^{12}$), so no complex or quaternionic block arises either way.

## Claim 3, the trivial-multiplicity check: right number, overstated in two places

The value is **CONFIRMED**: the $O(12)$-invariant cubics number exactly $2$, from my computation, which never used the character ring. And "trivial summand of $\mathrm{Sym}^3$" **is** the same as "cubic invariant", $\mathrm{Weyl}_n$ is self-dual as an $O(n)$-module, so $(\mathrm{Sym}^3 W)^{O}\cong(\mathrm{Sym}^3 W^*)^{O}$, the cubic invariant polynomials. Two overstatements, though:

- **Post F2g fixes only the lower bound, and the record was cited in the wrong place.** [Post F2g](../findings/fence-posts.md) names the two cubic contractions $\alpha$ and $\beta$ and proves $\beta=\tfrac12\alpha$ for $n\le5$ and *not* for $n\ge6$. That gives $\dim\ge2$ for $n\ge6$ by independence, and $\dim=1$ for $n\le5$. It never bounds the space above by $2$. The upper bound is proved elsewhere on the record, [ATTEMPTS.md](../ATTEMPTS.md) Result 3, four ways, including the observation that **in the stable range the count is the Newell–Littlewood number $N_{(2,2),(2,2),(2,2)}=2$**. So the number was already fixed at two from both sides; the commit cited the one post that gives only half of it.
- **The check silently assumed a fact about $\varepsilon$.** The script read the trivial multiplicity in the $SO(12)$ ring, which counts $O(12)$-invariants **plus $\det$-pseudo-invariants**. At $n=12$ that is not vacuous: $\varepsilon^{a_1\cdots a_{12}}$ has exactly the $12$ indices that three Weyl tensors carry, so $\varepsilon\,W\,W\,W$ is a candidate $SO(12)$-invariant that is not $O(12)$-invariant. Getting $2$ rather than $3$ *proves* that contraction vanishes identically, a genuine and slightly interesting fact, obtained by accident. **This is the one place the $O$/$SO$ confusion could have corrupted a check, and the only reason it did not is a coincidence the record did not know it was relying on.**

## Claim 4, the count alone is close to worthless

An $O(n)$-invariant SOS certificate for a degree-six form has one PSD matrix per isotypic block of $\mathrm{Sym}^3(\mathrm{Weyl}_n)$, **sized by that block's multiplicity**. The count fixes how many matrices; the profile fixes how big, and the profile is the whole content, it is what turns a $733\,813\,080\times733\,813\,080$ Gram matrix into something an SDP solver can hold.

**The script computed the profile and threw it away.** `d = S3.monomial_coefficients()` is a dictionary whose *values* are the multiplicities; the script reports `len(d)` and returns `d` to nobody. Supplying it:

- **$n\ge12$, $O(n)$ blocks:** profile $9,8,8,8,7,6,6,6,6,5,4^{6},3^{10},2^{16},1^{29}$, largest block $\mathbf{9\times9}$, multiplicities summing to $184$, and $\sum_i m_i(m_i+1)/2=\mathbf{477}$ free Gram parameters. Under $SO(12)$ instead: $77$ blocks, $485$ parameters.
- **$n=8$:** $72$ $SO(8)$ blocks, largest multiplicity $13$, $\sum m(m+1)/2=722$.

**This is the good news of the audit.** A $477$-parameter SDP with no block above $9\times9$ is small, and it is *constant in $n$* for all $n\ge12$. That is a far stronger statement of tractability than "77 blocks", and it is what sub-step 1 was for.

## Answers to the brief's questions

**(a) Anything asserted as new that the record already holds.** Two things, and the second is the expensive one.

- Sub-step 1 asks for the *stable* Brauer/orthogonal-Young decomposition; the script delivers two $n$-specific $SO(2r)$ block counts, a different object. The stable decomposition ($n$-independent labels and multiplicities for all $n\ge12$), is delivered here.
- **The record already held the exact tool the computation needed and did not use it.** [ATTEMPTS.md](../ATTEMPTS.md) Result 3 computes the cubic-invariant count as the stable **Newell–Littlewood number** $N_{(2,2),(2,2),(2,2)}=2$, precisely the trivial block of the stable orthogonal decomposition, done in the orthogonal universal-character ring, $n$-free and instant. Running the *whole* of $\mathrm{Sym}^3[2,2]$ through the same machinery is that computation with $h_3$ in place of the trivial component. Had the script started from Result 3's method rather than from `WeylCharacterRing`, it would have reached $71$ in under a second and never touched the $734$-million-dimensional character, the $5.2$ GB of swap, or the wrong group.

**(b) The $n=6$ exclusion.** The diagnosis is the right family of reason but the wrong statement, and **$n=6$ is fully recoverable**. In $D_3$, node $2$ is one of the two *fork* nodes, so $\omega_2=\tfrac12(1,1,-1)$ is a half-spin weight and $2\omega_2=(1,1,-1)$ is the $10$-dimensional $\mathrm{Sym}^2\mathbb C^4$ under $D_3\cong A_3$, which is where the reported $10$ comes from. The operative cause is the *node numbering at $r=3$*, not the exceptional isomorphism as such. Since $[2,2]=2e_1+2e_2$ and $e_1+e_2=\omega_2+\omega_3$, the correct label is

$$\mathrm{Weyl}_6=\ \text{the }D_3\text{-irreducible of highest weight }2(\omega_2+\omega_3),$$

**verified: dimension $84$ exactly**, $\dim\mathrm{Sym}^3=102\,340=\binom{86}{3}$, trivial multiplicity $2$. It gives $46$ $SO(6)$ blocks, of which $30$ are chiral, **$15$ mirror pairs, each pair carrying equal multiplicity** as the $O(6)$ action forces $(3,3)$, $(7,7)$, $(2,2)$, … So even at $n=6$ the $SO$ count overshoots by $15$ out of $46$. $n=6$ sits below Littlewood's range, so the residual fusion count $p$ there is not settled here; the $O(6)$ count is $31+p$.

**(c) Is grade $9$ defensible?** **Yes, and better supported than before**, but the row's *justification* has to be rewritten. The impact and `closes` factors are untouched by sub-step 1. The tractability factor of $3$ is now backed by something real: $71$ blocks, none above $9\times9$, $477$ free parameters, constant in $n$ for $n\ge12$. What must change is the table cell and the prose: the number is $71$, the group is $O(n)$, the count does not grow with $n$, and the deliverable is the profile.

## Corrections owed to the record

1. [plan.md](../plan.md) item 3c table: the block column is an $SO(2r)$ count. The $O(n)$ count is $71$, stable for all $n\ge12$. The $n=8$ row's $72$ is an $SO(8)$ count of which $42$ blocks are chiral ($21$ mirror pairs), so the $O(8)$ count is $51+p$, it is not $72$.
2. The script's docstring and the plan's prose both say "$O(n)$-irreducibles" and "the orthogonal character ring". `WeylCharacterRing("D6")` is $SO(12)$'s. The sentence "the orthogonal character ring is the right home" is the confusion in one line.
3. Report the multiplicity profile, not the count. It is already in `d`.
4. "fence post F2g fixes independently at two" → post F2g fixes it at **at least** two; the upper bound is separate.
5. The `assert trivial == 2` also guards $n=14$, which has never been run. It happens to be true.
6. `CASES` includes $n=10$ ($D_5$, the default `nmax`), where $\ell(\lambda)$ can reach $6>r=5$: there **both** fusion and splitting can fire, and the reported count is neither group's cleanly.
7. [plan.md](../plan.md) line 257 carries a duplicated fragment: `...$\mathrm{Sym}^3[2,2]$*Sub-steps:* (1) the stable Brauer/orthogonal-Young decomposition of $\mathrm{Sym}^3[2,2]$, which...`.
8. The cost note asks for "a method that does not expand the character … before $n=14$". [sym3_weyl_stable.sage](../scripts/reviewers/r167/sym3_weyl_stable.sage) is that method: seconds, ~100 MB, and it verifies $n=14$ and $n=16$ by dimension without materialising a $4.9$-billion or $24.9$-billion-dimensional character.


## Addendum, written after the report was drafted

[sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) was rewritten in the working tree while this review was in flight. **The rewritten version agrees with this report on every number**: $71$ blocks, multiplicities $1\ldots9$ summing to $184$, $477$ scalar unknowns, largest block $9\times9$, trivial multiplicity $2$, and it names the $77$ as an $SO(12)$ count arising from six constituents with $n/2$ rows, $65+2\cdot6$ against $71$. It reaches this through `SymmetricFunctions(QQ).o()`, the orthogonal universal-character basis, which is Sage's own implementation of the stable Littlewood restriction that [sym3_weyl_stable.sage](../scripts/reviewers/r167/sym3_weyl_stable.sage) builds by hand out of $c^\mu_{\lambda\beta}$. **Two independent implementations of that restriction, agreeing block for block and multiplicity for multiplicity.**

It also supplies the constraint side, which this review did not compute: the $O(n)$-invariant dimensions by degree are $1,2,7,19,89$ for $k=2\ldots6$, so the symmetry-reduced SDP is **$477$ unknowns against $89$ constraints**. That is the full statement sub-step 1 was after.

Corrections 1, 2, 3 and 8 are actioned by that rewrite; 5, 6 and 7's script half no longer apply to a file that has dropped `CASES` entirely; 4 is actioned in the right direction, the citation now pointing at [ATTEMPTS.md](../ATTEMPTS.md) Result 3. **What remains owed is [plan.md](../plan.md)**: its item 3c table still reports $72$ and $77$ as $O(n)$ block counts, still reads as growth in $n$, and the duplicated fragment at line 257 stands.
