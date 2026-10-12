# Review r1911: the absolute trace floor and H on f4, e6, e7, e8

Log: [agent_logs/r1911-trace-floor.log](../agent_logs/r1911-trace-floor.log). Section under review: "An absolute trace floor, and H asks nothing of f4, e6, e7, e8" in [the I117 working note](2026-09-28l-I117-g2-torus.md). Lean: [ExceptionalH.lean](../lean/HamiltonsCubic/Results/ExceptionalH.lean). Footing: analysis only; the two screens below are seconds of arithmetic on objects built for the purpose, reported as screens.

**Verdict: CONFIRMED.** (1) and (2) hold as stated. One correction to the second closing bullet (g2 passes already at j = 2, not only j ≥ 4), one simplification that removes L256, L265 and L286 from (2), and one stale sentence on the record (L266's *What it gives*).

| # | claim | verdict |
|---|---|---|
| 1 | diagonal identity, row sum, chain to 2 ≤ K tr C | CONFIRMED |
| 2 | K = max ‖[x,y]‖² = max ‖ad_x‖²_op = abs(θ)² | CONFIRMED |
| 3 | abs(θ)² = 2c/h∨, c = h∨/j, the indices 3, 6, 12, 30 | CONFIRMED |
| 4 | g = 1 − r/2 = γ*/c, the lower-end formula, monotonicity, the four values | CONFIRMED |
| 5 | assembly, every embedding including reducible ones | CONFIRMED (simplification available) |
| 6 | closing bullets | first CONFIRMED; second PLAUSIBLE with a correction |
| 7 | Lean | CONFIRMED, standard axioms only |
| 8 | prior record | new to the record; L266's closing sentence goes stale |

## 1. The diagonal identity and the chain

- $C^\#C=\tfrac12\sum_{i,j}\lambda_i\lambda_j[u_i,u_j][u_i,u_j]^{\mathsf T}$ from bilinearity and the rank-one rule, so the $(m,m)$ entry is $\tfrac12\sum_{i,j}c_{ijm}\lambda_i\lambda_j$. Correct.
- $\langle[u_i,u_j],u_m\rangle=\pm\langle u_i,[u_j,u_m]\rangle$ by invariance of the restricted metric (the $\mathfrak{so}(n)$ trace form is ad-invariant and $\mathfrak h$ is a subalgebra), so $\sum_ic_{ijm}=\lVert[u_j,u_m]\rVert^2$ provided $\{u_i\}$ is an orthonormal basis of the whole of $\mathfrak h$. For PSD $C$ that is arranged by completing the eigenbasis on $\ker C$ with $\lambda_i=0$. PSD is enough.
- The chain uses $\lambda_i\le\lambda_m$ and $c_{ijm}\lambda_j\ge0$ (needs $\lambda_j\ge0$, PSD), then divides by $\lambda_m$. Division needs $\lambda_m>0$, which "nonzero PSD" supplies. $2\le\sum_j\lambda_j\lVert[u_j,u_m]\rVert^2\le K\operatorname{tr}C$ follows.

## 2. K = abs(θ)²

- $\max_{\lvert y\rvert=1}\lVert[x,y]\rVert=\lVert\mathrm{ad}_x\rVert_{\mathrm{op}}$ by definition. $\mathrm{ad}_x$ is skew in an invariant metric, hence normal, so its operator norm is its spectral radius.
- Conjugating $x$ into $\mathfrak t$ (compact group, conjugation an isometry), the spectrum is $\{0\}\cup\{\pm i\alpha(x)\}$, and $\max_{\lvert x\rvert=1}\max_\alpha\alpha(x)^2=\max_\alpha\lvert\alpha\rvert^2$ by Cauchy–Schwarz, attained at $x=\theta/\lvert\theta\rvert$ with $\theta$ long. Correct, in the metric dual to the restricted one on $\mathfrak t$.

## 3. abs(θ)² = 2c/h∨ and c = h∨/j

- $\operatorname{tr}(\mathrm{ad}_x^{\mathsf T}\mathrm{ad}_x)$ at $x=u_k$ is $\sum_{i,j}c_{ijk}=2c$ (L260). The same trace on $\mathfrak t$ is $\sum_{\alpha\in\Delta}\alpha(x)^2$ (each real root plane of $\pm\alpha$ contributes $2\alpha(x)^2$), which is $-B(x,x)$. If the metric is $s\cdot(-B)$, then $\lvert x\rvert^2=s\lvert x\rvert_B^2$ and $\lvert\theta\rvert^2=(\theta,\theta)_B/s=1/(sh^\vee)$, using the standard $(\theta,\theta)_B=1/h^\vee$. So $\sum_\alpha\alpha(x)^2=\lvert x\rvert^2/s=h^\vee\lvert\theta\rvert^2\lvert x\rvert^2$, and $2c=h^\vee\lvert\theta\rvert^2$. Confirmed.
- $c=h^\vee/j$: the $\mathfrak{so}(n)$ metric with orthonormal $e_{ab}$ is $\langle X,Y\rangle=-\tfrac12\operatorname{tr}_\rho(XY)$, and $\operatorname{tr}_\rho(XY)=(j/h^\vee)\,B(X,Y)$ in the convention where the adjoint has index $h^\vee$ (half of Slansky's). So $\lvert x\rvert^2=\tfrac12(j/h^\vee)\cdot2c\lvert x\rvert^2$, giving $c=h^\vee/j$. The index is additive, so reducible embeddings (trivial summands included) are covered with $j$ the sum.
- Record checks (half convention): $\mathfrak{so}(n)$ vector $j=1$, $c=n-2$ ✓; $\mathfrak g_2$'s $\mathbf 7$, $j=1$, $c=4$ ✓; $\mathfrak{sp}(k)$'s $\mathbb C^{2k}$ has index $\tfrac12$, realified $\mathbb R^{4k}$ has $j=1$, $c=k+1$ ✓. Hand check on $\mathfrak{so}(n)$: $x=(e_{12}+e_{34})/\sqrt2$ has $\lVert\mathrm{ad}_x\rVert^2_{\mathrm{op}}=2=2(n-2)/(n-2)$ ✓.
- **Screen** (seconds, $\mathfrak{su}(3)\subset\mathfrak{so}(6)$ through realified $\mathbb C^3$, $j=1$): $\sum_{i,j}c_{ijk}=6$ at every basis vector, so $c=3=h^\vee/j$, and the maximum of $\lVert\mathrm{ad}_x\rVert^2_{\mathrm{op}}$ over the unit circle of $\mathfrak t$ is $2.000000=2c/h^\vee$.
- Indices (half convention; Slansky's $\mathbf{26}$: 6, $\mathbf{27}$: 6, $\mathbf{56}$: 12, $\mathbf{248}$: 60): $\mathfrak f_4$'s $\mathbf{26}$ is real, $j=3$; $\mathfrak e_6$'s $\mathbf{27}$ is complex, realified $54$, $j=6$ (the real $\mathbf{78}$ has $j=12$); $\mathfrak e_7$'s $\mathbf{56}$ is quaternionic, real form $112$, $j=12$ (the real $\mathbf{133}$ has $18$); $\mathfrak e_8$'s $\mathbf{248}$, $j=30$. No nontrivial real representation has smaller index, since every other irreducible has larger index. What matters for (2) is the minimal $j$, not the minimal $n$, and these coincide here.

## 4. g, the lower-end formula and the values

- $\operatorname{Sym}^2\mathfrak h=\mathbf 1\oplus V(2\theta)\oplus Y$ with $V(2\theta)=\mathbf{1053}',\mathbf{2430},\mathbf{7371},\mathbf{27000}$ and $Y=\mathbf{324},\mathbf{650},\mathbf{1539},\mathbf{3875}$: dimensions $1+1053+324=1378$, $1+2430+650=3081$, $1+7371+1539=8911$, $1+27000+3875=30876$, each $d(d+1)/2$. Exactly two nontrivial components, as the D6 note's list (line 433) has it.
- Scalar $c-\mathrm{Cas}_V/4=c(1-r/2)$ since $\mathrm{Cas}_V=2cr$. On $V(2\theta)$, $r>2$ gives a negative scalar; on $Y$, $r<2$ gives the positive one. So $\gamma^*=c(1-r/2)$, $g=\tfrac5{18},\tfrac14,\tfrac29,\tfrac15$. Spot check for $\mathfrak e_8$: $\mathrm{Cas}(\mathbf{3875})/\mathrm{Cas}(\mathbf{248})=96/60=\tfrac85$.
- At $\tau=j=h^\vee/c$: $[j-(c-\gamma^*)j^2/d]/\gamma^*$ with $cj=h^\vee$, $\gamma^*=gh^\vee/j$ gives $j^2(1-h^\vee(1-g)/d)/(gh^\vee)$ ✓. Increasing in $j$ because the bracket is positive ($h^\vee<d$).
- **Screen** (exact rationals): $3.15$, $10.615$, $32.21$, $135.48$, matching the note.

## 5. The assembly

- $\tau\mapsto(\tau-A\tau^2)/\gamma^*$, $A=(c-\gamma^*)/d\ge0$, $\gamma^*>0$: concave, so on $[j,d/c]$ at least the smaller end value. $d/c=dj/h^\vee\ge j$, so the interval is nonempty. The upper end $\tau\le d/c$ is L260 (4) with $K=cI$ on simple $\mathfrak h$, which needs positive definiteness, and (2) assumes it.
- At $\tau=d/c$: $[d/c-(c-\gamma^*)d/c^2]/\gamma^*=d/c^2$ ✓, and $d/c^2\ge N/(n-2)^2$ by L256 (as used in L264 (3)).
- $N/(n-2)^2=\tfrac12\big(1+(3n-4)/(n-2)^2\big)$ decreases in $n$, equal to $\tfrac{36}{49}<\tfrac34$ at $n=9$ ✓.
- "Every embedding": every embedding is a faithful real orthogonal representation, possibly reducible, with $j\ge j_{\min}$ by additivity. Monotonicity in $j$ then covers all of them ✓.
- **Simplification (all four algebras, and more).** The D6 note (batch 33) and L260's *What it gives* already record $\operatorname{tr}C\le c\lVert C\rVert^2$ (pair with $I$, top eigenvalue of $I\#$ is $c$). With the floor this gives $\lVert C\rVert^2\ge h^\vee/c^2=j^2/h^\vee$ at once, for every nonzero PSD idempotent: $1,3,8,30$ for $\mathfrak f_4,\mathfrak e_6,\mathfrak e_7,\mathfrak e_8$, each $>\tfrac34$. No concavity, no L265 scalar, no L256, no L286, and positive semidefinite suffices. The concave route is correct but stronger than needed. The general criterion is: **H asks nothing of any embedding with $j^2\ge\tfrac34h^\vee$**, or, via L286 (1)'s sharper end value, $j^2(1-h^\vee(1-g)/d)/(gh^\vee)\ge\tfrac34$.

## 6. The closing bullets

- **First bullet: CONFIRMED.** $h^\vee/d=\tfrac4{14}=\tfrac27$ on $\mathfrak g_2$ and $(k+1)/(k(2k+1))\approx1/(2k)$ on $\mathfrak{sp}(k)$. The description of L260 (4)'s obstacle matches the D6 note line 331 ("none gives the absolute lower bound on the trace that U needs").
- **Second bullet: PLAUSIBLE, one correction.** $\mathfrak g_2\subset\mathfrak{so}(7)$: floor $1$ against $\tfrac{12}7$ ✓, and the end value $\varphi(1)=\tfrac12<\tfrac{36}{49}$ confirms the method fails there. $\mathfrak{sp}(k)$ in $\mathbb R^{4k}$: floor $1$, $\varphi(1)=2(1-\tfrac1{4k+2})/(k+2)<\tfrac12$ ✓. $\mathfrak{so}(k)$ ($\gamma^*=\tfrac{k-4}2$) and $\mathfrak{su}(k)$ ($\gamma^*=c/2$) at $j=1$ have $\varphi(1)\approx2/k$ or $2/c$ and threshold $\tau_-\approx\gamma^*\cdot\tfrac34$ growing with $k$ ✓. **Correction:** "the larger embeddings of $\mathfrak g_2$ ($j\ge4$) pass" lists only irreducible ones. The reducible $\mathbf7\oplus\mathbf7\subset\mathfrak{so}(14)$ ($j=2$) and $\mathbf7^{\oplus3}$ ($j=3$) also pass: $\varphi(2)=2$, $\varphi(3)=4.5$ (and even the simple bound $j^2/4=1$ at $j=2$). The sentence should read: *every embedding of $\mathfrak g_2$ with $j\ge2$ passes, so only $\mathbf7$ plus trivial summands ($j=1$) is left, which is $\mathfrak g_2\subset\mathfrak{so}(7)\subset\mathfrak{so}(n)$.* The same holds for doubled embeddings of $\mathfrak{sp}(k)$ at small $k$ ($\varphi(2)=4\varphi(1)$).

## 7. Lean

- `trace_floor`: hypotheses $c_{ijk}\ge0$, $\lambda_i\ge0$, $\lambda_i\le\lambda_m$, $\lambda_m>0$, the diagonal row identity over all $i,j$, and $\sum_ic_{ijm}\le K$ for every $j$; conclusion $2\le K\sum_i\lambda_i$. States exactly the table's scalar core ✓.
- `concave_min`: $\min(a-Aa^2,b-Ab^2)\le t-At^2$ for $A\ge0$, $a\le t\le b$ ✓ (the $1/\gamma^*$ scaling is positive, so it transfers).
- `f4_end` … `e8_end`: literal instances of $j^2(1-h^\vee(1-g)/d)/(gh^\vee)>\tfrac34$ with $(j,h^\vee,d,g)=(3,9,52,\tfrac5{18})$, $(6,12,78,\tfrac14)$, $(12,18,133,\tfrac29)$, $(30,30,248,\tfrac15)$ ✓.
- Axioms: all six depend only on propext, Classical.choice, Quot.sound (`#print axioms`, exit 0), no sorryAx.
- The docstring's untyped list matches the table's prose row.

## 8. On the record already?

- No trace lower bound is on the record. [second-order.md](../findings/second-order.md) L266's *What it gives* says "No such lower bound is in hand: every pairing and stability bound on record caps the trace from above", and L260 and the D6 note (line 331) state the same obstacle. The floor $\operatorname{tr}C\ge h^\vee/c$ is new.
- **Downstream:** L266's sentence goes stale once the floor is folded. L266 (2) with the floor gives, at a maximiser supported on a proper simple $\mathfrak h$, $h^\vee/c\le d/\mathrm{Cas}_{\mathfrak h}(V)$ for every invariant irreducible $V\subseteq\mathfrak h^\perp$. That is a support restriction worth recording.
- The exceptional algebras appear on the record only in L256's ratio table ($C/\sqrt d<1$) and L265's stability list. Neither gives H on them for general idempotents.
