### Reviewer 29: the same brief as Reviewer 28, independently

**Run under the two-reviewer rule, on an identical brief, with no sight of the other audit.** Independent rebuild in [review_r29_core.py](scripts/review_r29_core.py) and its drivers; report in [review_r29_report.md](agent_logs/review_r29_report.md).

**Irreducibility CONFIRMED and stronger than needed.** The commutant is computed as $\ker\Omega$ for $\Omega(M)=-\sum_a[\rho_a,[\rho_a,M]]$, positive semidefinite with kernel exactly the commutant, by matrix-free Lanczos. $\dim\mathrm{End}_{SO(n)}=\dim\mathrm{End}_{O(n)}=1$ at $n=5\ldots10$, so $\mathcal W_n$ is absolutely irreducible of real type already under $SO(n)$; the $n=4$ control returns $2$, confirming the method detects reducibility when it is there.

**T1 CONFIRMED.** $\tau=0$ to $2\times10^{-14}$ in two unrelated orthonormal bases, and $\operatorname{tr}(L_x)=0$ at random **non**-critical $x$ for $n=5\ldots12$.

**T2 CONFIRMED and extended.** Exact at $n=5\ldots12$ with six independent pairs per $n$, including the dimensions the claim never tested.

**T3 CONFIRMED**, as a corollary of T2 at $x=y=e$, verified at more than seventy critical points including symmetry-free ones.

**T4 PLAUSIBLE, the inequality is valid, two supporting statements are false.** $\lambda=1$ is not simple and $\lambda=\tfrac12$ is not confined to the orbit tangent; neither breaks the inequality, which uses both only as lower bounds.

**The sharpening REFUTED.** The bound is exactly optimal for the information it uses, no further eigenvalue is forced, and the deficit tends to exactly $2$ at every $n$, with $\mathrm{bound}/\theta_0$ peaking at $1.5104$ near $n=10$ and falling to $\sqrt2$.

**Two identities offered as repair, and they matter more than the claims audited.** $\kappa_W=\|T\|^2/D$ with $T$ the structure tensor and $D=\dim\mathcal W_n$, verified exactly as $315/35$, $1155/84$, $3276/168$, a route to **proving** the closed form for $\kappa_F$, which is currently fitted both here and in Fox. And $\operatorname{tr}(X^\#)=-\|X\|^2$ on $\mathcal W_n$ at $n=5\ldots8$, the general form of the constraint that killed the relaxation's witness.

**Two corrections beyond the shared ones.** The $\tfrac12$-inclusion is **proven** by differentiating $Q(gW)=gQ(W)$, with multiplicity exceeding the orbit dimension at degenerate points, $60$ against $21$ at $S^2\times S^3\times S^3$, where $m(1)=3$. And the $O(n)$-not-$SO(n)$ remark recorded with Fox's theorem is an $n=4$ statement; for odd $n$ the two groups act through the same image on $\Lambda^2$.

**The suppression at symmetry-free points is far larger than the bound sees**: every one found has $\theta\le0.143$ at $n=6$ against $\theta_0=1.054$, and $\theta\le0.067$ at $n=8$. Closing the gap would need $m(\tfrac12)\approx2.2\times$ the orbit dimension, and at all 35 symmetry-free points converged the multiplicity is exactly the orbit dimension with $L_e$ of full rank, so the requirement is generically false rather than merely unproved.

**Reconciliation with Reviewer 28.** The two audits agree on every substantive point: irreducibility, T1, T2, T3 being T2 at $x=y=e$ and carrying no criticality, the two false spectral premises of T4 with the inequality surviving them, and the sharpening being closed rather than merely short. They also agree on the asymptotics, $\mathrm{bound}/\theta_0\to\sqrt2$ and $\mathrm{needed}/\mathrm{forced}\to2$. **The only difference is a label**: Reviewer 28 records T4 as CONFIRMED with premises refuted, Reviewer 29 as PLAUSIBLE with supporting statements false. The substance behind the two labels is identical, so the claim is recorded as confirmed in its inequality and corrected in its premises.
