# REVIEW r529, Lemma L27 (sphere products are Morse–Bott nondegenerate)

**Target:** `findings/nondegeneracy.md`, `#### Lemma L27` (line 457) to the next heading.
**Reviewer:** r529, cold, adversarial. Analysis-only footing: no searches, sweeps, censuses; screening only.

**Statement under audit.** For $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$: $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent, $\dim E(\tfrac12)=pq=\dim(\text{orbit})$, so $S^p\times S^q$ is Morse–Bott nondegenerate.

## Phase plan

- P1 read L27 verbatim, fix conventions against the anchors
- P2 ten-summand decomposition vs Nienhaus notes; dimension sum $=\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$
- P3 multiplicity-freeness, especially $p=q$
- P4 the Schur step's stated reason
- P5 the three deciding eigenvalues; nothing exceeds or ties $1/2$ off the orbit
- P6 $(3,3)$ and $p=2$
- P7 sample of the 58 citations
- P8 contradictions elsewhere in `findings/`

VERDICT: **CONFIRMED**, the statement is true as written, every step of the argument checks, and the two defects found are a citation and a wording, both repairable in place without touching the conclusion. *Note: F9 was written before I found the derivation at second-order.md:589 and is corrected by F14, read them together.*

## Findings

### F1, the source citation is accurate, and it is *stronger* than the block needed (CONFIRMS attack 1)

Read from the record's own notes, [references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md), and from the `pdftotext` extraction [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 3760–3830. No PDF was opened.

The notes' index card for Prop 4.6 quotes the hypothesis "$k,l\ge5$, $k,l\ne6$", which looks at first like a hypothesis violation in L27's $p,q\ge3$. It is not. Two distinct statements sit on that page:

| Statement | Object decomposed | Hypothesis | Group |
| --- | --- | --- | --- |
| Proposition 4.6 proper (4.4), 18 summands | $S^2(\mathfrak{so}(n))$ | $k,l\ge5$, $k,l\ne6$ | $SO(k)\times SO(l)$ |
| the **summary display** immediately after (a)–(f) , 10 summands | $\mathrm{Weyl}_n$ | see below | both |

The summary display's own closing sentence, verbatim from the extraction:

> "This decomposition is orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, **it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$.**"

That is exactly L27's hypothesis and exactly L27's group. The block's phrase "Proposition 4.6 **and the summary display following it**" is therefore precise, not loose, and the $k,l\ne6$ exclusion is a red herring for L27: it enters Prop 4.6 through the lemma above it, "$\Lambda^2(\mathbb R^k)\otimes\mathbb R^k=\Lambda^3(\mathbb R^k)\oplus\mathbb R^k\oplus X_k$ … irreducible for any $k\ge3$ with $k\ne4,6$", and both exclusions are $SO$-specific and dissolve under $O(k)$, at $k=4$, $\Lambda^3(\mathbb R^4)\cong\mathbb R^4$ under $SO(4)$ but $\cong\mathbb R^4\otimes\det\not\cong\mathbb R^4$ under $O(4)$; at $k=6$, $\Lambda^3(\mathbb R^6)$ splits into $\Lambda^3_\pm$ under $SO(6)$ and is irreducible under $O(6)$. So $O$ is the group that makes $k\ge3$ uniform, and it is the group L27 uses.

The ten summands match the source display one for one, in the same order:
$\langle W_{S^k\times S^l}\rangle\oplus\mathrm{Weyl}_k\oplus\mathrm{Weyl}_l\oplus(\mathbb R^k\otimes\mathbb R^l)\oplus S^2_0(\mathbb R^k)\oplus S^2_0(\mathbb R^l)\oplus(S^2_0\otimes S^2_0)\oplus(\Lambda^2\otimes\Lambda^2)\oplus(X_k\otimes\mathbb R^l)\oplus(X_l\otimes\mathbb R^k)$.

$\dim X_m$ is checked against the source's *definition* of $X_m$ (the orthogonal complement of $\mathbb R^k$ in $\ker\Phi\subset\Lambda^2(\mathbb R^k)\otimes\mathbb R^k$), rather than taken on trust: $\tfrac{k^2(k-1)}2-\tfrac{k(k-1)(k-2)}6-k=\tfrac k6(3k^2-3k-k^2+3k-2-6)=\tfrac{k(2k^2-8)}6=\tfrac{k(k^2-4)}3$. Agrees with the block.

### F2, the ten dimensions sum to $\dim\mathcal W_n$ identically in $p,q$ (CONFIRMS attack 1, the cheapest check)

By hand, with $\dim\mathrm{Weyl}_m=\tfrac{m(m-3)(m+1)(m+2)}{12}$, $\dim S^2_0(\mathbb R^m)=\tfrac{(m+2)(m-1)}2$, $\dim\Lambda^2(\mathbb R^m)=\tfrac{m(m-1)}2$, $\dim X_m=\tfrac{m(m^2-4)}3$:

$$1+\mathrm{W}_p+\mathrm{W}_q+pq+S_p+S_q+S_pS_q+\Lambda_p\Lambda_q+qX_p+pX_q\;=\;\frac{n(n-3)(n+1)(n+2)}{12},\qquad n=p+q .$$

Screened symbolically (sympy, seconds; objects constructed for this check): the difference expands to $0$, and the sum factors back to $(p+q)(p+q-3)(p+q+1)(p+q+2)/12$. Spot values: $(3,3)\to84$, $(4,4)\to300$, $(3,5)\to300$, $(6,6)\to1638$, all equal to $\dim\mathcal W_n$. Note $\mathrm{Weyl}_3=0$ falls out of the same formula, so $p=3$ needs no special casing. **The arithmetic closes.**

One number worth carrying forward: at $(3,3)$, $\dim(\mathbb R^3\otimes\mathbb R^3)=9$ and $\dim(\Lambda^2\otimes\Lambda^2)=3\cdot3=9$. That is where the block's $\dim E(\tfrac12)=18$ comes from.

### F3, conventions fixed, and the record's $\varepsilon$-values reproduce Nienhaus's $\theta_{k,l}$ from scratch

Anchors used, all from [conventions.md](../findings/conventions.md): $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\lVert W\rVert^2=\sum_{a<b}\varepsilon_{ab}^2$; $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$; $e=W/\theta$ and $L_e=e\circ(\cdot)$.

The three-block values the record uses, $\varepsilon_{PP}=\tfrac q{(p-1)(n-1)}$, $\varepsilon_{QQ}=\tfrac p{(q-1)(n-1)}$, $\varepsilon_{PQ}=\tfrac{-1}{n-1}$, are not taken on trust. Trace: $\tfrac{pq}{2(n-1)}+\tfrac{pq}{2(n-1)}-\tfrac{pq}{n-1}=0$, so $e$ is trace-free on $\Lambda^2$ as a Weyl operator must be. Norm:

$$\lVert e\rVert^2=\frac{pq}{(n-1)^2}\cdot\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{2(p-1)(q-1)}=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)(n-1)^2},$$

using $p^2+q^2+2pq-3p-3q+2=(n-1)(n-2)$. Since $\lVert e\rVert=1/\theta$ this gives

$$\theta=\sqrt{2\cdot\frac{p-1}p\cdot\frac{q-1}q\cdot\frac{n-1}{n-2}},$$

which is **Nienhaus Proposition 2.25 verbatim**, and at $p=q=n/2$ collapses to $\theta_0(n)^2=2(n-1)(n-2)/n^2$, giving $\theta_0(6)=\sqrt{10}/3$. All four of the brief's anchors are met. The record's normalisation and the source's therefore differ by nothing.

### F4, the $\tfrac12$ on the orbit is right, and the $\tfrac12$ threshold is the right one (CONFIRMS attack 4, first value)

Derived independently. $Q$ is quadratic with polarisation $\circ$, so $Q(W+sV)=Q(W)+2s\,W\circ V+s^2Q(V)$ and $DQ_W(V)=2\,W\circ V$. Along an orbit curve $W_t=g_t\cdot W$, equivariance of $Q$ and constancy of $\theta$ give $Q(W_t)=\theta W_t$; differentiating, $2W\circ\dot W=\theta\dot W$, i.e. $L_e\dot W=\tfrac12\dot W$. The block's one-line justification is exactly this and is correct. $\langle\dot W,W\rangle=0$ puts the orbit tangent inside $W^\perp$.

The threshold is not arbitrary. With $\langle X\circ Y,Z\rangle$ totally symmetric, $DP_W(V)=3\langle Q(W),V\rangle$ and $D^2P_W(V,V)=6\langle W\circ V,V\rangle$; at a critical point the multiplier is $3\theta$, so on $W^\perp$

$$\mathrm{Hess}_{S}P\,(V,V)=6\langle W\circ V,V\rangle-3\theta\lVert V\rVert^2=6\theta\Big[\langle L_eV,V\rangle-\tfrac12\lVert V\rVert^2\Big].$$

So $\ker\mathrm{Hess}_S=E_{L_e}(\tfrac12)\cap W^\perp$ and $\mathrm{Hess}_S\preceq0$ iff $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$. **L27's spectral statement and its Morse–Bott conclusion are the same statement**, which is what the lemma needs and does not overclaim. It also explains, correctly, why $p=2$ (where $\mu>\tfrac12$) is nondegenerate yet not a local maximum, the record's own scope correction (i).

That the orbit tangent is the *whole* $\mathbb R^p\otimes\mathbb R^q$ summand, not a proper subspace, is settled two ways: the source's Proposition 4.6(b) says the $k\cdot l$-dimensional space generated by $[\mathrm{ad}_v,W_{S^k\times S^l}]$ *is* the orbit tangent; and independently, the orbit tangent is a nonzero $O(p)\times O(q)$-submodule of type $\mathbb R^p\otimes\mathbb R^q$, so multiplicity-freeness forces it to be that summand. $\dim=\binom n2-\binom p2-\binom q2=pq$.

### F5, the ten values reproduce the record's own exact-spectra table character for character

Screened (exact rationals, seconds, objects built for this check). Feeding only the ten dimensions and the ten values, $1$, $\tfrac12$ at $pq$, $\lambda_m=\tfrac{m-2}{2(m-1)}$ at $s_m=\tfrac{(m+2)(m-1)}2$, $-\mu$ at $s_ps_q$, $+\mu$ at $c_pc_q=\tfrac{p(p-1)}2\tfrac{q(q-1)}2$, $0$ on the remaining four, and merging coincident values:

| split | reconstructed from L27's ten values | the table at [nondegeneracy.md:674](../findings/nondegeneracy.md#L674) |
| --- | --- | --- |
| $3{+}5$ | $-\tfrac38^{70},0^{165},\tfrac14^{5},\tfrac38^{44},\tfrac12^{15},1^{1}$ | identical |
| $4{+}4$ | $-\tfrac13^{81},0^{148},\tfrac13^{54},\tfrac12^{16},1^{1}$ | identical |
| $3{+}7$ | $-\tfrac13^{135},0^{518},\tfrac14^{5},\tfrac13^{63},\tfrac5{12}^{27},\tfrac12^{21},1^{1}$ | identical |
| $4{+}6$ | $-\tfrac4{15}^{180},0^{446},\tfrac4{15}^{90},\tfrac13^{9},\tfrac25^{20},\tfrac12^{24},1^{1}$ | identical |
| $5{+}5$ | $-\tfrac14^{196},0^{420},\tfrac14^{100},\tfrac38^{28},\tfrac12^{25},1^{1}$ | identical |

Every total equals $\dim\mathcal W_n$. Note the merges are non-trivial and would break under a wrong value: at $3{+}5$ the recorded $\tfrac38^{44}$ is $+\mu$ at $c_3c_5=30$ *plus* $\lambda_5$ at $s_5=14$, and at $4{+}4$ the recorded $\tfrac13^{54}$ is $36+9+9$. The ten values are internally consistent with the record's measured spectra to the last multiplicity.

### F6, an independent structural cross-check on $\lambda_m$, the value L27 states without proof

The block asserts $\lambda_m=\tfrac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ flatly. It is the only one of the three deciding values with no argument attached in the block, and it is the one that supplies the *true* second eigenvalue (see F9). Rather than take it, note that the record's index computation reports "raw-block eigenvalues $1,-\tfrac12,\tfrac{p-2}2$". Solving for a criticality-free form in the three block values gives

$$\lambda_m=\frac{m-2}{2}\big(\varepsilon_{mm}-\varepsilon_{PQ}\big),$$

the exact analogue of Lemma L26's criticality-free $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, with the raw-block constant $\tfrac{m-2}2$ appearing as its coefficient. Substituting the $\varepsilon$'s of F3 reproduces every recorded value: $\lambda_3=\tfrac12(\tfrac5{14}+\tfrac2{14})=\tfrac14$; $\lambda_5=\tfrac32(\tfrac5{36}+\tfrac4{36})=\tfrac38$; $\lambda_7$ at $(3,7)$ is $\tfrac52(\tfrac1{18}+\tfrac2{18})=\tfrac5{12}$; $\lambda_4$ at $(4,4)$ is $1\cdot(\tfrac4{27}+\tfrac1{7})$, recomputing, $\varepsilon_{PP}=\tfrac4{3\cdot7}=\tfrac4{21}$, $\varepsilon_{PQ}=-\tfrac17$, so $1\cdot(\tfrac4{21}+\tfrac3{21})=\tfrac13$. Agrees in every case.

This is corroboration, not a proof: it shows $\lambda_m$ has the shape the same machinery produces and is independent of the other block, which is what makes a formula in $m$ alone credible. **The gap it names is real**, see F11.

Whatever its provenance, the inequality the lemma uses is immediate from the value: $\lambda_m=\tfrac12\cdot\tfrac{m-2}{m-1}<\tfrac12$ for every finite $m$, with no exceptions and no case split.

### F7, multiplicity-freeness holds, including at $p=q$; the block's one-word justification is loose but the fact is right (CONFIRMS attack 2)

The block says "the Young labels are pairwise distinct for every $p,q\ge3$". Read literally that is imprecise: a summand here is an $O(p)\times O(q)$-representation, so its label is a **pair** of Young labels, and the distinctness that matters is distinctness of pairs. With that reading it holds, and the two collisions the brief asks about are exactly where the pair reading does the work:

| # | summand | label pair |
| --- | --- | --- |
| 1 | $\langle W\rangle$ | $([\,],[\,])$ |
| 2 | $\mathrm{Weyl}_p$ | $([2,2],[\,])$ |
| 3 | $\mathrm{Weyl}_q$ | $([\,],[2,2])$ |
| 4 | $\mathbb R^p\otimes\mathbb R^q$ | $([1],[1])$ |
| 5 | $S^2_0(\mathbb R^p)$ | $([2],[\,])$ |
| 6 | $S^2_0(\mathbb R^q)$ | $([\,],[2])$ |
| 7 | $S^2_0\otimes S^2_0$ | $([2],[2])$ |
| 8 | $\Lambda^2\otimes\Lambda^2$ | $([1,1],[1,1])$ |
| 9 | $X_p\otimes\mathbb R^q$ | $([2,1],[1])$ |
| 10 | $X_q\otimes\mathbb R^p$ | $([1],[2,1])$ |

- **$S^2_0(\mathbb R^p)$ against $S^2_0(\mathbb R^q)$ at $p=q$**: rows 5 and 6 are $([2],[\,])$ and $([\,],[2])$, the *external* tensor product distinguishes them however equal $p$ and $q$ are. An isomorphism would have to intertwine $[2]$ with the trivial rep on the first factor. **No collision.**
- **$X_p\otimes\mathbb R^q$ against $X_q\otimes\mathbb R^p$ at $p=q$**: rows 9 and 10 are $([2,1],[1])$ and $([1],[2,1])$; these agree only if $X_m\cong\mathbb R^m$, which fails on dimension alone ($\tfrac{m(m^2-4)}3=m$ would need $m^2=7$). **No collision.** Same for rows 2 and 3.
- The remaining risk is a coincidence *within one factor's* label set $\{[\,],[1],[2],[1,1],[2,1],[2,2]\}$ at small $m$, and I checked the two real ones by hand: at $m=3$, $\Lambda^2(\mathbb R^3)$ and $\mathbb R^3$ both have dimension $3$, and $X_3$ and $S^2_0(\mathbb R^3)$ both have dimension $5$, under $SO(3)$ each pair *is* isomorphic. Under $O(3)$ they are not: $-I$ acts on the irrep labelled $\lambda$ by $(-1)^{\lvert\lambda\rvert}$, giving $+1$ on $[1,1]$ and $[2]$ against $-1$ on $[1]$ and $[2,1]$. This is the same $\det$-twist mechanism as in F1, and it is why $O$ rather than $SO$ is the right group. It matches the record's own commutant computation ("including $\mathbb R^3$ against $\Lambda^2(\mathbb R^3)$ and $S^2_0$ against $X_3$, which share dimensions").
- $[2,2]$ is not a valid $O(3)$ label ($\lambda'_1+\lambda'_2=4>3$), consistent with $\mathrm{Weyl}_3=0$; at $m=4$, $[2,2]$, $[1,1]$ and $[2,1]$ each split under $SO(4)$ and stay irreducible under $O(4)$, again the record's own statement, and again $O$-only.

**The swap symmetry at $p=q$ is not a threat**: $L_e$ is only claimed equivariant for $O(p)\times O(q)$, and multiplicity-freeness under a *subgroup* of the full stabiliser is what Schur needs. A larger group would add constraints, never remove them.

### F8, the Schur step reaches the right conclusion; its stated reason is compressed, not wrong (attack 3)

The block: *"since $L_e$ is symmetric the $\mathbb C$ and $\mathbb H$ Schur cases cannot occur; so $L_e$ acts as a **scalar** on each summand"*. The same sentence appears at [nondegeneracy.md:700](../findings/nondegeneracy.md#L700) as "Absolute irreducibility is what Schur needs, and $L_e$ being symmetric rules out the $\mathbb C$ and $\mathbb H$ cases."

**I checked what the record already means by this before calling it wrong**, per the brief's warning. The line at 700 pairs the symmetry remark with "absolute irreducibility is what Schur needs", so the record's "the $\mathbb C$ and $\mathbb H$ cases" names the *outcomes* of Schur's lemma ($\mathrm{End}_G(U)\in\{\mathbb R,\mathbb C,\mathbb H\}$), not the representations. Under that reading the sentence is true. Under the other reading it is false, and worth saying so plainly: **symmetry of an operator does not prevent a real-irreducible summand from being of complex or quaternionic type.** What it prevents is the commutant element being non-real.

The one-line proof the block does not give, and which makes the step airtight either way:

> $L_e$ is $G$-equivariant, so $L_e|_U:U\to\mathcal W_n$ has image a quotient of $U$, hence $0$ or a copy of $U$; multiplicity-freeness puts that copy inside $U$ itself. So $A:=L_e|_U\in D:=\mathrm{End}_G(U)$, a real division algebra. $A$ is symmetric on a finite-dimensional real inner-product space, so it has a real eigenvalue $\lambda$; then $A-\lambda\,\mathrm{id}_U\in D$ is singular, hence zero. Therefore $A=\lambda\,\mathrm{id}_U$.

This uses only symmetry and works in all three Schur cases, so it is strictly stronger than what the block asserts. In fact the question is moot here, every $O(m)$-irreducible is of real type, and an external tensor product of real-type reps is of real type, so $D=\mathbb R$ throughout, but that is a fact about the *representations*, which is precisely what the block's sentence does not say. **Verdict on this step: sound, one line short.**

### F9, two of the ten values are stated in the block with no derivation anywhere on the record (attack 4, the real defect)

Taking the ten values one at a time against what the record actually supplies:

| summand | value | where it is proved |
| --- | --- | --- |
| $\langle W\rangle$ | $1$ | immediate: $L_ee=Q(e)=Q(W)/\theta^2=e$. Removed by $W^\perp$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $\tfrac12$ | **proved**, F4 above, and it is the orbit tangent by source Prop 4.6(b) |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu=\tfrac{n-2}{2(p-1)(q-1)}$ | **proved**, [Lemma L26](../findings/nondegeneracy.md), symbolic in $p,q$, audited by r32/r33 and r527 |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$ | $0$ | **proved** two independent ways ([nondegeneracy.md:708](../findings/nondegeneracy.md#L708)) |
| $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $0$ | **proved**, the index computation uniform in $p,q,n$ ([nondegeneracy.md:716](../findings/nondegeneracy.md#L716)) |
| $S^2_0(\mathbb R^p)$, $S^2_0(\mathbb R^q)$ | $\lambda_m=\tfrac{m-2}{2(m-1)}$ | **stated flat, no argument in the block and none found in the record** |
| $S^2_0\otimes S^2_0$ | $-\mu$ | **cited to L26, which does not state it** |

The second of these is already on the record as a defect: [LEDGER.md:771](../findings/LEDGER.md#L771), "L27 cites L26 for '$-\mu$ and $+\mu$ on the two tensor summands', where L26 supplies **one** eigenvector on $\Lambda^2\otimes\Lambda^2$ only … the other summand's value now has no source." I reached it independently: L26's statement is about $X=\phi_\pi\odot\phi_\rho$ with $\pi\subset P$, $\rho\subset Q$ coordinate 2-planes, which lies in $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ and nowhere else. **The block is unrepaired in the file.**

The first is worse, because nothing flags it. $\lambda_m$ is the value that supplies the *true* second eigenvalue of $L_e$ (see the correction at [nondegeneracy.md:736](../findings/nondegeneracy.md#L736): $\lambda_2=\lambda_{\max(p,q)}$ off $(3,4)$), and downstream results cite **L27** for it, [second-order.md:1103](../findings/second-order.md#L1103) "$L_e$ acts there as the scalar $\lambda_m=(m-2)/(2(m-1))$", and Lemmas L145/L146's whole margin analysis. So the citation runs to L27 and stops there.

**This does not falsify the lemma** (the conclusion needs only $\lambda_m<\tfrac12$ and $\lvert{\pm\mu}\rvert<\tfrac12$) but as written the proof has two values it does not earn. F11 closes most of the hole.

### F10, nothing exceeds or ties $\tfrac12$ off the orbit, and the two boundaries behave (attacks 4 and 5)

Given the ten values, the maximum over $W^\perp$ is decided by three strict inequalities and there is no fourth:

- $\lambda_m=\tfrac12\cdot\tfrac{m-2}{m-1}<\tfrac12$ for every finite $m$, no case split, no exception.
- $-\mu<0<\tfrac12$ since $\mu>0$ for $n>2$.
- $+\mu<\tfrac12\iff\tfrac12-\mu=\dfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0\iff(p-2)(q-2)\ge2$. For $p,q\ge3$ the product $(p-2)(q-2)$ is at least $1$, equal to $1$ only at $(3,3)$, and at least $2$ otherwise. **The block's displayed identity is arithmetically correct**: $(p-1)(q-1)-(n-2)=pq-2p-2q+3=(p-2)(q-2)-1$.
- The four zeros and the excluded $1$ on $\langle W\rangle$ need nothing.

**$(3,3)$, verified from the ten values as the brief asks.** $\mu=\tfrac{4}{2\cdot2\cdot2}=\tfrac12$, so $\Lambda^2\otimes\Lambda^2$ joins the orbit at $\tfrac12$ with multiplicity $c_3c_3=3\cdot3=9$; the orbit contributes $pq=9$; total $\dim E(\tfrac12)=18$ against orbit $9$. Exactly the block's claim, and my reconstruction of the full $(3,3)$ spectrum from the ten values gives $-\tfrac12^{25},0^{30},\tfrac14^{10},\tfrac12^{18},1^{1}$, summing to $84=\dim\mathcal W_6$. **Confirmed.**

That this is an eigenvalue coincidence rather than representation mixing is also right, and it is the one place where the file appears to contradict itself. [nondegeneracy.md:129](../findings/nondegeneracy.md#L129) says "$\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ (the orbit's own irrep) so two copies land on $\tfrac\theta2$", while L27 says "$\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$". **Both are true of different groups and the two passages do not collide**: under $SO(3)\times SO(3)$ they are isomorphic; under $O(3)\times O(3)$ the twist is by the character $\det\boxtimes\det$, which is non-trivial, so they are not. The earlier passage says so itself in its next paragraph ("Even under $O(3)\times O(3)$, where the decomposition *is* multiplicity-free, the kernel is still $18$"). L27 runs under $O$, so L27's reading is the operative one.

**$p=2$, and why $p,q\ge3$ is needed.** Two independent failures, both real:
1. $\mu=\tfrac{n-2}{2(q-1)}=\tfrac q{2(q-1)}=\tfrac12+\tfrac1{2(n-3)}>\tfrac12$, so $\lambda_{\max}(L_e|_{W^\perp})$ **exceeds** $\tfrac12$ and the point is not a local maximum. $\Lambda^2(\mathbb R^2)$ is one-dimensional, not zero, so the eigenvalue genuinely occurs.
2. The summand list itself breaks. The polynomial identity of F2 still holds, but $\mathrm{Weyl}_2$ is not a summand of dimension $\tfrac{2(-1)(3)(4)}{12}=-2$; it is $0$. So the *actual* dimensions overshoot by $2$, $86$ against $\dim\mathcal W_6=84$ at $S^2\times S^4$, which is precisely the over-count [r507](REVIEW_r507.md) reported and [LEDGER.md:561](../findings/LEDGER.md#L561) logged. The record's own repair (drop $S^2_0(\mathbb R^2)$, dimension $2$) restores the count.

Both boundaries are therefore load-bearing and correctly drawn.

### F11, a repair: $\operatorname{tr}L_e=0$ is unconditional, the ten values satisfy it identically in $p,q$, and at $p=q$ it *forces* $\lambda_m$

This is the finding I would most like folded into the block. It is analytic, cheap, and it closes most of F9.

**Claim.** For every $e\in\mathcal W_n$ with $n\ge5$, $\operatorname{tr}_{\mathcal W_n}(L_e)=0$.

**Proof.** Let $\{V_i\}$ be an orthonormal basis of $\mathcal W_n$. The trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is totally symmetric (it is $\tfrac16D^3P$; the record checks the symmetry independently), so $\langle L_eV_i,V_i\rangle=T(e,V_i,V_i)=T(V_i,V_i,e)=\langle Q(V_i),e\rangle$ and

$$\operatorname{tr}L_e=\Big\langle e,\ \sum_iQ(V_i)\Big\rangle .$$

$Q$ is $O(n)$-equivariant, so for $g\in O(n)$, $\sum_iQ(gV_i)=g\sum_iQ(V_i)$; but $\{gV_i\}$ is another orthonormal basis and $\sum_iQ(V_i)$ is basis-independent, so $\sum_iQ(V_i)$ is an $O(n)$-invariant vector of $\mathcal W_n$. $\mathcal W_n$ is $O(n)$-irreducible and non-trivial, so it contains none but $0$. Hence $\sum_iQ(V_i)=0$ and $\operatorname{tr}L_e=0$. $\square$

**The ten values pass it identically in $p,q$.** With $s_m=\tfrac{(m+2)(m-1)}2$ and $c_m=\tfrac{m(m-1)}2$,

$$\operatorname{tr}L_e=1+\tfrac{pq}2+\lambda_ps_p+\lambda_qs_q-\mu\,s_ps_q+\mu\,c_pc_q .$$

Now $\lambda_ms_m=\tfrac{(m-2)(m+2)}4=\tfrac{m^2-4}4$, and $s_ps_q-c_pc_q=\tfrac{(p-1)(q-1)}4\big[(p+2)(q+2)-pq\big]=\tfrac{(p-1)(q-1)(n+2)}2$, so $\mu(s_ps_q-c_pc_q)=\tfrac{(n-2)(n+2)}4=\tfrac{n^2-4}4$ and

$$\operatorname{tr}L_e=1+\tfrac{pq}2+\tfrac{p^2-4}4+\tfrac{q^2-4}4-\tfrac{n^2-4}4=\tfrac{4+2pq+p^2+q^2-8-n^2+4}{4}=0 .$$

Screened symbolically as well: sympy returns $0$. **This is a non-trivial constraint**, it couples all ten multiplicities to the four non-zero values, and a wrong $\lambda_m$ or a wrong sign on $S^2_0\otimes S^2_0$ breaks it.

**And at $p=q$ it determines $\lambda_m$ outright.** Grant only the $S^2_0\otimes S^2_0$ value $-\mu$ (which [second-order.md:889](../findings/second-order.md#L889) supplies independently of L26: on each $(2,2)$-split four-set block $L_e$ carries $\pm\mu$ on $\mathbf1^\perp$, and there are $\binom p2\binom q2=c_pc_q$ such blocks, matching the $+\mu$ multiplicity exactly). Writing $f(m)=\lambda_ms_m$, the trace identity reads $f(p)+f(q)=\tfrac{p^2-4}4+\tfrac{q^2-4}4$. At $p=q=m$ this gives $2f(m)=2\cdot\tfrac{m^2-4}4$ with no further assumption, hence

$$\lambda_m=\frac{m^2-4}{4}\cdot\frac{2}{(m+2)(m-1)}=\frac{m-2}{2(m-1)} .$$

**So at every balanced product the value L27 states without source is a theorem**, and $\lambda_m<\tfrac12$ follows. The balanced case is exactly what [Lemma L3](../findings/second-order.md)'s promotion at even $n\ge8$ and [Lemma L69](../findings/graded-half.md) turn on. For unbalanced $p\ne q$ the same identity gives one equation in $\lambda_p$ and $\lambda_q$; adding only "$\lambda_m$ depends on $m$ alone", which the record's criticality-free form $\lambda_m=\tfrac{m-2}2(\varepsilon_{mm}-\varepsilon_{PQ})$ of F6 supports, makes $f-g$ a constant summing to zero in pairs, hence identically zero, and the unbalanced case closes too.

### F12, no citation takes a strengthening (attack 6)

Sampled the load-bearing sites of the 242 mentions. Every non-review use of L27 sits inside the stated hypotheses:

| site | what it takes | inside scope? |
| --- | --- | --- |
| [second-order.md:39](../findings/second-order.md#L39), [results.md:114](../results.md#L114), [INDEX-results.md:18](../findings/INDEX-results.md#L18), L3's promotion | $\lambda_{\max}=\tfrac12$ attained exactly on the orbit, balanced $(m,m)$, even $n\ge8$ | yes: $m\ge4$, and the one refusal $(3,3)$ is exactly the one case L3 is false ($n=6$) |
| [graded-half.md:343](../findings/graded-half.md#L343), L69's nondegeneracy half | the same, at $p,q\ge5$ | yes, strictly interior |
| [second-order.md:894](../findings/second-order.md#L894) | "attained exactly on the orbit tangent … covers every $n=2m\ge12$" | yes |
| [second-order.md:735,741](../findings/second-order.md#L735), L127 | L27's summand list for the $\mathcal D_n$ row; explicitly says it "does not establish nondegeneracy independently" | yes, and it declares its dependence |
| [second-order.md:785](../findings/second-order.md#L785), L128.1 | "**Assume $p,q\ge3$** … at $p=2$ it over-counts, $86$ against $84$" | yes, and it carries the $p=2$ warning |
| [nondegeneracy.md:442](../findings/nondegeneracy.md#L442), L11 | $\tfrac12$ attained on the orbit alone in the surviving range | yes |
| [second-order.md:1103,1168](../findings/second-order.md#L1103), L145/L146 | $\lambda_m$ as a *scalar* on the $S^2_0$ summands | yes on scope, **but this is where F9's unsourced value is spent** |

Two near-misses already caught by the record rather than by me, and both hold up: [LEDGER.md:767](../findings/LEDGER.md#L767), a downstream block used $\tfrac12-\lambda_m$ where it needed a different margin, and the error ran in the safe direction; and [nondegeneracy.md:736](../findings/nondegeneracy.md#L736), the identity $\tfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ is the gap to the family-B block and **not** the spectral gap, the true second eigenvalue being $\lambda_{\max(p,q)}$ (except at $(3,4)$, where $\mu=\tfrac5{12}$ overtakes $\lambda_4=\tfrac13$).

**That last one is the "wrong quantity" trap the brief warns about, and L27 does not fall into it.** The block never calls that expression a gap or a margin; it uses it only as the strict inequality $\tfrac12-\mu>0$, which is exactly what "attained on the orbit summand alone" needs. Checked where the record says what that quantity is: [nondegeneracy.md:746](../findings/nondegeneracy.md#L746), "The family-B statement, correct as such". The correction paragraph itself concludes "**Nondegeneracy is unaffected**". I independently verified the exception set: $\mu>\lambda_{\max(p,q)}$ iff $M(2-m)+3m-4>0$ with $m=\min$, $M=\max$, whose only solutions at $p,q\ge3$ are $(3,3)$ (where $\mu=\tfrac12$) and $(3,4)$, with $(4,4)$ a tie at $\tfrac13$, matching the record exactly.

### F13, the file's own later sections corroborate rather than contradict

The brief warns that seven results this session were refuted by passages below them in their own file. I read [nondegeneracy.md:588–760](../findings/nondegeneracy.md#L588) in full. Every later passage either restates L27 (the heading at line 736), scopes it (lines 666, 748), or supplies a piece of it (lines 700–736). The exact-spectra table at line 674 is reproduced character for character by L27's ten values (F5). The one apparent collision, the $(3,3)$ isomorphism at line 129, is an $SO$-versus-$O$ difference and dissolves (F10). **No contradiction found.**

### F14, CORRECTION TO F9, made before the verdict: $\lambda_m$ *is* derived on the record, and my F6 reconstruction is that derivation

I wrote in F9 that $\lambda_m$ has "no argument in the block and none found in the record". **That is wrong, and I withdraw it.** The derivation is at [second-order.md:589](../findings/second-order.md#L589), under the $\mathrm{Sym}_0$ deformation framing rather than the summand framing, which is why the grep on $\lambda_m$ did not lead there first:

> "**The block closed form is DERIVED.** *Gate 2, Reviewers 301 and 302 on identical briefs … 302 supplied the proof the record owed.*", write the sphere product's Weyl part with $a$ on $pp$ pairs, $b$ on $qq$, $c=-s$ mixed; Ricci-freeness gives $a=qs/(p-1)$, $b=ps/(q-1)$, criticality $\theta=(n-1)s$; for trace-free $A$ in the first block the Weyl projection leaves the shape $\beta(\alpha_i+\alpha_j)$ on $pp$, $0$ on $qq$, $\gamma\alpha_i$ mixed, subject to $\beta(p-2)+q\gamma=0$, "**that condition makes the shape one-dimensional, which is what forces scalarity**", and the $pp$ entry collapses to $\lambda=\frac{(p-2)(a-c)}{2\theta}=\frac{p-2}{2(p-1)}$.

Checked cold. $a-c=\tfrac{qs}{p-1}+s=s\tfrac{n-1}{p-1}$, so $\lambda=\tfrac{(p-2)s(n-1)}{2(p-1)(n-1)s}=\tfrac{p-2}{2(p-1)}$. The passage's own cross-check also closes: the mixed entry gives $\tfrac{(n-2)(p-1)-q}{2(n-1)(p-1)}$, and $(n-2)(p-1)-q=(p-1)(p-2)+q(p-2)=(p-2)(n-1)$, so the two routes agree identically in $p,q$. It answers the $q$-independence the same passage earlier called unexplained.

**And it is exactly the form I reconstructed in F6.** $\tfrac{p-2}2(\varepsilon_{PP}-\varepsilon_{PQ})=\tfrac{(p-2)(a-c)}{2\theta}$, the same expression, reached from the recorded values without having seen the derivation. F6 stands as an independent confirmation of second-order.md's result rather than as a substitute for it.

The residue of F9 is therefore **one** unsourced value in the block, not two, and it is a **citation defect**: "$-\mu$ and $+\mu$ on the two tensor summands, by Lemma L26" attributes to L26 a value L26 does not state.

### F15, and that last value is forced, uniquely, by F11's trace identity

With the other nine values now each carrying a derivation, $1$ (immediate), $\tfrac12$ (F4), $\lambda_p,\lambda_q$ (F14), $+\mu$ (L26), four zeros ([nondegeneracy.md:708,716](../findings/nondegeneracy.md#L708)), the identity $\operatorname{tr}L_e=0$ of F11 is one linear equation in the single remaining unknown $\nu$, the scalar on $S^2_0\otimes S^2_0$:

$$\nu\,s_ps_q=-\Big[1+\tfrac{pq}2+\tfrac{p^2-4}4+\tfrac{q^2-4}4+\mu\,c_pc_q\Big]=-\tfrac{n^2-4}4-\mu\,c_pc_q,$$

and since $\mu(s_ps_q-c_pc_q)=\tfrac{n^2-4}4$ identically (F11), the unique solution is $\nu=-\mu$. **So the block's tenth value is a theorem, and the sign assignment is forced rather than assumed.** I reached the trace identity independently and cold; [LEDGER.md:795](../findings/LEDGER.md#L795) records r530 reaching it concurrently and using it for the same repair, and [r528](REVIEW_r528.md) as having raised the gap. Convergence, not inheritance, my F11 proof is written out above and rests on $O(n)$-irreducibility of $\mathcal W_n$.

One qualification on the ledger's phrasing: the trace identity forces the value **uniquely only because the other nine are independently derived**. Taken alone it is one equation in several unknowns and would not settle anything; the ledger's "forces it uniquely" is right in context and would be an overstatement out of it.

### F16, one live internal inconsistency, in the file but not in the block

[nondegeneracy.md:690](../findings/nondegeneracy.md#L690) writes "the eigenvalues are $\pm\mu$ at multiplicities $s_ps_q$ and $c_pc_q$", which read in order puts $+\mu$ on the **symmetric** summand $S^2_0\otimes S^2_0$. **The block's assignment is the opposite and the block is right.** Three independent confirmations, one of them mine before I saw the ledger:

1. The exact-spectra table two lines above line 690 has $-\tfrac38$ at multiplicity $70=s_3s_5$ at $3{+}5$ and $-\tfrac14$ at $196=s_5s_5$ at $5{+}5$, the table contradicts the sentence beneath it.
2. My F5 reconstruction only reproduces the table under the block's assignment.
3. The trace identity vanishes under the block's assignment and not under the reverse.

Also: L26's eigenvector $X=\phi_\pi\odot\phi_\rho$ with $\pi\subset P$, $\rho\subset Q$ coordinate $2$-planes lies in $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$, so the $+\mu$ L26 proves is on the antisymmetric summand by construction. Nothing cites line 690, so this is a text defect rather than a spread.

---

## VERDICT: CONFIRMED

**Lemma L27 is true as stated, and its argument is sound at every step I could attack.**

### What closes

| step | status |
| --- | --- |
| ten-summand decomposition, credited to Nienhaus Prop 4.6 | **confirmed against the source's own summary display**, which additionally states $O(k)\times O(l)$-irreducibility "for any $k,l\ge3$", exactly L27's hypothesis. The $k,l\ge5,\ k,l\ne6$ restriction belongs to the $S^2(\mathfrak{so}(n))$ statement and is $SO$-specific (F1) |
| ten dimensions sum to $\dim\mathcal W_n$ identically in $p,q$ | **confirmed**, by hand and by symbolic screen; difference expands to $0$ (F2) |
| multiplicity-freeness, including $p=q$ | **confirmed**; the pair-label reading is what makes it work, and both of the brief's collision candidates are separated by the external tensor structure, the $m=3$ dimension ties by the $\det$-twist (F7) |
| Schur $\Rightarrow$ scalar per summand | **sound**; the stated reason is compressed and the missing line is supplied (F8) |
| $\tfrac12$ on the orbit tangent | **derived independently**; and the constrained Hessian is $6\theta(L_e-\tfrac12)$, so the spectral statement and Morse–Bott nondegeneracy are the same statement (F4) |
| $+\mu$ on $\Lambda^2\otimes\Lambda^2$ | Lemma L26, and its $\varepsilon$-values reproduce Nienhaus Prop 2.25's $\theta_{k,l}$ exactly (F3) |
| $\lambda_m$ on $S^2_0(\mathbb R^m)$ | **derived on the record** at [second-order.md:589](../findings/second-order.md#L589), which I re-derived cold and which matches my independent reconstruction (F6, F14) |
| $-\mu$ on $S^2_0\otimes S^2_0$ | **forced uniquely** by $\operatorname{tr}L_e=0$ given the other nine (F11, F15) |
| nothing exceeds or ties $\tfrac12$ off the orbit | **confirmed**: $\lambda_m<\tfrac12$ always, $-\mu<0$, and $+\mu<\tfrac12\iff(p-2)(q-2)\ge2$ (F10) |
| $(3,3)$ excluded, $\dim E(\tfrac12)=18$ against orbit $9$ | **confirmed from the ten values**; full spectrum $-\tfrac12^{25},0^{30},\tfrac14^{10},\tfrac12^{18},1^1$ summing to $84$ (F10) |
| $p\ge3$ needed | **confirmed twice over**: $\mu=\tfrac12+\tfrac1{2(n-3)}>\tfrac12$ at $p=2$, and the summand list over-counts by $2$ there (F10) |
| the 58 citations | **no strengthening taken**; the two heaviest, L3's promotion at even $n\ge8$ and L69 at $p,q\ge5$, sit strictly inside the hypotheses (F12) |
| later sections of the same file | **corroborate**; the apparent $(3,3)$ collision at line 129 is $SO$ against $O$ and dissolves (F13) |

### Two defects, neither touching the conclusion

1. **Citation defect (in the block, unrepaired).** *"$-\mu$ and $+\mu$ on the two tensor summands, by Lemma L26"*, L26 supplies one eigenvector, on $\Lambda^2\otimes\Lambda^2$ only. Already logged at [LEDGER.md:771](../findings/LEDGER.md#L771). **Suggested repair**: replace the attribution with L26 for $+\mu$ and $\operatorname{tr}L_e=0$ for $-\mu$, quoting F11's two-line proof, and add the $\lambda_m$ pointer to [second-order.md:589](../findings/second-order.md#L589), which the block also omits.
2. **Wording defect (in the block and at line 700).** *"since $L_e$ is symmetric the $\mathbb C$ and $\mathbb H$ Schur cases cannot occur"*. Read as naming Schur's *outcomes* it is true; read as naming the representations it is false, since symmetry of an operator cannot change a representation's type. **Suggested repair**: "a symmetric element of a real division algebra of operators has a real eigenvalue, so it is a real scalar, which covers all three Schur cases at once."

### One text defect elsewhere in the file

[nondegeneracy.md:690](../findings/nondegeneracy.md#L690) assigns $+\mu$ to $S^2_0\otimes S^2_0$, against its own table two lines above, against L26's construction, and against the trace identity. Nothing cites it (F16).

### What I did not do

No searches, sweeps, censuses or falsifier hunts. Three screens, seconds each, on objects built for the screen: the dimension-sum identity, the spectrum reconstruction against the recorded table, and the trace identity, each reported as corroboration of a hand derivation written out above, never as evidence on its own.
