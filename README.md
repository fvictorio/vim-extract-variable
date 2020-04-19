# vim-extract-variable

Extract an expression to a variable.

![vim-extract-variable demo](https://i.imgur.com/cHbl0xk.gif)

## Installation

Use one of the hundred of methods that exist to install a vim plugin. I recommend [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'fvictorio/vim-extract-variable'
```

## Usage

A normal and visual mapping is set: `<leader>ev`. If you use it in visual mode, it extracts the selected text to a variable. The name of the variable will be prompted to you. If you use it in normal mode, the text between parentheses is used.

The declaration is created in the previous line, using `O`, so it should preserve the indentation if you have `autoindent` on.

## Supported languages

The following languages are supported:

| Language              | Result                   |
| ----------------------| ------------------------ |
| Elixir                | `foo = 42`               |
| Go                    | `foo := 42`              |
| JavaScript            | `const foo = 42`         |
| R                     | `foo <- 42`              |
| Ruby                  | `foo = 42`               |
| TypeScript            | `const foo = 42`         |
| Python                | `foo = 42`               |
