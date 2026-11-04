# Verify v80, the integral-lift argument for L87: does a mod-$p$ Gram rank bound $\dim U$ when the sampled group elements are born in characteristic $p$?

**Cold brief.** I was given the argument neutrally, with no author, no verdict, and no property named. **I ran nothing**, no script, no Sage, no numerics, and I wrote none; every number below is derived by hand or read off a source file as text. Log: [agent_logs/verify-L87-v80.log](../agent_logs/verify-L87-v80.log).

## Verdict, `VALID WITH A NAMED GAP`

**The conclusion is true and the load-bearing inequality chain is correct.** The construction does supply the one thing the block's original one-liner lacked: a single object defined over $\mathbb Z[\tfrac12]$ whose two reductions are the two things being compared, so that "rank drops on reduction" finally has something to reduce. The $3700$ sampled group elements are never reduced and never need to be; they enter the chain only through a sample-spans-no-more-than-the-whole inclusion, and that is the right way round.

**The gap.** The argument's central sentence, *"$SO_{5,k}$ is reduced, so $f$ kills the whole image iff $L_kf=0$; hence $\dim_k\mathop{\mathrm{span}}\Phi(SO_{5,k})=\mathop{\mathrm{rank}}(L_k)$"*, asserts an equality at every field $k$ of characteristic $\ne2$, and **reducedness does not deliver it at either field the argument then uses**:

- **at $k=\mathbb F_p$** the asserted equivalence is *false* under the reading that makes $\Phi(SO_{5,k})$ a set of points, because $SO_5(\mathbb F_p)$ is a finite set and a finite set of points does not detect a nonzero regular function by reducedness alone. **The chain survives because it consumes only the inclusion $\ker L_k\subseteq\{f:\ f\circ\Phi\ \text{vanishes pointwise}\}$, which is free of both reducedness and algebraic closedness.**
- **at $k=\mathbb Q$** the *other* inclusion is genuinely consumed, $\mathop{\mathrm{rank}}(L_{\mathbb Q})\le\dim U$ is the step that needs *"$f$ vanishing on the orbit $\Rightarrow$ $L_{\mathbb Q}f=0$"*, and what supplies it is **Zariski density of $SO(5,\mathbb R)$ in $SO_{5,\mathbb C}$**, a hypothesis the argument neither states nor gets from reducedness of $SO_{5,\mathbb Q}$.

**And one looseness of construction:** $\mathbb Z[\tfrac12][SO_5]$ is not a finitely generated $\mathbb Z[\tfrac12]$-module and carries no grading in which *"the relevant degree"* is defined, so *"fix $\mathbb Z[\tfrac12]$-bases and let $L$ be its matrix"* does not name an object as written. The repair is inside the argument's own resources and is recorded below as what would have to be proved, not as a repair I supply.

**Net: the argument reaches $\mathop{\mathrm{rank}}_{\mathbb F_p}(\text{Gram})\le\dim U$. It reaches it by a route two of its own sentences misdescribe.**

## What the objects are, fixed before anything is adjudicated

Write $R=\mathbb Z[\tfrac12]$, $A=R[SO_5]$ the coordinate ring of the group scheme, $\mathcal W$ the $35$-dimensional Weyl space, $\Phi(g)=(gW_0)^3\in\mathop{\mathrm{Sym}}^3\mathcal W$, $F=\mathop{\mathrm{Sym}}^3(\mathcal W)^*$ of rank $\binom{37}{3}=7770$, and $\Lambda:F\to A$, $\Lambda(f)=\big(g\mapsto f(gW_0)\big)$.

**Three facts about the run that the argument leans on, checked against the source rather than assumed.** Reading [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) as text:

- **$W_0$ really is a reduction.** It is assembled as $2w_1^{\mathsf T}w_1-w_2^{\mathsf T}w_2-w_3^{\mathsf T}w_3$ from $\{0,\pm1\}$ vectors in $\Lambda^2$, and the orbit point is $\Lambda^2(g)\,W_0\,\Lambda^2(g)^{\mathsf T}$. So the ambient module is $\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb Z^5)$, free over $\mathbb Z$, stable under $SO_5$ over *any* ring, with $W_0$ an integral point of it. **The one half-sentence of the argument that carries real weight, *"$W_0$ is integral"*, is literally true of the object the run used**, and no prime beyond $2$ needs inverting to have an $SO_5$-stable free lattice available.
- **The sample lies in $SO_5(\mathbb F_p)$, not merely $O_5(\mathbb F_p)$.** For skew $A$, $(I-A)^{\mathsf T}=I+A$, so $\det(I-A)=\det(I+A)$ and the Cayley transform has $\det g=1$ identically, in every characteristic. The script checks only $gg^{\mathsf T}=I$; determinant one comes free from the construction. *The record's own prose calls these elements of $O(5,\mathbb F_p)$; they are $\mathbb F_p$-points of $SO_5$, which is exactly what the argument needs and slightly better than what the record claims for them.*
- **$p=46337$ is prime**, trial division by hand through $211>\sqrt{46337}\approx215.3$ leaves no divisor, and $p-1=46336=2^8\cdot181$ with $181$ prime, so $3\nmid p-1$.

## 1. Is $\Lambda$ well defined into $\mathbb Z[\tfrac12][SO_5]$, and is $L$ a matrix over $\mathbb Z[\tfrac12]$?

**$\Lambda$ is well defined; $L$ is not, as written; and the fix costs the argument nothing but is not in it.**

**Well-definedness holds, and over $\mathbb Z$ rather than $\mathbb Z[\tfrac12]$.** The entries of $g$ are the coordinate functions of $A$; $gW_0$ has coordinates that are $\mathbb Z$-linear combinations of degree-two monomials in them (the action is through $\Lambda^2$, hence quadratic in $g$), so $f(gW_0)$ is a polynomial in the coordinate functions with coefficients depending $R$-linearly on $f$. **No denominator is introduced by $\Lambda$ itself.** The $\tfrac12$ is spent entirely on the group scheme.

**The target is where the sentence fails.** Three things are asserted or presupposed by *"fix $\mathbb Z[\tfrac12]$-bases and let $L$ be its matrix"*, and they have different statuses:

| presupposition | status |
|---|---|
| $F$ is free of finite rank over $R$ | **true**, once $\mathcal W$ is given an $SO_5$-stable free $R$-form; the run supplies one concretely, $\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb Z^5)$ or the saturation of $\mathcal W$ inside it |
| $A=R[SO_5]$ is free with a basis one can "fix" | **not established, and not needed.** $A$ is the coordinate ring of a $10$-dimensional affine scheme: it is of infinite rank, and torsion-free non-free modules over a PID exist, so freeness of $A$ is a claim, not a convenience |
| $A$ is "finitely generated in the relevant degree" | **the presupposition is false.** The defining ideal of $SO_5$ (the entries of $gg^{\mathsf T}-I$ and $\det g-1$), is inhomogeneous, so $A$ carries no grading and *"the relevant degree"* names nothing. There is a filtration by degree of representative, but a filtration piece is not what a basis is fixed in |

**What would have to be proved, stated and not supplied by me.** That there is a finitely generated **free** $R$-submodule $N\subseteq A$ containing $\mathop{\mathrm{im}}\Lambda$. Two ingredients would settle it, that $\mathop{\mathrm{im}}\Lambda$ is finitely generated (immediate: $7770$ generators) and that $A$ is torsion-free over $R$ (which is what $SO_5$ smooth over $R$ buys, smooth $\Rightarrow$ flat $\Rightarrow$ torsion-free over a PID), and finitely generated torsion-free modules over a PID are free. **I record the shape of that argument to name the gap precisely, not to close it: the block that adopts this text owes the sentence, not me.**

**Note that saturation of $N$ is *not* among the requirements**, which is worth saying because it is the natural place to expect a hidden condition. Any free $N\supseteq\mathop{\mathrm{im}}\Lambda$ serves: enlarging $N$ adds zero rows to $L$ and moves no rank, and at $k=\mathbb Q$ flatness of $\mathbb Q$ over $R$ makes $N\otimes\mathbb Q\to A\otimes\mathbb Q$ injective, so $\mathop{\mathrm{rank}}(L_{\mathbb Q})=\mathop{\mathrm{rank}}(\Lambda_{\mathbb Q})$ regardless of the choice.

**Strongest defence of the sentence, constructed before reporting it.** One can read *"$\mathbb Z[\tfrac12][SO_5]$"* as shorthand for "the $R$-module generated by the image", which is the only part of the target any matrix could be written against, and read *"bases"* as "a basis of $F$ and a generating set of that submodule". Under that reading the sentence is a compression of a correct construction rather than an error. **The defence succeeds as a reading and fails as a warrant**: it presupposes exactly the freeness statement above, which is where the smoothness hypothesis is doing its second, unadvertised job.

## 2. Does "$SO_{5,k}$ is reduced" give what it is used for?

**It gives one of the two inclusions, at algebraically closed $k$ only, and that is not the inclusion the mod-$p$ end of the chain consumes.**

Unfold the asserted equivalence into its halves. Let $Z_k=\{f\in F\otimes k:\ f(gW_0)=0\ \text{for every point }g\}$.

- **($\Leftarrow$) $L_kf=0\Rightarrow f\in Z_k$.** The composite $F\otimes k\to N\otimes k\to A\otimes k=k[SO_{5,k}]$ *is* $\Lambda_k$, by base change of an affine scheme's coordinate ring. So $L_kf=0$ forces the regular function $f\circ\Phi$ to be zero, hence to vanish at every point. **Reducedness is not used. Algebraic closedness is not used. This half is unconditional.**
- **($\Rightarrow$) $f\in Z_k\Rightarrow L_kf=0$.** This is the half that needs work, and it needs *two* things, only one of which the argument names: the $k$-points must be Zariski dense in $SO_{5,k}$ (so pointwise vanishing implies the function lies in the nilradical), and $SO_{5,k}$ must be reduced (so the nilradical is zero).

**Where reducedness enters, exactly.** At the second of those two, and nowhere else. **What would fail without it:** on a non-reduced group scheme a nonzero regular function can vanish at every point, $x$ on $\mathop{\mathrm{Spec}}k[x]/(x^2)$ is the model, and $\mu_p$ and $\alpha_p$ are the live examples in characteristic $p$, so $Z_k$ could strictly contain $\ker L_k$, $\mathop{\mathrm{rank}}(L_k)$ could strictly exceed $\dim_k\mathop{\mathrm{span}}\Phi$, and the asserted equality would fail with the surplus on the rank side. **This is why excluding characteristic $2$ is not optional:** the scheme $\{g:gg^{\mathsf T}=I\}$ is non-smooth in characteristic $2$ precisely as the "$x^2$" phenomenon, so the failure mode is the one the exclusion is aimed at.

**But density is the missing partner.** Reducedness alone is inert without it, and the argument supplies it at no $k$. Over $\overline{\mathbb F_p}$ and over $\mathbb C$ it comes free (finite type over an algebraically closed field, closed points dense, Jacobson). **Over $\mathbb F_p$ and over $\mathbb Q$ it does not**, and those are the two fields the argument instantiates at.

**Strongest defence.** The author may mean *"the whole image"* scheme-theoretically (the image of the morphism $\Phi:SO_{5,k}\to\mathop{\mathrm{Sym}}^3\mathcal W_k$), in which case *"$f$ kills the image"* is by definition $f\circ\Phi=0$ in $k[SO_{5,k}]$ and the equivalence is a tautology holding at every $k$. **The defence works, and it costs reducedness its job**: under the scheme-theoretic reading the sentence is true and the reducedness clause is decorative. So the argument has a reading on which the sentence is true and reducedness idle, and a reading on which reducedness is essential and the sentence is false at $k=\mathbb F_p$. **There is no reading on which the sentence is both true at $k=\mathbb F_p$ and using the hypothesis it cites.** That is the finding, and it is a defect of statement, not of conclusion.

## 3. Is $\dim_k\mathop{\mathrm{span}}\Phi(SO_{5,k})=\mathop{\mathrm{rank}}(L_k)$ correct, at $\mathbb Q$ and at $\mathbb F_p$, and does the finite sample reach the full group?

**As an equality: correct at $k=\overline{\mathbb F_p}$ and at $k=\mathbb C$; not established at $k=\mathbb F_p$ or $k=\mathbb Q$. As the inequality the chain uses, correct at every $k$.**

- **At $k=\mathbb F_p$.** $SO_5(\mathbb F_p)$ is a *finite* set (of order $p^4(p^2-1)(p^4-1)$, large but finite) and reducedness says nothing about whether a finite set of points detects a nonzero regular function on a $10$-dimensional scheme. **What would make the equality true here is a point-count or degree bound (a Lang–Weil or Schwartz–Zippel estimate forcing $\#\{f\circ\Phi=0\}<\#SO_5(\mathbb F_p)$ for $f\circ\Phi\ne0$), and the argument invokes none.** *This is a genuine hole in the equality and a harmless one for the chain*, because only $\dim_k\mathop{\mathrm{span}}\Phi\le\mathop{\mathrm{rank}}(L_k)$ is consumed and that is the unconditional half of item 2.
- **At $k=\mathbb Q$.** The equality is asserted in the form $\mathop{\mathrm{rank}}(L_{\mathbb Q})=\dim U$, and here **the conditional half is exactly what is consumed**, because $\dim U$ is the record's real orbit span and the chain needs $\mathop{\mathrm{rank}}(L_{\mathbb Q})\le\dim U$, i.e. $\{f:\ f|_{SO(5,\mathbb R)}=0\}\subseteq\ker\Lambda$. **This is Zariski density of $SO(5,\mathbb R)$ in $SO_{5,\mathbb C}$**, true, standard for a compact real form of a connected reductive group, and **not a consequence of $SO_{5,\mathbb Q}$ being reduced**, since a reduced scheme can perfectly well have few rational points. **This is the named gap.**
- **Does the argument need the full group?** **No.** It needs the sample to consist of $\mathbb F_p$-points of the group scheme $SO_5$ base-changed to $\mathbb F_p$ (which the Cayley construction supplies, defining equations and all) and nothing more. **The finite sample does not reach the full group and is not asked to.** Its span is a subspace of the group's span, the inclusion is used in that direction, and any $3700$ points whatever would have served. *No genericity, no seed, no equidistribution and no Haar-measure property of the sample is load-bearing anywhere in this argument.*

## 4. "Rank drops on reduction", the condition, and whether the construction supplies it

**Condition:** $L$ must be **one** matrix with entries in $R=\mathbb Z[\tfrac12]$, such that $L\otimes\mathbb Q$ represents the characteristic-zero map and $L\otimes\mathbb F_p$ represents the characteristic-$p$ map. Given that, every $(r+1)$-minor of $L$ vanishing over $\mathbb Q$ has integral value $0$, hence vanishes mod $p$, so $\mathop{\mathrm{rank}}(L_{\mathbb F_p})\le\mathop{\mathrm{rank}}(L_{\mathbb Q})$. **The reduction map $R\to\mathbb F_p$ must exist, which is $p$ odd.**

**The construction supplies it, and this is the argument's real contribution.** $L$ depends on the group *scheme* $SO_5$ over $R$ and on the integral point $W_0$, **on no sampled group element at all.** That is precisely why the objection it answers evaporates: the block's original warrant needed the *orbit points* to be reductions of characteristic-zero rotations, which they are not; the replacement needs only the *map* $\Lambda$ to be defined over $R$, which it is. **The two characteristics are joined at $\Lambda$, not at the sample.**

Base change is the one thing to check and it holds: for affine $X$ over $R$, $\mathcal O(X_k)=\mathcal O(X)\otimes_Rk$ unconditionally, so $\Lambda\otimes k=\Lambda_k$ and $L_k$ really is the matrix of the characteristic-$k$ map, **modulo item 1's freeness of $N$, without which "$L_k$" has no referent.**

## 5. The full chain, and where the sample enters

$$3570=\mathop{\mathrm{rank}}_{\mathbb F_p}\!\big(\langle g_aW_0,g_bW_0\rangle^3\big)\ \overset{(1)}{\le}\ \dim_{\mathbb F_p}\mathop{\mathrm{span}}\{\Phi(g_a)\}_{a\le3700}\ \overset{(2)}{\le}\ \dim_{\mathbb F_p}\mathop{\mathrm{span}}\Phi(SO_5(\mathbb F_p))\ \overset{(3)}{\le}\ \mathop{\mathrm{rank}}(L_{\mathbb F_p})\ \overset{(4)}{\le}\ \mathop{\mathrm{rank}}(L_{\mathbb Q})\ \overset{(5)}{=}\ \dim U\ \overset{(6)}{\le}\ 3570.$$

| link | what carries it | status |
|---|---|---|
| **(1)** | $\langle X^{\otimes3},Y^{\otimes3}\rangle=\langle X,Y\rangle^3$, and a Gram matrix of a family has rank at most the rank of the family, in characteristic $p$ the form may be degenerate on the span, so the Gram can only **under**-report | **correct, and outside the argument adjudicated here**, which begins at (3) |
| **(2)** | a subset spans no more than the whole; the sample consists of $\mathbb F_p$-points of $SO_5$ because the Cayley transform of skew $A$ satisfies $gg^{\mathsf T}=I$ and $\det g=1$ | **correct** |
| **(3)** | $\ker L_{\mathbb F_p}\subseteq\{f:\ f\circ\Phi\ \text{vanishes pointwise}\}$, the unconditional half of the asserted equivalence | **correct**, and it does **not** use reducedness |
| **(4)** | minors of one integral matrix; $p$ odd | **correct**, given item 1's $L$ |
| **(5)** | the conditional half, at $\mathbb Q$: needs $SO(5,\mathbb R)$ Zariski dense in $SO_{5,\mathbb C}$ | **true and unstated, the named gap** |
| **(6)** | [L86](../findings/sym3-blocks.md)'s **full** parity rule ($\dim V_\lambda^H\le1$ *and* $=0$ at odd $\lambda_2$) with [L83](../findings/sym3-blocks.md)'s dimensions | **outside this argument entirely**, and separately known to be stated on too weak a hypothesis in the block |

**Where the sample enters: link (2), and only there.** **It is consumed the right way round**, as a *lower* bound on the group's span, propagating upward to $\dim U$, so that the cap at (6) closes the squeeze from above. The sample is never asked to approximate the group, only to sit inside it.

**One asymmetry worth stating plainly.** Every link from (1) to (5) is an inequality pointing the same way, so the chain is **robust to the sample being bad and fragile to the run being wrong**: if the reported rank were spuriously high the chain would not detect it, since $3570$ is exactly what the cap permits. *That is the trap [L90](../findings/sym3-blocks.md) names in this same file, and the argument under adjudication does nothing about it, nor claims to.*

## 6. Characteristic $2$, and $p=46337$

**Excluding characteristic $2$ is enough for what it is asked to do, and it is necessary.** Over $R=\mathbb Z[\tfrac12]$ the scheme $O_n=\{gg^{\mathsf T}=I\}$ for the standard form is smooth, $\mu_2$ is étale so $SO_5=\{\det=1\}$ is open and closed in it, and every fibre is smooth hence reduced. In characteristic $2$ that fails at the first step, which is exactly the non-reducedness item 2 needs excluded. **The half-trace normalisation of the record's pairing also needs $2$ invertible, and $p$ odd covers it.**

**What else about $p$ matters, and what does not:**

- **Size against $7770$, $3700$ or $3570$: nothing is required.** Every link is one-directional; a small $p$ would risk the rank coming out *low*, which would prove nothing rather than prove something false. **A size condition would appear only if one wanted the converse of (3)**, where a Lang–Weil estimate needs $p$ large against the degree, and the argument does not want it.
- **Relation to the group order: irrelevant here, and pointedly so.** $p$ divides $|SO_5(\mathbb F_p)|=p^4(p^2-1)(p^4-1)$ for every $p$, so $\mathbb F_p[SO_5(\mathbb F_p)]$ is never semisimple and the isotypic decomposition underwriting the cap does not exist in characteristic $p$. **The argument is built so as not to need it:** it transports a single dimension through $\Lambda$ and does all representation theory over $\mathbb Q$. *This is the strongest structural thing to be said in the argument's favour and it is unstated.*
- **The lattice question does not force more primes out.** One might expect the $35$-dimensional Weyl summand to need $3$, $5$ or $7$ inverted to split off traces integrally; the concrete lattice $\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb Z^5)$ the run actually uses is $SO_5$-stable over any ring and contains $W_0$, and the rank of $\Lambda$ is the dimension of the span either way. **$\mathbb Z[\tfrac12]$ is the right ring.** *Recorded as a candidate failure I constructed and then withdrew.*
- **$46337$ is prime and $3\nmid p-1$.** The second fact makes entrywise cubing a bijection on $\mathbb F_p$, which bears on link (1)'s formation of the Gram and not on the lift argument at all.

## 7. What the argument does NOT establish

- **It does not make $3570$ checkable.** It licenses one machine run's number as a valid lower bound; it does not verify the number. **One prime, one seed, one run stands exactly as it stood.**
- **It does not promote the lemma from measured to proved.** The upper bound is a theorem, the lower bound is still a computation, and adopting this argument changes only *why the computation is admissible*. Any headline reading *"proved rather than measured"* is untouched by it.
- **It does not give $\mathop{\mathrm{rank}}(L_{\mathbb F_p})=\mathop{\mathrm{rank}}(L_{\mathbb Q})$**, and nothing in it licenses reading the mod-$p$ rank as *equal to* $\dim U$ independently of the cap. Had the run returned any number below $3570$, the argument would have yielded nothing whatever.
- **It does not supply the cap.** Links (6) and the odd-block vanishing are [L86](../findings/sym3-blocks.md)'s, and the block's stated hypothesis $\dim V_\lambda^H\le1$ gives $5640$, at which the squeeze does not close. **Adopting this argument repairs the warrant sentence and leaves that defect exactly where it is.**
- **It does not establish the block-by-block conclusion except through the squeeze**, so it inherits the squeeze's fragility: a defect landing the computed rank on the cap is invisible to it.
- **It does not establish anything in characteristic $p$ about the module structure** (no isotypic decomposition, no evaluation map, no multiplicity) and a reader who takes it to have transported the sixteen even blocks to $\mathbb F_p$ has read more than is there.
- **It does not retire the check [L86](../findings/sym3-blocks.md) names**, evaluating the $41$ highest-weight vectors at a handful of orbit points, sixteen independent small facts in place of one rank. That remains the thing that would make the dependency go away, and it remains open.
- **It says nothing about $O(5)$ versus $SO(5)$.** The identification is harmless, $-\mathrm{Id}$ acts trivially on $\mathcal W_5\subset V^{\otimes4}$, so the two orbits of $W_0$ coincide, but it is a step the argument passes over in silence while the cap is indexed by $O(5)$-blocks.

## The strongest defence I constructed, and what became of it

**The defence, put at its highest:** every sentence of the argument is a compression of a correct standard construction; *"fix bases"* means the free submodule generated by the image, *"kills the whole image"* means kills the scheme-theoretic image, and *"reduced"* is shorthand for the smoothness that makes every one of those steps available at once. Read that way there is nothing to find, and the argument is two correct lines doing exactly the work claimed for them.

**Where it holds:** at items 1 and 4 completely, and at item 2 as a reading. The freeness of $N$ and the identity $\mathcal O(X_k)=\mathcal O(X)\otimes k$ are both consequences of the stated hypotheses, and the integral matrix $L$ genuinely exists and genuinely bridges the two characteristics without touching a sampled group element.

**Where it breaks:** at link (5). No compression of *"$SO_{5,k}$ is reduced"* yields *"$SO(5,\mathbb R)$ is Zariski dense in $SO_{5,\mathbb C}$"*, they are independent statements about different objects, and only the second gets $\mathop{\mathrm{rank}}(L_{\mathbb Q})\le\dim U$, which is the one place in the chain where the conditional half of the equivalence is actually spent. **The gap is small, true, and standard; it is also load-bearing and absent.** A block adopting this text owes that sentence, and owes item 1's freeness sentence, and would do well to drop the claim of *equality* at $k=\mathbb F_p$ in favour of the inequality it actually uses, which is unconditional and therefore stronger as a warrant.
