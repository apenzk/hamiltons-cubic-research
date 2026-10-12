# Review r116, the two-condition grading test, the sign convention, the $\theta=0.418198$ refutation, the kernel tolerance, and the cone sweep's reach

Independent implementation from the brief's definitions only, in [scripts/reviewers/r116/](../scripts/reviewers/r116/). The scripts under review were read and run only after every number below was already in hand.

## Verdict table

| # | Claim audited | Verdict | The number that decides it |
|---|---|---|---|
| 1 | the test is $S_{\mathfrak{mmm}}=0$ **and** $S_{\mathfrak{hhm}}=0$; $S_{\mathfrak{hhm}}\equiv S_{\mathfrak{hmh}}$ | **CONFIRMED**, and it is an identity rather than a coincidence | $\max\lvert S_{\mathfrak{hhm}}-S_{\mathfrak{hmh}}\rvert=1.8\times10^{-33}$ over 200 arbitrary orthogonal splittings |
| 2 | the sign flip swaps $\mathfrak h$ and $\mathfrak m$ and moves every block mass | **CONFIRMED** exactly | $\theta=+1.054093$ graded, $\theta=-1.054093$ with $S_{\mathfrak{mmm}}=12$, $S_{\mathfrak{hhm}}=36$ |
| 3 | the $\sigma(3,3)$ point at $\theta=0.418198$ is ungraded | **CONFIRMED** to every digit, and the diagnosis is sharpened | $S_{\mathfrak{mmm}}=21.5213$, $S_{\mathfrak{hhm}}=7.1738$, $\dim\mathfrak m=10$, gap $=0.0021748$ |
| 4 | the $h/\mathfrak m$ split needs a kernel tolerance | **CONFIRMED** in mechanism and in the tolerance branch; the two quoted no-tolerance figures are **one presentation's**, not the operator's | with tolerance $\dim\mathfrak m=2$, $S_{\mathfrak{hhm}}=8$; without, the same operator gives $\dim\mathfrak m\in\{3,\dots,9\}$ and $S_{\mathfrak{mmm}}\in[0,19.0]$ |
|, | "the sweep says **nothing** about the per-$n$ gap floor" | **direction CORRECT, justification UNDERSTATED**, a much stronger conclusion is available and half of it is already on record | the cones contain critical points at $\theta=1.054093$ and $\theta=1.224745$; the sweep's per-cone ceilings are $0.8811$, $0.8811$, $0.7599$, $0.7921$ |

## The build, and why its conventions are pinned rather than chosen

$\mathfrak{so}(n)$ under $\langle A,B\rangle=\mathrm{tr}(A^{\mathsf T}B)/2$ with $E_{ij}$ orthonormal; $C_{\alpha\beta\gamma}=\langle[X_\alpha,X_\beta],X_\gamma\rangle$ from matrix commutators; $W^\#_{\alpha\beta}=\tfrac12C_{\alpha\gamma\delta}C_{\beta\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$; $\mathrm{Weyl}_n$ as the nullspace of (first Bianchi, Ricci) inside $\mathrm{Sym}^2(\Lambda^2)$. Four checks fix the normalisation with no fitting: $\mathrm{Id}^\#=(n-2)\,\mathrm{Id}$ at $n=4,5,6$; $\dim\mathrm{Weyl}_n=10,35,84$ against $n(n+1)(n+2)(n-3)/12$; $C$ totally antisymmetric at residual exactly $0$; and $S^3\times S^3$'s $\theta$ landing on $1.054093$ from the geometry alone ($R=\mathrm{Id}\oplus\mathrm{Id}$ on the two $\Lambda^2(\mathbb R^3)$ blocks, Weyl part $R-\tfrac{\mathrm{scal}}{n(n-1)}\mathrm{Id}$).

**One structural fact worth recording, because it makes the criticality equation simpler than the brief states it.** $Q$ maps $\mathrm{Weyl}_6$ into $\mathrm{Weyl}_6$, residual $4.5\times10^{-14}$ against $\lVert Q\rVert\approx40$ on random elements, i.e. relative $10^{-15}$. So $Q(W)$ is already Ricci-flat and the projection that the constrained problem would need is the identity: "$Q(W)=\theta W$" holds literally, and both scripts' projected residuals and my unprojected fixed-point map $Q(W_0)=W_0$ describe the same solution set.

## Claim 1, confirmed, and the identity is exact

$\langle[X,Y],Z\rangle$ is totally antisymmetric, so $S_{\mathfrak{hhm}}$ and $S_{\mathfrak{hmh}}$ sum the same squares over the same index set. Measured over 200 **arbitrary** orthogonal splittings of $\mathfrak{so}(6)$ (not only eigen-splittings), the difference is $1.8\times10^{-33}$, which is exact in the only sense floating point offers.

The equivalence itself also holds: against a direct check of all three bracket conditions by projection ($\Pi_{\mathfrak m}[\mathfrak m,\mathfrak m]$, $\Pi_{\mathfrak m}[\mathfrak h,\mathfrak h]$, $\Pi_{\mathfrak h}[\mathfrak h,\mathfrak m]$), the two-condition test agreed on 60/60 random splittings and on $S^3\times S^3$. **And the test's exclusions are right too**: $S_{\mathfrak{mmh}}=36$ at graded $S^3\times S^3$, so a test that added $S_{\mathfrak{mmh}}=0$ would reject the standing control. The sum rule $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)=120$ closes at $S^3\times S^3$ as $0+108+0+12$.

## Claim 2, confirmed exactly, from the geometry rather than from a vertex matrix

Building $W$ from the product metric and normalising gives eigenvalues $0.316228$ (multiplicity 6, the two $\mathfrak{so}(3)$s) and $-0.210819$ (multiplicity 9, the mixed 2-forms).

| sign | $\theta$ | $\dim\mathfrak m$ | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{hhm}}$ | $S_{\mathfrak{hmh}}$ | graded |
|---|---|---|---|---|---|---|
| $+$ | $+1.054093$ | 9 | $0$ | $0$ | $0$ | **yes** |
| $-$ | $-1.054093$ | 6 | $12.0000$ | $36.0000$ | $36.0000$ | no |

Both are critical at $\max\lvert Q(W)-\theta W\rvert=5.6\times10^{-17}$. The claimed $12$ and $36$ are reproduced on the nose. The geometric reason the record's $\theta>0$ convention is the right one is visible here: at $\theta>0$, $\mathfrak h$ is the *subalgebra* $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ and $\mathfrak m$ the isotropy complement, which is the Cartan decomposition of the symmetric pair. The flip reverses the roles of subalgebra and complement, and $S_{\mathfrak{mmm}}=12$ is then just $6\cdot1$ per $\mathfrak{so}(3)$ factor.

## Claim 3, confirmed, and the diagnosis of the old record is sharper than stated

Solving criticality inside the $\sigma(3,3)$-invariant subspace ($\dim=45$, confirmed) from 400 random starts returns 318 converged points at **113 distinct** $\theta$, and $\theta=0.418198317$ is among them. At criticality residual $7.2\times10^{-16}$:

| sign | $\theta$ | gap | $\dim\mathfrak m$ | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{hhm}}$ | graded |
|---|---|---|---|---|---|---|
| $+$ | $+0.418198317$ | $0.0021748$ | 10 | $\mathbf{21.5213}$ | $7.1738$ | no |
| $-$ | $-0.418198317$ | $0.0021748$ | 5 | $0.0000$ | $25.6525$ | no |

Every claimed digit is reproduced independently, and the row matches [nondegeneracy.md](../findings/nondegeneracy.md) line 165 exactly.

**Two things the claim does not say, and both strengthen it.** First, the flipped sign has $S_{\mathfrak{mmm}}=0$ but $S_{\mathfrak{hhm}}=25.6525$, so the old "$S=0$" can only have been $S_{\mathfrak{mmm}}$ measured on $-W$, a **one-condition** test on the **wrong sign**, two errors compounding, and either one alone would have caught it. Neither sign of this point is graded, so the falsifier is dead twice over. Second, this point carries **no kernel**: its $h/\mathfrak m$ split is identical for every tolerance in $[0,10^{-3}]$, the gap $0.0021748$ sitting thirteen orders above the numerical zero level. So claim 3 is independent of the claim 4 defect, which matters because the two were found together.

## Claim 4, mechanism confirmed; the two quoted numbers belong to one float presentation

The tolerance branch is exactly as claimed: $\theta=1.224744871=\sqrt{3/2}$, criticality residual $1.7\times10^{-16}$, $\dim\mathfrak m=2$, $S_{\mathfrak{mmm}}=0$, $S_{\mathfrak{hhm}}=S_{\mathfrak{hmh}}=8$, ungraded. The 12-dimensional exact kernel does return from `eigh` at $\pm10^{-17}$, and a bare $\lambda<0$ split does scatter part of it into $\mathfrak m$. **The fix is right and it is load-bearing.**

**The caveat.** "$\dim\mathfrak m=5$ and $S_{\mathfrak{mmm}}=2.64$" is a property of one matrix presentation, not of the operator:

- the record's own `cp2_padded` matrix reproduces $5$ and $2.6443$ (with $S_{\mathfrak{hhm}}=16.8814$), the claim is honest about its own build;
- **on that same matrix, `np.linalg.eigvalsh` reports 4 negative eigenvalues where `np.linalg.eigh` reports 5**, so the figure is not stable across two calls in the same library;
- my mathematically identical build gives $\dim\mathfrak m=3$ and $S_{\mathfrak{mmm}}=0$;
- re-expressing the same operator through 40 random orthonormal $\mathrm{Weyl}_6$ bases (which is what any solver hands to `eigh`), gives $\dim\mathfrak m\in\{7,8,9\}$ with $S_{\mathfrak{mmm}}$ ranging over $[4.39,18.99]$ and $S_{\mathfrak{hhm}}$ over $[10.39,17.32]$.

So the hazard is **larger** than the docstring's single figure suggests, and a reader who checks against $2.64$ and sees $16.2$ will think the tolerance is not the issue. The two numbers should be attributed to the presentation that produces them.

## The inference, right direction, weak justification, and a stronger conclusion is available

My own sweep, 400 starts in each of the four cones, invariant dimensions $49$, $44$, $45$, $48$ (matching the record), **1356 converged, 0 passing the full test**, the record's $1493$ and $0$, reproduced with a different solver (fixed points of $Q$ rather than Levenberg–Marquardt on the projected residual).

**"It says nothing about whether the per-$n$ gap floor holds" is the correct verdict, and I would not weaken it.** Zero graded points found bounds the graded set in neither direction. But the stated justification (a basin anecdote), is the weakest evidence available for it, and two stronger arguments are in the data.

**First, the recovery control is three samples along one ray.** [run_graded_cone_sweep.py](../scripts/runs/run_graded_cone_sweep.py) re-seeds `np.random.default_rng(7)` inside the $\varepsilon$-loop, so all three perturbations point the same direction. Sampling 40 independent directions at each radius, the fraction returning to $S^3\times S^3$ inside $\sigma(3,3)$ is:

| relative radius | 0.001 | 0.003 | 0.01 | 0.03 | 0.1 | 0.3 | 1.0 |
|---|---|---|---|---|---|---|---|
| returns to $S^3\times S^3$ | 68% | 48% | 22% | 32% | 10% | 12% | **0%** |

So "recovered only when started within about $0.01$" over-reads it: recovery is probabilistic and survives at $10\%$ out to radius $0.3$. What actually matters is the last column, the sweep's own starts sit at relative distance $\approx1.4$, where capture is $0/40$. Rule of three on the 337 converged $\sigma(3,3)$ starts puts the per-start capture probability below $0.9\%$ at 95%. **Zero hits is the predicted outcome of a sampler with that reach, whatever the graded set contains.**

**Second (and this is the strong form), the sweep misses a known critical point in every cone that contains one, including the global maximiser.** Per-cone ceilings on $\theta$ from my sweep are $0.8811$, $0.8811$, $0.7599$, $0.7921$, against:

| cone | contains $S^3\times S^3$, $\theta=1.054093$ | contains padded $W_{\mathbb{CP}^2}$, $\theta=1.224745$ | ceiling reached |
|---|---|---|---|
| $\sigma(1,5)$ | yes | no | $0.8811$ |
| $\sigma(2,4)$ | yes | **yes** | $0.8811$ |
| $\sigma(3,3)$ | yes | no | $0.7599$ |
| $J$ | no | **yes** | $0.7921$ |

Re-run with the record's **own** `hunt_in` at 120 starts per cone, the ceilings are $0.5866$, $0.6101$, $0.6101$, $0.7423$, with zero hits at either $\theta$ in any cone that contains the point. [nondegeneracy.md](../findings/nondegeneracy.md) line 200 makes this argument with one witness in one cone; it holds with **two** witnesses across **three** cones, and the second witness is the point of largest $\theta$ in the whole space. That upgrades fence post F13 from an observation about one high-$\theta$ basin to a measured ceiling on the sampler.

**A third caveat, which neither script states and which will bite exactly where the hunt is aimed.** `block_masses` calls a point graded at $S<10^{-16}$ on both conditions, while $S$ scales as $(\varepsilon/\mathrm{gap})^2$ in the perturbation $\varepsilon$. Measured at $S^3\times S^3$ (gap $0.2108$): $\varepsilon=10^{-9}$ gives $S=1.2\times10^{-17}$ and passes, $\varepsilon=10^{-8}$ gives $7.4\times10^{-16}$ and fails. Since the solver accepts residuals up to $10^{-12}$ and the falsifier being hunted is a graded point of *small* gap, a genuine graded point with gap $\lesssim10^{-4}$ would be reported ungraded. Nothing in the present sweep comes near the threshold, so no recorded zero is affected, but before this test is used as a falsifier the threshold should be scaled by the gap.

**A coverage limit, for completeness.** Both formulations exclude $\theta=0$ critical points by construction (the record drops $\lvert\theta\rvert<10^{-6}$; my fixed-point map cannot represent them). That is harmless for a statement about the graded set's gap floor, and it should be stated rather than left implicit.

## What the sweep does establish, corrected

Not "ungraded points dominate". The sampled population never approaches gradedness: the minimum of $S_{\mathfrak{mmm}}+S_{\mathfrak{hhm}}$ over converged points is $11.70$ in $\sigma(1,5)$ and $\sigma(2,4)$, $12.00$ in $\sigma(3,3)$, $12.05$ in $J$, with 1st and 5th percentiles at $\approx12.1$ and $\approx13.5$. The sample is uniformly far from the graded locus, so it carries no information about how close the critical set gets to it either. The record's own reading, that the sweep's value is the $S_{\mathfrak{mmm}}\approx0$ yet ungraded witnesses at $\theta=0.104886$ with $S_{\mathfrak{hhm}}=17.0000$, kernel-free and padding-free, is the right one, and I reproduce those points.

## One finding outside the four claims

Projected gradient ascent on the **full** 84-dimensional $\mathrm{Weyl}_6$ sphere converges to padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$ from **500 of 500** random starts, and to $S^3\times S^3$ from **0 of 500**. So at $n=6$ the numerical global maximiser of $\theta$ is the ungraded padded point and $S^3\times S^3$ is a saddle, consistent with the record's Lemma L39 and the known $4\le n\le11$ exception, and with $\ker(\mathrm{Hess})=18$ against an orbit of $9$ at line 74.

**The methodological reading is the useful part.** Ascent reaches the top of the spectrum with certainty where cone-restricted Newton reaches nothing above $0.89$; the reachability failure is a property of the root-finder, not of the geometry. Ascent is still not the fix for a graded census, since the graded point at $n=6$ is a saddle and ascent misses it 500 times out of 500. That leaves [nondegeneracy.md](../findings/nondegeneracy.md) line 204's open item (a search over isotropy subalgebras, which reaches graded points by construction), standing as the only proposal that addresses the actual obstruction.

## Disagreements with the scripts and the record

1. **[run_grading_test.py](../scripts/runs/run_grading_test.py) `block_masses` docstring** states $\dim\mathfrak m=5$ and $S_{\mathfrak{mmm}}=2.64$ as facts about padded $W_{\mathbb{CP}^2}$. They are facts about that file's matrix under `numpy.linalg.eigh`; `eigvalsh` on the same matrix gives 4 negatives, and other presentations of the same operator give 3 to 9 with $S_{\mathfrak{mmm}}$ up to $19$. Attribute the figures, or quote the range.
2. **[run_graded_cone_sweep.py](../scripts/runs/run_graded_cone_sweep.py) `recovery_control`** re-seeds `np.random.default_rng(7)` inside the $\varepsilon$-loop, so its three trials share one direction. The conclusion it supports (basins too small for random starts), survives, but "drifted away every time" at $\varepsilon=0.1$ is one sample, and the true rate at that radius is about 10%.
3. **[nondegeneracy.md](../findings/nondegeneracy.md) line 200** cites the $\sigma(3,3)$ ceiling of $0.661148$ against $\theta_0(6)$. The same statement is available in $\sigma(2,4)$ and $J$ against padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$, where the missed point is the global maximiser, a strictly stronger witness that the text already has the ingredients for.
4. **The `graded` threshold of $10^{-16}$** is absolute where the quantity it tests scales as $(\varepsilon/\mathrm{gap})^2$. It should be gap-scaled before the test is used to certify the absence of small-gap graded points, which is precisely its intended use.

Everything else in the four claims and in the sweep's recorded numbers reproduced from an independent build.
