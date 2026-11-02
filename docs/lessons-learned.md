# Lessons learned: six months of a voice AI agent in production

Notes from running Javi on a real support line in Mexico since May 2026. Ordered roughly by how much each one mattered.

## 1. The bottleneck is integrations, not the model

Getting GPT to sound natural took an afternoon. Getting it to pull live customer data, end a stuck ride, and leave a usable Zendesk case took most of the build. If the bot can only explain, the customer still needs a human, and your "deflection" is just a delayed escalation.

**Practice:** design the tools first (what the agent can *do*), then write the prompt around them.

## 2. Voice bots break on details, not on "intelligence"

The #1 failure after launch was not a hard question. It was callers dictating their phone number digit by digit: a missed digit, a "plus", a country code said twice, and the account lookup fails. The caller gets asked again, gets annoyed, and asks for a human.

**Fix:** look up the account by caller ID first (`call.customer.number` in Vapi). Only ask for the number if the caller is calling from a different phone. When you must ask, ask for it slowly and read it back once.

Other details in the same family: brand names misheard by speech-to-text (add them as key terms), amounts read in the wrong language, and the bot reading long decimals out loud.

## 3. Measure resolution, not call endings

An 85% deflection rate means nothing if half of those callers hung up frustrated. We count a call as resolved only when the issue was actually handled: ride ended, balance explained, refund status given. Everything else is either an escalation or a failure to investigate.

## 4. Handoff rules take longer to settle than anything else

The three rule sets that took the longest to get right:

- **When to hand off.** Too eager and the bot is a costly IVR; too stubborn and it traps people. The template prompt uses simple triggers: the caller asks for a human, the same problem fails twice, or the issue needs a decision the tools can't make.
- **Silence.** Customers put the phone down to check the app. The agent should wait, nudge once, and only then end the call.
- **Clean tickets.** Every handoff creates a case with a one-line summary, the language, the account, and the transcript. A human should never need to call the customer back to understand the problem.

## 5. Multilingual has to mean mid-call switching

In LATAM, people switch languages mid-sentence. In the demo, the caller starts in Portuguese, asks for English, and closes in Spanish. Multilingual speech-to-text (Deepgram Nova-3 in `multi` mode) plus a prompt rule "always answer in the caller's latest language" handles it. Single-language models with a "language detection" step in front do not.

## 6. Connect voice to the rest of support

The agent tells customers that a human will follow up on WhatsApp. When the customer replies there, the WhatsApp thread and the voice case merge automatically, so the agent sees one conversation instead of two parallel tickets.

## 7. Know where the economics stop

At low to mid volumes, a usage-priced stack (about $100/month here) beats a fixed-price call center by a wide margin. At high volumes, per-minute costs across telephony, speech-to-text, LLM and voice add up, and the comparison changes. Run the numbers for your volume before promising savings. See [cost-model.md](cost-model.md).
