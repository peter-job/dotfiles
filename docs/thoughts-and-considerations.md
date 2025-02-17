# Thoughts and considerations

## Choosing an interactive shell

I've been using zsh for several years now. There's a lot left for me to learn!

When setting up this repo, I considered switching to fish or bash. fish seemed like it would be nice to use, but it's not very popular – learning the fish language might not be a great time investment. bash is a pretty safe choice for portability and popularity. I like the features of zsh though, and it's close enough to bash and POSIX standard that the differences feel low risk.

I decided to stick with **zsh** for now. It shouldn't be too difficult to switch to bash in the future if I change my mind.

## Choosing a shebang for shell scripts

I've used a few different shebangs in the past, never with much confidence in the choice. I thought this might be a good chance to do some research on what others generally use and why, and to record the decision I make for myself.

### Most popular shebangs for shell scripts

I gathered some stats by searching GitHub for code that uses popular shebangs in shell scripts.

| Shebang                  |   Ocurrences | Search Pattern                                         |
| ------------------------ | -----------: | ------------------------------------------------------ |
| **Total**                | **14000000** | `/^#!\// AND language:shell`                           |
| `#!/bin/bash` 🏅         |      7500000 | `/^#!\/bin\/bash\s*\n/ AND language:shell`             |
| `#!/bin/sh` 🥈           |      2700000 | `/^#!\/bin\/sh\s\*\n/ AND language:shell`              |
| `#!/usr/bin/env bash` 🥉 |      2400000 | `/^#!\/usr\/bin\/env bash\s*\n/ AND language:shell`    |
| `#!/usr/bin/env sh`      |       158000 | `/^#!\/usr\/bin\/env sh\s*\n/ AND language:shell`      |
| `#!/usr/bin/bash`        |        89900 | `/^#!\/usr\/bin\/bash\s*\n/ AND language:shell`        |
| `#!/bin/zsh`             |        60200 | `/^#!\/bin\/zsh\s*\n/ AND language:shell`              |
| `#!/usr/bin/env zsh`     |        48500 | `/^#!\/usr\/bin\/env zsh\s*\n/ AND language:shell`     |
| `#!/bin/ksh`             |        20900 | `/^#!\/bin\/ksh\s*\n/ AND language:shell`              |
| `#!/usr/bin/sh`          |        11100 | `/^#!\/usr\/bin\/sh\s*\n/ AND language:shell`          |
| `#!/usr/bin/zsh`         |         7200 | `/^#!\/usr\/bin\/zsh\s*\n/ AND language:shell`         |
| `#!/bin/ash`             |         5900 | `/^#!\/bin\/ash\s*\n/ AND language:shell`              |
| `#!/usr/bin/local/bash`  |         4700 | `/^#!\/usr\/local\/bin\/bash\s*\n/ AND language:shell` |
| `#!/bin/dash`            |         4500 | `/^#!\/bin\/dash\s*\n/ AND language:shell`             |
| `#!/usr/bin/ksh`         |         3600 | `/^#!\/usr\/bin\/ksh\s*\n/ AND language:shell`         |
| `#!/usr/bin/env dash`    |         1500 | `/^#!\/usr\/bin\/env dash\s*\n/ AND language:shell`    |
| `#!/usr/bin/dash`        |         1400 | `/^#!\/usr\/bin\/dash\s*\n/ AND language:shell`        |
| `#!/usr/bin/env ksh`     |         1200 | `/^#!\/usr\/bin\/env ksh\s*\n/ AND language:shell`     |
| `#!/usr/bin/env ash`     |          992 | `/^#!\/usr\/bin\/env ash\s*\n/ AND language:shell`     |
| `#!/usr/bin/ash`         |          328 | `/^#!\/usr\/bin\/ash\s*\n/ AND language:shell`         |

> [!NOTE] Notes
>
> - Results are as of 2025-02-13
> - I included `language:shell` along with the regex pattern to filter out readme files, etc.
> - I included `\s*\n` at the end of the regex pattern to filter out shebangs that call the interpreter with arguments.
> - I didn't include shebangs for non-shell scripts like Python, etc.
> - The results are just meant for rough comparison!

To keep my life simple, I'm limiting the choice to one of the top three – `/bin/bash`, `/bin/sh`, or `/usr/bin/env bash`.

### Choosing a non-interactive shell for scripts

I've ruled out using zsh for shell scripts because I want portability. The results above narrow things down to **bash** or **sh**.

- bash is the most popular shell by a wide margin.
- Being the most popular shell, there's a lot more public bash code available to use as references.
- bash isn't available on some minimal systems like Alpine Linux.
- I don't currently use bash as my interactive shell.
- POSIX sh has less features than bash, for better or worse.
- As I'm not a daily bash user, I don't have a good eye for detecting bashisms.

I'm deciding to use **bash** by default, and reserve sh for scripts that require POSIX compatibility.

### Choosing a path for the shebang

- `/bin/bash` is the most popular path for bash scripts.
- `/bin` is usually a well protected directory.
- `/usr/bin/env bash` is recommended for portability.
- If a system doesn't have bash under `/bin/bash`, it _probably_ doesn't have bash in the path either.
- One case I saw for using `/usr/bin/env bash` is that macOS currently ships with bash 3.2. If you wanted to use the latest version of bash (5.2), you would likely install it with Homebrew, and have the Homebrew bin directory near the top of your PATH. With a `/bin/bash` shebang, scripts would still execute using the system bash shell, and if they relied on new features, they would break. I'm not planning to write scripts that use new bash features myself, so it's more of a consideration about using other people's scripts.

I'm deciding to use **`/bin/bash`** until I have a good reason to switch to `/usr/bin/env bash`.

## Dependency on chezmoi

The dependency on chezmoi might be an issue in some restricted corporate environments, minimal container images, etc. See an [issue raised in the GitHub repo](https://github.com/twpayne/chezmoi/issues/1410).

If the dependency becomes too much of an issue, there are some mechanisms to [migrate away from chezmoi](https://www.chezmoi.io/user-guide/advanced/migrate-away-from-chezmoi/). The pain-points would be around migrating the chezmoi-specific features like templating, hooks, secrets to a new system.

It's something I'd like to keep in mind when building out these dotfiles – not just specific to the dependency on chezmoi, but on any tool. One way to mitigate the risk is pushing "core" functionality into more portable, standard formats like POSIX-compatible shell scripts, and make sparing use of the tool-specific features, being aware of how they might be replaced in the future.
