# Reviewer 796, Gate 2 on the Lean base layer: can these definitions be broken?

**Review number: r796.** Target: [lean/HamiltonsCubic/Base/](../lean/HamiltonsCubic/Base/), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean), read against [conventions.md](../findings/conventions.md) and [README.md](../README.md). Brief: break the definitions, or establish that they hold.

**Analysis only.** Everything below is derivation. Two Lean screens were run on objects built for the purpose and are labelled as screens where they appear; neither is offered as evidence for a positive mathematical claim, only as a machine check on a claim already derived by hand. No search, sweep, census or optimisation was opened.

## Verdict table

| claim | verdict | correction owed |
| --- | --- | --- |
| 1. [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) is $\mathcal W_n$ | **CONFIRMED**, no clause is missing, and the one the layer records as owed is derivable | none; three docstrings overstate the gap (§2.3) |
| 2. [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153) is $R^\#$, [Qop](../lean/HamiltonsCubic/Base/WeylReal.lean#L189) is $Q$ | **CONFIRMED**, the $-\tfrac14$ over ordered pairs is the record's normalisation (§3) | the anchor should be stated in Lean; §3.3 supplies the arithmetic |
| 3. [Pcubic](../lean/HamiltonsCubic/Base/WeylReal.lean#L170) is $P$, [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180) is $\theta$ | **CONFIRMED**, and independently anchored at $\theta_0(12)$ (§4.2) | none |
| 4. [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean#L201) and [ProblemPNamed](../lean/HamiltonsCubic/Base/Families.lean#L440) state Problem P | **CONFIRMED**, with a scope note | say that the competitor is the **two**-factor family (§5.1) |
| 5. [WCP2](../lean/HamiltonsCubic/Base/Families.lean#L795), [theta0Sq](../lean/HamiltonsCubic/Base/Families.lean#L465), [ThetaSq](../lean/HamiltonsCubic/Base/Families.lean#L473) | **CONFIRMED** | one gloss: $\Theta_n$ is the **diagonal** maximum (§5.2) |
| 5b. [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L394) is the record's family | **REFUTED** | its $t\ne0$ admits the sign-reversed family, which is no sphere product (§5.3) |
| 6. [Alt](../lean/HamiltonsCubic/Base/AltPart.lean#L311) carries the $\tfrac13$, [defectSq](../lean/HamiltonsCubic/Base/AltPart.lean#L719) is $\delta^2$ | **CONFIRMED**, and the $\tfrac13$ is genuinely pinned (§6) | none |
| 7. [br_phi_phi](../lean/HamiltonsCubic/Base/StructureConstants.lean#L41) is the $\mathfrak{so}(n)$ bracket | **CONFIRMED as an identity, REFUTED as the record's display** | the layer's $\varphi$ is $-1$ times the record's (§7) |

**Lead item.** The failure mode that broke `IsWeyl` earlier today, a definition constraining $R$ only through skew pairings while the norm and the cubic form see it in full, **cannot recur here, and the reason is a lemma the layer does not know it has**: the first two clauses of `IsWeyl` *force* $R$ to be linear on $\Lambda^2$, and $\Lambda^2$ is the only place `Pcubic`, `normSq`, `theta` and `Qop` ever evaluate it. §2 gives the derivation; §2.3 lists the three files that carry the linearity gap as an open debt against statements it does not threaten.

## 1. What the seven definitions have to match

The record's objects, quoted rather than restated. From [conventions.md](../findings/conventions.md): $Q(W)=W^2+W^\#$; $P(W)=\langle W,Q(W)\rangle$; $\theta=P/\lVert W\rVert^3$; $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix; $\lVert\varphi_{ab}\rVert^2=1$; every $\#$ formula checked at $\mathrm{id}^\#=(n-2)\,\mathrm{id}$; $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$; $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$; $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$; $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$; $\theta_0(n)^2=2(n-1)(n-2)/n^2$; $\Theta_n$ the diagonal maximum. From [README.md](../README.md): maximise $P$ on the unit sphere of $\mathcal W_n$, $n\ge12$.

## 2. Claim 1, `IsWeyl`, and the clause that is not missing

### 2.1 The set-up

[IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) is four clauses: **(a)** $X$ skew $\Rightarrow RX$ skew; **(b)** $\langle RX,Y\rangle=\langle X,RY\rangle$ at skew $X,Y$; **(c)** [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) vanishes at every four indices; **(d)** [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) vanishes. The record's $\mathcal W_n$ is a **linear subspace** of $\mathrm{End}(\Lambda^2)$, and linearity is absent from the four. [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) supplies it separately as [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L97); [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) both record the absence as a live gap. So the obvious attack is a nonlinear $R$ meeting all four clauses, at unit norm, with `Pcubic` unbounded, exactly the shape of the object that made `ProblemP` a false proposition before the skew clause was added.

### 2.2 The attack fails, and it fails for a reason

**Clauses (a) and (b) determine $R$ on $\Lambda^2$ by an explicitly linear formula.** For skew $X$, clause (a) gives $RX$ skew, so [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79) applies to it:

$$RX=\tfrac12\sum_{i,j}\langle RX,\varphi_{ij}\rangle\,\varphi_{ij}=\tfrac12\sum_{i,j}\langle X,R\varphi_{ij}\rangle\,\varphi_{ij},$$

the second equality being clause (b) at $Y=\varphi_{ij}$. The right-hand side is linear in $X$ with no hypothesis at all, so $R$ restricted to the skew matrices is additive and $\mathbb R$-homogeneous.

**And $\Lambda^2$ is the only place the layer's quantities look.** [normSq](../lean/HamiltonsCubic/Base/WeylReal.lean#L173) and [trCube](../lean/HamiltonsCubic/Base/WeylReal.lean#L142) evaluate $R$ at $\varphi_{ij}$ and at $R\varphi_{ij}$, both skew by (a). [sharpPair](../lean/HamiltonsCubic/Base/WeylReal.lean#L167) reaches $R$ only through `sharpOp R (phi i j)`, whose `sharpBil` arguments are $\varphi_{ij}$ and $\varphi_{ij}+\varphi_{kl}$ (skew) and `sharpQF` then feeds $R$ the matrices $\varphi_{ab}$ and $[\eta,R\varphi_{ab}]$, skew because $[\mathfrak{so}(n),\mathfrak{so}(n)]\subseteq\mathfrak{so}(n)$. [Qop](../lean/HamiltonsCubic/Base/WeylReal.lean#L189) and [IsCritical](../lean/HamiltonsCubic/Base/WeylReal.lean#L194) are stated at $\varphi_{ij}$ outright. **So `Pcubic`, `normSq`, `theta` and `Qop` depend on $R$ only through $R|_{\Lambda^2}$, where `IsWeyl` is exactly the record's four conditions on a linear self-adjoint operator.**

**Screen.** The two derivations above were transcribed and checked in Lean against the existing `.olean` cache, using only [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79), [inner2_comm](../lean/HamiltonsCubic/Base/WeylReal.lean#L218) and [inner2_add_right](../lean/HamiltonsCubic/Base/WeylReal.lean#L223): `IsWeyl R → IsSkew X → IsSkew Y → R (X + Y) = R X + R Y`, and the same for `R (c • X) = c • R X`, both compile with no error and no `sorry`. Kernel-checked, no `native_decide`. Reported as a screen on a claim derived by hand above.

**Nothing else is missing.** The remaining candidates and why each is closed: the pair symmetry $R_{ij,kl}=R_{kl,ij}$ is clause (b); antisymmetry in each pair is automatic, $\varphi_{ji}=-\varphi_{ij}$ and $R$ now linear; first Bianchi is (c); Ricci-flatness is (d), and $\operatorname{scal}=0$ follows from it. At $n=4$ the count closes exactly: $\dim\mathrm{Sym}(\Lambda^2\mathbb R^4)=21$, minus $10$ Ricci conditions and the single four-subset Bianchi condition, is $10=\dim\mathcal W_4$. **No clause admits an object the record's does not.**

### 2.3 The correction this produces

Three docstrings carry the linearity gap as a debt against statements it cannot reach, and should be narrowed to say that the debt is real only off $\Lambda^2$, which nothing reads:

- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s closing note (*"what is owed … `sharpBil R X` linear in its second slot, hence `R` linear"*), is discharged for every `IsWeyl R`.
- [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s *"`IsWeyl` carries the three curvature conditions and **not** linearity"* is true of the predicate and false of its consequences; `IsWeylOp` is `IsWeyl` on the arguments any of its own statements evaluate.
- [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s *"homogeneity of $\theta$ itself is not typed here and is not needed, since `Pcubic` is homogeneous only for linear `R`"* rests on the same over-reading; `Pcubic` **is** homogeneous on `IsWeyl`.

## 3. Claim 2, `sharpOp` is $R^\#$, and the $-\tfrac14$ is the record's

### 3.1 The normalisation question, stated exactly

[sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean#L102) is $-\tfrac14\sum_{i,j}\langle[\eta,R[\eta,R\varphi_{ij}]],\varphi_{ij}\rangle$ over **ordered** pairs. [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) carries $-\tfrac12$ over the six **unordered** basis bivectors of $\Lambda^2\mathbb R^4$ and discharges $\mathrm{id}^\#=(n-2)\,\mathrm{id}$ there by `native_decide`. The real layer states no anchor. [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean) now says so in its own docstring, having claimed otherwise earlier today.

### 3.2 The derivation

$\{\varphi_{ij}\}_{i<j}$ is orthonormal and $\varphi_{ii}=0$, so for any $T$ on $\Lambda^2$ the ordered sum is $\sum_{i,j}\langle T\varphi_{ij},\varphi_{ij}\rangle=2\operatorname{tr}T$. Hence `sharpQF R η` $=-\tfrac12\operatorname{tr}(\mathrm{ad}_\eta R\,\mathrm{ad}_\eta R)$, which is the record's own display. At $R=\mathrm{id}$ and $\eta=\varphi_{ab}$: [br_br_phi](../lean/HamiltonsCubic/Base/StructureConstants.lean#L78) gives $\mathrm{ad}_{\varphi_{ab}}^2=-1$ on each of $\varphi_{ad},\varphi_{bd}$ for $d\notin\{a,b\}$, and [br_phi_disjoint](../lean/HamiltonsCubic/Base/StructureConstants.lean#L66) kills everything else, so $\operatorname{tr}(\mathrm{ad}_{\varphi_{ab}}^2)=-2(n-2)$ and `sharpQF id φ_ab` $=n-2=(n-2)\lVert\varphi_{ab}\rVert^2$. **That is $\mathrm{id}^\#=(n-2)\,\mathrm{id}$, so the $-\tfrac14$ over ordered pairs is the record's normalisation and not a coincidence of shape.** It is also $2\times$ Sharp.lean's $-\tfrac12$ over unordered pairs, as that file's note asserts.

### 3.3 Screen, and what should be added to the layer

The real layer's `sharpQF` was transcribed verbatim to $\mathbb Q$ over [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean)'s primitives and evaluated at $R=\mathrm{id}$: the value is $2$ at $n=4$, $3$ at $n=5$, $4$ at $n=6$ on $\varphi_{01}$, and $4$ at $n=4$ and $6$ at $n=5$ on $\varphi_{01}+\varphi_{23}$, where $\lVert\eta\rVert^2=2$ makes the $\lVert\eta\rVert^2$ scaling visible. Five `native_decide` goals, all closing. **This is a screen and trusts the compiler rather than the kernel**; it is offered only as a machine check on §3.2, which stands on its own. The summation step §3.2 performs is the one [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean) records as still owed, and it is short: the two bracket lemmas it already proves plus $\sum_{i,j}=2\operatorname{tr}$.

### 3.4 `sharpOp` reassembles $R^\#$ exactly

With §2's linearity in hand, $\eta\mapsto$ `sharpQF R η` is a genuine quadratic form on $\Lambda^2$, so [sharpBil](../lean/HamiltonsCubic/Base/WeylReal.lean#L147) is its symmetric polarisation and equals $\langle R^\#X,Y\rangle$; [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153) then applies [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79)'s coefficients to it and returns $R^\#X$ on the nose. Self-adjointness of $R^\#$ is free, a polarisation being symmetric by construction. **Claim 2 is CONFIRMED for every `IsWeyl R`.**

## 4. Claim 3, `Pcubic` is $P$, `theta` is $\theta$

### 4.1 The pairing is the record's, at both levels

[inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) carries the $\tfrac12$ at the $\Lambda^2$ level; [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135)'s $\tfrac12$ pays only for the ordered-pair double count, so `innerOp R S` $=\sum_{i<j}\langle R\varphi_{ij},S\varphi_{ij}\rangle=\operatorname{tr}(R^{\mathsf T}S)$, plain Frobenius on the operator. That is [conventions.md](../findings/conventions.md)'s *"the $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level"* exactly. `Pcubic` $=\operatorname{tr}R^3+\langle R,R^\#\rangle=\langle R,Q(R)\rangle$ at self-adjoint $R$, and [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180) is $P/\lVert R\rVert^3$.

### 4.2 An anchor the layer does not claim, and it holds

The brief asks whether an alternative convention would pass each claimed check. It would pass some (§8), so here is one it would not, assembled from three of the layer's own definitions and one record value. Take $n=12$, $S$ of size $6$: [sphereWeight](../lean/HamiltonsCubic/Base/Families.lean#L291) gives $\alpha=6/5$ inside each block and $-1$ across. [diagOp_normSq](../lean/HamiltonsCubic/Base/Families.lean#L257) gives $\lVert W\rVert^2=\tfrac12(2\cdot30\cdot\tfrac{36}{25}+2\cdot36)=79.2$. [diagP](../lean/HamiltonsCubic/Base/Families.lean#L641) gives $\tfrac12(31.68+1710.72)=871.2$, the trace term counting $2\cdot120$ same-block triangles at $\alpha^3$ and $2\cdot540$ mixed ones at $\alpha$. Then $\theta=871.2/79.2^{3/2}=1.23604$, against $\theta_0(12)=\sqrt{55/36}=1.23604$. **The $\tfrac12$ in `inner2`, the ordered-pair doubling in `innerOp`, the sphere weight, the record's weighted-graph functional and $\theta_0(n)^2=2(n-1)(n-2)/n^2$ all close on one number.** Under plain Frobenius at the $\Lambda^2$ level they do not. Hand arithmetic, presented as derivation.

## 5. Claims 4 and 5, Problem P, the families, the constants

### 5.1 `ProblemP` against [README.md](../README.md)

[ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean#L201) reads: at $\lvert\iota\rvert\ge12$, for every `IsWeyl R` of unit norm there is a unit-norm sphere product $S$ with $P(R)\le P(S)$. That is *"$P$ restricted to $W$ of norm $1$ is maximised on the Weyl tensor of products of spheres when $n\ge12$"*, and by §2 the quantifier now ranges over exactly the record's unit sphere of $\mathcal W_n$. [exists_unit_sphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L425) supplies the competitor, so the existential is not satisfiable by an empty family.

**Scope note, not a defect.** [README.md](../README.md) says *products* of spheres and the record's [Lemma L48](../findings/problem.md) works with partitions $n=\sum_a n_a$ into $k\ge2$ factors, while [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L394) is the two-block family $S\sqcup S^{\mathsf c}$ alone. Narrowing the competitor set makes `ProblemP` **stronger**, and the record's own target constant $\Theta_n$ is defined by the two-block split, so the Lean statement is the record's claim. *Charitable reading, which is the one adopted:* the file says outright that it builds $S^p\times S^q$. Worth one clause in the docstring saying the restriction is deliberate and conservative.

### 5.2 The families and the constants

The two-block weight is right: [sphereWeight](../lean/HamiltonsCubic/Base/Families.lean#L291) is $pq$ times [diagonal-half.md](../findings/diagonal-half.md)'s $1/(p(p-1))$ inside and $-1/(pq)$ across, and the in-block values $q/(p-1)$, $p/(q-1)$ are forced by zero row sums once the cross entry is $-1$, as the file says. [thetaSplitSq](../lean/HamiltonsCubic/Base/Families.lean#L460) is Nienhaus's $\theta_{k,l}^2$; specialising $p=q=n/2$ returns [theta0Sq](../lean/HamiltonsCubic/Base/Families.lean#L465) and $p,q=\tfrac{n\mp1}2$ returns [ThetaSqOdd](../lean/HamiltonsCubic/Base/Families.lean#L469), both proved in file. $\Theta_4^2=3/4$ and $\Theta_6^2=10/9$ reproduce the record's $0.866$ and $1.0541$.

[WCP2](../lean/HamiltonsCubic/Base/Families.lean#L795) is the record's $aa^{\mathsf T}-\tfrac12(bb^{\mathsf T}+cc^{\mathsf T})$: $a,b,c$ are the self-dual triple for the standard orientation ($\star e_{01}=e_{23}$, $\star e_{02}=-e_{13}$, $\star e_{03}=e_{12}$), $\lVert a\rVert^2=2$ under the record's pairing turns the coefficients $1,-\tfrac12,-\tfrac12$ into eigenvalues $2,-1,-1$, and $\lVert W\rVert^2=6$ follows. Ricci-flatness runs through $vv^{\mathsf T}=I$ for each of the three, so the weights cancel, correct, and independent of $n=4$.

**One gloss to fix.** [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s header calls $\Theta_n$ *"the sphere-product maximum"*; [conventions.md](../findings/conventions.md) defines it as **the diagonal maximum**, and the same file's $M(n)$ row turns on the distinction. The two agree numerically on the record's own account, but the substitution of a gloss for a definition is the exact move that regrew [L0](../findings/problem.md)'s refuted constant, and that file records it as such. The closed form in Lean is right; only the sentence is loose.

### 5.3 `IsSphereProduct` admits objects the record's family does not

**Located.** [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L394) quantifies the scale as $t\ne0$; the file's own [SphereProductValue](../lean/HamiltonsCubic/Base/Families.lean#L622) quantifies it as $0<t$. **The two disagree about membership at every negative $t$.**

**Exhibited.** [diagOp_smul](../lean/HamiltonsCubic/Base/Families.lean) makes $\mathrm{diagOp}(t\cdot w)=t\cdot\mathrm{diagOp}(w)$ pointwise, and [Qop_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean) makes $Q(cR)=c^2Q(R)$, so `Pcubic` is $3$-homogeneous and $P(-W)=-P(W)$. Take $S$ of size $6$ inside $\iota=\mathrm{Fin}\,12$ and the $t<0$ that normalises: the operator is `IsWeyl`, has `normSq = 1`, satisfies `IsSphereProduct`, and carries $P=\theta=-1.23604$. **It is the negative of the balanced sphere product's Weyl tensor and is the Weyl tensor of no product of spheres.**

**Argued the other way.** `ProblemP`'s existential is unharmed (the $+t$ member is in the family too and dominates) so nothing proved about `ProblemPNamed` is wrong, and the record's *"$\theta$ is scale-invariant"* is the file's stated reason for the quantifier. **But that reason is false as written**: $\theta(cW)=\operatorname{sign}(c)\,\theta(W)$, scale-invariant under **positive** scaling only, and the docstring's *"the scale is the existential's, not a choice made here"* is what hides it. Any statement of the form *"every `IsSphereProduct` has $\theta=\theta_{p,q}$"* is false, and [SphereProductValue](../lean/HamiltonsCubic/Base/Families.lean#L622) shows the file already knows the right hypothesis.

**Correction.** Change $t\ne0$ to $0<t$ in [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L394); [exists_unit_sphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L425) already builds its witness with a positive scale, so nothing downstream moves. *Raised independently by [r797](REVIEW_r797.md) on the same brief; verified here from the homogeneity of `Pcubic` rather than from that report.*

## 6. Claim 6, `Alt` and $\delta^2$

[alt4](../lean/HamiltonsCubic/Base/AltPart.lean#L311) is $\tfrac13(T_{ijkl}+T_{iklj}+T_{iljk})$, the record's display verbatim, and [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean#L383) ties it to the layer's undivided `bianchi`. **The $\tfrac13$ is not a free choice here, and [alt4_idem](../lean/HamiltonsCubic/Base/AltPart.lean#L316) is what pins it**: writing the average as $c(T+T'+T'')$, the cyclic sum of a cyclic sum is $3\times$ the cyclic sum, so idempotence reads $3c^2=c$ and holds at $c=\tfrac13$ alone. With [alt4_selfAdjoint](../lean/HamiltonsCubic/Base/AltPart.lean#L333) that makes `alt4` an orthogonal projection, and on arrays with the curvature symmetries its image is $\Lambda^4$, the three-cycle on the last three slots is even, so a totally antisymmetric array is fixed. That is the record's *"orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$"*.

The norm is the record's too. [normSq_eq_fourNormSq_comp](../lean/HamiltonsCubic/Base/AltPart.lean#L281) **proves** $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$ rather than assuming it, and the identification of `comp` with the record's $R_{ijkl}$ is checkable against a record value: [star4_phi](../lean/HamiltonsCubic/Base/SelfDual.lean#L397) gives $\star\varphi_{01}=\varphi_{23}$, so `comp star4 0 1 2 3` $=1=\epsilon_{0123}$ with no factor and no sign, and [normSq_star4](../lean/HamiltonsCubic/Base/SelfDual.lean#L584) returns the record's $\lVert\star\rVert^2=6$. [defectSq](../lean/HamiltonsCubic/Base/AltPart.lean#L719) is `altNormSq` of [negPartOp](../lean/HamiltonsCubic/Base/AltPart.lean#L549), whose scalar is $(\lvert x\rvert-x)/2\ge0$, the record's sign for $W_-$, the one that makes $\mathrm{Alt}(u_-)=+a\star$ with $a>0$. **CONFIRMED.**

## 7. Claim 7, the bracket, and the sign the layer runs at

**The identity is right for the layer's own $\varphi$ and is the sign-reverse of the record's.** All three protocol tests clear.

**Located.** [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) is `single j i 1 - single i j 1`, that is $E_{ji}-E_{ij}$, and its docstring says so. [conventions.md](../findings/conventions.md), the bivector-norm bullet, writes $\varphi_{ab}=E_{ab}-E_{ba}$; [diagonal-half.md](../findings/diagonal-half.md) repeats it and adds *"the structure tensor is the single monomial $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$"*. **The two $\varphi$'s differ by a sign.**

**Exhibited.** At $[\varphi_{12},\varphi_{23}]$: the record reads $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1$, [isotropy-cap.md](../findings/isotropy-cap.md) and [LEDGER.md](../findings/LEDGER.md), where it carries the refutation of an isotropy claim, while [br_phi_phi](../lean/HamiltonsCubic/Base/StructureConstants.lean#L41) returns $-\varphi_{13}$ and the pairing $-1$. Likewise [br_phi_share](../lean/HamiltonsCubic/Base/StructureConstants.lean#L60) proves $[\varphi_{ab},\varphi_{bd}]=-\varphi_{ad}$ against the record's $+\varphi_{ad}$. Both are correct under their own $\varphi$; I re-derived each from $E_{ij}E_{kl}=\delta_{jk}E_{il}$.

**Argued the other way.** The divergence is a global basis sign $\varphi\mapsto-\varphi$, and **every quantity the layer computes is even in $\varphi$**, `inner2` of two $\varphi$'s, [comp](../lean/HamiltonsCubic/Base/AltPart.lean#L147), `bianchi`, `Ric`, `normSq`, `sharpQF` (the $\eta$ and the $\varphi_{ij}$ each appear twice), `sharpOp`, `Pcubic`, and $T_{abc}=c_{abc}^2$, which is what $\#$ actually consumes. **No number anywhere in the layer or the record changes.** The layer also declares its convention in the docstring rather than hiding it.

**Verdict.** The identity is CONFIRMED; the *display* is REFUTED as a quotation of the record, and this belongs in [conventions.md](../findings/conventions.md) rather than being fixed in Lean, the file whose stated purpose is that conventions are quoted and never restated currently holds one convention at two signs. Two ways to close it: flip [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) to $E_{ij}-E_{ji}$, which changes no proved value but touches [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean), [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) and the `curvature_operator.py` correspondence they cite; or add one line to [conventions.md](../findings/conventions.md) recording that the Lean layer runs at $\varphi_{ij}=E_{ji}-E_{ij}$ and that odd-degree displays therefore differ in sign. **The second is the cheap one and the one I recommend**, since the Lean sign is the one [curvature_operator.py](../scripts/lib/curvature_operator.py) already fixes.

## 8. Theorems that cannot fail

[Pcubic_eq_inner_Qop](../lean/HamiltonsCubic/Base/WeylReal.lean#L249) is the one the layer already names. Four more, with what each does and does not test:

| declaration | why it cannot fail | does it test anything? |
| --- | --- | --- |
| [Pcubic_eq](../lean/HamiltonsCubic/Base/WeylReal.lean#L209) | `rfl` | no, it restates the definition |
| [foxTri_self](../lean/HamiltonsCubic/Base/FoxProduct.lean#L294) | [foxProd_self](../lean/HamiltonsCubic/Base/FoxProduct.lean#L234) plus `Pcubic_eq_inner_Qop` | **partly**, it pins the $\tfrac12$ in $\circ$ against `Qop`, and is **blind to $\#\mapsto c\,\#$**, which rescales both sides alike. It is not the coherence check on $\#$ a reader may take it for, and its docstring's *"if the $\tfrac12$ in $\circ$ were anywhere else this would fail by a factor"* is right about the $\tfrac12$ and silent about $\#$ |
| [foxTri_comm](../lean/HamiltonsCubic/Base/FoxProduct.lean#L288) | `add_comm` inside `foxProd` | no; the file says so |
| [altNormSq_of_isWeyl](../lean/HamiltonsCubic/Base/AltPart.lean#L439), [altNormSq_eq_zero_iff](../lean/HamiltonsCubic/Base/AltPart.lean#L424) | `altCoeff` **is** $\tfrac13\cdot$`bianchi` and `IsWeyl` **contains** `bianchi = 0` | no, the record's *"$\mathrm{Alt}(H)=0$ for every $H$ satisfying first Bianchi"* is here a definitional unfolding, true whatever the constant. The $\tfrac13$ is checked instead by [alt4_idem](../lean/HamiltonsCubic/Base/AltPart.lean#L316), §6 |

Against them, the declarations that **could** fail and do not: [alt4_idem](../lean/HamiltonsCubic/Base/AltPart.lean#L316), [normSq_eq_fourNormSq_comp](../lean/HamiltonsCubic/Base/AltPart.lean#L281), [normSq_star4](../lean/HamiltonsCubic/Base/SelfDual.lean#L584), [inner2_complexStructure](../lean/HamiltonsCubic/Base/SelfDual.lean#L650) (the record's *"unit norm forces $c=\tfrac13$"*; plain Frobenius would give $6$ and $c=\tfrac16$), [WCP2_normSq](../lean/HamiltonsCubic/Base/Families.lean#L852), [sphereWeight_isWeight](../lean/HamiltonsCubic/Base/Families.lean#L381), [foxProd_idemOf_self](../lean/HamiltonsCubic/Base/FoxProduct.lean#L329).

## 9. One further discrepancy, minor and locatable

[IsCritical](../lean/HamiltonsCubic/Base/WeylReal.lean#L194)'s docstring reads *"`R` is a critical point of `P` on the unit sphere with multiplier `θ`"*, and the definition carries **no unit-norm clause**. Off the unit sphere the multiplier is $P/\lVert R\rVert^2$ and not the record's $\theta=P/\lVert R\rVert^3$. This is precisely the trap [conventions.md](../findings/conventions.md) tables, *"a criticality relation quoted without its normalisation reads as a $\theta$ value, and has been tabulated as one"*. **Argued the other way, and the argument mostly wins**: the definition itself is the right object, the eigen-relation, and every consumer checked carries the norm clause separately, [theta_of_critical_unit](../lean/HamiltonsCubic/Results/L74Statement.lean#L394), [L74Bridge](../lean/HamiltonsCubic/Results/L144Statement.lean#L399), [primitive_critical_not_in_band](../lean/HamiltonsCubic/Results/L144Statement.lean#L408). And [foxProd_idemOf_self](../lean/HamiltonsCubic/Base/FoxProduct.lean#L329) genuinely needs no norm clause, $e=W/\theta$ being normalised by $\theta$. **So: a docstring fix, not a definitional defect.** Add *"at unit norm"* as a stated hypothesis of the reading, or drop the phrase.

## 10. Withdrawn candidates

Recorded so the next reader does not re-spend the round.

- **A nonlinear `IsWeyl` operator on which `Pcubic` is unbounded.** Withdrawn: §2. Clauses (a) and (b) force linearity on $\Lambda^2$, and $\Lambda^2$ is all `Pcubic` sees.
- **`bianchi` quantified over all $i,j,k,l$ over-constrains at coincident indices.** Withdrawn: at $i=j$ the identity reduces to $\langle R\varphi_{ik},\varphi_{li}\rangle+\langle R\varphi_{il},\varphi_{ik}\rangle=0$, which clause (b) supplies, so no object is excluded. The $n=4$ dimension count confirms it.
- **`trCube` is $\operatorname{tr}(R^{\mathsf T}R^{\mathsf T}R)$, not $\operatorname{tr}R^3$.** Withdrawn: they agree at self-adjoint $R$, and `Pcubic` is the pairing $\langle R,Q(R)\rangle$ either way.
- **`theta` divides by zero at $R=0$.** Withdrawn: Lean returns $0$, and every statement that reads $\theta$ carries `normSq = 1`.
- **`IsSphereProduct`'s scale quantifier admits a non-competitor.** *Not withdrawn*, it is upheld at §5.3. The reading under which it looked harmless, that [IsSphereProduct.isWeyl](../lean/HamiltonsCubic/Base/Families.lean#L399) holds at every scale, answers a different question: Weyl-ness survives $t<0$ and sphere-product-hood does not.
- **`alt4`'s image is the $C_3$-invariants, not $\Lambda^4$.** Withdrawn: on arrays with the curvature symmetries, which [altCoeff_antisym_mid](../lean/HamiltonsCubic/Base/AltPart.lean#L389) and [altCoeff_antisym_first](../lean/HamiltonsCubic/Base/AltPart.lean#L400) establish, the two coincide.

## 11. The falsifier, and how I looked for it

**The object that would falsify the layer is a map $R:\mathrm{Matrix}\to\mathrm{Matrix}$ satisfying all four `IsWeyl` clauses with `normSq R = 1`, on which `Pcubic` takes a value the record's $\mathcal W_n$ does not admit**, the successor of the symmetric-valued operator at $n=5$ that made `ProblemP` false this morning. Two ways it could exist: a member of the Lean set that is not a member of the record's, or a $\#$ normalisation $c\ne1$ that leaves every stated check standing.

**How I looked.** For the first: I traced every argument at which `Pcubic`, `normSq`, `theta` and `Qop` evaluate $R$ (they are all skew) and then showed clauses (a) and (b) determine $R$ there by a formula linear on its face, screening both steps in Lean. There is no room left: `IsWeyl` seen through `Pcubic` **is** the record's $\mathcal W_n$. For the second: I evaluated `sharpQF` at $R=\mathrm{id}$ analytically, getting $(n-2)\lVert\eta\rVert^2$ from the two bracket lemmas the layer already proves, and screened it at $n=4,5,6$ and at a non-basis $\eta$; $c=1$. **No such object exists by either route, and both are closed.** *A third route does open, one step out from the falsifier as stated:* the competitor family, rather than the admissible set, is where a definition here admits what the record's does not, §5.3.

What remains genuinely open in the layer is what its own files say is open, [DiagCubicFormula](../lean/HamiltonsCubic/Base/Families.lean#L649), [SphereProductValue](../lean/HamiltonsCubic/Base/Families.lean#L622), [StarWedgeIdentity](../lean/HamiltonsCubic/Base/SelfDual.lean#L686), full symmetry of $T$, and $P(W_{\mathbb{CP}^2})=18$. None of them is a definition that admits the wrong objects; each is an evaluation not yet performed.
