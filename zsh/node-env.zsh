# Node.js environment tweaks

# Disable happy-eyeballs (parallel IPv4/IPv6 connection attempts introduced in
# Node 20). When routing traffic through a Tailscale exit node from Russia,
# external IPv6 routes black-hole — Node's fetch() and https.get() hang for
# ~28s on every outbound HTTPS call. This forces sequential connection
# attempts so IPv4 is used directly without waiting for IPv6 timeout.
#
# Symptom without this: Clerk JWT verify timeouts, any SDK using global fetch
# stalls (Stripe, OpenAI, Square, Twilio, etc.), backend endpoints returning
# 401/500 after long delays even though curl works fine.
export NODE_OPTIONS="--no-network-family-autoselection"
