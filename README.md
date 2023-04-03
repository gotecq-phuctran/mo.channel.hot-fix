# mobile-manifest

## Usage

- Navigate to your directory: `cd your_dir`
- Initialize with tsrc : `tsrc init git@github.com:gotecq/mo.manifest.master.git  --group default apps modules libs translations`
- Sync repos: `tsrc sync && cp -rf mobile-consumer/_/. mobile-consumer && rm -rf mobile-consumer/_`
- Sync repos by groups: `tsrc sync --group default apps modules libs translations`


## Notes

- To edit `manifest.yml` in `.tsrc` folder safely. We can use below command instead of `tsrc sync` to avoid sync latest manifest from gitlab.

  - `cd your_dir` (It's directory where initialize tsrc)
  - `tsrc apply-manifest .tsrc/manifest/manifest.yml  --group default apps modules libs translations`

- To clone with specific environment (e.g. `dev`, `beta`, `main`). We can use script above with `--branch` with specific branch.
  - E.g `tsrc init --branch main git@github.com:gotecq/mo.manifest.master.git --group default apps modules libs translations`

- ref: [https://dmerejkowsky.github.io/tsrc/guide/manifest](https://dmerejkowsky.github.io/tsrc/guide/manifest/)
