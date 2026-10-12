# REVIEW r1851: I121 Kneser structure, CP^m calibration, large E and good frames, block products

Brief: [BRIEF_I121_kneser.md](BRIEF_I121_kneser.md), claims quoted from [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md). Log: [agent_logs/r1851-i121-kneser.log](../agent_logs/r1851-i121-kneser.log). Scripts: [review_r1851_cpm.py](../scripts/reviewers/review_r1851_cpm.py) (builds $\mathbb{CP}^m$ from the Fubini–Study tensor, independent of the quoted spectrum), [review_r1851_split.py](../scripts/reviewers/review_r1851_split.py) (a copy of the capped four-set screen, same seed and steps, printing the $JJJ$/$XXX$ split). Analysis-only footing: both runs are checks of values on objects already in hand, seconds each.

| # | claim | verdict |
|---|---|---|
| 1 | the three $X$'s of a four-set sum to zero, each $J$ is $\tfrac23$ of a signed sum of the other two $X$'s, the $X$'s parametrise $B_f$ | CONFIRMED |
| 2 | triangles of $KG(n,2)$ are the rectangles, maximum cliques are the perfect matchings, $24T\le24\kappa_nt^3$ | CONFIRMED at even $n$ (scope: at odd $n$ the maximum cliques are near-perfect matchings) |
| 3 | the visible-cubic and capped four-set screens and the sentences drawn from them | REFUTED in one sentence (the $9\sum JJJ$ / $24\sum XXX$ figures), the diagonal-equation bullet PLAUSIBLE with its test corrected, the rest PLAUSIBLE as screens with wording corrections |
| 4 | the $\mathbb{CP}^m$ Weyl spectrum and multiplicities | CONFIRMED |
| 5 | the $\mathbb{CP}^m$ table, the $n=12$ conclusion, "from $n=14$ below $\varepsilon_n$" | CONFIRMED, with $t^2=\tfrac3{n+2}$ proved at every $m$ (L95) and the "loss is $\theta\lambda_{\max}$" sentence corrected |
| 6 | large $E$ came with a good frame: lower-bound logic, calibrations, conclusions | lower-bound logic CONFIRMED, calibrations PLAUSIBLE as heuristics, the conclusions REFUTED as stated |
| 7 | $\nu_1\circ\nu_2=(X_1X_2,\tfrac12J_1J_2)$ and the $\chi_Q$ block equation at pair-free $W$ | CONFIRMED |

## Claim 1: the $X$'s and $J$'s on a four-set

**CONFIRMED by hand.** With $Q=\{i<j<k<l\}$, $a=W_{ij,kl}$, $b=W_{ik,jl}$, $c=W_{il,jk}$ and sorted edges:

- $(ij|kl)$: $X_1=\tfrac12(W_{ik,jl}+W_{il,jk})=\tfrac12(b+c)$.
- $(ik|jl)$: $X_2=\tfrac12(W_{ij,kl}+W_{il,kj})=\tfrac12(a-c)$.
- $(il|jk)$: $X_3=\tfrac12(W_{ij,lk}+W_{ik,lj})=-\tfrac12(a+b)$.
- The sum is $0$ identically, Bianchi unused. Each $X_\pi$ is independent of the edges' orientations (reversing $e$ exchanges the two terms by the symmetry of $W$), so "in the sorted-edge orientation" is a harmless restriction.
- With Bianchi $a=b-c$: $X_2-X_3=\tfrac32a$, $X_1-X_3=\tfrac32b$, $X_1-X_2=\tfrac32c$. So $J_\pi=\tfrac23(X_{\pi'}-X_{\pi''})$ with the stated signed sum, and the linear map $(b,c)\mapsto X$ is injective onto the plane $\sum X=0$. The $X$'s parametrise $B_f$ exactly.
- The screens implement this map correctly: `L` and `LJ` in [screen_I121_capped_fourset.py](../scripts/misc/screen_I121_capped_fourset.py) are the formulas above, and the norm matrix encodes $\lVert\nu_Q\rVert^2=\tfrac23\sum_\pi4X_\pi^2$, which is the given $\sum_\pi4X_\pi^2=\tfrac32\lVert\nu_Q\rVert^2$.

## Claim 2: the Kneser structure and $\kappa_n$

**CONFIRMED at even $n$.** A triangle of $KG(n,2)$ is three pairwise disjoint edges, a rectangle by definition. A clique is a set of pairwise disjoint edges, a matching, so the maximum cliques are the matchings of size $\lfloor n/2\rfloor$. At even $n$ these are the perfect matchings. At odd $n$ they are near-perfect matchings, and no perfect matching exists. The matching inequality is stated at even $n$ ([2026-09-28b](2026-09-28b-LIT-step8-sweep.md) line 92), so the scope is even $n$ throughout.

- $24T\le24\kappa_nt^3$: $T$ is cubic and $\max_ME(M)$ quadratic, so scaling $X=tY$ gives it. $\kappa_n$ is finite because at even $n$ every pair of disjoint edges lies in some perfect matching, so $\max_ME(M)=0$ forces $X=0$, and the constraint set is compact on the $\sum X=0$ subspace.
- The screen maximises over $(b,c)$, hence over the constrained subspace, so its values are valid lower bounds on $\kappa_n$.

## Claim 3: the screens of the Kneser section

**One sentence REFUTED.** "At the maximisers the value is almost all visible: $9\sum JJJ=0.009$ to $0.063$ against $24\sum XXX=0.48$ to $0.60$ at $n=8,10$" is inconsistent with the note's own values, since $P(B_f)=9\sum JJJ+24\sum XXX$ and $0.063+0.60<0.75$, the note's $n=10$, $c=\tfrac12$ value. The copy of the capped screen (same seed, starts and steps) gives at the returned maximisers:

| $n$ | $c$ | $P$ | $9\sum JJJ$ | $24\sum XXX$ | $\max_ME(M)$ |
|---|---|---|---|---|---|
| $8$ | $\tfrac12$ | $0.5253$ | $0.1328$ | $0.3924$ | $0.0633$ |
| $8$ | $2$ | $0.8333$ | $0.0833$ | $0.7500$ | $0.2088$ |
| $10$ | $\tfrac12$ | $0.7536$ | $0.1320$ | $0.6216$ | $0.0437$ |
| $10$ | $2$ | $0.8378$ | $0.0917$ | $0.7461$ | $0.1421$ |

- The quoted $0.48$ and $0.60$ are the *visible-cubic* screen's $24T$ values ($0.48$, $0.59$), a different screen. The large-$E$ table's own $E=0.392$, $0.622$ at $n=8,10$ agree with this rerun (for $B_f$ alone $E=24\sum XXX$ by Claim 2 of the note with $A=0$), so the note contradicts itself.
- **Correction**: "the value is mostly visible: $9\sum JJJ=0.08$ to $0.13$ against $24\sum XXX=0.39$ to $0.75$ at $n=8,10$", a visible share of $75$ to $90$ per cent.
- At $n=8$, $c=2$ the cap is inactive ($\max_ME(M)=0.21<\tfrac28$) and the value is $\tfrac56$, the unconstrained figure.

**The diagonal-equation bullet: PLAUSIBLE, with its test corrected.** The equation $\theta A=Q(A)+\operatorname{diag}Q(B_p)+D(B_f)$ is right: cross terms between different characters have zero diagonal, and $D(B_f)$ has zero row sums (per four-set the three pairings give $\tfrac32\cdot\tfrac12N-2\cdot\tfrac38N=0$), as it must.

- **The inequality used points the wrong way for an exclusion.** $\lVert D(B_f)\rVert\lesssim\theta t$ is an upper bound on $D$ that any small $D$ passes. The binding direction at pair-free $W$ is $\theta t\le\lVert D(B_f)\rVert+\lVert Q(A)\rVert$, an *upper* bound on $t$, set against the matching inequality's lower bound $t^2\ge\max_ME(M)$.
- At leading order ($Q(A)$ dropped) it reads $t\approx\lVert D\rVert/\theta=0.12$ and $0.17$ at $\theta_0(8)$, below the $t\ge0.25$ the matching inequality demands. So at leading order the equation does exclude them.
- With the $O(t^2)$ term the exclusion is not forced. For a Weyl diagonal $A$ with entries $K_{ab}$, $(A^\#)_{ab,ab}=(K^2)_{ab}$, so $\lVert Q(A)\rVert\le(1+\sqrt2)t^2$, and $\max_{t\ge0.2516}\big(\theta_0t-(1+\sqrt2)t^2\big)=0.135$. The two maximisers ($0.14$, $0.20$) pass, the first by $0.005$. "Does not exclude" survives at $\theta=\theta_0(8)$, marginally.
- The script's $\theta t\approx0.33$ uses a hard-coded $\theta=1.3$, not $\theta_0(8)=1.146$. At $\theta=1.3$ the corrected test excludes the first maximiser ($0.14<0.175$). The sentence should state the $\theta$ used.

**Wording corrections, the rest PLAUSIBLE as screens.**

- "$t^2\approx0.45/n$" and "$23$ to $35$ times the clique cap" hold at $n=8,10$. At $n=6$ the figures are $0.78/n$ and $11.5$. Here $t^2$ means the least $t^2$ the matching inequality allows, $\max_ME(M)$, which should be said.
- "the unconstrained four-set sups $0.833$, $0.949$, $1.033$" are ascent lower bounds on $S_F$ (the [first sweep](2026-09-28b-LIT-step8-sweep.md) calls them "largest $P$ found", and $1.033$ at $n=12$ is one of twelve starts). So "the cap lowers the reachable value by about a fifth" compares two lower bounds. The note's "in these ascents" carries this. "sups" should read "values found".
- The $\kappa_n$ arithmetic is consistent: $24\kappa_n(\max E)^{3/2}$ reproduces $0.24$, $0.49$, $0.58$.

## Claim 4: the $\mathbb{CP}^m$ spectrum

**CONFIRMED, by hand and against the Fubini–Study tensor.** With holomorphic sectional curvature $4$, the curvature operator has $2(m+1)$ on $\omega$, $2$ on $\mathfrak{su}(m)$ and $0$ on $\mathfrak u(m)^\perp$ ($\operatorname{tr}=2m(m+1)$, half the scalar curvature $4m(m+1)$, and $m=1$ gives $K=4$). The metric is Einstein, so $W=R-\bar\lambda I$ with $\bar\lambda=\tfrac{2(m+1)}{2m-1}$, giving $\tfrac2{2m-1}\big(2(m^2-1),\,m-2,\,-(m+1)\big)$ with multiplicities $1$, $m^2-1$, $m^2-m$.

- [review_r1851_cpm.py](../scripts/reviewers/review_r1851_cpm.py) builds $R(X,Y)Z=\langle Y,Z\rangle X-\langle X,Z\rangle Y+\langle JY,Z\rangle JX-\langle JX,Z\rangle JY+2\langle X,JY\rangle JZ$ directly, and at $m=3,4,5,6$ finds $\operatorname{Ric}(W)=0$, the spectrum ratios and multiplicities exactly as stated, and $\lVert Q(W)-\theta W\rVert\le4\times10^{-16}$ with $W^\#$ from the $\mathfrak{so}(n)$ structure constants normalised by $I^\#=(n-2)I$. $\theta$ agrees with $\sqrt{(m+1)(2m-1)/(3m(m-1))}$ to six places.
- At $m=2$, $(6,0,-3)$ with multiplicities $(1,3,2)$ is proportional to $(2,-1,-1,0,0,0)$ as stated.

## Claim 5: the $\mathbb{CP}^m$ table and the $n=12$ conclusion

**Every entry CONFIRMED** by the same script at $m=5,6$ and by the closed form below at $m=7,8$: $\theta$, $\operatorname{tr}W^3$, $\theta\lambda_{\max}=\tfrac{2(m+1)}{3m}$, $E$, $\varepsilon_n$, $t^2$.

- **Closed form.** With $D=3m(m^2-1)(2m-1)$, $\lVert\cdot\rVert^2\propto D$, $\operatorname{tr}W^3=\tfrac{4m^2+2m-11}{3\sqrt D}$ and $\theta=\tfrac{(m+1)(2m-1)}{\sqrt D}$, so $$E(\mathbb{CP}^m)=\frac{9}{2\sqrt{3m(m^2-1)(2m-1)}},$$ which gives $0.079057$, $0.054056$, $0.039311$, $0.029881$ at $m=5,\dots,8$.
- **"From $n=14$, $\mathbb{CP}^m$ sits below $\varepsilon_n$" is then proved**: $E(\mathbb{CP}^m)$ strictly decreases in $m$, $\varepsilon_n$ increases in $n$ ($\theta_0^2=2(1-\tfrac3n+\tfrac2{n^2})$ increases for $n\ge2$), and $0.0393<0.0728$ at $n=14$. $E\to0$ at rate $\tfrac{9}{2\sqrt6}m^{-2}$, sharper than the note's "$\to0$".
- **$t^2=\tfrac3{n+2}$ is proved at every $m\ge2$**, and the note understates it as "measured at $m=4,5$ and the formula beyond". [bispectral.md](../findings/bispectral.md) Lemma L95 proves $\kappa^2(\mathbb{CP}^m)=\tfrac3{m+1}$ (kernel-checked as kappaSq_CP in [L95.lean](../lean/HamiltonsCubic/Results/L95.lean)), and $t^2=\kappa^2/2=\tfrac3{2(m+1)}$ in the note's normalisation. The script's $J$-adapted frame gives $0.2143$ at $m=6$. So the $n=12$ conclusion rests on a proved mass, and the sentence should cite L95.
- **The $n=12$ conclusion CONFIRMED**: $\mathbb{CP}^6$ is a critical point with $E=0.054>\varepsilon_{12}=0.022$ at maximal-frame $t^2=\tfrac3{14}$. So no argument of the form "$E<\varepsilon_{12}$ at critical points with $t_{\max}^2\le\tau$" holds with $\tau\ge\tfrac3{14}$.
- **Correction: "The loss is L198's step, $\theta\lambda_{\max}=0.78$ at $\mathbb{CP}^6$ against the $1$ it spends".** The loss is L198's step, but $\theta\lambda_{\max}$ does not measure it. The slack $1-\theta\operatorname{tr}W^3=\sum_k\lambda_k^2(1-\theta\lambda_k)=0.463$ splits as $0.157$ from the top eigenvalue, $0.077$ from $\mathfrak{su}(m)$ and $0.229$ from the negative eigenspace $\mathfrak u(m)^\perp$, where $\theta\lambda_k^3\le\lambda_k^2$ is slack by $1+\theta\lvert\lambda_k\rvert$. The step loses most on the negative eigenvalues, about half of the total, and the top eigenvalue carries about a third.

## Claim 6: large $E$ and good frames

**The lower-bound logic CONFIRMED.** [screen_I121_large_E_frame.py](../scripts/misc/screen_I121_large_E_frame.py) starts from a QR orthogonal matrix and multiplies by exponentials of skew generators, so every frame is orthogonal, and `rot_op` is $\Lambda^2g$. The reported $t^2$ is exact in an explicit frame and is a lower bound on $t_{\max}^2$ of the tensor it was computed for. $P=0.525$ and $E=0.392$ at $n=8$ agree with the rerun above.

**The calibrations PLAUSIBLE as heuristics**, stated without derivation or source.

- The balanced product has $E=\theta_0-\tfrac3{2p\sqrt{(p-1)(2p-1)}}$ exactly at $n=2p$ ($1.202$ against $\theta_0=1.236$ at $n=12$), so "$E\approx\theta_0$" holds.
- For $k$ unit copies in random frames, the mixed terms of the cubic include $\langle Q(A_i),A_j\rangle=\theta_0\langle A_i,A_j\rangle$, of order $\dim\mathcal W_n^{-1/2}$. "$E\approx\theta_0/\sqrt k$" needs $k\ll\dim\mathcal W_n$ ($1638$ at $n=12$). The sentence should carry that range.

**The conclusions REFUTED as stated.**

- **(a) The screened tensors do not pass the matching family.** They are $B_f$ alone, $t^2=0$ in their own frame, with $\max_ME(M)=0.063$ and $0.044$. In their own frame the matching inequality demands $E(M)\le0$, so the $\tfrac\pi4$ rotation along that matching strictly raises the diagonal mass. The family does see them. "No single $\tfrac\pi4$ matching rotation raises the diagonal mass beyond the cap" holds only for a hypothetical $W=A+B_f$ with $\lVert A\rVert^2\ge\max_ME(M)$, a tensor the screen never built.
- **(b) For that tensor the screen's bound degrades to the $\mathbb{CP}^m$ scale.** $t_{\max}(A+B_f)\ge t_{\max}(B_f)\lVert B_f\rVert-\lVert A\rVert$ gives $t_{\max}^2\ge(0.736\sqrt{0.937}-\sqrt{0.063})^2=0.21$ at $n=8$ and $(0.672\sqrt{0.956}-\sqrt{0.044})^2=0.20$ at $n=10$. These sit at $\tfrac3{n+2}=0.20$, $0.25$, not "far from small mass". A typical $A$ would leave more, but the screen does not show it.
- **(c) "near-diagonal tensors seen in bad frames"**: $t_{\max}^2\ge0.45$ to $0.54$ leaves about half the mass off the diagonal in the best frame found, so "half-diagonal" is what was seen.
- **(d) Generalisation.** "The configurations that pass the matching family with a large visible cubic are ..." and "the statement these screens support" rest on two tensors, the first start of one ascent at each $n$, neither a critical point of $P$. A screen of two non-critical tensors cannot support a statement about critical points. The correct reading is "in the two cases screened, the four-set maximiser alone had $t_{\max}^2\ge0.45$".
- **(e) "equivalently $E\lesssim Ct_{\max}$ at critical points".** Through the note's Claim 2, "visible cubic $O(t)$" and "$E=O(t)$" differ by the diagonal term $O(t^3)$ and the coupling, at most $\tfrac32\sqrt{3(n-3)}\,t^2$. That difference is $O(t)$ only when $t^2=O(1/n)$, and Claim 2 covers pair-free $W$ only. The pair part enters $E$ at order $\sqrt n\,t$ (the note's own "what is open"), so for general critical points the two statements are not equivalent. The correction: "at pair-free $W$ with $t^2=O(1/n)$, a visible cubic $O(t)$ in the maximal frame gives $E=O(t)$, and conversely for the upper bound".
- Minor: the table's cap column gives $0.05$ at $n=10$, the cap $c/n$, where the attained $\max_ME(M)$ is $0.044$.

## Claim 7: the product in $(X,J)$ coordinates and the block equation

**CONFIRMED by hand.** With $b=X+\tfrac J2$, $c=X-\tfrac J2$: $2(aa'+bb'+cc')=2(JJ'+2XX'+\tfrac12JJ')=4XX'+3JJ'$, so the Hilbert–Schmidt inner product on $V_Q$ is the stated metric in each pairing's coordinates.

- Given $\nu_1\circ\nu_2\in V_{Q_3}$ ([r1846](REVIEW_r1846.md)) and $\tau=\tfrac32J_1J_2J_3+4X_1X_2X_3$ for every $\nu_3$, the element with $4X^*X_3+3J^*J_3=\tau$ for all $(X_3,J_3)$ is $X^*=X_1X_2$, $J^*=\tfrac12J_1J_2$, relative to the pairing that the rectangle induces on $Q_3$.
- **The block equation.** At pair-free $W=A+B_f$, $Q(W)=A\circ A+2A\circ B_f+B_f\circ B_f$, and $Q(W)$ is Weyl (its Ricci contraction is a contraction against $\operatorname{Ric}(W)=0$), so criticality is $Q(W)=\theta W$ with no projection. The $\chi_Q$ component of an algebraic curvature tensor is supported on entries whose indices are exactly $Q$, hence lies in $V_Q$. $A\circ A$ has trivial character. $A\circ\nu_{Q'}$ carries $\chi_{Q'}$, so only $2A\circ\nu_Q$ survives. $\nu_{Q_1}\circ\nu_{Q_2}$ carries $\chi_{Q_1\triangle Q_2}$, and $Q_1\triangle Q_2=Q$ with $\lvert Q_i\rvert=4$ forces $\lvert Q_1\cap Q_2\rvert=2$, $Q_1=e\cup g$, $Q_2=f\cup g$ with $(e|f)$ a pairing of $Q$ and $g$ an edge disjoint from $Q$. Ordered pairs give the factor $2$. So $\theta\nu_Q=2L_A\nu_Q+2\sum_{(e|f)}\sum_g\nu_{e\cup g}\circ\nu_{f\cup g}$ as stated, $L_A\nu:=A\circ\nu$, each summand expressed in the $(X,J)$ coordinates of its own pairing $(e|f)$ of $Q$.
- The note leaves $L_A\nu_Q$ in operator form. Its coordinates are not given, which the "next derivation" will need.

## Summary of corrections for the fold

1. Replace the $JJJ$/$XXX$ figures with $9\sum JJJ=0.08$ to $0.13$, $24\sum XXX=0.39$ to $0.75$, and "almost all" with "mostly".
2. Restate the diagonal-equation test as $\theta t\le\lVert D(B_f)\rVert+(1+\sqrt2)t^2$ against $t^2\ge\max_ME(M)$, state the $\theta$ used, and record the margin ($0.005$ at $\theta_0(8)$).
3. Cite L95 for $t_{\max}^2(\mathbb{CP}^m)=\tfrac3{n+2}$ at every $m$. Add $E(\mathbb{CP}^m)=\tfrac9{2\sqrt{3m(m^2-1)(2m-1)}}$, which proves the $n\ge14$ sentence.
4. Replace "the loss is ... $\theta\lambda_{\max}=0.78$" with the slack split, about half from the negative eigenspace.
5. In the large-$E$ section: the tensors screened are $B_f$ at $t=0$, which the matching family sees. With the diagonal part restored the robust bound is $t_{\max}^2\ge0.20$ to $0.21$. Drop "near-diagonal", "the configurations that ..." and "the statement these screens support", and restrict "equivalently" to pair-free $W$ at $t^2=O(1/n)$.
6. "sups" to "values found", and the $n$-range on "$0.45/n$" and "$23$ to $35$".
