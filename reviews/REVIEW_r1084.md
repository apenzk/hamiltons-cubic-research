# Review r1084, Lemma L233, the pair direction's second-order quotient

*Cold adversarial Gate 2 review of [Lemma L233](../findings/second-order.md) as committed in `d4cda4c9`. Every identity below was derived from the definitions in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) and [conventions.md](../findings/conventions.md) and screened against objects built from scratch. The author's screen was neither read nor run. Log: [r1084-L233.log](../agent_logs/r1084-L233.log).*

| # | claim | verdict |
|---|---|---|
| K1 | the boxed closed form at every `W` with `θ ≠ 0` and every distinct eigenpair | **CONFIRMED**, and true under strictly weaker hypotheses than stated |
| K2 | the anticommutator half is `¼(ε_α + ε_β)` | **CONFIRMED** |
| K3 | the `#` half is one trace per basis element, each `½(u·A_γ v)²` | **CONFIRMED**, antisymmetry really is the only hypothesis |
| K4 | the `#` content of the admissible direction is carried by the projection | **REFUTED as a general claim**, CONFIRMED on commuting pairs |
| K5 | `⟨W, Y₀⟩ = 0` automatically | **CONFIRMED**, the hypothesis it consumes is orthogonality, not distinct eigenvalues |
| K6 | non-vacuity from self-adjointness plus the orbit tangent's `½` | **CONFIRMED as an implication**, with a scope the headline does not carry |

## The `#` index contraction, derived here

With $\{\varphi_a\}$ orthonormal in $\Lambda^2$ under the record's $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ totally antisymmetric, the record's index formula $(X^{\#})_{ab}=\tfrac12\sum c_{acd}c_{bef}X_{ce}X_{df}$ polarises in the curvature slot to

$$\mathrm{sharpBil}(X,Y)_{ab}=\tfrac12\sum_{cdef}c_{acd}c_{bef}X_{ce}Y_{df},$$

the two polarisation terms being equal under $(c,d,e,f)\mapsto(d,c,f,e)$, which flips both $c$'s at sign $(-1)^2$. Contracting against a symmetric $Y$ and writing $(\mathrm{ad}_\psi)_{xy}=\langle[\psi,\varphi_y],\varphi_x\rangle$ gives

$$\langle Y,\mathrm{sharpBil}(E,Y)\rangle=\tfrac12\sum_\gamma\varepsilon_\gamma\operatorname{tr}\big((\mathrm{ad}_{\psi_\gamma})^{\mathsf T}Y\,\mathrm{ad}_{\psi_\gamma}Y\big)=-\tfrac12\sum_\gamma\varepsilon_\gamma\operatorname{tr}\big((\mathrm{ad}_{\psi_\gamma}Y)^2\big),$$

**which is the block's identity, sign and factor included.** The normalisation was checked against the anchor before use and against two further anchors the record fixes: $\mathrm{id}^{\#}=(n-2)\,\mathrm{id}$ holds **exactly** (machine zero at $n=4,5,6$), $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ holds to $10^{-14}$, and the derived form reproduces [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s own `sharpQF R η = -½ tr((ad_η R)²)` after the ordered-pair doubling is paid. *The anchor is what settles the $\tfrac12$: dropping it returns $2(n-2)\,\mathrm{id}$, the error [conventions.md](../findings/conventions.md) records as having entered twice.*

**The block's formula is basis-free, and saying so is stronger than what the block says.** Since $e=\sum_\gamma\varepsilon_\gamma\psi_\gamma\psi_\gamma^{\mathsf T}$,

$$\sum_\gamma\varepsilon_\gamma\big\langle\psi_\gamma,[u,v]\big\rangle^2=\big\langle[u,v],\,e\,[u,v]\big\rangle,$$

so the boxed right-hand side is $\tfrac12(\varepsilon_\alpha+\varepsilon_\beta)-\tfrac12\langle[u,v],e[u,v]\rangle$ and no basis appears in it at all. **The block's warning is still the right warning**: weighting the $\varphi$-basis components of $[u,v]$ by eigenvalues indexed in the eigenbasis is a type error, and screened here it returns $-33.18$ against the correct $550.06$. *What the block should say is that the sum is the quadratic form of $e$ at the commutator, which is invariant, rather than that it must be taken in one particular basis.*

## K1, confirmed, and its hypotheses are inert

Screened at $24$ eigenpairs over $4$ generic $W\in\mathcal W_6$ (dimension $84$, recovered as the nullspace of first Bianchi and Ricci): the direct $\langle Y_0,e\circ Y_0\rangle/\lVert Y_0\rVert^2$ agrees with the boxed form to $7\cdot10^{-14}$ and with the basis-free form to $3\cdot10^{-14}$, with $\lVert Y_0\rVert^2=\tfrac12$ exact at every pair. A sign-flipped variant is separated by $2.55$, so the check is able to fail.

**Four of the statement's hypotheses do no work.** The identity was screened at an arbitrary symmetric $e$ that is neither Weyl, nor critical, nor of unit norm, and held to $4\cdot10^{-15}$. Screened further at a pair $u,v$ that is orthonormal but **not** eigenvectors, the identity still held exactly in the form

$$\frac{\langle Y_0,\,e\circ Y_0\rangle}{\lVert Y_0\rVert^2}=\tfrac12\big(\langle u,eu\rangle+\langle v,ev\rangle\big)-\tfrac12\big\langle[u,v],e[u,v]\big\rangle .$$

*So the true statement is about any symmetric operator on $\Lambda^2$ and any orthonormal pair.* The eigen-hypothesis buys exactly two things: it names $\langle u,eu\rangle$ as $\varepsilon_\alpha$, and it is what makes K5 automatic. **Stating it over $W\in\mathcal W_n$ at $\theta\ne0$ hides which hypothesis carries the identity**, which is the fault the block's own Lean file is written to avoid.

## K2 and K3, confirmed, and the Lean says what the block says

`pairDir_sq`, `trace_mul_pairDir_sq` and `trace_pairDir_sq` carry $u\cdot u=1$, $v\cdot v=1$, $u\cdot v=0$ and nothing else, and `trace_sq_pair_direction` carries $A^{\mathsf T}=-A$ and nothing else. **Both fidelity claims hold as stated.** The trace identity was screened at $u,v$ neither unit nor orthogonal and agreed to $2\cdot10^{-14}$, so the absence of orthonormality there is real rather than an unused-hypothesis accident. `#print axioms` on all six declarations returns `[propext, Classical.choice, Quot.sound]`, with no `sorryAx` and no `Lean.ofReduceBool`.

Three small gaps between the Lean and the prose, none of them defects in the mathematics:

- **`trace_mul_pairDir_sq` proves $\operatorname{tr}(EY^2)$, not $\langle Y,\tfrac12(EY+YE)\rangle$.** The step between them needs symmetry of $Y$ and cyclicity, and is untyped. The same holds for reading `trace_pairDir_sq` as $\lVert Y\rVert^2$.
- **The bridge from $(u\cdot A_\gamma v)^2$ to $\langle\psi_\gamma,[u,v]\rangle^2$ is untyped.** It is ad-invariance, and it carries a sign: screened, $u\cdot(\mathrm{ad}_\psi v)=-\langle\psi,[u,v]\rangle$ to $10^{-15}$. *Squared, so the block's figure is unaffected.*
- **The Lean transfers to the record only in orthonormal coordinates**, because `dotProduct` is the Euclidean form and $A^{\mathsf T}$ the Euclidean adjoint. $\mathrm{ad}_\psi$ is antisymmetric on $\Lambda^2$ in the $\varphi$ basis, which is orthonormal under the record's $\tfrac12$-carrying inner product, so the hypothesis is met. It is met rather than free.

**One docstring is false.** [I73PairDirection.lean](../lean/HamiltonsCubic/Results/I73PairDirection.lean)'s header says the pair direction is built from eigenvectors *"lying in distinct eigenspaces"*, and the block's own worked example violates it: at $p=q$ the two coordinate planes carry the **same** eigenvalue, $\varepsilon_\pi=\varepsilon_\rho=\tfrac4{21}$, so $\varphi_\pi$ and $\varphi_\rho$ lie in one eigenspace. The record's statement says only $\alpha\ne\beta$, which is right. *The identity is insensitive to the degeneracy and was screened at it.*

## K4, the load-bearing clause, REFUTED as stated

**The first half is confirmed and is the good part of the lemma.** The $\#$ term is $-\tfrac12\langle[u,v],e[u,v]\rangle$, manifestly quadratic in the commutator, so it vanishes identically whenever $u$ and $v$ commute, and two disjoint coordinate planes commute.

**The second half does not follow and is false at the block's own configuration.** The block's *"What this settles"* records as settled *"the fact that the projection rather than the bracket carries the $\#$ term"*, with no restriction to commuting pairs. Taking the same $W$ the block uses, at $n=8$, and the eigenpair $u=\varphi_{01}$, $v=\varphi_{04}$, which **shares the index $0$**:

| pair | $\varepsilon_\alpha,\varepsilon_\beta$ | $\lVert[u,v]\rVert$ | unprojected `#` | unprojected total | projected total |
|---|---|---|---|---|---|
| $\varphi_{01},\varphi_{45}$, disjoint | $+\tfrac4{21},+\tfrac4{21}$ | $0$ | $0$ | $\tfrac4{21}$ | $\tfrac13$ |
| $\varphi_{01},\varphi_{04}$, shared index | $+\tfrac4{21},-\tfrac17$ | $1$ | $+0.0714286$ | $+0.0952381$ | $+0.1$ |
| $\varphi_{04},\varphi_{05}$, shared index | $-\tfrac17,-\tfrac17$ | $1$ | $-0.0952381$ | $-0.2380952$ | $-0.2666667$ |

Both shared-index rows are genuine orthonormal eigenvectors of the same $e$ (eigen-residual $0$ exactly, $\langle W,Y_0\rangle$ at machine zero), and both carry nonzero unprojected $\#$. **So the bracket carries $\#$ content at this very maximiser candidate**, and the correct scope is: *on a commuting eigenpair the unprojected direction carries no $\#$ content, and there the whole of it is the projection's.* At the disjoint pair that statement is sharp and worth having, the projected direction's $\#$ part being $0.253968$ of a total $\tfrac13$, which is $76\%$ of the quotient.

**A verdict stated for a family and tested on one member is a finding about what was tested, and that is what happened here.** The general clause should be struck or rewritten with the commuting hypothesis attached.

*Screened alongside: at generic $W\in\mathcal W_6$ the commutator of two eigenvectors is never zero, $\lVert[u,v]\rVert$ running $0.47$ to $1.07$ over $24$ pairs. So the lemma is neither vacuous nor the plain average dressed up: the $\#$ term is generically the whole of what distinguishes it.*

## K5, confirmed, with the hypothesis correctly named

$\langle W,Y_0\rangle=\operatorname{tr}(WY_0)=u^{\mathsf T}Wv=\theta\,\varepsilon_\beta\langle u,v\rangle=0$. **The hypothesis consumed is $\langle u,v\rangle=0$, which orthonormality of the eigenbasis supplies, and not $\alpha\ne\beta$ in the sense of distinct eigenvalues.** Screened at machine zero at every pair above, including the degenerate pair. And since $W\in\mathcal W_n$, $\langle W,\pi_{\mathcal W_n}Y_0\rangle=\langle W,Y_0\rangle=0$, so the admissible direction inherits it, which is what [L24](../findings/second-order.md) and [L125](../findings/second-order.md) need.

## K6, the implication is valid, the headline is wider than it

**The inference is sound and needs only containment.** $L_e$ is self-adjoint, so eigenvectors at distinct eigenvalues are orthogonal. The orbit tangent lies inside $E(\tfrac12)$ by [post F37](../findings/fence-posts.md), so anything that is an $L_e$-eigenvector at $\mu\ne\tfrac12$ is orthogonal to all of $E(\tfrac12)$ and a fortiori to the tangent. **Whether the tangent is the whole $\tfrac12$-eigenspace is irrelevant to the conclusion, and here it happens to be the whole of it**: at this $W$, $\operatorname{spec}(L_e)$ on $\mathcal W_8$ is $1^{(1)},\tfrac12^{(16)},\tfrac13^{(54)},0^{(148)},(-\tfrac13)^{(81)}$, summing to $300$, and the orbit tangent has dimension $16$ with $\lVert L_et-\tfrac12t\rVert\le9\cdot10^{-17}$ on an orthonormal basis of it. The overlap of the projected pair direction with the tangent reproduces at $8.8\cdot10^{-17}$.

**The scope the headline drops.** The argument applies only where the projected direction *is* an $L_e$-eigenvector, and that is a property of this configuration rather than of pair directions. Screened at the same $W$: the disjoint pair's projection is an eigenvector to $10^{-15}$, while both shared-index projections fail to be eigenvectors by a relative $1.2\cdot10^{-1}$. *For those, [post F39](../findings/fence-posts.md)'s trap has to be excluded some other way, and L233 offers nothing.* The block's *"The test is NOT vacuous"* is therefore established for one direction at one point, not for the route.

## The configuration is MISLABELLED, and the label it was given is the one case where K6 is empty

**The block calls it $S^3\times S^3$ inside $n=8$. It is $S^4\times S^4$ at $n=8$.** Three independent readings agree, each computed here from scratch:

- $\mu=\tfrac{n-2}{2(p-1)(q-1)}=\tfrac13$ at $n=8$ forces $(p-1)(q-1)=9$, hence $p=q=4$.
- the tangent dimension the block itself quotes, $\dim\mathfrak{so}(8)-\dim(\mathfrak{so}(4)\oplus\mathfrak{so}(4))=16$, is the isotropy of a $4{+}4$ split. Padded $S^3\times S^3$ at $n=8$ would give $28-7=21$.
- $\theta=\sqrt{21}/4=1.145643924$, which is the value [nondegeneracy.md](../findings/nondegeneracy.md) tables against the row **$S^4\times S^4$, $n=8$**. Reproduced here to nine digits with criticality residual $3\cdot10^{-17}$.

**The label matters more than a naming slip usually does.** $S^3\times S^3$ is the unique degenerate sphere product and the unique member sitting at $\mu=\tfrac12$, as [L26](../findings/nondegeneracy.md)'s own criterion $(p-2)(q-2)\le1$ records with equality at $(3,3)$. Computed here at $n=6$: the disjoint pair's projected quotient is **exactly $\tfrac12$**, so the projected direction lies in $E(\tfrac12)$ and K6's argument gives nothing at all there. *Read literally, the block demonstrates its non-vacuity argument at the one point in the family where the argument is empty.* The mathematics is right and the name is wrong, and the name is the part a later consumer will quote.

**Every other figure in the block reproduces exactly.** $\lVert Y_0\rVert^2=\tfrac12$, $\varepsilon_\pi=\varepsilon_\rho=\tfrac4{21}$, unprojected quotient $\tfrac4{21}=0.190476$, $\lVert\pi_{\mathcal W_n}Y_0\rVert^2=\tfrac13$ against $\lVert Y_0\rVert^2=\tfrac12$, projected quotient $\tfrac13$ with eigen-residual $10^{-15}$, shift exactly $\tfrac17$, $\dim\mathcal W_8=300$.

*One convention note, against [nondegeneracy.md](../findings/nondegeneracy.md) rather than against L233.* The vertex entries recorded there as $-q/(p-1)$, $-p/(q-1)$ and $1$ give $\theta=-1.145643924$, and the $\theta>0$ branch is their negation, and it is the negation that returns L233's $+\tfrac4{21}$. Under the recorded signs the unprojected quotient would be $-\tfrac4{21}$ and the shift $\tfrac{11}{21}$ rather than $\tfrac17$. **L233's number is the right one and the sign convention behind it is tabled nowhere.**

## The `Lean: blocked` trailer overstates the blocker

`sharpQF_eq_sum_ad`, `sharpBilin_eq_sum_ad` and `sharpBil_eq_sum_ad` are absent from the tree as declarations, confirmed by grep over the whole repository. **The reason given for the block is wrong on two counts.**

- **The ad-trace expansion over a basis of $\Lambda^2$ is not what the lemma needs.** For $Y_0$ specifically the contraction collapses with no eigenbasis anywhere: $\langle Y_0,E\#Y_0\rangle=-\tfrac14\langle[u,v],E[u,v]\rangle$, because $\sum_a c_{acd}u_au_d=0$ by total antisymmetry and the surviving contraction is the commutator's coordinate vector twice. *The spectral theorem, a basis of $\Lambda^2$ at general $n$ and a sum over $\gamma$ are all avoidable.*
- **The trailer cites only `sharpBilin` in [RelationB.lean](../lean/HamiltonsCubic/Base/RelationB.lean), which is indeed `Fin 6` over $\mathbb Q$, and does not mention that the real layer already carries `sharpOp` at general $n$ over $\mathbb R$** with `sharpOp_id` proved there without `native_decide`. Polarising `sharpOp` in its curvature slot is the same three-line device the file already uses in the bivector slot.

**So this is a blocker the cycle could have built**, at least as far as a general-$n$ real-layer curvature-slot polarisation plus the collapsed pair-direction identity. What would remain genuinely hard is only the passage between operator language and the matrix-and-`dotProduct` language of [I73PairDirection.lean](../lean/HamiltonsCubic/Results/I73PairDirection.lean), for which `skew_expand` is already in place. *The half that got typed is the half that was easy, and the trailer's account of why the other half did not is not the real reason.*

## Corrections owed

1. **Strike or scope the general clause.** *"The projection rather than the bracket carries the $\#$ term"* holds on commuting eigenpairs and fails at shared-index eigenpairs of the same $W$. Attach the hypothesis.
2. **Rename $S^3\times S^3$ to $S^4\times S^4$** at both occurrences in the block, and in the commit's account of it.
3. **State the $\#$ term invariantly** as $-\tfrac12\langle[u,v],e[u,v]\rangle$, keeping the basis warning as a warning rather than as the statement.
4. **Weaken the statement's hypotheses to what it uses**: any symmetric $e$ on $\Lambda^2$ and any orthonormal $u,v$, with $\tfrac12(\langle u,eu\rangle+\langle v,ev\rangle)$ in the first term. The eigen-hypothesis belongs beside $\langle W,Y_0\rangle=0$, which is the clause that needs it.
5. **Repair the Lean docstring's *"distinct eigenspaces"***, which the block's own example violates.
6. **Rewrite the blocked trailer** to name the polarisation of the real layer's `sharpOp` in its curvature slot, which is what is missing, in place of three ad-trace declarations the lemma does not require.
