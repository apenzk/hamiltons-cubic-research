# Reviewer 1003: does `isWeyl_toTensor` bridge the two layers, or only appear to?

*Cold brief: [BRIEF-g2-tensor-bridge.md](BRIEF-g2-tensor-bridge.md), no prior report read, no author's conclusion supplied. **No numerical work was done.** Every value below is exact and rational, derived by hand. The machine steps are `lake env lean` and `#print axioms` on one scratch file of 160 lines that I wrote for this round and then deleted: each reports what the kernel holds rather than computing a value, and the nine declarations in it cost under two minutes in total. Log: [agent_logs/r1003.log](../agent_logs/r1003.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | `toTensor R a b c d = ⟨R φ_ab, φ_cd⟩` is the record's $W_{abcd}$, factor included | **CONFIRMED** on the nose, neither twice nor half, and **no statement in the file depends on it** |
| 2 | `IsWeylOp` is inhabited by something with content | **CONFIRMED**, kernel-checked witness at every weight and a named one at $n=4$, **exhibited nowhere in the file** |
| 3 | `toTensor` loses information | **CONFIRMED**, kernel-checked non-injectivity witness, and **nothing in the file needs injectivity** |
| 4 | the five clauses match their sources, index order included | **CONFIRMED**, Bianchi term for term and definitionally, tracelessness by a double swap the proof supplies explicitly |
| 5 | linearity is genuinely needed | **REFUTED**, `RealLayer.IsWeyl` alone gives every clause, and `IsLinOp` is an artefact of the route |
| 6 | the reverse map and the transport of $\theta$ and local-maximality are what [I36](../plan.md) still owes | **CONFIRMED that all three are absent, CORRECTED on what I36 needs**: the reverse map is not among them, and the isometry is |

**Actionable summary.** Two repairs, no mathematical defect. Drop `IsLinOp` from [toTensor_antisym12](../lean/HamiltonsCubic/Results/TensorBridge.lean#L44), [toTensor_traceless](../lean/HamiltonsCubic/Results/TensorBridge.lean#L69) and [isWeyl_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L82), which then applies to [diagOp_isWeyl](../lean/HamiltonsCubic/Base/Families.lean#L249) directly, and rewrite the file's own headline claim at [TensorBridge.lean:20](../lean/HamiltonsCubic/Results/TensorBridge.lean#L20), which asserts a necessity that does not hold. Then add the isometry $\operatorname{normM2}(\operatorname{toTensor}R)=\operatorname{normSq}R$, which is ten lines from [sum_inner2_phi](../lean/HamiltonsCubic/Base/Families.lean#L127) and [normM2_quarter](../lean/HamiltonsCubic/Results/L94Statement.lean#L241) and is the only thing that makes [L94](../lean/HamiltonsCubic/Results/L94Statement.lean)'s conclusion a statement about the record's $\theta$ rather than about an unrelated normalisation.

## 0. Conventions, fixed once

- $\varphi_{ab}=E_{ba}-E_{ab}$, which is [conventions.md:89](../findings/conventions.md)'s fixed sign and is [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) verbatim.
- $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, the $\Lambda^2$ pairing with the $\tfrac12$ at the $\Lambda^2$ level and not at the operator level ([conventions.md:85](../findings/conventions.md)), which is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) verbatim. Under it $\lVert\varphi_{ab}\rVert^2=1$ at $a\ne b$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal ([conventions.md:88](../findings/conventions.md)).
- $R$ is a curvature operator on $\Lambda^2$, written in the layer's ambient type `Matrix ι ι ℝ → Matrix ι ι ℝ` as a bare function.
- $M$ is the matrix of $R$ in the basis $\{\varphi_{ab}\}_{a<b}$, so $M_{(ab),(cd)}=\langle R\varphi_{ab},\varphi_{cd}\rangle$.
- $W_{abcd}$ is the record's four-index component array, and $\lVert M\rVert_F^2=\sum_{a<b}\sum_{c<d}W_{abcd}^2$, which is [normM2](../lean/HamiltonsCubic/Results/L94Statement.lean#L89) verbatim.
- Indices are $0$-based, matching Lean. All sums over pairs are over ORDERED pairs unless a range says otherwise, which is the record's standing rule.

## Hypothesis inventory, as the declarations bind it

| declaration | binders | conclusion |
| --- | --- | --- |
| [toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L33) | none | `Tensor4 n`, at `a b c d` the value `inner2 (R (phi a b)) (phi c d)` |
| [neg_of_lin](../lean/HamiltonsCubic/Results/TensorBridge.lean#L39) | `IsLinOp R` | `R (-X) = -R X` |
| [toTensor_antisym12](../lean/HamiltonsCubic/Results/TensorBridge.lean#L44) | `IsLinOp R` | antisymmetry in the first pair |
| [toTensor_antisym34](../lean/HamiltonsCubic/Results/TensorBridge.lean#L51) | none | antisymmetry in the second pair |
| [toTensor_pairSym](../lean/HamiltonsCubic/Results/TensorBridge.lean#L58) | `RealLayer.IsWeyl R` | pair symmetry |
| [toTensor_bianchi](../lean/HamiltonsCubic/Results/TensorBridge.lean#L64) | `RealLayer.IsWeyl R` | the first Bianchi identity |
| [toTensor_traceless](../lean/HamiltonsCubic/Results/TensorBridge.lean#L69) | `IsLinOp R`, `RealLayer.IsWeyl R` | $\sum_a W_{abad}=0$ |
| [isWeyl_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L82) | `IsWeylOp R` | `L94Statement.IsWeyl (toTensor R)` |

**Kernel status, read rather than assumed.** `#print axioms` returns `[propext, Classical.choice, Quot.sound]` on [isWeyl_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L82), on [toTensor_antisym12](../lean/HamiltonsCubic/Results/TensorBridge.lean#L44) and on [toTensor_traceless](../lean/HamiltonsCubic/Results/TensorBridge.lean#L69), and on every one of the nine declarations I wrote for this round. No `sorry` and no `native_decide` anywhere on the chain, so the round is about the objects and not the manipulations, as the brief directs.

**One legibility hazard, not an error.** [TensorBridge.lean:28](../lean/HamiltonsCubic/Results/TensorBridge.lean#L28) opens both `HamiltonsCubic.RealLayer` and `HamiltonsCubic.L94Statement`, and each exports an `IsWeyl`. The four intermediate theorems write the bare `IsWeyl R`, which elaborates to the operator one because `R` is a function, and the headline theorem writes `HamiltonsCubic.L94Statement.IsWeyl` in full. The disambiguation is by argument type alone, so a reader checking a binder must resolve it by elaboration rather than by reading.

## 1. Is `toTensor` the record's component convention, factor included?

**Verdict: CONFIRMED**, and with a scope note that is the more interesting half.

**It is the record's $W_{abcd}$ exactly.** The record's curvature operator is a map on $\Lambda^2$ and its components are its matrix entries in the basis $\{\varphi_{ab}\}_{a<b}$, which [conventions.md:88](../findings/conventions.md) makes orthonormal under the half-trace pairing and under that pairing alone. An orthonormal basis makes the matrix entry the pairing $\langle R\varphi_{ab},\varphi_{cd}\rangle$, so $W_{abcd}=\langle R\varphi_{ab},\varphi_{cd}\rangle$ with no factor. That is [toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L33) on the nose.

**Under plain Frobenius it would be twice this**, because $\varphi^{\mathsf T}\varphi=E_{aa}+E_{bb}$ gives $\lVert\varphi_{ab}\rVert^2=2$ there, so the basis is $\sqrt2$ times too long and the entries of the operator in it are half what the pairing returns. The $\tfrac12$ in [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) is therefore the convention the record fixed, its own docstring saying so and [conventions.md:85](../findings/conventions.md) saying it again.

**The sign of $\varphi$ costs nothing here.** The record's $\varphi_{ab}=E_{ba}-E_{ab}$ is the negative of the usual $e_a\wedge e_b$ under $v\wedge w\mapsto vw^{\mathsf T}-wv^{\mathsf T}$, and `toTensor` carries $\varphi$ in both slots, so the two signs cancel and the array is the same under either choice. This is [conventions.md:89](../findings/conventions.md)'s own observation that every quantity the record consumes is even in $\varphi$, and it applies to this map verbatim.

**THE SCOPE NOTE, AND IT IS THE POINT.** *No statement in the file depends on the factor.* Replace [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) by $c\cdot\operatorname{inner2}$ at any $c\ne0$: the four clauses of [RealLayer.IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) are each an equation between two expressions of the same degree in `inner2`, so the hypothesis class is unchanged, and the five clauses of [L94Statement.IsWeyl](../lean/HamiltonsCubic/Results/L94Statement.lean#L71) are each homogeneous and linear in the array, so the conclusion is unchanged. **The bridge as it stands would hold under plain Frobenius, and would hold under any rescaling whatever**, so it is a correct theorem that tests nothing about the normalisation. The factor becomes load-bearing at exactly the point the file stops, which is section 6.

## 2. Is `IsWeylOp` inhabited by anything with content?

**Verdict: CONFIRMED**, by a witness the file does not exhibit and that the tree already holds in two pieces.

**What the file leaves the reader.** [FoxProduct.lean:107](../lean/HamiltonsCubic/Base/FoxProduct.lean#L107)'s `isWeylOp_zero` is the only inhabitation statement in scope, and its own docstring says it *certifies nothing beyond non-vacuity*. Its tensor is identically zero, and the zero array satisfies all five clauses of [L94Statement.IsWeyl](../lean/HamiltonsCubic/Results/L94Statement.lean#L71) with no hypothesis, so read against that witness alone the bridge is a theorem about nothing.

**The candidate the brief names qualifies, and both halves are already proved.** [diagOp_isWeyl](../lean/HamiltonsCubic/Base/Families.lean#L249) gives `RealLayer.IsWeyl (diagOp w)` at every [IsWeight](../lean/HamiltonsCubic/Base/Families.lean#L153) `w`, and [isLinOp_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L285) gives `IsLinOp (diagOp w)` at every `w` with no hypothesis. Their conjunction is `IsWeylOp (diagOp w)` by the definition at [FoxProduct.lean:101](../lean/HamiltonsCubic/Base/FoxProduct.lean#L101). **No declaration in the tree writes that conjunction down**, so the composition was available and unmade.

**Its tensor, in closed form.** From [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean#L160) and [inner2_phi_phi](../lean/HamiltonsCubic/Base/Families.lean#L84),
$$\operatorname{toTensor}(\operatorname{diagOp}w)_{abcd}=w_{ab}\,(\delta_{ac}\delta_{bd}-\delta_{bc}\delta_{ad}),$$
so at $a\ne b$ the sectional entry is $W_{abab}=w_{ab}$ exactly. This is the array [r1002](REVIEW_r1002.md) machine-checked as a Weyl tensor from the tensor side, reached here from the operator side through the bridge, which is an independent arrival at the same object.

**A named nonzero member at $n=4$.** Take $S=\{0,1\}$ in `Fin 4`, so $p=q=2$ and [sphereWeight_isWeight](../lean/HamiltonsCubic/Base/Families.lean#L381) applies. Its cross-block entry is $-1$ by [sphereWeight_cross](../lean/HamiltonsCubic/Base/Families.lean#L322), so
$$\operatorname{toTensor}(\operatorname{diagOp}(\operatorname{sphereWeight}\{0,1\}))_{0202}=-1\ne0 .$$
I elaborated `IsWeylOp (diagOp (sphereWeight {0,1}))` together with that value in Lean, and `#print axioms` returns the standard three on it. **So the class carries the record's own $S^2\times S^2$ operator and the bridge sends it to a nonzero Weyl tensor**, which is content rather than non-vacuity.

**The general statement is stronger than the witness.** Every member of [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L394) is `diagOp` of a scaled `sphereWeight`, so the whole competitor family of [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean#L201) lies in the class and crosses the bridge, and [sphereWeight_normSq_pos](../lean/HamiltonsCubic/Base/Families.lean#L404) already says each has positive norm.

## 3. Does `toTensor` lose information?

**Verdict: CONFIRMED that it does, and nothing in the file needs otherwise.**

**It is not injective on `IsWeylOp`, and the reason is the ambient type.** [CurvOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L84) is `Matrix ι ι ℝ → Matrix ι ι ℝ` as bare functions, so its members are defined on ALL matrices while every clause of [RealLayer.IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) quantifies over SKEW arguments and `toTensor` evaluates only at $\varphi$'s. **A linear map that kills every bivector is therefore invisible to the hypotheses and to the map alike.** Concretely, for $R$ in the class put
$$R'(X)=R(X)+X+X^{\mathsf T},$$
which is linear, agrees with $R$ at every skew $X$ because $X+X^{\mathsf T}=0$ there, and differs from $R$ at $E_{00}$, where $R'(E_{00})-R(E_{00})=2E_{00}$. I elaborated `IsWeylOp R' `, `toTensor R' = toTensor R` and `R' ≠ R` in Lean, all three on the standard three axioms. **So the fibre of `toTensor` over any array in the image is infinite.**

**What it does determine is exactly the operator on $\Lambda^2$.** For $R$ in the class, $R\varphi_{ab}$ is skew by the first clause, and [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79) reconstructs a skew matrix from its $\varphi$ pairings, so the row $\operatorname{toTensor}R_{ab\cdot\cdot}$ determines $R\varphi_{ab}$ as a matrix. Linearity and the fact that the $\varphi$'s span the skew matrices then determine $R$ on all of $\Lambda^2$. **`toTensor` is injective on the restriction to $\Lambda^2$ and on nothing more**, and the kernel of the difference is precisely the linear maps vanishing on $\Lambda^2$.

**Nothing in the file needs injectivity.** All five clauses are forward implications from $R$ to its array, and [isWeyl_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L82) is the forward direction alone. The loss is priced only when a fact is carried BACK across the bridge, which is section 6.

**And it is a defect of the representation the tree has already diagnosed.** [WeylModule.lean:26](../lean/HamiltonsCubic/Base/WeylModule.lean#L26) says it in its own words, that `CurvOp` is infinite-dimensional because its domain is infinite and that `IsLinOp` as a side predicate cannot be repaired by any amount of work about $\mathcal W_n$, and it supplies [CurvLin](../lean/HamiltonsCubic/Base/WeylModule.lean#L71) and [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean#L91) as the bundled alternative. The file under review uses neither.

## 4. The five clauses, each against its source

**Verdict: CONFIRMED on all five.** Three need no permutation, one needs a double swap and gets it explicitly, and the claim the brief singles out is true in the strongest available sense.

**`antisym34` is the cheapest and carries no hypothesis at all**, correctly: [phi_swap](../lean/HamiltonsCubic/Base/WeylReal.lean#L51) moves the sign out of the second slot, where `inner2` is linear on the nose.

**`pairSym` IS the self-adjointness clause, with no index work.** [RealLayer.IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s second clause at $(\varphi_{ab},\varphi_{cd})$ reads $\langle R\varphi_{ab},\varphi_{cd}\rangle=\langle\varphi_{ab},R\varphi_{cd}\rangle$, and [inner2_comm](../lean/HamiltonsCubic/Base/WeylReal.lean#L218) turns the right side into $\langle R\varphi_{cd},\varphi_{ab}\rangle$. That is $W_{abcd}=W_{cdab}$ with the index order untouched. The two skewness side conditions are discharged by [phi_isSkew](../lean/HamiltonsCubic/Base/WeylReal.lean#L47), and they are the clause's own binders rather than an extra hypothesis.

**BIANCHI IS TERM FOR TERM, AND DEFINITIONALLY SO.** [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) at $(i,j,k,l)$ is
$$\langle R\varphi_{ij},\varphi_{kl}\rangle+\langle R\varphi_{ik},\varphi_{lj}\rangle+\langle R\varphi_{il},\varphi_{jk}\rangle,$$
and [L94Statement.IsWeyl](../lean/HamiltonsCubic/Results/L94Statement.lean#L71)'s clause at $(a,b,c,d)$ is $W_{abcd}+W_{acdb}+W_{adbc}$. Substituting $(i,j,k,l)=(a,b,c,d)$ gives $\langle R\varphi_{ab},\varphi_{cd}\rangle$, $\langle R\varphi_{ac},\varphi_{db}\rangle$ and $\langle R\varphi_{ad},\varphi_{bc}\rangle$, which are $W_{abcd}$, $W_{acdb}$ and $W_{adbc}$ in that order. **The match is not up to a permutation, it is literal**, and the file's proof is the bare term `hW.2.2.1 a b c d` with no tactic, so the kernel accepts it by unfolding alone. That is the strongest possible confirmation of the file's own headline claim at [TensorBridge.lean:16](../lean/HamiltonsCubic/Results/TensorBridge.lean#L16).

**TRACELESSNESS NEEDS A PERMUTATION, AND THE PROOF SUPPLIES IT IN THE OPEN.** [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) contracts the SECOND index of each $\varphi$, $\operatorname{Ric}(R)_{bd}=\sum_c\langle R\varphi_{bc},\varphi_{dc}\rangle$, while the tensor layer contracts the FIRST and THIRD slots, $\sum_aW_{abad}$. The two differ by swapping both pairs, and the file's `hstep` at [TensorBridge.lean:71](../lean/HamiltonsCubic/Results/TensorBridge.lean#L71) is exactly that swap, written as its own `have` with the two [phi_swap](../lean/HamiltonsCubic/Base/WeylReal.lean#L51) rewrites named. The two sign changes cancel, which is why the identity holds rather than the negative of it. **So the answer to the brief's question is that one clause does need a permutation and none of it is silent.**

**`antisym12` is where the file's stated hypothesis sits**, and section 5 is about it.

## 5. Is linearity genuinely needed?

**Verdict: REFUTED.** The file's claim at [TensorBridge.lean:20](../lean/HamiltonsCubic/Results/TensorBridge.lean#L20), that linearity *is what the operator layer's `IsWeyl` does not carry and this needs*, asserts a necessity that fails. **[RealLayer.IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) alone gives every clause of the bridge.**

**Located exactly.** The hypothesis enters at one place only, [neg_of_lin](../lean/HamiltonsCubic/Results/TensorBridge.lean#L39), which instantiates homogeneity at $c=-1$ to get $R(-X)=-RX$. That oddness is used twice, at [toTensor_antisym12](../lean/HamiltonsCubic/Results/TensorBridge.lean#L44) and inside `hstep` at [toTensor_traceless](../lean/HamiltonsCubic/Results/TensorBridge.lean#L69). Additivity is never used, and homogeneity is never used at any other scalar.

**The derivation, and it is four lines.** Fix $a,b$ and put $Z=R\varphi_{ba}+R\varphi_{ab}$.

1. $Z$ is skew, since [RealLayer.IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s first clause makes each summand skew and skewness is closed under addition.
2. The second clause is therefore applicable at $Z$ in the right slot, giving $\langle R\varphi_{ba},Z\rangle=\langle\varphi_{ba},RZ\rangle$ and $\langle R\varphi_{ab},Z\rangle=\langle\varphi_{ab},RZ\rangle$.
3. Adding them and using $\varphi_{ba}+\varphi_{ab}=0$ from [phi_swap](../lean/HamiltonsCubic/Base/WeylReal.lean#L51) gives $\langle Z,Z\rangle=\langle\varphi_{ba}+\varphi_{ab},RZ\rangle=\langle0,RZ\rangle=0$.
4. $\langle Z,Z\rangle=\tfrac12\sum_{a,b}Z_{ab}^2$ by [inner2_eq_sum](../lean/HamiltonsCubic/Base/WeylReal.lean#L58), a sum of squares over $\mathbb R$, so $Z=0$ and $R\varphi_{ba}=-R\varphi_{ab}$.

**That is the whole of what the two clauses wanted.** `antisym12` follows by substituting it into the first slot, and `hstep` follows by substituting it into the first slot and [phi_swap](../lean/HamiltonsCubic/Base/WeylReal.lean#L51) into the second, the two signs cancelling as before. **Self-adjointness on bivectors plus skew-valuedness delivers oddness ON THE $\varphi$'s, which is the only place the bridge ever evaluates $R$.**

**Screened in the kernel before being written down.** I elaborated the three statements `Rphi_swap`, `antisym12_of_isWeyl` and `traceless_of_isWeyl` over `RealLayer.IsWeyl` alone, and `#print axioms` returns `[propext, Classical.choice, Quot.sound]` on each.

**The opposite reading, argued and rejected.** Read as a remark about the ROUTE the file takes, the sentence is true: `phi_swap` moves $\varphi_{ab}$ to $-\varphi_{ba}$ inside $R$'s argument, and getting the sign back out of $R$ does need oddness. But the sentence as written says `IsWeyl` does not carry what the bridge NEEDS, and the derivation above needs nothing `IsWeyl` lacks. **A weaker hypothesis suffices and the weaker hypothesis is one the layer already has.**

**What the correction buys, beyond tidiness.** [diagOp_isWeyl](../lean/HamiltonsCubic/Base/Families.lean#L249) hands out `RealLayer.IsWeyl` and not `IsWeylOp`, so as stated the bridge cannot consume the record's own diagonal-locus family without the extra step of section 2. Dropped, it consumes them directly, and the file no longer needs [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) in its import list at all.

**What the correction does not buy.** `IsLinOp` is satisfied by everything the programme studies, so the theorem as stated is true and applies to every object of interest. This is a hypothesis to drop, not a gap.

## 6. What this does not give I36

**Verdict on the file's own list: CONFIRMED that the reverse map, the transport of $\theta$ and the transport of local-maximality are all absent.** I grepped the tree for any declaration sending `Tensor4` to an operator and there is none, and [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) mentions neither `theta` nor `normSq` nor any local-maximality predicate.

**Verdict on what I36 needs: CORRECTED.** The reverse map is not on the critical path, and the item the list omits is.

**The shape claim is [I36_shape](../lean/HamiltonsCubic/Results/L174.lean#L49), quantified over $W$ unit, locally maximal, with $t<\theta(W)$, concluding that some frame makes $W$ coordinate-diagonal.** Take each piece at the operator layer in turn.

- **Coordinate-diagonality is statable NOW, through the forward map alone.** `∃ F, IsFrame F ∧ CoordinateDiagonal (rotate F (toTensor R))` is well-typed the moment [isWeyl_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L82) exists, since [rotate](../lean/HamiltonsCubic/Results/L94Statement.lean) and [CoordinateDiagonal](../lean/HamiltonsCubic/Results/L94Statement.lean#L94) are functions of the array. **No reverse map is wanted for this**, and it is the half the plan's entry says the bridge buys.
- **$\theta$ is already defined at the operator layer**, as [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180), so the threshold hypothesis $t<\theta(R)$ needs nothing new.
- **Local maximality already ELABORATES at the operator layer**, and [L9Statement.lean:171](../lean/HamiltonsCubic/Results/L9Statement.lean#L171) writes it: `IsLocalMaxOn Pcubic {R | IsWeyl R ∧ normSq R = 1} W` on the bare function type. **But the topology it gets is the wrong one.** The ambient type is a function space over an infinite domain, carrying the product topology, in which a neighbourhood constrains only finitely many arguments. A coarser topology gives a coarser neighbourhood filter, so `IsLocalMaxOn` there is a STRICTLY STRONGER hypothesis than the record's local maximality on $\mathcal W_n$, and a theorem stated with it is correspondingly weaker. *This is section 3's defect wearing a second hat: the type is too big, in the same direction and for the same reason.*

**THE ITEM THE LIST OMITS, AND IT IS THE ONE THE FACTOR OF SECTION 1 IS FOR.** The bridge is an ISOMETRY and does not say so:
$$\operatorname{normSq}R=\operatorname{normM2}(\operatorname{toTensor}R).$$
Derivation, in the layer's own lemmas. [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135) gives $\operatorname{normSq}R=\tfrac12\sum_{i,j}\langle R\varphi_{ij},R\varphi_{ij}\rangle$. Each $R\varphi_{ij}$ is skew, so [sum_inner2_phi](../lean/HamiltonsCubic/Base/Families.lean#L127) applied at $v=u=R\varphi_{ij}$ gives $\langle R\varphi_{ij},R\varphi_{ij}\rangle=\tfrac12\sum_{k,l}\langle R\varphi_{ij},\varphi_{kl}\rangle^2$, the right side being $\tfrac12\sum_{k,l}(\operatorname{toTensor}R)_{ijkl}^2$. Hence $\operatorname{normSq}R=\tfrac14\operatorname{full4}(\operatorname{toTensor}R)$, and [normM2_quarter](../lean/HamiltonsCubic/Results/L94Statement.lean#L241) says $4\operatorname{normM2}=\operatorname{full4}$ under the two antisymmetries, which the bridge itself supplies.

**Why it is load-bearing rather than decorative.** [L94](../lean/HamiltonsCubic/Results/L94Statement.lean#L535)'s conclusion is read at `normM2 W = 1`, and the record's $\theta$ is read at `normSq R = 1`. Without the identity those are two unrelated unit spheres, and **it is here, and only here, that section 1's factor decides truth**: under plain Frobenius the identity would read $\operatorname{normSq}R=4\operatorname{normM2}(\operatorname{toTensor}R)$ and the unit spheres would differ by a factor $2$ in every $\theta$, which is precisely [conventions.md:85](../findings/conventions.md)'s recorded trap. *So the bridge is correct on a convention whose correctness it cannot yet exhibit, and the isometry is the statement that would exhibit it.*

**What would have to exist before I36's shape claim could be STATED in Lean, in full.**

1. The isometry above, ten lines from [sum_inner2_phi](../lean/HamiltonsCubic/Base/Families.lean#L127) and [normM2_quarter](../lean/HamiltonsCubic/Results/L94Statement.lean#L241), both already proved.
2. A home for $R$ in which local maximality means the record's, which is [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean#L91) over [CurvLin](../lean/HamiltonsCubic/Base/WeylModule.lean#L71), already built and finite-dimensional, with the forward map restated there.

**Neither needs the reverse map**, and with both the statement is assembled from declarations that exist. *What the reverse map would buy is different and worth naming separately: it is what would let a conclusion about arrays be read back as a fact about operators, which is what a PROOF of I36 through the tensor layer would need. Section 3 fixes its shape in advance, since `toTensor` is injective only on the restriction to $\Lambda^2$, so any reverse map lands in operators on $\Lambda^2$ and a round trip is the identity only there.*

## Overall verdict

**PROVEN (hypotheses corrected).**

The map is the record's map, the class it is stated over carries the record's own $S^p\times S^q$ family, the four-index conventions agree slot by slot, and Bianchi matches definitionally. The stated hypothesis `IsLinOp` is superfluous and the file's headline sentence about it is false as written. The forward half is sound and is less than the plan's entry suggests is still owed on one point and more on another: the reverse map is not what I36's statement needs, and the isometry, which nothing has written down, is.
