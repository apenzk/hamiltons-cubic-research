# Gate 2 brief, Lemma L217, the value bootstrap at a gapped critical orbit

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break the result.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 772 and 776-801)

#### Lemma L217, the value bootstrap at a gapped critical orbit: a global maximiser within $\arcsin\min(3\gamma,\tfrac12)$ has value at most the orbit's

**Statement.** *Let $u$ be a unit critical point of $P$ on the unit sphere of $\mathcal W_n$ with $\theta_u=P(u)>0$ and $e=u/\theta_u$, and suppose $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp u$ orthogonal to the orbit tangent $T_u\mathcal O$, $\mathcal O=O(n)\cdot u$, with $\gamma\ge0$. Let $W^\ast$ be a global maximiser of $P$ on the unit sphere, $m=P(W^\ast)$, at geodesic distance $\varphi\in[0,\tfrac\pi2]$ from $\mathcal O$ with $\sin\varphi\le\min(3\gamma,\tfrac12)$. Then $m\le\theta_u$.*

**Corollaries.**

- **(a) The balanced orbit.** *At $n=2k\ge12$ and $u$ the unit Weyl tensor of $S^k\times S^k$, [L216](../findings/second-order.md#lemma-l216-an-explicit-isolation-radius-at-every-quantitatively-nondegenerate-critical-orbit)'s corollary gives $\gamma=1/(n-2)$ and [Lemma L0](../findings/problem.md)'s lower half gives $\theta_0(n)\le m$.* **So if some global maximiser lies within geodesic angle $\arcsin\frac3{n-2}$ of the balanced orbit, then $\sup P=\theta_0(n)$**, which is Conjecture A's value. *The angle is $0.3047$ at $n=12$, against L216's critical-point radius $0.0132$.*
- **(b) Every sub-maximal sphere product.** *For $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$ and $\theta_{p,q}<\Theta_n$, with L216's gap $\gamma_{p,q}$, no global maximiser lies within geodesic angle $\arcsin\min(3\gamma_{p,q},\tfrac12)$ of its orbit*, since $m\le\theta_{p,q}<\Theta_n\le m$ would follow.
- **(c) Padded $\mathbb{CP}^2$, for comparison only.** *Its gap $\gamma=\tfrac16$ is [L21](../findings/route-a.md)'s $\alpha\le\tfrac13$ read through the Hessian, so (b)'s device gives $\varphi\le\tfrac\pi6$, weaker than [L20](../findings/route-a.md)'s $0.5748$, which solves the envelope exactly rather than bounding it.*

**Proof.** (1) *The geodesic.* $\mathcal O$ is compact, so $\varphi$ is attained at some $u_1=g\cdot u$, and for $\varphi>0$ the minimising great circle leaves $u_1$ with a unit velocity $V\perp u_1$ and $V\perp T_{u_1}\mathcal O$ by the first variation of distance, so $W^\ast=c\,u_1+s\,V$ with $c=\cos\varphi\ge0$, $s=\sin\varphi$. By equivariance $P(u_1)=\theta_u$ and the gap holds at $u_1$ with $e_1=u_1/\theta_u$. At $\varphi=0$, $W^\ast\in\mathcal O$ and $m=\theta_u$.

(2) *The exact expansion.* With $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ the fully symmetric polarisation of $P$ ([Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s argument), $P(c\,u_1+s\,V)=c^3P(u_1)+3c^2s\,T(u_1,u_1,V)+3cs^2\,T(u_1,V,V)+s^3P(V)$. Criticality gives $T(u_1,u_1,V)=\langle Q(u_1),V\rangle=\theta_u\langle u_1,V\rangle=0$, and $T(u_1,V,V)=\langle L_{u_1}V,V\rangle=\theta_u\langle L_{e_1}V,V\rangle$. So
$$m=\theta_u\big(c^3+3cs^2\alpha\big)+s^3P(V),\qquad\alpha=\langle L_{e_1}V,V\rangle\le\tfrac12-\gamma.$$

(3) *The global comparison.* $V$ is a unit element of $\mathcal W_n$ and $W^\ast$ is a global maximiser, so $P(V)\le m$. With $c\ge0$ the coefficient $3cs^2\theta_u$ is nonnegative, so $m\le\theta_u\big(c^3+3cs^2(\tfrac12-\gamma)\big)+s^3m$, and with $c^3=c-cs^2$,
$$m\,(1-s^3)\ \le\ \theta_u\big(c+(\tfrac12-3\gamma)\,c\,s^2\big).$$

(4) *The envelope.* $(1-\tfrac{s^2}2)^2=c^2+\tfrac{s^4}4$ gives $c\le1-\tfrac{s^2}2$. If $\gamma\le\tfrac16$, then $c\le1$ gives $(\tfrac12-3\gamma)cs^2\le(\tfrac12-3\gamma)s^2$, so the bracket is at most $1-3\gamma s^2\le1-s^3$, by $s\le3\gamma$. If $\gamma>\tfrac16$, the middle term is at most $0$, so the bracket is at most $1-\tfrac{s^2}2\le1-s^3$, by $s\le\tfrac12$.

(5) $s\le\tfrac12$ makes $1-s^3>0$, so $m\le\theta_u$. $\square$

**What is used**: criticality at $u$, the gap, the total symmetry of $T$, $O(n)$-equivariance, the first variation of distance, and the one fact only a global maximiser supplies, $P(V)\le m$ for every unit $V$. *Not used: [L143](../findings/bounds.md), Bernstein's inequality, any frame, or criticality of $W^\ast$.*

**How it sits against the record.** *It is [L20](../findings/route-a.md)'s engine, the self-bootstrap $\gamma_V\le m$, run at any gapped orbit rather than at $\mathbb{CP}^2$ alone.* **Against [L216](../findings/second-order.md#lemma-l216-an-explicit-isolation-radius-at-every-quantitatively-nondegenerate-critical-orbit)** it trades scope for radius: L216 excludes every critical point from its tube, and bounds the cubic remainder by L143 and Bernstein because a critical point supplies no comparison; L217 speaks only of global maximisers, which supply the comparison exactly, and gains a factor near $27(1+\sqrt{n-2})/(12\theta_u)$ in the radius. **Against [L147](../findings/second-order.md#lemma-l147-the-tube-radius-tracks-supvert-pvert-on-beta-in0tfrac12-and-the-route-ends-at-thetan-1)**, whose $P$-side branch caps a penalised-functional radius at $c_p/\theta_0\le3/(n-2)$ with $\sup\lvert P\rvert$ unknown, the scale agrees: the maximiser's value is what that branch lacked.

**What it does not give.** *A global maximiser outside every such tube is untouched, and the tubes about the rigid orbits do not cover the sphere. Conjecture A follows from (a) only under the localisation that some maximiser lies within $\arcsin\frac3{n-2}$ of the balanced orbit, which is [I100](../plan.md)'s target.*

## Given 1, Lemma L216 and its corollary, whose gap L217 consumes ([findings/second-order.md](../findings/second-order.md) lines 746-757)

#### Lemma L216, an explicit isolation radius at every quantitatively nondegenerate critical orbit

**Let $W_0$ be a unit critical point of $P$ with $\theta_0=P(W_0)>0$ and $e=W_0/\theta_0$, and suppose that $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp W_0$ orthogonal to the orbit tangent $T_{W_0}\mathcal O$, with $\gamma>0$. Then no critical point of $P$ on the unit sphere of $\mathcal W_n$ lies within geodesic distance**
$$r=\frac{4\,\theta_0\,\gamma}{9\,\big(1+\sqrt{n-2}\big)}$$
**of the orbit $\mathcal O=O(n)\cdot W_0$, other than the points of $\mathcal O$ itself.**

**Corollary, at the sphere products.** *For $S^p\times S^q$ with $p,q\ge3$ and $(p,q)\ne(3,3)$, [L27](../findings/nondegeneracy.md) makes the $\tfrac12$-eigenspace exactly the orbit tangent and, with [L26](../findings/nondegeneracy.md)'s $\mu=\frac{n-2}{2(p-1)(q-1)}$, gives the gap in closed form,* $$\gamma_{p,q}=\min\Big(\frac1{2(p-1)},\ \frac1{2(q-1)},\ \frac12-\mu\Big).$$ **At the balanced product, $n=2m\ge8$, this is $\gamma=1/(n-2)$ and**
$$r_n=\frac{4\,\theta_0(n)}{9\,(n-2)\,\big(1+\sqrt{n-2}\big)}=\Theta\big(n^{-3/2}\big),$$
*which is $0.0246$ at $n=8$ and $0.0132$ at $n=12$.*

**This is the first explicit isolation radius on the record.** *[L19](../findings/problem.md)'s block records that "no isolation radius $r_i$ is anywhere on the record" and [I35](../plan.md) was filed to supply one, its own note saying the radius needs a second-variation bound AND a third-order remainder, the latter "a computation at the balanced orbit and not transferable".* **For $P$ itself the remainder IS transferable**, being controlled by [L143](../findings/bounds.md)'s GLOBAL bound on $\lvert P\rvert$, so the only orbit-specific input is the gap. *And it supersedes the isolation estimate of the block above, whose radius was refuted in a fixed frame and vacuous where stated: here every constant is evaluated on the orbit and carried along it by equivariance, never at a perturbed diagonal part, and the gauge is handled by the nearest-point geodesic rather than by a hypothesis.*

## Given 2, the total symmetry of $T$, from Lemma L24's argument ([findings/second-order.md](../findings/second-order.md) line 67)

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](../findings/second-order.md#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

## Given 3, the lower half of Lemma L0, $\sup P\ge\Theta_n$ ([findings/problem.md](../findings/problem.md) line 590)

> **THE LOWER HALF, SUPPLIED, IT IS ONE CITATION AND IT NOW STANDS INSIDE THE PROOF.** *$\sup\ge\Theta_n$ holds because **[Nienhaus Proposition 2.25](https://arxiv.org/abs/2311.02404)** gives, for every split $k+l=n$, a unit $W_{S_{k,l}}\in\mathcal W_n$ with $W^2+W^\#=\theta_{k,l}W$ and $P=\theta_{k,l}$; taking the balanced split gives $P=\Theta_n$, so the supremum is at least $\Theta_n$ and, with $(\Leftarrow)$'s $\sup\le\Theta_n$, exactly it.* **The source's own odd-dimension value confirms the constant independently of the split algebra**: Nienhaus prints $P(W^{\mathrm{crit}}_{\mathrm{sym},11})=\tfrac{2\sqrt{30}}9$, whose square is $\tfrac{40}{27}=\Theta_{11}^2$ and **not** $\theta_0(11)^2=\tfrac{180}{121}$. *At $n=13$ the balanced split $(7,6)$ gives $\theta_{7,6}^2=2\cdot\tfrac67\cdot\tfrac56\cdot\tfrac{12}{11}=\tfrac{120}{77}=\Theta_{13}^2$.* **Three verifiers on identical briefs, [ROUND_L00](../verification/ROUND_L00b.md); two read the proposition at source.** *A refuting review prescribed four repairs and this was the one that did not land, the sentence was added **as a report that it was missing**, after the $\square$, rather than as the step.*

## Given 4, Lemma L20's heading and proof, whose engine L217 reuses ([findings/route-a.md](../findings/route-a.md) lines 103 and 111)

#### Lemma L20, no maximizer lies near the rival maximizer's orbit, for every $n\ge12$

*Proof.* The unit sphere of $\mathrm{Weyl}_n$ is compact, so $m:=\sqrt{2/3}\max P$ is attained, at some $W^*$. **Three standard facts are used.** $d$ is $SO(n)$-invariant, because $SO(n)$ acts on $\mathrm{Weyl}_n$ by isometries. The orbit is a compact embedded submanifold, being the orbit of a compact group acting smoothly, so a nearest point exists and satisfies the first-variation condition. And $\varphi>0$ in the main branch, which is what makes $V$ below well defined. The degenerate branch $\varphi=0$ is treated after the proof. Suppose $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$. Since $P$ is invariant under the conjugation action of $SO(n)$ on $\Lambda^2(\mathbb{R}^n)$, rotate so that the nearest orbit point is $u=W_{\mathbb{CP}^2}$ itself, and write $W^*=\cos\varphi\,u+\sin\varphi\,V$. The vector $V$ is a unit vector orthogonal to $u$, and orthogonal also to $T_u(SO(n).u)$ by the first-variation condition for a nearest point on the orbit. Since $P$ is a cubic form with polarization $T$, and $Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle=0$, the expansion is exact and has no linear term:

## Definitions ([findings/conventions.md](../findings/conventions.md))

| $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself | [README.md](../README.md) |
| $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$, the $\#$ part because permuting the arguments permutes the slots of two totally antisymmetric $c$'s at sign $(-1)^2$. **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$ and [L35](../findings/stratum-two-negative.md)'s cap $\tfrac{2\sqrt2}3A$** | [second-order.md](../findings/second-order.md) |
- **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

## The Lean declarations ([L217.lean](../lean/HamiltonsCubic/Results/L217.lean)), docstrings removed

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L217

theorem cos_le_one_sub_half_sq {s c : ℝ} (hc0 : 0 ≤ c)
    (hc : c ^ 2 = 1 - s ^ 2) : c ≤ 1 - s ^ 2 / 2 := by
  have h1 : (0 : ℝ) ≤ 1 - s ^ 2 / 2 := by nlinarith
  nlinarith [sq_nonneg (s ^ 2), sq_nonneg (c - (1 - s ^ 2 / 2)), sq_nonneg (c + (1 - s ^ 2 / 2))]

theorem envelope_le_one {s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) :
    c + (1 / 2 - 3 * γ) * c * s ^ 2 + s ^ 3 ≤ 1 := by
  have hcle : c ≤ 1 - s ^ 2 / 2 := cos_le_one_sub_half_sq hc0 hc
  have hc1 : c ≤ 1 := by nlinarith
  have hs2 : 0 ≤ s ^ 2 := sq_nonneg s
  rcases le_or_gt γ (1 / 6) with hγ | hγ
  · -- the coefficient is nonnegative, so `c ≤ 1` bounds the middle term
    have hcoef : 0 ≤ 1 / 2 - 3 * γ := by linarith
    have hmid : (1 / 2 - 3 * γ) * c * s ^ 2 ≤ (1 / 2 - 3 * γ) * s ^ 2 := by
      have := mul_le_mul_of_nonneg_left hc1 (mul_nonneg hcoef hs2)
      nlinarith [this]
    have hkey : s ^ 3 ≤ 3 * γ * s ^ 2 := by nlinarith [mul_le_mul_of_nonneg_left hs hs2]
    nlinarith [hcle, hmid, hkey]
  · -- the coefficient is negative, so the middle term is at most `0`
    have hmid : (1 / 2 - 3 * γ) * c * s ^ 2 ≤ 0 := by
      have hneg : 1 / 2 - 3 * γ < 0 := by linarith
      have : 0 ≤ c * s ^ 2 := mul_nonneg hc0 hs2
      nlinarith [this, hneg]
    have hkey : s ^ 3 ≤ s ^ 2 / 2 := by nlinarith [mul_le_mul_of_nonneg_left hshalf hs2]
    nlinarith [hcle, hmid, hkey]

theorem tube_value_le {m θu α g s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) (hθ : 0 < θu)
    (hexp : m = θu * (c ^ 3 + 3 * c * s ^ 2 * α) + s ^ 3 * g)
    (hα : α ≤ 1 / 2 - γ) (hg : g ≤ m) : m ≤ θu := by
  have hs2 : 0 ≤ s ^ 2 := sq_nonneg s
  have hs3 : 0 ≤ s ^ 3 := by positivity
  have hs3lt : s ^ 3 < 1 := by nlinarith
  have hstepα : θu * (3 * c * s ^ 2 * α) ≤ θu * (3 * c * s ^ 2 * (1 / 2 - γ)) := by
    have h3 : 0 ≤ 3 * c * s ^ 2 := by positivity
    have := mul_le_mul_of_nonneg_left hα h3
    nlinarith [this, hθ]
  have hstepg : s ^ 3 * g ≤ s ^ 3 * m := mul_le_mul_of_nonneg_left hg hs3
  have hc3 : c ^ 3 = c - c * s ^ 2 := by nlinarith [hc]
  have henv := envelope_le_one hs0 hc0 hc hγ0 hs hshalf
  have hrhs : θu * (c ^ 3 + 3 * c * s ^ 2 * (1 / 2 - γ)) = θu * (c + (1 / 2 - 3 * γ) * c * s ^ 2) := by
    rw [hc3]; ring
  have hmain : m * (1 - s ^ 3) ≤ θu * (1 - s ^ 3) := by
    have h1 : m ≤ θu * (c ^ 3 + 3 * c * s ^ 2 * (1 / 2 - γ)) + s ^ 3 * m := by
      rw [hexp] at hstepg ⊢
      nlinarith [hstepα, hstepg]
    have h2 : θu * (c + (1 / 2 - 3 * γ) * c * s ^ 2) ≤ θu * (1 - s ^ 3) := by
      have := mul_le_mul_of_nonneg_left (by linarith [henv] : c + (1 / 2 - 3 * γ) * c * s ^ 2 ≤ 1 - s ^ 3) hθ.le
      exact this
    nlinarith [h1, h2, hrhs]
  have hpos : 0 < 1 - s ^ 3 := by linarith
  exact le_of_mul_le_mul_right hmain hpos

theorem balanced_value_eq {m θu α g s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) (hθ : 0 < θu)
    (hexp : m = θu * (c ^ 3 + 3 * c * s ^ 2 * α) + s ^ 3 * g)
    (hα : α ≤ 1 / 2 - γ) (hg : g ≤ m) (hlow : θu ≤ m) : m = θu :=
  le_antisymm (tube_value_le hs0 hc0 hc hγ0 hs hshalf hθ hexp hα hg) hlow

theorem exclusion {m θu Θ α g s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) (hθ : 0 < θu)
    (hexp : m = θu * (c ^ 3 + 3 * c * s ^ 2 * α) + s ^ 3 * g)
    (hα : α ≤ 1 / 2 - γ) (hg : g ≤ m) (hsub : θu < Θ) (hlow : Θ ≤ m) : False := by
  have := tube_value_le hs0 hc0 hc hγ0 hs hshalf hθ hexp hα hg
  linarith

theorem radius_twelve : (3 : ℝ) * (1 / (12 - 2)) = 3 / 10 ∧ (3 : ℝ) / 10 ≤ 1 / 2 := by
  constructor <;> norm_num

theorem three_gamma_le_half {n : ℝ} (hn : 8 ≤ n) : 3 * (1 / (n - 2)) ≤ 1 / 2 := by
  have hpos : 0 < n - 2 := by linarith
  rw [mul_one_div, div_le_div_iff₀ hpos (by norm_num)]
  linarith

example : (1 : ℝ) = 1 * ((1 : ℝ) ^ 3 + 3 * 1 * (0 : ℝ) ^ 2 * (1 / 2 - 1 / 10)) + (0 : ℝ) ^ 3 * 1 := by
  norm_num

end HamiltonsCubic.L217
```

**Which claims the kernel settles**: the envelope inequality and the step from the expansion, the gap and $P(V)\le m$ to $m\le\theta_u$, over reals, are proved in that file. **Which it does not**: that the expansion is exact, that $V\perp T_{u_1}\mathcal O$, that the gap transfers along the orbit, and every corollary's inputs. Spend your attention there.

## What to attack

1. **The expansion in step (2)**: the coefficients $1,3,3,1$ against the polarisation convention $X\circ X=Q(X)$, $P(X)=\langle X,Q(X)\rangle$, whether $T(u_1,V,V)=\langle L_{u_1}V,V\rangle=\theta_u\langle L_{e_1}V,V\rangle$ with $L_x=x\circ(\cdot)$, and whether the linear term vanishes by criticality alone.
2. **The first-variation step (1)**: that a nearest point exists, that the unit velocity is orthogonal to both $u_1$ and $T_{u_1}\mathcal O$, and that the gap hypothesis at $u$ transfers to $u_1$.
3. **The global comparison (3)**: $P(V)\le m$, the sign of $3cs^2\theta_u$, and the need for $c\ge0$, i.e. $\varphi\le\pi/2$.
4. **The envelope (4)**: both cases, the bound $c\le1-\tfrac{s^2}2$, and whether $s\le\min(3\gamma,\tfrac12)$ is what is used.
5. **Corollary (a)**: the gap $\gamma=1/(n-2)$ at the balanced product from Given 1 (check it is the minimum of the three terms at $p=q=n/2$, $n\ge12$), that Given 1's hypotheses $p,q\ge3$, $(p,q)\ne(3,3)$ hold, the lower bound $\theta_0(n)\le m$ from Given 3, and $0.3047=\arcsin0.3$ at $n=12$.
6. **Corollary (b)**: the exclusion argument, and whether every sub-maximal sphere product it names meets Given 1's hypotheses.
7. **Corollary (c)**: $\gamma=\tfrac16$ from $\alpha\le\tfrac13$, the normalisations of Given 4's $\alpha$ against $\langle L_eV,V\rangle$, and $\arcsin\tfrac12=\pi/6$ against $0.5748$.
8. **"How it sits against the record"**: the factor $27(1+\sqrt{n-2})/(12\theta_u)$ against Given 1's radius, and the agreement claimed with Lemma L147's scale.
9. **Scope**: that the statement speaks of global maximisers only, that nothing uses criticality of $W^\ast$, and "What it does not give".
10. **The boundary**: $\varphi=0$, $\gamma=0$, $\gamma=\tfrac16$, $s=\tfrac12$, a critical orbit whose nearest point is not unique, and a $u$ with $\ker u\ne0$.

**Rules.** Argue from the definitions. No numerical work beyond the smallest check that refutes a claim, and say why an argument could not. Read no other file of the repository except the ones linked above for context, and no other reviewer's output.
