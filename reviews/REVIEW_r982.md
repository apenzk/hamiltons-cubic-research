# r982: Gate 2 on the first-order condition on $O(k)$

Reviewer r982, working from [BRIEF_R28_first_order.md](BRIEF_R28_first_order.md) and from the $R28$ cell of [routes.md](../routes.md), which the brief quotes. The working note, the other reviewers' reports and the scripts were left unread.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | criticality on $O(k)$ is $(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}=0$ for all $i\ne j$ | **CONFIRMED**, exactly, with no dropped factor, sign or symmetrisation |
| 2 | equivalent to $(\nu_i-\nu_j)\big[\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}\big]=0$ | **CONFIRMED** |
| 3 | holds at every critical point, not only at maxima, and is $\lvert J\rvert$-free | **CONFIRMED** as an equivalence for the $V$-frame section, with one hypothesis to write down |
| 4 | $\nu$ pairwise distinct and $\tilde U$ diagonal give $\tilde C$ diagonal | **CONFIRMED**, after the hypothesis "at a critical point" is restored to the sentence |
| 5 | hence $[\hat U,C]=0$ | **CONFIRMED as an implication**, and the sentence as written reads as an unconditional conclusion it does not support |
| 6 | $\tilde U$ block diagonal gives simultaneous block diagonalisation, which does not imply commuting | **CONFIRMED** on the mathematics, with an explicit critical witness. **PLAUSIBLE on the attribution to `Splits`**, which as defined admits $R\ne C$ and then yields something other than block diagonality |
| 7 | the distinctness hypothesis is necessary | **CONFIRMED**, with a two-dimensional counterexample constructed here |

## The headline, before the detail

**The lemma is correct and the node cannot run it forwards.** Its hypothesis set is exactly the common orthonormal eigenframes of $\hat U$ and $C$, which is empty off the commuting stratum, so at a non-commuting pair the lemma says that no critical point diagonalises $\hat U$. That is a contrapositive, and it is useful, and it is a different statement from $[\hat U,C]=0$. The $R28$ cell's own witness is a non-commuting pair with $\nu$ pairwise distinct, so on the node's own data claims 4 and 5 fire in the negative direction only.

## Claim 1, derived from scratch

The tangent space is $T_PO(k)=\{P\Omega:\Omega^{\mathsf T}=-\Omega\}$, so take $P(t)=P\exp(t\Omega)$ with $\Omega$ skew. Then $\tilde U(t)=\exp(-t\Omega)\tilde U\exp(t\Omega)$ and $\dot{\tilde U}(0)=[\tilde U,\Omega]$, and likewise for $\tilde C$.

With $f(t)=\mathop{\mathrm{tr}}(\mathop{\mathrm{diag}}(a)\tilde U(t))+\mathop{\mathrm{tr}}(\mathop{\mathrm{diag}}(b)\tilde C(t))$ and the identity $\mathop{\mathrm{tr}}(D[M,\Omega])=\mathop{\mathrm{tr}}([D,M]\Omega)$,

$$f'(0)=\mathop{\mathrm{tr}}(A\Omega),\qquad A:=[\mathop{\mathrm{diag}}(a),\tilde U]+[\mathop{\mathrm{diag}}(b),\tilde C],\qquad A_{ij}=(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}.$$

$A$ is skew-symmetric automatically, because $\tilde U$ and $\tilde C$ are symmetric while $a_i-a_j$ and $b_i-b_j$ are antisymmetric in the index pair. Testing against $\Omega=E_{ij}-E_{ji}$ gives $\mathop{\mathrm{tr}}(A\Omega)=A_{ji}-A_{ij}=-2A_{ij}$, so $f'(0)=0$ for every skew $\Omega$ holds if and only if $A=0$. The block's equation is exactly that.

**Four things the derivation settles that the brief asked about.**

- **No dropped symmetrisation.** A gradient on $O(k)$ is generally the skew part of a matrix, and here $A$ is skew before any projection, so the projection is the identity and nothing was silently dropped.
- **The factor is $-2$ and it is immaterial**, since only the vanishing locus of $A$ is claimed.
- **"For all $i\ne j$" and "for $i<j$" define the same locus.** The $(j,i)$ equation is the negative of the $(i,j)$ equation, and the $i=j$ equation reads $0=0$. So the honest count is $\binom k2$ independent equations, which is $\dim T_PO(k)$ exactly. **This count is the control**: a characterisation of criticality on $O(k)$ must produce $k(k-1)/2$ independent scalar equations and this one does.
- **The choice of curve does not matter.** $\exp(t\Omega)P$ sweeps the same tangent space and gives an equivalent condition on the unconjugated pair. The tilde form is the one belonging to $P\exp(t\Omega)$, and the block has them matched correctly.

**Screen** (assertions, no printed expectations, a fraction of a second on objects built for the purpose): at $k=2,3,5,7$ over random symmetric $\hat U,C$, random $\nu$, random $P\in O(k)$ and random skew $\Omega$, the central difference of $f$ along $P\exp(t\Omega)$ agrees with $\mathop{\mathrm{tr}}(A\Omega)$ to $10^{-6}$ relative, $A$ is skew to $10^{-12}$, and $\mathop{\mathrm{tr}}(A(E_{ij}-E_{ji}))=-2A_{ij}$ to $10^{-12}$.

## Claim 2

$a_i-a_j=\beta(\nu_i^2-\nu_j^2)=\beta(\nu_i-\nu_j)(\nu_i+\nu_j)$ and $b_i-b_j=\nu_i-\nu_j$, so $A_{ij}=(\nu_i-\nu_j)\big[\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}\big]$. This is a `ring` identity and the brief's Lean row 2 is right that it is typeable and untyped.

## Claim 3, and the load-bearing word "exactly"

**It is an equivalence, not merely a necessary condition**, because the test directions $E_{ij}-E_{ji}$ span the skew matrices and recover each $A_{ij}$ individually. So "criticality is" is the correct verb.

$O(k)$ is compact without boundary, so every maximiser is critical and the critical set contains the maximisers strictly. The derivation names $k$ only through the size of the matrices and never touches $\lvert J\rvert$, so the uniformity claim holds.

**The hypothesis that should be written down.** The equivalence is an equivalence *for the $V$-frame section with $\hat U$, $C$ and $\nu$ held fixed*. If the node's full objective lets any of the three depend on $P$, then $A=0$ survives as a **necessary** condition at a joint critical point, because the $P$-partial still vanishes there, and the word "exactly" stops applying to the full problem. The block inherits this from the register's phrase "the $V$-frame dependence of the value", which is a section by construction, so the claim is true as stated and the scope should travel with it.

## Claim 4

With $\tilde U$ diagonal the condition collapses to $(\nu_i-\nu_j)\tilde C_{ij}=0$ for $i\ne j$, so $\tilde C_{ij}=0$ **exactly on the pairs with $\nu_i\ne\nu_j$**. Pairwise distinctness covers every pair, and $\tilde C$ is diagonal.

**The sharp general form**, which is what the block's sentence is a special case of: at a critical point with $\tilde U$ diagonal, $\tilde C$ is block diagonal with respect to the partition of $[k]$ into the level sets of $\nu$. Distinctness is the case where that partition is into singletons.

**The hypothesis the block dropped.** The quoted sentence reads "With $\nu$ pairwise distinct and $\tilde U$ diagonal, $\tilde C$ is diagonal" and omits "at a critical point", which is doing all the work. It is recoverable from the preceding sentence, and it should be in the statement, because the sentence is the one a later reader will lift.

**Vacuity, which the brief asked about directly.** $\tilde U=P^{\mathsf T}\hat UP$ is diagonal if and only if the columns of $P$ are an orthonormal eigenframe of $\hat U$, so the hypothesis **is** a restatement of "$P$ diagonalises $\hat U$". The claim is still a deduction rather than a restatement, because the conclusion adds that the same $P$ diagonalises $C$, and criticality is what supplies it.

**The vacuity that is real lives one level up.** Combining claim 4 with criticality, the set $\{P\in O(k)\ \text{critical}:\tilde U\ \text{diagonal}\}$ is exactly the set of common orthonormal eigenframes of $\hat U$ and $C$, which is empty whenever $[\hat U,C]\ne0$. So the implication is sound and its hypothesis is satisfiable only on the commuting stratum. The direction with content off that stratum is the contrapositive: **at a non-commuting pair with $\nu$ pairwise distinct, no critical point diagonalises $\hat U$.**

**Screen on the node's own data.** Taking the $R28$ cell's witness $\hat U=\mathop{\mathrm{diag}}(1,-1,10)$, $C$ the padded $2\times2$ swap and $\nu=(0.5,1.3,2.0)$, a gradient flow along $-A$ from $60$ random frames reaches a maximiser of the brief's functional at which $\lVert A\rVert<10^{-8}$ and $\tilde U$ carries off-diagonal entries of order $1$. The value scale of the brief's reduced functional differs from the $41.64730082$ the register records, so this is a screen on the register's data and not a reproduction of that number.

## Claim 5

$\tilde U$ and $\tilde C$ diagonal in the same frame commute, and $\tilde U\tilde C=P^{\mathsf T}\hat UPP^{\mathsf T}CP=P^{\mathsf T}\hat UCP$ uses $PP^{\mathsf T}=I$. So $[\tilde U,\tilde C]=P^{\mathsf T}[\hat U,C]P$ and $P$ invertible gives $[\hat U,C]=0$.

**Orthogonality is load-bearing and is not merely invertibility.** For a general invertible $P$ the map $M\mapsto P^{\mathsf T}MP$ is a congruence rather than a conjugation, and congruence does not preserve commuting: $M=I$ and $N=\begin{pmatrix}0&1\\1&0\end{pmatrix}$ commute, while under $P=\mathop{\mathrm{diag}}(1,2)$ their congruences $\mathop{\mathrm{diag}}(1,4)$ and $\begin{pmatrix}0&2\\2&0\end{pmatrix}$ have commutator entry $-6$. $P\in O(k)$ supplies what is needed, so the claim stands, and the brief's Lean row 5 calling it "one line" is right only with $P^{\mathsf T}=P^{-1}$ in hand.

**The wording to fix.** "Hence $[\hat U,C]=0$" reads as a conclusion about the pair. It is a conclusion about the pair *given a critical point at which $\tilde U$ is diagonal*, and per claim 4 that hypothesis is exactly the commuting stratum. Stated unconditionally it would be circular, so the implication arrow must stay visible in the statement.

## Claim 6

**The inheritance direction is right, and it is stronger than block diagonality.** With $\nu$ pairwise distinct, criticality gives, for every $i\ne j$,

$$\tilde C_{ij}=-\beta(\nu_i+\nu_j)\tilde U_{ij},$$

so every off-diagonal zero of $\tilde U$ is an off-diagonal zero of $\tilde C$, whatever the pattern. Block diagonality is the special case where the pattern is a partition into blocks, and $\tilde C$ inherits the same blocks.

**Refinement the block's phrase "simultaneous block diagonalisation" hides.** The inheritance runs one way. Where $\nu_i=-\nu_j$ the relation forces $\tilde C_{ij}=0$ even with $\tilde U_{ij}\ne0$, so $\tilde C$ can be strictly sparser than $\tilde U$. The two matrices share a block structure, and their supports are equal only on the pairs with $\nu_i+\nu_j\ne0$.

**Simultaneous block diagonality falls short of commuting, and here is a critical point that shows it.** At $k=3$ with the partition $\{1,2\}\mid\{3\}$, $\nu=(1,2,3)$, $\beta=\tfrac94$,

$$\hat U=\begin{pmatrix}0&1&0\\1&1&0\\0&0&\tfrac12\end{pmatrix},\qquad C=\begin{pmatrix}0&-\tfrac{27}4&0\\-\tfrac{27}4&0&0\\0&0&7\end{pmatrix},$$

where $-\tfrac{27}4=-\beta(\nu_1+\nu_2)\hat U_{12}$. Then $P=I$ is critical, both matrices are block diagonal for that partition, and $[\hat U,C]$ has entries $\pm\tfrac{27}4$, of norm $\tfrac{27}{4}\sqrt2\approx9.55$. **So this is a witness inside the lemma's own hypotheses rather than an unrelated pair**, which is what makes it decisive. Verified by assertion.

**The one thing here that is short of established is the attribution to `Splits`.** The brief's `Splits` permits the row set $R$ and the column set $C$ to be permuted independently, so $R\ne C$ is allowed. Applied to a symmetric matrix that gives something other than block diagonality: at $k=2$ with $R=\{1\}$ and $C=\{2\}$, vanishing on $R\times C^{\mathsf c}$ and $R^{\mathsf c}\times C$ forces $M_{11}=M_{22}=0$ and leaves $M_{12}$ free, so $\begin{pmatrix}0&x\\x&0\end{pmatrix}$ splits and is block **anti**-diagonal. On such a pattern the criticality relation forces nothing at all, since no off-diagonal entry of $\tilde U$ is zero.

Two further gaps in the same clause, recorded as questions for the node rather than as verdicts, since `Splits` is given and outside this review:

- **$R=C$ is what the clause needs**, and the block should say so or derive it. With $R=C$ the matrix vanishes on $R\times R^{\mathsf c}$ and $R^{\mathsf c}\times R$ and is genuinely block diagonal, and everything above applies.
- **The register applies `Splits` to the orthostochastic images, not to $\tilde U$**. The $R28$ cell records "$R$ and $S$ both splitting" for the pair of orthostochastic matrices. Block diagonality of $\tilde U$ is a different object from splitting of $(E^{\mathsf T}P)^{\circ2}$, and the step between them is unstated in the block. The brief's own Lean row 6 says the same thing from the other side, that `Splits` in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) types the two-sided condition rather than block diagonality of a conjugate.

## Claim 7

**The invariance is real.** With $\nu_1=\nu_2=\lambda$ the first two summands combine into $\beta\lambda^2\mathop{\mathrm{tr}}(\hat U\Pi)+\lambda\mathop{\mathrm{tr}}(C\Pi)$ with $\Pi=p_1p_1^{\mathsf T}+p_2p_2^{\mathsf T}$ the projector onto $\mathop{\mathrm{span}}(p_1,p_2)$, and $\Pi$ is fixed by every rotation inside that plane.

**The counterexample, constructed here rather than accepted.** Take $k=2$, $\nu=(1,1)$, $\hat U=\mathop{\mathrm{diag}}(1,2)$ and $C=\begin{pmatrix}0&1\\1&0\end{pmatrix}$. Then $a_1=a_2$ and $b_1=b_2$, so $A\equiv0$ and **every** $P\in O(2)$ is critical. At $P=I$ the matrix $\tilde U$ is diagonal, $\tilde C=C$ is not, and $[\hat U,C]$ has entries $\pm1$. So claim 4's implication and claim 5's conclusion both fail the moment $\nu$ repeats. Verified by assertion, including that $A$ vanishes at $50$ random frames.

**The block's word "converse" is loose.** What fails without distinctness is the forward implication of claim 4, that criticality plus $\tilde U$ diagonal gives $\tilde C$ diagonal. The sentence should name it.

**Can $\nu$ repeat in the node?** Undecided from the brief, and this is the one thing a successor must check against the node's data rather than against this block. What is visible: the $R28$ cell's own witness carries $\nu=(0.5,1.3,2.0)$, pairwise distinct, and $\nu$ is data of the node rather than a free choice, so a repeat is a codimension-one degeneracy in that data. **The honest reading is that distinctness is a restriction which the node's recorded witness happens to satisfy**, and a $\lvert J\rvert=3$ argument that must cover every $\nu$ owes the degenerate stratum a separate treatment, where by the sharp form of claim 4 the conclusion weakens from diagonal to block diagonal along the level sets of $\nu$.

## Corrections to apply to the block

1. **Restore "at a critical point"** to the sentence beginning "With $\nu$ pairwise distinct and $\tilde U$ diagonal".
2. **Keep the implication arrow in claim 5.** The conclusion $[\hat U,C]=0$ is conditional on a critical point with $\tilde U$ diagonal existing, and that condition is equivalent to commuting, so the forward reading is circular and the contrapositive is what carries content.
3. **State the sharp form of claim 4**, that $\tilde C$ is block diagonal along the level sets of $\nu$, which contains both the distinct case and the degenerate case in one line.
4. **Either restrict `Splits` to $R=C$ in the block diagonality clause, or supply the step** from splitting of the orthostochastic image to block diagonality of $\tilde U$. As it stands the clause names an object `Splits` does not deliver.
5. **Say "inherits" rather than "simultaneous"** for the $\tilde U$ to $\tilde C$ block structure, since the pairs with $\nu_i+\nu_j=0$ break the symmetry of the statement.
6. **Note the equation count.** $\binom k2$ independent equations against $\dim O(k)=\binom k2$ is the cheapest available check that nothing was dropped, and it belongs next to the lemma.

## What the lemma buys the $\lvert J\rvert=3$ node

**A negative certificate at every critical point, free of numerics and uniform in $k$**: with $\nu$ pairwise distinct and $[\hat U,C]\ne0$, every critical frame fails to diagonalise $\hat U$, and more sharply every critical frame satisfies $\tilde C_{ij}=-\beta(\nu_i+\nu_j)\tilde U_{ij}$ off the diagonal, which pins the whole off-diagonal of $\tilde C$ to that of $\tilde U$ with explicit coefficients. **That pinning is the part worth carrying forward**, because it removes $\binom k2$ of the free parameters from any second-order or third-order computation done at a critical point, and it holds at maxima in particular.

## Method note

Every numerical statement above is an assertion in a single screening script built for this review, on objects constructed here, running in under a second. No claim in this report rests on a numerical result alone.
