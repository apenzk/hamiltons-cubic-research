# VERIFY_v8, L04: "a generator for critical points, and a new family"

Verifier `v8`. Cold brief; no numerical work of any kind was performed. Every quantity below is a closed-form rational or surd, obtained by hand.

## 1. Hypothesis inventory

### 1.1 Hypotheses the entry states

| # | Hypothesis | Where used in the entry | Status |
|---|---|---|---|
| H1 | $K\subseteq SO(n)$ | criticality generator | needed only so that $K$ acts orthogonally on $\mathcal W_n$ |
| H2 | $(\Lambda^4\mathbb R^n)^K=0$ | criticality generator | **redundant for criticality** (F1); it is a filter on which $K$ enter the family |
| H3 | $\dim\mathcal W_n^K=1$ | criticality generator | this is the whole of the generator (F1) |
| H4 | "every member has just two eigenvalues" | closed form, cap | **false** under H1–H3 (F3) |
| H5 | $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra, $r=\dim\mathfrak h$ | closed form, cap | used, but $\mathfrak h$ is undefined for a member whose $W$ is not $a\Pi_{\mathfrak h}+bI$ |
| H6 | "$\theta$ increases with $\dim\mathfrak h$" | cap argument | true *given* the closed form, hence inherits H4's failure (F5) |
| H7 | Lemma L23 | cap and the "simple isotropy tops out" claim | not exhibited; load-bearing (F5) |

### 1.2 Hypotheses the entry leaves unstated

| # | Unstated hypothesis | Consequence if dropped |
|---|---|---|
| U1 | $n$ even | $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ does not exist for odd $n$; the "attained by" clause is vacuous there (F6) |
| U2 | $W$ has the specific form $c\,(\Pi_{\mathfrak h}-\tfrac rN I)$ | the closed form and the cap both silently assume it; the generator does not deliver it (F3) |
| U3 | $r\ge n/2$ | forced by $\kappa(\mathfrak h)\ge 0$ (F4); never stated, and it is the true lower edge of the family |
| U4 | the two-eigenvalue family and the generator's output set are the same set | they are not: the maximal torus is in the first and not the second; $SO(5)\times SO(7)$ is in the second and not the first (F3) |
| U5 | the value $\theta$ of a member is determined by $r$ | true only inside the two-eigenvalue family (F2 proves it there) |

### 1.3 Conventions fixed for this report

$N=\binom n2$; $S^2(\mathfrak{so}(n))$ carries $\langle A,B\rangle=\operatorname{tr}(AB)$ with $\{e_i\wedge e_j\}_{i<j}$ orthonormal; $\Pi_{\mathfrak h}$ is orthogonal projection of $\Lambda^2\mathbb R^n$ onto $\mathfrak h$; $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ is totally antisymmetric in an orthonormal basis $\{\varphi_\alpha\}$ of $\mathfrak{so}(n)$; $A^{\#}_{\alpha\beta}=\tfrac12 c_{\alpha\gamma\epsilon}c_{\beta\delta\zeta}A_{\gamma\delta}A_{\epsilon\zeta}$, and $T(A,B,C):=\langle A\#B,\,C\rangle$. I write $\kappa(\mathfrak h):=\sum_{a,c\in\mathfrak h}\lVert[\varphi_a,\varphi_c]\rVert^2$ for an orthonormal basis of $\mathfrak h$.

## 2. Imported-theorem checks

All four imports were read in the source, not taken from memory.

### 2.1 Böhm–Wilking, *Manifolds with positive curvature operators are space forms*

Read at [boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187); absolute path `references/boehm-wilking-2008-space-forms/`.

- **Trilinear symmetry** (line 198 and the display above it): `tri(R1,R2,R3) = tr((R1R2+R2R1+2 R1#R2)·R3)` is "symmetric in all three components", attributed to Huisken, with the manifestly symmetric expansion $\sum_{\alpha\beta\gamma}\langle[R_1b_\alpha,R_2b_\beta],R_3b_\gamma\rangle\langle[b_\alpha,b_\beta],b_\gamma\rangle$. Hypotheses: none beyond $R_i\in S^2(\mathfrak{so}(n))$. **Applies.** Hence $T$ above is fully symmetric.
- **$P$ is the potential of $Q$** (line 198): $P(R)=\tfrac13\operatorname{tr}(R^3+RR^{\#})=\tfrac16\mathrm{tri}(R,R,R)$ is the function whose gradient flow is $\dot R=R^2+R^{\#}$. This is the project's $P$ up to the factor 3, so $\nabla P=3Q(W)$ in the project's normalisation. **Applies.**
- **Lemma 2.1** (line ~"Lemma 2.1"): for $R\in S^2_B(\mathfrak{so}(n))$, $R+R\#I=(n-1)R_I+\tfrac{n-2}{2}R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$. Hypothesis: $R$ satisfies the first Bianchi identity. **Applies to $W\in\mathcal W_n$**, and since $W$ has $R_I=0$ and $R_{\mathrm{Ric}_0}=0$ it gives the identity I use throughout:
  $$W\,\#\,I=-\,W\qquad\text{for every }W\in\mathcal W_n .$$
  Putting $R=I$ in the same lemma gives $I+I^{\#}=(n-1)I$, i.e. $I^{\#}=(n-2)I$, which fixes my normalisation of $\#$ against the source.
- **Equation (6)** (line 203): $\mathrm{Ric}(R^2+R^{\#})_{ij}=\sum_k \mathrm{Ric}_{kk}R_{kijk}$, in an orthonormal eigenbasis of $\mathrm{Ric}$. Hypothesis: $R$ Bianchi. **Applies to $W$**, and since $\mathrm{Ric}(W)=0$ it yields $\mathrm{Ric}(Q(W))=0$. Combined with $\operatorname{tr}Q(W)=\lVert W\rVert^2+T(W,W,I)=\lVert W\rVert^2+\langle W\#I,W\rangle=0$, this proves $Q(\mathcal W_n)\subseteq\mathcal W_n$, so the project README's "sending $W_n$ to itself" is correct and criticality on the unit sphere is exactly $Q(W)=\lambda W$ with no projection.

### 2.2 Principle of symmetric criticality

The entry appeals to "equivariance", not to Palais, and that is the right call: no properness or compactness hypothesis is needed here. For $K$ acting orthogonally on the Euclidean space $\mathcal W_n$ and $P$ $K$-invariant, $\nabla P$ is $K$-equivariant, so $\nabla P(\mathcal W_n^K)\subseteq\mathcal W_n^K$. Palais' theorem would additionally require $K$ compact and the fixed set a submanifold; both hold, but neither is used. **No imported hypothesis fails.**

### 2.3 Cartan: invariant forms compute cohomology on a compact symmetric space

Used implicitly by the entry's identification of $(\Lambda^4\mathbb R^n)^K=0$ with $b_4=0$. For a compact symmetric space $G/K$ the harmonic forms are the $K$-invariant elements of $\Lambda^\bullet\mathfrak m$, so $(\Lambda^4\mathfrak m)^K\cong H^4(G/K;\mathbb R)$. **Applies to the listed examples.** For a compact simple Lie group $H^\ast$ is exterior on generators of odd degree $\ge3$, so $b_4=0$ automatically, the entry's claim that bi-invariant metrics on compact simple groups satisfy H2 is correct. I checked the corresponding statement for $\mathbb{CP}^k$ directly instead: $\omega\wedge\omega\ne0$ is $U(k)$-invariant in $\Lambda^4\mathbb R^{2k}$, so $\mathbb{CP}^k$ fails H2, consistent with $b_4(\mathbb{CP}^k)=1$.

## 3. Findings

### F1, H2 is redundant for criticality; the generator is $\dim\mathcal W_n^K=1$ alone

**Re-derivation.** $P$ is a cubic polynomial on $\mathcal W_n$ with $\nabla P(W)=3Q(W)$ (Böhm–Wilking's identification of $P$ as the potential, §2.1). $K\subseteq SO(n)$ acts orthogonally on $\mathcal W_n$ and $P$ is $O(n)$-invariant, so $\nabla P$ is equivariant and $\nabla P(\mathcal W_n^K)\subseteq\mathcal W_n^K$. If $\dim\mathcal W_n^K=1$ and $W$ spans it with $\lVert W\rVert=1$, then $Q(W)\in\mathbb R W$, i.e. $Q(W)=\lambda W$; the spherical gradient $3(Q(W)-\langle Q(W),W\rangle W)$ vanishes. $W$ is critical. $(\Lambda^4\mathbb R^n)^K$ never enters.

**Concrete instance where H2 is doing nothing.** $K=U(k)\subseteq SO(2k)$, $n=2k$. Under $U(k)$, $\Lambda^2\mathbb R^{2k}$ splits as $\mathbb R\omega\oplus\mathfrak{su}(k)\oplus[\![\Lambda^{2,0}]\!]$, three pairwise non-isomorphic real-type irreducibles, so $\dim(S^2\Lambda^2)^{U(k)}=3$; imposing $\operatorname{tr}=0$ and $\mathrm{Ric}_0=0$ leaves $\dim\mathcal W_{2k}^{U(k)}=1$, spanned by the Weyl operator of $\mathbb{CP}^k$. So $\mathbb{CP}^k$'s Weyl tensor **is** a critical point of $P$ by the argument above, yet $K=U(k)$ fails H2 because $\omega\wedge\omega\ne0$. The generator as stated refuses a critical point it in fact produces.

**Strongest defence.** H2 is not idle in the entry's *overall* design: it is what makes an invariant element of $S^2\Lambda^2$ automatically Bianchi (the Bianchi obstruction of a $K$-invariant operator lies in $(\Lambda^4)^K$), which is how one verifies "$\dim\mathcal W_n^K=1$" cheaply for a candidate $K$, and it is what prunes $\mathbb{CP}^k$ out of the two-eigenvalue family. So H2 earns its place as a *screening* condition. The defect is only that the entry sells it as part of the criticality mechanism, which it is not.

**Severity.** Presentational; the generator is sound and in fact stronger than advertised.

### F2, the closed form is a theorem, not a fit, and its correct hypothesis is not the one given

The entry offers "checked against held-out spaces it was never fitted to", which is a description of validation, not of proof. Here is the proof, together with the hypothesis it actually needs.

**Setup.** Let $\mathfrak h\subseteq\mathfrak{so}(n)$ be a subalgebra of dimension $r$ and suppose $\hat W:=\Pi_{\mathfrak h}-\tfrac rN I\in\mathcal W_n$.

**Step A, the three cubic terms.** With $\Pi=\Pi_{\mathfrak h}$ and an orthonormal basis adapted to $\mathfrak h\oplus\mathfrak h^{\perp}$:
- $T(\Pi,\Pi,\Pi)=\tfrac12\sum_{a,c,d\in\mathfrak h}c_{acd}^2=\tfrac12\kappa(\mathfrak h)$, using $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$;
- $(\Pi\#I)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\epsilon}c_{\alpha\gamma\epsilon}c_{\beta\delta\epsilon}\Pi_{\gamma\delta}$ (polarise $(\Pi+I)^{\#}$), whence $T(\Pi,\Pi,I)=\langle\Pi\#I,\Pi\rangle=\tfrac12\sum_{a,c\in\mathfrak h}\lVert[\varphi_a,\varphi_c]\rVert^2=\tfrac12\kappa(\mathfrak h)$;
- $T(\Pi,I,I)=\langle\Pi,I^{\#}\rangle=(n-2)r$ and $T(I,I,I)=(n-2)N$, from $I^{\#}=(n-2)I$.

**Step B, $\kappa$ is forced.** $\operatorname{tr}(\hat W^{\#})=T(\hat W,\hat W,I)=\tfrac{\kappa}{2}-2t(n-2)r+t^2(n-2)N=\tfrac\kappa2-\tfrac{(n-2)r^2}{N}$ with $t=r/N$. Böhm–Wilking Lemma 2.1 gives $\hat W\#I=-\hat W$, so $\operatorname{tr}(\hat W^{\#})=\langle \hat W\#I,\hat W\rangle=-\lVert\hat W\rVert^2=-\tfrac{r(N-r)}{N}$. Solving, and using $N=\tfrac{n(n-1)}2$:
$$\boxed{\;\kappa(\mathfrak h)=\frac{4r^2}{n}-2r\;}$$
This uses only $\hat W\in\mathcal W_n$, no symmetric space, no Einstein condition, no $b_4$.

**Step C, assemble.** $\lVert\hat W\rVert^2=\tfrac{r(N-r)}{N}$, $\operatorname{tr}(\hat W^3)=\tfrac{r(N-r)(N-2r)}{N^2}$, and
$$\langle\hat W,\hat W^{\#}\rangle=\tfrac{\kappa}{2}\!\left(1-\tfrac{3r}{N}\right)+\tfrac{2(n-2)r^3}{N^2}.$$
Substituting $\tfrac\kappa2=\tfrac{2r^2}{n}-r$ and clearing $nN^2$, the sum is $2r^2N^2-6r^3N+2n^2r^3-2nr^3$; since $n(n-1)=2N$ this equals $2r^2N^2-2r^3N$, i.e.
$$P(\hat W)=\frac{2r^2(N-r)}{nN},\qquad \theta=\frac{P}{\lVert\hat W\rVert^{3}}=\frac2n\sqrt{\frac{rN}{N-r}} .$$

**Independent cross-checks (all closed form).**
1. $\mathfrak h=\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $n=2m$: directly $\kappa=2\cdot2(m-2)\binom m2=2m(m-1)(m-2)$, and $\tfrac{4r^2}{n}-2r=2m(m-1)^2-2m(m-1)=2m(m-1)(m-2)$. Equal.
2. Same $\mathfrak h$: $r=\tfrac{n(n-2)}4$, $N-r=\tfrac{n^2}4$, so $\tfrac{rN}{N-r}=\tfrac{(n-1)(n-2)}2$ and $\theta^2=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. The formula reproduces the balanced sphere product exactly.
3. A second, disjoint derivation. For any Einstein symmetric space, Ricci flow gives $Q(R)=\lambda R$ with $\mathrm{Ric}=\lambda g$; writing $W=R-sI$, $s=\operatorname{tr}R/N$, and expanding with $T(R,R,R)=\lambda\lVert R\rVert^2-\operatorname{tr}R^3$, $T(R,R,I)=\lambda\operatorname{tr}R-\operatorname{tr}R^2$, $T(R,I,I)=(n-2)\operatorname{tr}R$, everything collapses to $P(W)=(n-1)s\lVert W\rVert^2$, i.e. $\theta=\lambda/\lVert W\rVert$. For $R=\Pi_{\mathfrak h}$ this gives $\theta=(n-1)\sqrt{r/(N(N-r))}$, which is identically $\tfrac2n\sqrt{rN/(N-r)}$ because $\tfrac{(n-1)n}{2N}=1$.
4. Compact simple $G$ with bi-invariant metric: $\mathfrak h=\mathrm{ad}(\mathfrak g)$, $r=n$, giving $\theta^2=\tfrac{4(n-1)}{n(n-3)}$, strictly decreasing in $n$. $SU(3)$ ($n=8$): $\theta^2=\tfrac{28}{40}=\tfrac7{10}$, and $\sqrt{7/10}$ is the entry's $0.8367$. $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ ($n=6$): $\theta^2=\tfrac{4\cdot5}{6\cdot3}=\tfrac{10}9=\theta_0(6)^2$, the entry's boundary case $S^3\times S^3$ recovered exactly.
5. $SU(6)/Sp(3)$: $r=21$, $n=14$, $N=91$, $\theta^2=\tfrac{4}{196}\cdot\tfrac{21\cdot91}{70}=\tfrac{1911}{3430}$, and $0.7464^2$ agrees.

**Strongest defence of the entry.** The formula is correct and the entry's numbers are right. The objection is only that no derivation is offered and the stated grounds ("held-out spaces") cannot establish a universally quantified identity.

**Severity.** Proof-debt, now discharged above. **The correct hypothesis is $\Pi_{\mathfrak h}-\tfrac rN I\in\mathcal W_n$**, which is weaker and cleaner than "isotropy-irreducible symmetric space with $b_4=0$".

### F3, "every member has just two eigenvalues" is false: $K=SO(5)\times SO(7)\subseteq SO(12)$

**Re-derivation.** Take $n=n_1+n_2$, $K=SO(n_1)\times SO(n_2)$ with $n_1,n_2\ge5$, $V_i=\mathbb R^{n_i}$.

*It satisfies H2.* $\Lambda^4(V_1\oplus V_2)=\bigoplus_{a+b=4}\Lambda^aV_1\otimes\Lambda^bV_2$, and $(\Lambda^aV_i)^{SO(n_i)}=0$ for $1\le a\le 4<n_i$, so every summand with $a+b=4$ has no invariant. $(\Lambda^4\mathbb R^n)^K=0$.

*It satisfies H3.* $\Lambda^2\mathbb R^n=\Lambda^2V_1\oplus\Lambda^2V_2\oplus(V_1\otimes V_2)$: three pairwise non-isomorphic real-type irreducible $K$-modules, so the invariant symmetric operators are exactly $x\Pi_{\Lambda^2V_1}+y\Pi_{\Lambda^2V_2}+z\Pi_{V_1\otimes V_2}$, a 3-dimensional space. Bianchi is automatic by H2. The Ricci eigenvalues are $x(n_1-1)+zn_2$ on $V_1$ and $y(n_2-1)+zn_1$ on $V_2$; $\mathrm{Ric}=0$ (which is $\mathrm{Ric}_0=0$ together with $\operatorname{tr}=0$) reads
$$x(n_1-1)+zn_2=0,\qquad y(n_2-1)+zn_1=0,$$
two independent conditions, leaving $\dim\mathcal W_n^K=1$, spanned by
$$(x,y,z)=\bigl(n_2(n_2-1),\;n_1(n_1-1),\;-(n_1-1)(n_2-1)\bigr).$$

**Failure exhibited.** For $(n_1,n_2)=(5,7)$, $n=12$: $(x,y,z)=(42,20,-24)$, **three distinct eigenvalues**. The entry's H4 fails on a $K$ that satisfies both of its stated hypotheses, at the very dimension $n=12$ the goal is about.

*Independent confirmation of the same tensor.* $S^5(1/\sqrt3)\times S^7(1/\sqrt2)$ is Einstein ($3\cdot4=2\cdot6=\lambda=12$) with $R=\mathrm{diag}(3,2,0)$ on the three blocks, $\operatorname{tr}R=3\cdot10+2\cdot21=72$, $s=72/66=12/11$, and $W=R-sI=\tfrac1{11}(21,10,-12)$, proportional to $(42,20,-24)$.

Its true value, from $\theta=\lambda/\lVert W\rVert$ (F2 cross-check 3): $\lVert W\rVert^2=\tfrac{441\cdot10+100\cdot21+144\cdot35}{121}=\tfrac{11550}{121}$, so
$$\theta^2=\frac{144\cdot121}{11550}=\frac{2904}{1925}.$$
Sanity: $\theta^2<\theta_0(12)^2=\tfrac{55}{36}$ since $2904\cdot36=104544<105875=55\cdot1925$. The member is a genuine critical point strictly below the balanced product, the conjecture is not threatened; only the entry's description of the family is.

**Strongest defence.** One may read "member" as *member of the two-eigenvalue subfamily*, in which case H4 is true by fiat. But then H4 is a tautology, not the observation the entry presents, and the family it delimits is no longer the generator's output set, which is exactly what F5 needs it to be.

**Severity.** Breaks the stated characterisation of the family.

### F4, the closed form has an unstated floor $r\ge n/2$, and is unbounded above

**Re-derivation.** $\kappa(\mathfrak h)=\sum_{a,c}\lVert[\varphi_a,\varphi_c]\rVert^2\ge 0$ always, with equality iff $\mathfrak h$ is abelian. F2 Step B forces $\kappa=\tfrac{4r^2}{n}-2r=2r\bigl(\tfrac{2r}{n}-1\bigr)$. Hence **every** two-eigenvalue member has $r\ge n/2$, with equality iff $\mathfrak h$ is abelian.

**The floor is attained.** $n$ even, $\mathfrak h=\operatorname{span}\{e_1\wedge e_2,\dots,e_{n-1}\wedge e_n\}$ a maximal torus, $r=n/2$. Bianchi holds because each $\omega_i$ is decomposable so $\sum_i\omega_i\wedge\omega_i=0$; $\mathrm{Ric}(\Pi_{\mathfrak h})=\mathrm{id}$ and $\mathrm{Ric}(tI)=t(n-1)\mathrm{id}$ with $t(n-1)=\tfrac{(n/2)(n-1)}{n(n-1)/2}=1$, so $\Pi_{\mathfrak h}-\tfrac rN I$ is Ricci-flat and lies in $\mathcal W_n$. Its value is $\theta^2=\tfrac{2(n-1)}{n(n-2)}$.

**Two consequences the entry does not record.**
1. This torus member belongs to the closed-form family but **not** to the generator's output set: $\mathcal W_n^{T}$ for a maximal torus $T$ has dimension far above 1. So the two families named in the entry are genuinely different sets, in both directions (with F3 supplying the other direction).
2. At the top edge, $\theta\to\infty$ as $r\to N$, and $r=N$ is degenerate ($\Pi_{\mathfrak h}=I$, $\hat W=0$). The formula carries **no internal bound**. Everything in the entry's maximality claim therefore rests on the cap, and on nothing else.

**Strongest defence.** These are edges, not errors; the entry's listed examples all sit comfortably inside. Granted, but U3 and the unboundedness are exactly what make F5 load-bearing rather than cosmetic.

**Severity.** Unstated hypotheses; no false statement.

### F5, the cap $r\le n(n-2)/4$ is false as stated, and unproved even in the restricted reading

**Re-derivation of the entry's argument.** $r\mapsto \tfrac{r}{N-r}$ is strictly increasing on $[0,N)$, so H6 is correct *conditional on the closed form*. The maximality claim is then exactly the assertion $r\le n(n-2)/4$ over the family.

**Failure exhibited, reading A ("how large a subalgebra can be while still generating a critical point").** $\mathfrak h=\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subseteq\mathfrak{so}(12)$ has $r=10+21=31$, and by F3 its $K$ satisfies H2 and H3 and does generate a critical point. But $\tfrac{n(n-2)}4=\tfrac{12\cdot10}4=30<31$. The cap is violated by a member the entry's own hypotheses admit. Worse, feeding $r=31$ into the closed form gives
$$\theta_{\text{formula}}^2=\frac{4}{144}\cdot\frac{31\cdot 66}{35}=\frac{341}{210},$$
and $341\cdot36=12276>11550=55\cdot210$, so $\theta_{\text{formula}}^2>\theta_0(12)^2$. Taken at face value the entry's own two claims contradict the goal it serves. (They do not refute the conjecture, because the true value is $\tfrac{2904}{1925}$ by F3; the formula simply does not apply, $341\cdot1925=656425>609840=2904\cdot210$, so it overstates by a definite margin.)

**Failure exhibited, reading B (cap restricted to two-eigenvalue members).** Then the cap is not proved here and does not follow from anything stated. The only elementary bound available is $\kappa\le\sum_{a\in\mathfrak h}\sum_{c\in\mathfrak{so}(n)}\lVert[\varphi_a,\varphi_c]\rVert^2=2(n-2)r$ (the $\mathfrak{so}(n)$ Casimir on $\Lambda^2$ is $2(n-2)$), and combining with F2 Step B:
$$\frac{4r^2}{n}-2r\le 2(n-2)r\iff \frac{2r}{n}\le n-1\iff r\le N,$$
which is vacuous. Under reading B the cap is equivalent to Conjecture A restricted to this family, so citing it as an input to the conjecture's proof would be circular unless Lemma L23 proves it independently, and Lemma L23 (H7) is not exhibited.

**Strongest defence.** If the family is *defined* as the two-eigenvalue members and Lemma L23 really does bound $r$ there by a route independent of the conjecture, the entry's arithmetic is fine and only its phrasing over-reaches. That is possible; it is also unverifiable from the entry, which is the point. The sub-claim "members with simple isotropy top out at $0.8367$" I *can* verify for compact simple Lie groups: $\theta^2=\tfrac{4(n-1)}{n(n-3)}$ is decreasing in $n$, degenerate at $n=3$ ($r=N$, $W=0$), so $SU(3)$ at $n=8$ is the maximum, $\theta=\sqrt{7/10}$. That part is sound.

**Severity.** Breaks the cap as stated; leaves a named, load-bearing, absent lemma under the charitable reading.

### F6, the maximiser clause is an even-$n$ statement presented without the restriction

**Re-derivation.** $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ requires $n$ even; the cap value $n(n-2)/4$ is an integer for all even $n$ and is attained there.

**Failure exhibited.** $n=13$: there is no $\mathfrak{so}(6.5)$, no balanced sphere product, and the best product of round spheres is the unbalanced $S^6\times S^7$, whose $\theta$ is strictly below $\theta_0(13)$ by the mechanism of F3. The clause "attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, so the balanced sphere product is itself a member and the family's maximiser" is simply empty for odd $n$, and the goal ($n\ge12$) includes odd $n$.

**Strongest defence.** The conjecture's extremal object may be defined only for even $n$ elsewhere in the record, with odd $n$ handled by a separate route; $\theta_0(n)$ as given is a formula, not necessarily an attained value. Fair, but then the entry's unqualified "the family's maximiser" should say so.

**Severity.** Scope, correctable by adding "$n$ even".

## 4. Withdrawn candidates

### W1, "zero-padding breaks criticality via the kernel", **withdrawn**

I expected the record's recurring kernel obstruction to bite: padding $W\in\mathcal W_{n}$ by zero into $\mathcal W_{n'}$, $n'>n$, the operator $Q(\tilde W)$ is supported on $\Lambda^2\mathbb R^{n}$, and if it carried a scalar or traceless-Ricci part measured in dimension $n'$, the $\mathcal W_{n'}$-projection would acquire components on $\Lambda^2\mathbb R^{n'-n}$ and on the mixed block, destroying $Q(\tilde W)\parallel\tilde W$. It does not happen. Böhm–Wilking eq. (6) gives $\mathrm{Ric}(Q(W))=0$ for every $W\in\mathcal W_n$, and Lemma 2.1 gives $\operatorname{tr}Q(W)=\lVert W\rVert^2+\langle W\#I,W\rangle=\lVert W\rVert^2-\lVert W\rVert^2=0$; so $Q(W)\in\mathcal W_n$ and criticality reads $Q(W)=\lambda W$ with no projection at all. Padding commutes with $\#$ because $\mathfrak{so}(n)\subseteq\mathfrak{so}(n')$ is a subalgebra, so $Q(\tilde W)=\widetilde{Q(W)}=\lambda\tilde W$, and $\tilde W$ is trace-free and Ricci-flat in dimension $n'$ as well. $\lVert\cdot\rVert$ and $P$ are likewise unchanged. **The entry's "zero-padding preserves everything" is correct and unconditional.**

### W2, "$K=SO(n-1)$ is a member with $r=\binom{n-1}{2}$, far above the cap", **withdrawn**

I first read the invariants of $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^{n-1}\oplus\mathbb R^{n-1}$ under $SO(n-1)$, imposed only $\operatorname{tr}=0$, and obtained a 1-dimensional space with $r=\binom{n-1}2$ vastly exceeding $n(n-2)/4$. Imposing $\mathrm{Ric}_0=0$ as well kills it: for $x\Pi_{\Lambda^2\mathbb R^{n-1}}+y\Pi_{\text{mixed}}$ the Ricci eigenvalues are $x(n-2)+y$ and $y(n-1)$, so $\mathrm{Ric}_0=0$ forces $x=y$, and trace-freeness then forces $x=0$. Hence $\mathcal W_n^{SO(n-1)}=0$ and H3 fails. The lesson generalises: a candidate counterexample must impose Ricci-flatness, not merely $\operatorname{tr}=0$, and F3's $SO(n_1)\times SO(n_2)$ survives precisely because it has one more invariant block to spend.

## 5. Verdict

**BROKEN.**

The two halves of the entry come apart.

**What survives, in corrected form:**
- *Generator.* If $K\subseteq SO(n)$ and $\dim\mathcal W_n^K=1$, the spanning unit $W$ satisfies $Q(W)=\lambda W$ and is a critical point of $P$ on the unit sphere of $\mathcal W_n$. $(\Lambda^4\mathbb R^n)^K=0$ is **not** needed; it is a screening condition that also removes $\mathbb{CP}^k$, a bona fide critical point. (F1)
- *Closed form.* If $\mathfrak h\subseteq\mathfrak{so}(n)$ is a subalgebra with $\Pi_{\mathfrak h}-\tfrac rN I\in\mathcal W_n$, then $\kappa(\mathfrak h)=\tfrac{4r^2}{n}-2r$ and $\theta=\tfrac2n\sqrt{rN/(N-r)}$ exactly. This is a theorem, proved in F2 from Böhm–Wilking Lemma 2.1; it needs neither a symmetric space nor Einstein nor $b_4=0$, and it is stronger than the entry claims. Zero-padding is unconditionally value- and criticality-preserving (W1).
- *Simple-isotropy ceiling.* Among compact simple Lie groups, $\theta^2=\tfrac{4(n-1)}{n(n-3)}$ is maximised at $SU(3)$, $\theta=\sqrt{7/10}$. (F2, cross-check 4)

**What is broken:**
- "Every member has just two eigenvalues" is false for $K=SO(5)\times SO(7)\subseteq SO(12)$, which satisfies both stated hypotheses and whose unique invariant Weyl tensor is $(42,20,-24)$. (F3)
- The cap $r\le n(n-2)/4$ is false for that same member ($r=31>30$); applying the closed form to it returns $\tfrac{341}{210}>\theta_0(12)^2=\tfrac{55}{36}$, against a true value of $\tfrac{2904}{1925}$. Under the charitable reading that restricts the family to two-eigenvalue members, the cap is unproved and reduces to the conjecture itself; the elementary Casimir bound yields only the vacuous $r\le N$. **Lemma L23 is load-bearing and absent, that is the hypothesis-debt inside the BROKEN verdict.** (F5)
- The maximiser clause is stated for all $n$ but is empty for odd $n$. (F6)

**What would have to be proved to repair the second half:** a bound $r\le n(n-2)/4$ over $\{\mathfrak h\subseteq\mathfrak{so}(n) \text{ subalgebra}: \Pi_{\mathfrak h}-\tfrac rN I\in\mathcal W_n\}$, by a route independent of Conjecture A, together with an explicit restriction of "member" to that set and a separate treatment of the generator's non-two-eigenvalue outputs.
