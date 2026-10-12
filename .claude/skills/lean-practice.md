# Adding a machine-checked file

**Shared by every loop that formalises a result.** A loop's own skill says *when* to write one; this says *how*, so the three do not each carry a copy that drifts.

## What the file is for

**It proves the arithmetic and names the rest.** A record's results rest on two kinds of claim: things a kernel can settle (identities, inequalities, counts, closed forms) and things it cannot, which arrive as geometry, representation theory or a cited theorem. **The file's value is the boundary between them**, drawn precisely, so a reader knows which half is checked.

**So the owed line names the specific fact, never the field.** *That this operator is algebraic at this dimension* is an import a reader can go and check. *The geometry* is a shrug. **An import named vaguely is indistinguishable from one nobody has looked at.**

**And the owed line is checked against what the file itself proves.** A result whose consuming step is formalised owes only its inputs. An owed list that overstates hides how close a result is, which is as much a defect as one that understates.

## Before writing anything

**Search the layer for the name and the constant.** A file may already exist under a different subject, or the same closed form may sit in a neighbouring result. Grep for the definition's name *and* for its most distinctive coefficient, searching by subject alone misses a proof filed elsewhere.

**Read the target before writing to it.** A file that exists may be stronger than the replacement: stated over a larger field, carrying a biconditional where the new one has an inequality, and imported by something else. Overwriting without reading is recoverable only by luck.

**Search the library before deriving.** A standard lemma under an unfamiliar name is the common case, and a proof rebuilt by hand is longer, weaker and unreviewed.

## Statements that survive a kernel

**Prefer division-free and squared forms.** Cross-multiply an inequality between quotients rather than reasoning about the quotients; compare squares rather than roots. A statement carrying no radical needs no positivity side conditions and no approximation.

**Bracket a decimal by squaring.** To pin an irrational against a printed figure, state that the figure's square brackets the exact rational. **The bracket is then an exact rational inequality** and the irrational never enters.

**Carry rationals as rationals.** A value derived as a fraction stays one; a decimal introduced for readability is a second object that must then be related back.

## A statement no input can falsify is not a statement

**Before the build, read each new statement and ask what would make it false.** If nothing would, it is padding standing where the file wanted a claim, and it will read as proved.

The forms that recur:

- an identity between syntactically equal sides, discharged by reflexivity;
- a disjunction whose second branch is trivially true;
- a proof term that is its own hypothesis, or a hypothesis applied to its own arguments;
- **an existential over propositions discharged by supplying truth values**, provable for any statement whatever, and the form that survives a naive search.

**Grep for these before building, not after.** The check is mechanical where the shapes are literal, and every hit is a prompt to read rather than a verdict: the same syntax appears legitimately in a witness for a genuine existence claim, and in destructuring a hypothesis. **A tautology assembled from a proposition and its negation matches no literal pattern**, so read the proof terms as well as searching them.

**When the file wants a structural claim the language cannot express**, take the unformalisable part as a hypothesis and prove what follows from it. That is honest and checkable; a tautology in its place is neither.

## Working the build

**Let the kernel adjudicate.** A tactic that closes a goal outright makes a trailing simplification an error, and one that leaves a side condition needs it supplied, which of these happens is not reliably predictable, so build and read the message rather than reasoning about it in advance.

**ITERATE WITH `lake env lean <file>`, NEVER WITH A BUILD.** *Every `lake build` freshness-checks the entire job graph, Mathlib included, and pays that floor with nothing to compile; naming one module does not avoid it.* **`lake env lean` skips the graph and elaborates the file against the prebuilt `.olean`s, so an error arrives in seconds rather than minutes.** *The gap is the slowest step in the round against the fastest, paid on every iteration.* **Leave `lake build` to the pre-commit hook, which launches it in the background after every commit staging `lean/`.**

**NOTHING COMPILES AT COMMIT TIME, SO CHECK THE MODULE WITH `lake env lean <file>` BEFORE COMMITTING IT.** The hook's background tree build writes `/tmp/lean_tree_build.log`: read its errors before the next Lean commit, and fix any there in that commit.

**EVERY LEAN INVOCATION (`lake build`, `lake env lean <file>`, bare `lean`) AND EVERY COMMIT STAGING `lean/` RUNS IN THE BACKGROUND, WITHOUT EXCEPTION, AND SO DOES ANY WAIT FOR ONE (`until ! pgrep -x lake ...`).** *A foreground one holds the session for as long as it lasts, and a full build here outlives any timeout that can be set*, so the user cannot be answered at all until it ends. **A single-file check is no exception: it hides behind the lake wait in front of it and hangs as readily.** **There is no case where a foreground build is the right call**, and the exceptions invented for one ("just this segment", "the cache is warm now", "only one file") are how the session became unreachable five separate times.

**ONE BUILD AT A TIME.** *Lake takes no cross-process lock on its build directory*, so two invocations compile the same module to the same `.olean` and each halves the other's cores. **THIS IS GATED**, in [mechanical_check.py](../hooks/mechanical_check.py), which refuses any `lake build`, `env` or `exe` while one is live. **AND KILLING A PARENT SHELL ORPHANS ITS CHILDREN RATHER THAN STOPPING THEM**: clear the tree with `pkill -9 -P <pid>`, then confirm with `pgrep -fl lake` that nothing survived.

**AND A TASK LISTED AS RUNNING IS NOT EVIDENCE THAT ANYTHING IS.** *The task list shows a shell until it exits, not the work inside it*, so a killed build leaves an entry reading `Running 47m` with no compiler alive behind it. **AND KILL A DEAD ENTRY WITH `TaskStop` RATHER THAN LEAVING IT**, since a list of stale rows is what makes a live one impossible to spot, *and asking the user to clear them is handing over work the tool does in one call.* **CHECK THE PROCESSES, NOT THE LIST**: `pgrep -fl "bin/(lake (build|env)|lean /)"` counts live compilers, the path anchor keeping the editor's own `lake serve` and `lean --server` out of the count, and zero means nothing is happening whatever the list says. *Reading the list as liveness cost this session four wrong diagnoses, including a withdrawn gate and a reverted retirement.*

**A `Base/` EDIT COSTS A FULL REBUILD, SO BATCH THEM AND PREFER A LEAF.** *Nearly everything imports the base layer, so changing one file there invalidates every module downstream; `lake` is already incremental and there is nothing to tune, the cost is in WHAT is edited and HOW OFTEN it is committed.* **Two economies, both entirely in the author's hands.**

**Commit several `lean/` changes together rather than one at a time, and the number is why.** *A NO-OP `lake build` here costs about EIGHT AND A HALF MINUTES*, freshness-checking nine thousand jobs with nothing to compile, **so every commit staging `lean/` has that floor whatever it contains.** *The cost is PER COMMIT rather than per file changed*, which makes batching worth far more than it looks: five separate commits of one lemma each pay forty minutes where one commit of five pays eight. **Measure the no-op before assuming a slow commit means a real rebuild**, since the two are indistinguishable from the outside and the floor is most of it.

**And put a new lemma in a LEAF module where it has one consumer.** *A helper that only its neighbour needs does not belong upstream of the whole tree*: a new file imported by that neighbour alone rebuilds the neighbour and nothing else, where the same lemma in a base file rebuilds everything.

**THE BUILD'S OWN LOG IS THE THING TO READ FIRST.** *The background tree build writes `/tmp/lean_tree_build.log` and it survives*, so a build that appears to hang is diagnosed by reading that file rather than by inference from silence. **A log with zero `error` lines is a build that was succeeding when it stopped**, which is a different problem from a build that failed.

**AND A BACKGROUNDED BUILD THAT HAS PRINTED NOTHING IS UNFINISHED, NOT DEAD.** *The gate above was withdrawn once on exactly that misreading, an empty log and a `pgrep` returning nothing taken together as a dead process, when the same commit landed cleanly some minutes later.* **Neither an empty log nor a quiet process table is evidence of failure**, and the cost of believing they are is a withdrawn fix and a false report of progress.

**Supply the product a nonlinear step needs.** An arithmetic tactic will not find a factorisation on its own; give it the positive product, or the square, that the inequality turns on.

**Never leave a gap marker in a committed file.** An unproved step under a theorem that looks proved is worse than an open entry on the owed list, because the list is honest about what is missing and the marker is not.

**Nothing that bypasses the kernel.** A result the kernel did not check is a measurement wearing a proof's authority.

## What the file records

**Each derived constant is a theorem, never only a comment.** A number in prose is a claim nobody checked; the same number as a statement is one the kernel did.

**Say which values were checked and which hold generally.** A closed form proved for all parameters and one verified at three dimensions are different claims, and a file that does not distinguish them invites the stronger reading.

**Quote the record verbatim or not at all.** A span presented as a quotation must be findable in the record; a phrase the file coins to name a hypothesis is marked differently, and a paraphrase as neither. Without that distinction no audit of the file's citations can run.
