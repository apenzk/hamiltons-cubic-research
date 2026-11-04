# Review r682, Lemma L87, the rank-one step

**Reviewer B of an independent pair on identical briefs; the other reviewer takes r681. Analysis only, no computation was run beyond one arithmetic screen of numbers I derive by hand below.**

## Verdict

**GAP.** Every number in [L87](../findings/sym3-blocks.md) is right and I re-derived all of them cold: the cap $3570$, the sixteen even blocks, the $25$ surviving multiplicities, the $36$ unknowns. The conclusion *"every even block loses exactly one multiplicity"* is true and follows. **What fails is the block's account of why.**

- **"PROVED RATHER THAN MEASURED" is false.** The upper bound is a theorem; the lower bound is one machine run (the rank of a $3700\times3700$ matrix over $\mathbb F_{46337}$) and nothing about it is checkable by a reader. This is the **same shape** the same file grades differently four blocks down: [L62](../findings/sym3-blocks.md)'s audit ([r633](REVIEW_r633.md), [r634](REVIEW_r634.md)) split *"a `Lemma` for the cap and an `Observation` for the value"* on an attained mod-$p$ rank, and L87 is that configuration promoted instead of split.
- **The stated justification does not apply to the run that was made.** *"A mod-$p$ rank is a lower bound for the characteristic-zero span"* is a statement about reducing a fixed integral matrix. [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) does not reduce one: its $3700$ orbit points are elements of $SO(5,\mathbb F_{46337})$, built by Cayley transform of random skew matrices **over $\mathbb F_p$**, which are not reductions of real rotations. The conclusion survives under a different two-line argument, given below; the one-liner in the block does not reach it.
- **The cap is stated on a hypothesis too weak to give it.** The block says the cap is $\sum d_\lambda$ over the even blocks *"using $\dim V_\lambda^H\le1$"*. That inequality alone gives the cap $5640$, over all $24$ blocks, and **the squeeze fails at $5640$**. The number $3570$ needs the other half of [L86](../findings/sym3-blocks.md) ($\dim V_\lambda^H=0$ at odd $\lambda_2$) which the block neither states nor cites.
- **One attribution is false.** *"174's 'measured' $3570$"*: [r174](REVIEW_r174.md) **derived** the cap and matched it against a measurement someone else had made. The measurement is [r170](REVIEW_r170.md)'s, confirmed by [r173](REVIEW_r173.md).
- **The block carries no links at all**, not to [REVIEW_r178.md](REVIEW_r178.md), not to [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), not to [L86](../findings/sym3-blocks.md) or [L83](../findings/sym3-blocks.md). For a block whose whole lower bound is one machine run, an unlinked script is the worst available hygiene defect: the claim cannot be checked from the record at all.

**On the brief's headline question: yes, the chain [L87](../findings/sym3-blocks.md) → [L59](../findings/sym3-blocks.md) → [L62](../findings/sym3-blocks.md) carries two measured links, and the companion audit is right that no block says so.** L59 and L62 may rest on L87 (the dependency is real, correct and acyclic) but they rest on a measurement, and L87's headline is the sentence that hides it.

## Readings adopted, before anything else

I read [conventions.md](../findings/conventions.md) in full. The conventions that bear here, and the reading I take:

| item | reading adopted | why it does not bite |
| --- | --- | --- |
| the $\Lambda^2$ pairing | $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, the half-trace, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | **inert here.** The whole argument is about the *rank* of a Gram matrix. Rescaling the pairing by $c\ne0$ rescales every entry of $\langle g_aW_0,g_bW_0\rangle^3$ by $c^3$, a global unit, and rank is unchanged. $p$ is odd and does not divide the small constants in play |
| $W_0$'s normalisation | $W_0$ is the padded $W_{\mathbb{CP}^2}$, $\Lambda^2$-spectrum $(2,-1,-1,0^7)/\sqrt6$ | **inert.** [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) works at spectrum $(4,-2,-2,0^7)$ unnormalised; scaling $W_0$ scales the span's spanning set and moves no dimension |
| $\Pi$ | none of the four senses is in play in this block |, |
| $B$ | neither the Killing form nor the second-order operator is in play; this file's own $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(5)$ appears only in the header material above L83 |, |
| the $O(5)$ versus $SO(5)$ question | $-\mathrm{Id}$ acts trivially on $\mathcal W_5$, so $O(5)\cdot W_0=SO(5)\cdot W_0$ and the two spans coincide | stated in [L86](../findings/sym3-blocks.md) and in [r170](REVIEW_r170.md); I checked it independently, $\mathcal W_5\subset V^{\otimes4}$, so $-\mathrm{Id}$ acts by $(-1)^4$ |
| the weight-label basis | the $e$-basis, as in [L83](../findings/sym3-blocks.md)'s table; *"$\lambda_2$ even"* means the second $e$-basis label | in the $\omega$-basis the parity statement is a different statement; [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) already flagged that the basis is unstated in L83, and L87 inherits the silence |

## What the block actually claims, restated so the halves separate

Write $U=\mathop{\mathrm{span}}\{(gW_0)^{\otimes3}:g\in O(5)\}\subseteq\mathrm{Sym}^3(\mathcal W_5)$, and $K=U^\perp$ the cubics vanishing on the orbit. Decompose $\mathrm{Sym}^3(\mathcal W_5)=\bigoplus_\lambda M_\lambda\otimes V_\lambda$, $\dim M_\lambda=m_\lambda$. Then $U$'s $\lambda$-part is $N_\lambda\otimes V_\lambda$ for some $N_\lambda\subseteq M_\lambda$, and the claim *"block $\lambda$ loses exactly one multiplicity"* is $\dim N_\lambda=1$.

The block asserts three things and they have three different statuses.

| claim | status |
| --- | --- |
| $\dim N_\lambda\le1$ for every $\lambda$, and $=0$ when $\lambda_2$ is odd | **theorem**, from [L86](../findings/sym3-blocks.md); I rebuild it below |
| $\dim U=3570$ | **one exact machine computation** |
| $\dim N_\lambda=1$ on all sixteen even blocks | **theorem given the computation** |

## Deriving the proved half cold

$H=\mathrm{Stab}_{O(5)}(W_0)$ fixes $W_0$, hence fixes $W_0^{\otimes3}$. So the $\lambda$-component of $W_0^{\otimes3}$ lies in $M_\lambda\otimes V_\lambda^H$. By [L86](../findings/sym3-blocks.md), $\dim V_\lambda^H\le1$, so that component is $u_\lambda\otimes v_\lambda$, a **rank-one** element of $M_\lambda\otimes V_\lambda$, or zero. $U$ is the module generated by $W_0^{\otimes3}$, so its $\lambda$-part is $\mathbb R u_\lambda\otimes V_\lambda$ and $\dim N_\lambda\in\{0,1\}$. Equivalently, and this is the cleaner statement: $U$ is a quotient of $\mathbb R[G/H]$, whose $\lambda$-multiplicity is $\dim V_\lambda^H$ by Frobenius reciprocity.

Hence

$$\dim U=\sum_\lambda \dim N_\lambda\cdot d_\lambda\ \le\ \sum_{\lambda_2\ \mathrm{even}} d_\lambda .$$

**This is where the block's stated hypothesis runs out.** To restrict the sum to the even blocks one needs $V_\lambda^H=0$ at odd $\lambda_2$, the *other* half of L86, the one whose mechanism is the $\mathfrak{su}(2)_R$ Weyl element acting on the $m=0$ vector of spin $j$ by $(-1)^j$. Without it the cap is the sum over all $24$ blocks. I computed both sums by hand off [L83](../findings/sym3-blocks.md)'s table:

- **even blocks, sixteen of them**, $220+35+105+390+165+55+30+14+455+810+625+140+429+91+5+1=3570$.
- **odd blocks, eight of them**, $231+154+81+35+770+455+260+84=2070$.
- **all twenty-four**, $5640$.

So under the block's own stated ground the cap is $5640$, a measured rank of $3570$ sits strictly inside it, and **nothing is forced**: some even block could have $\dim N_\lambda=0$ with an odd block picking up the slack. *The squeeze survives only on the full parity rule.* That is a genuine hole in the block as written, and it is the fifth uncited consumption of L86 this file has been found to carry.

Multiplicity arithmetic, also derived cold and confirming L86's downstream numbers:

- **$29$ of the $41$ multiplicities sit in even blocks**, $4+4+3+(2\times5)+(1\times8)=29$, leaving $12$ in odd blocks as $(2\times4)+(1\times4)$.
- **$41-16=25$ survive**, one lost per even block.
- **the unknowns are $36$**, $\sum_\lambda\binom{m_\lambda'+1}{2}$ over surviving multiplicities $m'$: two blocks at $m'=3$ give $6+6$, one at $m'=2$ gives $3$, five at $m'=1$ give $5$, eight at $m'=0$ give $0$, and the odd blocks contribute $(3\times4)+(1\times4)=16$. Total $12+3+5+16=36$, shaped as **two $3\times3$, five $2\times2$ and nine scalars**, and $36=20+16$ as [L59](../findings/sym3-blocks.md) has it.
- **$65-36=29$**, matching L59's split of the invariant symmetric forms.

*(Screen, reported as a screen: I ran these four sums and the primality of $46337$ in one python line, seconds, on numbers I had already derived by hand, and every one agreed. No positive claim below rests on it.)*

## The sampled half, and where the block's justification breaks

### The Gram identity is fine

$\langle X^{\otimes3},Y^{\otimes3}\rangle=\langle X,Y\rangle^3$, so the $3700\times3700$ matrix $\big(\langle g_aW_0,g_bW_0\rangle^3\big)$ is the Gram matrix of the vectors $(g_aW_0)^{\otimes3}$ and no $7770$-dimensional object need be built. The script forms it as $M M^{\mathsf T}$ on the $100$ raw entries of each $g_aW_0$ and cubes entrywise, which is the plain Frobenius pairing rather than the record's half-trace, a global unit, inert on rank as noted above.

### The inequalities all point the right way

The brief asks specifically. They do, and I checked each junction for a reversal:

$$3570=\mathop{\mathrm{rank}}_{\mathbb F_p}(\text{Gram})\ \overset{(1)}{\le}\ \dim_{\mathbb F_p}\mathop{\mathrm{span}}\{(g_aW_0)^{\otimes3}\}\ \overset{(2)}{\le}\ \dim\mathop{\mathrm{span}}\Phi(SO_5)_{\overline{\mathbb F_p}}\ \overset{(3)}{\le}\ \dim_{\mathbb C}U\ \overset{(4)}{\le}\ 3570 .$$

- **(1)** In characteristic $p$ the form can be degenerate on the row space, so $\mathop{\mathrm{rank}}(VV^{\mathsf T})\le\mathop{\mathrm{rank}}(V)$ and the Gram trick can only **under**-report. That is the safe direction here, since we want a lower bound on the span. *This is the one place a squeeze of this shape usually goes wrong and it does not go wrong.*
- **(2)** A finite sample spans no more than the whole image.
- **(3)** is the step the block gets wrong. See below.
- **(4)** is the cap, and it is the theorem, **on the full parity rule, not on the $\le1$ the block names.**

The chain closes, so every $\dim N_\lambda$ is $1$ on the sixteen. *Exactly one* is genuinely two-sided: **at most one** from Frobenius reciprocity, **at least one** from attainment. Both directions are present, which is more than the pre-L87 state of the record had.

### Step (3) is not the step the block states

The block's warrant is *"a mod-$p$ rank is a lower bound for the characteristic-zero span"*. That is true of $\mathop{\mathrm{rank}}_{\mathbb F_p}(\bar A)\le\mathop{\mathrm{rank}}_{\mathbb Q}(A)$ **for a fixed integral $A$**. The matrix here is not one. Reading [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage): $p$ is fixed first, then

```
A random skew over F_p ;  B = I + A ;  g = (I - A) B^{-1}  ;  check g g^T = I
```

so the $3700$ group elements live in the finite group $SO(5,\mathbb F_p)$ and are **not** reductions of characteristic-zero rotations. There is no integral matrix of which the sampled rows are the reduction, so the quoted one-liner has nothing to reduce. The script's own header makes the same too-quick claim.

**The conclusion is nonetheless correct, by a different argument, and it is short enough that the block should carry it.** $W_0$ is integral and $SO_5$ is smooth over $\mathbb Z[\tfrac12]$. Let $\Lambda:\mathrm{Sym}^3(\mathcal W_5)^*\to\mathbb Z[\tfrac12][SO_5]$ send $f$ to the regular function $g\mapsto f(gW_0)$; fix $\mathbb Z[\tfrac12]$-bases and let $L$ be its matrix. Over any field $k$ of characteristic $\ne2$, $SO_{5,k}$ is reduced, so $f$ kills the whole image iff $L_kf=0$; hence $\dim_k\mathop{\mathrm{span}}\Phi(SO_{5,k})=\mathop{\mathrm{rank}}(L_k)$. Rank drops on reduction, so $\mathop{\mathrm{rank}}(L_{\mathbb F_p})\le\mathop{\mathrm{rank}}(L_{\mathbb Q})=\dim U$, and (2)–(3) compose. **Two lines, and they are the load-bearing two.**

### Is the sample's exactness guaranteed?

**Yes, and this is the block's real contribution, which it does not claim.** Everything in [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) is over $\mathbb F_{46337}$: the group elements, $W_0$, the Gram, the rank. There is no floating point anywhere and no tolerance is chosen. That is strictly better than the two prior determinations of the same number, both of which read a **numerical** rank off an eigenvalue gap:

| run | points | arithmetic | what it buys |
| --- | --- | --- | --- |
| [r170](REVIEW_r170.md) | $5200$ | float, rank stable at tolerances $10^{-8}$ to $10^{-12}$ | the first sighting of $3570$; a numerical rank, so evidence |
| [r173](REVIEW_r173.md) | $4800$ Haar | float, tolerances $10^{-6}$ to $10^{-12}$ | confirmation, same method |
| [r178](REVIEW_r178.md), the block's | $3700$ | **exact over $\mathbb F_{46337}$** | a rank that is a theorem about a finite matrix, hence a genuine lower bound |
| [r203](REVIEW_r203.md), [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) | $3700$ | float, eigenvalue gap at index $3570$ | a fourth agreement, **declared a screen in the script's own docstring** |

$46337$ is prime, and $\gcd(3,p-1)=1$, so entrywise cubing is a bijection on $\mathbb F_p$ and cannot collapse a nonzero Gram entry, a small robustness point in the run's favour that nobody has recorded. **One prime, one seed, one run.** [L90](../findings/sym3-blocks.md)'s attainment claim is carried by *four* primes and an independent reproduction at a second prime chosen $3\bmod4$ on purpose; L87's is carried by one. The asymmetry is unremarked.

### Is the squeeze circular?

**No, and this is the one place the block is cleanly in the right.** The cap comes from [L86](../findings/sym3-blocks.md)'s branching rule, derived by hand and independently by [r174](REVIEW_r174.md), [r177](REVIEW_r177.md) and [r178](REVIEW_r178.md), together with [L83](../findings/sym3-blocks.md)'s dimension table, itself four-times reproduced and now derived by plethysm. The rank comes from explicit matrices over a finite field. **The two sources share nothing**, which is exactly what [r663](REVIEW_r663.md) says of it from the other side.

**But the run knew its target.** [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) hardcodes `theoretical cap = 3570` in its header and prints the rank beside it; nothing compares the rank against an independently computed quantity. That is not circularity, but it is the configuration this file records at [L90](../findings/sym3-blocks.md) as a trap in its own right, ***"Attainment is not self-validating. A defect landing the rank exactly on the cap is invisible."*** L62's audit flagged that L62 sits in that configuration. **L87 sits in it too and says nothing.** *That the three prior and subsequent floating-point runs agree is what actually guards it, and the block cites none of them.*

## Provenance

*"Reviewer 178, independently and while 177's objection was being folded in."* Checked against `git` and against the reviews.

| time | commit | what |
| --- | --- | --- |
| 12:40:11 | `07c2a9dd` | [r177](REVIEW_r177.md)'s review lands, carrying the objection: *"'Each such block loses one multiplicity' requires the evaluation map $\mathbb C^{m_\lambda}\to V_\lambda^H$ to be nonzero … So $36$ is a lower bound"* |
| 12:42:39 | `9999706c` | the objection is folded into [L86](../findings/sym3-blocks.md)'s block |
| **12:44:20** | **`a1028174`** | **L87 is written**, *"the rank-one step is proved, so 36 unknowns is exact"* |
| 12:45:25 | `6da8eb27` | [r178](REVIEW_r178.md)'s review and [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) land together |

**"while 177's objection was being folded in" is a shade off but not false.** The block was written **after** the fold-in commit, not during it; 177 and 178 were a concurrent pair, so 178's work was genuinely underway across that window. I would not file this.

**"Independently" is the word that fails, in two ways.** [r178](REVIEW_r178.md)'s own review says *"[plan.md](../plan.md) supplies this by citing 174's measured span of 3570"*, the target was in hand before the run. And the *method* is not independent at all: the Veronese Gram-cube identity is exactly what [r170](REVIEW_r170.md) and [r173](REVIEW_r173.md) had already used. What **is** independent is the construction of $W_0$, the sampling, and the arithmetic. r178's own sentence is careful (*"an independent construction of $W_0$"*) and the block dropped the qualifier, the same way [L83](../findings/sym3-blocks.md)'s headline dropped its script's *"checked here rather than established here"*.

**And "174's *measured* 3570" is a false attribution.** [r174](REVIEW_r174.md) never measured anything of the kind. Its §2.3 is headed *"The bound is attained, and it reproduces $3570$ exactly"* and reads *"gives precisely the record's measured span. **An upper bound that equals a measured value forces equality throughout**"*, r174 **derived** the cap, the same cap L87 uses, and matched it against a number already on the record. That number is [r170](REVIEW_r170.md)'s, confirmed by [r173](REVIEW_r173.md). **[L86](../findings/sym3-blocks.md) carries the same error one paragraph up** (*"which reviewer 174 measured at 3570"*) so L87 inherited it rather than invented it, and repairing one without the other leaves half of it standing.

*Net: one clean item, one shade off, one false.*

## Duplication, four kinds

- **Same content, unnumbered, under the preceding lemma's heading.** [L86](../findings/sym3-blocks.md)'s block already states **L87's entire argument**: *"$\sum_\lambda(\mathrm{rank}_\lambda\cdot d_\lambda)$ is the dimension of the $O(5)$-submodule generated by $W_0^3$ … the derived upper bound is the same $3570$. An upper bound attained forces every one of the sixteen ranks to be exactly $1$, so no block has rank $0$ and $36$ is exact."* This is the brief's *"one block's proof under a different lemma's heading"* pattern, and here the two are **four lines apart**.
- **And the two copies contradict each other.** L86 says, in bold: ***"THE RANK-ONE STEP IS AN INEQUALITY, AND WHAT PROMOTES IT TO AN IDENTITY IS A MEASUREMENT"***, and *"Everything downstream … rests on that single measured number."* L87 says ***"PROVED RATHER THAN MEASURED"***. `git` shows the two were written **101 seconds apart** and both have stood for a week. A reader meets the objection and its purported answer in that order and is given no way to tell which sentence the record means. *This is the identical defect [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) filed against L62 ("the file contradicts this block, fifty-four lines above"), recurring in the same file with a four-line separation instead of fifty-four.*
- **The check L86 names is not the check L87 ran.** L86 closes with *"the check that would remove the dependency … evaluating the $41$ [highest-weight vectors] at a handful of points"*. L87 ran a Gram rank instead. **It therefore replaced one measurement with a better measurement, and did not remove the dependency.** The named check is still open and is still the thing that would make the headline true.
- **In [report/](../report/), unnumbered and unattributed.** [07-gradedness-split.tex:908](../report/sections/07-gradedness-split.tex#L908) states *"$A(W_0^6)$'s catalecticant is the orbit average of the rank-one forms … **of rank $3570$**"*, the same fact, with no indication that it is measured. [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) cites *"a mod-$p$ Gram rank of $3570$ meeting the theoretical cap"* at three sites, which is the honest form and is more precise than the canonical block.

## Pointers

**The block carries zero links**, the only block in its neighbourhood that does. It names *"Reviewer 178"* without linking [REVIEW_r178.md](REVIEW_r178.md); it names $\mathbb F_{46337}$ and $3700$ orbit points without linking [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage); it uses [L86](../findings/sym3-blocks.md)'s parity rule and [L83](../findings/sym3-blocks.md)'s dimensions without linking either. *Nothing resolves falsely because there is nothing to resolve*, the same finding [r673](REVIEW_r673.md) filed against L84, but here it is worse in kind, because the lower bound **is** the script and a reader cannot reach it.

[INDEX-results.md](../findings/INDEX-results.md) line 102 records **"Gate 2: no verdict on the record"** for result 87, which is accurate: this is its first audit.

## Does the file settle it above or below?

Partly, and against the block. Above: L86 states the objection and the answer, and names the check that would close it. Below: [L90](../findings/sym3-blocks.md) states the trap this block is standing in (*attainment on a cap is self-invisible*), and [L62](../findings/sym3-blocks.md)'s Gate-2 note states the remedy the record has already adopted once for this exact shape. **All three are in this file and none is connected to L87.**

## L59, L62, and the two measured links

**They may rest on L87 as they do. The dependency is real, correct and acyclic, and it is a dependency on a measurement.**

- **[L59](../findings/sym3-blocks.md)** needs *"an even one keeps $u\otimes v+v\otimes u$, $K$ having codimension $1$ there"*. Codimension **exactly** one is L87's conclusion; the proved half gives only codimension $\le1$, under which $36$ becomes a lower bound on the unknowns and $29$ an upper bound on the forms killing $K\times K$, and the clean split $65=36+29$ becomes an inequality in both directions. **So L59's strongest and best-verified sentence rests entirely on L87's measured half.**
- **[L62](../findings/sym3-blocks.md)** needs L59's apolarity to turn $\mathop{\mathrm{rank}}=13$ into $\dim\mathrm{ANN}=1$, and needs the $36$ for *"the affine family is $36-13=23$ dimensional"*. Its own $\mathop{\mathrm{rank}}\ge13$ is a **second** mod-$p$ attained-cap measurement, at $40$ points and two primes.

**So the chain carries exactly two measured links, and they are the same failure mode twice:**

| link | what is proved | what is measured | recorded as measured? |
| --- | --- | --- | --- |
| **L87** | cap $\dim U\le3570$ | $\mathop{\mathrm{rank}}_{\mathbb F_{46337}}=3570$, $3700$ points, one prime, one seed | **no**, the block says "proved" |
| **L62** | cap $\mathop{\mathrm{rank}}\le13$ | $\mathop{\mathrm{rank}}=13$ at $40$ points, $p=1000033$ and $p=1000003$ | **yes**, since [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) |

The companion audit's finding is confirmed in full. I add one thing it did not have: **the two links are unequally supported.** L62's is two primes with a deliberately chosen second and an independent code path; L87's is one prime and one run, guarded only by three floating-point agreements the block does not cite. **If either link is the weaker, it is L87's**, which is the one the record calls proved.

## Repairs owed, none of which moves a number

1. **Replace the headline.** *"SETTLED, AND THE RANK IS NOW PROVED RATHER THAN MEASURED"* → the cap is a theorem, the attainment is one exact finite computation. Under [INDEX-results.md](../findings/INDEX-results.md)'s own literal labels (*"**Lemma** is proven … **Observation** is verified numerically"*), **the honest form is a `Lemma` for the cap and an `Observation` for the value**, which is precisely what this record already did to L62.
2. **State the cap on the hypothesis that gives it.** *"using $\dim V_\lambda^H\le1$"* → the full parity rule of [L86](../findings/sym3-blocks.md), cited. Without the odd-block vanishing the cap is $5640$ and the squeeze does not close.
3. **Replace the mod-$p$ one-liner** with the two-line semicontinuity argument in §*Step (3)* above, since the sampled group elements are not reductions of characteristic-zero rotations.
4. **Fix the attribution, in both blocks.** The measurement is [r170](REVIEW_r170.md)'s, confirmed by [r173](REVIEW_r173.md); [r174](REVIEW_r174.md) derived the cap. Repair [L86](../findings/sym3-blocks.md)'s copy at the same time.
5. **Say "an independent construction of $W_0$ and exact arithmetic"**, not "independently", the method is [r170](REVIEW_r170.md)'s and the target was known.
6. **Add the links**: [REVIEW_r178.md](REVIEW_r178.md), [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), [L86](../findings/sym3-blocks.md), [L83](../findings/sym3-blocks.md), and the three corroborating runs.
7. **Reconcile with [L86](../findings/sym3-blocks.md)'s "what promotes it to an identity is a measurement"**, four lines above, and record that the check L86 names (evaluating the $41$ highest-weight vectors), is **still open** and is still what would make the headline true.
8. **Say, in L59 and L62 or in a line of their own, that the chain has two measured links.** The record has the sentence already, in [r652](REVIEW_r652.md)'s note on L59; no block carries it.

## What would settle it, and what a run would decide

**The block's headline becomes true only by the check [L86](../findings/sym3-blocks.md) already names**: evaluate the $41$ highest-weight vectors of [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py), read as cubic polynomials, at a handful of orbit points $g\cdot W_0$ over $\mathbb Q$. **A single nonzero value per even block settles that block's rank at $1$ by itself**, block by block, with no cap and no attainment, sixteen independent small facts in place of one $3700\times3700$ rank. *That run needs computation and I do not have approval for it; I record it as the open item rather than starting it.* Outcomes: **sixteen nonzeros** retires the measured link and the headline becomes earned; **any zero** refutes L87, collapses $36$ to a lower bound, and reopens the eight block deaths and the two vanishing Casimir collisions with them.

Short of that, **the honest split of 1. above costs the record nothing**: $3570$, $25$, $36$, $29$, the shape, the eight deaths and the surviving collision all stand exactly as written.
