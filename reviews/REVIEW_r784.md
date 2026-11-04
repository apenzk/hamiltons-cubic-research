# Gate 2 review r784, L184's strengthened statement, and case 1's Weyl-free route

*Cold brief: I worked from [BRIEF-g2-l184b.md](BRIEF-g2-l184b.md) and nothing else, and did not open [findings/](../findings/) for the answer. **No numerical work was done in the sense the standing rule reserves**, no search, no sweep, no census, no optimisation, no falsifier hunt. Every derivation below is closed form and every value exact. **One screen** was run, about a second of exact integer arithmetic on four $2$-forms I wrote down myself, to re-check the sign bookkeeping I had already done by hand on the block's three-matchings witness and on the star identity; it is reported as a screen in section 11 and is cited for nothing positive. Log: [agent_logs/g2-l184b-r784.log](../agent_logs/g2-l184b-r784.log).*

## The claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | The strengthened statement is what the three cases establish | **TRUE OF THE ARGUMENT IN THE BOX; FALSE OF THE PRINTED CASE 1** |
| 1b | Case 2 free of every Weyl condition | **FREE** |
| 1c | Case 3 free of every Weyl condition | **FREE** |
| 1d | The setup free of every Weyl condition | **FREE** |
| 2 | Case 1's new route: $s_{ij}s_{ik}$ well defined | **WELL DEFINED, AND THE STEP IS ORIENTATION-INVARIANT** |
| 2b | Independence of $i$, and that it gives $\omega_i=\eta_i\omega_1$ | **DERIVED FROM SCRATCH; EXACTLY THAT, NOTHING WEAKER** |
| 2c | The constant $\mp2$ | **CORRECT** |
| 3 | The common mechanism $\omega_i=\pm\omega_1$ holds in case 3 too | **TRUE, AND THE BLOCK'S OWN CASE 3 NEVER SAYS IT** |
| 4 | Dropping the Weyl hypothesis leaves the corollary intact | **INTACT; ONE BRIDGE LIES OUTSIDE THE BRIEF** |
| 5 | Case 1 no longer appeals to the premise | **THE BOXED ROUTE DOES NOT; THE PRINTED CASE 1 STILL DOES** |
| 6 | Any parity restriction anywhere | **NONE, NOT IN THE PREMISE, NOT IN THE NEW ROUTE, NOT ANYWHERE** |
| 7 | Case 2's identity is a $\dim V=6$ fact, and no step confuses $\dim V$ with $n$ | **CORRECT ON BOTH COUNTS** |
| 7b | The stated reason $\epsilon_J$ is well defined | **RIGHT CONCLUSION, WRONG GROUP NAMED** |
| 8 | No step assumes the triple spans more than it does | **NONE DOES** |
| 9 | The three cases are exhaustive for the strengthened statement | **EXHAUSTIVE, AND THE SPLIT NEVER USED A WEYL TENSOR** |
| 10 | Overreach beyond what the cases reach | **ONE SENTENCE, ABOUT $\dim V\ge8$** |
| 10b | Case 3's "$\sigma_i=\tau_i$ outright" | **CONVENTION-DEPENDENT; THE CONCLUSION SURVIVES EITHER WAY** |
| (| **The strengthened statement itself** | **TRUE, AND ITS PROOF IS ON FILE), IN THE WRONG PLACE** |

**Actionable in one line:** move the boxed orthogonality route into case 1's body and delete case 1's last sentence, which still appeals to the premise and still concludes "$W=0$", so that the block stops contradicting its own headline; then soften the $\dim V\ge8$ sentence, which as written invites a reading the three cases do not reach.

## 0. Conventions, fixed once

I use the brief's normalisation and nothing else.

- A $2$-form and a real skew matrix are one object, under $f_a\wedge f_b\mapsto E_{ab}-E_{ba}$; $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$ and $\langle\alpha,\beta\rangle=-\tfrac12\mathop{\mathrm{tr}}(\alpha\beta)$. Orthonormality of the triple is therefore $\mathop{\mathrm{tr}}(\omega_i\omega_j)=-2\delta_{ij}$.
- **Support** of $\omega$ is the image of its matrix. $V$ is the common support, $\dim V=6$, so each $\omega_i$ has rank $6$ and $\ker\omega_i=V^\perp$ for all three.
- $\varepsilon_P$ is a unit area form of an oriented plane $P$: $\varepsilon_P^2=-\mathrm{Id}_P$, $\mathop{\mathrm{tr}}(\varepsilon_P^2)=-2$.
- A **complex structure** on a Euclidean space means skew with $J^2=-\mathrm{Id}$; orthogonality then follows from $J^{\mathsf T}J=-J^2=\mathrm{Id}$.
- $\star$ always means the Hodge star **of $V$**. Section 7 is about why that matters.
- **None of $\sqrt{3/2}$, $6+2\sqrt7$ or the range "even $n\ge12$" is used anywhere in the block or in the premise.** The brief asked me to say so if one appeared. One appears as text and not as a step: the anchor text of the link to L178 inside the premise's supporting prose contains $\Theta\le\sqrt{3/2}$. It is a title, no argument reads it, and I record it only because the instruction was literal.

## The hypothesis inventory

**Used, and stated.**

- *Orthonormality of $\omega_1,\omega_2,\omega_3$.* Carries $\mathop{\mathrm{tr}}A=2$, and is the whole contradiction in case 1's new route and in case 3. In case 2 only linear independence of the triple is used.
- *Coincidence of the squares*, $\omega_1^2=\omega_2^2=\omega_3^2$. This makes $A$ common, hence the eigenspace splitting common. Everything rests on it.
- *Coincidence of the self-wedges*, $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$. Used in all three cases once case 1 is run the new way.
- *$\dim V=6$.* Gives the three-pair spectrum, hence the three-way split; and in case 2 it is what puts $\star_V\Lambda^4V$ back in $\Lambda^2V$.

**Used, and unstated.**

- *$\ker\omega=\ker\omega^2$ for a real skew $\omega$.* The setup asserts $A$ is positive definite on $V$ "because $V=\mathop{\mathrm{im}}A$"; that $\mathop{\mathrm{im}}A=\mathop{\mathrm{im}}\omega_i$ needs the one line $\omega^2x=0\Rightarrow\langle\omega^2x,x\rangle=-\lVert\omega x\rVert^2=0\Rightarrow\omega x=0$. It is true and cheap, and the block's parenthesis half-states it.
- *Injectivity of $\alpha\mapsto\alpha\wedge\varepsilon_P$ on $\Lambda^2Q$*, and the independence of $\Lambda^4Q$ from $\Lambda^2Q\wedge\varepsilon_P$ inside $\Lambda^4V$. Case 3's cross-term step is exactly a component-wise reading and needs both. Both hold; section 3 gives them.
- *A choice of orientation on each eigenplane*, so that the signs $s_{ij}$ and $\tau_i$ exist as numbers at all. Section 2 shows the conclusions are invariant under changing it.

**Stated, and not used.**

- *Every Weyl condition* (trace-freeness, first Bianchi, the Riemann symmetries), in cases 2 and 3 and in the setup, and in case 1 under the boxed route. In case 1 **as printed** they are used, through the premise; that is finding 1.
- *$\mathop{\mathrm{tr}}(J_iJ_j)\ne0$ in case 2*, which the block itself already retires.
- *Unit norm*, beyond fixing $\mathop{\mathrm{tr}}A=2$ and the numerical value $c=\tfrac13$ in case 2. Nothing in any of the three contradictions needs the normalisation: they all survive for a merely orthogonal triple of nonzero forms.

## 1. Is the strengthened statement what the three cases establish?

**Of the argument printed in the pull-quote, yes. Of the argument printed in case 1's body, no, and the two are different arguments.**

I checked each case for a surviving Weyl condition.

- **Setup.** $A=-\omega_i^2$ common, positive definite on $V$ of trace $2$, doubled spectrum. Every ingredient is skewness, orthonormality and $\dim V=6$. **Weyl-free.**
- **Case 2.** Complex structures, $\star_V(J\wedge J)=2\epsilon_JJ$, injectivity of $\star$, then linear independence of the triple. **Weyl-free.**
- **Case 3.** The $4+2$ splitting, the cross term, the trace identity $\mathop{\mathrm{tr}}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, then $4a=-2b$ against $a,b>0$. **Weyl-free.**
- **Case 1, as printed.** Its last two sentences read "all three block-diagonal for one common splitting. [Lemma L181] then gives $W=0$." L181 is a statement about $W\in\mathcal W_n$ and its proof consumes Ricci-flatness *and* the first Bianchi identity, the brief's own premise is emphatic that neither half is redundant. So the printed case 1 uses two Weyl conditions and, worse, concludes something about a $W$ that the strengthened statement does not have. **A Weyl condition survives here.**

The strengthened statement is nonetheless **true**, because the route in the pull-quote closes case 1 with no Weyl input at all, and I re-derive it from scratch in section 2. The finding is that the block asserts "No Weyl hypothesis is used anywhere" while its case-1 paragraph visibly uses two. This is not hypothesis debt (the argument is on file, one paragraph above), it is a block that was strengthened in its headline and its box and left stale in its body. The repair is mechanical and I do not perform it: replace case 1's last two sentences with the box's three, and the block says what it means.

## 2. Case 1's Weyl-free route, derived from scratch

**Setting.** $c_1^2,c_2^2,c_3^2$ pairwise distinct, so $A$'s eigenspaces are three planes $P_1,P_2,P_3$ with $V=P_1\oplus P_2\oplus P_3$. Each $\omega_i$ commutes with $A=-\omega_i^2$, hence preserves each $P_j$. Orient each $P_j$ arbitrarily and let $\varepsilon_j$ be its unit area form.

**The forms.** $\omega_i|_{P_j}$ is skew on a plane, so $\omega_i|_{P_j}=t_{ij}\varepsilon_j$ for a real $t_{ij}$. Then $-\omega_i^2|_{P_j}=t_{ij}^2\,\mathrm{Id}_{P_j}$, which is $c_j^2\,\mathrm{Id}_{P_j}$, so $t_{ij}=s_{ij}c_j$ with $s_{ij}\in\{\pm1\}$ and $c_j>0$. Hence
$$\omega_i=\sum_{j=1}^3 s_{ij}c_j\,\varepsilon_j .$$

**Is $s_{ij}s_{ik}$ well defined?** $s_{ij}$ depends on the chosen orientation of $P_j$; reversing it flips $\varepsilon_j$ and so flips $s_{ij}$ **for all three $i$ at once**. Therefore every statement of the form "$s_{ij}s_{ik}$ does not depend on $i$" is invariant under the choice, and so is the ratio $s_{ij}s_{1j}$ used below. **Well defined once a choice is fixed, and the step is independent of which choice.**

**The wedge.** $\varepsilon_j\wedge\varepsilon_j=0$, and the three products $\varepsilon_j\wedge\varepsilon_k$ with $j<k$ are linearly independent in $\Lambda^4V$ (disjoint index supports). So
$$\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}\,c_jc_k\,\varepsilon_j\wedge\varepsilon_k .$$
Equality of the three self-wedges, read component-wise and divided by $c_jc_k>0$, gives exactly
$$s_{ij}s_{ik}=s_{1j}s_{1k}\qquad\text{for each }j<k\text{ and each }i. \tag{$\ast$}$$
**The independence-of-$i$ step is right**, and it is an equality of signs, not of magnitudes, because the magnitudes $c_jc_k$ are the same on both sides, that is what the common $A$ buys.

**From $(\ast)$ to $\omega_i=\eta_i\omega_1$.** Fix $i$ and set $u_j=s_{ij}s_{1j}\in\{\pm1\}$. For $j\ne k$,
$$u_ju_k=(s_{ij}s_{ik})(s_{1j}s_{1k})=(s_{1j}s_{1k})^2=+1,$$
so $u_1=u_2=u_3=:\eta_i\in\{\pm1\}$, and $s_{ij}=u_js_{1j}=\eta_is_{1j}$ for every $j$. Therefore
$$\omega_i=\sum_j \eta_i s_{1j}c_j\varepsilon_j=\eta_i\,\omega_1 .$$
**It really gives $\omega_i=\eta_i\omega_1$ and nothing weaker.** The step needs at least two blocks so that a pair $j<k$ exists; with three planes there are three pairs and the system is over-determined, which is why the conclusion is this rigid.

**The constant.** $\lVert\omega_1\rVert^2=1$ is $-\tfrac12\mathop{\mathrm{tr}}(\omega_1^2)=1$, i.e. $\mathop{\mathrm{tr}}(\omega_1^2)=-2$. Hence
$$\mathop{\mathrm{tr}}(\omega_1\omega_2)=\eta_2\mathop{\mathrm{tr}}(\omega_1^2)=-2\eta_2=\mp2\neq0,$$
against $\mathop{\mathrm{tr}}(\omega_1\omega_2)=0$. **The constant $\mp2$ is correct** with the brief's normalisation, and the sign convention is the block's: $\eta_2=+1$ gives $-2$. Case 1 is closed by orthogonality alone. Linear independence would do just as well, so the route survives even a triple that is merely independent rather than orthonormal.

**One remark on scope, since it is free.** Nothing above used $\dim V=6$ beyond having at least two distinct eigenplanes. The route closes the pairwise-distinct sub-case at every even $\dim V\ge4$. This is what section 10 measures the block's $\dim V\ge8$ sentence against.

## 3. The claimed common mechanism, and case 3

**The claim is true in case 3, and the block's case 3 never states it.**

Case 3 has $Q$ a $4$-plane, $P$ a plane, $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i^2=-\mathrm{Id}_Q$ and $\tau_i=\pm1$. Since $\omega_i\in\Lambda^2Q\oplus\Lambda^2P$,
$$\omega_i\wedge\omega_i=\underbrace{a\,J_i\wedge J_i}_{\in\Lambda^4Q}+\underbrace{2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P}_{\in\Lambda^2Q\wedge\varepsilon_P},$$
the $\varepsilon_P\wedge\varepsilon_P$ term being zero. The two summands sit in independent subspaces of $\Lambda^4V$ ($\dim\Lambda^4Q=1$, $\dim(\Lambda^2Q\wedge\varepsilon_P)=6$, and in coordinates with $P=\langle e_5,e_6\rangle$ the first has no $e_5,e_6$ and the second has both), so the wedge equality may be read component-wise. On $\Lambda^2Q\wedge\varepsilon_P$ the map $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective, so equality across $i$ gives $\tau_iJ_i$ independent of $i$:
$$J_i=\tau_i\tau_1J_1 .$$
Writing $J=J_1$ and $\sigma_i=\tau_i\tau_1$, this is $J_i=\sigma_iJ$ with $\sigma_i\tau_i=\tau_1$ for all $i$, one constant sign $\rho$. Then
$$\omega_i=\tau_i\big(\rho\sqrt a\,J+\sqrt b\,\varepsilon_P\big)=\tau_i\tau_1\,\omega_1=\pm\,\omega_1 .$$
**So case 3 does force $\omega_i=\pm\omega_1$**, and the block's mechanism claim is accurate. What the block's case-3 body actually does is different: it never writes $\omega_i=\pm\omega_1$, and instead derives the sign identity $4a\sigma_i\sigma_j=-2b\tau_i\tau_j$ and kills it by positivity. Both routes are valid; the box describes a mechanism the body does not run. I record this as a mismatch of narrative and proof, not as an error.

## 4. Does the strengthening lose anything?

**It loses nothing, and the reason is structural.** The general statement's hypotheses, an orthonormal triple, common support of dimension six, coincident squares, coincident self-wedges, are a subset of what the Weyl instance supplies. Deleting hypotheses from a "there is no such object" statement strictly enlarges the class it empties, so the corollary is an instance, not a casualty.

Three things had to be checked before saying that, and all three hold.

- **Common support is not an extra demand.** In the Weyl instance one might worry that the three eigenforms have different supports. They cannot: $\omega_i^2=\omega_j^2$ already forces $\mathop{\mathrm{im}}\omega_i=\mathop{\mathrm{im}}\omega_j$, since $\mathop{\mathrm{im}}\omega=\mathop{\mathrm{im}}(-\omega^2)$ for skew $\omega$. **Coincidence of the squares supplies the common support for free**, so the corollary's $\dim V=6$ is the general statement's $\dim V=6$ and no reconciliation step is needed.
- **The conclusion is not weaker.** The old case 1 ended at "$W=0$"; the new statement ends at "no such triple". For a rank-three $W$ the triple *is* the tensor together with its three eigenvalues, so no triple means no such $W$. Nothing that the old conclusion delivered is missing.
- **Orthonormality is available.** The eigenforms of a symmetric operator with three nonzero eigenvalues can be taken orthonormal.

**The one thing I cannot close from this brief.** The corollary is phrased with $\Phi$ ("three images under $\Phi$ coincide") and the brief quotes neither $\Phi$'s definition nor L183. If $\Phi(\omega)$ is the pair $(\omega^2,\omega\wedge\omega)$ then the bridge is an identity and there is nothing to check; if $\Phi$ is anything else, the bridge from "images coincide" to "squares and self-wedges coincide" is a step, and it is a step **outside this brief**. I name it rather than guess it: *the corollary rests on one unquoted identification, $\Phi$-coincidence with the pair of coincidences, and this round cannot see it.* That is the only place where item 4 has anything at risk, and it is a citation question, not a mathematical one.

## 5. Case 1 without the premise

**The boxed route is free of it; the printed case 1 is not.**

I went through case 1's paragraph clause by clause. "$A$ positive definite because $V=\mathop{\mathrm{im}}A$", no premise. "Multiplicities all even", no premise. "$A$'s eigenspaces are three planes, each $\omega_i$ preserves them, a skew map on a plane is a multiple of its area form", no premise. "$\omega_i=\sum_j\pm c_j\varepsilon_j$, all three block-diagonal for one common splitting", no premise, and this is precisely the hypothesis of L181. "[Lemma L181] then gives $W=0$", **the premise, load-bearing, and the only thing that ends the case in the printed text.**

So the sentence "Case 1 no longer appeals to Given C at all" is, in the paragraph that contains it, contradicted two sentences later. The replacement route of section 2 is complete on its own: it uses the same block-diagonal form, the wedge hypothesis, and orthonormality, and it needs no Ricci-flatness, no Bianchi and no $W$. **Case 1 is Weyl-free once the last sentence goes, and not before.**

## 6. Parity

**There is no parity restriction anywhere, in the premise or in the new route, and the earlier odd-$n$ debt does not exist against the premise as quoted here.**

- **In the premise.** The splitting is $\mathbb R^n=P_1\oplus\dots\oplus P_m\oplus P_0$ *with a remainder summand $P_0$*, whose dimension is unconstrained and may be odd. No step touches it: $\varepsilon_j$ is supported on $P_j$, so $\varepsilon_j\varepsilon_k=0$ for $j\ne k$ and $\omega_i^2=-\sum_jM_{ij}^2\mathrm{Id}_{P_j}$; the Ricci half reads $\mathop{\mathrm{diag}}(M^{\mathsf T}\Lambda M)=0$, the Bianchi half reads the off-diagonal, and $MM^{\mathsf T}=I_r$ turns $M^{\mathsf T}\Lambda M=0$ into $\Lambda=0$. **$\dim P_0$ enters no equation.** The only arithmetic constraint is $m\le\lfloor n/2\rfloor$, which is a bound at odd $n$ and not an exclusion. The premise's own box says as much ("the statement holds at every $n$, every rank and every number of blocks") and the derivation bears it out.
- **In case 1's new route.** Three planes inside $V$, $\dim V=6$; the ambient $n$ appears only as $n\ge6$. **No parity.**
- **Anywhere else.** Case 2 needs $\dim V=6$, case 3 needs $\dim V=4+2$; both are constraints on $\dim V$, which is even because it carries a nonsingular skew form, not because of anything about $n$. The nearest thing to a divisibility question in the block is "nothing here wants $4\mid n$", which the three-matchings construction settles by exhibiting three pairwise trace-orthogonal complex structures on $\mathbb R^6$. That is correct and I re-checked it (section 11).

**A dropped remainder summand is the whole explanation of the earlier debt.** With $P_0$ restored, an odd $n$ is simply a splitting with an odd-dimensional leftover, and L181 never looks at the leftover. Nothing is owed.

## 7. $\dim V$ against $n$

**Case 2's identity is a $\dim V=6$ fact and the block says so correctly; no step confuses the two.**

$\star_V$ maps $\Lambda^4V\to\Lambda^{\dim V-4}V$, which is $\Lambda^2V$ exactly when $\dim V=6$; equivalently $\binom{2m}4=\binom{2m}2$ at $2m=6$ and at no larger even value ($70$ against $28$ at $2m=8$, and the gap only widens). At $\dim V=4$ the star of a $4$-form is a scalar, so the identity has no content there either. **Correct as stated.**

The legitimacy of applying $\star_V$ at all is worth one line, since the forms live in $\Lambda^2\mathbb R^n$: all three $\omega_i$ are supported in $V$, so $\omega_i\wedge\omega_i\in\Lambda^4V$, and $\Lambda^4V\hookrightarrow\Lambda^4\mathbb R^n$ means the hypothesis "equal self-wedges in $\Lambda^4\mathbb R^n$" is the same statement as "equal in $\Lambda^4V$". The block's warning that the star is $V$'s and not $\mathbb R^n$'s is exactly the right warning and it is respected everywhere I looked.

**On $\epsilon_J$: right conclusion, wrong group named.** The identity $\star_V(J\wedge J)=2\epsilon_JJ$ with $\epsilon_J=\pm1$ holds because $SO(6)$ acts transitively on each of the two families of compatible complex structures with stabiliser $U(3)$, and $\star$ and $\wedge$ are $SO(6)$-equivariant, so $\epsilon$ is a continuous $\{\pm1\}$-valued function on a connected orbit. **What is needed is the connectedness of $SO(6)$, not of $U(3)$**, and the block cites the latter. The conclusion is unaffected ($\epsilon$ is well defined and takes both values, one on each orientation class) and I verified both values in closed form on $J=e_{12}+e_{34}+e_{56}$ and $J'=e_{12}+e_{34}-e_{56}$, getting $+2J$ and $-2J'$. This is a mis-stated reason, not a false claim.

## 8. The kernel, and over-spanning

**No step assumes the triple spans more than it does.**

The general statement has no $W$, so the recurring $\ker W\ne0$ obstruction reappears here only as $\ker\omega_i=V^\perp$, and every argument is conducted inside $\Lambda^\bullet V$: $A$ is definite on $V$ and zero off it, the eigenspace decomposition is a decomposition of $V$, and the wedges are compared in $\Lambda^4V$. Nothing is asserted about $\mathbb R^n$ outside $V$, and nothing needs to be.

As to the triple's own span: orthonormality gives $\dim\langle\omega_1,\omega_2,\omega_3\rangle=3$ as a *hypothesis*, and each case then derives a contradiction with it, case 1 by producing a proportionality, case 2 by producing a line, case 3 by a sign identity with no solution (or, by section 3, again by a proportionality). At no point is a larger span assumed and then used. The one place where a count could have gone wrong is case 1's need for at least two distinct eigenplanes to form a pair $j<k$; at $\dim V=6$ with pairwise distinct $c_j^2$ there are three planes and three pairs.

## 9. Exhaustiveness for the strengthened statement

**The three cases are exhaustive, and the split never used a Weyl tensor to begin with, which is why removing the Weyl hypothesis does not disturb it.**

The chain is: each $\omega_i$ is skew and $\ker\omega_i=V^\perp$, so on $V$ the real skew normal form gives a decomposition into invariant planes with $\omega_i$ acting by $\pm\mathrm ic_j$; hence $A=-\omega_i^2$ restricted to $V$ is positive definite with every eigenvalue of even multiplicity, and with $\dim V=6$ the spectrum is $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$ for three positive numbers $c_1^2,c_2^2,c_3^2$. Three numbers admit exactly three equality patterns (all distinct, all equal, exactly two equal), corresponding to the partitions $1{+}1{+}1$, $3$, $2{+}1$ of the index set. **Nothing else is possible.**

Every ingredient of that chain is skewness, the coincidence of the squares, and $\dim V=6$. **Trace-freeness, the first Bianchi identity and the Riemann symmetries appear nowhere in it.** In the Weyl instance those conditions constrain the *eigenvalues of $W$*, for example Ricci-flatness with coincident squares would read $(\sum_i\lambda_i)A=0$, hence $\sum_i\lambda_i=0$, but the case split is on the spectrum of $A$, not on the $\lambda_i$, so it never drew on them. This was the brief's nominated likeliest break and **it does not break**: the split was over-attributed to the Weyl setting, not derived from it.

Two boundary readings I checked and found harmless. First, $\mathop{\mathrm{tr}}A=2$ comes from unit norms and enters only as a numerical value ($c=\tfrac13$ in case 2, $2a+b=1$ in case 3), never into the classification. Second, $A$ is symmetric positive semidefinite and therefore always diagonalisable, so no defective-spectrum case is being silently skipped.

## 10. Overreach

**One sentence overreaches, and one sign statement is convention-dependent.**

- **"At $\dim V\ge8$ only case 1 survives."** Read as "of the three cases, only case 1's mechanism extends past six dimensions", it is right, and section 2 confirms that case 1's route needs only two distinct eigenplanes. Read as a statement about $\dim V\ge8$ (which the phrase "only case 1 survives" invites), it is **false by omission**: at $\dim V=8$ the spectrum is four numbers $c_1^2,\dots,c_4^2$ and the equality patterns are five, not three. The pattern $(a,a,b,b)$ splits $V$ into two $4$-planes and is covered by none of the three cases. The block is not claiming to close $\dim V\ge8$, the footnote about the earlier "one case left" defect shows the authors know nothing reaches there, but a ledger row taken from this sentence would inherit the wrong reading, which is precisely the failure mode that footnote is about. **The sentence should say which mechanism extends, not which case survives.**
- **Case 3's "$\sigma_i=\tau_i$ outright."** The cross term gives $J_i=\tau_i\tau_1J_1$, so with $J:=J_1$ one gets $\sigma_i=\tau_i\tau_1$, which is $\sigma_i=\tau_i$ only after normalising $\tau_1=+1$, available, by reversing the orientation of $P$, which flips all three $\tau_i$ together. The invariant statement is that $\rho_i=\sigma_i\tau_i$ is **one constant sign $\rho=\tau_1$**, not necessarily $+1$. The conclusion is untouched either way: $\sigma_i\sigma_j=\rho^2\tau_i\tau_j=\tau_i\tau_j$, so orthogonality reads $-4a\tau_i\tau_j-2b\tau_i\tau_j=0$ and $4a=-2b$ follows at once, impossible for $a,b>0$. I also note the superseded three-signs step is itself correct, $\rho_1\rho_2=\rho_1\rho_3=\rho_2\rho_3=k$ multiplied together gives $(\rho_1\rho_2\rho_3)^2=k^3$, so $k=1$, so the block loses nothing by retiring it.
- **Everything else in the closing box is within reach.** "At $\dim V=6$ the coincident case is empty" is exactly what the three cases give. "Cases 2 and 3 are strictly six-dimensional" is right for the reasons given. The mechanism claim is right (section 3). The dimension remark "nothing here wants $4\mid n$" is right (section 11).

## 11. The screen, reported as a screen

I had derived by hand, exactly, the three self-wedges of the block's witness $J_1=e_{12}+e_{34}+e_{56}$, $J_2=e_{13}+e_{25}+e_{46}$, $J_3=e_{14}+e_{26}+e_{35}$, together with $\mathop{\mathrm{tr}}(J_kJ_l)=0$ and the two values of $\epsilon_J$. To re-check the sign bookkeeping I ran about a second of exact integer arithmetic on those four forms, which I wrote down myself for the purpose. It returned $J_k^2=-\mathrm{Id}_6$ for all three, $\mathop{\mathrm{tr}}(J_kJ_l)=0$ for all three pairs, the self-wedges $2(e_{1234}+e_{1256}+e_{3456})$, $2(-e_{1235}+e_{1346}-e_{2456})$, $2(-e_{1246}-e_{1345}+e_{2356})$ with nine pairwise distinct $\Lambda^4$ supports, and $\star(J_1\wedge J_1)=2J_1$ against $\star(J'\wedge J')=-2J'$ for $J'=e_{12}+e_{34}-e_{56}$.

This agrees with my hand derivation and with every value the block prints. **It is a screen and I cite it for nothing positive**; the block's claims here stand on the closed-form computation, which is short enough to be read directly.

## 12. What would falsify the strengthened statement, and what I did

**The object.** An orthonormal triple $\omega_1,\omega_2,\omega_3\in\Lambda^2\mathbb R^n$, each of rank exactly six with the same image $V$, satisfying $\omega_1^2=\omega_2^2=\omega_3^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$. No Weyl condition on it, no constraint on $n$ beyond $n\ge6$.

**What I did to look for it.** I did not search, and the standing rule forbids it; a falsifier here would in any case have to defeat a closed classification rather than hide in a corner of parameter space. What I did instead was test the classification at its joints: I checked that the equality patterns of three positive numbers are three and only three (section 9), that each pattern's argument uses only hypotheses the falsifier would have to satisfy, and that the two places where a falsifier could slip through a gap, case 1's dependence on the premise, and the possibility that a Weyl condition was silently constraining the spectrum, are closed, the first by the route of section 2 and the second by the observation that the spectrum of $A$ never saw a Weyl condition. I also examined the one near-miss on file in closed form: three pairwise trace-orthogonal complex structures on $\mathbb R^6$, which satisfy orthonormality, rank six, common support and coincident squares, and fail **only** the wedge condition, their three self-wedges have pairwise disjoint supports in $\Lambda^4$, so they are as far from coincident as the hypothesis can put them. That witness shows the wedge condition is doing all the work and shows where a falsifier would have to be built: among triples of complex structures on $\mathbb R^6$ with a common self-wedge, which case 2 empties by the injectivity of $\star$.

**The honest boundary.** A falsifier at $\dim V=8$ with spectrum pattern $(a,a,b,b)$ would not contradict this lemma, which is about $\dim V=6$; it would contradict the closing box only under the loose reading flagged in section 10. That is the one place where the block's prose is exposed and the mathematics is not.

## Overall verdict

**SOUND BUT MIS-ASSEMBLED.**

The strengthened statement is **true**, its three cases are **exhaustive**, and case 1's Weyl-free route (the reason this round exists), is **correct as claimed, including the constant $\mp2$**, and I derived it independently before comparing. There is **no parity restriction anywhere**, in the premise with its remainder summand restored, in the new route, or in the block. The scope discipline between $\dim V$ and $n$ is **kept**. The common-mechanism claim is **true even in case 3**, which the block's own case 3 never says.

What is wrong is assembly, not mathematics. **Case 1's printed paragraph still ends by invoking the premise and concluding $W=0$, so the block's headline "No Weyl hypothesis is used anywhere" is contradicted by the block's own body**, and a reader who audits the body rather than the box will find two Weyl conditions in use. One sentence about $\dim V\ge8$ invites a claim the three cases do not reach. Two smaller items, the group named for $\epsilon_J$'s well-definedness, and the convention-dependence of "$\sigma_i=\tau_i$", are imprecise reasons for correct conclusions.

**No hypothesis debt was found**, and I supplied nothing: the argument case 1 needs is already on file one paragraph above the place it belongs.
