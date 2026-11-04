# REVIEW r1701: L143's attainment of sup |P| at a critical point in Lean (d80abcd7)

**Verdict: CONFIRMED, with two presentation findings and two observations.** [L143Attain.lean](../lean/HamiltonsCubic/Results/L143Attain.lean) states over [WeylMaximiser.lean](../lean/HamiltonsCubic/Results/WeylMaximiser.lean)'s `weylSphereSet`, which is the record's unit sphere of $W_n$ under the layer's $\langle A,B\rangle=\tfrac12\sum_{ij}$ pairing, that at $n\ge4$ a critical $a$ ($Q(a)=P(a)a$) with $P(a)>0$ dominates $\lvert P\rvert$ on the whole sphere, and derives from it that a bound at every critical point bounds $\lvert P\rvert$ everywhere. The oddness step is sound, the range $n\ge4$ is the one where the sphere is nonempty, and the module rests on the standard three axioms. The findings are that the INDEX row's owed list omits the bridge between the two Lean layers L143's pieces live in (G1), and that [bounds.md](../findings/bounds.md)'s L143 proof note still lists the attainment as unchecked (G2).

| # | Claim | Verdict |
|---|---|---|
| 1a | `weylSphereSet` is the record's unit sphere of $W_n$ | **CONFIRMED** |
| 1b | `Qop2 a = Pcubic2 a • a` is the record's criticality at unit norm | **CONFIRMED** |
| 2a | `sup_abs_attained` states that $\sup\lvert P\rvert$ is attained at a critical point | **CONFIRMED** |
| 2b | $n\ge4$ is the right range | **CONFIRMED** |
| 2c | $P(-R)=-P(R)$ is used soundly | **CONFIRMED** |
| 3a | `sup_abs_le_of_critical` is the passage L143's block takes from critical points to $\sup\lvert P\rvert$ | **CONFIRMED**, and its hypothesis is dischargeable by the record's bound, which holds pointwise (O1) |
| 3b | The INDEX row states correctly what remains owed | **INCOMPLETE**: `hso` is named, the layer bridge is missing (G1) |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script, 3/3) |
| 5 | The record's prose is current | **STALE** at bounds.md:33 (G2) |

One line: the attainment r1469 owed is now a kernel-checked statement on the record's sphere, and what separates the layer from L143's headline is the second-order bound together with a bridge from `CurvOp2`/`IsWeyl2` to the `EigenFrame` layer that `L143_of_second_order` is typed in.

## Attack line 1: the sphere and criticality

- **`weylSphereSet ι := {R | normSq2 R = 1 ∧ IsWeyl2 R}`** ([WeylMaximiser.lean:98](../lean/HamiltonsCubic/Results/WeylMaximiser.lean#L98)). `normSq2 R = innerOp2 R R` and `innerOp2 R S = (1/2) * ∑ i, ∑ j, inner2 (applyPhi R i j) (applyPhi S i j)` ([Bivectors2.lean:279-283](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279)), which is the normalisation [r1469](REVIEW_r1469.md) recorded as the record's, $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$.
- **`IsWeyl2`** ([Bivectors2.lean:352](../lean/HamiltonsCubic/Base/Bivectors2.lean#L352)) bundles self-adjointness on $\Lambda^2$, first Bianchi and Ricci-flatness, the three conditions defining $W_n$. The record's $\sup_{\lVert W\rVert=1}$ in L143's statement ranges over $W_n$ (the block's proof works in a Weyl eigenframe with both Weyl marginals), so the set is the record's.
- **`Qop2 R := compOp2 R + sharpMapCL R`** ([Bivectors2.lean:825](../lean/HamiltonsCubic/Base/Bivectors2.lean#L825)) is $Q(R)=R^2+R^\#$, and `Pcubic2 = trCube2 + sharpPair2` is $P(R)=\langle R,R^2+R^\#\rangle$. At unit norm, $Q(a)=\theta a$ pairs with $a$ to give $\theta=\langle a,Q(a)\rangle=P(a)$ (`Pcubic2_eq_innerOp2`, used the same way in `Qop2_eq_smul_weyl`), so `Qop2 a = Pcubic2 a • a` is the record's "critical point, where $P=\theta$" with $\theta$ eliminated rather than a different condition.

## Attack line 2: `sup_abs_attained`

- **What it says.** $\exists a\in$ `weylSphereSet`, `Qop2 a = Pcubic2 a • a`, `0 < Pcubic2 a`, and $\forall R\in$ `weylSphereSet`, $\lvert P(R)\rvert\le P(a)$. Since $a$ is itself on the sphere, $P(a)=\lvert P(a)\rvert$ is the supremum of $\lvert P\rvert$ and is attained at $a$, which is critical. That is the record's *"$\sup\lvert P\rvert=\sup P$ is attained at a critical point"* ([bounds.md:25](../findings/bounds.md#L25)) exactly, including the equality $\sup\lvert P\rvert=\sup P$ (the conclusion also gives $P(R)\le P(a)$).
- **The range.** $W_n=0$ for $n\le3$, so the sphere is empty there and the existential would be false. `L24_nonvacuous` needs $n\ge4$ for the nonempty witness `Wc n`. `4 ≤ n` is the range where the claim has content and is true, and the record's L143 is used at $n\ge4$ only.
- **Oddness.** `neg_mem_weylSphereSet` uses `normSq2_smul` ($(-1)^2=1$) and `isWeyl2_smul`, so $-R$ is on the sphere. `Pcubic2_smul` ([L24Weyl.lean:47](../lean/HamiltonsCubic/Results/L24Weyl.lean#L47)) gives $P(-R)=(-1)^3P(R)$, and the maximality `hmax` of $a$ at $-R$ gives $-P(R)\le P(a)$. With `hmax hR` for the other side, `abs_le` closes. Sound, and the only place a sign could slip is `Pcubic2_smul`'s cube, which is a proved lemma.
- **The object that would break it**: a unit Weyl $R$ with $P(R)<-P(a)$, the negative lobe of the cubic exceeding the positive one. I looked for it by checking that the reflection $R\mapsto-R$ preserves both halves of `weylSphereSet` (it does, by the two smul lemmas) and that $P$ is exactly odd under it (it is, homogeneous of degree three). Such an $R$ would give $-R$ with $P(-R)>P(a)$, contradicting `IsMaxOn`. It cannot exist.

## Attack line 3: `sup_abs_le_of_critical` and the row

- **The passage.** The block reads *"attained at a critical point, where $P=\theta$ and second-order.md's bound $\theta\le\lambda_{\max}p+B_5$ applies"*. `sup_abs_le_of_critical` takes a bound $\Theta$ on $P$ at every critical point of the sphere and returns $\lvert P\rvert\le\Theta$ on the sphere. That is the passage. It is [WeylMaximiser.lean](../lean/HamiltonsCubic/Results/WeylMaximiser.lean)'s `L0_critical_reduction` (backward direction) composed with oddness.
- **Could the hypothesis be too strong?** It quantifies over every critical point, including saddles and minima. If the imported bound needed second-order optimality it would hold only at local maxima, and the passage would ask for more than the record can give. It does not: [second-order.md:980-984](../findings/second-order.md#L980) derives $\langle W,W^\#\rangle\le B_5$ and $\mathop{\mathrm{tr}}W^3\le\lambda_{\max}p$ by Cauchy–Schwarz at any unit $W$, and r444/r445 confirmed the borrowed bound is pointwise at unit norm. So the hypothesis is dischargeable (O1).
- **The row.** It now says the second-order bound $\theta\le\lambda_{\max}p+B_5$ stays owed as `hso`, and the attainment is proved. Both statements are true. The owed list is incomplete (G1).

### G1. The row omits the layer bridge (minor)

- `L143_of_second_order` ([L143Assembly.lean:74](../lean/HamiltonsCubic/Results/L143Assembly.lean#L74)) is typed over `W : Matrix ι ι ℝ → Matrix ι ι ℝ` with `RealLayer.IsWeyl W` and an `L41Statement.EigenFrame W v lam`, and its `θ` is a free real. `sup_abs_le_of_critical` is typed over `CurvOp2 (Fin n)` with `IsWeyl2` and `Pcubic2`.
- No file in the layer mentions both `EigenFrame` and `CurvOp2` (grep over lean/HamiltonsCubic). So discharging `hcrit` from `L143_of_second_order` needs, besides `hso`, a map from a critical `CurvOp2` to an eigenframe of the matrix-layer operator with $\sum\lambda^2=1$ and `θ = Pcubic2 R`.
- The row lists `hso` as the one remaining input. A reader would conclude that proving `hso` types L143's headline, and it does not. *Opposite argued*: the trailing *"statement: not typed"* already says the headline is absent. It says so, but the owed list is presented as the remainder, the same pattern r1469's G1 found. Survives, minor. Repair: add the bridge, with `θ = Pcubic2 R` at the frame, to the owed list.

### G2. bounds.md's proof note is stale (minor)

- [bounds.md:33](../findings/bounds.md#L33) still closes with *"which leaves the imported second-order bound and the attainment at a critical point as the unchecked steps"*. The commit did not touch bounds.md. The attainment is now checked in L143Attain.lean. Repair: name L143Attain.lean's `sup_abs_attained` there and leave the second-order bound and the layer bridge as the unchecked steps.

## Attack line 4: axioms and build

- `lake build HamiltonsCubic.Results.L143Attain` completes. One linter warning in the new file: line 11 exceeds 100 characters (docstring). Presentation only.
- `python3 scripts/misc/axiom_audit.py --only L143Attain.lean`: *3/3 clean, resting on the standard three alone*. Reported as a screen.
- No `sorry`, no `native_decide`.

## Observations

- **O1. The attainment is inessential to L143's inequality.** Because $P(W)\le\lambda_{\max}p+B_5$ holds at every unit Weyl $W$, the block's bound follows pointwise, $P(W)\le1+\sqrt{n-2}$ everywhere, with $\lvert P\rvert$ from oddness alone. The attainment step is correct, and it is the route the block writes, so formalising it is faithful. A Lean assembly may find the pointwise route shorter, since it needs the eigenframe bridge at every unit $W$ rather than at critical points and the criticality then plays no role.
- **O2. The strength is the record's.** `sup_abs_attained` adds `0 < Pcubic2 a`, stronger than the record's text and true (`P(a) ≥ √(3/2)`). Nothing weaker than the record is claimed.
