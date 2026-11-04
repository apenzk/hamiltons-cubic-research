# Review r1083, Lemma L233, the pair direction's second-order quotient

*COLD adversarial Gate 2 review of [Lemma L233](../findings/second-order.md), commit `d4cda4c9`. Log: [r1083-L233.log](../agent_logs/r1083-L233.log). Every figure below was rebuilt from [conventions.md](../findings/conventions.md)'s index formula in a scratch build that imports nothing from [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py). Numbers are screens, and the verdicts rest on the derivation.*

| # | claim | verdict |
| --- | --- | --- |
| K1 | the boxed closed form at every `W` with `θ ≠ 0` and every distinct eigenpair | **CONFIRMED**, and true far beyond its stated hypotheses |
| K2 | anticommutator half is `¼(ε_α + ε_β)` from `Y₀² = ¼(uuᵀ + vvᵀ)` | **CONFIRMED** |
| K3 | the `#` half is one trace per basis element, each `½(u·A_γ v)²` | **CONFIRMED**, antisymmetry the only hypothesis |
| K4 | the admissible direction's whole `#` content is carried by the projection | **REFUTED as stated**, CONFIRMED for the disjoint-plane construction alone |
| K5 | `⟨W, Y₀⟩ = 0` automatically at `α ≠ β` | **CONFIRMED**, carried by orthonormality rather than by `α ≠ β` |
| K6 | an eigenvector at `μ ≠ ½` is orthogonal to the orbit tangent | **CONFIRMED** in the block, on a premise the commit and [plan.md](../plan.md) overstate |
| K7 | Lean statement fidelity of the six theorems, and their axioms | **CONFIRMED** |
| K8 | the `Lean: blocked` trailer | **PLAUSIBLE as a blocker, REFUTED as a diagnosis**: [lean/INDEX.md](../lean/INDEX.md)'s "nothing to be written in" is false |

**And one defect the claim table does not cover: the worked configuration is mislabelled.** Every number in the block belongs to the `(4,4)` split at `n = 8`, which this record calls $S^4\times S^4$. The block, the commit and the screen call it $S^3\times S^3$, and at the genuine $S^3\times S^3$ the block's own non-vacuity argument is empty.

## K1, the closed form: CONFIRMED, by a derivation that shares nothing with the author's

**The index contraction, derived here from the definition.** With $c_{abc}=\langle[\psi_a,\psi_b],\psi_c\rangle$ totally antisymmetric and the record's $\tfrac12$-carrying index formula $(X^{\#})_{ab}=\tfrac12\sum c_{acd}c_{bef}X_{ce}X_{df}$, polarisation gives $\mathrm{sharpBil}(X,Y)_{ab}=\tfrac12\sum c_{acd}c_{bpq}X_{cp}Y_{dq}$, the two cross terms coinciding after the relabelling $(c\leftrightarrow d,\ p\leftrightarrow q)$ at sign $(-1)^2$. Writing $(\mathrm{ad}_c)_{da}=c_{cad}=-c_{acd}$ and evaluating in $E$'s own eigenbasis,

$$\langle Y,\mathrm{sharpBil}(E,Y)\rangle=\tfrac12\sum_\gamma\varepsilon_\gamma\mathop{\mathrm{tr}}\big(\mathrm{ad}_{\psi_\gamma}Y\,\mathrm{ad}_{\psi_\gamma}^{\mathsf T}Y\big)=-\tfrac12\sum_\gamma\varepsilon_\gamma\mathop{\mathrm{tr}}\big((\mathrm{ad}_{\psi_\gamma}Y)^2\big),$$

**which is the block's identity with the block's sign and the block's $\tfrac12$.** *The normalisation was checked before use, as [conventions.md](../findings/conventions.md) requires: at $E=Y=\mathrm{id}$ the right side is $-\tfrac12\sum_\gamma B(\psi_\gamma,\psi_\gamma)=(n-2)\binom n2=\langle\mathrm{id},\mathrm{id}^{\#}\rangle$, using $\mathop{\mathrm{tr}}(\mathrm{ad}_a\mathrm{ad}_b)=-2(n-2)\delta_{ab}$, which is the same $2(n-2)$ [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean)'s `sum_inner2_ad2` proves.*

**Then K3's trace and K2's square assemble the box exactly.** $-\tfrac12\sum_\gamma\varepsilon_\gamma\cdot\tfrac12(u\!\cdot\!\mathrm{ad}_{\psi_\gamma}v)^2=-\tfrac14\sum_\gamma\varepsilon_\gamma\langle\psi_\gamma,[u,v]\rangle^2$, since $u\!\cdot\!\mathrm{ad}_{\psi_\gamma}v=-\langle\psi_\gamma,[u,v]\rangle$ by cyclicity. Adding $\tfrac14(\varepsilon_\alpha+\varepsilon_\beta)$ and dividing by $\lVert Y_0\rVert^2=\tfrac12$ gives the box.

**The hypotheses are far stronger than the identity needs, and this block is the one place that should say so.** Neither $W\in\mathcal W_n$, nor unit norm, nor criticality, nor $\theta>0$ enters: the identity holds for **every** symmetric operator $E$ on $\Lambda^2$ and every orthonormal pair of its eigenvectors. *The file's own Lean docstring makes exactly this point about `trace_sq_pair_direction` and the statement above it does not.*

**Screen.** Rebuilt independently, the box holds at all $15+45+105+210$ eigenpairs of a random symmetric $E$ at $n=4,5,6,7$ to $4\cdot10^{-15}$, with $\mathrm{id}^{\#}=(n-2)\mathrm{id}$ exact and the trilinear $\langle X\#Y,Z\rangle$ symmetric to ten digits, and at all $105$ eigenpairs of a random $W\in\mathcal W_6$ (the constraint nullspace returning $\dim=84$) to $2\cdot10^{-15}$.

### The basis the sum runs over: the expression is basis-free, and saying so removes the trap

$\sum_\gamma\varepsilon_\gamma\langle\psi_\gamma,[u,v]\rangle^2=\langle[u,v],\,e\,[u,v]\rangle$, a quadratic form evaluated at one vector. **So the box is basis-independent, the eigenbasis is only where it is easiest to write, and inside a degenerate eigenspace the choice is free because $\varepsilon_\gamma$ is constant there.** The block's warning names a real trap: writing the boxed form and then reading the $\varphi$-basis components of $[u,v]$ against eigenbasis-indexed $\varepsilon$'s. *This reviewer reproduced that exact slip on the first pass and it moved a quotient by $0.32$ at $n=5$.* **The repair is to display $\langle[u,v],e[u,v]\rangle$ and give the spectral sum as a corollary**, which no reader can misindex. *[plan.md](../plan.md)'s rendering $\tfrac12\lVert[u,v]\rVert^2_\varepsilon$ should go the same way: $\varepsilon$ takes both signs, so it is a quadratic form and not a norm.*

## K2, K3, K5: CONFIRMED

- **K2.** $Y_0^2=\tfrac14\big(u(v\!\cdot\!v)u^{\mathsf T}+v(u\!\cdot\!u)v^{\mathsf T}+(v\!\cdot\!u)(uv^{\mathsf T}+vu^{\mathsf T})\big)$ collapses to $\tfrac14(uu^{\mathsf T}+vv^{\mathsf T})$ at orthonormal $u,v$, and $\langle Y_0,\tfrac12(eY_0+Y_0e)\rangle=\mathop{\mathrm{tr}}(eY_0^2)$ by cyclicity, giving $\tfrac14(\varepsilon_\alpha+\varepsilon_\beta)$.
- **K3.** $AY_0=\tfrac12(Au\,v^{\mathsf T}+Av\,u^{\mathsf T})$, the two cross terms carry $u\!\cdot\!Au$ and $v\!\cdot\!Av$ and die, and the survivors are $\tfrac14\big((v\!\cdot\!Au)^2+(u\!\cdot\!Av)^2\big)=\tfrac12(u\!\cdot\!Av)^2$. **Antisymmetry alone**, as claimed.
- **K5.** $\langle W,Y_0\rangle=\tfrac\theta2(v\!\cdot\!eu+u\!\cdot\!ev)=\tfrac\theta2(\varepsilon_\alpha+\varepsilon_\beta)\langle u,v\rangle=0$. **The hypothesis consumed is $u\perp v$, not $\alpha\ne\beta$**: at $\varepsilon_\alpha\ne\varepsilon_\beta$ orthogonality is automatic, and inside one eigenspace it is supplied by the statement's own choice of an orthonormal eigenbasis. *The block's "automatically at $\alpha\ne\beta$" attributes it to the wrong hypothesis.*

## K4, the load-bearing structural claim: REFUTED as stated

**The chain up to the third link is right.** The `#` half is quadratic in $[u,v]$, so it vanishes when $u$ and $v$ commute. Two disjoint coordinate planes commute, so the direction built from them has no `#` content. *All three verified.*

**The fourth link, "so the admissible direction's whole `#` content is carried by the projection", is a verdict about a family tested on one member.** Two counterexamples, the second inside the very configuration the block demonstrates:

- **At a random $W\in\mathcal W_6$, every one of the $105$ eigenpairs has $[u,v]\ne0$**, with $\lVert[u,v]\rVert^2$ running from $0.163$ to $1.223$, median $0.536$, and none below $10^{-9}$. So on a generic maximiser the bracket carries `#` content at every pair and the unprojected quotient is **not** the plain average.
- **At the block's own sphere product, a SHARING eigenpair breaks it.** Take $u=\varphi_{01}$ and $v=\varphi_{04}$, both eigenvectors of the same diagonal $e$, in distinct eigenspaces ($\tfrac4{21}$ and $-\tfrac17$). They share the index $0$, so $\lVert[u,v]\rVert^2=1$ and the unprojected quotient is $\tfrac2{21}$ against a plain average of $\tfrac1{42}$. **The `#` content of the unprojected direction is $\tfrac1{14}$, not zero.**

**So the correct statement is scoped**: *on a pair direction built from two commuting eigenvectors, in particular two disjoint coordinate planes, the unprojected quotient is the plain average, and the whole of the admissible direction's `#` content is created by the $\Lambda^4$ removal.* The commit message's bullet already carries that scope. **The findings block, the [INDEX-results.md](../findings/INDEX-results.md) row and the [plan.md](../plan.md) item drop it**, the row making it worse with a "which is why" that derives the unscoped claim from the scoped premise.

### The one member it was tested on, rebuilt here, and what the split into halves shows

*The block asserts that the projection moves the quotient by $\tfrac17$. That is the net of two moves in opposite directions, and only one of them is the `#` term.*

| direction | $\lVert\cdot\rVert^2$ | anticommutator half | `#` half | quotient |
| --- | --- | --- | --- | --- |
| $Y_0=\varphi_\pi\odot\varphi_\rho$ | $\tfrac12$ | $\tfrac4{21}=\tfrac{12}{63}$ | **exactly $0$** | $\tfrac4{21}$ |
| $X=\pi_{\mathcal W_n}Y_0$ | $\tfrac13$ | $\tfrac5{63}$ | $\tfrac{16}{63}$ | $\tfrac13$ |

*Reproduced independently: the sphere product is critical to $8\cdot10^{-17}$ with $\theta=\theta_0(8)=1.145644$ and Ricci residual $4\cdot10^{-16}$; $X$ is an exact eigenvector, $e\circ X=\tfrac13X$ to $7\cdot10^{-18}$, with $\langle W,X\rangle=0$ and $\mathrm{Alt}(X)=0$ to $2\cdot10^{-17}$. So [L26](../findings/nondegeneracy.md)'s $\mu$ is confirmed from structure constants, as the block claims.*

**The shift is $-\varepsilon_{PQ}$ and it is structural, not a coincidence at $\tfrac17$.** [L26](../findings/nondegeneracy.md)'s own three-symbol identity $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ already says the projected quotient exceeds the unprojected one by exactly the mixed-block eigenvalue, here $\tfrac17$. *So at the sphere product L233 adds no number that L26 did not already hold. What L233 adds is the general-$W$ closed form, and the block would be stronger for saying that.*

## The configuration is mislabelled, and at the point named the argument is empty

**Every figure in the block is the $(p,q)=(4,4)$ split at $n=8$.** $\mu=\tfrac{n-2}{2(p-1)(q-1)}=\tfrac13$ forces $(p-1)(q-1)=9$; the quoted tangent $16=\dim\mathfrak{so}(8)-\dim(\mathfrak{so}(4)\oplus\mathfrak{so}(4))$ forces the same; and $\varepsilon_{PP}=\tfrac4{21}$ is what the $(4,4)$ operator returns. **Under this record's own convention, $S^p\times S^q$ is the split $(p,q)$ at $n=p+q$** ([L26](../findings/nondegeneracy.md), [L27](../findings/nondegeneracy.md), and the excess table's "$S^4\times S^4$, $S^6\times S^6$, $S^5\times S^7$ at $n=8,10,12$"), so this configuration is **$S^4\times S^4$**. *[INDEX-values.md](../findings/INDEX-values.md) settles it outright: it records $\theta_0(8)=1.145644$ against $S^4\times S^4$ at $n=8$, and $1.145644$ is the $\theta$ the block's own configuration returns.*

**At the genuine $S^3\times S^3$, rebuilt here, the numbers are different and the argument dies.** The $(3,3)$ split at $n=6$ gives $\theta=1.054093$, $\varepsilon_{PP}=\varepsilon_{QQ}=\tfrac3{10}$, $\varepsilon_{PQ}=-\tfrac15$, unprojected quotient $\tfrac3{10}$ and $\mu=\tfrac12$ **exactly**. *So at the point the block names, the pair direction sits at $\mu=\tfrac12$, which is precisely where "an eigenvector at $\mu\ne\tfrac12$ is orthogonal to the orbit tangent" says nothing, and where this same file records the degeneracy, the excess of $9$, and the third-order failure.* **A reader who takes the label at face value imports the one split in the range where the block's own non-vacuity clearance is vacuous.**

**Spread, three places, originating in the screen**: [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py) line 258 prints "the same S^3 x S^3 inside n=8" while line 133 sets `n, p = 8, 4`; the block says it twice; the commit message once. *[INDEX-results.md](../findings/INDEX-results.md) and [plan.md](../plan.md) name no point and are clean.*

## K6, non-vacuity: CONFIRMED in the block, on a premise the commit and plan.md overstate

**The inference is sound and needs less than it is given.** $L_e$ is self-adjoint because $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric (verified here on general symmetric operators, not only on $\mathcal W_n$), and [post F37](../findings/fence-posts.md) puts the orbit tangent **inside** the $\tfrac12$-eigenspace. Self-adjointness then separates eigenvectors at distinct eigenvalues, so an eigenvector at $\mu\ne\tfrac12$ is orthogonal to the tangent. *Containment is all the conclusion consumes, and the block's wording, "the orbit tangent consists of exact $\tfrac12$-eigenvectors", says exactly that.*

**The commit message and [plan.md](../plan.md) say instead that "the orbit tangent is its exact $\tfrac12$-eigenspace", and that is false in general.** *This same file defines EXCESS as the gap between the two and records it as $9$ at $S^3\times S^3$, $12$ and $24$ at padded $S^2\times S^6$.* The conclusion survives, the premise as written does not, and a successor quoting the plan rather than the block inherits a false statement.

**One limit the paragraph does not state.** The clearance covers pair directions **that are eigenvectors** of $L_e$. At the sphere product $\pi_{\mathcal W_n}Y_0$ is one, by L26. At a general $W$ nothing says it is. *So [post F39](../findings/fence-posts.md)'s trap is cleared for the eigenvector case, which is the case the route uses, and is open in general.*

## K7, the Lean: CONFIRMED

`#print axioms` returns `[propext, Classical.choice, Quot.sound]` on all six, the file carries no `sorry` and no `native_decide`, and the elaborated types read as follows.

`pairDir_sq`, `trace_mul_pairDir_sq` and `trace_pairDir_sq` carry $u\cdot u=1$, $v\cdot v=1$, $u\cdot v=0$ and nothing else, so **orthonormality is the hypothesis of the anticommutator half, as the block says**, and `trace_mul_pairDir_sq` is in fact stated at every `E`, eigenvector-freely. `trace_sq_pair_direction` carries $A^{\mathsf T}=-A$ and nothing else, so **antisymmetry is the only hypothesis of K3, as the block says**, and the identity is stated at every `Fintype` over $\mathbb R$.

*One step of the anticommutator half sits outside the file: $\langle Y,\tfrac12(EY+YE)\rangle=\mathop{\mathrm{tr}}(EY^2)$, cyclicity plus symmetry of `Y`, is used by the block and typed nowhere. It is two lines and it is not what the trailer names as blocked.*

## K8, the blocked trailer: the blocker is real, the diagnosis is not

**The three names are genuinely absent.** `sharpQF_eq_sum_ad`, `sharpBilin_eq_sum_ad` and `sharpBil_eq_sum_ad` appear nowhere in [lean/](../lean/).

**But [lean/INDEX.md](../lean/INDEX.md)'s reason is false, and it is the reason a successor will act on.** It says *"`sharpBilin` itself is fixed at `Fin 6` over $\mathbb Q$ in RelationB.lean, so the sum over $\Lambda^2$'s basis at general $n$ has nothing to be written in."* [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) carries `sharpQF`, `sharpBil`, `sharpOp` and `sharpPair` at every `ι` over $\mathbb R$, and [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) carries `sharpQF2` and `sharpBil2` at every `ι` as well. **More than that, the sum the trailer says cannot be written IS the definition already in the tree:**

`sharpQF R η = -(1/4) * ∑ i, ∑ j, inner2 (br η (R (br η (R (phi i j))))) (phi i j)`,

which over ordered pairs is $-\tfrac12\mathop{\mathrm{tr}}\big((\mathrm{ad}_\eta R)^2\big)$, **the block's per-$\gamma$ term verbatim at $R=Y_0$, $\eta=\psi_\gamma$**. *[StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean)'s own docstring records [r797](REVIEW_r797.md) deriving that identity by hand, and `sharpQF_id` discharges its normalisation at every $n$.*

**What is actually missing, and it should be named instead.** Two things, neither of which is a general-$n$ `#`: (i) the polarisation in the **operator** slot, `sharpOpBil R S := (1/2)•(sharpOp (R+S) - sharpOp R - sharpOp S)`, three lines, the real-layer mirror of what `sharpBilin` already is over $\mathbb Q$; and (ii) the **full symmetry of $\langle X\#Y,Z\rangle$ in the three operator slots**, which is what turns $\langle Y,\mathrm{sharpBil}(E,Y)\rangle$ into $\langle E,Y^{\#}\rangle=\sum_\gamma\varepsilon_\gamma\,$`sharpQF Y (ψ γ)`. *[conventions.md](../findings/conventions.md) asserts (ii) in one clause and no declaration holds it.* **(i) the cycle could plainly have built; (ii) is a round of its own.** So the trailer is honest that the assembly is untyped and wrong about why, and the entry a successor reads points at the wrong file.

## Corrections owed

1. **Rename the worked point $S^4\times S^4$** in the block (twice) and in [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py) line 258, and say $n=p+q$ beside it.
2. **Scope K4** in the block, the [INDEX-results.md](../findings/INDEX-results.md) row and the [plan.md](../plan.md) item to commuting pairs, with the sharing-pair counterexample $\varphi_{01},\varphi_{04}$ at the same sphere product recorded as the reason.
3. **Replace the premise "the orbit tangent is its exact $\tfrac12$-eigenspace"** in [plan.md](../plan.md) with containment, which is what F37 gives and all the conclusion needs.
4. **Display the `#` term as $\langle[u,v],e\,[u,v]\rangle$**, with the spectral sum as a corollary, and drop $\lVert\cdot\rVert^2_\varepsilon$.
5. **Rewrite the blocked reason** in [lean/INDEX.md](../lean/INDEX.md) and name the operator-slot polarisation and the trilinear symmetry.
6. **State the box at every symmetric $E$ on $\Lambda^2$**, with $W\in\mathcal W_n$ as the application, since no clause of the proof uses Weyl, unit norm or criticality.
