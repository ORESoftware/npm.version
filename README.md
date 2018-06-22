
# @oresoftware/npv

>
> Change NPM versions, just like changing Node versions with NVM
>

<br>

***Caveat/Disclaimer***

Not all NPM versions are compatible with all Node versions.
Many NPM versions are not compatible with older or newer Node versions.

<br>

# Installation

```bash
$ npm i -g '@oresoftware/npv'
```

<br>

## Usage

<i>__Add a new NPM version__</i>

```bash
$ npv use 6
```

The above will look to see if any local versions match 6* <br>
If no local versions match, then it will go to NPM to get the latest version that starts with 6. <br>

If you use the `--latest` flag:

```bash
$ npv use 6 --latest
```

then you will always get the latest version from NPM that starts with 6.

<br>

<i>__List all existing versions__</i>

```bash
$ npv ls
```

<br>

<i>__Remove matching versions__</i>

```bash
$ npv rm 6*
```

The above will remove all versions that start with 6.

<br>

<i>__Remove all versions__</i>

```bash
$ npv remove-all
```

The above will remove all versions. NPM will then be <br>
replaced with the latest version: `npm install -g npm@latest`

<br>

### Alias for the executable

Note that if npv / npmv executables already exists on your system, you can use this same
package with a different name/executable:

```bash
$ npm i -g '@oresoftware/kk5'
```

'kk5' is completely random - I just chose it because it was easy to type lol.
Most people will probably prefer using npv / npmv.
