# Review r195, Q is block-diagonal by weight because the form is Hermitian, $14$ is attained rather than bounded, and the multiplicity Gram is measured at the one probe that cannot see the object

Gate 2, adversarial. Everything below was re-derived from definitions and re-measured with scripts written for this review, under [scripts/reviewers/r195/](../scripts/reviewers/r195/). Exact arithmetic over $\mathbb{Q}(i)$ throughout; the only floating-point numbers in the review are wall-clock times. The Hermitian Gram $H$, the Sym$^3$ form and the bilinear Gram were rebuilt **from the cached tensors rather than imported**, so nothing in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) is trusted, and importing it is in any case unusable here, since its module level runs three $\kappa$ trials on dense Sym$^3$ cubes.

## Verdict table

| Claim | Verdict | What decided it |
| --- | --- | --- |
| 1a, Q is block-diagonal by weight within a copy, because word-basis vectors of different weight are orthogonal | **Upheld, and provable in two lines rather than measured, but the stated reason is incomplete, and the shipped code computes not one of the entries that could falsify it** | $H_{ab}=0$ unless the two weights agree (rebuilt with the weight filter removed: $45$ nonzero of $1225$, $0$ across distinct weights), so every bijection term in `sym3_ip` forces $\mathrm{mwt}(t)=\mathrm{mwt}(s)$. It is a property of the **conjugation**: the invariant bilinear Gram on the same basis is supported *exactly* on the pairs $(\mu,-\mu)$, $40$ of the $40$ entries off the zero weight |
| 1b, the blocks are at most $14$ wide | **The number is right and is attained, but it is an enumerated maximum, not a bound, and it is the third unrelated $14$ in this file** | Freudenthal over the $24$ blocks: $\max=14$, in $V(6,3)$ at $(1,0)$ and $V(6,4)$ at $(0,0)$. Cross-validated by $\sum_\mu m(\mu)=\dim$ on every block and by a $169$-equation character identity. $V(7,4)$ would give $18$; $14$ survives only because Sym$^3$ stops at $(6,6)$ |
| 1c, the cost estimate at line 133 | **A conflation of the same shape reviewer 192 found** | `sup[-14:]` are the fourteen largest supports **anywhere among the 7770 vectors**; the widest weight block is fourteen vectors of **one** weight in **one** copy. The exact figure the run will print is computable in advance: $32\,530$ stored entries against $2\,669\,238$ dense |
| 2 (every weight block is square | **True, and it is exactly the character identity), verified independently, and unlike its neighbours it has a working negative control** | $0$ of $169$ weights differ. Three perturbations of the block table make it fire at $69$, $68$ and $1$ weights. But it tests the **block table**, is implied by the $7770$ count on line 68, and does not establish what its comment claims, that the vectors are a **basis** |
| 3, the multiplicity Gram $h$ from the single probe $(0,0)$ | **The normalisation is correct and one probe is mathematically enough; the measurement as shipped is unfalsifiable, because $(0,0)$ is the unique probe that never applies a lowering operator** | Schur verified at $984$ further probe entries across four blocks, $0$ disagreements. $R_i[0]=u_i$ for **any** word list, so the shipped probe returns the same $h$ on a corrupted identification, demonstrated |
| 4, the checks' negative controls | **"$h$ Hermitian" and "$h$ is not the identity" are the twelfth and thirteenth entries; squareness is not** | Both pass on random garbage vectors, on every block. "$h$ Hermitian" is a theorem about `ip3` for *any* input. The negative control that works (a same-weight transposition inside copy 2), passes both shipped checks and fires the multi-probe test at $6$ of $64$ and $10$ of $112$ |
| 5, stage 3's four declared checks | **Still absent, exactly as [plan.md](../plan.md) records; only the line count moved** | There is no $W$, no sample point, no $B$, no rank and no $F_5$ anywhere in the $174$ lines. The file ends at the Q print |

---

## Claim 1a, the orthogonality is real, the reason given is half of it, and nothing in the file could have caught it

### The two-line derivation

Write $T_a$ for the $a$-th weight-basis vector as a rank-four tensor and $H_{ab}=\sum_{ijkl}(T_a)_{ijkl}\overline{(T_b)_{ijkl}}$. Two facts settle the claim.

1. $H_{ab}=0$ whenever $\mathrm{WT}[a]\neq\mathrm{WT}[b]$. This is not an accident of the basis: $SO(5,\mathbb{R})$ acts on four-index tensors by real orthogonal transformations, so $H$ is the Hermitian extension of an invariant real inner product, the compact torus acts on it by unit-modulus characters, and distinct characters are orthogonal.
2. `sym3_ip(t, s)` is the plain bijection sum $\sum_{\sigma\in S_3}\prod_i H_{t_i\,s_{\sigma(i)}}$. A term survives only if $\mathrm{WT}[t_i]=\mathrm{WT}[s_{\sigma(i)}]$ for every $i$, and summing over $i$ gives $\mathrm{mwt}(t)=\mathrm{mwt}(s)$.

So monomials of distinct Sym$^3$ weight are orthogonal, hence so are any two vectors supported on disjoint weight sets, hence Q is block-diagonal by weight inside a copy. The claim holds under the Hermitian form actually in use.

Fact 1 was re-established here rather than taken from [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py): [common195.py](../scripts/reviewers/r195/common195.py) rebuilds $H$ from `wbasis_tensors` **with no weight filter at all**, over all $1225$ pairs. Result: $45$ nonzero entries, $0$ of them pairing distinct weights, $H$ Hermitian. This reproduces reviewer 192's $45$ by a third route.

### The stated reason omits the load-bearing word

The comment at [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) lines 120–123 gives the reason as "word-basis vectors of different weight are orthogonal", as though the weight grading were doing the work. It is not; the conjugation is. [bilinear_gram.py](../scripts/reviewers/r195/bilinear_gram.py) builds the **invariant bilinear** Gram $B_{ab}=\sum_{ijkl}(T_a)_{ijkl}(T_b)_{ijkl}$ from the same tensors, again over all $1225$ pairs:

| Gram | nonzero of $1225$ | on $\mu=0$ | equal weights, $\mu\neq0$ | $(\mu,-\mu)$, $\mu\neq0$ | anything else |
| --- | --- | --- | --- | --- | --- |
| Hermitian $H$ | $45$ | $5$ | $40$ | $0$ | $0$ |
| bilinear $B$ | $45$ | $5$ | $0$ | $40$ | $0$ |

Away from the zero weight, where the two coincide, the bilinear form is supported **exactly** on the anti-diagonal and the Hermitian form **exactly** on the diagonal. Under it the same word basis gives a block-**anti**-diagonal Q, and every sentence in that comment is false as written. This matters because bilinear pairings are not hypothetical in this record (reviewer 182's apolarity route is one) and the file offers no way to tell which form its comment is about.

*The width bound happens to survive either convention: $-1\in W(B_2)$, so $m(\mu)=m(-\mu)$ and the anti-diagonal blocks are the same sizes. The labelling does not survive.*

### The one pattern this record has already repaired, not carried across

[run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) line 85 skips the cross-weight pairs of $H$ with a `continue`, and lines 96–105 exist because reviewer 191 pointed out that this discards exactly the pairs that could falsify the claim; the repair recomputes them and reports `cross` must be $0$. [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) lines 160–168 have the identical shape (the Q loop iterates weight by weight, so a cross-weight entry is never formed) and the repair was **not** carried across. There is no `cross` here and no way for the block-diagonality claim to fail.

[checks195.py](../scripts/reviewers/r195/checks195.py) computes the discarded entries on four blocks:

| block | $\dim$ | weights | cross-weight Q entries computed | nonzero |
| --- | --- | --- | --- | --- |
| $(2,0)$ | $14$ | $13$ | $156$ | $0$ |
| $(2,2)$ | $35$ | $25$ | $600$ | $0$ |
| $(3,2)$ | $105$ | $45$ | $1980$ | $0$ |
| $(4,2)$ | $220$ | $69$ | $4692$ | $0$ |

$7428$ entries, all zero. The claim is true; the code just cannot say so.

### A smaller unchecked assumption underneath it

Both weight indices (`BYW` at line 66 and `byw` at line 164), read a vector's weight off `mwt(max(v))`, the weight of its largest monomial **index**. That is the weight of the vector only if the vector is homogeneous, which is true (each is $X_w u_i$ with $X_w$ a product of root vectors) and is checked nowhere. Measured: across the four blocks, $0$ vectors carry more than one weight and $0$ are zero.

## Claim 1b, $14$ is attained, is not a bound, and collides with two other $14$s

[freudenthal_b2.py](../scripts/reviewers/r195/freudenthal_b2.py) computes the weight multiplicities of all $24$ blocks by Freudenthal's recursion in exact arithmetic. Every block's multiplicities sum to the Weyl dimension, which is the control on the recursion; the top of the table:

| $\lambda$ | $\dim$ | widest weight space | at |
| --- | --- | --- | --- |
| $(6,4)$ | $810$ | $14$ | $(0,0)$ |
| $(6,3)$ | $770$ | $14$ | $(1,0)$ |
| $(6,2)$ | $625$ | $13$ | $(0,0)$ |
| $(5,3)$ | $455$ | $11$ | $(0,0)$ |
| $(5,2)$ | $390$ | $10$ | $(1,0)$ |
| $(6,6)$ | $455$ | $7$ | $(0,0)$ |

So $14$ is exactly right, and it is **attained twice**, which is worth saying because the file writes it as an inequality. The independent confirmation is stronger than the recursion alone: summing $m_\lambda\cdot m_\lambda(\mu)$ over the $24$ blocks reproduces the Sym$^3$ monomial count at **every one of the $169$ weights** ([claim2_characters.py](../scripts/reviewers/r195/claim2_characters.py)), so the whole multiplicity table is pinned against data that has nothing to do with Freudenthal.

**It is not a bound.** Nothing about $B_2$, about weight spaces, or about Sym$^3$ produces $14$. It is the maximum over the $24$ $\lambda$ that happen to occur, and it holds only because $\mathrm{Sym}^3(V(2,2))$ contains no highest weight beyond $(6,6)$: the next block in the same family, $V(7,4)$, has widest weight space $18$. Written as "at most $14$" the comment reads as structure; it is arithmetic, and it will not transfer to $n=6$.

**And $14$ is overloaded three ways in this file.** $\dim(\mathrm{Sym}^6\mathcal{W}_5)^{O(5)}=14$ is the rank bound of the docstring's third check (reviewer 194); $\dim V(2,0)=14$ is a block dimension; and $14$ is this maximum weight multiplicity. Lines 22 and 133 use two different ones eleven lines apart with no distinguishing word. Given that reviewer 192's finding in this record was a conflation of exactly this kind, the numbers should be named where they appear.

### Claim 1c, the cost line is a conflation

Line 134 estimates the widest weight's Q cost as `sum(s*s*6 for s in sup[-14:])`, where `sup` is the sorted support sizes of **all $7770$** adapted vectors. Those fourteen are the fourteen largest supports anywhere in the basis; the widest Q block is fourteen vectors of a single weight in a single copy, and there is no reason for those to be the same fourteen. The estimate is an upper bound presented as an estimate.

The quantity the file actually wants is computable before the run and needs no vectors at all: $\sum_{\lambda}\sum_{\mu} m_\lambda(\mu)^2 = 32\,530$ stored Q entries, against $\sum_\lambda(\dim V(\lambda))^2 = 2\,669\,238$ for dense Grams, a factor of $82$. Lines 172–174 will print those two numbers; they can be asserted instead.

## Claim 2, squareness is the character identity, and it is the one check here that has a control

The shipped check compares, per Sym$^3$ weight $w$, the monomial count against the adapted-vector count. The second number is $\sum_\lambda m_\lambda\cdot m_\lambda(w)$ block by block, so squareness **is** the character identity $\mathrm{ch}\,\mathrm{Sym}^3(V(2,2))=\sum_\lambda m_\lambda\,\mathrm{ch}\,V(\lambda)$, the isotypic decomposition this record fixed several cycles ago. [claim2_characters.py](../scripts/reviewers/r195/claim2_characters.py) verifies it with no adapted vector in play: $0$ of $169$ weights differ, totals $7770$ and $41$ copies.

**Verify:** yes, it holds identically.

**What a mismatch would diagnose, precisely.** Given the character identity, a mismatch can only mean the vectors were lost, not that the weights are wrong, and there is a real route to that: line 65's `if not v: continue` silently drops a vector that came out zero, and line 164 drops it again. A replay that degenerated on some copy therefore surfaces here as a count deficit at the affected weights and nowhere else. That is the failure mode with content, and it is not the one the comment names.

**Negative controls, which this check does have.** Perturbing the block table and re-running the identity:

| perturbation | weights failing squareness | total |
| --- | --- | --- |
| drop one copy of $(4,2)$ | $69$ | $7550$ |
| relabel $(6,3)$ as $(6,4)$ | $68$ | $7810$ |
| drop the trivial block | $1$ | $7769$ |

It fires, loudly, and even the smallest perturbation is visible. So squareness is **not** a twelfth entry in [plan.md](../plan.md)'s table. What it is, is redundant: line 68 already prints `tot == 7770`, and equal totals plus agreement on every common weight forces agreement everywhere.

**What it does not establish is what its comment claims.** "The adapted vectors of a given Sym$^3$ weight ARE a basis of that weight space" is a statement about independence; counting is necessary and not sufficient. The statement is true, for a reason stated nowhere in the file: each copy's replay has full rank (checked in [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py)), the $m$ copies of a block meet only in $0$ (reviewer 192's direct-sum argument), distinct isotypic components are independent, and weight vectors of distinct weights are independent. Four ingredients, none of them the count. Measured directly on the four blocks: the per-weight widths equal the Freudenthal multiplicities exactly, which is the count refined to the block level.

## Claim 3, one probe is enough for the mathematics and not enough for the measurement

### The normalisation is correct

Line 106 computes $g\cdot\overline{q_{00}}/|q_{00}|^2$, which is $g/q_{00}$; $q_{00}=\langle u_0,u_0\rangle$ is real, so the division cannot disturb Hermiticity. The result is $h_{ij}/h_{00}$, i.e. $\langle u_i,u_j\rangle/\langle u_0,u_0\rangle$, the same normalisation reviewer 192 derived independently. Nothing wrong here.

### Analytically, any probe gives the same $h$

Write the isotypic block as $V(\lambda)\otimes M$. The ambient Hermitian form is $G$-invariant, $V(\lambda)$ is irreducible, and Schur makes the space of invariant sesquilinear pairings one-dimensional, so the form restricted to the block is $\langle\cdot,\cdot\rangle_{V}\otimes h$ with $h$ Hermitian on $M$. Hence $\langle R_i[t],R_j[s]\rangle=h_{ij}Q_{ts}$ for **every** $(t,s)$, and any $(t,s)$ with $Q_{ts}\neq0$ returns the same $h$. **One probe is enough, provided the identification $R_i[t]\leftrightarrow R_j[t]$ is the $\mathfrak{g}$-map.** That proviso is the entire content of [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py).

Verified across probes, on top of reviewer 192's $784$ and $3136$:

| block | copies | probe entries $(t,s)$, $t,s<14$, same weight, $Q_{ts}\neq0$ | disagreements with the $(0,0)$ probe |
| --- | --- | --- | --- |
| $(2,0)$ | $2$ | $64$ | $0$ |
| $(2,2)$ | $4$ | $320$ | $0$ |
| $(3,2)$ | $3$ | $216$ | $0$ |
| $(4,2)$ | $4$ | $384$ | $0$ |

The factorisation holds. $h$ is complex, non-diagonal and positive definite on $(2,2)$, leading principal minors $1,\ \tfrac{2208}{1369},\ \tfrac{36720}{50653},\ \tfrac{891000}{1874161}$, which confirms the reading in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py)'s docstring. Positive definiteness is a property $h$ must have (Gram of independent vectors under a positive definite form) and is checked nowhere in the pipeline; it is the cheapest real check available on $h$.

### But $(0,0)$ is the one probe that cannot see the thing being measured

`word_list` starts its BFS from `([], u)`, so `words[0]` is the empty word and $R_i[0]=u_i$ for **any** word list whatsoever. The shipped probe never applies a single lowering operator: it measures $\langle u_i,u_j\rangle$, which is the labelling that defines the copies in the first place. Everything the shared word list buys lives at $t>0$, and the measurement never looks there.

The consequence is not academic. [negcontrol_schur.py](../scripts/reviewers/r195/negcontrol_schur.py) builds a **non-equivariant identification that every piece of bookkeeping in the file accepts**: permute copy 2's word positions by a transposition of two positions of the *same weight*, leaving position $0$ fixed. Weights, widths, the weight index, squareness and the total $7770$ are all untouched by construction.

| block | shipped $(0,0)$ probe: $h$ identical to the correct one | "$h$ Hermitian" | "$h$ is not the identity" | multi-probe Schur |
| --- | --- | --- | --- | --- |
| $(2,0)$, positions $6\leftrightarrow7$ at weight $(0,0)$ | **yes** | passes | passes | **fires: $6$ of $64$** |
| $(3,0)$, positions $8\leftrightarrow9$ at weight $(1,0)$ | **yes** | passes | passes | **fires: $10$ of $112$** |

Positive control in the same script: rescaling copy 2 by $3+2i$ **is** an equivariant change; $h$ moves and Schur still holds at $0$ of $64$ and $0$ of $112$. So the multi-probe test discriminates rather than merely rejecting perturbations.

### A correction to how reviewer 192's control is described

Reviewer 192's negative control is described in this record as "a per-copy word list". Reproducing it requires more than that: [claim4_gmap.py](../scripts/reviewers/r192/claim4_gmap.py) line 203 calls `word_list(us[1], want, order=(1,0))`, a per-copy list **with the two lowering operators applied in the reverse order**. Building a per-copy list the way [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) builds copy 1's returns copy 1's list *verbatim*: measured at $0$ of $2$, $0$ of $4$ and $0$ of $3$ copies differing on $(2,0)$, $(2,2)$ and $(3,2)$, with the resulting $h$ and Schur test both identical to the correct ones. The BFS is deterministic in the frontier order, so "per copy" alone is not a corruption on this construction, the operator order is what makes it one. Reviewer 192's measurement stands; the one-phrase summary of it does not, and anyone reaching for that control as written will find it inert.

## Claim 4, the twelfth and thirteenth entries

Both checks the shipped $h$ measurement runs pass on random garbage. [checks195.py](../scripts/reviewers/r195/checks195.py) feeds $m$ random sparse vectors of mixed weight, drawn from nothing, through lines 96–114 verbatim: on all four blocks, "$h$ Hermitian" is `True` and "$h$ is not the identity" is `True`.

**"$h$ Hermitian" cannot fail, and the proof is three lines.** $H$ is a Gram of a sesquilinear form, so $H_{ab}=\overline{H_{ba}}$; reindexing the bijection sum by $\sigma\mapsto\sigma^{-1}$ gives $\texttt{sym3\_ip}(t,s)=\overline{\texttt{sym3\_ip}(s,t)}$; and `ip3` conjugates its second argument, so $\texttt{ip3}(u,v)=\overline{\texttt{ip3}(v,u)}$ for **any** $u,v$. Then $q_{00}=\texttt{ip3}(u_0,u_0)$ is real and $\texttt{row}[i][j]=\overline{\texttt{row}[j][i]}$ identically. It is a fact about line 90, not about the adapted basis, and no error in the vectors, the word list, the weights or the copies can make it fire. This is the twelfth entry.

**"$h$ is not the identity" is the thirteenth, and its polarity is backwards.** It passes on garbage for the trivial reason that random vectors are not orthonormal. Worse, a failure would be *good* news: $h=I$ would mean the highest-weight vectors are orthonormal and no multiplicity-Gram factor could ever enter the $B_{ij}\to h_{ij}B_{ij}$ dispute. A check whose failure state is a better world is not a correctness check; it is an observation, and it should be printed as one.

**Squareness is not an entry**, see claim 2; it has three working controls.

**"Bounded by $14$" is not a check at all.** Line 172 prints `max(allw)` followed by the parenthetical `(bounded by 14)`. There is no comparison, no assertion and no exit. Nothing happens if a block comes out $15$ wide.

## Claim 5, the four declared checks still do not exist

[plan.md](../plan.md) records "stage 3's three declared checks (none of them exists in the code), [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) is $64$ lines". The file is now $174$ lines and the docstring declares **four** checks: $B$ Hermitian at every sample point; the trivial block giving $B_{11}\propto\operatorname{tr}(W^3)^2$; the coefficient matrix having rank exactly $14$; and consistency, $\mathrm{rank}(A)=\mathrm{rank}[A\mid F_5]$. Grepping the file for `B_`, `rank`, `sample`, `F_5` and `F5` returns hits in the docstring and comments only. There is no $W$ in the file, no sample point, no $B$, no coefficient matrix. It builds the adapted basis, measures $h$, checks squareness, builds Q and stops.

The docstring's own line 30 ("NONE OF THESE WAS IN THE CODE when 193 and 194 read this file"), is written in the past tense about a situation that has not changed. The table entry in [plan.md](../plan.md) needs no revision beyond the line count.

## What to change

1. **Name the form in the comment at lines 120–123.** "Word-basis vectors of different weight are orthogonal *under the Hermitian form*", the bilinear form on the same basis is supported exactly on $(\mu,-\mu)$ and would make Q block-anti-diagonal.
2. **Carry [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py)'s repair across.** Compute a sample of the cross-weight Q entries the loop discards and report the count, the way `cross` does for $H$. $7428$ of them are verified zero here; a few hundred per block costs seconds.
3. **Replace "at most $14$" with the attained maximum and its provenance**, and say which $14$ it is. Assert `max(allw) == 14` rather than printing a parenthetical, and assert the entry count against $32\,530$ and $2\,669\,238$, both of which are known before the run.
4. **Measure $h$ at more than one probe, or state that the single probe is a definition.** The check with content is $\langle R_i[t],R_j[s]\rangle=h_{ij}Q_{ts}$ for $t,s>0$; it is the only test inside stage 3 that can see the shared word list at all, and it costs $\mathcal{O}(m^2)$ inner products per probe.
5. **Replace the two vacuous $h$ checks with the one that can fail:** $h\succ0$, by leading principal minors, exactly. It is one line, it is a genuine property, and it would catch a sign error in $H$.
6. **Assert rather than print.** Every check in the file is a formatted boolean; a run with `square = False` and a $15$-wide block finishes with exit status $0$.
7. **Fix the cost estimate at line 134** or delete it; `sup[-14:]` is not the widest weight block.

## Scripts

Under [scripts/reviewers/r195/](../scripts/reviewers/r195/):

- [common195.py](../scripts/reviewers/r195/common195.py), $H$, the Sym$^3$ Fischer form, the lowering operators, `word_list` and `replay`, rebuilt from the cached tensors so no module under review is imported
- [freudenthal_b2.py](../scripts/reviewers/r195/freudenthal_b2.py), weight multiplicities of all $24$ blocks, controlled by $\sum_\mu m(\mu)=\dim$
- [claim2_characters.py](../scripts/reviewers/r195/claim2_characters.py), squareness as a character identity, with three perturbations of the block table as negative controls
- [bilinear_gram.py](../scripts/reviewers/r195/bilinear_gram.py), the invariant bilinear Gram, supported exactly on $(\mu,-\mu)$
- [checks195.py](../scripts/reviewers/r195/checks195.py), pure-weight test, cross-weight Q entries, widths against Freudenthal, multi-probe Schur, and the random-garbage control
- [negcontrol_schur.py](../scripts/reviewers/r195/negcontrol_schur.py), the same-weight transposition that passes both shipped checks and fires the multi-probe test, with the rescaling positive control

*Superseded within this review: the `C1b` "bilinear" line in [checks195.py](../scripts/reviewers/r195/checks195.py) drops the conjugate from the Sym$^3$ coefficients while keeping $H$, which is what carries the weight filter, so it returns $0$ and shows nothing. [bilinear_gram.py](../scripts/reviewers/r195/bilinear_gram.py) is the correct contrast. The script is annotated to say so.*
