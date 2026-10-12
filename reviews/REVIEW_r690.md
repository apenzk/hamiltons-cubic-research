# Review r690, Lemma L91, the identity Gram on $K$ and the lower bound $1$

**Reviewer B of a pair on identical briefs. Review number 690.** Target: [findings/sym3-blocks.md:163](../findings/sym3-blocks.md#L163), the heading `#### Lemma L91, the identity Gram on $K$ gives the unconditional lower bound $1$`, with its body at lines 165–171.

**Analysis only. No computation was run.** Every figure below is re-derived by hand from the block table at [findings/sym3-blocks.md:22](../findings/sym3-blocks.md#L22) or from a definition in [findings/conventions.md](../findings/conventions.md). Two items are named at the end as needing a run that I did not open.

## Verdict

**GAP.** The mathematics is right (the bound holds, its proof is two lines, and every number the block borrows reproduces by hand) but the block cannot be read as written. **The bound is free**: $\mathrm{rank}\ge1$ says only that the map is nonzero, it needs none of the file's block structure, and it bears on nothing the route is trying to decide. **And two of the three bullets are a superseded stratum**: bullet 2 calls consistency "the open necessary condition" and bullet 3 calls tightness open, while [L90](../findings/sym3-blocks.md#L141) (thirteen lines above L91's heading, in the same file), boxes $F_5\in\mathrm{image}$ and $\mathrm{rank}=13$. The block cites nothing: $36$, $65$, $29$, $14$ and $13$ all arrive bare.

## The readings I adopt, stated

[findings/conventions.md](../findings/conventions.md) tables **none** of this block's symbols, and three of the ones it does table are in collision here. I fix them as follows and use nothing else.

| symbol | reading adopted here | status in [conventions.md](../findings/conventions.md) |
| --- | --- | --- |
| $S$ | $\mathrm{Sym}^3(\mathcal W_5^*)$, the cubic forms on $\mathcal W_5$, $\dim=\binom{37}3=7770$ | absent; the $7770$ is [L83](../findings/sym3-blocks.md#L15)'s |
| $K$ | the cubics in $S$ vanishing on the cone over $O(5)\cdot W_0$, [L59](../findings/sym3-blocks.md#L183)'s "span cut out by the orbit constraint" | **collides**: conventions.md's $K$ is the symmetric hollow sectional matrix $K_{ab}=W_{abab}$ |
| $\mu$ | multiplication $\mathrm{Sym}^2(S)\to\mathrm{Sym}^6(\mathcal W_5^*)$, here **restricted** to invariant forms supported on $K$ | **collides**: conventions.md's $\mu$ is $\operatorname{spec}(M)$ on $\Lambda^2$, and carries a third sense in [bispectral.md](../findings/bispectral.md) |
| $B$ | a Gram, in [L59](../findings/sym3-blocks.md#L183)'s display $\langle F,\mu(B)\rangle$ | **collides**: conventions.md's $B$ is the Killing form, and separately $\tfrac\theta2\mathrm{Id}-L_W$; the file itself uses a third $B$ at [line 12](../findings/sym3-blocks.md#L12) |
| $\Delta$ | the sextic $\sum_a q_a^2$ of this block | **collides, and the brief did not list this one**: conventions.md tables $\Delta$ as *the symmetry defect* of [diagonal-half.md](../findings/diagonal-half.md) |
| $\mathrm{Cat}_F$ | the middle catalecticant of a sextic $F$, $\mathrm{Cat}_F(q,q')=\langle F,qq'\rangle$ under the apolar pairing | **absent from [findings/](../findings/) entirely**, as [r651](REVIEW_r651.md)/[r652](REVIEW_r652.md) already recorded on [L59](../findings/sym3-blocks.md#L183) |
| $\mathrm{ANN}$ | $\{F\in(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$, the annihilator of the image inside [L85](../findings/sym3-blocks.md#L68)'s $14$ | **absent**, and spelled two ways in this file ($\mathrm{ANN}$ at [line 150](../findings/sym3-blocks.md#L150), $\mathrm{ann}$ at [line 227](../findings/sym3-blocks.md#L227)) |
| $W_0$ | the padded $W_{\mathbb{CP}^2}$ in $\mathcal W_5$, unit norm | **absent** |
| the pairing | the apolar (Bombieri) form on $S$, $O(5)$-invariant and **positive definite over $\mathbb R$** | absent; [L59](../findings/sym3-blocks.md#L183)'s audit already found "the pairing is never named, and that is the defect" |

One reading is genuinely forced and I flag it because the block leaves it open. **"The identity Gram" must mean the identity in a *real orthonormal* basis, i.e. the invariant inner product itself, not the identity matrix in the $\mathbb Q(i)$ highest-weight basis**, [L88](../findings/sym3-blocks.md#L104)'s audit establishes that the basis in hand is *not* real for the real structure. The conclusion survives either reading (under the Hermitian one, $\mu$ of the identity is $\sum_a\lvert q_a\rvert^2=\sum_a(\operatorname{Re}q_a)^2+(\operatorname{Im}q_a)^2$, still a nonzero psd SOS), so nothing downstream moves; but the phrase is ambiguous in exactly the place [L88](../findings/sym3-blocks.md#L104) says the record has already been bitten.

## 1. The derivation, cold, what is bounded, and by what

**The quantity bounded below by $1$ is $r:=\mathrm{rank}(\mu_K)$**, where $\mu_K$ is multiplication read as a linear map

$$\mu_K:\ \mathcal G:=\mathrm{Sym}^2(K)^{O(5)}\ \longrightarrow\ (\mathrm{Sym}^6\mathcal W_5^*)^{O(5)},\qquad \dim\mathcal G=36,\quad \dim(\text{target})=14 .$$

The block never says this. It says "lower bound $1$" and lets the reader take the antecedent from [L90](../findings/sym3-blocks.md#L159)'s "the rank is open in $[1,13]$" four lines above the heading. That antecedent is *outside the block*, and it is the sentence I show below to be stale, so the block's own subject is defined only by a stale neighbour.

**The proof, in full.**

1. The apolar form on $S$ is $O(5)$-invariant and positive definite over $\mathbb R$. Restricted to the submodule $K$ it is an invariant positive-definite quadratic form $g_K$, hence $g_K\in\mathcal G$.
2. Pick $q_1,\dots,q_N$ an apolar-orthonormal basis of $K$. **Such a basis always exists**: positive definiteness alone gives Gram–Schmidt, and no invariance of the basis is asked for. In this reading $N=\dim K=7770-3570=4200$.
3. $\mu_K(g_K)=\sum_{a}q_a^2=:\Delta$.
4. $\Delta\ne0$: each $q_a$ is a nonzero polynomial, so at any $W$ with $q_1(W)\ne0$ one has $\Delta(W)\ge q_1(W)^2>0$, and such a $W$ exists.
5. Hence $\mu_K\ne0$, so $r\ge1$. $\square$

**"Unconditionally" is earned, and earned more cheaply than the block claims.** The hypotheses are exactly two: $K\ne0$, and the ground field is $\mathbb R$ (step 4 is where a sum of squares can fail to vanish, and over $\mathbb C$ it would fail). Neither the $36$, nor [L86](../findings/sym3-blocks.md#L82)'s parity rule, nor [L87](../findings/sym3-blocks.md#L100)'s rank-one step is used: $K$ is cut out by at most $41$ linear conditions on a $7770$-dimensional space, so $K\ne0$ needs no block table at all. **The block invokes the $36$ in the very sentence that proves a statement independent of it.**

**Two hedges checked.** *"Psd"*: yes, $\Delta$ is a sum of real squares. *"Vanishing on the orbit"*: yes, but the step is not free under every reading of $K$. Under [L59](../findings/sym3-blocks.md#L183)'s definition ("cut out by the orbit constraint") it is definitional; under [L86](../findings/sym3-blocks.md#L84)'s ("the single condition $\sigma_\lambda(W_0)=0$") it needs the submodule argument, $K$ is an $O(5)$-submodule, so vanishing at $W_0$ propagates to every $gW_0$. **That argument exists on the record and is uncited here**: it is [L90](../findings/sym3-blocks.md#L155)'s second bullet, reviewer 210's. The conclusion is unaffected; the block simply owes the pointer.

**And the numerical witness in bullet 1 is unnecessary.** *"Nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)"* is a measurement standing where step 4 above is a one-line proof. On a programme whose standing rule is that a derivation beats a run, a free analytic fact is being supported by numerics.

## 2. Is the bound free? Yes, and "unconditional" is doing rhetorical work

**The bound is free.** $r\ge1$ is precisely the statement "$\mu_K\ne0$", and $\mu_K$ cannot be zero, for a reason with no content in it: $\mathbb R[\mathcal W_5]$ is an integral domain, so $\mu(q\otimes q)=q^2\ne0$ for any $0\ne q\in K$; averaging over $O(5)$ to land inside $\mathcal G$ is the only work, and $g_K$ does it. **The bound excludes exactly one case, $r=0$, and $r=0$ would say that every invariant sum of squares built from $K$ is the zero sextic.** Nothing on the route was ever at risk from that.

**It also decides nothing the route asks.** The route needs $F_5\in\mathrm{im}(\mu_K)$, one specified direction out of $14$. A lower bound on $r$ constrains that only at $r=14$, which is excluded by [L62](../findings/sym3-blocks.md#L227)'s cap $r\le13$. So over its whole live range $1\le r\le13$ the bound is **information-free with respect to consistency**, which is the only question the block's own second bullet says is open. This is the same shape as the companion result the brief names.

**Where the rhetoric enters.** The bullet's own coda, *"this replaces an earlier '$F_5$ lies in the image', which assumed what the route exists to establish"*, is true as history (see §5), and it is what makes "unconditionally" load-bearing in the *presentational* sense: a refuted strong claim is retracted and a free true claim is put in its slot with an emphatic modifier, so the paragraph reads as a repair. **It is a loss, not a repair.** $F_5\in\mathrm{image}$ and $r\ge1$ are not two grades of the same statement; the first is the route's necessary condition and the second is the assertion that a nonzero map is nonzero. The honest form of the bullet is: *the earlier claim is withdrawn; what survives unconditionally is only that $\mu_K\ne0$, which does not bear on it.*

**One thing here is not free, and the block half-notices it.** $\Delta$ itself (an explicit invariant psd sextic vanishing on the orbit cone), is a usable object, and the *"live lead"* paragraph is the block's best content. The bound is free; the witness is not.

## 3. Bullet 2 is right, and it is stale, the file settles it above the block

**The caveat is correct as stated.** $\{G\in\mathcal G:\mu_K(G)=F_5\}$ is the solution set of an inhomogeneous linear system; it is empty, or an affine translate of $\ker\mu_K$ of dimension $36-r$. Consistency is literally $F_5\in\mathrm{im}(\mu_K)$, so *"consistency is exactly the ... condition: $F_5$ must lie in the image"* is a restatement of the definition rather than a theorem, true, and trivially so. **Stating it is to the block's credit** and I confirm it.

**A second caveat rides underneath and is not stated.** Even when consistent, $36-r$ is the dimension of the **linear** solution set, not of the set of certificates: a certificate needs $G\succeq0$, and the psd points form a convex subset that can be empty or lower-dimensional. The block writes *"the dimension of the solution set"* unqualified. [L59](../findings/sym3-blocks.md#L193)'s audit made the identical point in its own words, *"PSD-ness is dropped entirely, and the certificate still owes a PSD point in the $23$-dimensional family"*, and the record even carries [run_n5_psd.py](../scripts/runs/run_n5_psd.py), whose docstring is *"Is there a PSD point in the 23-dimensional affine family?"*. So the block understates its own caveat by one clause.

**Does anything on the record use $36-\mathrm{rank}$ without the caveat?** I checked every occurrence. **No.** There are five: [findings/sym3-blocks.md:151](../findings/sym3-blocks.md#L151) (*"the affine family is $36-13=23$ dimensional"*), which sits in the same display that establishes $F_5\in\mathrm{image}$ and is therefore licensed; and four in scripts, [run_n5_psd.py](../scripts/runs/run_n5_psd.py) plus three reviewer files ([dump_state.py](../scripts/reviewers/r210/dump_state.py), [r213_assemble_80.py](../scripts/reviewers/r213/r213_assemble_80.py), [assemble_r214_freshpoint.py](../scripts/reviewers/r214/assemble_r214_freshpoint.py)), each carrying the caveat verbatim as a comment. **The neighbouring failure the brief warns of does not recur here.** This is the one place where the block's discipline has propagated cleanly.

**But the bullet is stale.** *"Consistency is exactly the **open** necessary condition"* was true when written; it is not true of the file it now sits in. [L90](../findings/sym3-blocks.md#L150) prints, thirteen lines above L91's heading,

$$\mathrm{rank}=13,\qquad\dim\mathrm{ANN}=1,\qquad\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6),\qquad\boxed{F_5\ \text{lies in the image}}$$

under the heading *"THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM"*. Bullet 3's *"tightness is open"* is stale by the same sentence. And [L90](../findings/sym3-blocks.md#L159)'s own *"the rank is open in $[1,13]$"*, four lines above L91's heading, contradicts [L90](../findings/sym3-blocks.md#L150)'s display **inside one block**.

**This is already on the record from the other side.** [L62](../findings/sym3-blocks.md#L239)'s audit records: *"THE FILE CONTRADICTS THIS BLOCK, FIFTY-FOUR LINES ABOVE, where the rank is called 'open in $[1,13]$' and 'tightness is open', three unreconciled strata, of which the block quotes only the newest."* Those two quoted phrases are [line 159](../findings/sym3-blocks.md#L159) and **L91's own bullet 3**. So L91 is one of the strata that audit named, and this review confirms it from L91's side: **bullets 2 and 3 are the oldest of the three strata, and they are the ones carrying a `Lemma` number.**

## 4. Where the $36$ comes from, assumed, and uncited, along with $65$, $29$, $14$ and $13$

**The $36$ is [L86](../findings/sym3-blocks.md#L82)'s**, promoted from a lower bound to an exact count by [L87](../findings/sym3-blocks.md#L100). **L91 neither derives nor imports it, it assumes it**, using the bare figure twice (*"one of the $36$ invariant forms"*, *"a search over the $36$"*). **The block contains no markdown link at all.** Every number in it is borrowed:

| figure | owner | cited in L91 |
| --- | --- | --- |
| $36$ | [L86](../findings/sym3-blocks.md#L82) / [L87](../findings/sym3-blocks.md#L100) | no |
| $14$ | [L85](../findings/sym3-blocks.md#L68) | no |
| $65$ | [L88](../findings/sym3-blocks.md#L104) | no |
| $29$ | [L59](../findings/sym3-blocks.md#L183)'s $65-36$, stated **70 lines below** L91 | no |
| $13$ | [L62](../findings/sym3-blocks.md#L227) / [L90](../findings/sym3-blocks.md#L150) | no |
| $\mathrm{rank}=14-\dim\mathrm{ANN}$ | [L59](../findings/sym3-blocks.md#L183), verbatim in content | no |

**The $29$ is the worst of these.** A reader taking the file in order meets it in bullet 3 with no antecedent whatever: it is not defined, not derived, and its definition sits in a later block. This is the pattern the brief names (four numbered results consumed uncited in this file), recurring at a sixth site.

**Every borrowed figure is nevertheless correct, and I rebuilt each by hand** from [L83](../findings/sym3-blocks.md#L22)'s table, so the defect is citation rather than arithmetic:

- **$3570$** $=\sum d_\lambda$ over the sixteen $\lambda_2$-even blocks: $220+35+105+390+165+55+30+14+455+810+625+140+429+91+5+1=3570$. Hence $\dim K=7770-3570=4200$, and $\Delta$ is a sum of $4200$ squares.
- **$65=20+6+27+12$**, $\sum\binom{m+1}2$ over multiplicities $4,4\,\vert\,3\,\vert\,2^{\times9}\,\vert\,1^{\times12}$.
- **$25$ surviving multiplicities** and **$36$ unknowns**: even blocks drop by one, giving $3,3\,\vert\,2\,\vert\,(1,2,1,2,2,1,2,1,1)\,\vert\,1^{\times4}$, summing to $8+13+4=25$, with $\sum\binom{m'+1}2=15+17+4=36$; shape **two $3\times3$, five $2\times2$, nine scalars**, all as [L86](../findings/sym3-blocks.md#L84) states.
- **$29=65-36$**, and [L59](../findings/sym3-blocks.md#L183)'s block-by-block count $8+3+10+8=29$ agrees.
- **$14+29-65=-22<0$**, the arithmetic of bullet 3's dimension count.

**Bullet 3's formula is correct.** Apolarity gives $\langle F,\mu(G)\rangle=\mathrm{Cat}_F(G)$, so $F$ annihilates $\mathrm{im}(\mu_K)$ iff $\mathrm{Cat}_F(K,K)=0$, whence $r=14-\dim\mathrm{ANN}$. $\mathcal A(W_0^6)\in\mathrm{ANN}$, since $\langle\mathcal A(W_0^6),qq'\rangle$ averages $(qq')(gW_0)=0$; and it is nonzero because it pairs to $\lVert W_0\rVert^6=1$ against $\lVert W\rVert^6$. So $\dim\mathrm{ANN}\ge1$ and $r\le13$, independently reproducing [L62](../findings/sym3-blocks.md#L227)'s cap. **One qualification on the heuristic**: $\mathrm{Cat}$ embeds the $14$ in the $65$ and the forms killing $K\times K$ number $29$, so a *generic* intersection would be empty at $14+29-65=-22$, but both subspaces are $O(5)$-canonical, so there is no genericity to appeal to, and the intersection is already known to be nonzero. The bullet's own *"unless a second coincidence occurs"* concedes this correctly; the count is a heuristic and is labelled as one.

## 5. The consistency condition, settled, on a measured quantity

**It is settled on the record, twice, and neither settlement is unconditional.**

**Route one, [L62](../findings/sym3-blocks.md#L227) and [L90](../findings/sym3-blocks.md#L150).** $F_5\in\mathrm{image}\iff F_5\perp\mathrm{ANN}$ is [L59](../findings/sym3-blocks.md#L183)'s adjunction, confirmed by [r651](REVIEW_r651.md)/[r652](REVIEW_r652.md). The cap $r\le13$ is a six-line theorem. **The other half is a sampled mod-$p$ rank.** [L62](../findings/sym3-blocks.md#L239)'s audit states it flatly: *"$\operatorname{rank}\ge13$, $\dim\mathrm{ANN}=1$ and $F_5\in\operatorname{image}$ are all measured. The proved half alone yields only $F_5\perp\mathcal A(W_0^6)$, which restates $F_5(W_0)=0$ and is content-free."* **So yes: the route's life rests on a measured quantity, and I say so plainly.** It rests on it doubly, [L87](../findings/sym3-blocks.md#L100)'s $3570$, which makes the $36$ exact and hence fixes the domain of $\mu_K$, is also a mod-$p$ Gram rank. And [L90](../findings/sym3-blocks.md#L157) warns in its own third bullet that *"a defect landing the rank exactly on the cap is invisible"*, which is the configuration both measurements are in.

**Route two, the exhibited certificate.** [findings/sym3-blocks.md:130](../findings/sym3-blocks.md#L130) records an exact rational psd Gram mapping to $F_5$. If it stands, $F_5\in\mathrm{image}$ by construction and consistency is closed outright. **It carries its own caveat**: [L61](../findings/sym3-blocks.md#L208)'s audit found it *"an SDP point lifted to $\mathbb Q$ … exact, and unverifiable by hand even in principle"*, and found the recorded *"denominator $10^5$"* false. So route two replaces a measurement with a machine certificate.

**Either way, "or the route dies" is a live clause about a dead question.** The route did not die; the record says so above the block. The clause should read as history.

## 6. Provenance, clean, and the first clean one I can find in this file today

Checked with `git log -S` on the block's distinguishing strings.

- **The content originates at `ec35c0b9` (`fix(n5): apply Gate 2 r203/r204`, 2026-08-28), and the commit body states the block's provenance clause verbatim**: *"rank >= 1 is now unconditional via Delta = sum_a q_a^2, replacing the retracted 'F_5 lies in the image'"* and *"'family = 36 - rank' holds only if the system is consistent, which is the open condition."* **The block's italic note is a true report of a real event.** This is the opposite of [L84](../findings/sym3-blocks.md#L44)'s manufactured $\rho$ clause: here the history matches on every strand I checked.
- **The heading was placed later, at `8d869d2c` (`docs(sym3-blocks): place headings for Lemmas 83-92`, 2026-09-02), whose body promises *"headings only: no statement, proof or ordering is altered"*.** The promise holds literally, and it is why the block boundary is wrong (§7).
- **The staleness has a date and a commit.** `d7fd5fce` (`docs(findings): the restricted rank is 13, so F_5 lies in the image -- proved`, 2026-08-29) inserted [L90](../findings/sym3-blocks.md#L150)'s resolution **above** the older text without retracting it; the diff shows the new paragraph landing immediately before the surviving *"the rank is open in $[1,13]$"*. **So the contradiction was created by an insertion that never looked down.** L91's bullets were already two days old at that point and were never revisited.

## 7. Duplication and the block boundary

**Two of the four kinds are present.**

- **Same claim under two numbers.** Bullet 3's $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$ **is** [L59](../findings/sym3-blocks.md#L183)'s displayed $\mathrm{rank}=14-\dim\mathrm{ANN}$, and [L59](../findings/sym3-blocks.md#L183)'s $65=36+29$ is bullet 3's dimension count. L59 sits $70$ lines below L91 in the same file and reached [results.md:202](../results.md#L202); L91's copy reached nothing.
- **Content under the wrong heading, the pattern the brief names.** The paragraph *"Two of the three Casimir collisions vanish with them"* at [line 171](../findings/sym3-blocks.md#L171) falls inside L91's block and has nothing to do with the identity Gram. It is [L86](../findings/sym3-blocks.md#L82)/[L87](../findings/sym3-blocks.md#L100)'s content, and [L87](../findings/sym3-blocks.md#L102) already asserts it (*"the eight block deaths, with the two collisions that vanish with them, stand unconditionally"*). **It is also [L92](../findings/sym3-blocks.md#L173)'s antecedent**: L92 opens *"And the highest-weight route never meets even that one"*, and *"that one"* is the surviving $c=30$ pair, named only inside L91's block. So the heading placement severs a sentence from its referent.

**The stranded paragraph is itself correct**, and I checked it by hand rather than assume it. $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ gives $(4,1)\mapsto30$, $(3,3)\mapsto30$, $(4,3)\mapsto40$, $(5,0)\mapsto40$, $(5,4)\mapsto60$, $(6,2)\mapsto60$. Under [L86](../findings/sym3-blocks.md#L82)'s parity rule: $(5,4)$ and $(6,2)$ have $\lambda_2$ even at multiplicity $1$, so both die; $(5,0)$ dies and $(4,3)$ ($\lambda_2=3$) survives; $(4,1)$ and $(3,3)$ both have $\lambda_2$ odd and both survive. **Only $c=30$ survives, exactly as printed.** The defect is location, not content.

**Does the block's own file settle its subject above or below?** Yes, above: [L90](../findings/sym3-blocks.md#L150), thirteen lines up. And below: [L59](../findings/sym3-blocks.md#L183) and [L62](../findings/sym3-blocks.md#L227). **All three answers are in the same file, which is the seventeenth time on this programme.**

## 8. Pointers

**The block contains no pointer at all** (no link, no `[L86]`, nothing) so no pointer resolves falsely and none resolves. **I found no off-by-a-fixed-offset anchor**, and I record the true line numbers as of this reading: heading at [163](../findings/sym3-blocks.md#L163), bullets at [165–167](../findings/sym3-blocks.md#L165), the $\Delta$ paragraph at [169](../findings/sym3-blocks.md#L169), the stranded collisions paragraph at [171](../findings/sym3-blocks.md#L171).

Two neighbouring pointers do bear on this block and both are already recorded as defective by other audits: [L61](../findings/sym3-blocks.md#L208)'s and [L62](../findings/sym3-blocks.md#L227)'s section notes, on which [r633](REVIEW_r633.md) and [r634](REVIEW_r634.md) split over what a `##` section contains. **That ambiguity does not bite L91**, which names no section.

## 9. The one claim I cannot decide, and what a run would settle

**Δ's zero set.** The block says $\Delta$ *"appears to vanish exactly on the orbit cone, the zero set $F_5$ is conjectured to have"*, and reports $F_5/\Delta\in[2.50,3.15]$ over twelve random unit points. Analytically I can settle only the inclusion: $Z(\Delta)=\bigcap_a\{q_a=0\}$ is the common zero locus of $K$, which **contains** the orbit cone and equals it only if the ideal of the orbit cone is generated in degree $3$. Nothing on the record establishes that. Note also that $\Delta$ is even, the $q_a$ being odd, so $Z(\Delta)$ contains the $-W_0$ orbit, the same point [L61](../findings/sym3-blocks.md#L208)'s audit makes about $F_5$'s zero set, and consistent rather than contradictory here.

**What a run would decide, which I did not open.** *(i)* Whether $Z(\Delta)$ exceeds the orbit cone, a single point off the cone with all $4200$ generators vanishing would settle it negatively and would kill the *"vanishes exactly"* clause; finding none over a sweep would leave it conjectural, as now. *(ii)* Whether $\inf F_5/\Delta$ over the sphere is attained and positive, twelve points support no interval, and the recentring $F_5-\lambda\Delta$ at $\lambda\approx2.5$ that the block proposes as a search direction is only as good as that infimum. **Neither is needed for the verdict above**, and both are on the analysis-only footing's blocked list.

## Summary of what is owed

1. **Say what is bounded.** The block's subject ($\mathrm{rank}(\mu_K)$), is never named inside it.
2. **Say the bound is free.** $r\ge1$ is "$\mu_K\ne0$", it needs only $K\ne0$ and $\mathbb R$, and it is information-free over the whole live range $[1,13]$ with respect to consistency, which is the question the block itself says is at stake.
3. **Retract bullets 2 and 3, or date them.** [L90](../findings/sym3-blocks.md#L150) settles both thirteen lines above the heading; [L62](../findings/sym3-blocks.md#L239)'s audit already named them as the oldest of three unreconciled strata.
4. **Cite the numbers**: $36$ to [L86](../findings/sym3-blocks.md#L82)/[L87](../findings/sym3-blocks.md#L100), $14$ to [L85](../findings/sym3-blocks.md#L68), $65$ to [L88](../findings/sym3-blocks.md#L104), $29$ and the rank formula to [L59](../findings/sym3-blocks.md#L183), $13$ to [L62](../findings/sym3-blocks.md#L227). All five are correct; none is attributed.
5. **Move the collisions paragraph** out from under L91's heading to [L87](../findings/sym3-blocks.md#L100), and give [L92](../findings/sym3-blocks.md#L173) back its antecedent.
6. **Add the psd clause** to bullet 2: $36-r$ is the dimension of the *linear* solution set, and a certificate still owes a psd point in it.
7. **Replace the numerical nonvanishing witness** with step 4 of §1, which is one line.
8. **Table $\mathrm{Cat}$, $\mathrm{ANN}$, $W_0$ and the apolar pairing** in [conventions.md](../findings/conventions.md), and record $\Delta$'s collision with the symmetry defect there.

**Nothing above changes a number.** $r\ge1$ is true, $\Delta$ is what the block says it is, and every figure the block borrows reproduces by hand.
