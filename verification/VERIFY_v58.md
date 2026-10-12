# Verifier v58, Lemma L61, the $n=5$ sum-of-squares certificate and its four written forms

Verifier v58 of round [ROUND_L61](ROUND_L61.md), working from a cold brief. The definitions were taken from [conventions.md](../findings/conventions.md) and nowhere else; [sym3-blocks.md](../findings/sym3-blocks.md) was not opened, and neither was any report in [reviews/](../reviews/). **No numerical work was done and no script was executed.** Every value below is exact: the two constants I re-derive are derived by hand from the record's own structure constants, the counterexample I exhibit is a spectrum, and the two hand screens of certificate blocks are determinants of rationals. The log is at [verify-L61-v58.log](../agent_logs/verify-L61-v58.log).

## Claims attacked

| # | claim | verdict | reason |
| --- | --- | --- | --- |
| 1 | Step 1 ($(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ is one-dimensional | **NOT THE RECORD'S ARGUMENT**), the canon proves the collapse by Lovelock's syzygy ([L50](../findings/bispectral.md)), and one-dimensionality is that argument's by-product, not its premise |
| 2 | Step 2, the anchor $\theta(W_0)=3/\sqrt6$ against $\operatorname{tr}(W_0^3)=1/\sqrt6$ pins $c=2$ | **CONFIRMED, AND REDUNDANT**, $c=2$ falls out of [L153](../findings/bounds.md)'s row marginal at $n=4$ in four lines, with no anchor and no dimension count |
| 3 | Step 3, $P(W)=3\operatorname{tr}(W^3)$ on $\mathcal W_5$ | **PROVEN AT $n=4$ AND AT EVERY PADDED POINT** by my own derivation; on all of $\mathcal W_5$ it rests on a syzygy whose one free ratio is fixed numerically |
| 4 | Step 4, $F_5\ge0\iff\theta\le\sqrt{3/2}$, all norms, critical or not | **CONFIRMED**, and it is two-sided: $F_5\ge0$ says $\lvert\theta\rvert\le\sqrt{3/2}$. Vacuous at $W=0$, where $\theta$ is undefined |
| 5 | Step 5 (the Gram is positive definite, exactly, over $\mathbb Q$ | **CONFIRMED**), [run_n5_verify.py](../scripts/runs/run_n5_verify.py)'s test is sound and exact, and I hand-screened every $1\times1$ and $2\times2$ block |
| 6 | Step 6 (the Gram's sextic **is** $F_5$ | **GAP**), the support named in the record's own verifier is a **singular-value** rank, and the 120 sextics it was read off are not in the record |
| 7 | The shipped file verifies the certificate | **BROKEN AS DESCRIBED**, [n5_certificate.json](../scripts/runs/n5_certificate.json) carries no rows and no right-hand side, so the identity half is unverifiable from it in principle |
| 8 | "with equality exactly on that orbit" | **HYPOTHESIS-DEBT**, nothing on file bounds $\{F_5=0\}$ from above, and cubics being odd the SOS zero set contains a second, provably distinct orbit |
| 9 | $M(5)\ge\sqrt{3/2}$, the half that makes the max an equality | **CONFIRMED** by hand, exactly |
| 10 | Forms A, B, C and D state the same thing | **THEY DO NOT**, B and D say *exact rational*, C says *measured*, and C alone declines the equality clause that A, B and [results.md:625](../results.md) all assert |

**One line the round can act on:** the inequality $\theta\le\sqrt{3/2}$ on $\mathcal W_5$ is sound in every step except the one that turns 40 sampled agreements into an identity, and that step is carried by a floating-point rank on data the record does not hold, so Forms B and D's phrase *exact rational certificate* overstates what is on file, and the equality clause A, B and the detail block assert is debt that C alone books honestly.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\mathcal W_n$, "the space of algebraic Weyl curvature operators on $\mathbb R^n$", of dimension $\frac{n(n-3)(n+1)(n+2)}{12}$, which is $35$ at $n=5$.
- $Q(W)$ ("Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"; $P(W)$), "the cubic form $\langle W,Q(W)\rangle$"; $\theta$, "$P(W)/\lVert W\rVert^3$".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$, $M(n)=\max\{P(A):\lVert A\rVert=1\}$", and "**Distinct from $\Theta_n$, which is the *diagonal* maximum**".
- $\Theta_n$, "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- The pairing, "**The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix", so on the pair matrix $\lVert W\rVert^2=\operatorname{tr}(W^2)$ and $\langle W,W^2\rangle=\operatorname{tr}(W^3)$ with **no** half. This is the reading under which "$\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$" holds, and it is the one Step 3 needs.
- Structure constants, "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric** … so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide"; and a bivector "$\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing … which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal".
- The row marginal, "$\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$", which is [Lemma L153](../findings/bounds.md), and in the ordered reading "$\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$".
- Padding, "**Padding commutes with $Q$**, and preserves both the norm and $\theta$."
- $W_0$, $H$, "the $n=5$ base point of the $\mathrm{Sym}^3$ machinery and its stabiliser $H\subset O(5)$, the orbit $O(5)\cdot W_0$ being the zero set a certificate must vanish on … *Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically.*"

That last clause is the record's own, and §8 below is what follows from it once one asks whether $-W_0$ is on the orbit.

## The hypothesis inventory

Every hypothesis the four forms carry, every hypothesis their imports carry, and whether the written argument uses it.

| # | hypothesis | carried by | checked against the object? | used? |
| --- | --- | --- | --- | --- |
| H1 | $W\in\mathcal W_5$ (symmetric on $\Lambda^2\mathbb R^5$, first Bianchi, Ricci-trace-free | all four forms | yes), every step is a polynomial identity on that space, and $W_0$ is verified to lie in it ($\mathcal W_4\subset\mathcal W_5$ by padding) | yes, in Step 3 (Bianchi and tracelessness are what leave only two cubic contractions) |
| H2 | $n=5$ exactly | Steps 1, 3 | yes | **load-bearing**, the syzygy fails at $n=6$, and [bispectral.md](../findings/bispectral.md) says so in terms |
| H3 | $\operatorname{tr}(W_0^3)\ne0$, so the anchor pins something | Step 2 | yes, $=1/\sqrt6$ | yes, under the brief's route; **unused** under the record's |
| H4 | $Q$ maps $\mathcal W_n$ to itself | the definition of $P$ | yes, [conventions.md](../findings/conventions.md) cites Böhm–Wilking for it | yes |
| H5 | $\lVert W\rVert\ne0$ for $\theta$ to be defined | Step 4 | **not stated in any of the four forms**, "$\theta\le\sqrt{3/2}$ on $\mathcal W_5$" is a statement at $W=0$ too, where $\theta$ is $0/0$ | not used, and harmless: see §4 |
| H6 | the certificate's Gram is Hermitian | Step 5 | yes, forced by construction in [run_n5_verify.py](../scripts/runs/run_n5_verify.py) and re-checked by asserting each power-trace real | yes, the PD test is valid only for real spectrum |
| H7 | the ambient block pairing $Q$ on each $V_\lambda$ is **positive** definite | Step 5, to read a Hermitian PD Gram as a sum of squares | asserted in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py)'s preamble ("a uniform positive **scalar** per block that $G$ absorbs"); the sign is what makes it a sum rather than a difference of squares | yes, silently, no form states it |
| H8 | evaluation at the 40 sample points is injective on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ | Step 6 | **this is the gap**, §6 | yes, decisively |
| H9 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ | Step 6, as the cap the rank is read against | three machine routes (Weyl integration, Kostant, plethysm); no hand argument on file | yes |
| H10 | the rational reconstruction from four $40$-bit primes returned the true rationals | the whole affine-membership check in [run_n5_lift.py](../scripts/runs/run_n5_lift.py) | guarded by `max(hts) < BOUND`, the standard criterion, which is a soundness *guard* and not a proof | yes, silently, no form states it |
| H11 | $V_{\mathbb R}(K)=O(5)\cdot W_0$, the cubics' common real zero locus is the orbit | the equality clause of Forms A and B | **nothing on file**, §8 | yes, decisively, for the clause |
| H12 | block-diagonality of the Gram | the certificate's shape | not needed for soundness, one PD Gram in any shape suffices; it is a completeness convenience | **not used**, correctly |
| H13 | the anchor value $\theta(W_0)=3/\sqrt6$ is computed independently of $P=3\operatorname{tr}W^3$ | Step 2 | if it is not, Steps 2 and 3 are one circle | §2 settles it: I recomputed both sides from the structure constants and they agree |

**Two entries with no user.** H3 and H12 are hypotheses nobody needs: under the record's actual route (§1) the constant comes from a syzygy and not from a point, and block-diagonality is a shape convenience that no step of the soundness argument consumes. **Two users with no entry.** H7 and H10 are consumed by the argument and stated in no form of the claim, H7 decides the *sign* of the whole certificate, and H10 is the only reason the exactly-checked affine membership is a statement about the true rows rather than about four congruences.

## 1. Step 1, the dimension claim is not where the brief puts it, and the record argues something stronger

The brief presents one-dimensionality of $(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ as the first step. **The canonical statement does not use it.** [results.md:625](../results.md) reads:

> Since $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$ on $\mathcal W_5$ (the cubic collapses to one spectrum, Lemma L50), $P(W)=3\operatorname{tr}(W^3)$ there …

and [L50](../findings/bispectral.md)'s own file gives a mechanism rather than a count:

> On $\mathrm{Weyl}_n$ for $n\le5$, and only there, $\beta=\tfrac12\alpha$ … The mechanism: $\beta-\tfrac{\alpha}{2}=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}$, and the generalized Kronecker delta over six indices vanishes identically when $n\le5$, Lovelock's dimensionally-dependent identity, obtained by antisymmetrising over $n+1$ indices.

This is the better argument and it subsumes the dimension claim: it proves the two cubic contractions are proportional at $n\le5$, which *is* one-dimensionality of the invariant cubics, given the standard first-fundamental-theorem fact that a complete contraction of three Weyl tensors reduces to $\alpha$ and $\beta$. The record even records the correction that a dimension-flavoured argument had got wrong once, "$\mathrm{Weyl}_5$ is $O(5)$-irreducible and collapses regardless, so reducibility is not the separating fact."

**What the mechanism still owes.** The Lovelock delta vanishing at $n\le5$ is elementary; the content is that the six-index contraction expands as $c_1\alpha+c_2\beta$ with $c_1/c_2=-\tfrac12$, and the record fixes that ratio by measurement: "The constant $-64$ is verified at $n=6,7,8$ ([run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py))." The ratio is the whole content (once it is known, the conclusion at $n\le5$ is immediate) so the collapse rests on a finite exact expansion that the record obtained by evaluation rather than by expansion. The controls are unusually good for a measured link (the sample provably spans $\mathrm{Weyl}_4$ and $\mathrm{Weyl}_5$ at ranks 10 and 35, and the identity holds over 64 polarisations, so it is an identity of trilinear forms rather than of the diagonal). It remains a measured link.

## 2. Step 2, the anchor is consistent, and it is not needed

**The two quoted values are consistent with each other and with [conventions.md](../findings/conventions.md).** $W_{\mathbb{CP}^2}$ is self-dual with $W_-=0$ and $W_+$ of eigenvalue ratio $(2,-1,-1)$ on $\Lambda^2_+$. Writing the eigenvalues $a(2,-1,-1)$: $\operatorname{tr}W=0$ automatically, $\lVert W\rVert^2=\operatorname{tr}(W^2)=6a^2$ so unit norm gives $a=1/\sqrt6$, and $\operatorname{tr}(W^3)=6a^3=1/\sqrt6$. Padding to $n=5$ changes neither, since padding preserves the norm and $\theta$. So $\operatorname{tr}(W_0^3)=1/\sqrt6$ exactly, and $P(W_0)=3\operatorname{tr}(W_0^3)=3/\sqrt6=\sqrt{3/2}$, which is $\theta(W_0)$ at unit norm. **The pair is consistent, and $\sqrt{9/6}=\sqrt{3/2}$ is the headline constant, so nothing is off by a factor here.**

**But the constant does not need an anchor, and I pin it independently.** In an eigenbasis, the record's own conventions give
$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\gamma\varepsilon}T_{\alpha\gamma\varepsilon}\lambda_\alpha\lambda_\gamma\lambda_\varepsilon=3\!\!\sum_{\alpha<\gamma<\varepsilon}\!\!T_{\alpha\gamma\varepsilon}\lambda_\alpha\lambda_\gamma\lambda_\varepsilon,$$
which is exactly the display at [target.md:751](../findings/target.md), so the $\#$ convention is the record's. Now take $n=4$ and $W$ supported on $\Lambda^2_+$, with $\{\omega_1^+,\omega_2^+,\omega_3^+\}$ orthonormal under the half-trace pairing. The only triple of distinct indices on which all three eigenvalues are nonzero is $(1,2,3)$ inside $\Lambda^2_+$, so $\langle W,W^\#\rangle=3\,T_{123}\,w_1w_2w_3$. And $T_{123}$ is read straight off [Lemma L153](../findings/bounds.md): $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)=4$ at $\alpha=\omega_1^+$, while the only ordered pairs contributing are $(\omega_2^+,\omega_3^+)$ and $(\omega_3^+,\omega_2^+)$ ($\Lambda^2_+$ commutes with $\Lambda^2_-$) so $2T_{123}=4$ and $T_{123}=2$. With $\operatorname{tr}W=0$ giving $w_1^3+w_2^3+w_3^3=3w_1w_2w_3$,
$$\langle W,W^\#\rangle=6\,w_1w_2w_3=2\operatorname{tr}(W^3).$$

So $c=2$, derived, not measured, and derived from the record's own numbered marginal. The same count gives the same constant on $\Lambda^2_-$, so it holds on all of $\mathcal W_4$; and since padding commutes with $\#$ and the extra $2(n-2)$ marginal mass at $n=5$ sits on directions where $\lambda=0$, it holds at every padded point of $\mathcal W_5$. **H13 is discharged: Step 2's two quoted values are not the definition of each other.**

What this does *not* give is the identity on all of $\mathcal W_5$, since a generic $W\in\mathcal W_5$ is not padded. That remains §1's business.

## 3. Step 3, where the statement is proven and where it is cited

$P(W)=\langle W,W^2\rangle+\langle W,W^\#\rangle=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$, the first term with **no half**, per the pairing convention quoted in §0. With $c=2$ this is $3\operatorname{tr}(W^3)$.

| where | status |
| --- | --- |
| all of $\mathcal W_4$ | **proven**, §2, by hand |
| every padded point of $\mathcal W_5$, $W_0$ included | **proven**, §2, by hand |
| all of $\mathcal W_5$ | **cited** to [L50](../findings/bispectral.md), whose one free ratio is measured (§1) |

This is the brief's item 4 answered: the part I could re-derive is the padded subfamily, and the certificate is applied on the whole space. That is not a defect of L61 (L50 is a numbered result with Gate 2 recorded) but it is where the general statement actually rests, and no form of L61 says so. Forms A, B, C and D all present the collapse as ambient, and only the detail entry at [results.md:625](../results.md) names L50.

## 4. Step 4, the equivalence, at every $W$

$F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ and $P=3\operatorname{tr}(W^3)$ give $F_5=\tfrac32\lVert W\rVert^6-P^2$ identically on $\mathcal W_5$. Both sides are homogeneous of degree 6, so:

- **At $\lVert W\rVert\ne1$** the equivalence is exact and needs no normalisation: $F_5(W)\ge0\iff P(W)^2\le\tfrac32\lVert W\rVert^6\iff\lvert\theta(W)\rvert\le\sqrt{3/2}$.
- **The bound delivered is two-sided.** $F_5\ge0$ says $\lvert\theta\rvert\le\sqrt{3/2}$, strictly more than the one-sided $\theta\le\sqrt{3/2}$ the forms state. Harmless, but it is why §8's second orbit is in the zero set.
- **At $W=0$** $F_5=0$ and $\theta$ is $0/0$. "$\theta\le\sqrt{3/2}$ on $\mathcal W_5$" is therefore a statement with an undefined instance. Nothing turns on it and the repair is one word ("on the unit sphere", or "for $W\ne0$"), but H5 is a hypothesis nobody stated.
- **No criticality anywhere.** Forms B and D's "critical or not" is honest: every step is a polynomial identity or a pointwise nonnegativity, and $Q(W)=\theta W$ is used at no point.

**Verdict: CONFIRMED.** This is the cleanest step in the chain and I rebuilt it from the definitions in three lines.

## 5. Step 5, what [run_n5_verify.py](../scripts/runs/run_n5_verify.py) checks, exactly

**What it checks.**

1. That the 47 rational coordinates match $\sum_k k^2$ over the shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$, $9{+}9{+}4{+}1{+}4{+}1{+}4{+}1{+}4{+}4{+}1{\cdot}6=47$, and the assertion fires if not.
2. That each block is Hermitian, by asserting every Faddeev–LeVerrier power-trace has zero imaginary part.
3. That each block is positive **definite**, via the characteristic polynomial over $\mathbb Q$ and strict sign alternation. **The test is sound**: a Hermitian matrix has real spectrum, and for a real polynomial with all-real roots, $(-1)^mc_m>0$ for every $m$ is equivalent to $p(x)>0$ on $x\le0$, hence to every root being strictly positive. Exact over $\mathbb Q$, no elimination, no pivoting to get wrong, which is the point the file's own preamble makes, having been burned by an LDL that returned `True` on an indefinite matrix.
4. The same test on the halved-off-diagonal form $C=(M+\operatorname{diag}M)/2$, "the form the certificate actually represents", so the packing convention is not relied on.

**What it does not check.** It never touches the identity. It cannot: [n5_certificate.json](../scripts/runs/n5_certificate.json) contains only `denominator`, `point`, `shape` and `blocks`. **The rows and the right-hand side are not in it.** They live in the four [n5_rows_*.json](../scripts/runs/) files, which the verifier never opens. So "Verify n5_certificate.json from the file alone" is true and the file alone cannot carry the claim, everything after line 126 of that script is prose citing reviewers, not a check.

**Two hand screens, exact.** The point's block diagonals are all positive, which is the whole of the test for the ten $1\times1$ blocks: $11319/20000$, $2337/100000$ (six times), $12809/25000$, $3283/2500$ and the rest. For the four $2\times2$ blocks the packed determinant is diagonal product minus $\lvert\text{off}\rvert^2$, and all four are comfortably positive, block 2 gives $\tfrac{66829}{10^5}\cdot\tfrac{100879}{6250}-\big(\tfrac{80601}{25000}\big)^2\approx10.786-10.394>0$, block 6 gives $\approx0.01200-0.0000253>0$, block 8 $\approx0.0027308-0.0005253>0$, block 9 $\approx0.63676-0.12819>0$. Halving the off-diagonals only increases each margin. The two $3\times3$ blocks I did not screen by hand.

**One internal consistency check that passes and is worth recording.** The file's note says the `denominator` field "is the denominator imposed on the 34 kernel coefficients; 13 of the 47 coordinates come out with larger denominators". Counting the point, **exactly 13** coordinates carry a denominator above $10^5$, and $47-13=34$. That is the rank-13 bookkeeping of [L59](../results.md)/[L62](../results.md) showing up in the shipped data, and it agrees.

**Verdict: CONFIRMED**, for what it covers. Positive definiteness is exact, twice, by a test with no shared code with the producer.

## 6. Step 6, the identity, and the discrepancy

### D1, the identity half is carried by a floating-point rank, inside a file that opens by saying nothing numerical is consulted

**1, Located exactly.** [run_n5_verify.py:1](../scripts/runs/run_n5_verify.py) opens:

> Verify n5_certificate.json from the file alone. Nothing is imported from the producer, and **nothing numerical is consulted**.

and at line 143 the same file gives the identity's support:

> Building 120 explicit invariant sextics as complete contractions of six copies of W and evaluating them at the 40 points gives rank 14 against a cap of 14, **with a 14-decade singular value gap**.

A singular-value gap is a floating-point measurement. The claim it supports is H8, injectivity of evaluation on the 14-dimensional space of invariant sextics, which is the sole reason 40 agreements are an identity. So the second half of the certificate rests on a numerical rank, in a file whose first paragraph says no numerical thing is consulted.

**2, Exhibited concretely.** The object at which it breaks is the evaluation matrix itself: 120 invariant sextics against 40 points. The record does not hold it. [lean/INDEX.md](../lean/INDEX.md) states the consequence in terms, *"Closing it in Lean needs an exact rank over $\mathbb Q$ of that evaluation matrix, which needs the 120 invariant sextics as data. They are not in the record."* A numerical rank is neither an upper nor a lower bound on the true rank; the exact statement that would suffice is one nonzero $14\times14$ minor over $\mathbb Q$, and no such minor is on file. **Nothing I can read repairs this**, and by the standing rule I do not supply the argument: the finding is that H8 has no exact support on file.

**3, Argued the opposite, and this is where it gets interesting.** The strongest reading available to the author is that the *other* pieces of the record close H8 without the 120 sextics, because the rank actually needed is 13 rather than 14 and 13 is available exactly. [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) asserts `rk_A == 13` over $\mathbb F_p$ at four primes, and a mod-$p$ rank is a genuine lower bound on the rank over $\mathbb Q$; [L62](../results.md) caps the same rank at 13 from above by the exact fact that every reachable sextic vanishes at $W_0$. Those two together say evaluation is injective on the 13-dimensional space of reachable sextics, and $F_5$ lies in that space iff $F_5(W_0)=0$, which is checked exactly (`assert F5_of(W0T) == 0`, over $\mathbb F_p$ and true over $\mathbb Z$). **I record this as a reading the record's materials support, and not as a proof**: it needs H9's $14$ (three machine routes, no hand argument), it needs [L62](../results.md)'s cap, which is stated in [sym3-blocks.md](../findings/sym3-blocks.md) and I am forbidden to read, and its own status line calls its rank "one sampled mod-$p$ rank". So the opposite argument does not dissolve the discrepancy; it relocates it onto two other machine results and shows the float SVD is probably not the only route. **The discrepancy stands as reported: the support the verifier names is numerical, and the record's summaries call the whole thing exact.**

### D2, the shipped certificate cannot be re-checked on the half that matters

**1, Located.** [n5_certificate.json](../scripts/runs/n5_certificate.json) is 1341 bytes: a denominator, 47 rationals, a shape, and 16 block labels. The affine condition $\sum_kB_k\,\mathrm{row}_k(W)=F_5(W)$ needs `rows` and `rhs`, which are in the per-prime dumps and are dropped at write time by [run_n5_lift.py:288](../scripts/runs/run_n5_lift.py).

**2, Exhibited.** The consequence is precise: a reader handed the certificate and the verifier can establish that *some* Hermitian PD Gram exists, and nothing whatever about which sextic it represents. Positive definiteness alone is not a certificate of anything, it is a certificate that the point is in the PSD cone, and every point of a 34-dimensional cone interior would pass.

**3, Argued the opposite.** The affine membership **is** checked exactly, at production, over $\mathbb Q$: [run_n5_lift.py](../scripts/runs/run_n5_lift.py) asserts `sum(A[i][j]*xr[j] for j in range(NC)) == B[i]` for every one of the 40 rows before writing the file, with $A$ and $B$ the rationally reconstructed rows. So the check exists and was run; what is missing is only its inputs in the artefact. That is a reproducibility defect rather than a mathematical one, and it is the reason I report D2 as a defect of the *artefact* and not of the lemma. **It becomes mathematical at one remove**: the reconstruction guard is `max(hts) < BOUND` with `BOUND = int((M // 2) ** 0.5)`, a float square root of a 160-bit integer, accurate to about $2^{28}$ in a bound of about $2^{81}$. The slop is a relative $10^{-16}$ and I do not claim it bites; I record it because it is the one place where the "exact over $\mathbb Q$" pipeline routes a bound through a float (H10).

### D3, withdrawn: the row entries are not invariant

**Candidate.** [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py)'s preamble establishes, for its own route, that $\sum_{ij}G_{ij}P_i\overline{P_j}$ is generally *not* invariant, "$g^{-1}u_i$ does NOT lie in the span of the $u_j$: the highest-weight vectors span a Cartan-graded slice, not a $g$-stable subspace". [run_n5_verify.py](../scripts/runs/run_n5_verify.py) asserts the opposite of the shipped route: "Every row entry is an $O(5)$-invariant sextic". Two files of one pipeline, contradicting each other.

**Withdrawn at step 3.** They are different constructions. The refuted route paired one highest-weight vector per copy; the shipped route pairs multiplicity coordinates in the abstract $V_\lambda$, [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py): "$B_{ij}=\overline{c^i}^{\mathsf T}Qc^j$", with $c$ "coordinates in the ABSTRACT $V(\lambda)$". An invariant pairing of two $V_\lambda$-valued covariants is invariant. The verifier's sentence is correct for the object it describes, and the refuted route's warning does not reach it. **No finding.** I note only that [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py) is the record of a *refuted* route and its name is one character from the shipped artefact's, which is a trap for the next reader.

### D4, withdrawn: the assemble script demands the wrong rank

**Candidate.** [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py)'s preamble says "the coefficient matrix must have rank EXACTLY 14 … Rank above 14 means the equations are not all invariant", while the code 1200 lines later asserts `rk_A == 13`.

**Withdrawn at step 3.** Both are right about different matrices: 14 is the dimension of the invariant sextics, 13 the rank of the reachable ones, the drop being the exact vanishing at $W_0$ that [L62](../results.md) supplies. The docstring is stale rather than wrong-headed. Reported as presentation, not as a defect.

## 7. The edge of every range, the kernel

$W_0$ is the padded $W_{\mathbb{CP}^2}$: on $\Lambda^2\mathbb R^5$ its spectrum is $\{2/\sqrt6,\,-1/\sqrt6,\,-1/\sqrt6,\,0^{\times7}\}$, three nonzero eigenvalues on $\Lambda^2_+\subset\Lambda^2\mathbb R^4$, and a **seven-dimensional kernel**: the three anti-self-dual directions and the four $e_i\wedge e_5$. This is the record's recurring obstruction and the brief is right to ask.

| step | behaviour at $\ker W\ne0$ |
| --- | --- |
| Steps 1, 3, 4 | polynomial identities in $W$; no rank, no inverse, no eigenvalue-tolerance anywhere. **Unaffected.** |
| Step 2 | my derivation of $c=2$ runs *at* the degenerate point and uses the degeneracy constructively, the vanishing eigenvalues are exactly why only one triple contributes. **Unaffected.** |
| Step 5 | a statement about 16 rational matrices. **Unaffected.** |
| Step 6 | **this is where the kernel lives.** The 40 sample points come from `random_weyl`, so every sampled check (the rank 13, the consistency, the hold-outs), runs at points with trivial kernel. The one structural fact asserted *at* $W_0$ is that the block covariants vanish there, which is what puts every reachable sextic in the hyperplane $\{F(W_0)=0\}$ and what makes the rank 13 rather than 14. |

So the pattern the brief warns about is present but inverted: the degenerate point is not skipped, it is the *pivot* of the rank bookkeeping. The one check the pipeline runs at $W_0$ is exact (`assert F5_of(W0T) == 0`) and it fires before the solve. What I cannot check is the load-bearing step [conventions.md](../findings/conventions.md) names, "$\sigma_\lambda(W_0)\in V_\lambda^H$ because $H$ fixes $W_0$", because it is stated in the file this brief forbids. **I record it as unverified by me, at a point with a 7-dimensional kernel and rank-4 support in a 5-dimensional space, which is the most degenerate object in the argument.**

## 8. The equality clause

### D5, "with equality exactly on that orbit" has no argument on file, and the SOS route's zero set provably is not that orbit

**1, Located exactly.** [results.md:204](../results.md), [results.md:625](../results.md) and Form A all end "with equality exactly on that orbit". The support offered is the sum-of-squares certificate and nothing else.

**2, Exhibited concretely, in closed form.** A sum of squares gives $\{F_5=0\}=\bigcap_i\{q_i=0\}$ with $q_i$ the cubics of the decomposition. Two things follow immediately and neither is the claim.

- **$F_5$ is even.** $F_5(-W)=\tfrac32\lVert W\rVert^6-9\operatorname{tr}((-W)^3)^2=F_5(W)$. So $F_5(-W_0)=0$, and $-W_0$ is in the zero set. Equivalently, the cubics are odd, so each $q_i(-W_0)=-q_i(W_0)=0$, which is the clause [conventions.md](../findings/conventions.md) already carries: *"Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically."*
- **$-W_0$ is not on the orbit of $W_0$.** $O(5)$ acts on $\Lambda^2\mathbb R^5$ by conjugation, which preserves the spectrum. $\operatorname{spec}(W_0)=\{2,-1,-1,0^{\times7}\}/\sqrt6$ and $\operatorname{spec}(-W_0)=\{-2,1,1,0^{\times7}\}/\sqrt6$; these multisets differ. **So $\{F_5=0\}\supseteq O(5)\cdot W_0\sqcup O(5)\cdot(-W_0)$, a strict superset of the orbit, exhibited in closed form and with no computation.**

So an SOS certificate for $F_5$ can never have its zero set equal to a single non-symmetric orbit. And even the union is only a lower bound: nothing on file bounds $V_{\mathbb R}(K)$ from above, which is H11.

**3, Argued the opposite, and it is the strongest reading.** Read the clause as attaching to $\theta$ rather than to $F_5$: "$\theta\le\sqrt{3/2}$, with equality exactly on that orbit". Then $-W_0$ is no counterexample, $\theta(-W_0)=-\sqrt{3/2}$, and the sign of $\operatorname{tr}(W^3)$ separates the two orbits trivially. **Under that reading the clause is not refuted.** But it is not proven either, and by exactly the same missing ingredient: the $\theta$-equality set is $\{F_5=0\}\cap\{\operatorname{tr}W^3>0\}$, and one still needs $V_{\mathbb R}(K)$ from above to know it is one orbit. A real-Nullstellensatz statement about the common real zeros of a span of cubics is a separate theorem and there is none on file.

**Verdict: HYPOTHESIS-DEBT, not BROKEN.** What would have to be proved, precisely: *the common real zero locus of the cubics in $K$ is $O(5)\cdot W_0\cup O(5)\cdot(-W_0)$.* And the record already knows: [results.md:23](../results.md) says "the equality case is unproven and unreachable by that route". **That line and the three that assert the clause are in the same file.**

## 9. $M(5)=\sqrt{3/2}$, the lower half, which no form argues

Forms C and D are about $M(5)$, a maximum. The certificate is an upper bound. The other half is attainment, and it needs $P(W_0)=\sqrt{3/2}$ exactly at a unit $W_0\in\mathcal W_5$. **I verified it by hand in §2**: $W_0$ padded from $W_{\mathbb{CP}^2}$ has $\lVert W_0\rVert=1$, $\operatorname{tr}(W_0^3)=1/\sqrt6$, and $P(W_0)=\operatorname{tr}(W_0^3)+\langle W_0,W_0^\#\rangle=3\operatorname{tr}(W_0^3)=\sqrt{3/2}$ with the second term computed from [L153](../findings/bounds.md)'s marginal rather than assumed. The maximum is attained because the unit sphere of the 35-dimensional $\mathcal W_5$ is compact and $P$ is continuous. **This half is fully proven and it is the half no form of the claim mentions.**

## 10. Quantifier order and scope

Nothing is distributed. $F_5\ge0$ is a pointwise statement about a polynomial on a 35-dimensional vector space; there is no sup, no inf, and no variable shared between two separately bounded terms. The one scope point worth stating: the certificate bounds $\lvert P\rvert$, so it caps $M(5)$ and $-\min P$ at once, and the forms report only the first. The claim's scope over $n$ is likewise clean, L61 gives $M(5)$, and the only thing it transports upward is $M(n)\ge M(5)=\sqrt{3/2}$ by padding, which is why $\theta_0(n)>\sqrt{3/2}$ at $n\ge12$ is the threshold at all.

## 11. Forms A, B, C and D against each other

| axis | A ([sym3-blocks.md:326](../findings/sym3-blocks.md)) | B ([results.md:204](../results.md)) | C ([results.md:23](../results.md)) | D ([results.md:40](../results.md)) |
| --- | --- | --- | --- | --- |
| the object | $\theta\le\sqrt{3/2}$, a bound | same, with "critical or not" | "an inequality on a machine certificate" | "$M(5)=\sqrt{3/2}$", an equality |
| the certificate's status | unqualified | **"with exact rational coefficients"** | **"resting on two measured links"** | **"by an exact rational certificate"** |
| the equality clause | **asserted** | **asserted** | **"the equality case is unproven and unreachable by that route"** | absent |
| attainment ($M\ge$) | absent | absent | absent | asserted by the equality sign, argued nowhere |

**Three of the four disagreements are real.**

- **Exact against measured.** B and D call the certificate exact and rational. Half of it is: §5's positive definiteness. The other half is a singular-value rank (§6). C is the accurate one, and it is the one written in the least quotable form, a status-table cell.
- **The equality clause.** A, B and [results.md:625](../results.md) assert it; C denies it is proven, in the same file as B and D, 180 lines apart. §8 shows C is right.
- **Which two links are "measured".** C says two and names none. The candidates I can see are at least four: the Lovelock ratio (§1), $\dim=14$ (H9), the mod-$p$ rank 13 (H10 and [L62](../results.md)), and the float SVD rank 14 (D1). **A count with no list is not a caveat.**

The fourth axis, $M(5)$ against $\theta\le\sqrt{3/2}$, is not a disagreement (the extra content is attainment, which is true and easy (§9)) but D states an equality and cites only the half that gives $\le$.

## 12. What would break it, and what I did to look

**The object that would falsify the inequality** is a $W\in\mathcal W_5$ with $\lVert W\rVert=1$ and $P(W)>\sqrt{3/2}$; equivalently $\operatorname{tr}(W^3)>1/\sqrt6$ at unit norm, since $P=3\operatorname{tr}W^3$ there. **The object that would falsify the equality clause** is a unit $W\notin O(5)\cdot(\pm W_0)$ with $F_5(W)=0$, i.e. $\operatorname{tr}(W^3)=\pm1/\sqrt6$, and by §8 the record has no upper bound on that set at all, so such a $W$ is not excluded by anything on file.

**What I did.** Analysis only, no execution.

- Re-derived the two constants the argument turns on ($c=2$, $\operatorname{tr}W_0^3=1/\sqrt6$) from the structure constants and [L153](../findings/bounds.md), independently of the anchor, looking for a factor-2 or a $\sqrt2$ of the kind [conventions.md](../findings/conventions.md) tables four times. **None: every normalisation lands.**
- Attacked the zero set of $F_5$ for a second component, using the parity the record itself flags. **Found one, in closed form, and it is a distinct $O(5)$-orbit**, which refutes the clause under one reading and leaves it unproven under the other.
- Traced the identity half through the three scripts that build it, looking for the point where an exact claim becomes a measured one. **Found it at the singular-value gap**, inside the file whose preamble denies consulting anything numerical.
- Read the certificate's 47 coordinates against the shape and screened the fourteen $1\times1$ and $2\times2$ blocks by hand. **All positive definite**, and the 13/34 denominator split independently reproduces [L59](../results.md)'s rank.
- Looked for the padded point in every step, since it is where this record's arguments usually fail. **It is the pivot of the rank bookkeeping rather than a blind spot**, but the one step that makes it so is stated in the file I was not to open.

**What I did not do**: prove H8, H11, or the Lovelock ratio. Each is named above as debt with the statement that would have to be proved, and none is patched here.

## Verdict

**GAP.**

The inequality $\theta\le\sqrt{3/2}$ on all of $\mathcal W_5$ is sound in every step I could check independently, the collapse $P=3\operatorname{tr}W^3$ at every padded point (proven here by hand), the equivalence with $F_5\ge0$ (rebuilt from the definitions), and the exact positive definiteness of the shipped Gram (a valid test, hand-screened on 14 of 16 blocks). The lower half $M(5)\ge\sqrt{3/2}$ is proven outright and is stated in no form of the claim.

The gap is Step 6 and it is one hypothesis: **evaluation at the 40 sample points is injective on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$**, whose only support the record names is a floating-point singular-value rank of a 120-sextic matrix the record does not hold. Until an exact rank replaces it, Forms B and D's *exact rational certificate* is a description of the half that is exact, and Form C's *measured links* is the accurate summary that no quotable form of the lemma carries.

Alongside it, **HYPOTHESIS-DEBT** on the equality clause: nothing on file bounds $\{F_5=0\}$ from above, and the SOS zero set provably contains the second orbit $O(5)\cdot(-W_0)$, so the clause as written in A, B and [results.md:625](../results.md) is at best unproven and at worst false, while the same file's status row already books it as unproven. **That is a repair the round can make without deciding anything: delete the clause from the three places that assert it, or attach C's qualification to them.**
