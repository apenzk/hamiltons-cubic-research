### Reviewer 289: the shared-frame majorization coupling of the two curvature spectra

Independent build from the brief's definitions only, in [r289.py](../scripts/reviewers/r289/r289.py). Nothing from [run_f2_majorization.py](../scripts/runs/run_f2_majorization.py) was imported, and no repo module was imported at all: the $\mathfrak{so}(n)$ structure constants, $M^\#$, the Weyl projector, the sphere products, $W_{\mathbb{CP}^2}$ and the Okumura relaxation were all rebuilt here.

## Verdict table

| Claim | Verdict | One-line reason |
|---|---|---|
| C1 | **CONFIRMED** (argument + computation) | Li's $W_{iklj}$ makes both halves true *simultaneously*; the opposite order breaks the second half and the bi-spectral identity together |
| C2 | **CONFIRMED** (argument + computation) | Schur's half of Schur–Horn, and the non-canonical $\psi_k$ cost nothing, every completion works, and diagonalising the block is *provably* the optimal one |
| C3 | **CONFIRMED** (argument) | both convexity statements and both directions are right; the support constants are legitimately available a priori, but the reported numbers use the true ones and are a best case |
| C4 | **REFUTED as stated** | the closed form is $\text{bound}-\theta_{\rm diag}$, not $\text{bound}-\theta$; the dropped term is sign-indefinite. The *"exact iff both diagonal in one shared frame"* half survives and is proved below |
| C5 | **SPLIT** | $3.980$, $\tfrac12$, $\tfrac32$, the exactness at the three sphere products and the random-tensor band all **reproduce**; the slack $3.674$ is **REFUTED** (true slack $2.7557$), and the masses $\tfrac12,\tfrac32$ hold in **one frame**, not at the point |
| C6 | **REFUTED as stated** | the coupling **does** clear post F33's literal demand, [bispectral.md](../findings/bispectral.md) line 41 says so itself, it is simply inert; and at $n=6$ it is *worse* than the relaxation post F33 killed |

## Baseline, and what validates it

$M_{(ij),(kl)}=W_{ijkl}$ on the pair basis; $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$ on $S^2_0$; $\theta$ computed **not** from the bi-spectral identity but from its definition $\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$, with

$$(R^\#)_{ab}=\sum_{\gamma\delta\varepsilon\zeta}c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta},\qquad b_{(ij)}=\tfrac1{\sqrt2}(E_{ij}-E_{ji}),$$

the overall factor pinned by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ (error $\le2.7\times10^{-15}$ at $n=4,5,6$) and cross-checked against the diagonal formula $(R^\#)_{(ij),(ij)}=\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$ (error $\le2.2\times10^{-15}$, off-diagonal exactly $0$). $\mathring W$ comes out symmetric to $1.8\times10^{-15}$ without symmetrisation, and $\sum\omega=0$, $\sum\omega^2=3$ hold at every point tested. The bi-spectral identity then reproduces the independently computed $\theta$ to $2\times10^{-15}$, so the whole apparatus is anchored to a definition rather than to the identity under audit.

## C1, CONFIRMED, and Li's order is the one that makes both halves true

By argument. With $h=\varphi_{ij}$, i.e. $h_{ij}=h_{ji}=1/\sqrt2$ and zero elsewhere, Li's convention gives $(\mathring Wh)_{ij}=\tfrac1{\sqrt2}(W_{iijj}+W_{ijij})=\tfrac1{\sqrt2}W_{ijij}$ because $W_{iijj}=0$, hence $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=2\cdot\tfrac1{\sqrt2}W_{ijij}\cdot\tfrac1{\sqrt2}=W_{ijij}$. The first half is the definition of $M$. Both are statements in *one* frame, so the coupling is real rather than an artefact of two independent bases.

By computation, at random Weyl tensors $n=5,6,7$:

| order | $\max_{i<j}\lvert\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle-W_{ijij}\rvert$ | $\theta$ from $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ vs $\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$ |
|---|---|---|
| $W_{iklj}$ (Li) | $\le5.6\times10^{-17}$ | agrees to $2\times10^{-15}$ |
| $W_{ikjl}$ | $0.25$–$0.36$ | disagrees at order one |

$\lvert M_{(ij),(ij)}-W_{ijij}\rvert$ is exactly $0$ in both, since it does not involve $\mathring W$. **The same convention makes both halves of C1 true and the bi-spectral identity true**, which is what the brief asked to be checked. Also confirmed by argument: $\mathring W$ preserves $S^2_0$ on a Weyl tensor, $\mathring W(g)_{ij}=\sum_kW_{ikkj}=-\mathrm{Ric}_{ij}=0$ and $\mathop{\mathrm{tr}}(\mathring Wh)=-\sum W_{ikil}h_{kl}=0$, so the restriction in the claim is well posed.

## C2, CONFIRMED, and the $\psi_k$ are a strength rather than a gap

The brief asks whether Schur–Horn applies to $K'$ given that the $\psi_k$ are not canonical. It does, and the non-canonicity is harmless: only **Schur's** half is used (the diagonal of a symmetric operator in any orthonormal basis is majorized by its spectrum), and it holds for *every* completion of $\{\varphi_{ij}\}$ to an orthonormal basis of $S^2_0$. Dimensions check: $\binom n2+(n-1)=\tfrac{n(n+1)}2-1=\dim S^2_0$.

Verified: over sphere products, padded $\mathbb{CP}^2$ and random Weyl tensors at $n=6,7,8$, the largest violation of any partial-sum inequality for $K\prec\mu$ and $K'\prec\omega$ is $8.6\times10^{-16}$.

**One point the record understates.** It calls diagonalising the $\psi$ block "the only basis freedom left"; that is right, and the choice is also *provably optimal*, which the record does not say. The bound depends on $d=$ the $\psi$-block diagonal only through $\sum f(d)$ with $f(t)=t^3+3mt^2$ convex, and $d$ ranges over the permutohedron of that block's eigenvalues, on which a convex sum is maximised at a vertex. So diagonalising the block is the choice that makes the $\omega$-side inequality tightest, by the same Schur–Horn already in play. It matters: at padded $W_{\mathbb{CP}^2}$ the bound is $3.9804$ with the block diagonalised and $4.5928$ with the fixed $\psi$ basis that [run_f2_majorization.py](../scripts/runs/run_f2_majorization.py) actually uses.

## C3, CONFIRMED, with the support constants labelled honestly

Re-derived independently. $f(t)=t^3+3mt^2$ has $f''(t)=6(t+m)\ge0$ on $[-m,\infty)$, and every $\omega_i$ and every $K'_i$ lies there ($K'_i$ is a diagonal entry, hence in $[\min\omega,\max\omega]$). Hardy–Littlewood–Pólya on $K'\prec\omega$ gives $\sum f(K')\le\sum f(\omega)$, i.e. $p_3(K')+3mp_2(K')\le p_3(\omega)+9m$, i.e. $p_3(\omega)\ge p_3(K')+3m(p_2(K')-3)$. A **lower** bound on $p_3(\omega)$ is what $-\tfrac12p_3(\omega)$ needs. Symmetrically $g(t)=t^3-3M_+t^2$ has $g''=6(t-M_+)\le0$ on $(-\infty,M_+]$, concavity reverses the direction, $\sum g(K)\ge\sum g(\mu)$, giving the **upper** bound on $p_3(\mu)$. Both directions are right, and the composed inequality is right. Both penalty terms are non-negative, since $p_2(K)\le1$ and $p_2(K')\le3$.

**On whether $m,M_+$ smuggle in the answer.** They do not smuggle, but the quoted numbers are a best case and the gap between the two regimes is large. Legitimately a priori: $M_+\le\lVert\mu\rVert=1$, and $m\le\sqrt{2(n-2)/(n-1)}$ by the five-line theorem already on the record ([bispectral.md](../findings/bispectral.md), reviewer 131). The bound is monotone increasing in each constant, so any valid pair works. Measured at padded $W_{\mathbb{CP}^2}$:

| constants | $n=4$ | $n=6$ | $n=12$ |
|---|---|---|---|
| true ($m=M_+=2/\sqrt6=0.8165$) | $3.9804$ | $3.9804$ | $3.9804$ |
| a priori ($M_+=1$, $m=\sqrt{2(n-2)/(n-1)}$) | $5.1543$ | $5.4022$ | $5.5901$ |

So a version of this argument that anyone could actually write down is $40\%$ weaker than the version measured. **The one place this does not bite is the diagonal family**: there the off-diagonal masses vanish, $m$ and $M_+$ drop out of the bound entirely, and exactness holds for *any* admissible constants, checked at $S^4{\times}S^4$, $S^6{\times}S^6$, $S^5{\times}S^7$ with $M_+=1,m=\sqrt3$, still exact to $10^{-15}$.

## C4, REFUTED as stated: the closed form is the slack against the wrong reference point

Derive it. Write $\theta_{\rm diag}:=\tfrac32p_3(K)-\tfrac12p_3(K')$, what the bi-spectral formula returns if the two diagonals are fed to it in place of the two spectra. Then, identically,

$$\text{bound}-\theta_{\rm diag}=\tfrac92M_+\big(1-p_2(K)\big)+\tfrac32m\big(3-p_2(K')\big)=\tfrac92M_+\lVert M_{\rm off}\rVert_F^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert_F^2 .$$

That is an algebraic identity with nothing in it: the two $p_3(K)$ terms cancel by construction. The quantity C4 names ($\text{bound}-\theta$), is

$$\text{bound}-\theta=\underbrace{\big(\theta_{\rm diag}-\theta\big)}_{\textbf{dropped}}+\tfrac92M_+\lVert M_{\rm off}\rVert_F^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert_F^2 ,$$

and the dropped term is not zero and has no sign. Measured on nine random Weyl tensors at $n=6,7,8$ it runs from $-0.0997$ to $+0.1163$; at padded $W_{\mathbb{CP}^2}$ it is $-0.9186$ at every $n$. The equivalent exact statement, which is the one the record should carry:

$$\text{bound}-\theta=\tfrac32\Big[\textstyle\sum g(K)-\sum g(\mu)\Big]+\tfrac12\Big[\sum f(\omega)-\sum f(K')\Big],$$

two manifestly non-negative majorization gaps. The claimed formula is the same thing with the $p_3$ differences deleted.

**The "exact iff both diagonal in one shared frame" half is CORRECT, and here is the proof the record does not give.** $f''(t)=6(t+m)$ vanishes only at the single point $t=-m$, so $f$ is *strictly* convex on $[-m,\infty)$; likewise $g$ is strictly concave on $(-\infty,M_+]$. Equality in Hardy–Littlewood–Pólya with a strictly convex $f$ forces $K'=\omega$ up to permutation, hence $p_2(K')=p_2(\omega)=3$, hence $\lVert\mathring W_{\rm off}\rVert_F=0$; symmetrically $\lVert M_{\rm off}\rVert_F=0$. Conversely zero off-diagonal mass makes both diagonals equal to both spectra and every step an equality.

Confirmed computationally, and **more widely than the record claims**: on generic diagonal Weyl tensors (hollow symmetric $\Lambda$ with vanishing row sums) at $n=5,6,8$, the slack is $\le5.2\times10^{-15}$ and both off-diagonal masses are $\le2.7\times10^{-15}$, so the coupling is exact on the *whole* diagonal family, not only at the three sphere products, and $\mathring W$ is diagonal in $\{\varphi_{ij},\psi_k^{\rm diag}\}$ there with a vanishing $\varphi$–$\psi$ cross block.

## C5, most of it reproduces; the slack figure is wrong and the masses need a frame

Every number below is from my own build.

**Exactness on the diagonal family: CONFIRMED and strengthened.**

| point | $\theta$ | bound | slack |
|---|---|---|---|
| $S^4\times S^4$ | $1.145643924=\theta_0(8)$ | $1.145644$ | $-1\times10^{-15}$ |
| $S^6\times S^6$ | $1.236033081=\theta_0(12)$ | $1.236033$ | $+2\times10^{-16}$ |
| $S^5\times S^7$ | $1.228239158$ | $1.228239$ | $+3\times10^{-16}$ |
| $S^3\times S^3$ | $1.054092553=\theta_0(6)$ | $1.054093$ | $-4\times10^{-16}$ |

**Padded $W_{\mathbb{CP}^2}$, everything in closed form.** In the $\mathbb{CP}^2$ coordinate frame, at $n=4,5,6,8,10,12,16$ alike: $m=M_+=2/\sqrt6$, $p_2(K)=\tfrac12$, $p_3(K)=\tfrac1{4\sqrt6}$, $p_2(K')=\tfrac32$, $p_3(K')=-\tfrac3{4\sqrt6}$. Hence

$$\lVert M_{\rm off}\rVert^2=\tfrac12,\quad\lVert\mathring W_{\rm off}\rVert^2=\tfrac32,\quad \theta=\frac{12}{4\sqrt6}=\sqrt{3/2},\quad \theta_{\rm diag}=\frac3{4\sqrt6}=\frac\theta4,$$
$$\text{bound}=\frac{39}{4\sqrt6}=3.9804208,\qquad \tfrac92M_+\lVert M_{\rm off}\rVert^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert^2=\frac{36}{4\sqrt6}=\frac9{\sqrt6}=3.6742346,$$
$$\boxed{\ \text{true slack}=\text{bound}-\theta=\frac{27}{4\sqrt6}=2.7556760\ }$$

- The masses $\tfrac12$ and $\tfrac32$: **CONFIRMED**, and $n$-independent, exactly half the total in each operator.
- The bound $3.980$: **CONFIRMED**, exactly $39/(4\sqrt6)$.
- The slack $3.674$: **REFUTED.** It is $\text{bound}-\theta_{\rm diag}$. The record's own three numbers do not close, $1.224745+3.674235=4.898979\ne3.980421$, and the discrepancy is exactly $9/(4\sqrt6)=0.918559=\tfrac34\theta$.
- The masses are a statement about **one frame**, which the record's wording omits. Over $40$ random frames at padded $W_{\mathbb{CP}^2}$: $\lVert M_{\rm off}\rVert^2$ reaches $0.9938$ ($n{=}4$), $0.9755$ ($n{=}6$), $0.9842$ ($n{=}12$) and $\lVert\mathring W_{\rm off}\rVert^2$ reaches $2.98$, $2.93$, $2.95$, with the bound climbing to $7.30$, $7.17$, $7.23$. The coordinate frame is the good one (no rotation beat it) so the figures stand as best-case measurements, but "the off-diagonal mass is exactly half at every $n$" is true of a frame, not of the point.
- The loss factor is **not** $\approx3.2$ across $n$: $\text{bound}/\theta_0(n)$ runs $4.596,\ 4.063,\ 3.776,\ 3.474,\ 3.317,\ 3.220,\ 3.108$ at $n=4,5,6,8,10,12,16$, tending to $39/(4\sqrt6\cdot\sqrt2)=2.815$. The quoted $3.2$ is the $n=12$ value.
- Random Weyl tensors: **reproduced with a wider band.** Frame-optimised over $64$–$96$ random rotations with the $\psi$ block diagonalised, nine points at $n=6,7,8$ give $\text{bound}/\theta_0$ in $[2.95,\ 4.01]$, and a tenth reaches $4.09$. So "$3.0$–$3.8$" is the middle of a sample, not a range.

**Reproducibility defect.** [run_f2_majorization.py](../scripts/runs/run_f2_majorization.py) does **not** diagonalise the $\psi$ block (it uses a fixed nested-difference diagonal basis) and its catalogue is $[4,4],[6,6],[5,7],[3,3]$ with **no** $\mathbb{CP}^2$ entry. The padded-$\mathbb{CP}^2$ figures the record attributes to it cannot be produced by running it.

## C6, REFUTED as stated, and the record contradicts itself on this exact point

The brief's C6 says the coupling "does not clear fence post F33". Post F33 asks for *"a third piece of information about $\omega$ beyond its first two moments and a support bound"*. $K'\prec\omega$ **is** that: it is a family of $\dim S^2_0$ partial-sum inequalities tying $\omega$ to $\mu$ through a shared frame, not another moment of $\omega$. [bispectral.md](../findings/bispectral.md) line 41 says so in the same paragraph (*"This is a genuine third piece of information about $\omega$ in the sense post F33 demands"*) so the record already carries the correct reading and the brief's C6 carries the wrong one. **The honest statement is: the coupling clears post F33's letter and is quantitatively inert.**

Quantified, with my own recomputation of the two-cubic Okumura relaxation that post F33 killed (it reproduces the record's figures exactly: $4.0129$ at $n=12$, ratio $3.247$; ratio $3.076$ at $n=24$):

| $n$ | post-33 relaxation | ratio to $\theta_0$ | coupled bound at padded $W_{\mathbb{CP}^2}$, true constants | with a-priori constants |
|---|---|---|---|---|
| 6 | $3.7446$ | $3.552$ | $3.9804$ | $5.4022$ |
| 8 | $3.9038$ | $3.408$ | $3.9804$ |, |
| 12 | $4.0129$ | $3.247$ | $3.9804$ ($3.220\,\theta_0$) | $5.5901$ ($4.523\,\theta_0$) |

So at $n=12$ the coupling buys $0.8\%$ against the relaxation it is meant to beat, and only with the true support constants; with constants an argument could actually supply it is **worse**. At $n=6$ and $n=8$ it is worse outright at this point.

**And the comparison is between two different kinds of object, which is the deeper problem.** $4.0129$ is a *supremum over all admissible spectra*, a theorem. $3.9804$ is the value of an expression *at one tensor*. The quantity a proof would need is $\sup_W$ of the coupled bound, and every measured value is a lower bound for it. My sampling already puts that supremum above the relaxation: at $n=6$ a random Weyl tensor has frame-optimised coupled bound $4.3048$ against a relaxation of $3.7446$. **So there is no basis for saying the coupling improves on post F33 at all**; the fair verdict is that it supplies new information which, as deployed, does not tighten the bound.

**The route-level conclusion survives, on a sharper argument than the record's.** On the diagonal family the coupling is not a bound but an *identity*, $\text{bound}=\theta$ exactly (verified on generic diagonal Weyl tensors, not merely on sphere products). So on the locus where the conjecture is granted it is a tautology, and off it, it is $\ge3\times$ loose. That is a stronger form of "sharp exactly where the problem is already solved" than a factor $3.2$ at one point.

## Corrections the record should absorb

1. [bispectral.md](../findings/bispectral.md) line 51: the boxed closed form is $\text{bound}-\theta_{\rm diag}$, not the slack. Either restate it as such, or state the true slack as the sum of the two majorization gaps $\tfrac32[\sum g(K)-\sum g(\mu)]+\tfrac12[\sum f(\omega)-\sum f(K')]$.
2. Line 53: replace "giving slack $3.674$" with **"true slack $27/(4\sqrt6)=2.7557$"**, keeping the bound $39/(4\sqrt6)=3.9804$ and $\theta=12/(4\sqrt6)=\sqrt{3/2}$ so the three numbers close.
3. Line 53: qualify the masses $\tfrac12,\tfrac32$ as holding **in the $\mathbb{CP}^2$ coordinate frame**, over random frames they reach $0.99$ and $2.98$.
4. Line 53: the loss factor is $n$-dependent, from $4.60$ at $n=4$ to $2.82$ asymptotically; $3.2$ is $n=12$.
5. Line 55: add that the exactness holds on the **entire diagonal family** and for **any** admissible support constants there, which makes the "sharp only where it is granted" reading airtight.
6. Line 55 / [ATTEMPTS.md](../ATTEMPTS.md) line 2323: record that with a-priori support constants the bound is $4.52\,\theta_0$ at padded $W_{\mathbb{CP}^2}$ at $n=12$, and that a sampled frame-optimised value of $4.30$ at $n=6$ already exceeds the post-33 relaxation $3.7446$, so the coupling is **not** an improvement on post F33 in any measured direction.
7. [run_f2_majorization.py](../scripts/runs/run_f2_majorization.py): add the $\psi$-block diagonalisation and a padded-$\mathbb{CP}^2$ entry, or stop citing it for the $\mathbb{CP}^2$ figures.

## Method note

Verified **by argument**: C1's frame identity and index order, C2's use of Schur's theorem and the optimality of diagonalising $\psi$, C3's convexity and both inequality directions, C4's identity $\text{bound}-\theta_{\rm diag}=\tfrac92M_+\lVert M_{\rm off}\rVert^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert^2$ and the strict-convexity proof of the equality case, C6's reading of post F33 against the record's own text.

Verified **by computation**: the failure of the $W_{ikjl}$ order, the majorization partial sums, the sign-indefiniteness of the dropped term, every number in C5, the exactness on generic diagonal Weyl tensors, the frame-dependence of the $\mathbb{CP}^2$ masses, the a-priori-constant table, and the Okumura relaxation cross-check.


---

## Synthesis carried in REVIEW.md

### Reviewers 289 and 290: the shared-frame majorization coupling of the two curvature spectra

Full reports in [REVIEW_r289.md](reviews/REVIEW_r289.md) and [REVIEW_r290.md](reviews/REVIEW_r290.md). Identical briefs, independent pipelines, **the same C4 falsification reached independently with the same numbers**, dropped terms $-0.459279$ each, true slack $2.755676$.

**The error and how it was visible.** The two penalty terms sum to $\text{bound}-\theta_{\mathrm{diag}}$ with $\theta_{\mathrm{diag}}=\tfrac32p_3(K)-\tfrac12p_3(K')$, not to $\text{bound}-\theta$; the difference $\theta_{\mathrm{diag}}-\theta$ is sign-indefinite and cannot be dropped. **The record's own three numbers failed to add up**, $1.224745+3.674235\ne3.980421$, which is an internal check the cycle never ran. The script now asserts the decomposition on every point it reports.

**Validated here before applying**, on this session's own code path rather than the reviewer's: the honest-constant bound is $5.590086$ at $n=12$ ($4.52\,\theta_0$) against $5.502128$ at $n=8$, confirming that the coupling is *worse* than the relaxation it was meant to improve once the support constants stop being read off the answer.

**What the corrections leave standing is stronger than the original claim.** Exactness is now proved rather than observed, $t^3+3mt^2$ is strictly convex on $[-m,\infty)$, so Hardy–Littlewood–Pólya equality forces $K'=\omega$, and it holds on the *entire* diagonal family rather than at three sphere products. So the coupling is a tautology precisely where the conjecture is already granted. **The one claim that must be restated rather than dropped**: it *does* supply information beyond post F33's two moments and support bound, and is inert rather than absent. A later cycle told the post is unclearable would not think to look here.

**Reviewer 290's decisive addition.** The coupling is not merely inert: at padded $W_{\mathbb{CP}^2}$ the one-line bound $\tfrac32(M_++m)=2.4495$ and **post F33's own moment bound $2.3779$ both beat it**, and on random Weyl tensors post F33 wins by $3.5$–$5\times$. *So the coupling loses to the relaxation it was built to improve, everywhere except the diagonal family where it is an identity.* The one-line comparison was reproduced on this session's own path: $2.449490$ against $3.980421$ at $n=8$ and $n=12$.
