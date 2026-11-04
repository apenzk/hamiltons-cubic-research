# Reviewer r758, L173, the pinned class's kernel witness at $n=12$, Gate 2

**Cold from [BRIEF-g2-l173.md](BRIEF-g2-l173.md).** Every relation, cap and closed form below was re-derived by hand from the displayed coefficients before any repository file other than the brief and [L173.lean](../lean/HamiltonsCubic/Results/L173.lean) was opened. **No numerical work was done**: every value in this report is an exact rational or a surd handled symbolically, and the two exact-rational scripts I ran are *screens* of statements I had already derived by hand, reported as screens and never as evidence. **No Lean toolchain is installed on this machine** (`lake`, `lean` and `elan` are all absent) so the Lean audit below is an audit of *statements*, which is what the brief asked for; that the file compiles is unverified and I could not verify it. Log: [agent_logs/g2-l173-r758.log](../agent_logs/g2-l173-r758.log).

| # | claim | verdict |
| --- | --- | --- |
| 1 | The nine relations (A$_i$), (B$_i$), (C$_i$) hold at the witness as exact rational identities with $\theta/a=7$ | **CONFIRMED** |
| 2 | Pair-cap coefficients $\mu^{(ij)}_k=m_k-\delta_{ik}-\delta_{jk}$, including $i=j$ | **CONFIRMED** |
| 3 | All six caps hold; $(1,1)$, $(1,2)$, $(2,2)$ tight at $2$; $(1,3)=(2,3)=\tfrac8{59}$; $(3,3)=\tfrac{562}{1711}$ | **CONFIRMED** |
| 4 | Admissibility: every $m_i\ge3$, all ten types exist, no inadmissible type set nonzero | **CONFIRMED** |
| 5 | Forced parameters: $4+3+59=\binom{12}2$, $b=\tfrac43a$, $a=\sqrt{3/28}$ | **CONFIRMED** |
| 6 | $\theta=7a=\tfrac{\sqrt{21}}2$, $\tfrac{21}4>\tfrac{220}{144}$, ratio $\sqrt{189/55}$ | **CONFIRMED** |
| 7 | The $\theta$ of (C) is the functional's $\theta$, the claim the conclusion rests on | **CONFIRMED**, and the direction of use corrected: the lemma needs only soundness, not realizability |
| 8 | The conclusion's quantifier: one point at one spectrum defeats the whole method class | **CONFIRMED**, with a scope clause that must be written down |
| 9 | *"positivity and support alone"*, the word **support** | **AMBIGUOUS, REPAIR OWED**: on one reading the record's own next sentence contradicts the conclusion |
| 10 | The kernel mechanism is the $\{1,3,3\}$ weight $3422$ against $20$ | **CONFIRMED at $n=12$, INCOMPLETE as an account**: at $n=8$ that term is $0$ and the witness still gives $\theta=\tfrac{\sqrt{21}}2$ |
| 11 | [L173.lean](../lean/HamiltonsCubic/Results/L173.lean) checks *"all nine relations"* | **REFUTED**: `row2_B` states the (B$_3$) cancellation, not (B$_2$); (B$_2$) and (C$_3$) are checked nowhere |
| 12 | [L173.lean](../lean/HamiltonsCubic/Results/L173.lean)'s `unit_norm` and `theta_closed_form` | **VACUOUS**: hypothesis $a^2=3/28$ over $\mathbb Q$ has no solution, so both are empty |
| 13 | [L173.lean](../lean/HamiltonsCubic/Results/L173.lean)'s docstring *"that the witness is nonnegative"* is checked | **REFUTED**: no theorem in the file states it |
| 14 | [L173.lean](../lean/HamiltonsCubic/Results/L173.lean)'s owed item, [L104](../findings/bounds-relaxations.md)'s value-type reduction | **OVERSTATED**: the direction the lemma uses is an elementary lift, not L104 |
| 15 | Whether the witness survives at $n\ne12$ | **IT DOES, at every $n\ge8$**, with the same $\theta=\tfrac{\sqrt{21}}2$, a strengthening the lemma does not claim |

**Actionable summary.** The lemma is right and its arithmetic is exact at every one of the twenty-two checked quantities; fix the machine check, which is missing (B$_2$) under a mislabel and carries two vacuous $\mathbb Q$-theorems, and pin the word *"support"* to the admissibility sense before a reader takes the conclusion to exclude kernel-free hypotheses that the record's own following sentence relies on.

## 0. Conventions, fixed once

Indices $\alpha,\beta,\gamma$ run over an orthonormal eigenbasis $v_\alpha$ of $W$ inside $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$ of them, $Wv_\alpha=\lambda_\alpha v_\alpha$. $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ with $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, totally symmetric and vanishing whenever two indices coincide (*hollow* in the three-tensor sense). $t_{ijk}$ is the value of $T$ on the class-multiset $\{i,j,k\}$. **All sums over pairs are over ordered pairs of distinct indices**, this is the convention relation (A) takes and the one the whole witness lives or dies by; see section 10.

I write $\nu=a\cdot w$ with $w=(-1,\tfrac43,0)$ and $\tau=\theta/a$, so (A) is rational, (B) is rational, and (C) is rational in $\tau$. $\mu_j=m_j-\delta_{ij}$ at row class $i$; $\mu^{(ij)}_k=m_k-\delta_{ik}-\delta_{jk}$ at pair class $(i,j)$.

$\theta$ is $P(W)/\lVert W\rVert^3$ ([conventions.md](../findings/conventions.md)), and at a critical point $Q(W)=\theta W$. $\theta_0(n)^2=2(n-1)(n-2)/n^2$, giving $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}$.

## 1. Hypothesis inventory

| # | hypothesis | where it is used | status |
| --- | --- | --- | --- |
| H1 | $\lVert W\rVert=1$, i.e. $\sum_im_i\nu_i^2=1$ | forces $a=\sqrt{3/28}$ | stated in the brief's setting, load-bearing |
| H2 | $\mathop{\mathrm{tr}}W=0$, i.e. $\sum_im_i\nu_i=0$ | forces $b=\tfrac43a$ | stated, load-bearing |
| H3 | $N=\binom{12}2=66$ | forces $m_3=59$ | stated, load-bearing |
| H4 | $Q(W)=\theta W$ (criticality) | makes (C) a *necessary* condition on real points with the functional's $\theta$ | **unstated in the lemma's statement**, and it is what makes the conclusion mean anything, see section 7 |
| H5 | ordered-pair reading of (A): $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ | every (A$_i$) | stated in the brief; **the single most fragile input**, see section 10 |
| H6 | the pair cap constant is $2$, not smaller ([L31](../findings/stratum-two-negative.md)) | three caps sit exactly on it | stated; **also load-bearing**, since a cap below $2$ destroys the witness, see section 10 |
| H7 | the lift of $t$ to $T$ on $66$ indices is legitimate | turns three equations per row-class into $66$ rows | **elementary and not [L104](../findings/bounds-relaxations.md)**, see section 11 |
| H8 | $T\ge0$ entrywise | positivity of the ten values | satisfied |
| H9 | $n$ is even at $n=12$, so $\Theta_{12}=\theta_0(12)$ | the comparison target is the conjecture's own constant | satisfied; would matter at odd $n$, where $\theta_0>\Theta_n$ |

## 2. The forced parameters (attack item 4)

$4+3+59=66$ and $\binom{12}2=\tfrac{12\cdot11}2=66$. **Confirmed.**

Tracelessness: $\sum_im_i\nu_i=4(-a)+3b+59\cdot0=-4a+3b$, zero iff $b=\tfrac43a$. **Confirmed**, and note the third class contributes nothing to either normalisation, which is why the multiplicity $59$ is free to be whatever $N$ leaves over.

Unit norm: $\sum_im_i\nu_i^2=4a^2+3\left(\tfrac43a\right)^2=4a^2+\tfrac{16}3a^2=\tfrac{28}3a^2$, equal to $1$ iff $a^2=\tfrac3{28}$. **Confirmed.** The consequence worth naming: the whole unit-norm budget is carried by seven of the sixty-six eigenvalues, which is what makes $a$ as large as $0.3273\ldots$ and is the true engine of the lemma.

## 3. The nine relations (attack item 1)

Derived by hand, then screened in exact rational arithmetic. Both agree at every entry; the screen is reported as a screen.

**Row 1**, $\mu=(3,3,59)$.

- (A$_1$): $2\mu_1\mu_2t_{112}+\mu_3(\mu_3-1)t_{133}=18\cdot\tfrac23+3422\cdot\tfrac4{1711}=12+8=20=2(n-2)$. The reduction $3422=2\cdot1711$ is what makes $t_{133}=\tfrac4{1711}$ contribute exactly $8$.
- (B$_1$): only $\{1,1,2\}$ survives, coefficient $\mu_1\mu_2(w_1+w_2)=9\cdot\tfrac13=3$, giving $3\cdot\tfrac23=2=-2w_1$. The $\{1,3,3\}$ term dies on $w_3=0$.
- (C$_1$): coefficient $2\mu_1\mu_2w_1w_2=18\cdot(-\tfrac43)=-24$, giving $-24\cdot\tfrac23=-16$, against $2w_1(\tau-w_1)=-2(\tau+1)$, so $\tau=7$.

**Row 2**, $\mu=(4,2,59)$.

- (A$_2$): $\mu_1(\mu_1-1)t_{112}+\mu_2(\mu_2-1)t_{222}+\mu_3(\mu_3-1)t_{233}=12\cdot\tfrac23+2\cdot2+3422\cdot\tfrac4{1711}=8+4+8=20$.
- (B$_2$): $12\cdot(-1)\cdot\tfrac23+2\cdot\tfrac43\cdot2=-8+\tfrac{16}3=-\tfrac83=-2w_2$.
- (C$_2$): $12\cdot1\cdot\tfrac23+2\cdot\tfrac{16}9\cdot2=8+\tfrac{64}9=\tfrac{136}9$, against $2w_2(\tau-w_2)=\tfrac83\tau-\tfrac{32}9$, so $\tfrac83\tau=\tfrac{168}9$ and $\tau=7$.

**Row 3**, $\mu=(4,3,58)$.

- (A$_3$): $2\mu_1\mu_3t_{133}+2\mu_2\mu_3t_{233}+\mu_3(\mu_3-1)t_{333}=464\cdot\tfrac4{1711}+348\cdot\tfrac4{1711}+3306\cdot\tfrac{178}{32509}$. With $1711=29\cdot59$, $32509=19\cdot29\cdot59$, $3248=16\cdot7\cdot29$ and $3306=6\cdot19\cdot29$ this is $\tfrac{112}{59}+\tfrac{1068}{59}=\tfrac{1180}{59}=20$.
- (B$_3$): $\mu_1\mu_3(w_1+w_3)t_{133}+\mu_2\mu_3(w_2+w_3)t_{233}=-232\cdot\tfrac4{1711}+232\cdot\tfrac4{1711}=0=-2w_3$, the cancellation being $174\cdot\tfrac43=232$ together with $t_{133}=t_{233}$.
- (C$_3$): every term carries $w_3$ or $w_3^2$ except those on $t_{113}$, $t_{123}$, $t_{223}$, all zero at the witness; so $0=0=2w_3(\tau-w_3)$.

**All nine confirmed, with $\tau=7$ independently forced twice**, by (C$_1$) and by (C$_2$), which is the one genuinely non-trivial coincidence in the witness and the thing a transcription error would have broken.

Screen (exact `Fraction` arithmetic, seconds, on the objects above): all nine relations `True`, all six caps as claimed, $\sum m_iw_i=0$, $\tfrac3{28}\sum m_iw_i^2=1$.

## 4. The pair-cap coefficients, and the $i=j$ case (attack item 2)

$\sum_\gamma T_{\alpha\beta\gamma}$ runs over all $N$ indices $\gamma$, and hollowness kills $\gamma=\alpha$ and $\gamma=\beta$. So the count of surviving $\gamma$ in class $k$ is $m_k$ minus the number of the two excluded indices that lie in class $k$, which is $\delta_{ik}+\delta_{jk}$ **whether or not $i=j$**, because when $i=j$ both $\alpha$ and $\beta$ lie in class $i$ and both are removed, giving $m_i-2$. The record's $\mu^{(ij)}_k=m_k-\delta_{ik}-\delta_{jk}$ is therefore correct at the diagonal too. **Confirmed.**

The three diagonal pairs, which is where an error would hide because they are the tight ones:

| pair | $\mu^{(ij)}$ | cap value |
| --- | --- | --- |
| $(1,1)$ | $(2,3,59)$ | $2t_{111}+3t_{112}+59t_{113}=3\cdot\tfrac23=2$, **tight** |
| $(1,2)$ | $(3,2,59)$ | $3t_{112}+2t_{122}+59t_{123}=2$, **tight** |
| $(2,2)$ | $(4,1,59)$ | $4t_{122}+1\cdot t_{222}+59t_{223}=2$, **tight** |
| $(1,3)$ | $(3,3,58)$ | $58\cdot\tfrac4{1711}=\tfrac{232}{1711}=\tfrac8{59}$ |
| $(2,3)$ | $(4,2,58)$ | $58\cdot\tfrac4{1711}=\tfrac8{59}$ |
| $(3,3)$ | $(4,3,57)$ | $\tfrac{16}{1711}+\tfrac{12}{1711}+57\cdot\tfrac{178}{32509}=\tfrac{16+12+534}{1711}=\tfrac{562}{1711}$ |

using $57/32509=3/1711$. **All six confirmed, all $\le2$, three exactly $2$.** The $(2,2)$ row is the delicate one: $m_2=3$, so $\mu^{(22)}_2=1$ and the single remaining class-$2$ index carries the entire cap through $t_{222}=2$. That is right, and it is the coefficient a wrong $i=j$ rule would have got wrong.

## 5. Admissibility, positivity, and the ten types (attack items 3 and 9)

$m=(4,3,59)$, so $m_i\ge3$ at every $i$ and all ten class-multisets $\{i,j,k\}$ are admissible. **Confirmed.** The witness's five nonzero types are $\{1,1,2\}$ (needs $m_1\ge2$), $\{2,2,2\}$ (needs $m_2\ge3$, met with nothing to spare), $\{1,3,3\}$, $\{2,3,3\}$ (need $m_3\ge2$) and $\{3,3,3\}$ (needs $m_3\ge3$). **No inadmissible type is set nonzero.**

$m_2=3$ exactly is the edge worth checking and it survives twice over: in (A$_2$) the diagonal weight is $\mu_2(\mu_2-1)=2\cdot1=2$, the correct count of ordered pairs of distinct class-$2$ indices other than $\alpha$; in the $(2,2)$ cap the weight is $m_2-2=1$, the correct count of remaining class-$2$ indices. Both are right.

**$T\ge0$ at all ten types**: $t_{111}=t_{113}=t_{122}=t_{123}=t_{223}=0$, $t_{112}=\tfrac23$, $t_{222}=2$, $t_{133}=t_{233}=\tfrac4{1711}$, $t_{333}=\tfrac{178}{32509}$, ten values, all $\ge0$. **Confirmed at every one of the ten**, which section 12 notes the Lean file claims to check and does not.

## 6. The closed form (attack item 5)

$(7a)^2=49a^2=49\cdot\tfrac3{28}=\tfrac{147}{28}=\tfrac{21}4$, so $\theta=\tfrac{\sqrt{21}}2=2.29128784747792\ldots$ **Confirmed.**

$\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{220}{144}=\tfrac{55}{36}$, and $\tfrac{21}4=\tfrac{756}{144}>\tfrac{220}{144}$. **Confirmed**, and since both quantities are positive, $\sqrt{\cdot}$ is monotone and $\theta>\theta_0(12)$ follows.

Ratio: $\theta^2/\theta_0^2=\tfrac{21}4\cdot\tfrac{144}{220}=\tfrac{3024}{880}=\tfrac{189}{55}$, so $\theta/\theta_0=\sqrt{189/55}=1.85374\ldots$ **Confirmed**, and it agrees with $2.29129/1.23603$.

## 7. Is the $\theta$ of (C) the functional's $\theta$? (attack item 6, the load-bearing one)

**It is, and I derived the identification cold rather than taking the record's word.** In the eigenbasis of $W$, with $W$ diagonal, Hamilton's $\#$ has diagonal $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta=\tfrac12\sum_{\gamma\delta}T_{\alpha\gamma\delta}\lambda_\gamma\lambda_\delta$ over ordered pairs. So

$$Q(W)_{\alpha\alpha}=\lambda_\alpha^2+\tfrac12\sum_{\gamma\delta}T_{\alpha\gamma\delta}\lambda_\gamma\lambda_\delta,$$

and $Q(W)=\theta W$ read on the diagonal is $\sum_{\gamma\delta}T_{\alpha\gamma\delta}\lambda_\gamma\lambda_\delta=2\lambda_\alpha(\theta-\lambda_\alpha)$, **relation (C) verbatim**, with $\theta$ the eigenvalue in $Q(W)=\theta W$. Grouping the ordered pairs by class gives $2\mu_j\mu_k$ off the diagonal and $\mu_j(\mu_j-1)$ on it, exactly the displayed (C$_i$). And at a critical unit $W$, pairing $Q(W)=\theta W$ with $W$ gives $P(W)=\langle W,Q(W)\rangle=\theta$, which is the quantity [Conjecture A](../findings/problem.md) bounds by $\Theta_n$, equal to $\theta_0(n)$ at even $n$ and so at $n=12$. **The two $\theta$'s are one symbol and the identification is sound.** This also matches [bounds.md](../findings/bounds.md)'s own line, *"(C) is literally the diagonal of $Q(W)=\theta W$, which is why it needs criticality while (A) and (B) do not"*, which I read only after deriving it.

**But the brief's warning, *"a witness with a large $\theta$ in the relaxation says nothing unless that $\theta$ is the functional's"*, points at a hazard the lemma does not actually run into, and it is worth saying exactly why.** The lemma is not asserting that some Weyl operator has $\theta=2.29$; if it were, it would be refuting Conjecture A, and the witness's spectrum is almost certainly not realizable at all. What the lemma needs is the **soundness direction only**:

> every critical unit $W$ with spectrum $\lambda$ has its own $(T_W,\theta_W)\in\Pi(\lambda)$, with $\theta_W$ the functional's value.

That direction is what I derived above, and it gives $\theta_W\le\theta^\ast(\lambda):=\sup\{\theta:(T,\theta)\in\Pi(\lambda)\}$. A method that proves Conjecture A "from (A), (B), (C), positivity and support alone" is a method that bounds $\theta^\ast(\lambda)$; exhibiting one $\lambda$ with $\theta^\ast(\lambda)\ge\tfrac{\sqrt{21}}2>\theta_0(12)$ shows no such method can reach $\theta_0(12)$. **Realizability of the witness is not needed and would in fact be fatal if it held.** So the answer to item 6 is: the identification is correct, and the conclusion would survive even a demonstration that this spectrum is unrealizable, that is precisely the point being made. I recommend the lemma say this in one sentence, because a reader who reaches for the natural objection deserves to find it already answered.

**One thing I could not close and the record should not claim.** I did not establish, and the lemma does not need, that $(-a)^4,(\tfrac43a)^3,0^{59}$ is the spectrum of any $W\in\mathcal W_{12}$. It is unverified. If the sentence is ever read as "there is a Weyl operator with a large $\theta$", it is false or at least unproved; as a statement about $\Pi(\lambda)$ it is proved. That distinction is the whole content of the lemma.

**A strengthening I derived and the lemma does not claim: at this spectrum $\tfrac{\sqrt{21}}2$ is not merely feasible, it is the exact maximum.** With $w_3=0$, (C$_1$) reads $-24t_{112}+6t_{111}+\tfrac{32}3t_{122}=-2(\tau+1)$, so

$$\tau=12t_{112}-3t_{111}-\tfrac{16}3t_{122}-1.$$

The $(1,1)$ cap gives $3t_{112}\le2-2t_{111}-59t_{113}$, hence $\tau\le7-11t_{111}-236t_{113}-\tfrac{16}3t_{122}\le7$, **with equality iff $t_{111}=t_{113}=t_{122}=0$ and the $(1,1)$ cap is tight**. Row 2 gives the same ceiling independently: $\tfrac83\tau=12t_{112}-\tfrac{64}3t_{122}+\tfrac{32}9t_{222}+\tfrac{32}9$ with $t_{112}\le\tfrac23$ and $t_{222}\le2$ yields $\tfrac83\tau\le8+\tfrac{64}9+\tfrac{32}9=\tfrac{56}3$, so $\tau\le7$ again. **So $\theta^\ast=\tfrac{\sqrt{21}}2$ exactly at this spectrum, the witness attains it, and its support pattern is forced by the equality case**, using only (C$_1$), the $(1,1)$ cap and $T\ge0$, with (A) and (B) never invoked. This also confirms the record's *"the cap is what pins the witness"* in the only sense that can be checked from the lemma's own data: without the cap the ceiling $\tau\le7$ disappears entirely. The record's *"$t_{112}$ runs to $0.8985$ and $\theta$ to $3.2020$"* is consistent with the displayed relation, $\tau=12(0.8985)-1=9.782$ and $9.782\,a=3.2019$, but it is a figure from a run I have not reproduced and it is not load-bearing.

## 8. The conclusion's quantifier (attack item 7)

**What one feasible point at one spectrum at one dimension does establish.** Fix the method class $\mathcal M$: proofs whose only inputs about $(\lambda,T,\theta)$ are that $\lambda$ is a trace-free unit multiset of $N=\binom n2$ reals, that $T$ is totally symmetric, hollow and $\ge0$ on the class-multisets the multiplicities admit, that (A), (B), (C) hold at every row, and that the pair cap holds at every pair. Any $f\in\mathcal M$ proves at most $\theta\le\sup_\lambda\theta^\ast(\lambda)$, and section 7 gives $\sup_\lambda\theta^\ast(\lambda)\ge\tfrac{\sqrt{21}}2$ at $n=12$. **So no $f\in\mathcal M$ proves $\theta\le\theta_0(12)$.** One point suffices, because the quantifier the method must satisfy is universal over spectra and the witness is a counterexample to that universal. **Confirmed**, and the "one dimension" worry is answered outright by section 13: the same construction runs at every $n\ge8$, so it defeats a uniform-in-$n$ method as squarely as it defeats an $n=12$ one.

**What it does not rule out**, and this should be written into the lemma rather than left to a reader:

- bounds that use **realizability**, that $\lambda$ is the spectrum of some $W\in\mathcal W_n$, or that $T$ is the squared structure-constant tensor of an eigenbasis of one. The witness is presumably not realizable and the lemma is silent about such bounds.
- bounds that use the **first Bianchi identity** or any property of $\mathcal W_n$ beyond "symmetric traceless on $\Lambda^2$".
- bounds that use the **off-diagonal** part of $Q(W)=\theta W$; only the diagonal is (C), and [fence-posts.md](../findings/fence-posts.md) already calls the off-diagonal relations "the untouched reserve".
- bounds using a moment outside the span of (A), (B), (C) with polynomial weights, the $\{2,2,0\}$ pattern named in [INDEX-traps.md](../findings/INDEX-traps.md).
- bounds carrying a **kernel-free hypothesis**, which is the next item.

## 9. *"and support alone"*, the word that needs pinning (attack item 7, second half)

**On the admissibility reading the clause is correct; on the natural reading it is contradicted by the record's own next sentence.** The argument uses "support" in exactly one way: which class-multisets exist, given the multiplicities, and here all ten do, so support restricts nothing at this witness and the clause costs the lemma nothing. Fine.

But *support* is also the natural word for **where the spectrum's mass sits**, and the witness's defining feature is a zero class of multiplicity $59$, that is, a $59$-dimensional kernel. A bound proved under "no kernel" is a bound that uses support in that second sense, and it is untouched by this witness. The record itself concedes this in the sentence immediately following the conclusion, *"every spectral item must be kernel-free or carry a relation that is non-vacuous on zero rows"*, so under the second reading the conclusion and its own gloss disagree. **Repair owed: one clause pinning "support" to the admissible-type sense, e.g. "positivity, and the admissibility of class-multisets, alone".** Located exactly: the sentence at [bounds-relaxations.md](../findings/bounds-relaxations.md) beginning *"Hence no bound proved from (A), (B), (C), positivity and support alone"*. Arguing the opposite, as the brief requires: the strongest reading the words support is that "support" abbreviates "the support conditions of the value-type reduction", which is the admissibility sense and is what the proof uses, that reading is available, it is what I believe was meant, and it is exactly why one clause fixes it rather than a rewrite.

## 10. The kernel mechanism, and how large $m_3$ must be (attack item 8)

**The stated mechanism is correct at $n=12$.** In (A$_1$) the type $\{1,3,3\}$ carries weight $\mu_3(\mu_3-1)=59\cdot58=3422$ against a right-hand side of $20$, so $t_{133}=\tfrac4{1711}$ (a value smaller than $\tfrac1{400}$), supplies $8$, two-fifths of the row's mass. In (B$_1$) the same type's coefficient is $\mu_3(\mu_3-1)\nu_3=0$ and in (C$_1$) it is $\mu_3(\mu_3-1)\nu_3^2=0$. So the kernel absorbs (A)-mass at zero cost in (B) and (C). **Confirmed.**

**Does it need $m_3$ large or merely $\ge3$? Both thresholds are real and they are different thresholds.**

- $\{i,3,3\}$ exists at $m_3\ge2$; $\{3,3,3\}$ exists at $m_3\ge3$. The latter is what carries row 3's own mass here, $\tfrac{1068}{1180}$ of it, so $m_3\ge3$ is the existence threshold for the full witness.
- **Absorption capacity is linear in $m_3$**, and this is the quantitative threshold. The $(i,3)$ cap contains the term $(m_3-1)t_{i33}\le2$, so $t_{i33}\le\tfrac2{m_3-1}$, and the (A$_i$) contribution is at most $m_3(m_3-1)\cdot\tfrac2{m_3-1}=2m_3$. So the kernel can carry the whole row mass $2(n-2)$ only when $m_3\ge n-2$. At $n=12$, $m_3=59\gg10$, with enormous slack, which is why the caps at $(1,3)$ and $(2,3)$ read $\tfrac8{59}$ rather than anything near $2$.

**The record's account is correct but not complete, and the incompleteness is visible one dimension down.** At $n=8$ the same construction has $2(n-2)=12=18\cdot\tfrac23$, so $t_{133}=t_{233}=0$: **the $\{1,3,3\}$ absorption term is exactly zero and $\theta$ is still $\tfrac{\sqrt{21}}2$.** So the $\{1,3,3\}$ coefficient is not the engine, it is the *repair* that lets rows 1 and 2 balance once $2(n-2)$ exceeds the $12$ that classes 1 and 2 alone can carry. The engine is simpler and I would state it thus: **(B$_1$) forces $t_{112}=\tfrac23$ and (C$_1$) then forces $\tau=12t_{112}-1=7$ using only classes 1 and 2, while the kernel does two jobs, it lets $N$ reach $\binom n2$ with only seven nonzero eigenvalues, so the unit-norm budget concentrates and $a$ is large, and it soaks up whatever row mass classes 1 and 2 cannot.** That is a sharper statement of the same phenomenon and it does not contradict what the record says.

## 11. What the machine-checked file states, and what it does not (the Lean audit)

I read [L173.lean](../lean/HamiltonsCubic/Results/L173.lean) as text. I could not compile it: **`lake`, `lean` and `elan` are all absent from this machine**, which blocks confirming the file builds and blocks nothing else in this review.

**(i) `row2_B` is not (B$_2$). It is (B$_3$), stated a second time.** The theorem reads `174 * (4/3) = 232` and its docstring says *"Row 2: (B₂), which closes because $174b=232a$"*. At row class $2$ the multiplicity vector is $\mu=(4,2,59)$ and the six coefficients of (B$_2$) are $\{\tfrac83,-236,\tfrac{472}3,-12,\tfrac83,0\}$, **neither $174$ nor $232$ occurs among them, nor as a product of entries of $\mu$**. Both numbers come from row 3: $174=\mu_2\mu_3=3\cdot58$ and $232=\mu_1\mu_3=4\cdot58$ at $\mu=(4,3,58)$, and $174\cdot\tfrac43=232$ is precisely the (B$_3$) cancellation, which the file already states, twelve lines below, as `row3_BC : (-232) * 1 + 174 * (4/3) = 0`. **So the file carries two theorems for (B$_3$) and none for (B$_2$).** Arguing the opposite: could $174\cdot\tfrac43=232$ be an auxiliary identity consumed inside (B$_2$)? No, at this witness (B$_2$) involves only $t_{112}$ and $t_{222}$, with coefficients $-12$ and $\tfrac83$, and closes as $-8+\tfrac{16}3=-\tfrac83$; nothing in it needs $174$ or $232$. **The defect is in the check, not in the mathematics**: I verified (B$_2$) by hand and by screen in section 3 and it holds. **The docstring's *"all nine relations hold as exact rational identities"* is therefore refuted as a description of the file, as is the identical claim in [lean/INDEX.md](../lean/INDEX.md), whose L173 row goes further and spells the error out, *"including row 2's closing on $174\cdot\tfrac43=232$ and row 3's on $232=174\cdot\tfrac43$"*, naming the same identity twice as two different rows.** Counting distinct relations covered: (A$_1$), (B$_1$), (C$_1$), (A$_2$), (C$_2$), (A$_3$), (B$_3$), **seven of nine**. (C$_3$) is also unstated; it is the trivial $0=0$ and needs no theorem, but it should not be counted.

**(ii) `unit_norm` and `theta_closed_form` are vacuous over $\mathbb Q$.** Both are stated for `(a : ℚ)` under the hypothesis `a ^ 2 = 3 / 28`, and **no rational satisfies it**: $28p^2=3q^2$ forces $3\mid p$, then $q^2=84p'^2$, then $r^2=21p'^2$ with $q=2r$, and $21$ is not a square, so $p=q=0$. A theorem with an unsatisfiable hypothesis is true and empty, so the kernel establishes nothing at these two, including the file's headline `theta_closed_form`, the statement $(7a)^2=\tfrac{21}4$ that the whole lemma turns on. The algebra inside the proofs is correct and would carry over verbatim; **the repair is to state both over `ℝ` (or over an arbitrary field/`LinearOrderedField`) rather than `ℚ`**, which costs one word each and makes them non-vacuous. `traceless` is unaffected, being an unconditional `ring` identity true for every rational $a$ including $0$.

**(iii) The docstring claims nonnegativity is checked; no theorem states it.** *"What is checked here … that the witness is nonnegative"*, the file's sixteen theorems are `multiplicities`, `traceless`, `unit_norm`, `row1_A`, `row1_B`, `row1_C`, `row2_A`, `row2_B`, `row2_C`, `row3_A`, `row3_BC`, `caps_tight`, `caps_slack`, `theta_closed_form`, `exceeds_threshold`, `ratio_squared`, and **none of them is about $T\ge0$**. The fact is trivially readable off the numerals, which is presumably why it was skipped, but the docstring should not say it was checked. One conjunction of ten `0 ≤ _` fixes it.

**(iv) Two further statement-level notes, neither a defect.** `caps_slack` states the $(1,3)$ and $(2,3)$ caps through the single numeral `58 * (4/1711)`, dropping the vanishing $t_{113}$, $t_{123}$, $t_{223}$ terms and the distinct coefficient vectors $(3,3,58)$ and $(4,2,58)$; both caps do equal that number, so the statement is true but records less than the two rows it stands for. And `exceeds_threshold` compares squares, $\tfrac{220}{144}<\tfrac{21}4$; the step to $\sqrt{220}/12<\sqrt{21}/2$ is monotonicity of the square root on positives and lives outside the kernel, which the docstring's *"so"* concedes. $\theta_0(12)^2=\tfrac{220}{144}$ is imported as a numeral, not derived from $2(n-1)(n-2)/n^2$.

**(v) The file's stated debt is overstated, in the lemma's favour.** *"What is not [checked]: [L104](../findings/bounds-relaxations.md)'s value-type reduction, which is what licenses working with ten variables instead of $T$ itself."* **The lemma does not use L104.** L104's content is that the *supremum* over $\Pi(\lambda)$ is attained at a $G$-invariant $T$, which is the direction one needs to say the ten-variable optimum equals $\theta^\ast(\lambda)$. This lemma needs only **feasibility**, i.e. the opposite and elementary direction: define $T_{\alpha\beta\gamma}:=t_{ijk}$ for pairwise distinct $\alpha,\beta,\gamma$ in classes $i,j,k$ and $0$ otherwise. That $T$ is totally symmetric, hollow and $\ge0$ by construction, and at each of the $66$ rows the sum over ordered pairs of distinct indices $\ne\alpha$ groups by class into exactly $2\mu_j\mu_k$ off-diagonal and $\mu_j(\mu_j-1)$ diagonal terms, which is the counting I performed in section 3 and is all the ten displayed coefficients encode. **So the ten-variable system is a definition plus a count, and the lemma's only owed import is [L31](../findings/stratum-two-negative.md)'s cap and [L153](../findings/bounds.md)'s row marginal.** I recommend the docstring and the [lean/INDEX.md](../lean/INDEX.md) row say so, because as written they hand a reader a debt the lemma does not carry.

## 12. What would break it (attack item 10)

Named in order of how little it would take.

1. **The ordered-pair reading of relation (A).** Every row balances against $2(n-2)=20$. [conventions.md](../findings/conventions.md) records that the marginal has two readings in active use, $\sum_{\beta\gamma}T=2(n-2)$ and $\sum_{\beta<\gamma}T=n-2$, and that consumers use both. If the correct ordered value were $4(n-2)=40$, every (A$_i$) fails by a factor of two and the witness is infeasible. Nothing else in the lemma is this exposed, because (B) and (C) rescale with it while the *constants* $2(n-2)$ and $-2\nu_i$ do not.
2. **The pair cap constant $2$, from [L31](../findings/stratum-two-negative.md).** Three caps sit exactly on it. A cap of $c<2$ gives $t_{112}\le c/3$ and hence, by section 7's ceiling, $\tau\le4c-1$ (which is $7$ at $c=2$) so at $c=1$ the witness would give at best $\theta=3a=0.982<\theta_0(12)$ and **the lemma would fail entirely**. The lemma is sound in the direction that matters (a *larger* true cap only enlarges the feasible set) but the cap being at least $2$ is load-bearing for feasibility, and the witness is the tightest possible consumer of it.
3. **The diagonal weight $\mu_j(\mu_j-1)$**, not $\tfrac12\mu_j(\mu_j-1)$. Halving it turns (A$_1$) into $12+4=16\ne20$.
4. **The $i=j$ cap rule $m_i-2$.** If the removal were $m_i-1$, the $(2,2)$ cap would read $2t_{122}+2t_{222}+\ldots=4>2$ and the witness would violate a cap it currently saturates.
5. Not fragile: (C)'s right-hand factor $2$. Halving $2\nu_i(\theta-\nu_i)$ to $\nu_i(\theta-\nu_i)$ raises $\tau$ to $15$ and strengthens the lemma; an error there cannot break it.

## 13. Edges: $m_3=3$, other dimensions, and robustness (attack item 9)

**$m_3=3$ exactly.** The types survive ($\{3,3,3\}$ exists, with exactly one unordered triple) and the coefficients degrade correctly: $\mu_3(\mu_3-1)=6$ in (A$_i$) for $i\ne3$, $(m_3-1)=2$ in the $(i,3)$ cap, hence at most $6\cdot1=6$ of absorbable (A)-mass against $2(n-2)$. So the mechanism is *present* at $m_3=3$ and *sufficient* only when $m_3\ge n-2$. At $n=12$ the witness is nowhere near that edge; $m_3=59$ is forced by $N=66$ and the other two multiplicities, not chosen.

**Other dimensions, the witness is not special to $n=12$.** Keeping $m_1=4$, $m_2=3$, $\nu=a(-1,\tfrac43,0)$ and setting $m_3=\binom n2-7$, the same five types with $t_{112}=\tfrac23$, $t_{222}=2$, $t_{133}=t_{233}=\tfrac{2n-16}{m_3(m_3-1)}$ and $t_{333}$ solving (A$_3$) satisfies all nine relations and all six caps at **every $n\ge8$**, always with $\tau=7$ and hence $\theta=\tfrac{\sqrt{21}}2$, because $a$ is fixed by the two normalisations and those do not see $n$. Screened exactly at $n=7,8,\ldots,13,20,40$: relations, caps and nonnegativity all hold at $n\ge8$; at $n=7$ nonnegativity fails, since $2n-16<0$. **The screen reproduces $t_{333}=\tfrac{178}{32509}$ at $n=12$ from the general formula, which is an independent confirmation of the record's number by a route that does not read it.** Since $\theta_0(n)^2=2(n-1)(n-2)/n^2<2<\tfrac{21}4$ at every $n$, the witness exceeds $\theta_0$ at every $n\ge8$. This is my own construction, offered as a robustness observation rather than as part of the lemma; the lemma's $n=12$ instance stands on its own.

**Was $T\ge0$ checked at all ten types?** Yes, by me, in section 5, and no, by the Lean file, per section 11(iii).

## Overall verdict

**PROVEN, hypotheses corrected.**

The mathematics is right and exact at every checked quantity: nine relations, six caps, three tightnesses, four forced parameters, three closed forms, ten nonnegativities. $\theta/a=7$ is forced twice independently, and I showed in addition that $\tfrac{\sqrt{21}}2$ is the *exact maximum* of the capped relaxation at this spectrum rather than merely a feasible value. The claim the conclusion rests on (that (C)'s $\theta$ is the functional's), is confirmed by an independent derivation of (C) as the diagonal of $Q(W)=\theta W$, with the direction of use clarified: the lemma needs soundness, not realizability, and would survive a proof that the witness's spectrum is unrealizable.

Corrections owed, none touching the truth of the lemma:

1. **[L173.lean](../lean/HamiltonsCubic/Results/L173.lean)'s `row2_B` states (B$_3$), not (B$_2$)**, duplicating `row3_BC`; (B$_2$) is checked nowhere and the docstring's *"all nine relations"* and the [lean/INDEX.md](../lean/INDEX.md) row are refuted as written. Seven of nine relations are covered.
2. **`unit_norm` and `theta_closed_form` are vacuous**, their hypothesis $a^2=3/28$ being unsatisfiable over $\mathbb Q$. Restate over $\mathbb R$.
3. **The docstring claims nonnegativity is checked and no theorem states it.**
4. **The stated debt to [L104](../findings/bounds-relaxations.md) is overstated**: the lemma uses only the elementary lift from $t$ to $T$, not the value-type reduction's averaging argument.
5. **"support" in the conclusion must be pinned to the admissibility sense**, or the conclusion reads as excluding kernel-free bounds, which the record's own following sentence relies on.
6. **The scope of the conclusion should be written out**: it defeats every bound whose only inputs are (A), (B), (C), positivity and admissibility, at $n=12$ and in fact at every $n\ge8$; it is silent about bounds using realizability, Bianchi, the off-diagonal criticality block, a $\{2,2,0\}$ moment, or a kernel-free hypothesis.

**Unverifiable here, reported rather than filed as a caveat:** no Lean toolchain is installed (`lake`, `lean`, `elan` all absent), so I could not confirm the file compiles.
