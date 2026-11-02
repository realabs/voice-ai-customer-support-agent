# Cost model

Javi costs about **$100/month** all-in at GoJET Mexico's call volume, against a **$2,500/month** quote for a call center that wasn't even 24/7.

## Where the money goes

Every layer is billed per minute of conversation (plus a small fixed fee for the phone number):

| Layer | Billed by | Share of cost per minute |
|---|---|---|
| Vapi (orchestration) | Platform fee per minute | Largest single line |
| ElevenLabs (voice) | Characters / minutes spoken | Large |
| Twilio (telephony) | Per minute, depends on number type and direction | Medium |
| GPT-4.1-mini (LLM) | Tokens | Small |
| Deepgram Nova-3 (speech-to-text) | Per minute of audio | Smallest |
| n8n (self-hosted) | Server you already run | Fixed, near zero |
| Zendesk | Existing seats | No extra cost |

In our setup, a minute of conversation came out at roughly **$0.15-0.20 all-in**, which matches the commonly quoted range for Vapi-based stacks. Speech-to-text was the cheapest line by far, even though transcription quality decides whether everything else works.

Prices change. Check each vendor's current pricing for your country and number type before you plan.

## Rule of thumb

```
monthly cost ≈ calls per month × average minutes per call × cost per minute + number fee
```

With 2-3 minute calls, the stack stays far below a staffed call center until volumes reach thousands of calls a month. Above that, compare against a hybrid model (AI first line, smaller human team) rather than against "all human" or "all AI".
