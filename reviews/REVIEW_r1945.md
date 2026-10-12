# REVIEW r1945: I124 batch 10, the superposition bound

Reviewer r1945, Gate 2, on batch 10 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Log: [agent_logs/r1945-i124-superpos.log](../agent_logs/r1945-i124-superpos.log). Analysis-only footing: every number below is a screen of seconds on objects constructed for it, and the one positive claim that rests on a screen value says so.

**Verdict.** The identity and the bound $P(W)\le\Theta_n+P(N)$ at $n\ge12$ are CONFIRMED, with every step checked by hand. **The target (★) is REFUTED as stated**: the Weyl tensor of $\mathbb{CP}^6$ at $n=12$ is a unit critical point with $P=0.92496<\Theta_{12}$ and $P(N_F)\ge0.085>0$ in every orthonormal frame, by a two-line bound that needs only its value $\theta$. So (★) cannot be proved for all unit Weyl tensors, and restricted to tensors with $P(W)>\theta_0$ it is equivalent to P itself, so the reduction carries no content beyond the bound. The "owed" frame-averaging argument must use $P(W)>\theta_0$ or maximality.

| # | claim | verdict |
|---|---|---|
| 1 | three vanishings and the expansion | CONFIRMED |
| 2 | the identity, weights, unit tensors | CONFIRMED (edge cases $a=0$, $b=0$ unstated, trivial) |
| 3 | pair-character cap from L224 | CONFIRMED |
| 4 | four-set cap via L220, and the character types | CONFIRMED (L220's own $n\ge12$ clause states the cap outright) |
| 5 | reduction to (★), and the balanced-product remark | implication and remark CONFIRMED, **(★) itself REFUTED** by $\mathbb{CP}^6$ at $n=12$ |
| 6 | critical-point reading and the cap $\Theta_n\frac{1+2a^3}{3a^2}$ | CONFIRMED, with two scope notes |
| 7 | hunt on (★) | counterexample found at $n=6,8,12$ ($\mathbb{CP}^{n/2}$), analytic at $n=12$ given $\theta$ |
| 8 | Lean and screen | CONFIRMED (file compiles, screen reproduced at $n=5,6$) |
| 9 | record search | NEW as assembled, and claim 6 is L214's first relation plus the new cap |

## 1. The three vanishings

- The trivial sign character on $\mathrm{Sym}^2(\Lambda^2)$ is spanned by $e_{ab}\odot e_{ab}$ alone, since $e_{ab}\odot e_{cd}$ carries the character of $\{a,b\}\triangle\{c,d\}$. So $D$ is the trivial-character part of $\mathcal W_n$, the Weyl space being $O(n)$-invariant, and $\pi_D$ commutes with the character projections.
- $T(\hat A,\hat A,N)=\langle\hat A\circ\hat A,N\rangle=\langle Q(\hat A),N\rangle$, with $Q(\hat A)$ of character $1$, so it is orthogonal to every nontrivial character. CONFIRMED.
- $\hat A\circ N_\chi$ has character $\chi$, orthogonal to $V_\psi$ for $\psi\ne\chi$ (the group acts orthogonally). CONFIRMED.
- $\hat N_\chi\circ\hat N_\chi$ has character $\chi^2=1$, so it lies in $D\perp V_\chi$ and $P(\hat N_\chi)=0$. CONFIRMED.
- Expansion: $P(a\hat A+N)=a^3p+3a^2T(\hat A,\hat A,N)+3aT(\hat A,N,N)+P(N)$ and $T(\hat A,N,N)=\sum_\chi\lVert N_\chi\rVert^2T(\hat A,\hat N_\chi,\hat N_\chi)$ by the second vanishing. $P(N)$ keeps its cross terms $T(N_\chi,N_\psi,N_\rho)$ with $\chi\psi\rho=1$, and the section leaves it whole, which is right.

## 2. The identity

- $\sum_\chi w_\chi^2(a^3p+3ab^2t_\chi)=a^3p+3a\sum_\chi\lVert N_\chi\rVert^2t_\chi$ since $w_\chi^2b^2=\lVert N_\chi\rVert^2$ and $\sum w_\chi^2=1$. Adding $P(N)$ gives $P(W)$. CONFIRMED.
- $\lVert a\hat A+b\hat N_\chi\rVert^2=a^2+b^2=1$ by orthogonality of $D$ and $V_\chi$. CONFIRMED.
- Edge cases the statement leaves implicit: at $b=0$ the weights are undefined and $W$ is diagonal (L57 directly), and at $a=0$ any unit $\hat A$ serves. Neither affects the bound.

## 3. The pair cap

L224 is stated for every unit $W\in\mathcal D_n\oplus V_{jk}$, $n\ge4$, with $V_{jk}$ the Weyl elements $\nu_x=\sum_ax_ae_{ja}\odot e_{ka}$, $\sum x=0$. The character $\varepsilon_j\varepsilon_k$ space of $\mathrm{Sym}^2(\Lambda^2)$ is spanned by exactly these $e_{aj}\odot e_{ak}$, and Ricci-flatness at $(j,k)$ is $\sum x=0$. So $a\hat A+b\hat N_{jk}$ is in L224's domain and $P\le\Theta_n$. CONFIRMED.

## 4. The four-set cap and the character list

- $\mathcal D_n\oplus V_Q$ is the fixed space of $\ker\chi_Q$ (L220 step 1), hence closed under $\circ$, and a maximiser of $P$ on its unit sphere satisfies $Q(W)=\theta W$ in $\mathcal W_n$ because $Q(W)$ lies in the subspace. CONFIRMED.
- L220's hypotheses at that maximiser: $n\ge12\ge5$. $\theta=\max>0$ because the maximum is at least $\Theta_n>0$ (attained on $\mathcal D_n$). If $\nu\ne0$ then $\theta\le\sqrt{3/2}$, and if $\nu=0$ it is diagonal and L57 applies. CONFIRMED. L220's statement already ends "Hence at $n\ge12$, $\sup P=\Theta_n$ on the unit sphere of $\mathcal S_Q$", so citing that clause would be shorter.
- $\sqrt{3/2}<\Theta_n$ at $n\ge12$: $\Theta_{12}^2=220/144=1.528$, $\Theta_{13}^2=240/154=1.558$, both formulas increasing in $n$ ($2(1-\tfrac1n)(1-\tfrac2n)$ at even $n$, $2\big(1-\tfrac{3n-5}{n^2-n-2}\big)$ at odd $n$). CONFIRMED.
- Character types: the odd-multiplicity set of $\{a,b\}\sqcup\{c,d\}$ has size $0$, $2$ (one shared index) or $4$ (disjoint pairs). So trivial, pair and four-set are all. CONFIRMED.
- The weighted average of values each at most $\Theta_n$ is at most $\Theta_n$. CONFIRMED.

The $n\ge12$ hypothesis is load-bearing. The screen at $n=5$ found padded $\mathbb{CP}^2$ at $P=\sqrt{3/2}>\Theta_5$ with $P(N_F)=0$ in its L220 frame, so $P(W)\le\Theta_n+P(N)$ fails below twelve, as the four-set cap predicts.

## 5. The reduction and the balanced product

- If (★) held, then at even $n\ge12$ every unit $W$ has $P(W)\le\theta_0+P(N_F)\le\theta_0$. The implication is CONFIRMED.
- At the balanced product $P=\Theta_n$, so $P(N_F)\ge0$ in every frame, and $N=0$ in the product-adapted frames, where the curvature operator is diagonal in $e_a\wedge e_b$. CONFIRMED.
- **(★) as stated is false** (item 7). Every counterexample to P would have $P(N_F)\ge P(W)-\theta_0>0$ in every frame, so (★) restricted to $\{P(W)>\theta_0\}$ is equivalent to P, and (★) on all unit tensors fails at $\mathbb{CP}^6$. **Correction**: state the reduction as "P at even $n\ge12$ is equivalent to: no unit $W$ with $P(W)>\theta_0$ has $P(N_F)>0$ in every frame", and drop the universal (★). The bound's content is the per-frame inequality and its reading at critical points, and the reduction adds nothing beyond it.

## 6. The critical-point reading

- Pair $Q(W)=\theta W$ with $\hat A$: $T(W,W,\hat A)=a^2p+\sum_\chi\lVert N_\chi\rVert^2t_\chi=\theta a$. Substituting into the expansion gives $P(N)=\theta(1-3a^2)+2a^3p$, so $\sum_\chi w_\chi^2P(W_\chi)=3\theta a^2-2a^3p$. With the cap this is $3\theta a^2-2a^3p\le\Theta_n$. CONFIRMED.
- The section says "at a critical point with $\theta\ge\Theta_n$". The inequality holds at every critical point, so the qualifier is unneeded.
- With $p\le\Theta_n$ (L57) and $a>0$, $\theta\le\Theta_n\frac{1+2a^3}{3a^2}$. CONFIRMED. The factor $\tfrac13(a^{-2}+2a)$ is decreasing on $(0,1]$ with value $1$ at $a=1$, so the cap is at least $\Theta_n$ at every $a$ and excludes nothing above $\Theta_n$. "Tends to $\Theta_n$ as $a\to1$" is accurate, but the record should say the cap is never below $\Theta_n$.
- This is [L214](../findings/second-order.md)'s first relation $\theta t=P(D)+a_{L214}$ read through the new cap: $\sum w_\chi^2P(W_\chi)=P(D)+3a_{L214}=3\theta t-2P(D)$.

## 7. Hunt: (★) fails at $\mathbb{CP}^{n/2}$

**Construction.** $W$ is the Weyl tensor of Fubini–Study $\mathbb{CP}^m$, $n=2m$, holomorphic curvature $4$, normalised. It is $U(m)$-invariant, the $U(m)$-invariant Weyl tensors form a line, so $Q(W)=\theta W$ with $\theta=P(W)$ (screen residual $10^{-16}$).

**Analytic part (every frame).**
1. In a frame $F$ the diagonal entries are the Weyl sectional curvatures of the coordinate planes, $K_W(e_a,e_b)=3c_{ab}^2-\tfrac3{n-1}$ with $c_{ab}=\langle Je_a,e_b\rangle$, because the manifold is Einstein with mean sectional curvature $\tfrac{n+2}{n-1}$.
2. $\sum_{a<b}c_{ab}^2=\tfrac12\sum_a\lvert Je_a\rvert^2=\tfrac n2$ and $c_{ab}^2\le1$, so $\sum c_{ab}^4\le\tfrac n2$, with equality in a unitary frame. Hence $\lVert\pi_{D_F}W\rVert^2\le\tfrac{9n(n-2)}{2(n-1)}$, and $t_F=a_F^2\le\tfrac3{n+2}$ at unit norm ($\lVert W\rVert^2=\tfrac{9n(n-2)(n+2)}{6(n-1)}$ unnormalised, checked at $n=6,8,12,16$).
3. By item 6, $P(N_F)=\theta(1-3t_F)+2t_F^{3/2}p_F$, and $p_F\ge-\Theta_n$ by L57 applied to $-\hat A$. So $P(N_F)\ge g(t_F):=\theta(1-3t_F)-2\Theta_nt_F^{3/2}$, which decreases in $t_F$.
4. At $n=12$, $t_F\le\tfrac3{14}$ and $g(\tfrac3{14})=\tfrac5{14}\theta-2\Theta_{12}(\tfrac3{14})^{3/2}>0$ exactly when $\theta>0.687$.

**The one screen input.** $\theta=P(W_{\mathbb{CP}^6})=0.924962$, so $g(\tfrac3{14})=0.0851>0$ and **every frame has $P(N_F)\ge0.085$**, while $P(W)<\Theta_{12}=1.23603$. The value is a direct evaluation of one fixed tensor, and a closed form would remove even that.

**Screen corroboration.**

| $n$ | $P(W_{\mathbb{CP}^{n/2}})$ | $\Theta_n$ | $P(N)$ unitary frame | min over frames found |
|---|---|---|---|---|
| 6 | 1.054093 | 1.054093 | 0.1647 | 0.1647 (3 L-BFGS + 6 BFGS starts) |
| 8 | 0.986013 | 1.145644 | 0.2761 | 0.2761 (3 starts, 200 random frames min 0.551) |
| 12 | 0.924962 | 1.236033 | 0.4153 | 0.4153 (2 starts, 60 random frames min 0.754) |

The unitary frame appears to minimise $P(N_F)$. A side observation: $P(W_{\mathbb{CP}^3})=\Theta_6$ to six digits, a tie with $S^3\times S^3$ at $n=6$ worth checking against the record.

**At a maximiser.** (★) at a global maximiser is equivalent to P (a maximiser above $\theta_0$ has $P(N_F)>0$ in every frame, and the balanced product has a frame with $P(N)=0$). So nothing forces (★) at a maximiser beyond P itself. The $\mathbb{CP}^6$ example shows a proof of the "owed" frame inequality must use $P(W)>\theta_0$, criticality at a large value, or maximality. A statement for all unit $W$ is false.

## 8. Lean and screen

- `superposition_bound` in [I124Circle.lean](../lean/HamiltonsCubic/Results/I124Circle.lean) is the scalar averaging step with the identity and the caps as hypotheses, which is what the section claims. The file compiles (`lake env lean`, exit 0, no errors). CONFIRMED.
- Screen reproduced independently at $n=5$ and $n=6$ with my own $\#$ ($I\#I=(n-2)I$ asserted): $P(W)$ equals the right side to $10^{-16}$ in the coordinate frame and in a random rotated frame, $\sum w_\chi^2=1$, and the characters present have sizes $2$ and $4$. CONFIRMED as a screen.

## 9. Record search

- [L214](../findings/second-order.md) (frame split): gives $\theta t=P(D)+a$ and $\theta(1-t)=2a+P(N)$ at critical points in any frame. Item 6 is its first relation plus the new cap. The decoupled bound there (post F67) bounds $P(d)$ and $\langle L_d\nu,\nu\rangle$ separately. Batch 10 keeps them coupled per character through the exact $P(a\hat A+b\hat N_\chi)=a^3p+3ab^2t_\chi$, so post F67's objection does not apply.
- [L220](../findings/second-order.md)'s corollary (J) uses the same single-character computation $P(cd+s\nu)=c^3P(d)+3cs^2e$ on one four-set block. [L224](../findings/second-order.md)'s `L224_cubic` is the pair-block version.
- [L284](../findings/second-order.md) and R52 to R54 use the same character split for the mixing-gap identity and (MG), a different quantity. [bispectral.md](../findings/bispectral.md) line 90 is a $t_F$-weighted bound of a different form.
- No frame-wise bound $P(W)\le\Theta_n+P(N_F)$ was found. **Classification: NEW as an assembly**, its per-character pieces on record in L220 (J) and L224, and its critical-point reading being L214.

## Corrections to fold

1. Drop (★) as a universal statement. It is false at $\mathbb{CP}^6$, $n=12$ (item 7). Record the reduction as equivalent to P on $\{P(W)>\theta_0\}$.
2. Rescope the "Owed" line: a frame with $P(N_F)\le0$ exists only for some tensors, and any averaging argument must use $P(W)>\theta_0$ or maximality.
3. Item 6: drop "with $\theta\ge\Theta_n$", and say the cap $\Theta_n\frac{1+2a^3}{3a^2}$ is never below $\Theta_n$.
4. Optional: cite L220's $n\ge12$ supremum clause directly for the four-set cap, and state the $a=0$ and $b=0$ edge cases.
