# Brief, round L45

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/target.md](../findings/target.md) lines 758-767, under the heading at line 742)

For general $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$, five of the ten distinct triples of the cubic vanish and five survive:
\[
\langle R,\Phi(R)\rangle=\underbrace{c^3(n-1)\|I\|^2+3c\langle I,\Phi(Y)\rangle+\langle Y,\Phi(Y)\rangle}_{W\text{-even}}
+\underbrace{3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle}_{W\text{-odd}} .
\]
Against the slice exactly one new coupling appears, the triple $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$; every $I$--$W$ pairing vanishes. The $\Omega_0$ constraint depends only on $\|W\|$, so $cI+Y-W\in\Omega_0$ whenever $cI+Y+W$ is, and demanding the criterion at both signs gives the two-sided bound
\[
\big|\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\big|\;\le\;\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even},
\qquad \mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle .
\]

## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 104)

- **Lemma L45. Off the slice: five surviving triples, and one coupling.** For $R=cI+Y+W$ with $Y$ the traceless-Ricci part, five of the cubic's ten triples vanish and five survive; the one coupling absent from the slice is $(Y,Y,W)=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. Demanding the criterion at both signs of $W$ gives a two-sided bound.

## Passage C, the canonical statement, detail form ([results.md](../results.md) lines 380-384)

##### Lemma L45, off the slice: five surviving triples, and one coupling

Let $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$. Of the ten distinct triples of the cubic $\langle R,\Phi(R)\rangle$, five vanish identically and five survive, with multiplicities $1,3,1,3,1$: $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+3c\langle I,\Phi(Y)\rangle+\langle Y,\Phi(Y)\rangle+3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle$, the first three terms even in $W$ and the last two odd. Every $I$–$W$ pairing vanishes, and the only coupling absent from the slice is the triple $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$; the expansion is Huisken's, term for term. The $\Omega_0$ constraint depends on $\lVert W\rVert$ alone, so $cI+Y-W\in\Omega_0$ whenever $cI+Y+W$ is, and the criterion at both signs gives $\lvert\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\rvert\le\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$ with $\mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle$. It is a bookkeeping identity for the general criterion and proves no case of the conjecture by itself.

**Proof:** [target.md](findings/target.md)

## Passage D, the argument ([findings/problem.md](../findings/problem.md) lines 76-92)

**OFF THE SLICE: exactly one new coupling, explicitly identified.** Take the general $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$. [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Prop 2.7 plus [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.2 (which supplies the block Xu's list omits, $(\Phi(Y))_W=\frac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$) determine every one of the ten distinct triples. **Five vanish, five survive:**

$$\langle R,\Phi(R)\rangle=\underbrace{c^3(n-1)\lVert I\rVert^2+3c\langle I,\Phi(Y)\rangle+\langle Y,\Phi(Y)\rangle}_{W\text{-even}}+\underbrace{3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle}_{W\text{-odd}} .$$

Against the slice, **one** genuinely new coupling appears, the triple $(Y,Y,W)$, equal to $\frac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. The five that vanish include every $I$–$W$ pairing, by Xu (3).

**The parity argument, and it is two-sided.** The constraint $\frac{n-2}n\lVert W\rVert^2\le\lVert R_I\rVert^2$ depends only on $\lVert W\rVert$, so $cI+Y-W\in\Omega_0$ whenever $cI+Y+W$ is. On the right, $\mathrm{ric}(R)$ is $W$-independent and $F(R)$ is $W$-even, while the only $W$-dependent piece of $\mathrm{ric}(\Phi(R))$ is $2\Phi(Y,W)$, which lands in $\langle\mathrm{Ric}_0\rangle$ by Xu (5) and is $W$-odd. Demanding the criterion at both signs therefore gives

$$\big\lvert\,\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\,\big\rvert\ \le\ \mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even},\qquad\mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle .$$

**CLASSIFICATION: this expansion is AGREEMENT, not new.** [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) **Lemma 2.8, eq. (2.34)** is the same identity, term for term:

$$\langle Q(R),R\rangle=\frac n{2(n-1)}\bar\lambda^3+\frac3{2(n-1)}\bar\lambda\lvert\mathrm{Ric}_0\rvert^2+\frac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle-\frac2{(n-2)^2}\langle(\mathrm{Ric}_0^2)_0,\mathrm{Ric}_0\rangle+\langle Q(W),W\rangle,$$

matching $(I,I,I)$, $(I,Y,Y)$, $(Y,Y,W)$, $(Y,Y,Y)$, $(W,W,W)$ in that order, **including the coefficient $\frac3{n-2}$**, which was reached here from BW08 Lemma 2.2 rather than copied. Xu attributes it to Huisken's proof of his Theorem 3.3, where it is not stated as an independent lemma. So the block-vanishing derivation is corroboration of a published identity by a second route; the parity argument on top of it is not in Xu.

> **So off the slice the $a=0$ criterion is not Conjecture A alone.** $\langle W,Q(W)\rangle$ enters only as one of three pieces of an odd part that must be bounded on both sides. Setting $Y=0$ kills the new coupling and $\mathrm{RHS}_{\rm odd}$ together and recovers the bridge exactly, the consistency check. What a general-$R_{\mathrm{ric}_0}$ proof still owes is a bound on $\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}$ ([b_cone_offslice.py](../scripts/route-b/b_cone_offslice.py)).

## Passage E, the Lean statement ([lean/HamiltonsCubic/Results/L45Statement.lean](../lean/HamiltonsCubic/Results/L45Statement.lean), whole file, 157 lines)

```lean
import Mathlib

set_option linter.style.longLine false

/-!
# L45, stated as the parity argument and the triple census it runs on

## The record's statement, verbatim

> For general $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$, five of the ten distinct triples of the
> cubic vanish and five survive:
> \[
> \langle R,\Phi(R)\rangle=\underbrace{c^3(n-1)\|I\|^2+3c\langle I,\Phi(Y)\rangle+\langle
> Y,\Phi(Y)\rangle}_{W\text{-even}}
> +\underbrace{3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle}_{W\text{-odd}} .
> \]
> Against the slice exactly one new coupling appears, the triple $(Y,Y,W)$, equal to
> $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$; every $I$--$W$ pairing
> vanishes. The $\Omega_0$ constraint depends only on $\|W\|$, so $cI+Y-W\in\Omega_0$ whenever
> $cI+Y+W$ is, and demanding the criterion at both signs gives the two-sided bound
> \[
> \big|\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\big|\;\le\;\mathrm{RHS}_{\rm
> even}-\mathrm{LHS}_{\rm even},
> \qquad \mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle .
> \]

with the corrections the block carries:

> **THE MULTIPLICITIES ON THE CANON ARE WRONG.** [results.md](../../../results.md) records the
> survivors as carrying *"multiplicities $1,3,3,6$"*. They carry $1,3,1,3,1$, and **no survivor
> has multiplicity $6$**, the only weight-$6$ triple $(I,Y,W)$ being a vanisher. The partition
> checks: $18+9=27$.

> **THE CONSTANT IS $\tfrac1{n-2}$ AS A TRILINEAR VALUE; THE $3$ IS THE MULTINOMIAL WEIGHT.**

> **THE REFLECTION HOLDS, AND MORE WIDELY THAN CLAIMED.** Parity bookkeeping is correct including
> $\langle W,Q(W)\rangle$: $Q$ is even, and the pairing adds one $W$, so the cubic is odd. The
> $\Omega_0$ premise holds at *every* $a$, both defining clauses are $W$-even […]. **And
> $\mathrm{RHS}_{\mathrm{even}}-\mathrm{LHS}_{\mathrm{even}}\ge0$ is implied by adding the two
> instances, not an extra hypothesis.**

[target.md](../../../findings/target.md), Lemma L45.

## What this file states

Three parts, all of them free of the curvature layer and all proved here.

* **The reflection argument.** Reading the criterion at `+W` and at `-W` gives the two-sided
  bound, and gives `RHS_even ≥ LHS_even` as a consequence rather than a hypothesis. This is the
  lemma's actual mechanism and it is pure inequality manipulation.
* **The parity facts it rests on.** `Q` even makes the cubic odd; the `Ω₀` premise is invariant
  under `W ↦ -W` because it reads `‖W‖` only.
* **The triple census.** Ten multisets of size three over `{I, Y, W}`, split five and five, with
  multinomial weights `1,3,1,3,1` on the survivors and `3,3,6,3,3` on the vanishers, summing to
  `9` and `18` and so to `27 = 3³`; and no survivor carries weight `6`.

**Not typed here:** the identification of the surviving and vanishing triples with the terms of
`⟨R, Φ(R)⟩`, and the value `3/(n-2)⟨W, Ric₀ ∧ Ric₀⟩` of the new coupling. Both need `Φ`, `Q`,
`Ric₀` and the wedge, which is the curvature layer. The census below is the combinatorial
skeleton those terms are indexed by, and the `1,3,3,6` correction is a statement about that
skeleton alone.
-/

namespace HamiltonsCubic.L45

/-! ## The reflection argument -/

/-- **The two-sided bound.** `Le`, `Lo`, `Re`, `Ro` are the `W`-even and `W`-odd parts of the two
sides. `hplus` is the criterion at `cI + Y + W`, `hminus` at `cI + Y - W`; the second is available
because `Ω₀` reads `‖W‖` only. -/
theorem two_sided {Le Lo Re Ro : ℝ} (hplus : Le + Lo ≤ Re + Ro) (hminus : Le - Lo ≤ Re - Ro) :
    |Lo - Ro| ≤ Re - Le := by
  rw [abs_le]
  constructor <;> linarith

/-- **`RHS_even - LHS_even ≥ 0` is implied by adding the two instances**, so it is a consequence
and not an extra hypothesis. -/
theorem even_gap_nonneg {Le Lo Re Ro : ℝ} (hplus : Le + Lo ≤ Re + Ro)
    (hminus : Le - Lo ≤ Re - Ro) : 0 ≤ Re - Le := by linarith

/-! ## The parity facts -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **The cubic is odd.** `Q` is even (it is quadratic) and the pairing adds one factor of `W`,
so `⟨W, Q(W)⟩` changes sign with `W`. This is what makes the reflection argument's two instances
differ only in the odd part. -/
theorem cubic_odd (Q : V → V) (hQ : ∀ x : V, Q (-x) = Q x) (x : V) :
    (inner ℝ (-x) (Q (-x)) : ℝ) = -inner ℝ x (Q x) := by
  rw [hQ, inner_neg_left]

/-- **`P(-W) = -P(W)` on the slice**, which is the same fact and is why the two-sidedness is empty
there: `𝒲ₙ` is linear and the cubic is odd on it. -/
theorem slice_odd (P : V → ℝ) (hP : ∀ x : V, P (-x) = -P x) (x : V) : P (-x) = -P x := hP x

/-- **The `Ω₀` premise is `W`-sign-symmetric**, its clauses reading `‖W‖` only. -/
theorem omega0_sign_symmetric (φ : ℝ → Prop) (W : V) : φ ‖(-W)‖ ↔ φ ‖W‖ := by rw [norm_neg]

/-! ## The triple census

*Multisets of size three over the three summands of `R = cI + Y + W`, written as exponent triples
`(i,j,k)` with `i + j + k = 3` for the powers of `I`, `Y` and `W`. The multinomial weight is
`3!/(i! j! k!)`, and it is the number of ordered triples the multiset stands for.* -/

/-- The multinomial weight of an exponent triple. -/
def weight (t : ℕ × ℕ × ℕ) : ℕ :=
  Nat.factorial 3 / (Nat.factorial t.1 * Nat.factorial t.2.1 * Nat.factorial t.2.2)

/-- The five surviving triples, in the order the record's display writes them:
`(I,I,I)`, `(I,Y,Y)`, `(Y,Y,Y)`, `(Y,Y,W)`, `(W,W,W)`. -/
def survivors : List (ℕ × ℕ × ℕ) := [(3, 0, 0), (1, 2, 0), (0, 3, 0), (0, 2, 1), (0, 0, 3)]

/-- The five vanishing triples: `(I,I,Y)`, `(I,I,W)`, `(I,Y,W)`, `(I,W,W)`, `(Y,W,W)`. -/
def vanishers : List (ℕ × ℕ × ℕ) := [(2, 1, 0), (2, 0, 1), (1, 1, 1), (1, 0, 2), (0, 1, 2)]

/-- **There are ten triples in all.** -/
theorem ten_triples :
    ((Finset.univ : Finset (Fin 4 × Fin 4 × Fin 4)).filter
      (fun t => (t.1 : ℕ) + (t.2.1 : ℕ) + (t.2.2 : ℕ) = 3)).card = 10 := by decide

/-- **Five survive and five vanish, and the ten are distinct.** -/
theorem five_and_five :
    survivors.length = 5 ∧ vanishers.length = 5 ∧ (survivors ++ vanishers).Nodup := by
  refine ⟨rfl, rfl, ?_⟩
  decide

/-- **Every listed triple is an exponent triple of total degree three.** -/
theorem degrees : ∀ t ∈ survivors ++ vanishers, t.1 + t.2.1 + t.2.2 = 3 := by decide

/-- **The survivors' multiplicities are `1,3,1,3,1`**, the record's correction to
[results.md](../../../results.md)'s `1,3,3,6`. -/
theorem survivor_weights : survivors.map weight = [1, 3, 1, 3, 1] := by decide

/-- **The vanishers' multiplicities are `3,3,6,3,3`**, the weight-`6` triple `(I,Y,W)` among
them. -/
theorem vanisher_weights : vanishers.map weight = [3, 3, 6, 3, 3] := by decide

/-- **No survivor carries multiplicity `6`.** -/
theorem no_survivor_has_weight_six : ∀ t ∈ survivors, weight t ≠ 6 := by decide

/-- **The partition checks: `9 + 18 = 27 = 3³`.** -/
theorem weights_partition :
    (survivors.map weight).sum = 9 ∧ (vanishers.map weight).sum = 18 ∧ 9 + 18 = 3 ^ 3 := by
  refine ⟨by decide, by decide, by norm_num⟩

/-- **The new coupling's constant splits as weight times trilinear value.** The `3` in
`3/(n-2)` is `(Y,Y,W)`'s multinomial weight and the `1/(n-2)` is the trilinear value, the
record's correction, and the reason the live hazard is `Ric₀`'s scale rather than the `3`. -/
theorem coupling_split {x : ℝ} (hx : x ≠ 2) :
    3 / (x - 2) = (weight (0, 2, 1) : ℝ) * (1 / (x - 2)) := by
  have h : weight (0, 2, 1) = 3 := by decide
  rw [h]
  push_cast
  ring

end HamiltonsCubic.L45

```

## Definitions and sources

- $\Lambda^2\mathbb R^n$, $\langle R,S\rangle=\operatorname{tr}(R\circ S)$, $I$ the identity, $\lVert I\rVert^2=\binom n2$. For $n\ge4$ a curvature operator decomposes orthogonally as $R=cI+Y+W$, $Y=R_{\mathrm{ric}_0}$ the traceless-Ricci part, $W$ Weyl.
- $\Phi(R)=R^2+R^\#$, $\Phi(A,B)$ its symmetric polarisation, $T(A,B,C)=\langle A,\Phi(B,C)\rangle$; on Weyl tensors $Q(W)=\Phi(W)$.
- $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ on $\{\mathrm{scal}>0\}$, $\Omega_0=\{\mathrm{scal}>0\}\cap F^{-1}((-\infty,\tfrac4{n-2}])$, equivalently $\{\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2,\ \operatorname{tr}R>0\}$; the criterion at $R$ is $\langle R,\Phi(R)\rangle\le F(R)\,\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$.
- **Filed sources, readable at source**: [references/xu-2024-ricci-flow-invariant-conditions/](../references/xu-2024-ricci-flow-invariant-conditions/) (Proposition 2.7, Lemma 2.6 eq. (2.31), Lemma 2.8 eq. (2.34), items (3) and (5)), [references/boehm-wilking-2008-space-forms/](../references/boehm-wilking-2008-space-forms/) (Lemma 2.1, Lemma 2.2, eqs. (5), (6)), [references/huisken-1985-ricci-deformation/](../references/huisken-1985-ricci-deformation/), and [references/beitz-2018-bianchi-convexity/](../references/beitz-2018-bianchi-convexity/).

## What to attack, beyond the standing list

1. The census: that there are ten distinct triples, which five vanish and which five survive, and the multiplicity each carries in $\langle R,\Phi(R)\rangle$.
2. **A mechanism for every vanishing triple, $(I,I,Y)$, $(I,I,W)$, $(I,Y,W)$, $(I,W,W)$, $(Y,W,W)$**, located in the written argument or in a cited source, and whether total symmetry of $T$ is used.
3. The value of the $(Y,Y,W)$ triple, $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$: which part is multiplicity and which trilinear value, and the normalisations of $\wedge$ and $\mathrm{Ric}_0$ it needs.
4. "Against the slice exactly one new coupling appears": against what count, and whether $(I,Y,Y)$ and $(Y,Y,Y)$ are also absent from the slice.
5. The parity argument: that $\Omega_0$ membership is invariant under $W\mapsto-W$; the $W$-parity of each piece of both sides; **whether $\mathrm{RHS}_{\rm even}$ and $\mathrm{RHS}_{\rm odd}$ are defined anywhere in Passages A to D**; and whether the two-sided bound and $\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}\ge0$ follow.
6. The classification against Xu Lemma 2.8 eq. (2.34) and the attribution to Huisken, read at source.
7. Whether Passage E's Lean statements type what they say, **including whether a theorem's hypotheses exclude anything** (a hypothesis satisfied by every object makes a theorem say nothing about the lemma).
8. The boundary: $n=3$ and $n=4$ (where the decomposition and $\tfrac1{n-2}$ live), $Y=0$, $W=0$, $c\le0$, and $\ker W\ne0$.

