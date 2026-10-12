# Review r577, Lemma L79, the $\mathcal A$ eigenvalue theorem

*Reviewer r577, independent adversarial audit of [Lemma L79](../findings/isotropy-cap.md#L208) in [isotropy-cap.md](../findings/isotropy-cap.md). Analysis only; the one machine call made was a symbolic screen of two polynomial identities I had already done by hand, reported as a screen. Written without reading the other reviewer's report on this brief.*

## Overall verdict, CONFIRMED, with three defects of statement and one refuted sentence downstream

**The four eigenvalues are right at every $m\ge3$.** I rebuilt all four from the definition by two routes that share nothing with the block's: a one-line uniform Casimir derivation, and elementary bracket computations in $\mathfrak{so}(4)$ and on a 4-plane. The trace identity the brief proposed is an exact polynomial identity and I derived it independently from the Killing marginal. Nothing in the table is wrong.

**What is wrong is what the block says about the table.** It states no range of $m$; it presupposes a $\Lambda^2$ pairing it never names, in a record that carries two differing by a factor $2$; and it contains no argument for any of the four values. Separately, [Lemma L131](../findings/isotropy-cap.md#L314)(ii) (106 lines below, in the same file), asserts an eigenvalue that contradicts L79's own table.

**And the proof of L79 stood 138 lines above L79, in L79's own file, unjoined.** [isotropy-cap.md:70](../findings/isotropy-cap.md#L70) gives $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ and [isotropy-cap.md:72](../findings/isotropy-cap.md#L72) gives the same four numbers as $T$'s spectrum, negated and reordered, described as *"verified here with multiplicities matching to the digit at $n=4,5,6,7$"*. $T=-\mathcal A$ exactly. So the table L131(i) calls *"measured at $n=4,\dots,7$"* was already provable in one line from a formula on the record.

---

## What the block leans on that is still undefined

| what | status |
| --- | --- |
| $\varphi_g$ | never defined in the block. It must be an orthonormal basis of $\Lambda^2\mathbb R^m$ for the definition to be basis-free, **and the pairing is not named**, see the norm section below |
| $W_{gh}$ | never defined. Read as $\langle W\varphi_g,\varphi_h\rangle$ throughout, which is what makes $\mathcal A(vv^{\mathsf T})=\mathrm{ad}(v)^2$ |
| $\sum_{g,h}$ | over **ordered** pairs, by [conventions.md](../findings/conventions.md)'s standing rule. Load-bearing: the unordered reading halves the off-diagonal contribution and breaks the trace identity |
| $\mathrm{Weyl}_m$ | the block writes $\mathrm{Weyl}_m$ where [conventions.md](../findings/conventions.md) tables $\mathcal W_n$. Same object, two symbols; the dimension formulas agree |
| $S^2_0(\mathbb R^m)\hookrightarrow S^2(\Lambda^2)$ | the embedding is never given. It is $h\mapsto h\owedge g$, i.e. $\omega\mapsto h\omega+\omega h$ as an operator, and the eigenvalue depends on it |
| "$\mathcal A$ is linear" | linear in $W$, mapping $S^2(\Lambda^2)\to S^2(\Lambda^2)$. That the image is symmetric needs $\mathrm{ad}$ skew-adjoint plus $W_{gh}=W_{hg}$, and is unstated |

---

## (1) The decomposition closes, CONFIRMED as a polynomial identity in $m$

With $N=\binom m2$, the claim is $\binom{N+1}2=\dim\mathcal W_m+\left(\tfrac{m(m+1)}2-1\right)+1+\binom m4$.

Left side: $\tfrac{N(N+1)}2=\tfrac{m(m-1)(m^2-m+2)}8$.

Right side, in two steps. First the Bianchi part collapses:
$$\frac{m(m+1)(m+2)(m-3)}{12}+\frac{m(m+1)}2=\frac{m(m+1)}{12}\big[(m+2)(m-3)+6\big]=\frac{m(m+1)}{12}\cdot m(m-1)=\frac{m^2(m^2-1)}{12}.$$
Then adding $\binom m4$:
$$\frac{m^2(m^2-1)}{12}+\frac{m(m-1)(m-2)(m-3)}{24}=\frac{m(m-1)}{24}\big[2m(m+1)+(m-2)(m-3)\big]=\frac{m(m-1)\cdot3(m^2-m+2)}{24},$$
which is the left side. **Exact in $m$, not at samples.**

**But the identity holds formally past the range where it is a decomposition.** At $m=2$ the Weyl dimension formula returns $-2$, and the map $S^2_0\to S^2(\Lambda^2\mathbb R^2)$ is identically zero, since $h\omega+\omega h=(\operatorname{tr}h)\omega=0$ on the one-dimensional $\Lambda^2\mathbb R^2$. The polynomial identity survives only because the two errors cancel. **So the decomposition is a decomposition for $m\ge3$**, with $\mathcal W_3=\Lambda^4\mathbb R^3=0$ and the remaining two rows correct there.

## (2) The trace identity, CONFIRMED, and derived independently of the table

Take the orthonormal basis $E_{gg}=\varphi_g\varphi_g^{\mathsf T}$ and $E_{gh}=\tfrac1{\sqrt2}(\varphi_g\varphi_h^{\mathsf T}+\varphi_h\varphi_g^{\mathsf T})$, $g<h$, of $S^2(\Lambda^2)$.

Diagonal terms vanish: $\mathcal A(E_{gg})=\mathrm{ad}_g^2$ and $\langle\mathrm{ad}_g^2\varphi_g,\varphi_g\rangle=-\lVert[\varphi_g,\varphi_g]\rVert^2=0$.

Off-diagonal: $\mathcal A(E_{gh})=\tfrac1{\sqrt2}(\mathrm{ad}_g\mathrm{ad}_h+\mathrm{ad}_h\mathrm{ad}_g)$, and for symmetric $S$, $\operatorname{tr}(SE_{gh})=\sqrt2\,\langle S\varphi_g,\varphi_h\rangle$. The $\mathrm{ad}_h\mathrm{ad}_g$ half dies on $\mathrm{ad}_g\varphi_g=0$, and the other half gives $\langle\mathrm{ad}_g\mathrm{ad}_h\varphi_g,\varphi_h\rangle=-\langle\mathrm{ad}_h\varphi_g,\mathrm{ad}_g\varphi_h\rangle=\lVert[\varphi_g,\varphi_h]\rVert^2$. So each off-diagonal basis element contributes exactly $\lVert[\varphi_g,\varphi_h]\rVert^2$ and
$$\operatorname{tr}\mathcal A=\sum_{g<h}\lVert[\varphi_g,\varphi_h]\rVert^2=\tfrac12\sum_{g,h}\lVert[\varphi_g,\varphi_h]\rVert^2 .$$

[conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(m-2)$, itself $-\operatorname{tr}(\mathrm{ad}_\alpha^2)=-(m-2)\operatorname{tr}(v_\alpha^2)$ with $\operatorname{tr}(v^2)=-2$, closes it:
$$\boxed{\operatorname{tr}\mathcal A=\tfrac12\binom m2\cdot2(m-2)=\binom m2(m-2).}$$

Against the table, $\sum\dim\times\lambda$ is $m^2(m-3)$ from the Weyl and $\Lambda^4$ rows together and $\tfrac{-m^3+3m^2+2m}2$ from the other two, summing to $\tfrac{m(m-1)(m-2)}2$. **The table passes the trace test at every $m$, not at three samples.**

*Screen (seconds of compute, on expressions I constructed for it): sympy returns residual $0$ for both identities. It is a guard on my arithmetic, not evidence for the claim, the two derivations above are the evidence.*

## Rebuilding each eigenvalue from the definition

Two facts first, both needed repeatedly.

- **$\mathcal A(vv^{\mathsf T})=\mathrm{ad}(v)^2$** for every $v\in\Lambda^2$, immediately from bilinearity. Since rank-one symmetrics span $S^2(\Lambda^2)$, this determines $\mathcal A$.
- **$\mathcal A=-T$**, where $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)$ is the operator of [isotropy-cap.md:70](../findings/isotropy-cap.md#L70). On rank ones, $T(vv^{\mathsf T})=\sum_k(\mathrm{ad}(f_k)v)(\mathrm{ad}(f_k)v)^{\mathsf T}=\mathrm{ad}(v)\big(\sum_kf_kf_k^{\mathsf T}\big)\mathrm{ad}(v)^{\mathsf T}=-\mathrm{ad}(v)^2$, using $[f_k,v]=-\mathrm{ad}(v)f_k$ and $\sum_kf_kf_k^{\mathsf T}=\mathrm{Id}$. **The record holds L79's operator under two symbols in one file and does not say so.**

### The uniform route, all four in one line, from the Casimir

Write $\rho(X)A=[\mathrm{ad}X,A]$ for the action on $S^2(\Lambda^2)$ and $\mathrm{Cas}=-\sum_k\rho(f_k)^2$ ([conventions.md](../findings/conventions.md)'s sign). Expanding $\rho(f_k)^2A=\mathrm{ad}_k^2A-2\,\mathrm{ad}_kA\,\mathrm{ad}_k+A\,\mathrm{ad}_k^2$ and using $\sum_k\mathrm{ad}_k^2=-2(m-2)\mathrm{Id}$,
$$\sum_k\rho(f_k)^2A=-4(m-2)A+2T(A)\quad\Longrightarrow\quad \mathcal A=-T=\tfrac12\mathrm{Cas}-2(m-2)\,\mathrm{Id}.$$
The normalisation is pinned internally: on $\Lambda^2$ itself the Casimir is $-\sum_k\mathrm{ad}_k^2=2(m-2)$, which is $k(m-k)$ at $k=2$. So $\mathrm{Cas}|_{\Lambda^k}=k(m-k)$, $\mathrm{Cas}|_{[2]}=2m$, $\mathrm{Cas}|_{[2,2]}=4m-4$, $\mathrm{Cas}|_{\text{trivial}}=0$, and

| summand | highest weight | $\mathrm{Cas}$ | $\tfrac12\mathrm{Cas}-2(m-2)$ | table |
| --- | --- | --- | --- | --- |
| $\mathbb R\cdot\mathrm{Id}$ | $0$ | $0$ | $-2(m-2)$ | $-2(m-2)$ |
| $S^2_0(\mathbb R^m)$ | $[2]$ | $2m$ | $-(m-4)$ | $-(m-4)$ |
| $\mathrm{Weyl}_m$ | $[2,2]$ | $4m-4$ | $+2$ | $+2$ |
| $\Lambda^4\mathbb R^m$ | $[1^4]$ | $4(m-4)$ | $-4$ | $-4$ |

**Every ingredient of this was already on the record and never joined.**

### The elementary route, per row, and what each consumes

**$\mathbb R\cdot\mathrm{Id}$, $-2(m-2)$.** $\mathcal A(\mathrm{Id})=\sum_g\mathrm{ad}_g^2$, whose trace is $\binom m2\cdot(m-2)\operatorname{tr}(v^2)=-2(m-2)\binom m2$ and which is scalar by ad-invariance. *Consumes*: $\mathrm{ad}$ skew-adjoint, the Killing normalisation $B(X,X)=(m-2)\operatorname{tr}(X^2)$, and $\operatorname{tr}(v^2)=-2$.

**$\Lambda^4$, $-4$.** For the generator $\star_{1234}$ the three surviving component pairs commute, so $\mathcal A(\star_{1234})=2[\mathrm{ad}_{12}\mathrm{ad}_{34}-\mathrm{ad}_{13}\mathrm{ad}_{24}+\mathrm{ad}_{14}\mathrm{ad}_{23}]$. On $\varphi_{12}$: the first term dies on $[\varphi_{34},\varphi_{12}]=0$, the second gives $-\varphi_{34}$ and the third gives $-\varphi_{34}$, so $\mathcal A(\star)\varphi_{12}=-4\varphi_{34}=-4\,\star\varphi_{12}$. On $\varphi_{15}$ or $\varphi_{56}$ with indices outside the 4-plane, every one of the three terms has its inner bracket vanish, so both sides are $0$. Decomposable $4$-forms span $\Lambda^4$, so **$-4$ at every $m\ge4$, with no appeal to Schur at all.** *Consumes*: $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ and vanishing on disjoint supports.

**$\mathrm{Weyl}_m$, $+2$.** At $m=4$ take $R=\omega_1\omega_1^{\mathsf T}-\omega_2\omega_2^{\mathsf T}$ with $\omega_i$ the standard self-dual basis. It is Bianchi (block-diagonal with traceless blocks, so $\operatorname{tr}(\star R)=0$) and Ricci-flat, hence in $\mathrm{Weyl}_4$. From $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$ and its cyclic partners, $\mathrm{ad}(\omega_i)^2=-2(P_+-\omega_i\omega_i^{\mathsf T})$, so
$$\mathcal A(R)=\mathrm{ad}(\omega_1)^2-\mathrm{ad}(\omega_2)^2=2\omega_1\omega_1^{\mathsf T}-2\omega_2\omega_2^{\mathsf T}=2R.$$
Padding into $\mathbb R^m$ keeps it in $\mathrm{Weyl}_m$ and the identity holds off the 4-plane too, on $\varphi_{15}$ both $\mathrm{ad}(\omega_1)^2$ and $\mathrm{ad}(\omega_2)^2$ return $-\tfrac12\varphi_{15}$ and cancel. With $\mathrm{Weyl}_m$ irreducible under $O(m)$ this pins $+2$ at every $m\ge4$. *Consumes*: the $\mathfrak{su}(2)$ bracket relations and $[\Lambda^2_+,\Lambda^2_-]=0$.

**$S^2_0$, $-(m-4)$.** With $h$ traceless symmetric and $R=h\owedge g$, the Kulkarni–Nomizu tensor acts on $\Lambda^2$ as $R\omega=h\omega+\omega h$ and has $\mathrm{Ric}=(m-2)h$. Feeding those into the Weitzenböck form gives $\mathcal A(R)=2R\omega-(m-2)(h\omega+\omega h)=-(m-4)R\omega$. **Independently of the Weitzenböck citation**, the trace identity pins this row once the other three are known, its dimension being nonzero. *Consumes*: first Bianchi, through the identification $\mathring R=R$ on skew forms.

**A cross-check on the Weitzenböck form itself.** At $R=\mathrm{Id}$ the tensor is $g_{ik}g_{jl}-g_{il}g_{jk}$ with $\mathrm{Ric}=(m-1)g$, so $2R-(\mathrm{Ric}\,\omega+\omega\,\mathrm{Ric})=(2-2(m-1))\omega=-2(m-2)\omega$, the same number the Casimir gives, by a route with nothing in common.

---

## (3) The $m=4$ degeneracies are noted for the wrong summands, and are not handled

At $m=4$ the table reads $+2,\,0,\,-4,\,-4$. **Two things happen and the block records neither.**

- **$-4$ no longer separates $\mathbb R\cdot\mathrm{Id}$ from $\Lambda^4$.** They stay distinct as $O(4)$-representations (one trivial, one the determinant character) so Schur is unharmed, but any inference of the form *$\mathcal A(R)=-4R\Rightarrow R\in\Lambda^4$* is false at $m=4$. I found no consumer making it.
- **$\mathcal A$ acquires a kernel**, all of $S^2_0$, so $\mathcal A$ is singular exactly at $m=4$. Any step inverting $\mathcal A$ or dividing by $m-4$ breaks there. I found no consumer doing so.

**What the block does mention is a different thing.** Its parenthesis about *"two scalars on $\mathrm{Weyl}$ at $m=4$"* is about the $SO$-versus-$O$ reducibility of $\mathrm{Weyl}_4=S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$, not about the eigenvalue collision. **So the sentence a reader would take as the $m=4$ caveat is about a different degeneracy from the one that is there.**

## (4) The equivariance correction is complete, and $m=8$ carries no residue

I found no surviving *"$SO(m)$-equivariant"* reading of $\mathcal A$ anywhere in [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md) or [ATTEMPTS.md](../ATTEMPTS.md); the only occurrence is the block's own record of the correction. **The correction is complete as a textual matter.**

**And it costs nothing numerically, which the record does not say.** The worry the $SO$ reading licenses is two independent scalars where the table asserts one, at $m=8$ on $\Lambda^4=\Lambda^4_+\oplus\Lambda^4_-$, and at $m=4$ on $\mathrm{Weyl}_4$. My bracket derivation settles both without Schur: $-4$ holds on **every** decomposable $4$-form at every $m$, and decomposables span $\Lambda^4$, so both $SO(8)$ halves carry $-4$; and $+2$ on the self-dual block at $m=4$ transports to the anti-self-dual block by an orientation-reversing isometry. **So the two scalars coincide anyway, and $m=8$ has no residue.** The defect was in the licence the argument claimed, not in the numbers it reached.

*This is a weaker failure than [L71](../findings/bounds.md#L450)'s, which the brief compares it to. L71 consumed Cartan's classification up to $\mathrm{Aut}(\mathfrak g)$ while needing $SO(n)$-conjugacy, and there the exceptional dimension changes the answer. Here the group was understated and the answer is unchanged.*

## (5) Bianchi and Ricci-flatness, both halves CONFIRMED, and the framing understates what is needed

**"$\Lambda^4$ is itself Ricci-flat."** For totally antisymmetric $R$, $\mathrm{Ric}_{jl}=\sum_iR_{ijil}$ vanishes termwise, the index $i$ appearing twice. So the Ricci-flat locus of $S^2(\Lambda^2)$ is $\mathrm{Weyl}_m\oplus\Lambda^4$, on which $\mathcal A$ carries two different eigenvalues, and Ricci-flatness alone cannot give $\mathcal A(R)=2R$. **CONFIRMED**, for $m\ge4$; at $m=3$ the statement is vacuous, $\Lambda^4$ and $\mathcal W_3$ both being zero.

**"Bianchi alone gives the Weitzenböck form."** CONFIRMED, Bianchi's whole role is $\sum_{k,l}R_{ikjl}\omega^{kl}=\tfrac12\sum_{k,l}R_{ijkl}\omega^{kl}$ on skew $\omega$, which identifies $\mathring R$ with the $\Lambda^2$ operator $R$; the formula then holds on all three Bianchi summands by the eigenvalues above.

**Where the block's framing is loose.** *"Bianchi does the structural work and Ricci-flatness only clears the two $\mathrm{Ric}$ terms"* reads as a ranking, and the honest statement is symmetric: **neither hypothesis alone gives $\mathcal A(R)=2R$**, Bianchi alone failing on $\mathbb R\cdot\mathrm{Id}$ at $-2(m-2)$ exactly as Ricci-flatness alone fails on $\Lambda^4$ at $-4$. The block gives the second failure and not the first. *The hedging list is incomplete in the same way as the five the brief cites, though the omission here is rhetorical rather than load-bearing.*

**A positive statement the block could carry instead**: for $m\ge3$ the solution set of $\mathcal A(R)=2R$ is exactly $\mathrm{Weyl}_m$, since $2$ coincides with no other row's value there ($-(m-4)=2$ needs $m=2$; $-2(m-2)=2$ needs $m=1$; $-4$ never).

---

## The block against the brief's remaining questions

**Does the block state its heading's claim, and is the argument present?** It states the claim. **The argument is absent.** What is present is Schur, which establishes that there are four scalars, plus an attribution, *"the four constants are exact (Reviewers 60 and 61)"*. Not one of the four values is derived in the block. [L131](../findings/isotropy-cap.md#L312)(i) supplies a route 104 lines below, but routes it through [Böhm–Wilking's Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), which by [ATTEMPTS.md](../ATTEMPTS.md)'s own reading cannot reach $\Lambda^4$ at all, plus *"the Casimir on $\Lambda^4$"* named and not carried out. **So the $-4$ has no written derivation anywhere on the record.** The two above are offered to fill it.

**The norm.** The definition presupposes $\{\varphi_g\}$ orthonormal and **never says for which pairing**, in a record whose [conventions.md](../findings/conventions.md) flags exactly this as live: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing and $2$ under plain Frobenius. The choice is not cosmetic. Rescaling the $\Lambda^2$ pairing by $c$ rescales unit bivectors by $c^{-1/2}$ and leaves $W$'s eigenvalues alone, so $\mathcal A$ scales by $c^{-1}$: **under plain Frobenius the whole table halves**, to $+1,\,-\tfrac{m-4}2,\,-(m-2),\,-2$. The table as printed is the half-trace one, which is the record's ([conventions.md](../findings/conventions.md): *"the one every result uses"*), and it is consistent with $\operatorname{tr}(v^2)=-2$ throughout my derivations, but the block relies on the reader supplying it.

*A consequence worth recording: the factor $2$ in [L131](../findings/isotropy-cap.md#L307)'s $\mathcal A=-2(\cdot\#I)$ is exactly this normalisation. Under plain Frobenius the identity reads $\mathcal A=-(\cdot\#I)$. Stating the constant without stating the pairing is the trap [conventions.md](../findings/conventions.md) already names.*

**The quantifier.** The block states none, and [L131](../findings/isotropy-cap.md#L312)(i) says *"at every $n$"*. **The true range is $m\ge3$**: at $m=2$ the decomposition itself fails, as shown above. At $m=3$ the table is correct with two rows empty. Below the programme's own $n\ge4$ this changes nothing, but *"every $n$"* is false as written.

**What cites it, and whether the use is inside its hypotheses.** The identifier appears in the live record only at its own heading and at L131(i); the citations run under other names.

| consumer | what it takes | verdict |
| --- | --- | --- |
| [stratum-two-negative.md:138](../findings/stratum-two-negative.md#L138), [results.md](../results.md) L33, [isotropy-cap.md:205](../findings/isotropy-cap.md#L206) | $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$, which **is** $\mathcal A(W)=2W$, the $+2$ row | inside hypotheses; $W\in\mathrm{Weyl}_m$ is exactly the $+2$ eigenspace |
| [isotropy-cap.md:70–72](../findings/isotropy-cap.md#L70), and [L36](../findings/isotropy-cap.md#L17)'s canonical proof | $T$'s spectrum $2n-4,\,n-4,\,-2,\,4$, and $-2$ as $T$'s least eigenvalue | see the note below |
| [ATTEMPTS.md:3913](../ATTEMPTS.md) | the same table, to fix $c_4=2$ | inside hypotheses, and correct: $\mathcal A|_{\Lambda^4}=-4$ gives $\#I|_{\Lambda^4}=2$ |
| [L131](../findings/isotropy-cap.md#L302)(i), (iii) and its closed form | the table, and $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$ | consistent, that formula returns $-4$ on $\Lambda^4$ and the Weitzenböck form on the Bianchi part, and $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\mathrm{Alt}(R)$ checks on $\mathbb R\cdot\mathrm{Id}$ and $\Lambda^4$ |
| [L131](../findings/isotropy-cap.md#L314)(ii) | *"$\mathrm{Weyl}_n$ is $\mathcal A$'s $-2$ eigenspace"* | **REFUTED**, see below |

### REFUTED: L131(ii) states an eigenvalue that contradicts L79's table in the same file

$\mathrm{Weyl}_n$ is $\mathcal A$'s $+2$ eigenspace and $T$'s $-2$ eigenspace, $T=-\mathcal A$. Independently of my derivation, L131's own arithmetic says so: $W\#I=-W$ with $\mathcal A=-2(\cdot\#I)$ gives $\mathcal A(W)=+2W$.

**The provenance is visible.** [ATTEMPTS.md:3901](../ATTEMPTS.md) writes the correct sentence about $T$ (*"$\mathrm{Weyl}_n$ being $T$'s $-2$ eigenspace is $W\#I=-W$"*) and the findings block substituted $\mathcal A$ for $T$ without the sign. The same line of ATTEMPTS.md also attributes $(2n-4,n-4,-2,4)$ to L79, which is $T$'s table: L79's is its negation, in a different summand order.

**Repair**: L131(ii) should read *"$\mathrm{Weyl}_n$ is $\mathcal A$'s $+2$ eigenspace"*, and the two operators want one line saying $T=-\mathcal A$.

### A consumer note on L36, from the same degeneracy

[L36](../findings/isotropy-cap.md#L17) is stated for *"every $n\ge3$"* and its proof rests on *"$-2$ being $T$'s only negative eigenvalue"* ([isotropy-cap.md:72](../findings/isotropy-cap.md#L72)). **That reason is false at $n=3$**, where $\mathrm{Weyl}_3=0$ so the $-2$ eigenspace is empty, and $T$'s only negative eigenvalue is $n-4=-1$ on $S^2_0$.

**The conclusion survives, by the correct eigenvalue.** With $P$ the projection onto $\mathfrak m$, the $\mathbb R\cdot\mathrm{Id}$ component has norm$^2$ $d^2/N$ and the rest $d-d^2/N$, so $\mu\ge(2n-4)\tfrac{d^2}N+\lambda\big(d-\tfrac{d^2}N\big)$. At $\lambda=-2$ this is the block's $4d^2/n-2d$; at $n=3$, $N=3$, $\lambda=-1$ it is $d^2-d$, and chaining against $\mu\le(n-2)d=d$ gives $d\le2=\lfloor 9/4\rfloor$. **So the cap holds at $n=3$ and the stated reason does not.** A footnote fixes it; nothing downstream moves.

## What the record already knew, the fact settling L79 sits in L79's own file

[isotropy-cap.md:70](../findings/isotropy-cap.md#L70) carries $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, and [conventions.md](../findings/conventions.md) carries the Casimir sign. Together with $\mathrm{Cas}|_{\Lambda^k}=k(n-k)$ (itself pinned by the record's own $\sum_k\mathrm{ad}_k^2=-2(n-2)\mathrm{Id}$) that is a complete proof of all four values in one line, 138 lines above the block that calls them *"exact (Reviewers 60 and 61)"* and that [L131](../findings/isotropy-cap.md#L312)(i) calls *"measured at $n=4,\dots,7$"*.

**The two blocks never reference each other, and the table appears twice in the file under opposite signs and different orderings.** That is the collision that produced L131(ii)'s wrong sentence.

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1 | the four eigenvalues $+2$, $-(m-4)$, $-2(m-2)$, $-4$ | **CONFIRMED**, all four, by two routes sharing nothing with the block's |
| 2 | the decomposition closes | **CONFIRMED** as an exact polynomial identity in $m$, for $m\ge3$ |
| 3 | $\operatorname{tr}\mathcal A=\binom m2(m-2)$ | **CONFIRMED**, derived from the Killing marginal, independent of the table |
| 4 | $O(m)$-equivariance, and the $m=8$ residue | **CONFIRMED**; the correction is textually complete and carries **no numerical residue** at $m=8$ or $m=4$ |
| 5 | Ricci-flatness alone fails because $\Lambda^4$ is Ricci-flat | **CONFIRMED** for $m\ge4$ |
| 6 | Bianchi alone gives the Weitzenböck form | **CONFIRMED**; the framing understates, Bianchi alone failing on $\mathbb R\cdot\mathrm{Id}$ just as Ricci-flatness fails on $\Lambda^4$ |
| 7 | the quantifier | **DEFECT**, none stated, and L131(i)'s *"every $n$"* is false at $m=2$; the range is $m\ge3$ |
| 8 | the norm | **DEFECT**, the pairing behind "orthonormal $\varphi_g$" is never named, and the whole table halves under the other one the record carries |
| 9 | the argument | **DEFECT**, the block proves that four scalars exist and derives none of them; the $-4$ has no written derivation anywhere on the record |
| 10 | the $m=4$ degeneracies | **DEFECT**, $-4$ shared by two summands and a kernel on $S^2_0$, neither recorded; the block's $m=4$ sentence is about a different degeneracy |
| 11 | L131(ii), *"$\mathrm{Weyl}_n$ is $\mathcal A$'s $-2$ eigenspace"* | **REFUTED**, it is the $+2$ eigenspace, by the block's own table and by L131's own $\#$ arithmetic |
| 12 | L36's *"$-2$ is $T$'s only negative eigenvalue"* at $n\ge3$ | **REPAIRED**, false at $n=3$, where the correct eigenvalue is $-1$ on $S^2_0$ and gives the same cap |

**Overall: CONFIRMED.** Every number in L79 is right, at every $m\ge3$. The block is a true statement with an attribution where its argument should be, and four things a reader must supply from outside it: the pairing, the range of $m$, the derivation, and the $m=4$ collisions. One sentence downstream of it, in its own file, is wrong.
