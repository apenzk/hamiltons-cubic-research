# Verifier v168, Lemma L32, the surviving statement and the proof as written

Read cold from the definitions in [conventions.md](../findings/conventions.md) and the three statement forms on the record, against the proof block at [isotropy-cap.md:74-110](../findings/isotropy-cap.md). **No numerical work was done. No script, no Sage, no sampling, no sweep.** Every centraliser below is computed by hand in closed form from the block decomposition of a skew matrix, and every dimension is exact. The 29-partition Gate 2 sweep was not repeated and is not relied on. Log: [agent_logs/verify-L32-v168.log](../agent_logs/verify-L32-v168.log).

## The claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| 1 | **[isotropy-cap.md](../findings/isotropy-cap.md)'s Statement line**, quantified over all nonzero $x$ with no restriction | **REFUTED, still standing unrepaired.** The banner above it flags the defect; the Statement itself was never edited |
| 2 | **[results.md:467](../results.md)'s form**, $m\ne3$ | **PROVEN SHARP.** $m\ne3$ is exactly the set on which the conclusion holds, $m=2$ included |
| 3 | **[results.md:150](../results.md)'s landscape form**, $\mathfrak c\ne0$ | **SOUND BUT NOT SHARP.** $\mathfrak c\ne0\iff m\ge4$; it drops $m=2$, where the conclusion is true |
| 4 | The exception clause, a multiple of a complex structure on a $4$-plane | **EXACT.** Neither too wide nor too narrow in any case reachable in closed form; the value is $3$ at every corank |
| 5 | $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$ | **CONFIRMED** |
| 6 | $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$ | **CONFIRMED**, modulo an unstated complexification |
| 7 | *"Every root of $D_p$ …"*, the main branch is written for even $m$ and never says so | **NO ERROR, AND THE OMISSION IS NOT THE ONE ALLEGED.** Nondegeneracy *forces* $m$ even, so $p=m/2$ is legitimate. The cost is that **all odd $m$ falls into the one-sentence degenerate branch** |
| 8 | The $p=2$ branch and its $\mathfrak{su}(2)$ | **CONCLUSION TRUE, ARGUMENT INCOMPLETE.** The block never derives the value $3$; its own chain only bounds it above |
| 9 | The case split $p\ge3$ / $p=2$ | **GAP, $p=1$ is untreated**, exactly [L81](../findings/isotropy-cap.md)'s recorded defect, in the block that L81 says supersedes it |
| 10 | The degenerate branch reaches nothing at $\dim\ker x=1$ (prior finding, [stratum-two-negative.md:161](../findings/stratum-two-negative.md)) | **HALF CONFIRMED, HALF REFUTED.** The $\mathfrak{so}(\ker x)$ clause is indeed vacuous at corank $1$. The stated *reason* the charitable reading fails there is **refuted on the finding's own named instance** |
| 11 | The scope paragraph's root criterion, *"rank $4$ with equal singular values"* | **TRUE AT EVEN $m$, SILENT AT ODD $m$**, it is stated over $D_p$ only, and $B_p$'s short roots are a second inconclusive case that produces no exception |
| 12 | *"nondegeneracy is sufficient and not necessary at $m\ge6$ … false at $m=4,5$"* | **CONFIRMED AT $m=4$, VACUOUS AT $m=5$** under the record's own reading of nondegenerate |
| 13 | The consumer at $n\ge12$, *"expected, and not yet checked there"* | **STALE.** It is checked, twice, and the discharge is unconditional at every $m\ge4$, the $n\ge12$ hedge is not needed |
| 14 | The reverse inclusion $\mathbb Rx\subseteq\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ | **NEVER STATED.** The proof establishes $\subseteq$; the statement asserts equality |
| 15 | *"Gate 2 passed … at all $29$ multiplicity partitions to $m=12$"* | **THE CITED EVIDENCE COVERS ONLY THE BRANCH THAT ALREADY HAS A PROOF**, see §9, and it is an inference from the count, labelled as one |

## One line

**The statement is right and the hypothesis $m\ne3$ is sharp; the proof on file covers even $m$ with $\ker x=0$ and degenerate $x$ with $\dim\ker x\ge2$, and its two smallest gaps ($p=1$, and naming $D_p$ where odd $m$ needs $B_p$), are one word each, so the corank-$1$ debt is smaller than the record says but is not discharged here. Verdict `GAP`.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> **The Killing form of $\mathfrak{so}(n)$** is $B(X,Y)=(n-2)\operatorname{tr}(XY)$, with $\operatorname{tr}(v^2)=-2$ for a unit bivector

so the inner product in play is $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$ and the coordinate bivectors $\varphi_{ij}$ are orthonormal. Also quoted, because it is the one this block's frame choice leans on:

> **"Diagonal" means diagonal in coordinate $2$-planes $e_i\wedge e_j$** of an orthonormal frame of $\mathbb R^n$

And on the letters, quoted because it names this block's own collision:

> *And $x$ is a bivector in L33's proof where the same letter is a vector of $\mathbb R^m$ elsewhere in the file.* **Read each from its block.**

**Four of the five symbols carrying this proof are tabled nowhere.** $\mathfrak c$, $a$, $p$ and $\mathfrak t$ have no row in [conventions.md](../findings/conventions.md). $p$ is the one that has already cost a repair: [L81](../findings/isotropy-cap.md)'s own correction notice records that $p$ *"carries two readings (the torus rank $\lfloor m/2\rfloor$ and the support rank $\tfrac12\operatorname{rank}x$) which are different hypotheses"*. L32's proof uses the **torus** reading ($p=m/2$) and its scope paragraph uses the **support** reading (a padded rank-$4$ $x$ at $m=10$ is called a root of $D_p$ with $p$ read as $5$ in one sentence and $2$ in the next). A fifth collision sits inside the block itself: **$e$ is a bivector index in the refutation banner ($x=e_{12}\in\mathfrak{so}(3)$) and a weight-lattice basis vector four lines later ($\pm e_i\pm e_j$)**.

## 1. The hypothesis inventory

**What the three statements carry.**

| site | hypothesis carried |
| --- | --- |
| [isotropy-cap.md:88](../findings/isotropy-cap.md), the canonical **Statement** | $x\ne0$, and nothing else |
| [results.md:467](../results.md) | $m\ne3$, $x\ne0$ |
| [results.md:150](../results.md), landscape | $\mathfrak c\ne0$ |

**What the proof needs.** Reading the argument step by step, the restrictions it actually consumes are:

| step | restriction the step needs | stated? |
| --- | --- | --- |
| *"$\mathfrak t$ … spanned by $x$'s $p=m/2$ coordinate $2$-planes"* | $\ker x=0$, hence $m$ even | half, *"for nondegenerate $x$"* is in the heading, *"$m$ even"* is nowhere, and is redundant given it |
| *"every root of $D_p$"* | $m$ even. At odd $m$ the algebra is $B_p$ | **no** |
| *"For $p\ge3$ that forces …"* | $p\ge3$ | yes |
| *"For $p=2$ …"* | $p=2$ | yes |
| **neither branch** | $p=1$ | **no, $p=1$ is untreated** |
| *"the same argument runs inside the support"* | the support argument must apply to $x\vert_{\mathrm{im}\,x}$, i.e. $r\ne1$ or the kernel clause must bite | **no** |
| *"additionally centralising $\mathfrak{so}(\ker x)$"* | $\dim\ker x\ge2$, since $\mathfrak{so}(1)=\mathfrak{so}(0)=0$ | **no** |

**A hypothesis stated and never used.** $\mathfrak c\ne0$ appears in the landscape statement and in the two banners. **It is used at no step of the proof.** The proof's real requirement is *"no root is proportional to the (padded) singular-value vector, unless it is a long root"*; $\mathfrak c\ne0$ is a patch applied to the statement after the witness landed, not a premise the argument consumes.

**Which form is true.** $x\in\mathfrak z(x)$ and $x\ne0$, so $\mathfrak z(x)=\mathbb Rx\oplus\mathfrak c$ orthogonally and $\dim\mathfrak c=\dim\mathfrak z(x)-1$. Writing $x$ in normal form with distinct singular values of multiplicities $m_1,\dots,m_s$ and $k=\dim\ker x$,

$$\mathfrak z(x)=\bigoplus_{j}\mathfrak u(m_j)\ \oplus\ \mathfrak{so}(k),\qquad \dim\mathfrak z(x)=\sum_j m_j^2+\binom k2 .$$

(No mixed $\mathrm{im}\,x\wedge\ker x$ term survives: for $u$ in that part, $[x,u]\vert_{\ker x}=x\,u\vert_{\ker x}$ with $x$ invertible on its image, so $[x,u]=0$ forces $u=0$.) Hence

$$\mathfrak c=0\iff \sum_j m_j^2+\binom k2=1\iff s=1,\ m_1=1,\ k\le1\iff m\in\{2,3\}\ \text{with}\ \operatorname{rank}x=2 .$$

At $m=2$ that is every nonzero $x$, and there $\mathfrak c=0$, $\mathfrak z(\mathfrak c)=\mathfrak{so}(2)=\mathbb Rx$ and $\mathfrak c^\perp=\mathfrak{so}(2)$, so $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, **the conclusion holds**. At $m=3$ it fails, as recorded.

> **So $m\ne3$ is sharp and $\mathfrak c\ne0$ is strictly stronger than needed**, being equivalent to $m\ge4$. This matches [L81](../findings/isotropy-cap.md)'s own correction notice (*"the criterion holds at $m=2$ as well, so the $m\ge4$ form is conservative by that one case"*), reached here independently from the dimension formula rather than from that notice.

**What the consumers need.** The one live consumer is [L33](../findings/stratum-two-negative.md)'s proof, which applies L32 at $x$ a minority-side eigenvector of $W\in\mathrm{Weyl}_m$. $\mathcal W_m=0$ for $m\le3$, so the consumer sits at $m\ge4$ and **all three forms are adequate there**. §10 checks the discharge.

**A note on positivity of $a$.** The proof takes $a=(a_1,\dots,a_p)$ to be the singular values, hence $a_i>0$, which is what makes *"$a\propto(1,1)$"* the only $p=2$ case rather than $a\propto(1,-1)$ as well. Achieving all $a_i>0$ needs the freedom to reverse one coordinate of a $2$-block, which is an $O(m)$ and not an $SO(m)$ move. The statement is $O(m)$-invariant, so this is legitimate; the block never says it, and a reader who insists on $SO$ normal form will see a second $p=2$ case and reach the same $\mathfrak{su}(2)$.

## 2. The chain $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$, derived

Let $x$ be nondegenerate, $m=2p$, and let $\mathfrak t=\operatorname{span}(\varphi_{12},\varphi_{34},\dots,\varphi_{2p-1,2p})$ in a frame putting $x=\sum_i a_i\varphi_{2i-1,2i}$.

1. $\mathfrak t$ is abelian and $x\in\mathfrak t$, so $[\mathfrak t,x]=0$, i.e. $\mathfrak t\subseteq\mathfrak z(x)$.
2. Intersecting with $x^\perp$: $\mathfrak t\cap x^\perp\subseteq\mathfrak z(x)\cap x^\perp=\mathfrak c$.
3. The $\varphi_{2i-1,2i}$ are orthonormal, so under $\mathfrak t\cong\mathbb R^p$ the element $x$ corresponds to $a$ and $\mathfrak t\cap x^\perp$ to $a^\perp\subset\mathbb R^p$, of dimension $p-1$.

**CONFIRMED.** Nothing in this step uses nondegeneracy beyond the choice of $\mathfrak t$: at any $x$, a maximal torus containing $x$ works, with $p=\lfloor m/2\rfloor$. That observation is what §8 turns on.

## 3. $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$, derived

The inclusion is inclusion-reversal of the centraliser: $a^\perp\subseteq\mathfrak c$ from §2, so anything commuting with all of $\mathfrak c$ commutes with all of $a^\perp$. **CONFIRMED.**

The equality is the root-space computation. $\mathfrak t$ is a Cartan subalgebra of $\mathfrak{so}(2p)$; in $\mathfrak{so}(2p)\otimes\mathbb C$ write $u=h_0+\sum_\beta u_\beta$. For $h\in a^\perp\subseteq\mathfrak t$, $[h,h_0]=0$ and $[h,u_\beta]=\beta(h)u_\beta$, and the root spaces are independent, so $[h,u]=0$ for every $h\in a^\perp$ iff $\beta$ annihilates $a^\perp$ whenever $u_\beta\ne0$. Under the identification of $\mathfrak t^*$ with $\mathbb R^p$ by the inner product, $\beta$ annihilates $a^\perp$ iff $\beta\in(a^\perp)^\perp=\mathbb Ra$. **CONFIRMED.**

> **One unstated import.** The displayed line is an identity in the complexification, taken back to real points without comment. It is harmless, the real form of $\mathfrak g_\beta\oplus\mathfrak g_{-\beta}$ is a real $2$-plane and the conclusion is a dimension statement, but the block writes $\mathfrak g_\beta$ inside a real Lie algebra with no complexification named, and *"$\mathfrak t$ is a Cartan subalgebra"* is never asserted either. This is the block's one imported theorem and its hypotheses are checked nowhere in it.

The last step of the nondegenerate branch, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx$: from $a^\perp\subseteq\mathfrak c$ we get $\mathfrak c^\perp\subseteq(a^\perp)^\perp$, and inside $\mathfrak t$ the vectors orthogonal to $a^\perp$ are $\mathbb Ra=\mathbb Rx$. **CONFIRMED.**

## 4. What is missing at the end of the nondegenerate branch, claim 14

The proof produces $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathbb Rx$ and stops. The statement asserts **equality**. The reverse inclusion is immediate, $x$ commutes with every element of $\mathfrak z(x)\supseteq\mathfrak c$ by the definition of $\mathfrak z(x)$, and $x\perp\mathfrak c$ because $\mathfrak c\subseteq x^\perp$, but it is one line that is not on file, in a block whose entire content is an equality. **Recorded as an omission, not a defect.**

## 5. $p=2$: the complex-structure case and its $\mathfrak{su}(2)$

Take $m=4$, $x=\varphi_{12}+\varphi_{34}$ up to scale, so $a\propto(1,1)$.

**The roots.** $D_2$ has the four roots $\pm e_1\pm e_2$, none with a zero coordinate, the block's sentence is correct here. Of them exactly $\pm(e_1+e_2)$ are proportional to $a$, so $\mathfrak z(a^\perp)=\mathfrak t\oplus\mathfrak g_{e_1+e_2}\oplus\mathfrak g_{-(e_1+e_2)}$, of real dimension $4$. Intersecting with $(a^\perp)^\perp$ removes the line $a^\perp=\mathbb R(\varphi_{12}-\varphi_{34})$ and leaves **dimension $3$**.

**The actual value.** $\mathfrak{so}(4)=\Lambda^2_+\oplus\Lambda^2_-$ as commuting ideals, each $\cong\mathfrak{su}(2)$, and $x\in\Lambda^2_+$. Hence
$$\mathfrak z(x)=\Lambda^2_-\oplus\mathfrak z_{\Lambda^2_+}(x)=\Lambda^2_-\oplus\mathbb Rx=\mathfrak u(2),\qquad \mathfrak c=\Lambda^2_-,$$
$$\mathfrak z(\mathfrak c)=\mathfrak z(\Lambda^2_-)=\Lambda^2_+\quad(\text{the centre of }\mathfrak{su}(2)\text{ is }0),\qquad \mathfrak c^\perp=\Lambda^2_+,$$
so $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\Lambda^2_+\cong\mathfrak{su}(2)$, of dimension $3$. **The block's conclusion is exactly right, and the upper bound is attained.**

> **The block proves only the upper bound.** Its words are *"$a\propto(1,1)$ is admissible, exactly the complex-structure case"*, which establishes that the root-space method fails to force $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$. It never computes that the answer **is** $3$-dimensional, and never identifies the algebra as $\mathfrak{su}(2)$ rather than, say, $\mathbb R^3$ or $\mathfrak{sl}_2(\mathbb R)$. The statement asserts both. **GAP, of exactly the size of the display above.**

**$p=1$ is in neither branch.** The case split is *"For $p\ge3$"* and *"For $p=2$"*. At $p=1$ ($m=2$, nondegenerate) the argument as written says nothing: $D_1$ has no roots at all, so the sentence *"every root of $D_p$ is $\pm e_i\pm e_j$"* is vacuously true and $a^\perp=0$, giving $\mathfrak z(a^\perp)=\mathfrak{so}(2)$, which happens to be $\mathbb Rx$, so the conclusion holds by accident of dimension. **This is verbatim the defect [L81](../findings/isotropy-cap.md) was repaired for** (*"the proof splits on $p\ge3$ and $p=2$ and never treats $p=1$"*), sitting uncorrected in the block that L81's own entry says supersedes it.

## 6. Even $m$, and why that is not the defect it looks like, claim 7

**The brief's step**: *"the main branch is written for even $m$ and never says so."* The first half is true and the second half is true, but **there is no error**: a skew matrix of odd size is singular, so *"nondegenerate $x$"* (the branch's stated hypothesis), already forces $m$ even, and $p=m/2$ is well defined. Adding *"$m$ even"* would be adding a consequence, not a hypothesis.

**The real cost is structural.** Because nondegeneracy forces $m$ even, **every odd $m$, at every rank, falls into the degenerate branch**, which is one sentence. The block advertises a general statement and gives a proof whose developed half is empty at half the dimensions. That is the honest form of the criticism, and §8 is where it bites.

**And the $D_p$ sentence does not travel.** The degenerate branch says *"the same argument runs inside the support"*. Inside the support the algebra is $\mathfrak{so}(2r)$ and $D_r$ is right; but the *charitable* reading in which the roots are re-run in $\mathfrak{so}(m)$ itself with $a$ padded needs $B_p$ at odd $m$, and **every root of $B_p$** is $\pm e_i\pm e_j$ **or** $\pm e_i$, the short ones carrying $p-1$ zero coordinates. The block's sentence names only $D_p$.

## 7. The corank ladder, in closed form

Write $V=\mathrm{im}\,x$ ($\dim 2r$), $K=\ker x$ ($\dim k$), so $\mathfrak{so}(m)=\mathfrak{so}(V)\oplus\mathfrak{so}(K)\oplus(V\wedge K)$ and, by §1, $\mathfrak c=\mathfrak c_V\oplus\mathfrak{so}(K)$ with $\mathfrak c_V=\mathfrak z_{\mathfrak{so}(V)}(x)\cap x^{\perp}$.

| $k=\dim\ker x$ | what the written branch delivers |
| --- | --- |
| $0$ | the main branch, $m$ even. **Complete for $p\ge2$**, silent at $p=1$ |
| $1$ | $\mathfrak{so}(K)=\mathfrak{so}(1)=0$, so the clause *"additionally centralising $\mathfrak{so}(\ker x)$"* **says nothing** |
| $2$ | $\mathfrak{so}(K)=\mathbb R\varphi$ is one dimensional and abelian. It is in $\mathfrak c$, hence killed by $\cap\,\mathfrak c^\perp$, and it kills the mixed part $V\wedge K$ because a rotation of a $2$-plane fixes no nonzero vector of it. **The clause works** |
| $\ge3$ | $\mathfrak z_{\mathfrak{so}(m)}(\mathfrak{so}(K))=\mathfrak{so}(V)$, the centre of $\mathfrak{so}(k)$ is trivial for $k\ge3$, and $V\otimes K$ has no $\mathfrak{so}(K)$-invariant. **The clause works**, and reduces cleanly to the support |

So the written degenerate branch covers $k\ge2$ and is empty at $k=1$. **The prior finding at [stratum-two-negative.md:161](../findings/stratum-two-negative.md) is CONFIRMED on this half.**

## 8. The corank-$1$ diagnosis, the prior finding's stated reason is REFUTED

**The prior finding says**, in [stratum-two-negative.md:161](../findings/stratum-two-negative.md):

> *the charitable reading, re-running the roots with $a$ padded by zeros, fails the other way, since at odd $m$ the algebra is $B_p$ and "every root of $D_p$ has $p-2$ zero coordinates" is false, the centraliser of $x=\varphi_{12}\in\mathfrak{so}(5)$ has dimension $4$ where the containment allows $2$. **Corank $1$ is exactly the generic odd-$m$ case** … a concrete instance is $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ at $m=7$.*

**1. Locate it.** The two clauses are joined but describe different objects. *"$a$ padded by zeros"* is the general degenerate case. **At corank $1$ there is no padding**: $m=2p+1$ odd and $\operatorname{rank}x=m-1=2p$, so the singular-value vector fills the whole of $\mathbb R^p=\mathfrak t$ and has **no zero coordinate**. And $x=\varphi_{12}\in\mathfrak{so}(5)$ has $\dim\ker x=3$, not $1$; it is a corank-$3$ example, imported from [L81](../findings/isotropy-cap.md)'s correction notice (c), where it is correctly deployed against the *degenerate padded* reading.

**2. Exhibit the failure concretely**, on the finding's own named instance. Take $m=7$, $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$, so $k=1$, $p=3$, $a=(1,2,3)$. Then $\mathfrak t=\operatorname{span}(\varphi_{12},\varphi_{34},\varphi_{56})$ is a maximal torus of $\mathfrak{so}(7)$ containing $x$, and §2 gives $a^\perp\subseteq\mathfrak c$ unchanged. The roots of $B_3$ are the twelve $\pm e_i\pm e_j$ and the six $\pm e_i$; **the first have one zero coordinate and the second have two, while $a$ has none**, so no root is proportional to $a$ and §3 gives $\mathfrak z(a^\perp)=\mathfrak t$. Hence
$$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx .$$
Independently, by §1, $\mathfrak z(x)=\mathfrak u(1)^3\oplus\mathfrak{so}(1)=\mathfrak t$, $\mathfrak c=a^\perp$ and $\mathfrak z(\mathfrak c)=\mathfrak t$, giving $\mathbb Rx$ on the nose. **The short roots of $B_p$ are not an obstruction at corank $1$; they are ruled out by the same sentence that rules out the long ones, and more easily.**

**3. Argue the opposite.** The most charitable reading the words support is that the finding meant the *general* degenerate case, where $a$ genuinely is padded and short roots genuinely do become proportional to it, at $x=\varphi_{12}\in\mathfrak{so}(5)$, $a=(1,0)\propto e_1$, $a^\perp=\mathbb R\varphi_{34}$ and $\mathfrak z(a^\perp)=\mathfrak{so}(2)_{34}\oplus\mathfrak{so}(3)_{125}$ has dimension $4$ where $\mathfrak t$ has $2$. **That reading is correct**, and it is L81's. But it is a statement about corank $\ge2$, where the $\mathfrak{so}(\ker x)$ clause does apply; the finding attaches it to corank $1$, where it does not arise, and names a corank-$1$ instance on which it visibly does not arise. **The charitable reading rescues the sentence only by detaching it from the case it is filed under.**

**What survives, and what does not.** The corank-$1$ range breaks up as
- $p\ge3$ (so $m\ge7$ odd): no $B_p$ root is proportional to an all-nonzero $a$, and the chain closes at $\mathbb Rx$;
- $p=2$ ($m=5$): $a\propto(1,1)$ is the only proportionality, and $x=\varphi_{12}+\varphi_{34}$ **is** a multiple of a complex structure on a $4$-plane, with $\mathfrak c=\Lambda^2_-$, $\mathfrak z(\mathfrak c)=\Lambda^2_+$ (the mixed part $V\wedge K\cong V$ carries no $\mathfrak{su}(2)$-invariant) and the answer $\mathfrak{su}(2)$, the exception, correctly triggered;
- $p=1$ ($m=3$): $a\propto e_1$, a **short** root, $a^\perp=0$, $\mathfrak z(0)=\mathfrak{so}(3)$, the known failure.

> **THIS IS NAMED, NOT SUPPLIED.** The above is an audit of what the written sentence would give once *"$D_p$"* is read as *"$B_p$"* and *"$p-2$ zero coordinates"* as *"at least $p-2$"*. **That substitution is not on the record and this verifier does not put it there.** The debt owed by L32 at corank $1$ is therefore *smaller and more specific* than [stratum-two-negative.md:163](../findings/stratum-two-negative.md) records (it is a wrong root system named in one sentence, not a missing argument) but it is still a debt, and the repair round owns it. What must additionally be proved for the *general* degenerate case, and is on file nowhere, is that the mixed part $V\wedge K$ contributes nothing to $\mathfrak z(\mathfrak c)$ when $k=1$; the $k\ge2$ cases discharge it through $\mathfrak{so}(K)$, and $k=1$ has no such handle. **That is the sentence a repair must write.**

## 9. The exception clause, neither too wide nor too narrow

The clause is *"except when $x$ is a multiple of a complex structure on a $4$-dimensional subspace"*, i.e. $\operatorname{rank}x=4$ with the two singular values equal. Checked in closed form, each case computed from §1's decomposition:

| $x$ | $\mathfrak c$ | $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ | clause |
| --- | --- | --- | --- |
| $m=4$, $a_1\varphi_{12}+a_2\varphi_{34}$, $a_1\ne a_2$ | $\mathbb R(a_2\varphi_{12}-a_1\varphi_{34})$ | $\mathfrak t\cap\mathfrak c^\perp=\mathbb Rx$ | correctly **not** excepted |
| $m=4$, $\varphi_{12}+\varphi_{34}$ | $\Lambda^2_-$ | $\Lambda^2_+\cong\mathfrak{su}(2)$, $\dim 3$ | correctly excepted |
| $m=4$, $\varphi_{12}$ (rank $2$) | $\mathbb R\varphi_{34}$ | $\mathfrak t\cap\mathfrak c^\perp=\mathbb Rx$ | correctly **not** excepted |
| $m\ge5$, $\varphi_{12}$ (rank $2$, $k=m-2\ge3$) | $\mathfrak{so}(K)$ | $\mathfrak{so}(V)\cap\mathfrak c^\perp=\mathbb Rx$ | correctly **not** excepted |
| $m=5$, $\varphi_{12}+\varphi_{34}$ (corank $1$) | $\Lambda^2_-(V)$ | $\Lambda^2_+(V)$, $\dim 3$ | correctly excepted |
| $m=6$, $\varphi_{12}+\varphi_{34}$ (corank $2$) | $\Lambda^2_-(V)\oplus\mathfrak{so}(K)$ | $\Lambda^2_+(V)$, $\dim 3$ | correctly excepted |
| $m=6$, $\varphi_{12}+\varphi_{34}+\varphi_{56}$, a complex structure on **six** dimensions | $\mathfrak{su}(3)$ | $\mathbb Rx$, $\mathfrak{so}(6)/\mathfrak u(3)\cong\overline{\mathbb C^3}$ has no $\mathfrak{su}(3)$-invariant | correctly **not** excepted: *"$4$-dimensional"* is load-bearing |
| $m=8$, $a=(1,1,2,2)$ | $\mathfrak{su}(2)^{\oplus2}\oplus\mathbb R(2J_1-J_2)$ | $\mathbb R(J_1+2J_2)=\mathbb Rx$ | correctly **not** excepted: two equal *pairs* are not a rank-$4$ structure |

**Not too narrow.** A candidate for a missed exception would need $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)\ge2$ at some $x$ of rank $\ne4$ or with unequal singular values. The smallest place to look is where $\mathfrak c$ itself is smallest: $\dim\mathfrak c=1$ forces $\sum_jm_j^2+\binom k2=2$, hence $m\le5$, and the three configurations that realises are all in the table above and all return $\mathbb Rx$. **Not too wide.** Every rank-$4$-equal $x$ returns $3$ at every corank, uniformly: $\mathfrak c=\Lambda^2_-(P)\oplus\mathfrak{so}(K)$; $\Lambda^2_-(P)\cong\mathfrak{su}(2)$ acts on $P\cong\mathbb H$ with no fixed vector, so the mixed part $P\wedge K$ dies for **every** $k\ge1$; $\mathfrak{so}(K)$ lies in $\mathfrak c$ and is removed by $\cap\,\mathfrak c^\perp$; and $\Lambda^2_+(P)$ survives.

> **A curiosity worth the record.** At $m=3$ the answer is $\mathfrak{so}(3)$, which **is** a $3$-dimensional $\mathfrak{su}(2)$. So the $m=3$ witness refutes the exception's *trigger*, not its *value*: the dimension count $\{1,3\}$ of [L81](../findings/isotropy-cap.md)'s criterion survives at $m=3$ intact, and only the characterisation *"rank-$4$ complex structure"* breaks. That is why the failure was easy to miss.

**The cited evidence, and what it covers.** *"Gate 2 passed … at all $29$ multiplicity partitions to $m=12$"*. The record does not say what the $29$ are. $\sum_{p=1}^{6}P(p)=1+2+3+5+7+11=29$ exactly, which is the number of multiplicity patterns of a **nondegenerate** $x$ at **even** $m\le12$. **Under that reading (an inference from the count, and labelled as one), the sweep covered precisely the branch that already has a proof, and no odd $m$ and no $\ker x\ne0$ at all.** It is in any case an open hypothesis and not evidence for the sketch, as [ELIM-canon W7](../reviews/ELIM-canon.md) already says.

## 10. The scope paragraph, claims 11 and 12

> *"The criterion is the singular-value vector being proportional to a root of $D_p$, which is rank $4$ with equal singular values (so **nondegeneracy is sufficient and not necessary at $m\ge6$**), the qualifier was missing and the claim is false at $m=4,5$"*

**The $D_p$ half.** A root of $D_p$ has exactly two nonzero coordinates, of equal magnitude; with $a_i\ge0$ that means $a$ has exactly two nonzero entries and they are equal, i.e. rank $4$ with equal singular values. **CONFIRMED at even $m$.** At odd $m$ the criterion is incomplete for the same reason as the proof: $a\propto$ a **short** root of $B_p$ means $a$ has exactly one nonzero entry, i.e. $\operatorname{rank}x=2$, a second configuration on which the method is inconclusive, and one which produces **no exception** (row 4 of §9's table). So the paragraph's *"criterion"* is a criterion for the exception at even $m$, and at odd $m$ it is a criterion for neither the exception nor the method's success without the short-root case being separated out. **The paragraph is silent where the proof is wrong, and by the same omission.**

**Sufficiency at $m\ge6$.** Nondegenerate at $m\ge6$ forces $m$ even and $p\ge3$, so $a$ has $p\ge3$ nonzero coordinates and no $D_p$ root is proportional to it. **CONFIRMED.** Not necessary: rank $2$ at $m\ge5$, and $a=(1,1,2,2)$ at $m=8$, are degenerate-or-not cases outside the exception. **CONFIRMED.**

**"False at $m=4,5$."** At $m=4$: $x=\varphi_{12}+\varphi_{34}$ is nondegenerate and **is** the exception, so sufficiency genuinely fails. **CONFIRMED.** At $m=5$: under the record's own reading of nondegenerate ($\ker x=0$, which is what the *"For degenerate $x$"* branch complements), **no nondegenerate $x$ exists in $\mathfrak{so}(5)$ at all**, so *"nondegeneracy is sufficient"* is vacuously true there and the paragraph's *"false at $m=4,5$"* is false at $m=5$. It becomes true only under a second, undefined reading of nondegenerate as *maximal rank*, under which $x=\varphi_{12}+\varphi_{34}\in\mathfrak{so}(5)$ is the counterexample. **The record defines "nondegenerate" nowhere**, and the two readings differ exactly at odd $m$, which is the range this whole block gets wrong.

## 11. The consumer at $n\ge12$, checked

The block says: *"The one use on the record, in [stratum-two-negative.md](../findings/stratum-two-negative.md), is at $n\ge12$ where the hypothesis is expected to hold, **expected, and not yet checked there**."*

**It is checked, and the hedge is unnecessary.** The use is inside [L33](../findings/stratum-two-negative.md)'s proof, at $x$ a minority-side eigenvector of $W\in\mathrm{Weyl}_m$. Since $\mathcal W_m=0$ for $m\le3$, any $W\ne0$ forces $m\ge4$, and §1 gives $\mathfrak c\ne0$ at every $m\ge4$, **unconditionally, with no reference to $n\ge12$ at all**. The consumer's file records the same conclusion twice, and [LEDGER.md:247](../findings/LEDGER.md) a third time. **The isotropy-cap.md parenthetical is stale and should be deleted or rewritten to say the hypothesis is discharged for every $\mathrm{Weyl}$ consumer.**

**Two flaws inside the discharge as written, neither fatal.**

1. The box at [stratum-two-negative.md:167](../findings/stratum-two-negative.md) still reads *"$\mathfrak z(x)$ contains the torus spanned by $x$'s own $2$-blocks, so $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$"*. The **conclusion** is true, every $x$ lies in some maximal torus, and maximal tori of $\mathfrak{so}(n)$ have dimension $\lfloor n/2\rfloor$, but **the stated reason does not give it**: the torus spanned by $x$'s *own* blocks has dimension $r=\tfrac12\operatorname{rank}x$, which is $1$ at $x=\varphi_{12}\in\mathfrak{so}(6)$. The same file says so eleven lines above, and **the refuted box was left standing verbatim beneath the correction**. A reader arriving at line 167 reads the refuted argument.
2. The correction that replaces it asserts $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$ and gives **no reason either**. The reason is one line ($x$ lies in a maximal torus of dimension $\lfloor m/2\rfloor$, which centralises it) and it is on file nowhere. Naming it is all this verifier does with it.

## 12. Withdrawn candidates

- **"The main branch illegitimately assumes $m$ even."** *Withdrawn at protocol step 2.* No failure can be exhibited: nondegeneracy forces $m$ even, so $p=m/2$ is well defined wherever the branch speaks. What survives is the structural point in §6, recorded there instead.
- **"The $p=2$ branch misses $a\propto(1,-1)$."** *Withdrawn at protocol step 3.* The most charitable reading is the correct one: singular values are non-negative, so $a\propto(1,-1)$ does not occur in the block's own normal form, and the anti-self-dual case is reached by reversing one coordinate, an $O(m)$ move under which the statement is invariant. Recorded as an unstated normalisation in §1 instead of a defect.
- **"$\mathfrak c\ne0$ is the wrong hypothesis and the landscape entry is broken."** *Withdrawn at protocol step 2.* No $x$ satisfying $\mathfrak c\ne0$ falsifies the conclusion; the entry is sound, merely conservative by the single case $m=2$. Recorded as claim 3, verdict SOUND BUT NOT SHARP.
- **"The root-space identity is wrong because $\mathfrak{so}(m)$ is a real form."** *Withdrawn at protocol step 2.* The real points of $\mathfrak t_{\mathbb C}\oplus\bigoplus_{\beta\propto a}\mathfrak g_\beta$ have the dimension the argument uses, at $p=2$ giving exactly the $4$ that §5's direct computation confirms. Recorded as an unstated import in §3.

## 13. What would falsify the surviving statement, and where I looked

**The object.** A nonzero $x\in\mathfrak{so}(m)$, $m\ne3$, which is **not** a multiple of a complex structure on a $4$-plane and for which $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)\ge2$; or, on the other side, a multiple of a $4$-plane complex structure for which that space is not a $3$-dimensional $\mathfrak{su}(2)$.

**Where I looked, by hand and in closed form.** The dimension identity $\dim\mathfrak z(x)=\sum_jm_j^2+\binom k2$ localises the search: a falsifier of the first kind needs $\mathfrak z(\mathfrak c)$ to exceed $\mathbb Rx$, which the root computation forbids unless some root of $B_p$ or $D_p$ is proportional to the padded $a$, so the candidates are exactly (i) $a$ with two equal nonzero entries, which is the exception itself, (ii) $a$ with one nonzero entry, i.e. $\operatorname{rank}x=2$, and (iii) $p\le2$. I checked (ii) at $m=4$ and at $m\ge5$ separately, and (iii) at $m=2,3,4,5$, together with the corank ladder $k=0,1,2,\ge3$ and the patterns $(1)$, $(1,1)$, $(2)$, $(1,1,1)$, $(3)$, $(2,2)$, every one is in §7 or §9. **The only falsifier is $m=3$, which the surviving hypothesis excludes.** No sweep was run, no partition census was repeated, and this paragraph is a report of reasoning, not of search.

## Verdict

**`GAP`.**

The statement, in [results.md:467](../results.md)'s form with $m\ne3$, is **true and its hypothesis is sharp**; the exception clause is **exact**. The proof on file does not reach it. What is missing, in the order a repair should take it:

1. **The $D_p$ sentence is wrong at odd $m$**, where the algebra is $B_p$. One word, plus *"at least $p-2$ zero coordinates"*. This is the single sentence standing between the block and the whole corank-$1$ range, **the debt is smaller than [stratum-two-negative.md:163](../findings/stratum-two-negative.md) records, and its diagnosis there is refuted** (§8).
2. **$p=1$ is in neither branch**, the defect [L81](../findings/isotropy-cap.md) was already repaired for (§5).
3. **The $\mathfrak{su}(2)$ value is never derived**, only its dimension bounded above (§5).
4. **The degenerate branch's clause is vacuous at $\dim\ker x=1$** and the mixed-part step it needs there is on file nowhere (§7, §8), `HYPOTHESIS-DEBT`, **named and deliberately not supplied**.
5. **The canonical Statement line still carries no hypothesis at all** and is refuted as it stands (§1).
6. **The reverse inclusion is never stated** (§4), and *"expected, and not yet checked"* at the consumer is **stale** (§11).
