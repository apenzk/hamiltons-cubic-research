# Review r673, Lemma L84, "Casimir separation is forced, not measured"

**Reviewer A of a pair on identical briefs. Target: the block headed `#### Lemma L84` in [findings/sym3-blocks.md](../findings/sym3-blocks.md), with the section `## Separation of the blocks, which is a theorem` beneath it. Analysis only; no computation was run. Every number below is hand arithmetic, done as a screen on claims I record.**

## Verdict: GAP

**The forcing is real and the label is earned**, this is the rarer outcome the brief flagged as unlikely, and I want it stated first. The separation of the $24$ blocks by the centre of $U(\mathfrak{so}(5))$ is a theorem about *all* dominant $B_2$ weights, needs no table, no case check and no run, and I rebuilt it cold. The $21$, the three collisions and all six $p_4$ values reproduce exactly.

**Four things around it do not hold.**

| # | defect | severity |
| --- | --- | --- |
| D1 | *"the $22$ this file carried came from a run made before $\rho$ was corrected to $(3/2,1/2)$"* is **false**. `git` holds no run at any other $\rho$, and both reviews the clause descends from diagnose the $22$ as arithmetic. | manufactured provenance |
| D2 | The heading's *"the quartic generator separates all $24$"* is **true but not what the block's argument gives**. The argument delivers the *pair* $(C_2,C_4)$; the solo claim is a range check on $24$ numbers, measured, in a block headed "forced, not measured". | scope |
| D3 | The block is stated at a scope its **own file retires twice below it**, [L87](../findings/sym3-blocks.md) leaves one collision needing the quartic, and [L92](../findings/sym3-blocks.md) says the route in use needs no Casimir separation at all. | over-claim by scope |
| D4 | The load-bearing Harish-Chandra leading-term fact is **cited to no source anywhere on the record**, and it is the one step that names *which* quartic. | uncited |

Plus two minor: the letter $p$ carries two objects inside one paragraph, and the block resolves no pointer and credits one of the two reviewers who filed the correction.

## Readings adopted, stated as the brief requires

- **$\rho(B_2)=(3/2,1/2)$** in the $e$-basis, so $c_2(\lambda)=\langle\lambda,\lambda+2\rho\rangle=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$. This is [conventions.md](../findings/conventions.md)'s Casimir sign $C=-\sum_a\rho(A_a)^2$ under [sym3-blocks.md](../findings/sym3-blocks.md)'s own $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$, which is the normalisation [conventions.md](../findings/conventions.md) flags as *distinct from* its Killing $B_K=-6B$.
- **The block table is in the $e$-basis**, not the $\omega$-basis, the reading [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) pinned. Under the $\omega$-basis $(4,2)$ would be dimension $260$, and every number below would move.
- **$\ell_i=\lambda_i+\rho_i$**, so $\ell=(\lambda_1+\tfrac32,\lambda_2+\tfrac12)$ and $p_{2k}(\ell)=\ell_1^{2k}+\ell_2^{2k}$.
- **Dominant means $\lambda_1\ge\lambda_2\ge0$** (integral $B_2$; no half-integral spin weights occur, as [L88](../findings/sym3-blocks.md) records).
- Nothing here uses $\theta_0$, $S_{XYZ}$, or the $\mathring W$ index order, so the two conventions repaired on 2026-09-04 do not touch this block.

## 1. The forcing, written out, and it closes

**Theorem.** *The infinitesimal character separates dominant $B_2$ weights outright, and two central generators realise it.*

**Step 1, Harish-Chandra.** For $\mathfrak g$ semisimple of rank $r$, the Harish-Chandra homomorphism is an algebra isomorphism $Z(U(\mathfrak g))\xrightarrow{\ \sim\ }S(\mathfrak h)^W$ onto the honest (not dotted) $W$-invariants once written in the shifted variable $\ell=\lambda+\rho$, and the infinitesimal character is $\chi_\lambda(z)=\mathrm{HC}(z)(\lambda+\rho)$. Hence

$$\chi_\lambda=\chi_\mu\iff \mu+\rho\in W\cdot(\lambda+\rho).$$

**Step 2, the invariant ring at $B_2$.** $W(B_2)$ is the signed permutations of $(\ell_1,\ell_2)$, order $8$. Its invariants are the symmetric functions of $t_i=\ell_i^2$, so $S(\mathfrak h)^{W(B_2)}=\mathbb R[e_1,e_2]$ in the $t_i$, and equivalently $\mathbb R[p_2,p_4]$ via $e_1=p_2$, $e_2=(p_2^2-p_4)/2$. **This answers the brief's "do finitely many $p_{2k}$ suffice", exactly $r=2$ of them do, and no further $p_{2k}$ carries new information**, since $p_6,p_8,\dots$ are polynomials in $p_2,p_4$ by Newton. **The quartic is $k=2$**, degree $4$ in $\ell$.

**Step 3, regularity, which is where $B$-type is used.** For dominant $\lambda$,

$$\ell_1=\lambda_1+\tfrac32\ \ge\ \lambda_2+\tfrac32\ >\ \lambda_2+\tfrac12=\ell_2\ >\ 0 ,$$

so $\ell$ is strictly dominant. A regular point meets the open chamber in exactly one element of its $W$-orbit, so $\mu+\rho\in W(\lambda+\rho)$ forces $\mu=\lambda$. **The strictness is automatic from $\rho$ having strictly decreasing, strictly positive entries, it is not observed on the table.** The block says this correctly.

**Step 4, conclusion.** $(C_2,C_4)$ separate *every* pair of distinct dominant $B_2$ weights. Consequently the joint eigenspace decomposition of $(C_2,C_4)$ acting on $\mathrm{Sym}^3(\mathcal W_5)$ **is** the isotypic decomposition, a statement that does not consult which $24$ blocks occur, and so is independent of [L83](../findings/sym3-blocks.md)'s table.

**This closes.** The label "forced, not measured" is correct for this statement, and I record that against the brief's expectation. It is also the only claim in the block that is independent of the table.

**The one place the argument needs an unstated input.** *Which* degree-four central element works. The block anticipates the objection itself (*"$C_2^2$ is a legal degree-four central element and separates nothing"*) and the answer is exactly the sentence it asserts without a source: the Gelfand invariants $C_{2k}=\mathop{\mathrm{tr}}(F^{2k})$ have Harish-Chandra images $p_{2k}(\ell)+(\text{lower})$, so the coefficient of $p_4$ in $\mathrm{HC}(C_4)=a\,p_4+b\,p_2^2$ is $a\neq0$. That is standard (Perelomov–Popov), but **[references/](../references/) holds no Harish-Chandra, Humphreys, Knapp or Perelomov–Popov entry**, I checked the index and grepped the tree. This is [conventions.md](../findings/conventions.md)'s own "Cartan's classification" pattern: a load-bearing classical fact cited nowhere. **D4.**

*A cheap repair that removes the dependency: Step 2 already says $\mathrm{HC}(Z)=\mathbb R[p_2,p_4]$, so **some** degree-$\le4$ central element has $p_4$ in its image; the existence of a separating quartic is forced regardless. Only the identification of the specific generator needs the citation.*

## 2. The $21$, and the three collisions, both reproduce exactly

I computed $c_2$ by hand over the $24$ weights of the table. $\lambda_1(\lambda_1+3)$ for $\lambda_1=0..6$ is $0,4,10,18,28,40,54$; $\lambda_2(\lambda_2+1)$ for $\lambda_2=0..6$ is $0,2,6,12,20,30,42$.

| block | $c_2$ | block | $c_2$ | block | $c_2$ |
| --- | --- | --- | --- | --- | --- |
| $(0,0)$ | $0$ | $(4,0)$ | $28$ | $(5,1)$ | $42$ |
| $(1,0)$ | $4$ | $(4,1)$ | $30$ | $(5,2)$ | $46$ |
| $(2,0)$ | $10$ | $(3,3)$ | $30$ | $(4,4)$ | $48$ |
| $(2,1)$ | $12$ | $(4,2)$ | $34$ | $(5,3)$ | $52$ |
| $(2,2)$ | $16$ | $(4,3)$ | $40$ | $(6,0)$ | $54$ |
| $(3,0)$ | $18$ | $(5,0)$ | $40$ | $(5,4)$ | $60$ |
| $(3,1)$ | $20$ | | | $(6,2)$ | $60$ |
| $(3,2)$ | $24$ | | | $(6,3)$ | $66$ |
| | | | | $(6,4)$ | $74$ |
| | | | | $(6,6)$ | $96$ |

Sorted: $0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$, **$24$ entries, three repeats, $21$ distinct. The count and the three named pairs reproduce.** Two internal anchors fall out for free: $c_2(2,2)=16$ and $c_2(2,1)=12$, which is the file's own opening $16$-against-$12$ separation of $[2,2]$ from $[2,1]$.

**The six $p_4$ values reproduce exactly, and in the order printed.** With $16\,p_4=(2\lambda_1+3)^4+(2\lambda_2+1)^4$:

| pair | $\ell$ | $16\,p_4$ | $p_4$ | block prints |
| --- | --- | --- | --- | --- |
| $(4,1)$ | $(\tfrac{11}2,\tfrac32)$ | $14641+81$ | $7361/8$ | $7361/8$ |
| $(3,3)$ | $(\tfrac92,\tfrac72)$ | $6561+2401$ | $4481/8$ | $4481/8$ |
| $(4,3)$ | $(\tfrac{11}2,\tfrac72)$ | $14641+2401$ | $8521/8$ | $8521/8$ |
| $(5,0)$ | $(\tfrac{13}2,\tfrac12)$ | $28561+1$ | $14281/8$ | $14281/8$ |
| $(5,4)$ | $(\tfrac{13}2,\tfrac92)$ | $28561+6561$ | $17561/8$ | $17561/8$ |
| $(6,2)$ | $(\tfrac{15}2,\tfrac52)$ | $50625+625$ | $25625/8$ | $25625/8$ |

The listing order matches the collision order stated one sentence earlier. **A consistency anchor the block does not claim**: $p_2(\ell)=c_2(\lambda)+\langle\rho,\rho\rangle=c_2+\tfrac52$, so the three colliding pairs must and do share $p_2=130/4$, $170/4$, $250/4$. That is a genuine second check on $\rho$, since a wrong $\rho$ breaks the shift.

**Conditionality.** The $21$, the pairs and the $p_4$ values are all downstream of [L83](../findings/sym3-blocks.md)'s $24$-weight list, which [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) found is a single imported column with one external anchor ($7770$). Their killer witness (swapping the two dimension-$35$ blocks' multiplicities), leaves L84's Casimir multiset unchanged, so **L84 cannot check the table and the table cannot check L84**. That is the brief's independence question, answered: *the forcing half is fully independent of the table; the $21$ half is not independent of it at all.* The list is nonetheless well supported by the four reviewers r663/r664 name and this block does not.

## 3. D1, the provenance clause is false

The block says: *"the $22$ this file carried came from a run made before $\rho$ was corrected to $(3/2,1/2)$."* Checked against `git`, in the order the brief asks:

| time (2026-08-28) | commit | what it did |
| --- | --- | --- |
| 12:11:37 | `ef8358a1` | creates [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) **with $\rho=(3/2,1/2)$** |
| 12:27:10 | `b432dfd7` | creates [findings/sym3-blocks.md](../findings/sym3-blocks.md) carrying "$22$" **and the three correct collisions at $30$, $40$, $60$** |
| 12:40:11 | `07c2a9dd` | commits [r177](REVIEW_r177.md), *"21 not 22"* |
| 12:40:15 | `86245c49` | the fix to $21$, adding the provenance clause, crediting reviewer 178 |
| 12:45:25 | `6da8eb27` | commits [r178](REVIEW_r178.md) |

Four independent reasons the clause fails:

- **No such run exists.** `git log --all -S'rhoB2'` returns exactly one commit, the script's creation, already at $(3/2,1/2)$. No script in [scripts/runs/](../scripts/runs/) has ever been committed at another $\rho$; [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) carries `RHO2 = (3, 1)`, which is $2\rho$ in doubled exponents, the same $\rho$.
- **The sentence refutes itself.** The "$22$" was introduced in the *same sentence* as the collision values $30$, $40$, $60$, which are the post-correction values. A pre-correction run would have produced different collisions, not the right ones with a wrong count. I screened two plausible wrong conventions, $\rho=(2,1)$ and $\rho=(3,1)$: each yields a *single* collision and $23$ distinct values, and neither reproduces the three named pairs.
- **Both cited reviews say otherwise.** [r177](REVIEW_r177.md) files it as *"Arithmetic slip … 24 − 3 = 21"*. [r178](REVIEW_r178.md) is explicit: *"The sentence also contradicts the script it cites two paragraphs earlier: run_casimir_separation.py prints 'c2 takes 21 distinct values across 24 blocks'."* Neither mentions a stale $\rho$.
- **Attribution.** The fix landed four seconds after r177's review was committed and five minutes before r178's. Reading the timestamps alone, r177 is the review the fix answers; r178 reached the same defect independently. The block credits 178 only. *This is an inference from commit times, not from anything I can see about who reported what in session.*

**So: the number is right, and the reason given for its having been wrong is manufactured.** The honest note is one line, *the $22$ contradicted the file's own cited script, which printed $21$; filed by [r177](REVIEW_r177.md) and [r178](REVIEW_r178.md) independently.*

**And the rest of the file is clean on this axis.** I checked every $\rho$-dependent number in [sym3-blocks.md](../findings/sym3-blocks.md): the $16$-against-$12$ opening, the collision values, the six $p_4$ values, and $c_2$ itself. All are post-correction. The neighbouring $32$, $8$, $8/3$, $4$ are normalisation rescalings of $16$ ($B_K=-6B$ giving $8/3$), not $\rho$ variations, and each is right. **No residual pre-correction number survives in this file.**

## 4. D2, "separates all $24$" is true, and is a check

Read literally, the heading claims the quartic *alone* separates the $24$. That is a different statement from what §1 proves, which is that the *pair* does. I screened the solo claim: with $a=2\lambda_1+3$, $b=2\lambda_2+1$, the $24$ values of $a^4+b^4$ are

$82,\ 626,\ 2402,\ 2482,\ 3026,\ 6562,\ 6642,\ 7186,\ 8962,\ 14642,\ 14722,\ 15266,\ 17042,\ 21202,\ 28562,\ 28642,\ 29186,\ 30962,\ 35122,\ 50626,\ 51250,\ 53026,\ 57186,\ 79186$,

all distinct. **So the heading is true.** But it is true by exhaustion over $24$ numbers, not by the Harish-Chandra argument, the general obstruction is real, since sums of two fourth powers are only unique below Euler's $635318657=133^4+134^4=59^4+158^4$, and nothing in the block's argument rules out a repeat. **A block headed "forced, not measured" therefore carries, in its own heading, a claim that is measured.** The body's display ($e_1=p_2$ and $e_2=(p_2^2-p_4)/2$), is unambiguously the two-generator statement, so heading and body disagree about what does the separating.

*Repair: the heading should read that the quartic completes the separation of all $24$, or the body should note that $p_4$ alone happens to suffice here by a range check.*

## 5. D3, what separation buys, and the file has already answered

The brief asks which downstream step needs the blocks separated, and whether it needs all $24$. **The file settles this below the block, twice, and the block does not know it.**

- **The purpose.** [sym3-blocks.md](../findings/sym3-blocks.md)'s opening: the SOS Gram is block-diagonal over the isotypic components of $\mathrm{Sym}^3(\mathcal W_5)$, and separation is what would let you *build* that decomposition, as joint eigenspaces of $(C_2,C_4)$ on the $7770$.
- **[L87](../findings/sym3-blocks.md) cuts it to one pair.** The orbit constraint kills the eight $\lambda_2$-even multiplicity-$1$ blocks. Of the three collisions, $(5,4)$ and $(6,2)$ both die, and $(5,0)$ dies leaving $(4,3)$ alone; only $(4,1)$/$(3,3)$ (both with odd $\lambda_2$), survives. I reproduced the whole chain by hand: the $16$ $\lambda_2$-even blocks have dimensions summing to $220+35+105+390+165+55+30+14+455+810+625+140+429+91+5+1=3570$ exactly, matching L87's cap, and the eight deaths are exactly L86's list. The cited script says it in its own last line, *"so the quartic is needed for ONE pair, not three."*
- **[L92](../findings/sym3-blocks.md) removes even that.** *"A weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$ by definition … The highest-weight construction therefore needs no Casimir to separate any block, colliding or not."*

**So on the route the file adopts, nothing downstream needs any Casimir separation, and the strongest surviving consumer would have needed it for one pair out of $24$.** L84's heading is stated at $24$ times the scope of its own file's largest need and at infinite multiple of its actual one. That is not a mathematical error (the theorem is a theorem) but the record reads as though L84 is load-bearing when [L92](../findings/sym3-blocks.md) retires it. **The block should carry a scope line saying so**, in the file's own idiom: the theorem stands; its consumer does not.

**The brief's last sub-question, should "Casimir separation" be treated as one thing?** No. The phrase carries three senses in this file: the opening's degree-two separation of $[2,2]$ from $[2,1]$ ($16$ against $12$); L84's "the degree-two gives $21$ of $24$, the quartic finishes"; and L92's heading, which by context means the surviving $c_2$ collision. They are compatible if read slowly, but the bare phrase is exactly what [conventions.md](../findings/conventions.md)'s rule on the letter $B$ (*"say which you mean, every time"*), exists to prevent. **Say "degree-two" or "quartic" at each use.**

## 6. Minor

- **$p$ carries two objects one paragraph apart.** The block writes $p_{2k}(\ell)$ for the power sums, then *"generated by $p^2+q^2$ and $p^2q^2$"* where $p,q$ are $\ell_1,\ell_2$. The generating set is correct (those are $e_1,e_2$ in the variables $\ell_i^2$, and $p_4=e_1^2-2e_2$) but the letter should not be reused inside the same paragraph.
- **"$Z(U(\mathfrak{so}(5)))$ **is** the ring of $W(B_2)$-invariants"**, it is isomorphic to it, via Harish-Chandra in the shifted variable. As written it elides the shift that Step 3 then relies on.
- **The block resolves no pointer.** It carries zero links: no [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) (the file's link to it sits in L83's section), no [REVIEW_r178.md](REVIEW_r178.md) for the reviewer it names, no [L87](../findings/sym3-blocks.md) or [L92](../findings/sym3-blocks.md) for the two blocks that bound its scope. Every neighbouring block in this file links its reviews. **Nothing is broken, there is nothing to break.**
- **[INDEX-results.md](../findings/INDEX-results.md) row 84 reads "Gate 2: no verdict on the record"** while [r177](REVIEW_r177.md) and [r178](REVIEW_r178.md) each contain a full independent derivation of the theorem. Same pattern [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) flagged on L83, *"which is why the index recorded no verdict while the evidence existed."*

## What I did not do

Nothing here required computation and none was run, per the standing analysis-only rule. All arithmetic above is by hand on objects I constructed to screen claims I was about to record: the $24$ $c_2$ values, the six $p_4$ values, the two wrong-$\rho$ screens in §3, the $24$-value distinctness screen in §4, and the $3570$ sum in §5. **None of it is offered as evidence for a positive claim**, the positive claim is §1, which is a derivation.

## Recommended edits

1. **Replace the provenance clause** with the true one: the $22$ contradicted the script the file itself cites, and was filed independently by [r177](REVIEW_r177.md) and [r178](REVIEW_r178.md).
2. **Split the heading's claim**: the pair $(C_2,C_4)$ separates all $24$ by theorem; $p_4$ alone also does, by a check.
3. **Add the scope line**: [L87](../findings/sym3-blocks.md) reduces the need to one pair and [L92](../findings/sym3-blocks.md) removes it, so the theorem stands with no consumer on the current route.
4. **Cite the Harish-Chandra leading-term fact**, or reroute around it via the $\mathbb R[p_2,p_4]$ statement the block already makes.
5. **Name the degree at every use of "Casimir separation".**

**The label `Lemma` is correct and should stay.** The mathematics is a theorem, proved, at every $n$ where $B_r$'s $\rho$ is strictly positive, not an `Observation` at $n=5$. What is measured is the heading's incidental solo-quartic clause, not the result.
