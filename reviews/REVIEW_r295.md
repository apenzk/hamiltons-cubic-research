# Reviewer 295, the non-diagonal $S=0$, $\Delta>0$ critical point at $\theta=1.088948$

Cold adversarial audit of the brief's claims E1–E4 about the $n=8$ witness, including the coordinator's mid-task addendum replacing E2 by E2'. Every quantity below was re-derived in [r295_core.py](../scripts/reviewers/r295/r295_core.py), which shares no code with [review_r30_core.py](../scripts/lib/review_r30_core.py), [b0_psd_identity.py](../scripts/lib/b0_psd_identity.py) or [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py): structure constants by brute force over triples, $W^\#_{ab}=\tfrac12 c_{apq}c_{brs}W_{pr}W_{qs}$ from the Böhm–Wilking formula rather than the trace form, the $4$-tensor built directly from the pair basis rather than from an eigendecomposition, and Ricci, Bianchi, pair symmetry, $\Delta$ and $S_{\mathfrak{mmm}}$ off that tensor. The object itself was rebuilt from the construction by rerunning the multistart of [run_f4b_newton.py](../scripts/runs/run_f4b_newton.py) ([e3_census.py](../scripts/reviewers/r295/e3_census.py)); the saved copy was used only to cross-check.

## Verdicts

| Claim | Verdict | One line |
| --- | --- | --- |
| **E1**, genuine critical point in the target set | **CONFIRMED**, and strengthened | Every number reproduces; the residual survives $60$-digit arithmetic; and the Jacobian is nonsingular off the orbit, so an *exact* critical point sits within $2.5\times10^{-14}$ |
| **E2'**, certified non-diagonal by an identity | **CONFIRMED**, and upgraded from observed to **proved** | The eigenplane is a $2$-plane inside $\Lambda^2_-(U)$ for a $4$-dimensional $U\subset\mathbb R^8$, so $\omega\wedge\omega=-\mathrm{vol}_U$ *identically*, and a second, simpler certificate exists that the record misses |
| **E3**, displaces a recorded ceiling | **CONFIRMED as a statement about the record**, with one completeness gap | The ceiling, the three siblings and the margin arithmetic all reproduce; a **fifth** member of the family at $\theta=1.081605$ is missing from the sibling list |
| **E4**, the restriction to $V$ is legitimate | **CONFIRMED**, and it is a **theorem**, not a measurement | $V$ is exactly the $+1$ eigenspace of $\sigma=\Lambda^2(s)$ on $\mathcal W_8$ ($155$ of $300$), and $Q$ is exactly $\sigma$-equivariant, so the brief's challenge is impossible to meet |

## E1, the point, and whether it is real

Reproduced from my own machinery on the saved copy and, independently, on the rebuild:

| Quantity | Claimed | Measured (r295) |
| --- | --- | --- |
| $\theta$ | $1.088948053$ | $1.08894805250504805$ ($60$ digits) |
| criticality residual in full $\mathcal W_8$ | $10^{-15}$ | $\max 5.02\times10^{-16}$, Frobenius $2.83\times10^{-15}$ |
| Ricci / Bianchi / trace | $10^{-16}$ | $5.1\times10^{-16}$ / $2.6\times10^{-16}$ / $4.0\times10^{-16}$ |
| $S_{\mathfrak{mmm}}$ | $1.4\times10^{-28}$ | $1.43\times10^{-28}$ |
| $\Delta$ | $1.512231$ | $1.512231$ |
| $\dim\mathfrak m$, kernel, distinct positive eigenvalues | $15$, trivial, five | $15$, $0$, five ($3,6,1,2,1$) |
| $\sum_\gamma g_\gamma$ | $28=4(n-1)$ | $28.000000$ |

**Rebuild against the saved copy.** The multistart's own solution lands $6.6\times10^{-8}$ from [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) in Frobenius norm (the same point to solver tolerance, not merely the same $\mathrm{SO}(8)$ orbit), with $\lvert\Delta\theta\rvert=4.4\times10^{-16}$, spectra agreeing to $1.2\times10^{-15}$ and $\Delta=1.512230534$ from both.

**Is `is_weyl` doing what its name says?** Yes. [theta_screened](../scripts/lib/weyl_screen.py) tests Ricci, the Bianchi Alt component and the trace at unit norm against $10^{-9}$, and [ricci](../scripts/lib/b0_psd_identity.py) does compute $\mathrm{Ric}_{ik}=\sum_j R_{ijkj}$ correctly, if by an eigendecomposition route. I rebuilt the $4$-tensor directly from the pair basis and got the same three residuals, plus pair symmetry $R_{ijkl}=R_{klij}$ at exactly $0$ and scalar curvature at $7.9\times10^{-16}$. Two things `is_weyl` does *not* cover, and neither bites here: it says nothing about criticality (that lives in [critical_screened](../scripts/lib/weyl_screen.py)), and nothing about whether $Q(W)$ stays inside $\mathcal W_8$, measured separately at $6.9\times10^{-16}$.

**Is $\lVert W\rVert=1$ exactly?** No, and it cannot be: in $60$-digit arithmetic the saved `float64` array has $\lVert W\rVert^2-1=1.7\times10^{-16}$. [np.linalg.norm](https://numpy.org/doc/stable/reference/generated/numpy.linalg.norm.html) returns exactly $1.0$ because the rounding hides it. This is the representation floor, not a defect.

**Is the $10^{-15}$ residual real or `float64` cancellation?** Real. [e1_exact.py](../scripts/reviewers/r295/e1_exact.py) recomputes $Q(W)$ at the *saved* `float64` entries in $60$-digit [mpmath](https://mpmath.org/) via integral structure constants and gets $\max\lvert Q(W)-\theta W\rvert=5.0161\times10^{-16}$, the same number float arithmetic reported.

**New, and it is what E1 actually needs.** "Residual $10^{-15}$" is not "a critical point exists". [e1_jacobian.py](../scripts/reviewers/r295/e1_jacobian.py) computes $DF$ for $F(W)=Q(W)-\theta(W)W$ on $\mathcal W_8$, quotients out the $23$-dimensional $\mathrm{SO}(8)$-orbit tangent and the radial direction, and finds the remaining $276\times276$ block of **full rank with $\sigma_{\min}=0.109202$**. So $\lVert F\rVert/\sigma_{\min}=2.54\times10^{-14}$ bounds the distance from the saved point to an exact solution. The symmetric part has $275$ negative and $1$ positive eigenvalue, so the point is a **saddle**, which independently vindicates the script's stated reason for building an exact Jacobian instead of iterating $W\mapsto\Pi(Q(W))/\lVert\cdot\rVert$.

## E2', the certificate, and the mechanism the record gave up on

### The identity is exact, and stronger than stated

Write $\omega(t)=\cos t\,u+\sin t\,v$ on the eigenplane. Then $\omega\wedge\omega = C + \cos 2t\,a + \sin 2t\,b$ with $C=\tfrac12(u\wedge u+v\wedge v)$, $a=\tfrac12(u\wedge u-v\wedge v)$, $b=u\wedge v$. Measured in [e2_wedge.py](../scripts/reviewers/r295/e2_wedge.py): $\lVert a\rVert=\lVert b\rVert=0$ to $10^{-16}$ and $\lVert C\rVert=0.5$. So $\omega\wedge\omega$ is not merely constant in modulus, **it is the same $4$-vector at every angle**. That is a two-line exact check on the plane, not thirteen samples.

### Why: the mechanism, which the record records as refuted

The record ([bounds.md](../findings/bounds.md)) says the natural guess ("a plane of self-dual forms inside a $4$-space"), is *refuted by the plane's coordinate support being all eight directions*. **That refutation is wrong, and the guess is right.** Coordinate support is frame-dependent and is the wrong instrument; the frame-independent support of a bivector is the image of its skew matrix. Measured in [e2_mechanism.py](../scripts/reviewers/r295/e2_mechanism.py) and [e2_structure.py](../scripts/reviewers/r295/e2_structure.py):

- singular values of $[A_u\mid A_v]$ are $(1,1,1,1,0,0,0,0)$, so $\mathrm{im}\,A_u=\mathrm{im}\,A_v=U$ with $\dim U=4$, the plane does live in $\Lambda^2 U$, in a $U$ that simply is not a coordinate $4$-space (its per-coordinate mass is $0.988,0.491,0.521,0.363,0.860,0.161,0.095,0.522$, which is exactly what made the coordinate-support test read "all eight directions");
- in an orthonormal frame with $U=\mathrm{span}(e_0,\dots,e_3)$, decomposing $\Lambda^2U=\Lambda^2_+\oplus\Lambda^2_-$, the $\lambda=-0.302413$ eigenplane has $\lvert\text{SD part}\rvert^2=0.000000000$ and $\lvert\text{ASD part}\rvert^2=1.000000000$, it is **purely anti-self-dual on $U$**;
- each $A_\omega$ satisfies $\sqrt2 A_\omega$ squaring to $-\mathrm{Id}_U$ and $J_uJ_v+J_vJ_u=0$ to $10^{-15}$: the plane is a $2$-plane inside a quaternionic triple.

That gives a one-line proof of the identity. For unit $\omega\in\Lambda^2_-(U)$, $\star_U\omega=-\omega$, so $\omega\wedge\omega=-\omega\wedge\star_U\omega=-\lVert\omega\rVert^2\mathrm{vol}_U=-\mathrm{vol}_U$, the same unit $4$-vector for every $\omega$ on the circle, hence $\lVert\omega\wedge\omega\rVert\equiv1$ and no element is decomposable. **The constancy is not an artefact and not a coincidence; it is the Hodge star, and it is exactly the argument the record already carries in prose for $\mathbb{HP}^2$'s top eigenspace**, applied on a $4$-dimensional subspace instead of on all of $\mathbb R^8$.

### The factor $2$: both numbers are right

Pinning the definition by hand: $\omega\wedge\omega=\sum_{i<j<k<l}2\,\mathrm{pl}_{ijkl}\,e_{ijkl}$ with $\mathrm{pl}_{ijkl}=w_{ij}w_{kl}-w_{ik}w_{jl}+w_{il}w_{jk}$. [plucker_min](../scripts/lib/review_r56_core.py) returns $\lVert\mathrm{pl}\rVert$, which is **exactly half** $\lVert\omega\wedge\omega\rVert$. Checked on $(e_{12}+e_{34})/\sqrt2$, whose wedge is the unit $4$-vector $e_{1234}$: the routine returns $0.5$, the plain normalisation gives $1.0$. Neither has a bug; the coordinator's $1.0000$ and the record's $0.5000$ are the same fact. The closed form $\lVert\omega\wedge\omega\rVert^2=2(1-\sum_k a_k^4)$ over the normal form reproduces both, and $(e_{12}+e_{34}+e_{56}+e_{78})/2$ returns $1.224745$ as it must.

**And the roundness is now explained**: $0.5000$ is round because the answer is the volume form of a $4$-plane, a unit vector in $\Lambda^4$, halved by the Plücker convention.

### A simpler certificate that the record misses

Two eigenvalues of the witness are **simple**: $+0.114549164$ and $+0.573114703$. Their eigenvectors have bivector rank $4$ (singular values $0.8545,0.8545,0.5194,0.5194$; $\lVert\mathrm{pl}\rVert=0.443866$). A simple eigenvalue's eigenvector is unique up to sign, so in any diagonalising frame it would have to *be* a coordinate $2$-plane, hence rank $2$. Either one alone certifies non-diagonality, with no plane, no minimisation and no Grassmann-cone argument.

Reviewer 80's tolerance hole, recorded in [b_frame_independent_diagonality.py](../scripts/lib/b_frame_independent_diagonality.py), is the reason to distrust simple-eigenvalue rank tests, and it does not bite here: it needs a gap near $3\times10^{-9}$, while these gaps are $7.1\times10^{-3}$ and $0.256$, so the eigenvector perturbation is $\lVert\delta W\rVert/\text{gap}\approx4\times10^{-13}$ against a rank signal of $0.52$.

### Attempts to break it, all of which failed

- **Degeneracy.** The multiplicity at $-0.302413$ is exactly $2$ with a gap of $0.143$ to the next eigenvalue, so the plane is not a numerically chosen slice of a larger eigenspace. Over $200$ random orthonormal frames of the eigenplane, the worst deviation in the constancy and in the minimum is $1.05\times10^{-15}$, as it must be, since $\Lambda^2_-(U)$ is rotation-invariant.
- **Perturbation.** The exact critical point is within $2.5\times10^{-14}$ (E1). With gaps of $0.143$ and $0.256$ the eigenvectors move by $\lesssim2\times10^{-13}$, against certificate margins of $0.5$ and $0.4439$, twelve orders of room. The certificate applies to the exact point, not just to the float.
- **Direct diagonalisation.** [e2_diagonalise2.py](../scripts/reviewers/r295/e2_diagonalise2.py) minimises the off-diagonal Frobenius mass over $\mathrm{SO}(8)$, $200$ starts. Positive control (a randomly rotated $S^3\times S^5$, start mass $0.9689$) is driven to $1.5\times10^{-6}$; the witness floors at **$0.35254$**. That is *below* the record's $0.373$, so $0.373$ was not the true minimum, but the search still comes nowhere near $0$, and it is the proof, not the search, that settles it.

### The instrument's control table, reproduced with one caveat

| Plane | Coordinator | r295 |
| --- | --- | --- |
| two decomposable generators | $0.000000$ | $0.000000$ |
| decomposable $+$ rank $4$ | $0.000000$ | $0.000000$ |
| two orthogonal rank-$4$ generators | $0.500000$ | $0.500000$ |
| generic plane in a coordinate $4$-space | $0.480000$ | $0.237766$ / $0.000000$ / $0.021477$ (three seeds) |
| the witness eigenplane | $0.500000$ | $0.500000$ |

**Caveat on the third row.** "Two orthogonal rank-$4$ generators" returns $0.5$ only because the natural way to build such a pair (two orthogonal elements of $\Lambda^2_\pm$ of a common $4$-space), *is the witness's own structure*. It screens the instrument for the true-positive case, and is not an independent control. The fourth row's spread ($0$ among them) is the honest generic behaviour and is the row that shows the routine finds zeros when they exist.

## E3, the displacement

**The value is genuinely new to the record.** `git log -S"1.088948"` shows it first appearing in commit 7ee03c0, this cycle. The prior entries in the [findings index](../findings/INDEX.md) value table are $0.716134$ ($n=12$, diagonal) and $0.670820$ (the $C_5$ blow-up, $n=10$), as claimed, and the margin arithmetic checks: $\sqrt{3/2}/0.716134=1.7102$ and $\sqrt{3/2}/1.088948=1.1247$.

**The rebuild reproduces the family.** Rerunning the construction's own $30$-start multistart from scratch:

| $\theta$ | $\Delta$ | $S_{\mathfrak{mmm}}$ | $\dim\mathfrak m$ | $\ker$ | distinct $+$ | full residual |
| --- | --- | --- | --- | --- | --- | --- |
| $1.088948053$ | $1.512231$ | $2.1\times10^{-28}$ | $15$ | $0$ | $5$ | $5.1\times10^{-16}$ |
| $1.083688602$ | $3.025161$ | $4.7\times10^{-28}$ | $16$ | $0$ | $2$ | $3.7\times10^{-16}$ |
| $1.081549248$ | $2.400930$ | $5.0\times10^{-28}$ | $15$ | $0$ | $7$ | $4.0\times10^{-16}$ |
| $1.080092196$ | $3.494141$ | $8.0\times10^{-28}$ | $16$ | $0$ | $6$ | $4.7\times10^{-16}$ |

Ceiling, all three siblings and "two of them at the cap $\dim\mathfrak m=16$" all reproduce exactly.

**Competitors ruled out by hand.** Every catalogued $n=8$ point with $\theta>1.088948$ has $\Delta=0$ **exactly**, so none of them is in $\{\Delta>0\}$: $S^4\times S^4$ ($1.145644$), $\mathbb{HP}^2$ and $S^3\times S^5$ ($1.115547$), $(\mathfrak{su}(3),\mathfrak{so}(3))$ ($1.095445$), padded $W_{\mathbb{CP}^2}$ ($1.224745$). The multistart also returns $\sqrt{3/2}$ repeatedly, always with $\Delta=0$ and a $25$-dimensional kernel.

**The one gap.** A **fifth** member of the family exists that the record's sibling list omits: $\theta=1.081605297768$, $\Delta=0.791162$, $S_{\mathfrak{mmm}}=4.0\times10^{-29}$, $\dim\mathfrak m=12$, full residual $8.6\times10^{-16}$, Casimir $28.0000$, but with a **$7$-dimensional kernel**, which is why the construction's own multistart, and hence the record, did not see it. It sits below the ceiling, so it does not disturb E3's number; it does show that "three siblings" is a sample and not a census, and that the family reaches into the $\ker W\neq0$ stratum where [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py)'s $\Delta=0\Rightarrow$ graded implication is explicitly not available.

**Is E3 vacuous?** Partly, and it should be said plainly: "the highest on record" is a fact about the record's contents, over a set nobody has censused. What is not vacuous is the consequence, the measured margin on the only sub-statement in the programme that has one falls from $1.71\times$ to $1.12\times$, and that consequence survives audit.

## E4, symmetric criticality

Proved, not merely measured ([e4_symcrit.py](../scripts/reviewers/r295/e4_symcrit.py)):

- $\Lambda^2(s)$ for $s=\mathrm{diag}(I_3,-I_5)$ equals the $\pm1$ sign matrix $\sigma$ on the $\mathfrak p/\mathfrak m$ split, to $0.00$;
- $\sigma$ restricted to $\mathcal W_8$ has eigenvalue $+1$ with multiplicity $155$ and $-1$ with multiplicity $145$, and the $+1$ eigenspace **is** $V$, so $V=\mathcal W_8^\sigma$ exactly, and the restriction is a genuine one ($155$ of $300$), not vacuous;
- $Q$ is exactly $\sigma$-equivariant: $Q(\sigma X\sigma)-\sigma Q(X)\sigma=0.00\times10^{0}$ at random symmetric $X$. The reason is structural: conjugation by $s\in\mathrm O(8)$ is a Lie algebra automorphism of $\mathfrak{so}(8)$ preserving the trace form, so it fixes the structure constants and therefore $\#$.

**So the brief's challenge ("construct a point of $V$ where the full gradient has mass off $V$"), cannot be met.** $\nabla P(W)=3Q(W)$, and for $W\in V$, $Q(W)=Q(\sigma W\sigma)=\sigma Q(W)\sigma$, so $Q(W)\in V$. Measured at six random points of $V$: mass off $V$ between $9.4\times10^{-16}$ and $1.3\times10^{-15}$, which is rounding. As a bonus, $Q(W)$ also stays inside $\mathcal W_8$ for $W\in V$ (mass off $\mathcal W_8$ $\le3.2\times10^{-16}$), which is why the solve can impose $Q(W)=\theta W$ without a Weyl projection and why E1's "in the FULL $\mathcal W_8$" screen is meaningful rather than automatic.

## Two things the record should absorb

1. **The mechanism behind the constancy is settled, and the record's "refuted" note is itself wrong.** The eigenplane *is* a plane of anti-self-dual forms in a $4$-space; the $4$-space is not a coordinate one, and coordinate support was the wrong test. The identity $\omega\wedge\omega=-\mathrm{vol}_U$ follows from $\star_U\omega=-\omega$ in one line, so E2' should be stated as a proof rather than as an observation with $9\times10^{-16}$ of spread.

2. **The witness has a second, undocumented block structure.** $\Lambda^2 U$ is $W$-invariant, and so are $\Lambda^2 U^\perp$ and $U\wedge U^\perp$, off-block masses $3.4\times10^{-16}$, $8.7\times10^{-16}$, $9.1\times10^{-16}$. So the witness is block-diagonal for an $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ split as well as for the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ one it was built on, i.e. it lies in the fixed-point set of a *second* involution $\Lambda^2(\mathrm{diag}(I_4,-I_4))$. The two $6$-dimensional blocks carry the whole story: $\Lambda^2U^\perp$ splits as $-0.104960$ on one chirality and $+0.066658$ on the other, and $\Lambda^2U$ carries the two chiral eigenplanes plus the two simple eigenvectors. Its isotropy algebra is only $5$-dimensional, so it is block-diagonal without being $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$-equivariant, consistent with $\Delta>0$. Whether the family is more naturally generated from the $4+4$ pair is worth a cycle, since two of the siblings already sit at the $\dim\mathfrak m=16$ cap.

## What I did not check

- Whether the family climbs past $\sqrt{3/2}$ at larger $n$, out of scope and untouched.
- A census of $\{$critical, $S=0$, $\Delta>0\}$ at $n=8$. The fifth member above was found by a local kick, not a sweep, so there are very likely more.
- The frame minimisation is a $200$-start local search on a machine at load average $\sim110$; its $0.35254$ is an upper bound on the minimum and nothing more. It is not load-bearing for any verdict.

## Scripts

[r295_core.py](../scripts/reviewers/r295/r295_core.py) · [e1_exact.py](../scripts/reviewers/r295/e1_exact.py) · [e1_jacobian.py](../scripts/reviewers/r295/e1_jacobian.py) · [e2_wedge.py](../scripts/reviewers/r295/e2_wedge.py) · [e2_mechanism.py](../scripts/reviewers/r295/e2_mechanism.py) · [e2_eigcert.py](../scripts/reviewers/r295/e2_eigcert.py) · [e2_structure.py](../scripts/reviewers/r295/e2_structure.py) · [e2_diagonalise2.py](../scripts/reviewers/r295/e2_diagonalise2.py) · [e3_census.py](../scripts/reviewers/r295/e3_census.py) · [e3_reachable.py](../scripts/reviewers/r295/e3_reachable.py) · [e4_symcrit.py](../scripts/reviewers/r295/e4_symcrit.py)
