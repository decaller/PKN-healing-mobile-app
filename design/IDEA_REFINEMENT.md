# Idea Refinement: A Calm, Situational PKN Companion

## Status and evidence boundary

This is a **product recommendation for validation**, not an implementation plan, approved release commitment, or report of user research. The existing ambition is broader than the proposed first release. No interviews, observed demand, willingness to pay, clinical outcomes, or user reactions are established by the sources reviewed here. All predictions and proposed thresholds below are hypotheses.

The refinement uses How Might We (HMW), Jobs to Be Done (JTBD), SCAMPER-style lenses, first-principles scope reduction, and a pre-mortem. The evaluation prioritizes user value and feasibility, with differentiation as a tiebreaker. It follows the installed `idea-refine` skill and its `frameworks.md` and `refinement-criteria.md`; the requested destination replaces the skill's default save location. Recommendations are provisional because no stakeholder preference among the directions has been recorded.

### Source map

Line references identify the reviewed source snapshot, not a claim that all documented behavior has shipped.

| Source | Relevant evidence | Interpretation and limit |
|---|---|---|
| `README.md:11–12,41–48` | Micro-learning and Tazkiyatun Nafs for parents, educators, institution managers, and youth; situational guidance in minutes; burnout and guilt framing. | Documented mission and problem assertions, not measured demand or proven treatment efficacy. |
| `README.md:85–95,99–124` | Three languages of education, four age phases, TB-40, no streak shame or comparative leaderboard, qualitative adab, brief leads, five-card decks, hands-free audio. | Product principles and intended formats. Religious and pedagogical claims require accountable review. |
| `docs/USER_JOURNEYS.md:38–95,101–149` | Five ecosystem domains; brief actionable guidance; Ayah and Bunda JTBD and triggers. | Designed personas and journeys, not observed participant behavior. These make the initial caregiver job concrete. |
| `docs/USER_JOURNEYS.md:327–414,420–459,465–505` | Institutional, scholarly, youth, and independent learner jobs; broad proposed feature and architecture map. | Different jobs with different success conditions. The architecture description alone does not verify runtime capability. |
| `design/README.md:5–11,17–34,38–44,60–62` | 16 personas, lead-first journey, five-step deck, editable design artifacts and browser flow starts. | Design coverage is not release scope. Browser interaction is separate from native Figma reactions and Flutter implementation. |
| `design/README.md:82–111` | Game design scenes and simulated local interactions; 104 canonical screens / 12 flows; production audio, downloads, storage, reports and assessment not implemented **by the design**; illustrative instruments and unreviewed content limits. | The prototype is evidence of exploration, not a production game, validated assessment, or comprehensive accessibility audit. The storage limitation applies to the browser prototype, not automatically to Flutter. |
| `docs/GAME_CONCEPT_VIRTUAL_FITRAH.md:4–7,42–45,81–112,221–279,283–307,383–411,418–465` | Concept-stage life simulation, seven venues, AFK/ledger, real-world bridge, phased roadmap, narrative graph and prerequisite gating. | Proposed game mechanics and architecture, not functioning autonomous simulation or evidence of real-world learning transfer. |

**Scope/maturity separation:** (1) the mission and journey documents describe the intended ecosystem; (2) the design artifact and browser prototype demonstrate selected interfaces and simulated transitions; (3) Flutter is a separate implementation whose end-to-end feature readiness was not audited for this report; (4) this report proposes a narrower release to test value. Screen counts, README badges, and concept diagrams cannot substitute for production verification.

## Problem statement and HMW

**How might we help an Indonesian-speaking parent or caregiver of a child aged 2–7 choose one safe, gentle response during an everyday difficult interaction, without making them read a course, disclose the child's identity, or feel judged for needing help?**

Proposed core JTBD: *When my child is upset and I am close to reacting harshly, I want one understandable action and one adaptable sentence, so I can respond more deliberately and return my attention to the child.*

This deliberately narrows “healing” to **educational support and reflective practice**. It does not promise that a child will calm down, that burnout will resolve, or that spiritual or mental-health states can be diagnosed by an app. In an unsafe situation, immediate safety and appropriate human help take priority over screen use.

## Audience: documented ecosystem versus initial recommendation

**Documented audience:** Indonesian-context families (Ayah, Bunda, new parents), teachers across developmental phases, institutional managers, facilitators and researchers of religious sources, students/santri, and independent adult learners. The design maps 16 personas, including specialist jobs such as curriculum decisions and source verification (`design/README.md:17–34`; `docs/USER_JOURNEYS.md:38–76`). These are not interchangeable acquisition segments.

**Recommended initial audience — hypothesis:** Indonesian-speaking adult parents and caregivers of children aged 2–7 who want PKN-aligned, non-shaming guidance for routine emotional situations. Recruit across caregiver roles rather than treating daily care as exclusively the mother's responsibility. Bunda's documented rapid-response job is the closest starting point; Ayah and new caregivers should be included to test whether the same job travels across roles (`docs/USER_JOURNEYS.md:131–149`). Age-band selection is a starting constraint, not a developmental diagnosis.

**Why start here:** The job has a clear trigger and a short output; it can be tested without building reports, formal assessments, school administration, youth accounts, or a game engine. Its frequency and urgency remain unvalidated. The initial competitor set to investigate is the caregiver's actual workaround: memory, a partner, a teacher or trusted religious adviser, messaging groups, search, or saved articles. No superiority over those alternatives is assumed.

**Not the initial target:** Children as direct users; youth choosing careers; institutions managing reports; researchers inspecting sanad; or adults seeking treatment for anxiety. Keep these in the ecosystem vision, not in first-release acceptance criteria.

## Proposed success criteria — hypotheses, not findings

The primary outcome is **useful off-screen action**, not daily opens, longest sessions, streaks, or an adab score. A skipped session or declined reflection is not failure.

Use a proposed formative cohort of 12 adult caregivers for comprehension/usability, followed by a voluntary two-week pilot with 20 adults if safety and content review pass. These small samples are learning tools, not statistical proof of efficacy or market size. Pre-agree thresholds and record denominators, missing responses, and role/age-band differences; do not reclassify failures to make the results pass.

| Hypothesis | Proposed criterion | Measurement boundary |
|---|---|---|
| H1: Brief guidance is understandable under time pressure. | At least 10/12 formative participants locate an appropriate card within 30 seconds and explain its first action and important boundary correctly after a roughly 10-second read. | Safe role-play or retrospective tasks, not inducing or interrupting a child's distress. Separate navigation time from reading/comprehension. |
| H2: Guidance changes the next action, not just reading behavior. | At least 12/20 pilot participants voluntarily describe one attempted off-screen action and why it fitted their situation. | Self-report indicates attempted use, not verified child benefit or causal behavior change. Include “did not fit” and “did not try” responses. |
| H3: It is worth choosing over a current workaround. | At least 10/20 report choosing the tool on two separate relevant occasions during the pilot, with a concrete reason for choosing it. | Count opportunities as well as use; absence of a relevant situation is inconclusive. Interview non-users. No prompted daily-use quota. |
| H4: Tone avoids added guilt and false authority. | At least 10/12 describe the guidance as supportive rather than evaluative and understand that it is educational, not a diagnosis or guaranteed solution. | Any credible unsafe interpretation or coercive language blocks release of the affected content; aggregate satisfaction cannot override it. |
| H5: The selected scope is deliverable responsibly. | Every included card has reviewed references, practical safety boundaries and a named approval owner; the actual release is usable offline and passes its defined accessibility/privacy checks. | Release gates, not claims about the present prototype. Content readiness matters as much as software readiness. |

## Divergence: seven distinct variations

Each variation is a proposal. None is supported by user validation yet.

| Variation and lens | Experience and reason to exist | Main bet / cost |
|---|---|---|
| **1. One situation, one response — simplification / eliminate** | Open directly to a few situation labels, see one action and adaptable sentence, then leave. Explanation and dalil are optional. Removes mandatory onboarding and the need to “finish learning” before receiving help. | Adults can use concise guidance safely without oversimplifying context. Editorial precision is the hard work. Anchored in the lead-first format. |
| **2. Repair after a difficult moment — inversion** | Start with “I already reacted in a way I regret,” not with a perfect-parent response. Offer an age-appropriate repair conversation and permission to pause. | Post-event guidance may be easier to use than reaching for a phone mid-conflict. Must not imply that repair excuses harm. Draws on the game's islah direction without its meters (`GAME_CONCEPT_VIRTUAL_FITRAH.md:458–462`). |
| **3. Co-caregiver handoff card — combination** | A parent picks one reviewed response to discuss with another adult caregiver before the next difficult moment. The card contains no child record and can be shown on the same device. | A shared response may solve inconsistency better than another individual feed. Coordination may add friction; no chat or shared account is needed to test it. |
| **4. Classroom rehearsal pack — audience shift** | Teachers rehearse a classroom incident and choose a respectful response before teaching, with a short explanation of trade-offs. | Teacher preparation may offer predictable usage and a clearer distribution partner, but classroom constraints differ from parenting. Requires a separate teacher-specific content test, not relabelled family cards. |
| **5. Perspective-switching story — expert lens / adapt** | A short authored case lets an adult consider the child's perspective, try a response, inspect feedback, and practice a repair. All safe responses remain available. | Rehearsal may teach judgment better than instructions. Expertise is needed to avoid simplistic moral verdicts or claiming a child's inner state can be inferred. Borrows POV relay, not prerequisite locks (`GAME_CONCEPT_VIRTUAL_FITRAH.md:431–456`). |
| **6. Human-supported guidance clinic — constraint removal** | A small facilitated session pairs reviewed material with a qualified educator who helps adults adapt it to their context. Software becomes a take-home aid, not the primary service. | If contextual judgment is essential, human facilitation may create more value than self-service. Staffing, competence, safeguarding, and ongoing cost make this a service direction, not a simple feature. |
| **7. Reviewed local guidance network — 10x / expert infrastructure** | Trusted educators maintain versioned situational packs for local caregiver communities, with common reference and correction standards. | A repeatable review/distribution model could scale trust better than an endless feed. Needs demonstrated demand and editorial governance; local adaptation can fragment quality. A future operating model, not first-release infrastructure. |

## Convergence: three clustered directions

The ratings are comparative judgments from the documented constraints, **not research scores**. “High value” means a promising job to test, not proven demand. More screens do not increase a rating.

| Direction / variations | User value hypothesis | Feasibility and hardest part | Differentiation hypothesis | Verdict |
|---|---|---|---|---|
| **A. Situational caregiver companion** (1, 2, a small part of 3) | Potentially high at a relevant moment: a brief next action or repair step. Could still be only a vitamin if people cannot or should not open a phone then. | Relatively high for a bounded reviewed pack; harder than a static card demo because content safety, offline reliability, comprehension and accessibility must work together. | New context and simpler experience: PKN-grounded, action-first, guilt-free help instead of browsing advice. Easily copied interface; trustworthy review and fit are the possible advantage. | **Test first.** Fewest dependencies for learning whether the core promise is useful. |
| **B. Facilitated adult rehearsal** (4, 5, 6) | Potentially high for intentional skill practice; teachers or caregiver groups can discuss ambiguity and repair. Lower immediate utility during a difficult moment. | Medium. Authored branching and feedback are tractable; content specialists, facilitator capacity and recruitment are the bottleneck. Full simulation is unnecessary. | Perspective-taking and contextual conversation rather than a moral score. Switching from existing workshops or printed cases requires evidence. | **Keep as a separate pivot candidate**, especially if self-service guidance is too ambiguous or poorly timed. |
| **C. Trusted community distribution network** (7, expanded 3/6) | Potentially high for trusted access and consistent teaching; benefits publishers and communities as well as adults. Demand is indirect and several-sided. | Low initially. Review governance, distribution agreements, version control and sustained content ownership matter more than personalization technology. | Context-specific trust and accountable sourcing could be more durable than UI polish, but no institutional commitment or moat is established. | **Defer until one pack and one audience show pull.** Do not build a platform to discover whether the basic advice is wanted. |

### Hidden bets and pre-mortem by direction

- **A:** Must be true: safe, short advice can be understood and applied in the intended contexts. Could kill it: caregivers ignore it in the moment, or read it as a guarantee, blame, or permission to force a child. Deliberately ignore broad content personalization and long-term assessment until the single interaction proves useful.
- **B:** Must be true: rehearsal transfers to an off-screen choice and a credible facilitator or feedback model is available. Could kill it: participants learn to select the “approved” answer without understanding context, or the tool locks compassionate responses behind scores. Deliberately ignore autonomous avatars and art depth; neither proves learning transfer.
- **C:** Must be true: trusted partners want to distribute and maintain reviewed packs. Could kill it: no owner can sustain correction/review, or local adaptations undermine consistency. Deliberately ignore multi-tenant software and monetization optimization until a manual partnership works.

## Recommendation

Choose **Direction A: a small situational caregiver companion**, with equally visible entry points for “help me respond now” and “help me repair afterward.” Make the default experience a useful card, not an ecosystem profile. Offer a five-step deck only when the adult wants to understand or rehearse more; keep source context available without forcing a long read before the action.

The strongest idea is not “a large Islamic wellness app plus a virtual town.” It is “one trustworthy next step when an adult's attention and emotional capacity are limited.” The virtual-world concept can remain a design research asset, but it should not determine the first release. Even the game's documented phase one combines rooms, emotional-state mechanics and five scenarios; that is more than is needed to test the core guidance job (`docs/GAME_CONCEPT_VIRTUAL_FITRAH.md:383–411`). A short optional rehearsal can later test the game's educational claim without AFK, economy, or simulated measurements of the soul.

Treat **content review, safety interpretation and voluntary real-world use** as the critical path. The full ecosystem should expand only in response to demonstrated jobs, not because its screens already exist.

## Assumptions, validation and stop/pivot criteria

These are proposed decision rules. Validate the must-be-true bets before broad implementation or public claims. A stop means stop the affected release/direction and investigate, not abandon the mission.

| Priority / assumption | Validation proposed | Stop or pivot criterion |
|---|---|---|
| **Must:** Adult caregivers encounter this job and want external help. | Interview 12 caregivers about their most recent real episode, current workaround, reasons for using/avoiding advice, and privacy concerns; do not start with a product pitch. | If fewer than half can describe a recent relevant episode and unmet need, stop this initial segment choice. Test another documented job rather than increasing features. |
| **Must:** Short PKN-aligned guidance is both reviewable and safe. | Religious-source reviewer and qualified child-development/safeguarding reviewer inspect every card; formative participants paraphrase instructions and limits. Distinguish direct quotation, interpretation and practical suggestion. | Any unresolved harmful interpretation, coercive instruction, unsupported authority claim, or source dispute blocks the affected content. If safe guidance consistently needs extensive context, pivot toward facilitated rehearsal or longer preparation, not smaller disclaimer text. |
| **Must:** The moment is compatible with screen use. | Retrospective interviews and safe timed role-play; ask when opening a phone would worsen attention or distress. Pilot without real-time prompts. | If fewer than 10/12 meet H1 after one revision, or caregivers consistently cannot use it at the trigger, move the entry point to preparation/repair. Do not demand more engagement during distress. |
| **Must:** Tone and boundaries are understood. | Ask participants how they interpret “healing,” response choices, and a skipped session; test with adults unfamiliar with PKN terminology. | If users infer diagnosis, spiritual grading, guaranteed calming, or guilt for non-use, revise naming/copy and retest before release. Persistent misinterpretation stops the positioning. |
| **Should:** Users prefer it to a current workaround and attempt an action. | Two-week voluntary pilot; collect concrete use/non-use stories with opportunity counts and H2/H3 measures. | If H2 or H3 misses its proposed threshold, investigate fit, trust and timing. After one focused revision, another miss means reconsider Direction A rather than add a game or notification loop. Low opportunity frequency is inconclusive and requires a better sample or longer observation. |
| **Should:** A small team can sustain responsible content ownership. | Obtain named reviewers, correction owner and a feasible update process for the bounded pack before release work is committed. | If review capacity is unavailable, stop release preparation; reduce the pack or use a facilitated/manual pilot. Do not publish unreviewed religious or safeguarding advice to meet a deadline. |
| **Should:** Offline access and inclusive reading are sufficient for this audience. | Test the real release on representative devices with offline/restart cases, larger text, screen reader navigation and low reading confidence. | Block release if the core action is inaccessible or unavailable in intended offline conditions. If audio is essential to a substantial recruited subgroup, reconsider the text-first scope and its cost before committing. |
| **Might:** Co-caregiver discussion or authored rehearsal adds value. | Offer an optional same-device handoff or one rehearsal after the core job test; compare concrete usefulness stories. | Omit it if it distracts from H1/H2 or lacks a distinct need. This is not a prerequisite for the core release. |

No retention target should incentivize people to manufacture an incident, log private child behavior, or spend longer in the app. No proposed pilot establishes reduced burnout, improved child development, spiritual purification, or clinical effectiveness; those would require different evidence and expertise.

## Bounded proposed first-release scope

**One job:** help an adult choose and understand one gentle response or repair step for an ordinary difficult interaction with a child aged 2–7.

**Proposed boundary:** one Indonesian-language, adult-facing, text-first pack with **six reviewed situation cards** and **two optional five-step learning decks**. Candidate topics: transition away from play, bedtime resistance, disappointment when a request is refused, sharing/toy conflict, caregiver overwhelm, and repair after raised voices. These are editorial candidates, not approved guidance. The pack must remain within everyday education; unsafe or severe situations need clear human-help boundaries rather than a response script presented as sufficient.

Included experience:

1. Direct situation choice without account creation or mandatory persona onboarding; an optional age-band choice only where it materially changes the guidance.
2. A brief lead containing one first action, an adaptable sentence, and an important contextual/safety boundary. No instruction to force physical contact; adults must be able to adapt the response to the child and situation.
3. Optional “why this guidance” with attributed references, context and the difference between source text and editorial interpretation; clear correction/contact route with an accountable owner.
4. Two five-step decks following the documented sequence: situation, principle/source, response rehearsal, practical wording, and optional reflection (`design/README.md:9`). Safe responses are never locked behind an adab level, talent score, energy meter or prior completion.
5. Offline access to the reviewed pack and persistent local bookmarks, with understandable success/failure states in the actual release. No sensitive child journal is required.
6. A clear exit to off-screen practice; optional private reflection without a required submission or numeric rating. Returning after a break produces a welcome, not a penalty.
7. Release-level safety, accessibility, privacy and content review for this narrow surface. Prototype checks do not satisfy these gates.

**Proposed validation time box:** a four-week discovery/pilot cycle, subject to actual reviewer availability: establish the job and reviewed candidate material, run formative comprehension tasks, then conduct the two-week voluntary pilot. This is a learning boundary, not a software delivery estimate. If content cannot be reviewed in that window, do not compensate by shipping more interface. Reassess scope and ownership.

**Expansion gate:** proceed beyond the pack only when the agreed criteria support useful voluntary action and content/release gates pass. An invitation to add the next audience must identify its separate job, review needs and outcome measure. Audio, youth assessment, school reporting and Virtual Fitrah remain independent scope decisions.

## Not doing, and why

- **All 16 personas and six content pillars at launch:** dilutes the job and creates incompatible success criteria. Preserve the documented ecosystem as a roadmap of possible jobs, not an onboarding burden.
- **AFK engine, seven-venue town, avatar needs, harvest/economy, or Web companion:** adds simulation, art and runtime work without testing the core guidance assumption.
- **Love Tank percentages, nafs-state diagnostics, personal adab totals, or talent labels:** fictional game parameters cannot represent a real child's attachment, soul or ability. The design already labels TB-40 and other instruments illustrative (`design/README.md:98,109`).
- **TB-40 assessment or consequential school/career recommendations:** the current illustrated radar and questions are not a validated instrument. Youth-facing consent and safeguarding also require a separate product decision.
- **Comparative ranking, streaks, compulsory check-ins, escalating reminders, or moral skill locks:** incompatible with anti-guilt principles. Even voluntary rewards can pressure reporting; keep reflection independent of access to help.
- **Clinical treatment, crisis counselling, automated fatwa, or personalized religious rulings:** outside the educational job and evidence base. Set boundaries rather than imply expertise through “healing” branding.
- **AI-generated guidance or an always-on chatbot:** introduces unbounded content and accountability risk; the proposed core can use reviewed authored material.
- **School reports, institutional audits, curriculum management, or scholar research tools:** meaningful but separate jobs with governance and instrument-validity requirements.
- **Production audio/download/background playback in the initial text-first proposal:** potentially useful, but not needed to test the selected first job unless audience validation changes that judgment. Do not claim the design's audio states are a shipped player.
- **Accounts, cloud sync, child profiles, community chat, or sensitive family logs:** not necessary for this job; avoid collecting data merely to personalize a short pack.
- **Monetization model or growth platform as settled decisions:** payer, distribution cost and willingness to pay are unknown. No evidence supports charging, subscriptions, or institutional sales yet.

## Open decisions before committing to release

1. **Content authority:** Who approves religious references, contextual interpretation and child-safety wording, and who owns corrections after publication? What is the response process for a disputed or unsafe card?
2. **Positioning:** Can “healing” remain in the brand without implying clinical treatment or spiritual measurement? What wording do recruited adults actually understand?
3. **Audience fit:** Does the 2–7 caregiver segment have the clearest unmet need, or does the better entry point prove to be post-event repair or teacher preparation? Which caregiver roles and reading abilities must the first cohort represent?
4. **Access and formats:** Is text usable in the real context, or does essential audio access change the release boundary? Which actual devices, offline conditions and accessibility needs determine acceptance?
5. **Privacy and learning:** What minimal, consented information is needed to evaluate the pilot? Who can access it, how long is it retained, and can participants decline without losing guidance? Self-report is not a real-child adab record.
6. **Operating resources:** Is reviewer and editorial capacity available for the proposed pack? Who owns maintenance and distribution after the pilot? No budget, launch date or sustainable funding evidence is established here.
7. **Distribution and business:** Which trusted route reaches this segment, and who—if anyone—will fund ongoing review? Test a concrete recruitment/distribution route before claiming scalable demand.
8. **Game's future role:** If rehearsal is valuable, should it stay as a brief adult learning deck or become a separately validated game? Require demonstrated learning value before revisiting prerequisite gating, AFK or reward loops.

The immediate decision is which **job and evidence threshold** to test, not how much of the existing design to implement. A useful, safe, reviewed card is a stronger first proof than a larger simulated world.
