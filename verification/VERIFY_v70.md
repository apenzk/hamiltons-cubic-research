# VERIFY v70, Lemma L59's apolarity sentence: $\mathrm{rank}=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}\iff F_5\perp\mathrm{ANN}$

*The brief was cold: the step was put neutrally, with no verifier's finding attached and no prior round file read. **I ran nothing**, no script, no Sage, no numerics, and none written; every value below is exact and taken either from the record or from a derivation carried here in full. Log: [agent_logs/verify-L62-v70.log](../agent_logs/verify-L62-v70.log). The step under adjudication is the bolded sentence of [Lemma L59](../results.md#L619) in [results.md](../results.md), whose canonical block is [findings/sym3-blocks.md:285](../findings/sym3-blocks.md#L285).*

## Verdict

**`VALID AS WRITTEN`.** Both halves are true, and true simultaneously, once two readings the record leaves open are fixed the only way that makes the sentence cohere with its own definitions and with [Lemma L62](../findings/sym3-blocks.md#L329):

- $\mathrm{rank}$ is $\mathrm{rank}(\mu_K)$, the restricted map from the $36$ to the $14$;
- $\perp$ is orthogonality in the **apolar** pairing, the same pairing that makes the displayed adjunction $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ true.

Under those readings each half splits into a free inequality and one upgrade step. The free halves need nothing beyond the adjunction and nondegeneracy. The upgrade steps both need one and the same three-line argument, $K$ is an $O(5)$-submodule, $\mathrm{Cat}_F$ is $O(5)$-invariant when $F$ is, and a $G$-invariant functional vanishing on the invariants vanishes, which is **absent from the record** and is already booked as absent in L59's own Gate 2 note. It is fillable from material the record holds, so the sentence stands. Its exposition owes those three lines and a name for the pairing.

A second result, which I record because it changes how much the absent step matters: **in the configuration the record is actually in, the upgrade step is bypassed entirely.** A squeeze between L62's order-one cap, the explicit witness $\mathcal A(W_0^6)$, and the measured rank forces $\mathrm{ANN}=(\operatorname{im}\mu_K)^\perp$ outright, so nothing downstream of L59 rests on the missing lines. The derivation is in §6.

## 1. The spaces, fixed before anything is asserted

Write $V=\mathcal W_5$, the $O(5)$-irreducible $[2,2]$ of dimension $35$ ([conventions.md](../findings/conventions.md), [sym3-blocks.md](../findings/sym3-blocks.md)), carrying its $O(5)$-invariant inner product $\langle\cdot,\cdot\rangle_V$. Four spaces are in play and the sentence relates a rank in one to a dimension in another, so each is named once:

| object | space it lives in | dimension | source |
| --- | --- | --- | --- |
| a cubic $q$ | $U:=\mathrm{Sym}^3V^*$ | $7770=\binom{37}3$ | [L83](../findings/sym3-blocks.md#L15) |
| $K$ | an $O(5)$-submodule of $U$ | $4200=7770-3570$ | [L91](../findings/sym3-blocks.md#L253)'s aside, [L87](../findings/sym3-blocks.md#L124) |
| a Gram $B$ | $S:=(\mathrm{Sym}^2K)^{O(5)}$ | $36$ | [L86](../findings/sym3-blocks.md#L94), [L87](../findings/sym3-blocks.md#L124), [L88](../findings/sym3-blocks.md#L142) |
| a sextic $F$, and $F_5$ | $T:=(\mathrm{Sym}^6V^*)^{O(5)}$ | $14$ | [L85](../findings/sym3-blocks.md#L68) |
| $\mathrm{Cat}_F$ | $(\mathrm{Sym}^2U)^*$, i.e. an invariant symmetric bilinear form on $U$ | the invariant ones number $65$ | [L88](../findings/sym3-blocks.md#L142) |

$\mu\colon\mathrm{Sym}^2U\to\mathrm{Sym}^6V^*$ is multiplication, $\mu_K$ its restriction to $S$, and $\operatorname{im}:=\mu_K(S)\subseteq T$. $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ is $O(5)$-invariant of degree $6$, so $F_5\in T$; this is the one membership the second half of the sentence would be vacuous without, and it is immediate.

**$K$ is an $O(5)$-submodule, and this is load-bearing twice below.** The record's phrase is *"the span of cubics cut out by the orbit constraint"*, which I read as $K=\{q\in U:q\vert_{O(5)\cdot W_0}=0\}$. That set is manifestly $O(5)$-stable, and the reading is confirmed by the record's own dimension bookkeeping: the block description behind the $36$ and the $29$ is $K=\bigoplus_\lambda M'_\lambda\otimes V_\lambda$ with $M'_\lambda=M_\lambda$ at odd $\lambda_2$ and $\operatorname{codim}M'_\lambda=1$ at even $\lambda_2$, giving $\dim K=7770-3570=4200$, which is [L91](../findings/sym3-blocks.md#L253)'s figure. The competing reading, $\{q:q(W_0)=0\}$ of dimension $7769$, is not a submodule and is incompatible with every count in the file. [L90](../findings/sym3-blocks.md#L234)'s second bullet states the submodule property explicitly, so the record does carry it.

## 2. The pairing, which the sentence does not name and which everything turns on

Use $\langle\cdot,\cdot\rangle_V$ to identify $V\cong V^*$, write $\ell_v=\langle v,\cdot\rangle$, and let $\langle\cdot,\cdot\rangle_d$ be the **apolar (Bombieri) pairing** on $\mathrm{Sym}^dV^*$: in an orthonormal coordinate system $\langle x^\alpha,x^\beta\rangle_d=\alpha!\,\delta_{\alpha\beta}$. Three properties are used and each is elementary:

- **positive definite**, hence nondegenerate on every subspace, $T$ included;
- **$O(5)$-invariant**, being built from an invariant inner product;
- **reproducing**: $\langle F,\ell_v^{\,d}\rangle_d=F(v)$ for every $F\in\mathrm{Sym}^dV^*$ and every $v\in V$.

With $\mathrm{Cat}_F(B_1,B_2):=\langle F,B_1B_2\rangle_6$ for $B_1,B_2\in U$, the displayed identity $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ **is** the statement $\mathrm{Cat}=\mu^{*}$, adjointness with respect to $\langle\cdot,\cdot\rangle_6$ upstairs and the induced pairing on $\mathrm{Sym}^2U$ downstairs. It is the definition of the adjoint rather than a theorem, which is what L59's Gate 2 note says and what [conventions.md](../findings/conventions.md#L45) tables.

**The normalisation caveat, and why it is inert.** Whether $\langle u_1\odot u_2,w_1\odot w_2\rangle$ carries a factor $2$ from the polarisation, and whether $\mu(B_1\odot B_2)$ is $B_1B_2$ or twice it, shifts the identity by a fixed nonzero scalar $c$ uniform in $F$ and $B$. Every use below is of the form "this pairing vanishes", so $c$ cancels. The record's two Gate 2 reviewers reached the same conclusion from opposite normalisations, and no number moves.

**Why the apolar reading is forced rather than chosen.** The second half of the sentence is $F_5\in\operatorname{im}\iff F_5\perp\mathrm{ANN}$. Since $\mathrm{ANN}$ is defined through $\mathrm{Cat}$, and $\mathrm{Cat}$ is the adjoint for $\langle\cdot,\cdot\rangle_6$, the equivalence can only be an equivalence if $\perp$ is $\langle\cdot,\cdot\rangle_6$-orthogonality; under any other inner product on $T$ the right-hand side names a different $13$-dimensional subspace and the biconditional is false in general. The record pins the apolar reading in two places without ever naming it: [sym3-blocks.md:253](../findings/sym3-blocks.md#L253) says *"the apolar pairing is reproducing"*, and L62's own verification of $F_5\perp\mathcal A(W_0^6)$ from $F_5(W_0)=0$ is exactly the reproducing property in use. I adopt it.

## 3. The first half, $\mathrm{rank}=14-\dim\mathrm{ANN}$

Read $\mathrm{rank}=\dim\operatorname{im}\mu_K$. Since $\langle\cdot,\cdot\rangle_6$ is definite on $T$,

$$\mathrm{rank}=14-\dim\big(\operatorname{im}\mu_K\big)^{\perp_T},\qquad \big(\operatorname{im}\mu_K\big)^{\perp_T}=\{F\in T:\langle F,\mu(B)\rangle=0\ \forall B\in S\}=\{F\in T:\langle\mathrm{Cat}_F,B\rangle=0\ \forall B\in S\},$$

the second equality being the adjunction. So the identity holds **iff**

$$\mathrm{ANN}=\{F\in T:\mathrm{Cat}_F(K,K)=0\}\quad\text{equals}\quad\{F\in T:\mathrm{Cat}_F\ \text{annihilates }S=(\mathrm{Sym}^2K)^{O(5)}\}.$$

**The inclusion $\subseteq$ is free.** $\mathrm{Cat}_F(K,K)=0$ says $\mathrm{Cat}_F$ annihilates all of $\mathrm{Sym}^2K$, hence in particular its invariant part. So $\mathrm{ANN}\subseteq(\operatorname{im}\mu_K)^{\perp_T}$ unconditionally, and

$$\boxed{\ \mathrm{rank}\ \le\ 14-\dim\mathrm{ANN}\ }$$

needs only the adjunction and definiteness.

**The reverse inclusion is the one step genuinely absent from the record, and it is three lines.** Let $F\in T$ with $\mathrm{Cat}_F$ annihilating $S$, and put $\varphi:=\mathrm{Cat}_F\vert_{\mathrm{Sym}^2K}\in(\mathrm{Sym}^2K)^*$.

1. $\varphi$ is $O(5)$-invariant: for $g\in O(5)$, $\mathrm{Cat}_F(gB_1,gB_2)=\langle F,g\cdot(B_1B_2)\rangle_6=\langle g^{-1}F,B_1B_2\rangle_6=\mathrm{Cat}_F(B_1,B_2)$, using invariance of $\langle\cdot,\cdot\rangle_6$ and invariance of $F$. This needs $K$ to be $g$-stable for $\varphi$ to be defined on a $g$-stable domain at all, §1.
2. Let $R$ be the Reynolds operator of the compact group $O(5)$ on $\mathrm{Sym}^2K$, the projection onto $(\mathrm{Sym}^2K)^{O(5)}=S$. For invariant $\varphi$, $\varphi(x)=\int_{O(5)}\varphi(gx)\,dg=\varphi(Rx)$.
3. $\varphi$ vanishes on $S=\operatorname{im}R$ by hypothesis, so $\varphi=\varphi\circ R=0$, i.e. $\mathrm{Cat}_F(K,K)=0$ and $F\in\mathrm{ANN}$.

Hence $\mathrm{ANN}=(\operatorname{im}\mu_K)^{\perp_T}$ and $\mathrm{rank}=14-\dim\mathrm{ANN}$ exactly. **First half: valid.**

## 4. The second half, $F_5\in\operatorname{image}\iff F_5\perp\mathrm{ANN}$

$F_5\in T$, $\operatorname{im}\mu_K\subseteq T$, and $\langle\cdot,\cdot\rangle_6$ is definite on the finite-dimensional $T$, so $\big((\operatorname{im}\mu_K)^{\perp_T}\big)^{\perp_T}=\operatorname{im}\mu_K$. With §3's equality $\mathrm{ANN}=(\operatorname{im}\mu_K)^{\perp_T}$,

$$F_5\perp\mathrm{ANN}\iff F_5\in\mathrm{ANN}^{\perp_T}=\operatorname{im}\mu_K.$$

**The two directions cost different things, and the record consumes the expensive one.**

- $\Longrightarrow$ is free: $F_5\in\operatorname{im}\mu_K$ implies $F_5\perp(\operatorname{im}\mu_K)^{\perp_T}\supseteq\mathrm{ANN}$, using only §3's free inclusion.
- $\Longleftarrow$ requires $\mathrm{ANN}=(\operatorname{im}\mu_K)^{\perp_T}$, hence §3's Reynolds upgrade. And $\Longleftarrow$ is precisely the direction [L62](../findings/sym3-blocks.md#L329) and [L90](../findings/sym3-blocks.md#L207) use, where $F_5(W_0)=0$ is turned into $F_5\in\operatorname{image}$.

So the absent step is not decorative: it carries exactly the implication the certificate route lives on. **Second half: valid**, on the same footing as the first.

## 5. A consistency check the record supplies, and which the derivation predicts

$\mathrm{ANN}$ is asserted at L62 to be spanned by $\mathcal A(W_0^6)$, the $O(5)$-average of $\ell_{W_0}^6$. The derivation predicts both that this lies in $\mathrm{ANN}$ and that $F_5\perp$ it reduces to $F_5(W_0)=0$, and it does:

- By the reproducing property, $\mathrm{Cat}_{\ell_v^6}(B_1,B_2)=\langle\ell_v^6,B_1B_2\rangle_6=(B_1B_2)(v)=B_1(v)B_2(v)$. Averaging, $\mathrm{Cat}_{\mathcal A(W_0^6)}(B_1,B_2)=\int B_1(gW_0)B_2(gW_0)\,dg$, which vanishes for $B_1,B_2\in K$ because cubics of $K$ vanish on the whole orbit. So $\mathcal A(W_0^6)\in\mathrm{ANN}$.
- $\mathcal A(W_0^6)\neq0$, since $\langle\mathcal A(W_0^6),\lVert W\rVert^6\rangle_6=\int\lVert gW_0\rVert^6dg=1$.
- $\langle F_5,\mathcal A(W_0^6)\rangle_6=\int F_5(gW_0)\,dg=F_5(W_0)=0$ by invariance of $F_5$ and its vanishing at $W_0$.

Every one of these three uses the reproducing property, i.e. the apolar reading; none is available under a generic inner product on $T$. This is the sharpest internal evidence that the record's unnamed $\perp$ is the apolar one.

## 6. The absent step is bypassed in the record's actual configuration

The three lines of §3 are needed for the identity **as a general statement**. They are not needed for anything the record concludes, and I record the squeeze because it changes the risk profile of the gap to zero:

1. $\mathrm{ANN}\subseteq(\operatorname{im}\mu_K)^{\perp_T}$, free (§3).
2. $\dim\mathrm{ANN}\ge1$, by the explicit nonzero witness $\mathcal A(W_0^6)$ (§5).
3. $\mathrm{rank}\le13$, L62's cap, a theorem: $\lVert W\rVert^6\in T$ has value $1$ at $W_0$, so evaluation at $W_0$ is a nonzero functional on $T$; every element of $\operatorname{im}\mu_K$ is a sum of products of two cubics of $K$ and so vanishes at $W_0$; hence $\operatorname{im}\mu_K\subseteq\ker(\mathrm{ev}_{W_0})$, of dimension $13$, and $\dim(\operatorname{im}\mu_K)^{\perp_T}\ge1$.
4. With $\mathrm{rank}=13$ (L62's measured lower bound meeting the cap), $\dim(\operatorname{im}\mu_K)^{\perp_T}=1$, and by (1) and (2) the one-dimensional $\mathrm{ANN}$ **equals** it.

So $\mathrm{ANN}=(\operatorname{im}\mu_K)^{\perp_T}$ holds here by a squeeze that never invokes Reynolds, and $F_5\perp\mathrm{ANN}\Rightarrow F_5\in\operatorname{image}$ follows. The price is that this route inherits L62's measured link, where §3's route is unconditional. The two routes are worth keeping side by side for exactly that reason.

## 7. Hypothesis ledger

| hypothesis | what it carries | stated on the record? |
| --- | --- | --- |
| $\mathrm{Cat}=\mu^*$ under a nondegenerate pairing, up to a uniform nonzero scalar | both halves, entirely | yes, [results.md:619](../results.md#L619) displays it; [conventions.md](../findings/conventions.md#L45) tables it |
| the pairing is the apolar one, positive definite, $O(5)$-invariant, reproducing | fixes what $\perp$ means; without it the second half is false in general | **no**, never named; pinned only implicitly at [sym3-blocks.md:253](../findings/sym3-blocks.md#L253) and by L62's use of $F_5(W_0)=0$. L59's Gate 2 note books this as *"the pairing is never named, and that is the defect"* |
| $\mathrm{ANN}$ ranges over the **invariant** sextics | keeps $\mathrm{ANN}\subseteq T$, so that $14-\dim\mathrm{ANN}$ is meaningful | yes at [results.md:619](../results.md#L619) and [conventions.md](../findings/conventions.md#L45); **omitted** at [sym3-blocks.md:257](../findings/sym3-blocks.md#L257)'s third bullet, already booked twice |
| $\mathrm{rank}$ means $\mathrm{rank}(\mu_K)$, the restricted map | the identity; under the unrestricted reading $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ and the identity would be false by $1$ | **partly**, the record slides between the two maps within L59, which its Gate 2 note names; the restricted reading is forced by $K$-dependence of $\mathrm{ANN}$ and by L62's $13$ |
| $K$ is an $O(5)$-submodule of $U$ | §3's upgrade step; also the well-posedness of $\varphi$ | yes, [sym3-blocks.md:234](../findings/sym3-blocks.md#L234) |
| $F$ invariant $\Rightarrow\mathrm{Cat}_F$ invariant, plus Reynolds on $\mathrm{Sym}^2K$ | the reverse inclusion in §3, hence $\Longleftarrow$ in §4 | **no**, named as absent in L59's Gate 2 note (*"needs equivariance plus isotypic pairing. Two lines"*), never supplied. The Reynolds operator itself is on the record at [L89](../findings/sym3-blocks.md#L168) |
| $\dim T=14$ | the numeral in both halves | yes, [L85](../findings/sym3-blocks.md#L68), imported into L59 without attribution |
| $F_5\in T$ | the second half is otherwise vacuous | implicit; never stated, and immediate |

**What the sentence does *not* need**, worth recording because it is where the file's known weakness sits: neither half consumes the $36$, the $29$, the $65$, or any entry of [L83](../findings/sym3-blocks.md#L15)'s multiplicity column. The bolded sentence is insulated from the blind spot both L83 and L86 audits identify, the killer witness that swaps the two dimension-$35$ blocks leaves $14$ untouched. Only $\dim T=14$ enters, and that is a separate Weyl-integration count.

## 8. Readings adopted where the record admits two

| ambiguity | readings | adopted, and why |
| --- | --- | --- |
| $\mathrm{rank}$ | $\mathrm{rank}(\mu_K)$ from the $36$ to the $14$; or $\mathrm{rank}(\mu\vert_{\mathrm{inv}})$ from the $65$ | the restricted one. $\mathrm{ANN}$ is defined through $K$, so the unrestricted reading gives $14=14-1$, false; and L62 reads $13$ off this identity |
| $\perp$ | apolar; or any other inner product on the $14$ | apolar, forced, since $\mathrm{ANN}$ is defined by the adjoint of $\mu$ for that pairing (§2) |
| $K$ | cubics vanishing on the whole orbit ($4200$); or cubics vanishing at $W_0$ ($7769$) | the orbit reading, the only $O(5)$-stable one and the only one consistent with the file's $3570$ and $4200$ |
| $\operatorname{image}$ | $\mu_K(S)$ with invariant Gram; or $\mu(\mathrm{Sym}^2K)\cap T$ | immaterial: for invariant $F$ the two coincide, by averaging a preimage against the equivariance of $\mu$. Worth stating because it also shows restricting the certificate to invariant Grams loses nothing, PSD-ness surviving the average |

## 9. The strongest defence of the step, stated plainly

The sentence is one line of linear algebra dressed as two claims, and the line is correct. Multiplication $\mu$ has an adjoint; that adjoint is the catalecticant; a subspace of a definite inner-product space is the double perp of its own annihilator. Everything else is bookkeeping about which of four spaces each object sits in. The two claims are the corank identity and the double-perp identity for one and the same subspace $\operatorname{im}\mu_K\subseteq T$, and they are the same fact read twice, which is why the record can state them in one breath.

The one place a reader can lose the argument is the passage from "annihilates the invariant Grams" to "annihilates $K\times K$", because $\mathrm{ANN}$ is defined by the second condition and the rank is governed by the first. The defence is that the gap closes on invariance alone: an invariant functional cannot see anything a Reynolds average destroys. The record has the submodule property and it has the Reynolds operator, in the same file; it has simply never joined them.

Two things the sentence would be improved by, neither of which changes a number: naming the apolar pairing at the point $\perp$ first appears, and writing $\mu_K$ rather than $\mu$ where the restricted map is meant. Both are already booked in L59's Gate 2 note, and this adjudication adds nothing to that list except the observation of §6, that the missing three lines are not on any live dependency path, because the record's own squeeze reaches $\mathrm{ANN}=(\operatorname{im}\mu_K)^{\perp}$ without them.

## 10. Where it would fail

For completeness, the three ways this sentence could have been false, none of which obtains:

- if $\perp$ were meant in a non-apolar inner product on the $14$, then $\mathrm{ANN}^\perp$ is a different $13$-space and the second half is false. Excluded by §2 and §5.
- if $\mathrm{ANN}$ ranged over all sextics rather than the invariant ones, then $\dim\mathrm{ANN}\gg14$ and $14-\dim\mathrm{ANN}$ is negative. Excluded by the sentence's own wording, which carries "the $O(5)$-invariant sextics"; the variant at [sym3-blocks.md:257](../findings/sym3-blocks.md#L257) that drops the word is the one already booked as false as literally written.
- if $\mathrm{Cat}_F$ annihilating the invariant Grams failed to force $\mathrm{Cat}_F(K,K)=0$, then the identity degrades to the free inequality $\mathrm{rank}\le14-\dim\mathrm{ANN}$ and the second half loses its $\Longleftarrow$. Excluded by §3, and separately bypassed by §6.

`DONE VALID AS WRITTEN`
