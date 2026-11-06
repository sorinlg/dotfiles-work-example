# Work shell configuration, sourced by the dotfiles profile after all its own modules
# (zsh syntax). Fork this repo, replace the placeholders, and point config.sh at it.
# Keep company-internal values here, never in the public dotfiles repo.

export WORK_ORG="your-org"

# --- Corporate TLS-intercepting proxy -------------------------------------
# If your network re-signs HTTPS traffic with a company CA, tools that ship their
# own CA store (npm, pip, aws, curl builds) reject it. Build one bundle (system CAs
# plus the company CA) and point them at it. Setup is a one-time step, see README.md.
_work_ca_bundle="${HOME}/.config/work/ca-bundle.pem"
if [[ -f "${_work_ca_bundle}" ]]; then
  export NODE_EXTRA_CA_CERTS="${_work_ca_bundle}"
  export SSL_CERT_FILE="${_work_ca_bundle}"
  export REQUESTS_CA_BUNDLE="${_work_ca_bundle}"
  export AWS_CA_BUNDLE="${_work_ca_bundle}"
fi
unset _work_ca_bundle

# --- Aliases and helpers ---------------------------------------------------
# alias wk='cd ~/work/${WORK_ORG}'
