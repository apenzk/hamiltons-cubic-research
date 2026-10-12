# Review r634, Lemma L62, $\dim\mathrm{ann}=1$ and the rank $13$

*Reviewer r634, independent adversarial audit of [Lemma L62](../findings/sym3-blocks.md#L187) in [sym3-blocks.md](../findings/sym3-blocks.md). **Analysis only.** The machine was used only to read files the record already contains, the findings and results text, `git log`/`git show` on the pointer note, and three run logs to count the primes the record actually names. No rank was computed, no matrix was built, no sampling was done, and nothing below is offered as reproduction of the block's evidence. Written without reading the other reviewer's report on this brief.*

## Overall verdict, GAP. The upper bound is a theorem, the lower bound is a measurement, and the block is one statement where the record needs two

The two halves of the squeeze have genuinely different statuses, and the block's single `Lemma` label prices both at the higher one.

| the claim | status |
| --- | --- |
| $\mathrm{rank}\le13$, equivalently $\dim\mathrm{ANN}\ge1$ | **CONFIRMED, and it is a three-line theorem.** I rebuilt it cold from the definitions; it needs no computation and no certificate, only that $\lVert W\rVert^6$ is an invariant sextic |
| $\mathrm{rank}\ge13$, which is what pins the number | **a measurement.** An exact mod-$p$ rank of a sampled matrix, at primes the record names three of while the block claims four, and conditional on an equivariant identification that a machine test guards |
| $\dim\mathrm{ANN}=1$ *is* $\mathrm{rank}=13$ | **CONFIRMED, but by a corank identity and not the one the question presumes**, $\mathrm{ANN}$ is the annihilator of the image inside the $14$, not the kernel of the map whose rank is counted |
| the pointer to *"$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate"* | **RESOLVES**, unlike the identical pointer on [Lemma L61](../findings/sym3-blocks.md#L168), and for a reason worth recording |

**The finding the record most needs is the split**, and it is neither a confirmation nor a refutation: `Lemma` for $\mathrm{rank}\le13$, `Observation` for $\mathrm{rank}=13$. Text for both is in §6.

**And the block is contradicted from inside its own proof's section.** [Line 133](../findings/sym3-blocks.md#L133) of the same file says *"the rank is open in $[1,13]$"* and [line 141](../findings/sym3-blocks.md#L141) says *"Tightness is open"*, twelve and twenty lines below [line 121](../findings/sym3-blocks.md#L121)'s *"THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM"*. Three layers sit unreconciled in one section, and L62 was written from the newest of them.

---

## 1. The reading I adopt, and where the four objects are defined

[conventions.md](../findings/conventions.md) defines **none** of $\mathrm{ann}$, $K$, $W_0$ or *"the $14$"*, which is a breach of that file's own opening rule that a convention a block needs is added there and quoted. All four live in [sym3-blocks.md](../findings/sym3-blocks.md) alone:

| object | where | what I take it to be |
| --- | --- | --- |
| *"the $14$"* | [Lemma L85](../findings/sym3-blocks.md#L42) and [The constraint count](../findings/sym3-blocks.md#L44) | $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, of dimension $14$ by Weyl integration in exact Laurent polynomials |
| $W_0$ | [The orbit constraint](../findings/sym3-blocks.md#L58) | the zero-padding of $W_{\mathbb{CP}^2}$ into $\mathcal W_5$, unit norm, $\mathrm{Stab}_{O(5)}(W_0)$ with identity component $U(2)$ |
| $K$ | [Lemma L59](../findings/sym3-blocks.md#L157) and [The orbit constraint](../findings/sym3-blocks.md#L58) | the $O(5)$-submodule of cubic forms on $\mathcal W_5$ cut out by $\sigma_\lambda(W_0)=0$, the cubics vanishing at $W_0$, equivalently on its whole orbit |
| $\mathrm{ANN}$ | [Lemma L59](../findings/sym3-blocks.md#L157) | $\{F\in(\mathrm{Sym}^6\mathcal W_5)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$ |

The heading writes $\mathrm{ann}$ and the body writes $\mathrm{ANN}$; only the second is defined anywhere. I read them as one object.

**The space "the rank" is taken of, which the block never names.** It is the multiplication map restricted to the invariant quadratic forms supported on $K$,

$$\mu_K:\ \mathrm{Sym}^2(K)^{O(5)}\ \longrightarrow\ (\mathrm{Sym}^6\mathcal W_5)^{O(5)},\qquad 36\longrightarrow14 .$$

Naming it matters more here than usual, because [Lemma L89](../findings/sym3-blocks.md#L92), ninety-five lines above, proves $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ for the *unrestricted* map on the $65$. A reader meeting *"so the rank is $13$"* with no qualifier has two theorems in one file assigning two values to a bare noun. [results.md](../results.md) does better, saying *"in the setting of Lemma L59"* and *"the restricted catalecticant rank"*; the block should carry the same words.

**Arithmetic check on the ambient numbers, done by hand and closing.** The measured multiplicities are twelve blocks at $m=1$, nine at $m=2$, one at $m=3$, two at $m=4$. Then $\sum m=41$ matches the $41$ highest-weight vectors; $\sum m(m+1)/2=12+27+6+20=65$; $\sum m(m-1)/2=9+3+12=24$; $\sum m^2=89=65+24$. Sixteen even-$\lambda_2$ blocks each lose one multiplicity, leaving $25=2\cdot3+5\cdot2+9\cdot1$ and $36=2\cdot6+5\cdot3+9\cdot1$ unknowns. The complement $29=65-36$ is then forced to be $\sum_{\lambda_2\ \mathrm{even}}m_\lambda$, which is what [Lemma L59](../findings/sym3-blocks.md#L157)'s *"an even one keeps $u\otimes v+v\otimes u$"* means once $v$ is allowed to range: the forms vanishing on a hyperplane $H=\ker\varphi$ of $\mathbb R^m$ are exactly $\varphi\odot\psi$, an $m$-dimensional space. Every number L62 stands on is internally consistent.

## 2. The upper bound, derived cold, it is a theorem, and a short one

Write $\mathrm{ev}_{W_0}$ for evaluation at $W_0$, restricted to the $14$.

**(i) $\mathrm{ev}_{W_0}$ is a nonzero functional on the $14$.** $\lVert W\rVert^6$ is an $O(5)$-invariant sextic on $\mathcal W_5$, so it lies in the $14$, and $\lVert W_0\rVert^6=1\ne0$. That is the whole of it. The block asserts the clause without this one-line reason, and the reason is worth a sentence because it is the only place $W_0\ne0$ enters.

**(ii) The image of $\mu_K$ lies in $\ker\mathrm{ev}_{W_0}$.** An element of $\mathrm{Sym}^2(K)$ is $B=\sum_{a,b}c_{ab}\,q_a\odot q_b$ with every $q_a\in K$, so $\mu(B)=\sum_{a,b}c_{ab}q_aq_b$ and $\mu(B)(W_0)=\sum_{a,b}c_{ab}q_a(W_0)q_b(W_0)=0$, each factor vanishing because $K$ consists of cubics vanishing at $W_0$. This is the block's *"a product of two cubics of $K$ vanishes at $W_0$"*, and it is correct as stated.

**(iii) Hence $\mathrm{rank}\,\mu_K\le\dim\ker\mathrm{ev}_{W_0}=14-1=13$.**

This is where *"why $13$ rather than merely $14$"* is answered: the target is $14$-dimensional and (i) says $\mathrm{ev}_{W_0}$ cuts a genuine hyperplane out of it rather than being the zero functional, which would cut nothing. The cap is the codimension of the hyperplane, and it is $1$ because a single point imposes a single linear condition on sextics.

**"Order-$1$ vanishing" is the right name and the block's gloss on it is right too.** Order $1$ means the single condition $F(W_0)=0$, with no derivative conditions. [The bullet at line 135](../findings/sym3-blocks.md#L135) adds that order-$2$ vanishing buys nothing further, the extra conditions being free on the invariants, that is a claim about sharpening, not about the cap, and the cap needs only order $1$. Nothing in the derivation above uses more.

**Dually, $\dim\mathrm{ANN}\ge1$, and the spanning vector is the one the block names.** Under the apolar pairing, the Riesz representative of $\mathrm{ev}_{W_0}$ on the $14$ is the $O(5)$-average $\mathcal A(W_0^6)$, and $\mathrm{Cat}_{\mathcal A(W_0^6)}(q,q')=c\int_{O(5)}q(gW_0)q'(gW_0)\,dg$, which vanishes for $q,q'\in K$ because $K$ is an $O(5)$-submodule and so its members vanish on the whole orbit, not merely at $W_0$. **That submodule step is a real hypothesis of the dual form of the argument**, and the record has it, [line 130](../findings/sym3-blocks.md#L130), reviewer 210, but L62 does not cite it. The primal form in (i)–(iii) avoids needing it, which is a reason to state the bound primally.

**Verdict on the upper bound: CONFIRMED, unconditionally, with no computation.**

## 3. $\dim\mathrm{ann}=1$ against $\mathrm{rank}=13$, the same claim, by a corank identity

They are the same claim, but not for the reason the question supposes. $\mathrm{ANN}$ is **not** the kernel of $\mu_K$: that kernel is $36-13=23$-dimensional and is the linear part of the affine family. $\mathrm{ANN}$ lives in the **target**, and the identification is

$$\mathrm{ANN}=\big(\mathrm{image}\,\mu_K\big)^{\perp}\cap\text{the }14,\qquad\text{so}\qquad \mathrm{rank}\,\mu_K=14-\dim\mathrm{ANN}.$$

It needs exactly two inputs, both on the record. First, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ ([Lemma L85](../findings/sym3-blocks.md#L42)). Second, the apolarity adjunction $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ ([Lemma L59](../findings/sym3-blocks.md#L157)), which turns $F\perp\mathrm{image}\,\mu_K$ into $\mathrm{Cat}_F(K,K)=0$, together with the nondegeneracy of the apolar pairing on the $14$, the same fact L59 uses as *"$\mathrm{Cat}$ is injective on the invariant sextics"*.

So heading and body agree. **The identification is sound and it should be one clause in the block**, since as written the heading states a corank and the body proves a rank with nothing linking them.

## 4. The lower-bound direction, both inequalities run the right way

I checked this specifically, the brief warning that a neighbouring audit found a bound stated backwards. It is **not** stated backwards here.

- *"A sampled rank is bounded above by the true one."* Correct. The sampled matrix is $\mathrm{ev}\circ\mu_K$ for a finite point list, and it factors through $\mathrm{image}\,\mu_K$, so its rank is at most $\mathrm{rank}\,\mu_K$. Equality is unisolvence, which [Lemma L89](../findings/sym3-blocks.md#L92)'s own caveat says no theorem supplies.
- *"Reducing modulo $p$ can only lower it further."* Correct. A nonzero $r\times r$ minor mod $p$ lifts to a nonzero minor over $\mathbb Z$, so $\mathrm{rank}_{\mathbb F_p}(\bar A)\le\mathrm{rank}_{\mathbb Q}(A)$; the converse fails, which is the asymmetry the sentence is using. It needs the entries $p$-integral, which the pipeline asserts.
- Chaining: $13=\mathrm{rank}_{\mathbb F_p}(\bar A)\le\mathrm{rank}_{\mathbb Q}(A)\le\mathrm{rank}\,\mu_K\le13$, so all four are equal. The logic is valid and the direction is right.

**Three conditions ride on it, all of them in the file and none of them in the block.**

1. **The chain's first inequality is conditional on the equivariant identification.** [Line 129](../findings/sym3-blocks.md#L129) records reviewer 209's $S_3$ counterexample on $\mathbb R^3$, where a non-equivariant copy identification gives a *sampled* rank of $10$ against a cap of $7$. Without the identification the sampled rank can exceed the cap, and then attainment proves nothing. What guards it is a machine test (the multi-probe Schur agreement) which the file itself says is load-bearing and was never described as such.
2. **Attainment on the cap is exactly the configuration in which a defect is invisible.** [Line 131](../findings/sym3-blocks.md#L131) says so in the file's own words, and adds that the three wrong restrictions this stage went through were caught only by coming out *above* the cap. A wrong restriction landing at $13$ passes silently. That is a statement about this argument's shape, not about someone else's.
3. **The primes.** The block says the rank *"attains it, at four primes"*, and [results.md](../results.md#L206) repeats *"at four primes"*. [sym3-blocks.md](../findings/sym3-blocks.md#L121) names two ($1000033$ for the main run and $1000003$ for reviewer 209) and reading the run logs adds a third, $1099511627953$, in [assemble_p4.log](../scripts/reviewers/r211/assemble_p4.log) and [r213_assemble80.log](../agent_logs/r213_assemble80.log). **Three, not four.** The one place *"four primes"* is grounded in the file is the certificate table at [line 110](../findings/sym3-blocks.md#L110), where four primes near $2^{40}$ are the CRT moduli for lifting the certificate **rows**, a different computation with a different purpose. This reads as a conflation. The fourth prime may exist off the record, but a reader cannot find it, and the same *"four primes"* is also asserted inside [Lemma L90](../findings/sym3-blocks.md#L117), so the error, if it is one, has two carriers.

## 5. The file already carries the counter-statement, twice

The checklist item that has paid sixteen times pays again. Inside the very section L62 points at:

| line | text | against |
| --- | --- | --- |
| [121](../findings/sym3-blocks.md#L121), [123](../findings/sym3-blocks.md#L123) | *"THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM"*, then $\mathrm{rank}=13$, $\dim\mathrm{ANN}=1$, $\boxed{F_5\ \text{lies in the image}}$ |, |
| [133](../findings/sym3-blocks.md#L133) | *"On the restricted space the argument does not carry, and the rank is open in $[1,13]$."* | contradicts 121 outright |
| [141](../findings/sym3-blocks.md#L141) | *"Tightness is open, reduced to one question … So $13$ holds unless a second coincidence occurs."* | contradicts 121, and concedes the lower bound is unproved |

These are three strata of one section left in place as the result moved, and L62 quotes only the newest. Whatever the label ends up being, **lines 133 and 141 have to be repaired or deleted in the same edit**, or the block's proof section says its conclusion is open.

**And the dimension count at line 141 does not rescue the lower bound.** It reads $\mathrm{ANN}=\mathrm{Cat}(14)\cap(29)$ inside the $65$, with $14+29-65=-22<0$ as the expected dimension, so a second dimension would need a second coincidence. That is a genericity heuristic and cannot be a proof, for the plain reason that the configuration is already non-generic: the intersection is known to be at least $1$-dimensional, and the count predicted $0$. An argument whose prediction the object already violates once carries no weight against its violating it twice. The file is right to call this open.

## 6. The label, and the split I propose

The record's labels are literal: `Lemma` is proven, `Observation` is verified numerically at the dimensions stated, and a result inherits the status of its weakest input.

**The honest case for keeping `Lemma`** is real and should be stated: the lower bound is a mod-$p$ rank in exact integer arithmetic, not a floating-point estimate, and [results.md](../results.md#L598) says so in as many words. The record already treats this pattern as proof at [Lemma L87](../findings/sym3-blocks.md#L74) in the same file, where a rank over $\mathbb F_{46337}$ of $3570$ meets a derived cap of $3570$ and the block says *"the rank is now proved rather than measured"*.

**The case against it is what separates L62 from L87.** L87's cap $\sum_\lambda d_\lambda$ is a character-theoretic count and the Gram it measures is $\langle g_aW_0,g_bW_0\rangle^3$, an object a reader can define in one line. L62's measured matrix is $47$ columns of real and imaginary parts of block Gram functions read off a cached $\mathbb Q(i)$ adapted basis at $40$ sample points, and its validity as a lower bound is conditional on a second machine test. No reader reconstructs that by hand, even in principle. That is the same objection [Lemma L61](../findings/sym3-blocks.md#L168) already carries for $F_5\ge0$, and L62 inherits it.

**So: this is an `Observation` as stated, and the derivable half deserves its own statement.** Concretely,

> **Lemma, the restricted rank is at most $13$.** In the setting of [Lemma L59](../findings/sym3-blocks.md#L157), $\lVert W\rVert^6$ is an invariant sextic with $\lVert W_0\rVert^6=1$, so evaluation at $W_0$ is a nonzero functional on the $14$; and every product of two cubics of $K$ vanishes at $W_0$, so $\mathrm{image}\,\mu_K$ lies in its kernel. Hence $\mathrm{rank}\,\mu_K\le13$ and $\dim\mathrm{ANN}\ge1$, with $\mathcal A(W_0^6)\in\mathrm{ANN}$, the last using that $K$ is an $O(5)$-submodule, so its members vanish on the whole orbit. No computation enters.

> **Observation, the restricted rank is $13$, so $\dim\mathrm{ANN}=1$.** The sampled rank of $\mu_K$ is $13$ mod $1000033$ at $40$ points, reproduced at $p=1000003$ with independent code and points, and at $p=1099511627953$ at $40$ and $80$ points. Sampling and reduction only lose rank, so the cap of the Lemma above is attained and $\mathrm{rank}\,\mu_K=13$. **Conditional on the equivariant identification of the copies**, which the multi-probe Schur test guards and without which the sampled rank is not bounded by the cap.

The corollary the route actually consumes, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$ and $F_5\perp\mathrm{ANN}$, hence $F_5\in\mathrm{image}$, then rests on the `Observation` and should say so. Note that $F_5\perp\mathcal A(W_0^6)$ needs only $F_5(W_0)=0$, which is exact over $\mathbb Z$; it is the *spanning* of $\mathrm{ANN}$ by that one vector that needs the measured $13$.

**What would promote the `Observation` to a `Lemma`, without a run.** An analytic proof that $\dim\mathrm{ANN}\le1$, equivalently that no invariant sextic beyond $\mathbb R\,\mathcal A(W_0^6)$ has catalecticant vanishing on $K\times K$. Given the corank identity, that is a statement about $\mathrm{Cat}(14)\cap(29)$ block by block, and the block data needed for it ($16$ even blocks carrying $29$ of the $41$ multiplicities, $8$ odd blocks carrying $12$), is already in the file. This is the shape of an argument someone could write; I am not opening it here.

## 7. The pointer, it resolves, and the contrast with L61 is the finding

The note on L62 is word-for-word the note on L61, and `git show bbfa159b` shows that one commit narrowed both from *"the argument is the surrounding material in this file"* to the named section. **On L61 that narrowing manufactured a falsehood. On L62 it did not.**

The section [$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate](../findings/sym3-blocks.md#L104) runs from line 104 to line 150, the next `##` heading being [What the certificate would establish](../findings/sym3-blocks.md#L151). Under that reading (a `##` section contains its subordinate `####` blocks, which is the ordinary markdown reading), it holds every piece of L62:

| L62 needs | where, inside the section |
| --- | --- |
| the order-$1$ upper bound of $13$ | [line 135](../findings/sym3-blocks.md#L135), reviewer 203 |
| the sampled mod-$p$ rank $13$ and the squeeze | [line 121](../findings/sym3-blocks.md#L121) |
| $\mathrm{rank}=13$, $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, $F_5\perp$ | [line 123](../findings/sym3-blocks.md#L123) and [line 125](../findings/sym3-blocks.md#L125) |
| the three conditions on the cap | [lines 129–131](../findings/sym3-blocks.md#L129) |

Under the narrow reading (the section being only the prose and four-row table at lines 104–113, before the first `####`), the pointer would fail. **The distinction is worth one sentence somewhere in the record**, because two audits on the same day have now read the same section boundary two ways and reached opposite verdicts on two neighbouring blocks. L61's pointer is false under *both* readings: lines 104–150 contain no $\theta$, no $P$ and no Lovelock syzygy, and its transfer step is at line 151 and below. L62's is true under one and false under the other. The record's structure rules ([structure-check](../.claude/skills/structure-check/SKILL.md)) fix headings and ids but say nothing about what a `##` section contains, so the ambiguity is unadjudicated.

**One thing the location is genuinely wrong about.** L62's argument sits inside the blocks of [Lemma L90](../findings/sym3-blocks.md#L115) and [Lemma L91](../findings/sym3-blocks.md#L137), and **L90 consumes L62's conclusion**: its proof reads *"$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes"*, where $\mathrm{rank}\,\mu=13$ is exactly what L62 asserts. So the proof of L62 is physically housed inside the block of a lemma that depends on L62. There is no circularity in the mathematics (both consume the same sampled rank, and L62 adds the cap) but a reader following the pointer lands inside a downstream result and cannot tell which way the dependency runs. **L90's phrase *"$\mathrm{rank}\,\mu$ is measured"* also collides with [Lemma L89](../findings/sym3-blocks.md#L92)'s $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$**: the same bare symbol $\mu$ carries the restricted map in one block and the unrestricted one twenty-five lines above.

## 8. $\Theta_5$ against $M(5)$, warning W5 again, and L62 survives it

The section title writes $\Theta_5=\sqrt{3/2}$. Under [conventions.md](../findings/conventions.md) that is false: $\Theta_n$ is the *diagonal* maximum, $\Theta_5=2\sqrt2/3=0.9428$, and the object with value $\sqrt{3/2}=1.2247$ is $M(5)$, the global maximum. This is **W5** on what is now at least its fifth filing.

**L62's own statement does not depend on which object is meant.** The $14$ is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, fixed by [Lemma L85](../findings/sym3-blocks.md#L42) through Weyl integration, and no maximum enters it. The $13$ is $14-1$, the $1$ being the codimension of a point condition. $K$ and $\mathrm{ANN}$ are defined from $W_0$ and the module structure. So neither number is counted in a space the mistitled section defines, and **L62 is untouched numerically.**

**It is exposed in one place, and it is worth saying which.** $W_0$ is defined at [The orbit constraint](../findings/sym3-blocks.md#L58) as the padded $W_{\mathbb{CP}^2}$, and that definition is what L62 uses. But a reader who takes the section title at face value will identify $W_0$ as *the diagonal maximiser*, and at $n=5$ that is a different point: $\sqrt{3/2}>2\sqrt2/3$, so $W_0$ attains strictly more than any coordinate-diagonal configuration and therefore is not coordinate-diagonal. Under the wrong reading $K$ is a different submodule and $\mathrm{ANN}$ a different space, and every number in L62 would be about something else. **The misnaming costs nothing to the mathematics and can cost a reader the point that everything here is defined from.**

## 9. What I did not do

The block's evidence is a sampled rank reduced modulo $p$. Reproducing it is reserved, and I did not attempt it, no rank was computed, no matrix built, no point sampled, and I did not screen anything, there being no claim above that a screen would have decided. Reading [assemble_p4.log](../scripts/reviewers/r211/assemble_p4.log) and [r213_assemble80.log](../agent_logs/r213_assemble80.log) to count which primes the record names is a reading of files the repository already contains, and is reported as such rather than as reproduction.

**The run that would close the remaining gap, and what each outcome would mean.** Recompute the restricted sampled rank at a fourth prime chosen independently of the construction, with the restriction rebuilt from a different admissible position, and record the prime in [sym3-blocks.md](../findings/sym3-blocks.md). A result of $13$ would make *"four primes"* true as written and add one more independent witness, leaving the label question exactly where it is, the conditionality on the equivariant identification is not what more primes address. A result **above** $13$ would refute the restriction, since the cap of §2 is unconditional given equivariance; a result **below** $13$ would show the points non-unisolvent at that prime and prove nothing either way. **The run cannot promote L62 to a `Lemma`**; only the analytic $\dim\mathrm{ANN}\le1$ of §6 can. I have not run it and I am not asking for it as part of this audit.

---

## Summary of what should change

| # | change | why |
| --- | --- | --- |
| 1 | **Split L62 into a `Lemma` (rank $\le13$) and an `Observation` (rank $=13$)**, text in §6 | the two halves have different statuses and the single label prices both at the higher one |
| 2 | **Delete or repair [line 133](../findings/sym3-blocks.md#L133) and [line 141](../findings/sym3-blocks.md#L141)** | they say the rank is open, inside the section L62 names as its proof |
| 3 | **Name the space: *"the rank of $\mu$ restricted to the invariant forms supported on $K$"*** | *"the rank"* collides with [L89](../findings/sym3-blocks.md#L92)'s $14$ in the same file |
| 4 | **State the corank identity $\mathrm{rank}=14-\dim\mathrm{ANN}$ in the block** | the heading claims a corank, the body proves a rank, and nothing links them |
| 5 | **Correct or ground *"four primes"*** in both L62 and [L90](../findings/sym3-blocks.md#L117), and in [results.md](../results.md#L206) and [results.md](../results.md#L598) | the record names three; the only grounded *"four primes"* belongs to the CRT row lift |
| 6 | **Carry the equivariance condition into the block** | it is what makes *"sampled $\le$ true"* true, and it is guarded by a machine test the file calls load-bearing |
| 7 | **Add $\mathrm{ANN}$, $K$, $W_0$ and *"the $14$"* to [conventions.md](../findings/conventions.md)**, and unify $\mathrm{ann}$ with $\mathrm{ANN}$ | conventions.md's own rule requires it, and the heading's $\mathrm{ann}$ is defined nowhere |
| 8 | **Fix $\Theta_5\to M(5)$ at [line 104](../findings/sym3-blocks.md#L104)** and the remaining W5 sites | L62's numbers survive it, but $W_0$'s identity does not survive a reader taking the title literally |
| 9 | **Adjudicate what a `##` section contains** | two audits today read the same boundary two ways and reached opposite verdicts on neighbouring blocks |
