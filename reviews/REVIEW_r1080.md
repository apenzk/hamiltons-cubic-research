# Review r1080: Gate 2 on the unreachable-top gate, the novelty withdrawal, and the plan rewrite

**Reviewer r1080**, cold brief, on `c3c708f8`, `9986d7d2`, `18580453`, `f6c75c75`, `983ad608`. Log: [agent_logs/r1080-gate.log](../agent_logs/r1080-gate.log). *Analysis-only footing. Every figure below is a screen on objects already in hand: `_unreachable_top` imported and run against the live `plan.md`, its pre-rewrite version, and eight synthetic copies, seconds of arithmetic in total. No sweep, census or unbounded hunt was opened.*

**ONE READER IS RIGHT FOR FOUR OF THE FIVE.** *G1, G2, G4 and G5 are each a comparison against something already fixed: a function against the behaviour asserted of it, a withdrawal against its source, a rewrite against the sweep it answers.* **G3 IS DIFFERENT AND IS FLAGGED AS SUCH**: the reading of `attackable` it defends is an argument about a grade, that grade decides the gate's output, and the sweep's own justification for it points two ways at once. *That one wants a second reader or the user.*

| claim | what it says | verdict |
|---|---|---|
| G1 | `_unreachable_top` fired before the plan rewrite and returns `None` after it | **CONFIRMED**, both halves reproduced. The closers list carries a third item the commit message omits |
| G2 | the gate prescribes the right action in all three cases, both branches tested | **CONFIRMED**, both branches reproduced on the plans described |
| G3 | `attackable` $\ge2$ IS the route existing, by the rubric's scale | **CONFIRMED as a reading of the rubric**, and **the grade it is applied to is under-determined**: the sweep argues for $2$ from two premises, one of which gives $1$ and the other $3$ |
| G4 | the withdrawal in `c3c708f8` is correct and does not over-concede | **CONFIRMED**. One wording correction: r1069 carries a display two lines from the second bound, rather than the bound itself |
| G5 | the plan rewrite answers the sweep and carries the fence posts forward | **PLAUSIBLE on the sweep, REFUTED on the carry-forward**: the route register pointer was deleted, and R-A, R-B and R-C have no rows in [routes.md](../routes.md) |

**AND THE FINDING THE BRIEF EXPECTED IS REAL, IN THREE FORMS RATHER THAN ONE.** *Section A below. Two of them return `None` on zero parsed rows. The third parses twenty-one rows, mis-reads every one of them, and still returns `None`.*

---

## A: THE SILENT-FAILURE MODE, CONFIRMED, AND IT IS WIDER THAN `if not rows`

**Three edits to `plan.md` disable the gate with no output of any kind.** *Each was applied to a copy of the live file and `_unreachable_top` run against it.*

| drift applied to the live `plan.md` | rows parsed | `_unreachable_top` |
|---|---|---|
| the item ids in the table no longer bolded, `\| I73 \|` for `\| **I73** \|` | $0$ | `None` |
| one non-numeric column inserted between `moves` and `closes` | $0$ | `None` |
| one NUMERIC column inserted between `closes` and `attackable` | $21$, **every one mis-read** | `None` |

**THE THIRD IS THE WORST AND THE BRIEF NAMED IT EXACTLY.** *The regex has no anchor after the `moves` cell, so an inserted numeric column shifts the whole read one place left: `attackable` is read from the new column, `margin` from `attackable`, and `value` from `analytic`, which is $1$ on every live row.* **Every row then grades $1$, the argmax is whichever row comes first, and that row is `I73` at `closes` $3$, so the gate returns `None` and says nothing.** *A mis-parse producing plausible numbers, and the plausible numbers happen to be the answer that keeps the gate quiet.*

**A FOURTH, MILDER FORM: the gate TRUSTS the printed `value` and never recomputes it.** *Changing `I111`'s printed value from $4$ to $8$ and nothing else makes `I111` the top of the table and FIRES the gate, on a table whose own four factors multiply to $4$.* **So a one-character typo in a column the gate does not check moves the gate's verdict**, in either direction.

### The smallest fix that makes an unreadable table LOUD, tested against every fixture above

**Two changes to `_unreachable_top`, both inside the function, plus one branch in `main()`.** *The second is what catches the shifted-column case, and it costs one multiplication per row.*

```python
    rows, bad = [], []
    for m in ROW.finditer(text):
        ident = m.group(1)
        closes, attack, margin, analytic, value = (int(g) for g in m.groups()[1:])
        if closes * attack * margin * analytic != value:
            bad.append(ident)
        rows.append((ident, closes, attack, value))
    # THE TABLE IS THE GATE'S ONLY INPUT, so a table it cannot read is a LOUD failure.
    if not rows:
        return ("PARSE", "matched NO rows")
    if bad:
        return ("PARSE", "value disagrees with closes x attackable x margin x analytic on "
                + ", ".join(bad))
    top = max(rows, key=lambda r: (r[3], r[1]))   # ties go to the item that CLOSES
```

*`main()` then tests `unreach[0] == "PARSE"` first and prints the grade table as unreadable, naming `plan.md` and the function, rather than falling through.*

**Verified against all eight fixtures**: `None` on the live plan, fires unchanged on the pre-rewrite plan, and `PARSE` on all four drifts above. *The `(value, closes)` key also fixes hunt item 3, below.*

**One consequence to accept before applying it.** *The synthetic copy `18580453` used to test the second branch bumped `I73`'s `attackable` to $2$ without changing its printed `value`, so under this patch that fixture reports `PARSE` instead.* **That is the patch working**: a table whose value column disagrees with its own product is a table no gate should rank.

## B (hunt item 2): the regex DOES match the live table, and the column order it assumes is right

**Twenty-one rows parse, and on every one the printed `value` equals `closes` $\times$ `attackable` $\times$ `margin` $\times$ `analytic`.** *That product check is the independent confirmation that the read is aligned, since a shifted read breaks it on every row at once, as section A shows.* **The header is `item · moves · closes · attackable · margin · analytic · value` and `(?:[^\|]*\|){1}` consumes exactly the `moves` cell**, which holds no pipe on any live row, every occurrence of a bar in the mathematics being written `\lvert … \rvert`.

**The gate reads `I73` $(3,2,1,1,6)$, `I111` $(2,2,1,1,4)$, `I36` $(3,2,1,1,6)$**, which is the rewrite's stated intent exactly.

## C (hunt item 3): the tie is broken by ROW ORDER, and the gate's own opening sentence goes false

**`max(rows, key=lambda r: r[3])` returns the FIRST maximal row, so the verdict depends on where a row sits in the file.** *Constructed: move `I111` above `I73` and give it value $6$, tying the two closers. The gate FIRES, on `I111`, and prints* **"THE TOP OF THE GRADED TABLE DOES NOT TOUCH THE OPEN STATEMENT"** *while `I73` and `I36`, at the same value, score $3$ on `closes`.* **The sentence is false in that state and the table alone cannot be read to make it true.**

**The prescription survives, because `routed` then redirects to `I73` and `I36`** *(both at `attackable` $2$)*, **so the damage today is a false sentence rather than a wrong action.** *It stops being benign the moment the tied closer sits at `attackable` $1$: the gate then says "invent a route" while naming, in the same message, a closer tied for the top.*

**AND THE LIVE TABLE IS NOT SORTED BY VALUE**, $6$, $4$, $6$ down its first three rows, *which [the skill](../.claude/skills/research-loop/SKILL.md) requires and which is what makes the rewrite's "`I36` ranks below `I73`" unreadable to anything but a human.* **`key=(value, closes)` makes the decision order-independent and is one line.**

## D (G1, G2): both fire conditions reproduce, and the message names one closer more than the commit does

**Pre-rewrite** (`plan.md` at `9986d7d2`): `_unreachable_top` returns

```
('I111', 6, 2, [('I73', 3, 1), ('I36', 3, 1), ('I7', 0, 0)], [])
```

**so `routed` is empty and the gate says step 9, as claimed.** *The commit message says the gate "returns I111 (value 6, closes 2) against I73 and I36 at value 3" and omits* **`I7`**, *which scores `closes` $3$ and is therefore in the printed list of "the only items that would close it outright", at value $0$ and `attackable` $0$.* **That is the destination item, marked *no route known*, and naming it beside two items with the same `closes` and a real grade reads as an oversight rather than an inclusion.** *A closer at `attackable` $0$ is one the rubric says cannot be worked at all, and the message gives the reader no way to tell it apart.*

**Post-rewrite** (live `plan.md`): returns `None`. **CONFIRMED.**

**The second branch reproduces on the plan the commit describes.** *Pre-rewrite copy with `I73` bumped to `attackable` $2$:*

```
('I111', 6, 2, [('I73', 3, 2), ('I36', 3, 1), ('I7', 0, 0)], [('I73', 3, 2)])
```

**`routed` is `[I73]` and the gate prescribes working it rather than step 9**, which is the fix `18580453` claims. *The third case, no closers at all, is unreachable on any plan whose table holds a `closes` $3$ row and was not constructed.*

**The correction `18580453` makes is real and the diagnosis in its message is right**: the first version encoded "the top does not close, therefore no route exists", *which is a different proposition, true on that plan by accident.*

## E (G3, hunt item 4): the reading is right, the grade under it is not settled, and the gate turns on it

**G3 is CONFIRMED against the rubric's text.** *[The scale](../.claude/skills/research-loop/SKILL.md) reads $3$ a route exists and is untried $\cdot$ $2$ a route exists and is partly spent $\cdot$ $1$ a route must be invented $\cdot$ $0$ every named route is closed.* **Both $3$ and $2$ assert a route exists and neither $1$ nor $0$ does, so `attackable` $\ge2$ is the route existing, exactly as `18580453` states.**

**HUNT ITEM 4 ASKED WHETHER A PARTLY-SPENT ROUTE CAN BE SPENT TO EXHAUSTION, AND THE RUBRIC ALREADY ANSWERS IT**: exhaustion is "every named route is closed", which is $0$. *A route spent to exhaustion that is still carrying a $2$ is a mis-grade rather than a gap in the gate's reading.*

**AND THERE IS A LIVE INSTANCE.** *[I111](../plan.md)'s row scores `attackable` $2$ and its item body reads* **"Owed: lifting the equal-$N_i$, equal-$u$ ansatz … No named route yet; `attackable` $2$ because the ansatz half is spent."** *A route with no name is $1$ by the scale, "a route must be invented". The $2$ is scored on the observation that some WORK is done, and the scale measures whether a ROUTE remains, not how much work has been finished.* **`I111` should read $1$, value $2$ rather than $4$.** *It changes nothing today, `I111` being no closer, and it is the exact confusion hunt item 4 anticipated.*

### THE GRADE THAT SILENCED THE GATE IS THE ONE THE SAME TURN WROTE, AND THE SWEEP ARGUES FOR IT FROM TWO INCOMPATIBLE PREMISES

**[The sweep](2026-09-23-LIT-step9-sweep.md) justifies R-A's `attackable` $2$ in one sentence**: *"Scored `attackable` $2$ and not $3$, because the reformulation is untried while the underlying question has ten spent sweeps, and the rubric scores the item rather than the restatement."*

- **Read as "the rubric scores the item"**, the item is [I73](../plan.md), whose every named route was closed, whose row said `attackable` $1$ and whose heading said **THE DESTINATION, NO ROUTE KNOWN, after ten sweeps**, and nothing about the item changed on 2026-09-23. *That reading gives $1$.*
- **Read as "the reformulation is untried"**, R-A is a route, it exists, and no part of it has been run. *That reading gives $3$.*
- **$2$ is the average of two readings, and neither produces it.**

**WHAT TURNS ON THE DIGIT IS THE GATE'S OUTPUT.** *With `I73` and `I36` returned to `attackable` $1$ and value $3$, which is the grade they carried until this rewrite:*

```
('I111', 4, 2, [('I73', 3, 1), ('I36', 3, 1), ('I7', 0, 0)], [])   # step 9, again
```

**So the gate built this session to catch a plan that cannot reach its goal is silenced by a one-digit regrade written into the same file it reads, by the turn it was built to constrain, on a justification that contradicts itself.** *Neither the gate nor the patch in section A can see this: the product is consistent, the parse is clean, and the table is honest about what it says.*

**THE READING THAT SAVES THE GRADE IS AVAILABLE AND IS NOT THE ONE THE SWEEP GIVES.** *[I73](../plan.md)'s rewritten item carries three ordered sub-steps: list the record's identities on $W^\#$, ask whether [L24](../findings/second-order.md) forces $\langle W^\#,X\rangle=0$ for $X\perp\operatorname{span}\{W,\mathrm{Id}\}$, and if not find the smallest $X$ it does not force.* **A named mechanism with a concrete first step IS a route by the scale**, *so `attackable` $\ge2$ holds and the gate is right to be quiet.* **The correct grade on that reading is $3$, untried, value $9$**, and the gate stays quiet either way. *What the record should NOT keep is the stated justification, which is the one reading under which the grade is $1$.*

**This is the item that wants a second reader**, being an argument about a grade rather than a comparison against a fixed text, and the grade decides whether the loop's next action is step 9 or [I73](../plan.md).

## F (G4): the withdrawal is CORRECT, correctly scoped, and over-concedes nothing

**[r1069](REVIEW_r1069.md)'s line 45 carries the display the withdrawal cites**, verbatim:

$$\sum_a\cos^2\psi_a\ \ge\ \frac{5(3u^2-t)}{2u^2},$$

*and $\tfrac{5(3u^2-t)}{2u^2}=\tfrac52\big(3-\tfrac t{u^2}\big)=\tfrac52K$ identically.* **With $\sum_am_a^2\le3M^2$ at $M=\max_a\lvert c_a\rvert$ this gives $3M^2\ge\tfrac52K$, so $M\ge\sqrt{5K/6}$**, *and [r1070](REVIEW_r1070.md)'s own line reads "minimising $\max_ag$ subject to $\Phi\ge K$ puts every $c_a$ at the same value, so the optimum solves $\tfrac65\cos^2(\tfrac{2\pi}3+\alpha)=K$", i.e.* $\lvert c\rvert=\sqrt{5K/6}$. **The same number, so the same bound, and the twelve digits are a tautology once the identification is granted rather than five independent checks.**

**AND THE STEP IS EXACTLY TIGHT WHERE IT IS USED, WHICH IS WHY THEY COINCIDE.** *$\sum m^2\le3M^2$ is lossy in general and an equality precisely when all $\lvert c_a\rvert$ agree, which is r1070's minimiser.* **So the two bounds do not merely agree numerically, they are one bound reached by two routes.**

**The sentence the withdrawal retracts is FALSE and the withdrawal is right to retract it.** *[r1069](REVIEW_r1069.md)'s "What a successor should take" names two items, the $\mathcal D_n$ scalar shadow against $\Theta_n$ at $n=12$ and the three direction equations under its shape parameterisation.* **Neither is the Gram bound.**

**WHAT SURVIVES IS THE EVALUATION, AND THAT HALF STANDS.** *Neither [r1069](REVIEW_r1069.md) nor [r1070](REVIEW_r1070.md) contains the ratio at all: no occurrence of $1.014$ in either file. r1069 screened the direction bound alone to $0.202$ and sampled the Gram confinement at three points, and r1070 carries a $-$ branch column.* **Neither computed the minimum of the maximum over the region, so "which neither reader computed" is accurate and the withdrawal concedes nothing it did not have to.**

**ONE WORDING CORRECTION, and it is the direction these corrections usually go.** *`c3c708f8`'s subject line reads* **"r1069 carried both bounds"** *and the note says* **"r1069 held BOTH bounds"**. *What r1069 holds is a display two short steps from the second bound, the identification $\alpha_a=u_a\cos\psi_a$ being its own and $\sum m^2\le3M^2$ being one line more.* **[r1079](REVIEW_r1079.md)'s phrasing is the exact one, "two lines of Cauchy–Schwarz from a display r1069 already carries", and the record should use it.** *The conclusion is unchanged, the combination sitting inside one review either way.*

## G (G5): the rewrite ANSWERS the sweep, and LOSES the route register pointer

**What the rewrite gets right, checked against [the sweep](2026-09-23-LIT-step9-sweep.md) line by line.**

| the sweep says | the plan says | |
|---|---|---|
| R-A value $6$ (`closes` $3$, `attackable` $2$), the pick, work it first and alone | [I73](../plan.md) at value $6$ $(3\times2\times1\times1)$, **PRIMARY, route R-A** | matches |
| R-C value $4$, second, a bound on the same cubic | **FALLBACK, route R-C** | matches |
| R-B value $3$, a research programme, not opened until R-A is settled | **HELD CLOSED, route R-B** | matches |
| R-A falsified by a critical point outside the span above $\sqrt{3/2}$, or a proof the span condition is strictly stronger | both carried, and the second is also written as the abandon condition | matches |
| [L105](../findings/bounds-relaxations.md) closes P from R-A | carried in the item's theorem line | matches |

**[I36](../plan.md) inherits the route and [I111](../plan.md) drops to $4$, both as claimed.** *[Post F73](../findings/fence-posts.md) is carried into [I73](../plan.md)'s item with the reason it does not bar R-A, and [post F75](../findings/fence-posts.md) into [I111](../plan.md)'s.* **The dropped `F74` citation was a MIS-citation and losing it is a gain**: F74 in [fence-posts.md](../findings/fence-posts.md) is the $\mathcal D_n$ ceiling missing $n=11$, not the $-$ branch shortfall the old [I111](../plan.md) line hung on it.

**The Gate 2 ledger pointer is untouched**, *[LEDGER.md](../findings/LEDGER.md) still named as sole owner of the debt and every landed verdict.* *(The "NOTHING IN FLIGHT as of 2026-09-19" line above it is stale against three commits now owing Gate 2, but the rewrite neither wrote nor touched it.)*

### THE ROUTE REGISTER POINTER WAS NOT CARRIED FORWARD, AND THE COMMIT SAYS IT WAS

**`983ad608`'s message states "Fence posts, the route register pointer and the Gate 2 ledger are untouched." The middle one is FALSE.** *The rewrite deletes both of these lines and replaces neither:*

- **"[routes.md](../routes.md) owns every route's mechanism, rungs, abandon condition and clearance criteria, live or closed, and is read whole before any route is proposed."** *That sentence IS the register pointer and it is now absent from `plan.md`.*
- **"The primary route is [R27](../routes.md) … The fallback is [R17](../routes.md)."**

**AND THE NEW ROUTES ARE NOT IN THE REGISTER AT ALL.** *[routes.md](../routes.md) holds `R1` to `R29` and its `NEXT ROUTE ID` line still reads `R30`, unspent. `R-A`, `R-B` and `R-C` appear nowhere in it.* **[plan.md](../plan.md)'s own identifier standard says routes take `R<n>` and are owned by [routes.md](../routes.md)**, *and every previous step-9 choice, R24 through R29, took a number and got a row carrying its mechanism, what it needs, and what closes it.* **The programme's current primary route has none of that.**

**SO `plan.md` NOW NAMES TWO DIFFERENT PRIMARIES AND THE REGISTER NAMES A THIRD.** *Line 32 says R-A. Line 42, a blockquote the rewrite left standing, says* **"the primary is [R24](../routes.md) as stated above, with [R23](../routes.md) demoted … and [R17](../routes.md) the fallback"**, *and the words "as stated above" now point at a sentence that was deleted.* *[routes.md](../routes.md) itself marks R25, R27 and R28 LIVE and R24 reserve, with nothing naming R-A.* **The stale blockquote predates the rewrite. What the rewrite did was remove the correct line standing beside it, leaving the wrong one alone.**

**THE REPAIR, and it is small.** *Register R-A, R-B and R-C as `R30`, `R31`, `R32` in [routes.md](../routes.md) with the sweep's mechanism, what running it takes and what falsifies it, increment the `NEXT ROUTE ID` line, restore the ownership sentence to [plan.md](../plan.md), and rewrite the line-42 blockquote to name the new primary.* **Until that lands, the sweep file is the only place R-A's mechanism is written, and `plan.md` points a reader at a register that has never heard of it.**

---

## What this round asks for, in order

1. **Apply section A's patch.** *Three ways to disable the gate silently, one of which survives a full mis-parse, against a gate whose whole purpose is to speak up. Tested on eight fixtures.*
2. **Register R-A, R-B and R-C in [routes.md](../routes.md) and repair [plan.md](../plan.md)'s two route-pointer lines.** *Section G. Both owners are in this session.*
3. **Settle [I73](../plan.md)'s `attackable` at $3$ or at $1$ and rewrite the justification.** *Section E. It is a second reader's question or the user's, and the loop's next action hangs on it.*
4. **Correct "r1069 carried both bounds" to r1079's phrasing.** *Section F.*
5. **Regrade [I111](../plan.md) to `attackable` $1$, value $2$.** *Section E. "No named route yet" is a $1$ by the scale.*
6. **Drop `I7` from the gate's closers list, or mark it.** *Section D. A closer at `attackable` $0$ cannot be worked and should not read like one that can.*
