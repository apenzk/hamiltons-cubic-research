# Step 8 sweep, 2026-09-28c: questioning the approach at the small-mass node

*Position file: [2026-09-28c-step8-position.md](2026-09-28c-step8-position.md).*

## Batch 1, the record: candidate 1 is route R6's step at one eigenspace

*Gate 2: [r1842](REVIEW_r1842.md), [r1843](REVIEW_r1843.md), folded.*

- **Candidate 1, a decomposable vector in the top eigenspace, is [R6](../routes.md)'s step "force a maximiser to be diagonalisable" asked of one eigenspace**, and it is obstructed where R6 is ([diagonality.md](../findings/diagonality.md)). Padded $W_{\mathbb{CP}^2}$ is a **local maximum** with $\max\operatorname{spec}(L_e|_{W^\perp})=\tfrac12$, and its top eigenspace is the line through $\omega_1=(e_{12}+e_{34})/\sqrt2$ at $2/\sqrt6$, a rank-$4$ bivector, so it holds no decomposable vector ([r1842](REVIEW_r1842.md), the Plücker certificate on record being for the $2$-dimensional bottom eigenspace at $-1/\sqrt6=-0.408248$). R6 is **the record's lifting lemma renamed** ([problem.md](../findings/problem.md) item 11), and its successor criterion reads: *separate a maximiser from an obstructed local max by something other than the value.*
- **Frame maximality separates frames of one tensor, and R6's criterion asks to separate two tensors.** Every tensor has a globally maximal frame, padded $W_{\mathbb{CP}^2}$ included, so no frame condition at any order meets R6's criterion ([r1842](REVIEW_r1842.md), [r1843](REVIEW_r1843.md)). What frame maximality does is exclude a maximiser seen in a non-maximal frame, which is [post F81](../findings/fence-posts.md)'s requirement: its witness is the balanced product itself, rotated.
- **The small-mass node is the lifting lemma's small-mass part, and its locus holds obstructed critical points.** Padded $W_{\mathbb{CP}^2}$ sits at $t^2=\tfrac12$ in its maximal frame, but $\mathbb{CP}^4$ and $\mathbb{CP}^5$, also Plücker-obstructed, have frame-minimal off-diagonal mass $0.837$ and $0.866$ ([diagonality.md](../findings/diagonality.md)), so maximal-frame $t^2=0.30$ and $0.25$, which is $\tfrac3{n+2}$. They are cleared only by their value, $\theta(\mathbb{CP}^m)<\sqrt{3/2}$ at every $m\ge3$ ([r1843](REVIEW_r1843.md)). **So a bound at small maximal-frame mass uses the value**, with frame maximality excluding frame artefacts such as F81's witness.

## Phase 3b

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| I121 continued: $\theta\le\sqrt{3/2}$ at critical points of small maximal-frame mass, using the value and enough frame maximality to exclude F81's witness | 3 | 1 | 1 | 1 | 3 | Conjecture A at even $n\ge12$, no method |
| [I73](../plan.md), the two-value spectrum, the plan's named fallback | 3 | 1 | 1 | 1 | 3 | Conjecture A via [L105](../findings/bounds-relaxations.md), no method for the asymmetric spectra |
| the four-set line in full ([I104](../plan.md)), where the pair identity lands small mass | 1 | 1 | 1 | 1 | 1 | the four-set-dominated regime only |

**The top two tie, and the manager chose I121** under the user's standing direction: the small-mass statement is $P$'s own core, which I73 reaches too with fewer tools, so the next cycle attacks it directly by any method, with I73 as the fallback ([plan.md](../plan.md)).

## Along equal-angle matching rotations, maximality is two conditions (pair-free $W$)

*Gate 2: the algebra CONFIRMED by [r1842](REVIEW_r1842.md) and [r1843](REVIEW_r1843.md), each re-deriving it, and the per-block identity is `block_angle` and `block_linear` in [MatchingAngle.lean](../lean/HamiltonsCubic/Results/MatchingAngle.lean).*

For a pair-free $W$, a perfect matching $M$ and an orientation of each of its planes, rotate every plane of $M$ by the same angle $\varphi$. On each edge-pair block write the diagonal mass as $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$ ([the double-rotation note](2026-09-28-I121-MG-audit.md)). With no pair part, $\alpha_{IX}=\alpha_{XI}=\alpha_{ZX}=\alpha_{XZ}=0$, so $\alpha_{IZ},\alpha_{ZI}$ scale by $c=\cos2\varphi$ and $\alpha_{ZZ}\mapsto\alpha_{ZZ}c^2+\alpha_{XX}s^2$, $s=\sin2\varphi$. The rotation preserves each block's span and fixes the edge entries $a_e$, so summing over the edge pairs of $M$,
$$f(\varphi)-f(0)=4s^2\,g(s^2),\qquad g(u)=-S_{IZ}-2S_{ZZ}+2S_{ZX}+u\,(S_{ZZ}-2S_{ZX}+S_{XX}),$$
with $S_{IZ}=\sum(\alpha_{IZ}^2+\alpha_{ZI}^2)$, $S_{ZZ}=\sum\alpha_{ZZ}^2$, $S_{ZX}=\sum\alpha_{ZZ}\alpha_{XX}$, $S_{XX}=\sum\alpha_{XX}^2$. **$g$ is affine in $u=s^2$, so maximality along the family is two conditions**: $g(0)\le0$, the second-order condition along $\xi_M$, and $g(1)=S_{XX}-S_{ZZ}-S_{IZ}\le0$, the $\tfrac\pi4$ matching inequality at zero pair part.

- **Orientation.** Reversing one plane's orientation conjugates its blocks by $Z\otimes I$, which negates $\alpha_{XX}$ there and fixes $\alpha_{ZZ},\alpha_{IZ},\alpha_{ZI}$. So $S_{ZX}$ and $g(0)$ depend on the orientation pattern, giving $2^{n/2-1}$ second-order conditions, while $g(1)$ is shared ([r1843](REVIEW_r1843.md), checked here by hand).
- **The fourth-order Taylor condition binds only where $g(0)=0$**, and there it is $g(1)\le0$. F81's witness lies on that stratum: $g(0)=0$ and $E(M)=\tfrac{11}{12}$ against $t^2-\sum_{e\in M}a_e^2=\tfrac1{132}$ at $n=12$ ([r1842](REVIEW_r1842.md)).
- **With a pair part** the family gains odd terms in $cs$, including a first-order term along $\xi_M$, and is then strictly stronger than the $\tfrac\pi4$ inequality alone ([r1842](REVIEW_r1842.md)). A maximiser's maximal frame is not known to be pair-free.

## The matching family's strength (screens at $n=8$)

- **The first screen tested a relaxation.** [screen_I121_matching_feasible.py](../scripts/misc/screen_I121_matching_feasible.py) compares $V_M$ with $t^2$, where the inequality reads $V_M+\tfrac14\sum s_{ef}^2\le t^2-\sum_{e\in M}a_e^2$. Every frame it returns violates the full inequality: by $0.050$ to $0.060$ at a cap of $0.1$, and by $0.016$ and $0.025$ at a cap of $0.2$ ([r1842](REVIEW_r1842.md), [r1843](REVIEW_r1843.md)). *Validated here by direct rotation, sharing none of the Hadamard algebra* ([check_I121_matching_direct.py](../scripts/misc/check_I121_matching_direct.py)): the same frames gain $0.050$ to $0.070$ of diagonal mass under some $\tfrac\pi4$ matching rotation.
- **On the full family the screens disagree at $t^2\approx0.2$ and agree below.** Descent on the full inequality over the $105$ matchings found no feasible frame at either cap, the closest at $t^2\approx0.17$ to $0.19$ with excess about $0.012$ ([r1843](REVIEW_r1843.md)). Descent on direct rotation over all $840$ matching and orientation patterns found one frame of the product at $t^2=0.2114$ where every $\tfrac\pi4$ matching rotation lowers the diagonal mass, and none at a cap of $0.1$ (excess $0.036$ to $0.063$). First order along each $\xi_M$ was not imposed, and the relaxed screen's frames fail it ([r1842](REVIEW_r1842.md)).
- **So the matching family's floor at $n=8$ is not located**, beyond lying near $t^2\approx0.2$ for the $\tfrac\pi4$ inequalities alone, and nothing here fixes its dependence on $n$.
