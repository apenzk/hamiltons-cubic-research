# VERIFY v10, L04: "a generator for critical points, and a new family"

Verifier `v10`. Cold brief; no numerical work; no file of the project record read. External material consulted: [references/wolf-1968-isotropy-irreducible/notes.md](../references/wolf-1968-isotropy-irreducible/notes.md).

Notation used throughout: $N=\binom n2$; $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$, so $\{e_i\wedge e_j\}_{i<j}$ is orthonormal; $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra of dimension $r$ with orthonormal basis $\{h_a\}$; $\Pi=\Pi_{\mathfrak h}$ the orthogonal projection of $\Lambda^2$ onto $\mathfrak h$; $\operatorname{Cas}^V_{\mathfrak h}=-\sum_a (h_a|_V)^2$ the Casimir of $\mathfrak h$ on a representation $V$, in this normalisation.

## 1. Hypothesis inventory

### 1a. Stated in the entry

| # | Hypothesis | Where used | Status |
| --- | --- | --- | --- |
| H1 | $K\subseteq SO(n)$ | criticality; everything | stated |
| H2 | $(\Lambda^4\mathbb R^n)^K=0$ | attributed to criticality | **misattributed**, see F1 |
| H3 | $\dim\mathcal W_n^K=1$ | criticality | genuinely load-bearing |
| H4 | "every member has just two eigenvalues" | the closed form | **false under H1–H3**, see F3 |
| H5 | $\theta$ increases with $\dim\mathfrak h$ | the maximiser argument | true, and elementary, see F7 |
| H6 | $\dim\mathfrak h\le n(n-2)/4$ ("Lemma L23") | the maximiser argument | imported, not given; **false under H1–H3**, see F3 |

### 1b. Unstated, and needed

| # | Unstated hypothesis | Needed for |
| --- | --- | --- |
| U1 | $K$ compact, or replaced by its closure | symmetric criticality. Harmless: $\mathcal W_n^K=\mathcal W_n^{\overline K}$ since a fixed set of a linear action is closed. Should still be said. |
| U2 | $\mathfrak h=\operatorname{Lie}(K)$ is the $+$-eigenspace of $W$, and $W=\Pi_{\mathfrak h}-\tfrac rN I$ up to scale | the closed form. The line $\mathcal W_n^K$ carries $\pm W$; the formula computes $\theta$ for one sign. Also requires that $\mathfrak h^\perp$ is not itself a subalgebra, else the same formula with $r'=N-r$ would give a second, different value. |
| U3 | $\Pi_{\mathfrak h}$ satisfies the first Bianchi identity | the closed form. This is what H2 actually delivers, and it is the whole content of the derivation (F5). |
| U4 | $\operatorname{Cas}^{\mathbb R^n}_{\mathfrak h}$ is a scalar, necessarily $\tfrac{2r}{n}$ | the closed form (it is the Ricci-flatness of $\Pi_{\mathfrak h}-\tfrac rNI$). Automatic when $\mathbb R^n$ is $K$-irreducible; for reducible $\mathbb R^n$ it is a balance condition, and the entry's own maximiser $\mathfrak{so}(n/2)^{\oplus2}$ is a reducible case. |
| U5 | $n$ even | "attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$", see F6 |
| U6 | $\operatorname{tr}_{\Lambda^2}Q(W)=0$ | zero-padding preserving criticality (F4). Never mentioned; it is true, and I prove it below. |
| U7 | The scope of "member" is fixed once | F3, F11. The entry uses "member" both for *any* $K$ satisfying H2+H3 and for the two-eigenvalue subclass; the two readings give contradictory claims. |

## 2. Imported-theorem checks

**Principle of symmetric criticality (Palais 1979).** No copy exists under [references/](../references/), a grep for "Palais" and "symmetric criticality" over that tree returns nothing. Rather than import it, I checked the finite-dimensional case directly, which is all that is needed and is a two-line argument: $\mathcal W_n$ carries the $O(n)$-invariant inner product, $P$ is $O(n)$-invariant, $S=\{\lVert W\rVert=1\}$ is $K$-stable, and $S^K=S\cap\mathcal W_n^K$. At $W\in S^K$, $\nabla P(W)$ is $K$-invariant, hence lies in $\mathcal W_n^K$, hence in $T_WS^K$; so $\nabla(P|_{S^K})(W)=\nabla P(W)$. The hypotheses actually consumed are: $K$ acts orthogonally (true, $K\subseteq SO(n)$), $P$ is $K$-invariant (true), $\mathcal W_n^K$ is a linear subspace (true). Compactness of $K$ is *not* needed in this linear finite-dimensional setting, which is why U1 is harmless. **Verdict: the import is sound.**

**Wolf's classification (isotropy-irreducible spaces).** Read [notes.md](../references/wolf-1968-isotropy-irreducible/notes.md): Theorem 11.1 classifies non-symmetric $G/K$ with $\chi$ real-irreducible, up to central quotients and normalizer extensions. Two caveats recorded there bear on the entry's "top out far below at $0.8367$", which is a claim over this list: (i) the tables on pp. 107–110 do not survive the extraction and must be read off the PDF page, and (ii) Wolf himself flags a disagreement with Dynkin's table 30 at $E_8$, and there is a 1984 Acta correction. Any "tops out at" statement resting on the table needs the corrected list named. **Verdict: cited list is real; the entry's use of it is unverified here.**

**"Lemma L23" (the cap $n(n-2)/4$).** Not supplied in the brief and not readable under the constraints. It is the sole support for the entry's headline maximiser claim. See F3 and F7.

**README convention "$Q$ sends $\mathcal W_n$ to itself".** Not checked and not needed: symmetric criticality gives $\pi_{\mathcal W_n}Q(W)=\lambda W$ whether or not $Q$ preserves $\mathcal W_n$. Recorded so a later verifier does not treat it as established.

## 3. Findings

### F1, $(\Lambda^4\mathbb R^n)^K=0$ does no work in the criticality claim; its real role is elsewhere. CONFIRMED (misattribution).

**Re-derivation.** With $\dim\mathcal W_n^K=1$, $S^K=\{\pm W\}$ is zero-dimensional, so $T_WS^K=0$ and the argument of §2 gives $\nabla P(W)=0$ on $S$ immediately. Nothing in that derivation refers to $\Lambda^4$.

**Concrete exhibition.** Drop H2 and keep H3: $K=SO(4)\times SO(4)\subset SO(8)$ has $(\Lambda^4\mathbb R^8)^K\ne0$ (each factor contributes its volume form) yet $\dim\mathcal W_8^K=1$ by the count in F3 below, and its $W$ (the Weyl tensor of $S^4\times S^4$), is a critical point all the same. So H2 is not necessary for the stated conclusion.

**Opposite case.** H2 is not idle in the *entry*: it forces $(S^2\Lambda^2\mathbb R^n)^K=(\mathcal S^2_B)^K$, i.e. every $K$-invariant symmetric operator on $\Lambda^2$ automatically satisfies the first Bianchi identity, because its image under $b:S^2\Lambda^2\to\Lambda^4$ is $K$-invariant hence zero. That is exactly U3, the hypothesis the closed form needs. The defect is one of attribution, not of truth: the sentence sells H2 as part of the criticality generator when it is part of the closed-form theorem.

**Impact.** Cosmetic for the criticality claim, structural for the exposition: a reader deleting H2 as redundant loses the closed form.

### F2, The closed form is a theorem, not a fit. CONFIRMED (in the entry's favour).

The entry justifies $\theta=\tfrac2n\sqrt{rN/(N-r)}$ by "checked against held-out spaces it was never fitted to", which is the language of fitting. It is provable. I give the proof because the rest of the audit turns on knowing exactly which hypotheses it consumes.

**Setup.** $W=\Pi-tI$, $t=r/N$, so $\operatorname{tr}W=0$ and $W$ has eigenvalues $1-t$ on $\mathfrak h$, $-t$ on $\mathfrak h^\perp$. Then
$$\lVert W\rVert^2=\frac{r(N-r)}{N},\qquad \operatorname{tr}(W^3)=\frac{r(N-r)(N-2r)}{N^2}.$$

**The $\#$ term.** Write $F(R,S,T)=\sum_{\alpha\beta}\langle[R\varphi_\alpha,S\varphi_\beta],T[\varphi_\alpha,\varphi_\beta]\rangle$ over an orthonormal basis of $\Lambda^2$. $F$ is symmetric in its first two slots by relabelling, and fully symmetric by ad-invariance of $\langle\cdot,\cdot\rangle$. Since $B_{\mathfrak{so}(n)}(X,X)=(n-2)\operatorname{tr}(X^2)=-2(n-2)\lVert X\rVert^2$, one gets $F(I,I,I)=2(n-2)N$; matching against $\langle I^\#,I\rangle=(n-2)N$ (from Hamilton's $I^\#=(n-2)I$) fixes $\langle R\# S,T\rangle=\tfrac12F(R,S,T)$. Then, using $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$,
$$F(\Pi,I,I)=2(n-2)r,\qquad F(\Pi,\Pi,I)=F(\Pi,\Pi,\Pi)=\sum_{a,b}\lVert[h_a,h_b]\rVert^2=:2\kappa,$$
and expanding $W=\Pi-tI$,
$$\langle W,W^\#\rangle=\kappa\Bigl(1-\frac{3r}{N}\Bigr)+\frac{2(n-2)r^3}{N^2}.$$
Note $\kappa=\tfrac12\operatorname{tr}\bigl(\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}\bigr)$, the Casimir of $\mathfrak h$ on its own adjoint representation, in the metric induced from $\Lambda^2\mathbb R^n$.

**Solving for the required $\kappa$.** Setting $P=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$ equal to $\theta\lVert W\rVert^3=\tfrac{2r^2(N-r)}{nN}$ and writing $u=N-r$, the condition becomes
$$\kappa\,(u+r)(u-2r)=r\bigl(rnu-u^2-2(n-2)r^2\bigr)=-r(u-2r)\bigl(u-(n-2)r\bigr),$$
where the factorisation is exact ($u=2r$ is a root of the quadratic, since $-4r^2+2nr^2-2(n-2)r^2=0$). Cancelling $(u-2r)$,
$$\kappa=\frac{r\bigl[(n-1)r-N\bigr]}{N}\iff \tfrac12\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=\frac{2r}{n}-1 .$$

**The identity that supplies it.** Two standard steps close the loop.
1. *Ricci.* $\operatorname{Ric}(\Pi)_{ij}=\sum_k\langle\Pi(e_i\wedge e_k),e_j\wedge e_k\rangle=-\sum_a(h_a^2)_{ij}$, i.e. $\operatorname{Ric}(\Pi)=\operatorname{Cas}^{\mathbb R^n}_{\mathfrak h}$, of trace $2r$. So $W\in\mathcal W_n$ forces $\operatorname{Cas}^{\mathbb R^n}_{\mathfrak h}=\tfrac{2r}{n}$, hypothesis U4.
2. *Bianchi.* Acting on $\Lambda^2$ by derivations, $\operatorname{Cas}^{\Lambda^2}_{\mathfrak h}=2\operatorname{Cas}^{\mathbb R^n}_{\mathfrak h}-2S$ where $S(u\wedge v)=\sum_a h_au\wedge h_av$. In indices $S_{ijkl}=R_{ikjl}-R_{jkil}$ with $R_{ijkl}=\sum_a(h_a)_{ij}(h_a)_{kl}$, and the first Bianchi identity for $R=\Pi$ gives exactly $R_{ikjl}-R_{jkil}=R_{ijkl}$, i.e. $S=\Pi$. Restricting to $\mathfrak h$, where $\Pi$ is the identity and $\operatorname{Cas}^{\Lambda^2}$ restricts to $\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}$,
$$\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=2\operatorname{Cas}^{\mathbb R^n}_{\mathfrak h}-2=2\Bigl(\frac{2r}{n}-1\Bigr),$$
which is precisely the required value. $\square$

**Checks against the entry's own numbers, in closed form.** $\mathfrak{so}(n/2)^{\oplus2}$: $r=\tfrac{n(n-2)}4$, $N-r=\tfrac{n^2}4$, so $\theta^2=\tfrac4{n^2}\cdot\tfrac{(n-1)(n-2)}2=\theta_0(n)^2$, the formula reproduces the balanced sphere product exactly. $\operatorname{ad}\mathfrak{su}(3)\subset\mathfrak{so}(8)$: $r=8$, $N=28$, $\theta^2=\tfrac4{64}\cdot\tfrac{224}{20}=\tfrac{7}{10}$, and $\tfrac12\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=1=\tfrac{16}8-1$ ✓. $\mathfrak{sp}(3)\subset\mathfrak{so}(14)$: $r=21$, $N=91$, $\tfrac{2r}n-1=2$ ✓. Independently, at $r=N/3$ the coefficient $(1-3r/N)$ of $\kappa$ vanishes and the formula holds identically, a consistency the fit-reading cannot explain.

**Opposite case.** Could the entry mean the formula only descriptively? The three-step check above shows it is a theorem under U2+U3+U4; the criticism stands only against the *stated justification*. Report the derivation, not a defect.

### F3, "Every member has just two eigenvalues" is FALSE under H1–H3, and the cap $n(n-2)/4$ is not a cap on $\dim\mathfrak h$ over admissible $K$. CONFIRMED, the central defect.

**Re-derivation of the eigenvalue count.** $W$ is $K$-equivariant, so it acts as a scalar on each isotypic component of $\Lambda^2\mathbb R^n$. When $\Lambda^2$ is multiplicity-free, the number of distinct eigenvalues is at most the number of components, and
$$\dim(S^2\Lambda^2)^K=1+\dim(\operatorname{Sym}^2_0\mathbb R^n)^K+\dim\mathcal W_n^K+\dim(\Lambda^4\mathbb R^n)^K .$$
Under H2+H3 this is $2+\dim(\operatorname{Sym}^2_0\mathbb R^n)^K$. So the two-eigenvalue claim is a **theorem only when $\mathbb R^n$ is $K$-irreducible**; the moment $\mathbb R^n$ splits, the count rises. The entry's own maximiser is a split case.

**Counterexample, in closed form.** Take $n=12$ and $K=SO(7)\times SO(5)\subset SO(12)$, $\mathbb R^{12}=V_7\oplus V_5$.

- $(\Lambda^4\mathbb R^{12})^K=0$: $\Lambda^4(V_7\oplus V_5)=\bigoplus_{p+q=4}\Lambda^pV_7\otimes\Lambda^qV_5$, and $(\Lambda^pV_7)^{SO(7)}\ne0$ only for $p\in\{0,7\}$, $(\Lambda^qV_5)^{SO(5)}\ne0$ only for $q\in\{0,5\}$; no pair sums to 4. **H2 holds.**
- $\dim\mathcal W_{12}^K=1$: $\Lambda^2\mathbb R^{12}=\Lambda^2V_7\oplus\Lambda^2V_5\oplus(V_7\otimes V_5)$, three pairwise-inequivalent irreducibles of dimensions 21, 10, 35, so $\dim(S^2\Lambda^2)^K=3$; $(\operatorname{Sym}^2\mathbb R^{12})^K$ is 2-dimensional (the two metrics), contributing 1 to $\operatorname{Sym}^2_0$; scalars contribute 1; $\Lambda^4$ contributes 0. Hence $3-1-1-0=1$. **H3 holds.** So by §2, its $W$ is a critical point.
- **$W$ has three distinct eigenvalues.** Write $W=w_1\Pi_{\Lambda^2V_7}+w_2\Pi_{\Lambda^2V_5}+w_3\Pi_{V_7\wedge V_5}$. From step 1 of F2, $\operatorname{Ric}(W)|_{V_7}=6w_1+5w_3$ and $\operatorname{Ric}(W)|_{V_5}=4w_2+7w_3$; Ricci-flatness gives $w_1=-\tfrac56w_3$, $w_2=-\tfrac74w_3$, and then $\operatorname{tr}W=21w_1+10w_2+35w_3=0$ automatically. The spectrum is $w_3\cdot(-\tfrac56,\,-\tfrac74,\,1)$, **three distinct values**, so H4 fails.
- **$r=31>30$.** $\dim\mathfrak h=\binom72+\binom52=31$, against the claimed cap $n(n-2)/4=30$. So H6 fails as a statement about admissible $K$.

**The general shape.** For $p+q=n$ with $p,q\ge5$ and $p\ne q$, $K=SO(p)\times SO(q)$ satisfies H2 and H3 by the same two counts, and $\binom p2+\binom q2=\tfrac{p^2+q^2-n}2$ is *minimised* over the splitting at $p=q$. So **every unbalanced admissible split exceeds the cap**, and the balanced one is the minimum of $r$ over splits, not the maximum.

**What breaks.** The entry's maximiser argument is "closed form + monotone in $r$ + cap at $n(n-2)/4$". Two of the three legs fail on the same object: the closed form does not apply to $SO(7)\times SO(5)$ (three eigenvalues), and $r=31$ is above the cap. Had the formula applied, it would give $\theta^2=\tfrac{4}{144}\cdot\tfrac{31\cdot 66}{35}=\tfrac{341}{210}$ against $\theta_0(12)^2=\tfrac{55}{36}$, and $341\cdot36=12276>11550=55\cdot210$, a value **above** $\theta_0$, i.e. a refutation of the goal. It is not one, precisely because H4 fails there. The formula and the admissibility criterion must therefore be kept rigidly apart, and the entry conflates them.

**Opposite case.** The strongest defence is that "member" means the two-eigenvalue subclass by definition, so $SO(7)\times SO(5)$ is simply not a member. Granting that, three costs remain. (i) The sentence "If $K$ satisfies $(\Lambda^4)^K=0$ and $\dim\mathcal W_n^K=1$ … Every member has just two eigenvalues" then equivocates on "member" inside a single paragraph, and read the first way it is false. (ii) The cap becomes a cap over a class characterised by a spectral condition that the two stated hypotheses do not decide, so the generator no longer generates the family it caps, U4 (irreducibility, or balance) must be added as a third hypothesis. (iii) The maximiser claim then covers strictly less than "all critical points arising from the generator", which is what the entry's framing promises. Under reading (i) the claim is **false**; under reading (ii) it is **unproved as stated**. Either way it does not pass.

### F4, "Zero-padding preserves everything" is false as stated; padding preserves criticality and $\theta$, but destroys H3, H4 and the closed form. CONFIRMED.

**Re-derivation.** Let $W\in\mathcal W_m$ and $\hat W\in\mathcal W_n$, $m<n$, its extension by zero on $\Lambda^2\mathbb R^n\ominus\Lambda^2\mathbb R^m$.

*What survives.* $\hat W$ satisfies Bianchi and $\operatorname{tr}\hat W=0$; $\operatorname{Ric}(\hat W)$ is $\operatorname{Ric}(W)=0$ on $\mathbb R^m$ and $0$ elsewhere, so $\hat W\in\mathcal W_n$. $\hat W^2$ is the zero-extension of $W^2$; and since $[\mathfrak{so}(m),\mathfrak{so}(m)]\subseteq\mathfrak{so}(m)$, so is $\hat W^\#$. Hence $Q(\hat W)=\widehat{Q(W)}$.

*The obstruction, and why it vanishes.* $\pi_{\mathcal W_n}$ and $\pi_{\mathcal W_m}$ do not commute with padding: if $\operatorname{Ric}_m(Q(W))=\mu\,\mathrm{id}_m$ with $\mu\ne0$, that is pure trace inside $\mathbb R^m$ but $\mu\Pi_{\mathbb R^m}$ has a **non-zero traceless part** inside $\mathbb R^n$, contributing a Kulkarni–Nomizu term to $\pi_{\mathcal W_n}Q(\hat W)$ that is not a multiple of $\hat W$ (it has non-zero Ricci; $\hat W$ has none). Criticality would fail. It does not, because $\mu=0$: from the $\#$-expansion in F2, $\operatorname{tr}(W^\#)=\kappa-\tfrac{(n-2)r^2}{N}$, and substituting the proven $\kappa=\tfrac{r[(n-1)r-N]}N$ gives $\operatorname{tr}(W^\#)=\tfrac{r^2-rN}{N}=-\lVert W\rVert^2$, so
$$\operatorname{tr}_{\Lambda^2}Q(W)=\lVert W\rVert^2+\operatorname{tr}(W^\#)=0 .$$
Scalar curvature is $2\operatorname{tr}_{\Lambda^2}$, so $\mu=0$, hence in fact $Q(W)=\lambda W$ on the nose (no projection needed) and $Q(\hat W)=\lambda\hat W$. **Padding preserves criticality, and $P$ and $\lVert W\rVert$ are unchanged, so $\theta$ is preserved.** This is hypothesis U6, and the entry states none of it.

**Where "everything" is wrong.** Three things do not survive.
1. *The closed form.* $r$ is unchanged but $N$ is not. Padding $\operatorname{ad}\mathfrak{su}(3)$ from $n=8$ to $n=12$ keeps $\theta^2=\tfrac7{10}$ while the formula at $(r,N,n)=(8,66,12)$ returns $\tfrac{4}{144}\cdot\tfrac{8\cdot66}{58}=\tfrac{88}{348}=\tfrac{22}{87}$, and $\tfrac{22}{87}\ne\tfrac7{10}$ ($220\ne609$). So the entry asserts, of the same object, both "the closed form holds for every member" and "zero-padding preserves everything and they persist into $n=12$"; these are inconsistent.
2. *H4.* $\hat W$ has three eigenvalues, $a$ on $\mathfrak h$, $b$ on $\mathfrak h^\perp\cap\Lambda^2\mathbb R^m$, and $0$ on the complement, and $\ker\hat W\ne0$.
3. *H3.* Padding $\operatorname{ad}SU(3)$ into $n=12$ with $\hat K=K\times SO(4)$: $\Lambda^2\mathbb R^{12}$ then has five inequivalent summands ($\mathfrak k$, $\mathfrak m$, $\Lambda^2_+\mathbb R^4$, $\Lambda^2_-\mathbb R^4$, $\mathbb R^8\otimes\mathbb R^4$), $(\operatorname{Sym}^2_0)^{\hat K}$ contributes 1 and $(\Lambda^4\mathbb R^4)^{SO(4)}\ne0$ contributes 1, giving $\dim\mathcal W_{12}^{\hat K}=5-1-1-1=2\ne1$. So the *generator* no longer applies to the padded object; criticality has to be re-established by the $Q(\hat W)=\lambda\hat W$ argument above, which the entry does not give.

**Opposite case.** The conclusion the entry needs, that the $n=8$ and $n=14$ examples persist as critical points into $n\ge12$ with their $\theta$ intact, is **true**, and I proved it. The defect is that the one-clause justification is wrong on three counts and hides the identity $\operatorname{tr}Q(W)=0$ that does the work. The kernel is not benign here; it is benign only because of a computation nobody performed in the entry.

### F5, Monotonicity in $r$ is trivially true but carries no content without the cap. CONFIRMED (scoping).

$\theta(r)=\tfrac2n\sqrt{rN/(N-r)}$ is strictly increasing on $(0,N)$ since $r\uparrow$ and $N-r\downarrow$. But $\theta(r)\to\infty$ as $r\to N$, while the underlying object degenerates: at $r=N$, $W=\Pi_{\mathfrak{so}(n)}-I=0$, not a point of the unit sphere. So the formula is unbounded on its formal domain and **the entire content of "the closed form also determines the family's maximum exactly" sits in the cap H6**, which is delegated to Lemma L23 and is not given here. Combined with F3, where H6 is false over admissible $K$, "the answer is $n(n-2)/4$" is unsupported by anything in this entry.

At the other edge, $r=0$ gives $W=0$ and $\theta=0$ consistently, and $r=1$ is impossible: an abelian $\mathfrak h$ has $\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=0$, contradicting $\tfrac12\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=\tfrac{2r}n-1$ unless $2r=n$; concretely $\mathfrak h=\mathbb R J\subset\mathfrak{so}(2m)$ has $\operatorname{Cas}^{\mathbb R^{2m}}=\tfrac1m$ scalar yet $\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=0\ne2(\tfrac1m-1)$, and correspondingly $b(\Pi_{\mathfrak h})=J\wedge J\ne0$. So the Einstein condition alone does not imply the Casimir identity, Bianchi is indispensable, confirming U3.

### F6, $n$ odd: the stated maximiser does not exist, and the cap is exceeded. CONFIRMED.

$\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ requires $n$ even; the entry states no such hypothesis, and $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is written for all $n$. For odd $n$ the nearest splits are $\mathfrak{so}(\frac{n+1}2)\oplus\mathfrak{so}(\frac{n-1}2)$, which are unbalanced, hence three-eigenvalue by F3, hence outside the closed form, **and above the cap**. At $n=13$: $r=\binom72+\binom62=36$ while $n(n-2)/4=\tfrac{143}4$, and $36=\tfrac{144}4>\tfrac{143}4$. So for odd $n$ the cap is attained by nothing and exceeded by an admissible $K$.

### F7, "None is coordinate-diagonalizable" contradicts the entry's own membership claim. CONFIRMED.

The entry says the balanced sphere product "is itself a member", and separately that "None is coordinate-diagonalizable … the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$". For $\mathfrak h=\mathfrak{so}(n/2)^{\oplus2}$ with $n\ge 8$, $\Lambda^2\mathbb R^n=\Lambda^2V_1\oplus\Lambda^2V_2\oplus(V_1\wedge V_2)$ and every one of those three spaces is spanned by coordinate 2-forms $e_a\wedge e_b$; $W$ is a scalar on each, hence **diagonal in the coordinate basis**. At $n=12$, $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ is a second diagonalizable member and is not $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$. The same holds for every $SO(p)\times SO(q)$ member of F3, and for every zero-padded member of F4 restricted to a diagonalizable base. The claim is sustainable only under the narrow reading of "member" (Lie-group and isotropy-irreducible entries), which is again U7. As written, with the balanced product declared a member two sentences later, it is self-contradictory. No proof of the non-diagonalizability of the Lie-group members is supplied here, so the parenthetical "proven rather than numerical" is untestable from the entry.

### F8, WITHDRAWN: $K=SO(n-1)$ as an over-cap admissible example.

$\mathfrak{so}(n-1)$ has $r=\tfrac{(n-1)(n-2)}2>\tfrac{n(n-2)}4$ (the ratio is $\tfrac{2(n-1)}n>1$), and $(\Lambda^4\mathbb R^n)^{SO(n-1)}=\Lambda^4V\oplus\Lambda^3V$-invariants $=0$ for $n\ge7$, so H2 holds. **Withdrawn at step 2**: $\dim\mathcal W_n^{SO(n-1)}=0$, not 1. The invariant Bianchi operators are spanned by $\Pi_{\Lambda^2V}$ and $I$; requiring Einstein gives $a(n-2)+b=b(n-1)$, i.e. $a=b$, i.e. $W\in\mathbb R I$, and tracelessness then forces $W=0$, as it must, since $S^{n-1}\times\mathbb R$ is conformally flat. Recorded so the next verifier does not re-run it.

### F9, WITHDRAWN: $\mathfrak u(m)\subset\mathfrak{so}(2m)$ as an over-cap admissible example.

$r=m^2>m(m-1)=\tfrac{n(n-2)}4$. **Withdrawn at step 2**: $(\Lambda^4\mathbb R^{2m})^{U(m)}\ni\omega\wedge\omega\ne0$ for $m\ge2$, so H2 fails; independently the Casimir test fails, since the centre of $\mathfrak u(m)$ has $\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=0$ while $2(\tfrac{2r}n-1)=2(m-1)\ne0$, so $\Pi_{\mathfrak u(m)}$ is not Bianchi. Likewise $\mathfrak{sp}(2)\oplus\mathfrak{sp}(1)\subset\mathfrak{so}(8)$ ($r=13>12$), $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ ($r=21$) and $\mathfrak g_2\subset\mathfrak{so}(7)$ ($r=14$) all fail H2 on their defining 4-forms.

### F10, WITHDRAWN: $SU(2)^3$ at $n=9$ as a second diagonalizable Lie-group exception.

$\mathfrak h=\mathfrak{so}(3)^{\oplus3}$ is coordinate-diagonal and is not $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$. **Withdrawn at step 2**: $\Lambda^2\mathbb R^9$ has six inequivalent summands ($\Lambda^2V_i\cong V_i$ and $V_i\otimes V_j$), $(\operatorname{Sym}^2_0\mathbb R^9)^K$ is 2-dimensional and $(\Lambda^4)^K=0$, so $\dim\mathcal W_9^K=6-1-2-0=3\ne1$. The "lone exception" claim survives this particular attack; F7 defeats it by a different route.

## 4. Verdict

**GAP.**

The generator itself is sound, and one of its two hypotheses is doing a different job than advertised; the closed form is a genuine theorem on a strictly smaller class than the generator produces; and the maximiser claim (the part the entry advertises as "determined exactly"), does not follow from what is written.

Precisely:

- **Sound as stated.** Criticality from $\dim\mathcal W_n^K=1$ (F1, §2). Monotonicity of $\theta$ in $r$ (F5). The persistence of the $n=8$ and $n=14$ values into $n\ge12$ (F4), though for reasons the entry does not give.
- **Sound after correction.** The closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$ is proved in F2 under hypotheses U2+U3+U4, equivalently from the Casimir identity $\tfrac12\operatorname{Cas}^{\mathfrak h}_{\mathfrak h}=\operatorname{Cas}^{\mathbb R^n}_{\mathfrak h}-1$, which follows from the first Bianchi identity for $\Pi_{\mathfrak h}$ via $S=\Pi_{\mathfrak h}$. "Checked against held-out spaces" should be replaced by this derivation. $(\Lambda^4)^K=0$ should be moved from the criticality sentence to the closed-form hypotheses, and U4 ($\mathbb R^n$ $K$-irreducible, or the split balanced) added.
- **False as stated.** "Every member has just two eigenvalues", refuted by $SO(7)\times SO(5)\subset SO(12)$, spectrum $w_3(-\tfrac56,-\tfrac74,1)$ (F3). The cap $n(n-2)/4$ as a bound on $\dim\mathfrak h$ over admissible $K$, refuted by the same object, $r=31>30$, and by every unbalanced split for $n$ odd or even (F3, F6). "Zero-padding preserves everything" (F4). "None is coordinate-diagonalizable" against the entry's own "the balanced sphere product is itself a member" (F7).
- **Unproved and load-bearing.** The cap (Lemma L23), on which the whole maximiser claim rests and which is not supplied. Since $\theta(r)\to\infty$ as $r\to N$, the cap carries all the content, and F3 shows the cap must be stated over the two-eigenvalue subclass rather than over $\{K:\text{H2},\text{H3}\}$, a restatement Lemma L23 must be checked to actually make.
- **Unverified imports.** The "tops out at $0.8367$" claim over Wolf's list, whose table does not survive the local extraction and carries a known 1984 correction (§2). The README convention that $Q$ preserves $\mathcal W_n$, not needed, not checked.

If the entry is rewritten so that "member" means "two-eigenvalue member with $\mathbb R^n$ $K$-irreducible or balanced", F3, F6 and F7 all become scoping repairs rather than falsehoods, and the verdict would move to `PROVEN, hypotheses corrected` **provided** Lemma L23's cap is separately confirmed to be a cap over that restricted class. As the entry stands, the quantifiers are wrong and the maximum is not established.
