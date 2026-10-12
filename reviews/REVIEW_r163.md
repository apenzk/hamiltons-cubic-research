# Review r163, Gate 2 on the sign resolution and the r161/r162 corrections

**Verdict: CLAIM 1 IS REFUTED, and the sign was inverted the wrong way.** The brief's worry, that $\operatorname{tr}(W^3)=\langle W^2,W\rangle$ on $\Lambda^2$ might not be the $\operatorname{tr}(W^3)$ the coefficients $(40,-8)$ were derived for, is unfounded; both pictures use the same cubic. The failure is elsewhere and worse: **the six-digit agreement is invariant under flipping the sign of $C$ together with the sign of its coefficient, so it carries no information about the sign at all**, and the sign it was used to justify is the wrong one. [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) is correct as written; the record has now adopted the error it thought it was fixing. Claim 2's reading is right and its evidence is not, I supply the closed form, which makes the asymptotic statement a theorem. Claim 3's four corrections are all true, but two of them do not support the conclusion drawn from them, and one of those two is the stated ground for a grade of $0$.

---

## CLAIM 1, the sign resolution

### 1.1 The brief's normalisation worry does not fire

The record's $\operatorname{tr}(W^3)$ is $\operatorname{tr}_{\Lambda^2}(M^3)$ throughout, in both pictures.

- [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) computes `theta = sum((M @ M + sharp_op(M)) * M)`, which is $\langle M^2,M\rangle_F+\langle M^\#,M\rangle_F$ on the $\binom n2\times\binom n2$ matrix. On the $\Lambda^2$-diagonal class this is $\sum_{i<j}M_{ij}^3+\tfrac12\operatorname{tr}(\Lambda^3)$.
- [REVIEW_r159.md](REVIEW_r159.md) derived $C=40\sum_{i<j}M_{ij}^3-4\operatorname{tr}(\Lambda^3)$ and read the coefficients off *that* pair, $\operatorname{tr}(W^3)=\sum_{i<j}M_{ij}^3$, $\langle W^\#,W\rangle=\tfrac12\operatorname{tr}(\Lambda^3)$, which is [problem.md](../findings/problem.md) item 9's identity.

Same cubic, same normalisation. I confirmed the dictionary independently in closed form: at $S^{m}\times S^{m}$ with $n=2m$ the vertex matrix has within-block $\alpha$, cross $\beta=-(m-1)\alpha/m$, and $\sum_{i<j}\Lambda_{ij}^2=1$ forces $\alpha=1/\sqrt{(m-1)(2m-1)}$. Then $\sum_{i<j}\Lambda_{ij}^3=\alpha/m=0.0224733$ at $m=6$, the record's $0.022473$, and $\tfrac12\operatorname{tr}(\Lambda^3)=\alpha(2m-3)=1.213560$, and their sum is $\sqrt{(m-1)(2m-1)}/m=1.236033$. **The $\Lambda^2$ picture reproduces all three columns exactly.** *This part of the claim survives.*

### 1.2 The check is blind to the sign it is invoked to settle

$\theta=\operatorname{tr}(W^3)+\langle W^\#,W\rangle$ is the record's definition, with no factor, confirmed above to six digits from the closed form. Given that definition, "$\theta=6\operatorname{tr}(W^3)-\tfrac18C$" is *algebraically the same equation* as "$C=40\operatorname{tr}(W^3)-8\langle W^\#,W\rangle$" rearranged. It is not a check of the identity against anything; it is the identity.

And the table in [nondegeneracy.md](../findings/nondegeneracy.md) does not measure $C$ at all. Its $C$ column is $40\operatorname{tr}-8\langle\cdot\rangle$ **evaluated**, not computed from $\sum_j\mu_j\lvert S^jW\rvert^2$. So the commit computes $C$ from the formula, then verifies the formula. **Nothing independent enters, and the sign is a free parameter of the exercise**:

$$6(0.022473)+\tfrac18(+8.809545)=1.236031,\qquad 6(0.022473)-\tfrac18(-8.809545)=1.236031 .$$

Six digits either way. *A number is used here only to exhibit that the two sign conventions are numerically indistinguishable in this check; no argument about the check's structure could be more direct than displaying the two evaluations.* The conclusion "the identity and the coefficients are confirmed and the sign sits in the eigen-decomposition step alone" therefore does not follow: the check cannot see the sign, and an identity that holds under both signs cannot localise a sign error to any step.

### 1.3 And the sign chosen is the wrong one

The second-kind operator is fixed by the source itself. [paper.txt](https://arxiv.org/abs/2508.11226) lines 191–196 display, alongside the first-kind operator, $\mathring R(\varphi)_{ij}=\sum_{k,l}R_{iklj}\varphi_{kl}$, and [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) implements exactly that (`einsum('iklj,kl,ij->', W, h1, h2)`) on the tensor `full_W` builds with $W_{ijij}=M_{ij}$.

Evaluate it on the $\Lambda^2$-diagonal class by hand. $W_{abcd}\neq0$ only for $\{a,b\}=\{c,d\}$, so $\{i,k\}=\{l,j\}$ leaves two cases:

$$(\mathring Wh)_{ij}=+M_{ij}h_{ij}\ \ (i\neq j),\qquad (\mathring Wh)_{ii}=-\sum_k M_{ik}h_{kk}.$$

**Test on the round sphere**, where $M=\mathrm{Id}$ on $\Lambda^2$: off-diagonal gives $h_{ij}$, diagonal gives $-\sum_{k\neq i}h_{kk}=h_{ii}$ for traceless $h$. So $\mathring R=+\mathrm{Id}$, which is the whole content of "the round sphere has positive curvature operator of the second kind". The script's index order is the one that makes the model case come out positive, and it is the source's own.

[REVIEW_r159.md](REVIEW_r159.md) §1 states the exact negative: "$(\mathring Wh)_{ij}=-M_{ij}h_{ij}$ off the diagonal, $(\mathring Wh)_{ii}=\sum_kM_{ik}h_{kk}$ on it". That convention gives $\mathring R=-\mathrm{Id}$ on the round sphere. **r159's spectrum is negated, hence so is its $C$, hence so are its coefficients.** The record's own sign convention for $M$ is not in doubt: [product_weyl](../scripts/b_second_order_screen.py) sets the curvature operator to $+1$ on within-block bivectors before projecting, so within-block entries are positive and cross entries negative, exactly the sphere-positive convention.

The corrected statements:

$$C=-40\operatorname{tr}(W^3)+8\langle W^\#,W\rangle,\qquad \theta=6\operatorname{tr}(W^3)+\tfrac18C,\qquad C(S^6\times S^6)=+8.809545 .$$

So [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) returns $C$, not $+\lvert C\rvert$, and [82a93ac](../findings/nondegeneracy.md) introduces a sign error while reporting that it removed one.

### 1.4 The factor of 5 has a different cause, and I can name it exactly

Under the correct convention the $\Lambda^2$-diagonal spectrum of $\mathring W$ is $\{M_{pq}\}_{p<q}$ together with the spectrum of $-\Lambda|_{\mathbf1^\perp}$. At $S^6\times S^6$, $\Lambda$ has eigenvalues $0$, $10\alpha$ and $-\alpha$ (multiplicity $10$), so

$$\mu\ =\ \{\alpha^{(30)},\ \beta^{(36)}\}\cup\{-10\alpha,\ \alpha^{(10)}\},\qquad \alpha=0.134840,\ \beta=-0.112367 .$$

The two smallest are $-10\alpha$ and $\beta$, summing to $-1.460767$; the two largest are $\alpha,\alpha$, summing to $+0.269680$. With $\tfrac1{16}T=(n^2+n-8)/(2n)=6.166667$:

| evaluation | inputs | value |
|---|---|---|
| [nondegeneracy.md](../findings/nondegeneracy.md) tight-at-extremum table | $\mu_1+\mu_2=-1.460767$ fed into $\theta=6\operatorname{tr}-\tfrac18C$ | $9.142905$ |
| [REVIEW_r159.md](REVIEW_r159.md) §5 | $\mu_1+\mu_2=-0.269680$ fed into the same identity | $1.797866$ |

Both reproduce the recorded $9.142899$ and $1.79786$ to six digits, which identifies the provenance of each. **The first is a mixed-convention evaluation** (the bottom of the *correct* spectrum fed into the *negated* identity) and it is the source of the factor $9.142905/1.797866=5.085$. It is not "the bound's direction inverting with $C$'s sign": both rows are upper bounds on $\theta$, and the consistent instantiation is the second. *The $5$ was never a clean factor; it is a ratio between two different eigenvalue sums.*

Consequences the record must absorb:

- **The operative side flips back to r158's.** With $\theta=6\operatorname{tr}(W^3)+\tfrac18C$ the coefficient of $C$ is positive, so bounding $\theta$ above needs $C$ bounded **above**, the free-upgrade upper bound $C\le\tfrac12(\mu_{N-1}+\mu_N)T$. r158's "this is the side that could ever bound $\theta$" is correct; [REVIEW_r159.md](REVIEW_r159.md) §5's reversal is not.
- **The bound's numeric value is unaffected**: $1.797866$ against $\theta=1.236033$, $45\%$ slack, because the two conventions are a consistent relabelling of each other.
- **The tight-at-the-extremum table is wrong by $5\times$.** The loss at $S^6\times S^6$ is $1.45\times$, not $7.397\times$. The conclusion (loose at the extremiser, so no equality case), survives, but the number quoted for how loose is not the bound's.

---

## CLAIM 2, the $1.8\%$ figure

**The reading is right, the evidence offered for it is not, and the closed form is two lines from the record's own vertex matrix.** One ratio at one $n$ cannot support an asymptotic statement; but here nothing has to be sampled. Continuing §1.1 at $S^m\times S^m$, $n=2m$:

$$\operatorname{tr}(W^3)=\frac{\alpha}{m},\qquad \langle W^\#,W\rangle=\alpha(2m-3),\qquad \theta=\frac{(m-1)(2m-1)\alpha}{m}=\frac{\sqrt{(m-1)(2m-1)}}{m},$$

$$\boxed{\ \frac{\operatorname{tr}(W^3)}{\theta}=\frac1{(m-1)(2m-1)}=\frac{2}{(n-1)(n-2)}\ }$$

At $n=12$ this is $2/110=1.8182\%$, which is the recorded $1.8\%$, and it decays like $2/n^2$. **So [problem.md](../findings/problem.md) item 5's "asymptotically negligible at the conjectured maximizer" is a theorem on the balanced family, not an observation.** The same closed form gives $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and $\theta_0(n)\lessgtr\sqrt{3/2}$ reduces to $n^2-12n+8\lessgtr0$, the record's own criterion, recovered, which is an unforgiving check on the derivation.

*What it does not settle:* the ratio is for the balanced product only. Nothing here bounds $\operatorname{tr}(W^3)/\theta$ at an unknown maximiser, which is what a general argument would need.

---

## CLAIM 3, the four folded corrections, verified independently

| correction | verdict | what I did |
|---|---|---|
| $\dim E(\tfrac12)=pq$ except $(3,3)$, where it is $18$ | **true, and a rediscovery** | $\mu=\tfrac12\iff n-2=(p-1)(q-1)\iff(p-2)(q-2)=1\iff p=q=3$; and $\binom p2\binom q2=pq\iff(p-1)(q-1)=4$, again only $(3,3)$, giving $9+9=18$ |
| $\lambda_{\max}=1$ was the eigenvalue on $e$ | **true** | $L_e(e)=e^2+e^\#=Q(e)=Q(W)/\theta^2=W/\theta=e$, and $e\parallel W$ so $e\notin W^\perp$. Pure algebra, no computation |
| excess $0$ does not imply graded | **true as stated, but off-target** | see below |
| a lower bound on $\operatorname{mult}(\tfrac12)$ is equivalent to Conjecture A | **true as a quotation, and misapplied** | see below |

Both derivations reproduce numbers the record already carries: $\dim E(\tfrac12)$ at $n=12$ as $20,27,32,35,36$, matching $pq$ at the five splits, and $18$ against orbit $9$ at $(3,3)$.

### 3.1 "Excess 0 does not imply graded" is true, and does not refute what it was aimed at

Padded $W_{\mathbb{CP}^2}$ has $\theta=\sqrt{3/2}<\theta_0(n)$ for every $n\ge12$, so **it is not a maximiser in the range the conjecture covers**. The reduction under attack is conditioned on maximisers, "does a *maximiser* have excess $0$?", and a non-maximiser with excess $0$ and no grading leaves that conditional untouched.

**The reduction fails anyway, for the other reason [a3a365c](../plan.md) gives**: excess $0$ at a maximiser makes that maximiser's own orbit Morse–Bott nondegenerate and hence isolated, which says nothing about whether it is graded. The chain in [nondegeneracy.md](../findings/nondegeneracy.md) runs the other way (nondegeneracy of *every graded* point makes the graded set a union of components) and knowing one point is isolated does not enter it. *So the closure is sound and the witness quoted for it is not load-bearing; the witness should be dropped rather than defended.*

### 3.2 The circularity charge is wrong: it swaps an upper bound for a lower bound

[second-order.md](../findings/second-order.md) line 43 says the **moment method** needs a *lower* bound on $\operatorname{mult}(\tfrac12)$, because a contradiction requires $\operatorname{tr}(L_e^2)\ge R(n)$ and $\operatorname{tr}(L_e^2)\ge m(1)+\tfrac14m(\tfrac12)$.

Item 2 needs excess $=0$, i.e. $\operatorname{mult}(\tfrac12)\le\dim\mathcal O$, an **upper** bound, the automatic inequality already running the other way. **The two statements point in opposite directions and one cannot be quoted against the other.** Item 2's own text mislabels its need as "the lower bound on $\operatorname{mult}(\tfrac12)$ the record has circled repeatedly"; r161 and r162 took the mislabel at face value and derived circularity from it. *The mislabel is real and should be fixed; the circularity is not.*

---

## Answers to the questions

**(a) Asserted as new that the record already holds.**

- $\dim E(\tfrac12)=pq$ with the $(3,3)$ exception: [fence-posts.md](../findings/fence-posts.md) lines 205, 221 and 271 already carry it, with the same $(p-2)(q-2)=1$ derivation and the same $\dim\mathrm{Comm}$ argument for why $(3,3)$ is an eigenvalue coincidence rather than mixing. [plan.md](../plan.md) says so itself.
- "$\theta=6\operatorname{tr}(W^3)-\tfrac18C$ confirms the coefficients": r159 derived and r160 recovered them, with the single degree of overdetermination already spent. Re-evaluating at the same three points adds no check.
- The $1.8\%$ reading: [problem.md](../findings/problem.md) item 5 already states the qualitative fact. The measurement is weaker than the two-line closed form above.
- *One genuine defect I did not find already fixed:* [fence-posts.md](../findings/fence-posts.md) line 231 says nondegeneracy for $p,q\ge3$ "rests entirely on the multiplicity list below, which remains numerical", while line 271 records the symbolic solve over all $45$ summand pairs that supplies exactly the missing upper bound. One of the two sentences is stale.

**(b) The r161 contradiction, there is none, and the resolution is a dimension count.** [second-order.md](../findings/second-order.md) reports padded $W_{\mathbb{CP}^2}$ non-critical at $n=6,7$ (residuals $2\times10^{-1}$, $8\times10^{-2}$) and Morse–Bott nondegenerate at $n=8,10,12$; the witness stands at $n=5$. The nondegeneracy statement is $\ker=E(\tfrac\theta2)=T(\mathcal O)$ of dimension $4n-14$, and [plan.md](../plan.md)'s quoted $\dim E(\tfrac12)=18=\dim\mathcal O$ solves $4n-14=18$ at $n=8$. **The two statements are about different dimensions and never meet at $n=6$.** *r161's flag is a misreading of an $n$-free sentence.*

**(c) Item 2's grade of $0$ is NOT defensible on the record as written.** Its stated ground is `attackable 0, every named route closed`, and two of the three grounds offered fail (§3.1 off-target, §3.2 a direction swap), leaving one sound closure of one route. More decisively, **item 2's own section carries a live target and a never-run decisive test**: the gap theorem repaired to unpadded points is recorded as "not refuted", with "find the mechanism setting the $1.17$ floor" as the owed step, and Section 3's D1, "is any unpadded ungraded critical point at $\lambda_{\max}=\tfrac12$?", is described there as *"the cheapest decisive test the programme has and it has never been run"*, explicitly closing item 2's repaired target. A route that is named, live and untested is an attackable route. *This is a route being closed on a wrong reason again, and the pattern is the third instance in this file's own history.*

---

## Disagreements, stated plainly

- **I disagree with the sign resolution in [82a93ac](../findings/nondegeneracy.md).** The script was right; $C(S^6\times S^6)=+8.809545$; the coefficients are $(-40,+8)$ and the identity is $\theta=6\operatorname{tr}(W^3)+\tfrac18C$.
- **I disagree that the six-digit agreement confirms anything about the sign or localises the fault.** It is the identity restated, and it holds identically under both signs.
- **I disagree with the circularity charge against item 2's reduction**, and with citing padded $W_{\mathbb{CP}^2}$ against a maximiser-conditioned statement.
- **I agree with r161 and r162** on $\dim E(\tfrac12)=pq$ except $(3,3)$, on $\lambda_{\max}=1$ being the eigenvalue on $e$, and on the reduction being a non sequitur, that last one on its own merits, not on the grounds given.
- **I agree with r159** that $\operatorname{tr}(W^3)$ is the same cubic in both pictures and that the magnitudes and ratios are immune to normalisation, and note that this immunity is exactly why the sign had to be settled structurally and was not.

## Process finding

**The computation behind the resolution is again not in the repository.** [82a93ac](../findings/nondegeneracy.md) touches one Markdown file and ships no script, which is the failure mode [REVIEW_r159.md](REVIEW_r159.md) recorded one commit earlier against [36ac4c6](../findings/nondegeneracy.md). Had the table's $C$ column been produced by running [run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) rather than by evaluating $40\operatorname{tr}-8\langle\cdot\rangle$, the disagreement would have been visible in the output instead of being reported as resolved.
