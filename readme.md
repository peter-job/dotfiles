# Peter Job's dotfiles

My dotfiles for macOS and linux, managed with [`chezmoi`](https://chezmoi.io).

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
GITHUB_USERNAME="peter-job"
git clone "https://github.com/$GITHUB_USERNAME/dotfiles.git"
cd dotfiles
./install.sh
```

## Managing dotfiles

### Syncing brew packages

> TODO: Write something about the brew bundle --global + symlink I created here.

## Thoughts and considerations

I keep track of some [thoughts and considerations](docs/thoughts-and-considerations.md) to help me think through the decisions made in these dotfiles.

## Credits

I learned and borrowed a lot from [Felipe Santos' dotfiles](https://github.com/felipecrs/dotfiles) and [Tom Payne's dotfiles](https://github.com/twpayne/dotfiles) (the creator of chezmoi).

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
