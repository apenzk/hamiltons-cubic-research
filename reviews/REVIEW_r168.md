# Gate 2 review r168, the SOS block enumeration of item 3c

*Cold adversarial review of commit [75a8185](../plan.md), on the brief's four attacks. Derivation throughout; the only computations run are degree-12 symmetric functions and Weyl's dimension formula, both of which finish in seconds and neither of which expands a character.*

## Verdict

**The number is wrong for the group it is attributed to, and the useful object was computed and thrown away.** $77$ is the count of $SO(12)$-irreducibles. The count of $O(n)$-irreducibles (the blocks an $O(n)$-invariant SOS certificate actually has), is $\mathbf{71}$, stably for every $n\ge12$. The six-row constituents, of which there are exactly six, are single $O(12)$-irreducibles that each split into two on restriction to $SO(12)$, and $65+2\cdot6=77$ reproduces the record's number exactly.

| claim in [plan.md](../plan.md) item 3c | verdict |
|---|---|
| $2\omega_2$ in $D_r$ coroots is the Weyl module $[2,2]$ | **holds** for $r\ge4$, and for a reason stronger than the dimension match |
| $77$ blocks at $n=12$, in "$O(n)$-irreducibles" | **the count is right for $SO(12)$ and wrong for $O(12)$**; the $O(12)$ count is $71$ |
| $72$ blocks at $n=8$ | **outside the stable range**, and an $SO(8)$ count; it is not comparable to $77$ |
| trivial multiplicity $2$, fixed by [fence post F2g](../findings/fence-posts.md) | fact **holds**, citation **misattributed**, 2g does not assert exhaustiveness; [ATTEMPTS.md](../ATTEMPTS.md) does, four ways |
| $n=6$ excluded because $D_3\cong\mathfrak{su}(4)$ | **wrong diagnosis, and $n=6$ is recoverable**, highest weight $2\omega_2+2\omega_3$ gives $84$ on the nose |
| "sub-step 1 is done" | **done, but not by what is recorded**; the deliverable is the multiplicity profile, and only its cardinality was kept |
| grade $3\times3\times1=9$ | **defensible, and the corrected figures strengthen it**, the SDP is $71$ blocks of size $\le9$, $477$ unknowns, $89$ constraints |

## The method, which replaces the expensive one

The record's script takes $\mathrm{Sym}^3$ of a $1638$-dimensional character inside `WeylCharacterRing("D6")`, materialising $733\,813\,080$ weights, $5.2$ GB of swap and fifteen locked minutes. That is unnecessary. Restriction $R(\mathrm{GL}_n)\to R(O(n))$ is a homomorphism of $\lambda$-rings, so $\mathrm{Sym}^3$ commutes with it, and the whole calculation can be done on virtual $\mathrm{GL}$ characters in degree $12$.

The one input needed is a $\mathrm{GL}$ virtual character restricting to the Weyl module. Littlewood's rule gives $s_{22}|_O=[2,2]+[2]+[\,]$ and $s_2|_O=[2]+[\,]$, so

$$X:=s_{22}-s_2\ \longmapsto\ [2,2]=\mathrm{Weyl}_n ,$$

and therefore $\mathrm{Sym}^3(\mathrm{Weyl}_n)$ is the restriction of $h_3[X]$. Expanding $h_3[s_{22}-s_2]$ in the orthogonal (Koike–Terada) basis performs Littlewood's restriction and returns the stable decomposition directly. **Cost: under a second, in degree $12$.** The stable range needed is $n\ge2\max_\mu\ell(\mu)=12$, which is exactly the target dimension.

*This method is not new to the record.* [ATTEMPTS.md](../ATTEMPTS.md) Result 3 already names it ("the correct framework is the one already used for degrees 3 and 4), **Newell–Littlewood numbers over $O(n)$, with symmetrisation**, which needs $O(n)$ characters in the stable range plus the $\mathrm{Sym}^k$ rather than $\otimes^k$ projection". The commit's closing wish, that "a method that does not expand the character is worth having before $n=14$", was already granted on the record.

**Validation, against the record's own known-good numbers.** The same expression at $k=2,3,4$ returns the dimension of the degree-$k$ $O(n)$-invariants as $1,\ 2,\ 7$, precisely the values ATTEMPTS.md certifies, and precisely the values the naive $h_k[s_{22}]$ route gets wrong as $3,8,26$. The method reproduces the right answers on the cases where the record already knows them.

## Attack 1, is $2\omega_2$ the Weyl module? Yes, and the dimension match is not the reason

For $D_r$ with $r\ge4$ the second fundamental weight in $\varepsilon$-coordinates is $\omega_2=\varepsilon_1+\varepsilon_2$, so $2\omega_2=2\varepsilon_1+2\varepsilon_2$, the highest weight whose Young label is literally the partition $[2,2]$. Sage's `style="coroots"` numbers the $D_r$ nodes with the fork at $r-1,r$, so node $2$ is the second exterior-power node whenever $r\ge4$. The identification is exact, not inferred from a coincidence of dimensions. **The brief's worry about two irreducibles sharing a dimension does not bite here.**

## Attack 2, $O(n)$ versus $SO(n)$: this is the defect

`WeylCharacterRing("D6")` is the character ring of $\mathfrak{so}(12)$. Its dominant weights index $SO(12)$-irreducibles, and `len(monomial_coefficients())` counts those. The relation to $O(12)$ is standard: an $O(n)$-irreducible labelled by a partition $\mu$ with $\ell(\mu)<n/2$ stays irreducible on restriction to $SO(n)$, while one with $\ell(\mu)=n/2$ **splits into two**, the pair of $\mathfrak{so}$ weights $(\mu_1,\dots,\pm\mu_{n/2})$.

Constituents of $\mathrm{Sym}^3$ of a two-row module have at most six rows, so at $n=12$ the splitting condition $\ell(\mu)=6$ is live, and fusion of associate partitions is not: an associate of a $\le5$-row $\mu$ would need $12-\ell(\mu)\ge7$ rows and no such constituent exists.

The stable decomposition has **six constituents with exactly six rows**:

| $\mu$ | multiplicity |
|---|---|
| $[2,2,1,1,1,1]$ | $2$ |
| $[2,2,2,2,2,2]$ | $1$ |
| $[3,2,2,1,1,1]$ | $1$ |
| $[3,3,2,2,1,1]$ | $1$ |
| $[4,2,1,1,1,1]$ | $1$ |
| $[4,4,1,1,1,1]$ | $1$ |

and sixty-five with five rows or fewer. Hence

$$\#\,O(12)\text{-blocks}=65+6=\mathbf{71},\qquad \#\,SO(12)\text{-blocks}=65+2\cdot6=\mathbf{77}.$$

**The record's $77$ is the $SO(12)$ count, reproduced here to the unit from an independent method.** The label "$O(n)$-irreducibles" in both [plan.md](../plan.md) and the script's docstring is false.

**A discriminating check settles which group the derivation is in.** Summing $m_\mu\cdot\dim$ over the stable decomposition against $O(12)$ dimensions (doubling the six-row entries), gives $733\,813\,080=\binom{1640}{3}$ exactly. Summing against $SO(12)$ dimensions gives $725\,034\,310$, short by $8\,778\,770$. So the $71$ labels are $O(12)$-irreducibles, the module is the same one the record computed, and the discrepancy is purely the group.

**$n=8$ is a second, independent error of the same kind, plus a range error.** At $n=8$ the splitting threshold is $\ell(\mu)=4$ and, worse, Littlewood's rule needs $\ell\le n/2=4$ while constituents run to six rows, so $n=8$ sits *outside* the stable range and its blocks are governed by King's modification rules. $72$ is neither an $O(8)$ count nor comparable with $77$; the apparent growth $72\to77$ is truncation at $n=8$ lifting, not a trend. The stable count is reached at $n=12$ and is constant thereafter.

## Attack 3, the trivial-multiplicity check is weaker than billed, and the fact is stronger

Two separate questions.

- **Is "trivial summand of $\mathrm{Sym}^3$" the same as "cubic invariant"?** Yes. $\mathrm{Weyl}_n$ is self-dual, so $(\mathrm{Sym}^3\mathrm{Weyl}_n)^{O(n)}$ is the space of $O(n)$-invariant cubic forms, which is what $\alpha$ and $\beta$ span. The identification is sound.
- **Does [fence post F2g](../findings/fence-posts.md) fix the count at two?** **No.** 2g's content is the *relation* $\beta=\tfrac12\alpha$ for $n\le5$ and its failure from $n=6$, via Lovelock's dimensionally-dependent identity. It calls $\alpha,\beta$ "the two cubic contractions" but never proves exhaustiveness, it gives independence from $n=6$, i.e. a lower bound of two, not the upper bound the check needs.

**The upper bound is on the record elsewhere, and far more firmly.** [ATTEMPTS.md](../ATTEMPTS.md) proves the cubic invariant space is exactly two-dimensional for all $n\ge6$ by four routes, one of them being $N_{(2,2),(2,2),(2,2)}=2$, the very Newell–Littlewood number this decomposition recomputes. **So the third check is a re-derivation of a recorded theorem, cited to the wrong post.** It is still a real check (it caught the $h_3[s_{22}]$ blunder) but it is not the independent confirmation the commit message presents, and it should point at ATTEMPTS.md.

*One thing the check does do that is not obvious.* At $n=12$ there is a candidate cubic $\varepsilon_{a_1\cdots a_{12}}W^{a_1a_2a_3a_4}W^{a_5a_6a_7a_8}W^{a_9a_{10}a_{11}a_{12}}$, which is $SO(12)$-invariant and $O(12)$-anti-invariant; had it been nonzero the $SO$ trivial multiplicity would have been three. It reads $2$, so the $O$/$SO$ gap does **not** open in the trivial block, which is exactly why the check passed while the block count was wrong.

## Attack 4, the count on its own is close to worthless; the profile is the deliverable

**This is the brief's sharpest question and it lands.** In the symmetry-adapted (Gatermann–Parrilo) formulation, an $O(n)$-invariant SOS certificate for a degree-six invariant $p$ on $\mathrm{Weyl}_n$ is an invariant PSD Gram form on $\mathrm{Sym}^3(\mathrm{Weyl}_n)^*$. Schur's lemma block-diagonalises it into **one PSD matrix per isotypic component, of size equal to that component's multiplicity**. So:

- the **count** gives the number of matrices and *nothing about any of their sizes*;
- the **profile** $\{m_\mu\}$ gives the sizes, hence the number of scalar variables $\sum_\mu m_\mu(m_\mu+1)/2$, hence whether the SDP is runnable at all.

The count is a strictly weaker shadow of the profile. And the profile is not extra work: in the record's own script, `d = S3.monomial_coefficients()` **is** the profile (a map from irreducible to multiplicity) and the very next line reduces it to `len(d)`. *The object sub-step 1 exists to produce was in memory and was discarded; recovering it from the recorded artefact means paying the fifteen minutes again.* On that reading sub-step 1 is **not** done as recorded.

**The profile, stably for $n\ge12$.** Seventy-one blocks, multiplicities running $1$ to $9$, summing to $184$:

| multiplicity $m$ | $9$ | $8$ | $7$ | $6$ | $5$ | $4$ | $3$ | $2$ | $1$ |
|---|---|---|---|---|---|---|---|---|---|
| number of blocks | $1$ | $3$ | $1$ | $4$ | $1$ | $6$ | $10$ | $16$ | $29$ |

with the largest block $\mu=[3,2,1]$ at $m=9$, then $[2,2]$, $[3,3,1,1]$, $[4,2,2]$ at $m=8$.

**What that buys, and it is the finding that matters most for the route.** The invariant Gram cone has

$$\sum_\mu \frac{m_\mu(m_\mu+1)}{2}=\mathbf{477}$$

scalar unknowns, in $71$ PSD blocks of size at most $9$. **A $477$-variable SDP with a maximum block of $9\times9$ is trivially small**, solvable exactly, in rational arithmetic, which is what sub-step 2 was going to demand anyway. The "$734$ million" figure that dominates the commit message is the dimension of a space the certificate never has to touch. *The record currently reports the cost of the wrong computation and omits the number that makes the route look feasible.*

*The corresponding $SO$-invariant parametrisation has $485$ variables in $77$ blocks, a larger and redundant relaxation, since averaging a Gram matrix over $O(n)$ preserves both PSD-ness and the affine constraint, so an $O$-invariant certificate exists whenever any certificate does. The record's blocking is thus not merely mislabelled; it is the looser of the two.*

**The number of affine constraints, which the same method supplies and the record says it never got.** [ATTEMPTS.md](../ATTEMPTS.md) Result 3 states that "the degree-5 and degree-6 invariant dimensions were not obtained, and both attempted routes are closed for stated reasons". The method above returns them:

| degree $k$ | $2$ | $3$ | $4$ | $5$ | $6$ |
|---|---|---|---|---|---|
| $\dim(\mathrm{Sym}^k\mathrm{Weyl}_n)^{O(n)}$ | $1$ | $2$ | $7$ | $\mathbf{19}$ | $\mathbf{89}$ |

*The first three are the record's own certified values; the last two are new, and cost $8.5$ and $75$ seconds.* **Degree six is exactly the number the SOS route needs**: multiplication $(\mathrm{Sym}^2\mathrm{Sym}^3\mathrm{Weyl}_n)^{O(n)}\to(\mathrm{Sym}^6\mathrm{Weyl}_n)^{O(n)}$ is surjective, so item 3c's Gram spectrahedron is

$$\{G\succeq0\}\ \cap\ \text{an affine subspace of dimension } 477-89=\mathbf{388},$$

inside $71$ blocks of size at most $9$. That is a complete and quantitative statement of the SDP sub-steps 2 and 3 have to solve, and it says the problem is small.

**Where the profile still falls short, stated so the item is not oversold.** The block sizes fix the SDP's shape but not its data: setting up the affine constraint needs *explicit* equivariant isotypic projections $\mathrm{Weyl}_n^{\otimes3}\to$ each $\mu$-component, and constructing those is the real engineering of sub-step 3. Neither the count nor the profile supplies them. **Sub-step 1 is genuinely finished only for the shape of the problem.**

## Answers to the brief's questions

**(a) Asserted as new, already on the record.** Three things.

1. The correct method. [ATTEMPTS.md](../ATTEMPTS.md) Result 3 names "Newell–Littlewood numbers over $O(n)$, with symmetrisation" as *the* correct framework, in the same paragraph that closes the two failed routes. The commit installs SageMath and reaches for `symmetric_power` instead.
2. The failure that "the checks caught on first use". That same Result 3 records the $\mathrm{Sym}^k$-over-$\mathrm{GL}$ route as *"fast and wrong"*, with the numbers $3,8,26$ against $1,2,7$ and the correct explanation, "$\mathcal W_n$ is the **traceless** $O(n)$-irreducible and the GL version carries exactly the trace parts that inflate the count". The commit rediscovers this at $n=6$ as $105$ against $84$ and presents it as a new lesson.
3. The trivial multiplicity of two, discussed above.

**(b) $n=6$: wrong diagnosis, and it is recoverable.** The exceptional isomorphism $\mathfrak{so}(6)\cong\mathfrak{su}(4)$ is a red herring. The actual cause is Dynkin node numbering: at $r=3$ the fork sits at nodes $2$ and $3$, so $\omega_2$ is a **half-spin** weight rather than $\varepsilon_1+\varepsilon_2$, and $2\omega_2$ is $\mathrm{Sym}^2$ of the $4$-dimensional spin representation, dimension $10$. **The correct label exists.** Solving $2\varepsilon_1+2\varepsilon_2=a\omega_1+b\omega_2+c\omega_3$ in $D_3$ gives $a=0$, $b=c=2$:

$$\mathrm{Weyl}_6\ =\ \text{the }D_3\text{ irreducible of highest weight }2\omega_2+2\omega_3 .$$

Verified: its dimension is $84$ exactly, and $\mathrm{Sym}^3$ of it totals $102\,340=\binom{86}{3}$ with trivial multiplicity $2$, so all three of the record's checks pass at $n=6$. It gives $46$ $SO(6)$-blocks, *not* comparable to $71$, since $n=6$ is far outside the stable range and the $O(6)$ count is smaller still ($\ell(\mu)=3$ already splits). **The exclusion should be restated: $n=6$ is outside the stable range, which is a real reason; "$2\omega_2$ labels a different irreducible" is a fixable typo in the input.**

**(c) Is the grade of $9$ defensible?** **Yes, and the corrected figures argue for it more strongly than the recorded ones.** The `attackable` factor was raised to $3$ on the strength of "sub-step 1 done, $77$ blocks". That citation is wrong twice over: the number belongs to the wrong group, and a block count alone says nothing about attackability. What *does* justify a $3$ is the profile: **$71$ PSD blocks, maximum size $9$, $477$ scalar variables**, an SDP small enough for an exact rational certificate, which is precisely what sub-step 2 was going to ask for. The `closes` factor of $3$ and `margin` of $1$ are untouched by anything here. *The grade survives; the sentence supporting it in the table does not, and should be rewritten to cite the profile rather than the count.*

## Repairs owed

1. **[plan.md](../plan.md) item 3c and the [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) docstring**: $77$ is the $SO(12)$ count. State $71$ as the $O(n)$ block count, stable for $n\ge12$, with the six splitting six-row constituents named.
2. **Drop the $n=8$ row, or annotate it.** $72$ is an $SO(8)$ count outside the stable range and invites the false reading that the block count grows with $n$.
3. **Record the multiplicity profile**, and with it $\sum m(m+1)/2=477$ and $\max m=9$. This is the actual deliverable of sub-step 1.
4. **Record the degree-$5$ and degree-$6$ invariant dimensions, $19$ and $89$**, which [ATTEMPTS.md](../ATTEMPTS.md) Result 3 leaves open and which the same run produces in under two minutes. $89$ is the constraint count of item 3c's own SDP.
5. **Replace the computation.** $h_3[s_{22}-s_2]$ expanded in the orthogonal basis gives the same answer in under a second with no character expansion, at any $n$ in the stable range. The cost warning then has nothing to warn about.
6. **Recite the trivial-multiplicity check to [ATTEMPTS.md](../ATTEMPTS.md)**, which proves exhaustiveness; [fence post F2g](../findings/fence-posts.md) proves only independence.
7. **Restate the $n=6$ exclusion** on stable-range grounds, and record $2\omega_2+2\omega_3$ as the correct $D_3$ label.
8. **[plan.md](../plan.md) line 257 is corrupted** by commit 75a8185, the sub-steps sentence is duplicated mid-line, `...$\mathrm{Sym}^3[2,2]$*Sub-steps:* (1) the stable Brauer/orthogonal-Young decomposition of...`.

## What the three checks were and were not

They were fixed before output was seen, and they caught a real error, that discipline held and deserves the credit the commit claims for it. But **all three are blind to the defect found here.** The dimension of $[2,2]$, the total $\binom{D+2}{3}$, and the trivial multiplicity are each identical for $O(12)$ and $SO(12)$: the first two are dimensions, which restriction preserves, and the third happens to sit in a block that does not split. *A check that would have caught it is one line, compare the count against the stable symmetric-function answer, or simply ask whether any constituent has $n/2$ rows.*

## Reproduction

Everything above, apart from the $n=6$ label check, is this. It runs in seconds and expands no character.

```python
Sym = SymmetricFunctions(QQ); s = Sym.s(); h = Sym.h(); o = Sym.o()
X = s[2,2] - s[2]                      # o(X) == o[2,2], the Weyl module
d = o(h[3].plethysm(X)).monomial_coefficients()
len(d)                                 # 71  -- the O(n) block count, stable for n >= 12
sorted(d.values())                     # the multiplicity profile, 1..9, summing to 184
[mu for mu in d if len(mu) == 6]       # the six that split on restriction to SO(12)
o(h[6].plethysm(X)).coefficient([])    # 89 -- the degree-six invariants
```

The $n=6$ label check is `WeylCharacterRing("D3", style="coroots")` with highest weight `2*fw[2] + 2*fw[3]`, degree $84$.
