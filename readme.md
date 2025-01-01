# Dotfiles

## Installation

Below are three options to install chezmoi and the dotfiles.

More options to install chezmoi can be found on the [official website](https://chezmoi.io/install/).

### Option 1: Convenience install

Both chezmoi and the dotfiles can be installed with a single command using **curl** or **wget**:

```sh
GITHUB_USERNAME="peter-job"

# curl install
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

# wget install
sh -c "$(wget -qO- https://get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

> [!NOTE]
> A minimal container image (e.g. `ubuntu` base image in docker hub) might not have either.
> To install `curl` on a Debian-based system, run as root or with sudo:
>
> ```sh
> apt update -y
> apt install curl -y
> ```

### Option 2: Package manager install of chezmoi

#### Install chezmoi

chezmoi can be [installed using various package managers](https://www.chezmoi.io/install/#one-line-package-install).

Popular package managers include:

**Homebrew (macOS)**

```sh
brew install chezmoi
```

**APK (Alpine)**

```sh
apk add chezmoi
```

**APT (Debian-based systems)**

> [!WARNING]
> Official repositories for Debian-based systems don't include the `chezmoi` package, meaning that it can't be installed via `apt` with default repositories.
> Use one of the other options listed here to install chezmoi.

#### Install dotfiles

With a working chezmoi installation, the dotfiles can be installed with:

```sh
GITHUB_USERNAME="peter-job"
chezmoi init $GITHUB_USERNAME
```

### Option 3: GitHub install

The dotfiles can be installed directly from the repo via GitHub:

```bash
$GITHUB_USERNAME="peter-job"
git clone "https://github.com/$GITHUB_USERNAME/dotfiles.git"
cd dotfiles
./install.sh
```

## Risks and considerations

The dependency on chezmoi might be an issue in some restricted corporate environments, minimal container images, etc. See an [issue raised in the GitHub repo](https://github.com/twpayne/chezmoi/issues/1410).

If the dependency becomes too much of an issue, there are some mechanisms to [migrate away from chezmoi](https://www.chezmoi.io/user-guide/advanced/migrate-away-from-chezmoi/). The pain-points would be around migrating the chezmoi-specific features like templating, hooks, secrets to a new system.

It's something I'd like to keep in mind when building out these dotfiles – not just specific to the dependency on chezmoi, but on any tool. One way to mitigate the risk is pushing "core" functionality into more portable, standard formats like POSIX-compatible shell scripts, and make sparing use of the tool-specific features, being aware of how they might be replaced in the future.


<!-- Todo: merge in layouts from avb dotfiles and manage with chezmoi-->
<!--
### MacOS keyboard layout

1. Copy the keyboard layout files to the `Keyboard Layouts` directory in your home directory.

    ```bash
    cp ./macos/keyboard_layouts/* /Library/Keyboard\ Layouts/
    ```

2. Go to `System Settings` > `Keyboard` > `Text Input` > `Input Sources` > `Edit`.
3. Click `+` in the bottom left, scroll to the bottom of the list on the left and select `Others` then select `QWERTY no option` and click `Add`.
4. Either delete your existing layout (probably called `U.S.`) or just switch to the `QWERTY no option` layout using the input-source select in the menu bar.
-->
