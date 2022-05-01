# shell-utils

## install

First of all, get https://deno.land

```
curl -fsSL https://deno.land/x/install/install.sh | sh
```

Then install the scripts with

```
./install.sh
```

Run `asdf reshim` if https://deno.land was installed with
https://github.com/asdf-vm/asdf.

## edit

After that, to edit a script, use

```
settings <script_name>
```

To create a new script, run

```
cp script-template.ts scripts/new-script.ts
```

And run the `~/dotfiles/sh/shell-utils.sh` script again.
