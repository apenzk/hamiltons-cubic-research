# REVIEW r1853: the r1851/r1852 fold on I121 and CPmE.lean

Brief: [BRIEF_I121_fold1851.md](BRIEF_I121_fold1851.md). Log: [agent_logs/r1853-i121-fold.log](../agent_logs/r1853-i121-fold.log). Footing: analysis only. Two checks of values on objects in hand: one rerun of [screen_I121_visible_cubic.py](../scripts/misc/screen_I121_visible_cubic.py) at $n=8$ (one second), and one `lake env lean` compile of a copy of the draft in the session scratchpad (`scratchpad/r1853/CPmE_r1853.lean`, outside lean/HamiltonsCubic/).

| item | subject | verdict |
|---|---|---|
| 1 | fold f1ae74a7 against r1851 and r1852 | CONFIRMED as a fold, the L95 reconciliation correct, with one inherited figure corrected and five minor wording or bookkeeping corrections |
| 2 | CPmE.lean against the closed form | CONFIRMED, with the docstring's "not typed" line to be extended |

## Item 1: the fold

**The reconciliation is correct.** [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) defines `kappaSq W` as the supremum over orthonormal frames of `frobK`, the sum over ordered pairs $(a,b)$ of the squared sectional entries, and `normM2` as the squared Frobenius norm of the operator on $\Lambda^2$. `kappaSq_CP` in [L95.lean](../lean/HamiltonsCubic/Results/L95.lean) proves `kappaSq (Wcp (stdJ m)) = 3/(m+1) * normM2 (Wcp (stdJ m))` at every $m\ge1$, by `le_antisymm` of the standard-frame value with the bound `frobK_le` over every frame. For a Weyl tensor the sectional matrix has zero row sums, so the projection onto coordinate-diagonal Weyl tensors keeps the whole $\Lambda^2$ diagonal, and its mass is $\tfrac12$`frobK`. Hence $t_{\max}^2=\tfrac{3}{2(m+1)}=\tfrac3{n+2}$ at every $m$, attained by the $J$-adapted frame, as the fold says. r1852's "equality unestablished at $m=6$" is superseded, and its "down to $t_{\max}(\mathbb{CP}^6)^2$" correction collapses to the note's $\tfrac3{14}$.

**Finding by finding.**

| source | finding | applied |
|---|---|---|
| r1851 1, r1852 1 | "sorted-edge orientation" vacuous, "signed difference" | yes |
| r1851 2, r1852 2 | even $n$ scope for maximum cliques | yes |
| r1851 3, r1852 3 | the $JJJ$/$XXX$ split | yes, $c=\tfrac12$ values only (see b, c) |
| r1851 3, r1852 3 | diagonal-equation test direction, $\theta$ named, norm consequence only | yes (figure corrected in a) |
| r1851 3, r1852 3 | $0.45/n$ and $23$ to $35$ at $n=8,10$ | yes |
| r1851 3 | "sups" to "values found" | partly (see d) |
| r1851 5 | cite L95, closed form, monotonicity proves $n\ge14$ | yes |
| r1851 5, r1852 4 | slack split $0.463=0.157+0.077+0.229$ | yes, checked by hand here |
| r1851 6, r1852 5 | $B_f$ alone, not critical, fails the matching inequality in its own frame, $0.21$ and $0.20$ bound, "half-diagonal", "consistent with", "equivalently" restricted | yes |
| r1851 6, r1852 5 | table column realised against cap | partly (see e) |
| r1852 5 | the $\tau$ cap from $\mathbb{CP}^m$ | at $n=12$ only (see f) |
| r1851 6 | $E\approx\theta_0/\sqrt k$ needs $k\ll\dim\mathcal W_n$ | no, unstated (see f) |
| r1851 7, r1852 6 | $L_A$ defined | yes, as $Q(A,\cdot)$, the polarisation, which is $A\circ\cdot$ |
| r1852 6 | coordinate change between pairings left implicit | no, unstated (see f) |

**Corrections.**

- **(a) "holds with $0.005$ to spare" is a normalisation artefact, inherited from r1851.** The screen evaluates $\lVert D(B_f)\rVert$ and $\max_ME(M)$ at unit $\lVert B_f\rVert$. In a unit pair-free $W=A+B_f$ with $\lVert A\rVert^2=t^2$, both carry the factor $1-t^2$. The rerun gives $\lVert D\rVert=0.1428$ and $\max_ME(M)=0.0634$ for the first $n=8$ maximiser ($0.1984$, $0.0656$ for the second). With $\theta_0(8)=1.1456$ the conditions are $t^2\ge0.0634(1-t^2)$, so $t\ge0.244$, and $1.1456\,t-(1+\sqrt2)t^2\le0.1428(1-t^2)$. The second fails on $0.225<t<0.279$ and holds from $t\ge0.279$ ($t^2\ge0.078$). At the matching threshold it fails by $0.002$. At unit $B_f$, as r1851 computed, it holds everywhere by $0.007$ (with the unrounded $0.1428$). The conclusion "neither excludes them nor leaves room" survives in either normalisation. Replace "that pair of conditions holds with $0.005$ to spare" with "that pair of conditions is marginal: at unit $W$ it fails at the matching threshold by $0.002$ and holds from $t^2\approx0.08$".
- **(b) "reproduced here"** covers $n=8$ only by the fold's own commit message ("the split reproduced independently at n = 8"). The $n=10$ pair ($0.132$, $0.622$) rests on r1851 and r1852 and on the large-$E$ table. Say "reproduced here at $n=8$".
- **(c) "At these maximisers"** follows a sentence naming both the $c=\tfrac12$ and the $c=2$ maximisers, and the figures are the $c=\tfrac12$ ones. Say "at the $c=\tfrac12$ maximisers". At $c=2$ the split is $0.083$ / $0.750$ ($n=8$) and $0.092$ / $0.746$ ($n=10$) by r1851's table.
- **(d) "the four-set sups ... that unconstrained ascent reached"** still names lower bounds as suprema. Say "the four-set values that unconstrained ascent reached".
- **(e) The column is headed "realised $\max_ME(M)$" and the $n=10$ entry reads $\le0.05$**, the cap. Both reports give the realised value, $0.044$ (r1852 $0.0437$). Enter $0.044$.
- **(f) Three findings are neither applied nor declined with a reason**: r1851's range condition $k\ll\dim\mathcal W_n$ on the $k$-sum calibration, r1852's point that at $n\le10$ ($\varepsilon_n<0$) $\mathbb{CP}^4$ and $\mathbb{CP}^5$ also cap $\tau$ (at $t_{\max}^2=\tfrac13$ and $\tfrac14$), and r1852's note that summing the three pairings' terms in the block equation needs the change of coordinates between pairings. Each is a one-clause addition.

**No new claim entered under cover of the fold.** Every repaired sentence traces to r1851 or r1852 or to L95, and none claims more than they allow. The closed form's "decreasing in $m$" is immediate, as $3m(m^2-1)(2m-1)$ increases on $m\ge2$. The [plan.md](../plan.md) edit removes the refuted "whose large-$E$ maximisers have good frames" and adds nothing.

## Item 2: CPmE.lean

**CONFIRMED.**

- **The cube sum.** $(m^2-m)(-(m+1))^3=-(m^2-1)\,m(m+1)^2$, so `cp_cube`'s factored $K=(m^2-1)\big(8(m^2-1)^2+(m-2)^3-m(m+1)^2\big)$ is the multiplicity-weighted cube sum of the stated spectrum, and it matches r1852's unfactored form. Dividing the spectrum by $\sqrt N$ ($N$ its squared norm, `cp_norm`) makes it unit, so the normalised $\mathop{\mathrm{tr}}W^3=K/(N\sqrt N)$ as typed.
- **$\theta$.** $\big((m+1)(2m-1)\big)^2/N=\tfrac{(m+1)(2m-1)}{3m(m-1)}$, and $(m+1)(2m-1)>0$ at $m\ge2$, so $(m+1)(2m-1)/\sqrt N=\sqrt{(m+1)(2m-1)/(3m(m-1))}$ there. Typed as a check in the scratch copy (`example (m : ℝ) (hm : 2 ≤ m)`, `Real.sqrt_eq_iff_mul_self_eq_of_pos`, `field_simp`, `ring`), and it compiles.
- **The identity.** $K=\tfrac13N(4m^2+2m-11)$ (at $m=6$: $70^3+35\cdot4^3-30\cdot7^3=334950=\tfrac13\cdot6930\cdot145$), so $\theta-\tfrac32\mathop{\mathrm{tr}}W^3=\big[(m+1)(2m-1)-\tfrac12(4m^2+2m-11)\big]/\sqrt N=\tfrac9{2\sqrt N}$, which is `cp_E_poly` divided by $N\sqrt N$.
- **The hypothesis.** `0 < N` is exactly what `Real.sqrt_pos` needs for `field_simp` to clear $\sqrt N$, and it holds at every natural $m\ge2$. Witnesses compiled: $m=2$ ($N=54$) and $m=6$ ($N=6930$), each by `norm_num`.
- **Axioms.** `#print axioms cp_E` on the copy: `[propext, Classical.choice, Quot.sound]`, no `sorryAx`.

**Correction to the docstring.** "Not typed: the spectrum of $\mathbb{CP}^m$'s Weyl tensor and its value $\theta$" is accurate as far as it goes, and two further inputs are untyped. (i) The title reads $E=P-\tfrac32\mathop{\mathrm{tr}}W^3$, while `cp_E` has $\theta$ in the place of $P$: that $P(W)=\langle Q(W),W\rangle=\theta$ at a unit critical point is used and not typed. (ii) The draft takes $\theta$ in the form $(m+1)(2m-1)/\sqrt N$, while the record states $\theta^2=\tfrac{(m+1)(2m-1)}{3m(m-1)}$. The equality of the two at $m\ge2$ is the check above, which could be added as a lemma, or else named in the not-typed line.
