# Review r598, Lemma L61, $\theta_5=\sqrt{3/2}$ and its SOS certificate

**Reviewer B of a two-reviewer pair on identical cold briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 168, [Lemma L61](../findings/sym3-blocks.md#L168).**

## Verdict: GAP, the bound is true and its support is a certificate; the equality clause is unestablished

The two halves of the block have different standings and the block states them in one breath.

| clause | standing |
| --- | --- |
| $F_5\ge0\Rightarrow\theta\le\sqrt{3/2}$ on $\mathcal W_5$ | **the implication is sound**, and I re-derived it cold by two independent routes |
| $F_5$ is a sum of squares | **true, on a machine certificate**, 47 rationals in a basis no reader can rebuild by hand. Not an argument in this programme's sense |
| $\theta\le\sqrt{3/2}$ on $\mathcal W_5$ | **true**, on that certificate |
| equality **exactly** on the $O(5)$-orbit of $W_0$ | **NOT ESTABLISHED.** A rigidity claim with no proof anywhere on the record, and the same file calls the underlying fact *conjectured* 29 lines above the block |

Five further defects are listed in §6, three of them factual.

## 1. The pointer, and the provenance note

**The named section exists, and the note is a third false one.** [Lemma L61](../findings/sym3-blocks.md#L168) says *"the argument is in this file under '$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate'"*. That section is at [line 104](../findings/sym3-blocks.md#L104) and it does resolve. What it holds is the certificate's **exactness audit**, a four-row table on how the rows were lifted, how membership is by construction, and how positive definiteness is checked twice. It holds neither of the two steps the statement needs:

- **The step $F_5\ge0\Rightarrow\theta\le\sqrt{3/2}$ is in a different section**, ["What the certificate would establish"](../findings/sym3-blocks.md#L151) at line 153, forty-nine lines below the named one.
- **The equality clause is in no section of this file at all.** See §4.

**Git bears out the weaker half of the note.** The certificate section entered at [f3309892](../findings/sym3-blocks.md) (2026-08-29, *"Theta_5 = sqrt(3/2), by an exact rational SOS certificate"*), the transfer paragraph at [bac2049a](../findings/sym3-blocks.md) (2026-08-31), and the block itself at [86621751](../findings/sym3-blocks.md) later the same day, carrying the note in its first form, *"the argument is the surrounding material in this file"*. [bbfa159b](../findings/sym3-blocks.md) then replaced "the surrounding material" with a **named** section. So the mathematics was indeed in the file first; what the rewrite did was narrow a true vague pointer into a false precise one. That is the mechanism this brief's six earlier false notes should be checked for: the falsity was **introduced by the repair**, not carried over from the lift.

**Where the argument actually lives, in full:** the transfer step at [sym3-blocks.md line 153](../findings/sym3-blocks.md#L153) and [line 30](../findings/sym3-blocks.md#L30); the certificate at [line 104](../findings/sym3-blocks.md#L104); the image-membership chain at [Lemma L59](../findings/sym3-blocks.md#L157) and [Lemma L62](../findings/sym3-blocks.md#L175); the identity-from-40-points step at [Lemma L90](../findings/sym3-blocks.md#L115); and the only complete assembly of the four anywhere, in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) at the `\begin{proof}[sketch]` under `\begin{Lem}{61}`. **The findings record has no place where the proof is composed.** The report does; the block points away from it.

Every script and file pointer in the section resolves: [n5_certificate.json](../scripts/runs/n5_certificate.json), [run_n5_verify.py](../scripts/runs/run_n5_verify.py), [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py), [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py), [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py), [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py), [negated_generator.py](../scripts/reviewers/r177/negated_generator.py).

## 2. The transfer step $F_5\ge0\Rightarrow\theta\le\sqrt{3/2}$, CONFIRMED, derived cold two ways

This is the step the brief expects to have been assumed. **It has not been; it is on the record, and it is correct.** I derived it without reading the block's reasoning.

**What is needed.** $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a statement about $\mathop{\mathrm{tr}}(W^3)$, while $\theta=P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,Q(W)\rangle$ per [conventions.md](../findings/conventions.md). These are different cubics in general. The step needs exactly

$$P(W)=3\mathop{\mathrm{tr}}(W^3)\quad\text{on }\mathcal W_5,$$

after which $F_5\ge0\iff P(W)^2\le\tfrac32\lVert W\rVert^6\iff\lvert\theta\rvert\le\sqrt{3/2}$, and the one-sided form follows. The factor $9$ in $F_5$ is precisely $3^2$; it is not decorative.

**Route 1, Lovelock, plus one evaluation.** Under [conventions.md](../findings/conventions.md)'s pairing (the $\tfrac12$ at the $\Lambda^2$ level, plain Frobenius on the pair matrix) $\langle W,W^2\rangle=\mathop{\mathrm{tr}}(W^3)$, so $P=\mathop{\mathrm{tr}}(W^3)+\langle W,W^\#\rangle$. Both $\mathop{\mathrm{tr}}(W^3)$ and $\langle W,W^\#\rangle$ are cubic $O(5)$-invariants, and [Lemma L85](../findings/sym3-blocks.md#L42)'s degree sequence $1,1,4,5,14$ puts $\dim(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=1$. Hence they are proportional, and one non-degenerate evaluation fixes the constant. The constant is $2$, giving $P=3\mathop{\mathrm{tr}}(W^3)$.

**Route 2, the two spectra, and it is independent of Route 1.** [Lemma L50](../results.md) gives $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ with $\sum\mu^2=1$, $\sum\omega^2=3$. At $W_{\mathbb{CP}^2}$ I took the second-kind spectrum from [Li Example 2.5](../references/li-2021-nonnegative-second-kind/notes.md) in the record's $iklj$ order, $\mathring R$ at $-2$ with multiplicity $m^2-1$ and $+4$ with multiplicity $m(m+1)$, so at $m=2$ the Weyl part is $\omega\propto(-4^{(3)},2^{(6)})$, trace zero as required, normalised it to $\sum\omega^2=3$, and paired it with $\mu=(2,-1,-1,0^{\ge3})/\sqrt6$:

$$p_3(\mu)=\tfrac1{\sqrt6},\qquad p_3(\omega)=-\tfrac3{\sqrt6},\qquad\theta=\tfrac32\cdot\tfrac1{\sqrt6}+\tfrac32\cdot\tfrac1{\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}.$$

So $p_3(\omega)=-3p_3(\mu)$ at this point, which with one-dimensionality is the collapse for all of $\mathcal W_5$, and $\theta=3p_3(\mu)=3\mathop{\mathrm{tr}}(W^3)$, the same conclusion, reached through the second-kind operator rather than through $\#$. The two routes share only the dimension count. **The relative sign is load-bearing and I checked it**: flipping $\omega$ returns $\theta=0$ at $W_{\mathbb{CP}^2}$, so the record's $iklj$ order is the one that reproduces its own value, and the trap [conventions.md](../findings/conventions.md) warns about is not sprung here.

**Two remarks on what this costs.** First, the input $\dim(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=1$ is itself machine-computed in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), though it is also the classical Lovelock statement and the block gives a second, independent derivation of it at [line 30](../findings/sym3-blocks.md#L30). Second, [results.md line 592](../results.md) states this step correctly, with its citation to [Lemma L50](../results.md), **the findings block is the only place the chain is broken**, and it is the place the audit points at.

**A note on the direction actually obtained.** $F_5\ge0$ gives $\lvert\theta\rvert\le\sqrt{3/2}$, two-sided. Both signs are attained ($\theta(-W_0)=-\sqrt{3/2}$), and cubics being odd, every element of $K$ vanishes at $-W_0$ automatically. So the squares in the certificate vanish on **two** orbits, not one, and the block's "cubics vanishing on the $O(5)$-orbit of $W_0$" describes half of their forced zero locus. Harmless for the bound; it matters in §4.

## 3. Is $F_5\ge0$ an argument or a certificate?, a certificate, and the record should say so

**By the programme's own standard this is not a proof a human can read.** The route is exact and, as far as I can check by reading, correct, but every step is executed by machine and none is reproducible by hand.

- **The witness is 47 rational numbers** in [n5_certificate.json](../scripts/runs/n5_certificate.json), block-diagonal over 16 blocks of shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$. The count $47=\sum m_\lambda^2$ is the **Hermitian** parameter count, against the $36=\sum m_\lambda(m_\lambda+1)/2$ real-symmetric unknowns of [Lemma L86](../findings/sym3-blocks.md#L56); the 11 extra directions are the imaginary off-diagonals. That is legitimate, a Hermitian PSD Gram on cubics built over $\mathbb Q(i)$ still exhibits a real SOS, since $\lvert f\rvert^2=(\mathop{\mathrm{Re}}f)^2+(\mathop{\mathrm{Im}}f)^2$, but it means the decomposition is **not** the 36-unknown object the file's own dimension counts describe, and nothing in the section says so.
- **The basis those 47 numbers live in is 41 highest-weight vectors over $\mathbb Q(i)$**, produced by [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) in 86 seconds after complexifying $\mathcal W_5$, splitting 35 Cartan eigenspaces and intersecting two raising-operator kernels. **To verify the decomposition by expansion a reader must first rebuild that basis.** There is no route by hand, in principle or otherwise.
- **What a reader can check by hand is nothing; what a second machine can check is a great deal**, and the record has done that well: exactness over $\mathbb Q$ at every step, positive definiteness by two code-disjoint routes (Sylvester minors, and Sturm/Descartes on characteristic polynomials in [run_n5_verify.py](../scripts/runs/run_n5_verify.py)), and the honest note that a false certificate is the one error that would not announce itself.

**The support chain, stated so the record can carry it in these terms:**

1. $F_5$ lies in the image of $\mu$ restricted to $K$, [Lemma L59](../findings/sym3-blocks.md#L157) plus [Lemma L62](../findings/sym3-blocks.md#L175). The cap $13$ is derived (order-one vanishing at $W_0$); the attainment is a **sampled mod-$p$ rank at four primes**, which is a valid one-sided argument, since sampling and reduction only lose rank. Sound.
2. A PSD point exists in the resulting 23-dimensional affine family, **found by SDP, rounded, lifted by CRT**. Machine.
3. That point is PSD, **exact over $\mathbb Q$**, two routes. Machine, but rigorous.
4. Its sextic **equals** $F_5$ rather than agreeing at 40 points, [Lemma L90](../findings/sym3-blocks.md#L115). Machine, and see §6.4 for a discrepancy in which argument is being used.

So: **$F_5\ge0$ is established, by appeal to a solver's output made exact after the fact. No written SOS decomposition exists, and none could be written.** This is the outcome the brief asks to be named as distinct from confirmation and from refutation, and it should be named in the block.

**What an argument would have to beat.** For scale: at $n=4$ the same statement has a five-line proof. There $W=W^+\oplus W^-$ with $W^\pm$ traceless symmetric on $\mathbb R^3$, $P=3\mathop{\mathrm{tr}}(W^3)=9(\det W^++\det W^-)$, and $\max\det$ over traceless symmetric with $\mathop{\mathrm{tr}}A^2=s$ is $2(s/6)^{3/2}$ at spectrum $\propto(2,-1,-1)$; $s^{3/2}+(1-s)^{3/2}$ is convex on $[0,1]$, so the maximum is at an endpoint and equals $18/6^{3/2}=\sqrt{3/2}$, **with equality exactly when one factor vanishes and the other is of $(2,-1,-1)$ type**, the $O(4)$-orbit of $W_{\mathbb{CP}^2}$, orientation reversal fusing the two chiralities. At $n=5$ the self-dual splitting is gone and no such route is visible; the constraints are doing real work, since dropping them (maximising $\sum\mu^3$ over traceless unit $\mu\in\mathbb R^{10}$) gives $8/\sqrt{90}=0.843$ against the true $1/\sqrt6=0.408$, more than a factor of two slack. I record this to say the certificate is not laziness, but also that the $n=4$ case shows what the missing object looks like, **rigidity included**.

## 4. Equality exactly on the orbit, the gap

**The claim is asserted and nowhere proved, and the same file contradicts it.**

- **What the SOS gives is one inclusion.** $F_5=\sum_aq_a^2$ with each $q_a$ vanishing on the orbit gives $Z(F_5)\supseteq O(5)W_0$. Equality *on* the orbit follows. Equality *only* there is the reverse inclusion, $\bigcap_aZ(q_a)\subseteq O(5)W_0\cup O(5)(-W_0)$, which is a statement about the specific $q_a$ chosen, and the record computes nothing about their common zero locus. A different PSD point in the 23-dimensional family would give different $q_a$ and the same $F_5$.
- **Restated, the clause is uniqueness of the global maximiser up to $O(5)$**, since $F_5(W)=0$ at unit norm is exactly $\lvert\theta(W)\rvert=\sqrt{3/2}$. That is a rigidity theorem, and no such theorem is on the record at $n=5$.
- **The file itself calls the fact conjectural.** [Line 143](../findings/sym3-blocks.md#L143): *"$\Delta$ … appears to vanish exactly on the orbit cone, the zero set $F_5$ is **conjectured** to have."* Twenty-nine lines below that sentence, [Lemma L61](../findings/sym3-blocks.md#L168) states the same zero set as a theorem. **This is the checklist item "does the block's own file already settle it" answering in the opposite direction**: the file settles it as open.
- **The record's own standard says so too.** [Lemma L0](../findings/problem.md#L459)'s third scope condition, added by [r591](REVIEW_r591.md)/[r592](REVIEW_r592.md): *"The claim is about the maximum VALUE, not about the maximiser… Rigidity is a separate statement with a separate proof."* L61 supplies the value and asserts the maximiser.
- **The nearest thing the record has is not it.** [Result 124](../findings/INDEX-results.md#L142) gives $\theta^2\le\Sigma\le\tfrac32\rho^2$ *"with equality exactly at $\pm W_{\mathbb{CP}^2}$, a rigidity"*, but on the **half-flat four-set family** only, not on $\mathcal W_5$.

**What is owed, and whether it is reachable.** Owed: that every unit $W\in\mathcal W_5$ with $\theta(W)=\sqrt{3/2}$ lies in $O(5)\cdot W_0$. **Reachable, plausibly, and not by the certificate.** A route worth someone's cycle, stated as a reduction rather than a result:

1. A maximiser is critical, so $Q(W)=\theta W$ with $\theta=\sqrt{3/2}>0$.
2. **If** it has at most two negative eigenvalues, [Lemma L29](../results.md) and [Lemma L35](../results.md) cap $\theta$ at $\sqrt{3/2}$ dimension-free, so it sits at *their* equality, and their equality case would have to be characterised. L29's entry says only "attained at $(2,-1,-1)/\sqrt6$", which is attainment and not a characterisation; L35's closing inequality is proved by interval arithmetic, so its equality case is a certificate too.
3. [Lemma L30](../results.md) then bites: with a two-dimensional negative eigenspace, every eigenvector of nonzero eigenvalue has image in $U=\mathop{\mathrm{im}}v_9+\mathop{\mathrm{im}}v_{10}$, and $\dim U<5$ makes $W$ a padding of a $\mathcal W_4$ element, where the five-line argument of §3 closes rigidity outright.

So the whole clause reduces to two named steps: *a maximiser at $n=5$ has at most two negative eigenvalues*, and *the equality case of L29/L35*. Neither is on the record; both look like statements about $n=5$ alone rather than about the hard dimensions. **Until one of them is done, the clause should be marked as asserted** in the block, in [results.md line 592](../results.md), and in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), all three of which state it flatly.

## 5. Scope, what L61 licenses at $n\ge12$, and what the record claims it licenses

**The transfer runs downward for the theorem and upward for the witness, and the block states neither direction.**

| direction | status |
| --- | --- |
| $\theta\le\sqrt{3/2}$ on $\mathcal W_5\;\Rightarrow$ anything at $n>5$ | **No.** $\mathcal W_n$ properly contains the padded $\mathcal W_5$; a bound on a subspace is not a bound on the space. The file says so at [line 155](../findings/sym3-blocks.md#L155) (*"It does not lift"*) and gives the reason, the Lovelock syzygy killing trace-word transfer |
| $W_0\in\mathcal W_5\;\Rightarrow M(n)\ge\sqrt{3/2}$ at every $n\ge5$ | **Yes**, and this is what actually reaches $n\ge12$ |

The upward half is worth stating explicitly, because it is the only thing L61's dimension contributes to Problem P. Padding preserves the norm and $\theta$ because $\Lambda^2U=\mathfrak{so}(U)$ is a **Lie subalgebra**: for $\alpha\notin\Lambda^2U$ and $\gamma,\delta\in\Lambda^2U$ the structure constant $c_{\alpha\gamma\delta}$ vanishes, so $W^\#$ of a padded $W$ has no component outside, $Q$ commutes with padding, and $P$ and $\lVert\cdot\rVert$ come through unchanged. (Padded $W_0$ is genuinely in $\mathcal W_n$: every component with an index outside $U$ vanishes, so the Ricci trace is the $n=4$ one, which is zero.) Hence $M(n)\ge M(5)=\sqrt{3/2}$ for all $n\ge5$, the row [conventions.md](../findings/conventions.md) already carries, and the reason $n\ge12$ is the threshold at all, that being where $\theta_0(n)>\sqrt{3/2}$.

**The block says none of this.** It states an upper bound at one dimension with no transfer note, next to a section that carries the downward one.

### 5.1 $\theta_5$, $\Theta_5$ and $M(5)$, the W5 trap, third sighting

**They are not the same object, and the Lemma proves the third.** [W5](../findings/INDEX-traps.md#L23), the brief places it in [conventions.md](../findings/conventions.md), where the supporting $M(n)$ row lives; the warning itself is in [INDEX-traps.md](../findings/INDEX-traps.md), says $\Theta_n$ is the **diagonal** maximum and keeps being read as the global one. [conventions.md](../findings/conventions.md) gives $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, so

$$\Theta_5=\sqrt{8/9}=0.9428\;<\;\theta_0(5)=0.9798\;<\;M(5)=\sqrt{3/2}=1.2247 .$$

The certificate is an SOS on the **whole** of $\mathcal W_5$, so what it bounds is $M(5)$. Therefore:

- **"$\Theta_5=\sqrt{3/2}$" is false as written**, wherever it appears, the section heading at [sym3-blocks.md line 104](../findings/sym3-blocks.md#L104), the DECIDED line at [line 153](../findings/sym3-blocks.md#L153), [results.md](../results.md) lines 40, 204 and the L61 heading at 590, [report/sections/09-status.tex](../report/sections/09-status.tex) line 12, and both diagram files. The true statement is $M(5)=\sqrt{3/2}$.
- **The block's own heading, $\theta_5$, uses a symbol defined nowhere.** [conventions.md](../findings/conventions.md) defines $\theta$ as a function of $W$, with no $n$-subscripted form. Read charitably it means $M(5)$; the record already has that letter, so the heading should use it.
- **This is known and was left half-repaired.** [r474](REVIEW_r474.md) and [r499](REVIEW_r499.md) both filed it; r499's fix list item 5 reads *"Rename L61's $\Theta_5$, and table the collision in conventions.md"*. The findings heading was renamed (to the undefined $\theta_5$ rather than to $M(5)$) and nothing else moved: [results.md](../results.md) still says $\Theta_5$ in three places, the pointed-at section still says $\Theta_5$, and the "words with more than one meaning" section of [conventions.md](../findings/conventions.md) still has no $\Theta$ row. [LEDGER.md](../findings/LEDGER.md) line 460 records the collision as "holds" and resolved.

### 5.2 The conflation manufactures a false claim in the report

**This is the reason the naming matters rather than a style point.** [report/sections/09-status.tex](../report/sections/09-status.tex) line 12 reads *"$\Theta_5=\sqrt{3/2}$ (Lemma 61), **Proven** … **Conjecture A holds at $n=5$**"*, and line 169 repeats it. [Lemma L0](../findings/problem.md#L459), in the form [r591](REVIEW_r591.md) and [r592](REVIEW_r592.md) repaired it, states Conjecture A's conclusion at $\Theta_n$ and fixes its scope at $n\ge12$, with a second clause covering $8\le n\le11$ that removes $SO(n)\cdot W_{\mathbb{CP}^2}$ first. Read at $n=5$:

- **The $n\ge12$ clause is false there, and L61 is its witness.** It would assert $\sup P=\Theta_5=\sqrt{8/9}$; L61 exhibits $\sqrt{3/2}$.
- **The $8\le n\le11$-shaped clause is not established there either.** It asserts $P\le\Theta_n$ *off* the $\mathbb{CP}^2$ orbit. L61 gives $P\le\sqrt{3/2}$ everywhere and equality only on the orbit (itself unproven, §4); it says nothing about how far $P$ falls below $\sqrt{3/2}$ off the orbit, and in particular nothing putting it under $\sqrt{8/9}$.

So **"Conjecture A holds at $n=5$" is unsupported under either clause**, and the sentence exists only because $\Theta_5$ was read as $M(5)$: under that reading L61 says "$\sup P=\Theta_5$", which is Conjecture A's shape. **A wrong symbol has been promoted into a claimed dimension of the target theorem.** The honest sentence is that L61 settles the *value* of the global maximum at $n=5$ and that the machinery ran end to end, which is what the same file's line 169 says next, and says well.

## 6. Smaller findings, each checked

1. **"Rational entries at denominator $10^5$" is false of the certificate.** [Line 106](../findings/sym3-blocks.md#L106) says so; the file's 47 coordinates carry 20 distinct denominators, **13 of them not dividing $10^5$**, the largest $4.9895950104\times10^{16}$. The `denominator: 100000` field names the rounding imposed on the 34 kernel coefficients, not the point. **[run_n5_verify.py](../scripts/runs/run_n5_verify.py) says exactly this in a comment credited to reviewer 213, and the finding was never propagated to [findings/](../findings/).** The claim is not load-bearing (exactness comes from the lift, not from the denominator), but as written the section describes a file it does not match.
2. **The 47/36 mismatch is unstated.** §3 above. The block's neighbours count 36 real unknowns; the certificate has 47 Hermitian ones. Given that [Lemma L88](../findings/sym3-blocks.md#L78) was already refuted once on precisely the real-versus-Hermitian coordinates (reviewer 204), a section exhibiting a Hermitian point should say which object it is.
3. **The block does not render.** [Line 172](../findings/sym3-blocks.md#L172) writes `W_{\CP^2}` and `\Weyl_5`, macros defined in [report/report.tex](../report/report.tex) lines 49 and 58 and nowhere in markdown. It is the only line in [sym3-blocks.md](../findings/sym3-blocks.md) with an undefined macro, a fossil of the lift from the report. [results.md line 592](../results.md) has the same statement written correctly.
4. **Two different arguments for the load-bearing identity step, in two places.** [Lemma L90](../findings/sym3-blocks.md#L115) argues from $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu)=13=\mathop{\mathrm{rank}}\mu$ at four primes; [run_n5_verify.py](../scripts/runs/run_n5_verify.py) records reviewer 214 calling that comparison circular and replaces it with reviewer 213's route, 120 explicit invariant sextics evaluated at the 40 points, rank 14 against a cap of 14. **The report's proof sketch takes 213's route.** I judge L90's version defensible after L62 (the cap 13 is derived, the sampled rank is a lower bound, so both are 13 and the kernels coincide), so the circularity objection lands on an earlier phrasing rather than on the current text, but the two routes differ in character, 213's resting on a floating-point rank with a singular-value gap while L90's is exact mod $p$. **The report's certificate box claims "No floating-point step enters the verification" three paragraphs after its sketch invokes the float-based route.** One of the two should be chosen and stated in both places.
5. **A sign error in the report's sharpness paragraph.** [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) says *"the maximiser's $\Lambda^2$ spectrum is $(-2,1,1,0^7)$"*. That point carries $\mathop{\mathrm{tr}}(W^3)<0$, hence $\theta=-\sqrt{3/2}$: it is the **minimiser**. The maximiser is $(2,-1,-1,0^7)/\sqrt6$, as [sym3-blocks.md line 153](../findings/sym3-blocks.md#L153) and [r349](REVIEW_r349.md) both have it, and as the same paragraph's own integral check confirms, $\lVert W_0\rVert^2=24$ and $\mathop{\mathrm{tr}}(W_0^3)=+48$ is the spectrum $(4,-2,-2,0^7)$, positive-signed. The paragraph contradicts itself two sentences apart.

## 7. What I did not do

**No computation was run.** Under the standing analysis-only rule I did no SDP solve, no Gram fit, no rank sampling, and no sweep. The three arithmetic checks in this report, the $\mathbb{CP}^2$ two-spectra evaluation of §2, the $n=4$ maximisation of §3, and the denominator census of §6.1, are hand derivations and a read of a 1.3 KB JSON file, seconds of work on objects the claims name. **Nothing here is offered as numerical evidence for a positive claim.**

**One item needs computation and I am stopping at it rather than working around it.** Deciding the equality clause of §4 by the certificate's own route would mean computing the common zero locus of the $q_a$, a Gröbner or elimination problem on 35 variables. It would decide whether $Z(F_5)$ is the two orbit cones or something larger: *larger* refutes the clause outright with a witness, *equal* proves it. I have not opened it, and I would expect the reduction of §4 to be cheaper and to leave an argument behind.

## 8. Recommended repairs, in order of what they cost the record

1. **Split [Lemma L61](../findings/sym3-blocks.md#L168) into the bound and the rigidity**, and mark the rigidity asserted, in the block, in [results.md line 592](../results.md), and in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex).
2. **Withdraw "Conjecture A holds at $n=5$"** from [report/sections/09-status.tex](../report/sections/09-status.tex) lines 12 and 169.
3. **Rename the quantity $M(5)$** everywhere the value $\sqrt{3/2}$ is attached to $\Theta_5$ or $\theta_5$, and table the collision in [conventions.md](../findings/conventions.md) as r499 asked.
4. **Fix the provenance note** to name the sections that hold the transfer step and the certificate, or to say the composed proof is in [report/](../report/) alone.
5. **State in the block that the support is a certificate**, with the four-step chain of §3 and the note that no hand-checkable decomposition exists.
6. **Correct §6.1's denominator sentence, §6.3's macros, and §6.5's sign**, and choose one identity-step argument for §6.4.
