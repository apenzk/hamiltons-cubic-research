# Review r192, the shared word list realises the G-map, and the check that says so cannot fail

Gate 2, adversarial. Everything below was re-derived from definitions and re-measured with scripts written for this review, under [scripts/reviewers/r192/](../scripts/reviewers/r192/). Exact arithmetic over $\mathbb Q(i)$ throughout; the only floating-point number in the review is a wall-clock time.

## Verdict table

| Claim | Verdict | What decided it |
| --- | --- | --- |
| 4, the shared word list makes the copies comparable | **Upheld, and now proved rather than sampled** | $X_w u_i=\varphi_i(X_w v_\lambda)$ by equivariance, so the replay *is* $\varphi_j\varphi_i^{-1}$. Measured by the Kronecker test $\langle R_i[s],R_j[t]\rangle=h_{ij}Q[s,t]$: $0$ failures of $784$ on $\lambda=(2,0)$ and $0$ of $3136$ on $\lambda=(2,2)$ |
| 4a ("each replayed copy must still be independent), a shared word list that degenerates on copy 2 would show up here and nowhere else" | **A check that could not fail, and it does not detect what its comment claims** | $\varphi_i$ is injective, so it carries copy 1's basis to a basis. Rank $=\dim$ on $75$ random multiplicity-space vectors across three blocks. The negative control (a per-copy word list, the very thing the script was written to eliminate), **passes the spanning check** and breaks the G-map identification at $19$ of $196$ and $25$ of $196$ entries |
| 4b, [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) step 4: "$M_\lambda$ the Gram of copy 1's word basis, common to every copy of the block, which is exactly what the shared word list buys" | **The formula is defensible; the stated reason is false** | Copy $i$'s ambient Gram is $h_{ii}M_\lambda$ and the $(i,j)$ block is $h_{ij}M_\lambda$, with $h$ the multiplicity Gram, computed exactly here and neither the identity nor even diagonal |
| 5, $45$ nonzero entries of $1225$, none across distinct weights, diagonal in $\{12,24,36,48,64,96\}$ | **Confirmed independently, and it is a check that could have failed** | Rebuilt in exact integer arithmetic with the weight filter *removed*: $45$, all within a weight, diagonal multiset $\{12^1,24^8,36^1,48^1,64^{20},96^4\}$. The cap if every weight block were dense is $57$, so $45$ carries information |
| 1 (bonus), the $\mathrm{Sym}^3$ metric convention | **The discriminating test the brief asks for exists, and the shipped convention passes it** | Invariance $\langle Xu,v\rangle+\langle u,Xv\rangle=0$ for the ten real generators: plain permanent $0$ violations of $270$ live tests; every multinomial-weighted variant fails, $44$–$49$ of $270$ |
| 2 (bonus), the coordinate solve | **Correct as written** | $\mathrm{rhs}[b]=\langle W,f_b\rangle$ with the conjugate on the basis, and the assembled matrix is $H^{\mathsf T}$, which is what $\sum_a w_aH_{ab}=\mathrm{rhs}[b]$ requires |
| 3 (bonus), the cube map | **Consistent with 1 and with raise_mono** | Both are the polynomial-monomial convention; the multinomial in `cube` is the expansion of $(\sum_aw_af_a)^3$, and `raise_mono` is a derivation on the same monomials |

---

## Claim 4, what the shared word list actually buys

### The identification is forced, and spanning has nothing to do with it

Let $\mathfrak g=\mathfrak{so}(5,\mathbb C)$, let $V=\mathrm{Sym}^3(\mathcal W_5)$, and fix a block $\lambda$ with multiplicity $m$. [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) produces $u_1,\dots,u_m$ as a nullspace basis of the two raising operators on the $\lambda$-weight space, so each $u_i$ is a genuine highest-weight vector of weight $\lambda$.

Three standard facts settle the claim.

1. $C_i:=U(\mathfrak n^-)u_i$ is a finite-dimensional highest-weight module of weight $\lambda$, hence irreducible, hence $\cong V(\lambda)$. So there is a unique $\mathfrak g$-map $\varphi_i:V(\lambda)\to V$ with $\varphi_i(v_\lambda)=u_i$, and it is **injective** with image $C_i$.
2. A word $w=(o_1,\dots,o_k)$ names a fixed element $X_w=f_{o_k}\cdots f_{o_1}\in U(\mathfrak n^-)$. [replay](../scripts/runs/run_n5_adapted.py) computes $X_wu_i$, and equivariance gives
$$X_w u_i \;=\; X_w\varphi_i(v_\lambda)\;=\;\varphi_i(X_wv_\lambda)\;=\;\varphi_i(b_w),\qquad b_w:=X_wv_\lambda\in V(\lambda).$$
3. Copy 1's list having $\dim V(\lambda)$ independent entries means $\{b_{w_t}\}_t$ is a **basis of $V(\lambda)$**, because $\varphi_1$ is injective.

So the map $R_i[t]\mapsto R_j[t]$ sends $\varphi_i(b_{w_t})\mapsto\varphi_j(b_{w_t})$ on a basis: it **is** $\varphi_j\varphi_i^{-1}$, the unique $\mathfrak g$-map carrying $u_i$ to $u_j$. Reviewer 182's identification is exactly what the replay realises, and the reason is the equivariance of $\varphi_i$, not any property of the list beyond its being one list.

### The test with teeth

Schur's lemma makes the space of invariant sesquilinear pairings $V(\lambda)\times V(\lambda)\to\mathbb C$ one-dimensional, so if the identification is the $\mathfrak g$-map the full Gram of the adapted basis must factor as a Kronecker product
$$\langle R_i[s],R_j[t]\rangle \;=\; h_{ij}\,Q[s,t],\qquad h_{ij}=\frac{\langle u_i,u_j\rangle}{\langle u_1,u_1\rangle},\quad Q[s,t]=\langle R_1[s],R_1[t]\rangle .$$
A different $\mathfrak g$-map on copy $j$ permutes and mixes the $t$ index, which one scalar per copy pair cannot absorb. [claim4_gmap.py](../scripts/reviewers/r192/claim4_gmap.py) evaluates both sides exactly:

| block | copies | words probed | failures |
| --- | --- | --- | --- |
| $\lambda=(2,0)$, $\dim 14$ | $2$ | all $14$ | $0$ of $784$ |
| $\lambda=(2,2)$, $\dim 35$ | $4$ | first $14$ | $0$ of $3136$ |

### The negative control, and why the shipped check is empty

The failure mode [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) was written against is a word list chosen *per copy*. Give copy 2 its own BFS (the same routine with the two lowering operators tried in the other order) and:

- its replayed list has rank $14$ of $14$ (resp. $35$ of $35$): **the shipped spanning check passes**;
- the Kronecker identity fails at $19$ of $196$ entries on $(2,0)$ and $25$ of $196$ on $(2,2)$.

So the shipped check is blind to precisely the corruption its comment names. And it is blind because it cannot fail at all: $\varphi_i$ injective carries the basis $\{b_{w_t}\}$ to an independent set of the same size, for **every** $u$ in the multiplicity space. [claim4_vacuity.py](../scripts/reviewers/r192/claim4_vacuity.py) replays copy 1's list on $25$ random multiplicity-space vectors in each of $\lambda=(2,0),(2,2),(3,2)$ and the rank is $14$, $35$, $105$ every time, $75$ vectors, no variation.

The check that *can* fail is the one immediately above it, `len(words) != want`: if copy 1's BFS exhausts before reaching $\dim V(\lambda)$ there is no basis and nothing downstream is defined. That guard is real; the loop after it is decoration.

**Recommended replacement.** Keep `len(words) == want` and drop the per-copy rank loop in favour of the Kronecker identity on a probe window of words, it is the property the certificate consumes, and it separates a shared list from a per-copy one.

### 4b, the multiplicity Gram is not the identity

[claim4_gmap.py](../scripts/reviewers/r192/claim4_gmap.py) computes $h$ exactly. On $\lambda=(2,0)$,
$$h=\begin{pmatrix}1 & \tfrac{55}{37}i\\[2pt] -\tfrac{55}{37}i & \tfrac{5075}{1628}\end{pmatrix},$$
and on $\lambda=(2,2)$ the $4\times4$ matrix has entries such as $h_{12}=-\tfrac{16}{111}$, $h_{13}=-\tfrac{25}{74}i$, $h_{44}=\tfrac{40}{37}$. So the ambient Gram of the adapted basis is $h\otimes M_\lambda$, and the sentence "$M_\lambda$ … common to every copy of the block" is false for every block of multiplicity $\ge2$ that was checked.

The formula it justifies can still be right, under the reading that survives: expand $W^3$'s $\lambda$-component as $\sum_i\varphi_i(y_i)$ with $y_i\in V(\lambda)$, and take $B_{ij}=Q(y_i,y_j)$. That is invariant, because $y_i\mapsto gy_i$ under $W\mapsto gW$, and it needs $Q$ once, not once per copy, the shared word list is what makes the coordinates $c^{\lambda,i}$ of the $y_i$ refer to one basis of $V(\lambda)$. **What the shared word list buys is a common $b_t$, not a common Gram**, and the two readings are not interchangeable: replacing $B_{ij}$ by $h_{ij}B_{ij}$ reparametrises the SDP by a Hadamard product with $h$, which maps PSD into PSD but whose inverse does not, so the feasible set moves. The docstring should say which object $c^{\lambda,i}$ denotes before stage 2 is coded against it.

### A by-product: the copies are in direct sum

[plan.md](../plan.md) lists "$\sum m_\lambda d_\lambda=7770$, equal dimensions do not give a **direct** sum; two copies could coincide" among the checks that could not fail. The gap closes with the same argument. The map $(x_1,\dots,x_m)\mapsto\sum_i\varphi_i(x_i)$ has kernel the linear relations among the $\varphi_i$ in $\mathrm{Hom}_{\mathfrak g}(V(\lambda),V)$; evaluation at $v_\lambda$ identifies that $\mathrm{Hom}$ with the highest-weight space, sending $\varphi_i\mapsto u_i$; the $u_i$ are a nullspace basis, hence independent. So the copies meet only in $0$, unconditionally and for every block. [claim4_directsum.py](../scripts/reviewers/r192/claim4_directsum.py) confirms rank $28$, $140$ and $315$ for the three blocks tested.

## Claim 5, the Hermitian Gram

[claim5_gram.py](../scripts/reviewers/r192/claim5_gram.py) rebuilds $H_{ab}=\sum_{ijkl}(T_a)_{ijkl}\overline{(T_b)_{ijkl}}$ from the cached weight-basis tensors in **exact integer arithmetic** (every entry has denominator $2$, so clearing it once makes the whole computation integral) and, unlike [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py), it drops the `if WT[a] != WT[b]: continue` guard so that block-diagonality is a measurement rather than an assumption.

- **$45$ nonzero entries of $1225$.** Confirmed.
- **None across distinct weights.** Confirmed with the filter removed: $0$ such entries.
- **Diagonal in $\{12,24,36,48,64,96\}$.** Confirmed, with multiplicities $12^1,24^8,36^1,48^1,64^{20},96^4$ and imaginary part zero throughout.

Two additions the record does not carry. The $35$ off-diagonal budget is $45-35=10$ entries, in five conjugate pairs: $H_{6,7}=32i$, $H_{10,11}=-32i$, $H_{17,18}=12$, $H_{23,24}=32i$, $H_{27,28}=-32i$. And **$45$ is not forced**: the weight multiplicities are $16$ singletons, $8$ doubles and one triple, so a dense-on-each-block $H$ would have $16+8\cdot4+9=57$ nonzero entries. The gap of $12$ is real structure, in particular the weight-$(0,0)$ triple is not dense, one of its three vectors being orthogonal to the other two.

$H$ is Hermitian and positive definite on every weight block (exact leading-principal-minor test, all minors positive rationals), which is what makes [coords](../scripts/runs/run_n5_evaluate.py)'s pivot search total.

## Claim 1, a test that does discriminate the conventions

Reviewers 189 and 190 established that a weight check cannot separate the plain permanent from a multiplicity-weighted metric, the weighting being diagonal inside each weight space. **Invariance separates them, and the reason is structural.** If $A$ is $\mathfrak g$-invariant and $B(x_t,x_s)=c_t\overline{c_s}A(x_t,x_s)$, then $B$ is invariant exactly when the diagonal map $D:x_t\mapsto c_tx_t$ is a module map. A raising operator carries $x_{aab}$ to $x_{abt}$ (monomials of different multiplicity pattern) so a $c$ depending on the pattern makes $D$ non-equivariant, and at most one of the candidate conventions can be invariant.

[claim1_invariance.py](../scripts/reviewers/r192/claim1_invariance.py) tests $\langle Xu,v\rangle+\langle u,Xv\rangle=0$ for the ten real generators $\rho(A_{pq})$, over $\mathbb Q(i)$, on a **live** test set: $v$ is drawn from the support of $Xu$, so $259$ of $270$ triples have a nonzero term to cancel. A control first confirms the $35$-dimensional $H$ itself is invariant ($0$ violations of $12250$), without which the test would be void.

| convention | violations of $270$ |
| --- | --- |
| plain permanent, as `sym3_ip` ships | **$0$** |
| $\times\,\mathrm{multinom}(t)\,\mathrm{multinom}(s)$ | $49$ |
| $\div\,\mathrm{multinom}(t)\,\mathrm{multinom}(s)$ | $49$ |
| $\times\,\mathrm{multinom}(t)$ | $44$ |
| $\times\,36/(\mathrm{multinom}(t)\mathrm{multinom}(s))$ | $49$ |

**One caveat on what this pins.** $\mathrm{Sym}^3$ is not irreducible, so invariance alone leaves a Hermitian form $h^\lambda$ on each multiplicity space free, the invariant forms are $\bigoplus_\lambda h^\lambda\otimes Q_\lambda$. The route survives that freedom: stage 2 reads $M_\lambda$ off a **single** copy, so only the positive scalar $h^\lambda_{11}$ enters, and rescaling $M_\lambda$ by $s_\lambda>0$ is absorbed by $G^\lambda\mapsto G^\lambda/s_\lambda$ without moving the PSD cone. The Kronecker test of claim 4 passing exactly is independent evidence that `sym3_ip` is invariant, since the factorisation is a consequence of invariance.

## Claims 2 and 3, read, and correct

**Claim 2.** [coords](../scripts/runs/run_n5_evaluate.py) forms $\mathrm{rhs}[b]=\sum_{ijkl}W_{ijkl}\,\overline{(T_b)_{ijkl}}$, which is $\langle W,f_b\rangle$ in the same convention that defines $H_{ab}=\langle f_a,f_b\rangle$, the conjugate is on the basis side, where sesquilinearity in the second slot puts it. With $W=\sum_aw_af_a$ the equation is $\sum_aw_aH_{ab}=\mathrm{rhs}[b]$, and the assembled matrix is `A[b][a] = H[a,b]`, that is $H^{\mathsf T}$. Both halves of the brief's question resolve the same way the code has them. The pivot search is total because $H$ is positive definite on each weight block.

**Claim 3.** `cube` applies $3!/\prod m!$ to $w_{t_1}w_{t_2}w_{t_3}$, which is the expansion of $\big(\sum_aw_af_a\big)^3$ in the polynomial-monomial basis, the same basis `raise_mono` differentiates as a derivation, and the same basis `sym3_ip` is invariant on by the table above. The three agree.

## Scripts

- [core192.py](../scripts/reviewers/r192/core192.py), the lowering action on $\mathrm{Sym}^3$, leading-term reduction, the BFS word list, the replay
- [extract_low.py](../scripts/reviewers/r192/extract_low.py), [extract_gens.py](../scripts/reviewers/r192/extract_gens.py), one-off dumps of the lowering operators and the ten generators in the weight basis, so nothing else pays [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py)'s $98$ s
- [claim4_gmap.py](../scripts/reviewers/r192/claim4_gmap.py), the Kronecker test, the multiplicity Gram, and the per-copy-list negative control
- [claim4_vacuity.py](../scripts/reviewers/r192/claim4_vacuity.py), the spanning check on random multiplicity-space vectors
- [claim4_directsum.py](../scripts/reviewers/r192/claim4_directsum.py), the copies meet only in $0$
- [claim5_gram.py](../scripts/reviewers/r192/claim5_gram.py), $H$ in exact integers, with the weight filter removed
- [claim1_invariance.py](../scripts/reviewers/r192/claim1_invariance.py), the convention discriminator
