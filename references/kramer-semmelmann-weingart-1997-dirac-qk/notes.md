# Kramer, Semmelmann & Weingart, *Eigenvalue estimates for the Dirac operator on quaternionic Kähler manifolds* (arXiv:dg-ga/9703021)

**W. Kramer, U. Semmelmann, G. Weingart** (Mathematisches Institut der Universität Bonn), arXiv:dg-ga/9703021v1, 27 Mar 1997. Transcribed 2026-09-02 from [ksw-dg-ga-9703021.txt](https://arxiv.org/abs/dg-ga/9703021) (`pdftotext -layout`). See [README.md](README.md) for the verdict.

**What this project uses is §3, the algebra of curvature tensors**, the Dirac estimate itself is a spectral result on compact manifolds and does not touch the record's pointwise problem.

## The setting

Quaternionic Kähler manifolds are $4n$-dimensional, $n\ge2$, with holonomy in $\mathrm{Sp}(n)\cdot\mathrm{Sp}(1)\subset\mathrm{SO}(4n)$; equivalently they carry a parallel 4-form $\Omega$, the **fundamental** or **Kraines** form ([Bon67], [Kra66]). In even quaternionic dimension $n$ any such manifold is spin; for odd $n$ only $\mathbb{HP}^n$ is ([Sal82]). The tangent bundle is $TM^{\mathbb C}=H\otimes E$ in the local $H$–$E$ formalism.

## The curvature-tensor algebra, §3.1, which is what the record came for

The space is defined by generators:

> $$\mathrm{Curv}\,V^*:=\mathrm{span}\{(\alpha\cdot\beta)\times(\gamma\cdot\delta):=(\alpha\wedge\gamma)(\beta\wedge\delta)+(\alpha\wedge\delta)(\beta\wedge\gamma)\ \text{with}\ \alpha,\beta,\gamma,\delta\in V^*\}$$

as a subspace of $\mathrm{Sym}^2\Lambda^2V^*$, whose generators satisfy the 'dual' Bianchi identity

> $$(\alpha\cdot\beta)\times(\gamma\cdot\delta)+(\alpha\cdot\gamma)\times(\delta\cdot\beta)+(\alpha\cdot\delta)\times(\beta\cdot\gamma)=0.$$

> **Lemma 3.1.** There exists a natural isomorphism of vector spaces
> $$\mathrm{Sym}^2\Lambda^2V^*\ \xrightarrow{\ \cong\ }\ \mathrm{Curv}\,V^*\oplus\Lambda^4V^*,$$
> $$(\alpha\wedge\beta)(\gamma\wedge\delta)\ \longmapsto\ \tfrac13\big((\alpha\cdot\gamma)\times(\beta\cdot\delta)-(\alpha\cdot\delta)\times(\beta\cdot\gamma)\big)\oplus\tfrac13\,\alpha\wedge\beta\wedge\gamma\wedge\delta.$$
> In the same vein
> $$\mathrm{Sym}^2\mathrm{Sym}^2V^*\ \xrightarrow{\ \cong\ }\ \mathrm{Curv}\,V^*\oplus\mathrm{Sym}^4V^*,\qquad(\alpha\cdot\beta)(\gamma\cdot\delta)\ \longmapsto\ \tfrac13(\alpha\cdot\beta)\times(\gamma\cdot\delta)\oplus\tfrac13\,\alpha\cdot\beta\cdot\gamma\cdot\delta.$$
> **This isomorphism reveals an alternative realisation of $\mathrm{Curv}\,V^*$ as the subspace of sectional curvature tensors in $\mathrm{Sym}^2\mathrm{Sym}^2V^*$.**

The proof supplies the inverses explicitly. With
$$\Delta:\mathrm{Sym}^4V\to\mathrm{Sym}^2\mathrm{Sym}^2V,\qquad\alpha\cdot\beta\cdot\gamma\cdot\delta\mapsto(\alpha\cdot\beta)(\gamma\cdot\delta)+(\alpha\cdot\gamma)(\delta\cdot\beta)+(\alpha\cdot\delta)(\beta\cdot\gamma),$$
$$\mathrm{Cr}^*:\mathrm{Sym}^2\Lambda^2V^*\to\mathrm{Sym}^2\mathrm{Sym}^2V,\qquad(\alpha\wedge\beta)(\gamma\wedge\delta)\mapsto(\alpha\cdot\gamma)(\beta\cdot\delta)-(\alpha\cdot\delta)(\beta\cdot\gamma),$$
one has $(\alpha\wedge\beta)(\gamma\wedge\delta)=\tfrac13\big((\alpha\cdot\gamma)\times(\beta\cdot\delta)-(\alpha\cdot\delta)\times(\beta\cdot\gamma)\big)+\Delta(\tfrac13\alpha\wedge\beta\wedge\gamma\wedge\delta)$ and $(\alpha\cdot\beta)(\gamma\cdot\delta)=\Delta(\tfrac13\alpha\cdot\beta\cdot\gamma\cdot\delta)+\mathrm{Cr}^*(\tfrac13(\alpha\cdot\beta)\times(\gamma\cdot\delta))$.

> **Remark.** Either of the above isomorphisms may be used to deduce $\dim\mathrm{Curv}\,V^*=\tfrac{N^2}{12}(N^2-1)$ with $N=\dim V$.

> **Lemma 3.2.** There exists a natural isomorphism
> $$\mathrm{Sym}^2V^*\otimes\Lambda^2V^*\ \xrightarrow{\ \cong\ }\ \Lambda^2\mathrm{Sym}^2V^*\oplus\Lambda^2\Lambda^2V^*,$$
> $$\alpha\cdot\beta\otimes\gamma\wedge\delta\ \longmapsto\ \tfrac12\big((\alpha\cdot\gamma)\wedge(\beta\cdot\delta)+(\beta\cdot\gamma)\wedge(\alpha\cdot\delta)\big)\oplus\big((\alpha\wedge\gamma)\wedge(\beta\wedge\delta)+(\beta\wedge\gamma)\wedge(\alpha\wedge\delta)\big).$$

## Lemma 3.4, the first Bianchi identity as five projection equations

> **Lemma 3.4.** In terms of the decomposition of $\mathrm{Sym}^2\Lambda^2(H^*\otimes E^*)$ above, the first Bianchi identity is equivalent to the five equations
> $$\text{I}\quad\mathrm{pr}_{(\mathrm{Curv}H^*\otimes\mathrm{Curv}E^*)_H}R=\mathrm{pr}_{(\mathrm{Curv}H^*\otimes\mathrm{Curv}E^*)_E}R$$
> $$\text{II}\quad\mathrm{pr}_{\mathrm{Sym}^4H^*\otimes\Lambda^4E^*}R=0,\qquad\text{II}'\quad\mathrm{pr}_{\Lambda^4H^*\otimes\mathrm{Sym}^4E^*}R=0$$
> $$\text{III}\quad\mathrm{pr}_{(\Lambda^2\mathrm{Sym}^2H^*\otimes\Lambda^2\Lambda^2E^*)_H}R=\mathrm{pr}_{(\Lambda^2\mathrm{Sym}^2H^*\otimes\Lambda^2\Lambda^2E^*)_M}R$$
> $$\text{III}'\quad\mathrm{pr}_{(\Lambda^2\Lambda^2H^*\otimes\Lambda^2\mathrm{Sym}^2E^*)_E}R=\mathrm{pr}_{(\Lambda^2\Lambda^2H^*\otimes\Lambda^2\mathrm{Sym}^2E^*)_M}R\tag{3.9}$$

Its proof records the dimension count used to check the solution space, with $N=\dim E^*$:
$$\dim(\mathrm{Sym}^4E^*\oplus\mathrm{Curv}\,E^*\oplus\Lambda^4E^*)=\binom{N+3}{4}+\frac{N^2}{12}(N^2-1)+\binom N4=\frac{N}{4}\cdot\frac{N^2}{6}(N+5)\ \text{[as printed]}.$$

## Lemma 3.5, the quaternionic Kähler curvature tensor in closed form

> **Lemma 3.5.** A quaternionic Kähler manifold $M$ is **Einstein**, and its curvature tensor is given by
> $$R=-\frac{\kappa}{8n(n+2)}(R_H+R_E)+R_{\mathrm{hyper}},\tag{3.11}$$
> where $\kappa$ is the scalar curvature of $M$ and the symmetric 4-form $R$ is necessarily the symmetrisation
> $$R(e_1,e_2,e_3,e_4)=\frac{1}{24\,\sigma_H(h_1,h_2)\sigma_H(h_3,h_4)}\sum_{\tau\in S_4}\langle R_{h_1\otimes e_{\tau1},\,h_2\otimes e_{\tau2}}h_3\otimes e_{\tau3},\,h_4\otimes e_{\tau4}\rangle,$$
> which is independent of the choice of the $h_i$ as long as $\sigma_H(h_1,h_2)\sigma_H(h_3,h_4)\ne0$.

**This is the statement the record used to build $R_{\mathbb{HP}^m}$ from $\mathrm{Sp}(1)$-invariance rather than by looking up a formula.** The proof works through the five equations of Lemma 3.4: II$'$ is trivially satisfied because $\sigma_H\wedge\sigma_H=0$; the $H$-symmetric part reduces to $r_H\otimes\tfrac12(\sigma_E)^2$ because a nonzero $\mathrm{Sym}^4H^*$ contribution is incompatible with II when $\sigma_E\wedge\sigma_E\ne0$; III forces the mixed part to vanish, using Lemma 3.3's injectivity; and I forces $r_E$ and $r_H$ to be the same scalar multiple of the projections of $\tfrac12(\sigma_E)^2$ and $\tfrac12(\sigma_H)^2$.

The Einstein property is credited to Alekseevskii [Ale68-1], [Ale68-2], see also [Ish74].

> **Lemma 3.6.** Any symmetric 4-form in $\mathrm{Sym}^4E^*$ induces the trivial endomorphism on $\Lambda E$.

Proof: fourth powers span $\mathrm{Sym}^4E^*$, so it suffices to check $\tfrac1{24}\alpha^4$; comultiplication sends it to $\tfrac12\alpha^2\otimes\tfrac12\alpha^2$, and $\tfrac12\alpha^2$ acts as the derivation extension of $A=\alpha\otimes\alpha^\flat$, which satisfies $A^2=0$, the first sum in the derivation expansion vanishes because $A^2=0$ already on $E$, and the second because $A$ has **rank 1**.

## The spinor decomposition

> **Proposition 2.1.** The spinor bundle $S(M)$ of a quaternionic Kähler manifold $M$ decomposes as
> $$S(M)=\bigoplus_{r=0}^nS_r(M)=\bigoplus_{r=0}^n\mathrm{Sym}^rH\otimes\Lambda^{n-r}_\circ E,$$
> where each fibre of $S_r(M)$ is an eigenspace of $\Omega$ for the eigenvalue $\mu_r=6n-4r(r+2)$, and
> $$\mathrm{rank}\,(S_r(M))=(r+1)\Big[\binom{2n}{n-r}-\binom{2n}{n-r-2}\Big].$$

> **Proposition 2.2.** For any tangent vector $h\otimes e\in H\otimes E=TM^{\mathbb C}$, the Clifford multiplication $\mu(h\otimes e):S(M)\to S(M)$ is given by $\mu(h\otimes e)=\sqrt2\,(h\cdot\otimes e^\sharp\lrcorner+h^\sharp\lrcorner_\circ\otimes e\wedge_\circ)$. In particular, the Clifford multiplication maps the subbundle $S_r(M)$ to the sum $S_{r-1}(M)\oplus S_{r+1}(M)$.

The verification is of the general relation $\mu(X)\circ\mu(Y)+\mu(Y)\circ\mu(X)=-2g(X,Y)$ (2.1).

## The main results

> **Theorem 1.1.** Let $(M^{4n},g)$ be a compact quaternionic Kähler spin manifold of positive scalar curvature $\kappa$. Then any eigenvalue $\lambda$ of the Dirac operator satisfies
> $$\lambda^2\ge\frac{n+3}{n+2}\cdot\frac\kappa4.$$

> **Theorem 5.1.** Let $(M^{4n},g)$ be a compact quaternionic Kähler spin manifold of positive scalar curvature $\kappa$ and let $\psi=\psi_r+\psi_{r+1}\in\Gamma(S_r(M)\oplus S_{r+1}(M))$ be an eigenspinor for $D$ with eigenvalue $\lambda$. Then $\lambda^2\ge\dfrac{n+r+3}{n+2}\cdot\dfrac\kappa4$.

**Sharpness**: the bound $\tfrac{n+3}{n+2}\tfrac\kappa4$ is the first eigenvalue of $D^2$ on $\mathbb{HP}^n$, computed by Milhorat [Mil92]. The bound was conjectured by Hijazi and Milhorat [HiM95], who proved it for $n=2,3$ using quaternionic Kähler twistor operators and Weitzenböck formulas; this paper follows a similar approach through representation theory.

## Incomplete

Lemmas 2.1–2.5, 3.3, and all of §4 (the universal Weitzenböck formula, Lemmas 4.1–4.5) are not transcribed. §4 is the spectral apparatus that converts the algebra of §3 into the eigenvalue estimate, and it consumes compactness, the record's problem is pointwise-algebraic. Lemma 3.3 is used in the proof of Lemma 3.5 (injectivity of a projection) but its statement is not recorded here.
