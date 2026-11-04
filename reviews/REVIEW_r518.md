# REVIEW r518, Lemma L36

**Target:** Lemma L36, "$S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$", [findings/isotropy-cap.md](../findings/isotropy-cap.md) at the `#### Lemma L36` heading (line 17), down to the next heading. Second copy of the statement at [results.md](../results.md) line 462.

**Reviewer:** r518, cold, adversarial, analysis-only footing. Every step below was rebuilt from the definitions before the block was trusted.

**VERDICT: REFUTED, as stated.** The cap $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ and its proof are **correct at every step and confirmed twice over**; two clauses of the Statement are false with explicit witnesses, and one step of the proof is circular as written. Repairs are one line each, and **no downstream citation is damaged**.

---

## P0, conventions fixed against the record's anchors, before anything was derived

| anchor | rebuilt independently | verdict |
| --- | --- | --- |
| $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ | $(\mathrm{Id}^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}=\tfrac12\,\delta_{\alpha\beta}\sum_\gamma\lVert[v_\alpha,v_\gamma]\rVert^2=\tfrac12\cdot2(n-2)\,\mathrm{Id}$ | ✓ |
| $\theta_0(6)=\sqrt{10}/3$ | $\theta_0^2=2\cdot5\cdot4/36=10/9$ | ✓ |
| $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ | $0,10,35,84$ at $n=3,4,5,6$ | ✓ |
| $\mathop{\mathrm{tr}}W^\#=-1$ | not needed by L36; not re-derived |, |

**The normalisation this fixes** is the one in which $\{\varphi_{ij}\}_{i<j}$ is *orthonormal* ($\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$) and the adjoint Casimir is $c_{\mathrm{adj}}=2(n-2)$, i.e. $\sum_k\lVert[e,f_k]\rVert^2=2(n-2)$ for **unit** $e$ and orthonormal $\{f_k\}$. The $\mathrm{Id}^\#$ anchor pins it exactly, and it is the normalisation L36's $2(n-2)d$ needs. **Everything below is in it.**

> **A collision noticed in passing, in [conventions.md](../findings/conventions.md) itself.** The line "**A bivector's norm**: $\lVert\varphi_{ab}\rVert^2=2$" and the line "$\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$" disagree by a factor $2$, under the second, $\lVert\varphi_{ab}\rVert^2=1$. Under the first, $c_{\mathrm{adj}}=n-2$ and L36's $2(n-2)d$ would be wrong by $2$. **L36 is in the second convention**, consistently, and comes out right; the ambiguity is in the conventions file, not in L36. It is the same class as the $B$, $M$ and $\mu$ collisions that file already tables.

---

## F1, the equality case names an object that never attains the cap. **False as written, at every $n$.**

The Statement's clause: *"with equality attained by $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at $p=q=n/2$."*

**Two independent reasons it is false.**

1. **The dimension is wrong.** $\dim\big(\mathfrak{so}(p)\oplus\mathfrak{so}(q)\big)=\binom p2+\binom q2=\frac{n(n-2)}4$ at $p=q=n/2$, which falls short of $\frac{n^2}4$ by exactly $n/2$. At $n=6$ it is $6$ against the cap $9$; at $n=8$, $12$ against $16$; at $n=4$, $2$ against $4$.
2. **It is not even in the hypothesis class for $n\ge5$.** For a *subalgebra* $\mathfrak g$, $[\mathfrak g,\mathfrak g]\subseteq\mathfrak g$, so isotropy $\langle[\mathfrak g,\mathfrak g],\mathfrak g\rangle=0$ forces $[\mathfrak g,\mathfrak g]=0$, **a subalgebra is isotropic iff it is abelian.** $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is abelian only for $p,q\le2$, i.e. only $n\le4$, where it has dimension $2<4$. So the named object satisfies the hypothesis at no $n\ge5$ and attains the cap at no $n$ at all.

**The correct maximiser is the orthogonal complement**, $\mathfrak m=\big(\mathfrak{so}(p)\oplus\mathfrak{so}(q)\big)^\perp\cong\mathbb R^p\otimes\mathbb R^q$, of dimension $pq$. It *is* isotropic ($[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\perp\mathfrak m$ is the symmetric-pair relation) and $pq=\lfloor n^2/4\rfloor$ at $p=\lfloor n/2\rfloor$. In the $\varphi_{ij}$ basis it is the span of the cross-pairs, i.e. the edge set of $K_{p,q}$, which is what makes the Mantel reading exact.

**Its own file contradicts it, three times.**

- [isotropy-cap.md](../findings/isotropy-cap.md) line 135: *"Symmetric-pair subspaces realise $6,9,12,16$ at $n=5,6,7,8$"*, those are $pq$, not $\binom p2+\binom q2$ (which would be $4,6,9,12$).
- [isotropy-cap.md](../findings/isotropy-cap.md) "What it gives item B": *"the balanced sphere product's $\mathfrak m$ **is** the symmetric-pair subspace of $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, of dimension exactly $(n/2)^2$"*, the correct statement, and the repair, already on record 190 lines below the defect.
- The block's own "What it does not reach": *"Equality forces $\gamma=0$, hence $\mathfrak m^\perp$ a subalgebra"*, so within the block, $\mathfrak m^\perp$ is the subalgebra and $\mathfrak m$ is not.

**Repair, one line:** replace "$\mathfrak{so}(p)\oplus\mathfrak{so}(q)$" with "the isotropy summand $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ of the symmetric pair $\big(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q)\big)$". *This is loose naming of the pair by its subalgebra rather than a mathematical collapse, but in a Statement whose subject is $\mathfrak m$ and which asserts "equality attained by X", X must have dimension $\lfloor n^2/4\rfloor$, and this one never does.*

---

## F2, the "equivalently" is false in the direction that needs a construction. **Two witnesses.**

The Statement asserts that *$\mathfrak m$ isotropic for the Cartan 3-form* is **equivalent** to *$\mathfrak m$ is the negative eigenspace of a Weyl operator with $S=0$*.

**Direction (⇐), $S=0\Rightarrow$ isotropy, is a definition**, provided $S$ means $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$, which is how the record uses the bare "$S=0$" elsewhere ([nondegeneracy.md](../findings/nondegeneracy.md) line 303: *"$S_{\mathfrak{mmm}}=7\times10^{-30}$ … genuinely $S=0$"*). It carries the record's own caveat that the test is valid only at $\ker W=0$ ([target.md](../findings/target.md) line 498, [trap W4](../findings/INDEX-traps.md)).

**Direction (⇒) is a surjectivity claim and it is false.**

- **$n=3$.** $\dim\mathcal W_3=\frac{3\cdot0\cdot4\cdot5}{12}=0$, so the only Weyl operator on $\mathbb R^3$ is $0$ and the class "negative eigenspace of a Weyl operator with $S=0$" is $\{0\}$. But $\mathfrak{so}(3)$'s Cartan 3-form is a multiple of the determinant form on $\mathbb R^3$, for which **every** $2$-plane is isotropic. So an isotropic $\mathfrak m$ of dimension $2=\lfloor 9/4\rfloor$ exists and is realised by no Weyl operator.
- **$n=4$.** Take $\mathfrak m=\mathbb R\varphi_{12}$, trivially isotropic. Every $W\in\mathcal W_4$ is block-diagonal with respect to $\Lambda^2_\pm$ (the traceless-Ricci part is exactly the off-diagonal block), hence commutes with $\star$, hence **every eigenspace of $W$ is $\star$-invariant**. A $\star$-invariant line lies in $\Lambda^2_+$ or $\Lambda^2_-$; $\varphi_{12}=\tfrac12(\varphi_{12}+\varphi_{34})+\tfrac12(\varphi_{12}-\varphi_{34})$ lies in neither. So no Weyl operator on $\mathbb R^4$ has $\mathbb R\varphi_{12}$ as its negative eigenspace.

**What this costs.** The **cap is unaffected in both readings**, the isotropy class is the larger one, so a cap on it caps the Weyl class too. What fails is **sharpness in the Weyl reading at $n=3$**: the maximum of $\dim\mathfrak m$ over $S=0$ Weyl operators at $n=3$ is $0$, not $2$, so *"Sharp, every $n\ge3$"* is true only in the Lie-algebraic reading. At $n=4$ the Weyl reading is sharp, I checked it by construction: $W=-a\,\Pi_{\mathfrak m}+2a\,\Pi_{\mathfrak h}$ with $\mathfrak h=\langle\varphi_{12},\varphi_{34}\rangle$, $\mathfrak m=\langle\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}\rangle$, is traceless, commutes with $\star$ (both summands are $\star$-invariant) and is traceless on each of $\Lambda^2_\pm$ (one $+2a$ against two $-a$ in each), hence lies in $\mathcal W_4$, with negative eigenspace exactly $\mathfrak m$ of dimension $4=\lfloor16/4\rfloor$.

**Repair:** demote "equivalently" to "in particular", i.e. state the theorem for isotropic $\mathfrak m$ and record the Weyl case as the consumer. **An "equivalently" doing the work of a theorem is exactly what this is**, and the theorem it stands in for (that every isotropic subspace is realised), is false.

---

## F3, the bound itself. **CONFIRMED, rebuilt cold, exact at every step.**

Let $d=\dim\mathfrak m$, $N=\binom n2$, $\{e_a\}$ orthonormal in $\mathfrak m$, $\{f_k\}$ orthonormal in $\mathfrak m^\perp$, $\mu=\sum_{a,b}\lVert[e_a,e_b]\rVert^2$ over **ordered** pairs.

**Step 1, the Killing block identity, derived rather than assumed.** Sum the Killing marginal $\sum_{\text{all }\beta}\lVert[e_a,v_\beta]\rVert^2=2(n-2)$ over $a=1,\dots,d$:
$$\mu+\underbrace{\textstyle\sum_{a,k}\lVert[e_a,f_k]\rVert^2}_{X}=2(n-2)d .$$
Split $X$ by the type of the third index and use total antisymmetry of $c_{abc}$ (so $T_{abc}=c_{abc}^2$ is totally symmetric): $X=\sum_{a,k,c}c_{akc}^2+\sum_{a,k,l}c_{akl}^2$. The first sum re-indexes to $\sum_{a,c,k}c_{ack}^2$, which under isotropy is $\mu$ exactly, since isotropy puts $[\mathfrak m,\mathfrak m]$ wholly in $\mathfrak m^\perp$. Hence $X=\mu+\gamma$ with
$$\boxed{\ \gamma:=\sum_{a,k,l}c_{akl}^2=\sum_{k,l}\big\lVert[f_k,f_l]_{\mathfrak m}\big\rVert^2\ \ge0\ }\qquad\text{and}\qquad 2\mu+\gamma=2(n-2)d .$$
So $\gamma\ge0$ **is a theorem** (a sum of squares) and $\gamma=0$ iff $\mathfrak m^\perp$ is a subalgebra, which is the block's own equality condition and [Lemma L77](../findings/isotropy-cap.md)'s $\gamma=2S_{\mathfrak{mhh}}$. **Normalisation checks:** the RHS constant is $c_{\mathrm{adj}}d=2(n-2)d$ in the record's convention, matching [conventions.md](../findings/conventions.md)'s Killing marginal and the $\mathrm{Id}^\#$ anchor. Isotropy is used exactly once and is exactly what is needed. **Confirmed.**

**Step 2, $\mu\ge 4d^2/n-2d$ for every $d$-plane.** With $P$ the orthogonal projection onto $\mathfrak m$ and $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)$ over an orthonormal basis of all of $\mathfrak{so}(n)$:
$$\langle T(P),P\rangle=-\sum_k\mathop{\mathrm{tr}}(\mathrm{ad}_kP\,\mathrm{ad}_kP)=\sum_k\sum_{a,b}\langle[f_k,e_b],e_a\rangle^2=\sum_{a,b}\lVert[e_a,e_b]\rVert^2=\mu\ \checkmark$$
(using skewness of $\mathrm{ad}_k$ for the middle sign and total symmetry of $T_{abc}$ for the last). And with $\rho(X)A=[X,A]$ on $\mathrm{End}$, $\rho(f_k)^2A=\mathrm{ad}_k^2A-2\mathrm{ad}_kA\,\mathrm{ad}_k+A\,\mathrm{ad}_k^2$, so
$$\mathrm{Cas}(A)=-\sum_k\rho(f_k)^2A=4(n-2)A-2T(A)\quad\Longrightarrow\quad T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}\ \ \checkmark$$
exactly as the block writes it.

**Step 3, the spectrum of $T$, derived independently.** With $\lambda\mapsto\sum_i\lambda_i(\lambda_i+n-2i)$ normalised by $c(e_1)=n-1$ (which reproduces $c(\text{adjoint})=2(n-2)$):

| summand of $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$ | h.w. | $\mathrm{Cas}$ | $T=2(n-2)-\tfrac12\mathrm{Cas}$ | block |
| --- | --- | --- | --- | --- |
| $\mathbb R$ | $0$ | $0$ | $2n-4$ | $2n-4$ ✓ |
| $\mathrm{Sym}^2_0$ | $2e_1$ | $2n$ | $n-4$ | $n-4$ ✓ |
| $\mathcal W_n$ | $2e_1{+}2e_2$ | $4n-4$ | $-2$ | $-2$ ✓ |
| $\Lambda^4$ | $e_1{+}e_2{+}e_3{+}e_4$ | $4n-16$ | $4$ | $4$ ✓ |

Dimensions close: $1+9+10+1=21$ at $n=4$, $1+14+35+5=55$ at $n=5$, $1+20+84+15=120$ at $n=6$, $1+5+0+0=6$ at $n=3$. **And the table cross-checks against [Lemma L79](../findings/isotropy-cap.md) in the same file**, whose $\mathcal A$-eigenvalues $(+2,\,-(n-4),\,-2(n-2),\,-4)$ on $(\mathcal W_n,\mathrm{Sym}^2_0,\mathbb R\mathrm{Id},\Lambda^4)$ are $-1$ times mine on all four summands: $T=-\mathcal A$. Via [Lemma L131](../findings/isotropy-cap.md) that table is proved at every $n$ from Böhm–Wilking, so **L36's one load-bearing eigenvalue is established twice by routes that do not share a step.**

**Step 4, chaining.** $P=\tfrac dN\mathrm{Id}+P_0$ with $\lVert P_0\rVert^2=\mathop{\mathrm{tr}}P^2-d^2/N=d-d^2/N$, and $\lambda_{\min}(T)\ge-2$ on the non-trivial part, gives
$$\mu\ \ge\ \frac{(2n-4)d^2}{N}-2\Big(d-\frac{d^2}{N}\Big)=\frac{(2n-2)d^2}{n(n-1)/2}-2d=\frac{4d^2}{n}-2d ,$$
and against $\mu\le(n-2)d$: $4d/n\le n$, i.e. $d\le n^2/4$. **All arithmetic exact.**

**The floor.** The block stops at $d\le n^2/4$ while the Statement claims $\lfloor n^2/4\rfloor$. **The gap is closed by integrality of $\dim\mathfrak m$ and nothing else**, at odd $n$, $n^2/4\notin\mathbb Z$ so $d\le\lfloor n^2/4\rfloor=(n^2-1)/4$. One clause, missing, trivially supplied.

---

## F4, "$\gamma\ge0$" is circular in the block as written. **A real gap, one line to repair.**

**$\gamma$ is never defined in the L36 block.** The only definition in the file is 85 lines later, in the [Lemma L77](../findings/isotropy-cap.md) section: *"$\gamma=2(n-2)d-2\mu$"*, $\gamma$ **defined as the residual**. Under that definition the "Killing block identity" $2\mu+\gamma=2(n-2)d$ is a tautology carrying no content, and the entire force of Step 1 sits on the bare assertion $\gamma\ge0$, which is then just a restatement of the conclusion $\mu\le(n-2)d$. **As written, Lemma L1 assumes what it proves.**

The content is elsewhere: $\gamma=2S_{\mathfrak{mhh}}$, which is [Lemma L77](../findings/isotropy-cap.md), later in the file and carrying **"Gate 2: no verdict on the record"** in [INDEX-results.md](../findings/INDEX-results.md). So L36's proof rests on an unaudited result despite the brief's note that it cites none.

**Repair:** define $\gamma:=\sum_{k,l}\lVert[f_k,f_l]_{\mathfrak m}\rVert^2$ *in the block*, and derive the identity from the Killing marginal plus total antisymmetry as in F3 Step 1 above. Then $\gamma\ge0$ is visibly a sum of squares and the circularity is gone. **The mathematics is fine; the presentation proves nothing without the repair.**

---

## F5, $n=3$, "no genericity hypothesis", and the "whole content is one eigenvalue" gloss

- **"No genericity hypothesis": CONFIRMED.** Step 2 holds for *every* $d$-plane and Step 1 for every isotropic one. Nothing generic is used anywhere.
- **The cap at $n=3$: CONFIRMED, and sharp in the Lie reading.** $\lfloor9/4\rfloor=2$; the Cartan 3-form on $\mathfrak{so}(3)\cong\mathbb R^3$ is the volume form, whose isotropic subspaces are exactly the proper subspaces, so the maximum is $2$ and is attained, by $\mathbb R^1\otimes\mathbb R^2$, the $(p,q)=(1,2)$ split. Neither vacuous nor false. *Sharp in the Weyl reading it is not, see F2.*
- **But the block's gloss overreaches at $n=3$.** *"$-2$ is $T$'s only negative eigenvalue, and its eigenspace is exactly $\mathrm{Weyl}_n$"*, at $n=3$, $\mathcal W_3=0$, so $T$ has **no** $-2$ eigenvalue at all, while $\mathrm{Sym}^2_0$ carries $n-4=-1<0$. So at $n=3$ the only negative eigenvalue of $T$ is $-1$, on $\mathrm{Sym}^2_0$. The quoted multiplicities $10,35,84,168$ scope the claim to $n\ge4$ implicitly; it should say so. **The cap survives untouched**, because $-1\ge-2$ makes the Step-4 relaxation valid, the bound is simply not tight there.

---

## F6, sharpness and the odd-$n$ equality case

| | claim in the Statement | truth |
| --- | --- | --- |
| even $n$ | equality at $p=q=n/2$ | ✓ attained, by $\mathfrak m\cong\mathbb R^{n/2}\otimes\mathbb R^{n/2}$, $\dim=n^2/4$ |
| odd $n$ | "$p=q=n/2$", "sharp every $n\ge3$" | **the named split does not exist**; the cap $(n^2-1)/4$ *is* attained, by the **unbalanced** split $p=\tfrac{n-1}2,\ q=\tfrac{n+1}2$, $pq=\lfloor n^2/4\rfloor$ |

**So sharpness holds at every $n\ge3$ in the Lie reading, but with a maximiser the Statement does not name.** The file knows this: its own "odd-$n$ gap" section works with the pair $\big(\tfrac{n-1}2,\tfrac{n+1}2\big)$ and records $\mu=(n-2)d$ exactly there. **The Statement is inconsistent with a section 80 lines below it.**

What is genuinely open at odd $n$ is **uniqueness**, not attainment: $\gamma=0$ is forced at even $n$ (the chain gives $\gamma\le2d(n^2-4d)/n$, zero at $d=n^2/4$) but only bounded by $(n^2-1)/(2n)$ at odd $n$. The block's "What it does not reach" says this correctly. *The Statement claims neither uniqueness nor a classification, so this is not a defect of the Statement, but it means "equality attained by …" must be read as attainment only.*

**Repair:** "with equality attained by the isotropy summand $\mathbb R^p\otimes\mathbb R^q$ of the symmetric pair at $p=\lfloor n/2\rfloor$, $q=\lceil n/2\rceil$".

---

## P6, what the 10 citations actually use

| citation | what it takes | damaged by F1/F2? |
| --- | --- | --- |
| [results.md](../results.md) line 40 | the cap only | no |
| [results.md](../results.md) line 158 | the cap, plus "attained by the balanced symmetric pair", **the correct object, correctly named** | no |
| [results.md](../results.md) line 462 | the Statement **verbatim** | **yes, carries both F1 and F2** |
| [plan.md](../plan.md) line 96 | "L29–L36" as a stratum-closure range; the cap only | no |
| [routes.md](../routes.md) line 31 (R13) | the cap as "the already-proved Mantel cap", under the $S_{\mathfrak{mmm}}=0$ reading; **route CLOSED** | no |
| [ATTEMPTS.md](../ATTEMPTS.md) line 2208 | places the cap against the Turán/isotropy-index literature | no |
| [ATTEMPTS.md](../ATTEMPTS.md) line 2610 | R13 again; the cap only | no |
| [findings/bounds.md](../findings/bounds.md) line 173 | the cap as an active constraint in a relaxation ($2.392147$ vs $2.392105$ at $n=6$) | no |
| [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) line 142 | the **proof internals**: $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$, both halves confirmed in F3, and $\mu=2S_{\mathfrak{mmh}}$ is the file's own count | no |
| [plan-verification.md](../plan-verification.md) line 32 | an unchecked checklist row | no |
| [isotropy-cap.md](../findings/isotropy-cap.md) line 306 (self) | $\mu(\mathfrak m)=2\mathop{\mathrm{tr}}(\Pi_{\mathfrak m}^\#)$, **checked: correct**, since $\mathop{\mathrm{tr}}(A^\#)=\tfrac12\sum_{\gamma\delta}A_{\gamma\gamma}A_{\delta\delta}\lVert[v_\gamma,v_\delta]\rVert^2$ | no |

**Every consumer takes the cap or the proof internals. Not one takes the equality case, and not one takes the "equivalently".** So both false clauses are contained in the two copies of the Statement, [isotropy-cap.md](../findings/isotropy-cap.md) lines 24–27 and [results.md](../results.md) line 462, and repairing them there repairs the record.

---

## P7, contradictions elsewhere

Three, all inside [isotropy-cap.md](../findings/isotropy-cap.md) itself, all against the Statement and all in the direction of the repair: line 135 ($6,9,12,16=pq$), the odd-$n$ gap section (unbalanced split at odd $n$), and "What it gives item B" ($\mathfrak m$ *is* the symmetric-pair subspace, $\dim=(n/2)^2$). Nothing in `findings/` restates the cap with a different value; [Lemma L76](../findings/isotropy-cap.md)'s heading repeats F1's loose naming ("every symmetric pair $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is a maximal isotropic subspace") while its body uses $\dim\mathfrak m=pq$ correctly.

---

## VERDICT: REFUTED

**As stated.** The Statement asserts equality is attained by an object of dimension $\frac{n(n-2)}4$ that is not in the hypothesis class for $n\ge5$ (**F1**), and asserts an equivalence whose forward direction fails with witnesses at $n=3$ ($\mathcal W_3=0$) and $n=4$ ($\mathbb R\varphi_{12}$ is not $\star$-invariant) (**F2**). Its proof's first lemma is circular as written, $\gamma$ being defined only as the residual (**F4**).

**The theorem underneath is CONFIRMED and is stronger than its statement suggests.** $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ for every subspace of $\mathfrak{so}(n)$ isotropic for the Cartan 3-form, every $n\ge3$, no genericity, sharp at every $n$ with maximiser $\mathbb R^{\lfloor n/2\rfloor}\otimes\mathbb R^{\lceil n/2\rceil}$. I rebuilt the Killing identity, the $\mu=\langle T(P),P\rangle$ identity, the operator identity $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, the four Casimir eigenvalues and the chaining from the definitions; every one is exact in the record's normalisation, and the one load-bearing eigenvalue $-2$ is corroborated by [L79](../findings/isotropy-cap.md)/[L131](../findings/isotropy-cap.md) in the same file by an unrelated route.

**Three one-line repairs restore it**, and no citation on the record needs to move.
