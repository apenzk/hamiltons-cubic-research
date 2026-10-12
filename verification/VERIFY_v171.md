# Verifier v171, Lemma L11, the two-block sphere products and which of them are Morse–Bott degenerate

I read [BRIEF_L11.md](BRIEF_L11.md) first and then the sources it names, cold from the definitions: [L26](../findings/nondegeneracy.md) at [nondegeneracy.md](../findings/nondegeneracy.md) line 78, [L27](../findings/nondegeneracy.md) at line 457, the L11 block at lines 434–452 with its trailing prose at 442–454, and [L24](../findings/second-order.md), [L121](../findings/second-order.md), [L126](../findings/second-order.md), [L127](../findings/second-order.md) and [L128](../findings/second-order.md) in [second-order.md](../findings/second-order.md). **No numerical work was done.** Every value below is exact rational arithmetic carried out by hand on objects the record already prints; the 36-split sweep and the eight exact-arithmetic splits were neither repeated nor extended, and nothing in this report cites them as evidence for a positive claim. Log: [agent_logs/verify-L11-v171.log](../agent_logs/verify-L11-v171.log).

## The claim table

| # | Claim, as the record states it | Verdict |
| --- | --- | --- |
| 1 | $\mu=\frac{n-2}{2(p-1)(q-1)}$ and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ with $n=p+q$ | **PROVEN**, an identity, rederived below |
| 2 | $\mu<\tfrac12$ exactly when $(p-2)(q-2)>1$; among $p,q\ge2$ this fails only at $\min(p,q)=2$ and at $(3,3)$ | **PROVEN** |
| 3 | The two failures are different: $\mu=\tfrac12$ at $(3,3)$, $\mu>\tfrac12$ at $\min(p,q)=2$ | **PROVEN** |
| 4 | *Paragraph B*: "$\mu$ **reaches** $\tfrac12$ at $p=2$ … which is degeneracy" | **BROKEN**, it reads L26's $\mu\ge\tfrac12$ criterion as $\mu=\tfrac12$; witness at $(2,2)$ below |
| 5 | *Paragraph A*: at $p=2$, $\mu>\tfrac12$ costs **maximality**, not nondegeneracy | **PROVEN**, L24 plus the kernel-is-an-eigenspace step of L128(ii) |
| 6 | Canonical statement, [results.md](../results.md) line 393: "degenerate at $\min(p,q)=2$ and at $(3,3)$" | **BROKEN**, same misreading, and contradicted by the record's own $(2,2)$ spectrum |
| 7 | "The single degenerate case is $(3,3)$", read over $p,q\ge2$ at $n=p+q$ | **HYPOTHESIS-DEBT**, nondegeneracy at $p=2$ has no argument on file; the only two citations are circular |
| 8 | "The single degenerate case is $(3,3)$", read without a padding scope | **BROKEN**, padded $S^2\times S^q$ is degenerate, by [L126](../findings/second-order.md) line 729 |
| 9 | The $S^2\times S^4$ spectrum $1,\tfrac12,0,\tfrac13,\pm\tfrac23$ with $\tfrac12$ at multiplicity $pq=8$ | **PROVEN, hypotheses corrected**: right as a value list, but only after the one repair the block omits; it does not settle the dispute |
| 10 | $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ "is true and computes nothing" | **PROVEN**, and the dimension coincidence is not even unique to $(3,3)$ |
| 11 | The same isomorphism as *the mechanism*, trailing prose line 444 | **BROKEN**, false under $O(3)\times O(3)$, which is the group L27 uses |
| 12 | $(3,3)$: kernel $18$ against an orbit of $9$ | **PROVEN**, and attributable block-by-block without the isomorphism |
| 13 | "Verified at all 36 splits up to $n=14$", with $S^7\times S^7$ resting on floating point | **GAP**, the sentence's own last clause withdraws part of it; and the sweep's $k,l\ge2$ range exceeds the proof's $p,q\ge3$ |
| 14 | $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$ and $\theta>0$ | **GAP**, used throughout the L11 block, cited nowhere in it |
| 15 | The value-localised survival of the intended use, "by fiat" | **HYPOTHESIS-DEBT**, "every *known* exception" is a census, not a bound |
| 16 | Morse–Bott nondegeneracy as a definition | **GAP**, absent from [conventions.md](../findings/conventions.md); it is stated inline in two files |

## One line

**The corrected paragraph wins the dispute on the inference and loses on the scope: $\mu>\tfrac12$ at $p=2$ is non-maximality and not degeneracy, but "the single degenerate case is $(3,3)$" has no proof at $p=2$ and is outright false for padded $S^2\times S^q$, where the record's own recorded excess $q(n-n_0)$ is exactly the number of four-set blocks the padding puts at $\tfrac12$.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $B$: "$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$ and $Bu=z\circ z$ along an orbit. **$B\succeq0$ is only ever readable on $W^\perp$**, since $L_WW=\theta W$ gives $BW=-\tfrac\theta2W$ at every $\theta>0$."
- $\mu$: "**$\mu$ CARRIES TWO MEANINGS THIRTY LINES APART IN [bispectral.md](../findings/bispectral.md), AND A THIRD IN [target.md](../findings/target.md).**"
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.**"

**Morse–Bott nondegeneracy is not in that file.** The record's only definitions of it are inline: [L128](../findings/second-order.md)(ii), "$W$ is Morse–Bott nondegenerate, $\ker\mathrm{Hess}(P|_S)_W=T_W\mathcal O$,", and the L11 block's own "the Hessian kernel is exactly the orbit tangent, of dimension $pq$". They agree; the gap is that a load-bearing definition sits in the results rather than in the conventions file whose stated purpose is to hold it.

## 1. Hypothesis inventory

**What the L11 block needs.**

| ingredient | where it is stated | hypotheses it carries | does the L11 block check them? |
| --- | --- | --- | --- |
| $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, so $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$ | [L24](../findings/second-order.md), used via [L128](../findings/second-order.md)(ii) | $\theta\ne0$; at a **critical** point; the $\le\tfrac12$ direction needs a **local maximiser** | **No**, the block never cites L24, and every one of its inferences runs through this identity |
| $\mu$ in closed form | [L26](../findings/nondegeneracy.md) | $n=p+q$, $p,q\ge2$; a coordinate $2$-plane in each block | Partly: the block quotes $\mu$ and the criterion but never restates $n=p+q$ |
| $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained on the orbit tangent alone | [L27](../findings/nondegeneracy.md) | **$p,q\ge3$ and $(p,q)\ne(3,3)$**, explicitly, because "at $q\le2$ **the decomposition itself is false**" | **No**, the block applies L27's summand list at $(2,4)$ |
| the ten-summand $O(p)\times O(q)$ decomposition, multiplicity-free | Nienhaus Prop. 4.6, for $p,q\ge5$; plus exact commutant computation at $m=3,4$ inside L27 | irreducibility of each summand at the given $p,q$ | **No source at all at $m=2$** |
| orbit tangent $=\mathbb R^p\otimes\mathbb R^q$, $\dim=pq$ | Nienhaus, cited in L27 and in the trailing prose | stabiliser $S(O(p)\times O(q))$ | Arithmetic checked below; the identification is imported |
| $\ker\mathrm{Hess}=T_W\mathcal O\Rightarrow$ the orbit is isolated | [L128](../findings/second-order.md)(iii) | pure (frame-diagonal) critical point, unit norm, $\theta>0$, one fixed eigenframe | The trailing prose asserts isolation; L128 says outright that this "[Lemma L11](../findings/nondegeneracy.md) asserts without argument" and supplies the proof |

**Which of these the written proof actually uses.** The block's proof paragraph uses exactly two: L26's closed form, and L27's conclusion. Its *statement* paragraph uses a third that its proof paragraph does not (L27's decomposition at $p=2$) and a fourth that it never names, L24's Hessian normalisation. Nienhaus's orbit-tangent identification is used only through L27.

**Orbit dimension, checked at each edge.** $\dim\mathcal O=\binom n2-\binom p2-\binom q2=pq$ identically. At $(3,3)$: $15-3-3=9$. At $(2,4)$: $15-1-6=8$. At $(2,2)$: $6-1-1=4$. At $(1,q)$: $\binom n2-0-\binom q2=n-1=1\cdot q$ formally, but see §4.

## 2. The closed form, and the second display derived from the first

With $n=p+q$ and $p,q\ge2$ the denominator $2(p-1)(q-1)$ is a positive integer, so

$$\tfrac12-\mu=\frac12-\frac{p+q-2}{2(p-1)(q-1)}=\frac{(p-1)(q-1)-(p+q-2)}{2(p-1)(q-1)}=\frac{pq-2p-2q+3}{2(p-1)(q-1)}=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)},$$

since $(p-2)(q-2)=pq-2p-2q+4$. The second display is the first, exactly, and nothing is assumed beyond $p,q\ne1$. **Verdict: PROVEN.**

**Sign.** The denominator is positive throughout $p,q\ge2$, so the sign of $\tfrac12-\mu$ is the sign of $(p-2)(q-2)-1$, an integer. Hence over integers $p,q\ge2$:

| region | $(p-2)(q-2)$ | $\tfrac12-\mu$ | $\mu$ |
| --- | --- | --- | --- |
| $\min(p,q)=2$ | $0$ | $-\frac1{2(p-1)(q-1)}<0$ | **above** $\tfrac12$ |
| $(p,q)=(3,3)$ | $1$ | $0$ | **equal to** $\tfrac12$ |
| $p,q\ge3$, $(p,q)\ne(3,3)$ | $\ge2$ | $>0$ | **below** $\tfrac12$ |

The third row is exhaustive because $(p-2)(q-2)=1$ over non-negative integers forces $p-2=q-2=1$, and $(p-2)(q-2)=0$ forces a factor to vanish, i.e. $\min(p,q)=2$. So "$(p-2)(q-2)>1$ fails exactly at $\min(p,q)=2$ and at $(3,3)$" is correct as stated, and the three-way split the block draws from it is correct. **Verdict: PROVEN.**

**The same law in the record's other coordinates.** $\mu=\tfrac12\iff(p-1)+(q-1)=(p-1)(q-1)\iff\frac1{p-1}+\frac1{q-1}=1$, which is [L126](../findings/second-order.md)'s form, and $(u-1)(v-1)=1$ with $u=p-1,v=q-1$ gives $u=v=2$ alone. The two derivations agree. At $p=2$, $u=1$ forces $\frac1v=0$, impossible, so $\mu=\tfrac12$ is unreachable at $\min(p,q)=2$, which is the whole of the dispute in one line.

**At $p=2$ specifically.** $(p-1)(q-1)=n-3$, so $\mu=\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$, strictly above $\tfrac12$ for every $q\ge2$ (where $n-3\ge1$). The block's arithmetic here is right.

## 3. $p=1$

**The criterion says nothing there, and the record is right to exclude it.** At $p=1$ the denominator $2(p-1)(q-1)$ vanishes and $\mu$ is undefined; L26's construction is also unavailable, since it needs "a coordinate $2$-plane inside the $p$-block" and a $1$-dimensional block has none. The structural reason is on the record and I checked it cold: [L126](../findings/second-order.md) says "$p=1$ is excluded structurally, Ricci-flatness forcing $M\equiv0$ there", and with sectional entries $\alpha$ within the first factor, $\beta$ within the second and $\gamma$ across, Ricci-flatness reads $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$; at $p=1$ the first gives $\gamma=0$ and the second then $\beta=0$, so $M\equiv0$ and there is no critical point to be degenerate at. **The formal orbit count $pq=n-1$ at $p=1$ is therefore about the zero operator and is vacuous.** Neither L11 nor L26 claims anything at $p=1$; recorded as checked and cleared.

## 4. The disputed inference, what $\mu>\tfrac12$ costs

**Located exactly.** Paragraph B of the L11 block ([nondegeneracy.md](../findings/nondegeneracy.md) line 438) says: "[Lemma L26] records that the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$, a direction outside the orbit carrying the orbit's own eigenvalue, which is degeneracy."

**The failure, in closed form.** L26's own statement is "$\mu\ge\tfrac12\iff(p-2)(q-2)\le1$", and its next sentence separates the two cases in the same breath: "the family reaches $\tfrac12$ exactly at $p=2$, where it gives the recorded excess $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, **where it is an equality**." So "reaches $\tfrac12$" in L26 means *meets or passes the threshold*, i.e. $\mu\ge\tfrac12$; the word "excess" in the same clause is what distinguishes $p=2$ from $(3,3)$. Paragraph B quotes the verb and drops the criterion, converting $\mu\ge\tfrac12$ into $\mu=\tfrac12$. Concretely, at $p=2$ the direction $X$ carries $\mu=\tfrac12+\frac1{2(n-3)}$, which is **not** "the orbit's own eigenvalue" $\tfrac12$; the two differ by a positive rational at every $q\ge2$. Paragraph B's own premise refutes its own conclusion.

**What each situation implies.** By L24, $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$ with $\theta>0$. Hence, for a unit $V\perp W$:

- $L_eV=\tfrac12V$ with $V\notin T_W\mathcal O$, the Hessian **kernel** exceeds the orbit tangent: degeneracy.
- $L_eV=\lambda V$ with $\lambda>\tfrac12$, the Hessian is **strictly positive** in the direction $V$: an ascent direction, so $W$ is not a local maximiser. The kernel is untouched, because the kernel is an eigenspace at the single value $\tfrac12$ and $\lambda\ne\tfrac12$.

L128(ii) states exactly this distinction and calls it out as a repair of an earlier version of the same confusion: "the criterion excludes the value $\tfrac12$ rather than bounding the spectrum". **So paragraph A's inference is correct and paragraph B's is not.**

**A witness in closed form, from the record's own printed spectrum.** At $(p,q)=(2,2)$, $n=4$, L26's history paragraph prints the full spectrum: "$(-1)^4,(\tfrac12)^4,1^2$", ten values against $\dim\mathrm{Weyl}_4=10$. Here $\mu_{2,2}=\frac{4-2}{2\cdot1\cdot1}=1$, which [L126](../findings/second-order.md) confirms by name ("$\mu_{2,2}=1$ matches its $(2,2)$ spectrum"). So $\min(p,q)=2$, $\mu=1>\tfrac12$, $\lambda_{\max}(L_e|_{W^\perp})=1$, and $\dim E(\tfrac12)=4=pq=\dim\mathcal O$ exactly. **A $\min(p,q)=2$ point with $\mu$ far above $\tfrac12$ and a kernel equal to the orbit tangent: nondegenerate, and not a maximiser.** That is paragraph A's reading and refutes paragraph B's, on data the record printed before the dispute began.

**The charitable reading of paragraph B, and why it still fails.** The most one can extract is: "at $p=2$ the *bound* $\lambda_{\max}\le\tfrac12$ fails, so the old statement was wrong to call these points unproblematic." That is true and is L126's point, $\mu_{2,q}=\frac q{2(q-1)}>\tfrac12$, "so **no $S^2\times S^q$ is a local maximum**". But paragraph B does not say "not a maximiser", it says "which is degeneracy", and it is the word *degenerate* that propagated into the canonical statement. The charitable reading does not save the sentence that was written.

**Consequence for the canonical statement.** [results.md](../results.md) line 393 reads "degenerate at $\min(p,q)=2$ and at $(3,3)$"; [results.md](../results.md) line 130 and [INDEX-results.md](../findings/INDEX-results.md) line 26 carry the same. All three are the refuted paragraph, and all three contradict the $(2,2)$ spectrum in [nondegeneracy.md](../findings/nondegeneracy.md) itself. **The correction of 2026-09-04 was made in one file and propagated to none.**

## 5. The $S^2\times S^4$ spectrum, rebuilt cold

The block offers "$1,\tfrac12,0,\tfrac13,\pm\tfrac23$, with $\tfrac12$ at multiplicity $pq=8$" as positive evidence for nondegeneracy at $p=2$. It is read off [L27](../findings/nondegeneracy.md)'s ten-summand list, the list whose own statement says that "at $q\le2$ **the decomposition itself is false**, the ten dimensions over-counting by $2$ at $q=2$". So the block quotes a decomposition at the one place its source declares invalid. I rebuilt the list at $(p,q)=(2,4)$, $n=6$, in exact arithmetic by hand, using $\dim\mathrm{Weyl}_n=\frac{n(n-3)(n+1)(n+2)}{12}$, $\dim X_m=\frac{m(m^2-4)}3$, $\lambda_m=\frac{m-2}{2(m-1)}$ and $\mu_{2,4}=\frac{4}{2\cdot1\cdot3}=\tfrac23$:

| summand | $\dim$ at $(2,4)$ | $L_e$ value |
| --- | --- | --- |
| $\langle W\rangle$ | $1$ | $1$ |
| $\mathrm{Weyl}_2$ | $0$ (the polynomial gives $-2$) |, |
| $\mathrm{Weyl}_4$ | $10$ | $0$ |
| $\mathbb R^2\otimes\mathbb R^4$ | $8$ | $\tfrac12$ |
| $S^2_0(\mathbb R^2)$ | $2$ | $\lambda_2=0$ |
| $S^2_0(\mathbb R^4)$ | $9$ | $\lambda_4=\tfrac13$ |
| $S^2_0\otimes S^2_0$ | $18$ | $-\mu=-\tfrac23$ |
| $\Lambda^2\otimes\Lambda^2$ | $6$ | $+\mu=\tfrac23$ |
| $X_2\otimes\mathbb R^4$ | $0$ |, |
| $X_4\otimes\mathbb R^2$ | $32$ | $0$ |

The true dimensions sum to $86$ against $\dim\mathrm{Weyl}_6=84$, the record's own figure, printed in [L126](../findings/second-order.md) line 734 and in [Corollary L128.1](../findings/second-order.md) line 809. **The over-count is one whole summand and only one: $S^2_0(\mathbb R^2)$, of dimension exactly $2$, and it is the only summand of that dimension in the table.** Deleting it gives $1+10+8+9+18+6+32=84$ exactly, and the surviving values are $\{1,\tfrac12,0,\tfrac13,\pm\tfrac23\}$ with $\tfrac12$ at multiplicity $8=pq$, the block's list, character for character. The deletion is also the one L27's unconditional trace identity permits: $1\cdot1+8\cdot\tfrac12+9\cdot\tfrac13+6\cdot\tfrac23+18\cdot(-\tfrac23)=1+4+3+4-12=0$, and the deleted summand carried the value $0$, so the trace is unchanged by it.

**The repair is the record's own, stated elsewhere and not here.** [L127](../findings/second-order.md) line 753: "the $\lambda_p$-eigenvector needs $F_1\setminus\{j,k\}$ nonempty, so at $p=2$ the block is entirely $-\mu$ and the stated top $\tfrac{p-2}{2(p-1)}=0$ is **not in the spectrum at all**, at $S^2\times S^4$ it is $(-\tfrac23)^3$ against a printed $0$." That is the $S^2_0(\mathbb R^2)$ summand vanishing, seen from the block side.

**The repair passes an independent closed-form test the record already printed.** Run the same table at $(2,2)$, $n=4$: the ten summands give $\langle W\rangle\,1$ at $1$; $\mathbb R^2\otimes\mathbb R^2\,4$ at $\tfrac12$; $S^2_0(\mathbb R^2)\,2$ at $0$, **twice**; $S^2_0\otimes S^2_0\,4$ at $-\mu=-1$; $\Lambda^2\otimes\Lambda^2\,1$ at $+\mu=1$; the rest $0$-dimensional, $14$ in all against $\dim\mathrm{Weyl}_4=10$, an over-count of $2$ per $2$-block exactly as L27 predicts. Deleting both copies of $S^2_0(\mathbb R^2)$ leaves $10$ dimensions carrying $1^2,(\tfrac12)^4,(-1)^4$, which is **verbatim** the spectrum L26's history paragraph records, "$(-1)^4,(\tfrac12)^4,1^2$", including the non-simplicity of $1$ that paragraph flags. Two independent confirmations of one repair.

**Multiplicity-freeness at $p=2$, checked cold, since L27's source does not cover it.** L27 imports irreducibility from Nienhaus "for $p,q\ge5$" and supplies $m=3,4$ by exact commutant computation; $m=2$ appears nowhere. By inspection of the $O(2)$ factor the surviving summands at $(2,4)$ carry the labels $\mathrm{triv}\boxtimes\mathrm{triv}$, $\mathrm{triv}\boxtimes[2,2]$, $\mathrm{std}\boxtimes[1]$, $\mathrm{triv}\boxtimes[2]$, $S^2_0\boxtimes[2]$, $\det\boxtimes[1,1]$, $\mathrm{std}\boxtimes[2,1]$, pairwise distinct, with $\mathrm{triv},\det,\mathrm{std},S^2_0(\mathbb R^2)$ four pairwise non-isomorphic $O(2)$-irreducibles, each of real type ($\mathrm{End}_{O(2)}=\mathbb R$, since a reflection conjugates the rotation generator $J$ to $-J$). **So L27's Schur step survives at $m=2$**; what fails at $p=2$ is the decomposition, not the division-algebra argument. This is the analogue of the unital-algebra trap named in the brief, and it comes out clean here.

**What the spectrum does and does not settle.** It is a value list, obtained from a decomposition that the record disclaims at $p=2$ and repairs in a different file, and it covers one split. It does not settle the dispute, and the dispute does not need it, being settled in §4 by an inequality. **Verdict: PROVEN, hypotheses corrected.** The block should print the repaired list, cite L127 for the repair, and say $84$ rather than let a reader reconstruct $86$.

## 6. "The single degenerate case is $(3,3)$", the scope, and a circular citation

Read at $p,q\ge3$ with $n=p+q$, the statement is L27's conclusion and stands: $\tfrac12-\mu>0$ there, $\tfrac12$ is attained on $\mathbb R^p\otimes\mathbb R^q$ alone, $\dim E(\tfrac12)=pq$. **Nothing in this report touches that range.**

Read over $p,q\ge2$ (and the sentence that follows it forces that reading, since it argues about $p=2$), it asserts $\dim E(\tfrac12)=pq$ at every $S^2\times S^q$. **That assertion has no argument on file.**

1. **L27 cannot supply it.** Its statement excludes $q\le2$ by name and calls the decomposition there false.
2. **L126 does not claim it.** It clears only the four-set blocks, and its box says so: "[Lemma L27]'s decomposition **over-counts at $p=2$** … so the summand route does not reach this case."
3. **L127 does not claim it.** Its own box: "*Does not*: establish nondegeneracy independently, since the $\mathcal D_n$ row is L27's", and the same box records that "the $\mathcal D_n$ row's stated source has the same gap, [r392](../reviews/REVIEW_r392.md) having recommended the repair", a repair not on file.
4. **L128 does not supply it, it cites L11 for it.** Line 793: "$S^2\times S^4$ at $n=6$ is pure, critical and Morse–Bott nondegenerate ([Lemma L11](../findings/nondegeneracy.md))". And the L11 block's corrected statement says "**[Lemma L128](../findings/second-order.md) says the same and is right.**" **The two results cite each other and neither proves it.** That is the whole support for nondegeneracy at $p=2$ on the analytic side.

What remains is the sweep (the 36 splits, and the exact-arithmetic list which includes $(2,6)$), together with [nondegeneracy.md](../findings/nondegeneracy.md) line 377's "the whole $S^2\times S^k$ family for $k=2,\ldots,8$ is nondegenerate at its own dimension". That is an open hypothesis in this loop's terms, and it is also one closed-form data point at $(2,2)$ (§4), which is genuine but is a single split.

**What would have to be proved.** That $\mathrm{Weyl}_{2+q}$ decomposes under $O(2)\times O(q)$ as L27's list **minus the summand $S^2_0(\mathbb R^2)$**, or (equivalently for the purpose) that $\tfrac12$ is not an $L_e$-eigenvalue of $\mathcal D_n\cap W^\perp$ at $S^2\times S^q$, which is the one leg of [L128](../findings/second-order.md)(ii) whose $p=2$ value is unsourced. **Verdict: HYPOTHESIS-DEBT**, with the missing statement named.

## 7. $\ker W\ne0$, the padded sphere products, where the statement is false as written

**The block never states $n=p+q$.** L26 does ("Let $n=p+q$ with $p,q\ge2$"), L126 does ("*Stated at $n=p+q$: under padding the nonzero blocks are no longer only the $(2,2)$-splits*"), and the L11 block does not. Its $\mu$ is written in $n$, so a reader who pads is already computing a different number. Padding is the record's standing trap W1, "**THE KERNEL IS THE RECURRING OBSTRUCTION** … All invisible while working with sphere products, which have $\ker W=0$" ([INDEX-traps.md](../findings/INDEX-traps.md)), and [nondegeneracy.md](../findings/nondegeneracy.md) line 409 establishes that padding is critical-point-preserving with the same $\theta$ and the same $S$, so a padded $S^2\times S^q$ is a critical point that the sentence "the single degenerate case is $(3,3)$" ranges over.

**It is degenerate, in closed form, and I derived the recorded excess from the record's own two block lemmas.** [L126](../findings/second-order.md) line 729: "A four-set carrying two indices from the first factor, one from the second and one **padded** index has $L_e$ value $\frac1{2(p-1)}$, which is exactly $\tfrac12$ at $p=2$ for every $q$." By [L128](../findings/second-order.md)(i) the four-set blocks are orbit-free ("The four-set blocks and $\mathcal D_n$ carry no orbit direction") so every such block contributes a $\tfrac12$-eigenvector outside $T_W\mathcal O$, which by L128(ii) is degeneracy. **Counting those four-sets:** two indices from a $2$-dimensional first factor, $1$ way; one index from the second factor, $q$ ways; one padded index, $n-n_0$ ways, where $n_0=2+q$. That is $q(n-n_0)$ blocks. [nondegeneracy.md](../findings/nondegeneracy.md) line 377 records the measured excess as exactly "$q\,(n-n_0)$ for $S^2\times S^q$, doubled when both factors are $2$-spheres", and the doubling is the same count run with the roles of the two $2$-blocks exchanged, giving $2\cdot2(n-4)=4(n-4)$ at $S^2\times S^2$, which is the figure line 409 prints. **The closed-form mechanism and the recorded numbers agree exactly, and I did no computation to check it.**

**So the corrected statement is false on padded objects and true only at $n=p+q$.** The scope clause is one phrase and it is missing. Note also that padding does not rescue paragraph B: it makes $\min(p,q)=2$ degenerate for the *opposite* reason to the one paragraph B gives, not because $\mu_{2,q}$ equals $\tfrac12$ (it does not, at any $q$) but because a *different* block, one that exists only when $\ker W\ne0$, sits at $\tfrac1{2(p-1)}=\tfrac12$. **Verdict on the unscoped statement: BROKEN.**

**At $p,q\ge3$ padding is not benign either, and the record says so.** Line 409: "$S^3\times S^3$ keeps excess $9$ at $n=6\ldots14$ including odd $n$", and line 367 reports padded $S^4\times S^4$ and $S^5\times S^5$ staying nondegenerate. So padding at $p,q\ge4$ is recorded as harmless and at $(3,3)$ as carrying the degeneracy along; either way the L11 statement, which has no padding clause, is being read past its evidence. Recorded as checked.

## 8. The $(3,3)$ exception, which of the two accounts is the mechanism

**The two accounts.** The block's fourth paragraph: the isomorphism $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ "**is true and computes nothing**, it is a coincidence of dimension in three variables". The trailing prose at line 444: the same isomorphism is "the orbit's own representation, so two copies land on the same eigenvalue and the kernel is $18$ against an orbit of $9$", i.e. the mechanism.

**The trailing prose is false under the group in play.** L27 states it flatly and I checked it: under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$, and therefore under $O(3)\times O(3)$, $\Lambda^2\otimes\Lambda^2\cong(\mathbb R^3\otimes\mathbb R^3)\otimes(\det\boxtimes\det)\not\cong\mathbb R^3\otimes\mathbb R^3$, the two $\det$ characters sitting on *different* factors and so not cancelling. L27 measures the same thing as "$\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$, so Schur permits no mixing". The isomorphism holds only under $SO(3)\times SO(3)$, and L27's decomposition is an $O(p)\times O(q)$ one. **Verdict on the trailing prose's mechanism: BROKEN.**

**And the dimension coincidence is not even unique to $(3,3)$, a cold check the record does not have.** $\dim\bigl(\Lambda^2(\mathbb R^k)\otimes\Lambda^2(\mathbb R^l)\bigr)=\dim(\mathbb R^k\otimes\mathbb R^l)$ reads $\frac{k(k-1)}2\cdot\frac{l(l-1)}2=kl$, i.e. $(k-1)(l-1)=4$, whose integer solutions with $k,l\ge2$ are $(3,3)$, $(2,5)$ and $(5,2)$. At $(2,5)$ both sides are $10$-dimensional, and yet $\Lambda^2(\mathbb R^5)$ is the $[1,1]$ irreducible and $\mathbb R^5$ the $[1]$, so no isomorphism exists and (by §2), $\mu_{2,5}=\frac5{2\cdot1\cdot4}=\tfrac58\ne\tfrac12$, no eigenvalue coincidence either. **So the dimension coincidence occurs at a split where nothing happens**, which is the sharpest possible statement of "computes nothing". The trailing prose's "That isomorphism holds for no other $(k,l)$" survives as a claim about the *isomorphism*; what it must not be read as is a claim about the dimension count, which recurs. **Verdict on the block's fourth paragraph: PROVEN.**

**The kernel arithmetic.** $\dim E(\tfrac12)=18$ against $\dim\mathcal O=9$ at $(3,3)$ is consistent with both files and is attributable without any isomorphism: [L127](../findings/second-order.md)'s block table gives nine cross-factor pair blocks carrying $\tfrac12$ "along the orbit" ($pq=9$) and, since $\frac1{p-1}+\frac1{q-1}=1$ at $(3,3)$, nine $(2,2)$-split four-set blocks at $\mu=\tfrac12$ as well, $\binom32\binom32=9$ of them, total $18$, orbit $9$, excess $9$, which is also the padding-invariant excess line 409 records at every $n=6\ldots14$. **The mechanism is $\tfrac12-\mu=0$, i.e. $(p-2)(q-2)=1$, and the closed form finds it. Verdict: PROVEN**, and the trailing prose at line 444 should be deleted rather than left to contradict the paragraph eight lines above it.

**"Schur is not the mechanism" (trailing prose line 446) is right and consistent with L27**: "multiplicity-freeness forces one scalar per piece but never forces the scalars apart" is exactly L27's position. Checked and cleared.

## 9. The edges of every range, and the sweep

**$p,q\ge3$ is stated and then left.** The statement paragraph says "For $p,q\ge3$ with $(p,q)\ne(3,3)$"; the proof paragraph immediately reasons over "$p,q\ge2$" to identify the two failures. That is legitimate for L26, whose hypothesis is $p,q\ge2$, but the conclusion drawn ("at $\min(p,q)=2$ … the point is **nondegenerate** but not a maximiser"), is asserted in the wider range with the narrower range's tool. **A hypothesis stated and then stepped outside of.**

**$n=p+q$ is used and never stated.** §7. **A step using a hypothesis never stated.**

**Smallest admissible dimension in the proven range: $n=7$, at $(3,4)$.** $\mu=\frac5{12}$, $\tfrac12-\mu=\frac{(1)(2)-1}{2\cdot2\cdot3}=\frac1{12}>0$, so the point is nondegenerate; L26's separate flag is that $\mu=\frac5{12}$ overtakes $\lambda_4=\frac13$, which changes the *second-largest* eigenvalue and not the kernel. Consistent with L11, and it is an odd-$n$ case. **Odd $n$ generally**: nothing in $\tfrac12-\mu$ is parity-sensitive, and I found no parity assumption in the block; the parity caveat the record does carry is about $\theta_0(n)$, "*It is the value at the balanced sphere product **at even $n$ only***" ([conventions.md](../findings/conventions.md)), which bears on the danger-zone arguments and not on L11. Checked and cleared.

**Large $p,q$.** $\mu=\frac{p+q-2}{2(p-1)(q-1)}\to0$ and L26's gap $\frac1{2\max(p,q)-2}\to0$, so $\tfrac12-\mu\to\tfrac12$ while the *margin to the next eigenvalue* shrinks. L27 is symbolic in $p,q$, so no upper bound is needed and none is claimed. Checked and cleared.

**The sweep, and the trap of a subfamily used in general.** "Verified at all $36$ splits with $k,l\ge2$ up to $n=14$" is followed four sentences later by "$S^7\times S^7$ at $n=14$ rests on floating point", so the paragraph withdraws part of its own word "verified". For $p,q\ge3$ nothing turns on it: L27 is a theorem symbolic in $p,q$ and the sweep is decoration. **At $p=2$ the sweep is the entire support** for a claim with no upper bound on $q$, the one place in this record where the trap actually bites. And the sweep's range ($k,l\ge2$) is strictly wider than the proof's ($p,q\ge3$), which is what let the wider claim look covered. **Verdict: GAP**, the sentence should say which splits are exact, which are floating point, and that nothing above $n=14$ or at $p=2$ is proven by it.

**A universal claim with no witness.** "That isomorphism holds for **no other** $(k,l)$", §8 checks it and it survives as stated, with the caveat that the accompanying *dimension* claim recurs at $(2,5)$.

## 10. The trailing paragraph: the intended use, and the value-localised survivor

[nondegeneracy.md](../findings/nondegeneracy.md) line 454 says the intended use, every graded critical point nondegenerate, hence the graded set is a union of connected components, "**is false**", citing the Kähler family $\mathfrak{su}(m)$ and the two-block plateau with kernel excesses $5,9,14,20,16$ "established in **exact arithmetic over $\mathbb Q$**".

- **The refutation is right, and the record holds a closed-form witness cheaper than the ones cited.** $S^3\times S^3$ is graded and, by L27's own excluded case, Morse–Bott degenerate with $\dim E(\tfrac12)=18$ against an orbit of $9$. That is a proof, not a measurement, and it refutes the intended use on its own. The file already knows this, line 80 restates the target as "*for $n\ge8$, every graded critical point is Morse–Bott nondegenerate*". The cited excesses are additional witnesses at higher $n$ and rest on computation.
- **The hedge on the plateau is correctly stated**: "the obstruction proves no branch when it fails, rather than a branch when it vanishes". Checked and cleared.
- **The value-localised survivor is a definition, not a theorem.** "Every **known** exception sits at value at most $1.054$" is a census over what has been computed; the localised statement (every graded critical point with $\theta\ge t$ is nondegenerate), requires that no *unknown* exception sits above $t$, which is precisely what is not proven. The words "by fiat" concede this, and I record it as conceded rather than as a defect. The compactness step is sound: $\theta=P(W)$ is continuous on the unit sphere and $\mathrm{Crit}$ is closed, so $\{\theta\ge t\}\cap\mathrm{Crit}$ is compact.
- **Two checks in the survivor's favour, both closed-form.** $S^3\times S^3$ sits at $\theta_0(6)=\sqrt{10/9}=1.0541$, exactly the top of the quoted band, against the rival maximiser's $\sqrt{3/2}=1.2247$; and the $\min(p,q)=2$ family cannot reach the band at all, since $\theta(S^2\times S^q)\uparrow1$ ([nondegeneracy.md](../findings/nondegeneracy.md) line 377). Padding freezes $\theta$ at the seed value (line 409), so the padded degenerate points of §7 stay below $t$ too. The localisation is stable under the one operation that manufactures new degenerate points.
- **Scope creep to note**: the paragraph attributes "the plateau" to L11, and [second-order.md](../findings/second-order.md) line 778 does too ("[Lemma L11]'s plateau and the $\mathfrak{su}(m)$ family") but no plateau appears in any statement of L11. **Verdict: HYPOTHESIS-DEBT** on the survivor, with the attribution flagged.

## 11. Symbol collisions

- **$\mu$ is on its fourth or fifth meaning and this one is not tabled.** [conventions.md](../findings/conventions.md) records "**$\mu$ CARRIES TWO MEANINGS THIRTY LINES APART IN [bispectral.md](../findings/bispectral.md), AND A THIRD IN [target.md](../findings/target.md)**", and the same file's $\mathrm{Cat}_F$ row uses $\mu$ for the apolarity multiplication. L26/L11's $\mu$ (the two-block dangerous eigenvalue, in $L_e$ units where the threshold is $\tfrac12$), appears in none of them. It should be tabled, together with the normalisation note L127 gives: "*the $\tfrac12$ threshold is in $L_e$ units, L121 and L122 giving $L_M$ eigenvalues whose orbit value is $\theta/2$*".
- **$p$ is a block dimension and a prime in the same file, thirty lines apart.** L26 and L11 use $p$ for the first block; the kernel-identity paragraph between them writes "$k\,l=\mathrm{rank}_p(\text{orbit})\le\mathrm{rank}_{\mathbb Q}\le\mathrm{nullity}_{\mathbb Q}\le\mathrm{nullity}_p=k\,l$" with $p$ a prime, and "modulo two primes at $n=8,10,12$". The chain that upgrades the kernel identity to a theorem is written in the letter L11 uses for its own hypothesis.
- **$k,l$ and $p,q$ are the same two numbers in one block.** The statement says "of dimension $pq$", the trailing prose "the common value is $k\,l$", with no line saying they are the same symbols. Any reader merging the two paragraphs must first merge two alphabets.
- **$n$ is $p+q$ in the statement and the ambient dimension in the padding paragraphs.** That is the collision that hides §7: $\mu=\frac{n-2}{2(p-1)(q-1)}$ is a different number under the two readings, and only one of them is meant.

## 12. Withdrawn candidates

- **"The orbit dimension is not $pq$ at $p=2$."** Withdrawn: $\binom{q+2}2-\binom22-\binom q2=\frac{(q+2)(q+1)-q(q-1)}2-1=2q=pq$, and at $(2,4)$ that is $15-1-6=8$. No enlarged stabiliser is visible and the record's own count agrees.
- **"$\mu$ could equal $\tfrac12$ at $p=2$ for large $q$."** Withdrawn: $\mu=\tfrac12+\frac1{2(n-3)}$ decreases to $\tfrac12$ and never attains it at finite $q$; the criterion is a statement per split.
- **"$(3,4)$ breaks L27, since L26 flags it."** Withdrawn: the flag is that $\mu$ overtakes $\lambda_{\max(p,q)}$, i.e. the identity of the *second-largest* eigenvalue changes; $\tfrac12-\mu=\frac1{12}>0$, so the kernel is untouched and L27's conclusion holds.
- **"L27's trace identity fails at $p=2$, exposing the decomposition."** Withdrawn: the repaired $(2,4)$ list has $\operatorname{tr}L_e=1+4+3+4-12=0$, and the deleted summand carried the value $0$, so the trace is blind to the defect. It cannot be used as the detector; the dimension count is the detector.

## 13. What would break the conclusions I have reached

**The conclusion at risk is §4's**: that at $\min(p,q)=2$ and $n=p+q$ the point is non-maximal rather than degenerate.

**The object that would falsify it**: a direction $V\perp W$ at some unpadded $S^2\times S^q$ with $L_eV=\tfrac12V$ and $V\notin T_W\mathcal O$. It would make "degenerate at $\min(p,q)=2$" true again, for a reason unrelated to $\mu$, which is strictly above $\tfrac12$ at every such split.

**Where it could hide, and what I did.** By [L128](../findings/second-order.md)(ii) it would have to sit in a four-set block, in $\mathcal D_n\cap W^\perp$, or as a second $\tfrac12$ in a pair block. I read [L127](../findings/second-order.md)'s block table and both of its correction boxes and checked each family in closed form: the four-set blocks carry $\mu_{2,q}=\frac q{2(q-1)}>\tfrac12$ strictly at every $q\ge2$, never $\tfrac12$; the cross-factor pair blocks are exactly $\{\tfrac12\ \text{simple},0^{n-4}\}$ with the $\tfrac12$ on the orbit; the within-factor blocks at $p=2$ are "entirely $-\mu$", negative. **That leaves $\mathcal D_n\cap W^\perp$, whose $p=2$ values L127 takes from L27, the one source that disclaims itself there, and whose gap [r392](../reviews/REVIEW_r392.md) already recommended repairing.** In the repaired $84$-dimensional $(2,4)$ list of §5 no second $\tfrac12$ appears, and the same repair reproduces the recorded $(2,2)$ spectrum exactly; those are the two closed-form places I could look. **I ran nothing, searched no splits, and constructed no candidate $V$.** So the falsifier is not excluded, it is confined to one named block at $p=2$, and that is exactly the debt booked in §6.

**The padding conclusion of §7 would be falsified** by a padded four-set of that shape whose $L_e$ value is not $\frac1{2(p-1)}$. I did not derive that value from the definitions; it is L126's, contributed at Gate 2. What I did was check that the block count it forces, $q(n-n_0)$ (and $4(n-4)$ at $S^2\times S^2$), reproduces the independently recorded excesses exactly, which is a strong consistency test and not a proof of the value.

## Verdict

**BROKEN**, at the canonical statement, with the block's replacement standing in a narrower range than it claims:

| what | verdict |
| --- | --- |
| [results.md](../results.md) line 393, line 130 and [INDEX-results.md](../findings/INDEX-results.md) line 26, "degenerate at $\min(p,q)=2$ and at $(3,3)$" | **BROKEN.** The reason given is a misreading of L26's $\mu\ge\tfrac12$ criterion, and the record's own $(2,2)$ spectrum exhibits a $\min(p,q)=2$ point with $\dim E(\tfrac12)=pq$ |
| Paragraph B of the block ([nondegeneracy.md](../findings/nondegeneracy.md) line 438) | **BROKEN**, same cause; it should be struck rather than left standing next to the paragraph that refutes it |
| The block's statement at $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$ | **PROVEN**, by L27, whose $\tfrac12-\mu>0$ is symbolic in $p,q$ |
| "The single degenerate case is $(3,3)$" over $p,q\ge2$ at $n=p+q$ | **HYPOTHESIS-DEBT.** L27 excludes $q\le2$ by name; L126 and L127 say the summand route does not reach it; L128 cites L11 for it while L11 cites L128, a two-step circle with no proof at either end |
| The same, without a padding scope | **BROKEN.** Padded $S^2\times S^q$ is degenerate, with $q(n-n_0)$ four-set blocks at $\tfrac12$, all orbit-free |
| The $(3,3)$ mechanism | **PROVEN** as $\tfrac12-\mu=0$; the trailing prose's representation-isomorphism mechanism is **BROKEN** under $O(3)\times O(3)$ and should be deleted |

**The three repairs the block needs, none of which I have made:** add "$n=p+q$" to the statement; replace "the single degenerate case is $(3,3)$" with the range L27 actually proves plus an explicit debt at $\min(p,q)=2$; and propagate the 2026-09-04 correction to [results.md](../results.md) and [INDEX-results.md](../findings/INDEX-results.md), which still carry the refuted version.
