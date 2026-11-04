# Review r597, Lemma L61, $\theta_5=\sqrt{3/2}$ and its SOS certificate

*Reviewer r597, independent adversarial audit of [Lemma L61](../findings/sym3-blocks.md#L168) in [sym3-blocks.md](../findings/sym3-blocks.md). Analysis only; the machine was used twice, both times to read files the record already contains, counting the coordinates of [n5_certificate.json](../scripts/runs/n5_certificate.json) and reading `git log`. No solve, no fit, no sampling. Written without reading the other reviewer's report on this brief.*

## Overall verdict, GAP, and the support for the inequality is a certificate rather than an argument

Three separate things are bundled into two lines, and they have three different statuses.

| the claim | status |
| --- | --- |
| $F_5\ge0$ on $\mathcal W_5$ | **true on a certificate, not on an argument.** An SDP point, lifted to $\mathbb Q$ through four primes, whose positive-definiteness a reader can check by hand but whose *identity* with $F_5$ they cannot |
| $F_5\ge0\Rightarrow\theta\le\sqrt{3/2}$ on $\mathrm{Weyl}_5$ | **CONFIRMED.** I rebuilt it cold in three lines. The record proves it too, in [bispectral.md](../findings/bispectral.md) and in a *different* section of L61's own file from the one the block points at |
| equality exactly on the $O(5)$-orbit of $W_0$ | **GAP, and unreachable by this route.** Nowhere argued; the same file calls the zero set *conjectured* 29 lines above the block; and $F_5$ is an even sextic, so its zero set contains a second orbit no matter what the certificate says |

**The load-bearing pointer is false.** The block names the section [$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate](../findings/sym3-blocks.md#L104) as holding the argument. That section contains no $\theta$, no $P$, no $Q$ and no Lovelock syzygy, it is a four-row table about a JSON file. The step from $F_5\ge0$ to $\theta\le\sqrt{3/2}$ lives 40 lines further down under [What the certificate would establish](../findings/sym3-blocks.md#L151), and was put there ten hours before the block was written, by a commit that was *repairing* the file's own statement that nothing should cite $\Theta_5$ as proved. This is the seventh false provenance note.

**And the section it points at is misnamed.** $\Theta_5=2\sqrt2/3$ under [conventions.md](../findings/conventions.md)'s own definition. The object the certificate bounds is $M(5)$.

---

## 1. The pointer

### What the note says

> *Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is in this file under "$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate"**.*

### Where the argument actually lives

| piece of L61 | where it is | is it in the named section? |
| --- | --- | --- |
| $F_5$ is SOS of orbit-vanishing cubics | [sym3-blocks.md:106–113](../findings/sym3-blocks.md#L106), the named section | yes, as a certificate |
| $P(W)=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$, hence $F_5=\tfrac32\lVert W\rVert^6-P^2$ | [sym3-blocks.md:153](../findings/sym3-blocks.md#L153), a different section; derived in [bispectral.md:118–145](../findings/bispectral.md#L118) as [Lemma L50](../findings/bispectral.md#L127) | **no** |
| equality exactly on the orbit | nowhere | **no** |

The second row is the whole content of the word "hence" in the lemma. The named section never mentions $\theta$.

### The git record

| commit | date | what it did |
| --- | --- | --- |
| f3309892 | 2026-08-29 | added the named certificate section |
| bac2049a | 2026-08-31 10:23 | added the $\theta$ step, **deleting** the file's own *"$\Theta_5=\sqrt{3/2}$, which the record does not have"* and *"Nothing should cite $\Theta_5$ as proved until this is decided"* |
| 86621751 | 2026-08-31 20:50 | numbered the block, with the provenance note |

So "has always been in this file" is false for the step that makes the lemma a statement about $\theta$: it entered ten hours earlier, on the same day the block was written, as the resolution of an explicit open flag. The claim that the result "was numbered in [report/](../report/)" is true, [07-gradedness-split.tex:878](../report/sections/07-gradedness-split.tex#L878) carries `\begin{Lem}{61}`, with a proof paragraph the findings file does not have.

**Every other pointer in and around the block resolves.** [n5_certificate.json](../scripts/runs/n5_certificate.json), [run_n5_verify.py](../scripts/runs/run_n5_verify.py), [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py), [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py), [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py), [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py) and [negated_generator.py](../scripts/reviewers/r177/negated_generator.py) all exist.

---

## 2. Is the conclusion an argument, or a certificate?

**A certificate, and the certificate does not cover the part a reader would most want covered.**

### What is on the record for $F_5\ge0$

A single point in $\mathbb Q^{47}$, stored in [n5_certificate.json](../scripts/runs/n5_certificate.json), with a block shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$ over the 16 surviving $\lambda_2$-even blocks. The 47 is $\sum m_\lambda^2$ (the *Hermitian* parameter count, $36$ real-symmetric plus $11$ antisymmetric) which is the same $\mathbb Q(i)$ inflation [Lemma L88](../findings/sym3-blocks.md#L78) discusses and whose coordinate identification reviewer 204 refuted. There is no written decomposition $F_5=\sum q_i^2$ anywhere; there are no cubics $q_i$ on the record at all, only the machinery that would produce them.

### What is verifiable by hand, and what is not

| step | can a reader check it? |
| --- | --- |
| positive semidefiniteness of the Gram | **yes.** Sixteen Hermitian rational blocks, largest $3\times3$. Sylvester minors on a $3\times3$ is a hand computation, and [run_n5_verify.py](../scripts/runs/run_n5_verify.py) does it a second way, by Sturm sequences on the characteristic polynomial over $\mathbb Q$ |
| that this Gram maps to $F_5$ | **no.** It requires the 41 highest-weight vectors of $\mathrm{Sym}^3\mathcal W_5$ over $\mathbb Q(i)$, built by an 86-second run whose largest weight space is 234-dimensional inside a 7770-dimensional space |
| that agreement at 40 sample points is an identity | **no.** [Lemma L90](../findings/sym3-blocks.md#L115)'s injectivity argument is sound in form ($\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ always, and equal ranks force equal kernels) but its input, $\mathrm{rank}(\mathrm{ev}\circ\mu)=13$, is a mod-$p$ rank of a machine-built matrix at four primes |
| that the sampled row really is $\mu^*(\mathrm{ev}_W)$ | **no**, and the file says so: the rank cap is *"conditional on equivariance"*, guarded by a multi-probe Schur test ([sym3-blocks.md:129](../findings/sym3-blocks.md#L129)) |

**Note what [run_n5_verify.py](../scripts/runs/run_n5_verify.py) verifies.** Its docstring is explicit that it checks the point *"from the file alone"*, that is, positive definiteness. It never touches $F_5$. So the row of the table reading *"positive definiteness | two routes sharing no code"* is accurate and is the only row that is an independent check; *"membership | by construction"* means the point was built inside the affine solution set, which is a property of the producer, not a check of it.

**This is exactly the outcome the brief names as third.** The inequality $F_5\ge0$ is almost certainly true, it is corroborated by 200 and by 3000 gradient ascents, by the exact integer identity $6\cdot48^2=13824=24^3$ at $W_0$, and by [Lemma L35](../findings/stratum-two-negative.md), which caps $\theta$ at $\sqrt{3/2}$ for every $W$ with at most two negative eigenvalues, a class containing $W_0$. But its support is a machine pipeline, and the programme's standard says that is not an argument.

### One number presented as an identity, and it is wrong

[sym3-blocks.md:106](../findings/sym3-blocks.md#L106) says the Gram has *"**rational** entries at denominator $10^5$"*. It does not. Thirteen of the 47 coordinates have denominators up to $4.99\times10^{16}$. The verifier's own header says so, crediting reviewer 213: *"THE DENOMINATOR FIELD NAMES THE ROUNDING, NOT THE POINT ... It is the denominator imposed on the 34 kernel coefficients."* The correction is in the script and never reached the file. It does not affect exactness (every coordinate is rational) but "denominator $10^5$" is what makes the certificate sound small enough to read, and it is not.

A second uncorrected item of the same kind: reviewer 214's note in the same header that `herm_row` packs off-diagonals with no factor of two, so *"the form the certificate represents has off-diagonals HALF of what blocks() assembles"*. The direction is safe and both were checked, but the findings file records neither the discrepancy nor the check.

---

## 3a. $F_5\ge0\Rightarrow\theta\le\sqrt{3/2}$, CONFIRMED

This is the step the brief expects to have been assumed. It has not been; it is right, and it is short. Here it is derived without using the block.

**The relation between $\mathop{\mathrm{tr}}(W^3)$ and $P$.** By [conventions.md](../findings/conventions.md), $P(W)=\langle W,Q(W)\rangle$ with $Q(W)=W^2+W^\#$, the pairing on the operator being plain Frobenius, so

$$P(W)=\mathop{\mathrm{tr}}(W^3)+\langle W,W^\#\rangle .$$

The two summands are different cubics in general. At $n=5$ they are proportional, for a reason that does not depend on either of them:

- $(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ is one-dimensional, [Lemma L85](../findings/sym3-blocks.md#L42)'s degree sequence $1,1,4,5,14$ has a $1$ in degree three, computed by Weyl integration in exact Laurent polynomials and so sharing nothing with the contraction identity.
- $\mathop{\mathrm{tr}}(W^3)$ and $\langle W,W^\#\rangle$ are both $O(5)$-invariant cubics, and both are nonzero at $W_0$. Hence $\langle W,W^\#\rangle=c\mathop{\mathrm{tr}}(W^3)$ identically on $\mathcal W_5$, for a single constant $c$.
- **The constant is pinned by one anchor.** At $W_0$ the $\Lambda^2$ spectrum is $(2,-1,-1,0^7)/\sqrt6$: unit norm, since $(4+1+1)/6=1$, and $\mathop{\mathrm{tr}}(W_0^3)=(8-1-1)/6\sqrt6=1/\sqrt6$. The record's independently verified $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}=3/\sqrt6$ (result 44, rebuilt by hand from the $\mathfrak{so}(4)$ structure constants by two reviewers), gives $P(W_0)=3\mathop{\mathrm{tr}}(W_0^3)$, so $c=2$.

Therefore $P(W)=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$ and

$$F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2 ,$$

so $F_5\ge0$ reads $P(W)^2\le\tfrac32\lVert W\rVert^6$, that is $\lvert\theta\rvert\le\sqrt{3/2}$, at every $W\ne0$ in $\mathcal W_5$, critical or not. Both sides are homogeneous of degree six, so no normalisation is needed.

**Two independent confirmations that $c=2$ and not something else.**

- [Lemma L50](../findings/bispectral.md#L127) derives it from Lovelock's dimensionally-dependent identity: $\beta-\tfrac\alpha2=-\tfrac1{64}\delta^{a_1\cdots a_6}_{b_1\cdots b_6}W\,W\,W$ and the generalised Kronecker delta on six indices vanishes identically for $n\le5$. Gate 2 landed, reviewers 97 and 98. This is a genuine argument and it is the one the lemma should be citing.
- At $n=4$ on the self-dual part, $W^\#$ acts as $(W^\#)_i=c\lambda_j\lambda_k$ on a diagonal $W_+$, so $\langle W,W^\#\rangle=3c\lambda_1\lambda_2\lambda_3=c\mathop{\mathrm{tr}}(W^3)$ using $\sum\lambda_i=0$, the proportionality falls out of the $\mathfrak{su}(2)$ structure constants alone, independently of any dimension count.

**Normalisation check, because this record has a live $\sqrt2$ trap.** The certificate's $\lVert W\rVert$ is the operator Frobenius norm $\mathop{\mathrm{tr}}(W^2)$, not the tensor norm. [07-gradedness-split.tex:890](../report/sections/07-gradedness-split.tex#L890) records $\lVert W_0\rVert^2=24$ and $\mathop{\mathrm{tr}}(W_0^3)=48$ over $\mathbb Z$, matching the $\Lambda^2$ spectrum $(4,-2,-2,0^7)$ and giving $6\cdot48^2=13824=24^3$, the equality case of $F_5\ge0$, exactly. So $F_5$ and $\theta$ are measured in the same norm and the implication is not a normalisation accident.

---

## 3b. Equality exactly on the orbit, GAP, and the SOS route cannot supply it

**What the certificate gives.** Each $q_i$ vanishes on the orbit cone, so $F_5=\sum q_i^2$ vanishes there, so $\theta=\sqrt{3/2}$ *on* the orbit. That is the easy direction and it is the only one on the record.

**What "exactly" needs.** That $\{q_i=0\ \forall i\}\cap\{\lVert W\rVert=1\}$ is contained in the orbit. Exhibiting a psd Gram says nothing about that. Nothing in [sym3-blocks.md](../findings/sym3-blocks.md) addresses it, and the file's only sentence on the subject goes the other way:

> **$\Delta$ is a live lead for the search.** ... appears to vanish exactly on the orbit cone, the zero set $F_5$ is **conjectured** to have., [sym3-blocks.md:143](../findings/sym3-blocks.md#L143)

The lemma asserts as proved, 29 lines below, what its own file calls a conjecture.

**And there is a structural obstruction, which is the part worth recording.** The $q_i$ are cubics, hence odd: $q_i(-W)=-q_i(W)$. So any cubic vanishing on the orbit of $W_0$ vanishes on the orbit of $-W_0$ automatically, and $F_5$, being even, vanishes on both. The orbit of $-W_0$ is a *different* $O(5)$-orbit, $\theta$ is $O(5)$-invariant and $\theta(-W_0)=-\sqrt{3/2}\ne\theta(W_0)$. Consequently:

- **Read as a statement about the zero set of $F_5$, "vanishing exactly on that orbit" is REFUTED, with witness $-W_0$.**
- Read as a statement about equality in $\theta\le\sqrt{3/2}$, the witness does not bite ($\theta(-W_0)$ is the minimum, not the maximum) but the certificate can never distinguish the two orbits, because $F_5$ does not see the sign of $\theta$. **Even granting the zero set is exactly $\pm$ the orbit cone, the rigidity still needs the separate observation that $\theta>0$ selects one of the two.** That observation is one line and nobody has written it.

The record's actual support for the equality clause is numerical: 200 ascents in [sym3-blocks.md:153](../findings/sym3-blocks.md#L153), 3000 in the report, all reaching $1/\sqrt6$ at one critical value with negative semidefinite Hessian. That establishes attainment, which was never in doubt ($W_0$ is an explicit witness) and not uniqueness.

**Is it reachable?** Yes, and by a route the file half-describes. A sum of squares whose zero set is exactly a prescribed variety is a real-radical statement; here the natural handle is that $F_5=0$ at unit norm forces $W$ to be a global maximiser of $P$, hence a critical point, $Q(W)=\theta W$ with $\theta=\sqrt{3/2}$, after which the classification is a finite question about $\mathcal W_5$ and the second-order apparatus this programme already has. What is *owed* is that argument. What is **not** owed is more certificate: no psd Gram, however exact, decides it.

---

## 4. Scope, and $\Theta_5$ against $M(5)$

### The symbols are not the same object, and the section heading is false

[conventions.md](../findings/conventions.md) defines $\Theta_n$ as the **diagonal** maximum, $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$. At $n=5$ that is $\sqrt{16/18}=2\sqrt2/3=0.9428$. And $M(n)$ is the **global** maximum. So:

$$\Theta_5=\tfrac{2\sqrt2}3=0.9428\ \ne\ \sqrt{3/2}=1.2247=M(5).$$

The lemma proves a statement about *every* unit $W\in\mathcal W_5$, so what it proves is $M(5)=\sqrt{3/2}$. Therefore:

| where | writes | correct? |
| --- | --- | --- |
| [sym3-blocks.md:168](../findings/sym3-blocks.md#L168), the block heading | $\theta_5$ | undefined symbol, but reads as the global maximum, so the block itself is right |
| [sym3-blocks.md:104](../findings/sym3-blocks.md#L104), the named section heading | $\Theta_5=\sqrt{3/2}$ | **false** under conventions.md |
| [sym3-blocks.md:153](../findings/sym3-blocks.md#L153) | $\Theta_5=\sqrt{3/2}$, DECIDED | **false** as written; the mathematics beneath it is right |
| [results.md:204](../results.md#L204) and its heading | $\Theta_5=\sqrt{3/2}$ | **false**; the body of the entry states the correct global claim |
| [report/sections/07-gradedness-split.tex:878](../report/sections/07-gradedness-split.tex#L878), [09-status.tex:12](../report/sections/09-status.tex#L12), [diagram.tex:85](../report/sections/diagram.tex#L85) | $\Theta_5=\sqrt{3/2}$ | **false** in four further sites |

This is precisely warning [W5](../findings/INDEX-traps.md), and its stated cause, *"the file wanting the global maximum had no defined symbol for it and reached for the nearest"*, is the cause here too. [LEDGER.md:460](../findings/LEDGER.md#L460) has already logged the collision and closed it as *"holds. Both are true of different objects under one symbol"*. I disagree with that disposition: $B$, $M$ and $\mu$ carry two objects each because two objects are genuinely in play; here one object is in play, $M(5)$, and it is written under the symbol reserved for a different and smaller number. The row should be reopened. **Nothing mathematical turns on it**, since no consumer of L61 uses the value as a diagonal maximum, but six sites say a false thing.

### What L61 licenses at $n\ge12$, and what it does not

**Padding transfers upward, as a lower bound.** Let $U=\mathbb R^5\subset\mathbb R^n$. Padding by zero preserves $\mathop{\mathrm{tr}}(W^2)$ and $\mathop{\mathrm{tr}}(W^3)$ trivially, and preserves $W^\#$ because $\Lambda^2U=\mathfrak{so}(U)$ is a Lie *subalgebra* of $\mathfrak{so}(n)$: the sharp is built from structure constants $c_{\alpha\gamma\delta}$ contracted against $W$ in the last two slots, so a $W$ supported on $\Lambda^2U$ produces a $W^\#$ supported there, with the same values. The padded tensor stays Ricci-traceless. Hence $\theta$ is preserved exactly, and

$$M(n)\ \ge\ M(5)\ =\ \sqrt{3/2}\qquad\text{at every }n\ge5 .$$

That is the direction the transfer runs. [conventions.md](../findings/conventions.md) already records the inequality; **the L61 block says nothing about it**, and the file's only scope sentence, *"It does not lift"* at [sym3-blocks.md:155](../findings/sym3-blocks.md#L155), is about the method rather than the value.

**The upper bound does not transfer, and is false upward.** $\theta\le\sqrt{3/2}$ holds on the padded copy of $\mathcal W_5$ and nowhere else. At $n=12$ the balanced sphere product is an explicit counterexample: $\theta_0(12)^2=2\cdot11\cdot10/144=220/144$, so $\theta_0(12)=1.23604>1.224745=\sqrt{3/2}$. So the statement "$\theta\le\sqrt{3/2}$" is not merely unproved at $n=12$, it is **false**, with a witness the record already holds. This is the same crossover as $n^2-13n+18>0$ from result 44, it is exactly why $n\ge12$ is the threshold of Problem P.

**What it does license at $n\ge12$**, stated positively, is the stratum of Weyl operators whose support is a $5$-dimensional subspace: on that stratum $\theta\le\sqrt{3/2}<\theta_0(n)$ at every $n\ge12$, so no maximiser lives there. That is a real, narrow contribution, and it is the one the record does not state.

**One consumer claim that follows from the confusion.** [09-status.tex:12](../report/sections/09-status.tex#L12) and [09-status.tex:169](../report/sections/09-status.tex#L169) both say *"Conjecture A holds at $n=5$"*. Conjecture A, as [problem.md:469–472](../findings/problem.md#L469) pins it down, is a conjunction of an $n\ge12$ clause concluding at $\Theta_n$ and an $8\le n\le11$ clause with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed. It has no $n=5$ clause; and read as $\max P=\Theta_n$ it is *false* at $n=5$, where $M(5)=\sqrt{3/2}>2\sqrt2/3=\Theta_5$. What is true at $n=5$ is the analogue of the low-dimensional *exception* branch (the $\mathbb{CP}^2$ competitor wins) which is the opposite of the conjecture's $n\ge12$ conclusion. I did not edit the report; the correction is owed there.

---

## Checklist

| item | result |
| --- | --- |
| hedging clauses | *"has always been in this file"* (false; *"exact rational SOS certificate"*), exact, but "rational at denominator $10^5$" is not true of 13 of the 47 coordinates; *"Every step is exact over $\mathbb Q$"*, true of the arithmetic, and the identity step still rests on mod-$p$ ranks of machine-built matrices; *"with equality exactly on that orbit"*, asserted |
| numbers presented as identities | $\sqrt{3/2}$, $9$, $\tfrac32$: all derived, and I reproduced them. Denominator $10^5$: observed and wrong. $c=2$ in $\langle W,W^\#\rangle=2\mathop{\mathrm{tr}}(W^3)$: derived in [bispectral.md](../findings/bispectral.md), uncited by the block |
| does the file settle it above or below | **yes, twice**: the $\theta$ step is 15 lines *below* the block's own named section, and the equality claim is contradicted 29 lines above the block |
| do all pointers resolve | every script and JSON path resolves. The one prose pointer (the named section), does not carry the argument it claims |
| stray defect | [sym3-blocks.md:172](../findings/sym3-blocks.md#L172) uses `\CP` and `\Weyl`, macros defined in [report.tex](../report/report.tex) and in no markdown renderer. The block was pasted from the LaTeX |

## What is owed

1. **Repoint the block.** The argument for the "hence" is [Lemma L50](../findings/bispectral.md#L127); the block should cite it and the section it actually sits under, not the certificate table.
2. **Restate the equality clause as open**, or prove it. The route is the critical-point classification at $\theta=\sqrt{3/2}$, not more certificate; and it needs the sign remark, since $F_5$ is blind to it.
3. **Write $M(5)$ where $M(5)$ is meant**, in all six sites. Reopen [LEDGER.md:460](../findings/LEDGER.md#L460).
4. **Fold reviewers 213 and 214's corrections** (the rounding denominator and the factor-of-two packing), from the verifier's header into the file.
5. **State the scope positively**: $M(n)\ge\sqrt{3/2}$ at every $n\ge5$ by padding; $\theta\le\sqrt{3/2}$ false at $n\ge12$, witness the balanced sphere product; and the $5$-dimensional-support stratum closed at every $n$.

*No computation was performed beyond reading the record. The one thing a run would decide is nothing in this review: every claim above is settled by hand or by reading a file already on disk.*
