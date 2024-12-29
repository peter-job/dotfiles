# Dotfiles

## Installation

```bash
git clone <repo>
./setup.sh
```

### MacOS keyboard layout

1. Copy the keyboard layout files to the `Keyboard Layouts` directory in your home directory.

    ```bash
    cp ./macos/keyboard_layouts/* /Library/Keyboard\ Layouts/
    ```

2. Go to `System Settings` > `Keyboard` > `Text Input` > `Input Sources` > `Edit`.
3. Click `+` in the bottom left, scroll to the bottom of the list on the left and select `Others` then select `QWERTY no option` and click `Add`.
4. Either delete your existing layout (probably called `U.S.`) or just switch to the `QWERTY no option` layout using the input-source select in the menu bar.
