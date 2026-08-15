# Skill Catalog

This catalog lists the destination skills currently available in this repository. `think-router` must only recommend skills from this catalog and must not recommend itself.

## critical-thinking

- Directory: `skills/critical-thinking`
- Invocation: `$critical-thinking`
- Best for: views, claims, arguments, decisions, public statements, interpretations, or observed phenomena where the user wants to judge whether a conclusion is well supported.
- Method: practical critical thinking based on making the claim visible, separating facts from opinions and values, mapping reasons and evidence, testing evidence quality, surfacing assumptions and ambiguity, checking bias/rhetoric/fallacies, steelmanning opposition, and calibrating the final judgment.
- Interaction style: guided evaluation. The assistant asks for a concrete view or phenomenon first, clarifies the main claim, examines support and weaknesses, then produces a calibrated conclusion and next evidence to check.
- Use when the user says things like:
  - "Help me analyze whether this view is reasonable."
  - "Is this argument well supported?"
  - "I want to think critically about this phenomenon."
  - "What assumptions or biases are hidden in this claim?"
  - "Should I accept, reject, narrow, or suspend judgment on this conclusion?"

## beautiful-question

- Directory: `skills/beautiful-question`
- Invocation: `$beautiful-question`
- Best for: complex, vague, or surface-level problems where the user needs to find the real question before solving.
- Method: Warren Berger's Why / What If / How arc from *A More Beautiful Question*, strengthened with Toyota-style 5 Whys.
- Interaction style: guided conversation. The assistant asks one deeper question at a time, helps uncover a root question, expands solution hypotheses, ranks feasible options, and turns one chosen option into an implementation plan.
- Use when the user says things like:
  - "I do not know what the real problem is."
  - "Help me clarify this issue."
  - "I want to think more deeply before choosing a solution."
  - "This problem feels vague or shallow."
  - "Guide me from problem definition to an action plan."

## first-principle

- Directory: `skills/first-principle`
- Invocation: `$first-principle`
- Best for: problems, strategies, products, personal decisions, or innovation work where the user needs to strip away inherited assumptions and rebuild from a deeper base premise.
- Method: first-principles thinking distilled from Li Shanyou's *第一性原理*: expose induction, comparison thinking, continuity assumptions, and group beliefs; identify the system's hidden "one"; rebuild through deduction; validate by logical consistency and falsification.
- Interaction style: guided thinking training. The assistant frames the current system, asks one assumption-breaking question at a time, proposes candidate first principles, derives a new model, and turns it into a small test.
- Use when the user says things like:
  - "Help me think from first principles."
  - "What is the hidden assumption behind this strategy?"
  - "We are copying competitors and need a breakthrough."
  - "I want to rebuild this problem from the bottom up."
  - "What is the real 'one' behind this system?"

## deepthink-5so

- Directory: `skills/deepthink-5so`
- Invocation: `$deepthink-5so`
- Best for: phenomena, trends, events, signals, behaviors, policies, or decisions where the user wants to infer what they may eventually lead to.
- Method: 5So consequence-chain thinking. Repeatedly ask "so what?" or "so then what?" to move from surface result to shallow result, deep result, deeper result, and a useful terminal or low-probability endpoint.
- Interaction style: guided forward inference. The assistant frames the phenomenon, asks one consequence question at a time, tracks probability and impact, branches only when uncertainty matters, and stops when the next layer no longer gives practical guidance.
- Use when the user says things like:
  - "What could this phenomenon eventually lead to?"
  - "Help me use 5So to think deeper."
  - "So what happens next if this trend continues?"
  - "What are the second-order consequences of this decision?"
  - "At what point should this inference chain stop?"

## system-thinking

- Directory: `skills/system-thinking`
- Invocation: `$system-thinking`
- Best for: complex, recurring, cross-functional, delayed, or stakeholder-heavy problems where isolated single-point analysis misses important relationships.
- Method: systems thinking based on five elements: variables, causal chains, reinforcing loops, balancing loops, and delay effects, with attention to problem/issue, causes, results, entities, and stakeholders.
- Interaction style: guided system mapping. The assistant defines the system boundary, identifies stakeholders and variables, maps causal chains, finds feedback loops and delays, then evaluates leverage points or plan feasibility.
- Use when the user says things like:
  - "Help me analyze this as a system."
  - "This issue keeps recurring and I do not know why."
  - "Is this plan feasible if we consider the whole system?"
  - "What feedback loops are driving this problem?"
  - "What variables, stakeholders, and delays am I missing?"

## coding-art

- Directory: `skills/coding-art`
- Invocation: `$coding-art`
- Best for: writing, reviewing, refactoring, designing, debugging, or optimizing code when principled software engineering judgment is needed.
- Method: 66 programming craft principles distilled from *Code Complete 2* and *The Art of UNIX Programming*, organized across complexity management, modularity, naming, function design, defensive programming, interfaces, testing, optimization, and engineering practice.
- Interaction style: practical engineering critique or guidance. The assistant applies the relevant principles to the user's code, design question, or tradeoff, and cites principle numbers when useful.
- Use when the user says things like:
  - "Review this code for quality risks."
  - "How should I refactor this module?"
  - "Is this interface design reasonable?"
  - "Help me improve naming, structure, or complexity."
  - "What programming principle applies here?"

## deep-study-coach

- Directory: `skills/deep-study-coach`
- Invocation: `$deep-study-coach`
- Best for: substantial learning goals, ineffective-learning problems, knowledge-to-practice gaps, or existing learning work where the user wants to verify understanding, improve transfer, diagnose failure, or maintain progress across sessions.
- Method: a staged deep-study cycle covering preparation, active input, closed-source reflection, near-to-far transfer, output or practice, feedback diagnosis, and retrieval-based review.
- Interaction style: evidence-based learning coaching. The assistant selects full-cycle, stage-focus, diagnosis, or lightweight mode; assigns one bounded task at a time; checks stage evidence; and routes failures to the earliest stage that can repair them.
- Use when the user says things like:
  - "Help me design and execute a learning plan, not just list resources."
  - "How can I tell whether I genuinely understand this topic?"
  - "I know the definition but cannot apply it in real situations."
  - "Take me through the reflection or transfer stage for what I just learned."
  - "Diagnose why my learning is not turning into performance."
- Do not use for neural-network or machine-learning requests merely because they contain the phrase "deep learning."

## Catalog Maintenance

When a new skill should be discoverable through `think-router`, update this catalog with:

- Skill name.
- Directory.
- Invocation.
- Best-fit problem type.
- Method summary.
- Interaction style.
- Example user intents.
