# Aerynos Dotfiles Installation

### 1. Dependencies
If you are using a fresh console install you need to install curl:
```bash
sudo moss it curl
```

### 2. Clone and Install
Run the following commands to pull the configurations into your `.config` directory and execute the setup script:

```bash
git clone https://github.com/christian-bendiksen/aerynos-dotfiles .config
cd .config
./install.sh
```

### Post-Installation Setup

After the installation is complete, you need to configure your monitor and keyboard layout:

`hx ~/.config/mango/native/input.conf`

Edit whatever else you might need.

Run `mango` from tty
