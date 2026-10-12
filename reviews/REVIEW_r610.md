# REVIEW r610, Lemma L77

**Target:** Lemma L77, "$\gamma=2S_{\mathfrak{mhh}}$, so $\gamma=0$ iff $\mathfrak m^\perp$ is a subalgebra", [findings/isotropy-cap.md:112](../findings/isotropy-cap.md), the heading, the block under it ("The odd-$n$ gap, stated sharply"), the rigidity chain at line 122, and the isotypic table at line 128. Second copy of the statement at [findings/INDEX-results.md:92](../findings/INDEX-results.md).

**Reviewer:** r610, cold, adversarial, **analysis-only footing**, no searches, sweeps or censuses were run, and the block's own numerics were neither re-run nor extended. Every identity below was rebuilt from the definitions before the block was read for its reasoning. Two numerical series the block and its neighbours report are *re-derived in closed form* here and are therefore reported as derivations, not as measurements.

**VERDICT: REFUTED, as stated.** The mathematics is right and is confirmed in full **once the hypothesis $S_{\mathfrak{mmm}}=0$ is restored**: the identity, both equivalences, the chained bound, the parity arithmetic and the "exactly a $\mathbb Z_2$-grading" claim all hold, and the whole isotypic table is derivable in closed form rather than measured. **Both halves of the numbered statement are false without isotropy, at one four-dimensional witness**, and the record already knows this, Reviewer 67 wrote the correction into a neighbouring file on the day the identity was created, and it never reached L77's block, its heading or its index row. Two further gaps, one closable here and one not: the Cartan step drops a family and never crosses from $\mathrm{Aut}(\mathfrak g)$ to $SO(n)$-conjugacy (closed below, $n=8$ included); the odd-$n$ debt stands, and is restated sharply.

---

## P0, the conventions, fixed against the record's anchors before anything was derived

The block quotes nothing, so every convention it needs had to be pinned from outside it.

| object | what the block needs | where it is pinned | verdict |
| --- | --- | --- | --- |
| inner product | $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings" | ✓ |
| $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ | **totally** antisymmetric; $T_{\alpha\beta\gamma}=c^2$ totally symmetric, zero on repeated indices | [conventions.md](../findings/conventions.md), "Structure constants" | ✓ |
| row marginal $2(n-2)$ | $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ | [conventions.md](../findings/conventions.md), "The pair cap and the Killing marginal" | ✓, see below |
| $\mathfrak m$ | **L36's sense**: an isotropic subspace of $\mathfrak{so}(n)$, the negative eigenspace at an $S=0$ point | [conventions.md](../findings/conventions.md) tables three senses and names this one | ✓ |
| $\mathfrak h$ | **$\mathfrak h=\mathfrak m^\perp$, by definition, not by a step** | nowhere, see defect D3 | ✗ |
| $S_{\mathfrak{mhh}}$ | sum over **unordered** index triples | nowhere, see defect D2 | ✗ |
| $\gamma$ | $2(n-2)d-2\mu$ | this block only | ✗ |

### The row marginal is the Killing-form fact, not a coincidence

Asked for by the brief, and it checks. $\operatorname{ad}$ is skew for an ad-invariant inner product, so for unit $v$

$$\sum_\beta\lVert[v,v_\beta]\rVert^2=\operatorname{tr}\!\big(\operatorname{ad}(v)^{\mathsf T}\operatorname{ad}(v)\big)=-\operatorname{tr}\operatorname{ad}(v)^2=-B(v,v),$$

and [conventions.md](../findings/conventions.md) fixes $B(X,Y)=(n-2)\operatorname{tr}(XY)$ with $\operatorname{tr}(v^2)=-2$ for a unit bivector, giving $-B(v,v)=2(n-2)$. **Same constant, same fact.** Hand-check at $n=3$: $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$ and $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, each of norm $1$, total $2=2(n-2)$. ✓

---

## 1, The identity, derived

Fix an orthonormal basis $\{e_a\}_{a\le d}$ of $\mathfrak m$ and $\{f_i\}$ of $\mathfrak h=\mathfrak m^\perp$, $N=\binom n2$. Write $U_{XYZ}$ for the sum of $T$ over **unordered** triples with the named membership pattern. Because $T$ is totally symmetric and vanishes on repeated indices, the two block masses in the block's proof are

$$\mu:=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2=6U_{\mathfrak{mmm}}+2U_{\mathfrak{mmh}},\qquad X:=\sum_{a\in\mathfrak m,\,i\in\mathfrak h}\lVert[e_a,f_i]\rVert^2=2U_{\mathfrak{mmh}}+2U_{\mathfrak{mhh}}.$$

Summing the row marginal over the $d$ rows of $\mathfrak m$ gives $\mu+X=2(n-2)d$, so with $\gamma:=2(n-2)d-2\mu$,

$$\boxed{\ \gamma=X-\mu=2U_{\mathfrak{mhh}}-6U_{\mathfrak{mmm}}\ }$$

**at every subspace, isotropic or not.** Under isotropy the second term dies and $\gamma=2U_{\mathfrak{mhh}}$.

This is the block's identity, and the derivation reproduces its two intermediate lines ($\mu=2S_{\mathfrak{mmh}}$ and $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$), **only under the unordered reading $S=U$**, which is defect D2. The general law $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$ agrees to the letter with the one Reviewer 67 recorded at [bounds-relaxations.md:170](../findings/bounds-relaxations.md); I reached it before reading that line.

**Consistency check the block supplies without noticing.** $U_{\mathfrak{mmm}}\ge0$ forces $\gamma\le2S_{\mathfrak{mhh}}$ always. The block's non-isotropic figures are "$14.20$ against $16.84$" in that order, so the sign of its own discrepancy is the one the general law predicts, and the gap $2.64$ is $6U_{\mathfrak{mmm}}$. ✓

---

## 2, The two equivalences

**Sign-definiteness.** $U_{\mathfrak{mhh}}=\sum_{\{a,i,j\}}c_{aij}^2\ge0$, a sum of squares, with equality iff $c_{aij}=0$ for every $a\in\mathfrak m$ and $i,j\in\mathfrak h$. That is $\langle[\mathfrak h,\mathfrak h],\mathfrak m\rangle=0$, i.e. $[\mathfrak h,\mathfrak h]\subseteq\mathfrak m^\perp=\mathfrak h$. **First equivalence confirmed**, and it needs the identity, hence isotropy, the forward implication is exactly where the missing hypothesis bites.

**Second equivalence.** "$[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ iff $\mathfrak m^\perp$ is a subalgebra" is a definitional restatement **and only because $\mathfrak h=\mathfrak m^\perp$**. The block never says so, and [conventions.md](../findings/conventions.md) tables the opposite: there $\mathfrak h=E_{\max}$ with $\mathfrak r$ (kernel included), a third summand, so $\mathfrak m^\perp=\mathfrak h\oplus\mathfrak r$ and the restatement is **false** under the tabled sense whenever $\mathfrak r\ne0$, which is exactly the padded case the record cares about. See D3.

---

## 3, REFUTED as stated: the witness

Take $n=4$, $\mathfrak m=\mathfrak{so}(3)=\operatorname{span}(\varphi_{12},\varphi_{13},\varphi_{23})$, $d=3$, $\mathfrak h=\mathfrak m^\perp=\operatorname{span}(\varphi_{14},\varphi_{24},\varphi_{34})$. Everything is a two-line hand computation.

| quantity | value | how |
| --- | --- | --- |
| $\mu$ | $6$ | three unordered pairs, each bracket a unit $\varphi$; $2\times3\times1$ |
| $2(n-2)d$ | $12$ | $2\cdot2\cdot3$ |
| $\gamma$ | $\mathbf 0$ | $12-2\cdot6$ |
| $U_{\mathfrak{mmm}}$ | $1$ | the single triple, $c_{12,13,23}=-1$ |
| $U_{\mathfrak{mhh}}$ | $3$ | $[\varphi_{14},\varphi_{24}]=-\varphi_{12}$ and its two relabellings |
| $2S_{\mathfrak{mhh}}$ | $6$ | |

**Both halves of the numbered statement fail here.**

- $\gamma=0\ne6=2S_{\mathfrak{mhh}}$, the discrepancy being exactly $6U_{\mathfrak{mmm}}=6$, as the general law predicts.
- $\gamma=0$ **yet $\mathfrak m^\perp$ is not a subalgebra**: $[\varphi_{14},\varphi_{24}]=-\varphi_{12}\notin\mathfrak h$. So the second claim is refuted independently of the first, in the same witness.

**The missing hypothesis is $S_{\mathfrak{mmm}}=0$**, i.e. isotropy of $\mathfrak m$, the standing setting of the file, and absent from the heading, from the displayed equation at line 118, and from [INDEX-results.md:92](../findings/INDEX-results.md). This is the same failure mode the file already carries against [Lemma L36](../findings/isotropy-cap.md) and [Lemma L32](../findings/isotropy-cap.md), both "REFUTED as stated: a hypothesis is missing".

**Repair, one clause.** Heading and index row to read *"for isotropic $\mathfrak m$, $\gamma=2S_{\mathfrak{mhh}}$; in general $\gamma=2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$"*. No downstream consumer is damaged: [L114](../findings/bounds-relaxations.md) and the L36 chain both apply it only on $\{S=0\}$.

---

## 4, Provenance: the correction was written the same day, into the wrong file

Checked against `git log`, by distinctive-phrase search, in both directions.

| claim | check | verdict |
| --- | --- | --- |
| the block gives **no** account of its own history | grep of the block for dates, "moved", "was", "until" | ✓ none to falsify |
| the identity originates at `34124ca3`, 2026-08-23, "gamma = 2 S_mhh, so the cap rigidity is a grading condition" | `git log -S` on the identity | ✓, and the commit body **already reports** the non-isotropic failure, so the hypothesis was visible at creation and was not stated |
| Reviewer 67 recorded the fix at `8d0eb3d8`, **also 2026-08-23**, in [bounds-relaxations.md:170](../findings/bounds-relaxations.md): *"needs $S_{\mathfrak{mmm}}=0$ as a standing hypothesis, the general law being $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$"* | `git show` | ✓ |
| the numbered heading was placed **ten days later**, at `5b258c14` (2026-09-02), whose message says *"headings only: no statement … is altered"* | `git show --stat` | ✓, so the retrofit froze the unrepaired form into the record's canonical statement |

**L77 has no statement-and-proof block of its own.** It is a heading placed over a narrative paragraph, which is why the hypothesis had nowhere to be stated and why the index row inherited the heading verbatim.

---

## 5, The chained bound and the parity claims, each labelled by parity

$\mu\ge 4d^2/n-2d$ (Lemma L2) with $\gamma=2(n-2)d-2\mu$ gives

$$\gamma\le 2(n-2)d-2\Big(\tfrac{4d^2}n-2d\Big)=2dn-\tfrac{8d^2}n=\frac{2d(n^2-4d)}{n}. \qquad\checkmark$$

**Verified as printed**, both parities, every $d$. At $d=n^2/4$ the right side is $0$; with $\gamma\ge0$ (which needs isotropy) this forces $\gamma=0$.

**At odd $n$** the cap is $\lfloor n^2/4\rfloor=(n^2-1)/4$, an integer, attained by the mixed planes at $p=\tfrac{n-1}2$, $q=\tfrac{n+1}2$ ([L36](../findings/isotropy-cap.md)). Then $n^2-4d=1$ and

$$\gamma\le\frac{2d}{n}=\frac{n^2-1}{2n}\ \ \Longrightarrow\ \ 2.4\ \text{at}\ n=5,\quad \tfrac{48}{14}=3.4286\ \text{at}\ n=7. \qquad\checkmark$$

Both figures reproduce. Note the bound reaches $d\le n^2/4$ and only integrality of $d$ takes it to $\lfloor n^2/4\rfloor$; the block uses that silently and is entitled to.

### Parity label for every constant in the block, as the brief asks

| constant | statement | parity |
| --- | --- | --- |
| $2(n-2)$ | row marginal | **both**, every $n\ge2$ |
| $\gamma=2S_{\mathfrak{mhh}}$ | identity | **both**, under isotropy |
| $\gamma\le 2d(n^2-4d)/n$ | chained bound | **both**, every $d$ |
| $d=n^2/4$ | the cap | **even only** |
| $d=(n^2-1)/4$ | the cap | **odd only** |
| $\gamma=0$ at the cap | proved | **even only**; odd is the open debt |
| $(n^2-1)/(2n)$ | the allowance | **odd only**, and see D1 |
| $\mu=(n-2)d$ at a symmetric pair | exact | **both**, see below |
| $\lVert P_0\rVert^2=d-d^2/N$ | table column 3 | **both** |
| $\lVert P_s\rVert^2=\frac{d(n^2-4d)}{n(n-2)}$ | table column 4 | **both**; zero exactly at $d=n^2/4$ |
| $\Lambda^4$ column $=0$ | table column 6 | **both**, but only for the tabled subspaces, see D5 |

**"$\mu=(n-2)d$ exactly" is a theorem, not a measurement.** A symmetric pair has $S_{\mathfrak{mhh}}=0$, hence $\gamma=0$, hence $\mu=(n-2)d$, both parities, no computation. The block presents it under **Measured** alongside figures that are measurements.

### D1, a factor-two slip, and it is L77's own factor

The rigidity-chain paragraph at line 124 reads *"the cap forces $S_{\mathfrak{mhh}}=0$ there too, where the counting allows it to be as large as $(n^2-1)/(2n)$"*. **$(n^2-1)/(2n)$ is the allowance on $\gamma$**; L77 has just established $S_{\mathfrak{mhh}}=\gamma/2$, so the allowance on $S_{\mathfrak{mhh}}$ is $(n^2-1)/(4n)$, $1.2$ at $n=5$, $1.714$ at $n=7$. The block states the odd-$n$ debt with the wrong quantity attached to its own headline constant. *One-word repair: name $\gamma$, or halve the number.*

---

## 6, The rigidity chain, arrow by arrow

### "Exactly a $\mathbb Z_2$-grading", CONFIRMED, and the brief's suspicion resolves in the block's favour

The brief asks whether the third bracket relation is free. **It is neither free nor an extra assumption: it is the same condition as the first**, and total antisymmetry is why.

Let $\sigma=\operatorname{id}_{\mathfrak h}\oplus(-\operatorname{id}_{\mathfrak m})$. Since $\sigma$ is orthogonal, $\sigma$ is a Lie-algebra automorphism iff $c_{\sigma\alpha,\sigma\beta,\sigma\gamma}=c_{\alpha\beta\gamma}$, and $\sigma$ multiplies $c_{\alpha\beta\gamma}$ by $(-1)^{\#\{\text{indices in }\mathfrak m\}}$. Of the four index types only $\mathfrak{mmm}$ and $\mathfrak{mhh}$ have an odd count, so

$$\sigma\in\operatorname{Aut}(\mathfrak{so}(n))\iff S_{\mathfrak{mmm}}=S_{\mathfrak{mhh}}=0,$$

**two scalar conditions, not three.** Concretely $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ says $\langle[f_i,e_a],f_j\rangle=0$, and $c_{iaj}=-c_{aij}$ is the *same structure constant* that $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ kills. The equivalence runs both ways, so **"exactly" is earned**, the one place in this block where a hedging clause survives the check. The block never gives the reason, and a reader who counts three conditions against two masses will stall exactly where the brief did; **one sentence of repair is owed.**

### "Hence a symmetric pair", CONFIRMED

$\sigma$ an involutive automorphism with $\mathfrak h$ its fixed subalgebra is the definition of an orthogonal symmetric pair. ✓ ($n=4$ needs a word: $\mathfrak{so}(4)$ is semisimple rather than simple, so "Cartan's list" below must be read for the semisimple case; the extra symmetric pair there ($\mathfrak h$ the diagonal $\mathfrak{su}(2)$), has $\dim\mathfrak m=3<4$ and is eliminated by the same dimension count as everything else.)

### "Hence Cartan's list, hence the balanced split", **GAP**, closable, and closed here

Two things are missing, and the second is the one the brief flags.

**(a) The list has a second family, and the block never eliminates it.** Cartan's involutions of $\mathfrak{so}(n)$ are BDI, $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $\dim\mathfrak m=pq$, **and DIII**, $\mathfrak h=\mathfrak u(n/2)$ with $\dim\mathfrak m=\binom n2-\tfrac{n^2}4=\tfrac{n^2-2n}4<\tfrac{n^2}4$. So DIII never reaches the cap, and among BDI, $pq\le n^2/4$ with equality only at $p=q$. **The balanced split does follow, by a dimension count the block does not perform.** The record carries the full list at [bounds-relaxations.md:174](../findings/bounds-relaxations.md) and at [trap W2](../findings/INDEX-traps.md); L77 cites neither.

**(b) $\operatorname{Aut}(\mathfrak g)$ against $SO(n)$-conjugacy.** The chain **does** consume $SO(n)$-conjugacy: the downstream claim is that $W$ is the balanced sphere product, which is a statement about a frame of $\mathbb R^n$, not about an abstract involution. Cartan supplies conjugacy under $\operatorname{Aut}(\mathfrak g)$ only, and [conventions.md](../findings/conventions.md) records that these differ at $n=8$ by triality. **The bridge is missing from the block. It closes as follows, $n=8$ included:**

1. Let $\mathfrak m$ be isotropic with $\dim\mathfrak m=n^2/4$ and $\gamma=0$, and $\sigma$ its involution.
2. $\operatorname{Aut}$-conjugacy to $\sigma_{n/2,n/2}$ follows from the list, since $\dim\mathfrak m$ is an $\operatorname{Aut}$-invariant and $n^2/4$ occurs once on it. At $n=8$ the triality extras, $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, dimensions $21$ and $13$ by [trap W2](../findings/INDEX-traps.md), give $\dim\mathfrak m=7$ and $15$, **neither equal to $16$**, so the cap dimension is a singleton triality orbit.
3. $\operatorname{Inn}$ is normal in $\operatorname{Aut}$, and $\sigma_{n/2,n/2}=\operatorname{Ad}(\operatorname{diag}(I_{n/2},-I_{n/2}))$ is inner whenever $n/2$ is even; in general $\sigma$ lies in $\operatorname{Ad}(O(n))$, and conjugating by an outer automorphism keeps it there. So $\sigma=\operatorname{Ad}(g)$, $g\in O(n)$, $g^2=\pm I$.
4. $g^2=-I$ is DIII, excluded at step (a) by dimension. $g^2=I$ gives $g\sim\operatorname{diag}(I_p,-I_q)$ and $\dim\mathfrak m=pq=n^2/4$ forces $p=q$.
5. $O(n)$-conjugacy upgrades to $SO(n)$: $\operatorname{diag}(r,I_{n/2})$ with $r\in O(n/2)$, $\det r=-1$, preserves the standard split and has determinant $-1$ in $O(n)$.

**So $n=8$ is not affected**, and the chain is sound, but as written it asserts across a gap the record itself has flagged as a place it has already paid once.

---

## 7, The isotypic table: every entry is derivable, and the even-$n$ claim is a theorem the block reads off one row

The table is presented as a decomposition performed at four values of $n$, of which **exactly one is even**. I rebuilt it in closed form without computation.

Let $P$ be the orthogonal projection onto $\mathfrak m$ and $P_0=P-\tfrac dN\operatorname{Id}$, decomposed over $\mathbb R\oplus\operatorname{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ with component norms $s,w,\ell$.

**Column 3.** $\operatorname{tr}P^2=\operatorname{tr}P=d$, so $\lVert P_0\rVert^2=d-d^2/N$. At the four rows: $6-3.6=2.4$; $9-5.4=3.6$; $12-\tfrac{144}{21}=5.1429$; $20-\tfrac{400}{36}=8.8889$. **All four reproduce exactly.**

**Columns 4–6.** With $\mu=\langle T(P),P\rangle$ and $T$'s spectrum $2n-4,\ n-4,\ -2,\ 4$, eliminating $w$ gives the **exact** identity

$$\mu=\frac{4d^2}{n}-2d+(n-2)\lVert P_s\rVert^2+6\lVert P_\lambda\rVert^2,$$

which is Lemma L2 **plus its slack in closed form**, and confirms the block's claim that L2 is tight exactly when $P_0\in\mathrm{Weyl}_n$. Substituting $\gamma=2(n-2)d-2\mu$:

$$\boxed{\ \gamma=\frac{2d(n^2-4d)}{n}-2(n-2)\lVert P_s\rVert^2-12\lVert P_\lambda\rVert^2\ }$$

At a symmetric pair $\gamma=0$ and $\ell=0$ (the projection is diagonal in the $\varphi$ basis, so $\operatorname{Alt}(P)=0$ termwise), giving

$$\lVert P_s\rVert^2=\frac{d(n^2-4d)}{n(n-2)}:\qquad \tfrac{6}{15}=0.4,\quad 0,\quad \tfrac{12}{35}=0.342857,\quad \tfrac{20}{63}=0.31746 .$$

**All four match the table to the digit**, and the $\mathrm{Weyl}$ column follows by subtraction ($2.0$, $3.6$, $4.8$, $8.5714$). **The table is a closed form, not a measurement.**

**Is "at even $n$" supported by the table, derivable, or an extrapolation from $n=6$?** It is **derivable, in one line, and the record's warrant for it is the single row $n=6$.** The direct reason: $P$ is diagonal in the $\varphi$ basis with $K_{ij}=1$ on mixed pairs, so its Ricci is $\operatorname{diag}(r_i)$ with $r_i$ the row sums, $q$ on the $p$-block and $p$ on the $q$-block. **The traceless Ricci vanishes iff $p=q$**, which is available only at even $n$. So the claim is true at every even $n$; the block asserts it from one data point and gives no reason. *Per the brief's instruction, the label is the finding: the statement is sound, its stated warrant is not.*

---

## 8, Remaining defects

**D2, a live cross-file normalisation collision, and L77's headline factor $2$ turns on it.** $S_{XYZ}$ carries **two incompatible normalisations**, neither in [conventions.md](../findings/conventions.md).

| file | sum rule it satisfies | reading | $S_{\mathfrak{mhh}}$ at padded $W_{\mathbb{CP}^2}$, $n=6$ | L77 would read |
| --- | --- | --- | --- | --- |
| [bounds-relaxations.md:132](../findings/bounds-relaxations.md) ([L114](../findings/bounds-relaxations.md)) | $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$ | **unordered triples** | $4$ (line 212) | $\gamma=2S_{\mathfrak{mhh}}$ |
| [nondegeneracy.md:317](../findings/nondegeneracy.md) | $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)$ | **ordered slots** | $8$ (line 310, as $S_{\mathfrak{hhm}}$) | $\gamma=S_{\mathfrak{mhh}}$ |

Each file's sum rule is correct **in its own reading and false in the other's**, the coefficient vectors $(6,4,2)$ and $(1,3,3,1)$ are exactly the two marginals under the two conventions, so each rule pins its own file. **The two readings differ by a factor $3$ on the pure blocks and by a factor $2$ on the mixed ones**, which is precisely the factor in L77's headline.

*Derived, not measured, and it settles which file is which.* Padded $W_{\mathbb{CP}^2}$ has $\mathfrak m$ a $2$-plane in $\Lambda^2_+\mathbb R^4$ (automatically isotropic, a $3$-form vanishing on any $2$-plane), with $[\omega_2,\omega_3]=\sqrt2\,\omega_1$, so $\mu=4$ and

$$\gamma=2(n-2)\cdot2-2\cdot4=4n-16:\qquad 8,\ 16,\ 24,\ 32 \ \text{at}\ n=6,8,10,12.$$

[bounds-relaxations.md:212](../findings/bounds-relaxations.md)'s series is $4,8,12,16$, **exactly $\gamma/2$**, the unordered reading; [nondegeneracy.md:310](../findings/nondegeneracy.md)'s $8$ at $n=6$ is **$\gamma$ itself**, the ordered reading. The two spellings $S_{\mathfrak{mhh}}$ and $S_{\mathfrak{hhm}}$ track the split but nothing says so.

**This is the class of defect [conventions.md](../findings/conventions.md) exists to prevent**, and it sits under a numbered lemma whose statement is a factor. *Repair: table $S_{XYZ}$ in [conventions.md](../findings/conventions.md) with one reading named, and convert [nondegeneracy.md](../findings/nondegeneracy.md) or flag it as the record flags the BK/Li index order.*

**D3, $\mathfrak h=\mathfrak m^\perp$ is assumed and contradicted by the conventions file.** The whole of L77 needs $\mathfrak h=\mathfrak m^\perp$; [conventions.md:27](../findings/conventions.md) defines $\mathfrak h=E_{\max}$ with $\mathfrak r$, **kernel included**, a separate summand. Under the tabled sense the second equivalence is false whenever $\mathfrak r\ne0$. The operative sense elsewhere in the runs is $\mathfrak m^\perp$: [nondegeneracy.md:306](../findings/nondegeneracy.md) states *"Zeros belong to $\mathfrak h$"*. **The conventions table is the outlier and should carry a fourth row, or the $\mathfrak m$ row should name this sense of $\mathfrak h$ as it already names three senses of $\mathfrak m$.**

**D4, a false parity gloss.** Line 130: *"the same parity asymmetry that makes $\theta_0(n)$ non-integral at odd $n$"*. $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is **never** integral: $\theta_0=1$ requires $n^2-6n+4=0$, whose roots $3\pm\sqrt5$ are irrational, and $\theta_0<\sqrt2$ bounds it below $2$. So the clause names a parity asymmetry that does not exist. The intended one is presumably $\Theta_n\ne\theta_0(n)$ at odd $n$, which [conventions.md](../findings/conventions.md) does record. *Strike or replace.*

**D5, the parity-cause paragraph diagnoses the known extremiser, not the unknown competitor.** The table is computed at the symmetric pairs. The odd-$n$ debt is a statement about **every** isotropic $\mathfrak m$ at $d=(n^2-1)/4$, and for a general such subspace neither $\ell=0$ nor the value of $s$ is known. So *"The $\Lambda^4$ component vanishes at both parities"* is a fact about the tabled subspaces read as though it were general, and $\ell$ is exactly one of the two terms the debt must control. The block's *"$\mu$ exceeds the Lemma-2 bound by exactly its contribution"* also suppresses the weight: the excess is $(n-2)\lVert P_s\rVert^2+6\lVert P_\lambda\rVert^2$, the multiplier being the eigenvalue gap $(n-4)-(-2)$.

**D6, an empty link target.** [isotropy-cap.md:334](../findings/isotropy-cap.md) carries `[Lemma L36](#)`, a pointer to nothing, in the same file as its target's anchor. One of one such target in this file. *Repair: the anchor the L36 cross-reference at line 15 already uses.*

**D7, the measurement does not test what it is offered for.** *"ten random isotropic subspaces at each give $\lvert\gamma\rvert\le3\times10^{-14}$"* is the block's evidence for $\gamma=0$ at the odd cap. By the file's own rigidity evidence at $n=6,8$, isotropic subspaces found at the cap are conjugate to the symmetric pair, where $\gamma=0$ is a theorem. **So the measurement re-measures the known case**; it is consistent with the debt and is not independent evidence for it. The block is right to keep the debt open, and should say why the numbers do not close it.

---

## 9, What is owed at odd $n$, stated sharply

The exact identity of §7 converts the debt into a single equality. At $n$ odd, $d=(n^2-1)/4$, for any isotropic $\mathfrak m$,

$$\gamma=0\iff (n-2)\lVert P_s\rVert^2+6\lVert P_\lambda\rVert^2=\frac{n^2-1}{4n},$$

with $\gamma\ge0$ giving the inequality $\le$ for free. **So the debt is not to bound the $\operatorname{Sym}^2_0$ component but to force it to a prescribed exact value**, every isotropic subspace at the odd cap must carry precisely the $\operatorname{Sym}^2_0$ mass the symmetric pair carries, $\lVert P_s\rVert^2=\frac{n^2-1}{4n(n-2)}$ when $\ell=0$.

**Is it reachable?** The equality form is a rigidity statement of the same shape as the even-$n$ one, and it is strictly harder: at even $n$ the inequality alone closes it, while at odd $n$ an *equality* must be forced from a strict inequality, which needs an ingredient the $T$-spectrum does not carry. **The honest reading is that the debt is open and no argument in the block reduces it.** *A computation that would decide the shape of the answer, and which I do not have approval to run:* a census of $\lVert P_s\rVert^2$ and $\lVert P_\lambda\rVert^2$ over isotropic subspaces at $d=(n^2-1)/4$ for $n=5,7$. **Finding the pair spread over a range would refute the equality and so refute odd-$n$ rigidity outright; finding it pinned to a point would say the debt is a rigidity theorem awaiting a proof rather than a false claim.** As things stand the block's ten samples are consistent with the second and cannot distinguish it from the first, since it does not report the two components.

---

## Summary of verdicts

| item | verdict |
| --- | --- |
| $\gamma=2S_{\mathfrak{mhh}}$ as stated | **REFUTED**, witness $\mathfrak{so}(3)\subset\mathfrak{so}(4)$; needs $S_{\mathfrak{mmm}}=0$ |
| $\gamma=0\iff\mathfrak m^\perp$ a subalgebra, as stated | **REFUTED**, same witness, $\gamma=0$ with $\mathfrak m^\perp$ not a subalgebra |
| both, with the hypothesis restored | **CONFIRMED**, derived independently; general law $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$ |
| row marginal $2(n-2)$ is the Killing fact | **CONFIRMED** |
| $\gamma\le2d(n^2-4d)/n$, vanishing at $d=n^2/4$ | **CONFIRMED**, both parities |
| odd allowance $(n^2-1)/(2n)$ | **CONFIRMED for $\gamma$**; the block attaches it to $S_{\mathfrak{mhh}}$, which is half that (D1) |
| "exactly a $\mathbb Z_2$-grading" | **CONFIRMED**, both directions; the reason (total antisymmetry collapsing three relations to two), is absent from the block |
| "hence Cartan's list, hence the balanced split" | **GAP**, closed here: DIII eliminated by dimension, $\operatorname{Aut}\to SO(n)$ bridged, $n=8$ unaffected |
| the isotypic table | **CONFIRMED and derivable in closed form**, all four rows; presented as measurement |
| "at even $n$, entirely in $\mathrm{Weyl}_n$" | **true and derivable at every even $n$**; the record's warrant is the single row $n=6$ |
| the odd-$n$ debt | **open**, restated as an exact equality (§9) |
| $S_{XYZ}$ normalisation | **live cross-file collision** (D2), and L77's factor $2$ turns on it |
| $\mathfrak h=\mathfrak m^\perp$ | assumed throughout, **contradicted by [conventions.md](../findings/conventions.md)** (D3) |
| provenance | the block makes **no** self-historical claim; the correction it needs was filed the same day into another file and never propagated |
