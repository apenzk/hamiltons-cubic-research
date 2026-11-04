# Reviewer 631, Lemma L118, the sectional-curvature closed forms behind post F20

**Review number: r631.** Reviewer A of an independent pair on identical briefs; the other took r632 and was not read. Target: [curvature-invariants.md:31](../findings/curvature-invariants.md#L31). Cold derivation from the definitions; the block's own reasoning was read only for provenance. **Analysis only, no run of any kind was made, and no recorded $\theta$, $\Psi_3$ or $\Phi$ value was re-evaluated.** Every number below is either quoted from the record or derived by hand here.

## Verdict

**REFUTED in two clauses, and the surviving core is stronger than the block claims: the identity is a Lemma at every $n\ge4$, with $c_n=\tfrac1{144}(n-1)n(n+1)(n+2)(n+3)(n+4)$, derived below.**

| # | Clause of the block | Verdict |
|---|---|---|
| 1 | *"Gate 2, Reviewer 69 and Reviewer 70, agreeing on every number"* | **FALSE of the identity.** [r70](REVIEW_r70.md) contains no $\Phi$, no $5/72$, no $c_n$; it is [r69](REVIEW_r69.md)'s sole construction, and no reviewer has audited it until now |
| 2 | $\Psi_3$ alone does not determine $\theta$ | **CONFIRMED, and it is a theorem, not a measurement**, immediate from $a/b=-14\ne1$; the separating pair is decoration |
| 3 | $\theta=c_n\Psi_3+\tfrac5{72}\Phi$, residual $4\times10^{-16}$ | **CONFIRMED and upgraded to derived.** The form is forced by the $2$-dimensionality of the cubic invariants; both coefficients are then linear algebra, and $c_n$ has the closed form above |
| 4 | the $\Phi$ coefficient is $n$-independent | **CONFIRMED and forced**, by trace-freeness of $W$, through a Wick argument given in §4. It is currently asserted; it is provable in half a page |
| 5 | $\Phi:=\mathbb E_{x,y,z}[\sec(x,y)\sec(y,z)\sec(z,x)]$ | **REFUTED as written.** With that normalisation $\lvert\Phi\rvert\le\Psi_2=1/140$ at $n=6$, while the block's own numbers force $\Phi=14.3357$, wrong by $2\times10^3$, and the gap grows like $n^4$ |
| 6 | *"Also false at $n=4,5$"* | **REFUTED.** The same $c_n$ and the same $5/72$ satisfy the identity at $n=4$ and $n=5$; what fails there is **uniqueness**, and I check the two dimensions against [r70](REVIEW_r70.md)'s own numbers |
| 7 | $\theta=1.054092553389$ shared to $2\times10^{-16}$; $\Psi_3$ ratio exactly $13.5$ | **CONFIRMED and both are exact.** Both $\theta$ equal $\sqrt{10}/3$; the coincidence is the $n=6$ root of $n^2-7n+6=0$. The two $\Psi_3$ are $\sqrt{10}/56700$ and $\sqrt{10}/4200$ |

**The one sentence the record most needs:** the displayed identity is neither fitted nor an interpolation, it is forced, and the three integers $1050,2310,4620$ are the values of a closed form the block does not state. The label `Lemma` is right; the block's evidence for it is not.

## 1. Which reading I adopt for every symbol

[conventions.md](../findings/conventions.md) fixes the first five and is silent on the last four, so I state where each of those comes from.

| symbol | reading adopted | where fixed |
|---|---|---|
| $\mathcal W_n$, $Q$, $\#$ | as tabled | [conventions.md](../findings/conventions.md) |
| $\lVert W\rVert$ | $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)$, the $\Lambda^2$ operator trace, with $\{e_i\wedge e_j\}_{i<j}$ orthonormal, equivalently $\lvert W\rvert_4^2:=W_{ijkl}W_{ijkl}=4\lVert W\rVert^2$ | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\theta$ | $P(W)/\lVert W\rVert^3$ with $P=\langle W,Q(W)\rangle$, so at $\lVert W\rVert=1$: $\theta=T+C$, $T:=\mathop{\mathrm{tr}}(W^3)$, $C:=\langle W,W^\#\rangle$ | [conventions.md](../findings/conventions.md) |
| $\theta_0(n)$ | $\theta_0^2=2(n-1)(n-2)/n^2$; $\theta_0(6)=\sqrt{10}/3$, $\theta_0(8)=\sqrt{21}/4$ | [conventions.md](../findings/conventions.md) |
| $\sec$ | $\sec(\Sigma)=\langle W\hat B,\hat B\rangle$ at the unit decomposable bivector $\hat B$ spanning $\Sigma$, the **Weyl** sectional curvature, not the full $R$'s | [b_third_moment_refuted.py:52](../scripts/route-b/b_third_moment_refuted.py#L52). The record's own source note says the opposite, [weingart notes](../references/weingart-2017-moments-sectional-curvature/notes.md) call $\Psi_k$ "a moment of the **full** curvature tensor", and §5 below shows by exact recomputation that what was computed is the Weyl one |
| $\Psi_k$ | $\mathbb E_\Sigma[\sec(\Sigma)^k]$ over $G_2(\mathbb R^n)$ with the invariant measure, i.e. Weingart's Corollary 2.6 | [weingart notes](../references/weingart-2017-moments-sectional-curvature/notes.md), Corollary 2.6, **the only definition on the record; it is in [references/](../references/), not in [conventions.md](../findings/conventions.md)** |
| $\Psi_1,\Psi_2$ | $\Psi_1=\mathrm{scal}/(n(n-1))$, $\Psi_2=12\lVert W\rVert^2/\big((n-1)n(n+1)(n+2)\big)$ | the block itself, and [r69](REVIEW_r69.md) §6, [r70](REVIEW_r70.md) §6 |
| $\Phi$ | **defined nowhere that is consistent with its recorded value.** The two sites that state it, the block and [08-fence-posts.tex:106](../report/sections/08-fence-posts.tex#L106), give the normalised expectation, which §6 refutes. No script computes it. I therefore work with the object the record's numbers actually pin: $\Phi=16C-8T$ | derived in §3 |

**A convention note the record owes itself.** $\Psi_k$, $\Phi$ and $\sec$ are used in three files and are tabled in none, against [conventions.md](../findings/conventions.md)'s own standing rule that a needed convention is added there and quoted elsewhere. That is how the $\Phi$ defect in §6 survived: the definition lives only in prose, in two places, and the two agree with each other and with nothing else.

## 2. Provenance, the Gate 2 sentence is false of this statement

The block opens *"Gate 2, [Reviewer 69](REVIEW_r69.md) and [Reviewer 70](REVIEW_r70.md), agreeing on every number."* Checked against both reports:

- [r69](REVIEW_r69.md) §6 is headed *"Secondary REFUTED, with a construction"* and builds $\Phi$, the identity, $c_n$ and $5/72$ there for the first time. **It is the author of the statement.**
- [r70](REVIEW_r70.md) contains no occurrence of $\Phi$, of $5/72$, of $1050$, or of $c_n$ anywhere in its 86 lines. Its §6 verdict is *"Primary CONFIRMED exactly; secondary OVERSTATED and false at $n=4,5$"*, it agrees on $\Psi_1$, $\Psi_2$, the $n=4,5$ degeneracy and the transitivity remark, and it never saw the identity.
- Both reports were filed on 2026-08-23 and moved into [reviews/](.) on 2026-08-24 (`e43fa60a`); the L118 block is later, from the audit commits `cfc0c790` / `595f4444` on [curvature-invariants.md](../findings/curvature-invariants.md).

So [INDEX-results.md:136](../findings/INDEX-results.md#L136) is right to carry **"Gate 2: no verdict on the record"** for result 118, and the block's opening sentence contradicts the index. An author is not a reviewer: this pair is the first audit. **The sentence should read that the closed forms are r69's construction, confirmed in part by r70.**

## 3. The identity is derived, not fitted

### 3.1 The form is forced

Three facts, none of them numerical.

1. $\theta$, $\Psi_3$ and $\Phi$ are all $O(n)$-invariant polynomials of degree $3$ on $\mathcal W_n$. For $\theta$ this is [conventions.md](../findings/conventions.md)'s definition; for $\Psi_3$ and $\Phi$ it is immediate, since $\sec$ is an $O(n)$-equivariant function of $(W,\Sigma)$ and the measures on $G_2(\mathbb R^n)$ and on $(S^{n-1})^3$ are $O(n)$-invariant.
2. The space of $O(n)$-invariant cubics on $\mathcal W_n$ is **$2$-dimensional for $n\ge6$**, spanned by $T=\mathop{\mathrm{tr}}(W^3)$ and $C=\langle W,W^\#\rangle$. This is the classical count of full contractions of $W^{\otimes3}$ and is the fact the record already leans on at [weingart notes:9](../references/weingart-2017-moments-sectional-curvature/notes.md#L9).
3. Hence any two of $\{\theta,\Psi_3,\Phi\}$ that are linearly independent span the plane, and the third is a **determined** combination of them. Independence is exactly what the recorded ratios say: writing $\Psi_3=b_3(-14\,T+C)$ and $\Phi=b_\Phi(-\tfrac12T+C)$, the two directions differ because $-14\ne-\tfrac12$.

So the existence of the identity, and the uniqueness of its two coefficients, is a spanning argument. **Nothing is fitted; a fit was used to read off constants that a contraction determines.** Given the two ratios, solving $c\,b_3(-14,1)+d\,b_\Phi(-\tfrac12,1)=(1,1)$ in the basis $(T,C)$ gives

$$c\,b_3=-\tfrac19,\qquad d\,b_\Phi=\tfrac{10}9,$$

so $c_n=-1/(9b_3(n))$ and $d_n=10/(9b_\Phi(n))$: **the two coefficients are the two normalisations of $\Psi_3$ and $\Phi$ and nothing else.** Equivalently, on the record's own numbers,

$$c_n\Psi_3=\tfrac{14}9T-\tfrac19C,\qquad \tfrac5{72}\Phi=\tfrac{10}9C-\tfrac59T,$$

whose sum is $T+C=\theta$ identically. Screen of the first at the block's own two points, using the values in [b_third_moment_refuted.py:47–49](../scripts/route-b/b_third_moment_refuted.py#L47): $\tfrac{14}9(0.105409)-\tfrac19(0.948683)=0.058560=1050\Psi_3(S^3{\times}S^3)$, and $\tfrac{14}9(0.544614)-\tfrac19(0.509478)=0.790457=1050\Psi_3(\mathbb{CP}^3)$. Both agree with the recorded $\Psi_3$ to the digits the record prints.

### 3.2 The closed form for $c_n$

The block gives $c_n=1050,2310,4620$ at $n=6,7,8$ and stops. The closed form is

$$\boxed{\,c_n=\frac{(n-1)\,n\,(n+1)(n+2)(n+3)(n+4)}{144}=\frac{[n+4]_6}{144}\,}$$

at $n=6,7,8$: $151200/144=1050$, $332640/144=2310$, $665280/144=4620$. **And it is derived, not fitted**, from the definition of $\Psi_k$ the record already carries.

Weingart's Corollary 2.6, quoted at [weingart notes:17](../references/weingart-2017-moments-sectional-curvature/notes.md#L17), defines $\Psi^V_k(R)=\dfrac{(-\Delta_g)^k(\cdots)_0}{[m+2k-2]_{2k}}$. The numerator is a universal contraction of $R^{\otimes k}$ with **no dependence on $m$**, and the whole $m$-dependence is the falling factorial $[m+2k-2]_{2k}=(m-1)m(m+1)\cdots(m+2k-2)$. So

$$\Psi_k(W)=\frac{N_k(W)}{(n-1)n\cdots(n+2k-2)},\qquad N_k \text{ independent of } n .$$

That is visible twice in the record already: $\Psi_1=\mathrm{scal}/\big((n-1)n\big)$ and $\Psi_2=12\lVert W\rVert^2/\big((n-1)n(n+1)(n+2)\big)$, the same denominators at $k=1,2$, with $n$-free numerators $\mathrm{scal}$ and $12\lVert W\rVert^2$. At $k=3$ the denominator is therefore $(n-1)n(n+1)(n+2)(n+3)(n+4)$, and since $c_n=-1/(9b_3)$ with $b_3$ the $C$-coefficient of $\Psi_3$, $c_n$ is that denominator times an absolute constant. One recorded value fixes the constant: $c_6=1050$ gives $144$.

The same statement without Weingart: for Gaussian $x,y\sim N(0,I_n)$ the plane $\mathrm{span}(x,y)$ is independent of the Gram matrix $G$, so $\mathbb E\big[W(x,y,y,x)^k\big]=\mathbb E[\det G^k]\cdot\Psi_k$, and the Wishart determinant moment is $\mathbb E[\det G^k]=4^k\frac{\Gamma(\frac n2+k)\Gamma(\frac{n-1}2+k)}{\Gamma(\frac n2)\Gamma(\frac{n-1}2)}=(n-1)n(n+1)\cdots(n+2k-2)$, $n(n-1)$ at $k=1$, $(n-1)n(n+1)(n+2)$ at $k=2$, $[n+4]_6$ at $k=3$. **The block's own phrase "computed by Wick sums" is this calculation**; the denominator it produces is the closed form the block omits.

Hence, in full,

$$\Psi_3(W)=\frac{16\big(14\mathop{\mathrm{tr}}(W^3)-\langle W,W^\#\rangle\big)}{(n-1)n(n+1)(n+2)(n+3)(n+4)} .$$

**Checked against four independent recorded numbers, none of them used to build it:**

| check | closed form gives | record has |
|---|---|---|
| $\Psi_3(S^3\times S^3)$, $n=6$ | $16(14\cdot0.1054093-0.9486833)/151200=5.577209277\times10^{-5}$ | $5.577209277193\times10^{-5}$ ([r69](REVIEW_r69.md)) |
| $\Psi_3(\mathbb{CP}^3)$, $n=6$ | $16(14\cdot0.5446137-0.5094789)/151200=7.529232524\times10^{-4}$ | $7.529232524210\times10^{-4}$ ([r69](REVIEW_r69.md)) |
| $\Psi_3/\theta$ at $n=4$, where $C=2T$ | $16\cdot12T/20160=\theta/315$ | $\theta/315$ ([r70](REVIEW_r70.md) §6) |
| $\Psi_3/\theta$ at $n=5$, where $C=2T$ | $16\cdot12T/60480=\theta/945$ | $\theta/945$ ([r70](REVIEW_r70.md) §6) |

The last two are dimensions the block declares the identity *fails* at, and the closed form predicts [r70](REVIEW_r70.md)'s numbers there exactly. See §7.

### 3.3 Independent confirmation of the framework at $k=2$

The one step above that is quoted rather than derived is the $n$-freeness of $N_k$. Here it is at $k=2$, by hand, in the record's normalisation. Write $S=W(x,y,y,x)=W_{ijkl}x_iy_jy_kx_l$ for $x,y\sim N(0,I_n)$ independent. Then

$$\mathbb E[S^2]=W_{ijkl}W_{pqrs}\,\mathbb E[x_ix_lx_px_s]\,\mathbb E[y_jy_ky_qy_r].$$

Isserlis gives three pairings on each factor. **The pairings $\delta_{il}$, $\delta_{ps}$, $\delta_{jk}$, $\delta_{qr}$ each contract two slots of a single $W$ and vanish, because $W$ is totally trace-free**; only $(\delta_{ip}\delta_{ls}+\delta_{is}\delta_{lp})(\delta_{jq}\delta_{kr}+\delta_{jr}\delta_{kq})$ survives, giving $W_{ijkl}\big[W_{ijkl}+W_{ikjl}+W_{ljki}+W_{lkji}\big]$. The pair and antisymmetry relations give $W_{lkji}=W_{ijkl}$ and $W_{ljki}=W_{ikjl}$, and the first Bianchi identity gives $W_{ijkl}W_{ikjl}=\tfrac12W_{ijkl}W_{ijkl}$, so

$$\mathbb E[S^2]=3\,W_{ijkl}W_{ijkl}=3\lvert W\rvert_4^2=12\lVert W\rVert^2 ,$$

using [conventions.md](../findings/conventions.md)'s $\lvert W\rvert^2=4\lVert W\rVert_F^2$. Dividing by $\mathbb E[\det G^2]=(n-1)n(n+1)(n+2)$ returns the record's $\Psi_2$ **exactly, constant and all**. The numerator carries no $n$ for the stated reason: every index loop that could produce a factor of $n$ is a trace of $W$.

## 4. Why $5/72$ is $n$-independent, forced, not three coincidences

The brief asks whether this is an invariance or a coincidence. **It is forced, and the mechanism is the one just displayed.**

The $n$-dependence of a moment of $\sec$ enters through exactly one door: the normalisation of the plane, i.e. the falling factorial $[n+2k-2]_{2k}$ that divides Weingart's $\Psi_k$. The numerator (the Gaussian/Wick contraction itself), is $n$-free, because the only source of an $n$ is a self-contraction of one $W$, and $W$ is totally trace-free. $\Phi$ is a Wick sum of the same kind: three copies of $W$, each variable $x,y,z$ appearing quadratically in two of the three factors, so every surviving pairing joins slots of **different** $W$'s and closes into a full contraction with no free loop. Hence

$$\Phi=\alpha\mathop{\mathrm{tr}}(W^3)+\beta\langle W,W^\#\rangle\quad\text{with }\alpha,\beta\text{ absolute constants},$$

and by §3.1, $\tfrac5{72}\Phi=\tfrac{10}9C-\tfrac59T$, i.e.

$$\Phi=16\,\langle W,W^\#\rangle-8\mathop{\mathrm{tr}}(W^3)=8\big(2C-T\big),$$

whose ratio $\alpha/\beta=-\tfrac12$ is precisely the value [r69](REVIEW_r69.md) reports. **So the three data points are one theorem**: $\Phi$ carries no normalising falling factorial, therefore its coefficient in the identity carries no $n$; all of the identity's $n$-dependence has been pushed into $c_n$, where §3.2 computes it. That is the strongest sentence available here and the block asserts it flatly.

It also cuts the other way, and this is the substance of the next section: **an object with $\Phi$'s $n$-free normalisation cannot be a normalised expectation of sectional curvatures.**

## 5. The separating pair, both values are exact, and so is $13.5$

The block reports a shared $\theta=1.054092553389$ "to $2\times10^{-16}$" and a $\Psi_3$ ratio "exactly $13.5$". Both agreements are closed forms, so the $2\times10^{-16}$ is a check, not a claim, and the record already knows half of this: [08-fence-posts.tex:108](../report/sections/08-fence-posts.tex#L108) says the two *"share $\theta^2=\tfrac{10}9$ exactly"*, which the findings block, which is supposed to be the canonical site, does not say.

**$S^3\times S^3$.** Balanced sphere product at $n=6$: the curvature operator is $\mathrm{Id}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ and $0$ on $V_1\wedge V_2$; Einstein with $\mathrm{scal}=12$, so $W=\mathcal R-\tfrac25\mathrm{Id}$ has eigenvalues $\tfrac35$ (multiplicity $6$) and $-\tfrac25$ (multiplicity $9$). Then $\mathop{\mathrm{tr}}W^2=\tfrac{18}5$, $\mathop{\mathrm{tr}}W^3=\tfrac{18}{25}$, and after normalising, $T=\sqrt{10}/30=\theta_0(6)/10$ with $\theta_0(6)=\sqrt{10}/3$ from [conventions.md](../findings/conventions.md).

**$\mathbb{CP}^3$.** Fubini–Study with holomorphic sectional curvature $4$: $\mathcal R$ acts by $2(m+1)$ on $\mathbb R\omega$, $2$ on primitive $(1,1)$ (multiplicity $m^2-1$), $0$ on the real $(2,0)+(0,2)$ part (multiplicity $m(m-1)$), and $\mathrm{Ric}=2(m+1)g$. Subtracting $\mathrm{scal}/(n(n-1))=2(m+1)/(2m-1)$ gives the Weyl eigenvalues

$$\frac{4(m^2-1)}{2m-1}\ (\times1),\qquad \frac{2m-4}{2m-1}\ (\times\,m^2-1),\qquad -\frac{2(m+1)}{2m-1}\ (\times\,m(m-1)),$$

which at $m=3$ is $\tfrac{32}5,\tfrac25,-\tfrac85$ with multiplicities $1,8,6$. Two independent checks that this is the record's object: $\lambda_{\min}/\lVert W\rVert=-1.6/\sqrt{57.6}=-0.21083$ and $K_{\min}/\lVert W\rVert=-0.6/\sqrt{57.6}=-0.07906$, which are post F21's table entries $-0.2108$ and $-0.0791$ at [curvature-invariants.md:15](../findings/curvature-invariants.md#L15); and their ratio is $8/3=(n+2)/3$, the block's own exact strengthening. From these eigenvalues $T=\tfrac{31}{180}\sqrt{10}$, matching the script's $0.544614$.

**$\Psi_3(\mathbb{CP}^3)$ in closed form, by hand.** For a uniform real $2$-plane in $\mathbb C^m$ put $t=\omega(x,y)^2$ for an orthonormal basis; since $Jx$ is a unit vector of $x^\perp\cong\mathbb R^{2m-1}$ and $y$ is uniform there, $t\sim\mathrm{Beta}(\tfrac12,m-1)$. (Check: $\mathbb E[1+3t]=1+\tfrac3{2m-1}=\mathrm{scal}/(n(n-1))$, the record's $\Psi_1$.) The Weyl sectional curvature is $\sec=3t-\tfrac35$ at $m=3$, and $\mathbb E[t]=\tfrac15$, $\mathbb E[t^2]=\tfrac3{35}$, $\mathbb E[t^3]=\tfrac1{21}$ give $\mathbb E[\sec^3]=\tfrac{288}{875}$ before normalising. Dividing by $\lVert W\rVert^3=(57.6)^{3/2}=\tfrac{3456}{25}\sqrt{10}$,

$$\Psi_3(\mathbb{CP}^3)=\frac{1}{420\sqrt{10}}=\frac{\sqrt{10}}{4200}=7.529232524\times10^{-4},$$

which is [r69](REVIEW_r69.md)'s twelve digits. **This is an independent hand recomputation of one of the block's two headline numbers, and it also settles which curvature tensor $\sec$ is taken of: the Weyl one.**

**Consequences.** Feeding it into §3.2's closed form at $n=6$, where $[n+4]_6=151200$ and $151200/16=9450$,

$$14T-C=9450\,\Psi_3(\mathbb{CP}^3)=\frac{9450}{420\sqrt{10}}=\frac{45}{2\sqrt{10}}=\frac{9\sqrt{10}}{4}.$$

With $T=\tfrac{31\sqrt{10}}{180}$ this gives $C=14T-\tfrac{9\sqrt{10}}4=\tfrac{29\sqrt{10}}{180}$ and

$$\theta(\mathbb{CP}^3)=T+C=\frac{60\sqrt{10}}{180}=\frac{\sqrt{10}}3=\theta_0(6)\quad\textbf{exactly.}$$

The same arithmetic at $S^3\times S^3$ gives $\Psi_3=\sqrt{10}/56700$ and returns $\theta=\sqrt{10}/3$. So the ratio is

$$\frac{\Psi_3(\mathbb{CP}^3)}{\Psi_3(S^3\times S^3)}=\frac{56700}{4200}=\frac{27}2=13.5\quad\textbf{exactly},$$

and in invariant form $13.5=\dfrac{15\cdot\tfrac{31}{60}-1}{15\cdot\tfrac1{10}-1}$, where $\tfrac{31}{60}$ and $\tfrac1{10}$ are $T/\theta$ at the two points. **Both headline numbers of the block are theorems reported as measurements**, exactly as the brief suspected.

**Why the two points cross.** The general closed forms are $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}$ (the record's) and, from the $\mathbb{CP}^m$ eigenvalues above,

$$\theta(\mathbb{CP}^m)^2=\frac{(m+1)(2m-1)}{3m(m-1)}=\frac{2(n+2)(n-1)}{3n(n-2)} .$$

That form reproduces $\sqrt{3/2}$ at $m=2$ (which I derive independently below), $\sqrt{10}/3$ at $m=3$ and $\sqrt{35}/6=0.98601329718$ at $m=4$, the latter being [r69](REVIEW_r69.md)'s out-of-sample $0.986013297$ to all nine printed digits. Setting the two equal gives $n(n+2)=3(n-2)^2$, i.e. $n^2-7n+6=0$, i.e. $n\in\{1,6\}$. **The separating pair exists at $n=6$ and at no other dimension**, which is a sharper statement than "these two agree" and is the reason the witness could not have been found by looking at $n=7$.

*Independent anchor for the $\mathbb{CP}^m$ formula.* At $m=2$ the eigenvalues are $4,0,0,0,-2,-2$, so $\mathop{\mathrm{tr}}W^2=24$, $\mathop{\mathrm{tr}}W^3=48$, $T=1/\sqrt6$; with $C=2T$ at $n=4$ (§7) this gives $\theta=3T=\sqrt{3/2}$, which is [conventions.md](../findings/conventions.md)'s recorded $\theta$ at padded $\mathbb{CP}^2$ and the record's $M(n)\ge\sqrt{3/2}$. So one of the three points the $\mathbb{CP}^m$ formula passes through is derived rather than fitted; the other two are the record's own numbers.

**A corollary worth taking.** [r69](REVIEW_r69.md)'s "exact out-of-sample" is $1.145643924$ at $S^4\times S^4$ and $0.986013297$ at $\mathbb{CP}^4$, these are $\theta_0(8)=\sqrt{21}/4$ and $\sqrt{35}/6$, **both at $n=8$**, which is one of the three dimensions used to read off $c_n$. The out-of-sample check therefore tests the spanning claim at new *points* and tests the $n$-dependence of $c_n$ at no new *dimension* at all. §3.2 is what supplies the missing test, and it passes at $n=4,5$.

## 6. The definition of $\Phi$ is refuted by the block's own numbers

The block and [08-fence-posts.tex:106](../report/sections/08-fence-posts.tex#L106) both display

$$\Phi:=\mathbb E_{x,y,z}\big[\sec(x,y)\sec(y,z)\sec(z,x)\big].$$

**Under that reading the identity is wrong by three orders of magnitude, and the discrepancy grows like $n^4$.** For $x,y$ independent and uniform on $S^{n-1}$, the plane they span is uniform in $G_2(\mathbb R^n)$, so each of the three factors has the marginal law of $\sec$. Generalised Hölder with exponents $(3,3,3)$ then gives

$$\lvert\Phi\rvert\ \le\ \mathbb E\big[\lvert\sec\rvert^3\big]\ \le\ \big(\max_\Sigma\lvert\sec\rvert\big)\,\Psi_2\ \le\ \lVert W\rVert\cdot\Psi_2\ =\ \frac{12}{(n-1)n(n+1)(n+2)},$$

which at $n=6$ is $1/140=7.14\times10^{-3}$. The block's own numbers force the opposite: $\tfrac5{72}\Phi=\theta-c_6\Psi_3=1.054092553-1050\cdot5.577209277\times10^{-5}=0.9955319$, hence $\Phi=14.3357$, a factor $2\times10^3$ above a bound that holds for every unit $W$. Sharpening $\max\lvert\sec\rvert$ to its true value at $S^3\times S^3$ ($0.3162$) makes the violation worse, not better.

The failure is structural rather than arithmetical, and §4 names it: a normalised expectation of $\sec^{\otimes3}$ must carry the $[n+4]_6$ falling factorial and so decays like $n^{-4}$, while an $n$-independent coefficient $5/72$ requires an object that carries no factorial at all. **The two recorded properties of $\Phi$ (the displayed definition and the $n$-independence), are incompatible.** The natural rescue, reading "correlation" as division by $\Psi_2^{3/2}$, also fails: it needs $\mathbb E[\sec^3\text{-product}]=8.66\times10^{-3}$ against a bound of $2.26\times10^{-3}$ at $S^3\times S^3$, short by $3.8\times$.

**What the object almost certainly is.** Take $x,y,z\sim N(0,I_n)$ and the **unnormalised** curvature terms:

$$\Phi(W)=\mathbb E_{x,y,z\sim N(0,I_n)}\big[W(x,y,y,x)\,W(y,z,z,y)\,W(z,x,x,z)\big].$$

This is $n$-free by §4's trace argument, is of the same order as its $k=2$ sibling $\mathbb E[W(x,y,y,x)^2]=12\lVert W\rVert^2$ derived in §3.3, $12$ against the required $14.34$ at $S^3\times S^3$, and equals $16C-8T$, giving $\alpha/\beta=-\tfrac12$ as recorded. Whether this is what the run computed **cannot be settled from the record**: no script defines $\Phi$, and [r69](REVIEW_r69.md)'s working is not on disk. It is one Wick contraction of hand size to confirm, of exactly the kind §3.3 carries out; it needs no run.

**This is the block's one live defect for a reader.** As written, the identity cannot be checked, because its second term is undefined. Everything else in this review survives it, because the rest is pinned by $\Phi=16C-8T$, which the recorded coefficients determine.

## 7. $n=4,5$, the identity holds there; what fails is uniqueness

**The dimension count is right, for $O(n)$.** At $n=4,5$ the $O(n)$-invariant cubics on $\mathcal W_n$ are $1$-dimensional, and $C=2T$. At $n=4$ this is visible: $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ with $[\Lambda^2_+,\Lambda^2_-]=0$, so $\#$ preserves the splitting and acts on each $\mathfrak{so}(3)$ factor as the adjugate; for trace-free $3\times3$ symmetric $A$, $\langle A,\mathop{\mathrm{adj}}A\rangle=3\det A=\mathop{\mathrm{tr}}A^3$, giving $C=2T$ in the record's normalisation. At $n=5$ it is the Lovelock-type dimensionally dependent identity from antisymmetrising six indices in five dimensions. The record's own [r597](REVIEW_r597.md) carries the same fact as $P(W)=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$.

**The group in force is $O(n)$, and the block should say so.** $\theta$, $\Psi_3$ and $\Phi$ are all orientation-blind, so $O(n)$ is the right group and the count of $1$ is the right count *for this argument*. Stated unqualified, though, "the cubic invariants are $1$-dimensional" is false at $n=4$ under $SO(4)$: $\mathop{\mathrm{tr}}(W_+^3)$ and $\mathop{\mathrm{tr}}(W_-^3)$ are two independent $SO(4)$-invariant cubics, and $\mathcal W_4$ is $O(4)$-irreducible while splitting under $SO(4)$. The block is safe and the sentence is not; **one word, "$O(n)$-invariant", repairs it**, and this is the same confusion a neighbouring audit found elsewhere on the record.

**The logic is then wrong, and the conclusion with it.** Substituting $C=2T$ and $\theta=3T$ into §3's closed forms:

$$\Psi_3=\frac{16(14T-2T)}{[n+4]_6}=\frac{192T}{[n+4]_6},\qquad \Phi=16(2T)-8T=24T,$$

so with the block's own constants,

$$c_n\Psi_3+\tfrac5{72}\Phi=\frac{[n+4]_6}{144}\cdot\frac{192T}{[n+4]_6}+\frac5{72}\cdot24T=\tfrac43T+\tfrac53T=3T=\theta .$$

**The identity holds at $n=4$ and $n=5$, with the same $c_n$ and the same $5/72$.** It is a check, not an assertion: it reproduces [r70](REVIEW_r70.md)'s independently computed $\Psi_3=\theta/315$ at $n=4$ and $\theta/945$ at $n=5$, because $192/20160=1/105$ and $\theta=3T$ give $\Psi_3=\theta/315$, and $192/60480$ gives $\theta/945$.

What actually degenerates is uniqueness. With the invariant space $1$-dimensional the system $c\,b_3+d\,b_\Phi=$ (one equation) has a line of solutions, so *every* pair on that line works and the coefficients are no longer determined by the geometry, and $\Psi_3$ alone already determines $\theta$, which is the negation of the post's surviving content. **So the block asserts falsity where the truth is non-uniqueness, and the brief's distinction is the operative one.** The correct sentence is: *at $n=4,5$ the identity remains true with the same constants but ceases to be the unique such expression, and there $\theta$ is a function of $\Psi_3$ alone, $\theta=\tfrac94c_n\Psi_3$.*

The block's remaining clause here (that this, rather than sampling, is why the script's $n=5$ fit is rank-deficient), is **CONFIRMED**: a rank-$1$ design matrix is rank-deficient at any sample size.

## 8. What consumes L118

- [findings/INDEX.md:44](../findings/INDEX.md#L44) and [INDEX-results.md:136](../findings/INDEX-results.md#L136), index rows only.
- [report/sections/08-fence-posts.tex:104–108](../report/sections/08-fence-posts.tex#L104), the F20 fence post. **It repeats the $\Phi$ definition verbatim, so §6's defect is on two sites, one of them the outward-facing document.** It is also ahead of the findings block in one respect, stating $\theta^2=\tfrac{10}9$ *exactly* where the block gives twelve decimals.
- [results.md](../results.md) carries nothing for L118, and nothing anywhere cites the identity as a hypothesis.

**The use needs only the negative fact.** What F20 has to survive is that $\theta$ is not the uniform single-plane third moment, and that follows in one line from $a/b=-14\ne1$, the whole two-term identity is there to refute the *wider* reading, "$\theta$ is no closed form in sectional-curvature moments at all". So a defect in $\Phi$ does not propagate into any bound; it damages the record's claim to have a closed form, not any chain.

## 9. What remains un-derived, and what would close it

Two absolute constants, and nothing else:

- the ratio $a/b=-14$ in $\Psi_3=b_3(-14T+C)$, equivalently the numerator $N_3=224T-16C$;
- the pair $(\alpha,\beta)=(-8,16)$ for $\Phi$.

Both are single Wick contractions of degree $6$ in the Gaussian vectors, of the same kind as §3.3's $k=2$ computation, which I carried out in full and which reproduces the record's $\Psi_2$ exactly. **They are hand computations, not runs**, and doing them would move L118 from "derived given two measured constants" to fully derived. Everything else above, the spanning argument, the falling-factorial denominators, $c_n$, the $n$-independence of $5/72$, the exactness of both $\theta$ values and of $13.5$, and the $n=4,5$ behaviour, is derived here or quoted from a definition.

Nothing in this review needed a computation, and none was run.

## 10. Repairs owed to the block

1. **Strike the Gate 2 sentence** and replace it with the true provenance: the closed forms and the identity are [r69](REVIEW_r69.md)'s construction, with [r70](REVIEW_r70.md) confirming $\Psi_1$, $\Psi_2$ and the $n=4,5$ degeneracy and never seeing the identity. [INDEX-results.md:136](../findings/INDEX-results.md#L136) already says so.
2. **State $c_n=\tfrac1{144}(n-1)n(n+1)(n+2)(n+3)(n+4)$** and the derivation in §3.2, in place of the three integers. Give $\Psi_3$'s closed form beside the recorded $\Psi_1$ and $\Psi_2$, whose denominators are the $k=1,2$ cases of the same falling factorial.
3. **Fix or withdraw the definition of $\Phi$**, at [curvature-invariants.md:31](../findings/curvature-invariants.md#L31) and [08-fence-posts.tex:106](../report/sections/08-fence-posts.tex#L106) both. As written it is refuted by §6. Until it is fixed the identity is uncheckable by a reader, and the record should say which of the two sites is authoritative.
4. **Replace "also false at $n=4,5$" with the non-uniqueness statement** of §7, and qualify the invariant count as $O(n)$-invariant.
5. **Promote the exactness**: $\theta(S^3\times S^3)=\theta(\mathbb{CP}^3)=\sqrt{10}/3$, the crossing being the $n=6$ root of $n^2-7n+6=0$; $\Psi_3=\sqrt{10}/56700$ and $\sqrt{10}/4200$; ratio exactly $27/2$. The residuals $2\times10^{-16}$ and $4\times10^{-16}$ then become checks of closed forms, which is what they are.
6. **Table $\sec$, $\Psi_k$ and $\Phi$ in [conventions.md](../findings/conventions.md)**, with $\sec$ taken of the Weyl part, §5 establishes this by recomputation, and [weingart notes:47](../references/weingart-2017-moments-sectional-curvature/notes.md#L47) currently says the moments are of the full curvature tensor, which would be a different invariant.
7. **The label stands as `Lemma`**, and for a better reason than the block gives: the statement is proved at every $n\ge4$, not verified at $n=6,7,8$.
