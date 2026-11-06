# Work profile for dotfiles (sample)

A fork-able example of a company profile for the
[dotfiles](https://github.com/sorinlg/dotfiles) repo. The main repo stays free of
company-specific values; this one holds them and is loaded through `config.sh`.

## Set it up

1. Fork this repo into your organization and clone it next to your other work code:

   ```sh
   gh repo fork sorinlg/dotfiles-work-example --org your-org --clone ~/work/your-org/dotfiles-work
   ```

2. Edit the files for your company (see [What's in here](#whats-in-here)).

3. Point your dotfiles `config.sh` at it, then re-run the installer:

   ```sh
   _work_config_path="${HOME}/work/your-org/dotfiles-work"
   _work_shell_config='shell-config.sh'
   _work_git_config='gitconfig'
   _brewfile_extra="${_work_config_path}/Brewfile"
   _go_private='github.com/your-org/*'
   ```

   ```sh
   mise run setup
   ```

## Add a corporate CA bundle

Only needed behind a TLS-intercepting proxy. Export the company root CA and your system
roots into one file; `shell-config.sh` exports it for npm, pip, aws and curl:

```sh
mkdir -p ~/.config/work
security find-certificate -a -p -c "Your Proxy CA Name" /Library/Keychains/System.keychain > ~/.config/work/company-ca.pem
cat /etc/ssl/cert.pem ~/.config/work/company-ca.pem > ~/.config/work/ca-bundle.pem
```

Verify with `openssl s_client -connect registry.npmjs.org:443 -CAfile ~/.config/work/ca-bundle.pem`.

## What's in here

| File | Loaded by | Purpose |
|---|---|---|
| `shell-config.sh` | `_work_shell_config` | Environment, aliases, CA bundle exports |
| `gitconfig` | `_work_git_config` | `includeIf` that applies your work identity under your work directory |
| `gitconfig-identity.example` | copy by hand | Work name and email |
| `Brewfile` | `_brewfile_extra` | Work-only packages |

## Why a separate repo

Company settings change on a different schedule and have a different audience than your
personal shell setup, and some of them must not be public. Keeping them in their own
repository means the personal dotfiles can be shared or forked freely, while your
organization can keep this one private and share it between teammates.

## License

[MIT](LICENSE)
