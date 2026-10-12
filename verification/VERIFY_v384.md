# Verifier v384, the witness sphere product's location relative to the L20 tube (step G6)

Cold brief ([ADJ_L20r2_G6.md](ADJ_L20r2_G6.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L20-v384.log](../agent_logs/verify-L20-v384.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | "That it too lies outside the tube follows afterwards", read as a consequence of Passage A's conclusion (no maximizer within $0.5748$ of the orbit) | REFUTED AS STATED |
| 2 | Passage A's bootstrap re-run at the witness, with $\gamma_V\le m$, excludes the witness from the tube | REFUTED |
| 3 | The witness sphere product lies at geodesic angular distance greater than $0.5748$ from $SO(n).W_{\mathbb{CP}^2}$ for every $n\ge12$ | CONFIRMED, by an independent closed form |
| 4 | The contradiction in Passage A uses only the value $P>\sqrt{3/2}$ and presupposes nothing about where the sphere product sits | CONFIRMED |
| 5 | The witness is off the orbit ($\varphi>0$) | CONFIRMED |

**Summary: the location claim is true, with $\cos^2 d=\frac{2(2k-1)}{3k^2(k-1)}$ at $n=2k$ and $\frac{2(2k-1)}{3k(k+1)(k-1)}$ at $n=2k+1$, but it does not follow from Passage A, whose bootstrap closes only at a point whose value equals the maximum.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is realised as symmetric operators on $\Lambda^2\mathbb R^n$ with the trace (Frobenius) inner product, and $\{e_i\wedge e_j\}_{i<j}$ is orthonormal. Identifying $e_i\wedge e_j$ with $X_{ij}=E_{ij}-E_{ji}\in\mathfrak{so}(n)$ gives $[X_{ij},X_{jk}]=X_{ik}$ for distinct $i,j,k$ and $[X_{ij},X_{kl}]=0$ for disjoint index pairs.
- For operators diagonal in an orthonormal basis $\{\varphi_\alpha\}$ of $\mathfrak{so}(n)$, $A\#B=\tfrac12\sum_{\alpha,\beta}a_\alpha b_\beta\,[\varphi_\alpha,\varphi_\beta]\otimes[\varphi_\alpha,\varphi_\beta]$. This is the normalisation with $I\#I=(n-2)I$ (the diagonal entry at $X_{ik}$ counts the $2(n-2)$ ordered pairs whose bracket is $\pm X_{ik}$, halved).
- $W^\#=W\#W$, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$.
- $SO(n)$ acts on $\mathcal W_n$ by conjugation with $\Lambda^2 g$, an orthogonal action. $d$ is geodesic angular distance on the unit sphere, $\cos d(X,Y)=\langle X,Y\rangle$, and for a unit $X$ the distance to the orbit is $d(X,SO(n).u)=\arccos\max_{g}\langle X,g.u\rangle$.
- $u=W_{\mathbb{CP}^2}$ padded: on a 4-plane $E_0$ with a unit self-dual form $\omega$, $u=c\,(3\,\omega\otimes\omega-\Pi_{\Lambda^+E_0})$, extended by zero on $(\Lambda^2E_0)^\perp$. Unit norm forces $6c^2=1$, $c=1/\sqrt6$. On $\Lambda^+$ one has $[\omega_i,\omega_j]=\pm\sqrt2\,\omega_k$ (for example $[X_{12}+X_{34},X_{13}+X_{42}]=-2(X_{14}+X_{23})$), so $u^\#$ has eigenvalues $2w_jw_k$ on $\Lambda^+$ and $Q(u)$ has eigenvalues $(4c^2+2c^2,\,c^2-4c^2,\,c^2-4c^2)=3c\,(2c,-c,-c)$. Hence $Q(u)=3c\,u$ and $\theta^*=3c=\sqrt{3/2}$, matching the brief.
- $m=\sqrt{2/3}\max P$ over the unit sphere, and for the witness $\hat S$, $s:=\sqrt{2/3}\,P(\hat S)=\sqrt{2/3}\,\Theta_n$. At $n\ge12$ the brief's thresholds give $\Theta_n^2>3/2$, so $s>1$.

## Hypothesis inventory

- **Passage A's inputs, granted throughout**: $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$ (Lemma L21, with its recorded debt), $SO(n)$-invariance of $d$, compactness and embeddedness of the orbit with the first-variation condition, and Passage A's conclusion $d(W^*,\mathcal O)>0.5748$ for every maximizer $W^*$.
- **H1**: the witness $\hat S$ is a maximizer of $P$, that is $s=m$. This makes reading (i) immediate. Nothing in the passages establishes it.
- **H2**: $m<M(s):=\min_{0<\varphi\le0.5748}\dfrac{s-\cos\varphi}{\sin^3\varphi}$. This is the exact condition under which the re-run of reading (ii) closes. H1 implies H2 (Section 3.3). Nothing in the passages bounds $m$ above.
- **For Section 4 only**: the witness is the unit Weyl tensor of the product of round spheres $S^p\times S^q$, $p+q=n$, with $p=q=k$ at $n=2k$ and $(p,q)=(k,k+1)$ at $n=2k+1$, of the sign with $P>0$. Section 4.2 checks that this object has exactly the brief's $\Theta_n$ at both parities, which pins the identification. The argument needs $p,q\ge2$. None of Passage A's inputs is used, in particular not $\alpha\le\tfrac13$.

## 1. What the step asserts

The step is a conjunction: (a) $d(\hat S,\mathcal O)>0.5748$ for every $n\ge12$, and (b) (a) follows from Passage A's conclusion. The words "follows afterwards" at [route-a.md](../findings/route-a.md) line 135, [problem.md](../findings/problem.md) line 552 and [90-appendix.tex](../report/sections/90-appendix.tex) line 313 support two readings of (b):

- (i) as a logical consequence of the proved statement "no maximizer lies in the tube",
- (ii) as the same bootstrap argument applied afterwards to $\hat S$ in place of $W^*$.

Both are examined, then (a) is settled on its own.

## 2. Reading (i): a consequence of the conclusion

Passage A's conclusion is a statement about the set $\mathcal M$ of maximizers: $\mathcal M$ is disjoint from the closed tube $\{d\le0.5748\}$. The witness is one unit Weyl tensor with $P(\hat S)=\Theta_n>\theta^*$. The implication "$\mathcal M\cap\text{tube}=\emptyset\Rightarrow\hat S\notin\text{tube}$" holds when $\hat S\in\mathcal M$ (H1), and the passages give no other route from a property of $\mathcal M$ to a property of $\hat S$.

**Arguing the opposite.** Passage A stresses that the contradiction is with the value. One might read this as: the tube carries no point of value above $\theta^*$, so any such point, the witness included, lies outside. That is the statement $\sup_{\text{tube}}P\le\theta^*$. Passage A does not prove it. What it proves is $m\le\psi(\varphi)\le1$ **under the assumption that the point in the tube is a maximizer**, because the bound $\gamma_V\le m$ is a bound by the left-hand side itself (Section 3). So the value-only character of the contradiction concerns what the witness is used for (supplying $\max P>\theta^*$), and gives no information about where the witness sits. Claim 4 is correct and claim 1 does not follow from it.

## 3. Reading (ii): the bootstrap re-run at the witness

### 3.1 What transfers

Every step of Passage A up to the substitution concerns position, not value. For $\hat S$ with $\varphi=d(\hat S,\mathcal O)\in(0,0.5748]$, rotate the nearest point to $u$, write $\hat S=\cos\varphi\,u+\sin\varphi\,V$, and the same first-variation condition, the same vanishing linear term and $\alpha\le\tfrac13$ give

$$s=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V\le\cos\varphi+\sin^3\varphi\,\gamma_V.$$

The branch $\varphi=0$ does close: there $\hat S\in\mathcal O$, so $P(\hat S)=\theta^*$, contradicting $\Theta_n>\theta^*$. This is claim 5.

### 3.2 Where it fails

The line is Passage A's "And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them. Substituting both ... $m\le\cos\varphi+m\sin^3\varphi$, i.e. $m\le\psi(\varphi)$." At the maximizer the left side is $m$, so $m(1-\sin^3\varphi)\le\cos\varphi$ can be solved for $m$. At the witness the substitution gives

$$s\le\cos\varphi+m\sin^3\varphi,\qquad m\ge s,$$

and the unknown $m$ on the right is no longer the quantity on the left. No bound on $s$ results.

**Concrete exhibit.** Take $\varphi=\pi/6$, which lies in the tube because $\pi<22/7<3.4488$. Then $\sin\varphi=\tfrac12$, $\cos\varphi=\tfrac{\sqrt3}2$, and with $\alpha=\tfrac13$ the expansion reads $s=\tfrac{3\sqrt3}8+\tfrac{\sqrt3}8+\tfrac{\gamma_V}8=\tfrac{\sqrt3}2+\tfrac{\gamma_V}8$. Set $\gamma_V=m=8s-4\sqrt3$. Every relation the argument uses holds: $\alpha\le\tfrac13$, $\gamma_V\le m$, and $m\ge s$ because $7s\ge4\sqrt3$ follows from $s>1>4\sqrt3/7$ (the last is $48<49$). The maximizer's own relation is also undisturbed, because $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)\to\infty$ as $\varphi\to\pi/2^-$ (with $t=\sin\varphi\in[0,1)$, $1-t^3=(1-t)(1+t+t^2)\le3(1-t)$ and $\cos\varphi=\sqrt{(1-t)(1+t)}$, so $\psi\ge\tfrac13\sqrt{(1+t)/(1-t)}$), so some $\varphi^*>0.5748$ has $\psi(\varphi^*)\ge m$. The relations Passage A supplies are therefore jointly consistent with the witness inside the tube. Excluding it needs an input about the actual Weyl geometry beyond those relations.

### 3.3 The hypothesis that closes it

The re-run closes exactly when $s>\cos\varphi+m\sin^3\varphi$ for all $\varphi\in(0,0.5748]$, that is H2. The minimum in $M(s)$ exists because $(s-\cos\varphi)/\sin^3\varphi$ is continuous on $(0,0.5748]$ and tends to $+\infty$ as $\varphi\to0^+$ (the numerator tends to $s-1>0$). H1 implies H2: with $m=s$ the condition $s\sin^3\varphi<s-\cos\varphi$ is $\psi(\varphi)<s$, which holds because Passage A's exact reduction gives $\psi\le1$ on $[0,0.5748]$ and $s>1$. So reading (ii) is valid under H2, and in particular under H1, and neither is on the record.

## 4. Claim (a) settled directly, in closed form

### 4.1 The witness operator

Let $\mathbb R^n=A\oplus B$ with $\dim A=p$, $\dim B=q$, and split $\Lambda^2\mathbb R^n=\Lambda^2A\oplus\Lambda^2B\oplus M$ with $M=A\wedge B$, of dimensions $\tfrac{p(p-1)}2$, $\tfrac{q(q-1)}2$, $pq$. For $v=v_A+v_B$, $v\wedge w=v_A\wedge w_A+(v_A\wedge w_B+v_B\wedge w_A)+v_B\wedge w_B$ is the orthogonal decomposition, so $\Pi_{\Lambda^2A}(v\wedge w)=v_A\wedge w_A$. The operators $\Pi_{\Lambda^2A}$, $\Pi_{\Lambda^2B}$ and $I$ are the curvature operators of $S^p$, $S^q$ and $S^n$, so every $W=x\Pi_{\Lambda^2A}+y\Pi_{\Lambda^2B}+z\Pi_M$ satisfies the Bianchi identity. Its Ricci contraction at $e\in A$ is $(p-1)x+qz$ and at $e\in B$ is $(q-1)y+pz$, off-diagonal terms vanishing by $O(p)\times O(q)$ symmetry. Tracelessness with $z=-1$ gives

$$W_{p,q}=\frac{q}{p-1}\,\Pi_{\Lambda^2A}+\frac{p}{q-1}\,\Pi_{\Lambda^2B}-\Pi_M,\qquad x=\tfrac q{p-1},\ y=\tfrac p{q-1},\ z=-1.$$

### 4.2 Norm and value, and the match with $\Theta_n$

$|W_{p,q}|^2=x^2\tfrac{p(p-1)}2+y^2\tfrac{q(q-1)}2+pq=\tfrac{pq}2\,(x+y+2)$.

$\operatorname{tr}W^3=x^3\tfrac{p(p-1)}2+y^3\tfrac{q(q-1)}2-pq$. For $\operatorname{tr}(W\,W^\#)=\tfrac12\sum_{\alpha,\beta}w_\alpha w_\beta w_{[\alpha,\beta]}$ over ordered basis pairs sharing one index (signs square out), the brackets satisfy $[\Lambda^2A,\Lambda^2A]\subset\Lambda^2A$, $[\Lambda^2A,M]\subset M$, $[M,M]\subset\Lambda^2A\oplus\Lambda^2B$, $[\Lambda^2A,\Lambda^2B]=0$, and the ordered pairs count as follows: type $(A,A\to A)$, $p(p-1)(p-2)$ pairs, weight $x^3$; types $(A,M\to M)$ and $(M,A\to M)$, $2p(p-1)q$ pairs, weight $xz^2$; type $(M,M\to A)$, pairs $(X_{ib},X_{jb})$, $p(p-1)q$ pairs, weight $z^2x$; and the same with $A,B$ exchanged. So

$$\operatorname{tr}(W\,W^\#)=\tfrac12\big[p(p-1)(p-2)x^3+q(q-1)(q-2)y^3+3p(p-1)q\,xz^2+3q(q-1)p\,yz^2\big].$$

At $x=y=z=1$ this is $\tfrac12\cdot3pq(n-2)+\tfrac12[p(p-1)(p-2)+q(q-1)(q-2)]$, which equals $\operatorname{tr}(I\#I)=(n-2)\tfrac{n(n-1)}2$ (checked at $(p,q)=(2,2)$: $12=12$). With the values of 4.1, $(p-1)x=q$ and $(q-1)y=p$ give

$$P(W_{p,q})=\tfrac12\Big[\frac{pq^3}{p-1}+\frac{qp^3}{q-1}\Big]+pq\Big(\frac{3n}2-1\Big)>0,$$

so this sign is the one with positive value.

- $n=2k$, $p=q=k$: $|W|^2=\tfrac{k^2(2k-1)}{k-1}$, $P(W)=\tfrac{k^2(2k-1)^2}{k-1}$, so $P(\hat S)^2=\tfrac{P^2}{|W|^6}=\tfrac{(2k-1)(k-1)}{k^2}=\theta_0(2k)^2$.
- $n=2k+1$, $(p,q)=(k,k+1)$: $|W|^2=\tfrac{k(k+1)(2k-1)}{k-1}$, $P(W)=\tfrac{2k^2(k+1)(2k-1)}{k-1}$, so $P(\hat S)^2=\tfrac{4k(k-1)}{(k+1)(2k-1)}=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$.

Both agree with the brief's $\Theta_n$, which fixes the identification of the witness and confirms the conventions of Section 0.

### 4.3 Compression to an orbit point's plane

An orbit point $g.u$ is supported on $\Lambda^2E$ for the 4-plane $E=g(E_0)$, so $\langle W,g.u\rangle=\operatorname{tr}\big((\Pi_{\Lambda^2E}W\Pi_{\Lambda^2E})\,g.u\big)$. Let $h=\pi_E\pi_A|_E$, symmetric with eigenvalues $\lambda_i\in[0,1]$. By 4.1, $\langle\Pi_{\Lambda^2A}(v\wedge w),v'\wedge w'\rangle=\langle hv\wedge hw,v'\wedge w'\rangle$ for $v,w,v',w'\in E$, so $\Pi_{\Lambda^2A}$ compresses to $\Lambda^2h$, $\Pi_{\Lambda^2B}$ to $\Lambda^2(I-h)=I-D_h+\Lambda^2h$ with $D_h(v\wedge w)=hv\wedge w+v\wedge hw$, and $\Pi_M$ to $I-\Lambda^2h-\Lambda^2(I-h)$. For a Weyl operator $w$ on $E$, $\operatorname{tr}(Iw)=0$ and, in the eigenframe of $h$, $\operatorname{tr}(D_hw)=\sum_{i<j}(\lambda_i+\lambda_j)w_{ij,ij}=\sum_i\lambda_i\operatorname{Ric}(w)_{ii}=0$. Writing $T=\operatorname{tr}(\Lambda^2h\cdot g.u)$,

$$\langle W_{p,q},g.u\rangle=(x+y-2z)\,T=(x+y+2)\,T.$$

### 4.4 Maximising over the orbit

For $n\ge5$ every orthonormal frame of every 4-plane is the image of the standard frame under some $g\in SO(n)$, so the orbit points on $E$ are exactly $c\,(3\omega\otimes\omega-\Pi_{\Lambda^\pm E})$ for unit $\omega\in\Lambda^\pm E$. In the eigenframe $(f_i)$ of $h$ write $\omega=a\tfrac{f_{12}\pm f_{34}}{\sqrt2}+b\tfrac{f_{13}\mp f_{24}}{\sqrt2}+c'\tfrac{f_{14}\pm f_{23}}{\sqrt2}$ with $a^2+b^2+c'^2=1$. Since $\Lambda^2h$ is diagonal there with entries $\lambda_i\lambda_j$, and $\langle\Pi_{\Lambda^\pm}f_{ij},f_{ij}\rangle=\tfrac12$,

$$T=c\Big[\tfrac32\big(a^2\sigma_1+b^2\sigma_2+c'^2\sigma_3\big)-\tfrac12(\sigma_1+\sigma_2+\sigma_3)\Big],\quad\sigma_1=\lambda_1\lambda_2+\lambda_3\lambda_4,\ \sigma_2=\lambda_1\lambda_3+\lambda_2\lambda_4,\ \sigma_3=\lambda_1\lambda_4+\lambda_2\lambda_3.$$

Maximising over $\omega$ gives $c\max_i(\sigma_i-\tfrac12\sigma_j-\tfrac12\sigma_k)$. For $i=1$, with $S=\lambda_1+\lambda_2$ and $R=\lambda_3+\lambda_4$ in $[0,2]$, $\sigma_1-\tfrac12(\sigma_2+\sigma_3)=\lambda_1\lambda_2+\lambda_3\lambda_4-\tfrac12SR\le\tfrac{S^2}4+\tfrac{R^2}4-\tfrac{SR}2=\tfrac{(S-R)^2}4\le1$, and the other $i$ are the same after relabelling. Equality holds at $\lambda=(1,1,0,0)$, $\omega\propto f_{12}+f_{34}$, which is realised when $p,q\ge2$ by $E=\operatorname{span}(a_1,a_2,b_1,b_2)$. Since $x+y+2>0$,

$$\cos d(\hat S,\mathcal O)=\frac{c\,(x+y+2)}{|W_{p,q}|}=\frac{x+y+2}{\sqrt6\,\sqrt{\tfrac{pq}2(x+y+2)}}=\sqrt{\frac{x+y+2}{3pq}}.$$

At both parities $x+y+2=\tfrac{2(2k-1)}{k-1}$, so

$$\cos^2 d=\frac{2(2k-1)}{3k^2(k-1)}\ \ (n=2k),\qquad\cos^2 d=\frac{2(2k-1)}{3k(k+1)(k-1)}\ \ (n=2k+1).$$

At $n=12$ this is $\tfrac{11}{270}$ and at $n=13$ it is $\tfrac{11}{315}$.

### 4.5 Comparison with the radius

$\cos x\ge1-\tfrac{x^2}2$ for all real $x$ and $0.5748^2<1$, so $\cos(0.5748)>\tfrac12$. Both $d$ and $0.5748$ lie in $[0,\pi/2]$ (the former because $\cos d>0$, the latter because $\pi>3$), where $\cos$ is decreasing, so $\cos^2d<\tfrac14$ implies $d>0.5748$.

- Even, $n=2k$: $\cos^2d<\tfrac14$ is $3k^2(k-1)>8(2k-1)$. For $k\ge3$, $k(k-1)\ge6$ gives $3k^2(k-1)\ge18k>16k-8$.
- Odd, $n=2k+1$: $3k(k+1)(k-1)>8(2k-1)$. For $k\ge3$, $(k+1)(k-1)\ge8$ gives $3k(k^2-1)\ge24k>16k-8$.

At $n\ge12$, $k\ge6$, so $d(\hat S,\mathcal O)>0.5748$ at every $n\ge12$, and in fact $\cos d=O(1/k)$, so the witness approaches orthogonality to the whole orbit. This uses neither Lemma L21 nor Passage A, so it carries none of L21's recorded debt.

## 5. Verdict

**FAILS.** The inference as written does not hold: Passage A's conclusion concerns maximizers, and its bootstrap $\gamma_V\le m$ closes only when the point in the tube has value $m$ (Section 3.2, with the consistent assignment $\varphi=\pi/6$, $\alpha=\tfrac13$, $\gamma_V=m=8s-4\sqrt3$). A VALID reading of "follows from Passage A" needs H1 (the witness is a maximizer) or the weaker H2 ($m<\min_{0<\varphi\le0.5748}(s-\cos\varphi)/\sin^3\varphi$), and neither is on the record.

The location claim itself is true, unconditionally: $\cos^2d=\tfrac{2(2k-1)}{3k^2(k-1)}$ at $n=2k$ and $\tfrac{2(2k-1)}{3k(k+1)(k-1)}$ at $n=2k+1$, both below $\tfrac14<\cos^2(0.5748)$ for $k\ge3$. The repair is to replace "follows afterwards" by this computation, or to drop the clause, since Passage A's contradiction never uses the witness's location.
