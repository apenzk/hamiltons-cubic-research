# Verifier v376, the witness step G1 of Lemma L20: the balanced sphere product as a unit Weyl operator with P=θ₀(n)>θ* at every n≥12

Cold brief ([ADJ_L20r2_G1.md](ADJ_L20r2_G1.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L20-v376.log](../agent_logs/verify-L20-v376.log).

| Claim | Verdict |
| --- | --- |
| At every even $n\ge12$ the balanced product $S^{n/2}\times S^{n/2}$ gives a unit Weyl operator with $P=\theta_0(n)$ | CONFIRMED |
| $\theta_0(n)>\theta^*$ at every $n\ge12$, as a number | CONFIRMED |
| At every $n\ge12$ the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$ | REFUTED AS STATED (fails at every odd $n\ge13$) |
| At odd $n$ no two-factor sphere product attains $\theta_0(n)$: the best is $\Theta_n$ with $\theta_0(n)^2-\Theta_n^2=\frac{8(n-1)}{n^2(n-2)(n+1)}>0$ | CONFIRMED |
| At $n=13$: $\Theta_{13}^2=\tfrac{120}{77}<\tfrac{264}{169}=\theta_0(13)^2$, gap $\tfrac{48}{13013}$ | CONFIRMED AS ALGEBRA |
| Repaired step: at every $n\ge12$ the best two-factor sphere product is a unit Weyl operator with $P=\Theta_n>\theta^*$ | CONFIRMED |

**Summary: the step FAILS as written, because at odd $n$ there is no balanced split and the best split attains $\Theta_n<\theta_0(n)$, but the contradiction L20 needs survives with $\Theta_n$ in place of $\theta_0(n)$, as Passage A already states it.**

## 0. Conventions, fixed once

- $\mathcal W_n$ carries the $\Lambda^2$-level inner product in which the bivectors $\varphi_{ab}$, $a<b$, are orthonormal, and a curvature operator is an endomorphism of $\Lambda^2=\mathfrak{so}(n)$ with the Frobenius norm on that endomorphism ([conventions.md](../findings/conventions.md) lines 85 and 88).
- $\#$ is the halved Böhm–Wilking product, pinned by $\mathrm{id}^\#=(n-2)\,\mathrm{id}$ and so $Q(\mathrm{id})=(n-1)\,\mathrm{id}$ ([conventions.md](../findings/conventions.md) lines 75 and 79). In the orthonormal basis $\{\varphi_\alpha\}$, $\langle A^\#u,v\rangle=\tfrac12\sum_{\alpha,\beta}\langle[A\varphi_\alpha,A\varphi_\beta],u\rangle\langle[\varphi_\alpha,\varphi_\beta],v\rangle$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta^*=\sqrt{3/2}$, $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, and $\Theta_n$ as in the brief.
- [conventions.md](../findings/conventions.md) line 18 records that $\theta_0(n)$ is the balanced value at even $n$ only. Section 2 derives this independently, so the verdict rests on the derivation and uses the table only to fix the normalisation.

## 1. Hypothesis inventory

- **H1 (normalisation).** The inner product and $\#$ are those of section 0. Section 2 checks this against both closed forms in the brief, $\theta_0(n)$ at $p=q$ and $\Theta_n$ at $|p-q|=1$, so a different normalisation would contradict the brief's own formulas.
- **H2 (reading of "sphere product").** The witness is the Weyl part of the curvature operator of a Riemannian product $S^p\times S^q$ with $p+q=n$ and $p,q\ge2$, normalised to unit norm and signed so that $P>0$. Section 2.1 shows the direction is independent of the two radii, so this reading has no hidden parameter.
- **H3 (what the contradiction consumes).** Lemma L20's proof uses the witness only as some unit Weyl operator with $P>\theta^*$ (Passage A: "the contradiction is with the value, not the location"). No other property of the witness enters.
- **H4 (repaired reading).** "The balanced sphere product ... with $P=\theta_0(n)$" is read as "the best two-factor sphere product ... with $P=\Theta_n$", which coincides with the words at even $n$ and is the reading Passage A's proof body states.

## 2. The value of $P$ on every two-factor sphere product

### 2.1 The Weyl direction of $S^p\times S^q$

Write $\mathbb R^n=V_1\oplus V_2$ with $\dim V_1=p$, $\dim V_2=q$, and $\mathfrak{so}(n)=\mathfrak{so}(p)\oplus\mathfrak{so}(q)\oplus\mathfrak m$ with $\mathfrak m=V_1\wedge V_2$ of dimension $pq$. The curvature operator of $S^p(r_1)\times S^q(r_2)$ is $a\,\mathrm{id}_{\mathfrak{so}(p)}\oplus b\,\mathrm{id}_{\mathfrak{so}(q)}\oplus0_{\mathfrak m}$. In Kulkarni–Nomizu form it is $\tfrac a2g_1\owedge g_1+\tfrac b2g_2\owedge g_2$. Since $h\owedge g$ has zero Weyl part for every symmetric $h$, and $g_1\owedge g_1=g_1\owedge g-g_1\owedge g_2$, $g_2\owedge g_2=g_2\owedge g-g_1\owedge g_2$, the Weyl part is $-\tfrac{a+b}2\,\mathcal W(g_1\owedge g_2)$. Its direction is therefore fixed by $(p,q)$ alone, up to sign, whatever the radii.

Every operator block-diagonal as $x\,\mathrm{id}\oplus y\,\mathrm{id}\oplus z\,\mathrm{id}$ on the three summands is a sum of such Kulkarni–Nomizu terms, hence an algebraic curvature operator. Its Ricci form is $((p-1)x+qz)\,g_1+((q-1)y+pz)\,g_2$, so it is Weyl exactly when $x=-\frac{q}{p-1}z$ and $y=-\frac{p}{q-1}z$. Take $z=-1$:

$$W_{p,q}=\tfrac{q}{p-1}\,\mathrm{id}_{\mathfrak{so}(p)}\oplus\tfrac{p}{q-1}\,\mathrm{id}_{\mathfrak{so}(q)}\oplus(-1)\,\mathrm{id}_{\mathfrak m}.$$

### 2.2 The sharp product on block-diagonal operators

The brackets satisfy $[\mathfrak{so}(p),\mathfrak{so}(p)]\subset\mathfrak{so}(p)$, $[\mathfrak{so}(p),\mathfrak{so}(q)]=0$, $[\mathfrak{so}(p),\mathfrak m]\subset\mathfrak m$, $[\mathfrak m,\mathfrak m]\subset\mathfrak{so}(p)\oplus\mathfrak{so}(q)$. Let $K(u)=\tfrac12\sum_{\alpha,\beta}\langle[\varphi_\alpha,\varphi_\beta],u\rangle^2$, which is $(n-2)\lVert u\rVert^2$ on $\mathfrak{so}(n)$ by $\mathrm{id}^\#=(n-2)\mathrm{id}$, and split it by the blocks of $\alpha,\beta$.

- For $u\in\mathfrak{so}(p)$: the $\mathfrak{so}(p)\times\mathfrak{so}(p)$ part is $(p-2)\lVert u\rVert^2$ (the same identity in $\mathfrak{so}(p)$), so the $\mathfrak m\times\mathfrak m$ part is $(n-2)-(p-2)=q$.
- For $u\in\mathfrak{so}(q)$: the parts are $q-2$ and $p$.
- For $u\in\mathfrak m$: $\mathfrak{so}(p)$ acts on $\mathfrak m\cong V_1\otimes V_2$ through its standard representation on $V_1$, where $\sum_{a<b}\varphi_{ab}^2=-(p-1)$, so the mixed $\mathfrak{so}(p)\times\mathfrak m$ part (both orders) is $p-1$, the $\mathfrak{so}(q)\times\mathfrak m$ part is $q-1$, and they sum to $n-2$ as they must.

For $W=x\oplus y\oplus z$ each pair $(\alpha,\beta)$ is weighted by the product of its two eigenvalues, so

$$W^\#=\big((p-2)x^2+qz^2\big)\oplus\big((q-2)y^2+pz^2\big)\oplus\big((p-1)xz+(q-1)yz\big).$$

At $x=y=z=1$ every block reads $n-2$, which is the identity check the conventions require.

### 2.3 $W_{p,q}$ is an eigen-operator of $Q$

With $x=\frac q{p-1}$, $y=\frac p{q-1}$, $z=-1$:

- on $\mathfrak{so}(p)$: $x^2+(p-2)x^2+q=\frac{q^2}{p-1}+q=\frac{q(n-1)}{p-1}=(n-1)x$,
- on $\mathfrak{so}(q)$: $(n-1)y$ by symmetry,
- on $\mathfrak m$: $1-(q+p)=(n-1)z$.

Hence $Q(W_{p,q})=(n-1)W_{p,q}$ and $P(W_{p,q})=(n-1)\lVert W_{p,q}\rVert^2>0$. This agrees with [conventions.md](../findings/conventions.md) line 62, whose raw representative carries the factor $\frac{n-1}{pq}$ instead, the two differing by the scalar $pq$.

### 2.4 The unit value

$$\lVert W_{p,q}\rVert^2=\tbinom p2\frac{q^2}{(p-1)^2}+\tbinom q2\frac{p^2}{(q-1)^2}+pq=\frac{pq}{2(p-1)(q-1)}\big(q(q-1)+p(p-1)+2(p-1)(q-1)\big)=\frac{pq\,(n-1)(n-2)}{2(p-1)(q-1)},$$

using $q^2-q+p^2-p+2pq-2p-2q+2=n^2-3n+2$. For the unit operator $\hat W=W_{p,q}/\lVert W_{p,q}\rVert$, $P(\hat W)=(n-1)/\lVert W_{p,q}\rVert$, so

$$P(\hat W_{p,q})^2=\frac{2(n-1)}{n-2}\cdot\frac{(p-1)(q-1)}{pq}=\frac{2(n-1)}{n-2}\Big(1-\frac{n-1}{pq}\Big).$$

**Normalisation check (H1).** At $p=q=n/2$ this is $\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. At $p=\frac{n-1}2$, $q=\frac{n+1}2$ it is $\frac{2(n-1)(n-3)}{(n-2)(n+1)}=\Theta_n^2$. Both closed forms in the brief are reproduced exactly.

### 2.5 The best split

At fixed $n$ the value increases with $pq$. Over integers with $p+q=n$, $pq\le n^2/4$ at even $n$ with equality only at $p=q$, and $pq\le\frac{n^2-1}4$ at odd $n$ with equality only at $\{p,q\}=\{\frac{n-1}2,\frac{n+1}2\}$. The sign reversal $-\hat W$ gives $-P$. So the largest $P$ over all two-factor sphere products is $\theta_0(n)$ at even $n$ and $\Theta_n$ at odd $n$, which is the brief's definition of $\Theta_n$, now derived.

## 3. Where the step fails

The step, quoted from Passage C's detail entry ([results.md](../results.md) line 1065): *"forces $\max P\le\theta^*$, contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains"*, under the heading *"for every $n\ge12$"*.

**The failure.** At odd $n$ the balanced split $p=q=n/2$ has no integer solution, so the balanced sphere product does not exist. Every existing two-factor product has $pq\le\frac{n^2-1}4$, and by section 2.4

$$\theta_0(n)^2-\Theta_n^2=\frac{2(n-1)}{n-2}\cdot4(n-1)\Big(\frac{1}{n^2-1}-\frac{1}{n^2}\Big)=\frac{8(n-1)^2}{(n-2)\,n^2(n^2-1)}=\frac{8(n-1)}{n^2(n-2)(n+1)}>0.$$

Equivalently $(n-2)^2(n+1)-n^2(n-3)=4$, since both sides expand to $n^3-3n^2+4$ and $n^3-3n^2$. So no sphere product attains $\theta_0(n)$ at any odd $n$, in particular at any odd $n\ge13$.

**Concretely at $n=13$.** The two splits the brief names, $S^5\times S^8$ and $S^6\times S^7$, give $pq=40$ and $pq=42$. By section 2.4, $P^2=\frac{24}{11}\cdot\frac{28}{40}=\frac{168}{110}=\frac{84}{55}$ for $(5,8)$ and $P^2=\frac{24}{11}\cdot\frac{30}{42}=\frac{120}{77}$ for $(6,7)$. The best is $\Theta_{13}^2=\frac{120}{77}$, and $\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}$. Then $264\cdot77-120\cdot169=20328-20280=48$, so $\theta_0(13)^2-\Theta_{13}^2=\frac{48}{13013}$, matching $\frac{8\cdot12}{169\cdot11\cdot14}=\frac{96}{26026}$. The step's value is not attained at $n=13$.

**Arguing the opposite.** Three readings could rescue the words.

- *"Balanced" means the most balanced integer split.* Then the operator exists at odd $n$, but its value is $\Theta_n$, and the words "with $P=\theta_0(n)$" are false at every odd $n$ by the gap above.
- *Some sphere product with other radii reaches $\theta_0(n)$.* Section 2.1 shows the Weyl direction is independent of the radii, so there is no further parameter to tune.
- *The sentence only asserts $\theta_0(n)>\theta^*$.* That inequality is true at every $n\ge12$ (section 4), but the sentence says the sphere product attains it, and the contradiction consumes an attained value. A number that nothing attains contradicts nothing.

None of these makes the step true as written at odd $n$. It holds verbatim at every even $n\ge12$.

## 4. The repaired step is valid

Under H4 the step reads: at every $n\ge12$ the best two-factor sphere product is a unit Weyl operator with $P=\Theta_n>\theta^*$.

- **Existence and value.** Section 2 gives $\hat W_{p,q}\in\mathcal W_n$ of unit norm with $P=\Theta_n$, taking $p=q=n/2$ at even $n$ and $\{\frac{n-1}2,\frac{n+1}2\}$ at odd $n$. Both factors have dimension at least $6$ once $n\ge12$.
- **Even $n$.** $\theta_0(n)^2>\tfrac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, and $n^2-12n+8=n(n-12)+8\ge8>0$ at $n\ge12$.
- **Odd $n$.** $\Theta_n^2>\tfrac32\iff4(n-1)(n-3)>3(n-2)(n+1)\iff n^2-13n+18>0$, using $(n-2)(n+1)>0$. At odd $n\ge13$, $n^2-13n+18=n(n-13)+18\ge18>0$.
- **Consumption.** Lemma L20's proof needs a unit Weyl operator with $P>\theta^*$ against $\max P\le\theta^*$ (H3), and $\hat W_{p,q}$ supplies one at every $n\ge12$. This is the witness Passage A's proof body already names, and it matches `even_threshold`, `odd_threshold` and `thresholds_positive` in [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean) and `thirteen_witness` in [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean) as quoted in the brief.

The repair changes Passage C's detail entry and nothing downstream. The contradiction is with $\max P\le\theta^*$, and $\Theta_n>\theta^*$ serves it as well as $\theta_0(n)$ would.

## 5. Verdict

**FAILS.** As written the step asserts a sphere product with $P=\theta_0(n)$ at every $n\ge12$, and at every odd $n\ge13$ none exists: the best split attains $\Theta_n$, short of $\theta_0(n)$ by $\frac{8(n-1)}{n^2(n-2)(n+1)}$ in the square ($\frac{48}{13013}$ at $n=13$).

The defect is local to the wording of [results.md](../results.md) line 1065 (and the unqualified "sphere product's larger value" at line 321 should name $\Theta_n$ too). The corrected step, "the best two-factor sphere product attains $P=\Theta_n>\theta^*$ at every $n\ge12$", is VALID under H1–H4. H1 is the normalisation of section 0, H2 reads the witness as the unit Weyl part of a Riemannian product $S^p\times S^q$, H3 says L20 consumes only the attained value, and H4 replaces $\theta_0(n)$ by $\Theta_n$. Lemma L20's contradiction is therefore unaffected.
