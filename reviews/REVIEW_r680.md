# Review r680, Lemma L86, the parity rule and the $36$ unknowns

**Reviewer:** r680, reviewer B of a two-reviewer pair on identical cold briefs. **Analysis-only footing observed in full**: no branching run, no plethysm, no rank computation, no census, no search, and no screen was taken, none was needed, because every claim in the block is a finite representation-theoretic statement that closes on paper. Provenance was traced with `git log -S` and `git show`, which is reading. **I did not read r679, its log, or any other reviewer's output for this brief**; the two reviews r174 and r178 named *inside the block* were read only after my own derivation was complete, and are used below as provenance evidence, never as a source.

**Target read at [findings/sym3-blocks.md:82](../findings/sym3-blocks.md#L82)–[:98](../findings/sym3-blocks.md#L98)** (the `#### Lemma L86` heading plus the `## The orbit constraint` section beneath it, ending at the [L87](../findings/sym3-blocks.md#L100) heading). The file is being edited by other sessions while I read; the version audited is md5 `9410da18bf16a48b00580065dfdb6667`, working tree at `6f517aba`. Line numbers below are as of that read.

---

## VERDICT: GAP

**Every mathematical claim in the block is true, and I re-derived all of them cold.** The branching claim, the parity rule, the reduction of the orbit condition to one scalar, the $16$ blocks, the $3570$, the $25$ surviving multiplicities, the $36$, the shape *two $3\times3$, five $2\times2$ and nine scalars*, and the eight named block deaths all reproduce by hand from [L83](../findings/sym3-blocks.md#L15)'s table and the definitions. **Nothing here is refuted.**

The gap is threefold and none of it moves a number:

1. **The block's own heading claims a number the block does not prove.** *"and the $36$ unknowns it leaves"* is not a consequence of the parity rule; the block's own body says so, in the reviewer-177 paragraph, and [L87](../findings/sym3-blocks.md#L100) four lines below supplies the missing step **by a second mod-$p$ measurement**. What L86 proves is $\text{unknowns}\ge36$.
2. **$65=36+29$ is one computation split two ways, not two closures.** The identity is termwise Pascal: $\binom{m+1}2-\binom m2=m$, so $29=\sum_{\lambda_2\text{ even}}m_\lambda$ is exactly the complement of $36$ and confirms nothing. This is the same shape [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) found in [L83](../findings/sym3-blocks.md#L15)'s *"four independent ways"*, one block above.
3. **Four objects the block reasons with are undefined on the record**: $H$, $W_0$, the $\mathfrak{so}(4)$ label map $\mu\mapsto(j_L,j_R)$, and $\sigma_\lambda$, the last colliding with the $\sigma$ of the next sentence. The $L/R$ ambiguity is not hypothetical: **the record already carries both signs of $\mu_2$ for the same constituent**, [r174](REVIEW_r174.md) writing $(\lambda_2,+\lambda_2)$ where the block writes $(\lambda_2,-\lambda_2)$.

**[L59](../findings/sym3-blocks.md#L183) and [L62](../findings/sym3-blocks.md#L227) may rest on this as they do**, with one qualification, stated in §7.

---

## 0. Readings adopted, and what [conventions.md](../findings/conventions.md) does not carry

Read in full first, as the brief directs. Almost nothing in it bears on this block, which is pure $B_2$ representation theory; the entries I did consume:

| reading | source | status |
| --- | --- | --- |
| $\mathcal W_n$ = algebraic Weyl operators, $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$, so $\dim\mathcal W_5=35$ | [conventions.md](../findings/conventions.md) | carried |
| the Casimir sign $C=-\sum_a\rho(A_a)^2$, making $\langle\lambda,\lambda+2\rho\rangle$ positive | [conventions.md](../findings/conventions.md) | carried |
| padded $W_{\mathbb{CP}^2}$ sits at $\theta=\sqrt{3/2}=M(5)$, with $\lVert W_0\rVert^2=1$ and $\operatorname{tr}(W_0^3)=1/\sqrt6$ | [INDEX-values.md:19](../findings/INDEX-values.md#L19) | carried |
| $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ | [sym3-blocks.md:3](../findings/sym3-blocks.md#L3) | carried, in the file |
| $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ on $\mathfrak{so}(5)$, and $B_K=-6B$ | [sym3-blocks.md:11](../findings/sym3-blocks.md#L11), [conventions.md](../findings/conventions.md) | carried, flagged there as a live two-meaning collision |
| the weight labels are the $e$-basis, so $\lambda=(\lambda_1,\lambda_2)$ with $\lambda_1\ge\lambda_2\ge0$ | [L83](../findings/sym3-blocks.md#L15)'s audit note | carried, at L83 only |

**Four readings I had to adopt without the record stating them.** Each is flagged again in §6.

- **$H:=\mathrm{Stab}_{O(5)}(W_0)$.** The letter $H$ appears in the heading, in the body, in [L87](../findings/sym3-blocks.md#L100) and in [L62](../findings/sym3-blocks.md#L227)'s audit note, and **is defined nowhere in [findings/](../findings/)**. A grep for a definition returns nothing.
- **$W_0:=$ the padded Weyl tensor of $\mathbb{CP}^2$, unit-normalised.** Introduced by first use inside $\mathrm{Stab}_{O(5)}(W_0)$; the preceding clause names *"the padded $W_{\mathbb{CP}^2}$"* and the identification is left to the reader. Not in [conventions.md](../findings/conventions.md).
- **$j_L=\tfrac12(\mu_1+\mu_2)$, $j_R=\tfrac12(\mu_1-\mu_2)$**, with $\mathfrak{su}(2)_R$ the factor acting on $\Lambda^+$ and $\mathfrak{su}(2)_L$ the factor contained whole in $U(2)$. The block fixes neither the map nor which factor is which; this is the only assignment under which its own sentence is true.
- **$\sigma_\lambda$ = the $V_\lambda$-valued covariant of degree $3$ attached to a multiplicity vector.** Never defined. Two sentences later $\sigma$ denotes the $\mathfrak{su}(2)_R$ Weyl element, a **different object under the same letter, inside one paragraph**.

---

## 1. The reduction to a single condition, CONFIRMED, with three unstated facts

The sentence under audit: *"$F_5$ vanishes on the whole $O(5)$-orbit of the padded $W_{\mathbb{CP}^2}$, so every covariant entering a certificate vanishes there, and by equivariance that is the single condition $\sigma_\lambda(W_0)=0$."*

It is correct. The derivation, with each fact named:

**(a) $F_5$ vanishes on the orbit.** $F_5$ is $O(5)$-invariant, and $F_5(W_0)=\tfrac32-9\operatorname{tr}(W_0^3)^2=\tfrac32-9\cdot\tfrac16=0$ using [INDEX-values.md:19](../findings/INDEX-values.md#L19). Invariance plus one zero gives the orbit. **The block asserts orbit vanishing and never says it is invariance that carries it there**, trivial, but it is the first of the three.

**(b) Each cubic of a certificate vanishes on the orbit.** If $F_5=\sum_iq_i^2$ with the $q_i$ **real**, then $\sum q_i(x)^2=0$ forces every $q_i(x)=0$. **The reality hypothesis is load-bearing and unstated**, and it is not idle in this file: the certificate machinery here is built over $\mathbb Q(i)$ ([L88](../findings/sym3-blocks.md#L104), [L90](../findings/sym3-blocks.md#L141)), and [r598](REVIEW_r598.md) records the shipped Gram as Hermitian with $47$ parameters. The step survives ($\lvert q\rvert^2=(\operatorname{Re}q)^2+(\operatorname{Im}q)^2$) but that is a sentence the block owes.

**(c) From "the cubics vanish" to "the covariants vanish".** The orbit $O(5)\cdot W_0$ is $O(5)$-stable, so $q_i$ vanishing on it implies $q_i\circ g$ vanishes on it for every $g$. Hence the whole $O(5)$-submodule $K\subseteq\mathrm{Sym}^3\mathcal W_5^*$ generated by the $q_i$ vanishes on the orbit, and $K$ decomposes isotypically. *Note that no averaging of the Gram is needed here*, orbit-stability alone does it, which is cleaner than the invariant-Gram route a reader might reconstruct.

**(d) The collapse to one scalar.** For a covariant $\sigma_\lambda:\mathcal W_5\to V_\lambda$, equivariance gives $\sigma_\lambda(gW_0)=g\,\sigma_\lambda(W_0)$, so *vanishing on the orbit* $\iff$ $\sigma_\lambda(W_0)=0$. And $h\in H$ fixes $W_0$, so $\sigma_\lambda(W_0)=\sigma_\lambda(hW_0)=h\,\sigma_\lambda(W_0)$, i.e.

$$\sigma_\lambda(W_0)\in V_\lambda^H,\qquad \dim V_\lambda^H\le1 .$$

**So it is one scalar condition.** The facts used are: the orbit is $O(5)$-stable *(unstated)*; $\sigma_\lambda$ is equivariant into an **irreducible** $V_\lambda$ *(unstated, irreducibility is what bounds $V_\lambda^H$)*; $W_0$ is $H$-fixed *(implicit in the $\mathrm{Stab}$ notation)*; and $\dim V_\lambda^H\le1$.

**The brief's two candidate hypotheses, adjudicated.** *Single orbit*: used, but trivially, the object is defined as one orbit, and the argument would still run on a finite union with one condition per orbit. *Irreducibility of the covariant*: **genuinely used**, and it is the fact that does the work, since only irreducibility gives $\dim V_\lambda^H\le1$.

**The one ordering complaint.** The clause *"by equivariance that is the single condition"* consumes $\dim V_\lambda^H\le1$, which the block derives **in the next paragraph**. It is not circular (the parity argument uses nothing from this sentence) but as written the reader meets the conclusion before its input. One forward pointer fixes it.

**Codimension, made explicit.** Writing $E(q)=q(W_0)$ and restricting to the $\lambda$-isotypic piece $M_\lambda\otimes V_\lambda$, $H$-invariance of $E$ puts $E\rvert_\lambda\in M_\lambda^*\otimes(V_\lambda^*)^H$, so $E\rvert_\lambda=\phi_\lambda\otimes\sigma_\lambda^*$ with $\phi_\lambda\in M_\lambda^*$. Then $K_\lambda=\ker\phi_\lambda\otimes V_\lambda$, of codimension $1$ in the multiplicity space **when $\phi_\lambda\ne0$** and codimension $0$ otherwise. **That $\phi_\lambda\ne0$ is exactly the rank-one step**, and it is not in L86, see §5.

---

## 2. The branching claim, CONFIRMED, symbolically and in one line

**The statement.** Branching $\mathfrak{so}(5)\to\mathfrak{so}(4)$ leaves exactly one constituent with $j_L=0$, namely $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, and it has $j_R=\lambda_2$.

**Proof.** The classical $SO(5)\downarrow SO(4)$ branching is **multiplicity-free**, with constituents exactly the integral $\mu=(\mu_1,\mu_2)$ satisfying the interlacing

$$\lambda_1\ \ge\ \mu_1\ \ge\ \lambda_2\ \ge\ \lvert\mu_2\rvert .$$

Under $\mathfrak{so}(4)=\mathfrak{su}(2)_L\oplus\mathfrak{su}(2)_R$ the spins are $j_L=\tfrac12(\mu_1+\mu_2)$ and $j_R=\tfrac12(\mu_1-\mu_2)$. Then

$$j_L=0\iff \mu_2=-\mu_1\ \Longrightarrow\ \lvert\mu_2\rvert=\mu_1,$$

and the interlacing reads $\mu_1\ge\lambda_2\ge\lvert\mu_2\rvert=\mu_1$, which **forces $\mu_1=\lambda_2$**, hence $\mu=(\lambda_2,-\lambda_2)$ and $j_R=\tfrac12(\lambda_2+\lambda_2)=\lambda_2$. It does occur, since $\lambda_1\ge\lambda_2\ge\lambda_2\ge\lambda_2$ holds. **Existence and uniqueness in three lines, no examples.** $\square$

**Four dimension audits, run only as confirmation after the fact.**

| $\lambda$ | constituents $\mu_1=\lambda_2\dots$ | dimensions | sum | $\dim V_\lambda$ |
| --- | --- | --- | --- | --- |
| $(1,0)$ | $(1,0),(0,0)$ | $4+1$ | $5$ | $5$ ✓ |
| $(1,1)$ | $(1,1),(1,0),(1,-1)$ | $3+4+3$ | $10$ | $10$ ✓ |
| $(2,1)$ | $(1,\pm1),(1,0),(2,\pm1),(2,0)$ | $3{+}3{+}4{+}8{+}8{+}9$ | $35$ | $35$ ✓ |
| $(2,2)$ | $(2,\mu_2)$, $\mu_2=-2\dots2$ | $5{+}8{+}9{+}8{+}5$ | $35$ | $35$ ✓ |

**The convention defect, and it is on the record already.** The sign of $\mu_2$ is not intrinsic: under the equally standard map $j_L=\tfrac12(\mu_1-\mu_2)$ the same argument forces $\mu=(\lambda_2,+\lambda_2)$, since $(\lambda_2,\lambda_2)$ and $(\lambda_2,-\lambda_2)$ are the mirror pair exchanged by an orientation-reversing element of $O(4)$, one carrying $(j_L,j_R)=(0,\lambda_2)$ and the other $(\lambda_2,0)$. **Both are in the record**: the block writes $(\lambda_2,-\lambda_2)$; [REVIEW_r174.md:78](REVIEW_r174.md#L78) writes *"the interlacing then forces $p=q=b$: exactly one constituent survives, with $(j_+,j_-)=(b,0)$"*, i.e. $(\lambda_2,+\lambda_2)$. **Two derivations of one lemma, disagreeing on a sign that neither states a convention for.** Nothing downstream moves, since $j_R=\lambda_2$ either way, but this is precisely the class of collision [conventions.md](../findings/conventions.md) exists to prevent. *Repair: one clause naming $j_{L,R}=\tfrac12(\mu_1\pm\mu_2)$ and which factor lies inside $U(2)$.*

**Well-posedness, which nobody states and which does need a line.** The argument presumes $H$ preserves the $\mathfrak{su}(2)_L/\mathfrak{su}(2)_R$ splitting. It does: an element of $O(4)$ with $\det=-1$ exchanges $\Lambda^\pm$, and no such element lies in $H$ (§3), while $\varepsilon$ acts trivially on $\mathbb R^4$. **Had $H$ contained a $\Lambda^\pm$-swapping element, "the constituent with $j_L=0$" would not be a well-defined object.**

---

## 3. The stabiliser and the parity rule, CONFIRMED

### 3.1 What $H$ is, derived rather than quoted

$W_{\mathbb{CP}^2}$ is self-dual: $W^-=0$ and $W^+=\operatorname{diag}(2a,-a,-a)$ on $\Lambda^+$ in a basis whose first vector is the Kähler form $\omega$.

- **No orientation-reversing element of $O(4)$ stabilises it.** Such a $g$ carries the $\Lambda^+$-block of $W$ to the $\Lambda^-$-block; $gWg^{-1}=W$ would give $W^+=0$. So $\mathrm{Stab}_{O(4)}(W)=\mathrm{Stab}_{SO(4)}(W)$.
- **In $SO(3)_+$ the stabiliser of $\operatorname{diag}(2a,-a,-a)$ is $S(O(1)\times O(2))\cong O(2)$**, the line $\mathbb R\omega$ is preserved, *not* the vector, which is what admits the second component.
- Pulling back along $SU(2)_+\times SU(2)_-\twoheadrightarrow SO(4)$ gives $\bigl(N(T)_+\times SU(2)_-\bigr)/\{\pm1\}$, of dimension $1+3=4$, **identity component $\bigl(T_+\times SU(2)_-\bigr)/\{\pm1\}\cong U(2)$, two components.**
- **In $O(5)$ nothing new appears beyond the padding reflection.** $\operatorname{im}W_0=\Lambda^+$, whose support (the smallest $U$ with $\Lambda^+\subset\Lambda^2U$), is $\mathbb R^4$, since $\omega$ is nondegenerate there. Support is functorial, so any $g$ commuting with $W_0$ satisfies $g\mathbb R^4=\mathbb R^4$ and hence $g\mathbb Re_5=\mathbb Re_5$. Therefore $H=\mathrm{Stab}_{O(4)}(W)\times\{\pm1\}_{e_5}$: **four components, identity component $U(2)$.**

**This is exactly the block's sentence**, *"identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis"*, and it agrees with a figure computed elsewhere for a different purpose: [second-order.md:243](../findings/second-order.md#L243) and [LEDGER.md:1154](../findings/LEDGER.md#L1154) give the orbit dimension $\binom n2-4-\binom{n-4}2$, which at $n=5$ is $10-4-0=6$, so $\dim H=\dim SO(5)-6=4=\dim U(2)$ ✓. **An independent anchor the block does not claim.**

*One cross-file wrinkle, harmless.* [second-order.md:243](../findings/second-order.md#L243) calls $U(2)\times SO(n-4)$ *"the stabiliser"* where L86 correctly calls $U(2)$ only the **identity component**. Since that file uses it only for an orbit dimension, no number moves, but the two files say different things about the same group.

### 3.2 $U(2)$ is a subgroup of $H$ of index $4$, not $H$

The block's $U(2)$ is $H^\circ$. It says so (*"identity component"*), and it distinguishes the roles correctly: *"The $U(2)$-invariants are therefore always one-dimensional, and what decides is the extra component."* **The brief's question is answered in the block itself.**

### 3.3 $\dim V_\lambda^{U(2)}=1$ always

$U(2)=(SU(2)_L\times U(1)_R)/\{\pm(1,1)\}$ with $U(1)_R\subset SU(2)_R$ the stabiliser torus of $\omega$. A vector is fixed by the quotient iff fixed by the cover, so

$$V_\lambda^{U(2)}=\bigl(V_\lambda^{SU(2)_L}\bigr)^{U(1)_R} = \bigl(\text{the unique }j_L=0\text{ constituent, spin }j_R=\lambda_2\bigr)^{m_R=0},$$

which is **one-dimensional, because $\lambda_2$ is an integer** and the spin-$\lambda_2$ module has exactly one weight-zero line. $\square$

**An unstated hypothesis, narrow but real.** The lemma is headed with no restriction on $\lambda$, and **it is false for half-integral (spin) $\lambda$**, where $j_R=\lambda_2\notin\mathbb Z$, no $m=0$ vector exists, $\dim V_\lambda^{U(2)}=0$, and "$\lambda_2$ even" is not even a meaningful predicate. Only integral weights occur here, [L88](../findings/sym3-blocks.md#L104) states it explicitly, *"Every one of the $24$ weights is integral for $B_2$"*, so nothing is wrong downstream. *Repair: "for integral $\lambda$", four words.*

### 3.4 $\varepsilon$ is redundant, CONFIRMED

$\mathcal W_5\subset(\mathbb R^5)^{\otimes4}$, so $-\mathrm{Id}$ acts by $(-1)^4=+1$ on $\mathcal W_5$ and hence trivially on $\mathrm{Sym}^3(\mathcal W_5)$. Therefore $\varepsilon=\operatorname{diag}(1,1,1,1,-1)$ acts as $-\varepsilon=\operatorname{diag}(-1,-1,-1,-1,1)$, which has determinant $+1$, lies in $SO(5)$, and restricts to $-I_4$, **the central scalar $-1$ of $U(2)$, already inside $H^\circ$.** So $\varepsilon$ fixes $V_\lambda^{U(2)}$ pointwise. ✓ The block's sentence is exactly right.

### 3.5 $\sigma$ decides, and the sign is $(-1)^{\lambda_2}$

The non-identity component of $\mathrm{Stab}_{SO(4)}$ is $(w,1)$ with $w\in N(T)_+\setminus T_+$, in quaternion coordinates $x\mapsto jx$, whose adjoint sends $\omega\mapsto-\omega$ and preserves $\omega^\perp\cap\Lambda^+$. It lies in the factor **not** contained in $U(2)$, so on the $j_L=0$ constituent it acts as the spin-$\lambda_2$ Weyl element, which sends $\lvert j,m\rangle\mapsto(-1)^{j-m}\lvert j,-m\rangle$ and hence acts on the $m=0$ line by $(-1)^{\lambda_2}$.

*The coset representative is immaterial*: two choices differ by an element of $U(2)$, which acts trivially on $V_\lambda^{U(2)}$; and $w$ versus $-w$ differ by the central $-1$ of $SU(2)_R$, which lies in $U(1)_R\subset U(2)$.

$$\boxed{\ \dim V_\lambda^H=\begin{cases}1,&\lambda_2\text{ even}\\0,&\lambda_2\text{ odd}\end{cases}\ }$$

### 3.6 The four hand-checks all reproduce, and one is an external anchor

| $\lambda$ | rule | independent realisation | verdict |
| --- | --- | --- | --- |
| $(1,0)$ | $1$ | $e_5$, fixed by $U(2)$, by $\sigma\in SO(4)$, and by $\varepsilon$ *once $-\mathrm{Id}$ is trivialised* | ✓ |
| $(1,1)$ | $0$ | $\Lambda^2\mathbb R^5$: the $U(2)$-invariant is $\omega\in\Lambda^+$, and $\sigma$ sends $\omega\mapsto-\omega$ | ✓ |
| $(2,0)$ | $1$ | $\mathrm{Sym}^2_0\mathbb R^5$: invariant forms span $\{g_4,e_5^{\otimes2}\}$, traceless part one-dimensional | ✓ |
| $(2,2)$ | $1$ | $\mathcal W_5$ itself, and **$W_0$ is the invariant vector by construction** | ✓ |

**The $(1,0)$ check quietly depends on $\varepsilon$-redundancy.** On the bare vector representation $\varepsilon$ sends $e_5\mapsto-e_5$; it is only in the twist where $-\mathrm{Id}$ acts trivially (the twist in which every constituent of $\mathrm{Sym}^3\mathcal W_5$ sits) that $e_5$ is $H$-fixed. **The block asserts "realised by $e_5$" without that qualifier**, and a reader checking it against the untwisted $\mathbb R^5$ gets $0$, not $1$.

**The brief's cross-check with the companion audit: the two agree.** [r633](REVIEW_r633.md) uses $\dim\mathcal W_5^H=1$ at $\lambda=(2,2)$ to prove [L62](../findings/sym3-blocks.md#L227)'s cap unimprovable. Independently derived here: $(2,2)$ has $\lambda_2=2$ even, unique $j_L=0$ constituent $(2,-2)$, $j_R=2$, $\sigma$ acting by $(-1)^2=+1$, **so $\dim\mathcal W_5^H=1$, and $W_0$ itself realises the line.** The consumption is legitimate. *This is the strongest single check on the rule available without computation: the rule predicts a $1$, and an object the programme already owns sits in it.*

---

## 4. The $36$, every figure reproduces by hand

From [L83](../findings/sym3-blocks.md#L15)'s table, partitioned by the parity of $\lambda_2$, and each dimension re-derived from Weyl's $B_2$ formula $\dim V_{(a,b)}=\tfrac16(2a{+}3)(2b{+}1)(a{-}b{+}1)(a{+}b{+}2)$ rather than read off:

| $m$ | $\lambda_2$ **even** | $\lambda_2$ **odd** |
| --- | --- | --- |
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ |, |
| $3$ | $(3,2)_{105}$ |, |
| $2$ | $(5,2)_{390}$, $(4,4)_{165}$, $(4,0)_{55}$, $(3,0)_{30}$, $(2,0)_{14}$ | $(4,3)$, $(4,1)$, $(3,1)$, $(2,1)$ |
| $1$ | $(6,6)_{455}$, $(6,4)_{810}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,0)_{91}$, $(1,0)_5$, $(0,0)_1$ | $(6,3)$, $(5,3)$, $(5,1)$, $(3,3)$ |

- **Even blocks: $2+1+5+8=16$** ✓ (the block's *"exactly $16$"*).
- **$\sum_{\text{even}}d_\lambda = 255+105+654+2556=3570$** ✓, spot-checks $220,35,455,810,429,14,5$ all reproduce from the formula.
- **Surviving multiplicities $41-16=25$** ✓ ($\sum m_\lambda=8+3+18+12=41$).
- **New multiplicity multiset**: two $3$'s (from the $m=4$ evens), five $2$'s (one from $(3,2)$, four from the odd $m=2$ blocks), nine $1$'s (five from the even $m=2$ blocks, four from the odd $m=1$ blocks), and eight zeros. **Two $3\times3$, five $2\times2$, nine scalars** ✓, with $2\cdot3+5\cdot2+9=25$ ✓.
- **Unknowns $\sum\binom{m'+1}2=2\cdot6+5\cdot3+9\cdot1=12+15+9=36$** ✓.
- **The eight deaths** are precisely the even $m=1$ blocks $(0,0),(1,0),(5,0),(5,4),(6,0),(6,2),(6,4),(6,6)$ ✓, the block's list, in the block's order.

**Every number in the block's closing paragraph is correct.**

---

## 5. Is the $36$ independent of the $29$?, **NO. It is one computation split two ways**

[L59](../findings/sym3-blocks.md#L183) at [sym3-blocks.md:205](../findings/sym3-blocks.md#L205) writes: *"The forms vanishing on $K\times K$ number $29$, counted block by block... So $65=36+29$ splits the invariant forms."*

Both halves are correct arithmetic **and they are the same arithmetic**:

- $65=\sum_\lambda\binom{m_\lambda+1}2$ over the original multiplicities: $12\cdot1+9\cdot3+1\cdot6+2\cdot10=65$ ✓.
- $36=\sum_\lambda\binom{m'_\lambda+1}2$ with $m'=m-1$ on the $16$ even blocks.
- The block-by-block difference is $\binom{m+1}2-\binom m2=m$ on an even block and $0$ on an odd one, so

$$29=\sum_{\lambda_2\text{ even}}m_\lambda = \underbrace{4+4}_{m=4}+\underbrace{3}_{m=3}+\underbrace{2\cdot5}_{m=2}+\underbrace{1\cdot8}_{m=1}=8+3+10+8=29 .$$

**So $65=36+29$ is Pascal's identity applied termwise to one column of one table.** Computing $29$ "block by block" and finding it complements $36$ checks nothing beyond $\binom{m+1}2=\binom m2+m$. [REVIEW_r174.md:143](REVIEW_r174.md#L143) does exactly this sum and, to its credit, presents it as *"the reduction is $29$ unknowns"* (a consequence) where L59's *"splits"* invites a reader to bank two closures.

**This is the shape the brief warned of, and it is the second sighting in this file.** [L83](../findings/sym3-blocks.md#L15)'s audit note, twenty lines above, records *"'FOUR INDEPENDENT WAYS' IS ONE... $24$, $41$ and $65$ are three moments of a single imported column."* The $36/29$ split is a **fourth** moment of the same column, read against the same parity rule. *The one genuinely independent anchor on the $65$ is [L88](../findings/sym3-blocks.md#L104)'s Weyl integration, which touches no multiplicity table; given that $65$, the $36$ and the $29$ are one number and its complement.*

---

## 6. What the block does not prove, and what the file settles for it

### 6.1 The heading's $36$ is not L86's

The block's own body concedes it, in the paragraph beginning *"THE RANK-ONE STEP IS AN INEQUALITY"*: Frobenius reciprocity bounds the evaluation map $M_\lambda\to V_\lambda^H$ but does not exclude rank $0$, so **$36$ is a lower bound on the unknowns and the eight deaths are conditional**. That is right, and it is the $\phi_\lambda\ne0$ of §1.

**So the heading *"and the $36$ unknowns it leaves"* claims a number the section proves only as $\ge$.** What L86 proves is: $\text{unknowns}\ge36$, $\sum_\lambda\mathrm{rank}_\lambda d_\lambda\le3570$, and at most $16$ blocks lose a multiplicity.

### 6.2 The file settles it four lines below, with a second measurement

[L87](../findings/sym3-blocks.md#L100) closes the gap by a squeeze: a mod-$p$ Gram rank of $3570$ is a **lower** bound on the characteristic-zero span, $3570$ is the cap from $\dim V_\lambda^H\le1$, so the two meet and all sixteen ranks are $1$. **The squeeze is valid.** But it replaces reviewer 174's measurement with reviewer 178's, so the $36$ remains **measured, not derived**, as [L59](../findings/sym3-blocks.md#L183)'s audit note now says at [sym3-blocks.md:197](../findings/sym3-blocks.md#L197): *"the chain [L87] → L59 → [L62] has two measured links, not one."*

**Consequence for the block as written.** The paragraph *"The check that would remove the dependency, now that the $41$ vectors exist"* stands **immediately above** L87, which announces the dependency removed. A reader meets, in this order: a caveat, an answer by measurement, a proposal to remove the dependency, and a heading saying it is removed. **The caveat paragraphs are L87's material sitting under L86's heading**, the file-shape defect the brief flags, in its mild form. *Repair: move the reviewer-177 and reviewer-174 paragraphs under [L87](../findings/sym3-blocks.md#L100), and state L86's conclusion as $\ge36$.*

### 6.3 $O(5)$ against $SO(5)$, used, half-stated here, fully stated one block above

**The fact.** $n=5$ is odd, so $\det(-I_5)=-1$, $-I_5\notin SO(5)$ is central in $O(5)$, and $O(5)=SO(5)\times\{\pm I\}$. Every $O(5)$-irreducible is an $SO(5)$-irreducible with a sign choice on $-I$; since $-I$ acts trivially on $\mathcal W_5$ (degree $4$ in the vector representation) it acts trivially on $\mathrm{Sym}^3\mathcal W_5$, so every constituent is $V_\lambda$ with $-I\mapsto+1$ and $O(5)$-invariants coincide with $SO(5)$-invariants. **At even $n$ the argument collapses**: $-I\in SO(n)$, $O(n)/SO(n)$ is generated by a reflection that is not central, $SO(n)$-irreducibles can fuse or split, and the $\lambda$-labelling of $O(n)$-blocks is not available.

**What the block says.** It states the half it needs (*"every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially"*) and uses it correctly to trivialise $\varepsilon$. **It does not say that $n$ odd is what licenses $SO(5)$ labels on $O(5)$ blocks, nor that the step fails at even $n$.**

**The file now settles it, twenty lines above.** [L83](../findings/sym3-blocks.md#L15)'s audit note reads: *"Using $SO(5)$ labels as an $O(5)$ block table is legitimate only because $\det(-I)=-1$ at odd $n$, and the same step fails at even $n$; the block does not say so."* **So L86 inherits a stated justification, from a neighbouring block, uncited.** That is better than the neighbouring case the brief describes, and one cross-reference closes it.

### 6.4 Definitions owed

| symbol | status | where it bites |
| --- | --- | --- |
| $H$ | **undefined anywhere in [findings/](../findings/)** | it is in the heading of L86, in L87, and in [L62](../findings/sym3-blocks.md#L227)'s note |
| $W_0$ | introduced by first use; not in [conventions.md](../findings/conventions.md) | five blocks use it |
| $\sigma_\lambda$ vs $\sigma$ | **two objects, one letter, one paragraph apart** | a reader parsing $\sigma_\lambda(W_0)=0$ against *"$\sigma$ is the $\mathfrak{su}(2)_R$ Weyl element"* reads a scalar as a group element |
| $j_L$, $j_R$ | label map unstated; **the record carries both signs** (§2) | the displayed $(\lambda_2,-\lambda_2)$ |
| integrality of $\lambda$ | unstated; the rule is false without it (§3.3) | the heading's unrestricted $\iff$ |

*Each of $H$, $W_0$ and the $\sigma$ collision is exactly the class of defect [conventions.md](../findings/conventions.md) was built to absorb, its opening rule is that a needed convention absent from it is **added there and quoted**.*

### 6.5 Provenance, clean

`git log -S` on the branching sentence returns a single commit, `f25586af` *"docs(findings): the branching rule gets its mechanism"*, whose body states the branching, the $U(2)$-invariant claim, the $\sigma$ sign and the $\varepsilon$ redundancy **in exactly the form the file carries**. The pre-image sentence said *"exactly one constituent with $j_-=0$, and $\dim V_\lambda^H=1$ iff the second label is even"*, the same content, less mechanism. **No narrowing, no manufactured claim, no drift between commit body and file.**

The $36$/shape/deaths sentence traces to `b432dfd7`, the file-creation commit. The heading traces to `8d869d2c` *"place headings for Lemmas 83-92"*, whose *"headings only: no statement, proof or ordering is altered"* promise **holds**, the diff is heading insertions and blank lines only. **The heading's overclaim (§6.1) is therefore original to the heading-placement commit, which invented the phrase "and the $36$ unknowns it leaves" for a section that already carried its own caveat.**

*Contrast the [L59](../findings/sym3-blocks.md#L183)/[L61](../findings/sym3-blocks.md#L208)/[L62](../findings/sym3-blocks.md#L227) pointer-narrowing commit the brief warns about: it does not touch L86, which carries no pointers at all.*

### 6.6 Pointers and duplication

- **The section contains no links.** Reviewers 174, 177 and 178 are cited by bare number. All three files exist, [REVIEW_r174.md](REVIEW_r174.md), [REVIEW_r177.md](REVIEW_r177.md), [REVIEW_r178.md](REVIEW_r178.md), so nothing dangles, but the file links reviews everywhere else (`[r663](../reviews/REVIEW_r663.md)`), so this section is inconsistent with its own file.
- **[L83](../findings/sym3-blocks.md#L15)'s table is consumed without citation**, as it is by L84, L87 and L88, already recorded by [r663](REVIEW_r663.md).
- **Duplication.** The *derivation* appears once in [findings/](../findings/); no second copy, numbered or not. The *rule* is consumed at four sites, [L87](../findings/sym3-blocks.md#L100) (*"$\lambda_2$-even blocks... using $\dim V_\lambda^H\le1$"*), [L59](../findings/sym3-blocks.md#L183) (*"an odd-$\lambda_2$ block dies entirely"*), [L62](../findings/sym3-blocks.md#L227)'s audit note, and [INDEX-results.md:101](../findings/INDEX-results.md#L101), **all four consistent with the rule as I derived it, and three of the four cite it.** Outside [findings/](../findings/) it is reproduced independently in [r174](REVIEW_r174.md) and [r178](REVIEW_r178.md), which is corroboration rather than duplication, modulo the sign of §2.
- **[INDEX-results.md:101](../findings/INDEX-results.md#L101) records "Gate 2: no verdict on the record"** for result 86, accurate before this pair.

---

## 7. May [L59](../findings/sym3-blocks.md#L183) and [L62](../findings/sym3-blocks.md#L227) rest on this as they do?

**Yes, with the qualification that what they rest on is the parity rule, and the $36$ they also consume additionally needs [L87](../findings/sym3-blocks.md#L100).**

| consumer | what it takes from L86 | may it? |
| --- | --- | --- |
| [L62](../findings/sym3-blocks.md#L227), via [r633](REVIEW_r633.md) §3 | $\dim\mathcal W_5^H=1$ at $\lambda=(2,2)$, to force $dF(W_0)=0$ and make the cap $13$ unimprovable | **Yes, unreservedly.** Independently derived in §3.6; $W_0$ realises the line. **This is a strictly derived use, no measurement enters it.** |
| [L62](../findings/sym3-blocks.md#L227), via [r633](REVIEW_r633.md) Step 1 | *"by equivariance that is the single condition"*, to get $q(W_0)=0$ for every $q\in K$ | **Yes.** §1 derives it; the two unstated facts (orbit-stability, reality of the squares) both hold. |
| [L59](../findings/sym3-blocks.md#L183) | the parity rule, to split blocks into "dies entirely" and "codimension one" | **The parity half, yes.** *"Codimension one"* is the rank-one step and is **[L87](../findings/sym3-blocks.md#L100)'s, not L86's**, a mod-$p$ measurement. L59 attributes neither. |
| [L59](../findings/sym3-blocks.md#L183) | the $36$ of $65=36+29$ | **Yes as a number**, every figure reproduces (§4). **But not as an independent closure** (§5): given the $65$, the $36$ and the $29$ are one computation. |

**No circularity.** L86 consumes [L83](../findings/sym3-blocks.md#L15)'s table and the geometry of $W_0$; it consumes nothing from L59, L62, L87, L88 or L90. The dependency graph L83 → L86 → L87 → L59 → L62 is acyclic, matching [r651](REVIEW_r651.md)'s and [r652](REVIEW_r652.md)'s independent traces.

---

## 8. Repairs, in order of what they cost

| # | repair | why | cost |
| --- | --- | --- | --- |
| 1 | **State L86's conclusion as $\text{unknowns}\ge36$** in the heading, and let [L87](../findings/sym3-blocks.md#L100) carry the equality | the heading claims what the body disclaims | reword a heading |
| 2 | **Move the reviewer-177 / reviewer-174 / "check that would remove the dependency" paragraphs under [L87](../findings/sym3-blocks.md#L100)** | they are L87's subject sitting under L86's heading, and the last is stale where it stands | cut and paste |
| 3 | **Define $H:=\mathrm{Stab}_{O(5)}(W_0)$ and $W_0$ in [conventions.md](../findings/conventions.md)** | neither exists on the record; five blocks use them | two table rows |
| 4 | **Rename $\sigma_\lambda$ or $\sigma$** | two objects, one letter, one paragraph | one letter |
| 5 | **Name the label map $j_{L,R}=\tfrac12(\mu_1\pm\mu_2)$ and which factor lies in $U(2)$** | [r174](REVIEW_r174.md) and the block record opposite signs of $\mu_2$ for the same constituent | one clause |
| 6 | **Add "for integral $\lambda$"** | the rule is false for spin weights (§3.3) | four words |
| 7 | **Say that the orbit is $O(5)$-stable and that the squares are real** | the two unstated facts of §1(b),(c), the second live because this file's certificate is over $\mathbb Q(i)$ | one sentence |
| 8 | **Cross-reference [L83](../findings/sym3-blocks.md#L15)'s odd-$n$ note** for the $SO(5)$-labels-on-$O(5)$-blocks step | used here, justified there, connected nowhere | one pointer |
| 9 | **Stop presenting $65=36+29$ as two counts** at [sym3-blocks.md:205](../findings/sym3-blocks.md#L205) | Pascal, termwise (§5) | one clause |
| 10 | **Link reviewers 174/177/178** and cite [L83](../findings/sym3-blocks.md#L15) | file-internal inconsistency | three links |

**No repair on this list changes a number.** $16$, $3570$, $25$, $36$, $29$, the shape and the eight deaths all stand exactly as written.

---

## 9. Computation

**None was run, and none was needed.** Every claim in this review is closed by hand: the branching by the interlacing inequality, the stabiliser by the self-duality of $W_{\mathbb{CP}^2}$ and the support of $\Lambda^+$, the parity by the $SU(2)$ Weyl element, and the counts by arithmetic over [L83](../findings/sym3-blocks.md#L15)'s twenty-four rows. **No screen was taken.** The one place where computation *would* decide something is [L87](../findings/sym3-blocks.md#L100)'s rank-one step, which is not this lemma; the block's own proposal (*evaluate the $41$ highest-weight vectors at a handful of orbit points*), would replace a mod-$p$ Gram rank with a smaller computation, **not with an argument**, and is therefore blocked under the standing rule. *What such a run would decide: whether each of the sixteen evaluation maps $M_\lambda\to V_\lambda^H$ is nonzero. A nonzero reading on all sixteen would confirm $36$ exactly; a zero on any block would raise the unknown count above $36$ and revive one of the eight deaths. It has not been authorised and I did not open it.*
