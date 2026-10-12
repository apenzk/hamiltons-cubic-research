# Step 8 sweep, 2026-09-28g: a value-sensitive argument across the band

*Position file: [2026-09-28f-step8-position.md](2026-09-28f-step8-position.md), unchanged in substance; by the manager's decision of 2026-09-28 the work stays on I121's band, from the uniform threshold $t_{\max}^2\ge\tfrac29\tfrac{n-1}{n-2}\varepsilon_n^2$ to the parked product step, and the argument must use the value.*

## Batch 1: target.md's lift in the bottom eigenframe, with the frame cap (derived, screened)

- **The lift, per eigenvector.** At a unit critical point and a unit bottom eigenvector $h$ of $\mathring W$, [target.md](../findings/target.md) gives $\theta\mu=\mu^2-\mathrm{LOSS}$. Write $\Phi:=\mu(\theta-\mu)=-\mathrm{LOSS}$. In $h$'s eigenframe, with $h=\operatorname{diag}(e)$, the $W^2$ half is $-\langle(W^2)^\circ h,h\rangle=\sum_{i,k}e_ie_k\lVert Me_{ik}\rVert^2$, and at a diagonal $W$ the whole is $\Phi=-\sum_{i<k}K_{ik}^2(e_i-e_k)^2\le0$, the record's diagonal identity. *The rewrite is agreement; nothing here is new but its use.*
- **The dichotomy a bound on $\Phi$ would give.** If $\Phi\le\varphi$ at every critical point, then $\mu\le\varphi/\theta$ or $\mu\ge\theta-\varphi/\theta$. The large branch meets the frame cap and forces $t_{\max}\ge(\theta_0-\varphi/\theta_0)/\sqrt{2(n-2)/(n-1)}$, large mass. The small branch gives $E\le\tfrac32\mu\le\tfrac32\varphi/\theta$, so $\theta^2\le\tfrac32(1+\varphi)$, below $\theta_0^2$ exactly when $\varphi<\tfrac23\theta_0^2-1$.
- **Screened on the $\mathbb{CP}^m$ family, closed forms** ($\theta\mu=\tfrac1{m-1}$, target.md): padded $\mathbb{CP}^2$ has $\Phi=\tfrac13$ on the large branch, and padded $\mathbb{CP}^3$ has $\Phi=0.275$ on the small branch, at every $n$ since padding keeps $\theta$ and the bottom of $\mathring W$. The small branch closes only if $\varphi<\tfrac23\theta_0^2-1$, which is $0.061$ at $n=14$, $0.140$ at $n=20$, $0.203$ at $n=30$ and passes $0.275$ only from $n\approx68$.

| $m$ | $2$ | $3$ | $4$ | $6$ | $8$ | $10$ |
|---|---|---|---|---|---|---|
| $\Phi(\mathbb{CP}^m)$ | $0.333$ | $0.275$ | $0.219$ | $0.153$ | $0.118$ | $0.095$ |
| branch | large | small | small | small | small | small |

**So a uniform bound on the lift closes the band only at $n\gtrsim68$, and there only as the unproved statement that padded $\mathbb{CP}^3$ maximises $\Phi$ on the small branch.** *The obstruction is the same as the $E$ route's: the $\mathbb{CP}^m$ family sits on the small branch with $\Phi$ of order $\tfrac1m$, above the threshold at every moderate $n$, and only their value clears them.* First closure of this round.

## Batch 2: the literature on the cubic itself (record)

- **[Branca–Catino–Dameno–Mastrolia 2024](../references/branca-catino-dameno-mastrolia-2024-yamabe-rigidity/notes.md)** state the cubic estimate $\lvert Q\rvert\le C(n)\lvert W\rvert^3$ with the sharp $C(4)$ and Huisken's and Tran's constants above, and conjecture $C(n)=\tfrac{\sqrt6}4$, which is $\theta\le\sqrt{3/2}$, on SLSQP evidence at $n=5,6$. *They prove nothing under a structural hypothesis that could cover part of the band, and the conjecture itself is false from $n=12$.* The second-kind cone papers of batch 1 of [2026-09-28f](2026-09-28f-LIT-step8-sweep.md) carry the Einstein constant in every term. **So the literature holds no value-sensitive estimate at moderate frame mass.** Second closure of this round.

## Batch 3: the $\Lambda^2$ loss through the index concentration (derived), and the concentrated node's first screen

- **Proposed in [the note](2026-09-28d-I121-smallmass-direct.md)**: weighting L198's rows gives $\theta p_3=p_4+\tfrac12S\le\theta^{-2}+\operatorname{tr}(W^2\#W^2)$, and the index step $\operatorname{tr}(W^2\#W^2)\le\tfrac18\lVert N\rVert_F^2$ would give $\theta^2\le\tfrac3{2\theta^2}+\tfrac3{16}\lVert N\rVert_F^2+\theta C_nt_{\max}$, clearing index-spread tensors past the $\mathbb{CP}^m$ scale from $n=30$. Batch 4 shows the index step false on Weyl tensors.
- **Screened, and false: $\lambda_{\max}(N)\le\tfrac14\operatorname{tr}N$** ([screen_I121_N_top.py](../scripts/misc/screen_I121_N_top.py)), which would have made $\lVert N\rVert_F^2\le4$ with equality only at padded four-dimensional tensors and reduced the concentrated node to them. Ascent reaches $\lambda_{\max}(N)/\operatorname{tr}N=0.333$ at $n=5$ and $0.352$ at $n=6$, and $\lVert N\rVert_F^2=4.01$ at $n=5$. *So index-concentrated critical points are not near padded $\mathrm{Weyl}_4$ in general, and the concentrated node needs its own value bound.* Third closure of this round, counted as the lemma the node would have used.

## Batch 4: Gate 2 on the index step, and $\Sigma_4$ (derived, screened)

- **[r1868](REVIEW_r1868.md) and [r1869](REVIEW_r1869.md), independently**: the weighted rows and the sign drop are [bounds.md](../findings/bounds.md)'s $S_{22}$ identity with $G_2\ge0$ dropped, and the index step's coordinate formula keeps only the $k=l$ slice of a double sum. Exact: $\operatorname{tr}(W^2\#W^2)=\tfrac18\lVert N\rVert_F^2-\tfrac12\Sigma_4$.
- **$\Sigma_4=2\operatorname{tr}W^4-6\lVert\mathrm{Alt}(W^2)\rVert^2$** (derived here), so the index step says the $\Lambda^4$ part of $W^2$ carries at most a third of its mass. At $n=4$, $\Sigma_4=2\lVert W^+\rVert^2\lVert W^-\rVert^2\ge0$.
- **False on Weyl tensors from $n=5$** ([screen_I121_sigma4.py](../scripts/misc/screen_I121_sigma4.py)): bounded descent reaches $\Sigma_4/\operatorname{tr}W^4=-0.182$, $-\tfrac23$, $-1.143$, $-1.631$ at $n=5,6,7,8$, and the $n=6$ witness, a critical point at $\theta=0$, has isotropic $N$ with $\operatorname{tr}(W^2\#W^2)=\tfrac38>\tfrac13$ ([r1871](REVIEW_r1871.md), [r1872](REVIEW_r1872.md)). Open at critical points with $\theta>0$, where nothing on the record supplies it. **Fourth closure of this round.** *Every estimate the $E$ route has tried at its three losses is saturated or beaten by a tensor outside the band's value range, so the band needs criticality beyond the row identities.* A fifth closure redirects to [I73](../plan.md).
