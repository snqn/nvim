# Sine qua non for [Neovim](https://github.com/neovim/neovim).

This theme is dark-only and roughly tries to follow [Tonsky's syntax-highlighting article](https://tonsky.me/blog/syntax-highlighting/).

## Usage

You can use this repo as you would with any other Neovim theme.

### Nix flake

```nix
{
  inputs.snqn-nvim.url = "github:74k1/snqn-nvim";

  # ...
}
```

Then in Home Manager:

```nix
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    plugins = [
      {
        plugin = inputs.snqn-nvim.packages.${pkgs.stdenv.hostPlatform.system}.default;
        type = "lua";
        config =
        # lua
        ''
          require("snqn").setup({
            transparent = true,
          })

          vim.cmd('colorscheme snqn')
        '';
      }

      # other plugins ...
    ];
  };
}
```

### Configuration

```lua
require("snqn").setup({
  transparent = true,
  transparent_highlights = false,
  disable_semantic_tokens = true,
  palettes = {
    base0E = "#A37BFF",
    -- and so on
  },
  highlight_overrides = function(colors, opts)
    return {
      CursorLineNr = {
        fg = colors.comment,
        bg = opts.transparent and "NONE" or colors.gutter,
      },
    }
  end,
})
```

#### Options

- `transparent`: make editor backgrounds transparent
- `transparent_highlights`: also remove fills from highlight-style surfaces like selection/search/diff/diagnostic chips
- `disable_semantic_tokens`: disable LSP semantic token coloring on attach so Treesitter/theme colors stay in control
- `palettes`: override any `base00`-`base0F` color
- `highlight_overrides`: override/add custom highlight groups


## Thanks to

### Contributors

- [74k1](https://github.com/74k1)

### Inspirations

- [Nikita Prokopov](https://github.com/tonsky)
- [y9san9/y9nika.nvim](https://github.com/y9san9/y9nika.nvim)

---

Copyright © 2026-present SNQN
