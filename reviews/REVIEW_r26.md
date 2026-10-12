### Reviewer 26: the bracket-transportation relaxation and the axial hypothesis, both negatives

**Both conclusions survive; both statements needed correcting.** Everything rebuilt from definitions ([review_r26_core.py](scripts/review_r26_core.py), [review_r26_e1_lp.py](scripts/review_r26_e1_lp.py), [review_r26_e1_Cmax.py](scripts/reviewers/r26/review_r26_e1_Cmax.py), [review_r26_e1_identity.py](scripts/reviewers/r26/review_r26_e1_identity.py); report in [review_r26_report.md](agent_logs/review_r26_report.md)).

**E1, CONFIRMED, with the witness corrected.** The eigenframe identity $P=\sum_aw_a^3+\tfrac12\sum w_aw_bw_c\,c_{abc}^2$ matches $P$ from the full $Q$ to $7\times10^{-16}$ at $n=5\ldots8$ and follows from total antisymmetry. $C=\max\|[X,Y]\|^2=2$ is right, now with a proof: $\|\mathrm{ad}_X\|_{\mathrm{op}}=\max(|\theta_k|+|\theta_l|)\le\sqrt2$ for unit $X$, equality at the quaternionic bivector. The witness is feasible as an explicit tensor at $n=6,8,10$ and its values reproduce from raw ordered sums.

**The constraint the witness misses.** $Q$ maps Weyl to Weyl and Weyl operators are trace-free, so $\operatorname{tr}(W^\#)=-\|W\|^2=-1$ exactly (verified $n=5\ldots10$), a linear constraint on $T$. The witness returns $+(n-2)$, the largest value the marginals permit and the exact opposite extreme; structurally it demands a proper ideal of $\mathfrak{so}(n)$.

**It does not rescue the route, and the original claim understated its case.** The general-$w$ LP carrying every constraint (repeat-free, marginals, pair caps, $\operatorname{tr}(W^\#)=-1$, $|V_a|\le1$), still gives $1.6059$ at $n=6$ against $\theta_0=1.0541$, rising to $1.7654\times$ at $n=9$, with $\mathrm{LP}/\sqrt{n-2}$ flat near $0.80$. The LP optimum sits **above** the witness ($1.61$ against $0.91$ at $n=6$), each optimum re-audited by rebuilding $T$ as a full ordered tensor.

**One positive finding worth keeping.** On the two-block slice, $\operatorname{tr}(W^\#)=-1$ makes the relaxation **exactly tight**: the argmax is $p=m(m-1)$, the pure-bivector count of $S^m\times S^m$, with value $=\theta_0(n)$ to $2.2\times10^{-16}$ at $n=6,8,10,12$ and strictly below at odd $n$. The LP recovers the sphere product with no geometry supplied.

**E2, conclusion CONFIRMED, statement REFUTED.** Two corrections, one substantive.

**The spectrum has six families, not five.** $L_e$ carries $1,\ \tfrac12,\ \tfrac{m-2}{2(m-1)},\ \tfrac1{m-1},\ 0,\ -\tfrac1{m-1}$ with multiplicities $1,\ m^2,\ (m+2)(m-1),\ \binom m2^2,\ \text{rest},\ \big(\tfrac{(m-1)(m+2)}2\big)^2$. At $m=3$ the $\tfrac1{m-1}$ family collides with $\tfrac12$ and at $m=4$ two families collide at $\tfrac13$, so $n=6$ and $n=8$, the two dimensions first computed, are exactly the degenerate cases. Confirmed exactly at $n=10$ ($1,\tfrac12,\tfrac38,\tfrac14,0,-\tfrac14$) and $n=12$.

**A nontrivial $\mathbb Z_2$-grading does exist.** $R_g$ for $g=(-I_m)\oplus I_m$, the symmetric-pair involution of $(\mathfrak{so}(n),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$, which is this project's own $\mathbb Z_2$-gradedness, is an **exact automorphism** of Fox's algebra, $R_g(x\circ y)=R_gx\circ R_gy$ to $2.7\times10^{-15}$; it fixes $e$ and commutes with $L_e$. On the $\mathrm{Stab}(W^*)$-refinement it is the unique grading, the GF(2) solution space having dimension exactly $1$.

**The conclusion survives anyway.** $E(0)$ carries both signs ($128/20$ at $n=8$, $350/70$ at $n=10$) so $\sigma$ is not a function of the $L_e$ eigenvalue. It is therefore not a Miyamoto involution, and no fusion law on the eigenvalue partition recovers it, so gate G cannot be obtained as fusion rigidity.

**The numerical-threshold worry is unfounded.** Redone with exact projectors, the full structure tensor over all basis pairs (totally symmetric to $1.3\times10^{-15}$, which also confirms the algebra is Frobenius), and the grading solved as a GF(2) linear system rather than by enumeration: nonzero masses sit at $\sim5\times10^{-3}$ of maximum and zeros at $\sim10^{-29}$, and the answer is identical for thresholds from $10^{-14}$ to $10^{-6}$.
