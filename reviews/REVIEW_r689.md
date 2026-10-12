# Review r689, Lemma L91, the identity Gram on $K$ and the unconditional lower bound $1$

**Reviewer A of an independent pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 163, `#### Lemma L91, the identity Gram on $K$ gives the unconditional lower bound $1$`, and the three bullets and two paragraphs beneath it (lines 165–171).**

## Verdict: GAP

**Every mathematical claim in the block is true, and I rebuilt all three cold from the definitions.** Two things stop it short of CONFIRMED.

- **The block never says what the $1$ bounds.** The quantity is $\mathrm{rank}\big(\mu|_{\mathrm{Sym}^2(K)^{O(5)}}\big)$, and the sentence naming it (*"the rank is open in $[1,13]$"*), sits at [line 159](../findings/sym3-blocks.md), **four lines above L91's heading, under [L90](../findings/sym3-blocks.md)'s**. A reader who lands on L91 has a bound with no subject.
- **The third bullet is false as literally written**, for one missing word: $\{F:\mathrm{Cat}_F(K,K)=0\}$ must range over the *invariant* sextics. Unqualified it is a subspace of the whole of $\mathrm{Sym}^6\mathcal W_5^*$ and $14-\dim(\cdot)$ is wildly negative. This is the same defect [r651](REVIEW_r651.md)/[r652](REVIEW_r652.md) booked on [L59](../findings/sym3-blocks.md), inherited here.

**And the answer the brief asks for directly: the bound is FREE.** $\mathrm{rank}\ge1$ says only that $\mu$ is not the zero map on the $36$, which follows from $K\ne0$ alone in two lines. The identity Gram is one convenient witness, not a lever. *"Unconditionally" is honest about a repair and does no mathematical work.*

**Provenance is clean**, the rare outcome in this file. The commit body of `ec35c0b9` states the block's content verbatim, including the retraction the block reports.

## Readings adopted

Every convention I use, stated. [conventions.md](../findings/conventions.md) was read first; its three repairs of today ($\theta_0(n)$ as the closed form alone, $\Theta_n$'s square root, $S_{XYZ}$ as ordered slots), **do not appear in L91 and do not bear on it**.

| symbol | reading I use | why |
| --- | --- | --- |
| $\mathrm{Sym}^3\mathcal W_5^*$ | the real cubic **forms** on $\mathcal W_5$, $\dim=\binom{37}3=7770$ | matches the file's own $7770$ at [L83](../findings/sym3-blocks.md) |
| $K$ | the subspace of cubics vanishing on the whole $O(5)$-orbit of $W_0$ | [L59](../findings/sym3-blocks.md)'s *"the span cut out by the orbit constraint"*. **This is a fourth $K$**: [conventions.md](../findings/conventions.md) tables $K$ as the sectional matrix $K_{ab}=W_{abab}$, and the letter also carries the vertex matrix and $M$'s alias. Read from context. |
| $\mu$ | the multiplication map $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$, $q\odot q\mapsto q^2$ | **collides with [conventions.md](../findings/conventions.md)'s $\mu=\operatorname{spec}(M)$ and with $\mu$ the weight in [L92](../findings/sym3-blocks.md) twelve lines below.** Here it is the Gram-to-sextic map, and *restricted to $K$* throughout L91, [L89](../findings/sym3-blocks.md) uses the same bare letter for the unrestricted map |
| $\mathrm{rank}$ | $\dim\mu\big(\mathrm{Sym}^2(K)^{O(5)}\big)$, the **restricted, invariant** rank | forced by the $36$ and by $36-\mathrm{rank}$; $[1,13]$ at line 159 confirms it |
| $W_0$ | the padded $W_{\mathbb{CP}^2}$, $\lVert W_0\rVert=1$ | [L86](../findings/sym3-blocks.md). **Defined nowhere in [conventions.md](../findings/conventions.md)** |
| apolar pairing | the one with $\langle \ell_v^3,\ell_w^3\rangle=\langle v,w\rangle^3$, $\ell_v=\langle v,\cdot\rangle$ | the only normalisation under which the block's own $\Delta/\lVert W\rVert^6\approx0.5$ can lie in $[0,1]$; see §2. **Named nowhere on the record** |
| $\Delta$ | the invariant sextic $\mu(I_K)$ | **a collision the brief did not list**: [conventions.md](../findings/conventions.md) tables $\Delta$ as *the symmetry defect* from [diagonal-half.md](../findings/diagonal-half.md), and [scripts/reviewers/r313/](../scripts/reviewers/r313/) and [r314/](../scripts/reviewers/r314/) print that object under the same letter. Unrelated to L91's |
| $\mathrm{Cat}$, $\mathrm{ANN}$ | $\mathrm{Cat}=\mu^*$ and $\mathrm{ANN}=\{F\in(\mathrm{Sym}^6)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$ | [L59](../findings/sym3-blocks.md). **Both absent from [conventions.md](../findings/conventions.md)**, as the brief says |
| block extent | a `####` block runs to the next `####` | the only reading giving L91 content; flagged because [r633](REVIEW_r633.md) and [r634](REVIEW_r634.md) disagreed on the `##` boundary in this same file |

## 1. Deriving the lower bound cold

**The set-up.** An SOS certificate for $F_5$ is a psd $A\in\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)$ with $\mu(A)=F_5$. Averaging over the compact $O(5)$ preserves both psd-ness and the image, so $A$ may be taken invariant, the $65$ of [L88](../findings/sym3-blocks.md). Since $F_5\ge0$ and $F_5(W_0)=0$, every square in the decomposition vanishes at $W_0$, hence, by [L90](../findings/sym3-blocks.md)'s second cap-bullet at [line 156](../findings/sym3-blocks.md), the restricted cubics forming an $O(5)$-submodule, on the whole orbit. So $A$ lives on $K$, and the search space is $\mathrm{Sym}^2(K)^{O(5)}$.

**That space has dimension $36$.** Each $V_\lambda$ is of real type ([L88](../findings/sym3-blocks.md): every $B_2$ weight here is integral, the quaternionic ones being the half-integral spin representations), so $\mathrm{Sym}^2(V_\lambda\otimes K_\lambda)^{O(5)}\cong\mathrm{Sym}^2(K_\lambda)$, and Schur kills the cross terms. With [L86](../findings/sym3-blocks.md)'s shape (two $3\times3$, five $2\times2$, nine scalars), this is $2\cdot6+5\cdot3+9\cdot1=36$. **Cross-checks all close**: the surviving multiplicities are $2\cdot3+5\cdot2+9\cdot1=25$; the unrestricted count is $12\cdot1+9\cdot3+1\cdot6+2\cdot10=65$; and $65-36=29$.

**The witness.** $\mathcal W_5$ carries an invariant inner product, so $\mathrm{Sym}^3\mathcal W_5^*$ carries the apolar one, and $K$ (an invariant subspace), inherits it. Gram–Schmidt gives an apolar-orthonormal basis $q_1,\dots,q_{4200}$ of $K$, and the identity form $I_K=\sum_a q_a\odot q_a$ is independent of that choice and invariant. Then

$$\Delta:=\mu(I_K)=\sum_a q_a^2.$$

Each $q_a\in K$ vanishes on the orbit, so $\Delta$ does; $\Delta$ is a sum of real squares, so psd; and $\Delta\ne0$ because $q_1\ne0$ and a nonzero real polynomial is a nonzero function, so $\Delta(W)\ge q_1(W)^2>0$ somewhere. Hence

$$\boxed{\ \mathrm{rank}\big(\mu|_{\mathrm{Sym}^2(K)^{O(5)}}\big)\ \ge\ 1.\ }$$

**What "unconditionally" needs, in full.** $K\ne0$; the existence of an invariant inner product ($O(5)$ compact); [L90](../findings/sym3-blocks.md)'s point-to-orbit step. Nothing else. **An apolar-orthonormal basis of $K$ always exists**, $K$ is a finite-dimensional subspace of a Euclidean space, and that is the whole of it. The claim is genuinely unconditional. ✓ **CONFIRMED.**

## 2. A free identity the block misses, and what it fixes

The apolar pairing is reproducing: $q(w)=\langle q,\ell_w^3\rangle$. So for **any** subspace $U\subseteq\mathrm{Sym}^3\mathcal W_5^*$ with orthonormal basis $\{u_b\}$, $\sum_b u_b(w)^2=\lVert P_U\ell_w^3\rVert^2$. Applied to $U=K$ and $U=K^\perp$:

$$\Delta_K(W)+\Delta_{K^\perp}(W)=\lVert\ell_W^3\rVert^2=\lVert W\rVert^6.$$

And $K^\perp=\mathrm{span}\{\ell_{gW_0}^3:g\in O(5)\}=:C$ **is exactly [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md)'s $3570$-dimensional module**, which the block never notices. Four things fall out for free:

| consequence | value |
| --- | --- |
| $\dim K=7770-3570=4200$ | the block never states it |
| $0\le\Delta/\lVert W\rVert^6\le1$ exactly | so the reported $\approx0.5$ is *inside a proved interval*, not a bare sample |
| $\Delta\ne0$ iff $K\ne0$ | the one-line proof of the bullet's only load-bearing clause |
| $\Delta(v)=0\iff v^3\in C$ | the zero locus is $V(K)$, exactly |

**This is the record's own construction, unwritten.** [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) computes `G = (Cpts @ Cpts.T)**3` and $\rho(u)=\lVert P_Cu^3\rVert^2/\lVert u^3\rVert^2$, which is $1-\Delta/\lVert u\rVert^6$. So the block's $\approx0.5$ **is** $1-\rho$ at random points, and the apolar normalisation is pinned by that script rather than by any prose. *Screen-level remark, offered as such and not as evidence: $\dim K/\dim\mathrm{Sym}^3=4200/7770=0.5405$, which is where a random point would sit if the kernel's mass were spread evenly. It is not a derivation of $0.5$.*

**The sharpest consequence: bullets 1 and 3 are the same question, and the block states them as two.** [report/sections/07-gradedness-split.tex:914](../report/sections/07-gradedness-split.tex) already derives $\mathcal A(v^6)\in\mathrm{ANN}\iff v^3\in C$. Combined with the line above, $\Delta(v)=0\iff\mathcal A(v^6)\in\mathrm{ANN}$, so the *"live lead"* paragraph's *"appears to vanish exactly on the orbit cone"* and the third bullet's *"unless a second coincidence occurs"* are one enquiry. **The direction is one-way and the report is careful where L91 is not**: $\Delta$ vanishing only on the cone gives $\dim\mathrm{ANN}\ge1$, never $=1$, because a $2$-dimensional $\mathrm{ANN}$ need contain no $\mathcal A(v^6)$ at all. [report/sections/09-status.tex:15](../report/sections/09-status.tex) accordingly says *"No second **sixth-power** obstruction"*, with its restriction intact. L91 cites neither, and its own screen (twelve points, six in the script), is superseded by the report's $160$ ascents plus $W_0$ a smooth point of $V(K)$ at tangent dimension $7$.

## 3. Is the bound free? Yes, and the block's rhetoric outruns it

**$\mathrm{rank}\ge1$ is equivalent to "$\mu$ is not identically zero on the $36$".** Take any $q\in K\setminus\{0\}$ and set $A=\int_{O(5)}(g\cdot q)\odot(g\cdot q)\,dg$. Then $A$ is invariant, psd, supported on $K$, and $\mu(A)(W)=\int q(g^{-1}W)^2dg>0$ somewhere. **So the bound needs $K\ne0$ and nothing more**, and $K\ne0$ is visible from $\dim\mathrm{Sym}^2(K)^{O(5)}=36>0$.

Three ways of saying how little it buys:

- **It removes exactly one value from a range of fourteen** (rank $\in\{0,\dots,13\}$ becomes $\{1,\dots,13\}$) and the removed value was the impossible one.
- **The same file asserts the rank is $13$**, at [L90](../findings/sym3-blocks.md) (the boxed display at line 149) and [L62](../findings/sym3-blocks.md) (heading at line 227). **L91's bound is twelve short of what the record already claims.**
- **The predecessor was worse, not weaker.** `git show ec35c0b9` shows the bullet replaced *"$F_5$ lies in the image, so the rank is in $[1,14]$"*. The old $1$ came from a circular premise; the new $1$ comes from a free one. **The number did not move, only its justification did.** The block's own italic says exactly this, to its credit.

**Does "unconditional" do rhetorical work?** Mildly. It is accurate, and it earns its place as the record of a retraction. But placed as a headline it advertises strength in a statement whose content is "the map is nonzero", and the heading (*"gives the unconditional lower bound $1$"*), reads as a lemma with a lever. **The record should know this one carries no information.**

## 4. The consistency caveat, the honest half, and it is right

> *"$36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent, and consistency is exactly the open necessary condition: $F_5$ must lie in the image, or the route dies."*

**CONFIRMED, on both halves.**

- **The linear-algebra half is exactly right.** $\mu(A)=F_5$ on the $36$ is an inhomogeneous linear system into the $14$. If solvable its solution set is a coset of $\ker\mu|_{36}$, of dimension $36-\mathrm{rank}$; if not, it is empty, and $36-\mathrm{rank}$ is a number describing nothing. Stating this is to the block's credit and it is stated correctly.
- **Necessity is right.** By §1's averaging-and-restriction argument, *every* SOS certificate can be taken invariant and supported on $K$, so $F_5\notin\mathrm{image}(\mu|_{36})$ kills the route outright. **"Or the route dies" is sound in that direction.**

**One trap the phrasing leaves open.** Consistency is necessary but **not** sufficient: the route additionally needs a **psd** point inside the affine family, and the linear reduction drops psd-ness entirely. [L59](../findings/sym3-blocks.md)'s audit note already records this, *"the certificate still owes a PSD point in the $23$-dimensional family"*. L91 says *"necessary condition"* and is therefore correct as written, but *"or the route dies"* invites the converse reading. **One clause fixes it.**

**Does anything on the record use $36-\mathrm{rank}$ without the caveat? No.** I swept [findings/](../findings/), [results.md](../results.md), [report/](../report/) and [plan.md](../plan.md). The formula appears twice, both in this file: L91's own bullet, and [line 151](../findings/sym3-blocks.md)'s *"the affine family is $36-13=23$ dimensional"* under [L90](../findings/sym3-blocks.md), where consistency **is** established, three lines above, in the boxed $F_5\in\mathrm{image}$. **Neither [results.md](../results.md) nor [report/](../report/) carries $36-\mathrm{rank}$ at all.** *So the companion audit's pattern (a dimension asserted where consistency was never established), does not recur here.*

## 5. Where the $36$ comes from: imported, and uncited

**L91 derives nothing and cites nothing.** The block contains **zero markdown links**, I checked lines 163–172 directly. Four numbers are consumed bare:

| number | owner | status in L91 |
| --- | --- | --- |
| $36$ | [L86](../findings/sym3-blocks.md), proved by [L87](../findings/sym3-blocks.md) | **imported, uncited** |
| $14$ | [L85](../findings/sym3-blocks.md) | imported, uncited |
| $29$, $65$ | [L59](../findings/sym3-blocks.md), [L88](../findings/sym3-blocks.md) | imported, uncited |

**The $36$ is not even needed for the bound.** All the first bullet requires is that $I_K$ be invariant and supported on $K$; *"is one of the $36$ invariant forms"* is decoration. The number is load-bearing only in the second and third bullets. **So the one figure L91 could have earned by construction, it borrows.**

*Phrasing: "one of the $36$ invariant forms" reads as one of thirty-six objects. It is one element of a thirty-six-dimensional space, and, being positive definite in every block, an interior point of that space's psd cone. **The free content there is that the psd cone in the $36$ is full-dimensional**; the route needs a psd point in the affine slice $\mu^{-1}(F_5)$, which $\Delta$ does not supply.*

## 6. The consistency condition, settled, and on a measured number

**Plainly: the route's life rests on a measurement.** The chain, as the file has it:

1. [L62](../findings/sym3-blocks.md): $\mathrm{rank}\le13$ is a **theorem** (order-$1$ vanishing at $W_0$, evaluation nonzero on the $14$).
2. [L62](../findings/sym3-blocks.md)/[L90](../findings/sym3-blocks.md): $\mathrm{rank}\ge13$ is a **sampled mod-$p$ rank**, at $p=1000033$ and $p=1000003$.
3. Hence $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, and $F_5\perp\mathrm{ANN}$ because $F_5(W_0)=0$, so $F_5\in\mathrm{image}$.

**Step 2 is the whole of it.** [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) established that the proved half alone yields only $F_5\perp\mathcal A(W_0^6)$, which restates $F_5(W_0)=0$ and is content-free. **And this file warns at [line 157](../findings/sym3-blocks.md) that a defect landing the rank exactly *on* the cap is invisible, which is exactly this configuration.** So yes: L91's *"open necessary condition"* is closed on the record, by a number nobody has proved.

**A second route to consistency exists and is stronger, and L91 does not mention it.** The exact rational certificate at [lines 130–139](../findings/sym3-blocks.md) *exhibits* $F_5$ as a sum of squares, a witness, not a measurement. If it holds, $F_5\in\mathrm{image}$ is settled constructively. **But its own audits have dented it**: [r597](REVIEW_r597.md)/[r598](REVIEW_r598.md) found *"rational entries at denominator $10^5$"* false, thirteen of forty-seven coordinates reaching $5\times10^{16}$, and [r204](REVIEW_r204.md) refuted the $\mathbb Q(i)$ basis's gauge labelling. *It remains exact and machine-checkable, and unverifiable by hand even in principle.*

**And this is where L91 is stale.** A block calling consistency *"open"* sits thirty lines below an exhibited certificate and twenty above [L62](../findings/sym3-blocks.md)'s $\mathrm{rank}=13$. **[r633](REVIEW_r633.md) recommended reconciling exactly these lines** (its item 8: *"'open in $[1,13]$' and 'lower bound $1$, unconditionally' are stale"*), **and no repair was made.** I reach the same verdict independently and record it as a second sighting.

## 7. Provenance, clean, and I say so explicitly

The brief warns that one provenance clause in this file was found manufactured today. **This one is not.** Two strands:

- **`git log -S"apolar-orthonormal"` returns a single commit, `ec35c0b9`** (*"fix(n5): apply Gate 2 r203/r204"*, 2026-08-28). Its body carries, as bullets: *"rank >= 1 is now unconditional via Delta = sum_a q_a^2, replacing the retracted 'F_5 lies in the image'"* and *"'family = 36 - rank' holds only if the system is consistent, which is the open condition."* **The block says what its commit says, with no drift.** The italic retraction note is accurate: the diff shows the removed text was *"What is known: $F_5$ lies in the image, so the rank is in $[1,14]$"*.
- **`git log -S"unconditional lower bound"` returns only the heading commit `8d869d2c`** (*"docs(sym3-blocks): place headings for Lemmas 83-92"*), whose diff for this file is **additions of ten `####` lines and blank lines, nothing else.** The *"headings only"* promise holds, as [r663](REVIEW_r663.md) found on [L83](../findings/sym3-blocks.md).

## 8. Duplication and misplaced content, one hit, of the kind the brief names

**The heading was inserted into the middle of a four-item bullet list, and it split the list.** The diff of `8d869d2c` is unambiguous: `#### Lemma 91` was placed **between** the *"Upper bound $13$"* bullet and the *"Lower bound $1$"* bullet. Consequences, all live:

- **The upper-bound bullet is severed from its siblings** and now reads under [L90](../findings/sym3-blocks.md)'s heading, together with the lead sentence that names the quantity.
- **L91 inherits an orphan.** *"Two of the three Casimir collisions vanish with them"* (line 171) sits under L91's heading but **appears as a context line in `ec35c0b9`'s diff**, it predates the block entirely. Its *"them"* refers to [L86](../findings/sym3-blocks.md)'s eight dying blocks, and [L84](../findings/sym3-blocks.md)'s audit attributes the collision-killing to [L87](../findings/sym3-blocks.md). **It is not L91's content, and it is the antecedent [L92](../findings/sym3-blocks.md) opens by referring to**, *"And the highest-weight route never meets even that one"*.

**Does the content appear elsewhere? No, but a better version of half of it does.** `identity Gram`, `apolar-orthonormal` and `$\Delta$`-the-sextic occur nowhere but this block. The *related* material, $C$, $V(K)$, the orbit cone, $\mathcal A(v^6)\in\mathrm{ANN}\iff v^3\in C$, $160$ ascents, $W_0$ a smooth point at tangent dimension $7$, is developed at [report/sections/07-gradedness-split.tex:905–914](../report/sections/07-gradedness-split.tex) and tabled as Obs. 60 at [report/sections/09-status.tex:15](../report/sections/09-status.tex). **The report is the more careful of the two**, keeping the "sixth-power" restriction L91's *"appears to vanish exactly on the orbit cone"* drops.

**L91 is absent from [results.md](../results.md)**, as are [L90](../findings/sym3-blocks.md) and [L92](../findings/sym3-blocks.md), while [L59](../findings/sym3-blocks.md), [L61](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) are present. [INDEX-results.md:106](../findings/INDEX-results.md) carries it as *"Gate 2: no verdict on the record"*, correct before this review.

## 9. Pointers, anchors and the file's own answer

- **Do all pointers resolve? There are none to resolve.** Zero links in the block. Under the checklist's terms this passes vacuously and fails substantively, see §5.
- **Does the file settle it above or below? Yes, three times, and against the block.** [Line 159](../findings/sym3-blocks.md) supplies the quantity L91 omits; [L90](../findings/sym3-blocks.md) at line 149 and [L62](../findings/sym3-blocks.md) at line 227 assert the rank is $13$, making the bound of $1$ stale; and [L90](../findings/sym3-blocks.md)'s submodule bullet at line 156 supplies the point-to-orbit step L91 assumes. **The pattern this file's audits keep finding holds again.**
- **Stale anchors, and the offsets are not uniform.** As the brief warns: [r633](REVIEW_r633.md) anchors this material at lines $133$, $139$ and $141$ against today's $159$, $165$ and $167$, a **consistent $-26$**. But [r634](REVIEW_r634.md) anchors [L91](../findings/sym3-blocks.md) at `#L137` ($-26$) and [L90](../findings/sym3-blocks.md) at `#L115` ($-22$) in one sentence. **So the file has grown unevenly and no single offset repairs it; anchors must be re-derived by heading, not shifted.** Both reviews are stale rather than wrong.

## Owed list

Nothing here changes a number. $1$, $13$, $36$, $14$, $29$, $65$ and $3570$ all stand exactly as written.

1. **State what the $1$ bounds, inside the block.** One clause: *"the rank of $\mu$ on the $36$".*
2. **Restore "invariant" to the third bullet**: $\{F\in(\mathrm{Sym}^6\mathcal W_5)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$.
3. **Cite [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md) for the $36$**, [L85](../findings/sym3-blocks.md) for the $14$, [L59](../findings/sym3-blocks.md) for the $29$/$65$, [L90](../findings/sym3-blocks.md) for the point-to-orbit step.
4. **Say the bound is free**, and reconcile with [L62](../findings/sym3-blocks.md)'s $13$, [r633](REVIEW_r633.md)'s item 8, still unrepaired.
5. **Move the *"Two of the three Casimir collisions"* paragraph** above L91's heading, where it belongs and where it was written.
6. **Add $\Delta$, $\mathrm{Cat}$, $\mathrm{ANN}$, $W_0$ and the apolar normalisation to [conventions.md](../findings/conventions.md)**, and record that $\Delta$ now carries two objects.
7. **Consider replacing the numerical clause with the free identity** $\Delta_K+\Delta_C=\lVert W\rVert^6$, which proves $\Delta\ne0$, bounds $\Delta/\lVert W\rVert^6$ in $[0,1]$, gives $\dim K=4200$, and links the first bullet to the third.

## Standing rule

**Analysis only.** No computation was run for this review, no Gram build, no rank, no sweep. Every number I report is either derived by hand (§1, §2, the dimension checks), read from the record, or read from `git`. The two screen-level remarks, the $4200/7770=0.5405$ plausibility note and the reading of `orbit_cubic_span.py`'s $\rho$, are labelled as such and carry no positive claim. **Nothing in this review required a run**, and no item was blocked for want of one.
