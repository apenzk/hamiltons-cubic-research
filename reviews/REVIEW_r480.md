# Review r480, Lemma L52, "the two spectra do not couple usefully through a shared frame"

**Reviewer r480.** Cold brief, twin to r479, whose report was not read. Analysis only; the one numerical act below is a screen on the record's own six recorded digits, reported as a screen.

**Claim under audit.** [Lemma L52](../findings/bispectral.md), canonical block at [bispectral.md](../findings/bispectral.md) line 69, restated in the canon at [results.md](../results.md) lines 248 and 710, and used as the closure of route [R9](../routes.md).

**Verdict: SPLIT, the displayed inequality and its equality case are CONFIRMED; the headline is REFUTED as stated.** Detail below.

---

## Finding 1, the block does display a claim and does argue it, but the claim is not the heading's

*The first attack in the brief fails, and the second half of it lands.*

The block contains a genuine displayed inequality

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big]$$

and an argument for it. **I checked the argument line by line and it is correct.**

- $f(t)=t^3+3mt^2$ has $f''(t)=6(t+m)\ge0$ on $[-m,\infty)$, and $\omega_i\ge-m$ puts $\omega$ there; $K'\prec\omega$ puts every $K'_i$ in $[\min\omega,\max\omega]$, hence also there. Karamata gives $\sum f(K')\le\sum f(\omega)$, and $p_2(\omega)=3$ rearranges it to the stated lower bound on $p_3(\omega)$.
- $g(t)=t^3-3M_+t^2$ has $g''=6(t-M_+)\le0$ on $(-\infty,M_+]$; $\mu_i\le M_+$ and $K\prec\mu$ put both there, and $p_2(\mu)=1$ rearranges $\sum g(K)\ge\sum g(\mu)$ to the stated upper bound on $p_3(\mu)$.
- The two combine through [Lemma L50](../findings/bispectral.md)'s $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ with the correct signs ($+\tfrac32$ on an upper bound, $-\tfrac12$ on a lower bound).
- Equality forces equality in both, and $f$ is strictly convex on the interior, so Hardy–Littlewood–Pólya gives $K'=\omega$ and $K=\mu$ as multisets; $\sum K^2=\sum\mu^2=\lVert M\rVert_F^2$ then forces $M$'s off-diagonal to vanish, and likewise $\mathring W$'s. The stated equality case is right.

**What the heading claims is a different proposition.** *"Do not couple usefully"* is nowhere displayed and nowhere argued. Its entire support is the numerical paragraph "What it costs", four numbers at padded $W_{\mathbb{CP}^2}$ and a random-sample ratio. **The $\square$ is placed after that paragraph**, so the QED mark closes numerics rather than the proof, which ends one paragraph earlier.

**Consequence for the label.** What is proved is a bound with an exact equality case, Lemma-grade. What the heading asserts is a route verdict resting on measurement, Observation-grade at best, and as Finding 3 shows, false as written. *A Lemma whose heading rests on an Observation is an Observation.*

## Finding 2, the penalty is a one-parameter closed form the block never notices, and it makes the whole appraisal analytic

**The record's own facts collapse the two penalty terms into one.** [Lemma L54](../results.md) records $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ with $t=\lVert K\rVert_F^2$, and $p_2(\mu)=1$, $p_2(\omega)=3$. So the two off-diagonal masses are **rigidly locked in every frame**:

$$\lVert\mathring W_{\mathrm{off}}\rVert_F^2\;=\;3-\tfrac32t\;=\;3\big(1-\tfrac t2\big)\;=\;3\,\lVert M_{\mathrm{off}}\rVert_F^2 .$$

Substituting into the block's own penalty sum $\tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2+\tfrac32m\lVert\mathring W_{\mathrm{off}}\rVert_F^2$ gives

$$\textbf{penalty}\;=\;\tfrac92\,(M_++m)\,\big(1-\tfrac{t_F}2\big),\qquad\text{so}\qquad \theta\ \le\ \theta_{\mathrm{diag}}(K^F)+\tfrac92(M_++m)\big(1-\tfrac{t_F}2\big)$$

in **every** frame $F$. This is the whole of Lemma L52 in one line, in one parameter.

**Screen against the record's own numbers, exact to every recorded digit.** At padded $W_{\mathbb{CP}^2}$ the block records the one-line bound $\tfrac32(M_++m)=2.449490$, so $M_++m=1.632993$, and it records $t_F/2=\tfrac12$ ("the off-diagonal masses $\tfrac12$ and $\tfrac32$"). Then $\tfrac92(1.632993)(0.5)=3.674235$, **the block's recorded penalty sum $3.674235$, to six digits.** Residual $\theta_{\mathrm{diag}}=3.980421-3.674235=0.306186=(\tfrac12)^{3/2}\cdot\tfrac{\sqrt3}2$. *Reported as a screen of an identity I derived by hand, not as evidence for it.*

**And it closes further.** $\theta_{\mathrm{diag}}$ is a cubic form in $K$, so $\theta_{\mathrm{diag}}(K^F)=(t_F/2)^{3/2}\,\theta_{\mathrm{diag}}(\widehat K)$ with $\widehat K=K^F/\sqrt{t_F/2}$ hollow, symmetric, $\widehat K\mathbf1=0$ and $\lVert\widehat K\rVert_F^2=2$, that is, $\widehat K$ is the vertex matrix of a unit **coordinate-diagonal** Weyl tensor, so $\theta_{\mathrm{diag}}(\widehat K)\le\Theta_n$, the diagonal maximum of [conventions.md](../findings/conventions.md). Hence, unconditionally,

$$\boxed{\ \theta\ \le\ \big(\tfrac{t_F}2\big)^{3/2}\Theta_n\;+\;\tfrac92(M_++m)\big(1-\tfrac{t_F}2\big)\ }$$

**This is what Lemma L52 actually is: a reduction of Conjecture A to a lower bound on the frame-optimised diagonal mass $t=\max_Ft_F$.** At $t=2$ it returns $\Theta_n$ (the conjecture, at even $n$) and it degrades linearly below. *That positive reading is worth more to a reader than the heading, and the record does not carry it.*

## Finding 3, REFUTED: "off the diagonal family it loses to a one-line estimate" is false on a neighbourhood of that family

This clause is the load-bearing half of the headline. It appears three times in the canon, [results.md](../results.md) line 68 ("weaker than one-line estimates off it"), line 248 ("off it, loses to a one-line estimate and to the moment relaxation it was built to improve"), and [routes.md](../routes.md) R9 ("off it beaten by the one-line $\tfrac32(M_++m)$"). **It is a universal statement over the complement of the diagonal family, and one counterexample region refutes it.**

**Step 1, the comparison in closed form.** From Finding 2, with $O(W):=\tfrac32(M_++m)$ the one-line bound,

$$\text{coupling}-O\;=\;\theta_{\mathrm{diag}}+\tfrac32(M_++m)\Big[3\big(1-\tfrac{t_F}2\big)-1\Big]\;=\;\theta_{\mathrm{diag}}+\tfrac32(M_++m)\big(2-\tfrac32t_F\big).$$

*Screen:* at padded $W_{\mathbb{CP}^2}$ this is $0.306186+2.449490\cdot0.5=1.530931=3.980421-2.449490$, the block's own two figures. So the coupling can beat the one-line bound only where $\tfrac32t_F>2$, i.e. **$t_F>4/3$**, and it must beat it there for $t_F$ near $2$.

**Step 2, the one-line bound is strictly loose at every unit Weyl tensor.** $\tfrac32p_3(\mu)\le\tfrac32M_+p_2(\mu)$ is equality only if every $\mu_i\in\{0,M_+\}$; with $\sum\mu=0$ and $\sum\mu^2=1$ that is impossible. So $O(W)>\theta(W)$ **strictly**, always.

**Step 3, the coupling is exact at $t_F=2$.** [Lemma L54](../results.md)'s rigidity: at $t_F=2$, $\mu=d_\varphi$ and $\omega=d$, both penalties vanish, and the bound equals $\theta$.

**Step 4, continuity.** Fix a coordinate-diagonal $W_0$ whose $K_0$ has simple spectrum on $\mathbf1^\perp$, and evaluate the L52 bound in $W_0$'s **own fixed frame**, with the $\psi$'s taken as $K^{F_0}(W)$'s eigenvectors. Every ingredient ($K$, $K'$, $M_+=\lambda_{\max}(M)$, $m=-\lambda_{\min}(\mathring W)$), is continuous in $W$ near $W_0$. By Steps 2 and 3, $\text{coupling}(W_0)=\theta(W_0)<O(W_0)$, so the strict inequality persists on a neighbourhood.

**Step 5, the neighbourhood contains non-diagonal tensors.** The coordinate-diagonal-in-some-frame locus has dimension at most $\dim\mathcal D_n+\dim O(n)=\tfrac{n(n-3)}2+\tfrac{n(n-1)}2=n^2-2n$, against $\dim\mathrm{Weyl}_4=10>8$, $\dim\mathrm{Weyl}_5=35>15$, $\dim\mathrm{Weyl}_6=84>24$. **It is a proper subvariety, so its complement meets every neighbourhood.**

**Therefore there are non-diagonal Weyl tensors at which the shared-frame coupling strictly beats the one-line bound, and the same four steps beat [post F33](../findings/fence-posts.md)'s moment bound there too**, any valid upper bound is $\ge\theta$, and the coupling tends to $\theta$. *The clause is refuted as a universal; what is true is the quantitative version: the coupling loses whenever $t_F<4/3$, which is where padded $W_{\mathbb{CP}^2}$ ($t_F=1$) and the random samples sit.*

**This is not a rescue of route R9.** It sharpens where the route dies: the coupling wins only near the granted family, which is exactly Finding 4's point.

## Finding 4, the negative the Lemma means to record is already fence post F26, stated more generally and with a proof

[Post F26](../findings/INDEX-traps.md), held in the **same file** two blocks above: *"no bound exact at the coordinate-diagonal end $t=2$ and monotone below it can close, being $\ge\theta_0(n)$ at every $t<2$."*

Finding 2's closed form shows L52's bound is **exactly** such a bound: exact at $t_F=2$ by Lemma L54's rigidity, and with $\tfrac{d}{ds}\big[s^{3/2}\Theta_n+C(1-s)\big]=\tfrac32\Theta_n\sqrt s-C<0$ for $C=\tfrac92(M_++m)\ge3\theta$, monotone decreasing in $t$ below the diagonal end. **So Lemma L52's route verdict is an instance of F26, not an independent negative.**

**Consequences.**

- The honest label for the headline is **fence post, subsumed by F26**, with the clearance criterion [routes.md](../routes.md) R9 already states.
- The record currently holds this negative three ways (as post F26, as route R9's closure, and as Lemma L52's heading), with only F26 carrying an argument. *Two of the three are the same fence written in the vocabulary of the route it closes, which is the duplication the brief warned to look for.*

## Finding 5, the canon's own copy of L52 states only the positive half, so the heading does not match its statement

[results.md](../results.md) line 710's canonical block for L52 reproduces the dictionary, the convexity argument, the display, and the equality case. **It says nothing whatever about the coupling being unuseful.** The heading above it nonetheless reads "the two spectra do not couple usefully through a shared frame". *A reader consulting the canon finds a heading asserting a negative above a statement that is a bound.*

Worse, [Lemma L54](../results.md) (the very next entry), carries the sentence "the shared-frame coupling of Lemma L52 is an identity exactly on the diagonal family". **L54 already owns L52's structural content**; what is left uniquely to L52 is the convexity repair and the equality case.

## Finding 6, three inconsistent audit statuses for one result

| where | what it says |
| --- | --- |
| [INDEX-results.md](../findings/INDEX-results.md) row 52 | **"Gate 2: no verdict on the record."** |
| [bispectral.md](../findings/bispectral.md) line 39 heading | **"GATE 2 OWED"** |
| the same block's body, and L52's "Verification" paragraph | "Gate 2, Reviewers 289 and 290, agreeing" |

The heading and the index are both stale against the body. *A reader ranking work by what is unaudited will pick this up as unaudited and re-run it.*

## Finding 7, inputs, and one stale number in a sibling block

**Inputs trace cleanly to proved statements.** [Lemma L50](../findings/bispectral.md) (audited, confirmed) supplies the identity; Schur's theorem and Karamata/HLP are classical; $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=K_{ij}$ is [NPW Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md), literature. **No Conjecture or Observation is load-bearing.** The one ingredient the L52 block itself only asserts, the $\psi$-block being $-K\vert_{\mathbf1^\perp}$, cited elsewhere as "verified to $6\times10^{-17}$", *is* proved further down the same file (Reviewer 131's five-line computation, $\langle\mathring Wh,h\rangle=-v^{\mathsf T}K^Fv$), and I re-derived it independently: for $h=\mathop{\mathrm{diag}}(v)$, $\langle\mathring Wh,h\rangle=\sum_{i,k}W_{ikki}v_iv_k=-\sum_{i\ne k}K_{ik}v_iv_k$. **The gap is a missing cross-reference, not a missing proof.**

**One stale number, in [Lemma L50](../results.md)'s "What it does not reach" paragraph as carried in [bispectral.md](../findings/bispectral.md):** it still advertises "imposing the majorization constraint $\omega\succ d$ cuts the relaxation to $2.947$ … the first coupling between the two spectra that demonstrably tightens the bound". **Correction 2 of the "Schur–Horn: what it actually consumes" block, further down the same file, withdraws that number**, "the previously recorded $2.947$ was an artefact of using the $\varphi$-diagonal alone". *Left standing, the file simultaneously advertises the shared-frame coupling as the first one that demonstrably tightens the bound and heads it as one that does not couple usefully.*

## Finding 8, vacuity check, and the per-frame $t$ trap

**Not vacuous.** The construction is one a reader would attempt, it is the natural coupling, it clears post F33's letter, and Finding 2 shows it reduces the conjecture to a statable lower bound on $t$. A reader learns something actionable: *seek a frame with $t_F>4/3$, or abandon the route.*

**One convention slip to fix while editing.** [results.md](../results.md) line 728 (L54) writes "$\sum d^2=\tfrac32t$" and then "since $t\le2$ with equality exactly when $W$ is coordinate-diagonal **in some frame**, at $t=2$ …". The rigidity argument needs $t_{F}=2$ **in the frame being used**, not $t=\max_Ft_F=2$. This is exactly the per-frame/extremal trap [conventions.md](../findings/conventions.md) records. *The conclusion survives (the extremal frame is the one to work in) but as written it substitutes the extremal value into a frame-wise argument.* Likewise $\sum d^2=\tfrac32t$ holds only with the $\psi$'s taken as $K$'s eigenvectors; in a general basis of $\mathbf1^\perp$ it is $\le$.

---

## Verdict

**CONFIRMED, as a bound:** the displayed inequality of Lemma L52 and its equality case are correct, correctly derived, and rest on proved inputs alone.

**REFUTED, as headed:** *"the two spectra do not couple usefully through a shared frame"* is not a proposition the block proves. Its operative clause (that off the diagonal family the coupling loses to the one-line $\tfrac32(M_++m)$), is **false on a neighbourhood of that family** (Finding 3, four analytic steps). The true statement is quantitative: the coupling loses exactly when $t_F<4/3$.

**Hypotheses the surviving Lemma needs.** $W\in\mathrm{Weyl}_n$ with $\lVert M\rVert_F=1$; a fixed orthonormal frame $F$; the $\psi$-block basis taken as $K^F$'s eigenvectors on $\mathbf1^\perp$ whenever $\sum d^2=\tfrac32t_F$ is used; $M_+\ge\max\mu$ and $m\ge-\min\omega$ **supplied by an argument**, since reading them off the true spectra is not available to a proof (the block says so, and at usable constants the bound is $5.590$ at $n=12$).

**The label it deserves, split in two.**

1. **Lemma (renamed).** *"The shared-frame majorization bound, and its equality case."* Statement: the display, plus Finding 2's one-parameter closed form $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$, plus "exact iff both operators are diagonal in one shared frame". **All of this is proved and none of it is a route verdict.**
2. **Fence post, subsumed by F26.** The negative appraisal belongs in [INDEX-traps.md](../findings/INDEX-traps.md) as a scoped instance of post F26, with the clearance criterion [routes.md](../routes.md) R9 already carries and the corrected quantitative clause ($t_F<4/3$) replacing "off the diagonal family".

**Edits owed** (not made, this report edits nothing but itself): the three occurrences of the refuted clause at [results.md](../results.md) lines 68 and 248 and [routes.md](../routes.md) R9; the heading of [results.md](../results.md) line 710 and [bispectral.md](../findings/bispectral.md) line 69; the three-way status conflict of Finding 6; the withdrawn $2.947$ of Finding 7; the per-frame slip of Finding 8.
