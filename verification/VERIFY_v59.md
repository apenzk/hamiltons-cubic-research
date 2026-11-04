# Verifier v59, L61, $M(5)=\sqrt{3/2}$ by the $n=5$ sum-of-squares certificate

*The brief was cold: [findings/sym3-blocks.md](../findings/sym3-blocks.md) was not opened, and every claim below was attacked from [findings/conventions.md](../findings/conventions.md)'s definitions outward. **No numerical work was done. Nothing was executed.** The certificate and the scripts were read as text; the two closed-form checks in §3 and §4 were carried out by hand and every value in this report is exact. Log: [agent_logs/verify-L61-v59.log](../agent_logs/verify-L61-v59.log).*

## The claim table

| # | claim attacked | verdict | reason |
| --- | --- | --- | --- |
| 1 | Step 1, $(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ is one-dimensional | **CONFIRMED, and now proved by hand** | it equals $[\mathrm{Sym}^2\mathcal W_5:\mathcal W_5]$, which is $1$ by $B_2\cong C_2$, $\mathcal W_5\cong\mathrm{Sym}^4\mathbb C^4$ and Littlewood restriction in the stable range |
| 2 | Step 2, the anchor pins $c=2$ | **CONFIRMED** | $\#$ on $\mathfrak{su}(2)_+$ is $\mathrm{diag}(2\lambda_2\lambda_3,2\lambda_3\lambda_1,2\lambda_1\lambda_2)$, giving $c=2$ from the structure constants alone |
| 3 | Step 3, $P(W)=3\mathop{\mathrm{tr}}(W^3)$ on all of $\mathcal W_5$ | **CONFIRMED at a second, kernel-free anchor** | $S^2\times S^3$ returns $3\mathop{\mathrm{tr}}(W^3)=2\sqrt2/3=\Theta_5$, matching the record's independent closed form |
| 4 | Step 4 ($F_5\ge0\iff\theta\le\sqrt{3/2}$ | **PROVEN), hypotheses corrected** | the equivalence is to $\lvert\theta\rvert\le\sqrt{3/2}$, and $W=0$ must be excluded before $\theta$ exists |
| 5 | Step 5, the 16 blocks are positive definite | **CONFIRMED as far as it reaches** | exact over $\mathbb Q$ by a valid Descartes argument, in two packings; but it certifies a matrix whose meaning is in no file it reads |
| 6 | Step 6, the Gram's sextic **is** $F_5$ | **GAP** | rests on a floating-point rank of a $40\times120$ matrix and on a four-prime rational reconstruction of $A$ never recomputed over $\mathbb Q$ |
| 7 | "with equality exactly on that orbit" (Forms A, B) | **BROKEN as written** | $F_5$ is even, so its zero set contains $O(5)\cdot(-W_0)$ and $0$; no positivity statement about a Gram determines a zero set |
| 8 | "by an exact rational certificate" (Form D) | **OVERSTATED** | two links are measured, and Form D is the only form that does not say so |
| 9 | Forms A–D state the same thing | **NO** | Form C concedes precisely what Forms A, B and D assert |
| 10 | falsifier hunt | **NOTHING FOUND, and nothing on the record excludes the strongest candidate** | the spectral shape $(3,-1,-1,-1,0^6)/\sqrt{12}$ would give $\theta=\sqrt3$ and clears [L73](../results.md) at equality |

**One-line summary.** Steps 1–4 are correct and are now proved by hand from the conventions rather than taken on the record's word, and step 5's positive-definiteness is exact, but step 6, the step that turns a positive-definite matrix into a statement about $F_5$, rests on a floating-point rank and an uncertified rational reconstruction, so Form D's "exact rational certificate" is wrong and Forms A and B's equality clause is not merely unproven but unreachable by any sum-of-squares argument.

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), never restated:

- $\mathcal W_n$, "the space of algebraic Weyl curvature operators on $\mathbb R^n$", of dimension $\frac{n(n-3)(n+1)(n+2)}{12}$, so $\dim\mathcal W_5=35$.
- $Q(W)$, "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself".
- $P(W)$, "the cubic form $\langle W,Q(W)\rangle$".
- $\theta$, "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$, $M(n)=\max\{P(A):\lVert A\rVert=1\}$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$ … Distinct from $\Theta_n$, which is the *diagonal* maximum".
- $\Theta_n$, "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$", so $\Theta_5=\sqrt{16/18}=2\sqrt2/3$.
- $W_0$, $H$, "the $n=5$ base point of the $\mathrm{Sym}^3$ machinery and its stabiliser $H\subset O(5)$, the orbit $O(5)\cdot W_0$ being the zero set a certificate must vanish on. … *Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically.*"
- The pairing, "The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level. The inner product is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix", with $\{\varphi_{ab}\}_{a<b}$ orthonormal. So $\langle W,W^2\rangle=\mathop{\mathrm{tr}}(W^3)$ with the trace taken on $\Lambda^2$.
- Structure constants, "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**".
- Padding, "**Padding commutes with $Q$**, and preserves both the norm and $\theta$."

## 1. The hypothesis inventory

### 1a. Hypotheses the statement itself carries

| hypothesis | where it is used | verdict |
| --- | --- | --- |
| $n=5$ exactly | step 1 (the cubic invariants are two-dimensional from $n\ge6$), step 6 (the $14$), the whole certificate | **used, and load-bearing** |
| $W\in\mathcal W_5$, symmetric on $\Lambda^2$, first Bianchi, Ricci-flat | step 1's dimension count; the sample points are checked for it by `is_weyl` in [c3_rhs_is_F5.py](../scripts/reviewers/r213/c3_rhs_is_F5.py) | **used** |
| "critical or not", no criticality | nowhere; correctly, since $F_5\ge0$ is a polynomial statement | **stated and correctly unused** |
| $\lVert W\rVert=1$ | nowhere; $F_5$ is homogeneous of degree $6$, so the unit-sphere statement and the cone statement are the same | **not needed** |
| the cubics vanish on $O(5)\cdot W_0$ | it is a **consequence** of feasibility, not an extra hypothesis: $F_5(W_0)=0$ and a positive-definite Gram force every cubic in $K$ to vanish at $W_0$ | **correctly not an assumption** |

### 1b. Hypotheses of the imported theorems

| import | its hypothesis | checked against the object? |
| --- | --- | --- |
| $\mathcal W_n$ is $O(n)$-irreducible of highest weight $(2,2,0,\dots)$ | $n\ge5$ | ✓, at $n=4$ it splits and the whole argument fails, which is why nothing here travels to $n=4$ |
| $O(5)$-invariants $=SO(5)$-invariants | $n$ odd, so $-I\in O(n)\setminus SO(n)$ acts trivially on $\Lambda^2$ | ✓, **and this is never stated on the record.** It is what makes "$O(5)$" and "$SO(5)$" interchangeable throughout, and it is false at every even $n$ |
| Hermitian $M\succ0$ $\iff$ $\det(xI-M)$ has alternating coefficient signs | all roots real | ✓, the blocks are built Hermitian by construction in [run_n5_verify.py](../scripts/runs/run_n5_verify.py), and the file additionally asserts every Faddeev–LeVerrier trace is real |
| $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ |, | **NOT re-derived here, and it is the cap that makes step 6 work.** Without it, rank $14$ says only $\dim\ge14$ and nothing about sextics outside the sampled span |
| CRT + rational reconstruction recovers $A$ over $\mathbb Q$ | every entry of $A$ has height below $\sqrt{M/2}\approx2^{80}$ | **NOT checked anywhere.** A reconstruction above the bound returns a wrong rational silently; [run_n5_lift.py](../scripts/runs/run_n5_lift.py) guards only against *failure* to reconstruct |
| Brauer/Littlewood stable range (used in §2 below, by me, not by the record) | $\ell(\lambda)\le n$ for $Sp(2n)$; here $\ell\le2$, $n=2$ | ✓ |

### 1c. Steps using a hypothesis nobody stated

Two, both in step 6, and neither appears in Form A, Form B or Form D: the $14$-dimensionality of $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, and the height bound that makes the four-prime lift of $A$ correct. Form C's "resting on two measured links" is the only place the record admits anything of the kind, and §7 argues it names the wrong two.

## 2. Step 1, the one-dimensionality is TRUE, and here is a proof the record does not carry

The record asserts it. I proved it, and the proof is short enough that the record should carry it.

An invariant cubic form on $V$ is an element of $(\mathrm{Sym}^3V^*)^G$, and $\mathrm{Sym}^2V\otimes V=\mathrm{Sym}^3V\oplus S^{(2,1)}V$, so with $V$ self-dual

$$[\mathrm{Sym}^2V:V]\;=\;\dim(\mathrm{Sym}^3V)^{*G}+\dim(S^{(2,1)}V)^{*G}\;\ge\;\dim(\mathrm{Sym}^3V)^{G}.$$

So it suffices to show $[\mathrm{Sym}^2\mathcal W_5:\mathcal W_5]=1$; the reverse inequality is free because $\mathop{\mathrm{tr}}(W^3)$ is a nonzero invariant cubic.

$\mathcal W_5=V_{(2,2)}$ of $B_2$, of dimension $35$ by Weyl's formula ($\lambda+\rho=(7/2,5/2)$, $\rho=(3/2,1/2)$, giving $1\cdot5\cdot\tfrac73\cdot3=35$). In fundamental weights $(2,2)=4\omega_2$, and the exceptional isomorphism $B_2\cong C_2$ exchanges $\omega_1$ and $\omega_2$, so

$$\mathcal W_5\;\cong\;\mathrm{Sym}^4(\mathbb C^4)\quad\text{as a representation of }Sp(4),\qquad \dim\mathrm{Sym}^4\mathbb C^4=\binom73=35 .$$

The classical plethysm $\mathrm{Sym}^2(\mathrm{Sym}^m)=\bigoplus_{k\ \mathrm{even}}S^{(2m-k,k)}$ gives, at $m=4$,

$$\mathrm{Sym}^2(\mathrm{Sym}^4\mathbb C^4)\;=\;S^{(8)}\oplus S^{(6,2)}\oplus S^{(4,4)}\quad\text{as }GL(4)\text{-modules},$$

every summand of length $\le2=n$, so Littlewood's restriction rule applies in its stable range. The multiplicity of the $Sp(4)$-irreducible $\mu=(4)$ is $\sum_\beta c^{\lambda}_{(4)\beta}$ over $\beta$ with all columns of even length:

- $\lambda=(8)$: only $\beta=(4)$ occurs, whose single column has length $1$. Contributes $0$.
- $\lambda=(6,2)$: $\beta=(2,2)$ gives $c=1$ (the unique lattice filling of $(6,2)/(4)$ is row $1=(1,1)$, row $2=(2,2)$); $\beta=(1^4)$ gives $0$, since a lattice word must open with a $1$ and the entries are distinct. Contributes $1$.
- $\lambda=(4,4)$: $c^{(4,4)}_{(2,2),(4)}=0$, because $(4,4)/(2,2)$ has two cells stacked in column $3$ that would both carry a $1$; and $(1^4)\not\subset(4,4)$. Contributes $0$.

Total $1$. Hence $[\mathrm{Sym}^2\mathcal W_5:\mathcal W_5]=1$ and $\dim(\mathrm{Sym}^3\mathcal W_5)^{SO(5)}=1$; and since $-I$ acts trivially on $\Lambda^2\mathbb R^5$, the $O(5)$-invariants are the same space. **Step 1 holds.**

*Corroboration from the record's own scripts, read but not run:* [run_invariant_dimension_deg56.py](../scripts/runs/run_invariant_dimension_deg56.py) states that degree $3$ was settled by exhaustive enumeration of loop-free contractions, "dim 2 for n>=6 (1 at n=4,5)". That agrees, and it also makes explicit that **step 1 is a genuinely $n=5$ phenomenon**: the argument has no analogue from $n=6$ on.

## 3. Step 2, the anchor, and the constant is $c=2$

The anchor is legitimate *because* of step 1: on a one-dimensional space one point with $\mathop{\mathrm{tr}}(W^3)\ne0$ pins the constant, and $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6\ne0$.

Both quoted values are consistent with [findings/conventions.md](../findings/conventions.md), and both are reproduced here in closed form. $W_{\mathbb{CP}^2}$ is self-dual with $\Lambda^2_+$-spectrum $\lambda(2,-1,-1)$ and $W_-=0$; unit norm forces $6\lambda^2=1$, so $\lambda=1/\sqrt6$ and

$$\mathop{\mathrm{tr}}(W_0^3)=\lambda^3(8-1-1)=6\cdot6^{-3/2}=\tfrac1{\sqrt6}. \qquad\checkmark$$

For the sharp, take the orthonormal self-dual frame $\omega_1^+=(\varphi_{12}+\varphi_{34})/\sqrt2$, $\omega_2^+=(\varphi_{13}-\varphi_{24})/\sqrt2$, $\omega_3^+=(\varphi_{14}+\varphi_{23})/\sqrt2$. From $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$ one gets $[\omega_1^+,\omega_2^+]=-(\varphi_{23}+\varphi_{14})=-\sqrt2\,\omega_3^+$, so $c_{123}^+=-\sqrt2$. Hamilton's $W^\#_{ab}=\tfrac12c_{a\gamma\delta}c_{b\epsilon\zeta}W_{\gamma\epsilon}W_{\delta\zeta}$, the form implemented as `sharp2` in [run_gram_identity_exact.py](../scripts/runs/run_gram_identity_exact.py), then gives, for $W$ diagonal on $\Lambda^2_+$,

$$W^\#=\mathrm{diag}(2\lambda_2\lambda_3,\;2\lambda_3\lambda_1,\;2\lambda_1\lambda_2)\ \text{ on }\Lambda^2_+,\qquad \langle W,W^\#\rangle=6\lambda_1\lambda_2\lambda_3\cdot\ldots=\tfrac2{\sqrt6},$$

against $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$. **So $c=2$, from the structure constants alone.** Hence $P(W_0)=1/\sqrt6+2/\sqrt6=3/\sqrt6=\sqrt{3/2}$, which is the quoted $\theta(W_0)=3/\sqrt6$ and agrees with the conventions file's $M(n)\ge\sqrt{3/2}$.

Padding is not a loophole here: with $W$ supported on $\Lambda^2\mathbb R^4\subset\Lambda^2\mathbb R^5$, $c_{a\gamma\delta}\ne0$ with $\gamma,\delta\in\mathfrak{so}(4)$ forces $a\in\mathfrak{so}(4)$, so $W_0^\#$ is again supported there and equals the $n=4$ sharp, the conventions file's "padding commutes with $Q$", verified at this point.

## 4. Step 3, a second anchor, with trivial kernel, that the record does not use

The anchor $W_0$ is padded, with a $7$-dimensional kernel ($\Lambda^2_-\mathbb R^4$ and $e_5\wedge\mathbb R^4$). Pinning a constant at the most degenerate point in sight is safe only because step 1 has already collapsed the space to a line. Since the kernel is this record's recurring obstruction, I pinned it again at a point with $\ker W=0$.

Take $S^2\times S^3$ Einstein at $n=5$. [findings/bounds.md](../findings/bounds.md) derives the block eigenvalues $\tfrac{\mu(n-p)}{(p-1)(n-1)}$, $\tfrac{\mu(n-q)}{(q-1)(n-1)}$ and $-\tfrac\mu{n-1}$; at $(p,q,n)=(2,3,5)$ these are $\tfrac{3\mu}4$ on $\Lambda^2V_2$ (multiplicity $1$), $\tfrac\mu4$ on $\Lambda^2V_3$ (multiplicity $3$) and $-\tfrac\mu4$ on the mixed block (multiplicity $6$). The trace vanishes, the kernel is trivial, and $\lVert W\rVert^2=\tfrac{18}{16}\mu^2=1$ gives $\mu=\tfrac{2\sqrt2}3$. Then

$$\mathop{\mathrm{tr}}(W^3)=\mu^3\tfrac{27+3-6}{64}=\tfrac{3\mu^3}8=\tfrac38\cdot\tfrac{16\sqrt2}{27}=\tfrac{2\sqrt2}9,\qquad 3\mathop{\mathrm{tr}}(W^3)=\tfrac{2\sqrt2}3 .$$

That is exactly $\Theta_5=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at $n=5$, and exactly the record's closed form $\theta=\sqrt{2(p-1)(q-1)(n-1)/(pq(n-2))}=\sqrt{16/18}$ for the sphere product. **Step 3 therefore reproduces, at a kernel-free point of completely different spectral shape, a value the record derives by a route sharing nothing with the $\mathrm{Sym}^3$ machinery.** Steps 1–3 are confirmed.

The useful restatement that falls out: on $\mathcal W_5$ the whole lemma is the purely spectral inequality

$$\mathop{\mathrm{tr}}(W^3)\;=\;\sum_\alpha\lambda_\alpha^3\;\le\;\tfrac1{\sqrt6}\quad\text{at }\lVert W\rVert=1 ,$$

which is §10's falsification target.

## 5. Step 4, the equivalence, corrected

$F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2$ by step 3. So for $W\ne0$,

$$F_5(W)\ge0\iff P(W)^2\le\tfrac32\lVert W\rVert^6\iff\lvert\theta(W)\rvert\le\sqrt{3/2},$$

and at $W=0$ both sides are $0$ while $\theta$ is undefined. Two corrections to Forms A, B and D, neither of them fatal:

1. $F_5\ge0$ is **two-sided**: it gives $\theta\ge-\sqrt{3/2}$ as well. That is a free strengthening the record does not claim, and it is also the reason the equality clause cannot be read off the certificate (§7).
2. The statement "$\theta\le\sqrt{3/2}$ **on all of $\mathcal W_5$**" needs $W\ne0$ for $\theta$ to exist. Homogeneity makes the unit-sphere and cone versions equivalent, so the intended content is right; the phrasing is loose.

Nothing here breaks at $\ker W\ne0$. $F_5\ge0$ is a polynomial statement and the sum-of-squares identity, if it holds, holds at every $W$ including every padded one. **The kernel does not obstruct steps 1–5.** It obstructs exactly one thing, the equality clause, and it does so decisively.

## 6. Step 5, what [run_n5_verify.py](../scripts/runs/run_n5_verify.py) checks, and what it does not

**What it checks, exactly and correctly:**

- $\sum_k k^2=47$ against the length of the coordinate list, for shape $(3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1)$.
- Reassembly of $16$ Hermitian blocks from the $47$ rationals, with $M_{ji}=\overline{M_{ij}}$ imposed by construction.
- The characteristic polynomial of each block over $\mathbb Q$, by Faddeev–LeVerrier, with every trace asserted real.
- Positive definiteness by the alternating-sign test on those coefficients. **The argument is sound**: $M$ Hermitian gives real roots, $(-1)^mc_m=e_m(\lambda)$, so all $(-1)^mc_m>0$ makes the coefficients of $(-1)^kp(-x)$ all positive, hence $p$ has no root $\le0$ ($c_k=(-1)^k\det M\ne0$ excludes $0$), hence $M\succ0$. Exact over $\mathbb Q$, no elimination, no floating point.
- The same test again on $(M+\mathrm{diag}\,M)/2$, the off-diagonals halved, reviewer 214's packing ambiguity, discharged by checking both rather than by the implication.

**What it does not check, and this is the finding:** *nothing about $F_5$.* Everything from `print("WHY 40 EQUATIONS GIVE AN IDENTITY…")` onward is prose. The file evaluates no sextic, reads no sample point, and never sees a cubic. And it cannot: [n5_certificate.json](../scripts/runs/n5_certificate.json) has exactly four keys (`denominator`, `point`, `shape`, `blocks`) and carries no cubic basis, no sample points and no right-hand side. So the docstring's "Verify n5_certificate.json from the file alone" is true of positive-definiteness and false of the certificate: **the object certified positive definite has no meaning inside any file this script reads.** The link from that matrix to $F_5$ lives entirely in the pipeline that produced it.

Two further observations from reading the data file itself (reading, not computing):

- The largest coordinate denominator is $49\,895\,950\,104\,000\,000$, against the `denominator` field's $100000$, which the file's own comment already explains as naming the rounding of $34$ kernel coefficients, not the point.
- The blocks are **genuinely complex**: of the $11$ off-diagonal slots, $4$ carry a nonzero imaginary part. So the Gram is Gaussian-rational Hermitian, not real symmetric.

## 7. Step 6, the GAP

The printed argument is logically correct in shape. If every row entry and $F_5$ lie in $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, and evaluation at the $40$ points is injective there, then agreement at $40$ points is identity. And the injectivity is inferred correctly: $120$ explicit invariant sextics span a subspace $S$ of dimension $\le14$; an evaluation matrix of rank $14$ forces $\dim S=14$, hence $S$ is everything and evaluation is injective on all of it. The cap and the measured rank meet.

Reading [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) confirms the premise that the earlier route got wrong: the equation is $\sum_{ij}G_{ij}B_{ij}=F_5(W)$ with $B_{ij}=\overline{c^i}^{\mathsf T}Qc^j$ **contracted over the irreducible index**, so each of the $47$ row entries really is an invariant sextic. That is the repair of the route recorded as refuted in [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py), where $\sum G_{ij}P_i\overline{P_j}$ over bare covariants was inconsistent and was killed by a single exact point.

**Where it fails is the evidence, at two places.**

*(i) The rank is floating point.* The file's own words: "gives rank 14 against a cap of 14, with a **14-decade singular value gap**". A singular-value gap is an SVD, so the rank is numerical. And this is the one place it is cheapest to fix: the argument needs only a rigorous **lower** bound of $14$, because the cap supplies the other side, exactly the structure [L62](../results.md) exploits when it says "a sampled rank is a lower bound and reduction modulo $p$ can only lower it". One mod-$p$ rank of that $40\times120$ matrix discharges the step outright. The record computed it in floats instead.

*(ii) The matrix $A$ is a rational reconstruction that nothing certifies.* [run_n5_lift.py](../scripts/runs/run_n5_lift.py) computes the $40\times47$ rows only modulo four primes near $2^{40}$, that is what the four [n5_rows_*.json](../scripts/runs/) dumps hold, then CRT-lifts and rationally reconstructs with height bound $\sqrt{M/2}$. Reconstruction above that bound returns a *wrong* rational without signalling; the script guards only the case where it returns nothing. The subsequent `assert sum(A[i][j]*xr[j]) == B[i]` is exact over $\mathbb Q$, but over the reconstructed $A$. The right-hand side $B$ **is** independently certified, [c3_rhs_is_F5.py](../scripts/reviewers/r213/c3_rhs_is_F5.py) recomputes $F_5$ over $\mathbb Q$ from the rank-4 tensor and checks each sample is a Weyl tensor, and no equivalent exists for $A$. The hold-out tests that would catch a wrong $A$ ([c3_holdout.py](../scripts/reviewers/r213/c3_holdout.py), $80$ points; [assemble_r214_freshpoint.py](../scripts/reviewers/r214/assemble_r214_freshpoint.py), $12$ points) are run **mod $p$**.

**Verdict on step 6: GAP.** The claim is strongly corroborated and is very probably true; it is not proved, and Form D's "exact rational certificate" describes something that is not on the record.

**And Form C may undercount.** [results.md:23](../results.md) names its two measured links as L87's rank and L62's value, both of which belong to the apolarity/catalecticant side. Neither is the step-6 injectivity rank or the lift of $A$. I cannot check L87 (it is in the file this brief forbids) so I flag rather than assert: **the count "two" appears to omit the two links found here.**

### 7a. Withdrawn, L59's $36$ against the certificate's $47$

*Located:* [results.md:202](../results.md) states L59's split as "$65=36+29$", and [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py) opens "solve 36 unknowns against 14 constraints", while [n5_certificate.json](../scripts/runs/n5_certificate.json) carries $47$.

*Exhibited:* over the shipped shape, $\sum_\lambda m_\lambda(m_\lambda+1)/2=36$ and $\sum_\lambda m_\lambda(m_\lambda-1)/2=11$, and $36+11=47$. So $36$ is the real-symmetric parametrisation of the same $16$ blocks and $47$ the Hermitian one, and $4$ of the extra $11$ parameters are nonzero in the shipped point.

*The opposite:* a necessary condition proved for the smaller model is implied for the larger, so L59 being met is if anything a bonus for the shipped certificate. **Withdrawn**, a cross-reference the record should state, not a defect.

### 7b. Withdrawn, "with exact rational coefficients" against a Gaussian-rational Gram

*Located:* [results.md:204](../results.md), Form B.

*Exhibited:* with $G$ Hermitian, $F_5=\sum_kd_k\lvert\ell_k\rvert^2=\sum_kd_k[(\mathop{\mathrm{Re}}\ell_k)^2+(\mathop{\mathrm{Im}}\ell_k)^2]$ with $d_k\in\mathbb Q_{>0}$, a positive rational *combination* of squares of rational cubics, not a bare sum of squares, since absorbing $\sqrt{d_k}$ leaves the plane of rationals.

*The opposite:* over $\mathbb Q$ this is the standard meaning of "sum of squares with rational coefficients". **Withdrawn.**

## 8. The equality clause, BROKEN as written

*Located.* Form A ([findings/sym3-blocks.md:326](../findings/sym3-blocks.md), quoted in the brief) and Form B ([results.md:204](../results.md)) both end "with equality exactly on that orbit", stated as a consequence, "Hence". Form C ([results.md:23](../results.md)) says of the same lemma: "the equality case is unproven and unreachable by that route".

*Exhibited concretely.* $F_5$ has even degree and depends on $W$ only through $\lVert W\rVert^2$ and $\mathop{\mathrm{tr}}(W^3)^2$, so $F_5(-W)=F_5(W)$. Now $\mathop{\mathrm{spec}}_{\Lambda^2}(W_0)=\{2,-1,-1,0^{(7)}\}/\sqrt6$, whose negation $\{-2,1,1,0^{(7)}\}/\sqrt6$ is a different multiset, so $-W_0\notin O(5)\cdot W_0$. Hence

$$Z(F_5)\;\supseteq\;\mathbb R^\times\!\cdot O(5)W_0\;\cup\;\mathbb R^\times\!\cdot O(5)(-W_0)\;\cup\;\{0\},$$

three pieces where the clause names one. Worse, and this is the structural point the conventions file already flags, "*Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically*", a positive-definite Gram gives $Z(F_5)=\bigcap_{q\in K}Z(q)$, and every cubic in $K$ vanishes on $-W_0$'s orbit the moment it vanishes on $W_0$'s. **No sum-of-squares certificate can distinguish the two orbits, and none determines $Z(F_5)$ at all**, determining it is a real-algebraic-geometry statement about the common zero locus of $K$, on which positive-definiteness is silent.

*The opposite, argued.* Read the clause as being about the inequality $\theta\le\sqrt{3/2}$ rather than about $F_5$: then $\theta(-W_0)=-\sqrt{3/2}$ is not an equality case, $\theta(0)$ does not exist, and the sentence may well be true. Under that strongest reading the defect is narrower but survives: what is wrong is the word "Hence". The equality clause is a separate statement, owed a separate proof, and reachable by no strengthening of this certificate. It is what Form C says it is, and Forms A and B contradict Form C on the record's own front page.

**Finding: [results.md:204](../results.md)'s L61 and its counterpart in [findings/sym3-blocks.md](../findings/sym3-blocks.md) should carry the equality clause as owed, in the words [results.md:23](../results.md) already uses.**

## 9. Forms A–D against each other

| | asserts $F_5\ge0$ | asserts equality on the orbit | describes the evidence as |
| --- | --- | --- | --- |
| **A** ([findings/sym3-blocks.md:326](../findings/sym3-blocks.md)) | yes | **yes, as proved** | "a sum of squares of cubics" |
| **B** ([results.md:204](../results.md)) | yes | **yes, as proved** | "with **exact rational coefficients**" |
| **C** ([results.md:23](../results.md)) | yes | **no, "unproven and unreachable by that route"** | "an inequality on a machine certificate, resting on two measured links" |
| **D** ([results.md:40](../results.md)) | yes | silent | "by an **exact rational** certificate" |

They do not state the same thing, and the disagreement is not stylistic. On the equality case, A and B contradict C. On the status of the evidence, C is right and B and D are wrong: two links are measured, and §7 argues they are not even the two C names. Form C is the only form of the four that a reader can rely on.

*Quantifier order and scope (item 2), for completeness:* nothing is distributed. The bound is over the single set $\mathcal W_5$, $F_5$ is one polynomial, and the injectivity statement quantifies over one $14$-dimensional space with one evaluation map. No supremum is split across terms sharing a variable anywhere in steps 1–6.

*Proven-on-a-subfamily, cited in general (item 4):* the $40$ sample points are a fixed-seed subfamily, and step 6 upgrades correctly from them **provided** the two links of §7 hold. That upgrade is the only place the pattern appears, and it is handled rather than elided.

## 10. What would break it, and what I did to look

By §4 the statement is equivalent to $\sum_\alpha\lambda_\alpha^3\le1/\sqrt6$ over the $\Lambda^2$-spectrum of a unit $W\in\mathcal W_5$. A falsifier is therefore a unit Weyl operator on $\mathbb R^5$ with $\mathop{\mathrm{tr}}(W^3)>1/\sqrt6=0.40824\ldots$

**The unconstrained spectral bound is far weaker than the claim**, which measures how much the Bianchi and Ricci-flat conditions are being asked to do. Over $\sum\lambda=0$, $\sum\lambda^2=1$ on $N=10$ eigenvalues, $\max\sum\lambda^3=(N-2)/\sqrt{N(N-1)}=8/\sqrt{90}=0.8433$, more than double.

I enumerated the two-eigenvalue-plus-kernel shapes in closed form. For spectrum $a$ at multiplicity $p$, $-b$ at multiplicity $q$ and $0$ at the rest, trace-freeness and normalisation give $\sum\lambda^3=a-b=(q-p)/\sqrt{pq(p+q)}$. Checking against the record's own general spectral bound [L73](../results.md), $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert=3\lvert\lambda_{\min}\rvert$ at $n=5$, which holds on all of $\mathcal W_5$ with no criticality hypothesis:

| $(p,q)$ | $\sum\lambda^3$ | $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ | status |
| --- | --- | --- | --- |
| $(1,2)$ | $1/\sqrt6=0.4082$ | $2$ | padded $W_{\mathbb{CP}^2}$ itself |
| $(1,3)$ | $2/\sqrt{12}=0.5774$ | $3$ | **clears L73 at equality, and would give $\theta=\sqrt3$** |
| $(2,6)$ | $4/\sqrt{96}=0.4082$ | $3$ | ties the record value exactly |
| $(1,4)$ and beyond | $\ge0.6708$ | $\ge4$ | excluded by L73 |
| $(2,5)$, $(2,4)$, $(3,7)$ | $\le0.3592$ | $\le2.5$ | below |

**So the record's own general bound leaves exactly one two-eigenvalue shape alive above the claimed maximum**: a unit $W\in\mathcal W_5$ with $\Lambda^2$-spectrum $(3,-1,-1,-1,0^{(6)})/\sqrt{12}$, which would give $\theta=3\cdot2/\sqrt{12}=\sqrt3>\sqrt{3/2}$ and refute L61 outright. I found no closed-form obstruction to it on the record. A naive dimension count does not exclude it either: such operators form a cone of dimension $9+\dim\mathrm{Gr}(3,9)+1=28$ inside the $55$-dimensional $S^2(\Lambda^2\mathbb R^5)$, meeting the $35$-dimensional $\mathcal W_5$ in expected dimension $8$. *That count is a screen and evidence for nothing positive*, the analogous count at $W_0$'s own shape predicts $4$ against an actual $7$, so the intersections here are not transverse.

I also checked the two families the record does carry, in closed form, and both are consistent: $\mathop{\mathrm{tr}}(W^3)=1/\sqrt6$ at padded $W_{\mathbb{CP}^2}$ and $2\sqrt2/9=0.3143$ at $S^2\times S^3$, the latter saturating L73 while sitting well below the maximum, which is why L73-saturation is not by itself a route to a falsifier.

**No falsifier was exhibited, and nothing was run.** What this section establishes is narrower and worth stating: **the certificate is genuinely load-bearing.** Every closed-form constraint on the record permits the shape that would break L61, so the lemma has no analytic corroboration at all, it stands or falls with step 6.

## Verdict

**GAP.**

- Steps 1, 2, 3 and 4 are **correct**, and steps 1–3 are now proved here from the conventions rather than asserted: the one-dimensionality by representation theory ($B_2\cong C_2$, $\mathcal W_5\cong\mathrm{Sym}^4\mathbb C^4$, Littlewood in the stable range), the constant $c=2$ from the structure constants, and the resulting $P=3\mathop{\mathrm{tr}}(W^3)$ checked at a second, kernel-free point where it returns $\Theta_5=2\sqrt2/3$ exactly. Step 4's equivalence needs $W\ne0$ and is two-sided.
- Step 5 is **exact and valid**, and certifies a matrix whose meaning appears in no file the verifying script reads.
- Step 6 is the **gap**: a floating-point rank where a mod-$p$ rank would close it, and a four-prime rational reconstruction of $A$ that nothing certifies. The right-hand side is certified over $\mathbb Q$; the coefficient matrix is not.
- The equality clause in Forms A and B is **not established and is unreachable by any sum-of-squares argument**, since $F_5$ is even and a positive-definite Gram says nothing about a zero set. Form C already says so, and Forms A, B and D should be brought to it.

**Cheapest repairs, in order.** One mod-$p$ rank of the $40\times120$ evaluation matrix discharges the injectivity link entirely. One exact-over-$\mathbb Q$ recomputation of a handful of rows of $A$, or a fifth verification prime, discharges the lift. Neither is analysis, so both wait on the standing rule; both are named here so the round can decide.
