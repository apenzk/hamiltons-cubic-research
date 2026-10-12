# Gate 2, r834 on Lemma L195, the all-simple coincident stratum: every step is sound, and the constraint the proof drops is fatal to its headline

*The brief was cold: [findings/diagonal-half.md](../findings/diagonal-half.md)'s L195 block was read from disk as quoted, and every derivation below was re-run from the givens rather than checked against the block's wording. **No numerical work was done and no screen was run.** Every value here is exact rational arithmetic done by hand, and the one place a screen was contemplated (the $r=7$ weights) turned out to be a seven-term sum of fractions. Log: [agent_logs/g2-coincident-r834.log](../agent_logs/g2-coincident-r834.log).*

## Claim table

| # | Claim under attack | Verdict |
|---|---|---|
| 1 | Cross term $2\sigma_{ij}\sigma_{ik}c_jc_k$ in $\Lambda^2E_j\otimes\Lambda^2E_k$; $\varepsilon_j\wedge\varepsilon_j$ vanishes; $\Lambda^4E_j$ imposes nothing | **CONFIRMED** |
| 2 | $\langle\omega_i,\omega_{i'}\rangle=\sum_jt_j\sigma_{ij}\sigma_{i'j}$; $\sum_jt_j=1$ is $\operatorname{tr}A=2$; $\langle J_j,J_j\rangle=m_j$ | **CONFIRMED** |
| 3 | The three orthogonality relations force $T_{++}=T_{+-}=T_{-+}=T_{--}=\tfrac14$, uniquely, all classes nonempty | **CONFIRMED** |
| 4 | $r=3,4,5,6$ excluded by "at most one singleton"; $r=7$ admits $2+2+2+1$ | **CONFIRMED**, criterion necessary and not sufficient |
| 5 | Weights exist at $r=7$ with all seven $c_j^2$ distinct | **CONFIRMED**, exhibited in closed form |
| 6 | One simple eigenvalue suffices for the reduction to signs | **CONFIRMED AND UNDERSTATED**, since it yields $\omega_i=\pm\omega_1$ outright |
| 6b | $c_j^2m_j=c_k^2m_k$ achievable with $c_j^2\ne c_k^2$, so two singleton classes are consistent | **CONFIRMED but MOOT** |
| 7 | The frontier is exactly "every eigenvalue of $A$ of multiplicity at least four" | **REFUTED**, the frontier being $A=c\,\mathrm{Id}_V$ |
| 8 | No Weyl input; $V$ is the support; orthonormality | **CONFIRMED**, orthonormality over-spent |
| 9 | Falsifier: an all-simple coincident triple at $\dim V\in\{8,10,12\}$ | **NONE EXISTS**, and none exists at any $\dim V$ |
| **A** | **Statement, clause 1: no such triple at $r\in\{3,4,5,6\}$** | **TRUE, and strictly weaker than [L184](../findings/diagonal-half.md#L1012)'s case 1 already on file** |
| **B** | **Statement, clause 2 and the title: "$r=7$ is the first value not excluded", "first possible at $14$"** | **FALSE** |

**Act on this:** the proof derives "$\sigma_{ij}\sigma_{ik}$ is independent of $i$" and then never uses it again, and that one line by itself forces $\omega_2=\pm\omega_1$ at every $r$, so the all-simple stratum is empty in every dimension and the block's "$14$" must go from the title, the Statement and the last line of the proof.

## 0. Conventions, fixed once

- A $2$-form on $V$ is identified with a real skew endomorphism by $\omega(x,y)=\langle\omega x,y\rangle$, and $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $\varepsilon_j$ is the unit area form of an oriented plane $E_j$: in an adapted orthonormal frame it is $e^{2j-1}\wedge e^{2j}$, its matrix has entries $\pm1$ in that block, $\varepsilon_j^2=-\mathrm{Id}_{E_j}$ and $\langle\varepsilon_j,\varepsilon_j\rangle=1$. Each $\varepsilon_j$ is fixed only up to sign, so an individual $\sigma_{ij}$ is not canonical while the products $\sigma_{ij}\sigma_{i'j}$ are.
- On $\Lambda^4V$ the basis $4$-forms $e^{a}\wedge e^{b}\wedge e^{c}\wedge e^{d}$, $a<b<c<d$, are taken orthonormal. Only their linear independence is used.
- $A=-\omega_i^2$, positive definite on $V$ with $\operatorname{tr}A=2$. Its eigenspaces are $E_1,\dots,E_r$ with eigenvalues $c_1^2>0$ and $\dim E_j=2m_j$. All-simple means every $m_j=1$, so $\dim V=2r$.
- $J_{ij}$ denotes $\omega_i|_{E_j}/c_j$, a complex structure on $E_j$. In the all-simple case $J_{ij}=\sigma_{ij}\varepsilon_j$.
- $t_j=c_j^2m_j$, which is $c_j^2$ in the all-simple case.

## Hypothesis inventory

| Hypothesis | Where the block uses it | Where it is really needed |
|---|---|---|
| $\omega_i^2$ common | eigenspace preservation, the $c_j$ | everywhere |
| $\omega_i\wedge\omega_i$ common | one paragraph only, to get $\sigma_{ij}\sigma_{ik}$ $i$-independent, then dropped | it is the whole proof |
| $\langle\omega_i,\omega_i\rangle=1$ | $\sum_jt_j=1$ | the normalisation only |
| $\langle\omega_i,\omega_{i'}\rangle=0$, all three pairs | the three displayed relations | one pair suffices |
| all multiplicities $=2$ | distinctness of the $t_j$, hence "at most one singleton" | not needed for emptiness |
| $A\succ0$ on $V$, $V$ the common support | $c_jc_k>0$ cancels | genuinely needed |
| Ricci-flatness, first Bianchi, $W\in\mathcal W_n$ | nowhere | nowhere |

## 1. The cross-term step, derived from scratch

Because $\omega_i$ preserves every $E_j$ and the $E_j$ are mutually orthogonal, $\omega_i$ has no $\Lambda^1E_j\wedge\Lambda^1E_k$ component for $j\ne k$: for $x\in E_j$ and $y\in E_k$, $\omega_i(x,y)=\langle\omega_ix,y\rangle=0$ since $\omega_ix\in E_j\perp E_k$. So $\omega_i=\sum_j\omega_i^{(j)}$ with $\omega_i^{(j)}\in\Lambda^2E_j$. On a plane a skew map is a multiple of the area form, and $(\omega_i^{(j)})^2=-c_j^2\mathrm{Id}_{E_j}$ pins the multiple to $\pm c_j$, so
$$\omega_i=\sum_jc_j\sigma_{ij}\varepsilon_j,\qquad \sigma_{ij}=\pm1 .$$

Wedging, and using that $2$-forms commute under $\wedge$,
$$\omega_i\wedge\omega_i=\sum_jc_j^2\,\varepsilon_j\wedge\varepsilon_j+2\sum_{j<k}c_jc_k\,\sigma_{ij}\sigma_{ik}\,\varepsilon_j\wedge\varepsilon_k .$$
The block's component $2\sigma_{ij}\sigma_{ik}c_jc_k$ is confirmed, including the factor $2$, which is the $(j,k)$ and $(k,j)$ terms collected.

**The $\varepsilon_j\wedge\varepsilon_j$ terms vanish, for two independent reasons.** $\varepsilon_j$ is decomposable, $e^{2j-1}\wedge e^{2j}$, and a decomposable form wedged with itself repeats a factor, so $\varepsilon_j\wedge\varepsilon_j=0$. Separately, $\varepsilon_j\wedge\varepsilon_j\in\Lambda^4E_j$ and $\dim E_j=2$, so $\Lambda^4E_j=0$. The block's phrase "the $\Lambda^4E_j$ parts impose nothing extra once the signs are pinned" is true in the all-simple case for the second reason, and the qualifier "once the signs are pinned" is not needed here: the summand is zero before any sign is discussed. That qualifier is inherited from [L184](../findings/diagonal-half.md#L1016)'s case 3, where $\dim Q=4$ makes $\Lambda^4Q$ genuinely nonzero and the sequencing is load-bearing. Carrying it into the all-simple case is harmless and slightly misleading.

**Independence of the surviving terms.** For $j<k$, $\varepsilon_j\wedge\varepsilon_k=e^{2j-1}\wedge e^{2j}\wedge e^{2k-1}\wedge e^{2k}$ are distinct basis $4$-forms, hence linearly independent. This is [L184](../findings/diagonal-half.md#L1002)'s discharged debt (i). Equating $\omega_i\wedge\omega_i$ across $i$ therefore gives, coefficient by coefficient,
$$c_jc_k\,\sigma_{ij}\sigma_{ik}\ \text{independent of }i\quad\text{for every }j<k,$$
and $c_jc_k>0$ cancels. **Confirmed as written.** Note this needs $r\ge2$ for a pair to exist, which the statement's $r\ge3$ supplies.

## 2. The weights

$\langle\omega_i,\omega_{i'}\rangle=\tfrac12\operatorname{tr}(\omega_i^{\mathsf T}\omega_{i'})=-\tfrac12\operatorname{tr}(\omega_i\omega_{i'})$. Blockwise, $\operatorname{tr}(\omega_i\omega_{i'})|_{E_j}=c_j^2\sigma_{ij}\sigma_{i'j}\operatorname{tr}(\varepsilon_j^2)=-2c_j^2\sigma_{ij}\sigma_{i'j}$, so
$$\langle\omega_i,\omega_{i'}\rangle=\sum_jc_j^2\,\sigma_{ij}\sigma_{i'j}=\sum_jt_j\,\sigma_{ij}\sigma_{i'j}. \qquad\checkmark$$

$\operatorname{tr}A=\sum_j 2m_jc_j^2=2\sum_jt_j$, so $\operatorname{tr}A=2$ is exactly $\sum_jt_j=1$. **And it is exactly $\langle\omega_i,\omega_i\rangle=1$ as well**, since $\langle\omega_i,\omega_i\rangle=-\tfrac12\operatorname{tr}(\omega_i^2)=\tfrac12\operatorname{tr}A$. The two are the same condition, not two, which the block's phrasing leaves slightly open by attributing $\sum t_j=1$ to $\operatorname{tr}A=2$ and orthonormality separately.

**The implicit factor is right.** For a complex structure $J$ on a space of dimension $2m$, $\langle J,J\rangle=\tfrac12\operatorname{tr}(J^{\mathsf T}J)=\tfrac12\operatorname{tr}(-J^2)=\tfrac12\operatorname{tr}(\mathrm{Id}_{2m})=m$. With $J_{ij}=\sigma_{ij}J_j$ the same block computation gives $\langle\omega_i,\omega_{i'}\rangle=\sum_jc_j^2m_j\sigma_{ij}\sigma_{i'j}$, so $t_j=c_j^2m_j$ is the correct general weight and it is consistent with $\sum_jt_j=1$ from $\operatorname{tr}A=2$. **Confirmed**, including the $m_j$ the block leaves implicit.

## 3. The four classes

With $u=\sigma_1\sigma_2$ and $v=\sigma_1\sigma_3$ componentwise, $\sigma_2\sigma_3=uv$ componentwise, so the three orthogonality relations are the three displays. Partitioning by $(u_j,v_j)$:

$$\sum_jt_ju_j=T_{++}+T_{+-}-T_{-+}-T_{--},\quad \sum_jt_jv_j=T_{++}-T_{+-}+T_{-+}-T_{--},\quad \sum_jt_ju_jv_j=T_{++}-T_{+-}-T_{-+}+T_{--}.$$

All three signed forms are as the block writes them. Adding the first two gives $T_{++}=T_{--}$, subtracting gives $T_{+-}=T_{-+}$, and the third then reads $2T_{++}=2T_{+-}$. With $\sum T=1$ the solution is $T_{++}=T_{+-}=T_{-+}=T_{--}=\tfrac14$ and it is unique: the $4\times4$ system (three relations plus the normalisation) has the Hadamard-type matrix $\begin{pmatrix}1&1&1&1\\1&1&-1&-1\\1&-1&1&-1\\1&-1&-1&1\end{pmatrix}$, whose square is $4I$, so it is invertible. **Confirmed, with uniqueness.**

An empty class has weight $0\ne\tfrac14$, so every class is nonempty. **Confirmed.** This uses $t_j>0$ only through the class weights being sums of positive numbers, which is not even needed for the uniqueness, only for the reading of "nonempty".

**One scope remark that matters for section 5.** This section consumes orthonormality and nothing else. The wedge hypothesis of section 1 is not used anywhere in it.

## 4. The partition count

A class is a set of coordinates, so the four classes partition $\{1,\dots,r\}$ into four nonempty parts. Enumerating partitions of $r$ into exactly four positive parts:

| $r$ | partitions into four nonempty parts | singletons in each | verdict |
|---|---|---|---|
| $3$ | none | n/a | excluded |
| $4$ | $1+1+1+1$ | $4$ | excluded |
| $5$ | $2+1+1+1$ | $3$ | excluded |
| $6$ | $3+1+1+1$; $2+2+1+1$ | $3$; $2$ | excluded |
| $7$ | $4+1+1+1$; $3+2+1+1$; $2+2+2+1$ | $3$; $2$; $1$ | $2+2+2+1$ survives |

**The criterion is right and it is exactly necessary, not sufficient.** A singleton class $\{j\}$ has $T=t_j=\tfrac14$, and two singletons $\{j\},\{k\}$ give $t_j=t_k=\tfrac14$. In the all-simple case $t_j=c_j^2$ and the $c_j^2$ are distinct by hypothesis, so two singletons are impossible. The block uses "at most one singleton" only to exclude, which is the direction a necessary condition supports, so no error. It is not sufficient: a surviving partition still needs positive weights, distinct across the whole of $\{1,\dots,r\}$ and not merely within a class, summing to $\tfrac14$ per class. Section 5 supplies those for $2+2+2+1$, so the block's use of the criterion is sound in both directions it takes it.

## 5. $r=7$: the weights exist, and the stratum is still empty

**The weights exist.** Take
$$t_7=\tfrac14,\qquad \{t_1,t_2\}=\{\tfrac{27}{200},\tfrac{23}{200}\},\qquad \{t_3,t_4\}=\{\tfrac{28}{200},\tfrac{22}{200}\},\qquad \{t_5,t_6\}=\{\tfrac{29}{200},\tfrac{21}{200}\}.$$
Each pair sums to $\tfrac{50}{200}=\tfrac14$, the four class weights are $\tfrac14$ each, the total is $1$, all seven numerators $27,23,28,22,29,21,50$ are distinct and positive, so all seven $c_j^2=t_j$ are distinct and positive. **The block's closed-form claim at $r=7$ is confirmed**, and the general shape is $t_7=\tfrac14$ with pairs $\{\tfrac18+x_\ell,\tfrac18-x_\ell\}$ for distinct $x_\ell\in(0,\tfrac18)$.

**And it buys nothing, because the wedge hypothesis was left on the floor.** This is the defect. Section 1 derived, from equal wedges alone,
$$\sigma_{1j}\sigma_{1k}=\sigma_{2j}\sigma_{2k}\quad\text{for every }j<k .$$
Multiply both sides by $\sigma_{1j}\sigma_{1k}$, which squares to $1$ componentwise:
$$1=\sigma_{1j}\sigma_{2j}\,\sigma_{1k}\sigma_{2k}=u_ju_k\quad\text{for every }j<k .$$
Since $u_j\in\{\pm1\}$, $u_ju_k=1$ says $u_j=u_k$. **So $u$ is constant**, and by the same computation with $\omega_3$ in place of $\omega_2$, $v$ is constant. Writing $u\equiv\eta$, $\omega_2=\sum_jc_j\sigma_{2j}\varepsilon_j=\eta\sum_jc_j\sigma_{1j}\varepsilon_j=\eta\,\omega_1$, whence
$$\langle\omega_1,\omega_2\rangle=\eta\,\langle\omega_1,\omega_1\rangle=\pm1\ne0,$$
against orthogonality. **This holds at every $r\ge2$.** Read inside the block's own four-class language: $u$ and $v$ constant put every coordinate into one class, so that class has weight $1$ and the other three have weight $0$, flatly against $T=\tfrac14$ each. The block therefore contains, two paragraphs apart, a constraint and a conclusion that cannot both hold.

**What is exhibited concretely.** At $r=7$ with the weights above, any assignment of signs satisfying the four-class conclusion has $u$ non-constant, hence some pair $j<k$ with $u_ju_k=-1$, hence $\sigma_{1j}\sigma_{1k}\ne\sigma_{2j}\sigma_{2k}$, hence
$$(\omega_1\wedge\omega_1-\omega_2\wedge\omega_2)\ \text{has }\varepsilon_j\wedge\varepsilon_k\text{ coefficient }\ 2c_jc_k\big(\sigma_{1j}\sigma_{1k}-\sigma_{2j}\sigma_{2k}\big)=\pm4c_jc_k\ne0 .$$
So the wedges are unequal and the hypothesis fails. There is no all-simple coincident triple at $r=7$, and the same line kills every $r$.

**Arguing the opposite, as charitably as the words allow.** "$r=7$ is the first value not excluded" can be read as "not excluded *by this count*", which is a statement about the argument and is then true. Three things defeat that reading. The **title** says "first possible at $14$", which is a claim about the world with no hedge. The **proof's last sentence** presents the $r=7$ weights as though they were a step towards existence rather than a remark about the count. And the **header** advertises the lemma as extending [L184](../findings/diagonal-half.md#L1012)'s case 1, whose body on the same page already runs the very computation above, in three planes, to $\omega_i=\eta_i\omega_1$ and $\operatorname{tr}(\omega_1\omega_2)=\mp2$. So the charitable reading makes the lemma a strictly weaker restatement of the lemma it cites, advertised as an extension of it.

**What else $r=7$ would have needed, had the count been the only obstruction.** Weights are the spectrum of $A$ alone. A triple additionally needs sign vectors $\sigma_1,\sigma_2,\sigma_3\in\{\pm1\}^7$ realising the class pattern *and* satisfying the wedge condition, plus an orientation choice per plane. The wedge condition is the one that is unsatisfiable. Existence of $t$ was never close to existence of a triple, and the block says so in the abstract while its title does not.

## 6. The sharpening, which is stronger than the block claims

**The reduction.** Let $\dim E_1=2$, so $J_{i1}=s_{i1}\varepsilon_1$ with $s_{i1}=\pm1$. For $k\ne1$ the $\Lambda^2E_1\otimes\Lambda^2E_k$ component of $\omega_i\wedge\omega_i$ is $2c_1c_k\,J_{i1}\wedge J_{ik}=2c_1c_k\,s_{i1}\,\varepsilon_1\wedge J_{ik}$. The map $\alpha\mapsto\varepsilon_1\wedge\alpha$ from $\Lambda^2E_k$ into $\Lambda^4V$ is injective, $E_1\perp E_k$ making it $\alpha\mapsto\varepsilon_1\otimes\alpha$ into the summand $\Lambda^2E_1\otimes\Lambda^2E_k$ with $\varepsilon_1\ne0$. This is [L184](../findings/diagonal-half.md#L1002)'s discharged debt (ii). So equal wedges give $s_{i1}J_{ik}=s_{11}J_{1k}$, that is
$$J_{ik}=s_{11}s_{i1}\,J_{1k}\qquad\text{for every }k\ne1 .$$
**The sign $s_{11}s_{i1}$ carries no $k$.** Setting $\tau_i=s_{11}s_{i1}$, the same formula holds at $k=1$ as well, since $J_{i1}=s_{i1}\varepsilon_1=\tau_i\,s_{11}\varepsilon_1=\tau_iJ_{11}$. Hence
$$\omega_i=\sum_kc_kJ_{ik}=\tau_i\sum_kc_kJ_{1k}=\tau_i\,\omega_1,\qquad \langle\omega_1,\omega_2\rangle=\tau_2=\pm1\ne0 .$$
**So a single eigenvalue of multiplicity exactly two empties the coincident case outright**, at every dimension and whatever the other multiplicities are. The block's box stops one line short: it writes $\omega_i=\sum_jc_j\sigma_{ij}J_j$ with $\sigma_{ij}$ free in $j$, and then reaches for the weighted orthogonality, when its own cross term has already made $\sigma_{ij}$ independent of $j$. **The box is correct as far as it goes and understates itself.**

**The arithmetic claim in the next box is true and moot.** $c_j^2m_j=c_k^2m_k$ with $c_j^2\ne c_k^2$ is easy: $c_j^2=\tfrac18$ with $m_j=2$ and $c_k^2=\tfrac14$ with $m_k=1$ give $t_j=t_k=\tfrac14$, and with both multiplicities at least two, $c_j^2=\tfrac18,m_j=2$ against $c_k^2=\tfrac1{16},m_k=4$ do the same. **Confirmed as arithmetic.** It is moot as a statement about the programme: the regime in which the four-class count applies is the regime with a simple eigenvalue, and that regime is empty by the paragraph above, so "two singleton classes are consistent" is a remark about the interior of an empty set. The box's closing clause, "the four classes of weight $\tfrac14$ hold wherever one eigenvalue is simple", is vacuously true and reads as though a configuration space survived there.

## 7. The frontier is not where the block puts it

**Refuted as stated.** The claim is that what the argument leaves untouched is exactly the stratum with every eigenvalue of $A$ of multiplicity at least four. The cross term reaches further, by one step the record has not taken.

**The general cross term.** With $r\ge2$ and arbitrary multiplicities, write $\omega_i=\sum_jc_jJ_{ij}$. The decomposition $\Lambda^4V=\bigoplus_j\Lambda^4E_j\ \oplus\ \bigoplus_{j<k}\Lambda^2E_j\otimes\Lambda^2E_k\ \oplus\ \cdots$ is a direct sum of distinct isotypic summands, so equal wedges give, for each pair $j<k$,
$$J_{ij}\wedge J_{ik}=J_{1j}\wedge J_{1k},\qquad\text{that is}\qquad J_{ij}\otimes J_{ik}=J_{1j}\otimes J_{1k}\ \text{in }\Lambda^2E_j\otimes\Lambda^2E_k .$$
Both sides are nonzero rank-one tensors, so $J_{ij}=\lambda\,J_{1j}$ and $J_{ik}=\lambda^{-1}J_{1k}$ for some $\lambda\in\mathbb R^\times$. Squaring, $-\mathrm{Id}=J_{ij}^2=\lambda^2J_{1j}^2=-\lambda^2\mathrm{Id}$, so $\lambda=\pm1$ and $\lambda^{-1}=\lambda$. Writing $J_{ij}=\tau_{ij}J_{1j}$, the pair $(j,k)$ gives $\tau_{ij}=\lambda=\tau_{ik}$, and with $r\ge2$ every index has a partner, so $\tau_{ij}=\tau_i$ is independent of $j$ and $\omega_i=\tau_i\omega_1$. Orthogonality fails.

**So the coincident case is empty whenever $A$ has at least two distinct eigenvalues on $V$, at every dimension and every multiplicity pattern.** The surviving stratum is exactly $A=c\,\mathrm{Id}_V$, that is $\omega_i=cJ_i$ with $c^2=2/\dim V$ and $J_i$ complex structures, pairwise trace-orthogonal, with $J_i\wedge J_i$ common. That is [L184](../findings/diagonal-half.md#L1014)'s case 2 with the dimension freed, and it is where padded $W_{\mathbb{CP}^2}$ lives, at $\dim V=4$, $c^2=\tfrac12$, the three unit self-dual forms. **This paragraph is my own derivation and owes its own round**, on the footing the record already uses for a reviewer's construction. The refutation of the block's frontier claim does not depend on it being adopted: it depends only on the special case $m_j=1$ derived in section 6, which is the block's own box, and that case alone already contradicts "multiplicity at least four" being the frontier, since a stratum with one simple eigenvalue and the rest of multiplicity four is untouched by the block's lemma and closed by the block's own box.

**What is cheap at $\dim V=8$.** Under the general cross term the two-eigenvalue patterns $4+4$, $6+2$ and $2+2+2+2$ at $\dim V=8$ all close, leaving $A=\tfrac14\mathrm{Id}_8$ alone. There, equal wedges read
$$(\omega_1-\omega_2)\wedge(\omega_1+\omega_2)=0 .$$
If $\omega_1+\omega_2$ is nondegenerate then, by hard Lefschetz for a symplectic vector space of dimension $2m$, the map $L:\Lambda^2\to\Lambda^4$ is injective for $m\ge3$, since $L^{m-2}:\Lambda^2\to\Lambda^{2m-2}$ is an isomorphism and factors through it. So $\omega_1=\omega_2$, against orthogonality. If $\omega_1-\omega_2$ is nondegenerate the same argument gives $\omega_2=-\omega_1$. **Hence both $J_1+J_2$ and $J_1-J_2$ must be degenerate, that is $P=J_1^{-1}J_2$ must have both $+1$ and $-1$ in its spectrum**, at every $\dim V\ge6$. In particular **anticommuting pairs are excluded**: $J_1J_2=-J_2J_1$ gives $P^2=J_1J_2J_1J_2=-\mathrm{Id}$, so $P$ has no real eigenvalue at all. That closes the two natural $\dim V=8$ candidates in closed form, the quaternionic triple $L_i,L_j,L_k$ on $\mathbb H^2$ and the octonionic $L_u,L_v,L_w$ on $\mathbb O$ for orthonormal imaginary units, both of which anticommute, $L_uL_v+L_vL_u=-2\langle u,v\rangle\mathrm{Id}$. The $\dim V=8$ scalar stratum is not closed by this, and it is the honest frontier. *These two paragraphs are reviewer's derivations and are recorded as owing a round, not as record.*

## 8. Scope and hypotheses

**No Weyl input.** Nothing in the block uses Ricci-flatness, first Bianchi, or membership in $\mathcal W_n$. The two coincidences and orthonormality are the whole of it, and the same is true of every derivation above. This matches [L184](../findings/diagonal-half.md#L1002)'s own Weyl-free framing.

**$V$ as the support is used and used correctly.** $A\succ0$ on $V$ is what makes every $c_j>0$, which is what lets $c_jc_k$ cancel in section 1 and what makes $t_j>0$ in section 3. Off $V$ the eigenvalue $0$ would give a plane on which the cross term is identically zero and carries no sign information. The statement says "multiplicity exactly two **on $V$**", which is the correct qualifier, and it is the one [L184](../findings/diagonal-half.md#L1012)'s case 1 was repaired to carry.

**Orthonormality is over-spent.** The block needs all three orthogonality relations, because the four-class system has three rows. The correct argument needs one: $\omega_2=\eta\omega_1$ contradicts $\langle\omega_1,\omega_2\rangle=0$ as soon as $\omega_1\ne0$. Unit norms enter only as the normalisation $\sum t_j=1$, which is $\operatorname{tr}A=2$, and even that is dispensable, since $\langle\omega_1,\omega_2\rangle=\eta\lVert\omega_1\rVert^2$. **So the lemma as corrected is a two-form statement, not a three-form one**, which is the same observation that turned [L184](../findings/diagonal-half.md#L1002) into [L191](../findings/diagonal-half.md) and would turn this into an all-dimensions pair statement: two $2$-forms on $V$ with equal squares, equal self-wedges and $A$ having a simple eigenvalue satisfy $\omega_2=\pm\omega_1$.

## 9. Falsification

**What would falsify the lemma as stated.** An orthonormal triple at $\dim V\in\{8,10,12\}$, all-simple, with both coincidences. **What would falsify the corrected statement**, that the all-simple stratum is empty at every $r$: sign vectors $\sigma_1,\sigma_2\in\{\pm1\}^r$ with $\sigma_{1j}\sigma_{1k}=\sigma_{2j}\sigma_{2k}$ at every pair and $\sigma_2\ne\pm\sigma_1$. **What I did to look for it.** I reduced the falsifier to that finite sign question and solved it in closed form: $u_ju_k=1$ at every pair on $\{\pm1\}$ forces $u$ constant, so $\sigma_2=\pm\sigma_1$ and no falsifier exists, at any $r$. **No search, sweep or census was run**, and none is needed, the question having a two-line closed-form answer. The seven-term rational sum in section 5 was done by hand and is exact.

## Verdict

**BROKEN.**

- The **title** and the **second clause of the Statement** are false. There is no first possible value: the all-simple coincident stratum is empty at every $r\ge2$, hence at every $\dim V$.
- The **first clause of the Statement** is true, and is strictly weaker than [L184](../findings/diagonal-half.md#L1012)'s case 1, which is on the same page, is cited by this block's own header, and whose argument the record has twice recorded as dimension-free.
- Every individual step the block takes is correct: the cross term, the weights, the four classes and their uniqueness, the partition count, the $r=7$ weights, and the one-simple-eigenvalue reduction. **The defect is an omission.** The wedge hypothesis is used once, in the paragraph that derives it, and never again, and the count that follows is a consequence of orthonormality alone.
- **Repair, minimal.** Delete the dimensional claim from the title, the Statement and the last sentence of the proof, and either retire the lemma into [L184](../findings/diagonal-half.md#L1012)'s case 1 or restate it as the two-form statement of section 8. The four-class count is worth keeping only as what orthonormality alone gives, clearly labelled as insufficient.
- **Not folded, owing its own round:** section 7's general cross term, which would move the frontier from "every eigenvalue of multiplicity at least four" to "$A$ scalar", and section 7's Lefschetz remark, which excludes anticommuting pairs at $\dim V\ge6$.
