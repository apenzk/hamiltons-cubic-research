# Gate 2 brief, Lemma L219, the reflection split

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break the result.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 824 and 828-845)

#### Lemma L219, the reflection split: the odd part of a critical point has zero cubic and is a $\tfrac\theta2$-eigenvector of the even part

**Statement.** *Let $u\in\mathbb R^n$ be a unit vector, $\sigma_u\in O(n)$ the reflection in $u^\perp$, and split $W\in\mathcal W_n$ as $W=b+c$ with $\sigma_ub=b$ and $\sigma_uc=-c$. Then*
$$P(W)=P(b)+3\langle L_bc,c\rangle,\qquad P(c)=0,\qquad\langle b\circ b,c\rangle=0 .$$
*If $W$ is a critical point, $Q(W)=\theta W$, then*
$$b\circ b+c\circ c=\theta b,\qquad 2\,b\circ c=\theta c,\qquad\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2,\qquad P(b)=\theta\big(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2\big).$$
**And $W$ is coordinate-diagonal in an orthonormal frame $(e_1,\dots,e_n)$ exactly when its $\sigma_{e_k}$-odd part vanishes for every $k$.**

**Proof.** $O(n)$ acts on $\mathcal W_n$ by isometric algebra automorphisms, so $\sigma=\sigma_u$ satisfies $\sigma(x\circ y)=\sigma x\circ\sigma y$ and $\langle\sigma x,\sigma y\rangle=\langle x,y\rangle$, and $\sigma^2=1$. Hence the even and odd parts are orthogonal, $\sigma(b\circ b)=b\circ b$ and $\sigma(c\circ c)=c\circ c$ are even, and $\sigma(b\circ c)=-b\circ c$ is odd.

1. **The split.** Expanding $P(b+c)=\langle(b+c)\circ(b+c),b+c\rangle$ gives six terms. $\langle b\circ b,c\rangle$, $\langle b\circ c,b\rangle$ and $\langle c\circ c,c\rangle$ pair an even vector with an odd one and vanish, which is $\langle b\circ b,c\rangle=0$ and $P(c)=0$. The remaining three are $P(b)+\langle c\circ c,b\rangle+2\langle b\circ c,c\rangle=P(b)+3\langle b\circ c,c\rangle$ by total symmetry of $\langle x\circ y,z\rangle$.
2. **At a critical point.** $Q(W)=b\circ b+c\circ c+2\,b\circ c$, whose even part is $b\circ b+c\circ c$ and odd part $2\,b\circ c$, so $Q(W)=\theta W$ splits into the two displayed equations. Pairing the odd one with $c$ gives $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$. Pairing the even one with $b$ gives $P(b)+\langle b\circ c,c\rangle=\theta\lVert b\rVert^2$, hence $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$.
3. **Diagonality.** The reflections $\sigma_{e_k}$ generate the sign group $\Gamma$ of the frame, and $\mathcal D_n$ is exactly the $\Gamma$-fixed subspace ([L214](../findings/second-order.md#lemma-l214-the-frame-split-two-exact-relations-in-every-frame-and-one-inequality-under-the-second-order-cap), from [L120](../findings/second-order.md#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point)). So $W\in\mathcal D_n$ iff $\sigma_{e_k}W=W$ for every $k$, iff every odd part vanishes. $\square$

**In block terms**, for $u=e_n$: the even part is $\mathcal D_n$, the pair blocks $V_{jk}$ with $j,k<n$ and the four-set blocks $V_Q$ with $n\notin Q$, and the odd part is the pair blocks $V_{jn}$ and the four-set blocks $V_Q$ with $n\in Q$.

**What it gives.** *The root node of Problem P, that a global maximiser is coordinate-diagonal, becomes $n$ applications of one statement: a maximiser on the fixed subalgebra of some reflections of a frame is even under one more.* The frame split [L214](../findings/second-order.md#lemma-l214-the-frame-split-two-exact-relations-in-every-frame-and-one-inequality-under-the-second-order-cap) and the four-set split of [I101](../plan.md) have the same shape with a third term $P(N)$, which here vanishes. **H3 on the plane $\{b,c\}$ is an identity**, since the two relations determine $P$ there, so the lemma alone forces nothing: it is the calculus [I102](../plan.md)(b) and (c) work in.

**Gate 1** (screen, [sweep](2026-09-14b-LIT-step8-sweep.md) batch 3). *At $n=8$, at Fox's $\sqrt{3/2}$ and at $S^4\times S^4$ in a random frame, reflection in $e_0$: $P(c)=0$ exactly, the split to $5\times10^{-6}$, $P(b)/\theta=1-\tfrac32s^2$ at unit norm to four digits, and $\pi_{\mathcal W}(2b\circ c)=\theta c$ to $3\times10^{-6}$.*

## Given 1, Lemma L214's statement and structural input ([findings/second-order.md](../findings/second-order.md) lines 679-689)

#### Lemma L214, the frame split: two exact relations in every frame, and one inequality at every maximiser

**Fix any orthonormal frame $F$ of $\mathbb R^n$ and split a unit critical point as $W=D+N$, where $D=\pi_FW$ is its coordinate-diagonal part in $F$ and $N=W-D$, with $t=t_F=\lVert D\rVert^2\in[0,1]$ and $a=\langle L_DN,N\rangle$. Then**
$$\theta\,t=P(D)+a,\qquad\theta\,(1-t)=2a+P(N),$$
**and if in addition $L_W\le\tfrac\theta2$ on $W^\perp$, which [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement) gives at every GLOBAL maximiser, and at a local one with $\theta>0$, then**
$$a\ \ge\ \tfrac\theta2\,t(1-t),\qquad\text{equivalently}\qquad P(D)\ \le\ \tfrac\theta2\,t(1+t).$$

**The whole structural input is [Lemma L120](../findings/second-order.md#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point), used at $D$ rather than at a critical point.** *That lemma decomposes $\mathcal W_n=\mathcal D_n\oplus\bigoplus V_{ijkl}\oplus\bigoplus V_{jk}$ into $\Gamma$-isotypic summands and states that $L_M$ preserves each one whenever $M$ is $\Gamma$-fixed, criticality unused. $D$ is $\Gamma$-fixed, since $\mathcal D_n$ is exactly the $\Gamma$-fixed subspace: a sign flip $\varepsilon$ acts on the pair basis by $\varepsilon_i\varepsilon_j$, so an entry off the pair diagonal is fixed only if it vanishes.* **Two consequences, EITHER of which suffices:**
$$D\circ D=L_DD\in\mathcal D_n,\qquad \pi_F(D\circ N)=0,$$
*the first because $L_D$ preserves $\mathcal D_n$ and $D$ lies in it, the second because $N$ lies in the sum of the other summands, which $L_D$ also preserves.* **AND THE TWO SCALARS THEY DELIVER ARE ONE SCALAR**, since $\langle D\circ D,N\rangle=\langle D\circ N,D\rangle$ by the total symmetry of the polarisation: *the proof below needs only $\langle D\circ D,N\rangle=0$, and each consequence of L120 gives it alone.* **Found by typing the lemma**, where the two read as separate hypotheses until the symmetry was applied ([L214FrameSplit.lean](../lean/HamiltonsCubic/Results/L214FrameSplit.lean)'s `hperp`, once).


## Given 2, Lemma L120's statement ([findings/second-order.md](../findings/second-order.md) lines 624-631)

#### Lemma L120, $L_M$ is block-diagonal over the sign characters at every diagonal critical point

**Let $\Gamma=\{\operatorname{diag}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as**
$$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
**and at every diagonal $M$, **criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed**, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and $\binom n4$ of them have size $2$.

> **THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES.** $e=M/\theta$ lies in $\mathcal D_n$ and $L_ee=e$, so read without it the criterion gives $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and **no diagonal critical point is a maximiser, vacuously**, the balanced sphere product included. **$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality. *And the block size fails at $n=4$ as first printed, where the four-set block is $2$ against $n-3=1$.* *Gate 2, [r507](REVIEW_r507.md) and [r508](REVIEW_r508.md) on identical briefs, both CONFIRMED and agreeing on every repair.***


## The Lean declarations, docstrings removed ([L219Statement.lean](../lean/HamiltonsCubic/Results/L219Statement.lean))

```lean
import Mathlib
import HamiltonsCubic.Results.L217Statement

set_option linter.style.longLine false

namespace HamiltonsCubic.L219Statement

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

open HamiltonsCubic.L217Statement

theorem odd_cube_zero (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {c : V} (hc : σ c = -c) :
    T c c c = 0 := by
  have h := hσ c c c
  rw [hc] at h
  simp only [map_neg, LinearMap.neg_apply, neg_neg] at h
  linarith

theorem even_even_odd_zero (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {b c : V} (hb : σ b = b) (hc : σ c = -c) :
    T b b c = 0 := by
  have h := hσ b b c
  rw [hb, hc] at h
  simp only [map_neg] at h
  linarith

theorem reflection_split (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {b c : V} (hb : σ b = b) (hc : σ c = -c) :
    T (b + c) (b + c) (b + c) = T b b b + 3 * T b c c ∧ T c c c = 0 := by
  have e := cubic_expansion T h12 h23 b c 1 1
  simp only [one_smul, one_pow, one_mul, mul_one] at e
  have hbbc := even_even_odd_zero T σ hσ hb hc
  have hccc := odd_cube_zero T σ hσ hc
  refine ⟨?_, hccc⟩
  rw [e, hbbc, hccc]
  ring

theorem reflection_split_critical (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y) (σ : V →ₗ[ℝ] V)
    (hσ : ∀ x y z, T (σ x) (σ y) (σ z) = T x y z) {b c : V} (hb : σ b = b) (hc : σ c = -c)
    {θ : ℝ} (hcrit : ∀ x, T (b + c) (b + c) x = θ * inner ℝ (b + c) x) (horth : inner ℝ b c = 0) :
    T b c c = θ / 2 * ‖c‖ ^ 2 ∧ T b b b = θ * (‖b‖ ^ 2 - ‖c‖ ^ 2 / 2) := by
  have hbbc := even_even_odd_zero T σ hσ hb hc
  have hccc := odd_cube_zero T σ hσ hc
  have hcb : inner ℝ c b = 0 := by rw [real_inner_comm]; exact horth
  have hWc := hcrit c
  have hWb := hcrit b
  simp only [map_add, LinearMap.add_apply, inner_add_left, real_inner_self_eq_norm_sq] at hWc hWb
  have s1 : T c b c = T b c c := h12 c b c
  have s2 : T b c b = T b b c := h23 b c b
  have s3 : T c b b = T b b c := by rw [h12 c b b, s2]
  have s4 : T c c b = T b c c := by rw [h23 c c b, s1]
  have hc2 : T b c c = θ / 2 * ‖c‖ ^ 2 := by
    rw [horth] at hWc
    linarith
  refine ⟨hc2, ?_⟩
  rw [hcb] at hWb
  linarith

example : True := by
  have := reflection_split_critical (V := ℝ) 0 (fun _ _ _ => rfl) (fun _ _ _ => rfl) (-LinearMap.id)
    (fun _ _ _ => rfl) (b := 0) (c := 1) (by simp) (by simp) (θ := 0) (fun _ => by simp) (by simp)
  trivial

end HamiltonsCubic.L219Statement
```

**Which claims the kernel settles**: the split $P(b+c)=P(b)+3T(b,c,c)$, $T(c,c,c)=0$ and $T(b,b,c)=0$ for a symmetric trilinear form invariant under a linear map with $\sigma b=b$, $\sigma c=-c$, and at a critical point $T(b,c,c)=\tfrac\theta2\lVert c\rVert^2$ and $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$ given $\langle b,c\rangle=0$. **Which it does not**: that a reflection acts on $\mathcal W_n$ by an isometric algebra automorphism, that the even/odd parts exist inside $\mathcal W_n$, the two displayed equations $b\circ b+c\circ c=\theta b$ and $2b\circ c=\theta c$ as equations in $\mathcal W_n$, the diagonality corollary, and the block description. Spend your attention there.

## What to attack

1. **The automorphism**: that every $g\in O(n)$, a reflection included (determinant $-1$), acts on $\mathcal W_n$ preserving $\circ$ and the inner product, in the convention where $Q(W)=W^2+W^\#$, and that $\sigma_u^2=1$ on $\mathcal W_n$.
2. **The split**: each of the six terms and the symmetry used.
3. **The critical equations**: whether $Q(W)$'s parity split gives exactly the two displayed equations inside $\mathcal W_n$ (is $\circ$ the product of $\mathcal W_n$, with its projection, or the ambient one), and both pairings.
4. **Diagonality**: that the reflections $\sigma_{e_k}$ generate the frame's sign group, that $\mathcal D_n$ is exactly the fixed subspace (Given 1), and the equivalence with every odd part vanishing, including $n$ odd and the determinant of the group generated.
5. **The block description** for $u=e_n$ against Given 2's characters.
6. **"H3 on the plane $\{b,c\}$ is an identity"**: does the local-maximum inequality restricted to that plane really carry no information beyond the two relations?
7. **Scope**: any hypothesis used and unstated, any claim beyond what the proof shows, and whether the result is already on the record under another name (search [findings/](../findings/) by the object, not the word).

**Rules.** Argue from the definitions. No numerical work beyond the smallest check that refutes a claim, and say why an argument could not. Read no other file of the repository except the ones linked above for context, and no other reviewer's output. Analysis only: a screen of seconds on an object you construct is allowed and reported as a screen, never as evidence for a positive claim.
