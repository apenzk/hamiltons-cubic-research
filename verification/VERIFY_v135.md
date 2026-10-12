# VERIFY v135, Lemma L27: the ten-summand spectrum of $L_e$ at $W_{p,q}$, $\lambda_{\max}=\tfrac12$ on $W^\perp$, and $\dim E(\tfrac12)=pq=\dim(\text{orbit})$

**Cold brief.** Verifier v135 on round [L27](ROUND_L27.md). Target: [findings/nondegeneracy.md](../findings/nondegeneracy.md):457–502, with the canonical statement at [results.md](../results.md):423 and the landscape line at [results.md](../results.md):140. **No numerical work was done. No script was run. Every number below is an exact hand evaluation**, and where the record's own figures were checked they were re-derived symbolically and then evaluated at the printed points. Log: [agent_logs/verify-L27-v135.log](../agent_logs/verify-L27-v135.log). No other verifier's report was read; the reviews cited below ([r34](../reviews/REVIEW_r34.md), [r36](../reviews/REVIEW_r36.md), [r38](../reviews/REVIEW_r38.md), [r529](../reviews/REVIEW_r529.md), [r530](../reviews/REVIEW_r530.md)) were read because the record cites them or because they are the only place a claimed argument lives. [Nienhaus](../references/nienhaus-2023-second-best-einstein/) is on file and Proposition 4.6 with its summary display and Remark 4.7 were read from the extraction, not from memory.

## Claim table

| # | Claim, as the block states it | Verdict |
| --- | --- | --- |
| C1 | The ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$ | **PROVEN**, re-derived as a polynomial identity, not a spot check |
| C2 | The Young labels are pairwise distinct for every $p,q\ge3$, so the decomposition is multiplicity-free | **PROVEN**, but the ten labels are nowhere written in the block; they are in [r530](../reviews/REVIEW_r530.md), which the block does not cite |
| C3 | A symmetric element of a real division algebra of operators is a real scalar, so $L_e$ is scalar on each summand | **PROVEN**, one step (a non-invertible element of a division algebra is zero) is compressed out of the sentence |
| C4 | $1$ on $\langle W\rangle$ | **PROVEN**, no argument in the block; immediate from [second-order.md](../findings/second-order.md):11, which states $e$ is an idempotent |
| C5 | $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ | **PROVEN**, the differentiation argument is complete and uses only criticality |
| C6 | $\lambda_m=(m-2)/(2(m-1))$ on $S^2_0(\mathbb R^m)$ | **PROVEN**, derived at [second-order.md](../findings/second-order.md):593–597; **but the same file at :599–603 calls the same formula "a fit and not a proof"** |
| C7 | $+\mu$ on $\Lambda^2\otimes\Lambda^2$ by [L26](../findings/nondegeneracy.md) | **PROVEN**, with one unstated step: that L26's eigenvector lies in that summand |
| C8 | $-\mu$ on $S^2_0\otimes S^2_0$, forced uniquely by $\operatorname{tr}L_e=0$ given the other nine | **PROVEN**, the trace identity re-derived by hand and it closes to $0$ identically |
| C9 | $0$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | **PROVEN, MISATTRIBUTED**, the $X_p\otimes\mathbb R^q$ index computation is written out at [nondegeneracy.md](../findings/nondegeneracy.md):730–736 and at [r38](../reviews/REVIEW_r38.md):7, credited to Reviewers 38 and 39; the block's Sources line names 34 and 35, and [r34](../reviews/REVIEW_r34.md) records the constant as still owed |
| C10 | $\tfrac12-\mu>0$ for $p,q\ge3$, $(p,q)\ne(3,3)$, so $\tfrac12$ is on the orbit summand alone | **PROVEN** |
| C11 | $\dim E(\tfrac12)=pq$ **and** $\dim(\text{orbit})=pq$, and the two spaces coincide | **PROVEN**, three claims, all three present; the orbit dimension is Nienhaus 4.6(b), not the block's own |
| C12 | At $(3,3)$, $\mu=\tfrac12$ and $\dim E(\tfrac12)=18$ against orbit $9$ | **PROVEN** |
| C13 | The exclusion $q\le2$ | **PROVEN, and forced by the object**, the ten-summand list over-counts by $2$ at $q=2$ and by $1+p$ at $q=1$ |
| C14 | "A symbolic solve over all $45$ summand pairs finds it the only such coincidence" | **WORDING**, false on the literal reading, witness $(3,5)$ where $\mu=\lambda_q=\tfrac38$; true on the intended $\tfrac12$ reading |
| C15 | "It also discriminates the assignment: … a trace of $30$ … $70$ … never zero" | **CORRECT, and it is the same equation**, the residual is exactly $(n^2-4)/2$; the four printed numbers are right |
| C16 | The landscape line at [results.md](../results.md):140 | **THE NAMED TRAP**, it drops $n=p+q$, and the record's own padding result makes that omission load-bearing |
| C18 | "The list needs … $n\ge5$ for the count", [nondegeneracy.md](../findings/nondegeneracy.md):764 | **FALSE**, $37$ against $35$ at $(3,2)$, $n=5$; $86$ against $84$ at $(4,2)$. The correct criterion is $p,q\ge3$ |
| C19 | The same file's parallel exposition at [nondegeneracy.md](../findings/nondegeneracy.md):712 and :718 | **STALE**, ":718 is verbatim the sentence :483 exists to retract"; :712 calls the list "numerical" against :726 |
| C17 | "The $p,q\ge5$ case is proved in the source" | **UNDERSTATES THE SOURCE**, the summary display asserts $O(k)\times O(l)$-irreducibility for $k,l\ge3$, which is exactly L27's hypothesis and group |

**One-line summary.** The statement is **true as written and its argument is sound**; five defects sit beside it rather than in it, a scope paragraph that declares the summand list safe at $n\ge5$ when it fails at $(3,2)$ by $37$ against $35$, a parallel exposition in the same file still carrying the Schur non-sequitur its canonical block was written to retract, a cited derivation the cited file calls "a fit and not a proof" six lines later, a Sources line crediting the one review that records the claim as owed, and a landscape line that drops the hypothesis $n=p+q$ the record's own padding result makes indispensable, **verdict `PROVEN, hypotheses corrected`.**

## 0. Conventions, fixed once

- $n=p+q$ throughout, and $W=W_{p,q}\in\mathrm{Weyl}_n$ is the sphere-product Weyl operator. **The ambient dimension is exactly $p+q$**; nothing here concerns a zero-padded $W_{p,q}$ sitting in $\mathrm{Weyl}_N$ with $N>p+q$.
- $X\circ Y=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$, $e=W/\theta$ with $\theta=P(W)>0$, and $L_e=e\circ(\cdot)$, the definitions at [second-order.md](../findings/second-order.md):56.
- $\mathrm{Hess}_SP=6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$ on the tangent space to the unit sphere, i.e. on $W^\perp$, [Lemma L24](../findings/second-order.md).
- $\dim\mathrm{Weyl}_m=\tfrac1{12}m(m+1)(m+2)(m-3)=\tfrac1{12}(m^4-7m^2-6m)$. I write $W_m$ for that **polynomial**, which is the dimension only for $m\ge3$.
- $s_m:=\dim S^2_0(\mathbb R^m)=\tfrac12(m+2)(m-1)$, $c_m:=\dim\Lambda^2(\mathbb R^m)=\tfrac12m(m-1)$, $X_m:=\tfrac13m(m^2-4)$.
- $\lambda_m=\dfrac{m-2}{2(m-1)}$ and $\mu=\dfrac{n-2}{2(p-1)(q-1)}$.
- An $O(m)$-irreducible is labelled by a partition $\lambda$ with $\lambda'_1+\lambda'_2\le m$, distinct labels giving inequivalent irreducibles; $V_\lambda\otimes\det\cong V_{\lambda^*}$ with $\lambda^*$ got by replacing the first column length $\lambda'_1$ by $m-\lambda'_1$.

## 1. The hypothesis inventory

### 1a. Hypotheses the block states

| Hypothesis | Where used in the written proof |
| --- | --- |
| $p,q\ge3$ | four separate places: the source's $O(k)\times O(l)$ clause is stated for $k,l\ge3$; the labels $[1,1]$ and $[2,1]$ need $m\ge3$ to be admissible; the ten-summand **dimension** identity needs $\mathrm{Weyl}_p$ to have the polynomial's value, which first happens at $p=3$; and $(p-2)(q-2)\ge1$ |
| $(p,q)\ne(3,3)$ | once only, in the final strict inequality $\tfrac12-\mu>0$ |
| $n=p+q$ | everywhere, the decomposition is of $\mathrm{Weyl}_{p+q}$ |

### 1b. Hypotheses the block uses and does not state

| Hypothesis | Why it is needed | Status on file |
| --- | --- | --- |
| $W_{p,q}$ is a critical point of $P$ with $\theta>0$ | $e=W/\theta$ is undefined without it; the $\tfrac12$ on the orbit is got by differentiating $Q(W_t)=\theta W_t$; and $L_e e=e$ needs $e\circ e=e$ | on file elsewhere ($\theta^2$ closed form, [Lemma L24](../findings/second-order.md)); **absent from the statement and from the argument's preamble** |
| $L_e$ is self-adjoint for the $O(n)$-invariant inner product on $\mathrm{Weyl}_n$ | the word "symmetric" in the division-algebra step is doing all the work | **derived** at [second-order.md](../findings/second-order.md):62, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric; **not cited by the block** |
| the summands are mutually orthogonal | so that $L_e$ preserving each is what multiplicity-freeness gives, and so that "$\lambda_{\max}$ on $W^\perp$" reads off the summand values | supplied by the source, Nienhaus's display says "This decomposition is **orthogonal** and irreducible"; **not quoted by the block** |
| the stabiliser of $W_{p,q}$ in $SO(n)$ has identity component $SO(p)\times SO(q)$ | this, and nothing in the block, is what makes $\dim(\text{orbit})=pq$ | Nienhaus 4.6(b), read below |

### 1c. Hypotheses of every imported result, checked against the object

| Import | Its hypotheses | Met? |
| --- | --- | --- |
| Nienhaus Proposition 4.6 **proper** (the $18$-summand $S^2(\mathfrak{so}(n))$ statement) | $k,l\ge5$ **and** $k,l\ne6$, group $SO(k)\times SO(l)$ | **not met and not needed**, L27 uses the summary display, not 4.6 proper |
| Nienhaus, the **summary display** after 4.6(a)–(f) | "orthogonal and irreducible under $SO(k)\times SO(l)$ for any $k,l\ge5$. Furthermore, it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$" | **met exactly**, $p,q\ge3$, group $O(p)\times O(q)$ |
| [Lemma L26](../findings/nondegeneracy.md) | $p,q\ge2$; $\pi$ a coordinate $2$-plane in the $p$-block, $\rho$ in the $q$-block; $X=\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ part removed | met ($p,q\ge3\subset p,q\ge2$) |
| [second-order.md](../findings/second-order.md):593–597, the $\lambda_m$ derivation | the sphere product's block form with Ricci-freeness $a=qs/(p-1)$, $b=ps/(q-1)$, criticality $\theta=(n-1)s$; $A$ traceless in the first block; and $p\ge3$, since the same file at :753 records the value **false at $p=2$** | met |
| [r34](../reviews/REVIEW_r34.md):9, the $\mathrm{Weyl}_k$ vanishing | one route uses $L_{I_n}\equiv0$ on $\mathrm{Weyl}_n$ (Böhm–Wilking, $\mathrm{Ric}=0$); the other uses $\Phi(V)=2V$ on $\mathrm{Weyl}_n$ | met; **the Böhm–Wilking import is not named in the block** |
| [r38](../reviews/REVIEW_r38.md):7, the $X_p\otimes\mathbb R^q$ vanishing | its own text: "holds for all $p$ and $q$ with **no** Schur, **no** irreducibility and **no** $p,q\ge3$" | met vacuously |
| [Lemma L24](../findings/second-order.md), for the word "Morse–Bott" | $W$ critical, $\theta>0$ | met, unstated |

### 1d. Which of these the written proof actually uses

The proof as written uses: the summary display (for the ten summands and their irreducibility), $p,q\ge3$ (four times, as above), self-adjointness of $L_e$ (unstated), criticality (unstated), L26, the $\lambda_m$ derivation, the two vanishing arguments, the trace identity, and $(p,q)\ne(3,3)$ once. **It does not use** Proposition 4.6 proper, the $k,l\ne6$ exclusion, or Remark 4.7(ii), the last is in the Sources line but is a one-sentence remark ("There is a similar decomposition, if $k,l\le4$") that carries no proof and is not load-bearing once the display's $k,l\ge3$ clause is read.

## 2. Pre-registered question 1, is the decomposition multiplicity-free, and does the Schur step follow?

### 2a. The dimension sum, as an identity rather than a spot check

The block says "the ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$". I checked this as an algebraic identity, since agreement at four points would not settle a polynomial of degree four in each variable.

Write $T=1+W_p+W_q+pq+s_p+s_q+s_ps_q+c_pc_q+qX_p+pX_q$. From $W_m=\tfrac1{12}(m^4-7m^2-6m)$ and $n=p+q$,

$$W_n-W_p-W_q=\frac{4p^3q+4pq^3+6p^2q^2-14pq}{12}=\frac{2p^3q+2pq^3+3p^2q^2-7pq}{6},$$

so what the remaining eight terms must supply is that expression. They do:

- $1+s_p+s_q+s_ps_q=(1+s_p)(1+s_q)$, and $1+s_m=\tfrac12 m(m+1)$, so this is $\tfrac14p(p+1)q(q+1)$.
- $c_pc_q=\tfrac14p(p-1)q(q-1)$.
- $qX_p+pX_q=\tfrac13pq\big[(p^2-4)+(q^2-4)\big]=\tfrac13pq(p^2+q^2-8)$.

Hence, factoring $pq$ out of all four remaining terms and using $(p+1)(q+1)+(p-1)(q-1)=2pq+2$,

$$T-W_p-W_q=pq\Big[1+\frac{2pq+2}{4}+\frac{p^2+q^2-8}{3}\Big]=pq\cdot\frac{6+3pq+3+2p^2+2q^2-16}{6}=\frac{2p^3q+2pq^3+3p^2q^2-7pq}{6}.$$

The two agree term by term. **The identity is exact in $p,q$ as polynomials, no finding.** Evaluated at four points as a sanity check on the algebra: $(3,3)\to84=\dim\mathrm{Weyl}_6$; $(3,4)\to168=\dim\mathrm{Weyl}_7$; $(4,4)\to300$ and $(3,5)\to300$, both $=\dim\mathrm{Weyl}_8$.

**The one thing to hold on to for §3**: this is an identity in the *polynomials* $W_p,W_q,X_p,X_q$, and those equal the dimensions they name only for $p,q\ge3$.

### 2b. The ten labels, their admissibility, and their distinctness

The block asserts distinctness and **never writes the labels down**. They are on file at [r530](../reviews/REVIEW_r530.md):50–60, which the block does not cite. Read off the summands, as ordered pairs of $O(p)$- and $O(q)$-labels:

$$([\,],[\,]),\ ([2,2],[\,]),\ ([\,],[2,2]),\ ([1],[1]),\ ([2],[\,]),\ ([\,],[2]),\ ([2],[2]),\ ([1,1],[1,1]),\ ([2,1],[1]),\ ([1],[2,1]).$$

Ten distinct ordered pairs, by inspection. Three checks the block does not make and that I did:

- **Admissibility.** $[1,1]$ and $[2,1]$ have $\lambda'_1+\lambda'_2=2$ and $3$, so they need $m\ge2$ and $m\ge3$; $[2,2]$ has $\lambda'_1+\lambda'_2=4$ and needs $m\ge4$. At $p=3$ the label $[2,2]$ is inadmissible and $\mathrm{Weyl}_3=0$, the list degenerates by losing a summand, not by breaking. This is exactly why $p,q\ge3$ and not $p,q\ge2$.
- **The ordered pairs stay distinct at $p=q$.** The permutation that would identify $([2],[\,])$ with $([\,],[2])$ lies in $O(n)$ and not in $O(p)\times O(q)$, and $O(p)\times O(q)$ is the group the argument uses. So no $2\times2$ Schur block appears at the balanced product, the case the programme cares about most.
- **The group must be $O$, not $SO$, and $\dim X_m=\tfrac13m(m^2-4)$ is right.** $X_m$ is the $O(m)$-irreducible $[2,1]$, of dimension $\tfrac13m(m^2-1)-m=\tfrac13m(m^2-4)$: $5$, $16$, $35$ at $m=3,4,5$, consistent with $\binom m2 m=\binom m3+m+X_m$ ($24=4+4+16$ at $m=4$, $50=10+5+35$ at $m=5$). At $m=3$ the associated partition of $[2,1]$ is $[2]$ and that of $[1,1]$ is $[1]$, so $X_3\cong S^2_0(\mathbb R^3)\otimes\det$ and $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$, **two dimension coincidences that would fuse under $SO(3)$ and do not under $O(3)$.** The block's own $(3,3)$ paragraph says this with the right numbers.

**No finding on the mathematics.** One finding on the writing: the block's stated discharge for $p,q\le4$ is "exact $O(m)$-commutant computation at $m=3,4$", **a computation, offered as the ground of a positive claim.** It is not needed: distinct admissible labels give inequivalent $O(m)$-irreducibles, so multiplicity-freeness follows from the source's irreducibility clause alone at every $p,q\ge3$. What the computation actually adds is confirmation of the two $\det$-twist coincidences above.

### 2c. The division-algebra step, and what is really needed

The block writes: *"a symmetric element of a real division algebra of operators has a real eigenvalue and is therefore a real scalar, which covers $\mathbb R$, $\mathbb C$ and $\mathbb H$ alike"*. The step is correct, and it is worth writing out because the block compresses one link out of it.

Let $V$ be one summand, $D=\mathrm{End}_{O(p)\times O(q)}(V)$. Multiplicity-freeness gives $\mathrm{Hom}(V_i,V_j)=0$ for $i\ne j$, so equivariance of $L_e$ makes each summand invariant and $L_e|_V\in D$; Schur makes $D$ one of $\mathbb R,\mathbb C,\mathbb H$. Now $L_e|_V$ is self-adjoint for the invariant inner product, so it **has a real eigenvalue** $\lambda$. Then $L_e|_V-\lambda\,\mathrm{Id}\in D$ and is **not invertible**; in a division algebra the only non-invertible element is $0$. Hence $L_e|_V=\lambda\,\mathrm{Id}$.

**The compressed link is "not invertible, hence zero".** Without it "has a real eigenvalue and is therefore a real scalar" is a jump; with it the sentence is exactly right, and the parenthesis "which covers $\mathbb R$, $\mathbb C$ and $\mathbb H$ alike" is precise.

**Is symmetry what makes it work?** Yes, but it is not the weakest hypothesis, and the pre-registered question deserves both halves of the answer:

- **Strictly weaker sufficient condition.** All the argument consumes is *the existence of one real eigenvalue*. Any equivariant operator on $V$ with a real eigenvalue is scalar. Symmetry is one way to guarantee that; it is not the only one.
- **Where it is unnecessary altogether.** If $D=\mathbb R$ (the summand of real type, equivalently absolutely irreducible) then *every* equivariant operator is scalar and symmetry buys nothing. Every irreducible representation of a full orthogonal group $O(m)$ is of real type, and a tensor product of two such is too, so in fact $D=\mathbb R$ throughout here and the symmetry hypothesis is dispensable. **The block's parenthetical care over $\mathbb C$ and $\mathbb H$ is therefore belt-and-braces**, which is the right way round: it makes the step valid without needing the real-type fact.
- **What symmetry cannot do**, and the block says so in its own italics: it cannot change a representation's type. The italic clause "*it cannot, as the first version had it, change a representation's type*" is a correction that has landed **inside** the argument rather than beside it. Credit where due, that is the one place in this block where the record's signature failure was avoided.

## 3. The ten values, one at a time, and where each argument actually lives

| summand | dimension | value | where the argument is |
| --- | --- | --- | --- |
| $\langle W\rangle$ | $1$ | $1$ | **nowhere in the block.** Immediate from $e\circ e=Q(e)=e$, and [second-order.md](../findings/second-order.md):11 does say $e$ is an idempotent of $\circ$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $pq$ | $\tfrac12$ | in the block, complete |
| $S^2_0(\mathbb R^p)$, $S^2_0(\mathbb R^q)$ | $s_p$, $s_q$ | $\lambda_p$, $\lambda_q$ | [second-order.md](../findings/second-order.md):593–597, **contradicted at :599–603 of the same file** |
| $\Lambda^2\otimes\Lambda^2$ | $c_pc_q$ | $+\mu$ | [Lemma L26](../findings/nondegeneracy.md), with one unstated membership step |
| $S^2_0\otimes S^2_0$ | $s_ps_q$ | $-\mu$ | the trace identity, in the block |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$ | $W_p$, $W_q$ | $0$ | [r34](../reviews/REVIEW_r34.md):9, two routes; the block cites "Reviewers 34 and 35" |
| $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $qX_p$, $pX_q$ | $0$ | [r38](../reviews/REVIEW_r38.md):7, **which the block never names** |

### 3a. $\tfrac12$ on the orbit summand

$Q$ is $O(n)$-equivariant, so along $W_t=g_t\!\cdot\!W$ inside the orbit, $Q(W_t)=\theta W_t$ holds identically. $Q$ is quadratic, so $DQ_W(X)=2\,W\circ X=2\theta\,e\circ X$. Differentiating at $t=0$ gives $2\theta\,e\circ\dot W=\theta\dot W$, i.e. $L_e\dot W=\tfrac12\dot W$. **Complete, and it uses only criticality and equivariance**, no property of $W_{p,q}$, which is why the same statement holds at every critical point and why this value carries no information about the sphere product specifically.

### 3b. $+\mu$ on $\Lambda^2\otimes\Lambda^2$, and the step the block does not write

L26 exhibits **one** eigenvector: $X=\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ part removed, $\pi$ a coordinate $2$-plane in the $p$-block and $\rho$ one in the $q$-block, and $e\circ X=\mu X$. To read that as *the summand's scalar*, one needs $X$ to be a nonzero element of the $\Lambda^2\otimes\Lambda^2$ summand. It is: Nienhaus 4.6(d) says the copy of $\Lambda^2(\mathbb R^k)\otimes\Lambda^2(\mathbb R^l)$ inside $\mathrm{Weyl}_n$ is the part of $(\mathfrak{so}(k)\otimes\mathfrak{so}(l))\oplus(\Lambda^2\otimes\Lambda^2)$ complementary to $\Lambda^4(\mathbb R^n)$, which is precisely "$\phi_\pi\odot\phi_\rho$ with the $\Lambda^4$ component removed". **The block asserts the transfer and does not argue it; the source supplies it in one clause.** Not a defect, a compression.

### 3c. $-\mu$ on $S^2_0\otimes S^2_0$, and the trace identity re-derived

$\mathcal W_n$ is $O(n)$-irreducible and non-trivial, so the invariant vector $\sum_iQ(V_i)$ vanishes and $\operatorname{tr}_{\mathcal W_n}L_e=0$ unconditionally. I evaluated the trace of the ten listed values by hand. Writing $x$ for the unknown value on $S^2_0\otimes S^2_0$:

$$\operatorname{tr}L_e=1\cdot1+\tfrac12\,pq+\lambda_ps_p+\lambda_qs_q+\mu\,c_pc_q+x\,s_ps_q+0.$$

Three pieces, each exact:

$$\lambda_ms_m=\frac{m-2}{2(m-1)}\cdot\frac{(m+2)(m-1)}{2}=\frac{m^2-4}{4},\qquad \mu\,c_pc_q=\frac{n-2}{2(p-1)(q-1)}\cdot\frac{pq(p-1)(q-1)}{4}=\frac{(n-2)pq}{8},$$

$$\mu\,s_ps_q=\frac{n-2}{2(p-1)(q-1)}\cdot\frac{(p+2)(p-1)(q+2)(q-1)}{4}=\frac{(n-2)(p+2)(q+2)}{8}.$$

Putting $x=-\mu$ and combining the last two:

$$\frac{n-2}{8}\big[pq-(p+2)(q+2)\big]=\frac{n-2}{8}\big[-2p-2q-4\big]=-\frac{(n-2)(n+2)}{4}=-\frac{n^2-4}{4}.$$

Since $(p^2-4)+(q^2-4)-(n^2-4)=p^2+q^2-8-p^2-2pq-q^2+4=-2pq-4$,

$$\operatorname{tr}L_e=1+\frac{pq}{2}+\frac{-2pq-4}{4}=1+\frac{pq}{2}-\frac{pq}{2}-1=0.$$

**The identity closes to zero identically in $p,q$, confirmed, by hand, exactly.** And since $s_ps_q\ne0$ for $p,q\ge3$ (indeed $s_m\ge5$), the equation determines $x$ uniquely given the other nine. **The block's uniqueness claim is correct.**

**What the identity does not do.** It is *one* scalar equation. Used to determine $x$, it is spent: it can no longer independently check the value it produced. Its remaining content is a single joint constraint on the other nine values, real, but one equation against nine numbers. **The block's heading "The list checks itself" is fair only in that weak sense**, and the block's own next clause ("given the other nine it forces $-\mu$ uniquely") states the correct reading. *No finding; scope note.*

### 3d. The four zeros, and where their arguments actually are

These four are load-bearing twice over: for $\lambda_{\max}=\tfrac12$, and for the trace identity, which forces $-\mu$ **only given that the four are zero**. So each needs its own argument.

- $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$: [r34](../reviews/REVIEW_r34.md):9 records two independent proofs, one through $\Phi(V)=2V$ on $\mathrm{Weyl}_n$ with an $n$-independence argument by zero-padding, one through $e=\eta I_n+(A-\eta)I_p+(B-\eta)I_q$ with $L_{I_n}\equiv0$ on $\mathrm{Weyl}_n$ (Böhm–Wilking, $\mathrm{Ric}=0$) plus a support argument. **The block's Sources line names Reviewers 34 and 35, so this citation resolves.** What does not appear anywhere in the block is the Böhm–Wilking import the second route rests on.
- $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$: the argument is at [r38](../reviews/REVIEW_r38.md):7, the identity $H(I_p,V)_{ijkl}=\pi_{ik}\rho_{jl}-\pi_{il}\rho_{jk}-\chi_i\chi_kV_{jkli}+\chi_i\chi_lV_{jlki}$, Ricci-flatness forcing $\rho=0$ exactly once, a six-case exhaustion by block type, and the single live $(PP,MX)$ case using Bianchi twice to return $-V_{ijkl}/2$. The block reproduces that précis clause for clause. **The full computation is also in the same file, 240 lines below the block, at [nondegeneracy.md](../findings/nondegeneracy.md):730–736, credited there to Reviewers 38 and 39**, and the block's own Sources line credits 34 and 35. See §7, candidate D.

### 3e. $\lambda_m$, and a contradiction inside the file the block sends you to

The block writes "$\lambda_m=(m-2)/(2(m-1))<\tfrac12$ on $S^2_0(\mathbb R^m)$, derived at [second-order.md](../findings/second-order.md)", with no line anchor. Following it:

- [second-order.md](../findings/second-order.md):593–597 is headed "**The block closed form is DERIVED.**" It writes the sphere product's Weyl part as $a$ on $pp$ pairs, $b$ on $qq$, $c=-s$ mixed, with Ricci-freeness $a=qs/(p-1)$, $b=ps/(q-1)$ and criticality $\theta=(n-1)s$; the Weyl projection of $H_A$ has shape $\beta(\alpha_i+\alpha_j)$ on $pp$, $0$ on $qq$, $\gamma\alpha_i$ mixed with $\beta(p-2)+q\gamma=0$, which makes the shape one-dimensional, and $\lambda=\frac{(p-2)(a-c)}{2\theta}$. That closes: $\frac{(p-2)(qs/(p-1)+s)}{2(n-1)s}=\frac{(p-2)(q+p-1)}{2(p-1)(n-1)}=\frac{p-2}{2(p-1)}$, **exact, and I re-derived it.** The paragraph also records the independent mixed-entry route giving $\frac{(n-2)(p-1)-q}{2(n-1)(p-1)}$, which agrees because $(p+q-2)(p-1)-q=(p-2)(n-1)$. I checked that too: $(p+q-2)(p-1)=p^2+pq-3p-q+2$, so the left side is $p^2+pq-3p-2q+2$, and $(p-2)(p+q-1)=p^2+pq-3p-2q+2$ as well.
- [second-order.md](../findings/second-order.md):599–603, **six lines below**, prints the same formula and calls it "**three points against a two-parameter guess, which is a fit and not a proof**", and adds "Set up and not finished; the weight $(M_{ij}+M_{kj})$ is constant on each block-column, which is where a proof would start."

The two paragraphs give opposite provenance for the same quantity, in the same file, six lines apart. **See §7, candidate A.**

## 4. Pre-registered question 3, is $\tfrac12$ the maximum, or only attained?

**Every summand's value, evaluated exactly, and compared with $\tfrac12$.**

| summand | value | against $\tfrac12$ |
| --- | --- | --- |
| $\langle W\rangle$ | $1$ | **strictly above $\tfrac12$**, and this is why the statement restricts to $W^\perp$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $\tfrac12$ | equal |
| $S^2_0(\mathbb R^p)$ | $\lambda_p$ | $\tfrac12-\lambda_p=\dfrac1{2(p-1)}>0$ for every $p\ge2$ |
| $S^2_0(\mathbb R^q)$ | $\lambda_q$ | $\tfrac12-\lambda_q=\dfrac1{2(q-1)}>0$ |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu$ | $\tfrac12-\mu=\dfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ |
| $S^2_0\otimes S^2_0$ | $-\mu$ | $\mu>0$, so this is negative |
| $\mathrm{Weyl}_p,\ \mathrm{Weyl}_q,\ X_p\otimes\mathbb R^q,\ X_q\otimes\mathbb R^p$ | $0$ | below |

Two derivations, both mine and both exact.

**$\tfrac12-\lambda_m$.** $\tfrac12-\frac{m-2}{2(m-1)}=\frac{(m-1)-(m-2)}{2(m-1)}=\frac1{2(m-1)}$, strictly positive at every $m\ge2$. So the $S^2_0$ summands can never reach $\tfrac12$, at any $p,q$ whatever. This is the block's "$<\tfrac12$", and the block does not print the gap; the gap is what the tube lemmas downstream consume.

**$\tfrac12-\mu$.** $(p-1)(q-1)=pq-n+1$, so $(p-1)(q-1)-(n-2)=pq-2n+3=pq-2p-2q+3=(p-2)(q-2)-1$, giving

$$\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)},$$

exactly the block's display. **Over integers $p,q\ge3$ the numerator is $\ge0$ with equality only at $p=q=3$**, since $(p-2)(q-2)\ge1$ with equality iff both factors are $1$. So off $(3,3)$ the $\Lambda^2\otimes\Lambda^2$ summand is strictly below $\tfrac12$.

**Answer to the question.** $\tfrac12$ is **both** the maximum on $W^\perp$ and attained, and it is attained on exactly one summand. Nothing else reaches it and nothing else exceeds it. Off $W^\perp$ the operator does exceed $\tfrac12$ (the value $1$ on $\langle W\rangle$) which is why every consumer must carry the restriction.

**Two eigenvalue coincidences that are not with $\tfrac12$, and are harmless.** They matter because they falsify a literal reading of the block's uniqueness sentence (§7, candidate C) and because the record's tube lemmas depend on which summand carries the smallest gap.

- $\lambda_m-\mu$ at $p=q=m$ is $\frac{m-2}{2(m-1)}-\frac1{m-1}=\frac{m-4}{2(m-1)}$, so **$\mu=\lambda_m$ exactly at the balanced $(4,4)$**, both equal to $\tfrac13$.
- At $(3,5)$: $\mu=\frac{6}{2\cdot2\cdot4}=\tfrac38$ and $\lambda_5=\frac{3}{2\cdot4}=\tfrac38$. **Equal.** Two distinct summands, one value, at a split inside L27's scope.
- At $(3,4)$: $\mu=\frac{5}{2\cdot2\cdot3}=\tfrac5{12}$ against $\lambda_4=\tfrac13$, so $\mu$ **overtakes** the within-factor top, and the off-orbit gap is $\tfrac12-\tfrac5{12}=\tfrac1{12}$ rather than $\frac1{2(q-1)}=\tfrac16$. This is L26's recorded $(3,4)$ exception and it is right.

**What this means for $\dim E(\tfrac12)$ and for Morse–Bott.** $E(\tfrac12)\cap W^\perp$ is the single summand $\mathbb R^p\otimes\mathbb R^q$, of dimension $pq$. Under $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ the Hessian on $W^\perp$ is therefore negative definite off that summand and zero on it, which is Morse–Bott nondegeneracy **provided the summand is the orbit tangent**, §6. Had any other summand reached $\tfrac12$, $\dim E(\tfrac12)$ would exceed $pq$ and the point would be degenerate; had any exceeded $\tfrac12$, the point would not even be a local maximum. **Both failure modes occur in the record, at $(3,3)$ and at $p=2$ respectively, and they are different failures**, §5.

## 5. Pre-registered question 2, are the excluded cases excluded for the stated reason?

**They are excluded for two entirely different reasons, and the block runs them together in one hypothesis line.**

### 5a. $(3,3)$, the argument's conclusion fails; the argument's machinery does not

At $p=q=3$: $\mu=\frac{6-2}{2\cdot2\cdot2}=\tfrac12$ exactly, and $(p-2)(q-2)-1=0$. So $\Lambda^2\otimes\Lambda^2$, of dimension $c_3c_3=3\cdot3=9$, joins $\mathbb R^3\otimes\mathbb R^3$, of dimension $9$, at the value $\tfrac12$. Then $\dim E(\tfrac12)=18$ against an orbit of $pq=9$. **Every number checks.**

Everything else in the argument survives at $(3,3)$: the decomposition holds ($1+0+0+9+5+5+25+9+15+15=84=\dim\mathrm{Weyl}_6$), it is multiplicity-free, and $L_e$ is still scalar on each summand. **The failure is that two scalars collide.** The block says exactly this ("an **eigenvalue coincidence, not representation mixing**") and backs it with the commutant count: under $O(3)\times O(3)$ the two summands are non-isomorphic irreducibles with $\mathrm{End}=\mathbb R$ and no cross-$\mathrm{Hom}$, so $\dim\mathrm{Comm}=1+1=2$; under $SO(3)\times SO(3)$ they fuse into one isotypic component of multiplicity $2$ and $\dim\mathrm{Comm}=\dim M_2(\mathbb R)=4$. **Both numbers are right**, and they are the right numbers to quote: they are what shows Schur *permits* no mixing, so the two nine-dimensional pieces carry $\tfrac12$ separately rather than as one eighteen-dimensional isotypic block.

**So the $(3,3)$ exclusion is forced by the object, not by the argument.** The point genuinely is degenerate. No repair to the proof can recover it.

### 5b. $q\le2$, the decomposition itself fails, before any eigenvalue is computed

The block excludes $q\le2$ silently, by stating $p,q\ge3$ and saying nothing about why. The reason is sharper than "the inequality fails", and I found it by pushing §2a's identity below its range.

**§2a is an identity in the polynomials $W_p$, $X_p$, and those cease to be dimensions below $p=3$.**

- $W_2=\tfrac1{12}(16-28-12)=-2$, while $\dim\mathrm{Weyl}_2=0$.
- $W_1=\tfrac1{12}(1-7-6)=-1$, while $\dim\mathrm{Weyl}_1=0$; and $X_1=\tfrac13(1-4)=-1$, while the space is $0$.
- $X_2=\tfrac13\cdot2\cdot0=0$, which does agree.

So the ten **actual dimensions** exceed $\dim\mathrm{Weyl}_n$ by $2$ at $q=2$ and by $1+p$ at $q=1$. Concretely at $(p,q)=(4,2)$, $n=6$:

$$1+10+0+8+9+2+18+6+32+0=86,\qquad \dim\mathrm{Weyl}_6=84 .$$

**Eighty-six against eighty-four.** The listed ten-summand decomposition of $\mathrm{Weyl}_6$ is impossible at $S^2\times S^4$. At $(5,1)$, $n=6$: $1+35+0+5+14+0+0+0+35+0=90$ against $84$, an excess of $6=1+p$.

*This is on the record already*, [second-order.md](../findings/second-order.md):809 records "at $p=2$ it over-counts, $86$ against $84$ at $S^2\times S^4$", flagged by [r375](../reviews/REVIEW_r375.md) and [r376](../reviews/REVIEW_r376.md). **It is not on the record inside L27**, which is where a consumer reads the hypothesis.

**So the $q\le2$ exclusion is forced by the object too, but at a different level**: at $(3,3)$ the decomposition holds and the conclusion fails; at $q\le2$ the decomposition itself is false, so the argument cannot even be run. The record's [Lemma L11](../findings/nondegeneracy.md) box says the $p=2$ points are *nondegenerate but not maximisers* ($\mu=\tfrac12+\frac1{2(n-3)}>\tfrac12$), which is a true statement about the object reached by other means, **L27 cannot be the authority for it**, because L27's decomposition does not hold there. The two exclusions therefore need separating in any citation, and the block's single hypothesis line does not separate them.

### 5c. The rest of the range's edges

| edge | status |
| --- | --- |
| $(3,4)$ | **inside scope, and the tightest case.** $\tfrac12-\mu=\tfrac1{12}$, and $\mu=\tfrac5{12}$ overtakes $\lambda_4=\tfrac13$, so the second-largest eigenvalue changes summand here. The conclusion holds; downstream lemmas that assume the margin sits on $S^2_0$ do not, and the record carries $m\ge5$ in their scope boxes |
| $(3,q)$, $q\ge5$ | inside scope. $\mathrm{Weyl}_3=0$, so the list has **nine** nonzero summands, not ten. Harmless, the dimension identity is unaffected since $W_3=0$ as a polynomial too |
| $(4,4)$ | inside scope, $\mu=\lambda_4=\tfrac13$; the conclusion holds |
| **odd $n$** | **nothing in the argument is parity-sensitive.** $n$ enters only through $\mu=(n-2)/(2(p-1)(q-1))$ and $\dim\mathrm{Weyl}_n$. $(3,4)$, $(3,6)$, $(4,5)$, $(3,8)$ are ordinary members. *No finding: I looked for a parity dependence in the decomposition, the labels, the trace identity and the two inequalities, and there is none.* |
| unbalanced splits generally | inside scope, and they are the *easier* half: $\tfrac12-\mu$ grows with $\max(p,q)$ at fixed $\min$, and the binding constraint is always the small factor |
| $p=q$ | inside scope, and the case that would have been at risk had the group been $SO(p)\times SO(q)$ or had the factor swap been included, it is not, §2b |

## 6. The orbit-tangent identification, checked as three claims and not one

The statement compresses "$\dim E(\tfrac12)=pq=\dim(\text{orbit})$" into one chain. It is three separate assertions with three separate grounds, and only the first is the block's own work.

**Claim A, $\dim E(\tfrac12)\cap W^\perp=pq$.** From §4: every summand's value is known, exactly one equals $\tfrac12$, and that summand is $\mathbb R^p\otimes\mathbb R^q$ of dimension $pq$. **Ground: the block's own ten values.** This is the claim the whole apparatus exists to produce.

**Claim B, $\dim(\text{orbit})=pq$.** The block gives no argument. Two grounds exist on the record and both are outside the block:

- Nienhaus 4.6(b), read from the extraction: "within the space $(\mathbb R^k\otimes\mathbb R^l)_k\oplus(\mathbb R^k\otimes\mathbb R^l)_l$ there is a $k\cdot l$-dimensional subspace, generated by the elements $[\mathrm{ad}_v,W_{S^k\times S^l}]$ for $v\in\mathbb R^k\otimes\mathbb R^l$ that **corresponds to the tangent space of $SO(n).W_{S^k\times S^l}$**". So the source asserts both the dimension and the identification.
- The stabiliser count, which is [OrbitDim.lean](../lean/HamiltonsCubic/Results/OrbitDim.lean) in the Lean tree: $\binom n2-\binom p2-\binom q2=\tfrac12\big[(p+q)(p+q-1)-p(p-1)-q(q-1)\big]=\tfrac12\cdot2pq=pq$. **I re-derived this**; it presumes the identity component of the stabiliser of $W_{p,q}$ in $SO(n)$ is $SO(p)\times SO(q)$, which the block never states. At $p=q$ the extra factor swap is discrete and changes no dimension.

**Claim C, the two spaces are equal, not merely equidimensional.** The orbit lies in the unit sphere, so $T_W\mathcal O\subseteq W^\perp$; §3a puts $T_W\mathcal O\subseteq E(\tfrac12)$; hence $T_W\mathcal O\subseteq E(\tfrac12)\cap W^\perp=\mathbb R^p\otimes\mathbb R^q$, and Claims A and B make the dimensions agree, so the inclusion is an equality. **The block asserts "attained exactly on the orbit tangent" and leaves this three-line argument implicit.** It is correct, and it is *why* Claim B is load-bearing rather than decorative: without $\dim(\text{orbit})=pq$ from the source, the block would have proved only that the $\tfrac12$-eigenspace has dimension $pq$ and contains the orbit tangent, which is weaker than Morse–Bott nondegeneracy.

**No finding on the mathematics of any of the three.** One finding on the writing: **a consumer reading L27 alone would take Claim B to be part of what L27 proves.** It is not; it is imported, unattributed, from Nienhaus 4.6(b).

## 7. Discrepancy candidates, each through all three steps

### Candidate A, the file L27 cites for $\lambda_m$ contradicts itself six lines later. **STANDS.**

**Locate.** L27, [nondegeneracy.md](../findings/nondegeneracy.md):481: *"$\lambda_m=(m-2)/(2(m-1))<\tfrac12$ on $S^2_0(\mathbb R^m)$, derived at [second-order.md](../findings/second-order.md)"*, no line anchor. The cited file, [second-order.md](../findings/second-order.md):593: *"**The block closed form is DERIVED.** Gate 2, Reviewers 301 and 302 … 302 supplied the proof the record owed."* The same file, :603: *"**three points against a two-parameter guess, which is a fit and not a proof** … Set up and not finished; the weight $(M_{ij}+M_{kj})$ is constant on each block-column, which is where a proof would start."*

**Exhibit the failure concretely.** Both paragraphs are about the identical scalar $\frac{p-2}{2(p-1)}$ on the identical object $S^2_0(\mathbb R^p)$ at the identical point $S^p\times S^q$; :603's three "data points" $S^3\times S^5$, $S^4\times S^6$, $S^3\times S^7$ evaluate to $\tfrac14,\tfrac38$; $\tfrac13,\tfrac25$; $\tfrac14,\tfrac5{12}$, every one of them $\lambda_p,\lambda_q$ or $\mu$ from the formula :593 derives. [ATTEMPTS.md](../ATTEMPTS.md):2579 still carries the row *"the closed form $\tfrac{p-2}{2(p-1)}$ | derivation | **fitted from three data points** against a two-parameter guess"*, so the "not a proof" reading also survives in the open-debt ledger. **A consumer following L27's anchorless citation lands on whichever paragraph they scroll to, and one of them says L27's third eigenvalue is unproved.**

**Argue the opposite.** The most charitable reading is that :599–603 is superseded text that :593–597 replaced, and that its "VACUOUS"/"fit" language is aimed at the *pair* of claims $\{\lambda_p,\ \tfrac12\text{ on }\mathbb R^p\otimes\mathbb R^q\}$ taken as a two-parameter guess, whereas :593 derives $\lambda_p$ alone. That reading is available, and it is probably the history. **It does not survive contact with the text**: :603's final sentence is a live to-do ("Set up and not finished … which is where a proof would start") describing work that :593 says was completed, and :603 sits *after* :593 in the file, so the reader who scrolls forward reads the retraction last.

**Verdict: STANDS.** A citation defect, not a mathematical one, the derivation at :593–597 is correct and I re-derived it in §3e. **The repair is a line anchor in L27 and a strike-through at :599–603 and [ATTEMPTS.md](../ATTEMPTS.md):2579.**

### Candidate B, the landscape line drops $n=p+q$, and the record's own padding result makes that fatal to a citation. **STANDS. This is the named trap.**

**Locate.** [results.md](../results.md):140: *"**Lemma L27 (landscape). Sphere products are Morse–Bott nondegenerate.** … For $p,q\ge3$ other than $(3,3)$, $\lambda_{\max}=\tfrac12$ on the orbit alone."* The canonical form at [results.md](../results.md):423 and the block statement both open "Let $p,q\ge3$ with $(p,q)\ne(3,3)$ **and $n=p+q$**". The landscape line carries the two exclusions and drops the third hypothesis.

**Exhibit the failure concretely.** [nondegeneracy.md](../findings/nondegeneracy.md), in the L11 material above L27, states: *"**Padding does not preserve nondegeneracy**: $S^3\times S^3$ keeps excess $9$ at $n=6\ldots14$ including odd $n$ … and the whole $S^2\times S^k$ family is **nondegenerate natively but degenerate at every larger $n$** with excess growing linearly, $4(n-4)$ for $S^2\times S^2$."* So the record holds a family that is nondegenerate at $n=p+q$ and degenerate at every $n>p+q$. A reader of :140 alone has "sphere products are Morse–Bott nondegenerate for $p,q\ge3$ other than $(3,3)$" with no ambient dimension attached, and the ten-summand decomposition it cites as the mechanism is a decomposition of $\mathrm{Weyl}_{p+q}$ and of nothing else. The record's own reassurance (*"Balanced products with $k\ge4$ are unaffected"*), covers the balanced case only, leaving every unbalanced $p,q\ge3$ padded product neither covered by L27 nor addressed by that sentence.

**Argue the opposite.** The charitable reading is that "$S^p\times S^q$ is Morse–Bott nondegenerate" is a statement about the *manifold*, whose natural ambient Weyl space is $\mathrm{Weyl}_{p+q}$, so $n=p+q$ is implied by the notation and needs no restating in a landscape summary. That reading is genuinely available and is probably what was meant. **It does not survive the record's own usage**: the same file, forty lines earlier, uses "$S^3\times S^3$ keeps excess $9$ at $n=6\ldots14$", i.e. the record itself routinely speaks of a sphere product *at* a larger $n$. Once that usage is in the file, the unqualified landscape line is ambiguous in exactly the direction that costs a citation its truth.

**Verdict: STANDS.** The canonical forms are correct; the landscape line is the citable object that inherits the defect. **The repair is four words at [results.md](../results.md):140.**

### Candidate C, "the only such coincidence" is false on its literal reading. **WITHDRAWN, recorded as wording.**

**Locate.** [nondegeneracy.md](../findings/nondegeneracy.md):496: *"A symbolic solve over all $45$ summand pairs finds it the only such coincidence with $p,q\ge3$, over all $p,q$ rather than a tested range."*

**Exhibit the failure concretely.** $\binom{10}2=45$, so the pair count is right. But among those $45$ pairs, the six pairs drawn from $\{\mathrm{Weyl}_p,\mathrm{Weyl}_q,X_p\otimes\mathbb R^q,X_q\otimes\mathbb R^p\}$ carry the value $0$ **identically in $p,q$**; $\lambda_p=\lambda_q$ at every balanced product; $\mu=\lambda_4=\tfrac13$ at $(4,4)$; and $\mu=\lambda_5=\tfrac38$ at $(3,5)$, a named object inside L27's scope. Read as "no two summands share a value", the sentence is false at $(3,5)$ and at six pairs everywhere.

**Argue the opposite.** "Such" takes its antecedent from the preceding sentence, which is about the coincidence *with the orbit tangent's $\tfrac12$*. Under that reading the claim is that $\mu=\tfrac12$ is the only way a second summand can reach $\tfrac12$, and it is **true and provable in two lines without any solve**: the ten values are $\{1,\tfrac12,\lambda_p,\lambda_q,\pm\mu,0\}$; $\lambda_m<\tfrac12$ always, $-\mu<0$, $0\ne\tfrac12$, $1\ne\tfrac12$, so the only candidate is $\mu=\tfrac12$, i.e. $(p-2)(q-2)=1$, i.e. $p=q=3$ over integers $\ge3$.

**Verdict: WITHDRAWN** as a defect, the charitable reading is the intended one and is true. **Recorded as wording**, with the note that the intended claim needs no symbolic solve at all, which matters on this programme's analysis-only footing.

### Candidate D, the block's Sources line credits the wrong reviewers for the $X_p\otimes\mathbb R^q$ discharge. **STANDS, narrowed.**

*I opened this candidate as "no argument on file" and it did not survive the search. Recording the narrowed form, and the search, because the difference is the whole point of looking.*

**Locate.** [nondegeneracy.md](../findings/nondegeneracy.md):490: *"On $X_p\otimes\mathbb R^q$ it vanishes by an index computation uniform in $p,q,n$: writing $\mathrm{sharp\_bilin}(X,Y)=\mathrm{Sym}_{\text{pair}}\mathrm{Alt}_{ij}H$ and specialising $X=I_p$ … a six-case exhaustion leaves one live case in which Bianchi is used twice to give $-V/2$."* The Sources line, :501–502, names *"Nienhaus … Proposition 4.6 and Remark 4.7(ii). Audited by Reviewers 34 and 35 on identical briefs … both proved the $\mathrm{Weyl}_p$ vanishing independently, and both refuted the mechanism first proposed for the $(3,3)$ exception."*

**Exhibit the failure concretely.** The argument **is** on file, twice: written out in full at [nondegeneracy.md](../findings/nondegeneracy.md):730–736, under the heading "The constant, proved uniformly in $p,q,n$", with the identity $H(I_p,V)=\pi_{ik}\rho_{jl}-\pi_{il}\rho_{jk}-\chi_i\chi_kV_{jkli}+\chi_i\chi_lV_{jlki}$ and $\rho_{jl}=\sum_{a\in P}V_{jala}$; and at [r38](../reviews/REVIEW_r38.md):7. The file credits it at :726 to **Reviewers 38 and 39**. The canonical block's Sources line names **34 and 35**, and [r34](../reviews/REVIEW_r34.md):9 says of its own moment *"The entire remaining 'unnamed eigenvalues vanish' debt **is one constant**: $\mathrm{sharp\_bilin}(I_p,V)=-\tfrac12V$ on the $(pp,\mathrm{mix})$ block"*, r34 records the constant as still **owed**, so it demonstrably is not r34's discharge. **A reader who follows the block's own Sources line reaches a review that says the thing is unproved.**

**Argue the opposite.** The charitable reading is that "Audited by Reviewers 34 and 35" attaches to the audit of the block as a whole, not to the provenance of each discharge, and that the detailed proof 240 lines below in the same file is close enough for any reader of the file. **That reading holds for a reader of the file and fails for a reader of the block**, and the block is the citable unit: it opens "canonical statement and proof" and closes with a Sources line, which is where provenance is looked for.

**Verdict: STANDS, narrowed**, from "no argument on file" to "the canonical block's Sources line points at the one review that says the claim is owed, while the argument sits unlinked 240 lines below." **The repair is two words in the Sources line and one anchor.**

### Candidate E, "the $p,q\ge5$ case is proved in the source". **WITHDRAWN, recorded as an understatement.**

**Locate.** [nondegeneracy.md](../findings/nondegeneracy.md):490: *"The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$ … The $p,q\ge5$ case is proved in the source."*

**Exhibit the failure concretely.** Read from the extraction, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) immediately after the ten-summand display: *"This decomposition is orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, **it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$**."* The block's group *is* $O(p)\times O(q)$ and its range *is* $p,q\ge3$, so the source's own clause covers the whole of L27's scope, and the extra commutant computation is confirmation rather than a discharge. In the other direction the block's "$\ge5$ is proved" is also slightly generous: Proposition 4.6 proper carries the hypothesis "$k,l\ge5$, $k,l\ne6$", so at $k$ or $l$ equal to $6$ the display's $SO$ clause is asserted rather than proved as well.

**Argue the opposite.** The block may be distinguishing *proof coverage* from *assertion*: Prop 4.6's proof runs for $k,l\ge5$, $k,l\ne6$ under $SO$, and $SO$-irreducibility implies $O$-irreducibility, so "$p,q\ge5$ is proved" is defensible as a statement about what the source demonstrates rather than what it states. **That is a fair reading**, and on it the block is being conservative rather than wrong.

**Verdict: WITHDRAWN.** Recorded because the block *understates* its own footing: nothing extra is needed at $p,q\le4$, and the $k\ne6$ exclusion is a red herring, it attaches to the irreducibility of $\Lambda^2(\mathbb R^k)\otimes\mathbb R^k=\Lambda^3\oplus\mathbb R^k\oplus X_k$, and $\Lambda^3$ does not appear in the ten-summand display.

### Candidate F, "the list checks itself" overstates one linear equation. **WITHDRAWN.**

**Locate.** [nondegeneracy.md](../findings/nondegeneracy.md):488: *"**The list checks itself, and the check is not in the argument that produced it.** … It also discriminates the assignment: reversing the two tensor summands leaves a trace of $30$ at $(3,5)$ and $(4,4)$, $48$ at $(5,5)$, $70$ at $(5,7)$, never zero."*

**Exhibit the failure concretely.** The reversal residual is one closed form, which I derived: swapping the two values changes the trace by $2\mu(s_ps_q-c_pc_q)$, and $s_ps_q-c_pc_q=\tfrac14(p-1)(q-1)\big[(p+2)(q+2)-pq\big]=\tfrac12(p-1)(q-1)(n+2)$, so the residual is $2\mu\cdot\tfrac12(p-1)(q-1)(n+2)=\tfrac{(n-2)(n+2)}2=\tfrac{n^2-4}2$. **Evaluating exactly**: $n=8\to30$ (both $(3,5)$ and $(4,4)$), $n=10\to48$, $n=12\to70$. **All four printed numbers are exactly right.** But this is the *same* trace equation evaluated at a different assignment; since the block has already used that equation to determine $-\mu$ uniquely, the non-vanishing of its residual elsewhere is a restatement of uniqueness rather than an independent test.

**Argue the opposite.** The sentence claims only that the identity is *sensitive* to the swap, which is worth saying, because a trace identity symmetric in the two summands would have discriminated nothing, and the reader cannot see from $\pm\mu$ alone that the multiplicities break the symmetry. Read that way it is accurate and informative.

**Verdict: WITHDRAWN.** No defect. Recorded because the closed form $\tfrac{n^2-4}2$ is more useful than four sampled integers, and because "never zero" is then a theorem for all $n\ge3$ rather than an observation at four points.

### Candidate G, the file's own bottom-end scope paragraph states a criterion that is false at $q=2$. **STANDS. New here.**

**Locate.** [nondegeneracy.md](../findings/nondegeneracy.md):764, the paragraph headed "Scope at the bottom end", whose whole job is to say where this list stops working: *"The list needs $p,q\ge2$ for the summands to exist and **$n\ge5$ for the count**: at $(2,2)$ the named multiplicities sum to $14$ against $\dim\mathrm{Weyl}_4=10$ and $1$ is not simple."*

**Exhibit the failure concretely.** $n\ge5$ does not rescue the count. Two named objects, both with $n\ge5$:

- $(p,q)=(3,2)$, $n=5$, the very first case the criterion admits. $\dim\mathrm{Weyl}_5=\tfrac1{12}\cdot5\cdot6\cdot7\cdot2=35$. The ten dimensions are $1+0+0+6+5+2+10+3+10+0=37$. **Thirty-seven against thirty-five.**
- $(p,q)=(4,2)$, $n=6$. $\dim\mathrm{Weyl}_6=84$; the ten dimensions are $1+10+0+8+9+2+18+6+32+0=86$. **Eighty-six against eighty-four.**

The mechanism is exact and I derived it in §5b: the identity of §2a is an identity in the *polynomial* $W_m=\tfrac1{12}(m^4-7m^2-6m)$, and $W_2=-2$ while $\dim\mathrm{Weyl}_2=0$, so the true dimensions exceed the target by exactly $2$ at every $q=2$ and by $1+p$ at every $q=1$, at **every** $n$. The correct criterion is $p,q\ge3$, not $n\ge5$.

**Argue the opposite.** The charitable reading is that "the count" means the *multiplicity list* of §"The spectra, exact" ($\pm\mu$ at $s_ps_q$ and $c_pc_q$, $\lambda_m$ at $s_m$, $\tfrac12$ at $pq$, $1$ simple) rather than the ten summand dimensions, and that the paragraph is diagnosing only the $(2,2)$ pathology where $\mu=1$ and $1$ is not simple. **That reading does not rescue it**: at $(4,2)$ those same named multiplicities sum to $18+6+9+2+8+1=44$, and adding the four zero summands' $10+0+32+0=42$ gives $86$ against $84$, the identical failure, at $n=6$, inside the range the sentence declares safe.

**Verdict: STANDS.** The fact is on the record, [second-order.md](../findings/second-order.md):809 records "at $p=2$ it over-counts, $86$ against $84$ at $S^2\times S^4$", flagged by [r375](../reviews/REVIEW_r375.md) and [r376](../reviews/REVIEW_r376.md), **and it is on the record in a different file, in a different lemma's box, while the paragraph whose subject is this list's bottom-end scope states the opposite.** That is this record's named failure mode exactly. **The repair is to replace "$n\ge5$ for the count" with "$p,q\ge3$ for the count".**

### Candidate H, the correction to the Schur step landed in the canonical block and not in the same file's parallel exposition. **STANDS. The named trap, second instance.**

**Locate.** The canonical block, [nondegeneracy.md](../findings/nondegeneracy.md):482–484, carries the corrected step and its italicised warning: *"a symmetric element of a real division algebra of operators has a real eigenvalue and is therefore a real scalar, which covers $\mathbb R$, $\mathbb C$ and $\mathbb H$ alike … **Symmetry is what does this work; it cannot, as the first version had it, change a representation's type.**"* The parallel exposition in the **same file**, at :718, still reads: *"Absolute irreducibility is what Schur needs, and **$L_e$ being symmetric rules out the $\mathbb C$ and $\mathbb H$ cases**."*

**Exhibit the failure concretely.** ":718 is verbatim the sentence :483 exists to retract." Whether $\mathrm{End}_G(V)$ is $\mathbb R$, $\mathbb C$ or $\mathbb H$ is a property of the representation $V$ and the group $G$; no property of the operator $L_e$ bears on it. The claim at :718 is therefore a non-sequitur, and it is the non-sequitur the canonical block names as "the first version". A second stale line sits four lines above it, at :712: *"nondegeneracy for $p,q\ge3$ rests entirely on the multiplicity list below, **which remains numerical**"*, which the same file's :726 ("Both debts are discharged, and the result is unconditional") and :730–736 contradict outright.

**Argue the opposite.** The charitable reading is that :710–765 is a dated narrative of how the result was reached, kept for provenance, and that a reader knows the canonical block at :457 supersedes it. **The file gives the reader no such signal**: :718's paragraph is headed "The multiplicity list is the isotypic decomposition, and it is nearly proved" in the present tense, carries no supersession box, and this file uses supersession boxes freely elsewhere, three of them around [Lemma L11](../findings/nondegeneracy.md) alone, and states its conclusion as fact.

**Verdict: STANDS.** No consequence for the theorem: the conclusion at :718 (that $L_e$ is scalar on each summand) is true, by §2c. The defect is that a consumer reading :718 inherits a refuted reason for a correct conclusion, and a consumer reading :712 inherits "remains numerical" for a result that is proved. **The repair is a strike-through at :712 and a one-clause substitution at :718.**

## 8. Comparing the forms

Four forms of L27 exist on the record, and no Lean form.

| where | what it says | agreement |
| --- | --- | --- |
| [nondegeneracy.md](../findings/nondegeneracy.md):461–465, the canonical statement | "Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$ is Morse–Bott nondegenerate." | the reference form |
| [results.md](../results.md):425 | **word for word identical**, followed by "**Proof:** [nondegeneracy.md](../findings/nondegeneracy.md)" | **exact agreement**, the two canonical forms carry all three hypotheses and the same conclusion |
| [results.md](../results.md):140, the landscape line | "Sphere products are Morse–Bott nondegenerate. … For $p,q\ge3$ other than $(3,3)$, $\lambda_{\max}=\tfrac12$ on the orbit alone." | **drops $n=p+q$**, candidate B |
| [nondegeneracy.md](../findings/nondegeneracy.md):750, the narrative heading | "Hence, unconditionally: for $p,q\ge3$ with $(p,q)\ne(3,3)$, $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$, attained exactly on the orbit tangent, and $S^p\times S^q$ is Morse–Bott nondegenerate" | agrees on the mathematics; **drops $n=p+q$**, and the exposition beneath it carries candidate H's two stale lines |
| [nondegeneracy.md](../findings/nondegeneracy.md), the L27 landscape line quoted in the round brief | "The isotypic decomposition is multiplicity-free, so Schur makes $L_e$ scalar on each of ten summands and each value is an eigenvalue, not a lower bound." | true, and the right thing to headline, the whole content is the *upper* bound |

**The Lean row.** There is none. [lean/INDEX.md](../lean/INDEX.md):361 puts **L27** in the bucket "out, needs machinery Mathlib does not have", alongside L11, L28 and L69, with the reason "branching and isotypic decompositions of $\mathfrak{so}(n)$". That placement is right, the ten-summand $O(p)\times O(q)$ decomposition is not reachable in Mathlib today.

**What the row would have to claim if it existed.** Not the decomposition. Splitting the result the way this repository's Lean rows split things (the part the record holds data for, and the part it does not), a formalisable row would be:

1. **The arithmetic of the ten values, given as data.** $\tfrac12-\lambda_m=\frac1{2(m-1)}>0$ for $m\ge2$; $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$; over integers $p,q\ge3$ that numerator is $\ge0$ with equality **iff** $p=q=3$; hence the maximum of the nine off-$\langle W\rangle$ values is $\tfrac12$ and it is attained exactly once. This is pure integer arithmetic and would kernel-check with no `native_decide`.
2. **The dimension identity** of §2a ($1+W_p+W_q+pq+s_p+s_q+s_ps_q+c_pc_q+qX_p+pX_q=W_{p+q}$ as polynomials), with the accompanying **negative** result that the identity is about polynomials and fails as a statement about dimensions at $q\le2$, witnessed at $(3,2)$ by $37\ne35$ and at $(4,2)$ by $86\ne84$. That is candidate G in machine-checkable form, and it is the highest-value thing Lean could add here.
3. **The orbit dimension**, $\binom{p+q}2-\binom p2-\binom q2=pq$, already proved, at [OrbitDim.lean](../lean/HamiltonsCubic/Results/OrbitDim.lean).
4. **Owed, and out of reach**: the decomposition itself, its irreducibility under $O(p)\times O(q)$, the multiplicity-freeness, the Schur step, and each of the ten values.

**A note on the consumers already in the Lean tree.** [HessianFamilies.lean](../lean/HamiltonsCubic/Results/HessianFamilies.lean), [L26.lean](../lean/HamiltonsCubic/Results/L26.lean), [L126.lean](../lean/HamiltonsCubic/Results/L126.lean), [L128.lean](../lean/HamiltonsCubic/Results/L128.lean), [L3.lean](../lean/HamiltonsCubic/Results/L3.lean) and [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) all import L27's conclusion as a hypothesis and say so in their "Owed" clauses. **[L126.lean](../lean/HamiltonsCubic/Results/L126.lean)'s row proves the thing this verification most wanted machine-checked**: that L27's scope ($p,q\ge3$, $(p,q)\ne(3,3)$) and L126's ($p=2$ or $q=2$ or $(3,3)$) partition every pair with $p,q\ge2$, exhaustive and disjoint. So the two exclusions of §5 are, between them, provably complete. That is exactly the guarantee a consumer needs and it is **not** stated in L27's own block.

## 9. The gap between what is proven and what is used

### 9a. What is proven

For $p,q\ge3$ with $(p,q)\ne(3,3)$, at the critical $W_{p,q}\in\mathrm{Weyl}_{p+q}$ with $\theta>0$, the **full spectrum** of $L_e$ with multiplicities:

$$\sigma(L_e)=\Big\{1^{\,1},\ \big(\tfrac12\big)^{pq},\ \lambda_p^{\,s_p},\ \lambda_q^{\,s_q},\ \mu^{\,c_pc_q},\ (-\mu)^{\,s_ps_q},\ 0^{\,W_p+W_q+qX_p+pX_q}\Big\},$$

the multiplicities summing to $\dim\mathrm{Weyl}_n$ by §2a; hence $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, attained on $\mathbb R^p\otimes\mathbb R^q=T_W\mathcal O$ alone, hence $\mathrm{Hess}_SP$ negative definite transverse to the orbit and zero along it, hence Morse–Bott nondegeneracy. **This is conditional on nothing except its imports** (§1c), all of whose hypotheses are met.

### 9b. What consumers take, and where they take more

| consumer | what it takes | safe? |
| --- | --- | --- |
| [Corollary L128.1](../findings/second-order.md):809 | "$\mathcal D_n\cap W^\perp$ carries $\{\lambda_p,\lambda_q,-\mu,0\}$ … all $\ne\tfrac12$", plus L27's only $\tfrac12$-summand being $T_W\mathcal O$ | **yes**, and it states "Assume $p,q\ge3$, which is where L27's summand list is stated and where its decomposition counts correctly", and cites the $86$-against-$84$ failure. **The best-behaved consumer on the record** |
| [Lemma L146](../findings/second-order.md):1135, [L148](../findings/second-order.md):1201, [L149](../findings/second-order.md):1221 | "the off-orbit margin sits on the two $S^2_0(\mathbb R^m)$ summands, so it is $\tfrac1{2(m-1)}$" | **only for $m\ge5$**, and the record says so in their scope boxes: at $m=4$, $\lambda_m-\mu=\frac{m-4}{2(m-1)}=0$ so the eigenspace strictly contains the two copies; at $m=3$, $\mu=\tfrac12$ and the margin is zero. **Correctly scoped** |
| [Lemma L3](../findings/second-order.md), [L9](../findings/graded-half.md), [L69](../findings/graded-half.md) | the conclusion at named splits | safe within $p,q\ge3$, $\ne(3,3)$ |
| [Lemma L11](../findings/nondegeneracy.md) | "L27 then shows that in the remaining range $\tfrac12$ is attained on the orbit tangent alone" | **yes**, and its own box correctly separates the $p=2$ failure (not a maximiser) from the $(3,3)$ failure (degenerate) |
| [r450](../reviews/REVIEW_r450.md):52, [r452](../reviews/REVIEW_r452.md), [r453](../reviews/REVIEW_r453.md) | "$\tfrac12-\lambda_j=\Theta(1/n)$ on $S^2_0(\mathbb R^m)$ alone and $\Theta(1)$ on all six other off-orbit summands" | **only for $m\ge5$**, same reason |

**The one systematic over-reach available.** [second-order.md](../findings/second-order.md):601 records $L_e|_{\mathrm{Sym}_0(\mathbb R^p)}=\frac{p-2}{2(p-1)}$, an eigenvalue on $\mathrm{Sym}_0(\mathbb R^n)$, which is **not** a subspace of $\mathrm{Weyl}_n$. It matches L27's $\lambda_p$ because the Weyl projection of $H_A$ lands in L27's $S^2_0(\mathbb R^p)$ summand, but the two spaces are different objects and a consumer must not read L27's ten-summand list as a decomposition of $\mathrm{Sym}_0$ or of $S^2(\mathfrak{so}(n))$. Nienhaus's $S^2(\mathfrak{so}(n))$ decomposition has **eighteen** summands, not ten, and needs $k,l\ge5$, $k,l\ne6$.

### 9c. What a consumer may cite

**May cite, unconditionally within the stated range:**

> For $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$: at $W_{p,q}\in\mathrm{Weyl}_n$, $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, the $\tfrac12$-eigenspace on $W^\perp$ is exactly the orbit tangent, $\dim E(\tfrac12)=pq=\dim\mathcal O$, and $S^p\times S^q$ is Morse–Bott nondegenerate. The full spectrum is §9a's list, and the off-orbit gap is $\min\big\{\tfrac1{2(p-1)},\tfrac1{2(q-1)},\tfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}\big\}$.

**May not cite:**

- **anything at $n>p+q$.** L27 says nothing about a zero-padded $W_{p,q}$; the record's own material says padding can destroy nondegeneracy.
- **anything at $\min(p,q)\le2$.** Not merely because the inequality fails, the ten-summand decomposition itself over-counts, by $2$ at $q=2$ and by $1+p$ at $q=1$, at every $n$ (§5b). Whatever is true at $S^2\times S^k$ is true for other reasons.
- **$(3,3)$.** Degenerate, $\dim E(\tfrac12)=18$ against $9$.
- **"the margin is on $S^2_0$"** below $m=5$, or at any unbalanced split without checking $\mu$ against $\lambda_{\max(p,q)}$, at $(3,4)$ it is $\mu$ that binds, at $\tfrac5{12}$.
- **the eighteen-summand $S^2(\mathfrak{so}(n))$ decomposition**, whose hypotheses ($k,l\ge5$, $k,l\ne6$) L27 does not verify and does not need.

## 10. The named trap, every citable claim read alone, as a consumer would

| claim, read with nothing else | what a consumer gets | defect inherited |
| --- | --- | --- |
| [results.md](../results.md):425 | all three hypotheses, the full conclusion, and a proof pointer | **none.** It does presume $W_{p,q}$ critical with $\theta>0$ for $L_e$ to exist, which [Lemma L24](../results.md):701 supplies twenty pages away and this line does not name |
| [nondegeneracy.md](../findings/nondegeneracy.md):461–465 | identical | **none**, same presumption |
| [results.md](../results.md):140 | "sphere products are Morse–Bott nondegenerate" with **no ambient dimension** | **candidate B**, the record's own padding result makes the omission load-bearing |
| [nondegeneracy.md](../findings/nondegeneracy.md):718 | a refuted reason ("$L_e$ being symmetric rules out the $\mathbb C$ and $\mathbb H$ cases") for a correct conclusion | **candidate H**, the correction sits at :483, 235 lines above, and did not land here |
| [nondegeneracy.md](../findings/nondegeneracy.md):712 | "the multiplicity list … **remains numerical**" | **candidate H**, false since :726 |
| [nondegeneracy.md](../findings/nondegeneracy.md):764 | "the list needs … $n\ge5$ for the count" | **candidate G**, false at $(3,2)$, $n=5$, by $37$ against $35$ |
| [nondegeneracy.md](../findings/nondegeneracy.md):481, the $\lambda_m$ citation | an anchorless pointer into a file that says both "DERIVED" and "a fit and not a proof" | **candidate A** |
| [nondegeneracy.md](../findings/nondegeneracy.md):501–502, the Sources line | Reviewers 34 and 35 credited for a discharge that [r34](../reviews/REVIEW_r34.md) itself records as owed | **candidate D** |
| [results.md](../results.md):555, [Lemma L69](../results.md) | "Nondegeneracy is Lemma L27, whose gap to the next eigenvalue is $\frac1{2(M-1)}$ with $M=\max(p,q)$" | **none, and I checked it rather than assuming it.** The gap is $\tfrac12-\max(\lambda_M,\mu)$, and $\mu<\lambda_q$ **iff** $(p-2)(q-3)>2$ (clearing denominators: $p+q-2<(q-2)(p-1)$ reduces to $pq-3p-2q+4>0$). L69 is scoped to $p,q\ge5$, where $(p-2)(q-3)\ge6$, so $\lambda_M$ is second and the quoted gap is right. **At $(3,5)$ the product is exactly $2$ and $\mu=\lambda_5=\tfrac38$ (the tie of §4) and at $(3,4)$ it is $1$ and $\mu$ wins.** So the formula L69 quotes fails at three splits, all outside its own scope |

**Reading of the trap.** Four of the eight citable objects above carry a defect their own canonical form does not. **In every case the canonical statement is clean and the neighbour is not**, which is the failure mode named in the brief, and it appears here in both directions: a correction that landed only in the canonical block (candidate H), and a correction that landed only outside it (candidates A and G, where the true scope is recorded in [second-order.md](../findings/second-order.md) and not in the paragraph whose subject it is).

**What I did not find.** *No finding:* the two canonical statements, [results.md](../results.md):425 and [nondegeneracy.md](../findings/nondegeneracy.md):461–465, are word-for-word identical and both correct. *No finding:* no consumer on the record was found citing L27 for a padded $W_{p,q}$, for $\min(p,q)\le2$, or for $(3,3)$, I checked [second-order.md](../findings/second-order.md):809, [results.md](../results.md):555, [Lemma L11](../findings/nondegeneracy.md), [r450](../reviews/REVIEW_r450.md), [r452](../reviews/REVIEW_r452.md), [r453](../reviews/REVIEW_r453.md) and [r501](../reviews/REVIEW_r501.md). The exposure created by candidate B is latent, not yet realised.

## 11. Verdict

### `PROVEN, hypotheses corrected`

**The statement is true and the argument establishes it.** Every step I could check by hand checks: the ten-summand dimension identity is exact as polynomials (§2a, derived in full); the trace identity closes to zero identically in $p,q$ (§3c, derived in full); the ten Young-label pairs are distinct and admissible for $p,q\ge3$ (§2b); the division-algebra step is valid and I wrote out the link the block compresses (§2c); $\tfrac12-\lambda_m=\frac1{2(m-1)}$ and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ are exact and put $\tfrac12$ on the orbit summand alone (§4); the orbit identification is three claims and all three are present (§6).

**The hypotheses to be corrected**, none of which touches the conclusion:

1. **$n=p+q$ belongs in the landscape line at [results.md](../results.md):140** and in the narrative heading at [nondegeneracy.md](../findings/nondegeneracy.md):750. Candidate B.
2. **"$n\ge5$ for the count" at [nondegeneracy.md](../findings/nondegeneracy.md):764 must read "$p,q\ge3$ for the count."** Candidate G, false at $(3,2)$ and $(4,2)$.
3. **The block should state that $W_{p,q}$ is critical with $\theta>0$**, which every use of $e=W/\theta$ and the orbit argument consumes and which the statement omits.
4. **The Sources line should credit Reviewers 38 and 39** for the $X_p\otimes\mathbb R^q$ discharge, with an anchor to :730. Candidate D.
5. **[nondegeneracy.md](../findings/nondegeneracy.md):712 and :718 need striking**, being a superseded "remains numerical" and the exact non-sequitur that :483 retracts. Candidate H.
6. **The $\lambda_m$ citation at :481 needs the anchor :593**, and [second-order.md](../findings/second-order.md):599–603 and [ATTEMPTS.md](../ATTEMPTS.md):2579 need striking. Candidate A.

**Not a `GAP` and not `HYPOTHESIS-DEBT`.** I opened candidate D expecting to record a missing argument for the $X_p\otimes\mathbb R^q$ zeros, and found the argument written out in full at [nondegeneracy.md](../findings/nondegeneracy.md):730–736 and at [r38](../reviews/REVIEW_r38.md):7. Likewise the $\lambda_m$ derivation is real, at [second-order.md](../findings/second-order.md):593–597, and I re-derived it. Nothing in the ten values is unargued: the one value with no argument in the block, $1$ on $\langle W\rangle$, follows from $e$ being an idempotent, which the record states at [second-order.md](../findings/second-order.md):11.

**One standing observation on the programme's footing.** Two of the block's supports are computations offered for positive claims: the "exact $O(m)$-commutant computation at $m=3,4$" and the "symbolic solve over all $45$ summand pairs". **Neither is needed.** Multiplicity-freeness at $p,q\le4$ follows from distinct admissible Young labels plus the source's own $O(k)\times O(l)$ clause (§2b), and the uniqueness of the $(3,3)$ coincidence is two lines of integer arithmetic (§7, candidate C). Replacing both with the analytic arguments would cost the block nothing and would remove its only reliance on numerics.

### What would falsify this statement, and what I did to look for it

**The object.** A vector $V\in\mathrm{Weyl}_{p+q}$, for some $p,q\ge3$ with $(p,q)\ne(3,3)$, orthogonal to $W_{p,q}$ and to $\mathbb R^p\otimes\mathbb R^q$, with $L_eV=\tfrac12V$, equivalently, an eleventh summand, or a second summand whose scalar is $\tfrac12$, or an $L_e$-eigenvector straddling two summands.

**Where I looked.**

- **An eleventh summand** is excluded by §2a: the ten dimensions exhaust $\dim\mathrm{Weyl}_n$ as a polynomial identity in $p,q$, so nothing is left over. I pushed the identity below its range precisely to see where it could break, and it breaks only at $q\le2$ (§5b), outside the scope.
- **A second summand at $\tfrac12$** is excluded by evaluating all ten values (§4): $1$ is off $W^\perp$; $\lambda_m$ is short of $\tfrac12$ by $\frac1{2(m-1)}>0$ at every $m\ge2$; $-\mu<0$; $0\ne\tfrac12$; and $\mu=\tfrac12$ needs $(p-2)(q-2)=1$, i.e. $p=q=3$ over integers $\ge3$. **The only escape is an error in one of the ten values**, and the trace identity constrains them jointly, I re-derived it and it closes to $0$.
- **A straddling eigenvector** is excluded by multiplicity-freeness plus self-adjointness: distinct summands are non-isomorphic, so $L_e$ preserves each, and eigenvectors of a self-adjoint operator with distinct eigenvalues are orthogonal. I checked the distinctness at the two places it could fail, the $\det$-twist coincidences $X_3\cong S^2_0(\mathbb R^3)\otimes\det$ and $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$, and the factor swap at $p=q$ (§2b), and it does not fail, because the group is $O(p)\times O(q)$ and not $SO(p)\times SO(q)$.
- **A near miss**, which is the honest finding: at $(3,5)$ two summands *do* share an eigenvalue, $\mu=\lambda_5=\tfrac38$, and at $(4,4)$ likewise at $\tfrac13$. Both are safely below $\tfrac12$. Had the arithmetic put either at $\tfrac12$, the statement would have failed at a split nobody expected, which is why §4 evaluates every value rather than only the two the block singles out.

**Nothing I looked for was found. No numerical work was done in the looking.**
