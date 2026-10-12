# Gate 2 brief: the rows' blindness to anticommutators, and the criticality prefactor (r1167, r1168)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct only as a screen. Model: opus.

## The claims, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) at a011da9c

> **Why the rows cannot see the Ricci part of a pair product.** For skew $u,v,w$, $\operatorname{tr}(uvw)=\tfrac12\operatorname{tr}([u,v]w)+\tfrac12\operatorname{tr}(\{u,v\}w)$ and the second term vanishes, a symmetric matrix having zero trace against a skew one. **So every quantity built from $\Lambda^2$ pairings of products, including all the per-vector rows $b_{ab}(x)$, sees only the skew part $[u,v]$ of $uv$; the symmetric part $\{u,v\}$, which is $-2h_{uv}$, is invisible to them.** *This is why the band's requirement (near-skew products on $V_+$, equivalently small $h_x$) cannot come from the rows: it needs an identity pairing anticommutators with something, and the only one on file is criticality evaluated on symmetric directions (the paragraph above on $Q_c$), where $\mathring W(h,h)$ appears.* Algebra; no computation.

> **Criticality on symmetric directions moves the Ricci imbalance to a $1/\kappa$ prefactor, and the crude bound gives the factor back.** Applying the action on symmetric 2-tensors to the operator identity $W^\#=\theta W-W^2$ and evaluating at $h$ (record's convention for $\mathring W$): $\mathring W(h,h)=\sum_c\lambda_cQ_c(h)$, $(W^2)^\circ(h,h)=\sum_c\lambda_c^2Q_c(h)$, $(W^\#)^\circ(h,h)=\sum_{a,b}\lambda_a\lambda_b\mathring B_{ab}(h,h)$ with $\mathring B_{ab}(h,h)=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}\operatorname{tr}\big([\psi_\gamma,\psi_\delta]h[\psi_\gamma,\psi_\delta]h\big)$. On the symmetric family this reads
> $$Q_2(h)-Q_0(h)=\frac a\theta\Big(Q_0(h)+Q_2(h)+\big(\mathring B_{00}+\mathring B_{22}-2\mathring B_{02}\big)(h,h)\Big),\qquad\frac a\theta=\frac1\kappa\approx\frac1n .$$
> **So the imbalance that sizes the Ricci correction carries a prefactor $1/\kappa$, the extra factor of $n$ the band needs, provided the bracket is $O(n)\lvert h\rvert^2$.** *It is not, by the crude bound: $\lvert\mathring B_{ab}(h,h)\rvert\le\tfrac12\operatorname{tr}(h^2A_{ab})$ with $A_{ab}=\sum[\psi_\gamma,\psi_\delta]^{\mathsf T}[\psi_\gamma,\psi_\delta]$, and $\sum_{a,b}A_{ab}=2(n-1)(n-2)I$ by invariance (the Casimir mass, `casimir_skew_lt`), so the individual $\mathring B_{ab}$ are only $O(n^2)\lvert h\rvert^2$ and the prefactor is spent.* **The gap is precise: the band needs $\big(\mathring B_{00}+\mathring B_{22}-2\mathring B_{02}\big)(h_x,h_x)=O(n)\lvert h_x\rvert^2$ on the certificate's vectors, a cancellation among the bracket actions that the total $\sum_{a,b}\mathring B_{ab}=(n-2)\mathring{\mathrm{Id}}$, which is $O(n)$, suggests but does not force.** Derivation from the record's identities; the Casimir constant typed; no computation.
> 

## Givens (audited)

- The operator identity $W^\#=\theta W-W^2$ on $\Lambda^2$ at a critical point ([L234](../findings/second-order.md) step (1)); $B_{ab}=P_a\#P_b=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$; $\sum_{a,b}B_{ab}=(n-2)\mathrm{Id}$.
- The record's identities $\sum_c\lambda_cQ_c(h)=\mathring W(h,h)$ and $\sum_cQ_c(h)=\lvert h\rvert^2-(\operatorname{tr}h)^2$ (their sign convention for $\mathring{}$, opposite to $B_{\mathrm{Ric}}$'s per [r1159](REVIEW_r1159.md)).
- `casimir_skew_lt` in [Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean): $\sum_{i<j}\lVert[\varphi_{ij},x]\rVert_F^2=2(n-2)\lVert x\rVert_F^2$ for skew $x$.

## Lean

| claim | declaration |
|---|---|
| $\operatorname{tr}(\{u,v\}w)=0$ for $u,v,w$ skew | none: a one-line trace fact, typed nowhere; say whether it should be |
| the prefactor identity and the $A_{ab}$ bound | none: the action $\mathring{}$ of a $\Lambda^2$ operator on symmetric tensors has no declaration |

## Items

1. The blindness paragraph: is $\operatorname{tr}(uvw)=\tfrac12\operatorname{tr}([u,v]w)$ for skew $u,v,w$ right, and does it follow that every per-vector row sees only $[u,v]$? Is "the only identity on file pairing anticommutators is criticality on symmetric directions" accurate?
2. The prefactor identity: is the linear action $\mathring{}$ applied correctly to $W^\#=\theta W-W^2$, is $(W^\#)^\circ=\sum\lambda_a\lambda_b\mathring B_{ab}$ right, and does the symmetric-family form follow with the stated signs?
3. The bound: is $\lvert\mathring B_{ab}(h,h)\rvert\le\tfrac12\operatorname{tr}(h^2A_{ab})$ right, and is $\sum_{a,b}A_{ab}=2(n-1)(n-2)I$ (check against `casimir_skew_lt`)?
4. Is the stated gap (the combination being $O(n)\lvert h_x\rvert^2$) correct and complete, and is anything stated beyond support?

## Protocol

Reviewer N (1167 or 1168) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any other file; do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
