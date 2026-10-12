# REVIEW_r532, Lemma L121

**Target.** Lemma L121, "the 4-set block, its spectrum, and one necessary condition per 4-subset", in [findings/second-order.md](../findings/second-order.md) at the `#### Lemma L121` heading (line 629), down to the next heading.

**Reviewer.** r532, independent adversarial auditor, cold brief. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening only, labelled as such.

**Phase plan.**

1. P1, read L121 verbatim; fix conventions against the record's anchors.
2. P2, derive the matrix $G$ from the structure constants; settle the symmetry question.
3. P3, derive all three eigenvalues; check the radical and the two displayed forms.
4. P4, check the constant in the necessary condition ($\theta^2$ or otherwise).
5. P5, hypothesis audit: which claims need a critical point, which need a maximiser.
6. P6, cross-check the $S^p\times S^q$ value against Lemma L26.
7. P7, the 25 citations: spectrum, condition, or strengthening.
8. P8, grep `findings/` for restatements and for later passages contradicting the block.

**VERDICT: CONFIRMED** (full statement at the foot of this file)

---

## Findings

(appended as found)

### F1, The matrix $G$ is symmetric exactly as printed; the brief's premise is wrong (P2)

The brief says "as printed the rows are $(A,C,B)$, $(C,B,A)$, $(B,A,C)$, which is **not** symmetric". **It is symmetric.** Reading the printed
$$G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$$
entrywise: $G_{12}=C=G_{21}$, $G_{13}=B=G_{31}$, $G_{23}=A=G_{32}$. It is the symmetric Latin square with diagonal $(A,B,C)$ in which the off-diagonal $(m,m')$ entry is the *third* letter. So $G\mathbf 1=(A+B+C)\mathbf 1$ holds, the spectrum is real, and there is nothing to repair. No identity is needed to force the symmetry; it is already there.

### F2, $G$ derived from the structure constants, independently. It is right, and so is "in signed coordinates" (P2)

Conventions used, all from [findings/conventions.md](../findings/conventions.md): $\varphi_{ab}$ orthonormal under the half-trace pairing ($\lVert\varphi_{ab}\rVert^2=1$); $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ totally antisymmetric, $=\pm1$ on triangles and $0$ otherwise; $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, giving
$$L_M(X)=\tfrac12(MX+XM)+\Phi(M,X),\qquad \Phi(M,X)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\zeta}c_{\alpha\gamma\delta}c_{\beta\gamma\zeta}\,m_\gamma X_{\delta\zeta},$$
with $\Phi$ the polarisation of $\#$. **Anchor check on $\Phi$:** $\mathrm{Id}^\#=\tfrac12\kappa\,\mathrm{Id}=(n-2)\mathrm{Id}$ with $\kappa=2(n-2)$, and on diagonal $M$ it reduces to $(M^\#)_{ab,ab}=\sum_{c\ne a,b}M_{ac}M_{bc}$, the record's classical diagonal formula.

Take $\{i,j,k,l\}=\{1,2,3,4\}$ and raw coordinates $x_1=X_{(12),(34)}$, $x_2=X_{(13),(24)}$, $x_3=X_{(14),(23)}$.

- The anticommutator contributes $\tfrac12\operatorname{diag}(A,B,C)$.
- The $\Phi$ term at $\alpha=(12),\beta=(34)$: the shared index $\gamma$ must meet $\{1,2\}$ in one index and $\{3,4\}$ in one, so $\gamma\in\{(13),(14),(23),(24)\}$, and each choice forces $\delta$ and $\zeta$. Signs: $+M_{13}x_3$, $-M_{14}x_2$, $-M_{23}x_2$, $+M_{24}x_3$, giving $\tfrac12[Bx_3-Cx_2]$.
- Rows 2 and 3 follow by transporting the same identity through the transpositions $(2\,3)$ and $(2\,4)$, which are orthogonal and so commute with $\circ$; they carry the sign $\varphi_{23}\mapsto-\varphi_{23}$ etc.

Result: $L_M=\tfrac12\tilde G$ with
$$\tilde G=\begin{pmatrix}A&-C&B\\-C&B&-A\\B&-A&C\end{pmatrix},$$
already symmetric (as $L_M$ self-adjoint requires), and conjugating by $\operatorname{diag}(1,-1,1)$ (the flip $x_2\mapsto-x_2$), turns $\tilde G$ into the printed $G$ exactly. **So the lemma's "in signed coordinates" is load-bearing and correct, and the sign it means is $x_2\mapsto-x_2$.**

**The same flip is the one Bianchi wants, which is why "$\mathbf 1^\perp$ automatically" is true.** With $x_1=W_{ijkl}$, $x_2=W_{ikjl}$, $x_3=W_{iljk}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$ reads $x_1-x_2+x_3=0$, i.e. $y_1+y_2+y_3=0$ in signed coordinates. The Bianchi subspace **is** $\mathbf 1^\perp$, on the nose.

### F3, The spectrum is right, all three eigenvalues, and the two radical forms agree (P3)

$\operatorname{tr}G=A+B+C$, which is also the $\mathbf 1$ eigenvalue, so the other two sum to $0$: write them $\pm\rho$. Each letter occurs three times in the Latin square, so $\operatorname{tr}(G^2)=3(A^2+B^2+C^2)$, and
$$2\rho^2=3(A^2+B^2+C^2)-(A+B+C)^2=2\big(A^2+B^2+C^2-AB-BC-CA\big).$$
Hence $\operatorname{spec}(G)=\{A+B+C,\ \pm\sqrt{A^2+B^2+C^2-AB-BC-CA}\}$ and $L_M=\tfrac12G$ gives the displayed $\pm\tfrac12\sqrt{\cdot}$ **as the whole spectrum of the $2$-dimensional $4$-set block of $\mathcal W_n$**, the third eigenvalue $\tfrac12(A+B+C)$ sits on $\mathbf 1$, which Bianchi removes, so the lemma is complete rather than missing a root. The second displayed form is the identity $\tfrac12[(A-B)^2+(B-C)^2+(C-A)^2]=A^2+B^2+C^2-AB-BC-CA$ on expansion. **Both correct.**

### F4, The constant $\theta^2$ is right; there is no lost factor of $2$ (P4)

[Lemma L24](../findings/second-order.md) is normalised against $L_e=L_M/\theta$: $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, i.e. $\lambda_{\max}(L_M\vert_{W^\perp})\le\theta/2$. The $4$-set block lies wholly inside $W^\perp$ ([Lemma L120](../findings/second-order.md)'s callout: "$W^\perp$ cuts $\mathcal D_n$ and nothing else"), and its top eigenvalue is $\tfrac12\rho$. So $\tfrac12\rho\le\tfrac{\theta}2$, i.e. $\rho\le\theta$, i.e.
$$A^2+B^2+C^2-AB-BC-CA\le\theta^2 .$$
**Exactly as printed.** The two halves of the factor $\tfrac12$ (the one in $L_M=\tfrac12G$ and the one in L24's $\theta/2$), cancel, which is why no $2$ appears. L121 works in $L_M$ units throughout and says so where it matters ("an $L_e$ value; the paragraph above it is in $L_M$ units").

### F5, Cross-check against [Lemma L26](../findings/nondegeneracy.md): exact, on three independent counts (P6)

$S^p\times S^q$ Einstein with constant $\Lambda$: sectional entries $w_1=\Lambda\big(\tfrac1{p-1}-\tfrac1{n-1}\big)$ within the $p$-block, $w_2=\Lambda\big(\tfrac1{q-1}-\tfrac1{n-1}\big)$ within the $q$-block, $w_0=-\tfrac\Lambda{n-1}$ mixed.

- **Which $4$-subsets vanish.** $(4,0)$: $A=B=C=2w_1$. $(3,1)$: $A=B=C=w_1+w_0$. $(2,2)$: $A=w_1+w_2$, $B=C=2w_0$. So exactly the $(2,2)$-splits are nonzero, **as claimed**.
- **The value.** With $B=C$ the radicand collapses to $(A-B)^2$, and $A-B=w_1+w_2-2w_0=\Lambda\big(\tfrac1{p-1}+\tfrac1{q-1}\big)=\Lambda\tfrac{n-2}{(p-1)(q-1)}$. So the $L_M$ eigenvalue is $\tfrac\Lambda2\tfrac{n-2}{(p-1)(q-1)}$ and the $L_e$ eigenvalue is that over $\theta$.
- **$\Lambda=\theta$, derived rather than assumed.** At $\Lambda=1$, $Q(W)=W$: checked entry by entry at $(3,3)$ and $(2,4)$ from $(W^\#)_{ab,ab}=\sum_c W_{ac}W_{bc}$. Hence $\theta=P/\lVert W\rVert^3=1/\lVert W\rVert_{\Lambda=1}=\Lambda_{\text{unit}}$, and
$$\mu_{L_e}=\frac{n-2}{2(p-1)(q-1)},$$
**which is L26 verbatim.** Independent anchor: $\lVert W\rVert^2_{\Lambda=1}=\tfrac{pq(n-2)}{2(n-1)(p-1)(q-1)}$ gives $\tfrac9{10}$ at $(3,3)$, so $\theta_0(6)=\sqrt{10}/3$ (the record's anchor) and $\operatorname{tr}W^\#=(0-0.9)/0.9=-1$, the record's other anchor.
- **The eigenvector matches too.** For $B=C$ the $+\rho$ eigenvector is $(2,-1,-1)$ in signed coordinates, i.e. $(2,1,-1)$ raw, proportional to L26's stated coefficients $\tfrac23,\tfrac13,-\tfrac13$, whose norm $2\cdot\tfrac69=\tfrac43$ is L26's stated $\lVert X\rVert^2=\tfrac43$. **Three independent agreements (which subsets, what value, which vector and its norm).**
- **L26's $(3,4)$ exception does not touch this.** That exception is about which eigenvalue is *second-largest* in the full spectrum at $(3,4)$; L121 only claims the $4$-set value equals $\mu$, which is unaffected.

### F6, The subsidiary numbers in the block check out

$\mu=\tfrac{n-2}{2(p-1)(q-1)}=\tfrac2{n-2}$ at balanced $p=q=n/2$, hence $\tfrac12$ at $n=6$; the count of $(2,2)$-splits at $S^3\times S^3$ is $\binom32^2=9$; $\tfrac23$ at $S^2\times S^4$ ($\tfrac4{2\cdot1\cdot3}$); $\tfrac35$ at $S^2\times S^6$ ($\tfrac6{2\cdot1\cdot5}$). All four as printed.

### F7, Screen (labelled as a screen, not evidence for a positive claim)

Seconds of compute on objects built for the purpose: $n=5$, $\varphi_{ab}$ orthonormal, $c$ read off the brackets, $\#$ as above, and a **random diagonal $M$ that is neither critical nor Ricci-flat**. Results: $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ true; off-block leakage of $L_M$ on the three $4$-set generators exactly $0$; $2L_M$ equals $\tilde G$; $\operatorname{diag}(1,-1,1)\,\tilde G\,\operatorname{diag}(1,-1,1)=G$; the eigenvalues match $\{A+B+C,\pm\rho\}/2$. Script at the session scratchpad. **This screens the hand derivation of F2/F3 and the diagonality-only scope of F8; the derivations above are what carry the claim.**

### F8, Hypothesis: the block and its spectrum need only diagonality; the inequality needs maximality. Both are stated correctly, but the block's opening line over-specifies (P5)

The block opens *"Fix a diagonal critical point $M$ with $\theta>0$ and a $4$-subset $\{i,j,k,l\}$."* Splitting the claims:

| claim | what it actually needs |
| --- | --- |
| $L_M\vert_{4\text{-set}}=\tfrac12G$, $G$ as printed | $M$ diagonal in the pair basis. **Nothing else**, no criticality, no $\theta>0$, no row sum |
| Bianchi subspace $=\mathbf 1^\perp$, block traceless, spectrum $\pm\tfrac12\sqrt\Sigma$ | the same |
| $\Sigma\le\theta^2$ | $M$ a **maximiser** with $\theta>0$ |

My derivation (F2) never used a row sum or $Q(M)=\theta M$, and the screen confirms it on a non-critical diagonal $M$. **The conclusion sentence quantifies correctly** (it reads *"at every maximiser and every $4$-subset"*, not "at every critical point") so the trap the brief warns about (a hypothesis-free part run together with a part needing maximality) is **avoided here**. The record's strongest internal test of exactly this point is [second-order.md line 769](../findings/second-order.md): $S^2\times S^4$ is critical, is not a maximiser, and its four-set blocks sit at $\mu_{2,4}=\tfrac23>\tfrac12$, a value L121 itself prints. L121 is therefore consistent with its own example.

**The over-specification is already recorded in the file, 47 lines below the block**, at line 676: *"L121 holds under **diagonality alone** (verified from the structure constants, with no row sum of $M$ entering) although this file states it for a diagonal *critical* point"*. So this is a **presentation defect, not a mathematical one**: a reader of the block alone reads a narrower lemma than the one the file elsewhere relies on (and than [DERIVE-mx1.md](DERIVE-mx1.md) needs, applying it to $\operatorname{diag}(M)$ off the eigenframe). Repair: add "criticality unused for the block and its spectrum" to the block, in the style [Lemma L120](../findings/second-order.md) already uses one heading above.

### F9, One wording elision inside the block

*"$G\mathbf 1=(A+B+C)\mathbf 1$, so the Bianchi subspace is $\mathbf 1^\perp$ automatically"*, the eigenvector property gives **invariance** of $\mathbf 1^\perp$; it does not give the **identification** of the Bianchi subspace with $\mathbf 1^\perp$. That identification is a separate one-line fact about the sign convention: $W_{ijkl}+W_{iklj}+W_{iljk}=0$ reads $x_1-x_2+x_3=0$ raw, hence $y_1+y_2+y_3=0$ signed. **Both statements are true** (the file states the second explicitly at line 889: *"first Bianchi reads $T_{1234}-T_{1324}+T_{1423}=0$, so L121's signed coordinates negate the middle pairing"*), so this is a joint-that-should-be-two-joints, not an error.

### F10, The $25$ citations, classified (P7)

Mentions of `L121` in the record proper are $19$ in [findings/second-order.md](../findings/second-order.md) and $6$ in [plan.md](../plan.md), **exactly $25$**, one of which is the heading itself.

| what the citation takes | where |
| --- | --- |
| **the spectrum / closed form** (values $\mu_{p,q}$, $\Sigma=0$ on $(3,1)$ and $(4,0)$, "computable in closed form") | second-order.md 711, 720, 739, 769, 811, 877, 890; plan.md 51, 165 |
| **the equality case $\Sigma=\theta^2$** (a $4$-set block meets the $\tfrac12$-eigenspace) | second-order.md 712, 787; plan.md 182, 184 |
| **the necessary condition $\Sigma\le\theta^2$** | second-order.md 805; plan.md 141 |
| **a strengthening / off-frame generalisation** ($\Sigma\le\theta^2(1+c^2)^2$; the four-index certificate in every frame) | second-order.md 85, 813 |
| **the signed-coordinate convention alone** | second-order.md 889 |
| **scope notes and withdrawals** (diagonality-only; not licensed off-eigenframe; incompatible with half-flatness; three withdrawn readings) | second-order.md 674, 676, 700, 702, 704 |
| **non-mathematical** (an anecdote about a failed grep) | second-order.md 1197 |
| **miscitation, see F11** | plan.md 207 |

Every mathematical citation takes a claim L121 actually makes, in the normalisation L121 makes it, with the one exception below.

### F11, A miscitation, outside the target block

[plan.md line 207](../plan.md) reads:

> - [x] **I21 CLOSED, the compactness half is one line**, $\mathcal D_n$ being a linear subspace ([Lemma L121](findings/second-order.md)).

**L121 says nothing about $\mathcal D_n$.** It is the $4$-set block lemma; $\mathcal D_n$ is defined in [findings/conventions.md](../findings/conventions.md) ("$\{S$ symmetric, hollow, $S\mathbf 1=0\}$"), and the decomposition placing it inside $\mathcal W_n$ is [Lemma L120](../findings/second-order.md). The cited fact is true and trivial from that definition; the attribution is wrong. **This does not touch L121's own correctness**, it is a defect in the citing line. Repair: cite conventions.md (or L120) there.

### F12, Nothing later in the file contradicts the block (P8)

Checked every later passage that restates the same quantities:

- **[Lemma L124](../findings/second-order.md)** defines the *same* $A,B,C$ and $\Sigma:=A^2+B^2+C^2-AB-BC-CA$, and its (i) ($A+B+C=0\Rightarrow\Sigma=\tfrac32(A^2+B^2+C^2)$), follows from $\Sigma=\tfrac32\Sigma_2-\tfrac12\sigma^2$. Its $\theta^2\le\Sigma$ runs the **opposite** way to L121's $\Sigma\le\theta^2$, which is consistent: together they say no half-flat four-set tensor other than $W_{\mathbb{CP}^2}$ is a maximiser, and line 704 already records why composing them proves less than it looks. Its basis $\omega_2=(e_{ik}-e_{jl})/\sqrt2$ carries **the same middle-pairing sign flip** L121 means.
- **[second-order.md line 968](../findings/second-order.md)**: $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ with $\sigma=\sum_{a<b\in S}M_{ab}$, an identity, verified, agreeing with the block.
- **[second-order.md line 27](../findings/second-order.md)** records $\dim E(\tfrac12)=18$ at $S^3\times S^3$ against a $9$-dimensional orbit; L121's $9$ four-set directions make $9+9=18$, and [Lemma L26](../findings/nondegeneracy.md)'s "$(3,3)$, where it is an equality" independently puts those directions at $\tfrac12$. **Corroboration, not conflict.**
- **[second-order.md line 720](../findings/second-order.md)**: $\mu_{p,q}=\tfrac12\iff\tfrac1{p-1}+\tfrac1{q-1}=1\iff(p,q)=(3,3)$, re-derived here from $\mu=\tfrac12(\tfrac1{p-1}+\tfrac1{q-1})$; correct, and $\mu_{2,2}=1$ as stated.
- **Padding**: the note that under padding the nonzero blocks are no longer only the $(2,2)$-splits is right, a $(2,1,1_{\text{pad}})$ subset has $A=w_1$, $B=C=w_0$.

---

**VERDICT: CONFIRMED**

Every mathematical claim in the block is correct as printed: the matrix $G$ (which **is** symmetric, the brief's premise to the contrary is a misreading of the printed rows), the identification of the Bianchi subspace with $\mathbf 1^\perp$, the full spectrum including the third eigenvalue that Bianchi removes, both forms of the radical, and the constant $\theta^2$ in the necessary condition (no factor of $2$ is lost; the $\tfrac12$ in $L_M=\tfrac12G$ and the $\tfrac12$ in L24's $\theta/2$ cancel). The $S^p\times S^q$ cross-check with [Lemma L26](../findings/nondegeneracy.md) is exact on three independent counts, which subsets are nonzero, the value $\tfrac{n-2}{2(p-1)(q-1)}$, and the eigenvector $(2,1,-1)$ with $\lVert X\rVert^2=\tfrac43$, and passing it required deriving $\Lambda=\theta$ at every $S^p\times S^q$, which in turn reproduced the record's anchors $\theta_0(6)=\sqrt{10}/3$ and $\operatorname{tr}W^\#=-1$.

**Two presentation repairs owed, neither affecting the verdict**: the block's hypothesis line over-specifies (F8, criticality is unused for the block and its spectrum, as the same file already records at line 676), and the "so … automatically" of F9 joins two facts that need two joints. **One defect found outside the block**: [plan.md line 207](../plan.md) attributes "$\mathcal D_n$ is a linear subspace" to L121, which says nothing about $\mathcal D_n$ (F11).
