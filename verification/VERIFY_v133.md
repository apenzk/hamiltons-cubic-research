# Verify v133, Lemma L36: the isotropy cap $\lfloor n^2/4\rfloor$, its sharpness at both parities, the every-subspace Casimir floor, and the direction of the $S=0$ bridge

**Verifier v133, round L36, 2026-09-07.** Cold brief from [ROUND_L36.md](ROUND_L36.md); sources read, never cited from memory. **No numerical work of any kind was run**, every constant below is an exact hand evaluation (Casimir eigenvalues from $\langle\lambda,\lambda+2\rho\rangle$, bracket masses from the $\varphi_{ij}$ structure constants). Log: [agent_logs/verify-L36-v133.log](../agent_logs/verify-L36-v133.log).

## Claim table, verdicts before any prose

| # | claim, as a consumer would read it alone | verdict |
| --- | --- | --- |
| 1 | $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ for every isotropic $\mathfrak m\subseteq\mathfrak{so}(n)$, every $n\ge3$ | **PROVEN**, rebuilt cold, both steps |
| 2 | $T=-\sum_k\mathrm{ad}(f_k)\,\cdot\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, spectrum $2n-4,\ n-4,\ -2,\ 4$ | **PROVEN**, all four eigenvalues and all four multiplicities exact |
| 3 | $\mu\ge4d^2/n-2d$ for **every** $d$-dimensional subspace | **PROVEN**, and tight at $d=N$, the constant cannot be improved |
| 4 | the Killing block identity $2\mu+\gamma=2(n-2)d$ with $\gamma\ge0$ | **PROVEN** under isotropy, **DERIVATION NOT IN THE BLOCK**, it is 30 lines below |
| 5 | equality attained by the mixed planes at $p=\lceil n/2\rceil$, at **both** parities | **PROVEN**, isotropic, $pq=\lfloor n^2/4\rfloor$, and $\mu=(n-2)d$ exactly |
| 6 | *"which the negative eigenspace of a Weyl operator with $S=0$ is"* | **HYPOTHESIS-DEBT**, needs $W$ **critical**, stated nowhere at L36 in either form |
| 7 | *"$-2$ is $T$'s only negative eigenvalue"*, inside a statement claiming every $n\ge3$ | **FALSE AT $n=3$**; cap survives; correction lands 30 lines below |
| 8 | [isotropy-cap.md](../findings/isotropy-cap.md):11 (*"$S=0$ says **exactly** that $\langle[u,v],w\rangle=0$…"* | **OVERSTATED), one implication only**, by the record's own $S=T_1+2T_2+T_3$ |
| 9 | [results.md](../results.md):158, *"attained by the balanced symmetric pair"*, no caveat | **INHERITS THE REFUTED MAXIMISER** on the natural reading |
| 10 | which direction consumers need | **the forward one only**; nothing on the record uses the failing converse |

**Verdict: PROVEN, hypotheses corrected.** The cap, the Casimir floor and both-parity sharpness are theorems and I rebuilt each from the definitions; what is owed is the criticality hypothesis on the $S=0$ bridge clause, the $n\ge4$ qualifier on the one-eigenvalue gloss, and two citation-level repairs at [results.md](../results.md):158 and [isotropy-cap.md](../findings/isotropy-cap.md):11.

## 0. Conventions, fixed once

- $\varphi_{ij}=F_{ij}=E_{ij}-E_{ji}$, $i<j$, and $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$, which makes $\{\varphi_{ij}\}$ orthonormal and gives $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, structure constants $\pm1$, no stray factor. $N:=\dim\mathfrak{so}(n)=n(n-1)/2$.
- $c(x,y,z)=\langle[x,y],z\rangle$ is the Cartan 3-form, totally antisymmetric. **Isotropic** means $c$ vanishes identically on $\mathfrak m^{\times3}$; since $c$ is trilinear, checking a basis suffices.
- $\mu(\mathfrak m)=\sum_{a,b}\lVert[e_a,e_b]\rVert^2$ over an **orthonormal basis of $\mathfrak m$**, ordered pairs; $d=\dim\mathfrak m$; $\mathfrak h=\mathfrak m^\perp$ **in L36's sense**, which [conventions.md](../findings/conventions.md):28 warns is not the file's default $\mathfrak h=E_{\max}$.
- $\mathrm{Cas}(A)=-\sum_k[\mathrm{ad}f_k,[\mathrm{ad}f_k,A]]$ on $\mathrm{Sym}(\mathfrak{so}(n))\cong\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$, normalised so that its eigenvalue on the irreducible of highest weight $\lambda$ is $\langle\lambda,\lambda+2\rho\rangle$ with $\rho_i=(n-2i)/2$. **This normalisation is not assumed, it is pinned**: on $\mathbb R^n$ ($\lambda=e_1$) it gives $1+(n-2)=n-1$, and directly $-\sum_{i<j}F_{ij}^2=(n-1)\mathrm{Id}$, the two agree.

## 1. The hypothesis inventory

**Carried by the block itself.**

| hypothesis | where it is stated | does the written proof use it? |
| --- | --- | --- |
| $\mathfrak m$ a **linear subspace** of $\mathfrak{so}(n)$ (no subalgebra, no invariance) | statement | yes, Step 2 needs only the projection $P$ |
| $\mathfrak m$ **isotropic**: $c\equiv0$ on $\mathfrak m^{\times3}$ | statement | yes, and **only in Step 1** |
| $n\ge3$ | statement (*"Sharp, every $n\ge3$"*) | Step 2 holds at every $n\ge2$; $n\ge3$ is needed only so the cap is non-trivial |
| no genericity | statement | correct, nothing in either step is generic |
| **$W$ critical** | **nowhere** | **required by the bridge clause**, see §6 |

**Imported, and each checked against the object it is applied to.**

| import | statement as read at source | applied here to | verdict |
| --- | --- | --- | --- |
| **[Lemma L153](../findings/bounds.md)**, the Killing row marginal | $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for **any** $v\in\mathfrak{so}(n)$, any $n\ge2$ | the $d$ basis rows of $\mathfrak m$, all unit | **valid**, the general-$v$ form is wider than needed; the basis form alone suffices here. I re-derived it: $\sum_\beta\lVert\mathrm{ad}(v)v_\beta\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}(v)^2)=-B(v,v)=2(n-2)\lVert v\rVert^2$, and independently $\sum_{i<j}\lVert[\varphi_{ij},\varphi_{12}]\rVert^2=(n-2)+(n-2)=2(n-2)$, counting the pairs meeting $\{1,2\}$ in exactly one index |
| **the Casimir spectrum** on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ | eigenvalues $2n-4,\,n-4,\,-2,\,4$ | $P$, the orthogonal projection onto $\mathfrak m$ | **valid at every $n\ge3$**, §3 derives all four, and §3.1 handles the small-$n$ degenerations of $\Lambda^4$ where the naive highest weight is unavailable |
| the ordered/unordered reading of sums | [conventions.md](../findings/conventions.md):104, ordered by default, $2(n-2)$ vs $n-2$ | $\mu$, $\gamma$, $S_{XYZ}$ | **consistent inside L36**: $\mu$, $\gamma$ and the marginal are all ordered here. *The collision [r610](../reviews/REVIEW_r610.md) records lives in $S_{XYZ}$ and reaches L36 only through the $\gamma=2S_{\mathfrak{mhh}}$ restatement 30 lines below, not through the block* |
| **$S=T_1+2T_2+T_3$**, $T_3=\tfrac12\sum_{ij}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$ | [ATTEMPTS.md](../ATTEMPTS.md):1219, *"at **every** critical point with no hypotheses whatever"* | the bridge clause *"which the negative eigenspace … is"* | **the argument exists and is on file**, but it is stated at critical points, and the block imports it without the word. See §6 |
| Mantel / the Turán literature | [turan-multilinear-2026/README.md](../references/turan-multilinear-2026/README.md), read; also [qiao-2020-turan-alternating-multilinear](../references/qiao-2020-turan-alternating-multilinear/) present | the *"continuous Mantel"* paragraph | **placed correctly**, the literature's $\alpha_\Lambda$ is a **minimum over forms**, L36 a **maximum for one form**, so the cited theorems bound L36 from below and cannot supply it. **No source is cited from memory anywhere in this report** |

**Which hypotheses the written proof actually uses.** Step 2 uses *none* of them beyond $\mathfrak m$ being a subspace. Step 1 uses isotropy, and uses it exactly once, to kill the $\mathfrak{mmm}$ bracket mass so that $\gamma$ is a sum of squares. Everything else in the block is commentary.

## 2. Question 1a, the cap, derived from scratch

**Step 1 (isotropy).** For each unit $e_a\in\mathfrak m$, L153 gives $\sum_{k}\lVert[e_a,f_k]\rVert^2=2(n-2)$ over any orthonormal basis $\{f_k\}$ of $\mathfrak{so}(n)$. Splitting $\{f_k\}$ into a basis of $\mathfrak m$ and one of $\mathfrak h=\mathfrak m^\perp$ and summing over the $d$ rows,

$$\mu+X=2(n-2)d,\qquad X:=\sum_{a\in\mathfrak m,\,h\in\mathfrak h}\lVert[e_a,h]\rVert^2 .$$

That is all "L153 summed over the $d$ rows" delivers. The block's identity $2\mu+\gamma=2(n-2)d$ needs one further step, which is the type count. Write $A=\sum_{a,b,c\in\mathfrak m}c(a,b,c)^2$, $B=\sum_{a,b\in\mathfrak m,\,h}c(a,b,h)^2$, $C=\sum_{a\in\mathfrak m,\,h,h'}c(a,h,h')^2$, all over ordered slots. Expanding each norm against the full basis,

$$\mu=A+B,\qquad X=B+C\quad\Longrightarrow\quad \gamma:=X-\mu=C-A .$$

**Isotropy is exactly $A=0$**, whence $\gamma=C\ge0$ manifestly, $\mu=B$, and $\mu+B+C=2(n-2)d$ is $2\mu+\gamma=2(n-2)d$. So $\mu\le(n-2)d$. **The identity is not a tautology and $\gamma\ge0$ is not a restatement of the conclusion**, the block's own italic caveat is honest, and the content it points at is the line $\gamma=C-A$ with $A=0$.

**Step 2 (Casimir, no hypothesis).** With $P$ the orthogonal projection onto $\mathfrak m$ and $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$,

$$\langle T(P),P\rangle=-\sum_k\mathop{\mathrm{tr}}\bigl(\mathrm{ad}(f_k)P\,\mathrm{ad}(f_k)P\bigr)=\sum_k\sum_{a,b}\langle[f_k,e_b],e_a\rangle^2=\sum_{a,b}\lVert[e_a,e_b]\rVert^2=\mu,$$

the middle step using that $\mathrm{ad}(f_k)$ is skew and the last using ad-invariance, $\langle[f_k,e_b],e_a\rangle=\langle f_k,[e_b,e_a]\rangle$, then completeness of $\{f_k\}$. Decompose $P=\tfrac dN\mathrm{Id}+P_\perp$: the scalar part carries $\lVert\tfrac dN\mathrm{Id}\rVert^2=d^2/N$ at eigenvalue $2n-4$, and $\lVert P_\perp\rVert^2=d-d^2/N$ sits at eigenvalues $\ge-2$. Hence

$$\mu\ \ge\ (2n-4)\frac{d^2}N-2\Bigl(d-\frac{d^2}N\Bigr)=\frac{(2n-2)d^2}{N}-2d=\frac{4d^2}{n}-2d,$$

since $(2n-2)/N=(2n-2)\cdot\frac{2}{n(n-1)}=\frac4n$. **Chaining**: $4d^2/n-2d\le(n-2)d\iff 4d^2/n\le nd\iff d\le n^2/4$, and $d\in\mathbb Z$ gives $d\le\lfloor n^2/4\rfloor$. The floor step is unwritten in the block and is one line.

## 3. Question 1b, the spectrum, all four eigenvalues by hand

$T=\kappa\,\mathrm{Id}-\tfrac12\mathrm{Cas}$ with $\kappa$ defined by $\sum_k\mathrm{ad}(f_k)^2=-\kappa\,\mathrm{Id}$: expanding $\mathrm{Cas}(A)=-\sum_k[\mathrm{ad}f_k,[\mathrm{ad}f_k,A]]=2\kappa A+2\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)=2\kappa A-2T(A)$. And $\kappa=2(n-2)$ is L153 at a unit basis vector. So the block's $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ is right, with the same constant on both sides, a coincidence of the adjoint representation, not an algebraic identity to be assumed.

| summand | highest weight | $\mathrm{Cas}=\langle\lambda,\lambda+2\rho\rangle$ | $T=2n-4-\tfrac12\mathrm{Cas}$ |
| --- | --- | --- | --- |
| $\mathbb R$ | $0$ | $0$ | $2n-4$ |
| $\mathrm{Sym}^2_0$ | $2e_1$ | $4+2(n-2)=2n$ | $n-4$ |
| $\mathrm{Weyl}_n$ | $2e_1+2e_2$ | $8+2\bigl[(n-2)+(n-4)\bigr]=4n-4$ | $-2$ |
| $\Lambda^4$ | $e_1+e_2+e_3+e_4$ | $4+\bigl[(n-2)+(n-4)+(n-6)+(n-8)\bigr]=4n-16$ | $4$ |

**All four match the block exactly.** Multiplicities check against $\dim\mathrm{Sym}^2(\Lambda^2\mathbb R^n)=N(N+1)/2$: $1+9+10+1=21$ at $n=4$, $1+14+35+5=55$ at $n=5$, $1+20+84+15=120$ at $n=6$, $1+27+168+35=231$ at $n=7$, so the block's $\dim\mathrm{Weyl}_n=10,35,84,168$ is right at all four.

### 3.1 The small-$n$ degenerations, which the highest-weight row hides

$\Lambda^4\mathbb R^n$ is not the generic module below $n=8$, so its row must be recomputed rather than read off: $n=7$ gives $\Lambda^4\cong\Lambda^3$, $\lambda=e_1+e_2+e_3$, $\mathrm{Cas}=3+9=12$, $T=10-6=4$; $n=6$ gives $\Lambda^4\cong\Lambda^2$, $\mathrm{Cas}=2n-4=8$, $T=8-4=4$; $n=5$ gives $\Lambda^4\cong\Lambda^1$, $\mathrm{Cas}=n-1=4$, $T=6-2=4$; $n=4$ gives $\Lambda^4=\mathbb R$ trivial, $\mathrm{Cas}=0$, $T=4=2n-4$. **The value $4$ survives every degeneration**, so the block's flat "$4$" is correct at every $n\ge4$ and not merely for $n\ge8$. *At $n=4$ the $\mathbb R$ and $\Lambda^4$ summands are isomorphic trivial modules, so Schur does not separate them, but both carry $T=4$, so no mixing can move an eigenvalue. Independently: the Hodge star is $SO(4)$-equivariant, so $T(*)=-\sum\mathrm{ad}(f_k)^2\circ *=2(n-2)*=4*$.*

**No finding on the spectrum.** Every value the block prints is exact.

## 4. Question 1c, the claimed maximiser, and equality at both parities

$\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q=\mathop{\mathrm{span}}\{\varphi_{ij}:i\le p<j\}$, $q=n-p$.

**It is isotropic.** $c(\varphi_{ij},\varphi_{kl},\varphi_{rs})\ne0$ forces the three index pairs to be the three edges of a triangle: the bracket of two $\varphi$'s vanishes unless they share exactly one index, and $[\varphi_{ij},\varphi_{jl}]=\pm\varphi_{il}$ pairs only with $\varphi_{il}$. The mixed planes are the edge set of the complete bipartite graph $K_{p,q}$, which is triangle-free. **So the Cartan 3-form vanishes on a basis of $\mathfrak m$, hence on $\mathfrak m$.**

**Its dimension is the cap, at both parities.** $p=\lceil n/2\rceil$, $q=\lfloor n/2\rfloor$, $pq=\lfloor n^2/4\rfloor$: at $n=2m$, $m^2=n^2/4$; at $n=2m+1$, $(m+1)m=(n^2-1)/4$. **Equality really holds at both**, checked at the ends of the range: $n=3$ gives $\{\varphi_{13},\varphi_{23}\}$, $d=2=\lfloor9/4\rfloor$; $n=4$ gives $\{\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}\}$, $d=4$; $n=5$ gives $d=6$; $n=7$ gives $d=12$.

**And the chain closes on it, which is the real check.** Counting ordered pairs sharing their small index ($pq(q-1)$) and their large index ($pq(p-1)$),

$$\mu(\mathbb R^p\otimes\mathbb R^q)=pq(p+q-2)=(n-2)d\quad\text{exactly},$$

so $\gamma=0$ and Step 1 is an equality at the maximiser. Cross-check against the file's own figures: $n=5$, $d=6$, $\mu=18=3\cdot6$; $n=7$, $d=12$, $\mu=60=5\cdot12$. **Both reproduce exactly.**

**The parity asymmetry is in the Casimir step, not the isotropy step.** At even $n$ the Step-2 floor $4d^2/n-2d$ evaluates at $d=n^2/4$ to $n^3/4-n^2/2=(n-2)d$, the two bounds meet, so $\gamma=0$ is *forced*. At odd $n$, $d=(n^2-1)/4$ gives

$$(n-2)d-\Bigl(\frac{4d^2}{n}-2d\Bigr)=\frac{(n^2-1)}{4n}\bigl[n(n-2)-(n^2-2n-1)\bigr]=\frac{n^2-1}{4n},$$

so the $\gamma$-allowance is $2\cdot\frac{n^2-1}{4n}=\frac{n^2-1}{2n}$: **$12/5=2.4$ at $n=5$ and $24/7=3.428571\ldots$ at $n=7$**, reproducing the file's numbers exactly. **Sharpness is unaffected by this**, sharpness needs a witness, and the mixed planes are one at both parities. What the allowance blocks is *rigidity* at odd $n$, and the block says so.

## 5. Question 2, does the floor hold for every subspace, and what happens at the ends

**Yes, and I state the two ends separately because "admissible $d$" has two readings.**

| $d$ | $\mu$ | floor $4d^2/n-2d$ | status |
| --- | --- | --- | --- |
| $0$ | $0$ | $0$ | equality, vacuously |
| $1$ | $0$ (a line brackets to zero) | $4/n-2<0$ at every $n\ge3$ | holds with slack; **the floor is vacuous for $d\le n/2$** |
| $\lfloor n/2\rfloor$, a Cartan subalgebra | $0$ | $\le0$, $=0$ exactly at even $n$ | **equality at even $n$** |
| $\lfloor n^2/4\rfloor$, the mixed planes | $(n-2)d$ | $(n-2)d$ at even $n$; short by $\frac{n^2-1}{4n}$ at odd $n$ | equality at even $n$ |
| $N=n(n-1)/2$, all of $\mathfrak{so}(n)$ | $2(n-2)N=n(n-1)(n-2)$ | $\frac{4}{n}\cdot\frac{n^2(n-1)^2}{4}-n(n-1)=n(n-1)(n-2)$ | **equality, the constant $4/n$ is sharp** |

Two remarks the block does not make and a consumer should have. **(i) The floor is not merely valid at the top end, it is an equality there**, so no improvement of the form $\mu\ge\alpha d^2/n-2d$ with $\alpha>4$ is available: the cap $\lfloor n^2/4\rfloor$ is the best this pair of lemmas can give. **(ii) At even $n$ the Cartan subalgebra puts the floor at equality with $\mu=0$**, which reproves that every abelian subalgebra of $\mathfrak{so}(n)$ has dimension at most $n/2$, consistent with commuting skew matrices being simultaneously block-diagonalisable, so the floor is not overclaiming there.

**The one place the floor's proof could have failed is $n=3$, and it does not.** At $n=3$, $\mathrm{Weyl}_3=0$ and $\Lambda^4\mathbb R^3=0$, so the only summands are $\mathbb R$ and $\mathrm{Sym}^2_0$ with $T$-eigenvalues $2$ and $-1$. The derivation uses $-2$ only as a **lower** bound on the non-scalar eigenvalues, and $-1\ge-2$, so the floor survives, it is simply not tight. The cap then reads $d\le9/4$, i.e. $d\le2$, which is correct: every $2$-plane in $\mathfrak{so}(3)$ is isotropic (a $3$-form on a $2$-dimensional space is zero) and $\mathfrak{so}(3)$ itself is not, since $c(\varphi_{12},\varphi_{13},\varphi_{23})=\pm1$.

## 6. Question 3, which direction is used, and the hypothesis the bridge needs

**The consumers need the forward implication only: $S=0\Rightarrow\mathfrak m$ isotropic $\Rightarrow\dim\mathfrak m\le\lfloor n^2/4\rfloor$.** I read every citation of L36 on the record:

| consumer | what it takes | direction |
| --- | --- | --- |
| [results.md](../results.md):40, the low-strata summary | the cap as a closed stratum | forward |
| [bounds.md](../findings/bounds.md):204 | the cap as a constraint inside a relaxation | forward |
| [bounds-relaxations.md](../findings/bounds-relaxations.md):166 | the internal two-sided sandwich $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$ | forward, and only the chain |
| [Lemma L78](../findings/isotropy-cap.md):159 | the block identity **with $\alpha$ put back**, explicitly hypothesis-free | neither, it uses the identity, not the implication |
| [routes.md](../routes.md):31 (R13, closed) | the cap as "the already-proved Mantel cap" | forward |
| [r172](../reviews/REVIEW_r172.md):51,69 | a catalogued $S=0$ point *saturating* the cap | forward |

**Nothing on the record uses the failing converse.** I grepped every occurrence of "isotropic" in [results.md](../results.md) and of "L36" across the tree; no line concludes $S=0$, or the existence of a Weyl operator, from isotropy. **The refutation therefore costs the record nothing**, which is what the box in the file says, and it is right.

**But the forward implication carries an unstated hypothesis.** The clause *"isotropic, which the negative eigenspace of a Weyl operator with $S=0$ is"* is supported by exactly one thing on the record: the decomposition at [ATTEMPTS.md](../ATTEMPTS.md):1219,

$$S=T_1+2T_2+T_3,\qquad T_3=\mathop{\mathrm{tr}}(P_-W_-^\#P_-)=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2,$$

each term a compression of a PSD operator. Since $\mu_i>0$ on $E_-$, $S=0$ forces $T_3=0$ forces $P_{E_-}[v_i,v_j]=0$, which is isotropy of $E_-$. **The argument is on file and I am not supplying it.** What the block omits is the scope: that decomposition is stated *"at **every critical point**"*, and [ungraded-slack.md](../findings/ungraded-slack.md) records in the same breath that *"$S\ge0$ is printed with $W$ free and is **false off the critical set**, the record's own witness gives margin $-0.18$ at $n=6$"*. **Off the critical set, $S=0$ does not give $T_3=0$, so it does not give isotropy.** Neither [results.md](../results.md):158, nor :489, nor the block says $W$ is critical.

*I did not audit the two ingredients (A), (B) that ATTEMPTS.md substitutes to reach the boxed decomposition; the record marks them Gate-2 confirmed as identities of the whole Weyl space. **What I record is the missing hypothesis, not a doubt about the mathematics.***

## 7. The universal claim, tested against every structured family the record names

The brief asks for a witness attempt on *"every $d$-dimensional subspace satisfies $\mu\ge4d^2/n-2d$"*. I evaluated $\mu$ by hand on each named family. **No family violates it, and two attain it.**

| family | $d$ | $\mu$, by hand | floor | outcome |
| --- | --- | --- | --- | --- |
| Cartan subalgebra $\mathfrak t$ | $\lfloor n/2\rfloor$ | $0$ (abelian) | $\le0$ | holds; **equality at even $n$** |
| $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, balanced, $n=6$ | $6$ | $6+6=12$, each $\mathfrak{so}(3)$ contributing $2\cdot3\cdot1$ | $4\cdot36/6-12=12$ | **equality** |
| mixed planes $\mathbb R^p\otimes\mathbb R^q$ | $pq$ | $(n-2)pq$ | equality at even $n$ | holds |
| all of $\mathfrak{so}(n)$ | $N$ | $n(n-1)(n-2)$ | same | **equality** |
| a line, a generic plane at $n=3$ | $1$, $2$ | $0$; $2\lVert[\varphi_{12},\varphi_{13}]\rVert^2=2$ | $-2/3$; $4/3$ | holds with slack |

**And the refuted maximiser is refuted for the reasons the box gives, which I checked independently.** $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\frac{p^2+q^2-n}{2}$, which at $p=q=n/2$ is $\frac{n(n-2)}4$, **short of $\frac{n^2}4$ by exactly $n/2$**, $6$ against $9$ at $n=6$, as stated. It is also **inadmissible**: an isotropic subalgebra is abelian, since $[u,v]\in\mathfrak m$ and $\langle[u,v],[u,v]\rangle=0$; and $\mathfrak{so}(p)$ for $p\ge3$ is not abelian, with $c(\varphi_{12},\varphi_{23},\varphi_{13})=1$ inside the first factor. Both clauses hold.

**One thing the box does not say and a reader may want.** For $p,q\le2$ the object $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ *is* abelian and *is* isotropic, at $n=4$ it is a $2$-dimensional torus. So the inadmissibility is a statement about $\max(p,q)\ge3$, i.e. about every $n\ge5$ and about the balanced split at every $n\ge6$. It does not weaken the refutation, since the object is short of the cap in all those cases anyway.

## 8. Comparing the forms, read one at a time as a consumer would

| site | what it says on its own | reading it alone |
| --- | --- | --- |
| [findings/isotropy-cap.md](../findings/isotropy-cap.md):17– | full statement, the two-box correction immediately above it, the proof, the Mantel gloss, the odd-$n$ debt | **safe**, the corrections are inside the block a citer lands on |
| [results.md](../results.md):489 | the statement with **both** corrections folded into a closing italic sentence, the $n=3$ converse failure and the maximiser | **safe**, and this is the model the record should copy |
| [results.md](../results.md):158 (landscape) | *"…dimension at most $\lfloor n^2/4\rfloor$, **attained by the balanced symmetric pair**. A continuous analogue of Mantel's theorem."* | **defective**, see candidate D3 |
| [results.md](../results.md):40 | *"$S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$ (Lemma L36)"* | safe: it makes no maximiser claim and no converse claim |
| [lean/INDEX.md](../lean/INDEX.md):267 → [L36.lean](../lean/HamiltonsCubic/Results/L36.lean) | **partial**, and the row says so: `⌈n/2⌉·⌊n/2⌋ = ⌊n²/4⌋`, the shortfall $n/2$, and $\langle[\varphi_{01},\varphi_{12}],\varphi_{02}\rangle\ne0$. *"The cap itself is owed"* | **honest**. The three theorems are the arithmetic of sharpness and the inadmissibility witness, exactly the parts that need no Lie theory. `ceil_mul_floor` reads `((n+1)/2)*(n/2) = n^2/4` in `ℕ`, which is the intended identity since `ℕ`-division is the floor and `(n+1)/2 = ⌈n/2⌉` |

**What the Lean row would have to claim to cover the lemma**, since the brief asks: a formalisation of the cap needs (i) L153 as `∑ β, ‖⁅v, f β⁆‖² = 2(n-2)‖v‖²`, (ii) the type count $\gamma=C-A$ with $A=0$ under isotropy, and (iii) the Casimir floor, of which (iii) is the real cost, since it needs the isotypic decomposition of $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$ and its four eigenvalues, not available as a library fact. **The row's "partial" is correctly placed**, and a consumer must not read it as the cap having been machine-checked.

## 9. The discrepancies, each with the three-step record

### D1, the bridge clause has no criticality hypothesis · **CONFIRMED**

**Locate.** [findings/isotropy-cap.md](../findings/isotropy-cap.md):22 and [results.md](../results.md):491, identically: *"isotropic, which the negative eigenspace of a Weyl operator with $S=0$ is."* Also the headline at :158 and :489, *"$S=0$ caps the negative eigenspace"*.

**Exhibit.** The only support for that clause is $S=T_1+2T_2+T_3$, stated at [ATTEMPTS.md](../ATTEMPTS.md):1224 *"at **every critical point** with no hypotheses whatever"*. [ungraded-slack.md](../findings/ungraded-slack.md) records the failure off that set explicitly: *"$S\ge0$ is printed with $W$ free and is false off the critical set, the record's own witness gives margin $-0.18$ at $n=6$."* At such a $W$, $S=0$ is not $T_3=0$, and the negative eigenspace need not be isotropic. **The hypothesis is load-bearing and appears in neither form of L36.**

**Argue the opposite.** The most charitable reading is that $S(W)$ is a critical-point object by construction (its definition contains $\theta$, and $\theta$ is the criticality parameter of $Q(W)=\theta W$) so "a Weyl operator with $S=0$" might be read as tacitly critical. **That reading survives inside this programme and fails for a citer**, because the record itself evaluates $S$ off the critical set in the very sentence quoted above, and because [conventions.md](../findings/conventions.md):38 tables $S(W)$ as a function of $W$ with a *different* caveat attached ([W4](../findings/INDEX-traps.md): vacuous when $\ker W\ne0$). **Confirmed, as hypothesis-debt on the clause, not on the cap.**

### D2, *"$-2$ is $T$'s only negative eigenvalue"* is false at $n=3$, inside a statement scoped to $n\ge3$ · **CONFIRMED**

**Locate.** [findings/isotropy-cap.md](../findings/isotropy-cap.md):47 (the block's own commentary): *"**The whole content is one eigenvalue**, and it is the Weyl space's: $-2$ is $T$'s only negative eigenvalue, and its eigenspace is exactly $\mathrm{Weyl}_n$"*, in a block whose statement says *"Sharp, every $n\ge3$"*.

**Exhibit.** At $n=3$: $\mathrm{Weyl}_3=0$ and $\Lambda^4\mathbb R^3=0$, so $\mathrm{Sym}^2(\Lambda^2\mathbb R^3)=\mathbb R\oplus\mathrm{Sym}^2_0$ of dimensions $1+5=6=\binom{3+1}{2}$, and $T$ has eigenvalues $2n-4=2$ and $n-4=-1$. **$T$'s only negative eigenvalue at $n=3$ is $-1$, on $\mathrm{Sym}^2_0$**, and its eigenspace is not $\mathrm{Weyl}_3$, which is zero.

**Argue the opposite.** The charitable reading is that the sentence is commentary on the mechanism at the dimensions where $\mathrm{Weyl}_n$ exists, and that the *cap* is untouched, which is true, since the proof uses $-2$ only as a lower bound and $-1\ge-2$, giving $d\le9/4$, i.e. $d\le2$, which is correct and attained. **The defect is therefore in the gloss, not the theorem.** It is nonetheless a defect a citer inherits: the file's own later paragraph carries the repair (*"$-2$ being its only negative eigenvalue **at $n\ge4$**"*, with the $n=3$ case spelled out), and [LEDGER.md](../findings/LEDGER.md):1572 carries it again, **both of them below the block, neither inside it.**

### D3, the landscape line at [results.md](../results.md):158 names the refuted maximiser on the natural reading · **CONFIRMED**

**Locate.** *"…such a subspace of $\mathfrak{so}(n)$ has dimension at most $\lfloor n^2/4\rfloor$, **attained by the balanced symmetric pair**."*

**Exhibit.** A symmetric pair is a pair $(\mathfrak g,\mathfrak k)$; the balanced one here is $(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q))$. The object named is therefore ambiguous between the subalgebra $\mathfrak k$ and the odd part $\mathfrak m$, and **$\mathfrak k$ is exactly the object the file's own box refutes twice over**, it has dimension $\frac{n(n-2)}4$, short of the cap by $n/2$, and it is not isotropic at all for $\max(p,q)\ge3$. The correct object, $\mathfrak m$, is named at :489 and in the block, **not here**. This line also carries no trace of the converse failure.

**Argue the opposite.** A reader who already knows that "the symmetric pair's $\mathfrak m$" is meant reads the line correctly, and the landscape section is a summary whose entries point at :489. **That defence is exactly the trap the brief names**: this is a citable one-line form, it is the form a scanner meets first, and it contains a correction-free restatement of a refuted claim. **Confirmed.**

### D4, Step 1 is compressed past the point where isotropy enters · **CONFIRMED as a citation-level gap, not an error**

**Locate.** [findings/isotropy-cap.md](../findings/isotropy-cap.md):40 and :68, identically: *"the Killing block identity $2\mu+\gamma=2(n-2)d$, which is **Lemma L153** summed over the $d$ rows of $\mathfrak m$."*

**Exhibit.** L153 summed over the $d$ rows gives $\mu+X=2(n-2)d$ and nothing more. Reaching $2\mu+\gamma$ needs $X=\mu+\gamma$, i.e. $\gamma=X-\mu=C-A$ with $A$ the $\mathfrak{mmm}$ mass, **and $A=0$ is isotropy**. Without that line, "$\gamma\ge0$ by inspection" is unsupported, because $C-A$ is not a sum of squares in general. §2 gives the count.

**Argue the opposite.** The block does define $\gamma$ as *"the $\mathfrak h\mathfrak h\mathfrak m$ mass"*, which is $C$; with that definition the identity is true, and the block's italic caveat concedes that the naming is what makes the step an argument. **So the statement is correct as written and the missing line is the justification of the naming.** The record does carry that line, 30 lines below, in *"The odd-$n$ gap, stated sharply"* (*"counting triples by type gives $\mu=2S_{\mathfrak{mmh}}$ and $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$"*), **which is again a correction living beside its statement**, and which lands in the $S_{XYZ}$ normalisation collision that [r610](../reviews/REVIEW_r610.md) records as still owed in [conventions.md](../findings/conventions.md). *The derivation in §2 above avoids $S_{XYZ}$ entirely and is therefore immune to that collision.*

### D5, *"$S=0$ says **exactly** that…"* claims an equivalence the record's own decomposition denies · **CONFIRMED as an overstatement; witness partial**

**Locate.** [findings/isotropy-cap.md](../findings/isotropy-cap.md):11, the section heading six lines above the pointer to L36: *"#### $S=0$ says exactly that $\langle[u,v],w\rangle=0$ for all $u,v,w$ in the negative eigenspace"*.

**Exhibit.** By [ATTEMPTS.md](../ATTEMPTS.md):1224 item 3, the three terms are the violations of the **three** grading conditions, $T_1$ of $[E_+,E_+]\perp E_-$, $T_2$ of $[E_+,E_-]\subseteq E_-$, $T_3$ of $[E_-,E_-]\perp E_-$; and item 4 states $S=0\iff T_1=T_2=T_3=0$. **Isotropy of $E_-$ is $T_3=0$ alone**, so it gives $S=0$ only when $T_1=T_2=0$ as well, and ATTEMPTS records five generic $n=6$ critical points where $T_1\approx0.6$ and $2T_2\approx1.1$–$1.7$, so those two terms are not generally zero.

**Argue the opposite.** *"Says exactly that"* can be read as "the geometric content of $S=0$ is isotropy", a forward gloss rather than a biconditional, and the L36 box below does correct a neighbouring converse. **The defence is weak but not empty, so I grade this an overstatement rather than a refutation**, and I record what is missing: **no catalogued point has $T_3=0$ with $T_1+2T_2>0$**, so the record contains no single witness closing the $\Leftarrow$ direction at $n\ge4$. The record's $n=3$ witness ($\dim\mathcal W_3=0$ while isotropic $2$-planes exist and meet the cap) closes the converse of the *lemma clause*, which is a different sentence.

### Withdrawn candidates

- **"The floor fails at small $d$."** *Withdrawn.* At $d\le n/2$ the right-hand side is $\le0\le\mu$; nothing to check.
- **"The $\lfloor\cdot\rfloor$ is unjustified, the chain gives $d\le n^2/4$."** *Withdrawn as a defect, recorded as a one-line omission.* $d$ is an integer, so $d\le\lfloor n^2/4\rfloor$ follows immediately; the block writes *"i.e. $d\le n^2/4$"* and the statement writes the floor.
- **"$\Lambda^4$'s eigenvalue $4$ is derived from a highest weight that does not exist below $n=8$."** *Withdrawn*, §3.1 recomputes all four degenerations and every one returns $4$.
- **"The $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ refutation over-reaches at small $p,q$."** *Withdrawn as a refutation-breaker*, recorded as a scope note in §7: the object is abelian and isotropic for $p,q\le2$, but short of the cap there too.

## 10. The gap between what is proven and what is used, what a consumer may cite

**May be cited, unconditionally, at every $n\ge3$:**

- $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ for every isotropic subspace of $\mathfrak{so}(n)$, no genericity, no subalgebra hypothesis;
- $\mu\ge4d^2/n-2d$ for **every** $d$-dimensional subspace, isotropic or not, with **equality at $d=N$** and at the balanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at $n=6$;
- attainment at both parities by $\mathbb R^{\lceil n/2\rceil}\otimes\mathbb R^{\lfloor n/2\rfloor}$, where $\mu=(n-2)d$ exactly, so both inequalities in the chain are equalities at even $n$;
- $2\mu+\gamma=2(n-2)d$ with $\gamma$ the $\mathfrak{mhh}$ mass, **under isotropy**.

**May be cited only with the hypothesis added:** *"the negative eigenspace of a Weyl operator with $S=0$ is isotropic"*, **add "critical"**. Then it holds, by [ATTEMPTS.md](../ATTEMPTS.md):1219's $T_3\ge0$.

**May not be cited:**

- *"attained by the balanced symmetric pair"* without saying **which half of the pair**, the subalgebra half is refuted in the file it points to;
- *"$-2$ is $T$'s only negative eigenvalue"* without **$n\ge4$**;
- any equivalence between $S=0$ and isotropy of $E_-$, **the record supports one implication**;
- rigidity at the cap, at either parity. The block is explicit that the even-$n$ argument runs $\gamma=0\Rightarrow\mathfrak m^\perp$ a subalgebra $\Rightarrow$ symmetric pair $\Rightarrow$ Cartan, and that odd $n$ is open; and the conjugacy evidence behind it is flagged as random-start in [ELIM-canon.md](../reviews/ELIM-canon.md) W6. **None of that is needed for the cap.**

## 11. The falsifier, and what I did to look for it

**What would break the statement:** an isotropic subspace $\mathfrak m\subseteq\mathfrak{so}(n)$ with $\dim\mathfrak m=\lfloor n^2/4\rfloor+1$ at some $n\ge3$, equivalently, a $d$-dimensional subspace at $d>n^2/4$ on which the Cartan 3-form vanishes identically.

**Where I looked.** The chain has exactly two inputs, so a falsifier must break one of them, and both are equalities rather than estimates: L153's row marginal, which I re-derived twice (by ad-invariance and by counting the $2(n-2)$ index pairs meeting $\{1,2\}$ once), and the four $T$-eigenvalues, which I recomputed from $\langle\lambda,\lambda+2\rho\rangle$ with the normalisation pinned on $\mathbb R^n$, cross-checked against the multiplicity table at $n=4,5,6,7$, and re-derived at every small-$n$ degeneration of $\Lambda^4$. **The only slack in the argument is the gap between $-2$ and the true minimum eigenvalue on $P_\perp$'s support**, and at even $n$ the maximiser closes that gap exactly, so there is no room left to exploit at even $n$ at all. At odd $n$ the residual is $\frac{n^2-1}{4n}$ in $\mu$, which is **less than one unit of $d$** ($(n-2)$ per unit of $d$ against $\frac{n^2-1}{4n}<\frac n4$) so no odd-$n$ falsifier can hide in it either.

**I also tried the structured families directly**, in §7: the Cartan subalgebra, $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and its complement the mixed planes, the lines and planes at $n=3$, and $\mathfrak{so}(n)$ entire. **Every one satisfies the floor, two attain it, and none is isotropic above $\lfloor n^2/4\rfloor$.** In the coordinate case the question is Mantel's theorem exactly, the 3-form is supported on the triangles of $K_n$, which I verified from the structure constants, so a coordinate falsifier would be a triangle-free graph on $n$ vertices with more than $\lfloor n^2/4\rfloor$ edges. **No numerical search was run, per the standing analysis-only rule.**

## Verdict

**PROVEN, hypotheses corrected.**

The cap $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, the every-subspace floor $\mu\ge4d^2/n-2d$, and attainment at both parities by the mixed planes are theorems; I rebuilt each from the definitions with no step taken on trust. The corrections owed are: **(i)** the bridge clause needs $W$ **critical**, D1, hypothesis-debt, and it is the one that reaches every citable form; **(ii)** the one-eigenvalue gloss needs **$n\ge4$**, D2; **(iii)** [results.md](../results.md):158 must name $\mathfrak m$ rather than "the balanced symmetric pair", D3; **(iv)** the heading at [isotropy-cap.md](../findings/isotropy-cap.md):11 must be one implication, D5; **(v)** the type count that makes $\gamma\ge0$ an argument belongs inside the block, D4. **None of the five touches the cap itself.**
