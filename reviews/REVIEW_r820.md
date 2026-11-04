# r820: Gate 2 on L193, the adjugate law for the Pfaffian adjugate

*Cold brief: I was given the block, its two extension boxes and four givens, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L179 through L193), [findings/conventions.md](../findings/conventions.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [lean/INDEX.md](../lean/INDEX.md), [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean), [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean) and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand and every constant is exact. Four machine actions were screens on objects I constructed for the purpose, reported as screens in §8 and never as evidence for a positive claim. Log: [agent_logs/g2-l193-r820.log](../agent_logs/g2-l193-r820.log).*

| Claim | Verdict |
|---|---|
| **Statement**, $\omega\,\sigma(\omega)=-\mathrm{Pf}(\omega)\,\mathrm{Id}_6$ at every $\omega$, **including the sign** | **CONFIRMED**, and the sign is right in the record's own conventions. Recomputed from [star6](../lean/HamiltonsCubic/Base/SelfDual.lean), [levi6](../lean/HamiltonsCubic/Base/SelfDual.lean) and [pf6](../lean/HamiltonsCubic/Base/Pfaffian6.lean) rather than from the block: $\star e^{1234}=e^{56}$ at the layer's $1/4!$, $\mathrm{pf6}=c_1c_2c_3$ at its $1/48$, and $\sigma(\omega)=\sum_j(\prod_{k\ne j}c_k)\varepsilon_j$ with $+$ on all three planes. The minus is $J^2=-\mathrm{Id}_2$ and nothing else, and it is orientation-free: reversing orientation flips $\sigma$ and $\mathrm{Pf}$ together |
| **The proof by normal form**, soundness and completeness | **CONFIRMED as a proof, with two load-bearing steps unstated.** The real skew normal form is available with $g\in SO(6)$ and covers every degeneracy, a zero $c_j$ included, so rank $2$ and rank $4$ need no separate case. What the block never says is that both sides are $SO(6)$-equivariant, which is the only reason a computation in one frame is a statement about $\omega$. **Non-uniqueness at a repeated $c_j$ costs nothing** because the right side $-\mathrm{Pf}(\omega)\mathrm{Id}$ is manifestly frame-free |
| **"simultaneously block-diagonal for that splitting"** | **CONFIRMED and it is derived, not assumed.** It reads off the display for $\sigma(\omega)$ one line above it. The block's emphasis puts the weight on the wrong clause |
| **The polarised form and every coefficient** | **CONFIRMED exactly as displayed.** The three left terms carry coefficient $1$ each and the right carries $-\langle\beta(\alpha,\eta),\zeta\rangle$ unsymmetrised. **The reason no symmetrisation is needed is missing from the box**: $\langle\beta(\alpha,\eta),\zeta\rangle\mathrm{vol}=\alpha\wedge\eta\wedge\zeta$ is already totally symmetric |
| **The harmonicity box**, the factor $2$, and $\sum_i\lambda_i\beta(\omega_i,\omega_i)=\star\mathcal B$ | **CONFIRMED, every constant.** The $2$ is the collision of the first two terms at $\alpha=\eta=\omega_i$, and the identification needs no factor because $\beta(\omega,\omega)=\star(\omega\wedge\omega)$ is $2\sigma(\omega)$ rather than $\sigma(\omega)$ |
| **"neither follows from the other by inspection"** | **REFUTED in one direction.** §5 derives [L187](../findings/diagonal-half.md)'s $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$ from L193 in five lines, taking determinants once and inverting once. The converse I could not obtain and expect to be false, L187 being a statement the pair-spectrum model satisfies with no matrix product in it. **The sentence should claim the asymmetry it has** |
| **"the only relation the record carries between a form's SQUARE and its ADJUGATE"** | **REFUTED.** [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) carries two more: `StarWedgeIdentity`, the record's $\star_V(J\wedge J)=2\epsilon_JJ$ at $\omega^2=-\mathrm{Id}$, and `wedgeSelf_areaForm` together with `areaForm_sq_of_orthonormal` at the decomposable locus. **The repair is an upside**: L193 PROVES the first of those, constant, base sign and all, which the record carries as HYPOTHESIS-DEBT |
| **Lean, "what is typed is the proof's load-bearing step"** | **HALF REFUTED.** `adjugate_law_plane` and `adjugate_law_agree` are faithful and are the load-bearing half. **`adjugate_law_sign` is VACUOUS**: its hypothesis `c * c = -1` is unsatisfiable over `ℝ`, so it verifies nothing about the sign, and the opposite sign is equally provable from it (§7, screened) |
| **Lean, "the frame-free matrix form needs a normal-form theorem the layer does not build"** | **REFUTED as written**, and it conflates statement with proof. The frame-free STATEMENT types today out of `star6`, `wedgeSelf`, `pf6` and `IsSkew`, all four in the layer, and I compiled it (§7). A normal form is one route to a PROOF and not a necessity, the identity being a polynomial identity in the fifteen entries |
| **Scoping at $n>6$** | **ONE OMISSION.** In the record's rank-three setting $V\subseteq\mathbb R^n$, and the forms annihilate $V^\perp$, so $\mathrm{Id}_6$ must be read as $\mathrm{Id}_V$. As an $n\times n$ identity the harmonicity box is false. [L184](../findings/diagonal-half.md) is emphatic about exactly this for $\star_V$ and this block is silent |

**One line.** *The Statement, its sign, the polarised form and the harmonicity box all survive intact with every constant verified, and the defects are in what the block says ABOUT its result rather than in the result: L187 does follow from L193 in five lines, the "only relation" claim is false against the record's own Lean layer, and the Lean row misstates a proof obligation as a statement obligation while resting the sign on a lemma with an empty hypothesis class. Two things are worth folding beyond the repairs. **L193 discharges the record's standing HYPOTHESIS-DEBT** $\star_V(J\wedge J)=2\epsilon_JJ$, which L184's case 2 runs on and which the layer has carried unproved. And **the TRACE of the harmonicity box is L192's scalar identity**, $\mathop{\mathrm{tr}}\big(\sum_i\lambda_i\omega_i\beta(\omega_i,\zeta)\big)=-2\langle\star\mathcal B,\zeta\rangle$, so the two Weyl conditions were already meeting as scalars inside this matrix identity and the box's closing claim overstates the novelty by one word.*

## 0. Conventions, fixed once and checked against the layer

- A $2$-form is a skew matrix $\omega_{ab}$, and the pairing is `inner2 X Y = ½tr(XᵀY)`, which on $\Lambda^2$ is $\sum_{a<b}X_{ab}Y_{ab}$, so the $\varepsilon_j$ are orthonormal. This is [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s `inner2` and [conventions.md](../findings/conventions.md)'s norm.
- $(\alpha\wedge\eta)_{abcd}$ is the layer's `wedge2`, so $(\omega\wedge\omega)_{abcd}=2(\omega_{ab}\omega_{cd}-\omega_{ac}\omega_{bd}+\omega_{ad}\omega_{bc})$.
- $\star$ on $\Lambda^4\mathbb R^6$ is `star6`, $(\star T)_{ab}=\tfrac1{24}\sum_{cdef}\epsilon_{abcdef}T_{cdef}$, the normalisation under which $\star e^{1234}=e^{56}$.
- $\mathrm{Pf}$ is `pf6` at $1/48$, equivalently $\omega^{\wedge3}=3!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$, so $\mathrm{Pf}(\sum_jc_j\varepsilon_j)=c_1c_2c_3$. [conventions.md](../findings/conventions.md) still fixes no Pfaffian and no Hodge star, and these two files are the record's definition in practice.
- $\beta(\alpha,\eta)=\star(\alpha\wedge\eta)$, $\sigma(\omega)=\tfrac12\beta(\omega,\omega)$, $\mathcal B=\sum_i\lambda_i\,\omega_i\wedge\omega_i$.
- $J=\begin{pmatrix}0&1\\-1&0\end{pmatrix}$, so $\varepsilon_1$ as a matrix is $J$ on $\mathrm{span}(e_1,e_2)$ and $J^2=-\mathrm{Id}_2$.

## 1. The Statement and its sign, recomputed from the layer

**Located.** The Statement display and the last clause of the Proof.

Put $\omega=c_1\varepsilon_1+c_2\varepsilon_2+c_3\varepsilon_3$. Then $\omega\wedge\omega=2\big(c_1c_2\,e^{1234}+c_1c_3\,e^{1256}+c_2c_3\,e^{3456}\big)$, and the three stars are $\star e^{1234}=e^{56}$, $\star e^{1256}=e^{34}$ and $\star e^{3456}=e^{12}$, each with a PLUS: $e^{1256}\wedge e^{34}=e^{125634}$ and moving $34$ left past $56$ is four transpositions. Hence

$$\sigma(\omega)=\tfrac12\star(\omega\wedge\omega)=c_2c_3\,\varepsilon_1+c_1c_3\,\varepsilon_2+c_1c_2\,\varepsilon_3,$$

which is the block's $\sum_j(\prod_{k\ne j}c_k)\varepsilon_j$ with no stray factor. On the $j$-th plane the matrix product is $(c_jJ)\big((\prod_{k\ne j}c_k)J\big)=c_1c_2c_3\,J^2=-\mathrm{Pf}(\omega)\,\mathrm{Id}_2$, the same value on all three, so $\omega\,\sigma(\omega)=-\mathrm{Pf}(\omega)\,\mathrm{Id}_6$. **CONFIRMED.**

**The sign is stable under the one convention the record has not fixed.** Reversing orientation sends $\star\mapsto-\star$, hence $\sigma\mapsto-\sigma$ and $\mathrm{Pf}\mapsto-\mathrm{Pf}$, and both sides of the display change sign together. So no choice of $\epsilon_{123456}$ can flip the identity, and the minus is $J^2$'s alone, exactly as the block says.

**Argued the opposite.** For the sign to be wrong one would need either a minus in $\star e^{1256}$, which the four-transposition count excludes, or the record's $\mathrm{Pf}$ to be $-c_1c_2c_3$, which `pf6` at $1/48$ against `levi6` excludes. Neither survives.

**The identity in the classical form.** $\det\omega=\mathrm{Pf}(\omega)^2$, so the display says $\mathop{\mathrm{adj}}(\omega)=-\mathrm{Pf}(\omega)\,\sigma(\omega)$. The block's gloss is therefore right up to the factor it does not display, and the factor is worth writing, since $\sigma$ is the adjugate divided by $-\mathrm{Pf}$ and not the adjugate.

## 2. The proof by normal form, and what it leaves unstated

**Located.** The first sentence of the Proof, and "The two are simultaneously block-diagonal".

Two steps carry the argument and neither is written.

- **Real skew normal form.** Every $\omega\in\Lambda^2\mathbb R^6$ is $g\,\big(\bigoplus_jc_jJ\big)\,g^{\mathsf T}$ for some $g\in SO(6)$, the $c_j$ real and possibly zero. This covers **every degeneracy the brief asks about**: rank $4$ is $c_3=0$, rank $2$ is $c_2=c_3=0$, rank $0$ is all three, and the computation in §1 is polynomial in the $c_j$ so it does not care. At $c_3=0$ both sides are $0$, since $\sigma(\omega)=c_1c_2\varepsilon_3$ meets $\omega$ only on the plane where $\omega$ vanishes.
- **Equivariance.** $\sigma(g\omega g^{\mathsf T})=g\,\sigma(\omega)\,g^{\mathsf T}$ and $\mathrm{Pf}(g\omega g^{\mathsf T})=\mathrm{Pf}(\omega)$ for $g\in SO(6)$, because $\wedge$ and $\star$ are $SO(6)$-equivariant. **This is the step that makes a one-frame computation a theorem**, and the block replaces it with the words "Take a normal frame".

**Non-uniqueness at a repeated $c_j$ is harmless**, and the block's silence about frame-independence is a presentation defect rather than a gap: the right side $-\mathrm{Pf}(\omega)\mathrm{Id}_6$ is defined without reference to a frame, so any normal frame gives the same conclusion. What would genuinely need care is a conclusion stated plane by plane, and the block does not state one.

**"Simultaneously block-diagonal" is derived.** It follows from the display for $\sigma(\omega)$ immediately above it, both forms being combinations of the same three $\varepsilon_j$. Bolding it as though it were the insight misdirects the reader towards the one clause that costs nothing.

## 3. The polarised form, derived independently

**Located.** The first extension box.

Write the Statement as a cubic identity between matrix-valued cubic maps. Using $\mathrm{Pf}(\omega)=\tfrac13\langle\sigma(\omega),\omega\rangle=\tfrac16\langle\beta(\omega,\omega),\omega\rangle$, which is [L187](../findings/diagonal-half.md)'s pairing identity and checks as $\sum_jc_j\prod_{k\ne j}c_k=3c_1c_2c_3$, the Statement is

$$3\,\omega\,\beta(\omega,\omega)=-\big\langle\beta(\omega,\omega),\omega\big\rangle\,\mathrm{Id}_6.$$

Both sides are homogeneous cubic maps of $\omega$, so they agree if and only if their symmetric trilinear polarisations agree.

- **Left.** $C(\omega)=\omega\beta(\omega,\omega)$ polarises to $\tilde C(\alpha,\eta,\zeta)=\tfrac13\big[\alpha\beta(\eta,\zeta)+\eta\beta(\alpha,\zeta)+\zeta\beta(\alpha,\eta)\big]$, symmetric because $\beta$ is, and $\tilde C(\omega,\omega,\omega)=C(\omega)$. Times $3$ this is the box's left side with coefficient $1$ on each term. **The box's three coefficients are right.**
- **Right.** $\langle\beta(\alpha,\eta),\zeta\rangle\,\mathrm{vol}=\alpha\wedge\eta\wedge\zeta$, which is **already totally symmetric**, so its own polarisation is itself and no symmetrised version is called for. **The box's unsymmetrised right side is right, and the box gives no reason for it.**

So the polarised identity is exactly

$$\alpha\,\beta(\eta,\zeta)+\eta\,\beta(\alpha,\zeta)+\zeta\,\beta(\alpha,\eta)=-\big\langle\beta(\alpha,\eta),\zeta\big\rangle\,\mathrm{Id}_6,$$

totally symmetric in the three arguments as claimed, and it returns the Statement at $\alpha=\eta=\zeta=\omega$ after dividing by $6$. **CONFIRMED, every coefficient.**

**Argued the opposite.** The one place a factor could hide is the passage $\mathrm{Pf}\mapsto\tfrac16\langle\beta(\omega,\omega),\omega\rangle$, since $\beta(\omega,\omega)=2\sigma(\omega)$ and $\langle\sigma(\omega),\omega\rangle=3\mathrm{Pf}$. Both are checked on the normal form above and agree.

## 4. The harmonicity box, every constant

**Located.** The second extension box.

Set $\alpha=\eta=\omega_i$ in §3. The first two left terms collide and give the $2$:

$$2\,\omega_i\,\beta(\omega_i,\zeta)+\zeta\,\beta(\omega_i,\omega_i)=-\big\langle\beta(\omega_i,\omega_i),\zeta\big\rangle\,\mathrm{Id}.$$

Multiply by $\lambda_i$ and sum. Since $\beta(\omega_i,\omega_i)=\star(\omega_i\wedge\omega_i)$ and $\star$ is linear,

$$\sum_i\lambda_i\,\beta(\omega_i,\omega_i)=\star\Big(\sum_i\lambda_i\,\omega_i\wedge\omega_i\Big)=\star\mathcal B,$$

with **no factor**, the box's identification being correct precisely because $\beta$ carries the $2$ that $\sigma$ divides out. So

$$2\sum_i\lambda_i\,\omega_i\,\beta(\omega_i,\zeta)+\zeta\,\star\!\mathcal B=-\big\langle\star\mathcal B,\zeta\big\rangle\,\mathrm{Id},$$

which is the box's sentence verbatim. At $\zeta\in\mathrm{span}(\omega_1,\omega_2,\omega_3)$, [L192](../findings/diagonal-half.md)'s harmonicity is $\langle\star\mathcal B,\zeta\rangle=0$, the right side vanishes, and the display follows. **CONFIRMED.**

**The trace of it is L192, which the box does not notice.** For skew $X,Y$ one has $\mathop{\mathrm{tr}}(XY)=-2\langle X,Y\rangle$, so tracing the identity above over $\mathbb R^6$ gives $\mathop{\mathrm{tr}}\big(2\sum_i\lambda_i\omega_i\beta(\omega_i,\zeta)\big)=-6\langle\star\mathcal B,\zeta\rangle+2\langle\star\mathcal B,\zeta\rangle$, that is

$$\mathop{\mathrm{tr}}\Big(\sum_i\lambda_i\,\omega_i\,\beta(\omega_i,\zeta)\Big)=-2\big\langle\star\mathcal B,\zeta\big\rangle .$$

**So the scalar meeting of the two Weyl conditions is the trace of the matrix one**, and the box's "the first place the two Weyl conditions meet as matrices rather than as scalars" is true only if "as matrices" means the traceless part. Both sides of the box's own display are traceless on the span, which is the same observation.

**And under FULL first Bianchi the box's conclusion strengthens from three $\zeta$ to fifteen.** With $\mathcal B=0$ the right side vanishes for every $\zeta\in\Lambda^2\mathbb R^6$, not only on the span, giving $\sum_i\lambda_i\,\omega_i\,\star(\omega_i\wedge\zeta)=0$ for all $\zeta$. By the trace identity above that matrix condition is **equivalent** to first Bianchi rather than weaker, so it is a restatement and not new leverage. **The box is right to restrict to the span**, since harmonicity alone is what L192 leaves, and a successor should know that dropping the restriction buys an equivalent condition rather than a stronger one.

## 5. L187 follows from L193, in five lines

**Located.** The paragraph after the Statement.

1. L193 gives $\omega\,\sigma(\omega)=-\mathrm{Pf}(\omega)\,\mathrm{Id}_6$, and transposing it gives $\sigma(\omega)\,\omega=-\mathrm{Pf}(\omega)\,\mathrm{Id}_6$ as well, both factors being skew.
2. Determinants: $\det\omega\cdot\det\sigma(\omega)=\mathrm{Pf}(\omega)^6$, and $\det\omega=\mathrm{Pf}(\omega)^2$, so $\mathrm{Pf}(\sigma(\omega))^2=\mathrm{Pf}(\omega)^4$.
3. The polynomials $\mathrm{Pf}\circ\sigma-\mathrm{Pf}^2$ and $\mathrm{Pf}\circ\sigma+\mathrm{Pf}^2$ have identically vanishing product, and the polynomial ring is a domain, so one of them vanishes identically. Evaluating at $\omega=\varepsilon_1+\varepsilon_2+\varepsilon_3$, where $\mathrm{Pf}=1$ and $\sigma(\omega)=\omega$, selects $\mathrm{Pf}(\sigma(\omega))=\mathrm{Pf}(\omega)^2$.
4. Apply L193 at $\sigma(\omega)$: $\sigma(\omega)\,\sigma(\sigma(\omega))=-\mathrm{Pf}(\omega)^2\,\mathrm{Id}_6$. Where $\mathrm{Pf}(\omega)\ne0$, step 1 gives $\sigma(\omega)^{-1}=-\omega/\mathrm{Pf}(\omega)$, so $\sigma(\sigma(\omega))=\mathrm{Pf}(\omega)\,\omega$.
5. Both sides are polynomial and agree on the dense set $\mathrm{Pf}\ne0$, hence everywhere.

**That is [L187](../findings/diagonal-half.md)'s $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$.** The block's "neither follows from the other by inspection" is therefore weaker than the truth in the direction that matters for recording L193 as new: **L193 is the stronger statement.**

**The converse I could not obtain, and there is a reason to expect it to fail.** L187 as the record types it lives on the pair-spectrum model $s\mapsto(s_2s_3,s_1s_3,s_1s_2)$, in which no matrix product occurs, so it cannot by itself produce a statement about $\omega\,\sigma(\omega)$ without an extra input of exactly the kind L193 supplies. **The honest sentence is that L193 implies L187 and not conversely**, which is a better reason to record it than the one the block gives.

## 6. "The only relation between a form's square and its adjugate" is false

**Located.** The last extension box.

The record already carries two, both in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean).

- **`StarWedgeIdentity`**, the record's $\star_V(J\wedge J)=2\epsilon_JJ$ for $J$ a compatible complex structure, which is exactly a relation between $\omega^2=-\mathrm{Id}$ and $\sigma(\omega)$. It runs [L184](../findings/diagonal-half.md)'s case 2 and the scalar sub-case, and the layer's own docstring records it as HYPOTHESIS-DEBT, with *"neither the constant, nor the base sign, nor the two-orbit fact behind $\epsilon_J$'s well-definedness has a computation on file"*.
- **`wedgeSelf_areaForm`** with **`areaForm_sq_of_orthonormal`**, which give $\sigma(\alpha)=0$ and $\alpha^2=-\Pi$ at every decomposable $\alpha=u\wedge v$: a relation between square and adjugate at that locus, proved rather than owed.

**And the repair is worth more than the defect. L193 PROVES the first of them.** For $J$ skew with $J^2=-\mathrm{Id}_6$, $\det J=\mathrm{Pf}(J)^2\ge0$ and $J$ orthogonal give $\mathrm{Pf}(J)=\pm1$, and $J^{-1}=-J$, so L193 reads

$$\sigma(J)=-\mathrm{Pf}(J)\,J^{-1}=\mathrm{Pf}(J)\,J,\qquad\text{that is}\qquad \star(J\wedge J)=2\,\mathrm{Pf}(J)\,J .$$

**This is the owed identity with $\epsilon_J=\mathrm{Pf}(J)$**, and it settles all three things the layer says have no computation on file: the constant is $2$, the base sign is $+$, and $\epsilon_J=\pm1$ is well defined because $\mathrm{Pf}(J)^2=\det J=1$. So L193 discharges a HYPOTHESIS-DEBT the record has been carrying, and the block's "recorded as a tool and closes nothing" understates it by one debt.

**The tightest true version of the box's sentence** is that L193 is the only identity the record carries for the matrix PRODUCT of a form with its adjugate. Even that has neighbours: [L187](../findings/diagonal-half.md)'s $\langle\sigma(\omega),\omega\rangle=3\mathrm{Pf}(\omega)$ relates a form to its adjugate at every $\omega$, and [L181](../findings/diagonal-half.md) ties Ricci to Bianchi on the coordinate-diagonal family as the diagonal and off-diagonal of $M^{\mathsf T}\Lambda M$. Neither is a square-to-adjugate relation, so neither refutes the narrow claim, but both belong in a sentence about where a proof tying the two conditions would start.

## 7. Lean: one vacuous theorem, and one misplaced obligation

**Located.** [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) and the row in [lean/INDEX.md](../lean/INDEX.md).

**`adjugate_law_plane` and `adjugate_law_agree` are faithful**, and the row is right that the agreement of the three planes is the load-bearing half. Each reduces to `ring` on `sigma s = (s₂s₃, s₁s₃, s₁s₂)` and `pf s = s₁s₂s₃`, which are [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean)'s definitions and match §1's normal-form computation.

**`adjugate_law_sign` is VACUOUS.** Its hypothesis is `hJ : c * c = -1` for `c : ℝ`, which no real satisfies, so the theorem holds for the empty hypothesis class and verifies nothing. Its docstring, *"the matrix form carries a minus that the spectral form does not, and it comes from the square of the area form"*, claims content the statement cannot have: the same hypothesis proves the OPPOSITE sign. Both are screened in §8. **What the docstring describes needs $J$ as a matrix with `J * J = -1`, which the layer already has** as `IsComplexStructure` in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), and the scalar surrogate is not a weakening of it but an empty statement.

**The row's second half conflates the statement with the proof.** The frame-free matrix form types today out of primitives the layer already builds:

```lean
def AdjugateLaw : Prop :=
  ∀ X : Matrix (Fin 6) (Fin 6) ℝ, IsSkew X →
    X * ((1/2 : ℝ) • star6 (wedgeSelf X)) = (-(pf6 X)) • (1 : Matrix (Fin 6) (Fin 6) ℝ)
```

which compiles against `HamiltonsCubic.SelfDualLayer` and `HamiltonsCubic.RealLayer` unchanged (§8). The layer has the precedent for exactly this: `StarWedgeIdentity` is an owed identity typed as a `Prop` so that consumers carry the dependence in their statements. **So "the frame-free matrix statement is NOT typed" is a choice, not an obstruction**, and the row's *"what it needs is named: a normal-form theorem"* names a route to a PROOF. It is not the only route, since the identity is a polynomial identity in the fifteen entries of a skew matrix and expands componentwise with no normal form anywhere. Whether Lean chews that expansion in reasonable time I did not test, and the row should say that rather than assert a mathematical necessity.

**The absence of a normal form in Mathlib I checked** and found nothing for the real skew block form, and no Pfaffian at all, so that half of the row stands.

## 8. Screens, reported as screens

Four machine actions, on objects I constructed for the purpose, none of them evidence for anything positive above.

1. **A numerical screen at machine precision** of $\omega\sigma(\omega)+\mathrm{Pf}(\omega)\mathrm{Id}$, of the polarised identity on random triples, of $\langle\sigma(\omega),\omega\rangle-3\mathrm{Pf}(\omega)$, of $\mathrm{Pf}(\sigma(\omega))-\mathrm{Pf}(\omega)^2$, of $\sigma(\sigma(\omega))-\mathrm{Pf}(\omega)\omega$ and of the total symmetry of $\langle\beta(\alpha,\eta),\zeta\rangle$, all built from the layer's own `levi6`, `wedge2` and `star6` normalisations. Every residue at $10^{-14}$ or below, and `star(e1234)[4,5] = 1.0` anchors the star.
2. **A numerical screen** of the harmonicity box and of the trace identity of §4 on random weighted triples. Both at machine zero.
3. **A numerical screen** of $\star(J\wedge J)=2\mathrm{Pf}(J)J$ at $J=\varepsilon_1+\varepsilon_2+\varepsilon_3$ and at a $\mathrm{Pf}=-1$ conjugate, exact.
4. **A Lean screen**, `lake env lean` on a scratch file importing [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean), compiling clean: `sign_hyp_absurd (c : ℝ) (hJ : c * c = -1) : False` by `nlinarith`, an `adjugate_law_sign_opposite` with `= pf s` in place of `= -pf s` proved from the same hypothesis, and the `AdjugateLaw` definition of §7.

## 9. What would falsify each claim, and what I did to look for it

| Claim | Falsifier | What I did |
|---|---|---|
| The Statement and its sign | A single $\omega$ with $\omega\sigma(\omega)\ne-\mathrm{Pf}(\omega)\mathrm{Id}$, or a star or Pfaffian normalisation in the layer under which the sign flips | Recomputed $\sigma$ on the normal form from `star6`'s $1/24$ and `pf6`'s $1/48$, counted the transpositions in $\star e^{1256}$ by hand, checked the identity is orientation-free, screened |
| Completeness of the normal-form proof | A degenerate $\omega$ the frame misses, or a conclusion depending on the choice of frame at a repeated $c_j$ | Ran rank $4$, rank $2$ and rank $0$ through §1 explicitly, and checked the right side is frame-free so non-uniqueness cannot bite |
| The polarised form | A coefficient other than $1,1,1$ on the left, or a right side needing symmetrisation | Polarised the cubic from scratch and independently of the box, and proved $\langle\beta(\alpha,\eta),\zeta\rangle\mathrm{vol}=\alpha\wedge\eta\wedge\zeta$ symmetric, screened on random triples |
| The harmonicity box | A factor other than $2$, or $\sum_i\lambda_i\beta(\omega_i,\omega_i)$ differing from $\star\mathcal B$ by a constant | Substituted and summed by hand, traced the identity to see whether the trace closes, screened |
| Independence from L187 | A derivation of L187 from L193 or the reverse | Found the first in five lines (§5) and failed to find the second, with a reason to expect it absent |
| "the only relation between square and adjugate" | Any other such relation in the record | Read [L181](../findings/diagonal-half.md), [L183](../findings/diagonal-half.md), [L184](../findings/diagonal-half.md), [conventions.md](../findings/conventions.md) and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), and found two, one of which L193 proves |
| The Lean row | A theorem in the file that is not what it says, or a frame-free statement that genuinely cannot be typed | Read the file, found the sign lemma's hypothesis unsatisfiable, and compiled the frame-free statement out of existing primitives |

## 10. Repairs, in the order they should be made

1. **`adjugate_law_sign` is deleted or restated over matrices.** Its hypothesis is unsatisfiable and its docstring claims content it does not have. `IsComplexStructure` in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) already supplies the honest form.
2. **The Lean row separates statement from proof.** The frame-free form is typable now out of `star6`, `wedgeSelf`, `pf6` and `IsSkew`, and a normal-form theorem is one route to proving it rather than a precondition for stating it.
3. **The independence sentence claims the asymmetry it has**: L193 implies L187 in five lines, and the converse is not available.
4. **The "only relation" sentence is narrowed**, and the block records that **L193 proves $\star_V(J\wedge J)=2\epsilon_JJ$ with $\epsilon_J=\mathrm{Pf}(J)$**, discharging [L184](../findings/diagonal-half.md)'s HYPOTHESIS-DEBT.
5. **The proof names its two steps**, the real skew normal form and the $SO(6)$-equivariance of $\sigma$ and $\mathrm{Pf}$, and drops the emphasis on "simultaneously block-diagonal", which is a consequence of the line above it.
6. **$\mathrm{Id}_6$ is read as $\mathrm{Id}_V$** wherever the ambient is $\mathbb R^n$ with $n>6$, one clause, the same one [L184](../findings/diagonal-half.md) carries for $\star_V$.
7. **The harmonicity box records its trace**, $\mathop{\mathrm{tr}}\big(\sum_i\lambda_i\omega_i\beta(\omega_i,\zeta)\big)=-2\langle\star\mathcal B,\zeta\rangle$, and that under full Bianchi the unrestricted matrix condition is equivalent to Bianchi rather than stronger.

**Verdict: CONFIRMED.** *The Statement, the sign, the polarised form and the harmonicity identity all hold as written, with every constant checked against the Lean layer's own normalisations. Four surrounding claims fail and all four are repairable in a sentence each, and the round's net gain is that L193 discharges the record's $\star_V(J\wedge J)=2\epsilon_JJ$ debt and contains L192's scalar identity as its trace.*
