# Verifier v167, Lemma L32, the surviving statement and the proof as written

I read [BRIEF_L32.md](BRIEF_L32.md), the canonical block at [isotropy-cap.md](../findings/isotropy-cap.md):74-110, the canon copy at [results.md](../results.md):465-469, the landscape line at [results.md](../results.md):150, the report copy at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):1022-1024, the sole live consumer at [stratum-two-negative.md](../findings/stratum-two-negative.md):119-160, the sibling block [Lemma L81](../findings/isotropy-cap.md):317-330, and the L32 rows of [LEDGER.md](../findings/LEDGER.md):232, :247, :253, :1596-1606. Everything below is cold from the definitions. **No numerical work of any kind was done, no script, no Sage, no evaluation, no sweep of multiplicity patterns; every centraliser below was computed by hand from $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ and every value is exact.** Log: [agent_logs/verify-L32-v167.log](../agent_logs/verify-L32-v167.log).

| # | claim | verdict |
| --- | --- | --- |
| C1 | the **Statement.** line at the canonical home, carrying *no* restriction | **REFUTED AS STATED, AND STILL UNREPAIRED IN PLACE**, the banner above it is not the statement |
| C2 | the canon and report form, $m\ne3$ | **TRUE, AND SHARP**, it is exactly the set where the conclusion holds |
| C3 | the landscape form, requiring $\mathfrak c\ne0$ | **TRUE BUT STRICTLY NARROWER**, equivalent to $m\ge4$, silent at $m=2$ where the conclusion holds |
| C4 | $\mathfrak t\subseteq\mathfrak z(x)$, so $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$ | **CONFIRMED** |
| C5 | $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$ | **CONFIRMED**, both inclusions derived below |
| C6 | *"every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates"*, whence $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$ at $p\ge3$ | **CONFIRMED at even $m$; MISNAMED at odd $m$**, where the algebra is $B_p$, and the argument survives the renaming verbatim |
| C7 | *"$x$'s $p=m/2$ coordinate $2$-planes"* | **BROKEN AS WRITTEN**, the block's own scope paragraph is false unless $p=\lfloor m/2\rfloor$ |
| C8 | the $p=2$ clause, and that the exceptional algebra is a $3$-dimensional $\mathfrak{su}(2)$ | **CONFIRMED**, computed at $m=4$ and at $m=5$ |
| C9 | the case split $p\ge3$ / $p=2$ | **INCOMPLETE, $p=1$ is omitted, and $p=1$ is exactly where the statement fails** |
| C10 | the degenerate clause, *"with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$"* | **CONFIRMED, AND NEEDED IN ONE CELL ONLY**, odd $m$ with $\mathop{\mathrm{rank}}x=2$ |
| C11 | the prior finding that the proof *"reaches neither branch at corank $1$"* | **HALF-REFUTED**, true of the words, false of the reason given, and the witness cited for it is corank $3$ |
| C12 | the exception clause, *"a multiple of a complex structure on a $4$-dimensional subspace"* | **EXACTLY RIGHT** at every rank and every multiplicity pattern, once $m\ne3$ |
| C13 | the scope paragraph's criterion, *"proportional to a root of $D_p$"* | **CONFIRMED ONLY IF $D_p$ IS NOT RE-READ AS $B_p$**, the opposite of what the proof's own root line needs at odd $m$ |
| C14 | *"nondegeneracy is sufficient and not necessary at $m\ge6$ … false at $m=4,5$"* | **CONFIRMED under the maximal-rank reading of "nondegenerate", and VACUOUSLY TRUE at $m=5$ under the invertible reading** |
| C15 | *"the one use … is at $n\ge12$ where the hypothesis is expected to hold (expected, and not yet checked there"* | **STALE, AND WRONGLY FRAMED**), the hypothesis is discharged unconditionally at $m\ge4$, and the consumer does not sit at $n\ge12$ |
| C16 | the equality $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ | **ONE INCLUSION IS DERIVED, THE OTHER OMITTED**, trivial, and the block writes an equality |
| C17 | *"the disagreement was settled by checking $\mathfrak t\cap x^\perp\subseteq\mathfrak c$ directly at every pattern"* | **A SWEEP WHERE ONE LINE SUFFICES**, the containment is immediate from $\mathfrak t\subseteq\mathfrak z(x)$ |
| C18 | the one genuinely unwritten mathematical step | **HYPOTHESIS-DEBT**, named in §7 |

**One line.** The statement with $m\ne3$ is true, its exception clause is exactly the right one at every rank and multiplicity pattern, and the corank-$1$ hole the record books against this block is an artefact of the typo *"$p=m/2$"*, the block's own three root-system lines close corank $1$ once the algebra is called $B_p$ rather than $D_p$, which is a renaming the argument survives verbatim, so the previously recorded reason for the gap is refuted while the textual defect it names is real.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

The inner product, from the norms section:

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$. Equivalent to $\mathop{\mathrm{tr}}(v^2)=-2$ above.

and the basis it makes orthonormal:

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal

ad-invariance, which is what makes every orthocomplement below behave:

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant

and the one symbol warning this file carries for the letter $x$:

> *And $x$ is a bivector in L33's proof where the same letter is a vector of $\mathbb R^m$ elsewhere in the file.* **Read each from its block.**

**$\mathfrak c$, $a$, $p$ and $\mathfrak t$ are tabled nowhere.** They are defined inline in the L32 block and nowhere else, which is what lets $p$ carry three senses inside five lines (§6).

## 1. The hypothesis inventory

**What the proof needs, against what the statement carries.** Rows are read off the proof text at [isotropy-cap.md](../findings/isotropy-cap.md):40-51 and the scope paragraph at :53-59.

| the proof needs | the statement carries | status |
| --- | --- | --- |
| $x\ne0$ | yes, in all three forms | held |
| $x$ lies in a maximal torus $\mathfrak t$, and $a$ is its vector of block values in an orthonormal basis of $\mathfrak t$ | not stated; true of every $x\in\mathfrak{so}(m)$ | held, unstated, harmless |
| $m$ **even**, forced by *"$p=m/2$"* together with *"its singular values, all nonzero"* | **stated nowhere** | **the coverage defect, §3** |
| $p\ge3$, or $p=2$ | the split is written | held, but $p=1$ is omitted, §5 |
| the root system of $\mathfrak{so}(m)$ is $D_p$ | stated nowhere; **false at odd $m$** | **the imported-theorem defect, §4** |
| for degenerate $x$: $\mathfrak{so}(\ker x)\ne0$, i.e. $\dim\ker x\ge2$ | stated nowhere | held wherever the clause is actually needed, §7 |
| $m\ne3$, equivalently the conclusion at $p=1$ | carried by [results.md](../results.md) and the report; **absent from the block's own Statement line** | **§2** |
| $\mathfrak c\ne0$ | carried by the landscape line only | strictly stronger than needed, §2 |

**A hypothesis stated but never used.** [results.md](../results.md):465 states $m\ne3$; the proof text never mentions $m=3$, $p=1$, or $\mathfrak c\ne0$, and no step of it invokes the hypothesis. It is stated in the canon and consumed nowhere in the argument. That is not harmless: the hypothesis is doing real work at $p=1$, and the proof does not show where.

**A step using a hypothesis never stated.** *"$p=m/2$"* is an integrality assumption on $m$, and *"every root of $D_p$"* is a second, and neither appears in any of the three statements.

## 2. The three statements, and which is true

**They are three different claims, and they are not equivalent.**

- **No restriction**, the **Statement.** line at [isotropy-cap.md](../findings/isotropy-cap.md):36-38. **False**, by the recorded witness $x=\varphi_{12}\in\mathfrak{so}(3)$: there $\mathfrak z(x)=\mathbb Rx$, so $\mathfrak c=0$, $\mathfrak z(0)=\mathfrak{so}(3)$ and $\mathfrak c^\perp=\mathfrak{so}(3)$, giving dimension $3$ against the asserted $1$, with no $4$-plane in sight. **The canonical home still carries this form as its Statement**, repaired only by a quoted banner placed above it; the banner is a note about the statement and not the statement.
- **$m\ne3$**, [results.md](../results.md):465 and the report. **True, and sharp.**
- **$\mathfrak c\ne0$**, the landscape line at [results.md](../results.md):150. **True, and strictly narrower.**

**Why $m\ne3$ is sharp and $\mathfrak c\ne0$ is not.** $x$ lies in some maximal torus, so $\dim\mathfrak z(x)\ge\lfloor m/2\rfloor$ and $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$; hence $\mathfrak c\ne0$ at every $m\ge4$, and $\mathfrak c=0$ exactly at $m\le3$. The two forms therefore part at $m=2$ alone, and at $m=2$ the conclusion **holds**: $\mathfrak{so}(2)=\mathbb R\varphi_{12}=\mathbb Rx$ is abelian, so $\mathfrak c=\mathfrak{so}(2)\cap x^\perp=0$, $\mathfrak z(0)=\mathfrak{so}(2)=\mathbb Rx$ and $\mathfrak c^\perp=\mathfrak{so}(2)$, giving exactly $\mathbb Rx$. So $\mathfrak c\ne0$ excludes a case the statement covers, and $m=3$ is the unique failure. This agrees with what [Lemma L81](../findings/isotropy-cap.md):319 already records (*"the criterion holds at $m=2$ as well, so the $m\ge4$ form is conservative by that one case"*) so the point is corroboration rather than a new finding, and it settles which form the canon should carry.

**Which the consumers need.** Either serves. The only live consumer is [Lemma L33](../findings/stratum-two-negative.md), which applies L32 to eigenvectors of a $W\in\mathrm{Weyl}_m$, so $m\ge4$ throughout, see §8. The recommendation is $m\ne3$, because it is the sharp form and because the block's own criterion (§6) is a statement about all $m$.

## 3. The main branch is written for even $m$, and the words admit a reading in which it is not

**Step 1, locate it.** *"Let $\mathfrak t$ be the maximal torus spanned by $x$'s $p=m/2$ coordinate $2$-planes and $a=(a_1,\dots,a_p)$ its singular values, all nonzero."*

**Step 2, exhibit the failure.** Read literally, $p=m/2$ requires $m$ even, and *"singular values, all nonzero"* then says $x$ is invertible, which is possible only at even $m$, since a skew matrix of odd size has $\det x=(-1)^m\det x=-\det x=0$. So under the literal reading the branch is empty at every odd $m$, and the whole odd case falls to the one-sentence degenerate clause. **The block's own scope paragraph then contradicts the literal reading**: it asserts that *"nondegeneracy is sufficient and not necessary at $m\ge6$"* is *"false at $m=4,5$"*, and at $m=5$ the class of invertible $x\in\mathfrak{so}(5)$ is empty, so every statement about it (that one included), is vacuously **true**. A sentence cannot be false about an empty class.

**Step 3, argue the opposite.** The charitable reading is $p=\lfloor m/2\rfloor$, with *"nondegenerate"* meaning **maximal rank** (no zero among the $\lfloor m/2\rfloor$ block values) and this is well supported by the words: *"the maximal torus spanned by $x$'s coordinate $2$-planes"* is a correct description of a maximal torus of $\mathfrak{so}(2p+1)$ when $x$ has rank $2p$, and *"$a$ its singular values, all nonzero"* correctly names the $p$ block values, the extra zero singular value forced by odd size not being one of them. Under this reading the scope paragraph's *"false at $m=4,5$"* is **true**: at $m=5$ a maximal-rank $x=a_1\varphi_{12}+a_2\varphi_{34}$ with $a_1=a_2$ is a multiple of a complex structure on a $4$-plane, so nondegeneracy is not sufficient there either.

**Finding.** The two sentences are inconsistent under the literal reading and consistent under the charitable one, so the charitable one is the block's intent and *"$p=m/2$"* is a typo for $p=\lfloor m/2\rfloor$. **This is not cosmetic**: the whole of the record's booked corank-$1$ debt is the difference between the two readings (§7).

## 4. Odd $m$: what the argument gives, and whether the conclusion survives

**The two inclusions of the chain, derived.**

*First.* $x\in\mathfrak t$ and $\mathfrak t$ is abelian, so $\mathfrak t\subseteq\mathfrak z(x)$; the basis $\{\varphi_{2i-1,2i}\}_{i\le p}$ of $\mathfrak t$ is orthonormal by the convention quoted in §0, and under it $x\leftrightarrow a$, so $\mathfrak t\cap x^\perp$ is the hyperplane $a^\perp$ of $\mathfrak t$. Since $\mathfrak t\subseteq\mathfrak z(x)$ and $a^\perp\subseteq x^\perp$, indeed $a^\perp\subseteq\mathfrak z(x)\cap x^\perp=\mathfrak c$. **C4 confirmed**, at both parities, degenerate $x$ included.

*Second.* Centralising reverses inclusions, so $\mathfrak c\supseteq a^\perp$ gives $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)$. For the evaluation, decompose $\mathfrak{so}(m)\otimes\mathbb C=\mathfrak t_{\mathbb C}\oplus\bigoplus_\beta\mathfrak g_\beta$ with $[h,y_\beta]=\beta(h)y_\beta$ for $h\in\mathfrak t$. Writing $y=y_0+\sum_\beta y_\beta$, the condition $[h,y]=0$ for all $h\in a^\perp$ reads $\beta(h)y_\beta=0$ for every $\beta$ and every $h\in a^\perp$, i.e. $y_\beta=0$ unless $\beta$ annihilates the hyperplane $a^\perp$, which under the identification $\mathfrak t^*\cong\mathfrak t$ furnished by the same orthonormal basis is $\beta\propto a$. Hence $\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$, and this holds over $\mathbb R$ because the real form of $\mathfrak g_\beta\oplus\mathfrak g_{-\beta}$ is $\mathop{\mathrm{ad}}(\mathfrak t)$-stable. **C5 confirmed.** Note the derivation uses nothing about which root system it is.

**Where $D_p$ enters, and what it costs.** The next sentence is *"Every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates, while $a$ has none."* At odd $m=2p+1$ the algebra is $B_p$, whose root set is $\{\pm e_i\pm e_j\}\cup\{\pm e_i\}$, and the short roots have $p-1$ zero coordinates, not $p-2$. The sentence is **false as an assertion about $\mathfrak{so}(m)$ at odd $m$**, a root-system fact imported without its hypothesis, which is the trap *"an imported theorem whose hypotheses were never checked against the object"*. The dimension count confirms the two systems are different objects: $\dim\mathfrak{so}(2p+1)=p+2p(p-1)+2p=p(2p+1)$, against $\dim\mathfrak{so}(2p)=p+2p(p-1)=p(2p-1)$.

**What the argument gives once the name is corrected.** The step the proof actually performs is *"$a$ has no zero coordinate, so for $p\ge3$ no root is proportional to $a$."* Every root of $B_p$ has **at least** $p-2$ zero coordinates (the long ones exactly $p-2$, the short ones $p-1$) so a vector with no zero coordinate is proportional to a root only if $p\le2$, exactly as at $D_p$. **The renaming costs the argument nothing**, and the correct sentence is *"every root of $\mathfrak{so}(m)$ has at least $p-2$ zero coordinates"*, true at both parities.

**Where the $B_p$ short roots do bite.** Precisely when $a$ **has** a zero coordinate and only one nonzero one, that is, $\mathop{\mathrm{rank}}x=2$ at odd $m$. Closed form, and it is the record's own witness read correctly: at $x=\varphi_{12}\in\mathfrak{so}(5)$, $p=2$ and $a=(1,0)$, so $a^\perp=\mathbb R\varphi_{34}$ and $\mathfrak z(a^\perp)=\mathfrak{so}(2)_{34}\oplus\mathfrak{so}(3)_{125}$ has dimension $4$, matching $\mathfrak t\oplus\mathfrak g_{e_1}\oplus\mathfrak g_{-e_1}$ of real dimension $2+2=4$, where the $D_2$-only reading would allow $2$. **But this $x$ has corank $3$, not corank $1$**, see §7.

**And the conclusion survives there anyway.** At $x=\varphi_{12}\in\mathfrak{so}(5)$, $\mathfrak z(x)=\mathfrak{so}(2)_{12}\oplus\mathfrak{so}(3)_{345}$ and $\mathfrak c=\mathfrak{so}(3)_{345}$. Splitting $\mathfrak{so}(5)=\mathfrak{so}(S)\oplus\mathfrak{so}(K)\oplus\mathop{\mathrm{Hom}}(K,S)$ with $S=\langle e_1,e_2\rangle$ and $K=\langle e_3,e_4,e_5\rangle$: the $\mathfrak{so}(S)$ part is $\mathbb R\varphi_{12}=\mathbb Rx$ and commutes with $\mathfrak{so}(K)$; the $\mathfrak{so}(K)$ part must lie in the centre of $\mathfrak{so}(3)$, which is $0$; and $\mathop{\mathrm{Hom}}(K,S)\cong S\otimes K$ carries $\mathfrak{so}(3)$ in the standard factor, which has no invariant vector. So $\mathfrak z(\mathfrak c)=\mathbb Rx$ and the conclusion holds. **This is the cell the degenerate clause exists for**, and there $\dim\ker x=3$, so $\mathfrak{so}(\ker x)\ne0$ and the clause is available.

## 5. $p=2$, and the case the split omits

**$p=2$, the clause as written.** *"For $p=2$ the roots have no zero coordinate and $a\propto(1,1)$ is admissible, exactly the complex-structure case."*

**The reason given is false at odd $m$ and the conclusion is right anyway.** $B_2$ has the short roots $\pm e_1,\pm e_2$, which do have a zero coordinate, so *"the roots have no zero coordinate"* is a statement about $D_2$ only. It does not matter: $a$ has no zero coordinate at $p=2$ under the branch's hypothesis, so $a\propto\pm e_i$ is impossible and only the long roots can be proportional to $a$, exactly as at $D_2$.

**And it is exactly the complex-structure case, with the algebra as advertised.** Take $m=4$ and $x=\varphi_{12}+\varphi_{34}$, so $a=(1,1)$. In the self-dual/anti-self-dual basis $\alpha_1=\varphi_{12}+\varphi_{34}$, $\alpha_2=\varphi_{13}+\varphi_{42}$, $\alpha_3=\varphi_{14}+\varphi_{23}$ and $\beta_i$ the same with the sign of the second term reversed, $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ with the two summands commuting, and $x=\alpha_1$. Then $\mathfrak z(x)=\mathbb R\alpha_1\oplus\mathfrak{su}(2)_-$, of dimension $4$; $\mathfrak c=\mathfrak z(x)\cap x^\perp=\mathfrak{su}(2)_-$, of dimension $3$; $\mathfrak z(\mathfrak{su}(2)_-)=\mathfrak{su}(2)_+$ because $\mathfrak{su}(2)$ has trivial centre; and $\mathfrak c^\perp=\mathfrak{su}(2)_+$. So $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak{su}(2)_+$, **of dimension $3$, and it is an $\mathfrak{su}(2)$**, containing $x=\alpha_1$. **C8 confirmed**, both halves.

**The unequal case at $p=2$, for completeness.** With $a_1\ne a_2$ both nonzero, $\mathfrak z(x)=\mathfrak t$ and $\mathfrak c=\mathbb Ry$ for $y=a_2\varphi_{12}-a_1\varphi_{34}$, which is invertible with distinct block values, so $\mathfrak z(y)=\mathfrak t$ and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak t\cap y^\perp=\mathbb Rx$. The $p=2$ clause therefore splits correctly into exception and non-exception.

**The omitted case, $p=1$.** The split is *"For $p\ge3$ … For $p=2$ …"*, and $p=1$ is treated nowhere. At $p=1$ the hyperplane $a^\perp$ is $\{0\}$, $\mathfrak z(\{0\})$ is all of $\mathfrak{so}(m)$, and the chain gives nothing. **That is exactly where the statement fails**: $m=3$ has $p=1$, and the recorded witness is the failure of this cell. It does not fail at $m=2$, also $p=1$, because there $\mathfrak{so}(2)=\mathbb Rx$ and the vacuous bound is already the conclusion. So the missing hypothesis and the missing case are one thing: **the statement's $m\ne3$ is precisely the assertion that the omitted $p=1$ cell is not the failing one.** [LEDGER.md](../findings/LEDGER.md):253 records the same omission against the sibling [Lemma L81](../findings/isotropy-cap.md) (*"the proof splits on $p\ge3$ and $p=2$ and never treats $p=1$"*) and books it there; it is unbooked here, in the block that supplies L81's proof.

## 6. The exception clause, and the scope paragraph's criterion

**The exception is neither too wide nor too narrow.** Writing $\mathop{\mathrm{rank}}x=2r$ and $k=\dim\ker x=m-2r$, and splitting $\mathfrak{so}(m)=\mathfrak{so}(S)\oplus\mathfrak{so}(K)\oplus\mathop{\mathrm{Hom}}(K,S)$ along $S=\mathop{\mathrm{im}}x$ and $K=\ker x$, the classes are these. Every entry was computed by hand at the witness named.

| class | witness | $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ |
| --- | --- | --- |
| $r=1$, $k=0$ ($m=2$) | $\varphi_{12}\in\mathfrak{so}(2)$ | $\mathfrak{so}(2)=\mathbb Rx$ |
| $r=1$, $k=1$ ($m=3$) | $\varphi_{12}\in\mathfrak{so}(3)$ | $\mathfrak{so}(3)$, **dimension $3$, the sole failure** |
| $r=1$, $k\ge2$ | $\varphi_{12}\in\mathfrak{so}(5)$, §4 | $\mathbb Rx$ |
| $r=2$, $a_1\ne a_2$ | $\varphi_{12}+2\varphi_{34}$, any $m\ge4$ | $\mathbb Rx$ |
| $r=2$, $a_1=a_2$ | $\varphi_{12}+\varphi_{34}$, any $m\ge4$ | $\mathfrak{su}(2)_+$, **dimension $3$, the exception** |
| $r\ge3$, distinct $a_i$ | $\varphi_{12}+2\varphi_{34}+3\varphi_{56}\in\mathfrak{so}(7)$ | $\mathbb Rx$ |
| $r\ge3$, all $a_i$ equal | $\varphi_{12}+\varphi_{34}+\varphi_{56}\in\mathfrak{so}(7)$ | $\mathbb Rx$ |

The two hardest rows in closed form. For the padded complex structure at any $m\ge4$: $\mathfrak c=\mathfrak{su}(2)_-\oplus\mathfrak{so}(K)$; the $\mathfrak{so}(S)$ part of $\mathfrak z(\mathfrak c)$ is $\mathfrak{su}(2)_+$; the $\mathfrak{so}(K)$ part lies inside $\mathfrak c$ and is deleted by $\mathfrak c^\perp$; and $\mathop{\mathrm{Hom}}(K,S)\cong S\otimes K$ carries $\mathfrak{su}(2)_-$ on $S=\mathbb H$, which is irreducible over $\mathbb R$ and so has no invariant vector. **Dimension $3$ at every $m\ge4$, odd $m$ included**, so the block's *"padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time"* is right and its list of dimensions is even-only for no reason; $m=5,7,9$ do the same. For $x=\varphi_{12}+\varphi_{34}+\varphi_{56}\in\mathfrak{so}(7)$: $\mathfrak z(x)=\mathfrak u(3)$ and $\mathfrak c=\mathfrak{su}(3)$, whose commutant among real endomorphisms of $\mathbb R^6=\mathbb C^3$ is $\mathbb C$, whose skew part is $\mathbb Rx$; the mixed block is $\mathbb C^3$, with no $\mathfrak{su}(3)$-invariant vector. **Dimension $1$**, a maximal-multiplicity, corank-$1$, odd-$m$ pattern coming out on the non-exceptional side.

**So the exception is exactly $\mathop{\mathrm{rank}}x=4$ with equal singular values, at every $m\ge4$, and the only other deviation from $\mathbb Rx$ anywhere is $m=3$.** The clause is right.

**The scope paragraph's criterion, and a collision it hides.** *"The criterion is the singular-value vector being proportional to a root of $D_p$, which is rank $4$ with equal singular values."* Read with $\beta$ ranging over $\{\pm e_i\pm e_j\}$ (the long roots), this is correct at both parities and for degenerate $x$: a vector is proportional to $\pm e_i\pm e_j$ exactly when it has two nonzero coordinates of equal modulus and no others. **Read with $\beta$ ranging over the roots of $\mathfrak{so}(m)$, which is what §4 forces on the proof at odd $m$, it is false**: $a\propto e_1$ is a $B_p$ root and says $\mathop{\mathrm{rank}}x=2$, and the $\mathfrak{so}(5)$ computation of §4 returns $\mathbb Rx$ there, not an exception. **The same symbol $D_p$ must therefore be read one way in the proof (as "the roots of $\mathfrak{so}(m)$", to make the root-space decomposition true) and the opposite way in the scope paragraph, as "the long roots only", to make the criterion true.** That is the $p$/$D_p$ collision this block carries, on top of the $p=m/2$ against $p=r$ shift between its two branches. [conventions.md](../findings/conventions.md) tables none of $\mathfrak c$, $a$, $p$, $\mathfrak t$.

**The sufficiency remark.** *"nondegeneracy is sufficient and not necessary at $m\ge6$, the qualifier was missing and the claim is false at $m=4,5$."* Sufficient: at even $m\ge6$ a nondegenerate $x$ has $p\ge3$ and $a$ with no zero coordinate, so no root is proportional to $a$ and the answer is $\mathbb Rx$. Not necessary: $x=\varphi_{12}\in\mathfrak{so}(6)$ is degenerate and returns $\mathbb Rx$. False at $m=4$: the complex structure is nondegenerate and exceptional. **At $m=5$ it is false under the maximal-rank reading and vacuously true under the invertible one**, the discrepancy of §3, and it is the scope paragraph that decides the reading.

**C17.** *"the disagreement was settled by checking $\mathfrak t\cap x^\perp\subseteq\mathfrak c$ directly at every pattern"*, the containment is the first line of §4 and holds for every $x$ at once, because $\mathfrak t\subseteq\mathfrak z(x)$ whenever $x\in\mathfrak t$. A per-pattern check was run where one line closes it, and per the standing rule a check at every pattern is an open hypothesis rather than a proof in any case.

## 7. The degenerate branch, and the corank-$1$ finding

The clause is one sentence: *"For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$."*

**What the sentence is entitled to.** The splitting $\mathfrak{so}(m)=\mathfrak{so}(S)\oplus\mathfrak{so}(K)\oplus\mathop{\mathrm{Hom}}(K,S)$ is preserved by $\mathop{\mathrm{ad}}$ of anything in $\mathfrak{so}(S)\oplus\mathfrak{so}(K)$, and $x\in\mathfrak{so}(S)$ with $x|_S$ invertible, so $\mathfrak z(x)=\mathfrak z_{\mathfrak{so}(S)}(x)\oplus\mathfrak{so}(K)$, the mixed block contributes nothing, since $[x,y]$ acts there as $y\mapsto (x|_S)y$, which is injective. Hence $\mathfrak c=\mathfrak c_S\oplus\mathfrak{so}(K)$ with $\mathfrak c_S=\mathfrak z_{\mathfrak{so}(S)}(x)\cap x^{\perp}$, and $\mathfrak z(\mathfrak c)$ splits along the three blocks. So *"the same argument runs inside the support"* is legitimate for the $\mathfrak{so}(S)$ block, and *"additionally centralising $\mathfrak{so}(\ker x)$"* names the extra condition on the other two blocks correctly. **C10's shape is right.**

**Two eliminations the sentence names but does not carry out.** The $\mathfrak{so}(K)$ block is deleted because $\mathfrak{so}(K)\subseteq\mathfrak c$, so $\mathfrak c^\perp$ meets it in $0$, one line, unwritten. The mixed block is deleted, when $\dim\ker x\ge2$, because $\mathop{\mathrm{Hom}}(K,S)\cong S\otimes K$ carries $\mathfrak{so}(K)$ in the standard factor and the standard representation of $\mathfrak{so}(k)$ has no nonzero invariant vector for $k\ge2$, also one line, also unwritten. **This second line is the block's one genuinely owed mathematical step**, and it is what the phrase *"additionally centralising $\mathfrak{so}(\ker x)$"* is gesturing at without saying.

### 7.1 The prior finding, verified and refuted in its parts

The finding on the record, at [stratum-two-negative.md](../findings/stratum-two-negative.md):157, [plan-verification.md](../plan-verification.md):88 and [ATTEMPTS.md](../ATTEMPTS.md):5003, is that the written proof reaches neither branch at corank $1$, *"the degenerate clause invoking $\mathfrak{so}(\ker x)$, which is zero there, and the root argument failing at odd $m$ where the algebra is $B_p$"*.

**Verified.** Read literally the words reach nothing at corank $1$: $p=m/2$ is not an integer at odd $m$, so the main branch is inapplicable, and $\mathfrak{so}(\ker x)=\mathfrak{so}(1)=0$, so the degenerate clause's extra condition is empty. **The textual defect is real.**

**Refuted, in the reason.** The second half (that the charitable reading fails *"because at odd $m$ the algebra is $B_p$"*), does not hold at corank $1$. At corank $1$, $m=2p+1$ and $\mathop{\mathrm{rank}}x=2p$, so $a$ has **all $p$ coordinates nonzero**; and the only $B_p$ roots that could be proportional to a vector with no zero coordinate are those with no zero coordinate, which requires $p\le2$, the short roots $\pm e_i$ are excluded by exactly the hypothesis the block's own sentence states, *"while $a$ has none"*. So at corank $1$ the three root-system lines run verbatim: $p\ge3$ gives $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$ and hence $\mathbb Rx$, and $p=2$ (that is, $m=5$) gives the complex-structure exception when $a_1=a_2$ and $\mathbb Rx$ otherwise. §6's two corank-$1$ rows, $\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ and $\varphi_{12}+\varphi_{34}+\varphi_{56}$ in $\mathfrak{so}(7)$, and the padded $J$ in $\mathfrak{so}(5)$, are what the corrected lines predict, and they agree.

**Refuted, in the witness.** The object cited for the $B_p$ failure is $x=\varphi_{12}\in\mathfrak{so}(5)$, whose $\mathfrak z(\mathfrak a)$ has dimension $4$ against the $D_2$ formula's $2$. That computation is correct (§4 reproduces it) but $x$ there has $\dim\ker x=3$. **It is a corank-$3$ witness, offered as evidence about corank $1$.** The $B_p$ short roots bite exactly when $a$ has a zero coordinate, that is at corank $\ge3$ at odd $m$; and there $\dim\ker x\ge3$, so $\mathfrak{so}(\ker x)\ne0$ and the degenerate clause is available and does the work.

**The architecture this exposes.** The two failure modes are complementary and the block's two branches sit exactly on them: $a$ has no zero coordinate (corank $0$ or $1$) and the root lines close it at both parities; $a$ has a zero coordinate (corank $\ge2$) and $\dim\ker x\ge2$, so the degenerate clause is nonvacuous. **The single cell where both fail is corank $1$ with $\mathop{\mathrm{rank}}x=2$, which is $m=3$ and $p=1$, and there the statement is false.** A proof of a lemma hypothesised on $m\ne3$ is entitled to reach nothing in that cell.

**Consequence for the booked debt.** The corank-$1$ `HYPOTHESIS-DEBT` carried against this block, and inherited by [Lemma L33](../findings/stratum-two-negative.md) and by [results.md](../results.md):475, is an artefact of *"$p=m/2$"* together with the naming of $D_p$. It is discharged by the two textual repairs of §3 and §4 and needs no argument that is not already in the block. **I have written no new proof of it and none is owed**; what is owed is the one line of §7's second elimination, which bites only at odd $m$ with $\mathop{\mathrm{rank}}x=2$.

### 7.2 The debt, named exactly

**What is not on file, in the form a repair would have to prove:** *the standard representation of $\mathfrak{so}(k)$ on $\mathbb R^k$ has no nonzero invariant vector for $k\ge2$, so that $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)\cap\mathfrak z(\mathfrak c)=0$ whenever $\dim\ker x\ge2$.* The block asserts the containment this delivers and does not derive it. I did not derive it either.

## 8. What is proven against what is used

**The consumer.** [Lemma L33](../findings/stratum-two-negative.md) is the only live consumer. The citation in [Lemma L24](../findings/second-order.md)'s sharpness sentence was deleted by [ROUND_L24](ROUND_L24.md) row E3 and [second-order.md](../findings/second-order.md) now contains no occurrence of L32; [Lemma L80](../findings/isotropy-cap.md) and [Lemma L81](../findings/isotropy-cap.md) mention it without standing on it, and [LEDGER.md](../findings/LEDGER.md):1602 records that nothing consumes L81.

**The hypothesis, checked.** The block's *"the one use … is at $n\ge12$ where the hypothesis is expected to hold, expected, and not yet checked there"* is **stale and wrongly framed, and the hypothesis does hold**.

- *Stale.* The discharge is written into the consumer's own block: $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$ because $\mathfrak z(x)$ contains a maximal torus through $x$, which is $\ge5$ at $m\ge12$ and $\ge1$ at every $m\ge4$. [LEDGER.md](../findings/LEDGER.md):247 records the same discharge. The clause predates both.
- *Wrongly framed.* L33 is a statement about $\mathrm{Weyl}_m$ at every $m$, and its proof invokes L32 at whatever $m$ L33 is applied to, not at $n\ge12$. The right discharge is dimension-free: $\mathcal W_m=0$ for $m\le3$, so any $x$ that is an eigenvector of a nonzero $W\in\mathrm{Weyl}_m$ has $m\ge4$, where $\mathfrak c\ne0$. The $n\ge12$ range belongs to [Lemma L29](../findings/stratum-two-negative.md) downstream, not to this hypothesis.
- *Held.* Under either form of the statement ($m\ne3$ or $\mathfrak c\ne0$), the consumer's object satisfies it at every $m\ge4$.

**What the consumer inherits.** L33's advertised coverage of odd $m$ and degenerate minority eigenvectors is, by §7.1, not obstructed by anything mathematical in L32; it is obstructed by two words in L32's proof text. That changes the repair from *"write the missing corank-$1$ argument"* to *"correct $p=m/2$ to $p=\lfloor m/2\rfloor$ and $D_p$ to the roots of $\mathfrak{so}(m)$"*.

## 9. Candidates withdrawn

**The exception clause read as a restriction condition.** *"$x$ is a multiple of a complex structure on a $4$-dimensional subspace"* could be read as *"$x$ restricted to some $4$-plane is a multiple of a complex structure"*, and under that reading the clause is far too wide: $x=\varphi_{12}+\varphi_{34}+5\varphi_{56}\in\mathfrak{so}(6)$ restricts to a complex structure on $\langle e_1,e_2,e_3,e_4\rangle$ while $a=(1,1,5)$ is proportional to no root, so $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ and the clause would falsely predict an $\mathfrak{su}(2)$. **Withdrawn at step 3**: *"$x$ **is** a multiple of a complex structure on $V$"* carries the whole of $x$, hence vanishing on $V^\perp$, and the scope paragraph pins that reading with *"rank $4$ with equal singular values"*. Recorded as a wording note, not a defect.

**"Three root-system lines, uniform in the singular values."** The landscape and report both say this. It is accurate: the argument depends on the singular values only through which are zero and whether one vector is proportional to a root, so it is uniform in them. **Withdrawn at step 2**, no failure exhibited.

**The missing reverse inclusion.** The block derives $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathbb Rx$ and writes an equality. **Withdrawn at step 2** as a defect: $\mathfrak c\subseteq\mathfrak z(x)$ gives $x\in\mathfrak z(\mathfrak c)$, and $\mathfrak c\subseteq x^\perp$ gives $x\in\mathfrak c^\perp$, so the other inclusion is immediate. Recorded because the block asserts an equality and proves an inclusion, and the same omission at $p=1$ would have been visible.

## 10. What would break it

**The object.** A nonzero $x\in\mathfrak{so}(m)$ with $m\ne3$, not a multiple of a rank-$4$ complex structure, admitting some $y\in\mathfrak{so}(m)$ with $y\notin\mathbb Rx$, $y\perp\mathfrak c$, and $[y,c]=0$ for every $c\in\mathfrak z(x)\cap x^\perp$. Equivalently, by §4, a maximal torus $\mathfrak t\ni x$ whose block-value vector $a$ is proportional to a root of $\mathfrak{so}(m)$ that is not long, or a $y$ outside $\mathfrak z(a^\perp)$, neither of which can exist, since $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)$ holds for every $x$ at once.

**Where I looked.** At the boundary of every range the block names and at every corank: $m=2$ and $m=3$ by hand; $\mathop{\mathrm{rank}}x=2$ at $m=4,5,6,7$; $\mathop{\mathrm{rank}}x=4$ with equal and with unequal singular values, padded to arbitrary $m$; corank $1$ at $m=5$ and $m=7$, in both the all-distinct and the all-equal multiplicity pattern; and the two multiplicity patterns at even $m$ that make $\mathfrak c$ largest, $a=(1,\dots,1)$ giving $\mathfrak c=\mathfrak{su}(p)$ and $a=(1,1,2,2)$ giving $\mathfrak c$ of dimension $7$ at $m=8$. Every one returned $\mathbb Rx$ or the $\mathfrak{su}(2)$ predicted by the criterion. **I ran no sweep and no script; the $29$-partition Gate 2 in the block is an open hypothesis on this record and is not evidence I used or repeated.** The criterion of §6 supersedes it: it is a closed-form classification, and any falsifier would have to violate the root-space decomposition itself.

## Verdict

**`PROVEN, hypotheses corrected`**, for the statement carrying $m\ne3$, subject to three textual repairs that the block's own scope paragraph already forces and that cost the argument nothing.

1. **$p=\lfloor m/2\rfloor$, not $m/2$**, with *"nondegenerate"* meaning maximal rank. Without it the main branch is empty at odd $m$ and the scope paragraph is false.
2. **The root sentence must name $\mathfrak{so}(m)$, not $D_p$**, and must read *"every root has **at least** $p-2$ zero coordinates"*. The step the proof performs survives this verbatim; the sentence as written is false at odd $m$.
3. **The split must treat $p=1$**, which is where the statement fails at $m=3$ and holds at $m=2$. The hypothesis $m\ne3$ and this omitted cell are the same thing, and the proof currently states neither.

**Two further corrections to the record, neither affecting the mathematics.**

- The **Statement.** line at the canonical home still carries the refuted unrestricted form; the canon and the report carry $m\ne3$ and the landscape carries the narrower $\mathfrak c\ne0$. Four sites, three claims, one of them false.
- The consumer note *"expected, and not yet checked there"* is stale: the hypothesis is discharged in the consumer's own block and in [LEDGER.md](../findings/LEDGER.md), unconditionally at $m\ge4$ rather than at $n\ge12$.

**And one debt stands**, small and named in §7.2: the elimination of $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ when $\dim\ker x\ge2$, which the degenerate clause asserts and does not derive.

**The corank-$1$ `HYPOTHESIS-DEBT` booked against this block is withdrawn as a mathematical gap and re-booked as repair 1 together with repair 2.** No new argument was written to close it, and none is needed.
