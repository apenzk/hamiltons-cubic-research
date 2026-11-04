# Verifier v66, L62's cap $\mathop{\mathrm{rank}}\le13$, the two sampling inequalities, $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,A(W_0^6)$, $F_5\perp\mathrm{ANN}$, and "at four primes"

The brief was cold: I worked from the two written forms of L62 ([results.md:629](../results.md) and [sym3-blocks.md:346](../findings/sym3-blocks.md)), from L59's setting as it stands in [results.md:619](../results.md), and from the definitions at source in [sym3-blocks.md](../findings/sym3-blocks.md) and the pipeline files. **I ran nothing.** Every value in this report is exact and was either derived by hand from the record's own spectra or read off a file already on disk; the one file I opened programmatically was a stored row dump, and only for its `rows`/`shape`/`prime` metadata, which is reading the record rather than computing on it. Log: [agent_logs/verify-L62-v66.log](../agent_logs/verify-L62-v66.log).

## Claim table

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | Hypothesis inventory complete and each hypothesis used | **HYPOTHESIS-DEBT** | L62 uses L85, L86, an unnamed pairing and a reproducing property, citing none; it imports L59 whole and uses one clause of it |
| 2 | The cap: $\mathop{\mathrm{rank}}(\mu_K)\le13$ | **CONFIRMED** | image lies in $\ker\mathrm{ev}_{W_0}$, a hyperplane in L85's $14$; needs L86 for the odd blocks |
| 3a | Sampled rank $\le$ true rank; $\mathop{\mathrm{rank}}_p\le\mathop{\mathrm{rank}}_{\mathbb Q}$ | **CONFIRMED** | both directions right, both consumed the right way round |
| 3b | "a rank computed from a sample of $K$" | **REFUTED AS STATED** | the sample is $40$ evaluation points, not a subspace of $K$; the direction survives either reading |
| 4 | $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ | **CONFIRMED AS ALGEBRA** + **HYPOTHESIS-DEBT** | rank-nullity gives it for $F\mapsto\mathrm{Cat}_F|_{K\times K}$; identifying that rank with $\mathop{\mathrm{rank}}(\mu_K)$ needs a nondegenerate pairing on the $14$, and the record names no pairing |
| 5 | $\mathrm{ANN}=\mathbb R\,A(W_0^6)$ | **HYPOTHESIS-DEBT** | membership follows from the reproducing property, which appears only in a reviewer script; $A$ is defined nowhere in the canon and, read literally, is not an invariant sextic |
| 6 | $F_5\perp\mathrm{ANN}$ | **CONFIRMED** conditional on $\dim\mathrm{ANN}=1$ | $F_5(W_0)=\tfrac32-9\cdot\tfrac16=0$ exactly, from the record's own spectrum |
| 7 | "It attains it, at four primes" | **CONFIRMED** | four dumps at primes near $2^{40}$, each from a run asserting the restricted rank is $13$, re-ranked independently in [r214](../reviews/REVIEW_r214.md); **this overturns the standing "unsupported" finding of [r633](../reviews/REVIEW_r633.md)** |
| 8 | Nothing cites L62 above what its proof reaches | **CONFIRMED AS ALGEBRA** | the squeeze is a proof; its live input is a machine rank, and [results.md:23](../results.md) calls it "proofs rather than measurements" without saying so |

## One-line summary

**L62 is correct in every step I could check, and its "four primes" (the one numeric claim the record has on file as unsupported), is in fact supported at four dumped primes near $2^{40}$; what L62 owes is not an inequality but four unwritten hypotheses, of which the load-bearing one is that the pairing carrying $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ is nondegenerate on the $14$.**

## 0. Conventions, fixed once

Quoted from the brief and from the record, not restated in my own words.

- $\mathcal W_5$ is the space of algebraic Weyl curvature operators at $n=5$, the $O(5)$-irreducible $[2,2]$ of dimension $35$ ([sym3-blocks.md](../findings/sym3-blocks.md), "The Weyl module and the group action").
- $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$.
- $W_0$ is the zero-padding into $\mathcal W_5$ of the $\mathbb{CP}^2$ Weyl operator. As an operator on $\Lambda^2\mathbb R^5$ its spectrum is $(2,-1,-1,0^7)/\sqrt6$, the value [sym3-blocks.md](../findings/sym3-blocks.md) records at "What the certificate would establish", so $\lVert W_0\rVert^2=(4+1+1)/6=1$ and $\mathop{\mathrm{tr}}(W_0^3)=(8-1-1)/6^{3/2}=1/\sqrt6$. I use these two numbers repeatedly and they are exact.
- $K$ is "the span of cubics cut out by the orbit constraint" (L59). At source the constraint is $\sigma_\lambda(W_0)=0$, imposed **on the copy index alone**: [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) builds $T$ block by block killing one multiplicity in each $\lambda_2$-even block and keeping every $\lambda_2$-odd block whole. **I adopt the reading $K=C^\perp$ with $C=\mathop{\mathrm{span}}\{(gW_0)^3\}$**, equivalently $K=\{q\in\mathrm{Sym}^3\mathcal W_5^*: q\equiv0\text{ on }O(5)\cdot W_0\}$; the record admits also the reading "$q(W_0)=0$ at the single point $W_0$", and the two agree by the submodule argument recorded under L90 (the restriction cuts the copy index and leaves $V_\lambda$ whole).
- $\mu$ is multiplication $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$; $\mu_K$ is its restriction to $(\mathrm{Sym}^2K)^{O(5)}$. $\mathrm{Cat}_F$ is the adjoint, $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$.
- $\mathrm{ANN}=\{F\in(\mathrm{Sym}^6\mathcal W_5)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$, a subspace of L85's $14$.
- $A(\cdot)$: the brief says "the apolarity/dual pairing's image of a power". The only operative definition in the record is in [claim4_f5_at_w0.py](../scripts/reviewers/r210/claim4_f5_at_w0.py): $\langle F,A(W_0^6)\rangle$ is proportional to $F(W_0)$. **I adopt that reading** ($A(W_0^6)$ is the representative of evaluation at $W_0$) and §5 records what breaks under the literal one.
- "restricted rank" I read as $\mathop{\mathrm{rank}}(\mu_K)$ throughout; §4 checks that against L59's "rank".

## Hypothesis inventory

### Carried by L62, and used

| # | Hypothesis | Where it enters | Stated in L62? |
|---|---|---|---|
| H1 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ (L85) | the target space, and $13=14-1$ | no, imported uncited |
| H2 | $\lVert W_0\rVert\ne0$, so $\mathrm{ev}_{W_0}$ is nonzero on the $14$ | the cap | yes, as "$\lVert W\rVert^6$ is $1$ there" in the Gate-2 note; the block itself only asserts nonzero |
| H3 | Every $q\in K$ vanishes at $W_0$ | the cap | asserted; true by construction on the $16$ even blocks, and on the $8$ odd blocks **only because $\dim V_\lambda^H=0$ for $\lambda_2$ odd** (L86) |
| H4 | $K$ is an $O(5)$-submodule | needed for $P_{\mathrm{inv}}\mu(\mathrm{Sym}^2K)=\mu((\mathrm{Sym}^2K)^{O(5)})$, i.e. for ANN to be computed from the invariant part alone | no |
| H5 | The pairing carrying $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ is nondegenerate on the $14$ | $\mathop{\mathrm{rank}}(\mu_K)=14-\dim\mathrm{ANN}$ | no, the pairing is never named anywhere in the canon |
| H6 | The pairing is reproducing: $\langle G,A(v^6)\rangle\propto G(v)$ | $A(W_0^6)\in\mathrm{ANN}$, and $F_5\perp A(W_0^6)$ | no, only in [claim4_f5_at_w0.py](../scripts/reviewers/r210/claim4_f5_at_w0.py) |
| H7 | $F_5(W_0)=0$ | $F_5\perp\mathrm{ANN}$ | no, it sits in L61 and in the scripts |
| H8 | The multiplicity copies are identified **equivariantly** in the sampled rows | the sampled rank is $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu_K)$ at all; r209's $S_3$ counterexample gives sampled rank $10$ against a cap of $7$ without it | no |
| H9 | The sampled matrix is $p$-integral, so its reduction is the reduction of something | $\mathop{\mathrm{rank}}_p\le\mathop{\mathrm{rank}}_{\mathbb Q}$ | no, guarded only by asserts inside [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) |

### Carried, and not used

- **L59's "$\mathrm{Cat}$ is injective on the invariant sextics because $\mu$ is surjective".** L62's chain never needs it; injectivity places the $14$ inside the $65$, which serves L59's own $65=36+29$ count and nothing in L62. **A hypothesis imported and unused is a finding under the brief's own item 1, and this is one.**
- **L59's $65=36+29$.** Same: it is L59's necessary-condition count, and L62 consumes only $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$.
- **L87's rank-one step and the $36$ unknowns.** §2 and §3 show both halves of L62 survive intact if some even block had evaluation rank $0$: the cap holds a fortiori, and the sampled rank stays a lower bound because a wrong-but-smaller restriction samples a subspace of $K$. L87 is load-bearing for "$36-13=23$", not for L62's stated conclusion. **The record nowhere separates these**, and [INDEX-results.md](../findings/INDEX-results.md) records the chain L87 → L59 → L62 as carrying two measured links, which overstates L62's dependence.
- **$\mathcal W_5^H=\mathbb R W_0$.** Used only for the unimprovability remark (order-$2$ vanishing is free), not for the cap.

### A step using a hypothesis nobody stated

H5 and H6 are the two. H6 is the sharper omission: without "the pairing is reproducing", neither "$A(W_0^6)\in\mathrm{ANN}$" nor "$F_5\perp A(W_0^6)$ because $F_5(W_0)=0$" is a step at all, they are assertions relating two unconnected objects.

## 1. The cap, CONFIRMED

The written step is: *evaluation at $W_0$ is a nonzero functional on the $14$ invariant sextics and every product of two cubics of $K$ vanishes there, so the restricted rank is at most $13$.*

It closes, in this order. The map is $\mu_K\colon(\mathrm{Sym}^2K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, and both the domain's invariance and the target's follow from equivariance of $\mu$. $\lVert W\rVert^6$ is an $O(5)$-invariant sextic with value $\lVert W_0\rVert^6=1$, so $\mathrm{ev}_{W_0}$ is a nonzero functional on the $14$ and $\ker\mathrm{ev}_{W_0}$ has dimension $13$. Every $B\in\mathrm{Sym}^2K$ is a sum of products $q_1q_2$ with $q_i\in K$, and $q_i(W_0)=0$, so $\mu(B)(W_0)=0$; hence $\mathop{\mathrm{im}}\mu_K\subseteq\ker\mathrm{ev}_{W_0}$ and $\mathop{\mathrm{rank}}\mu_K\le13$. **Six lines, no measurement, and the target is exactly the $14$ the rank is measured in.**

Two things the written form leaves out and I had to supply from elsewhere in the record to make the step true:

- **H1.** "$13$" is $14-1$ and the $14$ is L85's. L62 cites nothing.
- **H3 on the odd blocks.** $K$ as constructed keeps every $\lambda_2$-odd block **entire**, with no condition imposed. Those cubics vanish at $W_0$ only because the $\lambda$-component of $W_0^3$ lies in $V_\lambda^H$ and $\dim V_\lambda^H=0$ when $\lambda_2$ is odd, **L86's parity rule, which L62 does not cite**. Had the parity rule gone the other way, $K$ would contain cubics not vanishing at $W_0$ and the cap would be false. This is the one place where an uncited import is genuinely load-bearing for the *proved* half.

The Gate-2 note's extra claim, that the cap is unimprovable by higher-order vanishing, also checks: [run_n5_order2.py](../scripts/runs/run_n5_order2.py) proves that for $x\ne0$ in an orthogonal $G$-representation with $V^{\mathrm{Stab}(x)}=\mathbb Rx$, any $\mathrm{Stab}(x)$-invariant homogeneous $p$ with $p(x)=0$ has $\nabla p(x)=0$, equivariance puts $\nabla p(x)$ in $V^H$ and Euler makes the coefficient $d\,p(x)/\langle x,x\rangle=0$. Degree, $O(5)$-invariance and $\lVert W_0\rVert=1$ all do no work there, which is the correct sharp form.

## 2. Every inequality's direction, CONFIRMED, and what the sample is OF, REFUTED AS STATED

**Sampled versus true.** The measured object is a $40\times47$ matrix whose row $t$ carries the $47$ real Hermitian coordinates of the restricted Gram at the sample point $W_t$; I read the row count, the column count and the block shape straight off the stored dumps, which carry `shape` $=[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$, $16$ blocks, $\sum m=25$, $\sum m^2=47$. Its rank is $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu_K)$ where $\mathrm{ev}$ evaluates at those $40$ points. Post-composition can only lose rank, so $\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu_K)\le\mathop{\mathrm{rank}}(\mu_K)$. **Sampled bounds the true from below.** Both written forms say this, in opposite phrasings that mean the same thing ("bounds the true rank from below" (Form A) and "is bounded above by the true one" (Form B)) and both are right.

**Mod $p$ versus characteristic zero.** For a $p$-integral matrix, a nonzero $k\times k$ minor mod $p$ lifts to a nonzero minor over $\mathbb Q$, so $\mathop{\mathrm{rank}}_p\le\mathop{\mathrm{rank}}_{\mathbb Q}$. **Reduction can only lower.** Written correctly.

**The squeeze consumes both the right way round:** $13=\mathop{\mathrm{rank}}_p(\mathrm{ev}\circ\mu_K)\le\mathop{\mathrm{rank}}_{\mathbb Q}(\mathrm{ev}\circ\mu_K)\le\mathop{\mathrm{rank}}(\mu_K)\le13$. Attainment forces equality. No inequality is reversed.

### Discrepancy 2.1, "a sample of $K$" names an object the run never forms

1. **Located.** [results.md:629](../results.md): *"A rank computed from a sample of $K$ bounds the true rank from below."*
2. **The failure, concretely.** The run samples $40$ Weyl tensors, [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) draws integer coordinate vectors in $\{-4,\dots,4\}^{35}$ under a fixed seed and pushes them through the module map, and evaluates the whole restricted Gram at each. Nothing anywhere samples a subspace of $K$; $K$ enters through the exact linear restriction $T$, applied in full. A reader auditing "a sample of $K$" would look for a spanning set of cubics and find a list of tensors.
3. **The opposite.** The most charitable reading is that "sample of $K$" is shorthand for "a sample of the system that $K$ cuts out", and under it the inequality still runs the right way, restricting the domain to a subspace also loses rank. **So the conclusion is untouched and this is a defect of description, not of derivation.** Form B in [sym3-blocks.md:346](../findings/sym3-blocks.md) avoids it by saying only "a sampled rank", which is the accurate wording; the canon carries the inaccurate one.

## 3. $\dim\mathrm{ANN}=1$ from rank $=13$, CONFIRMED AS ALGEBRA, with one debt

$\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ has two readings and they need different amounts of work.

- **As rank-nullity.** Let $\Psi\colon(\mathrm{Sym}^6)^{O(5)}\to(\mathrm{Sym}^2K)^*$ send $F$ to $\mathrm{Cat}_F|_{K\times K}$. Then $\ker\Psi=\mathrm{ANN}$ by definition and $\mathop{\mathrm{rank}}\Psi=14-\dim\mathrm{ANN}$ with no hypothesis at all. **Under this reading the identity is a tautology.**
- **As a statement about $\mu_K$**, which is what L62 needs, since $13$ is measured on $\mu_K$. Then $\mathop{\mathrm{rank}}\Psi=\mathop{\mathrm{rank}}(\mu_K)$ requires two things: that the pairing restricted to the $14$ be nondegenerate (H5), and that the invariant projection commute with $\mu$ so that pairing invariant sextics against $\mu(\mathrm{Sym}^2K)$ sees exactly $\mu((\mathrm{Sym}^2K)^{O(5)})$ (H4).

**H4 holds** and I checked it: $K$ is built as $\bigoplus_\lambda M'_\lambda\otimes V_\lambda$ with $M'_\lambda\subseteq M_\lambda$ a multiplicity subspace, so it is an $O(5)$-submodule, and the invariant projection is equivariant.

### HYPOTHESIS-DEBT 3.1, the pairing is never named, and the identity needs it nondegenerate on the $14$

1. **Located.** [results.md:619](../results.md), *"Apolarity, $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, gives $\mathrm{rank}=14-\dim\mathrm{ANN}$"*, and [results.md:629](../results.md) consuming it.
2. **The failure.** $\langle\cdot,\cdot\rangle$ appears on both sides as an undefined symbol on two different spaces. If it were degenerate on the $14$ (a degenerate invariant symmetric form on a real $14$-dimensional space is not an exotic object) then $\mathop{\mathrm{rank}}\Psi$ and $\mathop{\mathrm{rank}}(\mu_K)$ would differ by the dimension of the radical, and the measured $13$ would not transfer to $\dim\mathrm{ANN}=1$.
3. **The opposite.** The scripts pair through their own `ip3` product, so the intended object is identifiable from the code; and the record's phrase "apolarity" points at a specific classical form. **But identifying it from code is not the record stating it**, and this is the one gap where supplying the missing sentence would change a verdict rather than a wording. **What would have to be written and proved: that the pairing intended by "apolarity" is nondegenerate on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$.** I do not supply it.

## 4. Is "restricted rank" one number?, CONFIRMED, with one reconciliation the record does not make

Four quantities in [sym3-blocks.md](../findings/sym3-blocks.md) are called "rank":

| name | map | value | status |
|---|---|---|---|
| L89's $\mathop{\mathrm{rank}}(\mu\vert_{\mathrm{inv}})$ | unrestricted, $65\to14$ | $14$ | theorem (exactness of invariants) |
| L62's, L59's, L90's restricted rank | $\mu_K$, $36\to14$ | $13$ | cap proved, value measured |
| L91's "open in $[1,13]$" | the same $\mu_K$ | open | superseded stratum, never retracted |
| the sampled $\mathop{\mathrm{rank}}(A)$ | $\mathrm{ev}\circ\mu_K$, $47\to40$ | $13$ | measured |

L59's "rank" and L62's "restricted rank" are the same number, and the sampled rank is a lower bound for it. **The reconciliation the record omits is between the $47$ Hermitian columns actually measured and the $36$ real unknowns L59 counts**: they agree because the $47-36=11$ antisymmetric invariant directions map to the zero sextic (L88's "gauge"), so the sampled matrix has rank at most $36$ and its rank is the rank of the induced map on the real $36$. Even if L88's identification of *which* $11$ were wrong, [r204](../findings/sym3-blocks.md) refutes the labelling and leaves the count, the inequality that L62 consumes is unaffected, because a rank measured on a larger coordinate set is still a lower bound for $\mathop{\mathrm{rank}}(\mu_K)$.

## 5. $\mathrm{ANN}$ spanned by $A(W_0^6)$, HYPOTHESIS-DEBT

Two claims, and they need different things.

**Membership.** $\mathrm{Cat}_{A(W_0^6)}(q_1,q_2)=\langle A(W_0^6),\mu(q_1\odot q_2)\rangle=(q_1q_2)(W_0)=q_1(W_0)q_2(W_0)=0$ for $q_i\in K$. **This does follow from the cubics of $K$ vanishing at $W_0$**, and note it gives vanishing on all of $K\times K$, not merely on the invariant part, so it is stronger than the definition of ANN demands. It uses H6 and nothing else. Nonvanishing of $A(W_0^6)$ is H2 again.

**Spanning.** This is $\dim\mathrm{ANN}=1$, which is the measured half in its entirety. Nothing proved gives it.

### HYPOTHESIS-DEBT 5.1, $A$ is defined nowhere in the canon, and the literal reading puts it outside the space

1. **Located.** [results.md:206](../results.md) and [results.md:629](../results.md), "spanned by $A(W_0^6)$"; [sym3-blocks.md:227](../findings/sym3-blocks.md), $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$. Neither [results.md](../results.md) nor [findings/](../findings/) defines $A$ or $\mathcal A$.
2. **The failure, concretely.** Read literally as the symmetrised sixth power of $W_0$, $A(W_0^6)$ is fixed only by $H=\mathrm{Stab}_{O(5)}(W_0)$, whose identity component is $U(2)\subset SO(4)$, it is **not** $O(5)$-invariant, so it is not an element of the $14$, and "$\mathrm{ANN}=\mathbb R\,A(W_0^6)$" equates a subspace of the $14$ with the span of something outside it. The object that is in ANN is its $O(5)$-average, equivalently the representative of $\mathrm{ev}_{W_0}$ under the pairing.
3. **The opposite.** The charitable reading, the one [claim4_f5_at_w0.py](../scripts/reviewers/r210/claim4_f5_at_w0.py) uses, "$\langle F,A(W_0^6)\rangle$ proportional to $F(W_0)$", makes every sentence true, because averaging changes nothing about the functional it induces on invariant sextics. **So the mathematics is fine and the notation is undischarged.** What would have to be written: a definition of $A$, and the reproducing property H6.

## 6. $F_5\perp\mathrm{ANN}$, CONFIRMED, conditional on the measured half

$F_5\perp A(W_0^6)$ reduces by H6 to $F_5(W_0)=0$, and that I checked in closed form from the record's own spectrum, with no computation: $\lVert W_0\rVert^2=(4+1+1)/6=1$ and $\mathop{\mathrm{tr}}(W_0^3)=(8-1-1)/6^{3/2}=1/\sqrt6$, so
$$F_5(W_0)=\tfrac32\cdot1^3-9\cdot\tfrac16=\tfrac32-\tfrac32=0 .$$
The same number in the certificate's flat-tensor normalisation is $\tfrac32(4\cdot6)^3-9(8\cdot6)^2=20736-20736=0$, which is the identity $96t^3=576t^2$ at $t=6$ that [claim4_f5_at_w0.py](../scripts/reviewers/r210/claim4_f5_at_w0.py) records. **Both normalisations give zero, exactly, and the agreement is degree-$6$ homogeneity rather than a coincidence.**

Passing from $F_5\perp A(W_0^6)$ to $F_5\perp\mathrm{ANN}$ is exactly the step that needs $\dim\mathrm{ANN}=1$. **The proved half alone yields only $F_5\perp A(W_0^6)$, which by H6 restates $F_5(W_0)=0$ and carries no information about membership in the image.** The thing $F_5\perp\mathrm{ANN}$ needs about $F_5$ at $W_0$ is stated (in L61 and in the scripts) but not in L62, which is where it is used.

## 7. "At four primes", CONFIRMED, and a standing finding of the record is wrong

This is the item where I differ from the record.

**What is on file.** Four row dumps exist: [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json), [n5_rows_1099511627917.json](../scripts/runs/n5_rows_1099511627917.json), [n5_rows_1099511627933.json](../scripts/runs/n5_rows_1099511627933.json), [n5_rows_1099511627953.json](../scripts/runs/n5_rows_1099511627953.json), all near $2^{40}=1099511627776$. Each holds $40$ rows of $47$ columns with the $16$-block restricted shape, so each **is** the restricted sampled matrix at its prime. Each was written by a run of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) at `N5_PRIME` set to that prime, and that run asserts `rk_A == 13` and `rr <= 13` before the dump. Independently, [REVIEW_r214.md](../reviews/REVIEW_r214.md) tabulates `rank(A)` "mod each of the four primes" as $13,13,13,13$, by its own Gaussian elimination self-tested on planted ranks. Two further primes carry the same rank: $1000033$, the default in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py), and $1000003$, reviewer 209's independent reproduction.

**So "four primes" is supported, and the record could honestly say six.**

### Withdrawn candidate 7.1, "four primes is unsupported"

[r633](../reviews/REVIEW_r633.md) §7 records that *"the four primes near $2^{40}$ belong to the certificate's row lift, a different computation"*, and [INDEX-results.md](../findings/INDEX-results.md) and [results.md](../results.md) carry that verdict. **I withdraw it, and it should be withdrawn from the record.** The row lift and the rank measurement are the same matrix: the lift's inputs are the four dumps, and the dumps are the restricted sampled rows whose rank is asserted to be $13$ at each prime before dumping. The reviewer's inference (that primes named for a lift cannot also be primes of a rank), does not survive reading the producing script.

**The honest caveat, which no site states.** The four primes are four reductions of **one** $40$-point sample under **one** fixed seed, not four independent samples. For the lower bound this is redundancy against an unlucky reduction and nothing more: a single prime already gives $\mathop{\mathrm{rank}}(\mu_K)\ge13$, so the count four is not load-bearing. What the count does not do is broaden the sample, and the phrase "at four primes" invites the reading that it does.

## 8. Quantifier order, scope, and what cites L62 above its reach

- **Scope of the conclusion.** $n=5$ only, and the record says why it does not lift (the Lovelock syzygy makes the cubic invariant space one-dimensional at $n\le5$ and two-dimensional from $n\ge6$). No step of L62 is quantified over $n$.
- **The live half.** $\mathop{\mathrm{rank}}\ge13$, $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R A(W_0^6)$ and $F_5\in\mathop{\mathrm{image}}$ all rest on the sampled mod-$p$ rank. [report/sections/09-status.tex](../report/sections/09-status.tex) now says so ("Cap proven; equality an Observation"), and [results.md:206](../results.md) does not.
- **One phrase reaches past the proof.** [results.md:23](../results.md): *"a sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so L87's rank and L62's value are proofs rather than measurements."* The **shape** of the argument is a proof; its **input** is a machine-computed rank of a machine-built matrix under hypotheses H8 and H9. L62's own closing sentence, *"The argument is exact, the sampling being a lower bound rather than a numerical estimate"*, is true and is doing the work of a stronger sentence, it distinguishes exact from floating-point, and readers take it as distinguishing derived from computed. **Nothing else I found cites L62 above what it reaches.**
- **What L62 does not claim, and correctly.** It settles the linear necessary condition only. A certificate still owes a PSD point in the $23$-dimensional affine family, and L62 nowhere suggests otherwise.
- **Downstream, the dependency runs the way L90's block says it does.** The certificate's identity at $40$ points needs evaluation injective on $\mathop{\mathrm{im}}\mu_K$, which closes as $13\le\mathop{\mathrm{rank}}(\mathrm{ev}\circ\mu_K)\le\mathop{\mathrm{rank}}\mu_K\le13$, L62's cap plus L62's measurement. So **L61, tabled as proven, transitively consumes L62's measured half** unless the record adopts r213's alternative unrestricted route, which is a different measurement rather than an escape from measurement. The two routes are both on file and neither is designated.
- **An incidental, outside L62's scope.** [results.md:23](../results.md) carries the sentence *"L90's stated proof was withdrawn as circular, its repair sitting twelve lines below it"* **twice, consecutively, verbatim**.

## 9. The named traps, each checked

- **$\ker W_0\ne0$.** $W_0$ has spectrum $(2,-1,-1,0^7)/\sqrt6$ on $\Lambda^2\mathbb R^5$, so its kernel is $7$-dimensional, the four padding directions $e_i\wedge e_5$ and the three anti-self-dual directions of $\Lambda^2\mathbb R^4$. I looked for a step that needs invertibility and found none: the cap needs $\lVert W_0\rVert\ne0$; the order-$2$ theorem needs $x\ne0$ and $V^H=\mathbb Rx$; and $H=\mathrm{Stab}_{O(5)}(W_0)$ is computed *with* the padding, its second factor being the reflection on the padding axis. **The padding is used, not assumed away.**
- **Boundary of the range, odd $n$.** $n=5$ is odd and that is used positively: $-I\in O(5)\setminus SO(5)$ acts on a $4$-tensor by $(-1)^4=+1$, so $O(5)$-invariants equal $SO(5)$-invariants in every degree. The same step fails at even $n$, and L62 makes no claim there.
- **A claim proven on a subfamily and cited in general.** The $40$ points are a subfamily and are consumed in the direction a subfamily supports, a lower bound. Correct.
- **A hypothesis stated and never used.** Two: L59's injectivity of $\mathrm{Cat}$ and its $65=36+29$. Recorded in the inventory.
- **A step using a hypothesis never stated.** H4, H5, H6, H8, H9. Recorded.
- **A universal claim with no witness.** §10.
- **An imported theorem whose hypotheses were never checked.** The imports are L85 (Weyl integration), L86 (branching plus the $\mathfrak{su}(2)_R$ Weyl element), and the reproducing property. L86 is the one applied to a padded object: it is applied at $\lambda=(2,2)$, whose $\lambda_2$ is even, giving $\dim\mathcal W_5^H=1$, consistent with $\mathcal W_5^H=\mathbb R W_0$, which [run_n5_order2.py](../scripts/runs/run_n5_order2.py) measures rather than quotes. No import I found assumes a unit, an invertible operator, or a trivial kernel.

## 10. Withdrawn candidates

- **"The mod-$p$ sample lives in characteristic $p$, so it is not the reduction of anything."** This is the defect the record books against L87, whose orbit points are Cayley transforms of skew matrices over $\mathrm{GF}(46337)$. **It does not apply to L62.** [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) draws sample points with integer coordinates in $\{-4,\dots,4\}^{35}$ as exact `Fraction`s, maps them through the module basis over $\mathbb Q$, and reduces; the adapted-basis coefficients are Gaussian rationals with an explicit assert that no denominator is divisible by $p$. **So the matrix reduced is a genuine $p$-integral matrix over $\mathbb Q$ and $\mathop{\mathrm{rank}}_p\le\mathop{\mathrm{rank}}_{\mathbb Q}$ is licensed.** The L87 block's claim that L62 is "identical in shape" to it is wrong on exactly this point, and in L62's favour.
- **"The measured rank is of a $47$-column Hermitian matrix, while L59's rank is of a $36$-dimensional real space."** Withdrawn: §4. Either the $11$ extra directions die (L88) and the ranks agree, or they do not and the measured rank is still a lower bound. The conclusion cannot break here.
- **"$K$ may not be $O(5)$-stable, so ANN cannot be read off the invariant part."** Withdrawn: $K=\bigoplus M'_\lambda\otimes V_\lambda$ is a submodule by construction.
- **"$\pm W_0$ give two obstructions, so $\dim\mathrm{ANN}\ge2$."** Withdrawn: invariant sextics are even and constant on orbits, so $\mathrm{ev}_{-W_0}=\mathrm{ev}_{gW_0}=\mathrm{ev}_{W_0}$ on the $14$ and the two points induce the same functional. I checked the one nearby candidate that could have escaped this: the opposite-orientation $\overline{\mathbb{CP}}^2$ operator is $\mathrm{diag}(-1,1,1,1,1)\cdot W_0$ with $\mathrm{diag}(-1,1,1,1,1)\in O(5)$, so it lies in the same $O(5)$-orbit and gives nothing new either.
- **"The two forms disagree on the direction of the sampling inequality."** Withdrawn: "bounds the true rank from below" and "is bounded above by the true one" are the same statement written from the two ends. Only the *object* sampled differs between them (§2.1).

## Verdict

**L62 as a whole: CONFIRMED AS ALGEBRA, with the value measured, and with five hypotheses that must be written down before the block can be checked as written.**

- The cap $\mathop{\mathrm{rank}}\le13$ is a theorem and I re-derived it; it needs L85 and, on the odd blocks, L86, neither cited.
- Both sampling inequalities point the right way and are consumed the right way round.
- $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ is rank-nullity for $\Psi$ and needs a nondegenerate pairing to become a statement about $\mu_K$, the one debt that could change a number.
- $A(W_0^6)\in\mathrm{ANN}$ and $F_5\perp A(W_0^6)$ both follow, from a reproducing property that lives only in a reviewer script; $F_5(W_0)=0$ is exact in both normalisations and I verified it by hand.
- "At four primes" is **supported**, at four dumped primes near $2^{40}$ plus two more; the record's standing finding to the contrary should be withdrawn, and the caveat that should replace it is that the four are one sample reduced four ways.

## What a counterexample would look like, and what I did to find one

**A falsifier is a second invariant sextic in $\mathrm{ANN}$**, an $F\in(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, not proportional to the representative of $\mathrm{ev}_{W_0}$, whose catalecticant kills $K\times K$; equivalently, whose $\mathrm{Cat}_F$ is supported on $C=\mathop{\mathrm{span}}\{(gW_0)^3\}$. It would make $\dim\mathrm{ANN}\ge2$, drop the rank below $13$, and (unless $F_5$ happened to be orthogonal to it too), kill the necessary condition and the certificate route with it.

**In the special form the record already reaches for**, a falsifier is a $v\in\mathcal W_5$ with $A(v^6)\in\mathrm{ANN}$ and $A(v^6)$ not proportional to $A(W_0^6)$. By H6 that is exactly $q(v)=0$ for every $q\in K$, i.e. $v^3\in C$, i.e., using the record's own reproducing identity $\Delta_K+\Delta_C=\lVert W\rVert^6$ from L91's aside, the closed condition
$$\Delta_K(v)=0,\qquad\text{equivalently}\qquad \Delta_C(v)=\lVert v\rVert^6 ,$$
with $v\notin O(5)\cdot\{\pm W_0\}$ and $v$ not a scalar multiple of a point of that orbit.

**What I did.** I tested the structured families the record names, by hand and in closed form, for membership in the orbit cone rather than by any numerical evaluation:

- **$\mathbb{CP}^2$, both orientations, and the whole cone $t\,gW_0$.** All collapse into the one orbit: the orientation flip is realised by $\mathrm{diag}(-1,1,1,1,1)\in O(5)$, and $A((tgW_0)^6)=t^6A((gW_0)^6)$ induces $t^6\mathrm{ev}_{W_0}$ on the $14$. **No second obstruction here, and this is the family a falsifier would most plausibly have come from.**
- **$-W_0$.** Same functional on the $14$, sextics being even.
- **Padded diagonal points, the maximal torus of $\mathfrak{so}(4)\subset\mathfrak{so}(5)$, and the $n=5$ sphere product $S^2\times S^3$.** For each the falsifier test is $\Delta_K(v)=0$, a single exact rational number per point. **Deciding it needs the $4200$-dimensional projection, which is a run, and this task carries no computation approval, so I neither exhibit nor exclude a falsifier in these families, and I record the block rather than working around it.** Naming what such a run would decide: $\Delta_K(v)\ne0$ at a point removes it as a falsifier; $\Delta_K(v)=0$ off the orbit refutes $\dim\mathrm{ANN}=1$ outright.
- **General $F$, not of the form $A(v^6)$.** The record's only argument here is L91's transversality count, $14+29-65<0$, which says a second coincidence is non-generic and is not a proof that none occurs. **I found no argument on file that $\dim\mathrm{ANN}\le1$, and record that as the honest state: the upper bound on $\dim\mathrm{ANN}$ is the machine rank and nothing else.**
