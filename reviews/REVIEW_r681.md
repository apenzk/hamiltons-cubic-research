# Review r681, Lemma L87, the rank-one step

**Reviewer A of an independent pair on identical briefs; the companion takes r682. Derived cold from the definitions before the block's reasoning was read.** Analysis only: no sweep, census or rank computation was run, and the $3700$-point orbit sample was neither re-run nor extended. One screen is reported as such below.

## Verdict

**GAP.** *The conclusion is true and the numbers are all correct, I re-derived the cap $3570$, the $16$ even blocks, the $25$ multiplicities, the $36$ unknowns, the shape and the eight deaths by hand, and every one reproduces. The squeeze is legitimate and its inequalities point the right way. But the headline **"PROVED RATHER THAN MEASURED" is not earned as the block stands**, for a reason sharper than the usual one: the cited computation's orbit points are constructed **inside $\mathbb F_{46337}$**, so the sentence "a mod-$p$ rank is a lower bound for the characteristic-zero span" names a characteristic-zero object that does not exist until a lift is supplied. The lift exists and is two lines. It is nowhere on the record.*

## Readings adopted, per [conventions.md](../findings/conventions.md)

| symbol | reading taken | why it does not bite |
| --- | --- | --- |
| $\langle\cdot,\cdot\rangle$ on $\mathcal W_5$ | any $O(5)$-invariant positive-definite form | the argument is a **rank**, and rescaling $\langle\cdot,\cdot\rangle$ by $c>0$ rescales the Gram by $c^3$. The $\Lambda^2$-versus-Frobenius factor-$2$ trap of [conventions.md](../findings/conventions.md) is inert here |
| $W_0$ | the padded $W_{\mathbb{CP}^2}$, $2w_1w_1^{\mathsf T}-w_2w_2^{\mathsf T}-w_3w_3^{\mathsf T}$ on $\Lambda^2\mathbb R^5$ | traceless, Bianchi (self-dual-supported at $n=4$), Ricci-traceless after padding, so $W_0\in\mathcal W_5$ and the whole orbit of $W_0^{\otimes3}$ lies in $\mathrm{Sym}^3\mathcal W_5$. The cap argument needs exactly this |
| $H$ | $\mathrm{Stab}_{O(5)}(W_0)$, as in [L86](../findings/sym3-blocks.md) | the block's source works with the $SO(5)$-orbit instead; harmless, since $-\mathrm{Id}$ acts trivially on every constituent of $\mathrm{Sym}^3\mathcal W_5$ and [L86](../findings/sym3-blocks.md) shows $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ redundant, so the two orbits span the same space. **The block silently changes group and gets away with it** |
| $\lambda$-labels | $e$-basis, as in [L83](../findings/sym3-blocks.md)'s table | flagged as unstated by [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md); $\lambda_2$ parity is basis-dependent, so this reading is load-bearing for L87 and not just for L83 |
| $\mathrm{Sym}^3$ pairing | the tensor-power form, $\langle X^{\otimes3},Y^{\otimes3}\rangle=\langle X,Y\rangle^3$ | an identity over any commutative ring, so the Hadamard cube of the point Gram is exactly the Gram of the Veronese images. No normalisation choice enters |

## The derivation, cold

Write $\mathrm{Sym}^3\mathcal W_5=\bigoplus_\lambda M_\lambda\otimes V_\lambda$, and let $U=\mathrm{span}\{(gW_0)^{\otimes3}:g\in O(5)\}$, a submodule.

**The cap, which is a theorem.** $W_0^{\otimes3}$ is $H$-fixed, and $(M_\lambda\otimes V_\lambda)^H=M_\lambda\otimes V_\lambda^H$. By [L86](../findings/sym3-blocks.md), $\dim V_\lambda^H=1$ for $\lambda_2$ even and $0$ otherwise, so the $\lambda$-component of $W_0^{\otimes3}$ is a **single** decomposable tensor $w_\lambda\otimes v_\lambda$, and the submodule it generates has $\lambda$-multiplicity $r_\lambda=[\,w_\lambda\neq0\,]\in\{0,1\}$. Hence

$$\dim U=\sum_\lambda r_\lambda d_\lambda\ \le\ \sum_{\lambda_2\ \mathrm{even}}d_\lambda=3570 .$$

**The bridge to "loses one multiplicity", which the block omits.** A degree-$3$ covariant into $V_\lambda$ is an element of $M_\lambda^*$; its value at $W_0$ lies in $(V_\lambda^*)^H$, and the pairing computes $\langle\phi,w_\lambda\rangle\langle v,v_\lambda\rangle$. So the evaluation map $\mathrm{ev}_\lambda:M_\lambda^*\to(V_\lambda^*)^H$ has rank exactly $r_\lambda$: **zero when $w_\lambda=0$, and otherwise rank one with kernel the hyperplane $w_\lambda^\perp$.** *That is the two-sided statement the heading claims (at most one from $\dim V_\lambda^H\le1$, at least one from $r_\lambda=1$) and neither the block nor [r178](REVIEW_r178.md) writes the identification $\mathrm{rank}\,\mathrm{ev}_\lambda=r_\lambda$ down.* It is genuine, but a reader is asked to supply it.

**The squeeze.** $\mathrm{rank}$ of the Gram of finitely many orbit points $\le\dim U\le3570$; a computed rank of $3570$ therefore forces $\dim U=3570$, hence $r_\lambda=1$ on all sixteen even blocks. **Every inequality points the right way** (sampling under-counts, reduction mod $p$ under-counts, $\dim V_\lambda^H\le1$ over-counts) so the maximising/minimising confusion a neighbouring audit found does not occur here. *The two meet by coincidence of numbers, not by argument: nothing forces a finite sample to attain the cap.*

## The defect, the sample is built in characteristic $p$, so there is no characteristic-zero span to bound

[orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) draws each group element as `A = random skew over GF(46337)` followed by a Cayley transform, so **$g\in O(5,\mathbb F_{46337})$ and not the reduction of anything**. The block's justifying sentence (*"a mod-$p$ rank is a lower bound for the characteristic-zero span"*), compares $\mathrm{rank}_{\mathbb F_p}$ against a $\mathrm{rank}_{\mathbb Q}$ of a matrix that was never formed.

**The direct characteristic-$p$ route is unavailable, so this is not a formality.** The cap rests on complete reducibility and on the isotypic decomposition of $\mathrm{Sym}^3\mathcal W_5$; $p$ divides $\lvert O(5,\mathbb F_p)\rvert$ for every $p$, so that module is **not** semisimple over $\mathbb F_p$ and no isotypic decomposition of the kind the cap uses exists there. Nothing in characteristic $p$ bounds the computed rank by $3570$ at all.

**The repair, in two lines, and it works.** Lift $A$ entrywise to a skew $\tilde A\in M_5(\mathbb Z)$. For real skew $\tilde A$, $\det(I+\tilde A)\ge1$, so $\tilde g=(I-\tilde A)(I+\tilde A)^{-1}\in O(5,\mathbb Q)$ exists unconditionally, is $p$-integral because $\det(I+\tilde A)\equiv\det(I+A)\not\equiv0$, and reduces to $g$. Then $\Lambda^2$ and $W_0$ being integral, $\tilde W_a=\Lambda^2(\tilde g)\,W_0\,\Lambda^2(\tilde g)^{\mathsf T}$ is a genuine **real** orbit point reducing to the computed $W_a$, and $\tilde G_{ab}=\langle\tilde W_a,\tilde W_b\rangle^3$ is a $p$-integral rational matrix reducing to the computed Gram. Hence $3570=\mathrm{rank}_{\mathbb F_p}\le\mathrm{rank}_{\mathbb Q}\tilde G=\dim\mathrm{span}\{\tilde W_a^{\otimes3}\}\le\dim U\le3570$. **The conclusion survives intact; what is missing is the sentence.**

*Note in the block's favour, since a reviewer could wrongly object here: the prime is small ($46337$ against a $3700\times3700$ matrix) and that is **harmless**, because a bad prime can only lower the rank, which is the safe direction. Likewise a Gram matrix over $\mathbb F_p$ can have rank below the dimension of its span, again the safe direction. The exactness question the brief asks is answered cleanly: **all arithmetic is exact in $\mathrm{GF}(46337)$**, and exactness buys a rigorous lower bound rather than a numerical one.*

## The cap is neither [L85](../findings/sym3-blocks.md)'s $14$ nor [L86](../findings/sym3-blocks.md)'s $36$, and the squeeze is not circular

The cap is $\sum_{\lambda_2\ \mathrm{even}}d_\lambda=3570$, a sum of **representation dimensions** from [L83](../findings/sym3-blocks.md)'s table filtered by [L86](../findings/sym3-blocks.md)'s parity rule. [L85](../findings/sym3-blocks.md)'s $14$ is a sextic invariant count and [L86](../findings/sym3-blocks.md)'s $36$ is an unknown count; neither enters. **The two legs of the squeeze have disjoint sources**, the cap from the character table plus branching, the rank from an orbit computation touching neither, so the specific failure the brief asks about does not occur. *Screened, seconds, on objects built for the purpose: Weyl's $B_2$ dimension formula reproduces all $24$ subscripts, $\sum m_\lambda d_\lambda=7770=\binom{37}3$, the $16$ even blocks sum to $3570$, surviving multiplicities $25$, unknowns $36$, shape two $3\times3$ / five $2\times2$ / nine scalars, and the eight deaths are $(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$. All by hand first, then screened; agreement exact.*

**The two vanishing collisions check.** [L84](../findings/sym3-blocks.md)'s three $c_2$ collisions are $(4,1)/(3,3)$ at $30$, $(4,3)/(5,0)$ at $40$, $(5,4)/(6,2)$ at $60$. $(5,0)$, $(5,4)$ and $(6,2)$ are even multiplicity-$1$ blocks and die; $(4,1)$ and $(3,3)$ are both odd and both survive. So exactly two collisions vanish and one remains, **and it is the "at least one" half, the half L87 supplies, that this rests on.**

## Citation, pointers and provenance

- **The block contains no links whatsoever.** It consumes [L86](../findings/sym3-blocks.md) (the parity rule and $\dim V_\lambda^H\le1$), [L83](../findings/sym3-blocks.md) (the dimension table that makes the cap $3570$) and [L84](../findings/sym3-blocks.md) (the collisions) while citing none of them. *This is the fifth instance of the pattern [r651](REVIEW_r651.md)/[r652](REVIEW_r652.md) recorded on [L59](../findings/sym3-blocks.md).*
- **It points at no script.** The one computational claim it makes is unreproducible from the block; a reader cannot reach [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), and therefore cannot see that the points are $\mathbb F_p$-points and cannot notice the missing lift. *Every pointer resolves, vacuously, there are none.*
- **The provenance note is defensible.** *"Reviewer 178, independently and while 177's objection was being folded in"*: `git` puts 177's objection at 12:42:39 (9999706c) and L87 at 12:44:20 (a1028174), with [gate2_178.log](../agent_logs/gate2_178.log) placing phase 6 across that window. **So "while" is accurate, and this is one of the rare clean provenance notes in this file.** *"Independently" is method-independence only*: [r178](REVIEW_r178.md) line 101 shows 178 read plan.md's citation of 174's $3570$ before running, so the target number was known in advance, the construction of $W_0$ and the route are independent, the value is not. **The block's stronger phrase, "174's measured $3570$ is independently reproduced", overstates that by one notch.**
- **The commit body is more accurate than the block**, saying *"settling 177's objection independently"* where the block says *"independently and while ... being folded in"*, the opposite of the [L83](../findings/sym3-blocks.md) pattern, where the commit was right and the rewording made it false.

## The evidence is far stronger than the block says, and two corroborations go uncited

**This is the [L83](../findings/sym3-blocks.md) situation again (well supported by reviews the block never cites) and here it matters, because the uncited runs are exactly the ones that close the characteristic-zero hole.**

| run | points | arithmetic | what it buys |
| --- | --- | --- | --- |
| [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) | $3700$, Cayley over $\mathbb F_{46337}$ | exact in $\mathrm{GF}(p)$ | a rigorous lower bound **once the lift is written down**; alone it is a non sequitur |
| [r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py) | $4800$ Haar samples of $SO(5)$ | double precision | genuine characteristic-zero orbit points; rank $3570$ **stable at every tolerance from $10^{-6}$ to $10^{-12}$** ([r173](REVIEW_r173.md)) |
| [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) | $3700$ | double precision | genuine characteristic-zero points; eigenvalue gap $3.49\times10^{9}$ sitting exactly at index $3570$ ([r203](REVIEW_r203.md)) |

*The two floating-point runs are what the exact run is missing and vice versa. Cited together the result is beyond reasonable doubt; cited as the block cites it (one run, no pointer, no lift), it is a claim a reader cannot check.*

## The file settles it above, and the block above is now stale

[L86](../findings/sym3-blocks.md), six lines up, **already contains this exact squeeze**: *"the derived upper bound is the same $3570$. An upper bound attained forces every one of the sixteen ranks to be exactly $1$."* L87 changes the provenance of the input number, not the argument. And [L86](../findings/sym3-blocks.md) still closes with *"Everything downstream ... rests on that single measured number"* and proposes a removal check (*evaluating the $41$ highest-weight vectors at points $g\cdot W_0$*), **that was never run, L87 having taken a different route.** *So the file asserts the dependency stands and then closes it six lines later, and neither block reconciles with the other.* This is the same defect [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) recorded on [L62](../findings/sym3-blocks.md) at fifty-four lines' distance; here it is six.

**Duplication, in four kinds.** *(i)* Numbered elsewhere: none, L87 appears only in [INDEX-results.md](../findings/INDEX-results.md), which still records *"Gate 2: no verdict on the record"* while the block says **SETTLED**. *(ii)* Unnumbered in the same file: [L86](../findings/sym3-blocks.md)'s paragraph above, and [L59](../findings/sym3-blocks.md)'s codimension-one step, which **is** L87's conclusion restated as though structural. *(iii)* Another findings file: none. *(iv)* Outside [findings/](../findings/): [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 908 asserts the orbit average of the rank-one forms has *"rank $3570$"*, the same fact, unattributed. **L87 reaches neither [results.md](../results.md) nor [plan.md](../plan.md) at all.**

## Whether [L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) may rest on this as they do

**They may rest on the mathematics; they may not rest on it silently.**

- **[L59](../findings/sym3-blocks.md): the dependency is real, correct and acyclic, and its presentation is wrong.** Its $65=36+29$ split turns on *"an even one keeps $u\otimes v+v\otimes u$, $K$ having codimension $1$ there"*. The **at most one** half is [L86](../findings/sym3-blocks.md)'s and structural; the **at least one** half is L87's and rests on the sampled rank. L59's body reads as though both were structural, and cites L87 nowhere. *The numbers $36$ and $29$ are correct either way.*
- **[L62](../findings/sym3-blocks.md): rests on L87 only through L59, and legitimately.** Its own measured half (the sampled rank attaining $13$), is a separate computation at a separate scale with separate primes.
- **The chain carries two measured links, and I confirm it.** L87's $3700$-point Gram over $\mathbb F_{46337}$ feeds *both* of L59's uses (the $36$ and the codimension-one step are one fact, not two), and L62 adds a second, independent sampled rank. **So the correct count is two measurements over three results, and no block states either.** *Dependency order $\mathrm{L83}\to\mathrm{L86}\to\mathrm{L87}\to\mathrm{L59}\to\mathrm{L62}$ is acyclic; I found no cycle.*

## What the record should say, and the one honest wording

**[L62](../findings/sym3-blocks.md) and L87 have the identical logical shape (a proved cap, a sampled mod-$p$ rank attaining it) and this file calls one *"one sampled mod-$p$ rank, and it carries everything"* and the other *"PROVED RATHER THAN MEASURED"*.** Both cannot be right about the same form. **The honest form here is [L62](../findings/sym3-blocks.md)'s own prescription**: a `Lemma` for the cap $\dim U\le3570$, which is a theorem in four lines, and an `Observation` for the value, which is an exact computer computation resting on a lift the record has never written down.

*What is genuinely new in L87, and worth keeping: the promotion from 174's floating-point measurement to exact arithmetic is a real improvement in kind, and with the Cayley lift added it is a computer-assisted **proof** rather than a measurement. The word to strike is not "proved" but the implied "by hand".*

**Repairs owed, none of which moves a number:** state the lift; cite [L83](../findings/sym3-blocks.md), [L86](../findings/sym3-blocks.md) and [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage); add the one-line bridge $\mathrm{rank}\,\mathrm{ev}_\lambda=r_\lambda$; cite [r173](REVIEW_r173.md) and [r203](REVIEW_r203.md); retire [L86](../findings/sym3-blocks.md)'s stale closing paragraph; and reconcile [INDEX-results.md](../findings/INDEX-results.md)'s "no verdict" with the block's "SETTLED".

**No computation was requested or run beyond the arithmetic screen named above.** *Nothing in this review needs one: the lift, the bridge and the wording are all analysis, and the corroborating runs already exist on the record.*
