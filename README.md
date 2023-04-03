# mobile-manifest

## Notes

- To clone with specific environment (e.g. `dev`, `beta`, `main`). We can use script above with `--branch` with specific branch.
  - E.g `tsrc init --branch main git@github.com:gotecq/mo.manifest.master.git --group default apps modules libs translations`

- ref: [https://dmerejkowsky.github.io/tsrc/guide/manifest](https://dmerejkowsky.github.io/tsrc/guide/manifest/)

- To edit `manifest.yml` in `.tsrc` folder safely. We can use below command instead of `tsrc sync` to avoid sync latest manifest from gitlab.

  - `cd your_dir` (It's directory where initialize tsrc)
  - `tsrc apply-manifest .tsrc/manifest/manifest.yml  --group default apps modules libs translations`



