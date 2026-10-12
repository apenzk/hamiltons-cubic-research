# $P$ as a function of two spectra

The bi-spectral identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, the $n\le5$ Lovelock syzygy that collapses it, the maximiser's position in the bi-spectral plane, and the champion split that is the crossover.

Part of [findings/INDEX.md](INDEX.md), the index that says which file to open. The live front is covered by three files; the other two are [target.md](target.md) and [bounds.md](bounds.md).

---

#### $P$ is bi-spectral: $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$

#### Gate 2 landed, Reviewers 97 and 98

Cited nowhere as settled until they land.

Let $M$ be $W$ acting on $\Lambda^2$ with $\lVert M\rVert_F=1$, spectrum $\mu$; let $\mathring W$ be the curvature operator of the second kind on $S^2_0$, spectrum $\omega$, in **Li's convention** $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ ([arXiv:2112.08465](../references/li-2021-nonnegative-second-kind/README.md) eq. (2.2)). Then

$$\theta\;=\;\tfrac32\,p_3(\mu)\;-\;\tfrac12\,p_3(\omega),\qquad \textstyle\sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

#### The index order is load-bearing

The opposite order $W_{ikjl}$ negates $\mathring W$ and turns the $-\tfrac12$ into $+\tfrac12$. The repository standardises on Li's; [run_secondkind_sign.py](../scripts/runs/run_secondkind_sign.py) is the screen.

#### Derivation

Dai–Fu's two cubic contractions are this project's two cubics:

$$\alpha:=W_{tpsq}W_{tpkl}W_{sqkl}=8\operatorname{tr}(M^3),\qquad \beta:=W_{tspq}W_{tjpl}W_{sjql}=2\langle M^\#,M\rangle,$$

exactly at every $n\ge4$ ([run_bispectral_dictionary.py](../scripts/runs/run_bispectral_dictionary.py)). [Dai–Fu Lemma 3.3](../references/dai-fu-2023-einstein-second-kind/notes.md) at $s=0$ gives $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$ and $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$, both reproduced verbatim. Substituting into $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$ gives $p_3(\omega)=p_3(\mu)-2\langle M^\#,M\rangle$, hence $\langle M^\#,M\rangle=\tfrac12(p_3(\mu)-p_3(\omega))$ and the identity. Residual $\le5\times10^{-16}$ on random Weyl tensors at $n=4$–$7$ and at every catalogued point against the record's own `Q_general` ([run_bispectral_identity.py](../scripts/runs/run_bispectral_identity.py), [run_bispectral_catalogue.py](../scripts/runs/run_bispectral_catalogue.py)).

#### What it explains

The $n=6$ isospectral family (300 tensors, identical $\Lambda^2$-spectra, $P\in\{-24,0,+24\}$), is separated by its $S^2_0$-spectra, extreme eigenvalue $\pm2/\sqrt3$ at $P=\pm24$. What distinguishes its members is the second spectrum. The crossover $n=6+2\sqrt7$ appears without being imposed: $\theta$ is $97\%$ second-kind term at $S^6\times S^6$, $87\%$ $\Lambda^2$ term at $\mathbb{CP}^4$, and exactly half-and-half at $\mathbb{CP}^2$.

#### What it does not give, and this is the honest limit

Capping the two cubics separately by Okumura reaches $4.0129$ at $n=12$ against $\theta_0(12)=1.236$, a factor $3.25$, decaying only to $3.08$ by $n=24$, so it is *worse* than fence post F2's $1.7$–$1.8\times$ ([run_bispectral_caps.py](../scripts/runs/run_bispectral_caps.py)). The coupling between the two spectra is the whole problem. What has changed is its kind: it is now a coupling between two spectra of linear images of one tensor, rather than between a spectrum and an alignment, and both images are classical operators with a literature.

#### The shared-frame majorization coupling, derived, and it loses exactly the off-diagonal mass. **GATE 2 OWED**

*Cited nowhere as settled.* In **any** orthonormal frame the two operators carry the **same** sectional curvatures on their diagonals: $M_{(ij),(ij)}=W_{ijij}$, and by [Nienhaus–Petersen–Wink Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md) $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K=(W_{ijij})_{i<j}$ and $K'=(K,d)$ for the full $\mathring W$ diagonal, Schur–Horn gives the majorizations $K\prec\mu$ and $K'\prec\omega$. **This is a genuine third piece of information about $\omega$ in the sense [post F33](fence-posts.md) demands**, since it ties $\omega$ to $\mu$ rather than being another moment of $\omega$ alone.

**Majorization by itself says nothing about $p_3$** ($t^3$ is neither convex nor concave on $\mathbb R$) and the support bounds repair exactly that. With $\omega_i\ge-m$ the function $t^3+3mt^2$ is convex on $[-m,\infty)$, and with $\mu_i\le M_+$ the function $t^3-3M_+t^2$ is concave on $(-\infty,M_+]$, so

$$p_3(\omega)\ \ge\ p_3(K')+3m\big(p_2(K')-3\big),\qquad p_3(\mu)\ \le\ p_3(K)+3M_+\big(1-p_2(K)\big),$$

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

**The penalty terms are NOT the slack.** *Gate 2, Reviewers 289 and 290, agreeing and finding it independently.* Since $p_2(\mu)=1$ and $p_2(\omega)=3$, the two penalties sum to

$$\tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2+\tfrac32m\,\lVert\mathring W_{\mathrm{off}}\rVert_F^2\;=\;\text{bound}-\theta_{\mathrm{diag}},\qquad \theta_{\mathrm{diag}}:=\tfrac32p_3(K)-\tfrac12p_3(K'),$$

**which is the gap to the diagonal surrogate $\theta_{\mathrm{diag}}$, not to $\theta$.** The remaining piece $\theta_{\mathrm{diag}}-\theta$ is carried by the same two majorizations and is **sign-indefinite** ($-0.100$ to $+0.116$ on random points), so it cannot be dropped. At padded $W_{\mathbb{CP}^2}$ the penalty sum is $3.674235$ while the true slack is $2.755676=27/(4\sqrt6)$, the two dropped terms contributing $-0.459279$ each. *The error was visible in the record's own three numbers, which did not close: $1.224745+3.674235\ne3.980421$. The script now asserts the decomposition on every point.*

**What survives, and it is stronger than what was claimed.** The bound is **exact iff both operators are diagonal in one shared frame**, and now with a proof: $f(t)=t^3+3mt^2$ has $f''=6(t+m)$ vanishing only at the endpoint, so $f$ is *strictly* convex on $[-m,\infty)$ and Hardy–Littlewood–Pólya equality forces $K'=\omega$. Reviewer 289 sharpens the consequence: on the **entire** diagonal family (generic hollow $\Lambda$, not merely the three sphere products), the coupling is not a bound but an **identity**, slack $\le5\times10^{-15}$.

**Three corrections to how strong it looked.**

- **The off-diagonal masses $\tfrac12$ and $\tfrac32$ at padded $W_{\mathbb{CP}^2}$ describe a FRAME, not the point.** Over $40$ random frames they reach $0.99$ and $2.98$ and the bound climbs to $7.2$; the coordinate frame is the best one, not a canonical one.
- **The support constants were doing the work.** With constants an argument could actually supply ($M_+\le1$ and $m\le\sqrt{2(n-2)/(n-1)}$), the bound at padded $W_{\mathbb{CP}^2}$ is $5.590$ at $n=12$, i.e. $4.52\,\theta_0$, **worse than the $4.013$ relaxation [post F33](fence-posts.md) already killed.** Reading the constants off the true spectra is not something a proof may do.
- **The coupling DOES clear [post F33](fence-posts.md)'s letter**, and saying otherwise was the wrong claim: majorization against a shared frame *is* information about $\omega$ beyond its first two moments and a support bound. It is **inert rather than absent**, a distinction the record must carry, since a later cycle told the post is unclearable will not look here.

**And it is beaten by the bounds it was meant to improve.** At padded $W_{\mathbb{CP}^2}$ the one-line bound $\tfrac32(M_++m)=2.4495$ (immediate from $\mu_i\le M_+$ and $\omega_i\ge-m$) and **[post F33](fence-posts.md)'s own moment bound $2.3779$** both beat the coupling's $3.9804$; on random Weyl tensors post F33 beats it by a factor $3.5$–$5$. *Reviewer 290. Reproduced here independently for the one-line bound: $2.449490$ against $3.980421$ at $n=8$ and $n=12$.*

**So the route-level verdict stands on better grounds:** the coupling is a tautology exactly where the conjecture is granted, and off that family it is beaten by a one-line estimate and by the relaxation it was built to improve. *Two further scope corrections from Reviewer 290: only **Schur's** half of Schur–Horn is used, not Horn's; and $K'$ is not determined by the frame alone, the $\psi$ block carries a further $O(n-1)$ of freedom, worth $0.61$ at padded $W_{\mathbb{CP}^2}$, which is why the script diagonalises it, and that choice is **provably optimal**, by Karamata applied to the convex $t^3+3mt^2$, so $3.980$ is the best of its family rather than one member of it. The frame-optimised figure on random Weyl tensors is $2.4$–$3.0\,\theta_0$, not the $3.0$–$3.8$ first recorded here, that optimiser was under-converged.* **A normalisation trap, recorded because it makes the comparison look wrong.** [Post F33](fence-posts.md) works at $\lvert W\rvert_4=1$, where $p_2(\omega)=\tfrac34$; this file works at $\lVert M\rVert_F=1$, where $p_2(\omega)=3$. Compared naively, padded $W_{\mathbb{CP}^2}$ appears to violate post F33's closed form. It does not, Reviewer 290 re-derived the $k$-atom minimum from scratch and it matches post F33 exactly once rescaled. *Any comparison across the two must carry the factor.*

[run_f2_majorization.py](../scripts/runs/run_f2_majorization.py).

#### Lemma L52, the shared-frame majorization bound, and what its equality clause needs

*Conventions: [conventions.md](conventions.md). $W\in\mathrm{Weyl}_n$ with $n\ge4$ and $\lVert M\rVert_F=1$; $M_+$ is any constant with $\mu_i\le M_+$, $m$ any constant with $\omega_i\ge-m$, both frame-independent.*

**Why it was needed.** [Lemma L50](../results.md) makes $\theta$ a function of two spectra, and the obstruction it leaves is the coupling between them. The natural coupling is that both operators carry the same sectional curvatures on their diagonals in any one frame.

**Statement.** In any orthonormal frame, $M_{(ij),(ij)}=W_{ijij}$ and $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K$ for the sectional vector and $K'$ for the $\mathring W$ diagonal **in the basis $\{\varphi_{ij},\psi_k\}$ whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, a stipulation the frame alone does not supply, since the $\psi$-block carries $O(n-1)$ of further freedom, **Schur's theorem** gives $K\prec\mu$ and $K'\prec\omega$. Majorization alone bounds nothing, $t^3$ being neither convex nor concave; with $\omega_i\ge-m$ and $\mu_i\le M_+$ the functions $t^3+3mt^2$ and $t^3-3M_+t^2$ are respectively convex on $[-m,\infty)$ and concave on $(-\infty,M_+]$, and both diagonals lie in those ranges, giving

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

**The inequality needs no Karamata.** The majorization here is the special one where $K$ is a diagonal and $\mu$ a spectrum, so $K_i=\sum_j\lvert U_{ij}\rvert^2\mu_j$ with $(\lvert U_{ij}\rvert^2)$ doubly stochastic, and Jensen gives the bound row by row, summing collapses by the column sums, with no Abel summation and no sorting. *The double stochasticity and Schur's theorem are proved and kernel-checked in [SchurMajor.lean](../lean/HamiltonsCubic/Results/SchurMajor.lean): the spectral theorem writes the diagonal as $P\mu$ with $P_{ij}=U_{ij}^2$ doubly stochastic, and a doubly stochastic image is majorised by the vector it averages.*

**The equality clause needs more than the inequality does, and it is not the clause a consumer would write.**

- **The "if" half is false without the $\psi$ stipulation above.** At a coordinate-diagonal $W$ read in the staircase basis, both operators are diagonal in one shared frame and the bound is **strict**, so *"exact if both operators are diagonal in one shared frame"* is false under the reading in which $K'$ is merely "the $\mathring W$ diagonal in the frame".
- **The "only if" half follows row by row, by counting, and needs two strictnesses rather than one.** At equality with $g$ strictly convex, Jensen is tight in every row, so $K_i=\mu_j$ wherever $P_{ij}\ne0$: the rows with $K_i=v$ put all their mass on the columns with $\mu_j=v$, and those columns receive mass only from such rows, so both counts equal the mass between the two sets and $K$ is a rearrangement of $\mu$ ([DoublyStochasticEq.lean](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean), `eq_rearrangement`, `eq_multiset`). $U$ itself need not be a permutation: a $\pi/4$ rotation inside a degenerate eigenplane is row-tight, and degenerate spectra are the standing case here. The shared frame follows in one more line: once the diagonal is the spectrum as a multiset, $\sum_iK_i^2=\sum_j\mu_j^2=\lVert M\rVert_F^2$, so every off-diagonal entry of $M$ in that basis vanishes. At L52's objects the argument needs strict convexity of $t^3+3mt^2$ and strict concavity of $t^3-3M_+t^2$ on the closed ranges.

**What it costs.** The bound is an *identity* on the entire diagonal family, which is precisely where the conjecture is already granted. **So the coupling is sharp rather than useless**, a claim that the two spectra "do not couple usefully through a shared frame" is refuted by this bound, not supported by it. What is true is narrower: the bound beats the strict one-line bound $\theta\le\tfrac32(M_++m)$ on a neighbourhood of the diagonal family (both are continuous, and it is exact there), and away from the family it can be weak, returning $3.9804$ at padded $W_{\mathbb{CP}^2}$ against $\theta=\sqrt{3/2}$, where the one-line bound gives $2.4495$.

**A second display, derived and not reproduced here.** With $s=t_F/2$ and $C=M_++m$,

$$\theta\ \le\ (t_F/2)^{3/2}\,\Theta_n+\tfrac92C\big(1-t_F/2\big),$$

**derived in [r480](../reviews/REVIEW_r480.md) and carried here on a six-digit screen alone until this round.** Its penalty half is one line of exact algebra, $\tfrac92M_+(1-s)+\tfrac92m(1-s)=\tfrac92C(1-s)$, and the six-digit agreement is that identity read at one point rather than evidence for anything.

**It is not a reduction of Conjecture A to a lower bound on $t_F$, and the reason is exact.** Since $\frac{1-u^3}{1-u^2}=\frac{1+u+u^2}{1+u}\le\tfrac32$ on $[0,1]$, the display can return $\theta\le\Theta_n$ at some $t_F<2$ only if $C\le\tfrac13\Theta_n$, and then the one-line bound already gives $\theta\le\tfrac12\Theta_n$ outright. **So the display is informative only at $t_F=2$, the granted diagonal case.** *This matches [Post F26](INDEX-traps.md), which says no bound exact at $t_F=2$ and monotone below it can close.*

**Verification.** Gate 2 corrected an error in the first form of this result: the two penalty terms are the gap to a diagonal surrogate rather than to $\theta$, and the discarded difference is sign-indefinite.



*The display above is the same identity derived in context earlier in this file; it is repeated here so the block stands alone, and any correction must touch both.*
#### The gradient form, correct with $\mathrm{pr}$ on both sides, and inert

**Gate 2 landed, Reviewers 99 and 100, agreeing: the identity is CONFIRMED, the consequence drawn from it is REFUTED.** Recorded here in its corrected form because the uncorrected one stood for a day.

The bi-spectral identity holds on all of $\mathrm{Weyl}_n$, so its gradient does too. With $\mathrm{pr}$ the orthogonal projection onto $\mathrm{Weyl}_n$, $\iota^*$ the adjoint of $W\mapsto\mathring W$, and $\iota_1^*$ the adjoint of the $\Lambda^2$ inclusion,

$$\mathrm{pr}\big(W^\#\big)=\tfrac12\,\mathrm{pr}\big(\iota_1^*(M^2)\big)-\tfrac12\,\mathrm{pr}\big(\iota^*(\mathring W^2)\big),\qquad Q(W)=\tfrac13\nabla P .$$

**Three facts the $\kappa$ programme turns on.**

- **$W^\#$ is not a Weyl tensor.** About $60\%$ of $\lVert M^\#\rVert$ lies outside $\mathrm{Weyl}_n$, so the identity is false without $\mathrm{pr}$ on the *left*: relative error $0.58$ unprojected against $5.8\times10^{-16}$ projected.
- **$Q=\nabla P/3$** (of $P$, not of $\theta$, which differs at every non-critical point), ratio $3.000000$ exactly in every component.
- **$W^2$ must mean $\iota_1^*(M^2)$**, the adjoint pullback, not the sign-extension $J(M^2)$; under the other reading the constants are $2$ and $-\tfrac12$.

**And the consequence is inert.** The claim that this writes $W^\#$ as a difference of two *positive semidefinite* squares does not survive projection: $\mathrm{pr}$ discards $40$–$69\%$ of the norm and leaves negative eigenvalues in every sample tested, $30$ of $30$. The two terms are indefinite after $\mathrm{pr}$, so no positivity is available from the form. **The identity is the gradient of the $\theta$ identity already on this page and is recovered from it by contracting with $W$**, a restatement, not new structure. *One thing it does give:* at $n=5$ the two terms are proportional, $\mathrm{pr}(\iota^*(\mathring W^2))=-3\,\mathrm{pr}(\iota_1^*(M^2))$, which is the operator-level form of the $n\le5$ collapse below.

#### The $n\le5$ syzygy: the collapse is Lovelock's identity, and it reaches $n=5$

#### Gate 2 landed, Reviewers 97 and 98

On $\mathrm{Weyl}_n$ for $n\le5$, and only there, $\beta=\tfrac12\alpha$, equivalently $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and $\theta=3\operatorname{tr}(W^3)$, so the cubic is a function of the $\Lambda^2$-spectrum alone. The mechanism:

$$\beta-\tfrac{\alpha}{2}\;=\;-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\,W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6},$$

and the generalized Kronecker delta over six indices vanishes identically when $n\le5$, Lovelock's dimensionally-dependent identity, obtained by antisymmetrising over $n+1$ indices. The constant $-64$ is verified at $n=6,7,8$ ([run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py)).

#### Lemma L50, the potential is a function of two spectra, and collapses to one only below dimension six, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

**Why it was needed.** Every route this document records that reached $P$ through the spectrum of $W$ on $\Lambda^2$ has failed, and the recorded reason was that the value lives in eigenspace *alignment*, which no spectrum sees. That diagnosis is half right. There is a second spectrum, and together the two determine $P$ exactly.

**Statement.** Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$. Let $\mathring W$ be the curvature operator of the second kind on trace-free symmetric $2$-tensors, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$. Then

$$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

The index order $iklj$ is Li's and is load-bearing: the order $ikjl$ negates $\mathring W$ and the second coefficient.

**Two links carry this lemma.** **(a) $\alpha=8\operatorname{tr}(M^3)$ and $\beta=2\langle M^\#,M\rangle$** (the step the block calls new) are proved, and kernel-checked in [L50Spectra.lean](../lean/HamiltonsCubic/Results/L50Spectra.lean). With $B_{ijkl}=\sum_{p,q}W_{ipkq}W_{jplq}$, the sharp's entries are $(M^\#)_{(ij),(kl)}=B_{ijkl}-B_{ijlk}$ (the same computation as [L209](curvature-invariants.md)'s Step 2), so with the ordered-pair doubling $\langle M^\#,M\rangle=\tfrac14\sum W_{ijkl}(B_{ijkl}-B_{ijlk})$; relabelling $k\leftrightarrow l$ turns the second sum into minus the first, leaving $\tfrac12\sum W_{ijkl}B_{ijkl}=\tfrac12\beta$. The $\alpha$ half is the same expansion of $\operatorname{tr}(M^3)$. Neither uses Bianchi. *The whole coefficient pair is that constant: with $\beta=c\sigma$ the identity reads $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$.* **(b) the generalised-Kronecker display's proportionality, derived here.** Of the $720$ permutation terms of $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}$, $640$ contract a factor with itself and vanish by Ricci-flatness, and the remaining $80$ fall into two classes, $\alpha$ with signed weight $16$ and $\gamma=W_{abcd}W_{aecf}W_{bfde}$ with $-64$ ([classify_lovelock_terms.py](../scripts/misc/classify_lovelock_terms.py), exact enumeration). Bianchi gives $\gamma=\beta-T$ and $4T=\alpha$ for $T=W_{abcd}W_{aecf}W_{bdef}$, so the contraction is $16\alpha-64\beta+16\alpha=-64(\beta-\tfrac\alpha2)$, the display. *Machine-checked in full: `gamma_eq`, `T_eq` and the vanishing at $n\le5$ as `LL_zero` in [L50Lovelock.lean](../lean/HamiltonsCubic/Results/L50Lovelock.lean); the $640$ self-contracted terms as `selfEdge_zero` in [L50Self.lean](../lean/HamiltonsCubic/Results/L50Self.lean); the $80$ survivors and the expansion $16\alpha-64\gamma$ as `LL_expand` in [L50Expand.lean](../lean/HamiltonsCubic/Results/L50Expand.lean); and the collapse on the operator, $\langle M^\#,M\rangle=2\operatorname{tr}M^3$ and $P=3\operatorname{tr}M^3$ for $n\le5$, as `sharpPair_collapse` and `Pcubic_collapse` in [L50Coord.lean](../lean/HamiltonsCubic/Results/L50Coord.lean).* **And "only there" is proved by one witness per dimension.** For a diagonal $W$ with edge weights $w_{ij}$, $W_{ijkl}=w_{ij}(\delta_{ik}\delta_{jl}-\delta_{jk}\delta_{il})$, so $\alpha=4\sum_{i,j}w_{ij}^3$ and $\beta=\sum_{i,j,m}w_{ij}w_{im}w_{jm}$. The $S^3\times S^3$ weight, $3$ inside a block and $-2$ across, has zero row sums, and padded by zeros it is a Weyl weight at every $n\ge6$ with the same sums: $\alpha=720$ and $\beta=1620$, so $\beta-\tfrac\alpha2=1260\ne0$, and $P=900$ against $3\operatorname{tr}M^3=270$. *Machine-checked as `L50_converse` in [L50Converse.lean](../lean/HamiltonsCubic/Results/L50Converse.lean).* *The splitting $S^2=S^2_0\oplus\mathbb Rg$ at a Ricci-flat $W$ is kernel-checked too: $\mathring W$ on $S^2$ is its compression to $g^\perp=S^2_0$ and kills $g$ (`Bmat_compress`, `Bmat_zero_eigen` in [L50Split.lean](../lean/HamiltonsCubic/Results/L50Split.lean)); and its spectrum on $S^2$ is $\omega$ with one extra $0$, the restriction to $S^2_0$ formed as an operator (`Bmat_spectrum_split` in [L54Spectrum.lean](../lean/HamiltonsCubic/Results/L54Spectrum.lean)).*

**Proof.** Write $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$ and $\beta=W_{tspq}W_{tjpl}W_{sjql}$ for the two cubic contractions. Expanding each in the coordinate pair basis and using only the pair symmetries gives $\alpha=8\operatorname{tr}(M^3)$ and $\beta=2\langle M^\#,M\rangle$, where $M^\#$ is Hamilton's sharp with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$. Dai–Fu's Lemma 3.3, at $s=0$ and used as the pointwise algebraic identity it is, gives $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$, hence $p_3(\omega)=p_3(\mu)-2\langle M^\#,M\rangle$. Substituting into $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$ eliminates the sharp term and yields the display. The norm relation is Lemma 3.3's second identity at $s=0$, $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$. $\square$

**The collapse, and its exact range.** **As an identity of trilinear forms** (pointwise it is false as a characterisation, padded $W_{\mathbb{CP}^2}$ collapsing at every $n$) for $n\le5$ $\beta=\tfrac12\alpha$, so $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and $\theta=3\operatorname{tr}(W^3)$ is a function of $\mu$ alone. The mechanism is Lovelock's dimensionally-dependent identity: the generalized Kronecker delta on six indices vanishes identically when $n\le5$, and

$$\beta-\tfrac{\alpha}{2}=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\,W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}.$$

This covers $n=4$ and $n=5$ by one mechanism. **It corrects a claim on this project's record** which attributed the $n=4$ collapse to the reducibility of $\mathrm{Weyl}_4$ as an $O(4)$-module and concluded it could not extend: $\mathrm{Weyl}_5$ is $O(5)$-irreducible and collapses regardless, so reducibility is not the separating fact.

**A corollary, correct only with $\mathrm{pr}$ on both sides.** Differentiating the identity gives $\mathrm{pr}(W^\#)=\tfrac12\mathrm{pr}(\iota_1^*(M^2))-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$, with $\mathrm{pr}$ the projection onto $\mathrm{Weyl}_n$ and $\iota^*,\iota_1^*$ the adjoints of $W\mapsto\mathring W$ and of the $\Lambda^2$ inclusion. **The projection on the left is not cosmetic: $W^\#$ is not a Weyl tensor**, about $60\%$ of its norm lying outside $\mathrm{Weyl}_n$. An earlier version of this document stated the identity without it, and read it as writing the sharp map as a difference of two positive semidefinite squares. **That reading is withdrawn**, $\mathrm{pr}$ discards $40$–$69\%$ of the norm and both terms are indefinite after it, in $30$ of $30$ samples. The corollary is the gradient of the identity above, recovered from it by contracting with $W$; it is a restatement rather than new structure. Reviewers 99 and 100, agreeing.

**The transfer from Dai–Fu's Einstein hypothesis to an algebraic $W$ is proved, not assumed.** The pair operator $B_{(ij),(kl)}=W_{iklj}$ is symmetric, preserves the $S^2/\Lambda^2$ splitting, restricts to $\mathring W\oplus0$ on $S^2$ (Ricci-flatness being exactly where the source's $s$-terms live) and to $-M$ on $\Lambda^2$ by first Bianchi; then $\operatorname{tr}(B^2)=\lvert W\rvert^2$ and $\operatorname{tr}(B^3)=-\beta$ give the two identities directly. *And $\sum\omega^2=3$ is forced rather than chosen: $\operatorname{tr}(\mathring W^2)/\lVert M\rVert_F^2=3$ at every $W$ and every $n$, the factor $\lvert W\rvert^2=4\lVert M\rVert_F^2$ being what converts the source's $\tfrac34\lvert W\rvert^2$.*

**Attribution.** The identity is [Dai–Fu](https://arxiv.org/abs/2311.18235) Lemma 3.3 specialised; the operator and its convention are [Li](https://arxiv.org/abs/2112.08465) eq. (2.2); the syzygy is Lovelock's. New here are the dictionary connecting their contractions to Hamilton's $\#$, and the three consequences: the isospectral separation, the exact range of the collapse, and the crossover mechanism.

**What it does not reach.** The identity supplies no bound by itself, and the honest accounting is this. Bounding $p_3(\mu)$ and $p_3(\omega)$ separately by Okumura gives $4.013$ at $n=12$ against $\theta_0(12)=1.236$, but that figure is a product of two marginal caps, and the marginals fall well short of them ($\max(-p_3(\omega))=2.405$ against a cap of $5.094$). The relaxation over the true joint moment body is $2.291$, and the two marginal maxima are **not simultaneously attainable**, the joint maximum being $57\%$ of the separate bound ($2.291$ against $4.013$). So what obstructs a moments-only bound is the *shape* of the joint body (a realisability fact) and not any missing algebraic identity. Imposing the majorization constraint $\omega\succ d$ from the frame dictionary cuts the relaxation to $2.947$, recovering $62\%$ of the gap between the separate bound and the true joint relaxation ($4.013\to2.947$ against $4.013\to2.291$); measured instead against the gap to $\theta_0(12)$ it recovers $38\%$: **the first coupling between the two spectra that demonstrably tightens the bound**, and still a factor $2.4$ short. Verified to $5\times10^{-16}$ on samples that span $\mathrm{Weyl}_n$ and at every catalogued critical point; Gate 2 passed by Reviewers 97 and 98, with the corollary and the accounting above audited by Reviewers 99 and 100.

#### The two controls that make this a result rather than a coincidence

([run_n5_syzygy.py](../scripts/runs/run_n5_syzygy.py)): the random sample provably **spans** $\mathrm{Weyl}_4$ (rank $10$) and $\mathrm{Weyl}_5$ (rank $35$), so a deficient sample is not manufacturing the identity; and it holds over $64$ **polarisations**, so it is an identity of symmetric trilinear forms, not a coincidence on the diagonal. It fails at $n=6,7$, which is what confines it.

#### This corrects [fence post F2g](fence-posts.md), which confined the collapse to $n=4$

Reviewers 97 and 98, on identical briefs, agreeing. 2g's collapse table is *right*: 97 reproduced every row of it exactly. What fails is the inference, in three separate ways.

- **A quantifier inversion.** 2g asks which fixed $T$ satisfies $\sum T\lambda\lambda\lambda=\kappa e_3$ for *all* traceless $\lambda$. Collapse needs it only at the single $\lambda(W)$ that $T(W)$ comes with. Bianchi constrains the frame *relative to* $\lambda$, $54$ dimensions of traceless operators on $\Lambda^2\mathbb R^5$ against $\dim\mathrm{Weyl}_5=35$, so nineteen conditions are discarded. What 2g proves is that constant $T$ is the only $\lambda$-uniform mechanism, which decides no dimension.
- **It never computed $n=5$.** Its table lists $N=6,7,9$; $n=5$ is $N=10$ and is absent.
- **Its driver is refuted.** 2g attributes the specialness of $n=4$ to $O(n)$-reducibility of $\mathrm{Weyl}_n$. But $\mathrm{Weyl}_5$ is $O(5)$-irreducible and collapses anyway, so irreducibility is not the separating fact. The separating fact is the rank of the Kronecker delta.

The realisable $\lambda$ at $n=5$ are **not** a proper subvariety, the spectrum map's Jacobian has rank $9$ and fills the traceless hyperplane. The slack lives in the $(\lambda,T)$ *product*. At $n=5$ the realised $T$ is manifestly non-constant, range $[0,0.67]$ with standard deviation $0.127$, and the cubic collapses regardless.


#### The maximiser's position in the bi-spectral plane, in closed form

#### Proved symbolically in $m$; the literature input is [Li 2022 Thm 1.8](../references/li-2022-product-manifolds-second-kind/README.md)

For an Einstein product, $\mathrm{spec}(\mathring R)=\mathrm{spec}(\mathring R_1)\cup\mathrm{spec}(\mathring R_2)\cup\{0^{(n_1n_2)}\}\cup\{-\tfrac{n_1\rho_2+n_2\rho_1}{n_1+n_2}\}$, verified here to $1.8\times10^{-15}$ on six sphere products built from true metrics rather than from the vertex matrix ([run_li_thm18_check.py](../scripts/runs/run_li_thm18_check.py)).

Specialising to the balanced $S^m\times S^m$ at $n=2m$ and subtracting the multiple $\frac{m-1}{2m-1}G$ of the round curvature tensor to reach the Weyl tensor, the $\omega$-spectrum is three values, derived directly in Lemma L67 below:

| eigenvalue of $\mathring W$ | multiplicity |
|---|---|
| $mA$ | $(m-1)(m+2)$ |
| $-(m-1)A$ | $m^2$ |
| $-2m(m-1)A$ | $1$ |

with $A=\dfrac1{m\sqrt{(m-1)(2m-1)}}$. The multiplicities sum to $2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$, and $\sum\omega=0$, $\sum\omega^2=3$ identically, the normalisation the identity requires. Hence

$$p_3(\mu)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad p_3(\omega)=-\frac{4m^2-6m-1}{m\sqrt{(m-1)(2m-1)}} .$$

*The $\Lambda^2$ side.* $R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$ and as $0$ on the mixed part, so $W=R-c\,\mathrm{Id}$ has eigenvalues $\frac m{2m-1}$ at multiplicity $m(m-1)$ and $-\frac{m-1}{2m-1}$ at multiplicity $m^2$. Their unnormalised sum of squares is $\frac{m^2(m-1)}{2m-1}$, a third of the $\omega$ one, so the same scale $s$ normalises both, and $p_3(\mu)=s^3\frac{m^3\cdot m(m-1)-(m-1)^3m^2}{(2m-1)^3}=s^3\frac{m^2(m-1)}{(2m-1)^2}=A$.

#### $A$ is not a new constant

it equals the record's $\operatorname{tr}(W^3)=2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at the balanced product, checked to be identically zero difference. And the identity closes symbolically,

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)-\theta_0(2m)=0\quad\text{identically in }m,$$

the residual radical resolving as $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ ([run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py)).

#### The $\omega$-spectrum settles a question the second-kind route asks, symbolically in $m$

**Proved here from the closed form above, not measured.** The bottom of the $\omega$-spectrum is the isolated eigenvalue $-2m(m-1)A$, so

$$\mu:=-\min\omega=2m(m-1)A=\frac{2\sqrt{m-1}}{\sqrt{2m-1}},\qquad\text{and}\qquad \frac{n}{n-1}\theta_0(n)\Big|_{n=2m}=\frac{2\sqrt{2m^2-3m+1}}{2m-1},$$

and these are **equal identically in $m$**, difference exactly $0$ under `radsimp`. Hence

$$\lambda=\tfrac{n-1}{n}\mu\quad\text{exactly at every balanced sphere product,}$$

which is the equality case of the second-kind projection estimate and, through the identity of [target.md](target.md), says $\mathrm{LOSS}=\mu^2/n$ there. *So the tightness observed at those points is a theorem in $m$ rather than a coincidence of the dimensions tested.*

#### What this is for

A transfer inequality between $p_3(\omega)$ and $p_3(\mu)$ has to be *sharp at this point*, and the point is now known exactly rather than measured, so the sharpness condition can be imposed as an equation in $m$ while a candidate inequality is being constructed, instead of being checked numerically afterwards. It also makes the maximiser's $\omega$-spectrum a **three-value** spectrum, which is the same structural simplicity the $\Lambda^2$ side has at the sphere products.


#### $\kappa$, the frame-optimised diagonal spread, confirmed as an object, inert as a lever

#### Lemma L94, $\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame

*Verified `HYPOTHESIS-DEBT`, repaired, [ROUND_L94](../verification/ROUND_L94.md); machine-checked in [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean).*

**Statement.** For $W$ antisymmetric in each index pair, acting on $\Lambda^2$ as $M$, let $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}W_{abab}(F)^2$ in the frame $F$ and $\kappa^2=\max_Ft_F$ over orthonormal frames. Then the maximum is attained, $\kappa^2\le2\lVert M\rVert_F^2$ with $\lVert M\rVert_F$ the Frobenius norm of the operator on $\Lambda^2$, and $\kappa^2=2\lVert M\rVert_F^2$ exactly when $W$ is coordinate-diagonal in some frame. *The $4$-tensor norm would make the bound slack by a factor $4$.*

**Proof.** In each frame, $t_F\le2\lVert M\rVert_F^2$ with equality exactly when $W$ is coordinate-diagonal in $F$, which is [L54](#lemma-l54-the-two-diagonals-and-rigidity-at-t2)'s step (3): $t_F$ is twice the squared diagonal of the operator on $\Lambda^2$ in the pair basis of $F$, and a symmetric matrix's squared diagonal is at most its squared Frobenius norm, with equality exactly when it is diagonal. **The maximum is attained** because $F\mapsto t_F$ is a polynomial in the entries of the frame and the orthonormal frames form a closed and bounded, hence compact, set. So $\kappa^2\le2\lVert M\rVert_F^2$, and $\kappa^2=2\lVert M\rVert_F^2$ holds exactly when some frame attains $2\lVert M\rVert_F^2$, which is exactly when $W$ is coordinate-diagonal in that frame. $\square$ *Only the pair antisymmetries are used.*

#### Lemma L95, $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, closed form

**Closed form, proved:** $\kappa^2(\mathbb{CP}^m)=\dfrac3{m+1}$ at every $m\ge2$. *In any orthonormal frame $F$ the sectional matrix is $K^F_{ab}=3A_{ab}^2-\frac3{2m-1}$ with $A=F^{\mathsf T}JF$ orthogonal and antisymmetric, so $\lVert K^F\rVert_F^2=9\sum_{a,b}A_{ab}^4-\frac{18m}{2m-1}$, and $\sum A_{ab}^4\le\sum A_{ab}^2=2m$ because every entry of an orthogonal matrix has $\lvert A_{ab}\rvert\le1$, with equality exactly at the $J$-adapted frames, an equality case the Lean does not type* ([r615](../reviews/REVIEW_r615.md) §2.2, [r616](../reviews/REVIEW_r616.md), independently). The adapted frame gives $\lVert K\rVert_F^2=36m(m-1)/(2m-1)$ against $\lVert W\rVert^2=48m(m-1)(m+1)/(2m-1)$ ([r101](../reviews/REVIEW_r101.md)). **Kernel-checked** as `kappaSq_CP` in [L95.lean](../lean/HamiltonsCubic/Results/L95.lean), with `CP_not_coordDiag` giving that $\mathbb{CP}^m$ is coordinate-diagonal in no frame at $m\ge2$.

**Two corrections to how it was used here.**

- **The $[0.105,1.000]$ range recorded for $\lVert K(F)\rVert_F$ on padded $W_{\mathbb{CP}^2}$ was a sampling artefact.** Minimising properly gives $\min_F\lVert K(F)\rVert_F=0$, for *every* tensor tested, the conjectured maximiser included. So the fixed-frame lemma fails for a much stronger reason than the one recorded, and the witness should be the vanishing minimum rather than a sampled range.
- **$\mathbb{CP}^m$ is not the $\kappa$-minimiser**, and is not even low-$\kappa$: random Weyl tensors reach $\kappa^2\approx0.372$ against $\mathbb{CP}^6$'s $0.4286$, and $\kappa^2(\mathbb{CP}^m)$ sits at $(2m+1)/2$ times the generic value $\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$, a *high*-spread family, $6.5\times$ generic at $n=12$. The refutation of $\theta\le C\kappa$ stands, but only against a constant **uniform in $n$**; it says nothing about a per-$n$ constant $C_n$.

**And $\mathbb{CP}^m$ was the wrong witness for a simpler reason:** $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for every $m\ge4$, by $25\%$ at $n=12$. Its small-$\kappa$ members are the ones furthest *below* threshold, so they are out of the region any bound must cover. Per $n$, $\mathbb{CP}^{n/2}$ is the lemma's **sharpness case**, ratio ascent approaches its $\theta/\kappa$ from below and never beats it.


#### Schur–Horn: what it actually consumes, and why $\kappa$ was never the missing piece

**Gate 2 landed, Reviewers 101 and 102, identical briefs, agreeing on all five verdicts.** This section is written from their corrections; three numbers the previous version carried were wrong.

[NPW Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md) gives an orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ in which $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=W_{abab}=K_{ab}$, and Schur–Horn gives $\omega\succ d$ for the diagonal $d$ in that basis.

**Correction 1: $\sum d^2=\tfrac32\lVert K\rVert_F^2$, not $\tfrac12$, a threefold undercount.** The $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf1^\perp$ (machine-checked in block form: `diag_block` in [L54Basis.lean](../lean/HamiltonsCubic/Results/L54Basis.lean) with `K_compress` and `psi_one_null` in [L54Split.lean](../lean/HamiltonsCubic/Results/L54Split.lean)), so the $\psi$'s may be taken as $K$'s eigenvectors and the $\psi$-block contributes on the same scale as the $\varphi$-block.

**With the true diagonal the bound is EXACT at the maximiser.** Since $\operatorname{tr}\mathring W=0$ and $\lVert\mathring W\rVert_F^2=3\lVert M\rVert_F^2$, at $S^6\times S^6$ the corrected $\sum d^2=3=\sum\omega^2$, which forces $\omega=d$ outright. The relaxation then returns $1.2360=\theta_0(12)$. The previously recorded $2.947$ was an artefact of using the $\varphi$-diagonal alone.

**A lower bound on $\kappa$ is worth nothing, which retires the programme before $\mathbb{CP}^m$ is consulted at all.** With $d$ constrained only by $\sum d=0$ and $\lVert d\rVert^2\ge c$ (precisely the information $\kappa$ supplies), the relaxation stays at $4.0129$ for every $c$ up to the hard ceiling $\lVert d\rVert^2\le\sum\omega^2=3$, **including at $\kappa^2=2$**. This is provable rather than numerical: the free $p_3$-minimiser $\omega^\star=(b,\dots,b,-(D-1)b)$ majorizes the flat $d_c=(a,\dots,a,-(D-1)a)$ whenever $c\le3$. So the lemma the previous cycle chased would have bought nothing had it been proved.

**What the bound does consume** is the *bulk* cumulative sums $\sum_{k\le j}d^\downarrow_k$ at $j\approx D/2$, 37 of 76 constraints active at $n=12$, with $j=40$ alone giving $3.1723$. **That** is the "$d$ constrained but not pinned" formulation, and nobody has tried to prove one.

## Post F26, one-sided improvement on the second-kind cubic cannot close, and nor can any bound that is exact at $t=2$ and monotone below it

*Registered in [INDEX-traps.md](INDEX-traps.md) as fence post F26. It has two halves: the $\mu$-side ceiling stated immediately below, and the genericity of the $t=2$ mechanism proved further down under "The joint relaxation: what survives Gate 2, and what does not".*

**The real obstruction, which neither the previous cycle nor its fence posts identified.** Independently of everything above, $\tfrac32\max p_3(\mu)=1.4657$ **already exceeds** $\theta_0(12)=1.2360$. So no improvement on the $\omega$ side alone can close the conjecture in this formulation, however sharp.

#### And the one thing that might, Schur–Horn on the $\mu$ side as well

**And the one thing that might.** $\operatorname{diag}M$ in the $\varphi$-basis of $\Lambda^2$ is *also* exactly $K$, so $\mu\succ d_\varphi$ is a second, entirely unused Schur–Horn constraint, and it takes $p_3(\mu)$ from $0.9771$ to $0.0225$ at $S^6\times S^6$. Set against the previous paragraph, **applying Schur–Horn on both sides at once is the live direction**, and it is the first thing this route has produced that attacks the $\mu$ side at all.

#### Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall

**What $d$ actually is.** $d=(d_\varphi,d_\psi)$ with $d_\varphi$ the entries $K_{ab}$ and $d_\psi=-\{\text{eigenvalues of }K\text{ on }\mathbf1^\perp\}$ ([run_both_diagonals.py](../scripts/runs/run_both_diagonals.py)). So $\sum d^2=\tfrac t2+t=\tfrac32t=\tfrac32\lVert K\rVert_F^2$ is **pure algebra**, with no diagonality of $\mathring W$ anywhere in it. **And $d$ IS the diagonal of $\mathring W$ in an orthonormal basis of $S^2_0$**, *the earlier denial here was wrong, and it mattered.* In the basis $\{E_{ab}\}\cup\{\operatorname{diag}(v_k)\}$ one has $\langle E_{ab},\mathring WE_{ab}\rangle=K_{ab}$ and $\Pi_{\mathrm{diag}}\mathring W\Pi_{\mathrm{diag}}=-K\vert_{\mathbf1^\perp}$, checked at random Weyl tensors, $n=5,6,7$, to $2\times10^{-16}$. *Gate 2, reviewer 132.* **That identification is the only justification $\omega\succ d$ has** (without it the majorization rests on measurement) and it exposes what the apparatus is: $\omega\succ d$ here is **Cauchy interlacing on one compression**, a single Rayleigh quotient with nothing in it to sharpen. *A reimplementation that picked the wrong basis inside $K$'s degenerate eigenspaces fails to reproduce the identity, which is a fact about that basis choice and not about $d$.*

**The chain it gives.** $-d_{\min}=\max\big\{\max_{a<b}(-K_{ab}),\,\mu_1(K)\big\}\ge\mu_1(K)$, and $\omega\succ d$ forces $\omega_{\min}\le d_{\min}$, hence

$$\mu=-\omega_{\min}\ \ge\ \mu_1(K).$$

*Equality holds at every sphere product tested, so the chain is tight exactly on the saturating family.*

**And the ceiling is exactly the target.** $K\mathbf1=0$ caps $\mu_1(K)\le\sqrt{t(n-2)/(n-1)}\le\sqrt{2(n-2)/(n-1)}$, and

$$\sqrt{\tfrac{2(n-2)}{n-1}}\;=\;\frac{n\,\theta_0(n)}{n-1}\qquad\textbf{identically in }n,$$

**The identity itself holds at every $n$**, substituting $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ gives it with no parity condition. **What is parity-dependent is the relevance**, since at even $n$ the value to beat is $\theta_0(n)$ and at odd $n$ it is $\Theta_n$. At odd $n$, where $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ as [conventions.md](conventions.md) fixes it, the ratio is $\mathrm{cap}^2\big/\big(\tfrac n{n-1}\Theta_n\big)^2=\tfrac{n^3-3n^2+4}{n^3-3n^2}>1$, so the cap sits strictly **above** what branch 1 needs and the coincidence fails. *Reviewer 132.*

since $\theta_0(n)$ is the value [conventions.md](conventions.md) fixes, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. Verified to $0$ at $n=6,8,10,12,20,100$. **So the ceiling this route can put under $\mu$ is precisely the value branch 1 needs to reach $\theta_0(n)$, attained only when $t=2$, which is the diagonal locus.**

**The chain CAPS $\mu$ itself, and that cap is a theorem, the earlier claim here that $\mu$ is uncapped was FALSE.** *Gate 2, reviewer 131, and it is five lines.* Let $h$ be the unit bottom eigenvector of $\mathring W$ on $S^2_0$. Every traceless symmetric $h$ is diagonal in **its own** eigenframe $F$, so $h=\mathrm{diag}(v)$ with $\sum v=0$, $\sum v^2=1$, and there

$$\langle\mathring Wh,h\rangle=\sum_{i\ne j}W_{ijji}v_iv_j=-v^{\mathsf T}K^Fv,\qquad\text{so}\qquad \mu=v^{\mathsf T}K^Fv\le\mu_1(K^F).$$

The cap $\mu_1(K^F)\le\sqrt{t_F(n-2)/(n-1)}$ holds **frame by frame**, since $K^F\mathbf1=0$ and $t_F\le2$ in every frame. Hence, unconditionally,

$$\boxed{\ \mu\ \le\ \sqrt{\tfrac{2(n-2)}{n-1}}\ =\ \frac{n\,\theta_0(n)}{n-1}\ }$$

equivalently $\tfrac{n-1}n\mu\le\theta_0(n)$, **which is the EVEN half of the second-kind projection estimate.** The estimate [target.md](target.md) leans on is $\tfrac{n-1}n\mu\le\Theta_n$, sharper at odd $n$ where $\Theta_n<\theta_0(n)$; **the two coincide at even $n$ and this cap alone does not deliver the odd half**, which the vertex-space form below supplies and that the external report (unpublished, held in the private record) proves at its line 601. *Verified here: $\mu=v^{\mathsf T}K^Fv=\mu_1(K^F)$ to machine precision at $S^3{\times}S^3$, $S^4{\times}S^4$, $S^3{\times}S^4$, with $\mu$ attaining the cap exactly at the balanced ones, and $\mu\le$ cap at random Weyl tensors, $n=5,6,7,8$.*

**The shortfall at odd $n$ is a property of this cap and not of $\Theta_n$, and a sharper cap closes it.** *The reach is not confined to even $n$, and the shortfall is not permanent.* **The cap's equality case forces $n$ even.** Writing $K=\alpha uu^{\mathsf T}+\beta(\Pi_{\mathbf1^\perp}-uu^{\mathsf T})$, which is the only shape attaining $\mu_1=\sqrt{t(n-2)/(n-1)}$, hollowness $K_{aa}=0$ forces $u_a^2$ constant, so $u=\varepsilon/\sqrt n$ with $\varepsilon_a=\pm1$, and $u\perp\mathbf1$ then forces $\sum_a\varepsilon_a=0$, **impossible at odd $n$.** So the bound is strictly slack there. **The lossy step is that the eigenvalue-spread argument discards hollowness.** Replacing it with one Cauchy--Schwarz against the vertex space $\mathcal D_n$ gives a closed form in $\sum_av_a^4$ that reproduces this cap exactly at even $n$ and yields $\tfrac{n-1}n\mu\le\Theta_n$ at odd $n$. **The file's own shortfall ratio already named that target**: $(n^2-4n+4)(n+1)=n^3-3n^2+4$ exactly, so $\frac{n^3-3n^2+4}{n^3-3n^2}$ is the square of the factor by which this cap overshoots $\tfrac n{n-1}\Theta_n$. The external report (unpublished, held in the private record) proves the estimate at both parities through a fourth-moment lemma whose $\lvert Z(h)\rvert^2$ is half $\lVert P_{\mathcal D_n}(vv^{\mathsf T})\rVert_F^2$, identically, two routes, one function. *Gate 2, [r555](../reviews/REVIEW_r555.md) and [r556](../reviews/REVIEW_r556.md).* The superseded account: The cap delivers $\tfrac{n-1}n\mu\le\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$, which is the *even* extremal value. At odd $n$ the quantity to beat is $\Theta_n$ ([conventions.md](conventions.md)) with $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$, and $\Theta_n<\theta_0(n)$ strictly:

| $n$ | $5$ | $7$ | $9$ | $11$ | $13$ | $25$ |
|---|---|---|---|---|---|---|
| $\theta_0(n)$ | $0.9797959$ | $1.1065667$ | $1.1758895$ | $1.2196734$ | $1.2498521$ | $1.3290598$ |
| $\Theta_n$ | $0.9428090$ | $1.0954451$ | $1.1710801$ | $1.2171612$ | $1.2483756$ | $1.3288665$ |
| shortfall | $0.0369869$ | $0.0111216$ | $0.0048094$ | $0.0025122$ | $0.0014765$ | $0.0001933$ |

**So the estimate lands strictly above the odd-$n$ target at every odd $n$**, the gap shrinks but never closes, and at even $n$ it is exactly zero. *This is a scope limit on the proof above, not a defect in it: what closes the dichotomy chain at even $n$ leaves a positive margin unaccounted for at odd $n$, and something other than the $\lVert K^F\rVert_F^2\le2$ budget must supply it there.* **Recorded because the estimate was stated unconditionally and the parity restriction is invisible in its statement.**

**So the vertex matrix is not a dead end here, it PROVES the projection estimate.** $\mu=\max_F\mu_1(K^F)$ is an identity, not a lossy bound: in the right frame the lower bound $\mu\ge\mu_1(K)$ is attained. *The cap is the deliverable, and reading it as the loss was the error.* Two reviewers split on this and the disagreement resolves cleanly: "no cap over all admissible $d$" is a statement about tightness in a *fixed* frame, while applying the frame-wise cap at the varying frame $F(h)$ bounds $\mu$ absolutely.

**What the chain still does NOT give is branch 1.** $\lambda\le\tfrac{n-1}n\mu$ is a different statement, and the cap bounds the *right*-hand side rather than relating it to $\lambda$.


#### Both-sided Schur–Horn: the two diagonals rebuilt, and a first attempt that does NOT settle it

**The two constraints run off the same $K$, rebuilt from the definition rather than quoted** ([run_both_diagonals.py](../scripts/runs/run_both_diagonals.py)):

- $\operatorname{diag}M$ in the $\varphi$-basis of $\Lambda^2$ is **exactly** $K_{ab}=W_{abab}$, residual $0.0$, not merely small.
- Taking the $\psi$'s as $K$'s eigenvectors on $\mathbf1^\perp$, the full $S^2_0$ diagonal has $\sum d^2=\tfrac32\lVert K\rVert_F^2$ exactly, and $\omega\succ d$ holds to $10^{-15}$.
- $K\mathbf1=0$ at $10^{-17}$, Ricci-flatness *is* the vanishing of $K$'s row sums.

**One structural consequence, and it is exact.** Write $t=\lVert K\rVert_F^2\le2$. Then $\sum d_\varphi^2=t/2$ and $\sum d^2=3t/2$, so **at $t=2$**, $\sum d^2=3=\sum\omega^2$ and $\sum d_\varphi^2=1=\sum\mu^2$. Majorization with equal sums *and* equal norms forces equality, so $\omega=d$ and $\mu=d_\varphi$ outright: at $t=2$ the relaxation is not a relaxation at all but the exact value of $\theta$ at a coordinate-diagonal $W$, **Jäger's granted diagonal case, hence $\le\theta_0(n)$ for free.** The whole question is the interior $t<2$.

**A first attempt at the interior, recorded because it is wrong in instructive ways** ([run_joint_relaxation_attempt.py](../scripts/runs/run_joint_relaxation_attempt.py)). Sweeping $t$ with $d$ taken at the shape that makes majorization weakest returned $4.0129$ at nearly every $t$, suggesting the both-sided idea is as inert as the $\kappa$ programme. **It settles nothing, for three reasons:**

1. **The worst-case $d$ it used is not realisable.** An Okumura-shaped $d_\varphi$ (one very negative entry, the rest equal), has maximum $\lvert$row sum$\rvert$ of $0.69$, $0.76$, $0.84$ at $n=6,8,12$, so it **violates Ricci-flatness** and is not a vertex matrix of any Weyl tensor. The relaxation was taken over a set that excludes the real objects in the direction that matters.
2. **It contradicts the exact fact above.** At $t=2$ the answer is *forced* to $p_3(d)$, yet the sweep reported the unconstrained value there.
3. **The optimiser failed, and this reason is a proof rather than a symptom.** The $n=6$ sweep is non-monotone in $t$, more constraint returning a larger value at $t=1.9,2.0$. **A tighter constraint cannot raise a supremum**: if $S\subseteq T$ then every bound for $T$ bounds $S$, with no hypothesis on shape, smoothness or solver. So the larger tight value is not the supremum, and the reported numbers fall without needing to identify what the solver did, SLSQP falling back to its starting point is then an explanation of a refutation already complete. *Reason 2 closes it independently: a maximum is unique as a value, so a forced answer and a reported answer that differ cannot both be it.* *Checked in [RelaxationFailure.lean](../lean/HamiltonsCubic/Results/RelaxationFailure.lean).*

**With $K$'s structure carried, the picture reverses** ([run_joint_feasibility.py](../scripts/runs/run_joint_feasibility.py)). The two inner problems have an exact test that needs no optimiser: majorization only *lower*-bounds spread and Okumura maximises $\lvert p_3\rvert$ at fixed norm, so each inner optimum equals the Okumura value **precisely when the Okumura vector majorizes the diagonal**, a cumulative-sum comparison. Over random $K$ that are hollow, symmetric and have zero row sums to $10^{-17}$:

| | $t=0.5$ | $1.0$ | $1.5$ | $1.95$ | $2.0$ |
|---|---|---|---|---|---|
| $\mu$-side Okumura feasible ($n=12$) | $0/6$ | $0/6$ | $0/6$ | $0/6$ | $0/6$ |
| worst slack | $-1.26$ | $-1.85$ | $-2.43$ | $-2.88$ | $-2.86$ |
| $\omega$-side Okumura feasible ($n=12$) | $0/6$ | $0/6$ | $0/6$ | $0/6$ | $0/6$ |
| worst slack | $-1.95$ | $-3.04$ | $-3.76$ | $-4.54$ | $-4.59$ |

**Infeasible in all $42$ cells across $n=6,8,12$**, with substantial slack, and at every $t$ including $t=0.5$. So **the joint relaxation is strictly below $4.0129$ everywhere**, the failed attempt's suggestion of inertness was an artefact of its unrealisable $d$, exactly as diagnosed.

**And the mechanism is the one Reviewer 101 identified.** The Okumura vector has one huge entry and the rest tiny and equal; a realisable $d_\varphi$ has many moderate entries, so it is the *bulk* cumulative sums at intermediate $j$ where the Okumura partial sums fall below. That is 101's "$\sum_{k\le j}d^\downarrow_k$ at $j\approx D/2$" appearing independently from the other side.

*What this does not give is a number.* Infeasibility of the extremiser bounds the relaxation below $4.0129$ without saying by how much, and $6$ random $K$ per cell is a small sample from one distribution. **The constrained optimum itself is the computation owed**, and it now has to be solved rather than read off an extremiser.


#### The joint relaxation: what survives Gate 2, and what does not

**SINGLE-AUDITED, Reviewer 103 full, Reviewer 104 killed mid-run.** The two-implementation guarantee the skill's design rests on is absent here; 103's corrections stand on one build.

**The witness needs no search.** 103's values at $n=6$ are $3.7278$, $3.5245$, $2.8097$, $1.9385$, $1.2230$ and (at $t=2$), exactly $\theta_0(6)=1.054093$, beating the record at every $t$ by $+0.14$ to $+1.37$. The beating $K$ is simply $\sqrt{t/2}\,K_{S^3\times S^3}$: **the maximisation over $K$ was the weak part, at every $t$, not only at the two entries previously quarantined.**

**The monotonicity check was not a validity gate.** Monotonicity in $t$ is a *theorem* (the vertex class is a linear space, so scaling $K$ down weakens every majorization constraint) so passing it carries no information at all. It is also one-sided: under-exploration returns spuriously *low* values, which monotonicity tolerates exactly.

**The feasibility claim is provable, and it does not hold on the $\mu$ side.** The $\psi$-block identity forces $\max d\ge\sqrt{t/((n-1)(n-2))}$, so the $\omega$-side Okumura vector fails majorization at $j=1$ for **every** vertex $K$ once $t>12(n-2)/((n+2)(n^2+n-4))$, $0.158$ at $n=6$, $0.056$ at $n=12$. The sampling question is moot. But the **$\mu$ side is feasible** at $n=6$, $t=0.25$, so "infeasible in all 42 cells" was wrong.

**The evidence was gathered where the target does not exist.** Every value above is $n=6$, and Conjecture A is *false* there, padded $W_{\mathbb{CP}^2}$ reaches $\theta=1.224745>\theta_0(6)$, as it does at $n=8,10$. Any ratio taken against $\theta_0(6)$ measures against an unattainable target.

**And the "granted case" is not granted at the dimensions in play.** Jäger's theorem covers even $n\ge16$. At $n=12,14$ the $t=2$ end reduces to the *open* diagonal problem, not a settled one, so the circularity reading is sharper than stated: the relaxation is exact exactly where the problem is still open.

**What survives, and it needs neither of the computations the cycle spent itself on.** The conclusion follows in three lines from: the relaxation is non-increasing in $t$; it equals $\theta_0$ at $t=2$; and $t=2$ holds iff $W$ is coordinate-diagonal. **The mechanism is generic**, *any* bound that is exact at $t=2$ and monotone in diagonal information is $\ge\theta_0$ at every $t<2$, with nothing specific to Schur–Horn or Okumura about it.

**Two things left open that were assumed closed.** Multi-frame is untouched: $K(F)$ is the sectional-curvature function and determines $W$, so the multi-frame family is the original problem rather than a relaxation with fixed looseness, and the frame *minimum* of the single-frame bound does not help ($1.3900$ over $40$ frames). And a single-$W$ construction, $W=c\,W_{S^m\times S^m}+\sqrt{1-c^2}\,W'$ with $K(W')=0$ to $4\times10^{-17}$, answers the question of whether $t$ must be tied to the same $W$: it must, and it makes the negative stronger.

#### Lemma L93, WITHDRAWN AS A NUMBER: it is [Lemma L55](diagonal-half.md) under a second id

*Gate 2, [r625](../reviews/REVIEW_r625.md) and [r626](../reviews/REVIEW_r626.md) on identical briefs, **both leading with the duplication and both concluding that 55 survives**. The mathematics stands; the second number does not.*

> **THE SAME STATEMENT, HYPOTHESIS FOR HYPOTHESIS**, same constant $n(n-1)(n-2)$, same perfect-matching extremiser, and both proofs using the ordered-pair reading of $t$, so **neither falls into the live normalisation collision**. **55 survives**: its block is the earlier, it is the number [results.md](../results.md) and [report/](../report/) already cite, nothing outside [findings/](.) cites 93, and 55 now carries a Gate 2 verdict.

> **`git` SHOWS THE DUPLICATE WAS MANUFACTURED BY A SWEEP THAT DENIED MANUFACTURING ONE.** The mathematics and its proof entered *this* file on 2026-08-26; the report copied that proof verbatim as Lemma 55 the same evening; on 08-31 a sweep gave it a **second** block in [diagonal-half.md](diagonal-half.md) on the note *"the mathematics has always been in this file"*, **false, the constant entered that file in that very commit, and the same commit asserted "none is duplicated"**, and on 09-02 a second sweep found the original passage unnumbered and called it 93.

> **THE TWO PROOFS ARE GENUINELY DIFFERENT ARGUMENTS, WHICH IS CORROBORATION**, and L55's is the better one: it bounds every row against the global minimum, where this one discards $n-1$ of $n$ rows and **asserts** the extremal step L55 proves.

> **THE REVIEWERS DISAGREE ON WHERE THE SUBJECT BELONGS.** [r625](../reviews/REVIEW_r625.md) keeps the block in [diagonal-half.md](diagonal-half.md), by subject fit with [L68](diagonal-half.md)'s row-norm entry caps; [r626](../reviews/REVIEW_r626.md) returns it here, where it originated, where the report files it and where it is used. **Only the file is open; the number is not.**

> **DEFECTS THIS COPY CARRIED BEYOND ITS SIBLING'S.** The displayed $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$ is the **maximising** configuration unless $\alpha<0$, unstated, off by exactly $n-2$; *"an entry of modulus at least"* does not bound $\min_{a\ne b}K_{ab}$; and the **"wrong functional" paragraph is impossible on its face**, since $\min\lvert K_{ab}\rvert\le\lvert\min K_{ab}\rvert$ always, its two lists are $\min\lvert K\rvert$ and $\max\lvert K\rvert$, contradicting the block's own claim two paragraphs above. **And "why it matters" is refuted by this file**, which states a bound $\sqrt n$ stronger eight paragraphs above.

> **THE ODD-$n$ RATIO AT $n=9$ IS WRONG ON THE RECORD, AND THREE REVIEWERS NOW AGREE.** It is $\sqrt{21/17}=1.111438$, not $1.11153$, *the exact value was already in an earlier review and the block transcribed a stalled measurement instead.* One reviewer gives the explicit witness: a matching on six vertices at $7$, a triangle at $3$, $-1$ elsewhere.

*Provenance clean in every clause: Reviewer 104 exists, its salvage holds the statement and no proof, and it landed three minutes before the block.*

#### A lower bound on the vertex matrix's most negative entry, derived

**Derived, then checked, not established by search.** Reviewer 104 reached this statement before being killed mid-run; its partial is not citable, so the proof below is this cycle's own.

**Lemma.** Let $K$ be hollow, symmetric, with zero row sums and $\lVert K\rVert_F^2=t$. Then
$$\bigl\lvert\min_{a\ne b}K_{ab}\bigr\rvert\ \ge\ \sqrt{\frac{t}{n(n-1)(n-2)}} .$$

*Proof.* Fix a row $a$. Its $M=n-1$ off-diagonal entries sum to zero and have $\sum_bK_{ab}^2=s_a$. For reals $y_1,\dots,y_M$ with $\sum y=0$ and $\sum y^2=s$, the configuration minimising $\lvert\min y\rvert$ is $M-1$ equal negatives against a single positive, $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$ **with $\alpha<0$**, the sign is load-bearing, since at $\alpha>0$ the minimum is the single entry and $\lvert\min y\rvert=(M-1)\lvert\alpha\rvert$, larger by exactly $M-1=n-2$, making it the *maximising* configuration instead. It gives $s=M(M-1)\alpha^2$ and hence $\lvert\min y\rvert\ge\sqrt{s/(M(M-1))}$. *Checked in [L93.lean](../lean/HamiltonsCubic/Results/L93.lean).* So row $a$ contains an entry of modulus at least $\sqrt{s_a/((n-1)(n-2))}$. Since $\sum_as_a=\lVert K\rVert_F^2=t$, some row has $s_a\ge t/n$. $\square$

**Why it matters:** it is the analytic replacement for the sampled feasibility sweep. Combined with the $\psi$-block identity $d_\psi=-\operatorname{spec}(K|_{\mathbf1^\perp})$ it forces $\max d$ away from zero at every vertex $K$, so the $\omega$-side Okumura extremiser fails majorization at $j=1$ for a *reason* rather than in $42$ sampled cells.

**And it is loose, by a factor that is now located** ([run_minK_lemma_check.py](../scripts/runs/run_minK_lemma_check.py)). Measured against random vertex matrices the ratio runs $1.93$, $2.99$, $4.83$ at $n=6,8,12$, and at the balanced sphere product's own $K$ it is **exactly $\sqrt n$** ($2.449=\sqrt6$, $2.828=\sqrt8$, $3.464=\sqrt{12}$). Since the sphere product has all rows equal, the step $s_a\ge t/n$ is tight there and **the entire loss is in the single-row step**: the row-level equality configuration (one large positive against equal negatives), is not what symmetry permits a vertex matrix to have. So the sharp row-level constant, not the max-row one, is what a tightened version needs.

**The bound is SHARP for even $n$, and the extremiser is a perfect matching**, Reviewers 105 and 106, independently, correcting two things this page said. Equality *forces* a perfect matching: $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere makes both steps of the proof tight at once, gives $\lVert K\rVert_F^2=n(n-1)(n-2)c^2$, and is a genuine coordinate-diagonal Weyl tensor, residual $\le8\times10^{-17}$, $t=2.000000000000$. So

$$\min_{\lVert K\rVert_F^2=t}\bigl\lvert\min_{a\ne b}K_{ab}\bigr\rvert=\sqrt{\frac{t}{n(n-1)(n-2)}}\qquad(n\text{ even}),$$

not attained at odd $n$, ratios $\sqrt{5/3}$, $1.16024$ and $\sqrt{21/17}=1.111438$ at $n=5,7,9$, **all three are the closed form $\sqrt{2n(n-2)/((2n-1)(n-3))}$**, from the sharp odd-$n$ constant $C_n=\tfrac12(n-1)(2n-1)(n-3)$ derived over the fractional perfect matching polytope of $K_n$. *The $n=9$ entry stood at $1.11153$, a stalled optimiser's value; three reviewers corrected it independently ([r608](../reviews/REVIEW_r608.md), [r625](../reviews/REVIEW_r625.md), [r626](../reviews/REVIEW_r626.md)), and the exact value had been on the record in an earlier review all along.*

**Two recorded claims were wrong.** *"The derived bound is not attained"*, it is, at every even $n$. And the extremiser comparison used the **wrong functional**: the values $0.3162$, $0.2182$, $0.1667$ quoted for the balanced sphere product are $\min_{a\ne b}\lvert K_{ab}\rvert$, not $\lvert\min_{a\ne b}K_{ab}\rvert$, whose true values are $0.2108$, $0.1637$, $0.1333$, smaller by exactly $n/(n-2)$. **Both sequences have exact closed forms**: $\min_{a\ne b}\lvert K_{ab}\rvert^2=\tfrac2{(n-1)(n-2)}$, giving $\tfrac1{10},\tfrac1{21},\tfrac1{36}$, and $\lvert\min_{a\ne b}K_{ab}\rvert^2=\tfrac{2(n-2)}{n^2(n-1)}$, giving $\tfrac2{45},\tfrac3{112},\tfrac4{225}$. **The second contains this file's own $B$-block constant**, $\tfrac2{45}$ at $n=6$ is the square bracketing $0.210818511$, so that number is $\lvert\min K\rvert$ at the balanced product. **And the first agrees with [nondegeneracy.md](nondegeneracy.md)'s boxed cubic ratio** $\operatorname{tr}(W^3)/\theta=\tfrac2{(n-1)(n-2)}$ at all three dimensions both are recorded; *whether that is an identity or an agreement over three points is open, the record giving a closed form for only one of them.* *Checked in [MinVertex.lean](../lean/HamiltonsCubic/Results/MinVertex.lean).* The exhibited witnesses $0.1732$, $0.1499$, $0.1444$ sit $34$–$174\%$ **above** the true minimum, which is the lemma bound itself; they were stalled-optimiser output whose implied vertex norms were not vertex values. *The conclusion that the sphere product is not the extremiser survives; nothing else in that paragraph did.*

#### The stability statement is REFUTED in its meaning: $\theta$ decreases, the relaxation rises

**Reviewers 105 and 106 both reproduce the numbers exactly; 106 shows what they measure.** The recorded claim was $\theta\le\theta_0(n)+O(2-\kappa^2(W))$ with slope $1.05$–$1.23$ at $n=12$. The three values $0.004204$, $0.044519$, $0.240532$ at $2-t=0.004,0.0398,0.195$ are right, **and they are values of the relaxation $R$, not of $\theta$.**

**The true behaviour has the opposite sign.** $Q(D)$ is exactly diagonal for diagonal $D$ (exact zeros at $n=5,\dots,12$), so the linear term $\langle Q(D),\Delta\rangle$ **vanishes identically** and there is no first-order degradation at all. At second order, the form's top eigenvalue on $\mathcal W_n^{\text{off}}$ is exactly $\theta_0/2$ and that eigenspace **is** the $O(n)$-orbit, dimension $pq$, principal angles $1.000000$. Deflating the orbit gives

$$\lambda'=\theta_0\,\frac{n-4}{2(n-2)},\qquad C'=-\frac{3\theta_0}{2(n-2)},$$

verified to $\le1.7\times10^{-15}$ at $n=8,10,12,14,16$. **The coefficient is $0$ in $t$ and negative in $\kappa^2$.** Confirmed directly at $n=8$: $\theta$ *falls* to $1.14451$ at $2-t=0.004$ while $R$ *rises* with slope $+1.30$.

**So the statement was reading the relaxation's slack and reporting it as $\theta$'s landscape**, which is what a maximiser requires: $\theta$ must decrease off it.

**And what remains is not new.** That $\lambda'$ is the record's own audited $L_e$ family $\lambda_m=(m-2)/(2(m-1))$, so the corrected statement is a corollary of the granted diagonal case plus one orthogonality, and at $n=12,14$ it is conditional on *this project's* diagonal result rather than on Jäger, whose theorem covers only even $n\ge16$. $n=6$ is the Morse–Bott exception, $\lambda'=\theta_0/2$ and $C'=0$, reproduced independently.

*This is the fifth route-affecting inference this session drawn from a correct computation and wrong. All five were caught at Gate 2; none by self-check.*


#### The two cubics have different champions, and that is what the crossover is

#### Numerical, by ascent, so these are lower bounds on each direction's maximum, and the identifications are evidence rather than proof

Ascent in a direction $(a,b)$ maximises $a\,p_3(\mu)+b\,p_3(\omega)$ and can only ever bound that maximum from below; multistart convergence to a named point is what is being reported ([run_bispectral_region.py](../scripts/runs/run_bispectral_region.py), six directions, six starts each).

| direction | what it maximises | where the ascent lands, $n=6,8,10$ |
|---|---|---|
| $(0,-1)$ | $-p_3(\omega)$, the second-kind cubic alone | the **balanced sphere product**, at every one of the three, and at $n=12$ |
| $(\tfrac32,-\tfrac12)$ | $\theta$ itself | $W_{\mathbb{CP}^2}$, at $\sqrt{3/2}=1.224745$ |
| $(1,0)$ | $p_3(\mu)$, the $\Lambda^2$ cubic alone | $\theta_0(6)$ at $n=6$; $\mathbb{CP}^4$'s $0.986013$ at $n=8$ |

#### The first row is the finding

At $n=6,8,10$ the maximiser of the second-kind cubic alone is the balanced sphere product, and $\theta$ evaluates there to $\theta_0(n)$ **exactly**, $1.054093$, $1.145644$, $1.200000$ against the closed form $\sqrt{2(n-1)(n-2)}/n$. Its coordinates are $p_3(\mu)=2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$, which is $\operatorname{tr}(W^3)$ at the balanced product as the record already has it, and $p_3(\omega)=3p_3(\mu)-2\theta_0(n)$.

#### So the two competitors are separated by which cubic they extremise

: $W_{\mathbb{CP}^2}$ wins the $\Lambda^2$ cubic, the balanced sphere product wins the second-kind cubic, and $\theta$ weights them $3:1$. **The crossover $n=6+2\sqrt7$ is where the sphere product's advantage on the second cubic overtakes $\mathbb{CP}^2$'s on the first**, [fence post F7](fence-posts.md) says any candidate inequality must see that crossover, and this is the first description of the record that says what changes there rather than only where.

#### The positive control passed

Below the crossover the ascent in the $\theta$ direction returns $\sqrt{3/2}$, above $\theta_0(n)$ at $n=6,8,10$, which is the known and correct answer there, not a refutation of Conjecture A, whose range is even $n\ge12$. An implementation that could not reproduce $\mathbb{CP}^2$'s win below the crossover would not be trustworthy above it.

#### $n=12$, the run that tests the route, and the falsifier did not fire

Above the crossover both directions land on the same point:

| direction | $p_3(\mu)$ | $p_3(\omega)$ | $\theta$ | |
|---|---|---|---|---|
| $(0,-1)$ | $0.022473$ | $-2.404646$ | $1.236033$ | the balanced sphere product |
| $(\tfrac32,-\tfrac12)$ | $0.022473$ | $-2.404646$ | $1.236033$ | **the same point** |

$\theta_0(12)=1.236033$ exactly, and $\dim\mathrm{Weyl}_{12}=1638$ with singular-value gap $1.6\times10^2$ against $2\times10^{-12}$. **Below the crossover the two directions have different champions; at $n=12$ they coincide**, which is what the crossover *is*, made concrete. The ascent found nothing above the line, so the route's falsifier ("a realisable pair above $\tfrac32x-\tfrac12y=\theta_0(n)$ at $n=12$") did not fire.

#### What this is and is not

Ascent bounds each direction's maximum from below, so this is consistent with Conjecture A rather than evidence for it: it says the ascent found no counterexample from these starts, which is the only thing ascent can say. What it does establish is that the reformulation is not vacuous, the supporting line touches $\mathcal R_{12}$ at the conjectured maximiser, so the geometry the route is built on is the right geometry.

#### Observation L53, the champion split

*Gate 2, [r657](../reviews/REVIEW_r657.md) and [r658](../reviews/REVIEW_r658.md) on identical briefs, **both GAP and agreeing: the tabulated landings are right, the sentences around them are not, and the whole table converts to closed form**.*

> **ROW 3 DOES NOT IDENTIFY ITS LANDING POINT, AND THE RECORD ALREADY KNEW THE COLLISION.** At **both** dimensions the $\theta$-value is degenerate between two named objects: $\theta_0(6)=\sqrt{10}/3$ is also $\theta(\mathbb{CP}^3)$ exactly, and $0.986013$ is also $\theta(S^2\times S^6)=\sqrt{35}/6$ exactly. *An earlier Gate 2 recorded this very collision, "the $\mathbb{CP}^3$ paragraph described $S^3\times S^3$, the two sharing $\theta=\sqrt{10}/3$".* **The discriminating number was computed and thrown away**: the generating script prints a $p_3(\mu)$ column and the table kept only $\theta$, **so no new run is needed to settle it.** *The mathematics forces $\mathbb{CP}^3$ if the ascent worked and records a stall if it landed on $S^3\times S^3$; and the $\theta(\mathbb{CP}^m)=\theta_0(2m)$ coincidence holds at $m=3$ alone.*

> **EVERY ENTRY IS NOW A CHECK RATHER THAN EVIDENCE.** Both reviewers derived the closed forms cold, **new to the record**: the $\Lambda^2$ Weyl spectrum of $\mathbb{CP}^m$, and
> $$p_3(\mu)\big|_{\mathbb{CP}^m}=\frac{4m^2+2m-11}{3\sqrt{3m(m^2-1)(2m-1)}},\qquad p_3(\omega)\big|_{\mathbb{CP}^m}=-\frac9{\sqrt{3m(m^2-1)(2m-1)}}.$$
> These **close the bi-spectral identity symbolically in $m$ on a second family**, with no residual radical, and reproduce this file's own independently recorded shares to the digit. *$p_3(\mu)$ at the balanced product **is** [L67](bispectral.md)'s constant $A$, the record holds both and never says so.* *Machine-checked for the layer's $W_{\mathbb{CP}^m}$: $\lVert W\rVert^2=12m(m^2-1)/(2m-1)$, $\operatorname{tr}M^3=8(m^2-1)(8m^4-24m^2+11m)/(2m-1)^3$ and $\operatorname{tr}_{S^2}\mathring W^3=-216m(m^2-1)/(2m-1)^2$, whence both displayed forms and $\theta^2(\mathbb{CP}^m)$ (`p3mu_WCPm`, `p3omega_WCPm`, `thetaSq_WCPm` in [L53CPm.lean](../lean/HamiltonsCubic/Results/L53CPm.lean)), and their combination in [L53.lean](../lean/HamiltonsCubic/Results/L53.lean)'s `bispectral_closes`.*

> **$W_{\mathbb{CP}^2}$ DOES NOT WIN THE $\Lambda^2$ CUBIC, AND THIS TABLE'S OWN ROW SHOWS IT.** Within $\mathbb{CP}^m$, $\theta$ **decreases** in $m$ while $p_3(\mu)$ rises to a maximum at $m=6$. **And the inversion the label forbids is present three lines away**, *"the maximiser is the balanced sphere product"*, under a heading saying these are lower bounds. *The script's own docstring is honest; the prose is not, and the canonical restatement contradicts itself inside one sentence.*

> **THE STATEMENT IS VACUOUS AS PRINTED**: maximisation "over $\mathcal W_n$" of a degree-3 homogeneous objective, **with the unit-sphere constraint dropped**, the canon has it, this block does not. *The header promises $n=6,8,10$ and the $n=10$ entry is absent; half the sweep is unreported, three of six directions appearing nowhere, and $(0,+1)$ was never run.*

> **THE CHAMPION SPLIT AT $n=6,8,10$ HOLDS WHEREVER $M(n)<\tfrac{13\sqrt{10}}{24}$.** A common maximiser of the two extreme directions would need $\theta\ge\tfrac{13\sqrt{10}}{24}=1.7129$, above padded $W_{\mathbb{CP}^2}$'s $\sqrt{3/2}$. *The record proves $M(n)\ge\sqrt{3/2}$ and no ceiling below $1.7129$ at these dimensions ([r649](../reviews/REVIEW_r649.md), [r1941](../reviews/REVIEW_r1941.md)), so the split is conditional on one.*

*Provenance half-false: the mathematics was born in a file since split away, and the locator is truncated mid-word, a class defect shared with two other blocks of the same commit. The table is raw booktabs with undefined macros and markdown bold inside the LaTeX, so it renders in neither; the macro leak reaches five findings files.*
Ascent in a direction $(a,b)$, maximizing $a\,p_3(\mu)+b\,p_3(\omega)$ over $\Weyl_n$ from six starts each:
\begin{center}
\begin{tabular}{@{}p{0.13\linewidth}p{0.31\linewidth}p{0.50\linewidth}@{}}
\toprule
direction & what it maximizes & where the ascent lands, $n=6,8,10$ \\
\midrule
$(0,-1)$ & the second-kind cubic alone & the **balanced sphere product**, at all three, and at $n=12$ \\
$(\tfrac32,-\tfrac12)$ & $\theta$ itself & $W_{\CP^2}$, at $\thstar=1.224745$ \\
$(1,0)$ & the $\Lambda^2$ cubic alone & $\theta_0(6)$ at $n=6$; $\CP^4$'s $0.986013$ at $n=8$ \\
\bottomrule
\end{tabular}
\end{center}


#### Lemma L54, the two diagonals, and rigidity at $t=2$

*Proof written in full at [ROUND_L54](../verification/ROUND_L54.md), audited there; the statement's earlier argument was a pointer to a numerical check.*

**Statement.** Let $W\in\mathrm{Weyl}_n$, $n\ge4$, act on $\Lambda^2$ as $M$ with $\lVert M\rVert_F=1$ and spectrum $\mu$, and let $\mathring W$ be its curvature operator of the second kind on $S^2_0$ in Li's convention, with spectrum $\omega$. Fix a frame $F$, let $K=K(F)$, $K_{ab}=W_{abab}$, and $t_F=\sum_{a\ne b}K_{ab}^2$. Take the orthonormal basis $\{\varphi_{ab}\}_{a<b}\cup\{\psi_k\}_{k<n}$ of $S^2_0$ with $\varphi_{ab}=(e_a\odot e_b)/\sqrt2$ and $\psi_k=\operatorname{diag}(v_k)$ for an orthonormal **eigenbasis** $\{v_k\}$ of $K$ on $\mathbf1^\perp$, and let $d_\varphi$, $d_\psi$, $d=(d_\varphi,d_\psi)$ be the diagonal entries of $M$ in the pair basis $\{e_a\wedge e_b\}$ and of $\mathring W$ in this basis. Then:

1. $d_\varphi=(K_{ab})_{a<b}$ for both $M$ and the $\varphi$-block of $\mathring W$, the $\psi$-block of $\mathring W$ is diagonal with $d_\psi=-(\text{eigenvalues of }K\text{ on }\mathbf1^\perp)$, and $\sum d_\varphi^2=t_F/2$, $\sum d^2=\tfrac32t_F$.
2. $\mu\succ d_\varphi$ and $\omega\succ d$.
3. $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in $F$.
4. At $t_F=2$, $\mu=d_\varphi$ and $\omega=d$ as multisets.

**Proof.** *(0) $K\mathbf1=0$*: $\sum_bK_{ab}=\sum_bW_{abab}=\mathrm{Ric}(W)_{aa}=0$, $W$ being Weyl. So $K$ preserves $\mathbf1^\perp$ and the eigenbasis exists.

*(1)* $M_{(ab),(ab)}=W_{abab}$ and $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=W_{abab}$ are [Lemma L52](#lemma-l52-the-shared-frame-majorization-bound-and-what-its-equality-clause-needs)'s statement. For diagonal traceless $h=\operatorname{diag}(v)$ the quadratic form $\langle\mathring Wh,h\rangle=-v^{\mathsf T}Kv$ is derived under [the SAME wall](#both-sided-schurhorn-and-the-vertex-matrix-budget-are-the-same-wall); polarising, $\langle\mathring W\operatorname{diag}(u),\operatorname{diag}(v)\rangle=-u^{\mathsf T}Kv$ for $u,v\perp\mathbf1$, so in the eigenbasis the $\psi$-block is $\operatorname{diag}(-\kappa_k)$ with $Kv_k=\kappa_kv_k$. Then $\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=t_F/2$ and, by (0), $\sum d_\psi^2=\sum_k\kappa_k^2=\operatorname{tr}K^2=t_F$.

*(2)* The diagonal of a real symmetric matrix in an orthonormal basis is majorized by its spectrum (Schur, 1923); $M$ has $N=\binom n2$ diagonal entries in the pair basis and $\mathring W$ has $N+n-1=\dim S^2_0$ in this basis.

*(3)* $t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$, with equality exactly when every off-diagonal entry of $M$ in the pair basis of $F$ vanishes, which is $W$ coordinate-diagonal in $F$. *[Lemma L94](#lemma-l94-kappa2le2lvert-mrvert_f2-with-equality-exactly-when-w-is-coordinate-diagonal-in-some-frame) is the maximum of this over frames.*

*(4)* **Rigidity.** If $x\succ y$ in $\mathbb R^m$ and $\sum x_i^2=\sum y_i^2$ then $x^\downarrow=y^\downarrow$: with both sorted decreasingly and $X_k,Y_k$ the partial sums, $X_k\ge Y_k$ and $X_m=Y_m$, so $\sum y_i(x_i-y_i)=\sum_{k<m}(X_k-Y_k)(y_k-y_{k+1})\ge0$ and $0=\sum x_i^2-\sum y_i^2=\sum(x_i-y_i)^2+2\sum y_i(x_i-y_i)\ge\sum(x_i-y_i)^2$. At $t_F=2$, (1) gives $\sum d_\varphi^2=1=\sum\mu^2$ and $\sum d^2=3=\sum\omega^2$, the last by [Lemma L50](#lemma-l50-the-potential-is-a-function-of-two-spectra-and-collapses-to-one-only-below-dimension-six-canonical-statement-and-proof)'s normalisation, so (2) and rigidity give the sorted equalities. *And directly*: by (3) $M$ is diagonal in the pair basis, so its spectrum is $d_\varphi$; a coordinate-diagonal $W$ has $W_{iklj}\ne0$ only when $\{i,k\}=\{l,j\}$, so $(\mathring Wh)_{ij}$ reads $h_{ij}$ alone for $i\ne j$ and $h$'s diagonal alone for $i=j$, which makes $\mathring W$ diagonal on the $\varphi$-block and equal to $-K$ on the diagonal block, hence diagonal in the eigenbasis, and its spectrum is $d$. $\square$ *Machine-checked as matrix identities, `L54_direct` in [L54Direct.lean](../lean/HamiltonsCubic/Results/L54Direct.lean).*

**The eigenbasis is load-bearing.** Nienhaus–Petersen–Wink's staircase $\psi_k$ are fixed by the frame, and they diagonalise $K$ on $\mathbf1^\perp$ only when $K$ happens to be diagonal in them: at the $n=4$ coordinate-diagonal tensor with $K_{12}=K_{34}=\tfrac12$, $K_{13}=K_{24}=-\tfrac12$, $K_{14}=K_{23}=0$, $t_F=2$ while the staircase diagonal has $\sum d^2=\tfrac32$ against $\sum\omega^2=3$.

#### Lemma L67, the second-kind spectrum of the balanced product

*Audited in [ROUND_L67](../verification/ROUND_L67.md): `PROVEN, hypotheses corrected`.*

**Statement.** Let $m\ge2$, $n=2m$, and let $W$ be the Weyl tensor of $S^m\times S^m$, normalised to $\lVert W\rVert_F=1$, the Frobenius norm of $W$ as an operator on $\Lambda^2$, with $\lvert W\rvert^2=4\lVert W\rVert_F^2$ for the sum over all four indices ([conventions.md](conventions.md)), which is $\sum\omega^2=3$ by [Lemma L50](#lemma-l50-the-potential-is-a-function-of-two-spectra-and-collapses-to-one-only-below-dimension-six-canonical-statement-and-proof)'s norm relation. With $R_{ijij}$ the sectional curvature and $\mathring W$ in Li's $iklj$ order ([conventions.md](conventions.md)), $\mathring W$ on $S^2_0$ has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where
$$A=\frac1{m\sqrt{(m-1)(2m-1)}}>0 .$$
At $m=1$ the product is flat and $W=0$.

**Proof.** Let $P_1,P_2$ be the orthogonal projections of $\mathbb R^{2m}$ onto the two factors, $G^{(a)}_{ijkl}=(P_a)_{ik}(P_a)_{jl}-(P_a)_{il}(P_a)_{jk}$ the curvature tensor of the unit sphere on factor $a$, and $G$ the same with $P_a$ replaced by the identity. Then $R=G^{(1)}+G^{(2)}$ is the curvature of the unit product, with Ricci tensor $(m-1)I$, and $W=R-cG$ with $c=\frac{m-1}{2m-1}$, since $G$ has Ricci tensor $(2m-1)I$. For $h\in S^2_0$ and $t_a=\operatorname{tr}(P_ah)$, the $iklj$ contraction gives $\mathring G^{(a)}h=P_ahP_a-t_aP_a$ and $\mathring Gh=h$, so
$$\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch .$$
It has three invariant summands, which together fill $S^2_0$ since $(m-1)(m+2)+m^2+1=2m^2+m-1=\dim S^2_0$.
- *The trace-free parts within each factor*, $h=P_ahP_a$ with $t_a=0$: $\mathring Wh=(1-c)h=\frac m{2m-1}h$, multiplicity $2\big(\binom{m+1}2-1\big)=(m-1)(m+2)$.
- *The cross block*, $h=P_1hP_2+P_2hP_1$: every term but the last vanishes, so $\mathring Wh=-\frac{m-1}{2m-1}h$, multiplicity $m^2$.
- *The line* $h=P_1-P_2$, with $t_1=m$ and $t_2=-m$: $\mathring Wh=(1-m-c)h=-\frac{2m(m-1)}{2m-1}h$, multiplicity $1$.

The unnormalised sum of squares is $\frac{m^2(m-1)}{(2m-1)^2}\big((m+2)+(m-1)+4(m-1)\big)=\frac{3m^2(m-1)}{2m-1}$, so the positive scale $s=\sqrt{(2m-1)/(m^2(m-1))}$ gives $\sum\omega^2=3$, and the eigenvalues become $mA$, $-(m-1)A$ and $-2m(m-1)A$ with $A=s/(2m-1)$. $\square$

*Li's Theorem 1.8 gives the same spectrum as a product rule, in the section on the maximiser's position in the bi-spectral plane above.*

