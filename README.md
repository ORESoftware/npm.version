
## @oresoftware/npm.version

# => Change NPM versions, just like changing Node versions with NVM


### Installation >  ```$ npm i -g '@oresoftware/npm.version'```

## Usage

<i>Add a new NPM version</i>

```bash
$ npmv use 6
```

The above will look to see if any local versions match 6* <br>
If no local versions match, then it will go to NPM to get the latest <br>
version that starts with 6. <br>

If you use --latest flag:

```bash
$ npmv use 6 --latest
```

then you will always get the latest version from NPM that starts with 6.
<br>

<i>List all existing versions</i>

```bash
$ npmv ls
```

<br>

<i>Remove matching versions</i>

```bash
$ npmv rm 6*
```

The above will remove all versions that start with 6.

<i>Remove all versions</i>

```bash
$ npmv remove-all
```

The above will remove all versions. NPM will then be <br>
replaced with the latest version: `npm install -g npm@latest`
